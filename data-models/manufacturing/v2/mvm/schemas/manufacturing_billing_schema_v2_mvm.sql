-- Schema for Domain: billing | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-06-24 10:28:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`billing` COMMENT 'Billing and revenue domain serving as the SSOT for all customer invoices, billing cycles, payment processing, revenue recognition, credit management, collections, payment terms, accounts receivable, and billing dispute resolution across product sales, service contracts, and project-based engagements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice record.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Trade compliance and customs: commercial invoices in international manufacturing shipments must reference the bill of lading for customs clearance, letter of credit compliance, and export documentatio',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: An invoice is issued to a billing account — billing_account is the SSOT for the financial relationship between the company and the customer in this domain. invoice currently has no FK to billing_accou',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Invoice billing address must reference the canonical customer address record for tax jurisdiction, VAT validation, and regulatory compliance reporting. Manufacturing invoices require verified ship-to/',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to order.blanket_order. Business justification: Blanket orders in manufacturing generate periodic release invoices. Referencing the blanket order on the invoice enables cumulative value consumption tracking, contract compliance reporting, and blank',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: Delivery-based billing is standard in manufacturing: invoices are triggered by goods delivery confirmation. AR reconciliation, proof-of-delivery disputes, and revenue recognition all require tracing a',
    `delivery_note_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_note. Business justification: SAP SD billing flow: customer invoices in manufacturing are created with reference to outbound delivery notes (goods issue confirmation triggers billing). Revenue recognition and AR posting depend on ',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: In contract manufacturing, ECOs that require customer-approved design changes generate NRE or change-fee invoices. The invoice must reference the triggering ECO for cost-impact billing, customer appro',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Lease billing process requires each invoice to reference the leased equipment for revenue recognition and asset tracking.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Freight cost invoicing: in manufacturing, carrier invoices and freight billing documents are raised against freight orders. Finance teams reconcile freight invoices to freight orders for cost allocati',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: REQUIRED: Invoice‑Generation process needs to trace each invoice to its originating sales order for order‑to‑invoice reconciliation and audit reporting.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Order‑to‑cash process maps each invoice to its originating order intake record for fulfillment and billing reconciliation.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: An invoice is governed by specific payment terms (Net 30, Net 60, etc.). payment_term is the master reference for all payment conditions. invoice currently has a denormalized payment_terms_code column',
    `plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: In multi-plant manufacturing, invoices are issued from specific plants determining VAT registration, tax jurisdiction, intercompany accounting, and regulatory compliance. Plant-based invoicing is a ',
    `primary_credit_note_invoice_id` BIGINT COMMENT 'Identifier of the related credit note, if this invoice is a credit note.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Invoice Generation process requires linking each invoice to its originating production work order for financial reporting and cost allocation; production work order is the natural source of billing.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NRE (Non-Recurring Engineering) and tooling development projects are billed to customers in manufacturing. Invoices for project-based fees must reference the engineering project to support project cos',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Audit trail requires linking each invoice to the quote that defined pricing and terms after quote acceptance.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.order_rma. Business justification: Credit memo invoices in manufacturing are directly triggered by approved RMAs. The invoice must reference the originating RMA for audit trail completeness, credit processing workflow, customer dispute',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the underlying sales or service contract.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission reports need each invoice linked to the sales rep who closed the deal; essential for performance and payout calculations.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Invoice generation for each shipment requires linking invoice to the shipped order for traceability in the Shipment Billing process.',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: SLA annual fees, penalty credits, and service charges generate invoices that must reference the governing SLA agreement for dispute resolution, revenue recognition by contract, and SLA performance rep',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Warehouse of origin is required for logistics cost allocation, export reporting, and inventory valuation per invoice.',
    `billing_period_end` DATE COMMENT 'End date of the billing period covered by the invoice.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period covered by the invoice.',
    `collection_status` STRING COMMENT 'Current status of the collection process for overdue invoices.. Valid values are `open|in_collection|closed|written_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the invoice.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Discount rate applied to the invoice before tax.',
    `due_date` DATE COMMENT 'Date by which payment is due.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and adjustments.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice.. Valid values are `draft|issued|paid|overdue|cancelled|disputed`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document.. Valid values are `standard|credit_note|debit_note|proforma|self_billing`',
    `is_self_billing` BOOLEAN COMMENT 'True if the invoice is generated by the supplier on behalf of the customer (self‑billing).',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was issued.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `number` STRING COMMENT 'Official invoice number assigned by the billing system.',
    `payment_method` DECIMAL(18,2) COMMENT 'Method used by the customer to settle the invoice.',
    `payment_status` DECIMAL(18,2) COMMENT 'Current status of the payment for this invoice.',
    `po_number` STRING COMMENT 'Purchase order reference supplied by the customer.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the invoice.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the invoice is exempt from tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a formal demand for payment issued to a customer for product sales, service contracts, or project-based engagements. Captures invoice number, issue date, due date, billing period, total amount, tax amount, discount amount, currency, invoice status (draft, issued, partially_paid, paid, overdue, cancelled, disputed, written_off), invoice type (standard, credit_note, debit_note, proforma, self_billing), payment terms code, billing address, PO reference, contract reference, and source transaction reference. Serves as the SSOT for credit notes (returns, pricing corrections, quality disputes, volume rebate settlements) and debit notes (price adjustments, surcharges, underbilling corrections) via the invoice_type discriminator. Also supports self-billing/evaluated receipt settlement (ERS) for consignment and VMI arrangements. Managed in SAP S/4HANA SD/FI billing document types (VF01/VF04).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique surrogate key for each invoice line record.',
    `billing_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.billing_schedule. Business justification: For project-based and contract-based engagements, an invoice line corresponds to a specific billing schedule milestone. billing_schedule defines planned billing milestones; invoice_line is the actual ',
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to asset.calibration_record. Business justification: Calibration service invoice traceability: in regulated manufacturing (ISO 9001, FDA 21 CFR), external calibration lab invoices must be traceable to the specific calibration record for audit compliance',
    `catalog_entry_id` BIGINT COMMENT 'Foreign key linking to product.catalog_entry. Business justification: In manufacturing, invoice lines are generated from catalog entries (the priced, orderable product offering). Linking invoice_line to catalog_entry enables price audit trails, catalog-driven revenue re',
    `delivery_item_id` BIGINT COMMENT 'Foreign key linking to order.delivery_item. Business justification: Invoice lines in manufacturing must map to specific delivery items for quantity-based billing verification, partial-delivery credit memo processing, and goods-receipt-based invoice matching (GR/IR). A',
    `delivery_note_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_note. Business justification: Line-level delivery traceability: each invoice line in manufacturing billing corresponds to specific goods delivered per delivery note. Dispute resolution, returns processing, and revenue recognition ',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Service‑charge line items must identify the exact equipment serviced to allocate costs and support maintenance cost analysis.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inspection Service Billing – each inspection lot performed for a customer is charged as a line item on the invoice.',
    `invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: REQUIRED: Revenue recognition and audit trails require linking each invoice line to the specific order line it bills.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: In manufacturing, each invoice line for goods sold must trace to the specific lot/batch shipped, enabling recall management, quality dispute resolution, warranty claims, and regulatory compliance (FDA',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Invoice line items need to reference the exact material being billed. Adding material_master_id (FK → inventory.material_master.material_master_id) creates a proper parent‑child relationship and remov',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: NCR Cost Recovery – non‑conformance handling costs are billed to the customer via a dedicated invoice line.',
    `original_invoice_line_id` BIGINT COMMENT 'Reference to the original invoice line that this credit memo line reverses.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Individual invoice lines can carry their own payment terms, particularly in milestone billing or split-payment arrangements where different line items have different due dates and discount structures.',
    `price_book_entry_id` BIGINT COMMENT 'Foreign key linking to sales.price_book_entry. Business justification: Manufacturing pricing audits and contract compliance verification require tracing each invoice line to the price book entry used at quoting time. Revenue leakage analysis and pricing governance report',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: In contract/job-shop manufacturing, each invoice line maps to a specific work order for line-item work order billing. Enables work order line-item billing reports, revenue recognition per work order',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Individual invoice lines for NRE, tooling, or development charges reference specific engineering projects in contract manufacturing. The existing project_milestone_code plain attribute is a denormaliz',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Quote-to-cash reconciliation and margin analysis in manufacturing require tracing each invoice line back to the originating quote line. Revenue recognition audits and contract compliance reporting dep',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Revenue recognition and product cost allocation require each invoice line to reference the sold SKU; this mapping is essential for financial reporting and compliance.',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated to the cost center (derived from allocation_percent).',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the line amount allocated to the specified cost center.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice line record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values on this line.',
    `deferred_revenue_flag` DECIMAL(18,2) COMMENT 'Indicates whether the line amount is deferred revenue (true) or recognized immediately (false).',
    `invoice_line_description` STRING COMMENT 'Free‑text description of the product, service, or milestone billed.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied to this line.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the line gross amount.',
    `expense_account` DECIMAL(18,2) COMMENT 'GL account used for any expense component associated with this line.',
    `external_reference_code` STRING COMMENT 'Identifier from an external system (e.g., ERP, CRM) linked to this line.',
    `is_bundle_line` BOOLEAN COMMENT 'True if this line is part of a product bundle.',
    `is_credit_memo` BOOLEAN COMMENT 'True if this line represents a credit memo (negative amount).',
    `is_royalty_line` BOOLEAN COMMENT 'True if the line represents a royalty charge.',
    `is_tax_included` BOOLEAN COMMENT 'Indicates whether the unit price already includes tax.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total amount for the line before tax and discount (quantity × unit_price).',
    `line_status` STRING COMMENT 'Current processing status of the invoice line.. Valid values are `open|posted|reversed|cancelled`',
    `line_type` STRING COMMENT 'Classification of the line content (product, service, project milestone, fee, or other charge).. Valid values are `product|service|project|fee|charge`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after tax and discount (line_amount + tax_amount – discount_amount).',
    `notes` STRING COMMENT 'Free‑form notes or comments entered by users for this line.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the line was posted to the financial ledger.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the product or service delivered (units, hours, meters, etc.).',
    `revenue_account` DECIMAL(18,2) COMMENT 'GL account used for revenue posting of this line.',
    `revenue_recognition_method` DECIMAL(18,2) COMMENT 'Method used to recognize revenue for this line, per accounting standards.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Royalty rate applied to the base amount, expressed as a percentage.',
    `service_end_date` DATE COMMENT 'End date of the service period covered by this line (if applicable).',
    `service_start_date` DATE COMMENT 'Start date of the service period covered by this line (if applicable).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for this line.',
    `tax_code` DECIMAL(18,2) COMMENT 'Code that determines the tax rate and rules applicable to this line.',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the line is exempt from tax, false otherwise.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per single unit of the product or service before taxes and discounts.',
    `uom` STRING COMMENT 'Unit of measure for the quantity (e.g., each, kilogram, liter, meter, hour).. Valid values are `EA|KG|L|M|HRS`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the invoice line.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line item on a customer invoice representing a specific product, service, or project milestone being billed. Captures line number, item description, SKU or service code, quantity, unit of measure, unit price, line amount, tax code, tax amount, discount percentage, discount amount, cost center, profit center, GL account, revenue recognition method, and deferred revenue flag. Supports detailed revenue allocation across product sales, service contracts, and project milestones per SAP S/4HANA CO-PA and revenue recognition standards.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'System-generated unique identifier for the payment transaction.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: A payment is received from a billing account — billing_account is the financial relationship entity in this domain and the natural parent of payment transactions. payment currently only has customer_a',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: A payment is applied against an invoice. This is the primary 1:N relationship between payment and invoice (many payments per invoice). The payment table currently has no in-domain FK to invoice despit',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: A payment is made under specific payment terms (e.g., early payment discount applied, penalty terms). payment currently has a denormalized term_code (STRING) which is a direct reference to the payment',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Payments are recorded against the governing sales contract to monitor contract cash flow and compliance.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Advance or partial payments are tied to a specific order intake for accurate order financing and tracking.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Total amount of the payment that has been allocated to invoices.',
    `allocation_date` TIMESTAMP COMMENT 'Timestamp when the payment was allocated.',
    `allocation_status` STRING COMMENT 'Status of the payment allocation to invoices.. Valid values are `allocated|partial|unallocated|on_account`',
    `allocation_type` STRING COMMENT 'Nature of the allocation (full, partial, advance, on‑account).. Valid values are `full|partial|advance|on_account`',
    `amount_discount` DECIMAL(18,2) COMMENT 'Total discount applied to the payment.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before any discounts, taxes, or fees.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after discounts, taxes, and fees.',
    `bank_name` STRING COMMENT 'Name of the bank handling the payment.',
    `bank_value_date` DECIMAL(18,2) COMMENT 'Date on which the bank considers the funds available.',
    `batch_code` BIGINT COMMENT 'Identifier of the batch that groups this payment with others for processing.',
    `channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `online|mobile|branch|mail|phone`',
    `clearing_document_number` STRING COMMENT 'Reference number of the clearing document generated for the payment.',
    `clearing_status` STRING COMMENT 'Current status of the payment clearing process.. Valid values are `cleared|pending|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the payment.',
    `payment_description` DECIMAL(18,2) COMMENT 'Free‑form description or notes about the payment.',
    `discount_taken` DECIMAL(18,2) COMMENT 'Monetary discount amount applied to the payment.',
    `due_date` DATE COMMENT 'Date by which the payment was expected according to invoice terms.',
    `early_payment_discount_applied` DECIMAL(18,2) COMMENT 'Indicates whether an early‑payment discount was applied.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if payment currency differs from company currency.',
    `external_reference` STRING COMMENT 'Reference identifier from external payment gateway or bank.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any processing fees associated with the payment.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment has been reconciled to invoices.',
    `method` DECIMAL(18,2) COMMENT 'Instrument used to make the payment.',
    `notes` STRING COMMENT 'Additional internal notes regarding the payment.',
    `original_amount` DECIMAL(18,2) COMMENT 'Payment amount in the original currency before conversion.',
    `original_currency` STRING COMMENT 'Currency code of the original payment amount.',
    `payment_date` DECIMAL(18,2) COMMENT 'Timestamp when the payment was received or recorded.',
    `payment_number` DECIMAL(18,2) COMMENT 'Business-visible reference number assigned to the payment.',
    `payment_status` DECIMAL(18,2) COMMENT 'Current lifecycle state of the payment.',
    `reconciliation_date` TIMESTAMP COMMENT 'Timestamp when the payment was reconciled.',
    `remittance_advice_reference` STRING COMMENT 'Reference to the remittance advice supplied by the payer.',
    `sequence` STRING COMMENT 'Sequence number for multiple payments within a batch or settlement.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current payment status.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment.',
    `transaction_type` STRING COMMENT 'Classification of the payment transaction.. Valid values are `invoice_payment|prepayment|deposit|refund`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a payment transaction received from a customer against one or more invoices, serving as the SSOT for all incoming customer payments, cash application, and payment-to-invoice allocation in SAP S/4HANA FI-AR. Captures payment reference number, payment date, amount, currency, exchange rate, payment method (wire transfer, ACH, check, credit card, letter of credit), bank account reference, clearing document number, payment status, remittance advice reference, and bank value date. Includes allocation details: per-invoice allocated amount, allocation date, allocation type (full, partial, advance, on_account), discount taken, early payment discount applied, clearing status, and allocation sequence. Supports partial payments, split payments across multiple invoices, and on-account payments pending allocation.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'System-generated unique identifier for the billing account record.',
    `customer_account_id` BIGINT COMMENT '',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Billing accounts use a payment term; linking to the payment_term master eliminates the free‑text code and enforces referential integrity.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: In manufacturing key account management, each billing account is owned by a sales rep for AR escalation routing, commission attribution, and dunning coordination. Finance and sales ops both require kn',
    `account_name` STRING COMMENT 'Human‑readable name of the billing account (e.g., customer or partner name).',
    `account_number` STRING COMMENT 'External account number used in invoicing and payment processing.',
    `account_type` STRING COMMENT 'Classification of the account relationship (direct, distributor, OEM, end‑user).. Valid values are `direct|distributor|OEM|end_user`',
    `auto_payment_enabled` DECIMAL(18,2) COMMENT 'Indicates whether automatic payment processing is active.',
    `billing_account_status` STRING COMMENT 'Current lifecycle status of the billing account.. Valid values are `active|blocked|dormant|closed`',
    `billing_frequency` STRING COMMENT 'How often invoices are generated for the account.. Valid values are `monthly|quarterly|annual|milestone|on_delivery`',
    `close_date` DATE COMMENT 'Date when the billing account was closed or deactivated (nullable).',
    `collection_stage` STRING COMMENT 'Current stage in the collections process for overdue balances.. Valid values are `early|mid|late|defaulted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account record was first created.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the account.',
    `credit_rating` DECIMAL(18,2) COMMENT 'Credit rating assigned to the account based on financial risk assessment.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for billing.',
    `current_ar_balance` DECIMAL(18,2) COMMENT 'Outstanding accounts‑receivable balance for the account.',
    `billing_account_description` STRING COMMENT 'Free‑form notes or description about the billing account.',
    `dunning_procedure` STRING COMMENT 'Assigned dunning strategy for overdue payments.',
    `external_account_reference` STRING COMMENT 'Identifier of the account in an external system (e.g., ERP, CRM).',
    `invoice_delivery_method` STRING COMMENT 'Preferred channel for delivering invoices to the customer.. Valid values are `email|EDI|portal|paper`',
    `last_payment_date` DECIMAL(18,2) COMMENT 'Date of the most recent payment received.',
    `next_due_date` DATE COMMENT 'Scheduled date for the next invoice payment.',
    `open_date` DATE COMMENT 'Date when the billing account was created.',
    `payment_due_day_of_month` DECIMAL(18,2) COMMENT 'Numeric day of the month when payment is due (1‑31).',
    `payment_method` DECIMAL(18,2) COMMENT 'Method used for the most recent payment transaction.',
    `preferred_payment_method` DECIMAL(18,2) COMMENT 'Customer’s preferred method for settling invoices.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from tax.',
    `tax_exempt_reason` DECIMAL(18,2) COMMENT 'Reason for tax exemption (e.g., government entity, nonprofit).',
    `tax_region_code` DECIMAL(18,2) COMMENT 'Three‑letter country code defining the tax jurisdiction.',
    `tax_registration_number` DECIMAL(18,2) COMMENT 'Government‑issued tax registration identifier for the account holder.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing account record.',
    `vat_number` STRING COMMENT 'Value‑Added Tax identifier used for tax reporting.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Billing-specific account master record representing the financial relationship between Manufacturing and a customer entity for invoicing, credit management, and collections purposes. Captures account number, account name, account type (direct, distributor, OEM, end_user), billing currency, credit limit reference, current AR balance, payment terms code, billing frequency (monthly, milestone, on_delivery), invoice delivery method (email, EDI, portal, paper), tax registration number, VAT ID, dunning procedure assignment, account status (active, blocked, dormant), and preferred payment method. Serves as the billing-domain anchor for all financial transactions — distinct from the customer master in the customer domain which owns identity and relationship data.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` (
    `billing_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each billing schedule record.',
    `billing_account_id` BIGINT COMMENT '',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Equipment lease and asset-as-a-service billing: billing schedules for equipment leases or long-term maintenance contracts are tied to specific assets. This link enables asset-level billing schedule re',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Billing schedules in manufacturing are created against sales orders for milestone and progress billing on long-lead manufactured items. Tracking cumulative billed vs. order value and driving billing p',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: A billing schedule milestone, once triggered and processed, generates an invoice. billing_schedule should reference the invoice it produced to close the loop between planned billing and actual invoici',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: In contract manufacturing, billing schedules are triggered by work order milestones (e.g., bill on work order start/completion). The billing_schedule.percentage_complete_trigger and milestone_type fie',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Milestone-based billing schedules for NRE and tooling projects are standard in contract manufacturing. The billing_schedules milestone_type and percentage_complete_trigger fields align directly with ',
    `sales_contract_id` BIGINT COMMENT 'Identifier of the contract to which this billing schedule line belongs.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Milestone billing triggered by shipment: manufacturing contracts often bill on shipment confirmation (FOB shipping point). The billing schedule milestone is activated when a shipment is confirmed disp',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: Manufacturing service SLA agreements drive milestone-based billing schedules (maintenance contracts, uptime guarantees). Billing schedule must reference the governing SLA agreement to validate milesto',
    `actual_billed_amount` DECIMAL(18,2) COMMENT 'Monetary amount that was actually invoiced for this milestone.',
    `actual_billing_date` DATE COMMENT 'Date on which the billing was actually executed.',
    `billing_currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the planned billing amount.. Valid values are `^[A-Z]{3}$`',
    `billing_status` STRING COMMENT 'Current lifecycle status of the billing schedule line.. Valid values are `planned|ready_to_bill|billed|on_hold|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing schedule record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount subtracted from the planned billing amount, if any.',
    `is_retention_applicable` BOOLEAN COMMENT 'Indicates whether a retention amount is associated with this milestone.',
    `line_number` STRING COMMENT 'Sequential number of the schedule line within the contract billing schedule.',
    `milestone_description` STRING COMMENT 'Free‑text description of the billing milestone purpose or deliverable.',
    `milestone_type` STRING COMMENT 'Category of the billing milestone (e.g., advance payment, progress billing, final billing, retention release).. Valid values are `advance_payment|progress_billing|final_billing|retention_release`',
    `notes` STRING COMMENT 'Optional free‑text field for additional comments or special instructions.',
    `percentage_complete_trigger` DECIMAL(18,2) COMMENT 'Project completion percentage that triggers this billing milestone.',
    `planned_billing_amount` DECIMAL(18,2) COMMENT 'Monetary amount planned to be invoiced for this milestone.',
    `planned_billing_date` DATE COMMENT 'Date on which the billing amount is scheduled to be invoiced.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Monetary amount held as retention for this milestone, if applicable.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the planned billing amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing schedule record.',
    CONSTRAINT pk_billing_schedule PRIMARY KEY(`billing_schedule_id`)
) COMMENT 'Planned billing milestone schedule for project-based or contract-based engagements, defining when specific amounts are to be invoiced based on project progress, delivery milestones, or contractual dates. Captures schedule line number, planned billing date, planned billing amount, billing milestone description, milestone type (advance_payment, progress_billing, final_billing, retention_release), percentage complete trigger, actual billing date, actual billed amount, billing status (planned, ready_to_bill, billed, on_hold, cancelled), contract reference, and project WBS element reference. Supports project billing for industrial automation system installations (typically 12-36 month delivery cycles) and milestone-based revenue recognition per IFRS 15 variable consideration guidance.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'System-generated unique identifier for the payment term record.',
    `base_payment_term_id` BIGINT COMMENT 'Self-referencing FK on payment_term (base_payment_term_id)',
    `allowed_payment_channel` DECIMAL(18,2) COMMENT 'Channels through which payment can be made (e.g., online portal, mobile app).',
    `allowed_payment_method` DECIMAL(18,2) COMMENT 'Payment instruments permitted under this term.',
    `applicable_invoice_type` STRING COMMENT 'Invoice categories to which this payment term can be applied.. Valid values are `standard|credit|debit|proforma|rebate`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment term record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency applicable to the payment term.. Valid values are `^[A-Z]{3}$`',
    `early_payment_discount_days` DECIMAL(18,2) COMMENT 'Number of days from invoice date during which the early‑payment discount is available.',
    `early_payment_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied when payment is made within the early‑payment window.',
    `effective_from` DATE COMMENT 'Date when the payment term becomes binding.',
    `effective_until` DATE COMMENT 'Date when the payment term expires; null for open‑ended terms.',
    `grace_period_days` STRING COMMENT 'Additional days after the net due date before penalties apply.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this term is the default for new customers or contracts.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether taxes are waived for transactions using this term.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Upper limit on the monetary value of any discount granted under this term.',
    `min_payment_amount` DECIMAL(18,2) COMMENT 'Minimum amount that must be paid per invoice under this term.',
    `net_days` STRING COMMENT 'Standard number of days after invoice date when payment is due (e.g., Net 30).',
    `notes` STRING COMMENT 'Free‑form comments or special conditions related to the payment term.',
    `payment_term_status` DECIMAL(18,2) COMMENT 'Current lifecycle state of the payment term.',
    `penalty_rate_percent` DECIMAL(18,2) COMMENT 'Interest or fee percentage charged on overdue amounts.',
    `penalty_type` STRING COMMENT 'Method of applying the penalty (percentage of overdue amount or flat fee).. Valid values are `percentage|flat_fee`',
    `tax_exempt_reason` DECIMAL(18,2) COMMENT 'Explanation for tax exemption (e.g., government incentive, nonprofit status).',
    `term_code` STRING COMMENT 'Human‑readable code used to reference the payment term in contracts and invoices.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `term_type` STRING COMMENT 'Category of the payment term (e.g., Net, Discount, Milestone, Retention, Custom).. Valid values are `net|discount|milestone|retention|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment term record.',
    `version_number` STRING COMMENT 'Sequential version of the payment term record for change tracking.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Payment terms master defining standard and customer-specific payment conditions (Net 30, Net 60, 2/10 Net 30) applied to billing documents and customer accounts';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_primary_credit_note_invoice_id` FOREIGN KEY (`primary_credit_note_invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_schedule`(`billing_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_original_invoice_line_id` FOREIGN KEY (`original_invoice_line_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ADD CONSTRAINT `fk_billing_payment_term_base_payment_term_id` FOREIGN KEY (`base_payment_term_id`) REFERENCES `vibe_manufacturing_v1`.`billing`.`payment_term`(`payment_term_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `delivery_note_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `primary_credit_note_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Order Rma Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date (BILL_PERIOD_END)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date (BILL_PERIOD_START)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'open|in_collection|closed|written_off');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date (DUE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount (GROSS_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status (INV_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|overdue|cancelled|disputed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type (INV_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_note|debit_note|proforma|self_billing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `is_self_billing` SET TAGS ('dbx_business_glossary_term' = 'Self‑Billing Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Timestamp (ISSUE_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount (NET_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `catalog_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `delivery_item_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Item Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `delivery_note_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `original_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `deferred_revenue_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `expense_account` SET TAGS ('dbx_business_glossary_term' = 'Expense Account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_bundle_line` SET TAGS ('dbx_business_glossary_term' = 'Bundle Line Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_credit_memo` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_royalty_line` SET TAGS ('dbx_business_glossary_term' = 'Royalty Line Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|posted|reversed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'product|service|project|fee|charge');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_account` SET TAGS ('dbx_business_glossary_term' = 'Revenue Account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|HRS');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'allocated|partial|unallocated|on_account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'full|partial|advance|on_account');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `amount_discount` SET TAGS ('dbx_business_glossary_term' = 'Payment Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `bank_value_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Value Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `batch_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|mobile|branch|mail|phone');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `early_payment_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Applied');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `original_currency` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `remittance_advice_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Reference');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Payment Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Status Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'invoice_payment|prepayment|deposit|refund');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'direct|distributor|OEM|end_user');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `auto_payment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Payment Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|dormant|closed');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|milestone|on_delivery');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `collection_stage` SET TAGS ('dbx_business_glossary_term' = 'Collection Stage');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `collection_stage` SET TAGS ('dbx_value_regex' = 'early|mid|late|defaulted');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `current_ar_balance` SET TAGS ('dbx_business_glossary_term' = 'Current AR Balance');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `billing_account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `dunning_procedure` SET TAGS ('dbx_business_glossary_term' = 'Dunning Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `external_account_reference` SET TAGS ('dbx_business_glossary_term' = 'External Account Reference');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|EDI|portal|paper');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `payment_due_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day of Month');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_region_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Region Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'VAT Identification Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_account` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `actual_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Billed Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `actual_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Billing Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'planned|ready_to_bill|billed|on_hold|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `is_retention_applicable` SET TAGS ('dbx_business_glossary_term' = 'Retention Applicable Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Billing Milestone Description');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Milestone Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'advance_payment|progress_billing|final_billing|retention_release');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `percentage_complete_trigger` SET TAGS ('dbx_business_glossary_term' = 'Percentage Complete Trigger');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `planned_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Billing Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `planned_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Billing Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`billing_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term ID');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `base_payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Base Payment Term Id');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `base_payment_term_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `allowed_payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Channel');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `allowed_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `applicable_invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Invoice Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `applicable_invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit|debit|proforma|rebate');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percent');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Term Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `min_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Amount');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `net_days` SET TAGS ('dbx_business_glossary_term' = 'Net Days');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `penalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate Percent');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Type');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'net|discount|milestone|retention|custom');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`billing`.`payment_term` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Version Number');
