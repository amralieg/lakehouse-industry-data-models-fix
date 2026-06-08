-- Schema for Domain: billing | Business: Automotive | Version: v1_mvm
-- Generated on: 2026-05-07 02:20:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `automotive_ecm`.`billing` COMMENT 'SSOT for all revenue transactions and receivables. Owns dealer invoices, retail customer billing, fleet account statements, parts and service charges, payment records, credit notes, and dispute management. Handles invoicing, payment receipt, credit memos, and financial settlement for vehicle sales and services. Integrates with SAP SD/FI and supports MSRP-based and negotiated pricing models.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Invoicing is performed per billing account; needed for account‑level revenue reporting and statement generation.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Invoice includes carrier charges; linking to carrier enables carrier performance reporting and compliance with freight cost audits.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Invoices must post to a legal entity (company code) for financial consolidation, statutory reporting, and intercompany reconciliation. Required for SAP FI integration and multi-entity automotive opera',
    `dealer_statement_id` BIGINT COMMENT 'Foreign key linking to billing.dealer_statement. Business justification: A dealer statement is a periodic summary of invoices issued to a dealer. Individual invoices belong to a dealer statement period. Adding dealer_statement_id to invoice enables grouping invoices by sta',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Revenue recognition and period-close processes require invoices assigned to fiscal periods for accrual accounting, financial statement preparation, and revenue cutoff controls in automotive manufactur',
    `party_id` BIGINT COMMENT 'Reference to the customer (dealer, retail buyer, fleet account, or corporate buyer) to whom this invoice is issued.',
    `dealership_id` BIGINT COMMENT 'Reference to the dealer entity when the invoice is issued to a dealer for wholesale vehicle or parts transactions. Null for retail and fleet invoices.',
    `invoice_dealership_id` BIGINT COMMENT 'Reference to the dealer entity when the invoice is issued to a dealer for wholesale vehicle or parts transactions. Null for retail and fleet invoices.',
    `invoice_party_id` BIGINT COMMENT 'Reference to the customer (dealer, retail buyer, fleet account, or corporate buyer) to whom this invoice is issued.',
    `msrp_pricing_id` BIGINT COMMENT 'Foreign key linking to vehicle.msrp_pricing. Business justification: Automotive vehicle sale invoices are generated from the OEM MSRP pricing record — the invoice price basis, gas guzzler tax, EV tax credit eligibility, and destination charge all derive from the MSRP p',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Invoice references a payment term; using a foreign key to payment_term provides full term details and removes the redundant code column.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_purchase_order. Business justification: AP process matches supplier purchase orders to invoices for payment reconciliation; experts expect a PO FK on invoice.',
    `rebate_agreement_id` BIGINT COMMENT 'Foreign key linking to billing.rebate_agreement. Business justification: Rebate agreements generate credit invoices or settlement invoices when rebates are paid out. Linking invoice.rebate_agreement_id to rebate_agreement enables tracking which invoices (particularly credi',
    `rep_id` BIGINT COMMENT 'Reference to the salesperson or account manager responsible for this sale, used for commission and performance tracking.',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_contract. Business justification: REQUIRED: Service‑contract billing generates periodic invoices; linking enables contract‑level revenue and compliance tracking.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Freight invoices must reference specific shipments for cost reconciliation, accrual accounting, and dispute resolution. OEMs receive carrier invoices itemizing shipment-level charges; finance requires',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Needed for program-level financial reporting and cost allocation: linking each invoice to its vehicle program enables revenue tracking per engineering program.',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Invoices for vehicle sales need to reference the exact vehicle VIN; adding vin_id creates a direct link between billing and the vehicle master.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address to which the invoice is sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, building, department).',
    `billing_city` STRING COMMENT 'City of the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code of the billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_entity_code` STRING COMMENT 'Code identifying the legal entity or business unit issuing the invoice (e.g., regional sales company, parts distribution center, service center).. Valid values are `^[A-Z0-9]{4,10}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address.',
    `billing_state_province` STRING COMMENT 'State or province of the billing address.',
    `cancellation_reason` STRING COMMENT 'Description of the reason for invoice cancellation (order cancelled, billing error, duplicate invoice).',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice was cancelled, if applicable. Null for active invoices.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system. Audit trail field.',
    `credit_memo_reference` STRING COMMENT 'Reference to a credit memo document number if this invoice has been partially or fully credited.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code in which the invoice is denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice (volume discounts, promotional discounts, early payment discounts).',
    `dispute_date` DATE COMMENT 'Date when the invoice was flagged as disputed by the customer or internal review.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the invoice status is disputed (pricing error, quantity mismatch, quality issue, delivery issue).',
    `due_date` DATE COMMENT 'The date by which payment is expected per the agreed payment terms.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year when the invoice was issued.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice was issued, used for financial reporting and period closing.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes, discounts, and adjustments.',
    `invoice_date` DATE COMMENT 'The date the invoice was formally issued to the customer. Principal business event timestamp for the billing transaction.',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice document number issued to the customer. Business identifier for the invoice.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the billing and collection workflow.. Valid values are `draft|issued|partially_paid|paid|cancelled|disputed`',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the customer segment and transaction nature (dealer wholesale, retail customer, fleet account, parts sale, service work, warranty claim).. Valid values are `dealer|retail|fleet|parts|service|warranty`',
    `model_year` STRING COMMENT 'Model year of the vehicle or product being invoiced, providing context for pricing and product configuration.',
    `msrp_based_flag` BOOLEAN COMMENT 'Indicates whether the invoice pricing is based on MSRP (true) or negotiated/contracted pricing (false).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final invoice amount payable after applying taxes, discounts, and all adjustments. This is the amount due from the customer.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice (special instructions, payment arrangements, delivery notes).',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice (net_amount minus paid_amount).',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid against this invoice to date. Used to track partial payments.',
    `payment_method` STRING COMMENT 'The payment instrument or method expected or used for settling this invoice.. Valid values are `wire_transfer|check|credit_card|ach|cash|letter_of_credit`',
    `payment_received_date` DATE COMMENT 'Date when the full or final payment was received for this invoice. Null if not yet fully paid.',
    `sales_order_number` STRING COMMENT 'Reference to the originating sales order or service order that this invoice bills for.. Valid values are `^[A-Z0-9]{8,20}$`',
    `sales_region_code` STRING COMMENT 'Code identifying the sales region or territory to which this invoice is attributed for revenue reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `sap_billing_document_number` STRING COMMENT 'Reference to the SAP SD billing document number from which this invoice was generated. System of record identifier.. Valid values are `^[0-9]{10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice (sales tax, VAT, GST, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified. Audit trail field.',
    `vin` STRING COMMENT '17-character Vehicle Identification Number of the vehicle being invoiced, if applicable (for vehicle sales invoices).. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a formal demand for payment issued to dealers, retail customers, fleet accounts, or corporate buyers for vehicle sales, parts, or services. Captures invoice number, invoice date, due date, invoice type (dealer/retail/fleet/parts/service), billing entity, billing address, currency, total amount, tax amount, discount amount, net amount, payment terms, invoice status (draft/issued/partially_paid/paid/cancelled/disputed), SAP SD billing document reference, MSRP-based or negotiated pricing flag, and model year context. SSOT for all outbound billing documents in the enterprise.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice_line product.',
    `aftersales_service_appointment_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_appointment. Business justification: REQUIRED: Service appointments generate billable items; linking appointment to invoice line provides appointment‑level financial reporting.',
    `aftersales_warranty_claim_id` BIGINT COMMENT 'Foreign key linking to aftersales.aftersales_warranty_claim. Business justification: Warranty claims generate invoice lines for OEM reimbursement to dealers. Critical for warranty accounting, dealer compensation, and financial reconciliation. Standard warranty reimbursement billing pr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed to allocate line‑level costs to the correct cost center for internal cost tracking and reporting.',
    `dealer_incentive_claim_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_incentive_claim. Business justification: Incentive settlement invoice lines reference specific claims being paid. Enables claim-level payment reconciliation - critical for dealer incentive program financial tracking and audit.',
    `dealer_inventory_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_inventory. Business justification: Vehicle sales invoice lines reference specific dealer inventory stock records. Enables line-level inventory tracking for invoiced units - critical for inventory reconciliation and stock management.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for General Ledger posting of each invoice line revenue to the appropriate GL account for financial reporting.',
    `goodwill_adjustment_id` BIGINT COMMENT 'Foreign key linking to aftersales.goodwill_adjustment. Business justification: Goodwill adjustments create credit memo invoice lines for customer satisfaction resolutions. Required for financial adjustment tracking, customer account reconciliation, and goodwill cost reporting in',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the billing invoice document.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to sales.order_line. Business justification: Invoice lines itemize order lines (vehicle, accessories, options, delivery charges). Core billing detail: each invoiced item traces to ordered item for revenue recognition, warranty tracking, and orde',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Required for warranty claim and recall tracking: each invoice line must reference the engineering part master to associate sold parts with design, compliance, and cost data.',
    `parts_inventory_id` BIGINT COMMENT 'Foreign key linking to dealer.parts_inventory. Business justification: Parts sales invoice lines reference dealer parts inventory for parts sold to dealers. Standard parts distribution invoicing - tracks which inventory items were invoiced.',
    `parts_order_id` BIGINT COMMENT 'Foreign key linking to aftersales.aftersales_parts_order. Business justification: Parts orders generate invoice lines when parts are sold to dealers or service centers. Essential for wholesale parts billing, dealer statement generation, and parts revenue recognition.',
    `parts_return_id` BIGINT COMMENT 'Foreign key linking to aftersales.parts_return. Business justification: Parts returns generate credit memo invoice lines for returned inventory. Essential for returns processing, inventory adjustment, dealer credit management, and parts return financial reconciliation.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.supply_po_line. Business justification: Invoice line validation against PO line items is required for accurate cost allocation and audit; standard in automotive AP.',
    `price_condition_id` BIGINT COMMENT 'Foreign key linking to billing.price_condition. Business justification: Invoice line items can be priced by a pricing condition; linking to price_condition normalizes pricing logic.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports profit‑center profitability analysis by linking each sales line to its profit center.',
    `recall_completion_id` BIGINT COMMENT 'Foreign key linking to dealer.recall_completion. Business justification: Recall reimbursement invoice lines reference specific recall completions. Enables recall-level payment tracking - critical for campaign cost management and regulatory reporting.',
    `rep_id` BIGINT COMMENT 'Identifier of the salesperson who completed this transaction. Used for sales commission calculation and performance tracking.',
    `repair_order_line_id` BIGINT COMMENT 'Foreign key linking to aftersales.repair_order_line. Business justification: REQUIRED: Each invoice line originates from a repair‑order line; the link supports detailed cost‑to‑service analysis.',
    `service_contract_claim_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_contract_claim. Business justification: REQUIRED: Claims under service contracts are billed; linking claim to invoice line enables claim settlement and audit.',
    `service_part_id` BIGINT COMMENT 'Foreign key linking to aftersales.service_part. Business justification: Service parts sold generate invoice line items with specific part pricing, cost, and margin tracking. Essential for parts revenue recognition, inventory valuation, and profitability analysis in afters',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_leg. Business justification: Intermodal freight invoicing itemizes costs per leg (ocean, rail, trucking, port handling). Invoice lines must reference specific legs for cost allocation to business units, dispute resolution on leg-',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Invoice lines for parts/materials sales must reference the specific SKU being billed. Essential for parts revenue tracking, warranty claims processing, and service parts invoicing in automotive afters',
    `tax_code_id` BIGINT COMMENT 'Foreign key linking to billing.tax_code. Business justification: Invoice line tax details should reference the tax_code master; the tax rate can be derived, so the string code and rate columns are redundant.',
    `trim_option_availability_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_option_package. Business justification: Option packages (sunroof, towing, tech packages) are billed as discrete invoice line items in automotive dealer invoicing. Linking billing_invoice_line to vehicle_option_package enables option package',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Invoice line items are allocated to a specific vehicle for warranty and service charge tracking; linking ensures accurate vehicle‑level financial reporting.',
    `billing_date` DATE COMMENT 'Date when this line item was billed. Represents the accounting date for revenue recognition and the invoice document date.',
    `cancellation_reason` STRING COMMENT 'Reason code or description if this line was cancelled. Provides audit trail for cancelled billing lines and supports dispute analysis.',
    `cost_center` STRING COMMENT 'Cost center responsible for this revenue line. Used for internal cost accounting and profitability analysis by organizational unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was first created in the billing system. Provides audit trail for record creation.',
    `credit_memo_reference` STRING COMMENT 'Reference to the credit memo document if this line was credited. Links to the reversing document for returns, adjustments, or billing corrections.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Indicates the currency in which the line is billed (e.g., USD, EUR, JPY, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `dealer_code` STRING COMMENT 'Dealer or distribution partner code responsible for this sale. Identifies the selling dealer location for dealer network reporting and commission calculation.',
    `delivery_number` STRING COMMENT 'Reference to the delivery document that fulfilled this line. Links the billing to the physical shipment or service delivery event.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item. Represents the monetary reduction from the base unit price, including promotional discounts, volume discounts, and negotiated reductions.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount expressed as a percentage of the unit price. Provides the rate of discount applied to calculate the discount_amount.',
    `item_code` STRING COMMENT 'Universal item identifier for the billed product or service. May represent a vehicle model code, part number, labor operation code, accessory SKU (Stock Keeping Unit), or fee code depending on line_item_type.',
    `item_description` STRING COMMENT 'Human-readable description of the billed item. Provides detailed text explaining the product, service, or charge represented by this line.',
    `labor_operation_code` STRING COMMENT 'Standardized labor operation code for service work. Identifies the specific repair or maintenance task performed. Populated only when line_item_type is labor.',
    `line_item_type` STRING COMMENT 'Classification of the invoice line item. Distinguishes between vehicle units, parts, labor operations, accessories, service fees, freight charges, warranty products, and insurance products. [ENUM-REF-CANDIDATE: vehicle|part|labor|accessory|fee|freight|warranty|insurance — 8 candidates stripped; promote to reference product]',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and display sequence of line items on the invoice document.',
    `line_status` STRING COMMENT 'Current processing status of the invoice line. Tracks the lifecycle state from initial billing through payment or dispute resolution.. Valid values are `open|billed|paid|cancelled|disputed|credited`',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total amount for this line item including all charges and taxes. Calculated as subtotal_amount + tax_amount. Represents the final billable amount for this line.',
    `modified_by` STRING COMMENT 'User identifier of the person or system that last modified this invoice line record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was last modified. Tracks the most recent update to the record for audit and data quality purposes.',
    `msrp` DECIMAL(18,2) COMMENT 'Manufacturer Suggested Retail Price for the item. The list price recommended by the OEM (Original Equipment Manufacturer). Primarily applicable to vehicle and accessory line items.',
    `negotiated_price` DECIMAL(18,2) COMMENT 'Final negotiated price per unit after dealer or customer negotiations. May differ from MSRP (Manufacturer Suggested Retail Price) based on market conditions, promotions, or customer agreements.',
    `notes` STRING COMMENT 'Free-text notes or comments about this invoice line. Captures special instructions, explanations, or additional context for the billing line item.',
    `profit_center` STRING COMMENT 'Profit center for internal P&L (Profit and Loss) reporting. Enables profitability analysis by business segment, product line, or geographic region.',
    `promotion_code` STRING COMMENT 'Marketing promotion or incentive program code applied to this line. Tracks the specific promotional campaign that influenced the pricing or discount.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of items or units billed on this line. For vehicles typically 1, for parts the number of units, for labor the number of hours.',
    `revenue_category` STRING COMMENT 'Revenue classification for financial reporting and analytics. Categorizes the line item into major revenue streams for P&L (Profit and Loss) reporting and business intelligence. [ENUM-REF-CANDIDATE: new_vehicle|used_vehicle|parts|service|warranty|finance|insurance — 7 candidates stripped; promote to reference product]',
    `sales_order_line_number` STRING COMMENT 'Line number on the originating sales order. Provides traceability from the invoice line back to the specific sales order line item.',
    `sales_order_number` STRING COMMENT 'Reference to the originating sales order document. Links the invoice line back to the sales order that authorized this billing.',
    `service_date` DATE COMMENT 'Date when the service or delivery occurred. For labor lines, the date the work was performed; for parts, the date the parts were delivered; for vehicles, the delivery date.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Line subtotal before taxes. Calculated as (quantity × unit_price) - discount_amount. Represents the net selling amount before tax.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on this line item. Calculated by applying the tax_rate to the subtotal_amount. Includes sales tax, VAT (Value Added Tax), or GST (Goods and Services Tax) as applicable.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity. EA=Each (for countable items), HR=Hour (for labor), KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon, M=Meter, FT=Foot. [ENUM-REF-CANDIDATE: EA|HR|KG|LB|L|GAL|M|FT — 8 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit before discounts and taxes. Represents the base selling price for one unit of the item.',
    `warranty_code` STRING COMMENT 'Warranty program code if this line represents warranty coverage. Identifies the specific warranty plan or extended service contract being billed.',
    `created_by` STRING COMMENT 'User identifier of the person or system that created this invoice line record. Supports audit trail and accountability.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line item on a billing invoice representing a specific charge for a vehicle unit, parts SKU, labor operation, accessory, or service fee. Captures line number, item type (vehicle/part/labor/accessory/fee), item code, item description, VIN reference for vehicle lines, part number for parts lines, quantity, unit price, MSRP, negotiated price, discount amount, tax code, tax amount, line total, and revenue category. Supports multi-line invoices for mixed vehicle and parts/service billing.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment record. Primary key for the payment entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: A payment is made against a billing account. While payment already links to invoice (which links to account), a direct account_id FK on payment enables efficient account-level payment queries, reconci',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payments must be recorded against the receiving legal entity for cash management, bank reconciliation, and intercompany settlement in multi-entity automotive operations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payments are charged to a cost center for cash‑flow and expense tracking.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Cash accounting and treasury reporting require payments assigned to fiscal periods for liquidity analysis, DSO calculation, and cash flow statement preparation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cash receipt posting requires a GL account to record the payment in the ledger.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice against which this payment is applied. Links payment to the billing document.',
    `party_id` BIGINT COMMENT 'Identifier of the entity making the payment (dealer, retail customer, fleet operator, or corporate account).',
    `payment_payer_entity_party_id` BIGINT COMMENT 'Identifier of the entity making the payment (dealer, retail customer, fleet operator, or corporate account).',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: When a payment is made as an installment under a structured payment plan, the payment must reference the payment_plan it belongs to. This enables tracking of installment fulfillment, outstanding balan',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑center reporting of cash receipts requires linking payments to the responsible profit center.',
    `rebate_agreement_id` BIGINT COMMENT 'Foreign key linking to billing.rebate_agreement. Business justification: Rebate agreements generate periodic settlement payments to dealers or fleet accounts. Linking payment.rebate_agreement_id to rebate_agreement enables tracking of which payments represent rebate settle',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to billing.receivable. Business justification: A payment directly reduces an open receivable. Linking payment.receivable_id to receivable enables direct AR management — tracking which receivable a payment closes or partially reduces, supporting du',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the payment received before any adjustments or fees.',
    `applied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment amount that has been successfully applied to outstanding invoices or account balances.',
    `authorization_code` STRING COMMENT 'Authorization code provided by the payment processor or bank confirming approval of the payment transaction.',
    `bank_account_number` STRING COMMENT 'Bank account number from which the payment originated. Masked or tokenized for security. Used for reconciliation and fraud prevention.',
    `bank_reference_number` STRING COMMENT 'Unique reference number assigned by the bank or financial institution for the payment transaction. Used for reconciliation and dispute resolution.',
    `batch_reference` STRING COMMENT 'Identifier for the batch or group of payments processed together. Used for bulk payment processing and reconciliation.',
    `channel` STRING COMMENT 'Interface or channel through which the payment was submitted. Distinguishes between online portal, mobile app, bank transfer, mail, and in-person payments. [ENUM-REF-CANDIDATE: online_portal|mobile_app|bank_transfer|mail|in_person|automated_system|dealer_system — 7 candidates stripped; promote to reference product]',
    `clearing_date` DATE COMMENT 'Date when the payment was cleared and funds were confirmed as received in the company bank account.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user or system that created the payment record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system. Used for audit trail and data lineage.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount granted for early payment according to payment terms (e.g., 2% discount for payment within 10 days).',
    `dispute_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is currently under dispute or has been disputed by the payer or payee.',
    `dispute_reason` STRING COMMENT 'Description of the reason for payment dispute. Populated only when dispute_flag is true.',
    `lockbox_number` STRING COMMENT 'Identifier for the bank lockbox service used to receive and process the payment. Applicable for check and mail payments.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment. May include remittance advice, special instructions, or reconciliation notes.',
    `payer_entity_type` STRING COMMENT 'Classification of the entity making the payment. Distinguishes between dealer payments, retail customer payments, fleet operator payments, and corporate account payments.. Valid values are `dealer|retail_customer|fleet_operator|corporate_account|leasing_company|financial_institution`',
    `payment_date` DATE COMMENT 'Date when the payment was initiated or received by the payer. Represents the business event date of the payment transaction.',
    `payment_method` STRING COMMENT 'Instrument or mechanism used to make the payment. Includes wire transfer, ACH (Automated Clearing House), check, credit card, floorplan financing, and dealer draft. [ENUM-REF-CANDIDATE: wire_transfer|ach|check|credit_card|debit_card|floorplan_financing|dealer_draft|electronic_funds_transfer|cash|promissory_note — 10 candidates stripped; promote to reference product]',
    `payment_number` STRING COMMENT 'Business-facing unique reference number for the payment transaction. Used for customer communication and reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment. Tracks whether the payment is pending, cleared, returned, reversed, or cancelled. [ENUM-REF-CANDIDATE: pending|cleared|returned|reversed|cancelled|on_hold|partially_applied — 7 candidates stripped; promote to reference product]',
    `processor` STRING COMMENT 'Name of the third-party payment processor or gateway used to process the payment (e.g., Stripe, PayPal, bank name).',
    `reconciliation_date` DATE COMMENT 'Date when the payment was reconciled with bank statements and confirmed in the accounting system.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the payment has been successfully reconciled with bank statements and accounting records.. Valid values are `unreconciled|reconciled|disputed|under_review`',
    `remittance_advice` STRING COMMENT 'Detailed remittance information provided by the payer indicating which invoices or charges this payment is intended to cover.',
    `return_date` DATE COMMENT 'Date when the payment was returned or reversed by the bank or payment processor. Populated only when payment status is returned or reversed.',
    `return_reason_code` STRING COMMENT 'Code indicating the reason for payment return or reversal (e.g., insufficient funds, account closed, stop payment). Populated only when payment status is returned or reversed.',
    `routing_number` STRING COMMENT 'Bank routing number or SWIFT code for the payer financial institution. Used for wire transfers and ACH (Automated Clearing House) transactions.',
    `sap_clearing_document_number` STRING COMMENT 'Reference to the SAP FI clearing document that records the application of this payment to open invoices. Links payment to financial accounting records.',
    `sap_payment_document_number` STRING COMMENT 'Reference to the SAP FI payment document that records the receipt of this payment. Primary link to ERP (Enterprise Resource Planning) financial records.',
    `terms_code` STRING COMMENT 'Code representing the payment terms under which this payment was made (e.g., net 30, net 60, immediate). Links to master payment terms reference.',
    `transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor or gateway. Used for tracking and reconciliation with external systems.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment amount that remains unapplied and is held as credit on the payer account.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user or system that last modified the payment record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a payment received against an invoice or account balance from a dealer, retail customer, fleet operator, or corporate account. Captures payment date, payment method (wire/ACH/check/credit_card/floorplan/dealer_draft), payment amount, currency, applied invoice references, bank reference number, clearing date, payment status (pending/cleared/returned/reversed), SAP FI clearing document reference, and payer entity type. SSOT for all inbound payment receipts in the billing domain.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`payment_allocation` (
    `payment_allocation_id` BIGINT COMMENT 'Unique identifier for the payment allocation record. Primary key for the payment allocation entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: payment_allocation has a customer_account_number (STRING) denormalized field. Replacing this with a proper account_id FK to the account master normalizes the allocation record and enables direct accou',
    `dealer_incentive_claim_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_incentive_claim. Business justification: Payment allocations distribute payments across specific incentive claims when one payment covers multiple claims. Standard payment application process for batch incentive settlements.',
    `dealer_warranty_claim_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_warranty_claim. Business justification: Payment allocations distribute payments across specific warranty claims. Enables multi-claim payment settlement - standard for batch warranty reimbursement processing.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Cash application and revenue recognition require allocation transactions assigned to fiscal periods for accurate period-end cash reconciliation and revenue cutoff controls.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice receiving the payment allocation. Links to the invoice document being settled or partially settled by this allocation.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item being settled. Enables line-level payment allocation for partial settlements and dispute resolution.',
    `payment_id` BIGINT COMMENT 'Reference to the payment transaction being allocated. Links to the payment record that is being distributed across one or more invoices.',
    `recall_completion_id` BIGINT COMMENT 'Foreign key linking to dealer.recall_completion. Business justification: Payment allocations distribute payments across specific recall completions when batched. Standard recall reimbursement settlement - enables completion-level payment tracking for campaign cost manageme',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to billing.receivable. Business justification: Payment allocation records how a payment is applied against invoice lines. Linking payment_allocation.receivable_id to receivable enables direct tracking of which open receivable item is being cleared',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that is allocated to this specific invoice or invoice line. Represents the portion of the total payment applied to settle this receivable.',
    `allocated_amount_base_currency` DECIMAL(18,2) COMMENT 'The allocated amount converted to the company base currency using the exchange rate. Enables consolidated financial reporting and accounts receivable aging in a single currency.',
    `allocation_date` DATE COMMENT 'The date when the payment was allocated to the invoice. Represents the business event date for accounts receivable clearing and aging calculations.',
    `allocation_method` STRING COMMENT 'Method used to create the allocation. Automatic indicates system-matched allocation, manual indicates user-created allocation, system_proposed indicates system suggestion requiring approval, batch_clearing indicates mass clearing process.. Valid values are `automatic|manual|system_proposed|batch_clearing`',
    `allocation_number` STRING COMMENT 'Business-readable unique identifier for the payment allocation. Used for tracking and reference in accounts receivable operations and customer communications.. Valid values are `^[A-Z0-9]{8,20}$`',
    `allocation_priority` STRING COMMENT 'Priority sequence for applying payment when multiple invoices are eligible. Lower numbers indicate higher priority. Used in automatic allocation rules and aging calculations.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the payment allocation. Pending indicates awaiting confirmation, cleared indicates successfully applied, reversed indicates allocation has been undone, disputed indicates under investigation, reconciled indicates confirmed and balanced, voided indicates cancelled allocation.. Valid values are `pending|cleared|reversed|disputed|reconciled|voided`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment allocation was recorded in the system. Used for audit trail and transaction sequencing.',
    `allocation_type` STRING COMMENT 'Classification of the allocation method. Full indicates complete invoice settlement, partial indicates partial payment, advance indicates prepayment before invoice, overpayment indicates excess payment requiring refund or credit, credit_memo indicates credit note application, adjustment indicates manual correction.. Valid values are `full|partial|advance|overpayment|credit_memo|adjustment`',
    `approval_date` DATE COMMENT 'Date when the allocation was approved. Null for automatic allocations not requiring approval. Used for workflow tracking and compliance audit.',
    `business_area` STRING COMMENT 'SAP business area for segment reporting. Enables revenue and receivables analysis by business unit, product line, or geographic region.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_document_number` STRING COMMENT 'SAP FI clearing document number that records the open item clearing transaction. Links the payment allocation to the financial accounting clearing entry.. Valid values are `^[A-Z0-9]{8,20}$`',
    `clearing_status` STRING COMMENT 'Status of the open item clearing in SAP FI. Open indicates invoice not yet settled, cleared indicates fully settled, partially_cleared indicates partial payment applied, reset indicates clearing was reversed.. Valid values are `open|cleared|partially_cleared|reset`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity receiving the payment. Enables multi-entity financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the payment allocation record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount. Supports multi-currency billing and payment scenarios common in global automotive sales and dealer networks.. Valid values are `^[A-Z]{3}$`',
    `dealer_code` STRING COMMENT 'Unique identifier for the dealer or customer account associated with this payment allocation. Enables dealer-level accounts receivable reporting and performance tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount amount applied during this allocation. Common in automotive dealer invoicing where prompt payment terms offer percentage discounts.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage rate of the cash discount applied. Typically defined in payment terms and calculated based on payment timing relative to invoice date.',
    `dispute_indicator` BOOLEAN COMMENT 'Flag indicating whether this allocation is under dispute. True indicates customer has contested the invoice or payment application.',
    `dispute_reason` STRING COMMENT 'Free-text description of the dispute reason. Captures customer explanation for contesting the allocation or invoice amount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when payment currency differs from invoice currency. Used for cross-currency allocation calculations and financial reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the payment allocation occurred. Used for period-based financial reporting and accounts receivable aging analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the payment allocation record was last modified. Updated whenever any field in the record changes. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the payment allocation. Used for documenting special circumstances, manual adjustments, or customer communications.',
    `posting_date` DATE COMMENT 'The date when the allocation was posted to the general ledger. May differ from allocation date due to period-end processing or backdated corrections.',
    `profit_center` STRING COMMENT 'Profit center responsible for this revenue transaction. Used for internal management accounting and profitability analysis.. Valid values are `^[A-Z0-9]{6,10}$`',
    `reconciliation_status` STRING COMMENT 'Status of the allocation in the accounts receivable reconciliation process. Pending indicates awaiting reconciliation, reconciled indicates confirmed and balanced, exception indicates discrepancy requiring investigation, under_review indicates active reconciliation in progress.. Valid values are `pending|reconciled|exception|under_review`',
    `remaining_invoice_balance` DECIMAL(18,2) COMMENT 'The outstanding balance remaining on the invoice after this allocation is applied. Zero indicates full settlement. Used for open item management and accounts receivable aging.',
    `reversal_date` DATE COMMENT 'Date when the allocation was reversed. Null if allocation has not been reversed. Used for audit trail and accounts receivable reconciliation.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this allocation has been reversed. True indicates the allocation was subsequently undone, typically due to payment failure or correction.',
    `reversal_reason_code` STRING COMMENT 'Standardized code indicating the reason for allocation reversal. Examples include payment failure, incorrect allocation, duplicate payment, or customer dispute.. Valid values are `^[A-Z0-9]{2,6}$`',
    `source_system` STRING COMMENT 'Identifier of the source system that originated this payment allocation record. Examples include SAP_FI, CDK_DMS, SALESFORCE. Enables data lineage tracking in multi-system environments.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `value_date` DATE COMMENT 'The effective date for cash flow and liquidity management. Represents when funds are actually available in the bank account.',
    CONSTRAINT pk_payment_allocation PRIMARY KEY(`payment_allocation_id`)
) COMMENT 'Association record linking a payment to one or more invoice lines, capturing how a single payment is distributed across multiple invoices or partial invoice settlements. Tracks allocated amount per invoice, allocation date, allocation type (full/partial/advance/overpayment), remaining balance after allocation, and clearing status. Enables accurate accounts receivable aging and open item management aligned with SAP FI open item clearing.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Customer accounts must be assigned to a company code for legal entity-level AR aging, credit limit management, and statutory customer master data in automotive dealer networks.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigns a default cost center to the billing account for expense allocation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Default GL account for all transactions posted from a billing account for consistent accounting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Financial reporting requires mapping each billing account to a jurisdiction for tax and regulatory compliance.',
    `parent_account_id` BIGINT COMMENT 'Reference to the parent billing account for hierarchical account structures. Used for corporate accounts with multiple subsidiaries or dealer groups with multiple locations. Null for standalone accounts.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Account Management Report requires linking each billing account to its owning customer party for credit limits, statements, and compliance.',
    `account_name` STRING COMMENT 'Legal or registered name of the billing party. For dealers, this is the dealership legal entity name. For retail customers, the individual or household name. For fleet/corporate, the company legal name.',
    `account_number` STRING COMMENT 'Externally-visible unique account number assigned to the billing party. Used on invoices, statements, and payment correspondence. Typically alphanumeric format following internal numbering scheme.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account. Active accounts can transact normally. Suspended accounts have temporary restrictions. Closed accounts are permanently terminated. Pending approval accounts await credit review. Blocked accounts cannot transact due to payment issues. Dormant accounts have no recent activity.. Valid values are `active|suspended|closed|pending_approval|blocked|dormant`',
    `account_type` STRING COMMENT 'Classification of the billing account based on the nature of the billing party. Dealer accounts are for franchise dealerships, retail for individual consumers, fleet for commercial fleet operators, corporate for B2B accounts, government for public sector entities, and export for international distributors.. Valid values are `dealer|retail|fleet|corporate|government|export`',
    `auto_pay_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the account is enrolled in automatic payment processing. True when account has authorized automatic ACH, direct debit, or credit card charges for recurring invoices.',
    `billing_address_line1` STRING COMMENT 'Primary street address line for billing correspondence and invoice delivery. First line of the billing partys registered address.',
    `billing_address_line2` STRING COMMENT 'Secondary address line for suite, apartment, building, or additional location details for billing correspondence.',
    `billing_city` STRING COMMENT 'City or municipality name for the billing address.',
    `billing_contact_email` STRING COMMENT 'Email address of the primary billing contact person. Used for invoice inquiries, payment confirmations, and account correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the primary billing contact person at the billing party organization. Accounts payable manager, controller, or designated billing representative.',
    `billing_contact_phone` STRING COMMENT 'Primary phone number for the billing contact. Used for payment inquiries, dispute resolution, and collections communication.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the billing address country (e.g., USA, CAN, MEX, DEU, CHN, JPN).. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address. Format varies by country.',
    `billing_state_province` STRING COMMENT 'State, province, or regional administrative division for the billing address. Format varies by country (e.g., two-letter US state codes, Canadian province codes).',
    `closed_date` DATE COMMENT 'Date when the billing account was permanently closed. Null for active, suspended, or dormant accounts. Set when account status transitions to closed after final settlement.',
    `consolidated_billing_flag` BOOLEAN COMMENT 'Indicates whether this account receives consolidated invoices combining multiple transactions or sub-accounts into a single statement. Common for fleet and corporate accounts with multiple locations or cost centers.',
    `credit_check_date` DATE COMMENT 'Date of the most recent credit review or credit check performed for this account. Credit reviews are typically performed at account opening, annually, or when credit limit increase is requested.',
    `credit_exposure_amount` DECIMAL(18,2) COMMENT 'Current total outstanding receivables balance for this account, including open invoices and unbilled charges. Updated in near-real-time as transactions post. Compared against credit limit for credit control decisions.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding receivables balance allowed for this account before credit hold is triggered. Expressed in the accounts base currency. Set by credit management based on creditworthiness assessment.',
    `credit_rating_code` STRING COMMENT 'Internal or external credit rating assigned to the billing party. AAA is highest creditworthiness, D is default, NR is not rated. Used for credit limit determination and risk management. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D|NR — 11 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accounts base transactional currency (e.g., USD, EUR, CAD, MXN, CNY, JPY). All invoices and payments for this account are denominated in this currency unless explicitly converted.. Valid values are `^[A-Z]{3}$`',
    `dispute_count_ytd` STRING COMMENT 'Number of billing disputes or invoice challenges raised by this account in the current fiscal year. Used to identify problematic accounts and improve billing accuracy.',
    `distribution_channel_code` STRING COMMENT 'SAP distribution channel code indicating how products reach this account (e.g., direct sales, dealer network, fleet sales, export). Affects pricing and terms determination.. Valid values are `^[A-Z0-9]{2}$`',
    `division_code` STRING COMMENT 'SAP division code representing the product line or business unit (e.g., passenger vehicles, commercial vehicles, parts, service). Used for revenue segmentation and reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `dms_account_code` STRING COMMENT 'External account identifier from the dealer management system (CDK Global DMS) for dealer accounts. Used to link billing account to dealer inventory, service, and F&I transactions. Null for non-dealer account types.',
    `dunning_block_flag` BOOLEAN COMMENT 'Indicates whether automated dunning (collections) notices are blocked for this account. True when account is in dispute resolution, payment plan, or has special handling requirements.',
    `dunning_level` STRING COMMENT 'Current dunning (collections) level for overdue accounts. Ranges from 0 (no overdue) to higher numbers indicating escalating collection actions. Drives automated dunning letter generation and collection workflow.',
    `invoice_delivery_method` STRING COMMENT 'Preferred method for delivering invoices and statements to the billing party. Email for electronic delivery, postal mail for paper, EDI for automated B2B integration, portal for self-service access, fax for legacy systems.. Valid values are `email|postal_mail|edi|portal|fax`',
    `invoice_email_address` STRING COMMENT 'Primary email address for electronic invoice and statement delivery. Used when invoice delivery method is email or as backup contact for portal notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `last_invoice_date` DATE COMMENT 'Date of the most recent invoice issued to this account. Used to identify dormant accounts and track billing activity patterns.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received from this account in the accounts base currency. Used for payment pattern analysis and collections strategy.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from this account. Used for credit assessment, collections prioritization, and customer relationship management.',
    `opened_date` DATE COMMENT 'Date when the billing account was first established and activated. Marks the beginning of the financial relationship.',
    `payment_method_preference` STRING COMMENT 'Preferred payment method for this account. Wire transfer and ACH for electronic payments, check for paper payments, credit card for retail, direct debit for recurring charges, letter of credit for export accounts.. Valid values are `wire_transfer|ach|check|credit_card|direct_debit|letter_of_credit`',
    `payment_performance_score` DECIMAL(18,2) COMMENT 'Calculated score (0-100) representing the accounts payment timeliness and reliability. Based on historical payment patterns, days sales outstanding, and dispute frequency. Higher scores indicate better payment performance.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the due date calculation and discount conditions (e.g., NET30, NET60, 2/10NET30). Maps to SAP FI payment terms master data.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date until payment is due. Derived from payment terms code but stored for reporting convenience.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was first created in the data platform. System-generated audit field.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was last modified in the data platform. System-generated audit field updated on every change.',
    `sales_organization_code` STRING COMMENT 'SAP sales organization code responsible for this billing account. Defines the organizational unit for sales and distribution processes, pricing, and revenue recognition.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_customer_number` STRING COMMENT 'SAP FI customer account number (KUNNR) in the ERP system. Ten-digit numeric identifier used for financial postings, invoice generation, and payment application. Primary system of record reference.. Valid values are `^[0-9]{10}$`',
    `tax_registration_number` STRING COMMENT 'Government-issued tax identification number for the billing party. Format varies by jurisdiction (e.g., EIN in USA, GST number in Canada, RFC in Mexico, VAT number in EU). Used for tax reporting and compliance.',
    `vat_number` STRING COMMENT 'VAT registration identifier for EU and other VAT jurisdictions. Required for cross-border invoicing and VAT reclaim. Format follows country-specific VAT ID structure.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Billing account master record representing the financial relationship between Automotive and a billing party (dealer, retail customer, fleet operator, or corporate account). Captures account number, account type (dealer/retail/fleet/corporate/government), account name, billing address, payment terms, credit limit, credit exposure, currency, tax registration number, VAT ID, account status (active/suspended/closed), assigned credit controller, SAP FI customer account reference, and DMS account linkage for dealer accounts. Distinct from the customer identity record owned by the customer domain.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`receivable` (
    `receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable item. Primary key for the receivable product. Represents a single open item in the AR ledger.',
    `account_id` BIGINT COMMENT 'Reference to the billing account (dealer, retail customer, or fleet account) that owes this receivable. Represents the debtor party.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Receivables are legal obligations tracked by company code for statutory balance sheet reporting, AR aging by legal entity, and intercompany receivable reconciliation.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Receivables aging and DSO metrics require fiscal period assignment for period-over-period AR analysis, bad debt provisioning, and collection performance tracking.',
    `invoice_id` BIGINT COMMENT 'Reference to the source invoice that generated this receivable. Links to the originating billing document in SAP SD/FI.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the active payment plan agreement if payment_plan_flag is true. Links to payment plan schedule and terms.',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Receivables track amounts due from vehicle orders. Essential for aging analysis, collections, and credit hold decisions. Links AR records to originating sales transactions for dispute resolution and p',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Automotive receivables for vehicle sales are tracked against specific VINs for collections, dispute resolution, and lien management. The existing plain vin text column is denormalized; a proper FK t',
    `aging_bucket` STRING COMMENT 'Standard aging classification bucket based on days past due. Used for AR aging reports, bad debt provisioning, and collections prioritization.. Valid values are `current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days`',
    `closed_date` DATE COMMENT 'Date the receivable was fully closed (paid, written off, or otherwise resolved). Null for open receivables. Used for DSO calculation and historical analysis.',
    `collection_status` STRING COMMENT 'Current status of collection efforts for overdue receivables. Tracks progression through collections workflow from initial contact to legal action. [ENUM-REF-CANDIDATE: not_started|in_progress|on_hold|escalated|legal|resolved|abandoned — 7 candidates stripped; promote to reference product]',
    `cost_center` STRING COMMENT 'Cost center responsible for the revenue transaction that generated this receivable. Used for profitability analysis and management reporting.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable record was first created in the system. Audit trail for data lineage and compliance.',
    `credit_hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the debtor account is on credit hold due to this or other overdue receivables. Credit hold blocks new orders and shipments.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the receivable amounts. Supports multi-currency operations across global dealer networks and export markets.. Valid values are `^[A-Z]{3}$`',
    `customer_type` STRING COMMENT 'Segment classification of the debtor. Distinguishes dealer network, retail consumers, fleet operators, government entities, rental companies, and leasing firms.. Valid values are `dealer|retail|fleet|government|rental|leasing`',
    `days_past_due` STRING COMMENT 'Number of calendar days the receivable is overdue. Calculated as current date minus due date for unpaid balances. Zero or negative for current receivables.',
    `dealer_code` STRING COMMENT 'Dealer code if the receivable is from a dealer network transaction. Links to dealer master data for dealer-specific AR aging and floor plan management.. Valid values are `^[A-Z0-9]{5,10}$`',
    `dispute_date` DATE COMMENT 'Date the dispute was raised by the debtor. Used to track dispute aging and resolution SLA compliance.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the receivable is currently under dispute by the debtor. Disputed receivables are excluded from dunning and may be placed on payment hold.',
    `dispute_reason` STRING COMMENT 'Reason code for the dispute if dispute_flag is true. Categorizes the nature of the customer objection for resolution tracking. [ENUM-REF-CANDIDATE: pricing_error|quantity_discrepancy|quality_issue|delivery_problem|warranty_claim|incentive_disagreement|billing_error|not_disputed — 8 candidates stripped; promote to reference product]',
    `dispute_reference` STRING COMMENT 'External reference number for the dispute case. Links to dispute resolution system or customer service ticket.',
    `due_date` DATE COMMENT 'Contractual date by which payment is expected. Calculated from invoice date plus payment terms. Used to determine days past due and aging bucket.',
    `dunning_level` STRING COMMENT 'Current dunning escalation level for overdue receivables. Increments with each dunning run. Zero indicates no dunning action taken.',
    `gl_account_code` STRING COMMENT 'General ledger account code where this receivable is posted. Typically an AR control account in the balance sheet.. Valid values are `^[0-9]{6,10}$`',
    `invoice_date` DATE COMMENT 'Date the originating invoice was issued. Represents the business event timestamp when the receivable was created.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact attempt with the debtor regarding this receivable. Includes phone calls, emails, and letters.',
    `last_dunning_date` DATE COMMENT 'Date the most recent dunning notice was sent to the debtor. Used to calculate next dunning run eligibility and escalation timing.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this receivable record. Tracks changes to balance, status, or dispute information.',
    `next_dunning_date` DATE COMMENT 'Calculated date for the next dunning notice. Based on dunning frequency configuration and last dunning date.',
    `original_amount` DECIMAL(18,2) COMMENT 'Original gross amount of the receivable at invoice creation. Represents the initial debt obligation before any payments or adjustments.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid balance remaining on the receivable. Calculated as original amount minus payments, credits, and adjustments. SSOT for AR aging reports.',
    `payment_plan_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the debtor is on an approved payment plan for this receivable. Payment plan receivables follow modified dunning rules.',
    `payment_terms` STRING COMMENT 'Contractual payment terms governing the receivable. Defines the number of days until payment is due and any early payment discounts. [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30|custom — 7 candidates stripped; promote to reference product]',
    `profit_center` STRING COMMENT 'Profit center for internal P&L reporting. Represents the business unit or product line that earned this revenue.. Valid values are `^[A-Z0-9]{6,10}$`',
    `receivable_number` STRING COMMENT 'Business-facing document number for the receivable item. Externally visible identifier used in collections correspondence and dunning letters.. Valid values are `^[A-Z]{2,3}-[0-9]{8,12}$`',
    `receivable_status` STRING COMMENT 'Current lifecycle state of the receivable. Tracks progression from open through payment, dispute, collections, or write-off. [ENUM-REF-CANDIDATE: open|partially_paid|paid|disputed|written_off|under_collection|legal_action — 7 candidates stripped; promote to reference product]',
    `receivable_type` STRING COMMENT 'Classification of the receivable by business transaction type. Distinguishes vehicle sales, parts, service, warranty, fleet, incentive recovery, and finance charges. [ENUM-REF-CANDIDATE: vehicle_sale|parts_sale|service_charge|warranty_reimbursement|fleet_invoice|incentive_recovery|finance_charge — 7 candidates stripped; promote to reference product]',
    `sales_region` STRING COMMENT 'Geographic sales region where the transaction occurred. Used for regional revenue and collections performance analysis.',
    `sap_fi_company_code` STRING COMMENT 'SAP company code representing the legal entity that owns this receivable. Used for multi-entity consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_fi_document_number` STRING COMMENT 'SAP FI accounting document number for the open item. SSOT reference for reconciliation with SAP general ledger and subledger.. Valid values are `^[0-9]{10}$`',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as bad debt. May differ from outstanding balance if partial recovery was achieved before write-off.',
    `write_off_date` DATE COMMENT 'Date the receivable was written off. Represents the accounting period when the bad debt expense was recognized.',
    `write_off_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the receivable has been written off as uncollectible bad debt. Written-off receivables are removed from active AR aging.',
    `write_off_reason` STRING COMMENT 'Reason code for the write-off decision. Documents the business justification for recognizing bad debt expense. [ENUM-REF-CANDIDATE: bankruptcy|insolvency|uncollectible|customer_closure|legal_settlement|small_balance|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_receivable PRIMARY KEY(`receivable_id`)
) COMMENT 'Open accounts receivable item representing an outstanding amount owed by a billing account against a specific invoice. Tracks original invoice amount, outstanding balance, due date, days past due, aging bucket (current/30/60/90/120+), dunning level, last dunning date, dispute flag, dispute reference, write-off flag, and SAP FI open item reference. SSOT for AR aging and collections management across dealer, retail, and fleet receivables.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`dealer_statement` (
    `dealer_statement_id` BIGINT COMMENT 'Unique identifier for the dealer statement record. Primary key.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Dealer statements represent financial obligations tracked by legal entity for consolidation, dealer financing programs, and floorplan liability reporting in automotive distribution networks.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Dealer statements are issued per dealer account; linking to the master account removes the redundant dealer_account_number column.',
    `dealership_id` BIGINT COMMENT 'Reference to the dealership receiving this statement.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Dealer statement reconciliation and period-close processes require fiscal period assignment for monthly dealer account settlement and financial reporting cutoff.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Dealer statements must track jurisdiction for tax reporting, VAT/GST compliance, and multi-market regulatory requirements. Automotive OEMs operate across jurisdictions with different tax rates, report',
    `aging_bucket_30_days_amount` DECIMAL(18,2) COMMENT 'Portion of the closing balance that is 1-30 days past due.',
    `aging_bucket_60_days_amount` DECIMAL(18,2) COMMENT 'Portion of the closing balance that is 31-60 days past due.',
    `aging_bucket_90_days_amount` DECIMAL(18,2) COMMENT 'Portion of the closing balance that is 61-90 days past due.',
    `aging_bucket_current_amount` DECIMAL(18,2) COMMENT 'Portion of the closing balance that is current and not yet past due.',
    `aging_bucket_over_90_days_amount` DECIMAL(18,2) COMMENT 'Portion of the closing balance that is more than 90 days past due.',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle or schedule under which this statement was generated.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cdk_statement_reference` STRING COMMENT 'External reference identifier from CDK Global DMS linking this statement to the dealer management system record.',
    `closing_balance_amount` DECIMAL(18,2) COMMENT 'The outstanding balance at the end of the statement period, calculated as opening balance plus charges minus credits and payments.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this dealer statement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this statement.. Valid values are `^[A-Z]{3}$`',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The monetary amount under dispute by the dealer, if any.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the dealer has raised a dispute or discrepancy regarding this statement.',
    `dispute_reason_code` STRING COMMENT 'Code representing the reason for the dispute, such as pricing error, quantity discrepancy, or missing credit.. Valid values are `^[A-Z0-9]{2,10}$`',
    `distribution_channel_code` STRING COMMENT 'SAP distribution channel code indicating the route to market for this statement.. Valid values are `^[A-Z0-9]{2}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year for this statement.. Valid values are `^[0-9]{2}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this statement period falls, used for financial reporting and period alignment.. Valid values are `^[0-9]{4}$`',
    `floorplan_financing_flag` BOOLEAN COMMENT 'Indicates whether this statement includes floorplan financing charges or is relevant for floorplan reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this dealer statement record was last updated.',
    `opening_balance_amount` DECIMAL(18,2) COMMENT 'The outstanding balance carried forward from the previous statement period.',
    `payment_due_date` DATE COMMENT 'The date by which the dealer is expected to remit payment for the closing balance.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms applicable to this statement, such as net 30, net 60, or custom terms.. Valid values are `^[A-Z0-9]{2,10}$`',
    `reconciliation_date` DATE COMMENT 'The date on which the dealer acknowledged and reconciled this statement with their own records.',
    `sales_organization_code` STRING COMMENT 'SAP sales organization code responsible for this dealer statement.. Valid values are `^[A-Z0-9]{4}$`',
    `statement_date` DATE COMMENT 'The date on which the statement was generated and issued to the dealer.',
    `statement_notes` STRING COMMENT 'Free-text field for additional notes, comments, or instructions related to this statement.',
    `statement_number` STRING COMMENT 'Unique business identifier for the dealer statement, externally visible and used for dealer reconciliation and reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `statement_period_end_date` DATE COMMENT 'The last date of the billing period covered by this statement.',
    `statement_period_start_date` DATE COMMENT 'The first date of the billing period covered by this statement.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the dealer statement indicating its processing stage.. Valid values are `draft|issued|acknowledged|disputed|reconciled|closed`',
    `statement_type` STRING COMMENT 'Classification of the statement based on its frequency or purpose.. Valid values are `monthly|quarterly|ad_hoc|final|interim`',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all manual adjustments applied to the dealer account during the statement period, including corrections and write-offs.',
    `total_credit_memo_amount` DECIMAL(18,2) COMMENT 'Sum of all credit memos issued to the dealer during the statement period, reducing the amount owed.',
    `total_debit_memo_amount` DECIMAL(18,2) COMMENT 'Sum of all debit memos issued to the dealer during the statement period, increasing the amount owed.',
    `total_incentive_amount` DECIMAL(18,2) COMMENT 'Sum of all dealer incentives, rebates, and promotional credits applied during the statement period.',
    `total_invoice_amount` DECIMAL(18,2) COMMENT 'Sum of all invoices issued to the dealer during the statement period.',
    `total_parts_sales_amount` DECIMAL(18,2) COMMENT 'Sum of all parts sales invoices included in this statement period.',
    `total_payment_received_amount` DECIMAL(18,2) COMMENT 'Sum of all payments received from the dealer during the statement period.',
    `total_service_charges_amount` DECIMAL(18,2) COMMENT 'Sum of all service and labor charges included in this statement period.',
    `total_vehicle_sales_amount` DECIMAL(18,2) COMMENT 'Sum of all vehicle sales invoices included in this statement period.',
    `total_warranty_reimbursement_amount` DECIMAL(18,2) COMMENT 'Sum of all warranty claim reimbursements credited to the dealer during the statement period.',
    CONSTRAINT pk_dealer_statement PRIMARY KEY(`dealer_statement_id`)
) COMMENT 'Periodic account statement issued to a dealer summarizing all invoices, credit memos, debit memos, payments, and open balances within a statement period. Captures statement number, dealer account reference, statement period start/end dates, opening balance, total charges, total credits, total payments received, closing balance, statement status (draft/issued/acknowledged), and CDK Global DMS statement reference. Supports dealer reconciliation and floorplan financing reporting.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`price_condition` (
    `price_condition_id` BIGINT COMMENT 'Unique identifier for the price condition record. Primary key.',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: SAP SD price condition records in automotive are keyed to vehicle models — MSRP uplifts, fleet discounts, and market-specific pricing are all model-scoped. The existing vehicle_model_code is a denorma',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Price conditions must specify which parts/materials SKUs they apply to. Critical for parts pricing management, dealer pricing agreements, and service parts catalog pricing in automotive distribution.',
    `transport_rate_id` BIGINT COMMENT 'Foreign key linking to logistics.transport_rate. Business justification: Billing price conditions for logistics services derive from contracted transport rates. Pricing procedures must reference transport rate master data to calculate invoice line amounts, apply fuel surch',
    `trim_level_id` BIGINT COMMENT 'Foreign key linking to vehicle.vehicle_trim_level. Business justification: Automotive price conditions are frequently scoped to trim levels — premium trim commands different pricing conditions than base trim. The existing vehicle_trim_level plain text is denormalized; a prop',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Automotive price conditions (MSRP, dealer net, fleet pricing) are defined per vehicle program and model year. Linking billing_price_condition to vehicle_program enables program-level pricing governanc',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether application of this pricing condition requires managerial or pricing authority approval before being applied to a billing transaction. True requires approval workflow.',
    `approved_by` STRING COMMENT 'User ID or name of the pricing authority or manager who approved this condition for use in billing transactions. Null if approval is not required or pending.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing condition was approved for use. Null if approval is not required or still pending. Part of the governance audit trail.',
    `calculation_type` STRING COMMENT 'Method used to calculate the condition value in the billing transaction. Defines whether the condition is applied as a fixed amount, percentage of base, quantity-dependent, or using a tiered/formula approach.. Valid values are `fixed|percentage|quantity_based|tiered|formula`',
    `condition_class` STRING COMMENT 'High-level classification of the condition type grouping similar pricing elements together for reporting and analysis purposes.. Valid values are `price|discount|surcharge|tax|freight`',
    `condition_description` STRING COMMENT 'Detailed textual description of the pricing condition, including its business purpose, applicability rules, and any special terms or restrictions. Provides context for pricing analysts and auditors.',
    `condition_exclusion_flag` BOOLEAN COMMENT 'Indicates whether this condition is marked for exclusion from certain pricing scenarios or customer groups. True means the condition should be excluded under specific business rules.',
    `condition_record_number` STRING COMMENT 'Business identifier for the pricing condition record, typically sourced from SAP SD condition record (KONP table). Used for external reference and traceability.',
    `condition_status` STRING COMMENT 'Current lifecycle status of the pricing condition record. Active conditions are available for use in billing; inactive, expired, or suspended conditions are not applied.. Valid values are `active|inactive|pending|expired|suspended`',
    `condition_step_number` STRING COMMENT 'Sequence number within the pricing procedure that defines the order in which this condition is evaluated and applied during billing calculation.',
    `condition_type` STRING COMMENT 'Type of pricing condition applied to the billing transaction. Defines whether this is a base price (MSRP), negotiated price, discount, surcharge, tax, or other pricing element. Aligns with SAP SD condition types. [ENUM-REF-CANDIDATE: msrp|negotiated|fleet_discount|dealer_margin|volume_rebate|freight|pdi_charge|tax|surcharge|promotional_discount — 10 candidates stripped; promote to reference product]',
    `condition_unit` STRING COMMENT 'Unit of measure for the condition value. Indicates whether the value is an absolute amount, a percentage, or a per-unit rate.. Valid values are `amount|percentage|per_unit|per_vehicle`',
    `condition_value` DECIMAL(18,2) COMMENT 'Monetary or percentage value of the pricing condition. For absolute amounts, represents the price or adjustment in the condition currency. For percentage-based conditions, represents the rate (e.g., 5.5 for 5.5%).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing condition record was first created in the system. Part of the audit trail for master data lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the condition value when expressed as an absolute amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `customer_type` STRING COMMENT 'Type of customer for which this pricing condition is applicable. Enables customer segment-specific pricing strategies (retail, fleet, dealer, government, commercial).. Valid values are `retail|fleet|dealer|government|commercial`',
    `dealer_code` STRING COMMENT 'Unique identifier of the dealer or dealership for which this pricing condition is applicable. Enables dealer-specific pricing agreements and margin structures. Null indicates condition applies to all dealers.',
    `distribution_channel_code` STRING COMMENT 'SAP SD distribution channel code indicating the sales channel (e.g., retail, fleet, online) for which this condition applies. Enables channel-specific pricing strategies.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when this pricing condition record version is superseded or becomes inactive in the lakehouse. Null indicates the current active version. Used for SCD Type 2 tracking.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when this pricing condition record becomes effective in the lakehouse. Used for temporal queries and slowly changing dimension (SCD) Type 2 tracking.',
    `is_current_flag` BOOLEAN COMMENT 'Indicates whether this record represents the current active version of the pricing condition. True for the latest version, False for historical versions. Supports SCD Type 2 queries.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this pricing condition record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pricing condition record was last modified. Enables change detection and version control for pricing master data.',
    `manual_override_allowed_flag` BOOLEAN COMMENT 'Indicates whether sales or billing personnel are permitted to manually override this condition value during transaction processing. True allows manual adjustment, False enforces system-determined value.',
    `model_year` STRING COMMENT 'Model year of the vehicle for which this pricing condition is applicable. Enables year-over-year pricing adjustments and end-of-model-year promotions.',
    `pricing_procedure_code` STRING COMMENT 'Reference to the SAP SD pricing procedure that governs the sequence and logic of condition application. Links this condition to the broader pricing determination framework.',
    `sales_organization_code` STRING COMMENT 'SAP SD sales organization code that owns this pricing condition. Defines the organizational unit responsible for pricing governance and approval.',
    `sales_region_code` STRING COMMENT 'Geographic sales region or market code for which this pricing condition is valid. Enables region-specific pricing strategies to account for market conditions, competition, and regulatory requirements.',
    `sap_condition_table` STRING COMMENT 'Name of the SAP SD condition table (e.g., A001, A002) from which this condition record is sourced. Provides traceability to the source system configuration.',
    `sap_konp_record_number` STRING COMMENT 'Reference to the SAP SD KONP table record number that stores the condition record master data. Enables direct linkage to the source system for audit and reconciliation.',
    `sap_konv_counter` STRING COMMENT 'Reference to the SAP SD KONV table counter that tracks condition application instances in sales and billing documents. Used for transaction-level traceability.',
    `scale_basis` STRING COMMENT 'Basis for scale-based pricing conditions. Defines the dimension (quantity, value, weight, volume) used to determine tiered pricing or volume-based discounts.. Valid values are `quantity|value|weight|volume`',
    `scale_quantity_from` DECIMAL(18,2) COMMENT 'Lower bound of the scale range for tiered pricing conditions. Defines the minimum quantity or value at which this condition rate applies.',
    `scale_quantity_to` DECIMAL(18,2) COMMENT 'Upper bound of the scale range for tiered pricing conditions. Defines the maximum quantity or value at which this condition rate applies. Null indicates no upper limit.',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which this pricing condition record was extracted (e.g., SAP_SD, SFDC, DMS). Supports multi-system integration and data lineage tracking.',
    `valid_from_date` DATE COMMENT 'Start date from which this pricing condition becomes effective and can be applied to billing transactions. Part of the condition validity period.',
    `valid_to_date` DATE COMMENT 'End date until which this pricing condition remains effective. Null indicates the condition is valid indefinitely. Part of the condition validity period.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this pricing condition record in the system. Supports audit trail and accountability.',
    CONSTRAINT pk_price_condition PRIMARY KEY(`price_condition_id`)
) COMMENT 'Pricing condition record defining the applicable price, discount, surcharge, or tax condition for a billing transaction based on customer type, vehicle model, region, and validity period. Captures condition type (MSRP/negotiated/fleet_discount/dealer_margin/volume_rebate/freight/PDI_charge/tax), condition value, condition unit, scale basis, validity start/end dates, pricing procedure reference, and SAP SD condition record reference (KONP/KONV). Supports both MSRP-based and negotiated pricing models as required by the billing domain.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'Unique identifier for the payment term record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Accounts often have a default payment term; linking provides a normalized reference.',
    `applicable_account_types` STRING COMMENT 'Comma-separated list of billing account types to which this payment term applies (e.g., dealer, fleet, retail, corporate, OEM (Original Equipment Manufacturer)).',
    `approval_date` DATE COMMENT 'Date on which this payment term was approved by finance or credit management. Null if not yet approved.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether finance or credit manager approval is required before this payment term can be assigned to a customer account.',
    `approved_by` STRING COMMENT 'Name or user ID of the finance or credit manager who approved this payment term for use. Null if no approval required or pending.',
    `auto_dunning_enabled` BOOLEAN COMMENT 'Indicates whether automatic dunning (collection reminder) process is enabled for invoices using this payment term.',
    `baseline_date_rule` STRING COMMENT 'Rule defining the baseline date from which net due days and discount days are calculated (invoice date, delivery date, end of month, or custom).. Valid values are `invoice_date|delivery_date|month_end|custom`',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division that owns and manages this payment term (e.g., DEALER, FLEET, PARTS).. Valid values are `^[A-Z0-9]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was first created in the system.',
    `credit_check_required` BOOLEAN COMMENT 'Indicates whether a credit check is required before this payment term can be assigned to a billing account.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for which this payment term is defined (e.g., USD, EUR, JPY). Null if applicable to all currencies.. Valid values are `^[A-Z]{3}$`',
    `discount_days_1` STRING COMMENT 'Number of days from invoice date within which discount percentage 1 applies.',
    `discount_days_2` STRING COMMENT 'Number of days from invoice date within which discount percentage 2 applies (typically longer than discount days 1).',
    `discount_percentage_1` DECIMAL(18,2) COMMENT 'First early payment discount percentage offered if payment is made within discount days 1 (e.g., 2.00 for 2%).',
    `discount_percentage_2` DECIMAL(18,2) COMMENT 'Second early payment discount percentage offered if payment is made within discount days 2 (typically lower than discount 1).',
    `dunning_level` STRING COMMENT 'Default dunning level (escalation stage) for collection reminders associated with this payment term. Null if auto dunning is disabled.',
    `effective_end_date` DATE COMMENT 'Date after which this payment term is no longer valid for new assignments. Null if no end date is defined.',
    `effective_start_date` DATE COMMENT 'Date from which this payment term becomes valid and available for assignment to billing accounts.',
    `fixed_day_of_month` STRING COMMENT 'If baseline date rule is custom, specifies a fixed day of the month for payment due date (e.g., 15 for the 15th of each month). Null if not applicable.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this payment term record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was last updated.',
    `maximum_order_value` DECIMAL(18,2) COMMENT 'Maximum invoice or order value for which this payment term is applicable. Null if no maximum.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum invoice or order value required for this payment term to be applicable. Null if no minimum.',
    `net_due_days` STRING COMMENT 'Number of days from invoice date by which full payment is due without penalty.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or internal comments about this payment term.',
    `payment_method_restriction` STRING COMMENT 'Comma-separated list of allowed payment methods for this term (e.g., wire_transfer, check, ACH, credit_card). Empty if no restriction.',
    `payment_term_code` STRING COMMENT 'Short alphanumeric code representing the payment term (e.g., NET30, 2/10N30, COD). Maps to SAP FI payment term key in table T052.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payment_term_description` STRING COMMENT 'Detailed explanation of the payment term conditions, including discount and penalty clauses.',
    `payment_term_name` STRING COMMENT 'Full descriptive name of the payment term (e.g., Net 30 Days, 2% 10 Net 30, Cash on Delivery).',
    `payment_term_status` STRING COMMENT 'Current lifecycle status of the payment term: active (in use), inactive (not available for new assignments), deprecated (legacy term), or pending approval (awaiting finance approval).. Valid values are `active|inactive|deprecated|pending_approval`',
    `penalty_calculation_method` STRING COMMENT 'Method used to calculate late payment penalties: daily accrual, monthly accrual, flat fee, or none.. Valid values are `daily|monthly|flat_fee|none`',
    `penalty_grace_days` STRING COMMENT 'Number of days after net due date before penalty charges begin to accrue.',
    `penalty_rate` DECIMAL(18,2) COMMENT 'Late payment penalty rate applied after grace period expires, expressed as percentage per period (e.g., 1.5% per month).',
    `region_code` STRING COMMENT 'Three-letter geographic region code where this payment term is applicable (e.g., USA, EUR, JPN). Null if globally applicable.. Valid values are `^[A-Z]{3}$`',
    `sap_fi_payment_term_key` STRING COMMENT 'Reference to the SAP FI payment term key in table T052 for ERP (Enterprise Resource Planning) integration and synchronization.. Valid values are `^[A-Z0-9]{4}$`',
    `usage_count` STRING COMMENT 'Number of active billing accounts or invoices currently using this payment term. Used for impact analysis before deprecation.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this payment term record.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Reference master for standard payment terms offered to billing accounts, defining due date calculation rules, early payment discount percentages, and penalty terms. Captures payment term code, description, net due days, discount percentage 1 and 2, discount days 1 and 2, penalty rate, penalty grace days, applicable account types (dealer/fleet/retail/corporate), and SAP FI payment term reference (T052). Used to standardize billing terms across all invoice types.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`tax_code` (
    `tax_code_id` BIGINT COMMENT 'Unique identifier for the tax code record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Accounts may have a default tax code; linking normalizes tax code usage.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Tax codes are jurisdiction-specific by definition in automotive manufacturing. OEMs must map tax treatment (VAT, GST, sales tax) to regulatory territories for invoice compliance, cross-border vehicle ',
    `applicable_transaction_types` STRING COMMENT 'Comma-separated list of transaction types to which this tax code applies. Examples: vehicle_sale, parts_sale, service_labor, warranty_repair, fleet_lease, export_sale, dealer_invoice, retail_invoice. Supports multi-transaction applicability.',
    `calculation_method` STRING COMMENT 'The method used to calculate the tax amount. Percentage for rate-based calculation, fixed_amount for flat fees, tiered for progressive rates based on value bands, formula_based for complex calculations (e.g., emissions-based environmental levies).. Valid values are `percentage|fixed_amount|tiered|formula_based`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tax code record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which tax amounts are calculated and reported (e.g., USD, EUR, GBP, INR, CNY). Supports multi-currency billing operations.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this tax code and rate become active and applicable to transactions. Supports time-based tax rate changes and regulatory compliance.',
    `exemption_certificate_required` BOOLEAN COMMENT 'Indicates whether a tax exemption certificate must be on file to apply this code for exempt transactions. True if certificate is mandatory, False otherwise. Supports compliance with exemption documentation requirements.',
    `expiry_date` DATE COMMENT 'The date on which this tax code and rate cease to be valid. Nullable for indefinite validity. Supports sunset provisions and temporary tax measures.',
    `gl_account_code` STRING COMMENT 'The GL account number to which tax amounts calculated using this code are posted in the financial ledger. Supports automated accounting entries and financial reporting.. Valid values are `^[0-9]{4,10}$`',
    `is_deductible` BOOLEAN COMMENT 'Indicates whether the tax is deductible as a business expense for income tax purposes. Relevant for excise duties and certain non-recoverable taxes.',
    `is_recoverable` BOOLEAN COMMENT 'Indicates whether the tax paid under this code can be recovered or reclaimed from the tax authority (e.g., input VAT). True for recoverable taxes, False for non-recoverable taxes.',
    `jurisdiction_level` STRING COMMENT 'The governmental or regional level at which this tax is levied. Federal for national taxes, state for US state or equivalent provincial taxes, local for city/county taxes, EU for European Union-wide directives, APAC for Asia-Pacific regional harmonized taxes, multi_jurisdiction for taxes spanning multiple levels.. Valid values are `federal|state|local|eu|apac|multi_jurisdiction`',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this tax code record. Supports change management and audit compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tax code record was most recently updated. Supports change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or clarifications regarding the application of this tax code. May include references to specific regulations, exemptions, or business rules.',
    `reporting_code` STRING COMMENT 'The code or box number used when reporting this tax on statutory returns (e.g., VAT return box 1, GST return line 3A). Supports automated regulatory reporting and compliance.',
    `reverse_charge_applicable` BOOLEAN COMMENT 'Indicates whether the reverse charge mechanism applies, where the customer rather than the supplier accounts for VAT. Common in B2B cross-border EU transactions and certain domestic supplies.',
    `rounding_precision` STRING COMMENT 'The number of decimal places to which tax amounts are rounded (e.g., 2 for cents/pence, 0 for whole currency units). Supports multi-currency precision requirements.',
    `rounding_rule` STRING COMMENT 'The rounding method applied to calculated tax amounts. Round_up for ceiling, round_down for floor, round_nearest for standard rounding, no_rounding for exact amounts. Ensures compliance with jurisdiction-specific rounding regulations.. Valid values are `round_up|round_down|round_nearest|no_rounding`',
    `sap_fi_tax_code` STRING COMMENT 'The corresponding tax code identifier in SAP FI module (table T007A, field MWSKZ). Typically 1-2 character alphanumeric. Enables integration and reconciliation between lakehouse and SAP ERP.. Valid values are `^[A-Z0-9]{1,2}$`',
    `sap_sd_tax_code` STRING COMMENT 'The corresponding tax code identifier in SAP SD module used in sales orders and billing documents. May differ from FI code in some implementations. Supports sales-specific tax determination.. Valid values are `^[A-Z0-9]{1,2}$`',
    `tax_authority_name` STRING COMMENT 'The name of the governmental or regulatory body responsible for administering this tax. Examples: Internal Revenue Service (IRS), HM Revenue & Customs (HMRC), Goods and Services Tax Network (GSTN), California Department of Tax and Fee Administration.',
    `tax_authority_reference` STRING COMMENT 'The official reference number, code, or identifier assigned by the tax authority for this tax type or rate. Used for regulatory reporting and audit trail.',
    `tax_basis` STRING COMMENT 'The base amount on which the tax rate is applied. Net_amount for taxes on pre-tax subtotal, gross_amount for taxes on total including other taxes (cascading), MSRP (Manufacturer Suggested Retail Price) for luxury taxes, invoice_value for dealer invoices, customs_value for import duties.. Valid values are `net_amount|gross_amount|msrp|invoice_value|customs_value`',
    `tax_category` STRING COMMENT 'The accounting treatment category for this tax. Input_tax for recoverable VAT on purchases, output_tax for VAT charged on sales, withholding_tax for taxes deducted at source, reverse_charge for customer-remitted VAT, exempt for tax-exempt transactions, zero_rated for 0% taxable supplies.. Valid values are `input_tax|output_tax|withholding_tax|reverse_charge|exempt|zero_rated`',
    `tax_code_code` STRING COMMENT 'The alphanumeric tax code identifier used in billing and invoicing systems. Maps to SAP FI/SD tax code field (MWSKZ). Examples: VAT_STD, GST_18, SALES_TX_CA, EXCISE_LUX.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `tax_code_name` STRING COMMENT 'Human-readable name or description of the tax code for display and reporting purposes.',
    `tax_code_status` STRING COMMENT 'Current lifecycle status of the tax code. Active for codes in use, inactive for retired codes, pending for codes awaiting regulatory approval, superseded for codes replaced by newer versions.. Valid values are `active|inactive|pending|superseded`',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The tax rate as a percentage (e.g., 19.0000 for 19% VAT, 5.5000 for 5.5% GST). Precision to four decimal places supports fine-grained rates. Used to calculate tax amount from taxable base.',
    `tax_type` STRING COMMENT 'The category of tax represented by this code. VAT (Value Added Tax) for EU and similar jurisdictions, GST (Goods and Services Tax) for India/Australia/Canada, sales_tax for US state-level, excise for fuel/alcohol/tobacco duties, luxury_tax for high-value vehicles, environmental_levy for emissions-based charges.. Valid values are `vat|gst|sales_tax|excise|luxury_tax|environmental_levy`',
    `withholding_tax_applicable` BOOLEAN COMMENT 'Indicates whether withholding tax provisions apply to transactions using this code. Relevant for cross-border payments and certain domestic transactions where tax is deducted at source.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this tax code record. Supports accountability and audit trail.',
    CONSTRAINT pk_tax_code PRIMARY KEY(`tax_code_id`)
) COMMENT 'Reference master for tax codes applicable to automotive billing transactions across jurisdictions, capturing tax code identifier, tax type (VAT/GST/sales_tax/excise/luxury_tax/environmental_levy), jurisdiction (federal/state/local/EU/APAC), applicable transaction types, tax rate percentage, effective date, expiry date, tax authority reference, and SAP FI/SD tax code mapping. Supports multi-jurisdiction billing for domestic and export vehicle sales, parts, and services.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`rebate_agreement` (
    `rebate_agreement_id` BIGINT COMMENT 'Unique identifier for the rebate agreement record. Primary key.',
    `account_id` BIGINT COMMENT 'Identifier of the dealer or fleet customer account that is the recipient of the rebate. Links to dealer or customer master data.',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Dealer and fleet rebate agreements in automotive are scoped to specific vehicle models (e.g., $500/unit on Model X). The existing vehicle_model_scope is a denormalized text field; a proper FK to vehic',
    `powertrain_spec_id` BIGINT COMMENT 'Foreign key linking to engineering.powertrain_spec. Business justification: OEM rebate programs (EV incentives, hybrid purchase rebates) are scoped to specific powertrain configurations. Replacing the free-text powertrain_scope with a structured FK to powertrain_spec enables ',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: EV and hybrid incentive rebate agreements in automotive are scoped to specific powertrain variants (e.g., BEV-only rebates, PHEV incentives). The existing powertrain_scope is denormalized text; a prop',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Rebate programs are tied to specific regulatory incentives; linking enables tracking of compliance‑driven rebates.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Rebate agreements often apply to specific parts/materials SKUs (e.g., promotional parts rebates, volume discounts on specific components). Required for parts rebate program management and dealer incen',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Rebate agreements are defined per vehicle program; linking to vehicle_program allows accurate accruals, compliance reporting, and program‑specific financial analysis.',
    `accrual_method` STRING COMMENT 'Method by which rebate amounts are calculated and accrued: periodic (monthly/quarterly calculation), milestone (triggered when target is reached), transaction_based (accrued per invoice).. Valid values are `periodic|milestone|transaction_based`',
    `achieved_volume` STRING COMMENT 'Actual number of vehicle units sold or delivered under this agreement as of the last accrual calculation. Updated periodically based on billing transactions.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the rebate agreement, typically generated by SAP SD rebate management (BO01/BO02) or dealer management system.. Valid values are `^[A-Z0-9]{8,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the rebate agreement: draft (under negotiation), active (in force), suspended (temporarily paused), expired (validity period ended), terminated (cancelled before expiry), settled (final payment completed).. Valid values are `draft|active|suspended|expired|terminated|settled`',
    `agreement_type` STRING COMMENT 'Classification of the rebate agreement defining the incentive structure: volume_rebate (quantity-based), loyalty_bonus (retention incentive), conquest_bonus (new customer acquisition), fleet_incentive (commercial fleet programs), model_mix_bonus (product mix targets), early_payment_discount (payment terms incentive).. Valid values are `volume_rebate|loyalty_bonus|conquest_bonus|fleet_incentive|model_mix_bonus|early_payment_discount`',
    `approval_date` DATE COMMENT 'Date when the rebate agreement was approved by authorized personnel. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Approval workflow status for the rebate agreement: pending_approval (awaiting management sign-off), approved (authorized for execution), rejected (not approved).. Valid values are `pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or user ID of the manager or executive who approved the rebate agreement. Null if not yet approved.',
    `beneficiary_type` STRING COMMENT 'Classification of the rebate recipient: dealer (franchise dealership), fleet_customer (commercial fleet operator), distributor (regional distributor), broker (third-party intermediary).. Valid values are `dealer|fleet_customer|distributor|broker`',
    `contract_document_reference` STRING COMMENT 'Reference number or file path to the signed legal contract or agreement document supporting this rebate arrangement. Used for audit and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate agreement record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `dealer_tier` STRING COMMENT 'Performance tier classification of the dealer beneficiary, used to determine rebate eligibility and rate structure. Higher tiers may receive enhanced rebate terms.. Valid values are `platinum|gold|silver|bronze|standard`',
    `dispute_description` STRING COMMENT 'Description of the dispute or disagreement related to the rebate agreement terms, calculation, or settlement. Null if no dispute exists.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the rebate agreement or its settlement is currently under dispute. True if disputed, False otherwise. Used to flag agreements requiring resolution.',
    `effective_end_date` DATE COMMENT 'Date when the rebate agreement expires and no further transactions accrue rebates. Nullable for open-ended agreements subject to annual renewal.',
    `effective_start_date` DATE COMMENT 'Date when the rebate agreement becomes active and eligible transactions begin accruing rebates. Aligns with fiscal year (FY) or model year (MY) boundaries.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether the rebate agreement applies retroactively to transactions that occurred before the agreement effective start date. True if retroactive, False otherwise.',
    `last_accrual_calculation_date` DATE COMMENT 'Date when the rebate accrual amounts were last recalculated based on eligible transactions. Used to track data freshness and trigger next calculation cycle.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the rebate agreement record was last updated. Used for change tracking and audit purposes.',
    `last_settlement_date` DATE COMMENT 'Date of the most recent rebate settlement payment or credit memo issuance. Null if no settlements have occurred.',
    `next_settlement_date` DATE COMMENT 'Scheduled date for the next rebate settlement payment or credit memo generation. Null if agreement is settled or terminated.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or clarifications related to the rebate agreement. Used for operational context and dispute resolution.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining rebate amount accrued but not yet settled. Calculated as total_accrued_amount minus total_settled_amount.',
    `payment_method` STRING COMMENT 'Method by which rebate is settled: credit_memo (issued against future purchases), direct_payment (bank transfer or check), offset_against_invoice (deducted from current receivables).. Valid values are `credit_memo|direct_payment|offset_against_invoice`',
    `rebate_amount_per_unit` DECIMAL(18,2) COMMENT 'Fixed rebate amount paid per vehicle unit sold. Used for flat-rate rebate structures. Null if percentage-based rebate is used.',
    `rebate_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to eligible transaction amounts to calculate rebate accrual. Used for percentage-based rebate structures. Null if fixed amount rebate is used.',
    `sales_region` STRING COMMENT 'Geographic sales region or territory to which this rebate agreement applies. Used for regional incentive programs and performance tracking.',
    `sap_rebate_agreement_number` STRING COMMENT 'SAP SD rebate agreement reference number from transaction codes BO01 (create) or BO02 (change). Used for system integration and traceability.. Valid values are `^[0-9]{10}$`',
    `settlement_frequency` STRING COMMENT 'Frequency at which accrued rebates are paid out to the beneficiary: monthly, quarterly, semi_annual, annual, or upon_completion (at agreement end).. Valid values are `monthly|quarterly|semi_annual|annual|upon_completion`',
    `settlement_status` STRING COMMENT 'Current status of rebate settlement: not_started (no payments made), in_progress (settlement cycle active), partially_settled (some payments made), fully_settled (all accruals paid), disputed (settlement under review).. Valid values are `not_started|in_progress|partially_settled|fully_settled|disputed`',
    `target_volume` STRING COMMENT 'Target number of vehicle units that must be sold or delivered to qualify for the rebate. Null for non-volume-based agreements.',
    `termination_reason` STRING COMMENT 'Explanation for why the rebate agreement was terminated early, if applicable. Null for agreements that expired naturally or are still active.',
    `total_accrued_amount` DECIMAL(18,2) COMMENT 'Cumulative rebate amount accrued under this agreement as of the last calculation date. Represents the liability owed to the beneficiary.',
    `total_settled_amount` DECIMAL(18,2) COMMENT 'Cumulative rebate amount paid out to the beneficiary through credit memos or direct payments. Used to track settlement progress.',
    CONSTRAINT pk_rebate_agreement PRIMARY KEY(`rebate_agreement_id`)
) COMMENT 'Dealer or fleet rebate agreement defining the terms under which volume-based or performance-based rebates are accrued and settled. Captures agreement number, agreement type (volume_rebate/loyalty_bonus/conquest_bonus/fleet_incentive/model_mix_bonus), beneficiary account, vehicle model scope, agreement period, target volume, achieved volume, rebate rate or amount, accrual method (periodic/milestone), settlement frequency (monthly/quarterly/annual), settlement status, and SAP SD rebate agreement reference (BO01/BO02). Drives credit memo generation upon settlement.';

CREATE OR REPLACE TABLE `automotive_ecm`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Primary key for payment_plan',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Accounts may have a default payment plan; adding the FK enables direct lookup.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: A payment plan is governed by payment terms that define due date calculation, discount windows, and penalty rules. payment_plan has payment_frequency, billing_cycle, and penalty_rate as plan-specific ',
    `superseded_payment_plan_id` BIGINT COMMENT 'Self-referencing FK on payment_plan (superseded_payment_plan_id)',
    `auto_renewal` BOOLEAN COMMENT 'If true, the plan automatically renews at the end of its term.',
    `billing_cycle` STRING COMMENT 'Definition of the billing period used for invoicing.',
    `billing_day_of_month` STRING COMMENT 'Day of month on which recurring invoices are generated.',
    `collection_status` STRING COMMENT 'Current status of debt collection activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment plan record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for the plan.',
    `default_date` DATE COMMENT 'Date when the plan entered default status.',
    `defaulted_flag` BOOLEAN COMMENT 'True if the plan is in default due to missed payments.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the total amount.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial lump‑sum payment required at plan inception.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the plan is terminated before its effective end date.',
    `effective_end_date` DATE COMMENT 'Date when the payment plan terminates; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the payment plan becomes binding.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which customers may enroll in the plan.',
    `grace_period_days` STRING COMMENT 'Number of days after due date before penalties apply.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Amount due for each regular installment.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate applied to the outstanding balance.',
    `last_payment_date` DATE COMMENT 'Date when the most recent payment was received.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee applied when a payment is received after the grace period.',
    `next_payment_due_date` DATE COMMENT 'Date of the next scheduled payment.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions.',
    `number_of_installments` STRING COMMENT 'Total number of installments defined in the plan.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining amount due under the plan.',
    `payment_channel` STRING COMMENT 'Channel through which the payment is initiated.',
    `payment_frequency` STRING COMMENT 'Regular interval at which payments are scheduled.',
    `payment_method` STRING COMMENT 'Instrument used to settle payments.',
    `payment_plan_description` STRING COMMENT 'Detailed description of the plan, including purpose and key terms.',
    `payment_plan_status` STRING COMMENT 'Current lifecycle state of the payment plan.',
    `penalty_rate` DECIMAL(18,2) COMMENT 'Percentage applied to overdue balances as a penalty.',
    `plan_code` STRING COMMENT 'External business code used to reference the payment plan in contracts and invoices.',
    `plan_name` STRING COMMENT 'Human‑readable name of the payment plan.',
    `plan_type` STRING COMMENT 'Category of the payment plan indicating the financing model.',
    `promotional_code` STRING COMMENT 'Code representing a marketing promotion linked to the plan.',
    `recurring_amount` DECIMAL(18,2) COMMENT 'Amount that recurs each payment period after down payment.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the plan is eligible for renewal.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount based on tax_rate and taxable amount.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the plan is exempt from sales tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate for the plan (if not tax‑exempt).',
    `total_amount` DECIMAL(18,2) COMMENT 'Overall amount to be paid over the life of the plan.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Sum of all payments received to date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment plan record.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Master reference table for payment_plan. Referenced by payment_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_dealer_statement_id` FOREIGN KEY (`dealer_statement_id`) REFERENCES `automotive_ecm`.`billing`.`dealer_statement`(`dealer_statement_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `automotive_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rebate_agreement_id` FOREIGN KEY (`rebate_agreement_id`) REFERENCES `automotive_ecm`.`billing`.`rebate_agreement`(`rebate_agreement_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_price_condition_id` FOREIGN KEY (`price_condition_id`) REFERENCES `automotive_ecm`.`billing`.`price_condition`(`price_condition_id`);
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tax_code_id` FOREIGN KEY (`tax_code_id`) REFERENCES `automotive_ecm`.`billing`.`tax_code`(`tax_code_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `automotive_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_rebate_agreement_id` FOREIGN KEY (`rebate_agreement_id`) REFERENCES `automotive_ecm`.`billing`.`rebate_agreement`(`rebate_agreement_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `automotive_ecm`.`billing`.`receivable`(`receivable_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `automotive_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `automotive_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `automotive_ecm`.`billing`.`receivable`(`receivable_id`);
ALTER TABLE `automotive_ecm`.`billing`.`account` ADD CONSTRAINT `fk_billing_account_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `automotive_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `automotive_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ADD CONSTRAINT `fk_billing_dealer_statement_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ADD CONSTRAINT `fk_billing_payment_term_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ADD CONSTRAINT `fk_billing_tax_code_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ADD CONSTRAINT `fk_billing_rebate_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `automotive_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `automotive_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_superseded_payment_plan_id` FOREIGN KEY (`superseded_payment_plan_id`) REFERENCES `automotive_ecm`.`billing`.`payment_plan`(`payment_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `automotive_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `automotive_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `dealer_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Statement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `msrp_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Msrp Pricing Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Salesperson Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Cancelled Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|partially_paid|paid|cancelled|disputed');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'dealer|retail|fleet|parts|service|warranty');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `msrp_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP) Based Flag');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|credit_card|ach|cash|letter_of_credit');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `sap_billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Billing Document Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `sap_billing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `vin` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `vin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice` ALTER COLUMN `vin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `aftersales_service_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Service Appointment Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `aftersales_warranty_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Warranty Claim Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `dealer_incentive_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Incentive Claim Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `dealer_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Inventory Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `goodwill_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Goodwill Adjustment Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `parts_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Inventory Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `parts_order_id` SET TAGS ('dbx_business_glossary_term' = 'Aftersales Parts Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `parts_return_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Return Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Po Line Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `price_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `recall_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Completion Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Salesperson Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `repair_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Line Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_contract_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Claim Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_part_id` SET TAGS ('dbx_business_glossary_term' = 'Service Part Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_code_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `trim_option_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Option Package Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `labor_operation_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Operation Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_item_type` SET TAGS ('dbx_business_glossary_term' = 'Line Item Type');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|billed|paid|cancelled|disputed|credited');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `msrp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Suggested Retail Price (MSRP)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `negotiated_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Price');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `sales_order_line_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `warranty_code` SET TAGS ('dbx_business_glossary_term' = 'Warranty Code');
ALTER TABLE `automotive_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Entity Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payment_payer_entity_party_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Entity Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Payment Amount');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Bank Account Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Clearing Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Payment Record Created By User');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Dispute Flag');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Dispute Reason');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `lockbox_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payer_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Entity Type');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payer_entity_type` SET TAGS ('dbx_value_regex' = 'dealer|retail_customer|fleet_operator|corporate_account|leasing_company|financial_institution');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Reconciliation Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Reconciliation Status');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|disputed|under_review');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `remittance_advice` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Return Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Return Reason Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `sap_clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Clearing Document Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `sap_payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Payment Document Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Payment Amount');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Payment Record Updated By User');
ALTER TABLE `automotive_ecm`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dealer_incentive_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Incentive Claim Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dealer_warranty_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Warranty Claim Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `recall_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Completion Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount_base_currency` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount in Base Currency');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Method');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|system_proposed|batch_clearing');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Priority');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Status');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|reversed|disputed|reconciled|voided');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Type');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'full|partial|advance|overpayment|credit_memo|adjustment');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'open|cleared|partially_cleared|reset');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dealer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Percentage');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dispute_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dispute Indicator');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Posting Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|exception|under_review');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `remaining_invoice_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Invoice Balance');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_allocation` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `automotive_ecm`.`billing`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`billing`.`account` SET TAGS ('dbx_subdomain' = 'customer_accounts');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Billing Account ID');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Name');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Number');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Status');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_approval|blocked|dormant');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Type');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'dealer|retail|fleet|corporate|government|export');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `auto_pay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enrolled Flag');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `consolidated_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Billing Flag');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `credit_check_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Date');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Amount');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `credit_rating_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `credit_rating_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `dispute_count_ytd` SET TAGS ('dbx_business_glossary_term' = 'Dispute Count Year-to-Date (YTD)');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `dms_account_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Management System (DMS) Account ID');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `dunning_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Dunning Block Flag');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|edi|portal|fax');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_business_glossary_term' = 'Invoice Email Address');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `payment_method_preference` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Preference');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `payment_method_preference` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|direct_debit|letter_of_credit');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `payment_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Payment Performance Score');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `payment_performance_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `sap_customer_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Customer Number');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `sap_customer_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) ID');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `vat_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`account` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Aging Bucket');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|91_120_days|over_120_days');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Receivable Closure Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Activity Status');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Indicator Flag');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `customer_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Type Segment');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `customer_type` SET TAGS ('dbx_value_regex' = 'dealer|retail|fleet|government|rental|leasing');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due Count');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `dealer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Initiation Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Indicator Flag');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `dispute_reference` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Reference Number');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level Escalation');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Customer Contact Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Notice Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `next_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Dunning Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Active Flag');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `receivable_number` SET TAGS ('dbx_business_glossary_term' = 'Receivable Document Number');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `receivable_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[0-9]{8,12}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `receivable_status` SET TAGS ('dbx_business_glossary_term' = 'Receivable Lifecycle Status');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `receivable_type` SET TAGS ('dbx_business_glossary_term' = 'Receivable Type Classification');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `sap_fi_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `sap_fi_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `sap_fi_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Transaction Date');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Indicator Flag');
ALTER TABLE `automotive_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `dealer_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Statement ID');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership ID');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `aging_bucket_30_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 30 Days Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `aging_bucket_60_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 60 Days Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `aging_bucket_90_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 90 Days Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `aging_bucket_current_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket Current Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `aging_bucket_over_90_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket Over 90 Days Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `cdk_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'CDK (CDK Global) Statement Reference');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `closing_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `floorplan_financing_flag` SET TAGS ('dbx_business_glossary_term' = 'Floorplan Financing Flag');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `opening_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|issued|acknowledged|disputed|reconciled|closed');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|ad_hoc|final|interim');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Memo Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_debit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Memo Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Incentive Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_parts_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Sales Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_payment_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Received Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_service_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Service Charges Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_vehicle_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Vehicle Sales Amount');
ALTER TABLE `automotive_ecm`.`billing`.`dealer_statement` ALTER COLUMN `total_warranty_reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Warranty Reimbursement Amount');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` SET TAGS ('dbx_subdomain' = 'reference_configuration');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `price_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Price Condition ID');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `transport_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Rate Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `trim_level_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Trim Level Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_value_regex' = 'fixed|percentage|quantity_based|tiered|formula');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_class` SET TAGS ('dbx_business_glossary_term' = 'Condition Class');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_class` SET TAGS ('dbx_value_regex' = 'price|discount|surcharge|tax|freight');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Exclusion Flag');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Record Number');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_step_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Step Number');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_unit` SET TAGS ('dbx_business_glossary_term' = 'Condition Unit');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_unit` SET TAGS ('dbx_value_regex' = 'amount|percentage|per_unit|per_vehicle');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `condition_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Value');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `customer_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Type');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `customer_type` SET TAGS ('dbx_value_regex' = 'retail|fleet|dealer|government|commercial');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `dealer_code` SET TAGS ('dbx_business_glossary_term' = 'Dealer Code');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `effective_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `effective_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `is_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Current Flag');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `manual_override_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Allowed Flag');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `pricing_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Procedure Code');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `sales_region_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `sap_condition_table` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Table');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `sap_konp_record_number` SET TAGS ('dbx_business_glossary_term' = 'SAP KONP Record Number');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `sap_konv_counter` SET TAGS ('dbx_business_glossary_term' = 'SAP KONV Counter');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Scale Basis');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|value|weight|volume');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `scale_quantity_from` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity From');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `scale_quantity_to` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity To');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `automotive_ecm`.`billing`.`price_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` SET TAGS ('dbx_subdomain' = 'reference_configuration');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term ID');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `applicable_account_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Account Types');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `auto_dunning_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Dunning Enabled');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `baseline_date_rule` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date Rule');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `baseline_date_rule` SET TAGS ('dbx_value_regex' = 'invoice_date|delivery_date|month_end|custom');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `credit_check_required` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Required');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `discount_days_1` SET TAGS ('dbx_business_glossary_term' = 'Discount Days 1');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `discount_days_2` SET TAGS ('dbx_business_glossary_term' = 'Discount Days 2');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `discount_percentage_1` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage 1');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `discount_percentage_2` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage 2');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `fixed_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Fixed Day of Month');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `maximum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Value');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `net_due_days` SET TAGS ('dbx_business_glossary_term' = 'Net Due Days');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_method_restriction` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Restriction');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Description');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Name');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_value_regex' = 'daily|monthly|flat_fee|none');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `penalty_grace_days` SET TAGS ('dbx_business_glossary_term' = 'Penalty Grace Days');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Penalty Rate');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `sap_fi_payment_term_key` SET TAGS ('dbx_business_glossary_term' = 'SAP FI (Financial Accounting) Payment Term Key');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `sap_fi_payment_term_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `automotive_ecm`.`billing`.`payment_term` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` SET TAGS ('dbx_subdomain' = 'reference_configuration');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_code_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Code Identifier (ID)');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `applicable_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transaction Types');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|tiered|formula_based');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `exemption_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Exemption Certificate Required Flag');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `is_deductible` SET TAGS ('dbx_business_glossary_term' = 'Is Deductible Flag');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `is_recoverable` SET TAGS ('dbx_business_glossary_term' = 'Is Recoverable Flag');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'federal|state|local|eu|apac|multi_jurisdiction');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Code Notes');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `reverse_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Applicable Flag');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `rounding_precision` SET TAGS ('dbx_business_glossary_term' = 'Rounding Precision');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_value_regex' = 'round_up|round_down|round_nearest|no_rounding');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `sap_fi_tax_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Tax Code');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `sap_fi_tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,2}$');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `sap_sd_tax_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales and Distribution (SD) Tax Code');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `sap_sd_tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,2}$');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Reference');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_basis` SET TAGS ('dbx_business_glossary_term' = 'Tax Basis');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_basis` SET TAGS ('dbx_value_regex' = 'net_amount|gross_amount|msrp|invoice_value|customs_value');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'input_tax|output_tax|withholding_tax|reverse_charge|exempt|zero_rated');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_code_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_code_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Code Name');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_code_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Code Status');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'vat|gst|sales_tax|excise|luxury_tax|environmental_levy');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `withholding_tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Applicable Flag');
ALTER TABLE `automotive_ecm`.`billing`.`tax_code` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` SET TAGS ('dbx_subdomain' = 'customer_accounts');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `rebate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement ID');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account ID');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `powertrain_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Spec Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'periodic|milestone|transaction_based');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `achieved_volume` SET TAGS ('dbx_business_glossary_term' = 'Achieved Volume');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Number');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Status');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|settled');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Type');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'volume_rebate|loyalty_bonus|conquest_bonus|fleet_incentive|model_mix_bonus|early_payment_discount');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_value_regex' = 'dealer|fleet_customer|distributor|broker');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `dealer_tier` SET TAGS ('dbx_business_glossary_term' = 'Dealer Tier');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `dealer_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Is Retroactive');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `last_accrual_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accrual Calculation Date');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `next_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Settlement Date');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_memo|direct_payment|offset_against_invoice');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `rebate_amount_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount Per Unit');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `rebate_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate Percent');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `sap_rebate_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Rebate Agreement Number');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `sap_rebate_agreement_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|upon_completion');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|partially_settled|fully_settled|disputed');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `target_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Volume');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `total_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Accrued Amount');
ALTER TABLE `automotive_ecm`.`billing`.`rebate_agreement` ALTER COLUMN `total_settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Settled Amount');
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'customer_accounts');
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier');
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `automotive_ecm`.`billing`.`payment_plan` ALTER COLUMN `superseded_payment_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
