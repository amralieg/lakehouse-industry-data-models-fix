-- Schema for Domain: billing | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`billing` COMMENT 'Single source of truth for all revenue and financial transaction data: customer invoices, credit/debit memos, payment receipts, dispute management, revenue recognition, rebate settlements, and intercompany billing. Manages pricing execution, invoice generation from orders, payment reconciliation, and accounts receivable. Integrates with SAP FI/CO and supports SOX-compliant financial reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'System-generated unique identifier for the invoice record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer billed on this invoice.',
    `billing_party_id` BIGINT COMMENT 'Foreign key linking to billing.party. Business justification: invoice has six denormalized billing address fields (billing_address_line1, billing_address_line2, billing_city, billing_state, billing_postal_code, billing_country) that duplicate data from the party',
    `billing_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.billing_schedule. Business justification: In chemical manufacturing, long-term supply contracts use billing schedules (periodic or milestone-based). An invoice generated from a billing schedule must reference its originating billing_schedule.',
    `coa_document_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.coa_document. Business justification: Chemical shipment invoices are accompanied by a Certificate of Analysis. Linking invoice to coa_document supports quality-based payment terms, customer acceptance workflows, and regulatory compliance ',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Invoice delivery and billing notifications in chemical mfg are directed to a specific AP/billing contact at the customer. This link enables targeted invoice dispatch, e-invoicing workflows, and contac',
    `customer_allocation_id` BIGINT COMMENT 'Foreign key linking to planning.customer_allocation. Business justification: In supply-constrained chemical markets (e.g., specialty chemicals, agrochemicals), invoices are issued against approved customer allocations. Allocation-to-invoice traceability is required for allocat',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Chemical mfg customers often have multiple sites with separate billing arrangements (e.g., tank farms, plant locations). Linking invoice to the ship-to/delivery site enables site-level revenue reporti',
    `distributor_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.distributor_agreement. Business justification: Distributor invoices in chemical manufacturing must reference the governing distributor agreement for compliance reporting, authorized product scope validation, and agreement-level revenue tracking. D',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Equipment lease, rental, and maintenance service invoices in chemical manufacturing reference specific assets. Not all equipment invoices have an associated work order (e.g., pure lease invoices). Dir',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Invoices for environmental compliance services, permit fees, and waste management must be attributed to the specific facility. Chemical manufacturers operate multiple facilities; facility-level invoic',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Evaluated Receipt Settlement (ERS): in chemical manufacturing, goods receipt posting directly triggers vendor invoice creation. Linking billing.invoice to supply.goods_receipt enables ERS billing trac',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: Invoices for external HAZOP study consulting services reference the specific study engagement. Chemical manufacturers commission third-party HAZOP facilitators for PSM-covered processes; linking invoi',
    `inspection_audit_id` BIGINT COMMENT 'Foreign key linking to ehs.inspection_audit. Business justification: Invoices for third-party inspection and audit services reference the specific audit engagement. Chemical manufacturers pay external auditors for PSM audits, EPA compliance audits, and ISO 14001 assess',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Required for posting each invoice as a revenue journal entry; finance uses journal_entry for GAAP revenue recognition, a standard process in chemical manufacturing.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Chemical manufacturers operate across multiple legal entities (subsidiaries, JVs). Invoices must be attributed to the issuing legal entity for statutory VAT reporting, intercompany billing reconciliat',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: In chemical manufacturing, invoices are issued against specific material lots for traceability, regulatory audit trails, and COA linkage. Lot-controlled billing is standard practice — regulators and c',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Invoice generation is based on a specific manufacturing order; required for order‑to‑cash reporting and traceability of sold product.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Needed for Opportunity‑to‑Invoice conversion metrics used in pipeline performance dashboards.',
    `order_confirmation_id` BIGINT COMMENT 'Foreign key linking to product.order_confirmation. Business justification: Invoices in chemical manufacturing are generated after order confirmation is issued. Linking invoice to order_confirmation enables billing teams to verify confirmed quantities, agreed prices, and deli',
    `order_id` BIGINT COMMENT 'Identifier of the sales order that generated this invoice.',
    `outbound_delivery_id` BIGINT COMMENT 'Identifier of the delivery/shipment associated with the invoice.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: invoice has a denormalized payment_terms (STRING) field that should reference the payment_term master table. In chemical manufacturing, payment terms (net 30, 2/10 net 30, etc.) are centrally managed ',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Invoice-to-price-agreement header linkage supports contract compliance reporting and rebate settlement reconciliation in chemical manufacturing. Domain experts expect invoices to reference the governi',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Required for linking each invoice to the specific production plan that generated the shipped product, enabling cost allocation, ASC 606 revenue recognition, and plant performance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Chemical manufacturing invoices are attributed to profit centers (e.g., Performance Materials, Crop Science) for segment P&L reporting and revenue analysis by business line. A domain expert expects ev',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order from the customer, if applicable.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Required for Quote‑to‑Invoice conversion tracking report, essential for sales effectiveness and compliance.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Required: Customers are charged per waste stream disposal; linking invoices to waste streams enables detailed billing and waste tracking.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance Chargeback Invoice Generation: each work order that incurs service costs is billed via an invoice referencing the originating work_order.',
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
    `calibration_record_id` BIGINT COMMENT 'Foreign key linking to maintenance.calibration_record. Business justification: External calibration labs invoice chemical plants per calibration event for instruments (flow meters, pressure transmitters). Each invoice line maps to a specific calibration_record. Required for GMP/',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Needed for cost and compliance reporting to map each invoice line to the underlying chemical product, supporting GHS classification and REACH reporting.',
    `coc_record_id` BIGINT COMMENT 'Foreign key linking to quality.coc_record. Business justification: Chemical manufacturing customers require a Certificate of Conformance per invoice line item for regulatory compliance and product traceability. The CoC-to-invoice-line traceability process — mandate',
    `contract_price_id` BIGINT COMMENT 'Foreign key linking to supply.contract_price. Business justification: Contract price compliance reporting: billing.invoice_line records actual billed unit prices; supply.contract_price holds negotiated contract prices. Direct FK enables price variance analysis (billed v',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: invoice_line has a plain-text cost_center column — a denormalization. Chemical manufacturing invoice lines are attributed to cost centers for cost allocation and overhead recovery reporting. A prope',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: invoice_line has a plain-text cost_element column. In chemical manufacturing, invoice line items map to cost elements for product costing, COGS analysis, and standard cost variance reporting. A prop',
    `customer_allocation_id` BIGINT COMMENT 'Foreign key linking to planning.customer_allocation. Business justification: In allocation-constrained chemical markets, each invoice line consumes a customer allocation. Allocation consumption tracking (allocated vs. billed quantity) is a core S&OP and order fulfillment compl',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Service invoices in chemical manufacturing itemize charges per equipment unit (e.g., per-reactor inspection fee, per-compressor overhaul line). Direct equipment FK on invoice_line enables equipment-le',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each invoice line posts to a specific GL account for product revenue; linking enables line‑level GL reporting required for statutory and internal financial statements.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Chemical invoice lines must reference the specific grade sold (USP, ACS, EP, GMP) because grade determines unit price, regulatory compliance codes, and revenue recognition category. Billing analysts r',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: In chemical manufacturing, invoice lines for project-based work (R&D, capital projects, specialty chemical development) are settled against internal orders. This link enables project cost settlement r',
    `invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Required for audit and compliance: links each invoice line to its originating order line to support revenue recognition, traceability, and regulatory reporting.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Chemical invoice lines must reference the specific production lot shipped for CoA/CoC traceability, REACH/GHS regulatory compliance, and customer quality documentation. A domain expert expects invoice',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: In chemical manufacturing, invoice line pricing is tied to a specific material specification version (grade, purity tier). Spec-based pricing, quality acceptance criteria, and contract compliance all ',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Three‑way match process matches invoice lines to PO lines to ensure pricing and quantity accuracy; a direct FK is essential for this control.',
    `price_agreement_line_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement_line. Business justification: Ensures invoiced pricing aligns with agreed price‑agreement terms, required for rebate and audit reports.',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: Chemical manufacturing ERP systems (SAP PP-PI) settle invoice lines against process orders for cost reconciliation and revenue attribution. A domain expert expects invoice lines to reference the proce',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: invoice_line carries a plain-text profit_center column — a denormalization. In chemical manufacturing, each line item is attributed to a profit center for segment-level gross margin reporting. Repla',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Supports line‑level audit of invoiced items versus quoted items for pricing compliance.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for the invoicing process to associate each line item with the exact SKU sold, enabling inventory tracking, pricing, and regulatory reporting.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Waste disposal invoice lines must reference the specific waste stream being billed. Chemical manufacturers bill cost centers per waste stream for disposal services; line-level traceability is required',
    `work_order_operation_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order_operation. Business justification: Detailed Maintenance Billing Line Items: invoice lines map to specific work order operations to itemize labor and material costs.',
    `accounting_date` DATE COMMENT 'Fiscal date used for posting the line to the ledger.',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: Credit memos and billing adjustments in chemical manufacturing are frequently caused by batch quality failures (OOS results, yield shortfalls, rejected batches). Direct traceability from billing_adjus',
    `billing_party_id` BIGINT COMMENT 'Identifier of the customer to whom the adjustment applies.',
    `breakdown_event_id` BIGINT COMMENT 'Foreign key linking to maintenance.breakdown_event. Business justification: Unplanned equipment breakdowns in chemical plants trigger emergency service charges, unplanned downtime penalties, or insurance-related billing adjustments. Direct FK to breakdown_event enables root-c',
    `coa_document_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.coa_document. Business justification: Quality-triggered billing adjustments (credit/debit memos) in chemical manufacturing directly reference the COA that evidenced the out-of-spec condition. This link supports quality-based credit memo p',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Credit memos, rebate adjustments, and billing corrections in chemical mfg are requested by or communicated to a specific customer contact. This link supports adjustment approval workflows, customer no',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: billing_adjustment has a plain-text cost_center_code column. Chemical manufacturing billing adjustments (rebates, price corrections, write-offs) are attributed to cost centers for controlling and di',
    `dispute_id` BIGINT COMMENT 'Foreign key linking to billing.dispute. Business justification: A billing_adjustment (credit or debit memo) is frequently issued as the resolution action for a customer dispute. The billing_adjustment already references the original invoice via reference_invoice_i',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Billing adjustments (rebates, price corrections, write-offs) in chemical manufacturing post to specific GL accounts for proper revenue/expense classification. The GL account determines whether an adju',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: GR discrepancy adjustments: in chemical manufacturing, goods receipt quantity/quality variances (damaged packaging, temperature excursions, short shipments) directly trigger billing adjustments (debit',
    `incoming_inspection_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.incoming_inspection. Business justification: Incoming inspection failures in chemical manufacturing trigger supplier credit memos and billing adjustments. Linking billing_adjustment to the specific inspection record supports the quality-to-finan',
    `inspection_audit_id` BIGINT COMMENT 'Foreign key linking to ehs.inspection_audit. Business justification: Billing adjustments for penalty fee corrections or compliance cost adjustments arising from inspection findings reference the specific audit. Chemical manufacturers receive amended penalty assessments',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Billing adjustments in chemical manufacturing are often issued at the line level — for example, a price correction on a specific chemical product line, a quantity dispute on a particular SKU, or a haz',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Adjustments (credits/debits) must be recorded in a journal entry for audit trail; finance requires this link for adjustment posting.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Billing adjustments for quality deductions, returns, and price corrections in chemical manufacturing are lot-specific. A credit memo for an off-spec batch must reference the lot. billing_adjustment ha',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Quality‑related credit memos: adjustments due to material defects need a link to the specific material master for audit trails and compliance investigations.',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Permit fee adjustments (amended assessments, penalty recalculations) must reference the specific operating permit. Chemical manufacturers receive amended permit fee invoices from agencies; the adjustm',
    `physical_inventory_count_id` BIGINT COMMENT 'Foreign key linking to inventory.physical_inventory_count. Business justification: Physical inventory count variances in chemical manufacturing trigger billing adjustments for consignment settlements, intercompany corrections, and customer-owned stock reconciliations. Linking billin',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Billing adjustments for retroactive price changes, index-linked escalations, and volume rebate true-ups in chemical manufacturing must reference the governing price agreement. This link is essential f',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: In chemical manufacturing, off-spec material or contamination events (quality deviations) directly trigger billing adjustments — price reductions, credits, or penalties. The quality-driven billing ad',
    `rebate_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_rebate_agreement. Business justification: Rebate accrual postings and true-up adjustments in chemical manufacturing must reference the governing sales rebate agreement. Domain experts expect billing adjustments for rebate accruals to be trace',
    `invoice_id` BIGINT COMMENT 'Identifier of the original invoice that is being adjusted.',
    `returns_order_id` BIGINT COMMENT 'Foreign key linking to product.returns_order. Business justification: Credit memos and billing adjustments in chemical manufacturing are directly triggered by approved product returns (off-spec, over-shipment, damaged goods). Linking billing_adjustment to returns_order ',
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
    `ar_open_item_id` BIGINT COMMENT 'Foreign key linking to billing.ar_open_item. Business justification: A payment_receipt clears one or more ar_open_items. This is the fundamental AR clearing relationship in SAP FI/CO-aligned billing: a payment is applied against an open AR item, reducing the outstandin',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Payment receipts in chemical manufacturing are deposited into specific treasury bank accounts. Linking to bank_account enables daily cash position reporting, bank reconciliation, and liquidity managem',
    `billing_party_id` BIGINT COMMENT 'Foreign key linking to billing.party. Business justification: payment_receipt has denormalized payer_name (STRING) and payer_identifier (STRING) fields that duplicate data from the billing party master. The billing.party table has legal_name and registration_num',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Payment remittance advice in chemical mfg is submitted by a specific AP contact at the customer. Linking payment receipts to the contact enables cash application accuracy, remittance reconciliation, a',
    `invoice_id` BIGINT COMMENT 'Identifier of the accounts‑receivable invoice to which this payment is applied.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Payment receipts generate cash‑receipt journal entries; the link supports cash application and reconciliation reports mandated by finance.',
    `order_id` BIGINT COMMENT 'Identifier of the sales order that generated the invoiced amount.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: payment_receipt has a denormalized payment_terms (STRING) field. Adding payment_term_id normalizes the reference to the payment_term master, enabling early payment discount validation and reconciliati',
    `returns_order_id` BIGINT COMMENT 'Foreign key linking to product.returns_order. Business justification: Refund payments in chemical manufacturing are issued against approved returns orders. payment_receipt has an is_refund flag but no link to the originating returns_order. Cash application teams must ma',
    `amount_discount` DECIMAL(18,2) COMMENT 'Discounts or rebates applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount received before any deductions.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after tax and discount adjustments; the amount posted to accounts receivable.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax component deducted from the gross amount, if applicable.',
    `bank_name` STRING COMMENT 'Name of the financial institution that processed the payment.',
    `bank_routing_number` STRING COMMENT 'Routing/ABA number identifying the payers bank.',
    `check_number` STRING COMMENT 'Number on the check, if payment method is check.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the payment was made.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign currency amount to the functional currency, if applicable.',
    `foreign_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount expressed in the original foreign currency before conversion.',
    `is_advance_payment` BOOLEAN COMMENT 'True if the payment is an advance against future goods or services.',
    `is_refund` BOOLEAN COMMENT 'True if the payment represents a refund to the customer.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted (online portal, mobile app, branch, or mail).. Valid values are `online|mobile|branch|mail`',
    `payment_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the payment.',
    `payment_method` STRING COMMENT 'Instrument used to transfer funds (e.g., wire, ACH, check, credit card, cash).. Valid values are `wire|ach|check|credit_card|cash`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment receipt.. Valid values are `pending|processed|rejected|cancelled`',
    `payment_timestamp` TIMESTAMP COMMENT 'Exact date and time when the payment was received and recorded.',
    `receipt_number` STRING COMMENT 'Business identifier assigned to the receipt, used for external reference and audit.',
    `reconciliation_status` STRING COMMENT 'Result of matching the payment to open invoices.. Valid values are `unmatched|matched|partial|error`',
    `source_system` STRING COMMENT 'Name of the source system that generated the payment record (e.g., SAP FI, external bank feed).',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or rule applied to the payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment receipt record.',
    CONSTRAINT pk_payment_receipt PRIMARY KEY(`payment_receipt_id`)
) COMMENT 'Record of a customer payment received against an open accounts receivable invoice. Captures payment document number, payment date, payment method (wire, ACH, check), amount received, currency, bank clearing reference, and allocation to specific invoices. Supports payment reconciliation and AR aging in SAP FI.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` (
    `ar_open_item_id` BIGINT COMMENT 'System-generated unique identifier for the open AR item.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: AR collections in chemical mfg require contacting a specific AP contact at the customer for dunning and overdue item resolution. Linking AR open items to the responsible contact enables targeted dunni',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR aging reports are often broken out by cost center; linking open items to cost_center enables cost‑center level DSO analysis.',
    `dispute_id` BIGINT COMMENT 'Foreign key linking to billing.dispute. Business justification: ar_open_item has three denormalized dispute fields: dispute_flag (BOOLEAN), dispute_amount (DECIMAL), and dispute_reason (STRING). These duplicate data that belongs in the dispute master record. Addin',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR open items post to AR reconciliation GL accounts in chemical manufacturing. The AR subledger-to-GL reconciliation is a mandatory month-end close process. This FK enables automated reconciliation re',
    `invoice_id` BIGINT COMMENT 'Unique identifier of the source invoice in SAP FI.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AR open items must be attributed to a legal entity for statutory balance sheet reporting, intercompany AR netting, and country-specific credit management. Chemical manufacturers with multi-entity stru',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: ar_open_item has a denormalized payment_terms_code (STRING) that duplicates data from the payment_term master reference table. Adding payment_term_id as a typed FK normalizes this reference, enabling ',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer in the master data system.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AR open items in chemical manufacturing are tracked by profit center for segment-level DSO (Days Sales Outstanding) reporting and credit risk management by business line. Finance controllers need prof',
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
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `dunning_level` STRING COMMENT 'Current dunning step applied to the overdue item, where higher numbers indicate more severe collection actions.. Valid values are `1|2|3|4|5|6`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount including tax before any discounts or write‑offs.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment applied to the item.',
    `overdue_days` STRING COMMENT 'Number of days past the due date that the item remains unpaid.',
    `partial_payment_flag` BOOLEAN COMMENT 'True if one or more partial payments have been applied to the item.',
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
    `billing_party_id` BIGINT COMMENT 'Foreign key linking to billing.party. Business justification: dispute currently references the customer via account_id -> customer.account (cross-domain). The billing.party table is the in-domain billing party master that represents the entity raising the disput',
    `case_id` BIGINT COMMENT 'Identifier of a linked case or ticket in the customer service system.',
    `coa_document_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.coa_document. Business justification: Billing disputes in chemical manufacturing are frequently initiated because a COA shows out-of-specification material. Linking dispute to coa_document provides the evidentiary basis for the dispute, s',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Billing disputes in chemical mfg (e.g., price discrepancies, short deliveries, quality deductions) are raised by a specific customer contact (procurement or quality manager). This link enables dispute',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Disputes in chemical mfg frequently originate at a specific delivery site (e.g., short delivery to a plant, quality rejection at a tank farm). Linking disputes to the customer site enables site-level ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Disputes over equipment maintenance charges, lease fees, or calibration service invoices in chemical manufacturing reference specific equipment assets. Direct FK enables equipment-level dispute tracki',
    `invoice_id` BIGINT COMMENT 'System identifier of the invoice that is under dispute.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to product.line_item. Business justification: Customer disputes in chemical manufacturing are raised at the line-item level (wrong quantity, wrong grade, incorrect hazmat surcharge). Dispute resolution teams must pinpoint the exact order line con',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Customer billing disputes in chemical manufacturing are frequently lot-specific — off-spec batches, contamination, or purity failures trigger invoice disputes tied to a specific lot. dispute has mater',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Dispute analysis: linking disputes to the material master allows root‑cause analysis of quality or specification issues raised by customers.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Price agreement disputes — index escalation disagreements, volume tier classification disputes, take-or-pay shortfall challenges — are a named business process in chemical manufacturing. Domain expert',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Customer billing disputes in chemical manufacturing are frequently caused by quality deviations (OOS results, contamination, off-spec shipments). The quality-driven dispute resolution process requir',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Pricing disputes in chemical manufacturing frequently originate from discrepancies between invoiced price and the quoted price. Linking dispute directly to the originating quote enables root-cause ana',
    `returns_order_id` BIGINT COMMENT 'Foreign key linking to product.returns_order. Business justification: Disputes in chemical manufacturing frequently arise from or trigger returns (off-spec batch, contaminated shipment). AR teams must link a dispute to its associated returns order to determine whether a',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` (
    `revenue_recognition_event_id` BIGINT COMMENT 'Unique identifier for the revenue recognition event.',
    `account_id` BIGINT COMMENT 'Identifier of the customer associated with the revenue event.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: In GMP chemical manufacturing, batch release (QA approval of batch_record) is a distinct revenue recognition trigger under ASC 606/IFRS 15. Revenue recognition events must reference the specific appro',
    `billing_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.billing_schedule. Business justification: In chemical manufacturing, milestone-based and periodic billing schedules directly trigger revenue recognition events (ASC 606 performance obligation satisfaction). A billing_schedule with is_mileston',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: revenue_recognition_event has a plain-text cost_center_code. Under ASC 606/IFRS 15, chemical manufacturers attribute recognized revenue to cost centers for controlling integration. A proper FK repla',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Revenue recognition in chemical mfg is triggered by delivery to a specific customer site (ASC 606/IFRS 15 point-in-time recognition upon delivery). Consignment and tank farm arrangements require site-',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: ASC 606/IFRS 15 revenue recognition for long-term equipment maintenance service contracts requires tracking performance obligations per equipment asset. Direct FK enables equipment-level deferred/reco',
    `fiscal_period_id` BIGINT COMMENT 'Financial period identifier (e.g., FY2023Q2) for the revenue event.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Revenue recognition events in chemical manufacturing are triggered by invoice generation (ASC 606 / IFRS 15 compliance). The revenue_recognition_event currently has a generic polymorphic source_event_',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Revenue recognition events must be attributed to a legal entity for statutory financial reporting under IFRS 15/ASC 606. Chemical manufacturers with multi-entity structures require legal entity attrib',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Revenue recognition in chemical manufacturing under ASC 606/IFRS 15 is triggered by lot-level delivery acceptance — revenue is recognized when a specific lot transfers control to the customer. revenue',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Revenue must be recognized when a manufacturing order is completed (ASC 606/IFRS 15); linking enables accurate revenue timing.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: ASC 606/IFRS 15 compliance: revenue events tied to material deliveries need the material identifier to allocate revenue correctly.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Revenue recognition is driven by closed opportunities; linking enables ASC 606/IFRS15 reporting.',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: ASC 606/IFRS 15 revenue recognition ties events to performance obligation fulfillment tracked at the order level. Revenue recognition events can exist without an invoice (bill-and-hold, consignment ar',
    `outbound_delivery_id` BIGINT COMMENT 'Foreign key linking to product.outbound_delivery. Business justification: Under ASC 606, revenue is recognized at transfer of control, which in chemical manufacturing occurs at point of delivery. Linking revenue_recognition_event directly to outbound_delivery enables financ',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Under ASC 606/IFRS 15, revenue recognition in chemical manufacturing is triggered by production completion milestones defined in the production schedule (e.g., batch release, campaign completion). Aud',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue recognition events under ASC 606/IFRS 15 must be attributed to profit centers for segment P&L reporting in chemical manufacturing. Auditors and controllers require profit-center-level recogniz',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the accounting journal entry generated for this revenue event.',
    `reversal_of_event_revenue_recognition_event_id` BIGINT COMMENT 'If this event is a reversal, references the original revenue recognition event.',
    `compliance_flag_asc606` BOOLEAN COMMENT 'Flag indicating compliance with ASC 606 revenue recognition criteria.',
    `compliance_flag_ifrs15` BOOLEAN COMMENT 'Flag indicating compliance with IFRS 15 revenue recognition criteria.',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Long-term chemical supply billing schedules (e.g., annual contracts, consignment replenishment) are negotiated and managed with a specific customer contact. This link supports contract renewal notific',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Billing schedules in chemical mfg are frequently site-specific — e.g., scheduled bulk chemical deliveries to a customers tank farm or production site. Site-level billing schedules enable accurate del',
    `distributor_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.distributor_agreement. Business justification: Distributor agreements in chemical manufacturing drive recurring billing schedules for annual volume commitments and rebate settlement cycles. Domain experts expect billing schedules to reference the ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Chemical manufacturers set up recurring billing schedules for equipment leasing, equipment-as-a-service, or long-term maintenance service contracts tied to specific assets (reactors, compressors). Dir',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Long-term supply contracts in chemical manufacturing are frequently grade-specific (pharmaceutical customer contracts for USP-grade only at a premium price). billing_schedule has chemical_product_id b',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Billing schedules in chemical manufacturing multi-entity structures must be attributed to the invoicing legal entity for intercompany billing compliance, VAT determination, and statutory revenue forec',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Milestone-based billing schedules in toll/contract chemical manufacturing are triggered by manufacturing order status changes (e.g., order release, completion). Linking billing_schedule to manufacturi',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Contractual billing: scheduled billing for raw‑material supply contracts requires linking each schedule to the specific material being supplied.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Billing schedules for take-or-pay and milestone contracts in chemical manufacturing originate from won opportunities. Linking billing_schedule to opportunity enables pipeline-to-cash tracking and fore',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Billing schedules reference payment terms; adding a payment_term_id FK formalizes this relationship and allows joins to retrieve term details.',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Preventive maintenance service contracts in chemical plants generate billing schedules synchronized with PM plan cycles (annual inspections, scheduled turnarounds). Direct FK enables automated billing',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Derives billing frequency and amounts from the governing price agreement, used in contract billing execution.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Long-term chemical supply contracts use milestone billing tied directly to production plan milestones (e.g., campaign start, batch completion). The billing_schedule must reference the production_plan ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Long-term supply contracts in chemical manufacturing are priced at the SKU level (specific pack size and configuration). billing_schedule has chemical_product_id but no sku_id, preventing contract bil',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: Take-or-pay and volume-commitment contracts in chemical manufacturing align billing schedules directly to supply plans. The supply plan governs committed delivery quantities and timing; the billing sc',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Recurring billing schedules for ongoing waste stream management contracts reference the specific waste stream. Chemical manufacturers set up periodic billing for hazardous waste disposal services tied',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`billing_party` (
    `billing_party_id` BIGINT COMMENT 'Primary key for party',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Billing parties (customers, vendors, intercompany counterparties) in chemical manufacturing are associated with legal entities for intercompany transaction management, VAT registration validation, and',
    `parent_party_billing_party_id` BIGINT COMMENT 'Identifier of the parent party in hierarchical relationships.',
    `primary_ultimate_parent_billing_party_id` BIGINT COMMENT 'Top-level parent party identifier for consolidated reporting.',
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
    `party_status` STRING COMMENT 'Current lifecycle status of the party.',
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
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the party is exempt from sales tax.',
    `tax_identifier` STRING COMMENT 'Tax identification number (e.g., EIN, VAT) for the party.',
    `trade_name` STRING COMMENT 'Commonly used trade or brand name of the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the party record.',
    `vat_number` STRING COMMENT 'VAT registration number for the party.',
    CONSTRAINT pk_billing_party PRIMARY KEY(`billing_party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`billing`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Primary key for settlement',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Settlements in chemical manufacturing are executed through specific treasury bank accounts. Linking settlement to bank_account enables cash position management, bank statement reconciliation, and paym',
    `billing_adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.billing_adjustment. Business justification: A settlement record can clear a billing_adjustment (credit memo applied against an open balance). settlement currently links to invoice and payment_receipt but lacks a direct link to billing_adjustmen',
    `billing_party_id` BIGINT COMMENT 'Identifier of the party (customer, vendor, etc.) associated with the settlement.',
    `dispute_id` BIGINT COMMENT 'Foreign key linking to billing.dispute. Business justification: settlement has denormalized dispute_flag (BOOLEAN) and dispute_reason (STRING) fields. A settlement can be the resolution mechanism for a dispute (e.g., partial payment agreed upon dispute resolution)',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice that this settlement settles.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Settlements must be attributed to a legal entity for intercompany netting, statutory cash flow reporting, and regulatory payment compliance. Chemical manufacturers with global treasury centers require',
    `payment_receipt_id` BIGINT COMMENT 'Identifier of the payment receipt linked to this settlement.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: settlement has a denormalized payment_terms (STRING) field. Adding payment_term_id normalizes the reference to the payment_term master, enabling consistent early payment discount application and settl',
    `rebate_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_rebate_agreement. Business justification: Rebate settlement is a core named business process in chemical manufacturing — paying out accrued rebates against a sales rebate agreement. Linking settlement directly to sales_rebate_agreement enable',
    `reversed_settlement_id` BIGINT COMMENT 'Self-referencing FK on settlement (reversed_settlement_id)',
    `approval_status` STRING COMMENT 'Overall approval state of the settlement.',
    `approved_by` STRING COMMENT 'User who approved the settlement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement was approved.',
    `batch_number` STRING COMMENT 'Batch identifier for bulk settlement processing.',
    `channel` STRING COMMENT 'Channel through which the settlement was processed.',
    `country` STRING COMMENT 'Country associated with the settlement transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the settlement.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount applied to the gross amount before tax.',
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
    `region` STRING COMMENT 'Geographic region (e.g., North America, EMEA) for reporting.',
    `settlement_description` STRING COMMENT 'Free‑form text describing the settlement purpose or details.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement.',
    `settlement_type` STRING COMMENT 'Category of settlement (e.g., invoice, credit memo).',
    `source_system` STRING COMMENT 'Originating system of the settlement record (e.g., SAP FI, external ERP).',
    `status_reason` STRING COMMENT 'Explanation for the current settlement status.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the settlement.',
    `tax_code` STRING COMMENT 'Tax code applied to the settlement.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage used to calculate tax_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    `created_by` STRING COMMENT 'User or system that created the settlement record.',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Master reference table for settlement. Referenced by settlement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_party_id` FOREIGN KEY (`billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_schedule`(`billing_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_billing_party_id` FOREIGN KEY (`billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ADD CONSTRAINT `fk_billing_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_ar_open_item_id` FOREIGN KEY (`ar_open_item_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`ar_open_item`(`ar_open_item_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_billing_party_id` FOREIGN KEY (`billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ADD CONSTRAINT `fk_billing_payment_receipt_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ADD CONSTRAINT `fk_billing_ar_open_item_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_billing_party_id` FOREIGN KEY (`billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_schedule`(`billing_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_reversal_of_event_revenue_recognition_event_id` FOREIGN KEY (`reversal_of_event_revenue_recognition_event_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`revenue_recognition_event`(`revenue_recognition_event_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ADD CONSTRAINT `fk_billing_billing_schedule_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ADD CONSTRAINT `fk_billing_billing_party_parent_party_billing_party_id` FOREIGN KEY (`parent_party_billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ADD CONSTRAINT `fk_billing_billing_party_primary_ultimate_parent_billing_party_id` FOREIGN KEY (`primary_ultimate_parent_billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_billing_adjustment_id` FOREIGN KEY (`billing_adjustment_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_adjustment`(`billing_adjustment_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_billing_party_id` FOREIGN KEY (`billing_party_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`billing_party`(`billing_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_payment_receipt_id` FOREIGN KEY (`payment_receipt_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_receipt`(`payment_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ADD CONSTRAINT `fk_billing_settlement_reversed_settlement_id` FOREIGN KEY (`reversed_settlement_id`) REFERENCES `chemical_mfg_ecm`.`billing`.`settlement`(`settlement_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `chemical_mfg_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Document Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `customer_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `distributor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID (SO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `outbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID (DELIV_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID (PO_ID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `coc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Coc Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `contract_price_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `customer_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `price_agreement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `work_order_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Operation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`invoice_line` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `billing_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `breakdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Event Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Document Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `incoming_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Incoming Inspection Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `physical_inventory_count_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Count Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_adjustment` ALTER COLUMN `returns_order_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Order Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `ar_open_item_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Open Item Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `billing_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `returns_order_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_discount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|mobile|branch|mail');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ach|check|credit_card|cash');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|rejected|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|partial|error');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `ar_open_item_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Open Item Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `overdue_days` SET TAGS ('dbx_business_glossary_term' = 'Overdue Days');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`ar_open_item` ALTER COLUMN `partial_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Indicator');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `billing_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Document Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Line Item Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`dispute` ALTER COLUMN `returns_order_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Order Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `outbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `reversal_of_event_revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Event ID');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `compliance_flag_asc606` SET TAGS ('dbx_business_glossary_term' = 'ASC 606 Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`revenue_recognition_event` ALTER COLUMN `compliance_flag_ifrs15` SET TAGS ('dbx_business_glossary_term' = 'IFRS 15 Compliance Flag');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`payment_term` SET TAGS ('dbx_subdomain' = 'payment_settlement');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule ID (BSID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUSTID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID (PID)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `distributor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_schedule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `billing_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`billing_party` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `billing_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rebate Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`billing`.`settlement` ALTER COLUMN `reversed_settlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
