-- Schema for Domain: billing | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`billing` COMMENT 'Single source of truth for all revenue and financial transaction data: customer invoices, credit/debit memos, payment receipts, dispute management, revenue recognition, rebate settlements, and intercompany billing. Manages pricing execution, invoice generation from orders, payment reconciliation, and accounts receivable. Integrates with SAP FI/CO and supports SOX-compliant financial reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'System-generated unique identifier for the invoice record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer billed on this invoice.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX audit requires tracking which employee created each invoice; finance teams record creator for compliance.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to ehs.emission_source. Business justification: Required: Monitoring services for specific emission sources are billed; the FK connects the invoice to the emission source being serviced.',
    `ip_record_id` BIGINT COMMENT 'Foreign key linking to formulation.ip_record. Business justification: Royalty invoicing depends on the IP record that underlies the sold formulation; linking enables accurate royalty calculation.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Required for posting each invoice as a revenue journal entry; finance uses journal_entry for GAAP revenue recognition, a standard process in chemical manufacturing.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Invoice generation is based on a specific manufacturing order; required for order‑to‑cash reporting and traceability of sold product.',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Required: Permit fees are invoiced; linking an invoice to the operating permit records the fee source and supports compliance reporting.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Needed for Opportunity‑to‑Invoice conversion metrics used in pipeline performance dashboards.',
    `outbound_delivery_id` BIGINT COMMENT 'Identifier of the delivery/shipment associated with the invoice.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: INVOICE generation uses the selected price list to calculate line prices; finance reports require linking each invoice to its price list.',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order that generated this invoice.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Required for linking each invoice to the specific production plan that generated the shipped product, enabling cost allocation, ASC 606 revenue recognition, and plant performance reporting.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order from the customer, if applicable.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Required for Quote‑to‑Invoice conversion tracking report, essential for sales effectiveness and compliance.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Contract research invoices must reference the specific R&D project for revenue allocation and client billing reports.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Vendor invoice reconciliation and vendor statement generation require linking each invoice directly to the supplying vendor (standard ERP practice).',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Required: Customers are charged per waste stream disposal; linking invoices to waste streams enables detailed billing and waste tracking.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance Chargeback Invoice Generation: each work order that incurs service costs is billed via an invoice referencing the originating work_order.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for the customer.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address.',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country` STRING COMMENT 'Country code of the billing address (ISO 3166-1 alpha-3).',
    `billing_postal_code` STRING COMMENT 'Postal code of the billing address.',
    `billing_state` STRING COMMENT 'State or province of the billing address.',
    `comments` STRING COMMENT 'Free-text comments or notes attached to the invoice.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted on the invoice.',
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `external_reference_number` STRING COMMENT 'Reference number from external systems (e.g., EDI, third-party billing).',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and other adjustments.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued to the customer.',
    `invoice_number` STRING COMMENT 'External business identifier assigned to the invoice, visible to customers.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice.. Valid values are `draft|open|partially_paid|paid|cancelled|disputed`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document.. Valid values are `standard|credit_memo|debit_memo|proforma|intercompany`',
    `is_electronic_invoice` BOOLEAN COMMENT 'Indicates whether the invoice was issued electronically (e-invoice).',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the invoice is exempt from tax.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment applied to this invoice.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes and discounts.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was made.. Valid values are `web|mobile|call_center|in_person|email`',
    `payment_method` STRING COMMENT 'Method used for the payment transaction.. Valid values are `credit_card|bank_transfer|check|cash|wire|online`',
    `payment_status` STRING COMMENT 'Current status of payment against the invoice.. Valid values are `not_paid|partial|paid|overdue|written_off`',
    `payment_terms` STRING COMMENT 'Terms defining when payment is due, e.g., Net 30.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Amount of any rebate applied to the invoice.',
    `regulatory_compliance_status` STRING COMMENT 'Compliance status of the invoice with chemical industry regulations (e.g., REACH, GHS).. Valid values are `compliant|non_compliant|pending_review`',
    `settlement_status` STRING COMMENT 'Status of the invoice settlement process.. Valid values are `pending|settled|reversed`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the invoice.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the invoice.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of goods billed on the invoice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume of goods invoiced, expressed in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of goods invoiced, expressed in kilograms.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a customer invoice generated from a sales order or delivery. Captures invoice number, billing date, customer account, total amount, currency, payment terms, tax totals, and lifecycle status (open, partially paid, cleared, disputed). Serves as the primary accounts receivable document and SSOT for all customer-facing billing transactions in the chemical manufacturing order-to-cash cycle. Links to invoice_line for item detail and to payment_receipt for cash application.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique surrogate key for each invoice line record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: Regulatory and quality compliance demand linking each invoiced line to the exact production batch that supplied the material.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Needed for cost and compliance reporting to map each invoice line to the underlying chemical product, supporting GHS classification and REACH reporting.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Custom formulation sales need traceability; each invoice line for a formulation references the experimental formulation record.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Regulatory traceability report requires each sold line item to reference the exact formula version used in production.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each invoice line posts to a specific GL account for product revenue; linking enables line‑level GL reporting required for statutory and internal financial statements.',
    `invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Required for audit and compliance: links each invoice line to its originating order line to support revenue recognition, traceability, and regulatory reporting.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: COGS allocation: invoice lines must reference the raw material consumed for each sold product to support cost accounting and regulatory reporting (e.g., REACH cost tracking).',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Three‑way match process matches invoice lines to PO lines to ensure pricing and quantity accuracy; a direct FK is essential for this control.',
    `price_agreement_line_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement_line. Business justification: Ensures invoiced pricing aligns with agreed price‑agreement terms, required for rebate and audit reports.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Each invoice line is priced from a specific price‑list item; audit trails need the exact price list item reference.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Supports line‑level audit of invoiced items versus quoted items for pricing compliance.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for the invoicing process to associate each line item with the exact SKU sold, enabling inventory tracking, pricing, and regulatory reporting.',
    `work_order_operation_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order_operation. Business justification: Detailed Maintenance Billing Line Items: invoice lines map to specific work order operations to itemize labor and material costs.',
    `accounting_date` DATE COMMENT 'Fiscal date used for posting the line to the ledger.',
    `cost_center` STRING COMMENT 'Internal cost center to which the expense of this line is charged.',
    `cost_element` STRING COMMENT 'Cost element identifier for detailed cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values on this line.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount value applied to this line before tax.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the line amount to the corporate reporting currency.',
    `expiry_date` DATE COMMENT 'Expiration date of the batch/lot, if applicable.',
    `gl_account` STRING COMMENT 'GL account number used for posting the lines financial impact.',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the product is classified as hazardous under regulatory standards.',
    `intercompany_flag` BOOLEAN COMMENT 'True if the line is part of an intercompany billing arrangement.',
    `intercompany_invoice_number` STRING COMMENT 'Reference number of the corresponding intercompany invoice.',
    `line_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount for the line (quantity × unit_price).',
    `line_number` STRING COMMENT 'Sequential number of the line within the invoice for ordering.',
    `line_status` STRING COMMENT 'Operational status of the line (e.g., open, closed, cancelled).. Valid values are `open|closed|cancelled`',
    `manufacturing_site` STRING COMMENT 'Plant or site where the product batch was produced.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and discount (line_amount + tax_amount – discount_amount).',
    `plant` STRING COMMENT 'SAP plant code representing the production location.',
    `price_override_flag` BOOLEAN COMMENT 'True if the unit price was manually overridden.',
    `price_override_reason` STRING COMMENT 'Explanation for why the unit price was overridden.',
    `product_description` STRING COMMENT 'Human‑readable description of the product or service.',
    `profit_center` STRING COMMENT 'Profit center responsible for the revenue generated by this line.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of product or service delivered, expressed in the unit of measure.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Monetary value of the rebate applied to this line.',
    `rebate_flag` BOOLEAN COMMENT 'True if a rebate applies to this line.',
    `regulatory_compliance_code` STRING COMMENT 'Code indicating applicable regulatory requirements (e.g., REACH, GHS) for the product.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line is recognized per accounting policy.',
    `settlement_date` DATE COMMENT 'Date when the line was settled with the customer.',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement for this line.. Valid values are `pending|settled|rejected`',
    `special_handling_instructions` STRING COMMENT 'Any special handling or shipping instructions for the line item.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for this line.',
    `tax_code` STRING COMMENT 'Tax classification code applied to this line (e.g., VAT, GST).',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the line is exempt from tax.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the product before taxes, discounts, or rebates.',
    `uom` STRING COMMENT 'Standard unit of measure for the quantity (e.g., kilograms, liters, pieces).. Valid values are `kg|lb|l|gal|pcs|mol`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice line record.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Line-item detail of a customer invoice representing individual chemical products, formulations, or services billed. Captures material number, product description, quantity, unit of measure, unit price, line amount, tax code, cost center, and profit center. Supports detailed revenue recognition and COGS allocation per product SKU and batch lot in SAP FI/CO.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` (
    `billing_adjustment_id` BIGINT COMMENT 'Primary key for adjustment',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Finance adjustment approvals are performed by specific employees; linking supports approval trail and regulatory reporting.',
    `formula_change_request_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_change_request. Business justification: When a formula change alters product cost, a credit memo is issued; linking to the change request enables audit of price adjustments.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Adjustments (credits/debits) must be recorded in a journal entry for audit trail; finance requires this link for adjustment posting.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Quality‑related credit memos: adjustments due to material defects need a link to the specific material master for audit trails and compliance investigations.',
    `party_id` BIGINT COMMENT 'Identifier of the customer to whom the adjustment applies.',
    `invoice_id` BIGINT COMMENT 'Identifier of the original invoice that is being adjusted.',
    `related_adjustment_billing_adjustment_id` BIGINT COMMENT 'Identifier of the original adjustment that this record reverses or amends.',
    `safety_incident_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_incident. Business justification: Required: Credit memos are issued for costs arising from safety incidents; the FK ties adjustments to the originating incident for traceability.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Work Order Credit Memo Adjustment: adjustments (credits) are issued to correct charges generated by a specific work order.',
    `accounting_period` STRING COMMENT 'Fiscal period (e.g., 2023Q4) to which the adjustment is posted.',
    `adjustment_number` STRING COMMENT 'Business-visible document number assigned to the adjustment (e.g., CM-202300123).',
    `adjustment_type` STRING COMMENT 'Indicates whether the adjustment reduces (credit) or increases (debit) the amount owed.. Valid values are `credit|debit`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment before tax calculations.',
    `approval_status` STRING COMMENT 'Current approval state of the adjustment.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'Identifier of the user who approved the adjustment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was approved.',
    `billing_adjustment_status` STRING COMMENT 'Current lifecycle state of the adjustment document.. Valid values are `draft|pending_approval|approved|rejected|posted|cancelled`',
    `comments` STRING COMMENT 'Additional free‑form notes entered by users.',
    `cost_center_code` STRING COMMENT 'Accounting cost center associated with the adjustment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the adjustment becomes effective for accounting purposes.',
    `external_reference` STRING COMMENT 'Reference identifier from an external system (e.g., ERP, EDI).',
    `payment_method` STRING COMMENT 'Method used for any associated payment or surcharge.. Valid values are `bank_transfer|credit_card|cash|check|other`',
    `posted_by` BIGINT COMMENT 'Identifier of the user who posted the adjustment.',
    `posted_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the adjustment was posted to the ledger.',
    `posting_date` DATE COMMENT 'Date the adjustment was posted to the general ledger.',
    `reason_code` STRING COMMENT 'Standardized code representing the business reason for the adjustment (e.g., RETURN, PRICE_CORRECTION).',
    `reason_description` STRING COMMENT 'Free‑text description providing details of why the adjustment was issued.',
    `reversal_flag` BOOLEAN COMMENT 'True if this adjustment reverses a previous adjustment.',
    `source_system` STRING COMMENT 'Name of the source system that originated the adjustment record (e.g., SAP_SD).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the adjustment amount.',
    `tax_category` STRING COMMENT 'Classification of tax treatment for the adjustment.. Valid values are `standard|reduced|zero|exempt`',
    `tax_code` STRING COMMENT 'Code that determines the tax rate and rules applied to the adjustment.',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the adjustment is exempt from tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage (e.g., 7.25).',
    `total_amount` DECIMAL(18,2) COMMENT 'Net monetary impact of the adjustment after tax (adjustment_amount + tax_amount).',
    `transaction_timestamp` TIMESTAMP COMMENT 'The moment the adjustment was executed (e.g., when the credit memo was posted).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the adjustment record.',
    CONSTRAINT pk_billing_adjustment PRIMARY KEY(`billing_adjustment_id`)
) COMMENT 'Financial adjustment document issued to a customer to either reduce (credit) or increase (debit) the amount owed on an existing invoice. Credit scenarios include product returns, quality disputes (OOS/OOT), pricing corrections, or volume rebate settlements. Debit scenarios include underbilling corrections, surcharges, freight adjustments, or hazardous material handling fees. Captures adjustment document number, adjustment type (credit/debit), reference invoice, reason code, adjustment amount, tax impact, and approval workflow status. Serves as the SSOT for all post-invoice billing modifications in the chemical manufacturing order-to-cash cycle. Managed in SAP SD/FI as billing document types.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` (
    `payment_receipt_id` BIGINT COMMENT 'System-generated unique identifier for the payment receipt record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who made the payment.',
    `invoice_id` BIGINT COMMENT 'Identifier of the accounts‑receivable invoice to which this payment is applied.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Payment receipts generate cash‑receipt journal entries; the link supports cash application and reconciliation reports mandated by finance.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Tracks payments against originating sales opportunities for cash‑flow analysis and commission calculations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Receipt processing audit needs employee identifier to trace who recorded payments for internal controls.',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order that generated the invoiced amount.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Work Order Settlement Receipt: receipts are recorded against the work order whose costs are being settled.',
    `amount_discount` DECIMAL(18,2) COMMENT 'Discounts or rebates applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount received before any deductions.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after tax and discount adjustments; the amount posted to accounts receivable.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax component deducted from the gross amount, if applicable.',
    `bank_account_number` STRING COMMENT 'Account number of the payers bank used for the transaction.',
    `bank_name` STRING COMMENT 'Name of the financial institution that processed the payment.',
    `bank_routing_number` STRING COMMENT 'Routing/ABA number identifying the payers bank.',
    `check_number` STRING COMMENT 'Number on the check, if payment method is check.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the payment was made.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign currency amount to the functional currency, if applicable.',
    `foreign_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount expressed in the original foreign currency before conversion.',
    `is_advance_payment` BOOLEAN COMMENT 'True if the payment is an advance against future goods or services.',
    `is_refund` BOOLEAN COMMENT 'True if the payment represents a refund to the customer.',
    `payer_identifier` STRING COMMENT 'Tax ID, DUNS, or other identifier for the payer used for compliance.',
    `payer_name` STRING COMMENT 'Legal name of the individual or organization making the payment.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted (online portal, mobile app, branch, or mail).. Valid values are `online|mobile|branch|mail`',
    `payment_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the payment.',
    `payment_method` STRING COMMENT 'Instrument used to transfer funds (e.g., wire, ACH, check, credit card, cash).. Valid values are `wire|ach|check|credit_card|cash`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment receipt.. Valid values are `pending|processed|rejected|cancelled`',
    `payment_terms` STRING COMMENT 'Terms governing the payment (e.g., Net 30, Due on receipt).',
    `payment_timestamp` TIMESTAMP COMMENT 'Exact date and time when the payment was received and recorded.',
    `receipt_number` STRING COMMENT 'Business identifier assigned to the receipt, used for external reference and audit.',
    `reconciliation_status` STRING COMMENT 'Result of matching the payment to open invoices.. Valid values are `unmatched|matched|partial|error`',
    `settlement_id` BIGINT COMMENT 'Identifier of the settlement batch that includes this payment.',
    `source_system` STRING COMMENT 'Name of the source system that generated the payment record (e.g., SAP FI, external bank feed).',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or rule applied to the payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment receipt record.',
    CONSTRAINT pk_payment_receipt PRIMARY KEY(`payment_receipt_id`)
) COMMENT 'Record of a customer payment received against an open accounts receivable invoice. Captures payment document number, payment date, payment method (wire, ACH, check), amount received, currency, bank clearing reference, and allocation to specific invoices. Supports payment reconciliation and AR aging in SAP FI.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` (
    `ar_open_item_id` BIGINT COMMENT 'System-generated unique identifier for the open AR item.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR aging reports are often broken out by cost center; linking open items to cost_center enables cost‑center level DSO analysis.',
    `invoice_id` BIGINT COMMENT 'Unique identifier of the source invoice in SAP FI.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer in the master data system.',
    `aging_bucket` STRING COMMENT 'Categorized aging range used for collection reporting.. Valid values are `0-30|31-60|61-90|91-120|120+`',
    `amount_original` DECIMAL(18,2) COMMENT 'Total amount originally invoiced before any payments, discounts, or adjustments.',
    `amount_outstanding` DECIMAL(18,2) COMMENT 'Remaining amount that has not been settled, including taxes and fees.',
    `ar_open_item_description` STRING COMMENT 'Free‑text description of the goods or services represented by the line.',
    `collection_status` STRING COMMENT 'Current state of collection activities for the open item.. Valid values are `open|in_collection|closed|written_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the open‑item record was first created in the system.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'Monetary value of the credit memo applied.',
    `credit_memo_date` DATE COMMENT 'Date the credit memo was issued.',
    `credit_memo_flag` BOOLEAN COMMENT 'True if a credit memo has been applied to offset this open item.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction (e.g., USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount available if payment is made by the discount due date.',
    `discount_due_date` DATE COMMENT 'Last date on which the early‑payment discount can be claimed.',
    `dispute_amount` DECIMAL(18,2) COMMENT 'Monetary value currently under dispute.',
    `dispute_flag` BOOLEAN COMMENT 'True if the customer has raised a dispute on this item.',
    `dispute_reason` STRING COMMENT 'Free‑text description of why the customer disputes the charge.',
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `dunning_level` STRING COMMENT 'Current dunning step applied to the overdue item, where higher numbers indicate more severe collection actions.. Valid values are `1|2|3|4|5|6`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount including tax before any discounts or write‑offs.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment applied to the item.',
    `overdue_days` STRING COMMENT 'Number of days past the due date that the item remains unpaid.',
    `partial_payment_flag` BOOLEAN COMMENT 'True if one or more partial payments have been applied to the item.',
    `payment_terms_code` STRING COMMENT 'Code that defines the payment schedule and discount eligibility (e.g., NET30, 2%10).',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger.',
    `quantity` STRING COMMENT 'Number of units or amount represented by this line (e.g., liters, kilograms).',
    `reconciliation_date` DATE COMMENT 'Date the item was reconciled with a payment.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the open item has been matched to a payment.. Valid values are `unreconciled|reconciled|partial`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the invoice line.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative sum of all payments posted against this open item.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity field.. Valid values are `kg|lb|l|gal|pcs`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the open‑item record.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Monetary value written off for this item.',
    `write_off_date` DATE COMMENT 'Date on which the write‑off was recorded.',
    `write_off_flag` BOOLEAN COMMENT 'True when the remaining amount has been written off as uncollectible.',
    CONSTRAINT pk_ar_open_item PRIMARY KEY(`ar_open_item_id`)
) COMMENT 'Open accounts receivable item representing an outstanding customer obligation not yet fully cleared. Tracks invoice reference, due date, overdue days, dunning level, disputed amount, and partial payment status. Serves as the operational AR aging ledger for collections management and SOX-compliant financial reporting in SAP FI.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System-generated unique identifier for the billing dispute record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who raised the dispute.',
    `case_id` BIGINT COMMENT 'Identifier of a linked case or ticket in the customer service system.',
    `employee_id` BIGINT COMMENT 'System user who initially created the dispute record.',
    `dispute_employee_id` BIGINT COMMENT 'Identifier of the employee or team responsible for resolving the dispute.',
    `dispute_last_modified_by_user_employee_id` BIGINT COMMENT 'System user who performed the most recent update to the dispute record.',
    `invoice_id` BIGINT COMMENT 'System identifier of the invoice that is under dispute.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Dispute analysis: linking disputes to the material master allows root‑cause analysis of quality or specification issues raised by customers.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance Invoice Dispute: disputes are linked to the originating work order to trace the source of the charge.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any credit or debit applied during dispute resolution (e.g., discount, penalty).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the dispute was initially logged by the customer or internal staff.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency for the disputed amounts.. Valid values are `^[A-Z]{3}$`',
    `dispute_description` STRING COMMENT 'Free‑form text entered by the customer or agent describing the issue.',
    `dispute_number` STRING COMMENT 'Human‑readable identifier assigned to the dispute case, used in communications and tracking.',
    `dispute_status` STRING COMMENT 'Current state of the dispute within the resolution workflow.. Valid values are `open|in_review|resolved|closed|rejected`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total monetary amount that the customer claims is incorrect.',
    `disputed_invoice_amount` DECIMAL(18,2) COMMENT 'Total amount originally billed on the disputed invoice.',
    `escalated_to_department` STRING COMMENT 'Department to which the dispute was escalated, if applicable.. Valid values are `finance|sales|quality|operations`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute has been escalated beyond the initial owner.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments; the amount to be paid or refunded.',
    `priority` STRING COMMENT 'Business priority assigned to the dispute for handling urgency.. Valid values are `low|medium|high|critical`',
    `reason` STRING COMMENT 'Standardized reason why the customer is contesting the invoice.. Valid values are `pricing_error|quantity_discrepancy|quality_claim|duplicate_billing|other`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the dispute record was first persisted in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the dispute record.',
    `resolution_action` STRING COMMENT 'Action taken to settle the dispute (e.g., issue credit, provide rebate).. Valid values are `credit|rebate|adjustment|replace|none`',
    `resolution_date` DATE COMMENT 'Date the dispute was closed or otherwise resolved.',
    `resolution_notes` STRING COMMENT 'Additional comments or details recorded by the resolver.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Formal record of a customer-raised dispute against an invoice or billing document. Captures dispute case number, disputed invoice reference, dispute reason (pricing error, quantity discrepancy, quality claim, duplicate billing), disputed amount, dispute status, resolution owner, and resolution date. Supports CAPA-driven dispute resolution workflows and customer satisfaction tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` (
    `billing_rebate_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the rebate agreement record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer party to which the rebate agreement applies.',
    `contract_id` BIGINT COMMENT 'Identifier of the underlying sales contract linked to the rebate agreement.',
    `sales_rebate_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_rebate_agreement. Business justification: Links billing‑side rebate contracts to sales‑side rebate agreements for unified rebate accounting.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Rebate calculations follow a defined pricing strategy; linking enables accurate rebate accrual reporting.',
    `accrual_method` STRING COMMENT 'Method used to accrue rebate liability (periodic, continuous, or on invoice).. Valid values are `periodic|continuous|on_invoice`',
    `agreement_number` STRING COMMENT 'External business identifier assigned to the rebate agreement, used in contracts and invoicing.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the rebate agreement received formal approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the user who approved the rebate agreement.',
    `billing_rebate_agreement_description` STRING COMMENT 'Free‑form description of the rebate agreement purpose and scope.',
    `billing_rebate_agreement_status` STRING COMMENT 'Current lifecycle state of the rebate agreement.. Valid values are `draft|active|suspended|terminated|expired`',
    `calculation_basis` STRING COMMENT 'Metric used to calculate the rebate amount (revenue, volume, or product group).. Valid values are `revenue|volume|product_group`',
    `compliance_requirements` STRING COMMENT 'List of regulatory frameworks (e.g., REACH, GHS, EPA) that the rebate must satisfy. [ENUM-REF-CANDIDATE: REACH|GHS|EPA|OSHA|ISO_9001|ISO_14001|ISO_45001|TSCA|FASB|SOX — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for rebate amounts.',
    `effective_from` DATE COMMENT 'Date when the rebate agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the rebate agreement expires or is terminated (null for open‑ended).',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the rebate is exclusive to the customer (true) or can be combined with other incentives (false).',
    `last_modified_by` STRING COMMENT 'User identifier who performed the most recent update to the rebate agreement.',
    `notes` STRING COMMENT 'Additional internal comments or observations related to the agreement.',
    `product_group_code` STRING COMMENT 'Code identifying the product group(s) to which the rebate applies.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Monetary value of the rebate calculated for the current period.',
    `rebate_cap_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount payable under the rebate agreement for a given period.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Percentage or factor applied to the calculation basis to determine rebate value.',
    `rebate_type` STRING COMMENT 'Classification of the rebate (e.g., volume, growth, loyalty, market share).. Valid values are `volume|growth|loyalty|market_share`',
    `region_code` STRING COMMENT 'Three‑letter country or region code where the rebate is valid.',
    `revenue_threshold` DECIMAL(18,2) COMMENT 'Minimum revenue amount required to trigger the rebate.',
    `settlement_frequency` STRING COMMENT 'How often rebate amounts are settled with the customer.. Valid values are `monthly|quarterly|annually`',
    `tiered_scale_description` STRING COMMENT 'Textual or JSON representation of tiered rebate rates based on thresholds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rebate agreement record.',
    `volume_threshold` DECIMAL(18,2) COMMENT 'Minimum volume (e.g., metric tons) required to trigger the rebate.',
    `created_by` STRING COMMENT 'User identifier who initially created the rebate agreement record.',
    CONSTRAINT pk_billing_rebate_agreement PRIMARY KEY(`billing_rebate_agreement_id`)
) COMMENT 'Master record of a customer rebate or volume incentive agreement tied to a commercial contract. Captures rebate agreement number, customer account, rebate type (volume, growth, loyalty, market-share), calculation basis (revenue, volume, product group), rebate rate or tiered scale, validity period, accrual method, and settlement frequency. Common in chemical manufacturing for large-volume industrial customers and distributors with annual volume commitments.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` (
    `rebate_settlement_id` BIGINT COMMENT 'System-generated unique identifier for each rebate settlement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer receiving the rebate.',
    `billing_rebate_agreement_id` BIGINT COMMENT 'Identifier of the rebate agreement that this settlement fulfills.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the settlement.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rebate settlements are posted to a specific GL account; linking ensures accurate financial reporting of rebate expenses.',
    `sales_rebate_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_rebate_agreement. Business justification: Associates each rebate settlement with its originating sales rebate agreement for audit trails.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Settlement of rebates must reference the pricing strategy that generated the rebate for audit and compliance.',
    `accrued_rebate_amount` DECIMAL(18,2) COMMENT 'Total rebate amount accrued during the settlement period before any adjustments.',
    `approval_status` STRING COMMENT 'Current approval state of the settlement.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the settlement was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the settlement amounts.',
    `external_settlement_code` STRING COMMENT 'Identifier from an external system (e.g., bank, ERP) for reconciliation.',
    `gross_rebate_amount` DECIMAL(18,2) COMMENT 'Rebate amount before tax or other deductions.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the settlement.',
    `payment_method` STRING COMMENT 'Instrument used to transfer the rebate payment.. Valid values are `ACH|wire|check|credit_card`',
    `payment_reference` STRING COMMENT 'External reference (e.g., check number, transaction ID) for the payment.',
    `period_end_date` DATE COMMENT 'Last day of the period for which the rebate is calculated.',
    `period_start_date` DATE COMMENT 'First day of the period for which the rebate is calculated.',
    `rebate_settlement_status` STRING COMMENT 'Current processing state of the settlement.. Valid values are `pending|approved|rejected|settled|cancelled`',
    `regulatory_reporting_code` STRING COMMENT 'Code used for statutory reporting of rebate settlements (e.g., SOX, EPA).',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether the settlement has been reversed.',
    `reversal_reason` STRING COMMENT 'Explanation for why a settlement was reversed, if applicable.',
    `settled_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the customer after tax and adjustments.',
    `settlement_method` STRING COMMENT 'Means by which the rebate is settled (e.g., credit memo, cash).. Valid values are `credit_memo|cash|bank_transfer|check`',
    `settlement_number` STRING COMMENT 'Human‑readable settlement document number assigned by finance.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the settlement was executed.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the rebate settlement, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the settlement record.',
    CONSTRAINT pk_rebate_settlement PRIMARY KEY(`rebate_settlement_id`)
) COMMENT 'Transactional record of a rebate payout or credit settlement issued to a customer upon fulfillment of rebate agreement conditions. Captures settlement document number, rebate agreement reference, settlement period, accrued rebate amount, settled amount, settlement method (credit memo, payment), and settlement date. Supports period-end rebate accounting and SOX revenue recognition compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the revenue event.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Revenue must be recognized when a manufacturing order is completed (ASC 606/IFRS 15); linking enables accurate revenue timing.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: ASC 606/IFRS 15 compliance: revenue events tied to material deliveries need the material identifier to allocate revenue correctly.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Revenue recognition is driven by closed opportunities; linking enables ASC 606/IFRS15 reporting.',
    `performance_obligation_id` BIGINT COMMENT 'Identifier of the specific performance obligation being recognized.',
    `fiscal_period_id` BIGINT COMMENT 'Financial period identifier (e.g., FY2023Q2) for the revenue event.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: ASC 606 revenue recognition for R&D contracts requires linking each recognition event to the underlying project for compliance reporting.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the accounting journal entry generated for this revenue event.',
    `revenue_recognition_rule_id` BIGINT COMMENT 'Identifier of the revenue recognition rule applied (e.g., straight-line, milestone).',
    `reversal_of_event_revenue_recognition_event_id` BIGINT COMMENT 'If this event is a reversal, references the original revenue recognition event.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Revenue recognition rules (ASC 606/IFRS 15) are derived from the pricing strategy applied to the contract.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Revenue Recognition for Maintenance Services: revenue events are linked to the work order delivering the service.',
    `compliance_flag_asc606` BOOLEAN COMMENT 'Flag indicating compliance with ASC 606 revenue recognition criteria.',
    `compliance_flag_ifrs15` BOOLEAN COMMENT 'Flag indicating compliance with IFRS 15 revenue recognition criteria.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the revenue event for internal reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue recognition record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue amounts.. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'Amount of revenue deferred (unearned) associated with this event.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount or rebate amount applied to the recognized revenue.',
    `event_number` STRING COMMENT 'External reference number for the revenue recognition posting event.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the revenue recognition event was triggered (e.g., delivery, billing, milestone).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if currency conversion was required.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates if the revenue event is intercompany (between legal entities).',
    `is_estimated` BOOLEAN COMMENT 'Indicates if the recognized revenue amount is estimated (e.g., for long-term contracts).',
    `is_reversal` BOOLEAN COMMENT 'Indicates if this event is a reversal of a previously posted revenue recognition.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the revenue recognition event.',
    `posting_date` DATE COMMENT 'Financial posting date for the revenue recognition entry.',
    `recognition_end_date` DATE COMMENT 'End date of the revenue recognition period (for over-time recognitions).',
    `recognition_start_date` DATE COMMENT 'Start date of the revenue recognition period (for over-time recognitions).',
    `recognition_type` STRING COMMENT 'Indicates whether revenue is recognized at a single point or over a period.. Valid values are `point_in_time|over_time`',
    `recognized_revenue_amount` DECIMAL(18,2) COMMENT 'Amount of revenue recognized in this event.',
    `revenue_amount_local` DECIMAL(18,2) COMMENT 'Recognized revenue amount in the local currency of the transaction.',
    `revenue_category` STRING COMMENT 'Category of revenue (e.g., product sales, service, licensing).',
    `revenue_line_type` STRING COMMENT 'Type of revenue line item.. Valid values are `sale|service|royalty|license`',
    `revenue_recognition_event_status` STRING COMMENT 'Current processing status of the revenue recognition event.. Valid values are `pending|posted|reversed|cancelled`',
    `revenue_recognition_method` STRING COMMENT 'Accounting standard used for revenue recognition.. Valid values are `ASC606|IFRS15`',
    `source_event_reference` BIGINT COMMENT 'Identifier of the source transaction (e.g., delivery note, invoice) that caused this revenue recognition.',
    `source_event_type` STRING COMMENT 'Source event that triggered the revenue recognition.. Valid values are `delivery|billing|milestone|contract_sign`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component included in the recognized revenue amount.',
    `tax_code` STRING COMMENT 'Tax code applied to the revenue transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revenue recognition record.',
    CONSTRAINT pk_revenue_recognition_event PRIMARY KEY(`revenue_recognition_event_id`)
) COMMENT 'Record of a revenue recognition posting event triggered by delivery, billing, or contractual milestone completion. Captures recognition event type (point-in-time, over-time), recognized revenue amount, deferred revenue amount, performance obligation reference, recognition date, and ASC 606 / IFRS 15 compliance flags. Integrates with SAP FI/CO revenue accounting and reporting (RAR) for SOX-compliant financial close.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` (
    `intercompany_billing_id` BIGINT COMMENT 'Unique surrogate key for each intercompany billing record.',
    `interplant_supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.interplant_supply_plan. Business justification: Needed to tie intercompany billing records to the interplant supply plan that scheduled the material transfer, supporting transfer‑pricing compliance and inventory reconciliation.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Intercompany billing documents are conceptually similar to invoices; linking them via invoice_id enables traceability and eliminates the free-text invoice_number column.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Transfer‑pricing: internal billing for raw‑material transfers must reference the material master to satisfy tax and regulatory reporting.',
    `party_id` BIGINT COMMENT 'Surrogate key of the receiving legal entity in the master party table.',
    `sending_party_id` BIGINT COMMENT 'Surrogate key of the sending legal entity in the master party table.',
    `transfer_price_id` BIGINT COMMENT 'Foreign key linking to pricing.transfer_price. Business justification: Inter‑company billing is based on a pre‑agreed transfer price; tax and compliance reports require the transfer_price reference.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Intercompany Billing for Cross‑Plant Maintenance Work Order: internal invoices reference the work order that generated the cost.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before tax, discount, and net adjustments.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after tax and discount, the amount payable.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the transaction for reporting.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the billing record.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for the transaction.. Valid values are `USD|EUR|GBP|JPY|CNY|CHF`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted on the gross amount.',
    `due_date` DATE COMMENT 'Date by which the invoice must be paid.',
    `ic_elimination_flag` BOOLEAN COMMENT 'Indicates whether the transaction is eliminated in consolidated financial statements.',
    `last_modified_by_user` STRING COMMENT 'User identifier of the person who last modified the billing record.',
    `material_service_description` STRING COMMENT 'Textual description of the material or service transferred between entities.',
    `payment_status` STRING COMMENT 'Current status of payment for the invoice.. Valid values are `unpaid|partial|paid|overdue`',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due.. Valid values are `net_30|net_45|due_on_receipt|eom|custom`',
    `posting_date` DATE COMMENT 'Financial period date on which the invoice is posted.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Price per unit of the transferred material or service before taxes and discounts.',
    `profit_center_code` STRING COMMENT 'Internal profit center linked to the transaction.',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric amount of the material or service transferred.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Monetary value of any rebate applied to the invoice.',
    `rebate_settlement_flag` BOOLEAN COMMENT 'Indicates whether a rebate has been settled on this invoice.',
    `receiving_company_code` STRING COMMENT 'Code of the legal entity that is receiving the goods or services.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the billing record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the billing record.',
    `regulatory_transfer_pricing_doc` STRING COMMENT 'Reference to the supporting transfer pricing documentation required for regulatory compliance.',
    `sending_company_code` STRING COMMENT 'Code of the legal entity that is sending the goods or services.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applicable to the transaction.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany invoice.. Valid values are `draft|open|posted|cancelled|closed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany invoice was issued.',
    `transfer_price_methodology` STRING COMMENT 'Method used to determine the intercompany transfer price.. Valid values are `cost_plus|market_based|cup|tnm`',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity field.. Valid values are `kg|l|m3|pcs|ton|lb`',
    CONSTRAINT pk_intercompany_billing PRIMARY KEY(`intercompany_billing_id`)
) COMMENT 'Billing document for intercompany transactions between legal entities within the chemical manufacturing group. Covers transfer of chemical intermediates, toll manufacturing charges, catalyst loans, shared service allocations, and technology licensing fees. Captures sending and receiving company codes, intercompany invoice number, transfer price methodology (cost-plus, market-based, comparable uncontrolled price), material or service description, quantity, amount, currency, and IC elimination flag for consolidated financial reporting. Supports arms-length transfer pricing documentation required by OECD guidelines and local tax authorities.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` (
    `dunning_notice_id` BIGINT COMMENT 'Unique identifier for the dunning notice.',
    `account_id` BIGINT COMMENT 'Identifier of the customer to whom the notice is issued.',
    `settlement_id` BIGINT COMMENT 'Identifier linking to settlement transaction if payment reconciled.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Dunning Notice for Overdue Maintenance Invoice: dunning records are tied to the work order whose invoice is overdue.',
    `batch_number` BIGINT COMMENT 'Identifier of the processing batch that generated the notice.',
    `communication_channel` STRING COMMENT 'Method used to deliver the notice.. Valid values are `email|postal|edi`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notice record was created in the system.',
    `credit_limit_review_flag` BOOLEAN COMMENT 'Indicates if the notice triggered a credit limit review.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for amounts.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has raised a dispute on the notice.',
    `due_date` DATE COMMENT 'Payment due date associated with the notice.',
    `dunning_date` DATE COMMENT 'Date the dunning notice was generated and sent.',
    `dunning_level` STRING COMMENT 'Escalation level of the notice (1-4).',
    `dunning_notice_status` STRING COMMENT 'Lifecycle status of the notice.. Valid values are `draft|issued|closed|cancelled`',
    `dunning_number` STRING COMMENT 'System-generated sequential number for the dunning notice.',
    `escalation_date` DATE COMMENT 'Date when the notice was escalated to next level.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Calculated interest charge applied.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Applicable interest rate applied to overdue amount.',
    `is_automated` BOOLEAN COMMENT 'Flag indicating if the notice was generated automatically.',
    `last_reminder_sent_date` DATE COMMENT 'Date of the most recent reminder sent to the customer.',
    `legal_escalation_flag` BOOLEAN COMMENT 'Indicates if the notice has been escalated to legal action.',
    `notes` STRING COMMENT 'Free-text field for additional comments or actions taken.',
    `oldest_overdue_item_date` DATE COMMENT 'Date of the earliest overdue invoice item included in the notice.',
    `payment_received_amount` DECIMAL(18,2) COMMENT 'Amount received against this notice.',
    `payment_received_date` DATE COMMENT 'Date when payment was received for this notice.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Additional penalty fees applied.',
    `response_status` STRING COMMENT 'Current response status from the customer.. Valid values are `pending|responded|disputed|resolved|escalated|closed`',
    `source_system` STRING COMMENT 'Originating system of the notice record.. Valid values are `SAP|Oracle|Custom`',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Sum of overdue amount, interest, and penalties.',
    `total_overdue_amount` DECIMAL(18,2) COMMENT 'Aggregate amount overdue at time of notice.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the notice record.',
    CONSTRAINT pk_dunning_notice PRIMARY KEY(`dunning_notice_id`)
) COMMENT 'Formal overdue payment reminder issued to a customer at escalating dunning levels per SAP FI dunning program configuration. Captures dunning notice number, customer account, dunning level (1-4), total overdue amount, oldest overdue item date, dunning date, communication channel (email, postal, EDI), interest/penalty charges applied, and response status. Supports automated collections workflow, credit limit review triggers, and legal escalation for chronic non-payment. Critical for managing extended payment cycles common in chemical manufacturing B2B relationships where Net 60-90 terms are standard.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'Unique surrogate key for the payment term.',
    `applicability_customer_segment` STRING COMMENT 'Customer segment code (e.g., INDUSTRIAL, RETAIL) for which this payment term is valid.',
    `applicability_product_group` STRING COMMENT 'Product group identifier (e.g., CHEMICALS, POLYMERS) to which the term applies.',
    `applicability_region` STRING COMMENT 'Geographic region (ISO 3166‑1 alpha‑3 country code) where the payment term can be used.',
    `baseline_date_rule` STRING COMMENT 'Rule indicating which document date is used as the starting point for due‑date calculation.. Valid values are `invoice_date|delivery_date|receipt_date`',
    `cash_flow_impact_category` STRING COMMENT 'Categorization of the terms impact on cash‑flow forecasting.. Valid values are `high|medium|low`',
    `change_reason` STRING COMMENT 'Reason recorded for the most recent change to the payment term.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework that governs handling of the payment term.. Valid values are `SOX|IFRS|GAAP|GIPS|FASB|SEC`',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the payment term record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment term record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code applicable to monetary amounts in the payment term.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `discount_type` STRING COMMENT 'Indicates whether the early‑payment discount is a percentage or a fixed monetary amount.. Valid values are `percentage|fixed_amount`',
    `dunning_interval_days` STRING COMMENT 'Number of days between successive dunning notices.',
    `dunning_level_start` STRING COMMENT 'Initial dunning level triggered after the due date passes.',
    `early_payment_discount_days` STRING COMMENT 'Number of days from the baseline date during which the early‑payment discount applies.',
    `early_payment_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount offered for payment made within the qualifying early‑payment window.',
    `effective_from` DATE COMMENT 'Date on which the payment term becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the payment term expires; null if open‑ended.',
    `external_reference_code` STRING COMMENT 'Identifier of the payment term in an external source system (e.g., legacy ERP).',
    `fixed_discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount discount offered for early payment when discount_type is fixed_amount.',
    `is_consolidated` BOOLEAN COMMENT 'True if the term applies to intercompany or consolidated billing scenarios.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this term is the default for new customers or contracts.',
    `legal_clause_reference` STRING COMMENT 'Reference to the contract clause or statutory provision governing this payment term.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Cap on the total discount value that can be applied under this term.',
    `net_due_days` STRING COMMENT 'Standard number of days after the baseline date when full payment is due if no discount is taken.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks, special conditions, or legal caveats.',
    `payment_method_allowed` STRING COMMENT 'Payment methods that may be used when this term is applied.. Valid values are `wire|ach|credit_card|check|letter_of_credit`',
    `payment_term_description` STRING COMMENT 'Full textual description of the payment term and its business purpose.',
    `payment_term_status` STRING COMMENT 'Current lifecycle status of the payment term.. Valid values are `active|inactive|deprecated`',
    `requires_approval` BOOLEAN COMMENT 'True if usage of this payment term must be approved by a manager or finance officer.',
    `tax_included_flag` BOOLEAN COMMENT 'True if taxes are considered included in the net due amount.',
    `term_code` STRING COMMENT 'Short alphanumeric code representing the payment term (e.g., NET30, 2/10NET30).',
    `updated_by_user` STRING COMMENT 'User identifier of the person who last updated the payment term record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment term record.',
    `version_number` STRING COMMENT 'Version of the payment term definition for change‑management tracking.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Reference master defining standard payment terms offered to customers in chemical manufacturing commercial agreements. Captures payment term code, description, baseline date calculation rule, early payment discount percentage and qualifying days, net due days, and applicability rules by customer segment, region, or product group. Examples include Net 30, Net 60, 2/10 Net 30, letter of credit terms, and consignment settlement terms. Referenced by invoices and sales orders to calculate due dates and drive AR aging, dunning triggers, and cash flow forecasting in SAP FI/SD.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` (
    `billing_schedule_id` BIGINT COMMENT 'Unique identifier for the billing schedule record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer to be billed.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the product or service covered by the billing schedule.',
    `contract_id` BIGINT COMMENT 'Identifier of the underlying sales contract linked to this billing schedule.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Schedule creation is owned by a finance employee; audit logs require the creator employee for governance.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Contractual billing: scheduled billing for raw‑material supply contracts requires linking each schedule to the specific material being supplied.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Billing schedules reference payment terms; adding a payment_term_id FK formalizes this relationship and allows joins to retrieve term details.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Derives billing frequency and amounts from the governing price agreement, used in contract billing execution.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Project‑based billing schedules are tied to R&D project milestones for accurate invoicing and schedule tracking.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Billing Schedule tied to Maintenance Work Order: schedule defines periodic billing for recurring maintenance contracts per work order.',
    `amendment_date` DATE COMMENT 'Date when the most recent amendment was applied.',
    `amendment_number` STRING COMMENT 'Sequential number of contract amendments affecting this schedule.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the schedule.',
    `billing_amount` DECIMAL(18,2) COMMENT 'Planned monetary amount to be invoiced for each billing event.',
    `billing_currency` STRING COMMENT 'Three‑letter currency code of the billing amount.. Valid values are `^[A-Z]{3}$`',
    `billing_frequency` STRING COMMENT 'Regular interval at which billing events are generated.. Valid values are `monthly|quarterly|semiannual|annual|weekly|daily`',
    `billing_interval` STRING COMMENT 'Number of frequency units between successive billings (e.g., every 2 months).',
    `billing_schedule_status` STRING COMMENT 'Current lifecycle state of the billing schedule.. Valid values are `active|inactive|suspended|completed|cancelled`',
    `collection_status` STRING COMMENT 'Current status of the payment collection process.. Valid values are `pending|collected|overdue|written_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the billing schedule record was created.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied to the billing amount.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the billing amount before tax.',
    `due_date` DATE COMMENT 'Date by which the invoice must be paid.',
    `effective_from` DATE COMMENT 'Date when the billing schedule becomes legally effective.',
    `effective_until` DATE COMMENT 'Date when the billing schedule expires or is terminated (nullable for open‑ended contracts).',
    `end_date` DATE COMMENT 'Date of the final planned billing event.',
    `fixed_amount_flag` BOOLEAN COMMENT 'Indicates if the billing amount is a fixed value (true) or variable (false).',
    `is_milestone_based` BOOLEAN COMMENT 'True if billing is driven by achievement of defined milestones.',
    `last_billing_date` DATE COMMENT 'Date when the most recent billing was executed.',
    `milestone_description` STRING COMMENT 'Textual description of the milestone tied to billing.',
    `milestone_percentage` DECIMAL(18,2) COMMENT 'Portion of the total contract value associated with this milestone.',
    `next_billing_date` DATE COMMENT 'Date of the upcoming billing occurrence.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the billing schedule.',
    `payment_terms` STRING COMMENT 'Standard payment condition governing when payment is due.. Valid values are `net30|net45|net60|due_on_receipt|custom`',
    `percentage_of_contract` DECIMAL(18,2) COMMENT 'Portion of the total contract value represented by this schedule (e.g., 10.00 for 10%).',
    `reconciliation_status` STRING COMMENT 'Indicates whether the billed amount has been reconciled with received payments.. Valid values are `pending|reconciled|exception`',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for the scheduled billing.. Valid values are `point_in_time|over_time|percentage_of_completion`',
    `schedule_name` STRING COMMENT 'Descriptive name of the billing schedule for easy identification.',
    `schedule_type` STRING COMMENT 'Indicates whether the schedule is based on regular periods or specific milestones.. Valid values are `periodic|milestone`',
    `start_date` DATE COMMENT 'Date of the first planned billing event.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether tax is already included in the billing amount.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (percentage) for the billing amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the billing schedule.',
    `variable_amount_flag` BOOLEAN COMMENT 'Indicates if the billing amount can vary based on usage or other factors.',
    `created_by` STRING COMMENT 'User identifier of the person who created the schedule.',
    CONSTRAINT pk_billing_schedule PRIMARY KEY(`billing_schedule_id`)
) COMMENT 'Master record defining a periodic or milestone-based billing plan for long-term chemical supply contracts, toll manufacturing agreements, or take-or-pay arrangements. Captures billing plan type (periodic, milestone), billing dates, planned billing amounts, percentage of contract value, and billing status per period. Managed in SAP SD billing plan (FPLA/FPLP) for contract-driven revenue scheduling.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` (
    `withholding_tax_id` BIGINT COMMENT 'System-generated unique identifier for each withholding tax record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tax filing responsibility is assigned to a finance employee; linking enables compliance tracking and reporting.',
    `invoice_id` BIGINT COMMENT 'Identifier of the customer invoice to which this withholding tax applies.',
    `reversal_of_tax_withholding_tax_id` BIGINT COMMENT 'Reference to the original withholding tax record that is being reversed.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Withholding Tax applied to Maintenance Work Order Invoice: tax records reference the work order that generated the taxable invoice.',
    `adjusted_withholding_tax_id` BIGINT COMMENT 'Self-referencing FK on withholding_tax (adjusted_withholding_tax_id)',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the withholding tax record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the withholding tax record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the withholding tax becomes effective for reporting purposes.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when the tax amount is recorded in a foreign currency.',
    `filing_date` DATE COMMENT 'Date the withholding tax filing was submitted to the authority.',
    `filing_reference_number` STRING COMMENT 'Reference number assigned by the tax authority for the filing of the withholding tax.',
    `filing_status` STRING COMMENT 'Status of the tax filing with the jurisdiction.. Valid values are `not_filed|filed|rejected`',
    `jurisdiction_code` STRING COMMENT 'Three‑letter ISO country code representing the tax jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `remittance_date` DATE COMMENT 'Date on which the tax amount was remitted to the authority.',
    `remittance_status` STRING COMMENT 'Current status of the tax remittance to the tax authority.. Valid values are `not_remitted|remitted|partial|failed`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this record represents a reversal of a previously posted withholding tax.',
    `source_system` STRING COMMENT 'Name of the source system that generated the withholding tax record (e.g., SAP FI/CO).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount to be withheld from the invoice payment.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'Monetary amount on which the withholding tax is calculated.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the transaction is exempt from withholding tax.',
    `tax_period_end` DATE COMMENT 'End date of the tax period for which the withholding applies.',
    `tax_period_start` DATE COMMENT 'Start date of the tax period for which the withholding applies.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a decimal (e.g., 0.1500 for 15%).',
    `tax_type` STRING COMMENT 'Category of tax being withheld, such as income, sales, royalty, service, or generic withholding.. Valid values are `income|sales|royalty|service|withholding`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the withholding tax record.',
    `withholding_tax_status` STRING COMMENT 'Lifecycle status of the withholding tax record.. Valid values are `draft|calculated|posted|closed|reversed`',
    CONSTRAINT pk_withholding_tax PRIMARY KEY(`withholding_tax_id`)
) COMMENT 'Withholding tax calculation and reporting record for customer invoices in jurisdictions requiring tax withholding at source. Captures tax type, rate, base amount, and remittance status.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `parent_party_id` BIGINT COMMENT 'Identifier of the parent party in hierarchical relationships.',
    `ultimate_parent_id` BIGINT COMMENT 'Top-level parent party identifier for consolidated reporting.',
    `address_line1` STRING COMMENT 'First line of the partys primary mailing address.',
    `address_line2` STRING COMMENT 'Second line of the partys primary mailing address.',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported annual revenue of the party.',
    `bank_account_number` STRING COMMENT 'Primary bank account number for payments to the party.',
    `bank_routing_number` STRING COMMENT 'Bank routing number associated with the partys bank account.',
    `city` STRING COMMENT 'City of the partys primary address.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the partys primary address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the party record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the party.',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the party.',
    `duns_number` STRING COMMENT 'DUNS number for the party.',
    `effective_from` DATE COMMENT 'Date when the party became effective in the system.',
    `effective_until` DATE COMMENT 'Date when the partys record is no longer effective (null if still active).',
    `email_address` STRING COMMENT 'Primary email address for the party.',
    `industry_code` STRING COMMENT 'Standard industry classification code (e.g., NAICS) for the party.',
    `is_blacklisted` BOOLEAN COMMENT 'Flag indicating if the party is blacklisted for compliance reasons.',
    `is_vat_registered` BOOLEAN COMMENT 'Indicates if the party is registered for VAT.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact with the party.',
    `legal_name` STRING COMMENT 'Full legal name of the party as registered.',
    `number_of_employees` STRING COMMENT 'Total number of employees for the party (if applicable).',
    `party_type` STRING COMMENT 'Classification of the party based on business relationship.',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30) applicable to the party.',
    `phone_number` STRING COMMENT 'Primary telephone number for the party.',
    `postal_code` STRING COMMENT 'Postal code of the partys primary address.',
    `preferred_currency` STRING COMMENT 'Currency code used for transactions with the party.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for primary communications with the party.',
    `registration_number` STRING COMMENT 'Government registration number for the party (e.g., business registration).',
    `risk_score` STRING COMMENT 'Internal risk score (0-100) for the party.',
    `sic_code` STRING COMMENT 'Standard Industrial Classification code for the party.',
    `source_system` STRING COMMENT 'Source system where the party data originated.',
    `state_province` STRING COMMENT 'State or province of the partys primary address.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the party is exempt from sales tax.',
    `tax_identifier` STRING COMMENT 'Tax identification number (e.g., EIN, VAT) for the party.',
    `trade_name` STRING COMMENT 'Commonly used trade or brand name of the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the party record.',
    `vat_number` STRING COMMENT 'VAT registration number for the party.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Primary key for settlement',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice that this settlement settles.',
    `party_id` BIGINT COMMENT 'Identifier of the party (customer, vendor, etc.) associated with the settlement.',
    `payment_receipt_id` BIGINT COMMENT 'Identifier of the payment receipt linked to this settlement.',
    `reversed_settlement_id` BIGINT COMMENT 'Self-referencing FK on settlement (reversed_settlement_id)',
    `approval_status` STRING COMMENT 'Overall approval state of the settlement.',
    `approved_by` STRING COMMENT 'User who approved the settlement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement was approved.',
    `batch_number` STRING COMMENT 'Batch identifier for bulk settlement processing.',
    `channel` STRING COMMENT 'Channel through which the settlement was processed.',
    `country` STRING COMMENT 'Country associated with the settlement transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the settlement.',
    `settlement_description` STRING COMMENT 'Free‑form text describing the settlement purpose or details.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the gross amount before tax.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the settlement is under dispute.',
    `dispute_reason` STRING COMMENT 'Reason provided for the settlement dispute.',
    `due_date` DATE COMMENT 'Date by which the settlement amount is expected to be paid.',
    `effective_from` DATE COMMENT 'Start date of the settlements effective period.',
    `effective_until` DATE COMMENT 'End date of the settlements effective period (null if open‑ended).',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement event occurred.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied when settlement currency differs from reporting currency.',
    `exchange_rate_date` DATE COMMENT 'Date on which the exchange rate was sourced.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and adjustments.',
    `is_manual` BOOLEAN COMMENT 'True if the settlement was entered manually rather than automatically.',
    `method` STRING COMMENT 'Payment method used for the settlement.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after taxes, discounts, and adjustments.',
    `notes` STRING COMMENT 'Additional free‑form notes related to the settlement.',
    `number` STRING COMMENT 'Business identifier assigned to the settlement.',
    `payment_terms` STRING COMMENT 'Terms governing payment timing and conditions.',
    `region` STRING COMMENT 'Geographic region (e.g., North America, EMEA) for reporting.',
    `source_system` STRING COMMENT 'Originating system of the settlement record (e.g., SAP FI, external ERP).',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement.',
    `status_reason` STRING COMMENT 'Explanation for the current settlement status.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the settlement.',
    `tax_code` STRING COMMENT 'Tax code applied to the settlement.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage used to calculate tax_amount.',
    `settlement_type` STRING COMMENT 'Category of settlement (e.g., invoice, credit memo).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    `created_by` STRING COMMENT 'User or system that created the settlement record.',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Master reference table for settlement. Referenced by settlement_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `billing_frequency` STRING COMMENT 'How often billing occurs for this obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary amounts.',
    `performance_obligation_description` STRING COMMENT 'Free‑text description of the deliverable, scope, and conditions.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the total amount, if any.',
    `effective_end_date` DATE COMMENT 'Date when the performance obligation expires or is terminated; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the performance obligation becomes binding.',
    `is_recognized` BOOLEAN COMMENT 'Indicates whether revenue for the obligation has been fully recognized.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `metric_actual` DECIMAL(18,2) COMMENT 'Actual measured value of the performance metric to date.',
    `metric_target` DECIMAL(18,2) COMMENT 'Target value for the performance metric defined in the contract.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the performance obligation.',
    `obligation_number` STRING COMMENT 'External contract or agreement number that identifies the performance obligation to customers and auditors.',
    `obligation_type` STRING COMMENT 'Category of the performance obligation indicating the nature of the deliverable.',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30, 2% 10 Net 30).',
    `performance_metric` STRING COMMENT 'Metric used to measure fulfillment of the obligation.',
    `recognition_date` DATE COMMENT 'Date on which revenue for the obligation was recognized.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Cumulative revenue recognized to date for this performance obligation.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for this obligation per IFRS 15 / ASC 606.',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle state of the performance obligation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the obligation.',
    `tax_code` STRING COMMENT 'Tax classification code used for calculating tax on the obligation.',
    `total_amount` DECIMAL(18,2) COMMENT 'Contractual monetary value associated with the performance obligation before taxes, discounts, or adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance obligation record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule` (
    `revenue_recognition_rule_id` BIGINT COMMENT 'Primary key for revenue_recognition_rule',
    `superseded_revenue_recognition_rule_id` BIGINT COMMENT 'Self-referencing FK on revenue_recognition_rule (superseded_revenue_recognition_rule_id)',
    `accounting_standard` STRING COMMENT 'Accounting framework governing the rule.',
    `applicable_customer_segment` STRING COMMENT 'Customer segment (e.g., wholesale, retail) for which the rule is valid; null if universal.',
    `applicable_product_category` STRING COMMENT 'Product category to which this rule applies; null if universal.',
    `cost_account_code` STRING COMMENT 'Chart of accounts code for cost of goods sold related to revenue under this rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was created.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective.',
    `effective_until` DATE COMMENT 'Date when the rule expires or is superseded; null if indefinite.',
    `fiscal_year_alignment` STRING COMMENT 'Alignment of the rules timing with the companys fiscal year.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether revenue recognition is performed automatically by the system.',
    `notes` STRING COMMENT 'Free-text field for any additional remarks or exceptions.',
    `recognition_method` STRING COMMENT 'Method used to recognize revenue under this rule.',
    `recognition_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue to recognize per period when applicable.',
    `recognition_timing` STRING COMMENT 'Frequency at which revenue is recognized under the rule.',
    `revenue_account_code` STRING COMMENT 'Chart of accounts code for revenue postings under this rule.',
    `rule_description` STRING COMMENT 'Detailed description of the rules purpose and application.',
    `rule_name` STRING COMMENT 'Descriptive name of the revenue recognition rule.',
    `rule_type` STRING COMMENT 'Category of the rule defining the recognition methodology.',
    `revenue_recognition_rule_status` STRING COMMENT 'Current lifecycle status of the rule.',
    `trigger_event` STRING COMMENT 'Business event that triggers revenue recognition according to the rule.',
    `updated_by` STRING COMMENT 'User or system that last updated the rule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule record.',
    `created_by` STRING COMMENT 'User or system that created the rule record.',
    CONSTRAINT pk_revenue_recognition_rule PRIMARY KEY(`revenue_recognition_rule_id`)
) COMMENT 'Master reference table for revenue_recognition_rule. Referenced by revenue_recognition_rule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_party_id` FOREIGN KEY (`party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`party`(`party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_related_adjustment_billing_adjustment_id` FOREIGN KEY (`related_adjustment_billing_adjustment_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_adjustment`(`billing_adjustment_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ADD CONSTRAINT `fk_billing_rebate_settlement_billing_rebate_agreement_id` FOREIGN KEY (`billing_rebate_agreement_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement`(`billing_rebate_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_revenue_recognition_rule_id` FOREIGN KEY (`revenue_recognition_rule_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule`(`revenue_recognition_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_reversal_of_event_revenue_recognition_event_id` FOREIGN KEY (`reversal_of_event_revenue_recognition_event_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_party_id` FOREIGN KEY (`party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`party`(`party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ADD CONSTRAINT `fk_billing_intercompany_billing_sending_party_id` FOREIGN KEY (`sending_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`party`(`party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`settlement`(`settlement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ADD CONSTRAINT `fk_billing_withholding_tax_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ADD CONSTRAINT `fk_billing_withholding_tax_reversal_of_tax_withholding_tax_id` FOREIGN KEY (`reversal_of_tax_withholding_tax_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`withholding_tax`(`withholding_tax_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ADD CONSTRAINT `fk_billing_withholding_tax_adjusted_withholding_tax_id` FOREIGN KEY (`adjusted_withholding_tax_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`withholding_tax`(`withholding_tax_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ADD CONSTRAINT `fk_billing_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`party`(`party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ADD CONSTRAINT `fk_billing_party_ultimate_parent_id` FOREIGN KEY (`ultimate_parent_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`party`(`party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_party_id` FOREIGN KEY (`party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`party`(`party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_payment_receipt_id` FOREIGN KEY (`payment_receipt_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_receipt`(`payment_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_reversed_settlement_id` FOREIGN KEY (`reversed_settlement_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`settlement`(`settlement_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule` ADD CONSTRAINT `fk_billing_revenue_recognition_rule_superseded_revenue_recognition_rule_id` FOREIGN KEY (`superseded_revenue_recognition_rule_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule`(`revenue_recognition_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `chemical_mfg_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `ip_record_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Ehs Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `outbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID (DELIV_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID (SO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID (PO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1 (BILL_ADDR1)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2 (BILL_ADDR2)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City (BILL_CITY)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country (BILL_COUNTRY)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code (BILL_ZIP)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State/Province (BILL_STATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Invoice Comments (COMMENTS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date (DUE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number (EXT_REF)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (GROSS_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date (INV_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status (INV_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|open|partially_paid|paid|cancelled|disputed');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type (INV_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|proforma|intercompany');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `is_electronic_invoice` SET TAGS ('dbx_business_glossary_term' = 'Electronic Invoice Flag (E_INVOICE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date (LAST_PAY_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel (PAY_CHANNEL)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|call_center|in_person|email');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|wire|online');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_paid|partial|paid|overdue|written_off');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount (REBATE_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status (REG_COMP_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status (SETTLE_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|reversed');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity (TOTAL_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (VOLUME_M3)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (WEIGHT_KG)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `price_agreement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `work_order_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Operation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `intercompany_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Invoice Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `manufacturing_site` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `price_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Override Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `price_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Override Reason');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `rebate_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebate Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `regulatory_compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|rejected');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'kg|lb|l|gal|pcs|mol');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `billing_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `formula_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Change Request Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `related_adjustment_billing_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Related Adjustment ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Document Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (Credit/Debit)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (Pre‑Tax)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `billing_adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `billing_adjustment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|posted|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Comments');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of Adjustment');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|credit_card|cash|check|other');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount on Adjustment');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'standard|reduced|zero|exempt');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount (Net)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Transaction Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_discount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `foreign_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Foreign Currency Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `is_advance_payment` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payer_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payer_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|mobile|branch|mail');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ach|check|credit_card|cash');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|rejected|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|partial|error');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `ar_open_item_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Open Item Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = '0-30|31-60|61-90|91-120|120+');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `amount_original` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `amount_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `ar_open_item_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'open|in_collection|closed|written_off');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `credit_memo_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `credit_memo_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Due Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `overdue_days` SET TAGS ('dbx_business_glossary_term' = 'Overdue Days');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `partial_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|partial');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|l|gal|pcs');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Dispute ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolution Owner ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number (DN)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|in_review|resolved|closed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount (DISPUTED_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `disputed_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount (INVOICE_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `escalated_to_department` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Department');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `escalated_to_department` SET TAGS ('dbx_value_regex' = 'finance|sales|quality|operations');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Dispute Amount (NET_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'pricing_error|quantity_discrepancy|quality_claim|duplicate_billing|other');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'credit|rebate|adjustment|replace|none');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` SET TAGS ('dbx_subdomain' = 'rebate_recognition');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `billing_rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rebate Agreement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `sales_rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Rebate Accrual Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'periodic|continuous|on_invoice');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (User)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `billing_rebate_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `billing_rebate_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `billing_rebate_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Rebate Calculation Basis');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'revenue|volume|product_group');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Rebate Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Rebate Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Rebate Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Internal Notes');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `product_group_code` SET TAGS ('dbx_business_glossary_term' = 'Product Group Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `rebate_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Cap Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate (Percentage)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Type');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `rebate_type` SET TAGS ('dbx_value_regex' = 'volume|growth|loyalty|market_share');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `revenue_threshold` SET TAGS ('dbx_business_glossary_term' = 'Revenue Threshold');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Frequency');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `tiered_scale_description` SET TAGS ('dbx_business_glossary_term' = 'Tiered Rebate Scale Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_rebate_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` SET TAGS ('dbx_subdomain' = 'rebate_recognition');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `rebate_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `billing_rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `sales_rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `accrued_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `external_settlement_code` SET TAGS ('dbx_business_glossary_term' = 'External Settlement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `gross_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Notes');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|credit_card');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `rebate_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `rebate_settlement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|settled|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settled Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'credit_memo|cash|bank_transfer|check');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`rebate_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'rebate_recognition');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `reversal_of_event_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Event ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `compliance_flag_asc606` SET TAGS ('dbx_business_glossary_term' = 'ASC 606 Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `compliance_flag_ifrs15` SET TAGS ('dbx_business_glossary_term' = 'IFRS 15 Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition End Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Start Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_type` SET TAGS ('dbx_business_glossary_term' = 'Recognition Type');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognition_type` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `recognized_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Revenue Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_line_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Line Type');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_line_type` SET TAGS ('dbx_value_regex' = 'sale|service|royalty|license');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'ASC606|IFRS15');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `source_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Event ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `source_event_type` SET TAGS ('dbx_business_glossary_term' = 'Source Event Type');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `source_event_type` SET TAGS ('dbx_value_regex' = 'delivery|billing|milestone|contract_sign');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `intercompany_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing Record ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `interplant_supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Interplant Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `sending_party_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Party ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CHF');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `ic_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `material_service_description` SET TAGS ('dbx_business_glossary_term' = 'Material / Service Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partial|paid|overdue');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|due_on_receipt|eom|custom');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (Transfer Price)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Transferred');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `rebate_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `regulatory_transfer_pricing_doc` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Documentation Reference');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|open|posted|cancelled|closed');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transfer_price_methodology` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Methodology');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transfer_price_methodology` SET TAGS ('dbx_value_regex' = 'cost_plus|market_based|cup|tnm');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|l|m3|pcs|ton|lb');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|postal|edi');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `credit_limit_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Review Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_notice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `dunning_number` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `legal_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Escalation Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `oldest_overdue_item_date` SET TAGS ('dbx_business_glossary_term' = 'Oldest Overdue Item Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `payment_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'pending|responded|disputed|resolved|escalated|closed');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Custom');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `total_overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Overdue Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dunning_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `applicability_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segment');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `applicability_product_group` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Group');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `applicability_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `baseline_date_rule` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date Rule');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `baseline_date_rule` SET TAGS ('dbx_value_regex' = 'invoice_date|delivery_date|receipt_date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `cash_flow_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Impact Category');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `cash_flow_impact_category` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'SOX|IFRS|GAAP|GIPS|FASB|SEC');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `dunning_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Dunning Interval Days');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `dunning_level_start` SET TAGS ('dbx_business_glossary_term' = 'Dunning Start Level');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `fixed_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Billing Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Term Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `legal_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Clause Reference');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `net_due_days` SET TAGS ('dbx_business_glossary_term' = 'Net Due Days');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_method_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Payment Methods');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_method_allowed` SET TAGS ('dbx_value_regex' = 'wire|ach|credit_card|check|letter_of_credit');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` SET TAGS ('dbx_subdomain' = 'rebate_recognition');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule ID (BSID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUSTID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID (PID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID (CID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semiannual|annual|weekly|daily');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_interval` SET TAGS ('dbx_business_glossary_term' = 'Billing Interval');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'pending|collected|overdue|written_off');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `fixed_amount_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Amount Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `is_milestone_based` SET TAGS ('dbx_business_glossary_term' = 'Milestone‑Based Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `last_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Billing Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `milestone_percentage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Percentage');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|due_on_receipt|custom');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `percentage_of_contract` SET TAGS ('dbx_business_glossary_term' = 'Percentage of Contract Value');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|exception');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|percentage_of_completion');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Name');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Type (Periodic or Milestone)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'periodic|milestone');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `variable_amount_flag` SET TAGS ('dbx_business_glossary_term' = 'Variable Amount Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `withholding_tax_id` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `withholding_tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `withholding_tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `reversal_of_tax_withholding_tax_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Tax Identifier (REV_OF_TAX_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `reversal_of_tax_withholding_tax_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `reversal_of_tax_withholding_tax_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `adjusted_withholding_tax_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date (FILING_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number (FILING_REF)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status (FILING_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code (JURIS_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date (REMIT_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status (REMIT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `remittance_status` SET TAGS ('dbx_value_regex' = 'not_remitted|remitted|partial|failed');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag (REVERSAL_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount (TAX_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount (BASE_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (EXEMPT_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_period_end` SET TAGS ('dbx_business_glossary_term' = 'Tax Period End Date (PERIOD_END)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_period_start` SET TAGS ('dbx_business_glossary_term' = 'Tax Period Start Date (PERIOD_START)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate (RATE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Type (TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'income|sales|royalty|service|withholding');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `withholding_tax_status` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Record Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`withholding_tax` ALTER COLUMN `withholding_tax_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|posted|closed|reversed');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`party` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `reversed_settlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule` SET TAGS ('dbx_subdomain' = 'rebate_recognition');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule` ALTER COLUMN `revenue_recognition_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_rule` ALTER COLUMN `superseded_revenue_recognition_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
