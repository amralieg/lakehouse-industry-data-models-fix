-- Schema for Domain: revenue | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`revenue` COMMENT 'Manages revenue recognition, invoicing, payment processing, accounts receivable, JIB (Joint Interest Billing) statements, royalty payments, tariff charges, and cash application for crude oil sales, refined product sales, and petrochemical revenues. Owns invoice data, payment terms, revenue allocation, credit notes, and dispute resolution. Supports COPAS-compliant billing procedures, IFRS/GAAP revenue recognition standards (successful-efforts and full-cost methods), and SOX compliance. Integrates with SAP FI/SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system-generated identifier for the invoice record. Primary key for the invoice entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty being billed. May be an IOC (International Oil Company), NOC (National Oil Company), refiner, trader, industrial consumer, or joint venture partner.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Revenue invoices for joint venture cost recovery, capital project billing, and COPAS billing must reference the AFE budget to ensure proper cost allocation, working interest calculations, and audit tr',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Invoices for processing fees, gathering charges, compression services, or facility-based services must reference the specific facility for cost allocation, regulatory reporting, and joint venture bill',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: JV invoices must identify the operator or billing party partner for COPAS-compliant joint interest billing. Required for partner-specific AR aging, credit management, and regulatory audit trails in jo',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Invoices must be issued by a legal entity (company code) for GL posting, financial reporting, and SOX compliance. Essential for multi-entity oil & gas operations.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: PSA cost recovery invoices and royalty invoices must reference regulatory filings submitted to host governments. Critical for audit trail and government reconciliation in production sharing agreements',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue invoices allocated to cost centers for asset-level profitability analysis, AFE tracking, and joint venture accounting in oil & gas operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Invoice creation audit trail required for SOX compliance, dispute resolution, and authorization controls. Oil & gas revenue invoices (JIB, royalty, product sales) require employee accountability for r',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this JIB invoice is issued. Applicable only for invoice_type = jib. Defines the joint venture partnership and cost-sharing rules.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Production and sales invoices must tie to valid operating permits for regulatory validation. Revenue recognition requires proof of permitted operations, especially for offshore and federal leases.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline transportation invoices reference specific segments for regulatory compliance (FERC Form 6), shipper billing, tariff rate application, and segment-level revenue tracking.',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Invoices reference pricing benchmarks (Platts, Argus, NYMEX) for index-based contracts. Transparent pricing mechanism requires linking to benchmark definitions for price calculation verification, audi',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Invoices must be assigned to profit centers for segment reporting, P&L analysis by field/basin, and management reporting in oil & gas operations.',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: Product sales invoices originate from specific refineries. Billing entity code/name on invoice are denormalized refinery identifiers. Links invoice to producing facility for revenue attribution, trans',
    `payment_term_id` BIGINT COMMENT 'Standardized code representing the payment terms agreed with the customer (e.g., NET30, NET60, 2/10NET30 for 2% discount if paid within 10 days, net due in 30 days).',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Invoices bill spot trades directly (not just sales orders) in physical commodity trading. Required for spot market billing process where trades settle without formal sales orders.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well-level invoices for working interest billing, lease operating expenses, or production revenue require direct well attribution for joint interest billing and partner cost allocation.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustments applied to the invoice for pricing corrections, quality adjustments, demurrage charges, or other post-billing modifications. May be positive or negative.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The cumulative amount received from the customer against this invoice to date. Used to calculate outstanding balance and track partial payments.',
    `billing_period_end_date` DATE COMMENT 'The last date of the period covered by this invoice. Defines the temporal scope of the billed activities or deliveries.',
    `billing_period_start_date` DATE COMMENT 'The first date of the period covered by this invoice. For production sales, this is the start of the lifting or delivery period. For JIB invoices, this is the start of the cost accumulation period.',
    `copas_billing_method` STRING COMMENT 'The COPAS-compliant billing method used for JIB invoices. Detailed method provides line-by-line cost breakdowns. Summary method aggregates costs by category. Lump sum method bills a pre-agreed fixed amount. Applicable only for invoice_type = jib.. Valid values are `detailed|summary|lump_sum`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this invoice record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). All monetary amounts on this invoice are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
    `customer_name` STRING COMMENT 'The legal or trading name of the customer being invoiced. Denormalized for reporting convenience and invoice document generation.',
    `delivery_point_name` STRING COMMENT 'The name of the physical location where the product was delivered or title transferred (e.g., Cushing Hub, Houston Ship Channel, specific refinery gate, pipeline custody transfer point). Used for logistics tracking and pricing differential application.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice, including volume discounts, early payment discounts, or contractual rebates. Reduces the amount due.',
    `dispute_date` DATE COMMENT 'The date the customer formally notified Oil Gas of the invoice dispute. Used to track dispute aging and resolution SLAs.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason the customer has disputed this invoice. Populated when invoice_status = disputed. Used for dispute resolution tracking and root cause analysis.',
    `due_date` DATE COMMENT 'The date by which full payment is expected from the customer per the agreed payment terms. Used for aging analysis, late payment interest calculation, and credit management.',
    `gl_posting_date` DATE COMMENT 'The date this invoice was posted to the general ledger for financial reporting. Used for period close and financial statement preparation.',
    `invoice_date` DATE COMMENT 'The date the invoice was formally issued to the customer. This is the official billing date used for revenue recognition timing under IFRS 15 and ASC 606, and the starting point for payment term calculations.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number assigned to the billing document for customer reference and payment reconciliation. Used in customer communications and payment remittance.. Valid values are `^[A-Z0-9]{8,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the invoice in the accounts receivable workflow. Draft invoices are pending approval. Issued invoices are approved but not yet transmitted. Sent invoices have been delivered to the customer. Disputed invoices have customer challenges requiring resolution. Partially paid invoices have received partial payment. Paid invoices are fully settled. Cancelled invoices are voided. Written-off invoices are uncollectible and removed from active receivables. [ENUM-REF-CANDIDATE: draft|issued|sent|disputed|partially_paid|paid|cancelled|written_off — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the nature of the billing transaction. Commercial invoices are for third-party crude oil, refined product, or petrochemical sales. JIB (Joint Interest Billing) invoices are for joint venture partner cost allocations per COPAS standards. Royalty invoices are for mineral rights owner payments. Tariff invoices are for pipeline transportation or storage fees. Intercompany invoices are for internal cross-entity transactions. Service invoices are for technical or operational services rendered.. Valid values are `commercial|intercompany|jib|royalty|tariff|service`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time this invoice record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'The remaining unpaid amount on the invoice, calculated as total_amount - amount_paid. Zero when invoice is fully paid.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism agreed for settling this invoice. Wire transfer and ACH are electronic funds transfers. Check is paper-based. Letter of credit is a bank guarantee instrument common in international trade. Offset is used in joint venture netting arrangements.. Valid values are `wire_transfer|ach|check|letter_of_credit|offset`',
    `price_differential` DECIMAL(18,2) COMMENT 'The adjustment (positive or negative) applied to the reference_price to arrive at the actual transaction price. Accounts for quality differences, location basis, and contractual premiums or discounts. Expressed in the same units as reference_price.',
    `product_type` STRING COMMENT 'High-level classification of the primary product or service being billed. Crude oil includes WTI, Brent, and other crude grades. Refined products include gasoline, diesel, jet fuel, and other distillates. LNG is liquefied natural gas. LPG is liquefied petroleum gas. NGL is natural gas liquids. Petrochemicals include ethylene, propylene, benzene, and other chemical products. Service covers technical, operational, or consulting services. [ENUM-REF-CANDIDATE: crude_oil|refined_product|lng|lpg|ngl|petrochemical|service — 7 candidates stripped; promote to reference product]',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which revenue from this invoice is recognized in the financial statements per IFRS 15 or ASC 606. May differ from invoice_date based on performance obligation satisfaction criteria.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The sum of all line item amounts before taxes, discounts, and adjustments. Represents the gross value of goods or services billed.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the invoice, including sales tax, VAT, excise duties, or other applicable taxes per jurisdiction. May be zero for tax-exempt transactions or international sales.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final amount due from the customer, calculated as subtotal_amount + tax_amount - discount_amount + adjustment_amount. This is the amount the customer must remit.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a formal demand for payment issued to customers (IOCs, NOCs, refiners, traders, industrial consumers) for crude oil sales, refined product sales, LNG/LPG/NGL deliveries, and petrochemical revenues. Captures invoice number, date, due date, billing period, type (commercial, intercompany, JIB, royalty, tariff), currency, total amount, tax amount, discount amount, payment terms (net days, early payment discount, late interest rate), status (draft, issued, disputed, paid, cancelled), and COPAS billing method indicator. SSOT for all outbound billing documents in the revenue domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice_line product.',
    `blend_event_id` BIGINT COMMENT 'Foreign key linking to refining.blend_event. Business justification: Finished product invoice lines reference specific blend batches for traceability and quality certification. Batch number on invoice line is denormalized blend event identifier. Required for quality di',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Line-level audit trail for revenue recognition disputes, quality adjustments, and tariff calculations. Oil & gas operations require tracking who entered pricing differentials, gravity adjustments, and',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude oil invoicing references specific grades (WTI, Brent, Maya, Urals) with grade-specific pricing differentials and quality adjustments. Standard crude trading practice requires grade-level detail ',
    `customer_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to customer.lifting_schedule. Business justification: Invoice lines for crude liftings must link to the specific lifting schedule for volume reconciliation, entitlement tracking, and pricing validation. Required for matching invoiced volumes to actual li',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Invoice lines must track the specific delivery point for custody transfer documentation, tariff calculation, and revenue allocation by location. Critical for reconciling delivered volumes against cont',
    `end_use_declaration_id` BIGINT COMMENT 'Foreign key linking to customer.end_use_declaration. Business justification: Invoice lines for export-controlled petroleum products must reference the customers end-use declaration for regulatory compliance, sanctions screening, and customs documentation. Required for validat',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Invoice lines must post to specific GL accounts for revenue recognition, financial reporting, and audit trail. Essential for oil & gas accounting compliance.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the invoice transaction.',
    `lease_id` BIGINT COMMENT 'Unique identifier of the oil and gas lease or production unit associated with this revenue. Supports royalty calculation and revenue distribution.',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Invoice lines for crude oil sales must reference the customer nomination that authorized the lifting. Essential for reconciling nominated volumes against invoiced volumes, validating pricing basis, an',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Individual invoice line items for facility charges, tariffs, or production volumes must reference specific permits. Required for FERC and state regulatory validation of billed services.',
    `petroleum_product_id` BIGINT COMMENT 'FK to product.petroleum_product',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: Invoice lines for refined products (gasoline, diesel, jet fuel) trace back to producing process unit (FCC, HDS, reformer). Critical for margin analysis by unit, product costing, and operational perfor',
    `production_well_id` BIGINT COMMENT 'Unique identifier of the producing well or facility that generated the product being invoiced. Supports well-level revenue allocation and production accounting.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Invoice lines reference quality specifications for contractual compliance verification. Off-spec product triggers pricing penalties or rejection; linking to quality specs enables automated compliance ',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Invoice lines must track royalty owner entitlements for production revenue distribution, 1099 reporting, and suspense account management - fundamental to oil & gas revenue allocation processes.',
    `tank_inventory_id` BIGINT COMMENT 'Foreign key linking to refining.tank_inventory. Business justification: Custody transfer invoicing requires tank-level inventory snapshot at time of sale. Links invoice line to specific tank inventory record for volume reconciliation, opening/closing balance verification,',
    `tariff_agreement_id` BIGINT COMMENT 'FK to commercial.tariff_agreement',
    `afe_number` STRING COMMENT 'AFE number authorizing the activity that generated this revenue. Used in joint venture accounting to track revenues against authorized projects.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of crude oil, used for quality-based pricing adjustments. Higher API gravity indicates lighter, more valuable crude oil.',
    `base_amount` DECIMAL(18,2) COMMENT 'Gross line amount before quality adjustments, calculated as quantity multiplied by unit price. Represents the baseline revenue for this line item.',
    `btu_adjustment_amount` DECIMAL(18,2) COMMENT 'Price adjustment applied based on BTU content variance from contract specification for natural gas sales.',
    `btu_content` DECIMAL(18,2) COMMENT 'Energy content of natural gas measured in BTU per cubic foot. Used for quality-based pricing adjustments in gas sales contracts.',
    `business_area` STRING COMMENT 'Business segment or division responsible for this revenue. Supports segment reporting per IFRS 8 and GAAP ASC 280.. Valid values are `upstream|midstream|downstream|petrochemical|marketing`',
    `contract_number` STRING COMMENT 'Reference to the sales contract, offtake agreement, or term contract governing this transaction. Links invoice line to contractual terms and pricing formulas.',
    `cost_center` STRING COMMENT 'Cost center or profit center responsible for this revenue line item. Supports management accounting and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the billing system. Supports audit trail and SOX compliance.',
    `credit_note_reference` STRING COMMENT 'Reference number of the credit note issued to reverse or adjust this line item. Links to accounts receivable credit memo documents.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line item. Supports multi-currency invoicing for international operations. [ENUM-REF-CANDIDATE: USD|CAD|EUR|GBP|JPY|CNY|AUD|MXN|BRL — 9 candidates stripped; promote to reference product]',
    `discount_amount` DECIMAL(18,2) COMMENT 'Contractual discount applied to this line item. May include volume discounts, early payment discounts, or promotional pricing adjustments.',
    `dispute_reason` STRING COMMENT 'Reason code or description if this line item is under dispute. Documents customer challenges to quantity, quality, pricing, or contractual terms.',
    `gravity_adjustment_amount` DECIMAL(18,2) COMMENT 'Price adjustment applied based on API gravity variance from contract specification. Positive for premium crude, negative for discount.',
    `jib_category` STRING COMMENT 'Classification for joint interest billing purposes. Determines how costs and revenues are allocated among joint venture partners per the JOA (Joint Operating Agreement).. Valid values are `operated|non_operated|overhead|direct|indirect`',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and display sequence of line items on the invoice document.',
    `line_status` STRING COMMENT 'Current status of this invoice line item. Tracks lifecycle from initial billing through dispute resolution and final settlement.. Valid values are `active|disputed|adjusted|cancelled|credited`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last modified. Tracks changes for audit and dispute resolution purposes.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount for this line item after all adjustments, discounts, and taxes. Calculated as base amount plus quality adjustments minus discounts plus taxes.',
    `net_revenue_interest_pct` DECIMAL(18,2) COMMENT 'Net percentage of revenue retained after royalty and overriding royalty deductions. Calculated as working interest minus royalty burdens.',
    `pricing_basis` STRING COMMENT 'Reference pricing index or benchmark used to determine the unit price. Common values include WTI (West Texas Intermediate), Brent, Platts, NYMEX, or contract-specific pricing formulas.',
    `production_month` DATE COMMENT 'Calendar month in which the product was produced or delivered. Used for production accounting and revenue period matching per GAAP revenue recognition.',
    `quality_adjustment_total` DECIMAL(18,2) COMMENT 'Sum of all quality-based price adjustments including gravity, sulfur, BTU, and other specification variances. May be positive or negative.',
    `quantity` DECIMAL(18,2) COMMENT 'Volume or weight of product delivered and invoiced, measured in the specified unit of measure. Represents the billable quantity after adjustments for temperature, pressure, and quality.',
    `revenue_category` STRING COMMENT 'Classification of the revenue stream for this line item. Supports revenue recognition and financial reporting segmentation per IFRS 15 and GAAP ASC 606. [ENUM-REF-CANDIDATE: crude_oil|refined_product|ngl|lng|lpg|petrochemical|tariff|royalty|processing_fee|storage_fee|transportation_fee — 11 candidates stripped; promote to reference product]',
    `royalty_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of revenue subject to royalty payment to mineral rights owners. Used to calculate royalty obligations from gross revenue.',
    `sulfur_adjustment_amount` DECIMAL(18,2) COMMENT 'Price adjustment applied based on sulfur content variance from contract specification. Sweet crude (low sulfur) receives premium, sour crude (high sulfur) receives discount.',
    `sulfur_content_pct` DECIMAL(18,2) COMMENT 'Sulfur content of crude oil or refined product expressed as weight percentage. Lower sulfur content commands premium pricing due to environmental regulations and refining economics.',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Published tariff rate per unit for transportation, storage, or processing services. Rate is filed with and approved by FERC or state regulatory authority.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this line item based on applicable tax codes and rates. Includes sales tax, excise tax, severance tax, or VAT.',
    `tax_code` STRING COMMENT 'Tax jurisdiction and rate code applicable to this line item. Determines sales tax, excise tax, severance tax, or VAT treatment.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantity being billed. BBL for crude oil and refined products, MMBTU for natural gas, MT for petrochemicals, MCF for gas volumes. [ENUM-REF-CANDIDATE: BBL|MMBTU|MT|MCF|GAL|LB|KG|TON — 8 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for this line item. May be based on index pricing, contract pricing, or spot market rates.',
    `working_interest_pct` DECIMAL(18,2) COMMENT 'Percentage ownership interest in the producing property for this revenue line. Determines revenue allocation among joint venture partners.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line items on a revenue invoice, capturing the granular detail of each product or service billed. Includes line number, petroleum product code, product description, unit of measure (BBL, MMBTU, MT, MCF), quantity, unit price, line amount, pricing basis (WTI, Brent, Platts), quality adjustment, gravity adjustment (API gravity), sulfur content adjustment, BTU adjustment for gas, applicable tariff code, tax code, and revenue category (crude oil, refined product, NGL, LNG, petrochemical, tariff, royalty). Supports yield-based billing for refinery and petrochemical operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment entity.',
    `commercial_counterparty_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_counterparty. Business justification: Payments received from commercial counterparties (not just customer accounts). Tracks payer entity for cash application and counterparty reconciliation in trading operations.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payments received by specific legal entities for cash management, bank reconciliation, and financial reporting in multi-entity oil & gas operations.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Payments for regulatory fees, filing fees, and PSA government take must reference the specific regulatory filing. Essential for government payment reconciliation and audit compliance.',
    `bank_detail_id` BIGINT COMMENT 'Foreign key linking to customer.bank_detail. Business justification: Payments must reference the specific customer bank account used for settlement to enable cash application, bank reconciliation, and payment routing validation. Critical for matching incoming wire tran',
    `invoice_id` BIGINT COMMENT 'Reference to the revenue invoice against which this payment is applied. Links payment to the originating billing document.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Cash receipts from JV partners must track the paying partner for partner netting, cash call reconciliation, and default monitoring. Essential for JV cash management and partner credit risk assessment.',
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty who remitted this payment. Links to the party master for crude oil, refined product, or petrochemical sales customers.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cash application and payment processing require employee accountability for SOX cash handling controls, lockbox reconciliation, and JIB netting. Critical for segregation of duties and fraud prevention',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Direct payments to royalty owners require owner tracking for suspense clearing, escheatment management, and 1099 tax reporting - essential for royalty payment operations.',
    `amount` DECIMAL(18,2) COMMENT 'The total monetary value of the payment received, expressed in the payment currency. Represents the gross cash receipt before allocation or application to invoices.',
    `application_method` STRING COMMENT 'The method used to allocate the payment to open receivable items. Automatic application uses matching rules, manual requires user intervention, partial allows split allocation, and residual handles remaining balances.. Valid values are `automatic|manual|partial|residual`',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been successfully allocated and applied to open receivable items or invoices. Represents cleared receivables.',
    `bank_statement_date` DATE COMMENT 'The date on which the payment appeared on the bank statement. Used for bank reconciliation and cash position reporting.',
    `bank_statement_reference` STRING COMMENT 'The transaction reference or line item identifier from the bank statement corresponding to this payment. Enables automated bank reconciliation.',
    `business_unit_code` STRING COMMENT 'The business unit or operating segment (Exploration and Production (E&P), Refining, Petrochemicals, Marketing) to which the payment is attributed. Supports segment reporting under IFRS 8.',
    `channel` STRING COMMENT 'The interface or system through which the payment was received and recorded. Distinguishes between bank portal integration, lockbox processing, manual data entry, Electronic Data Interchange (EDI), or Application Programming Interface (API) integration.. Valid values are `bank_portal|lockbox|manual_entry|edi|api`',
    `check_number` STRING COMMENT 'The check number when payment method is check. Used for tracking and reconciliation of paper-based payments.',
    `clearing_reference` STRING COMMENT 'The accounting document number or clearing identifier generated when the payment is applied to invoices and receivables are cleared in the financial system.',
    `cost_center_code` STRING COMMENT 'The cost center or organizational unit to which the payment is attributed for management accounting and profitability analysis. Relevant for joint venture and production sharing agreement (PSA) cost allocation.',
    `created_by_user` STRING COMMENT 'The user identifier or system account that created the payment record. Audit trail for accountability and Sarbanes-Oxley (SOX) compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was first created in the system. Audit trail for data lineage and Sarbanes-Oxley (SOX) compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the payment was received. Critical for multi-currency settlement of international crude oil, Liquefied Natural Gas (LNG), and petrochemical transactions.. Valid values are `^[A-Z]{3}$`',
    `discount_taken` DECIMAL(18,2) COMMENT 'The early payment discount amount claimed by the customer and deducted from the invoice amount. Reflects payment terms incentives for prompt settlement.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the payment is associated with a disputed invoice or receivable item. True when customer has raised a billing dispute or short payment claim.',
    `dispute_reason` STRING COMMENT 'Textual description of the reason for payment dispute or short payment. Captures customer claims regarding pricing, volume, quality, or contractual terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount from the payment currency to the companys functional currency. Used for multi-currency accounting and reporting.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the companys functional currency using the exchange rate. Used for consolidated financial reporting and accounting entries.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the payment is posted. Typically a cash or bank account in the chart of accounts.',
    `jib_netting_reference` STRING COMMENT 'Reference to the Joint Interest Billing (JIB) netting transaction when payment is settled through partner netting arrangements. Common in joint venture operations under Joint Operating Agreement (JOA) structures.',
    `lockbox_batch_code` STRING COMMENT 'The batch identifier assigned by the lockbox service provider for payments processed through lockbox arrangements. Used for bulk payment reconciliation.',
    `modified_by_user` STRING COMMENT 'The user identifier or system account that last modified the payment record. Audit trail for accountability and Sarbanes-Oxley (SOX) compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was last modified. Audit trail for change tracking and Sarbanes-Oxley (SOX) compliance.',
    `overpayment_amount` DECIMAL(18,2) COMMENT 'The excess amount when the payment received exceeds the invoice amount due. May result from customer error, advance payment, or multi-invoice settlement.',
    `payment_date` DATE COMMENT 'The date on which the payment was received or recorded in the system. Represents the business event date for cash receipt recognition.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to remit payment. Includes wire transfer, Automated Clearing House (ACH), check, letter of credit, netting arrangements for Joint Interest Billing (JIB), and electronic funds transfer (EFT).. Valid values are `wire_transfer|ach|check|letter_of_credit|netting|eft`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment. Received indicates initial recording, cleared indicates successful application, bounced indicates failed bank processing, reversed indicates cancellation, pending indicates awaiting clearance, and reconciled indicates bank statement matching completed.. Valid values are `received|cleared|bounced|reversed|pending|reconciled`',
    `posting_date` DATE COMMENT 'The accounting period date on which the payment transaction was posted to the general ledger. May differ from payment_date due to period-end cutoffs and accounting calendar rules.',
    `profit_center_code` STRING COMMENT 'The profit center responsible for the revenue associated with this payment. Used for segment reporting and business unit performance analysis.',
    `reconciliation_status` STRING COMMENT 'Status of bank reconciliation for this payment. Unreconciled indicates no bank statement match, reconciled indicates successful matching, exception indicates discrepancies requiring investigation, and pending_review indicates awaiting manual review.. Valid values are `unreconciled|reconciled|exception|pending_review`',
    `reference_number` STRING COMMENT 'External reference number or transaction identifier provided by the payer or payment processor. Used for reconciliation and traceability across banking systems.',
    `remittance_advice` STRING COMMENT 'Textual information provided by the payer detailing which invoices or accounts the payment is intended to settle. Critical for accurate cash application and dispute resolution.',
    `short_payment_amount` DECIMAL(18,2) COMMENT 'The shortfall amount when the payment received is less than the invoice amount due, excluding authorized discounts. May indicate disputes or payment errors.',
    `tolerance` DECIMAL(18,2) COMMENT 'The acceptable variance threshold for payment matching. Small differences within tolerance are automatically cleared without manual intervention.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unallocated to specific invoices. May represent overpayments, advance payments, or payments pending manual allocation.',
    `value_date` DATE COMMENT 'The effective date on which funds become available for use, as determined by the banking institution. May differ from payment_date due to clearing cycles.',
    `wire_transfer_reference` STRING COMMENT 'The unique reference number assigned by the bank for wire transfer payments. Critical for tracing international crude oil and Liquefied Natural Gas (LNG) payments.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Records of cash receipts processed against revenue invoices, including the matching and allocation of payments to open receivable items. Captures payment reference, date, method (wire transfer, ACH, check, letter of credit, netting), bank account, currency, amount, exchange rate, value date, remittance advice, status (received, cleared, bounced, reversed), applied amount, unapplied amount, application method (automatic, manual, partial), short/overpayment amounts, tolerance, and clearing reference. Supports multi-currency settlement for international crude oil and LNG transactions and automated cash application workflows. SSOT for all inbound cash receipts and their allocation in the revenue domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`receivable` (
    `receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable record. Primary key for the receivable ledger entry.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Accounts receivable for facility-based services (processing, compression, storage) must track to the facility for collections management, dispute resolution, and facility-level revenue performance ana',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AR collections are assigned to specific employees for dunning, dispute resolution, and credit risk management. Performance tracking and workload balancing for collections teams require employee assign',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: AR balances owned by specific legal entities for balance sheet reporting, credit management, and SOX compliance in oil & gas operations.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that owes this receivable. Links to the customer master data for billing and collections.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: AR aging by JV partner is required for partner credit management, default notice triggers, and netting statement preparation. Supports partner-specific collection strategies and forfeiture risk assess',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice that created this receivable. Links to the invoice transaction for detailed line-item analysis.',
    `jib_statement_id` BIGINT COMMENT 'Reference to the JIB statement for joint venture partner billing. Applicable for receivables arising from joint operating agreements and production sharing agreements.',
    `plan_id` BIGINT COMMENT 'Reference to the payment plan agreement if the customer is on an installment schedule. Links to payment plan terms and schedule.',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Unpaid regulatory penalties are tracked as receivables (when company assesses penalties to JV partners) or payables. Links penalty assessment to collections process for joint venture penalty allocatio',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Receivables from royalty owners for cost recoveries, JIB billings, or overpayment recoupment need owner tracking for collections, aging analysis, and credit management.',
    `aging_bucket` STRING COMMENT 'Classification of the receivable based on days past due. Current = not yet due; 30/60/90/90+ days = days overdue. Used for aging reports, expected credit loss provisioning, and SOX compliance reporting.. Valid values are `current|30_days|60_days|90_days|over_90_days`',
    `ar_document_number` STRING COMMENT 'Business identifier for the AR document. External reference number used in SAP FI-AR module for tracking and reconciliation.',
    `ar_type` STRING COMMENT 'Classification of the receivable by business transaction type. Trade receivables are from product sales; JIB receivables are from joint interest billing; royalty receivables are from mineral rights payments; tariff receivables are from pipeline and transportation charges; service receivables are from technical services.. Valid values are `trade|jib|royalty|tariff|service|other`',
    `collection_status` STRING COMMENT 'Current state of the receivable in the collections workflow. Open = normal AR; in_collection = active collection efforts; payment_plan = customer on installment agreement; legal_referral = sent to legal counsel; written_off = deemed uncollectible; closed = fully paid.. Valid values are `open|in_collection|payment_plan|legal_referral|written_off|closed`',
    `cost_center` STRING COMMENT 'Cost center that originated the billable activity. Used for cost allocation and internal charging.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the receivable record was first created in the AR ledger. Used for audit trail and SOX compliance.',
    `credit_risk_rating` STRING COMMENT 'Internal credit risk classification of the customer at the time of receivable creation. Used for expected credit loss provisioning and credit limit management.',
    `credit_terms` STRING COMMENT 'Payment terms agreed with the customer, expressed in standard notation (e.g., Net 30, 2/10 Net 30, Net 45). Defines the payment period and any early payment discounts.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the receivable amount. Supports multi-currency operations for international crude oil, refined product, and petrochemical sales.. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'Number of days the receivable is overdue, calculated as current date minus due date. Negative values indicate payment is not yet due. Used for precise aging analysis and collection prioritization.',
    `dispute_date` DATE COMMENT 'Date the customer formally raised the dispute. Used to track dispute aging and resolution cycle time.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed this receivable. True if the customer has raised a billing dispute; false otherwise. Disputed receivables are excluded from aggressive collection actions.',
    `dispute_reason` STRING COMMENT 'Free-text description of the customers dispute reason. Captures the nature of the billing disagreement for resolution tracking and root cause analysis.',
    `due_date` DATE COMMENT 'Date by which payment is contractually due. Calculated from invoice date plus credit terms. Used for aging bucket classification and dunning trigger.',
    `dunning_level` STRING COMMENT 'Escalation level of collection notices sent to the customer. Typically ranges from 0 (no dunning) to 3+ (final notice before legal action). Increments with each dunning cycle.',
    `dunning_method` STRING COMMENT 'Communication channel used for the last dunning notice. Tracks how collection notices are delivered to the customer.. Valid values are `email|mail|phone|fax|none`',
    `expected_credit_loss_amount` DECIMAL(18,2) COMMENT 'Provision amount for expected credit loss calculated per IFRS 9 ECL model. Based on probability of default, loss given default, and exposure at default. Used for financial reporting and reserve adequacy.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the receivable was created. Typically 1-12 for monthly periods. Used for monthly financial close and reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the receivable was created. Used for period-based financial reporting and year-over-year analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code for the receivable. Maps to the chart of accounts for financial statement reporting and SOX compliance.',
    `last_dunning_date` DATE COMMENT 'Date the most recent dunning notice was sent to the customer. Used to schedule the next dunning cycle and track collection activity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the receivable record was last updated. Tracks changes to balance, status, or other attributes for audit trail and SOX compliance.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment applied to this receivable. Used for payment tracking and cash application analysis.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment applied to this receivable. Used to track payment activity and customer payment behavior.',
    `legal_referral_date` DATE COMMENT 'Date the receivable was referred to legal counsel for collection action. Indicates escalation to litigation or formal legal demand.',
    `original_amount` DECIMAL(18,2) COMMENT 'The original invoiced amount when the receivable was first created. Represents the total amount owed before any payments, credits, or adjustments.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid balance remaining on the receivable after applying payments, credits, and adjustments. Used for aging analysis and expected credit loss provisioning.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the customer is on an installment payment plan for this receivable. True if payment plan is active; false otherwise.',
    `profit_center` STRING COMMENT 'Profit center responsible for the revenue and receivable. Used for internal management reporting and profitability analysis.',
    `revenue_recognition_date` DATE COMMENT 'Date revenue was recognized for this receivable per IFRS 15 or GAAP ASC 606 revenue recognition standards. May differ from invoice date based on performance obligation satisfaction.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount of the receivable that has been written off as uncollectible. May be partial or full write-off. Impacts bad debt expense and expected credit loss reserves.',
    `write_off_date` DATE COMMENT 'Date the receivable was written off. Used for financial reporting and audit trail. Write-offs must be approved per SOX internal control requirements.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether this receivable has been written off as uncollectible. True if written off; false otherwise. Write-offs require management approval and are reported for SOX compliance.',
    `write_off_reason` STRING COMMENT 'Business justification for the write-off. Common reasons include customer bankruptcy, uncollectible after legal action, small balance administrative write-off, or disputed amount settlement.',
    CONSTRAINT pk_receivable PRIMARY KEY(`receivable_id`)
) COMMENT 'Accounts receivable ledger tracking outstanding amounts owed by customers for petroleum product sales and services. Captures AR document number, customer account, original invoice reference, original amount, outstanding balance, aging bucket (current, 30/60/90/90+ days), due date, credit terms, dunning level, dunning date, dunning method, dispute flag, dispute reason, write-off flag, write-off amount, collection status, and legal referral date. Supports SOX-compliant AR aging reporting, IFRS 9 expected credit loss provisioning, and COPAS-compliant collections procedures.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`cash_application` (
    `cash_application_id` BIGINT COMMENT 'Unique identifier for the cash application record. Primary key for the cash application entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this cash application. Identifies the party making the payment.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cash applications processed within specific legal entities for GL posting, bank reconciliation, and financial reporting in oil & gas operations.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or receivable item to which the payment is being applied. May be null for on-account payments.',
    `jib_statement_id` BIGINT COMMENT 'Reference to the JIB statement if this cash application relates to joint venture billing. Links payment to COPAS-compliant joint interest billing processes.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Cash application to JV partner receivables drives partner netting statements and cash call reconciliation. Required for accurate partner account balancing and dispute resolution in joint operations.',
    `payment_id` BIGINT COMMENT 'Reference to the incoming payment that is being applied to receivables. Links to the payment transaction that triggered this cash application event.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who processed the cash application. Used for audit trail and accountability in manual application scenarios.',
    `payment_term_id` BIGINT COMMENT 'Code representing the payment terms applicable to this cash application. Determines discount eligibility and due date calculations.',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Cash applications may apply to royalty owner payments for suspense clearing, requiring owner tracking for proper payment reconciliation and suspense account resolution.',
    `application_date` DATE COMMENT 'The date on which the payment was applied to the receivable item. Represents the business event date for revenue recognition and accounts receivable aging.',
    `application_method` STRING COMMENT 'Method by which the payment was applied to the receivable. Automatic indicates system-matched application, manual indicates user intervention, partial indicates split application, lockbox indicates bank lockbox processing, electronic indicates EDI or API-based application.. Valid values are `automatic|manual|partial|lockbox|electronic`',
    `application_number` STRING COMMENT 'Business-readable unique identifier for the cash application transaction. Used for tracking and reference in financial reporting and audit trails.',
    `application_status` STRING COMMENT 'Current status of the cash application. Matched indicates full application to invoice, partially matched indicates partial application, unmatched indicates payment received but not yet applied, on-account indicates payment held for future application, reversed indicates application has been reversed, pending indicates awaiting approval or processing.. Valid values are `matched|partially_matched|unmatched|on_account|reversed|pending`',
    `application_timestamp` TIMESTAMP COMMENT 'Precise date and time when the cash application was processed in the system. Used for audit trail and reconciliation purposes.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that was successfully applied to the receivable item. Represents the portion of the payment allocated to this specific invoice or receivable.',
    `approval_date` DATE COMMENT 'Date on which the cash application was approved, if approval workflow is required. Used for audit trail and process compliance monitoring.',
    `bank_statement_line_code` BIGINT COMMENT 'Reference to the specific line item on the bank statement from which this payment originated. Links cash application to bank reconciliation processes.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or operating segment to which this cash application belongs. Used for segment reporting and revenue allocation.',
    `clearing_document_number` STRING COMMENT 'SAP FI clearing document number generated when the payment is matched and cleared against the open receivable item. Used for financial reconciliation and audit.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the revenue or receivable being cleared. Used for internal cost allocation and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash application record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cash application amounts. Indicates the currency in which the payment was received and applied.. Valid values are `^[A-Z]{3}$`',
    `days_to_pay` STRING COMMENT 'Number of days between invoice date and payment application date. Used for customer payment behavior analysis and DSO calculations.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount amount granted to the customer as part of this cash application. Reflects payment terms incentives for prompt payment.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the payment or invoice is under dispute. True if there is an active dispute affecting this cash application, false otherwise.',
    `dispute_reason_code` STRING COMMENT 'Code indicating the reason for payment dispute if dispute flag is true. Used for dispute tracking and resolution workflow.',
    `due_date` DATE COMMENT 'Original due date of the invoice to which payment is being applied. Used to calculate days sales outstanding and aging analysis.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied when converting payment currency to functional currency. Used for multi-currency cash application and financial reporting.',
    `functional_currency_applied_amount` DECIMAL(18,2) COMMENT 'The applied amount converted to the company functional currency using the exchange rate. Used for consolidated financial reporting and analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the cash application is posted. Typically represents accounts receivable or cash clearing accounts.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the cash application. Used to document special circumstances, manual adjustments, or customer communications.',
    `overpayment_amount` DECIMAL(18,2) COMMENT 'The amount by which the payment exceeds the invoice total. Represents excess funds that may be refunded or held on-account for future invoices.',
    `profit_center_code` STRING COMMENT 'Profit center code for internal management reporting. Used to allocate revenue and cash collections to organizational profit centers.',
    `reversal_date` DATE COMMENT 'Date on which the cash application was reversed, if applicable. Null if the application has not been reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this cash application has been reversed. True if the application was subsequently reversed due to error or dispute, false otherwise.',
    `reversal_reason` STRING COMMENT 'Textual explanation for why the cash application was reversed. Provides audit trail for reversal decisions.',
    `royalty_payment_flag` BOOLEAN COMMENT 'Indicates whether this cash application relates to royalty payments for oil and gas production. True if the payment is for royalty obligations, false otherwise.',
    `short_payment_amount` DECIMAL(18,2) COMMENT 'The amount by which the payment falls short of the invoice total. Represents underpayment that may require follow-up or write-off.',
    `tolerance_amount` DECIMAL(18,2) COMMENT 'The amount of variance allowed between payment and invoice total for automatic matching. Small differences within tolerance are automatically cleared without manual intervention.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that remains unapplied and is held on-account. Represents funds received but not yet allocated to specific invoices.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash application record was last modified. Used for audit trail and change tracking.',
    `writeoff_amount` DECIMAL(18,2) COMMENT 'The amount written off as uncollectible or immaterial as part of this cash application. Used when short payments fall within write-off thresholds.',
    CONSTRAINT pk_cash_application PRIMARY KEY(`cash_application_id`)
) COMMENT 'Records the matching and allocation of incoming payments to open receivable items. Captures application date, payment reference, invoice reference, applied amount, unapplied amount, application method (automatic, manual, partial), short payment amount, overpayment amount, tolerance amount, clearing document number, bank statement line reference, and application status (matched, partially matched, unmatched, on-account). Supports automated cash application workflows integrated with SAP FI bank statement processing and lockbox operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`credit_note` (
    `credit_note_id` BIGINT COMMENT 'Unique identifier for the credit note record. Primary key.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or counterparty receiving the credit. Links to the customer master for account reconciliation and accounts receivable management.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Credit notes for facility downtime, processing quality issues, capacity shortfalls, or service level agreement breaches must reference the facility for root cause tracking and performance monitoring.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Credit notes adjust cargo nomination billing for BL shortfalls, quality claims, or demurrage disputes. Operational necessity for cargo-level billing corrections.',
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier of the joint venture partner if this credit note relates to joint interest billing (JIB) adjustments. Nullable for non-JV transactions.',
    `commercial_term_contract_id` BIGINT COMMENT 'Identifier of the underlying sales contract or term agreement governing the original transaction. Nullable for spot sales. Supports contractual compliance and price reopener tracking.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Credit notes issued by specific legal entities for revenue adjustments, financial reporting, and audit compliance in oil & gas operations.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to customer.complaint. Business justification: Credit notes issued for quality claims, volume disputes, or service failures must reference the originating customer complaint for audit trail, root cause tracking, and customer satisfaction measureme',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: JV credit notes must identify the partner receiving credit for accurate partner account reconciliation, netting statement adjustments, and dispute tracking. Essential for partner-specific credit manag',
    `dispute_id` BIGINT COMMENT 'Identifier of the formal dispute or claim case that triggered this credit note, if applicable. Nullable for non-dispute credits. Supports dispute resolution tracking and legal compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or manager who approved the credit note issuance. Supports SOX audit trails and segregation of duties compliance.',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice that this credit note adjusts or reverses. Links to the invoice product for traceability.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Credit notes for JV billing disputes must reference the governing JOA for proper allocation, dispute resolution per JOA terms, and audit compliance. Links credit adjustments to joint operating agreeme',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Credit notes for production revenue adjustments must reference lease for proper revenue reallocation to working interest and royalty owners per lease terms.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Credit notes adjust offtake agreement billing for measurement disputes, quality claims, or pricing corrections. Operational necessity for post-lifting billing adjustments.',
    `original_credit_note_id` BIGINT COMMENT 'Reference to the original credit note if this is a reissue or correction. Nullable for first-time issuances. Supports version tracking and audit trails.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Credit notes adjust billing for specific products due to quality deviations, volume disputes, or pricing corrections. Direct product reference required for quality claim validation and revenue adjustm',
    `quality_test_result_id` BIGINT COMMENT 'Foreign key linking to product.quality_test_result. Business justification: Credit notes cite specific lab test results as evidence for quality-based claims. Linking to test results provides audit trail for off-spec product credits, supports dispute resolution, and ensures SO',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Credit notes issued against sales orders for volume shortfalls, quality claims, or pricing adjustments. Direct operational link for order-level billing corrections.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Credit notes issued for billing corrections discovered during compliance audits or violation investigations. Links revenue adjustments to root cause compliance events for audit trail and SOX controls.',
    `accounting_period` STRING COMMENT 'Fiscal period (YYYY-MM format) in which the credit note is recognized for financial reporting purposes. Supports period-end close and revenue reconciliation.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `afe_number` STRING COMMENT 'AFE number associated with the joint venture project if this credit note relates to JIB adjustments. Nullable for non-JV transactions. Supports COPAS-compliant cost allocation.. Valid values are `^AFE-[0-9]{6,10}$`',
    `approval_status` STRING COMMENT 'Current workflow status of the credit note. Tracks progression through approval gates required by SOX controls and revenue policy.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the credit note was formally approved. Supports audit trail and compliance reporting.',
    `cost_center` STRING COMMENT 'Cost center or profit center to which the credit note is allocated for internal management reporting. Supports segment profitability analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the credit note record was first created in the system. Supports audit trail and data lineage tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the credit being issued, in the transaction currency. Represents the amount to be reversed or reduced from the customers accounts receivable balance.',
    `credit_date` DATE COMMENT 'Date on which the credit note was formally issued to the customer. Used for revenue recognition reversal timing and accounts receivable aging.',
    `credit_note_number` STRING COMMENT 'Externally-visible unique business identifier for the credit note, typically following a company-specific numbering convention (e.g., CN-20240001234). Used for customer communication and audit trails.. Valid values are `^CN-[0-9]{8,12}$`',
    `credit_reason_code` STRING COMMENT 'Standardized code indicating the business reason for issuing the credit note. Supports root-cause analysis and dispute resolution tracking.. Valid values are `quality_claim|volume_adjustment|price_correction|measurement_dispute|contractual_adjustment|billing_error`',
    `credit_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for the credit, including specific circumstances, claim details, or contractual clause references. Supports audit and customer communication.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, GBP). Supports multi-currency revenue operations.. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the credit note revenue reversal is posted. Supports financial reporting and chart of accounts compliance.. Valid values are `^[0-9]{4,10}$`',
    `measurement_dispute_flag` BOOLEAN COMMENT 'Indicates whether this credit note was issued due to a custody transfer measurement dispute (e.g., meter calibration error, tank gauging discrepancy). Supports measurement integrity audits.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the credit note record. Supports audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the credit note record was last updated. Supports change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, instructions, or context related to the credit note. Supports customer communication and internal documentation.',
    `payment_terms` STRING COMMENT 'Payment terms applicable to the credit note settlement (e.g., Net 30, Immediate, Applied to AR Balance). Supports cash application and accounts receivable management.',
    `posting_date` DATE COMMENT 'Date on which the credit note transaction was posted to the general ledger. May differ from credit_date due to period-end cutoffs or approval delays.',
    `price_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment due to price corrections, contractual price reopeners, or index adjustments. Nullable if credit is not price-related. Supports pricing dispute resolution.',
    `quality_claim_flag` BOOLEAN COMMENT 'Indicates whether this credit note was issued due to a product quality claim (e.g., off-spec crude, contamination, API gravity variance). Supports quality assurance tracking and supplier performance analysis.',
    `reissue_flag` BOOLEAN COMMENT 'Indicates whether this credit note is a reissue or correction of a previously issued credit note. Supports audit trail and version control.',
    `settlement_method` STRING COMMENT 'Method by which the credit will be settled with the customer (e.g., cash refund, accounts receivable credit, offset against future invoices, partner netting). Supports cash management and AR reconciliation.. Valid values are `cash_refund|ar_credit|offset_future_invoice|netting`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount being reversed or adjusted by this credit note (e.g., sales tax, VAT, excise duty). Supports tax compliance and reconciliation.',
    `tax_jurisdiction` STRING COMMENT 'Tax jurisdiction or authority under which the tax adjustment applies (e.g., US-Federal, UK-HMRC, TX-State). Supports multi-jurisdictional tax reporting.',
    `volume_adjustment_quantity` DECIMAL(18,2) COMMENT 'Physical quantity adjustment (in barrels, cubic feet, or metric tons) that triggered the credit note, if applicable. Nullable for non-volume-related credits. Supports measurement reconciliation and custody transfer audits.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume adjustment quantity. Common values: BBL (barrels), MCF (thousand cubic feet), MT (metric tons), GAL (gallons). Nullable if no volume adjustment applies.. Valid values are `BBL|MCF|MT|GAL|other`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created the credit note record. Supports audit trail and segregation of duties compliance.',
    CONSTRAINT pk_credit_note PRIMARY KEY(`credit_note_id`)
) COMMENT 'Formal credit document issued to customers to reverse or reduce previously billed amounts due to pricing adjustments, quality claims, volume disputes, measurement corrections, or contractual price reopeners. Captures credit note number, original invoice reference, credit reason code (quality claim, volume adjustment, price correction, measurement dispute, contractual adjustment), credit amount, date, approval status, approver, and reissuance flag. Supports COPAS-compliant billing adjustment procedures and IFRS 15 revenue reversal requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` (
    `revenue_allocation_id` BIGINT COMMENT 'Unique identifier for the revenue allocation record.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Revenue allocation to working interest owners requires partner identification for entitlement calculation, partner equity reporting, and distribution statements. Reuses existing owner_id for mineral o',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue allocations to cost centers for joint venture accounting, working interest tracking, and AFE cost recovery in oil & gas operations.',
    `division_order_id` BIGINT COMMENT 'Foreign key linking to land.division_order. Business justification: Revenue allocation follows division order decimal interests as the authoritative source for owner entitlement calculations - required for accurate revenue distribution and regulatory compliance.',
    `jib_statement_id` BIGINT COMMENT 'Identifier for the Joint Interest Billing statement that includes this revenue allocation, used for partner billing and reconciliation.',
    `joa_id` BIGINT COMMENT 'Identifier for the Joint Operating Agreement governing the revenue allocation and cost sharing among partners.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Revenue allocation must reference lease agreements to properly distribute revenue according to lease terms, working interest provisions, and royalty rates - core to production revenue accounting.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Revenue allocation distributes offtake agreement proceeds to JV partners based on working interest. Core PSA/JOA revenue distribution process for production sharing and joint operations.',
    `offtake_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.offtake_entitlement. Business justification: Revenue allocation calculates partner entitlements based on offtake agreements and working interest percentages. Direct link required for distributing production revenue according to contractual entit',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Revenue allocation distributes product-specific entitlements to JV partners and PSA participants. Core joint venture accounting requires linking allocated revenue to exact product grades with their pr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue allocations to profit centers for segment P&L reporting, field-level profitability analysis, and management reporting in oil & gas operations.',
    `property_id` BIGINT COMMENT 'Identifier for the oil and gas property or lease from which production revenue is generated.',
    `psa_id` BIGINT COMMENT 'Identifier for the Production Sharing Agreement governing cost recovery and profit oil splits with government or national oil company.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: PSA/JOA revenue allocation requires reservoir-level entitlement calculations for cost recovery, profit oil splits, and working interest distributions. Allocation runs reference reservoir OOIP/OGIP for',
    `royalty_owner_id` BIGINT COMMENT 'Identifier for the working interest owner, royalty owner, or partner receiving the allocated revenue.',
    `accounting_method` STRING COMMENT 'The accounting method applied for revenue recognition (successful efforts, full cost, or entitlement method for PSA arrangements).. Valid values are `successful_efforts|full_cost|entitlement`',
    `actual_lifted_volume` DECIMAL(18,2) COMMENT 'The actual volume of production physically lifted or taken by the partner during the allocation period.',
    `ad_valorem_tax_amount` DECIMAL(18,2) COMMENT 'The ad valorem (property) tax amount allocated to the owner based on their ownership interest and the assessed value of the property.',
    `allocated_revenue_amount` DECIMAL(18,2) COMMENT 'The revenue amount allocated to the specific owner based on their ownership interest and allocation method.',
    `allocation_method` STRING COMMENT 'The method used to allocate revenue among owners (volumetric based on production share, entitlement based on contractual rights, lifting based on actual offtake, net-back based on realized prices).. Valid values are `volumetric|entitlement|lifting|net_back|proportional`',
    `allocation_status` STRING COMMENT 'The current status of the revenue allocation record in the allocation workflow (draft, preliminary, final, adjusted, disputed, approved).. Valid values are `draft|preliminary|final|adjusted|disputed|approved`',
    `cost_recovery_amount` DECIMAL(18,2) COMMENT 'The amount of revenue allocated to cost recovery under a Production Sharing Agreement before profit oil is split between contractor and government.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the revenue amounts (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this allocation is under dispute by one or more partners (True = disputed, False = not disputed).',
    `dispute_reason` STRING COMMENT 'Description of the reason for the dispute if the allocation is flagged as disputed.',
    `entitlement_volume_uom` STRING COMMENT 'The unit of measure for the partner entitlement volume (BOE = Barrel of Oil Equivalent, BBL = Barrel, MCF = Thousand Cubic Feet, MMCF = Million Cubic Feet, MT = Metric Ton, GAL = Gallon).. Valid values are `BOE|BBL|MCF|MMCF|MT|GAL`',
    `government_take_amount` DECIMAL(18,2) COMMENT 'The total revenue amount allocated to the government or national oil company, including royalties, taxes, and profit oil share under PSA.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'The total gross revenue from production sales before allocation to individual owners, expressed in the functional currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue allocation record was last modified or updated.',
    `nri_percentage` DECIMAL(18,2) COMMENT 'The net revenue interest percentage held by the owner, representing their share of revenue after deducting royalties and overriding royalties from working interest.',
    `orri_percentage` DECIMAL(18,2) COMMENT 'The overriding royalty interest percentage carved out of the working interest, representing a share of revenue without bearing costs.',
    `overlift_underlift_value` DECIMAL(18,2) COMMENT 'The monetary value of the overlift or underlift position, calculated by multiplying the volume imbalance by the applicable product price.',
    `overlift_underlift_volume` DECIMAL(18,2) COMMENT 'The difference between actual lifted volume and entitlement volume, representing an overlift (positive) or underlift (negative) position that must be reconciled in future periods.',
    `owner_type` STRING COMMENT 'The type of ownership interest held by the owner receiving the allocation (e.g., working interest, royalty interest, overriding royalty interest).. Valid values are `working_interest|royalty_interest|overriding_royalty|net_profits_interest|production_payment|carried_interest`',
    `partner_entitlement_volume` DECIMAL(18,2) COMMENT 'The volume of production (in barrels of oil equivalent) that the partner is entitled to lift based on their ownership interest and allocation method.',
    `period_end_date` DATE COMMENT 'The end date of the allocation period, typically the last day of the production month.',
    `period_start_date` DATE COMMENT 'The start date of the allocation period, typically the first day of the production month.',
    `price_differential` DECIMAL(18,2) COMMENT 'The difference between the benchmark price (e.g., WTI, Brent) and the realized price, reflecting quality adjustments, location basis, and transportation costs.',
    `processing_deduction` DECIMAL(18,2) COMMENT 'The amount deducted from gross revenue to cover gas processing, treating, or conditioning costs.',
    `production_month` DATE COMMENT 'The calendar month for which production revenue is being allocated.',
    `profit_oil_percentage` DECIMAL(18,2) COMMENT 'The percentage of profit oil (revenue after cost recovery) allocated to the contractor under a Production Sharing Agreement.',
    `realized_price_per_unit` DECIMAL(18,2) COMMENT 'The actual price realized per unit of production after adjustments for quality, transportation, and market differentials.',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which the allocated revenue is recognized in the financial statements under IFRS 15 or ASC 606 revenue recognition standards.',
    `royalty_percentage` DECIMAL(18,2) COMMENT 'The royalty percentage applicable to the owner if they hold a royalty interest, representing their share of gross revenue without bearing costs.',
    `run_code` STRING COMMENT 'Identifier for the batch allocation run that generated this allocation record, used for audit trail and reprocessing.',
    `severance_tax_amount` DECIMAL(18,2) COMMENT 'The severance or production tax amount deducted from the allocated revenue, typically based on state or provincial regulations.',
    `transportation_deduction` DECIMAL(18,2) COMMENT 'The amount deducted from gross revenue to cover transportation costs from wellhead to point of sale.',
    `wi_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage held by the owner in the property, representing their share of costs and gross revenue before royalties.',
    CONSTRAINT pk_revenue_allocation PRIMARY KEY(`revenue_allocation_id`)
) COMMENT 'Records the allocation of gross production revenue to individual working interest owners, royalty owners, and cost recovery accounts under PSA and JOA structures. Captures allocation period, allocation method (volumetric, entitlement, lifting), gross revenue, allocated revenue by owner, WI percentage, NRI percentage, cost recovery amount (for PSA profit oil splits), profit oil percentage, government take, partner entitlement volume, overlift/underlift position, and allocation status. Supports IFRS/GAAP revenue recognition under successful-efforts and full-cost methods.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` (
    `tariff_charge_id` BIGINT COMMENT 'Unique identifier for the tariff charge record. Primary key for the tariff charge entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Tariff charges for pipeline, processing, and storage services are often capitalized to AFE budgets for new facilities or allocated to joint venture partners. Required for proper capital vs operating e',
    `asset_facility_id` BIGINT COMMENT 'Reference to the infrastructure facility (pipeline, terminal, FPSO, gas processing plant, LNG facility) for which the tariff charge is levied.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Tariff charges governed by transportation service agreements (TSAs) which are term contracts for pipeline/terminal services. Links midstream tariff billing to underlying service contract.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Tariff charges billed by specific legal entities for midstream revenue recognition, regulatory reporting, and financial compliance in oil & gas operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tariff charge calculations (pipeline, processing, storage) require creator tracking for regulatory compliance (FERC, state PUC filings) and dispute resolution. Audit trail for deficiency charges and m',
    `ferc_tariff_id` BIGINT COMMENT 'Foreign key linking to compliance.ferc_tariff. Business justification: Tariff charges must reference approved FERC tariff schedules for rate validation. Required for FERC-regulated pipeline billing compliance and rate case support. Replaces denormalized filing reference.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice document that includes this tariff charge. Links the charge to the billing and accounts receivable process.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Midstream tariff charges on JV-operated facilities must reference the governing JOA for cost allocation among partners per working interest. Required for accurate JIB statement preparation and partner',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or joint operating agreement under which the infrastructure is operated. Relevant for JIB allocation and partner billing.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Tariff charges for pipeline/gathering usage relate to lease production and require lease context for proper cost allocation to working interest owners.',
    `measurement_point_id` BIGINT COMMENT 'Reference to the custody transfer or measurement point where throughput volume was measured. Critical for volume allocation and audit trail.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tariff charges require valid pipeline operating permits. Links billed capacity to permitted capacity for regulatory validation and ensures charges dont exceed permitted throughput limits.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pipeline and facility tariffs vary by product type (crude vs refined vs gas) due to different handling requirements, viscosity, and hazard classifications. Product-specific tariff rates are standard i',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Tariff charges are assessed per pipeline segment for throughput billing, minimum volume commitment tracking, deficiency charges, and regulatory tariff filings required by FERC or state regulators.',
    `shipper_id` BIGINT COMMENT 'Reference to the party (shipper, producer, or third-party user) being charged for use of the transportation or processing infrastructure.',
    `tariff_agreement_id` BIGINT COMMENT 'Reference to the master tariff agreement that governs the terms and rates for this charge.',
    `adjustment_reference` STRING COMMENT 'Reference to any adjustment or credit note issued to correct this tariff charge. Links to subsequent billing adjustments or dispute resolutions.',
    `allocation_method` STRING COMMENT 'Method used to allocate throughput volume to this shipper when multiple parties share the infrastructure. Common methods include actual meter readings, proration, nomination-based, or scheduled allocation.. Valid values are `actual_meter|prorated|nominated|scheduled`',
    `base_charge_amount` DECIMAL(18,2) COMMENT 'Base transportation or processing charge calculated as throughput volume multiplied by tariff rate. Excludes additional charges such as fuel, shrinkage, or deficiency.',
    `charge_number` STRING COMMENT 'Business identifier for the tariff charge, typically used in invoicing and billing statements. Externally visible charge reference number.',
    `charge_period_end_date` DATE COMMENT 'End date of the period for which the tariff charge applies. Defines the conclusion of the service or throughput measurement window.',
    `charge_period_start_date` DATE COMMENT 'Start date of the period for which the tariff charge applies. Defines the beginning of the service or throughput measurement window.',
    `charge_status` STRING COMMENT 'Current lifecycle status of the tariff charge. Tracks progression from calculation through invoicing, payment, and any dispute resolution. [ENUM-REF-CANDIDATE: draft|calculated|invoiced|paid|disputed|adjusted|cancelled — 7 candidates stripped; promote to reference product]',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations, or special circumstances related to this tariff charge. Used for audit trail and billing clarification.',
    `compression_charge_amount` DECIMAL(18,2) COMMENT 'Charge for gas compression services required to maintain pipeline pressure and flow rates. Applicable to gas transportation tariffs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff charge record was first created in the system. Part of the audit trail for billing lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this tariff charge record.. Valid values are `USD|EUR|GBP|CAD|AUD|NOK`',
    `deficiency_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge levied when actual throughput volume falls below the minimum volume commitment. Calculated as the shortfall volume multiplied by the applicable deficiency rate.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this tariff charge is currently under dispute by the shipper. Triggers dispute resolution workflow and may delay payment.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if dispute_flag is True. Captures shipper objections to volume measurement, rate application, or charge calculation.',
    `facility_type` STRING COMMENT 'Classification of the infrastructure facility type. Determines applicable tariff structure and regulatory oversight.. Valid values are `pipeline|terminal|fpso|gas_processing_plant|lng_facility|storage_facility`',
    `fuel_gas_charge_amount` DECIMAL(18,2) COMMENT 'Charge for fuel gas consumed in the transportation or processing of natural gas. Typically calculated as a percentage of throughput volume or as a fixed rate.',
    `intercompany_flag` BOOLEAN COMMENT 'Indicates whether this tariff charge is for intercompany infrastructure cost recovery (True) or third-party billing (False). Affects accounting treatment and tax implications.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Contractually committed minimum throughput volume for the charge period. If actual volume falls below this threshold, deficiency charges may apply.',
    `modified_by` STRING COMMENT 'User identifier or system process that last modified this tariff charge record. Supports audit trail and accountability for billing adjustments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff charge record was last modified. Tracks changes to charge amounts, status, or other attributes during the billing lifecycle.',
    `payment_due_date` DATE COMMENT 'Date by which payment for this tariff charge is due. Determines late payment penalties and cash application timing.',
    `shrinkage_charge_amount` DECIMAL(18,2) COMMENT 'Charge for volume loss (shrinkage) during processing or transportation. Common in gas processing plants where NGLs are extracted.',
    `storage_charge_amount` DECIMAL(18,2) COMMENT 'Charge for temporary storage of product at the facility (e.g., tank farm, FPSO, LNG terminal). May be based on volume and duration.',
    `tariff_rate` DECIMAL(18,2) COMMENT 'Unit rate charged per volume of throughput. The rate applied to calculate the base transportation or processing charge.',
    `tariff_rate_basis` STRING COMMENT 'Unit basis for the tariff rate (e.g., per BBL, per MMBTU, per MT). Defines how the rate is applied to throughput volume. [ENUM-REF-CANDIDATE: per_bbl|per_mmbtu|per_mt|per_mcf|per_mmcf|per_gal|per_m3 — 7 candidates stripped; promote to reference product]',
    `throughput_volume` DECIMAL(18,2) COMMENT 'Actual volume of product transported or processed through the facility during the charge period. Basis for volume-based tariff calculations.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Total tariff charge amount including base charge and all additional charges (deficiency, fuel gas, shrinkage, compression, storage). This is the amount invoiced to the shipper.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the throughput volume. Common units include BBL (barrels), MMBTU (million British thermal units), MT (metric tons), MCF (thousand cubic feet), MMCF (million cubic feet). [ENUM-REF-CANDIDATE: BBL|MMBTU|MT|MCF|MMCF|GAL|M3 — 7 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'User identifier or system process that created this tariff charge record. Supports audit trail and accountability for billing operations.',
    CONSTRAINT pk_tariff_charge PRIMARY KEY(`tariff_charge_id`)
) COMMENT 'Charges levied for use of transportation and processing infrastructure including pipelines, terminals, FPSOs, gas processing plants, and LNG facilities. Captures charge number, period, tariff agreement reference, facility type, throughput volume, unit of measure, tariff rate and basis (per BBL, per MMBTU, per MT), minimum volume commitment, actual volume, deficiency charge, fuel gas charge, shrinkage charge, total amount, and regulatory tariff filing reference. Supports third-party access billing, FERC/PHMSA tariff compliance, and intercompany infrastructure cost recovery.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`dispute` (
    `dispute_id` BIGINT COMMENT 'Unique system-generated identifier for the billing dispute record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Revenue disputes over facility performance, measurement accuracy, processing quality, or service delivery require facility-level attribution for technical investigation and commercial resolution.',
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier of the customer, JIB partner, or royalty owner who raised the dispute. Links to the party master data.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Disputes tracked by legal entity for financial impact assessment, reserve calculations, and SOX control documentation in oil & gas operations.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Dispute resolution tracking requires identifying which JV partner raised the dispute for escalation routing, operating committee review, and partner-specific dispute history. Replaces denormalized dis',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Disputes are ABOUT invoices — this is a core business relationship. dispute currently has disputed_invoice_number (STRING business key) but no proper FK to invoice. Adding invoice_id (BIGINT) as FK to',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JV billing disputes must reference the specific JOA to apply correct dispute resolution procedures, voting thresholds, and arbitration provisions per the joint operating agreement.',
    `product_quality_test_id` BIGINT COMMENT 'Foreign key linking to refining.product_quality_test. Business justification: Revenue disputes over product quality (off-spec claims, price adjustments) reference specific quality test results as evidence. Quality test is supporting documentation for dispute resolution. Links c',
    `quality_test_result_id` BIGINT COMMENT 'Foreign key linking to product.quality_test_result. Business justification: Disputes reference lab test results as proof of quality deviation from contracted specifications. Direct link to test results enables evidence-based dispute resolution, supports arbitration processes,',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Disputes over assessed regulatory penalties (amount, applicability, allocation). Links penalty disputes to formal dispute resolution process for appeal tracking and settlement negotiation.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Revenue disputes often stem from compliance violations (measurement errors, quality issues, permit breaches). Links customer disputes to root cause compliance events for resolution and corrective acti',
    `aging_days` STRING COMMENT 'Number of calendar days the dispute has been open, calculated from dispute_date to current date (for open disputes) or to resolution_date (for resolved disputes). Used for aging analysis and SLA monitoring.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the underlying sales contract, offtake agreement, or JOA (Joint Operating Agreement) that governs the disputed transaction, if applicable.',
    `created_by_user` STRING COMMENT 'User ID or name of the system user who created the dispute record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the dispute record was first created in the database. Used for audit trail and data lineage.',
    `credit_note_issued_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether a credit note was issued to the disputing party as part of the dispute resolution. True if credit note was issued, False otherwise.',
    `credit_note_number` STRING COMMENT 'Reference number of the credit note issued to resolve the dispute, if applicable. Null if no credit note was issued.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'Date on which the dispute was formally raised or logged in the system by the customer, JIB partner, or royalty owner.',
    `dispute_description` STRING COMMENT 'Detailed narrative description of the dispute, including the nature of the disagreement, specific line items or charges challenged, and the basis for the dispute as stated by the disputing party.',
    `dispute_number` STRING COMMENT 'Business-facing unique dispute reference number assigned to the billing dispute for tracking and communication purposes. Used in correspondence with customers, JIB partners, and royalty owners.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute: open (newly raised), under_review (being investigated), pending_documentation (awaiting supporting evidence), escalated (elevated to management or legal), resolved (agreement reached), closed (finalized with no further action), or written_off (dispute amount written off as uncollectible). [ENUM-REF-CANDIDATE: open|under_review|pending_documentation|escalated|resolved|closed|written_off — 7 candidates stripped; promote to reference product]',
    `dispute_type` STRING COMMENT 'Classification of the dispute by nature of disagreement: volume (quantity discrepancies), price (pricing disagreements), quality (product specification issues), measurement (meter or gauge disputes), contractual (terms interpretation), royalty_deduction (royalty calculation challenges), allocation (production allocation disputes), tariff (transportation charge disputes), tax (tax treatment disputes), or other. [ENUM-REF-CANDIDATE: volume|price|quality|measurement|contractual|royalty_deduction|allocation|tariff|tax|other — 10 candidates stripped; promote to reference product]',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary value of the amount being disputed by the customer, JIB partner, or royalty owner. Represents the portion of the invoice or statement under challenge.',
    `disputed_line_item_number` STRING COMMENT 'Specific line item number or position on the invoice or JIB statement that is being disputed, if the dispute is limited to a particular line rather than the entire document.',
    `disputed_price` DECIMAL(18,2) COMMENT 'Unit price being disputed, if the dispute involves a pricing disagreement (e.g., price per barrel, price per MMBTU).',
    `disputed_product_code` STRING COMMENT 'Product or commodity code for the item being disputed (e.g., crude oil grade, refined product type, petrochemical SKU), if the dispute pertains to a specific product.',
    `disputed_volume` DECIMAL(18,2) COMMENT 'Quantity or volume being disputed, if the dispute involves a volume discrepancy (e.g., barrels of oil, cubic meters of gas, metric tons of product).',
    `escalation_date` DATE COMMENT 'Date on which the dispute was escalated to senior management, legal, or external arbitration due to inability to resolve at the operational level. Null if dispute was not escalated.',
    `escalation_reason` STRING COMMENT 'Explanation of why the dispute was escalated, including any unresolved issues, legal implications, or material financial impact requiring senior review.',
    `jib_statement_reference` STRING COMMENT 'Reference number of the JIB statement being disputed, if the dispute pertains to joint venture billing. Null if dispute is related to a standard invoice rather than JIB.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the system user who last modified the dispute record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the dispute record was last updated. Used for audit trail and change tracking.',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Final monetary amount agreed upon or adjusted as part of the dispute resolution. May differ from the originally disputed amount if a partial settlement or compromise was reached.',
    `resolution_date` DATE COMMENT 'Date on which the dispute was resolved, either through agreement, adjustment, or closure. Null if dispute is still open or under review.',
    `resolution_description` STRING COMMENT 'Detailed narrative of how the dispute was resolved, including any adjustments made, agreements reached, or reasons for closure or write-off.',
    `sap_dispute_case_number` STRING COMMENT 'SAP FI dispute management case reference number for integration and traceability with the ERP system dispute workflow.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this dispute is subject to SOX internal control testing and documentation requirements due to materiality or financial reporting impact. True if SOX-controlled, False otherwise.',
    `supporting_documentation_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation provided by the disputing party or gathered during investigation (e.g., contracts, delivery tickets, measurement reports, correspondence).',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the disputed volume: BBL (barrels), MMBTU (million British thermal units), MCF (thousand cubic feet), MT (metric tons), GAL (gallons), L (liters), M3 (cubic meters), KG (kilograms), LB (pounds). [ENUM-REF-CANDIDATE: BBL|MMBTU|MCF|MT|GAL|L|M3|KG|LB — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Formal records of billing disputes, invoice challenges, and payment disagreements raised by customers, JIB partners, or royalty owners. Captures dispute number, dispute date, disputed invoice or JIB statement reference, dispute type (volume, price, quality, measurement, contractual, royalty deduction), disputed amount, dispute description, supporting documentation reference, assigned resolver, resolution status (open, under review, resolved, escalated, written off), resolution date, resolution amount, credit note issued flag, and SAP FI dispute management case reference. Supports SOX-compliant dispute resolution workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`recognition_event` (
    `recognition_event_id` BIGINT COMMENT 'Primary key for recognition_event',
    `account_id` BIGINT COMMENT 'Reference to the customer or commercial counterparty to whom the product was sold.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Revenue recognition events for capital projects (new wells, facilities, infrastructure) must link to AFE budgets to ensure revenue is recognized in alignment with capital expenditure, support SEC repo',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the sales contract or commercial agreement under which this revenue is recognized.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Revenue recognition events for PSA cost recovery and profit oil must tie to regulatory submissions. Required for government audit trail and reconciliation of recognized revenue to reported entitlement',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Revenue recognition events require creator audit trail for SEC compliance (ASC 606), SOX controls, and external audits. Tracks who triggered recognition for performance obligations, especially for lon',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition events post to specific GL accounts per ASC 606, IFRS 15, and oil & gas accounting standards for financial reporting.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice associated with this revenue recognition event.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Revenue recognition for JV operations must tie to specific JOAs for partner-specific revenue allocation, working interest-based recognition, and SEC segment reporting by joint venture.',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or production sharing agreement under which this revenue is earned, if applicable.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Revenue recognition events for production sales must tie to lease agreements for proper revenue stream classification, working interest allocation, and SEC reporting.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Revenue recognition triggered by offtake agreement lifting/delivery (performance obligation satisfaction). IFRS 15 compliance for production sharing and equity crude sales.',
    `original_event_recognition_event_id` BIGINT COMMENT 'Reference to the original revenue recognition event ID if this record is a reversal or adjustment.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Revenue recognition under IFRS 15 requires tracking performance obligations tied to specific product delivery. Product characteristics (grade, quality specs) determine recognition timing and transacti',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA cost recovery ceilings and profit oil splits directly drive revenue recognition timing and amount. Required for contractor entitlement calculation and host government revenue allocation under prod',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Revenue recognition by partner share is required for JV partner equity reporting, SEC disclosure by partner, and partner-specific financial statement preparation. Links recognition events to partner e',
    `reserves_estimate_id` BIGINT COMMENT 'Foreign key linking to reservoir.reserves_estimate. Business justification: SEC revenue recognition rules require coupling with proved reserves bookings. Revenue recognition events must reference the reserves estimate that supports the transaction price allocation and perform',
    `reservoir_sec_reserves_disclosure_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir_sec_reserves_disclosure. Business justification: SEC SMOG (Standardized Measure of Oil and Gas) disclosures require coupling revenue recognition events with proved reserves disclosures. Links revenue transactions to the annual SEC reserves filing fo',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order that triggered this revenue recognition event.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Revenue recognition triggered by spot trade delivery/transfer of control. Required for IFRS 15 compliance to link performance obligation satisfaction to specific spot transactions.',
    `accounting_method` STRING COMMENT 'The oil and gas accounting method applied for this revenue recognition: successful-efforts or full-cost method.. Valid values are `successful_efforts|full_cost`',
    `accounting_period` STRING COMMENT 'The fiscal period (e.g., 2024-Q1, 2024-01) to which this revenue recognition event is posted, supporting period-close and financial reporting.',
    `business_unit` STRING COMMENT 'The business unit or operating segment responsible for this revenue (e.g., Upstream E&P, Downstream Refining, Petrochemicals).',
    `cost_center` STRING COMMENT 'The cost center to which this revenue is attributed for management accounting and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'The amount of revenue deferred to future periods because the performance obligation has not yet been fully satisfied.',
    `fi_document_number` STRING COMMENT 'SAP FI document number for the revenue recognition posting, providing traceability to the general ledger.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this revenue recognition event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition event record was last modified in the system.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The net revenue interest percentage after deducting royalties and overriding royalty interests, representing the companys share of revenue.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, explanations, or audit commentary for this revenue recognition event.',
    `performance_obligation_description` STRING COMMENT 'Detailed description of the performance obligation satisfied by this recognition event (e.g., crude oil delivery, refined product shipment, petrochemical sale).',
    `period_end_accrual_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event is part of a period-end accrual process for financial close and SOX compliance.',
    `posting_key` STRING COMMENT 'SAP posting key that controls the type of posting (debit/credit) and account assignment for this revenue recognition event.',
    `price_index_reference` STRING COMMENT 'Reference to the pricing index or benchmark used for this transaction (e.g., WTI, Brent, Henry Hub, NYMEX).',
    `profit_center` STRING COMMENT 'The profit center responsible for this revenue, used for segment reporting and performance evaluation.',
    `recognition_date` DATE COMMENT 'The date on which revenue is formally recognized in the general ledger, representing the satisfaction of the performance obligation.',
    `recognition_event_number` STRING COMMENT 'Business-facing unique identifier for the revenue recognition event, used for audit trails and external reporting.',
    `recognition_method` STRING COMMENT 'Method by which revenue is recognized: point-in-time (at delivery/title transfer) or over-time (as services are performed).. Valid values are `point_in_time|over_time`',
    `recognition_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the revenue recognition event was recorded in the system, supporting audit and SOX compliance.',
    `recognition_trigger` STRING COMMENT 'The specific business event that triggered revenue recognition (e.g., title transfer at loading terminal, custody transfer at pipeline meter, lifting from FPSO).. Valid values are `title_transfer|delivery|lifting|custody_transfer|shipment|service_completion`',
    `revenue_recognized_amount` DECIMAL(18,2) COMMENT 'The amount of revenue recognized in this event, posted to the income statement.',
    `revenue_stream_type` STRING COMMENT 'Classification of the revenue stream for financial reporting and analytics (e.g., upstream crude sales, downstream refined product sales, midstream tariff revenue). [ENUM-REF-CANDIDATE: crude_sales|gas_sales|ngl_sales|refined_product_sales|petrochemical_sales|service_revenue|royalty_revenue|other — 8 candidates stripped; promote to reference product]',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event is a reversal of a previously recognized amount due to adjustment or correction.',
    `royalty_amount` DECIMAL(18,2) COMMENT 'The amount of royalty payments deducted from gross revenue, payable to mineral rights owners or government entities.',
    `sec_reporting_category` STRING COMMENT 'SEC reporting category for this revenue, supporting 10-K and 10-Q financial statement disclosures.',
    `transaction_price_allocated` DECIMAL(18,2) COMMENT 'The portion of the total contract transaction price allocated to this specific performance obligation, per IFRS 15 allocation rules.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of volume for the product sold, used to calculate revenue recognized amount.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'Physical volume of product associated with this revenue recognition event.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume quantity (e.g., BBL for barrels, MMBTU for million British thermal units, MCF for thousand cubic feet). [ENUM-REF-CANDIDATE: BBL|MMBTU|MCF|GAL|MT|LB|other — 7 candidates stripped; promote to reference product]',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage owned by the company in the property or asset generating this revenue.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this revenue recognition event record in the system.',
    CONSTRAINT pk_recognition_event PRIMARY KEY(`recognition_event_id`)
) COMMENT 'Records the formal recognition of revenue in accordance with IFRS 15 / ASC 606 performance obligation satisfaction and SEC reporting requirements. Captures recognition event date, contract reference, performance obligation description, transaction price allocated, revenue recognized amount, deferred revenue amount, recognition method (point-in-time, over-time), recognition trigger (title transfer, delivery, lifting, custody transfer), product type, SAP FI revenue recognition posting reference, and period-end accrual flag. Supports successful-efforts and full-cost method accounting for E&P revenue and SOX period-close controls.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'Primary key for payment_term',
    `approved_by` STRING COMMENT 'User ID or name of the finance manager or controller who approved this payment term for use. Null if not yet approved or approval is not required.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term was approved for use. Null if not yet approved or approval is not required. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `baseline_date_rule` STRING COMMENT 'Rule determining the baseline date from which net due days and discount days are calculated. Invoice date is the date the invoice is issued; delivery date is the date product is delivered; bill of lading date is the date of shipment; month end calculates from the end of the invoice month; custom allows contract-specific baseline date logic.. Valid values are `invoice_date|delivery_date|bill_of_lading_date|month_end|custom`',
    `copas_compliant_flag` BOOLEAN COMMENT 'Indicates whether this payment term complies with COPAS (Council of Petroleum Accountants Societies) standard billing procedures for Joint Interest Billing (JIB) and petroleum accounting. True if COPAS-compliant; False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which payment is expected (e.g., USD for US Dollar, EUR for Euro, GBP for British Pound). Determines the currency for discount and interest calculations.. Valid values are `^[A-Z]{3}$`',
    `discount_days` STRING COMMENT 'Number of calendar days from invoice date within which payment must be received to qualify for the early payment discount (e.g., 10 in 2/10 Net 30 terms). Null if no early payment discount is offered.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered for early payment within the discount period (e.g., 2.00 for 2% discount in 2/10 Net 30 terms). Null if no early payment discount is offered.',
    `effective_end_date` DATE COMMENT 'Date after which this payment term is no longer available for use on new invoices. Null for open-ended terms. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date from which this payment term becomes effective and available for use on invoices. Format: yyyy-MM-dd.',
    `grace_period_days` STRING COMMENT 'Number of calendar days after the net due date during which late payment interest is not assessed, providing a buffer before penalties begin. Null if no grace period is granted.',
    `installment_count` STRING COMMENT 'Number of scheduled installment payments for installment-type payment terms. Null for non-installment terms.',
    `installment_frequency` STRING COMMENT 'Frequency of installment payments for installment-type payment terms (e.g., monthly, quarterly, semi-annual). Null for non-installment terms.. Valid values are `monthly|quarterly|semi_annual|custom`',
    `jib_standard_term_flag` BOOLEAN COMMENT 'Indicates whether this payment term is a standard term used for JIB (Joint Interest Billing) statements under Joint Operating Agreements (JOA). True if this is a JIB standard term; False otherwise.',
    `late_payment_interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate (percentage) applied to overdue balances after the net due date has passed. Expressed as annual percentage rate (APR). Null if no late payment penalty is assessed.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this payment term record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `net_due_days` STRING COMMENT 'Number of calendar days from invoice date by which full payment is due without penalty (e.g., 30 for Net 30, 45 for Net 45, 60 for Net 60). Used to calculate invoice due date.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or business context related to this payment term (e.g., negotiated terms for specific customers, regional variations, contract references).',
    `payment_term_status` STRING COMMENT 'Current lifecycle status of the payment term. Active terms are available for use on new invoices; inactive terms are no longer available but remain for historical reference; deprecated terms are being phased out; pending approval terms are awaiting finance approval before activation.. Valid values are `active|inactive|deprecated|pending_approval`',
    `product_category` STRING COMMENT 'Product category to which this payment term applies. Crude oil sales, natural gas sales, LNG (Liquefied Natural Gas) sales, NGL (Natural Gas Liquids) sales, LPG (Liquefied Petroleum Gas) sales, refined product sales (gasoline, diesel, jet fuel), petrochemical sales, service revenues, JIB (Joint Interest Billing) statements, or all categories. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|ngl|lpg|refined_product|petrochemical|service|jib|all — 10 candidates stripped; promote to reference product]',
    `revenue_recognition_impact` STRING COMMENT 'Describes how this payment term affects revenue recognition timing under IFRS 15 / ASC 606. None indicates no impact on recognition timing; deferred indicates revenue recognition is delayed until payment milestones; accelerated indicates early recognition based on payment terms; variable consideration indicates the payment term introduces variable consideration requiring constraint assessment.. Valid values are `none|deferred|accelerated|variable_consideration`',
    `sap_fi_payment_term_key` STRING COMMENT 'Four-character SAP Financial Accounting (FI) module payment term key used for integration with SAP S/4HANA accounts receivable and invoicing processes. Maps this payment term to the corresponding SAP master data record.. Valid values are `^[A-Z0-9]{4}$`',
    `term_code` STRING COMMENT 'Short alphanumeric code identifying the payment term (e.g., NET30, NET45, NET60, 2_10_NET30). Used as the business key for lookup and integration with SAP FI payment term master.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `term_description` STRING COMMENT 'Detailed explanation of the payment term conditions, including any special instructions or business rules applicable to crude oil sales, LNG sales, refined product sales, or petrochemical revenues.',
    `term_name` STRING COMMENT 'Full descriptive name of the payment term (e.g., Net 30 Days, 2% 10 Net 30, Net 45 Days End of Month).',
    `term_type` STRING COMMENT 'Classification of the payment term structure. Standard terms are simple net-due arrangements; early payment discount terms offer a percentage reduction for payment within a discount period; installment terms allow multiple scheduled payments; prepayment requires payment before delivery; consignment defers payment until product is sold; letter of credit terms require bank-backed payment guarantee.. Valid values are `standard|early_payment_discount|installment|prepayment|consignment|letter_of_credit`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this payment term record in the system.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Master reference for contractual payment terms governing invoice due dates, early payment discounts, and late payment penalties for petroleum product sales. Captures payment term code, description, net days (e.g., Net 30, Net 45, Net 60), discount percentage for early payment, discount days, late payment interest rate, grace period days, applicable product category (crude oil, LNG, refined product, petrochemical), currency, and SAP FI payment term key. Supports COPAS-standard payment terms for JIB billing and commercial terms for crude oil and LNG sales contracts.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`customer_credit` (
    `customer_credit_id` BIGINT COMMENT 'Unique identifier for the customer credit record. Primary key for the customer credit entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer or Joint Interest Billing (JIB) partner for whom this credit limit is established. Links to the customer master record in SAP FI/SD.',
    `commercial_counterparty_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_counterparty. Business justification: Customer credit limits track counterparty creditworthiness for commercial transactions. Core credit risk management linking AR credit exposure to trading counterparty master data.',
    `available_credit_amount` DECIMAL(18,2) COMMENT 'Remaining credit capacity calculated as credit limit minus credit exposure. Determines whether new orders can be accepted without credit hold.',
    `collateral_amount` DECIMAL(18,2) COMMENT 'Face value of the collateral instrument in the credit account currency. Reduces net credit exposure for risk assessment purposes.',
    `collateral_expiry_date` DATE COMMENT 'Date when the collateral instrument expires or must be renewed. Triggers proactive renewal workflows to maintain credit coverage.',
    `collateral_type` STRING COMMENT 'Type of collateral or credit enhancement instrument securing the credit exposure. Common in Joint Operating Agreement (JOA) and Production Sharing Agreement (PSA) contexts.. Valid values are `letter_of_credit|parent_guarantee|cash_deposit|surety_bond|standby_lc|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this customer credit record was first created in the system. Part of the audit trail for SOX compliance.',
    `credit_account_number` STRING COMMENT 'External business identifier for the credit account. Used in customer communications and credit review documentation.',
    `credit_exposure_amount` DECIMAL(18,2) COMMENT 'Current total credit exposure calculated as outstanding Accounts Receivable (AR) plus open sales orders. Updated in real-time from SAP FI/SD to support credit hold decisions.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the customer account is currently on credit hold. When true, new sales orders are blocked pending credit resolution. Enforced in SAP SD order processing.',
    `credit_hold_reason` STRING COMMENT 'Business reason for placing the customer on credit hold. Supports root cause analysis and dispute resolution workflows.. Valid values are `credit_limit_exceeded|payment_overdue|credit_rating_downgrade|bankruptcy_filing|dispute_unresolved|manual_hold`',
    `credit_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum amount covered by the trade credit insurance policy for this customer. May be less than the total credit limit.',
    `credit_insurance_flag` BOOLEAN COMMENT 'Indicates whether this customer credit exposure is covered by trade credit insurance. Reduces net credit risk for insured accounts.',
    `credit_insurance_policy_number` STRING COMMENT 'Policy number of the trade credit insurance covering this customer. Used for claims filing in case of customer default.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure authorized for this customer. Represents the ceiling for outstanding Accounts Receivable (AR) plus open sales orders. Used in SOX-compliant credit approval workflows.',
    `credit_limit_effective_date` DATE COMMENT 'Date when the current credit limit became effective. Supports historical credit limit tracking and audit trail requirements.',
    `credit_limit_expiry_date` DATE COMMENT 'Date when the current credit limit expires and must be reviewed or renewed. Null for indefinite credit limits.',
    `credit_notes` STRING COMMENT 'Free-text notes and comments from credit analysts regarding special credit considerations, payment history observations, or risk mitigation actions.',
    `credit_rating_agency` STRING COMMENT 'Name of the external credit rating agency that provided the external credit rating (e.g., Dun & Bradstreet, Moodys, Standard & Poors, Fitch).',
    `credit_status` STRING COMMENT 'Current lifecycle status of the credit account. Active accounts are eligible for new transactions; suspended or closed accounts require credit manager approval.. Valid values are `active|suspended|under_review|closed|defaulted`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit limit amount (e.g., USD, EUR, GBP). Aligns with SAP FI currency configuration.. Valid values are `^[A-Z]{3}$`',
    `days_sales_outstanding` STRING COMMENT 'Average number of days this customer takes to pay invoices. Key performance indicator for credit risk assessment and working capital management.',
    `external_credit_rating` STRING COMMENT 'Credit rating assigned by external credit rating agency (e.g., Dun & Bradstreet, Moodys, S&P). Provides independent third-party creditworthiness assessment.',
    `internal_credit_rating` STRING COMMENT 'Internal creditworthiness assessment assigned by the credit analyst. Scale ranges from AAA (highest quality) to D (default). Used for IFRS 9 expected credit loss provisioning. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `jib_partner_flag` BOOLEAN COMMENT 'Indicates whether this credit account is for a Joint Interest Billing (JIB) partner under a Joint Operating Agreement (JOA). JIB partners have specialized credit terms per COPAS standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this customer credit record was last updated. Tracks the recency of credit information for risk assessment purposes.',
    `past_due_amount` DECIMAL(18,2) COMMENT 'Total amount of invoices currently past their due date. Triggers credit hold and collection escalation workflows when thresholds are exceeded.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code assigned to this customer (e.g., NET30, NET60, 2/10NET30). Determines invoice due dates and early payment discount eligibility. Aligns with SAP FI payment terms master data.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Working Interest (WI) percentage held by this JIB partner in the joint venture. Used to calculate proportional billing amounts and credit exposure allocation.',
    CONSTRAINT pk_customer_credit PRIMARY KEY(`customer_credit_id`)
) COMMENT 'Credit limit and creditworthiness management records for customers and JIB partners to control exposure risk in petroleum product sales. Captures credit account reference, customer reference, credit limit amount, currency, credit exposure (outstanding AR + open orders), available credit, credit rating (internal), external credit rating agency, credit rating date, credit review date, credit hold flag, credit hold reason, collateral type (letter of credit, parent guarantee, cash deposit), collateral amount, collateral expiry date, and credit analyst. Supports SOX-compliant credit approval workflows and IFRS 9 expected credit loss assessment.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` (
    `deferred_revenue_id` BIGINT COMMENT 'Unique identifier for the deferred revenue record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer or joint venture partner who made the advance payment or is subject to the take-or-pay arrangement.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Deferred revenue from take-or-pay contracts, prepaid processing fees, or capacity reservations must track to specific facilities for performance obligation fulfillment and ASC 606 revenue recognition.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the underlying contract or agreement that governs the revenue recognition terms. May reference a PSA, JOA, or term contract.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Deferred revenue from take-or-pay, prepayments, or PSA cost pools reported in regulatory filings. Required for PSA quarterly reporting and government financial statement reconciliation.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Deferred revenue by JV partner is needed for partner equity reporting, partner-specific balance sheet preparation, and working interest-based revenue recognition schedules. Supports partner financial ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deferred revenue posted to specific GL accounts for balance sheet reporting, revenue recognition schedules, and financial compliance in oil & gas.',
    `invoice_id` BIGINT COMMENT 'Reference to the originating invoice that generated the deferred revenue. Links to the invoice master record in SAP FI.',
    `jib_statement_id` BIGINT COMMENT 'Reference to the JIB statement if the deferred revenue relates to joint venture billing under COPAS standards. Links to joint interest billing records.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Deferred revenue from take-or-pay obligations or prepayments needs lease context for performance obligation tracking and proper revenue recognition timing per lease terms.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Deferred revenue tracks product-specific prepayments and performance obligations under IFRS 15. Revenue recognition schedules depend on product delivery milestones and quality acceptance, requiring di',
    `recognition_schedule_id` BIGINT COMMENT 'Reference to the detailed revenue recognition schedule that defines the timing and amounts of periodic revenue recognition entries for this deferred revenue.',
    `accounting_period` STRING COMMENT 'The accounting period (e.g., 2024-01, 2024-Q1) in which the deferred revenue entry was created or last modified. Used for period-end close and financial reporting.',
    `business_unit` STRING COMMENT 'Business unit or operating segment responsible for the deferred revenue. May represent upstream E&P, downstream refining, or petrochemical divisions.',
    `cost_center` STRING COMMENT 'SAP CO cost center associated with the deferred revenue, used for internal management reporting and profitability analysis.',
    `created_by_user` STRING COMMENT 'The user ID or name of the person who created the deferred revenue record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the deferred revenue record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deferred revenue amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deferral_date` DATE COMMENT 'The date on which the revenue was initially deferred. Typically the invoice date or payment receipt date when the performance obligation was identified as unsatisfied.',
    `deferral_reason_code` STRING COMMENT 'Categorical code indicating the business reason for deferring revenue recognition. Aligns with IFRS 15 / ASC 606 performance obligation criteria.. Valid values are `advance_payment|take_or_pay|bill_and_hold|minimum_volume_shortfall|performance_obligation_unsatisfied|contract_modification`',
    `deferral_reason_description` STRING COMMENT 'Detailed narrative explanation of why revenue recognition was deferred, including specific contractual terms or performance obligations that remain unsatisfied.',
    `deferral_reference_number` STRING COMMENT 'Business-readable unique reference number for the deferred revenue entry, used for tracking and reconciliation purposes.',
    `deferral_status` STRING COMMENT 'Current lifecycle status of the deferred revenue entry. Tracks whether the revenue is still deferred, partially recognized, fully recognized, or reversed.. Valid values are `open|partially_recognized|fully_recognized|reversed|cancelled`',
    `expected_recognition_end_date` DATE COMMENT 'The anticipated date when all deferred revenue is expected to be fully recognized, based on the contract term or performance obligation completion schedule.',
    `expected_recognition_start_date` DATE COMMENT 'The anticipated date when revenue recognition is expected to begin based on the contractual terms or performance obligation schedule.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the deferred revenue entry was created. Used for annual financial reporting and multi-year trend analysis.',
    `last_modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified the deferred revenue record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the deferred revenue record was last updated. Used for audit trail and change tracking.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The net revenue interest percentage after deducting royalties and overriding royalty interests. Used for accurate revenue allocation in joint venture scenarios.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or special instructions related to the deferred revenue entry. Used by accounting staff for documentation purposes.',
    `original_deferred_amount` DECIMAL(18,2) COMMENT 'The total revenue amount initially deferred at the time of invoice or payment receipt. Represents the full performance obligation value that was not immediately recognizable.',
    `performance_obligation_description` STRING COMMENT 'Detailed description of the unsatisfied performance obligation(s) that caused the revenue deferral. May include delivery commitments, service obligations, or contractual milestones.',
    `profit_center` STRING COMMENT 'SAP CO profit center associated with the deferred revenue, used for segment reporting and internal performance measurement.',
    `recognition_method` STRING COMMENT 'The revenue recognition method applied to this deferred revenue entry, as prescribed by IFRS 15 / ASC 606. Indicates whether revenue is recognized at a point in time or over time, and the specific pattern used.. Valid values are `point_in_time|over_time_straight_line|over_time_output_method|over_time_input_method|milestone_based`',
    `recognized_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative revenue amount that has been recognized to date from the original deferred balance. Updated as performance obligations are satisfied over time.',
    `remaining_deferred_balance` DECIMAL(18,2) COMMENT 'Current outstanding deferred revenue balance that has not yet been recognized. Calculated as original deferred amount minus recognized to date amount.',
    `reversal_date` DATE COMMENT 'The date on which the deferred revenue entry was reversed, if applicable. Used when a contract is cancelled or modified and the deferral is no longer valid.',
    `reversal_reason` STRING COMMENT 'Explanation for why the deferred revenue entry was reversed, such as contract cancellation, customer refund, or contract modification.',
    `sec_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this deferred revenue entry is material and must be disclosed in SEC financial reporting filings (10-K, 10-Q).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this deferred revenue entry is subject to SOX internal control testing and audit procedures. True if the entry is material and requires enhanced controls.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage applicable to this deferred revenue entry if it relates to joint venture operations. Represents the ownership share in the revenue stream.',
    CONSTRAINT pk_deferred_revenue PRIMARY KEY(`deferred_revenue_id`)
) COMMENT 'Tracks revenue amounts received or billed but not yet recognized under IFRS 15 / ASC 606 due to unsatisfied performance obligations, take-or-pay arrangements, or advance payments. Captures deferred revenue balance, originating invoice or contract reference, customer, product type, deferral reason (advance payment, take-or-pay, bill-and-hold, minimum volume shortfall), deferred amount, recognition schedule, expected recognition date, recognized-to-date amount, remaining deferred balance, and SAP FI deferred revenue account. Supports period-end close and SEC revenue disclosure requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` (
    `intercompany_billing_id` BIGINT COMMENT 'Unique identifier for the intercompany billing transaction record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Intercompany transactions require employee accountability for transfer pricing documentation, BEPS compliance, and tax authority audits. Creator tracking supports arms-length pricing defense and withh',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Intercompany charges between JV entities must reference the governing JOA for proper cost allocation, transfer pricing validation, and elimination in consolidated JV financial statements.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Transfer pricing documentation requires product-specific details for tax compliance and BEPS reporting. Intercompany transactions must reference product master data for arms-length pricing validation ',
    `company_code_id` BIGINT COMMENT 'Identifier of the affiliated legal entity issuing the intercompany invoice or charge.',
    `receiving_entity_company_code_id` BIGINT COMMENT 'Identifier of the affiliated legal entity receiving the intercompany invoice or charge.',
    `payment_term_id` BIGINT COMMENT 'Payment terms for the intercompany billing transaction (e.g., Net 30, Net 60, Due on Receipt).',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Intercompany transactions subject to SOX transfer pricing controls. Links intercompany billing to specific SOX control tests for arms-length pricing validation and BEPS compliance.',
    `arms_length_price_reference` STRING COMMENT 'Reference to the market benchmark or comparable transaction used to establish the arms-length price for transfer pricing compliance (e.g., WTI index, Brent crude, published tariff schedule).',
    `beps_country_code` STRING COMMENT 'ISO two-letter country code for OECD BEPS country-by-country reporting requirements, identifying the jurisdiction of the transaction.. Valid values are `^[A-Z]{2}$`',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this intercompany billing transaction.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this intercompany billing transaction.',
    `business_area` STRING COMMENT 'Business area code representing the operational segment (e.g., upstream, downstream, midstream) for financial reporting and analysis.. Valid values are `^[A-Z0-9]{2,6}$`',
    `cost_center` STRING COMMENT 'Cost center code associated with the intercompany billing transaction for internal cost allocation and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany billing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'Externally-known unique document number for the intercompany billing transaction, used for reference and reconciliation across affiliated entities.. Valid values are `^[A-Z0-9]{8,20}$`',
    `due_date` DATE COMMENT 'Date by which payment is due from the receiving entity to the billing entity.',
    `elimination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this intercompany transaction should be eliminated in consolidated financial statements (True = eliminate, False = retain).',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the intercompany billing transaction is posted in the financial system.. Valid values are `^[0-9]{4,10}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of the intercompany billing transaction before any adjustments, taxes, or withholdings.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified the intercompany billing record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany billing record was last modified or updated.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount payable after deducting withholding tax and any other adjustments from the gross amount.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, explanations, or special instructions related to the intercompany billing transaction.',
    `payment_date` DATE COMMENT 'Actual date when payment was received or processed for the intercompany billing transaction.',
    `payment_status` STRING COMMENT 'Current payment status of the intercompany billing transaction: pending (awaiting payment), paid (payment received), overdue (past due date), disputed (under dispute resolution), cancelled (transaction voided).. Valid values are `pending|paid|overdue|disputed|cancelled`',
    `posting_date` DATE COMMENT 'Date when the intercompany billing transaction was posted to the general ledger in the financial system.',
    `profit_center` STRING COMMENT 'Profit center code associated with the intercompany billing transaction for segment reporting and profitability analysis.. Valid values are `^[A-Z0-9]{4,12}$`',
    `reference_document_number` STRING COMMENT 'Reference to the original source document (e.g., sales order, delivery note, service agreement) that triggered the intercompany billing transaction.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this transaction is a reversal or correction of a previous intercompany billing entry (True = reversal, False = original transaction).',
    `reversed_document_number` STRING COMMENT 'Document number of the original intercompany billing transaction that is being reversed by this entry, if applicable.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this intercompany billing transaction is subject to SOX internal control testing and audit requirements (True = subject to SOX controls, False = not subject).',
    `tax_jurisdiction` STRING COMMENT 'ISO country or jurisdiction code where the transaction is subject to taxation and withholding requirements.. Valid values are `^[A-Z]{2,3}$`',
    `transaction_date` DATE COMMENT 'Date when the intercompany transaction occurred or was recognized for accounting purposes.',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction: crude transfer (crude oil movement between entities), product exchange (refined product swap), pipeline tariff (infrastructure usage charge), processing_fee (refining or processing service), management_fee (corporate overhead allocation), or shared_service (shared support function charge).. Valid values are `crude_transfer|product_exchange|pipeline_tariff|processing_fee|management_fee|shared_service`',
    `transfer_pricing_method` STRING COMMENT 'OECD-compliant transfer pricing method applied: CUP (Comparable Uncontrolled Price), RPM (Resale Price Method), CPM (Cost Plus Method), TNMM (Transactional Net Margin Method), PSM (Profit Split Method).. Valid values are `CUP|RPM|CPM|TNMM|PSM`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of volume for the intercompany transaction, expressed in the transaction currency.',
    `volume` DECIMAL(18,2) COMMENT 'Quantity of crude oil, refined product, or natural gas transferred or exchanged in the intercompany transaction.',
    `volume_uom` STRING COMMENT 'Unit of measure for the transaction volume: BBL (barrels for crude oil), MMBTU (million British thermal units for gas), MCF (thousand cubic feet for gas), MT (metric tons), GAL (gallons for refined products).. Valid values are `BBL|MMBTU|MCF|MT|GAL`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Total withholding tax amount deducted from the gross billing amount, expressed in the transaction currency.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Applicable withholding tax rate as a decimal (e.g., 0.1500 for 15%) applied to the intercompany transaction per tax treaty or local regulation.',
    `created_by` STRING COMMENT 'User identifier or system account that created the intercompany billing record.',
    CONSTRAINT pk_intercompany_billing PRIMARY KEY(`intercompany_billing_id`)
) COMMENT 'Intercompany billing transactions between affiliated entities within the corporate group for crude oil transfers, product exchanges, infrastructure usage, and shared services. Captures document number, billing entity, receiving entity, transaction type (crude transfer, product exchange, pipeline tariff, processing fee, management fee), billing period, volume, unit price, total amount, transfer pricing method, arms-length price reference, tax jurisdiction, withholding tax rate, withholding tax amount, and net amount. Supports OECD transfer pricing compliance, BEPS country-by-country reporting, and intercompany elimination controls.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` (
    `take_or_pay_id` BIGINT COMMENT 'Unique identifier for the take-or-pay obligation record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Take-or-pay obligations for processing or transportation capacity are contracted at the facility level for capacity reservation tracking, deficiency billing, and makeup rights administration.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the buyer or offtaker party obligated to take or pay for the minimum contracted volume.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the parent gas sales agreement, LNG SPA (Sales and Purchase Agreement), or pipeline capacity contract under which this take-or-pay obligation exists.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Take-or-pay obligations disclosed in PSA regulatory filings and FERC gas contract filings. Required for government contract compliance reporting and regulatory transparency of minimum volume commitmen',
    `customer_volume_commitment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_volume_commitment. Business justification: Take-or-pay obligations in revenue domain enforce volume commitments tracked in customer domain. Direct link required for calculating shortfall volumes, invoicing deficiency charges, tracking makeup r',
    `delivery_point_id` BIGINT COMMENT 'FK to customer.delivery_point',
    `invoice_id` BIGINT COMMENT 'Foreign key reference to the invoice record in the invoicing system for the take-or-pay shortfall billing.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Take-or-pay provisions commonly embedded in offtake agreements (gas sales, LNG contracts). Direct contractual link for minimum volume commitment tracking and deficiency payment calculation.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Take-or-pay obligations in gas and LNG contracts specify exact product grades and quality specifications. Contractual enforcement and revenue recognition require linking TOP obligations to product mas',
    `actual_taken_volume` DECIMAL(18,2) COMMENT 'The actual volume taken (offtaken) by the buyer during the obligation period, expressed in the unit of measure specified.',
    `carryforward_balance_amount` DECIMAL(18,2) COMMENT 'The monetary value of the carry-forward balance volume, representing deferred revenue liability until make-up is utilized or entitlement expires.',
    `carryforward_balance_volume` DECIMAL(18,2) COMMENT 'The remaining make-up volume entitlement that has not yet been utilized and is carried forward to future periods (makeup_volume_entitlement - makeup_volume_utilized).',
    `contract_price_per_unit` DECIMAL(18,2) COMMENT 'The contractual price per unit of volume applicable to the take-or-pay obligation for this period. Used to calculate shortfall payment amount.',
    `contract_reference_number` STRING COMMENT 'External business identifier for the contract (e.g., contract number, SPA reference code) under which the take-or-pay obligation is defined.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this take-or-pay obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this record (contract price, shortfall amount, make-up credit). [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AUD|CAD|CHF|SGD|AED — 10 candidates stripped; promote to reference product]',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'The portion of the shortfall payment that is deferred as a liability on the balance sheet, representing the obligation to deliver make-up volume or refund if not utilized.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the take-or-pay obligation or shortfall amount is currently under dispute by the counterparty. True if disputed, False otherwise.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for dispute, if dispute_flag is True. Captures counterparty objections to volume measurement, pricing, or contract interpretation.',
    `force_majeure_flag` BOOLEAN COMMENT 'Indicates whether a force majeure event was declared by either party during the obligation period, potentially excusing non-performance of take-or-pay obligations. True if force majeure applies, False otherwise.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person or system process that last modified this record, supporting audit trail and SOX compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this take-or-pay obligation record was last updated, capturing any changes to volumes, amounts, status, or make-up utilization.',
    `makeup_period_end_date` DATE COMMENT 'End date of the make-up period. After this date, unused make-up entitlements typically expire and shortfall payments become final revenue.',
    `makeup_period_start_date` DATE COMMENT 'Start date of the period during which the buyer may take additional volume to make up for previously paid shortfalls, if contract allows make-up rights.',
    `makeup_volume_entitlement` DECIMAL(18,2) COMMENT 'The cumulative volume the buyer is entitled to take in future periods as make-up for this shortfall, if contract permits make-up rights. Typically equals shortfall_volume.',
    `makeup_volume_utilized` DECIMAL(18,2) COMMENT 'The volume that has been taken by the buyer under make-up rights for this specific shortfall obligation, reducing the carry-forward balance.',
    `measurement_method` STRING COMMENT 'Method used to determine actual taken volume. Values: meter (custody transfer meter reading), allocation (pro-rata allocation from production), nomination (buyer nomination accepted as actual), actual_lifting (physical cargo lifting for LNG).. Valid values are `meter|allocation|nomination|actual_lifting`',
    `minimum_contracted_volume` DECIMAL(18,2) COMMENT 'The minimum volume the buyer is obligated to take (or pay for if not taken) during the obligation period, expressed in the unit of measure specified.',
    `obligation_period_end_date` DATE COMMENT 'End date of the measurement period for this take-or-pay obligation.',
    `obligation_period_start_date` DATE COMMENT 'Start date of the measurement period for this take-or-pay obligation (typically monthly, quarterly, or annual).',
    `obligation_status` STRING COMMENT 'Current status of the take-or-pay obligation. Values: in_compliance (buyer met minimum volume), shortfall (buyer did not meet minimum, payment due), makeup_active (shortfall paid, make-up period open), makeup_expired (make-up period closed, revenue recognized), disputed (shortfall amount under dispute), waived (obligation waived by seller).. Valid values are `in_compliance|shortfall|makeup_active|makeup_expired|disputed|waived`',
    `payment_due_date` DATE COMMENT 'Contractual due date for the counterparty to remit the shortfall payment, per the terms of the gas sales agreement or SPA.',
    `payment_received_date` DATE COMMENT 'Date on which the shortfall payment was received from the counterparty, triggering cash application and revenue recognition assessment.',
    `revenue_recognition_status` STRING COMMENT 'Status of revenue recognition for the shortfall payment under IFRS 15. Values: deferred (payment received but revenue deferred due to make-up rights), recognized (revenue fully recognized), partially_recognized (some make-up utilized, partial recognition), reversed (revenue reversed due to dispute or contract modification).. Valid values are `deferred|recognized|partially_recognized|reversed`',
    `revenue_recognized_amount` DECIMAL(18,2) COMMENT 'The portion of the shortfall amount that has been recognized as revenue in the financial statements, net of any deferred revenue for outstanding make-up entitlements.',
    `shortfall_amount` DECIMAL(18,2) COMMENT 'The monetary amount the buyer must pay for the shortfall volume (shortfall_volume * contract_price_per_unit), representing the take-or-pay penalty or deficiency payment.',
    `shortfall_volume` DECIMAL(18,2) COMMENT 'The difference between minimum contracted volume and actual taken volume (minimum_contracted_volume - actual_taken_volume). Positive value indicates a shortfall; zero or negative indicates full compliance.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this take-or-pay obligation data originated (e.g., SAP FI/SD, SAP Joint Venture Accounting, Quorum Land System, custom contract management system).',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this take-or-pay obligation record is subject to SOX internal controls for revenue recognition and financial reporting. True if SOX-controlled, False otherwise.',
    `top_invoice_reference` STRING COMMENT 'Reference number of the invoice issued for the take-or-pay shortfall payment, linking this obligation to accounts receivable and revenue recognition.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for all volume fields in this record. Common values: MCF (Thousand Cubic Feet), MMCF (Million Cubic Feet), MMCFD (Million Cubic Feet per Day), BCF (Billion Cubic Feet), MMBTU (Million British Thermal Units), MT (Metric Tons for LNG), BBL (Barrels), GAL (Gallons). [ENUM-REF-CANDIDATE: MCF|MMCF|MMCFD|BCF|MMBTU|MT|BBL|GAL — 8 candidates stripped; promote to reference product]',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the seller has waived the take-or-pay obligation for this period (e.g., due to force majeure, commercial negotiation, or contract amendment). True if waived, False otherwise.',
    `waiver_reason` STRING COMMENT 'Free-text description of the reason for waiving the take-or-pay obligation, if waiver_flag is True. Captures business rationale and supporting documentation reference.',
    CONSTRAINT pk_take_or_pay PRIMARY KEY(`take_or_pay_id`)
) COMMENT 'Tracks take-or-pay (TOP) obligations and shortfall positions under gas sales agreements, LNG SPAs, and pipeline capacity contracts where buyers must pay for minimum contracted volumes regardless of actual offtake. Captures contract reference, obligation period, minimum contracted volume (MCF/MMCFD), actual taken volume, shortfall volume, shortfall amount, make-up period start/end, make-up volume entitlement, make-up volume utilized, carry-forward balance, TOP invoice reference, and obligation status (in compliance, shortfall, make-up active, expired). Supports revenue recognition for TOP shortfall payments under IFRS 15.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Primary key for accrual',
    `account_id` BIGINT COMMENT 'Identifier of the customer or counterparty to whom the product was sold or delivered. Links the accrual to the commercial relationship.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Revenue accruals by partner share support JV partner equity reporting, working interest-based accrual allocation, and partner-specific financial close processes. Required for accurate partner account ',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the production facility, refinery, or processing plant where the product was produced or processed. Enables facility-level revenue attribution.',
    `commercial_term_contract_id` BIGINT COMMENT 'Identifier of the sales contract or offtake agreement under which the revenue is being accrued. Provides traceability to contractual terms.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Revenue accruals posted to specific legal entities for period-end close, financial reporting, and SOX compliance in oil & gas operations.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Revenue accruals for PSA profit oil and cost recovery reported in quarterly regulatory filings. Links accrued revenue to government reporting for PSA compliance and audit reconciliation.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or role who approved the accrual entry. Supports audit trail and accountability requirements.',
    `field_id` BIGINT COMMENT 'Identifier of the oil or gas field from which the production originated. Supports field-level revenue tracking and analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue accruals posted to specific GL accounts for period-end close, financial reporting, and audit trail in oil & gas operations.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Revenue accruals are period-end estimates that are later matched to actual invoices. accrual currently has actual_invoice_number (STRING) but no proper FK. Adding invoice_id (BIGINT) as FK to invoice.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Revenue accruals for production not yet invoiced require lease identification for proper period-end revenue recognition and working interest allocation.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Revenue accruals estimate product-specific revenue before final measurement and pricing. Period-end close process requires product-level accruals for accurate financial reporting, especially for crude',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Transportation cost accruals require segment-level detail for accurate cost matching to revenue periods, regulatory reporting, and shipper billing reconciliation at period close.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Revenue accruals are estimated at well level before final measurement/invoicing for monthly financial close. Essential for SEC reserves reporting, PV-10 calculations, and well-level economic analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue accruals allocated to profit centers for segment P&L reporting, field profitability analysis, and management reporting in oil & gas.',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the accrual entry. Tracks whether the accrual has been posted to the general ledger, reversed upon invoicing, or adjusted for corrections.. Valid values are `posted|reversed|adjusted|pending`',
    `accrual_type` STRING COMMENT 'Classification of the revenue accrual by product or service category. Determines the nature of the revenue being recognized.. Valid values are `crude_oil_sales|gas_sales|ngl_sales|lng_sales|petrochemical_sales|tariff_income`',
    `adjustment_reason` STRING COMMENT 'The business reason for any adjustment made to the accrual after initial posting. Documents the rationale for corrections or revisions.',
    `amount` DECIMAL(18,2) COMMENT 'The total revenue amount accrued for the period, calculated as estimated volume multiplied by estimated price. Represents the revenue recognized in the financial statements prior to invoicing.',
    `approval_status` STRING COMMENT 'The approval status of the accrual entry. Tracks whether the accrual has been reviewed and approved by authorized personnel before posting.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the accrual entry was approved. Provides a complete audit trail for financial controls.',
    `basis` STRING COMMENT 'The calculation methodology used to determine the accrual amount, typically expressed as estimated volume multiplied by estimated price. Documents the business logic behind the accrual computation.',
    `business_area` STRING COMMENT 'The SAP business area or segment to which the accrual is allocated, such as upstream, midstream, downstream, or petrochemicals. Supports segment reporting requirements.',
    `cost_center` STRING COMMENT 'The cost center associated with the revenue accrual, if applicable. May be used for operational cost allocation and analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the accrual record was first created in the system. Provides audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the accrual amount is denominated.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `document_number` STRING COMMENT 'SAP FI accrual document number assigned during period-end posting. Serves as the external business identifier for this accrual entry.',
    `estimated_price` DECIMAL(18,2) COMMENT 'The estimated unit price per volume unit used to calculate the accrual amount. May be based on index prices, contract terms, or historical averages.',
    `estimated_volume` DECIMAL(18,2) COMMENT 'The estimated quantity of product sold or delivered during the accrual period for which invoicing has not yet occurred. Expressed in the unit of measure appropriate to the product type.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the accrual record was last updated or modified. Tracks the most recent change to the record.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The net revenue interest percentage after deducting royalties and overriding royalty interests. Represents the companys actual share of revenue.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or context related to the accrual entry. Used for documentation and communication among finance team members.',
    `period_end_date` DATE COMMENT 'The last day of the accounting period for which revenue is being accrued. Defines the end of the revenue recognition window and triggers period-end close procedures.',
    `period_start_date` DATE COMMENT 'The first day of the accounting period for which revenue is being accrued. Defines the beginning of the revenue recognition window.',
    `posting_date` DATE COMMENT 'The date on which the accrual entry was posted to the SAP FI general ledger. Represents the accounting date for financial reporting purposes.',
    `price_index_reference` STRING COMMENT 'The pricing index or benchmark used to estimate the price for the accrual, such as WTI (West Texas Intermediate), Brent, or Henry Hub. Provides transparency on pricing methodology.',
    `price_uom` STRING COMMENT 'The unit of measure basis for the estimated price, indicating the volume unit to which the price applies.. Valid values are `per_BBL|per_BOE|per_MCF|per_MMCF|per_MT|per_GAL`',
    `production_month` STRING COMMENT 'The production month (YYYY-MM format) for which the revenue is being accrued. Aligns the accrual with the physical production or delivery period.',
    `reversal_date` DATE COMMENT 'The date on which the accrual is scheduled to be or was reversed in the general ledger, typically in the subsequent accounting period when the actual invoice is posted.',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which the accrual data originated, such as SAP FI, production allocation system, or manual entry. Supports data lineage and reconciliation.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this accrual is subject to SOX financial reporting controls and requires additional review or approval. True if SOX controls apply, False otherwise.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the accrued revenue amount and the actual invoiced amount. A positive variance indicates the accrual underestimated revenue; a negative variance indicates overestimation.',
    `volume_uom` STRING COMMENT 'The unit of measure for the estimated volume. Common units include BBL (barrels), BOE (barrels of oil equivalent), MCF (thousand cubic feet), MMCF (million cubic feet), MT (metric tons), GAL (gallons).. Valid values are `BBL|BOE|MCF|MMCF|MT|GAL`',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage owned by the company in the production or asset generating the revenue. Used for revenue allocation in joint ventures.',
    CONSTRAINT pk_accrual PRIMARY KEY(`accrual_id`)
) COMMENT 'Period-end revenue accruals for petroleum product sales where invoicing has not yet occurred but revenue has been earned based on production volumes, liftings, or delivery confirmations. Captures accrual period, accrual type (crude oil sales, gas sales, NGL sales, LNG sales, petrochemical sales, tariff income), accrual basis (estimated volume × estimated price), estimated volume, estimated price, accrual amount, reversal date, actual invoice reference (post-reversal), SAP FI accrual document number, and accrual status (posted, reversed, adjusted). Supports IFRS/GAAP period-end close and SOX financial reporting controls.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` (
    `revenue_forecast_id` BIGINT COMMENT 'Unique identifier for the revenue forecast record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Unique identifier of the production, processing, or refining facility associated with the forecasted revenue.',
    `commercial_term_contract_id` BIGINT COMMENT 'Unique identifier of the sales contract or offtake agreement underlying the revenue forecast.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Revenue forecasts prepared by legal entity for budgeting, financial planning, and SEC guidance in oil & gas operations.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the user or authority who approved the forecast.',
    `field_id` BIGINT COMMENT 'Unique identifier of the oil or gas field from which production and revenue are forecasted.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: JV revenue forecasts by partner entitlement drive partner budgeting, cash call planning, and partner-specific financial planning. Required for partner equity forecast reporting and JV budget approval ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue forecasts mapped to GL accounts for budget preparation, variance analysis, and financial planning in oil & gas operations.',
    `joa_id` BIGINT COMMENT 'Unique identifier of the Joint Operating Agreement if the forecasted revenue is from joint venture operations.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Revenue forecasts are built from lease-level production and pricing assumptions, requiring lease linkage for accurate forward-looking revenue projections and budgeting.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Revenue forecasts model future offtake agreement deliveries and pricing. Standard FP&A process for projecting contracted volume revenue streams.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Revenue forecasts are product-grade specific (WTI crude vs Brent vs diesel vs LNG) with distinct price curves and market dynamics. Planning and budgeting require linking forecasts to product master da',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Transportation revenue forecasts for midstream operators require segment-level capacity, throughput projections, and tariff rate assumptions for financial planning and capacity contracting decisions.',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Revenue forecasts use forward curve benchmarks for price assumptions in planning and budgeting. Linking to benchmark definitions ensures consistent pricing methodology across forecasts and enables sce',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer or counterparty for whom revenue is being forecasted.',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Revenue forecasts are built from well-level production forecasts with price decks applied. Critical for reserves valuation (SEC/SPE), economic limit calculations, budget planning, and acquisition/dive',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue forecasts allocated to profit centers for segment planning, field-level budgeting, and management forecasting in oil & gas operations.',
    `psa_id` BIGINT COMMENT 'Unique identifier of the Production Sharing Agreement if the forecasted revenue is subject to PSA terms.',
    `recognition_schedule_id` BIGINT COMMENT 'Foreign key linking to revenue.recognition_schedule. Business justification: Revenue forecasts are executed according to a recognition schedule; linking the schedule provides the required parent relationship.',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: Revenue forecasts are built from refinery production schedules (crude slate, product slate, throughput targets). Schedule provides volume and product mix inputs to forecast model. Standard integrated ',
    `revenue_deck_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_deck. Business justification: Each revenue forecast belongs to a revenue deck for reporting aggregation; adding revenue_deck_id creates the necessary parent link.',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to refining.turnaround. Business justification: Major turnarounds cause planned production outages impacting revenue forecasts. Turnaround schedule (start/end dates, affected units, production deferral BOE) is critical input to multi-period revenue',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Revenue forecasts are built from well-level production forecasts combined with price decks for reserves reporting (SEC, SPE-PRMS), budget planning, and investment decision-making.',
    `previous_revenue_forecast_id` BIGINT COMMENT 'Self-referencing FK on revenue_forecast (previous_revenue_forecast_id)',
    `approval_status` STRING COMMENT 'Current approval status of the revenue forecast in the governance workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast was approved.',
    `basis` STRING COMMENT 'Description of the methodology and assumptions underlying the forecast (e.g., contracted volumes, spot market assumptions, historical trends, production capacity).',
    `confidence_level` STRING COMMENT 'Statistical confidence or probability level associated with the forecast (e.g., P50 for median case, P90 for conservative case).. Valid values are `high|medium|low|P10|P50|P90`',
    `cost_center` STRING COMMENT 'Cost center code associated with the forecasted revenue for cost allocation and analysis.',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created the forecast record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the revenue forecast record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the forecasted revenue amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `fiscal_period` STRING COMMENT 'Fiscal period or month within the fiscal year (e.g., P01, P02, Q1, Q2).',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the forecast period belongs.',
    `forecast_date` DATE COMMENT 'The date when this revenue forecast was created or generated.',
    `forecast_number` STRING COMMENT 'Business-facing unique document number for the revenue forecast, used for reference and tracking across systems.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the revenue forecast in the approval and planning workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|active|superseded|archived — 7 candidates stripped; promote to reference product]',
    `forecast_type` STRING COMMENT 'Classification of the forecast by planning horizon and purpose (e.g., annual budget, rolling 12-month, scenario planning).. Valid values are `budget|rolling|scenario|strategic|operational`',
    `forecasted_price` DECIMAL(18,2) COMMENT 'Projected unit price for the product during the forecast period.',
    `forecasted_revenue_amount` DECIMAL(18,2) COMMENT 'Projected total revenue amount for the forecast period, calculated as forecasted volume multiplied by forecasted price.',
    `forecasted_volume` DECIMAL(18,2) COMMENT 'Projected quantity of product to be sold during the forecast period.',
    `last_modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified the forecast record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the revenue forecast record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, assumptions, or explanations for the forecast.',
    `nri_percentage` DECIMAL(18,2) COMMENT 'The companys net revenue interest percentage after deducting royalties and overriding royalty interests.',
    `period_end_date` DATE COMMENT 'The ending date of the period for which revenue is being forecasted.',
    `period_start_date` DATE COMMENT 'The beginning date of the period for which revenue is being forecasted.',
    `price_differential` DECIMAL(18,2) COMMENT 'Expected differential (premium or discount) from the reference price index based on quality, location, or contract terms.',
    `price_uom` STRING COMMENT 'Unit of measure basis for the forecasted price (e.g., per barrel, per thousand cubic feet).. Valid values are `per_BBL|per_MCF|per_MT|per_GAL|per_LB`',
    `scenario` STRING COMMENT 'Scenario name or identifier for the forecast (e.g., Base Case, Optimistic, Pessimistic, High Oil Price, Low Demand).',
    `version` STRING COMMENT 'Version identifier for the forecast (e.g., Budget, Revised, Q1 Update) to track multiple forecast iterations for the same period.',
    `volume_uom` STRING COMMENT 'Unit of measure for the forecasted volume (e.g., BBL for barrels, MCF for thousand cubic feet, MT for metric tons). [ENUM-REF-CANDIDATE: BBL|BOE|MCF|MMCF|MT|GAL|LB — 7 candidates stripped; promote to reference product]',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The companys working interest ownership percentage in the property or joint venture for revenue allocation purposes.',
    CONSTRAINT pk_revenue_forecast PRIMARY KEY(`revenue_forecast_id`)
) COMMENT 'Forward-looking revenue projection record by product, customer, contract, and period. Captures forecast period, forecast basis (contract volumes, spot market assumptions), projected revenue amount, currency, and confidence level.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Unique identifier for the settlement record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty receiving the product and subject to this settlement.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the sales or offtake contract governing the terms of this settlement.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Settlements processed by specific legal entities for final revenue adjustments, financial reporting, and audit compliance in oil & gas operations.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Final settlements for PSA production entitlements and government take reported to regulatory authorities. Required for PSA annual reconciliation and government audit of entitlement calculations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Settlement documents (volume/price true-ups) require creator tracking for contract compliance and dispute resolution. Oil & gas settlements reconcile provisional vs. final pricing, quality adjustments',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude settlements adjust for actual grade delivered vs contracted, with quality premiums/penalties based on API gravity and sulfur content. Grade-specific assay data drives settlement calculations for',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Production settlements reconciling invoiced vs actual volumes/prices must reference lease for proper adjustment allocation to working interest and royalty owners.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Settlements reconcile offtake agreement actual lifted volumes/quality vs nominated amounts. Standard post-lifting adjustment for BL quantity vs nomination variance.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Final settlements reconcile invoiced vs actual product delivered with quality adjustments (API gravity, sulfur content). Custody transfer accounting requires linking settlement adjustments to product ',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline transportation settlements reconcile invoiced vs actual volumes by segment for shipper balancing, overlift/underlift calculations, and dispute resolution per segment operational performance.',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Settlements use benchmark prices for final price calculation in index-based contracts. Market-based pricing requires linking to benchmark definitions for differential application, price adjustment val',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Physical delivery settlements reconcile volume/quality adjustments at facility custody transfer points where measurement occurs. Required for custody transfer reconciliation, measurement dispute resol',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Settlements compare delivered quality against contracted specifications for quality adjustment calculations. Premium/penalty amounts depend on spec deviations (API gravity, sulfur, RVP); direct link t',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Settlements reconcile sales order actual delivered volumes/quality vs invoiced amounts. Standard post-delivery adjustment process for measurement ticket vs order confirmation variances.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Final settlements must identify the JV partner receiving or paying adjustments for accurate partner account reconciliation, netting statement finalization, and partner-specific settlement reporting.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Settlements reconcile spot trade final pricing/quality adjustments vs invoiced amounts. Standard post-delivery true-up process for crude/product spot transactions with index-based pricing.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Final settlements for crude/gas sales require well-level traceability for working interest and net revenue interest calculations mandated by joint operating agreements and production sharing agreement',
    `reversal_settlement_id` BIGINT COMMENT 'Self-referencing FK on settlement (reversal_settlement_id)',
    `accounting_period` STRING COMMENT 'The fiscal period (e.g., 2024-01, Q1-2024) to which this settlement is assigned for financial reporting.',
    `actual_delivered_volume` DECIMAL(18,2) COMMENT 'The final confirmed volume quantity delivered, based on custody transfer measurements and meter tickets.',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity measurement of the crude oil, used to determine quality adjustments and pricing differentials.',
    `created_by_user` STRING COMMENT 'The user ID or username of the person who created this settlement record.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this settlement record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this settlement is under dispute by the customer or joint venture partner.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for dispute, if dispute_flag is True.',
    `final_price` DECIMAL(18,2) COMMENT 'The final confirmed unit price per volume after all pricing adjustments, quality premiums or penalties, and index settlements.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which this settlement was posted to the general ledger for financial reporting.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'The total gross amount originally invoiced before settlement adjustments.',
    `invoiced_price` DECIMAL(18,2) COMMENT 'The unit price per volume used in the original invoice, typically based on provisional or index pricing.',
    `invoiced_volume` DECIMAL(18,2) COMMENT 'The volume quantity originally invoiced based on provisional or estimated measurements.',
    `last_modified_by_user` STRING COMMENT 'The user ID or username of the person who last modified this settlement record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this settlement record was last updated.',
    `net_revenue_interest_pct` DECIMAL(18,2) COMMENT 'The net revenue interest percentage after royalty and overriding royalty deductions, used for final revenue allocation.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'The final net settlement amount after all volume, price, quality, transportation, and tax adjustments. Represents the amount due to or from the customer.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special instructions related to this settlement.',
    `payment_due_date` DATE COMMENT 'The date by which the net settlement amount must be paid or received, based on contract payment terms.',
    `payment_status` STRING COMMENT 'Current payment status of the settlement: unpaid, partially paid, paid in full, or overdue.. Valid values are `unpaid|partially_paid|paid|overdue`',
    `period_end_date` DATE COMMENT 'The ending date of the delivery or production period covered by this settlement.',
    `period_start_date` DATE COMMENT 'The beginning date of the delivery or production period covered by this settlement.',
    `price_adjustment` DECIMAL(18,2) COMMENT 'The difference between invoiced price and final price, representing pricing true-ups based on final index values or contract terms.',
    `price_adjustment_amount` DECIMAL(18,2) COMMENT 'The monetary impact of price adjustments, calculated as price variance multiplied by delivered volume.',
    `quality_premium_penalty` DECIMAL(18,2) COMMENT 'The net adjustment amount applied for product quality variations (API gravity, sulfur content, BTU content) relative to contract specifications. Positive values represent premiums; negative values represent penalties.',
    `settlement_date` DATE COMMENT 'The business date on which the settlement was executed and finalized, representing the principal event timestamp for this transaction.',
    `settlement_number` STRING COMMENT 'Business-facing unique document number for the settlement transaction, used for external reference and audit trails.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement record in the approval and posting workflow.. Valid values are `draft|pending_approval|approved|posted|disputed|cancelled`',
    `settlement_type` STRING COMMENT 'Classification of the settlement transaction: provisional (initial estimate), final (after quality and volume confirmation), adjustment (correction to prior settlement), or reversal (cancellation).. Valid values are `provisional|final|adjustment|reversal`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this settlement is subject to SOX internal control testing and audit requirements.',
    `sulfur_content_pct` DECIMAL(18,2) COMMENT 'The sulfur content of the crude oil or product expressed as a percentage, used for quality-based pricing adjustments.',
    `tax_adjustment` DECIMAL(18,2) COMMENT 'Adjustments to severance tax, ad valorem tax, or sales tax based on final pricing and volume.',
    `transportation_adjustment` DECIMAL(18,2) COMMENT 'Adjustments to transportation or tariff charges based on actual delivery costs versus invoiced estimates.',
    `volume_adjustment` DECIMAL(18,2) COMMENT 'The difference between invoiced volume and actual delivered volume, representing measurement variance or shrinkage.',
    `volume_adjustment_amount` DECIMAL(18,2) COMMENT 'The monetary impact of volume adjustments, calculated as volume variance multiplied by applicable price.',
    `volume_uom` STRING COMMENT 'The unit of measure for volume quantities: Barrels (BBL), Thousand Cubic Feet (MCF), Million Cubic Feet (MMCF), Gallons (GAL), Metric Tons (MT), or Pounds (LB).. Valid values are `BBL|MCF|MMCF|GAL|MT|LB`',
    `working_interest_pct` DECIMAL(18,2) COMMENT 'The working interest percentage applicable to this settlement for joint venture revenue allocation.',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Settlement record reconciling invoiced amounts against actual delivered volumes and quality adjustments for crude oil, natural gas, and refined product sales. Captures settlement period, provisional vs final pricing, volume adjustments, quality premiums/penalties, and net settlement amount.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`credit_review` (
    `credit_review_id` BIGINT COMMENT 'Unique identifier for this credit review record. Primary key for the credit review association.',
    `customer_credit_id` BIGINT COMMENT 'Foreign key linking to the customer credit account being reviewed',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee performing or approving the credit review',
    `approval_authority_level` STRING COMMENT 'The approval authority level of the employee in this review. Explicitly identified in detection phase relationship data. Determines which credit limit thresholds this employee can approve. Values: analyst (up to $50K), manager (up to $500K), director (up to $2M), cfo (unlimited).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit review record was created in the system.',
    `credit_approval_authority` STRING COMMENT 'Name or role of the individual who approved the current credit limit (e.g., Credit Manager, CFO, Credit Committee). Supports SOX segregation of duties requirements. [Moved from customer_credit: This captures the role/authority level of the approver, which varies by employee and by review. In the association, this becomes approval_authority_level linked to the specific employee performing that review step.]',
    `credit_approval_date` DATE COMMENT 'Date when the current credit limit was approved by the authorized credit manager. Part of SOX-compliant credit approval audit trail. [Moved from customer_credit: This date represents when a specific employee approved the credit limit. In a multi-level approval workflow, there may be multiple approval dates (analyst recommends on date 1, manager approves on date 2, CFO approves on date 3). These dates belong in the credit_review association linked to the specific approving employee.]',
    `credit_rating_date` DATE COMMENT 'Date when the current credit rating (internal or external) was assigned or last updated. Used to track rating staleness and trigger periodic reviews. [Moved from customer_credit: This date represents when a credit rating was assigned, which is the outcome of a credit review performed by a specific employee. This date belongs in the credit_review association as review_date to link the rating assignment to the employee who performed the assessment.]',
    `credit_review_date` DATE COMMENT 'Date when the next periodic credit review is scheduled. Ensures timely reassessment of customer creditworthiness per SOX credit control policies. [Moved from customer_credit: This is the scheduled next review date, but the actual review history (when reviews were performed, by whom, with what outcome) belongs in the credit_review association. The customer_credit table can retain next_review_date for scheduling, but completed review dates belong in the association.]',
    `recommendation` STRING COMMENT 'Credit analyst or manager recommendation resulting from this review. Explicitly identified in detection phase relationship data. Values: approve, approve_with_conditions, reject, escalate (to higher authority), hold (pending additional information).',
    `review_date` DATE COMMENT 'Date when this credit review was performed by the employee. Explicitly identified in detection phase relationship data.',
    `review_notes` STRING COMMENT 'Free-text notes and rationale documented by the employee during their credit review. Captures risk assessment findings, justification for recommendation, and conditions or concerns.',
    `review_outcome` STRING COMMENT 'Final outcome of this review step in the approval workflow. Explicitly identified in detection phase relationship data. Values: approved (employee approved at their level), rejected (employee rejected), pending (awaiting employee action), escalated (sent to higher authority).',
    `review_sequence` STRING COMMENT 'Sequential order of this review in the multi-level approval chain for this customer credit account. 1 = initial analyst review, 2 = manager approval, 3 = director/CFO approval.',
    `review_status` STRING COMMENT 'Current lifecycle status of this review record. Values: draft (in progress), submitted (awaiting approval), completed (finalized), superseded (replaced by newer review).',
    `review_type` STRING COMMENT 'Type of credit review being performed. Explicitly identified in detection phase relationship data. Values: initial_assessment (new customer), periodic_review (scheduled), limit_increase_request (customer requested increase), credit_hold_review (evaluating hold release), annual_reassessment (mandatory annual review).',
    `reviewed_credit_limit` DECIMAL(18,2) COMMENT 'The credit limit amount being reviewed or recommended by this employee. May differ from current limit if this is a limit increase request or reassessment.',
    `risk_assessment_score` STRING COMMENT 'Quantitative risk score assigned by the employee during this review. Scale 1-100 where higher scores indicate higher credit risk. Used for SOX-compliant credit approval workflows.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit review record was last updated.',
    CONSTRAINT pk_credit_review PRIMARY KEY(`credit_review_id`)
) COMMENT 'This association product represents the credit review and approval workflow between customer credit accounts and employees. It captures the multi-level approval process required for credit limit establishment, periodic reassessment, and credit risk management. Each record links one customer credit account to one employee (credit analyst, credit manager, CFO) with their specific role, review findings, and approval authority level in the credit decision chain.. Existence Justification: In oil and gas credit management, customer credit accounts undergo multi-level approval workflows involving multiple employees at different authority levels (credit analyst, credit manager, CFO) based on credit limit size and risk rating. Each customer credit account has multiple employees review it over time (initial assessment, periodic reviews, limit increase requests), and each employee reviews multiple customer credit accounts. The business actively manages these credit reviews as operational records with specific review dates, recommendations, approval authority levels, and outcomes.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`revenue_deck` (
    `revenue_deck_id` BIGINT COMMENT 'Primary key for revenue_deck',
    `parent_revenue_deck_id` BIGINT COMMENT 'Self-referencing FK on revenue_deck (parent_revenue_deck_id)',
    `accounting_method` STRING COMMENT 'Revenue recognition method applied to the deck per IFRS/GAAP.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (discounts, fees, rebates) applied to the deck.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the revenue deck.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue deck record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for amounts in the deck.',
    `deck_code` STRING COMMENT 'Unique alphanumeric code identifying the revenue deck.',
    `deck_name` STRING COMMENT 'Descriptive name of the revenue deck used for reporting and analysis.',
    `deck_type` STRING COMMENT 'Classification of the revenue deck based on revenue source.',
    `revenue_deck_description` STRING COMMENT 'Detailed description of the revenue deck purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the revenue deck becomes effective for accounting.',
    `effective_until` DATE COMMENT 'Date when the revenue deck ceases to be effective; null if open-ended.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the deck contains confidential financial information.',
    `last_reconciled_date` DATE COMMENT 'Date when the revenue deck was last reconciled with the general ledger.',
    `notes` STRING COMMENT 'Free-text field for any additional remarks or comments.',
    `region` STRING COMMENT 'Region where the revenue deck is applicable.',
    `revenue_category` STRING COMMENT 'High-level category of revenue captured in the deck.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether the deck is subject to SOX internal control testing.',
    `revenue_deck_status` STRING COMMENT 'Current lifecycle status of the revenue deck.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of gross revenue amounts before deductions.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net revenue after taxes and adjustments.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax amount applicable to the revenue deck.',
    `updated_by` STRING COMMENT 'Identifier of the user who last updated the revenue deck record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revenue deck record.',
    `created_by` STRING COMMENT 'Identifier of the user who created the revenue deck record.',
    CONSTRAINT pk_revenue_deck PRIMARY KEY(`revenue_deck_id`)
) COMMENT 'Master reference table for revenue_deck. Referenced by revenue_deck_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` (
    `recognition_schedule_id` BIGINT COMMENT 'Primary key for recognition_schedule',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved the schedule.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the schedule record.',
    `parent_recognition_schedule_id` BIGINT COMMENT 'Self-referencing FK on recognition_schedule (parent_recognition_schedule_id)',
    `adjustment_method` STRING COMMENT 'Method used to adjust the schedule when changes occur.',
    `allocation_basis` STRING COMMENT 'Basis on which revenue is allocated across periods.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule was approved for use.',
    `business_unit` STRING COMMENT 'Organizational unit responsible for the schedule.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier associated with the schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the revenue amount.',
    `recognition_schedule_description` STRING COMMENT 'Free‑form description of the schedules purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date on which the schedule ceases to be effective; null for open‑ended schedules.',
    `effective_start_date` DATE COMMENT 'Date on which the schedule becomes effective for revenue recognition.',
    `external_reference` STRING COMMENT 'Identifier linking the schedule to an external ERP or billing system.',
    `frequency` STRING COMMENT 'How often revenue is recognized under this schedule.',
    `ifrs_standard` STRING COMMENT 'IFRS method applied to the schedule (full‑cost or successful‑efforts).',
    `interval_days` STRING COMMENT 'Number of days between recognitions when frequency is set to custom.',
    `is_adjustable` BOOLEAN COMMENT 'Indicates whether the schedule can be adjusted after creation.',
    `last_recognition_date` DATE COMMENT 'Date when revenue was most recently recognized.',
    `legal_entity` STRING COMMENT 'Legal entity under which the schedule is recorded.',
    `next_recognition_date` DATE COMMENT 'Scheduled date for the next revenue recognition event.',
    `notes` STRING COMMENT 'Additional remarks, exceptions, or operational notes.',
    `recognition_method` STRING COMMENT 'Method used to calculate revenue recognition (e.g., % of completion, completed contract).',
    `remaining_amount` DECIMAL(18,2) COMMENT 'Revenue amount still pending recognition.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Contractual total revenue amount subject to the schedule.',
    `revenue_recognition_policy` STRING COMMENT 'Reference to the corporate policy governing how revenue is recognized.',
    `schedule_category` STRING COMMENT 'High‑level category indicating the schedules primary business domain.',
    `schedule_code` STRING COMMENT 'External business code used to reference the schedule in finance and billing systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the purpose or scope of the schedule.',
    `schedule_type` STRING COMMENT 'Classification of the schedule (e.g., revenue, royalty, tariff, joint‑interest billing).',
    `schedule_version` STRING COMMENT 'Version identifier for change‑management and audit purposes.',
    `sox_compliant` BOOLEAN COMMENT 'Indicates whether the schedule complies with Sarbanes‑Oxley controls.',
    `recognition_schedule_status` STRING COMMENT 'Current lifecycle state of the schedule.',
    `tax_jurisdiction` STRING COMMENT 'ISO‑3 country code of the tax jurisdiction governing the schedule.',
    `total_recognized_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of revenue already recognized to date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the schedule record.',
    CONSTRAINT pk_recognition_schedule PRIMARY KEY(`recognition_schedule_id`)
) COMMENT 'Master reference table for recognition_schedule. Referenced by recognition_schedule_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `oil_gas_ecm`.`revenue`.`payment_term`(`payment_term_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `oil_gas_ecm`.`revenue`.`payment`(`payment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `oil_gas_ecm`.`revenue`.`payment_term`(`payment_term_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `oil_gas_ecm`.`revenue`.`dispute`(`dispute_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_original_credit_note_id` FOREIGN KEY (`original_credit_note_id`) REFERENCES `oil_gas_ecm`.`revenue`.`credit_note`(`credit_note_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_original_event_recognition_event_id` FOREIGN KEY (`original_event_recognition_event_id`) REFERENCES `oil_gas_ecm`.`revenue`.`recognition_event`(`recognition_event_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_recognition_schedule_id` FOREIGN KEY (`recognition_schedule_id`) REFERENCES `oil_gas_ecm`.`revenue`.`recognition_schedule`(`recognition_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ADD CONSTRAINT `fk_revenue_intercompany_billing_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `oil_gas_ecm`.`revenue`.`payment_term`(`payment_term_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_recognition_schedule_id` FOREIGN KEY (`recognition_schedule_id`) REFERENCES `oil_gas_ecm`.`revenue`.`recognition_schedule`(`recognition_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_revenue_deck_id` FOREIGN KEY (`revenue_deck_id`) REFERENCES `oil_gas_ecm`.`revenue`.`revenue_deck`(`revenue_deck_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_previous_revenue_forecast_id` FOREIGN KEY (`previous_revenue_forecast_id`) REFERENCES `oil_gas_ecm`.`revenue`.`revenue_forecast`(`revenue_forecast_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_reversal_settlement_id` FOREIGN KEY (`reversal_settlement_id`) REFERENCES `oil_gas_ecm`.`revenue`.`settlement`(`settlement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ADD CONSTRAINT `fk_revenue_credit_review_customer_credit_id` FOREIGN KEY (`customer_credit_id`) REFERENCES `oil_gas_ecm`.`revenue`.`customer_credit`(`customer_credit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_deck` ADD CONSTRAINT `fk_revenue_revenue_deck_parent_revenue_deck_id` FOREIGN KEY (`parent_revenue_deck_id`) REFERENCES `oil_gas_ecm`.`revenue`.`revenue_deck`(`revenue_deck_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` ADD CONSTRAINT `fk_revenue_recognition_schedule_parent_recognition_schedule_id` FOREIGN KEY (`parent_recognition_schedule_id`) REFERENCES `oil_gas_ecm`.`revenue`.`recognition_schedule`(`recognition_schedule_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`revenue` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`revenue` SET TAGS ('dbx_domain' = 'revenue');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `copas_billing_method` SET TAGS ('dbx_business_glossary_term' = 'Council of Petroleum Accountants Societies (COPAS) Billing Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `copas_billing_method` SET TAGS ('dbx_value_regex' = 'detailed|summary|lump_sum');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `delivery_point_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Name');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'commercial|intercompany|jib|royalty|tariff|service');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|letter_of_credit|offset');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `blend_event_id` SET TAGS ('dbx_business_glossary_term' = 'Blend Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `customer_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `end_use_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'End Use Declaration Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Inventory Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `tariff_agreement_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `btu_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'British Thermal Unit (BTU) Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `btu_content` SET TAGS ('dbx_business_glossary_term' = 'British Thermal Unit (BTU) Content');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = 'upstream|midstream|downstream|petrochemical|marketing');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `credit_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `gravity_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Gravity Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `jib_category` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Category');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `jib_category` SET TAGS ('dbx_value_regex' = 'operated|non_operated|overhead|direct|indirect');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|disputed|adjusted|cancelled|credited');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `net_revenue_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `quality_adjustment_total` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Total');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `royalty_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Interest Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `sulfur_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `sulfur_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `bank_detail_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Bank Detail Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Application Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `application_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|partial|residual');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `bank_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `bank_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'bank_portal|lockbox|manual_entry|edi|api');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `clearing_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearing Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `jib_netting_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Netting Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `lockbox_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Batch Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|letter_of_credit|netting|eft');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'received|cleared|bounced|reversed|pending|reconciled');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|pending_review');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `remittance_advice` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `short_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Short Payment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `tolerance` SET TAGS ('dbx_business_glossary_term' = 'Payment Tolerance');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `wire_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agent Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Debtor Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|30_days|60_days|90_days|over_90_days');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `ar_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `ar_type` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `ar_type` SET TAGS ('dbx_value_regex' = 'trade|jib|royalty|tariff|service|other');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'open|in_collection|payment_plan|legal_referral|written_off|closed');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Rating');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `credit_terms` SET TAGS ('dbx_business_glossary_term' = 'Credit Terms');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `dunning_method` SET TAGS ('dbx_business_glossary_term' = 'Dunning Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `dunning_method` SET TAGS ('dbx_value_regex' = 'email|mail|phone|fax|none');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `expected_credit_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `legal_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Referral Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Receivable Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `cash_application_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Application Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `application_method` SET TAGS ('dbx_business_glossary_term' = 'Application Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `application_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|partial|lockbox|electronic');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Cash Application Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'matched|partially_matched|unmatched|on_account|reversed|pending');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `bank_statement_line_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Line Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `days_to_pay` SET TAGS ('dbx_business_glossary_term' = 'Days to Pay');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `functional_currency_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Applied Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Application Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `royalty_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `short_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Short Payment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `tolerance_amount` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `writeoff_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Credited Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `original_credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Original Credit Note ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE-[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Approval Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Issue Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_value_regex' = '^CN-[0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_value_regex' = 'quality_claim|volume_adjustment|price_correction|measurement_dispute|contractual_adjustment|billing_error');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `credit_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `measurement_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `price_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `quality_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Claim Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `reissue_flag` SET TAGS ('dbx_business_glossary_term' = 'Reissue Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'cash_refund|ar_credit|offset_future_invoice|netting');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `volume_adjustment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Adjustment Quantity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MCF|MT|GAL|other');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `revenue_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Division Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `offtake_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Accounting Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `accounting_method` SET TAGS ('dbx_value_regex' = 'successful_efforts|full_cost|entitlement');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `actual_lifted_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifted Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `ad_valorem_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Ad Valorem Tax Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `allocated_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'volumetric|entitlement|lifting|net_back|proportional');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|adjusted|disputed|approved');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `cost_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `entitlement_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `entitlement_volume_uom` SET TAGS ('dbx_value_regex' = 'BOE|BBL|MCF|MMCF|MT|GAL');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `government_take_amount` SET TAGS ('dbx_business_glossary_term' = 'Government Take Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `nri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `orri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `overlift_underlift_value` SET TAGS ('dbx_business_glossary_term' = 'Overlift Underlift Value');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `overlift_underlift_volume` SET TAGS ('dbx_business_glossary_term' = 'Overlift Underlift Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'working_interest|royalty_interest|overriding_royalty|net_profits_interest|production_payment|carried_interest');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `partner_entitlement_volume` SET TAGS ('dbx_business_glossary_term' = 'Partner Entitlement Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `processing_deduction` SET TAGS ('dbx_business_glossary_term' = 'Processing Deduction');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `profit_oil_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `realized_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Realized Price Per Unit');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `run_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `severance_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Severance Tax Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `transportation_deduction` SET TAGS ('dbx_business_glossary_term' = 'Transportation Deduction');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `tariff_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Charge Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `ferc_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Ferc Tariff Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `shipper_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `tariff_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Agreement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `adjustment_reference` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'actual_meter|prorated|nominated|scheduled');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `base_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Charge Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `charge_number` SET TAGS ('dbx_business_glossary_term' = 'Charge Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `charge_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Charge Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `charge_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Charge Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `compression_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Compression Charge Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|NOK');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `deficiency_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Charge Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'pipeline|terminal|fpso|gas_processing_plant|lng_facility|storage_facility');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `fuel_gas_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Charge Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment (MVC)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `shrinkage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Charge Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `storage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Storage Charge Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `tariff_rate` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `tariff_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Basis');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `throughput_volume` SET TAGS ('dbx_business_glossary_term' = 'Throughput Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Disputing Party Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Disputing Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Test Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `credit_note_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Issued Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `disputed_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Disputed Line Item Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `disputed_price` SET TAGS ('dbx_business_glossary_term' = 'Disputed Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `disputed_product_code` SET TAGS ('dbx_business_glossary_term' = 'Disputed Product Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `disputed_volume` SET TAGS ('dbx_business_glossary_term' = 'Disputed Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `jib_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `sap_dispute_case_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Dispute Case Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Event Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `original_event_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Event ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Recognizing Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `reserves_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Reserves Estimate Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `reservoir_sec_reserves_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Sec Reserves Disclosure Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `accounting_method` SET TAGS ('dbx_business_glossary_term' = 'Accounting Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `accounting_method` SET TAGS ('dbx_value_regex' = 'successful_efforts|full_cost');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial (FI) Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `period_end_accrual_flag` SET TAGS ('dbx_business_glossary_term' = 'Period-End Accrual Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_event_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_trigger` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Trigger');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_trigger` SET TAGS ('dbx_value_regex' = 'title_transfer|delivery|lifting|custody_transfer|shipment|service_completion');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `revenue_recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognized Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `revenue_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `sec_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Reporting Category');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `transaction_price_allocated` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price Allocated');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `baseline_date_rule` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date Rule');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `baseline_date_rule` SET TAGS ('dbx_value_regex' = 'invoice_date|delivery_date|bill_of_lading_date|month_end|custom');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `copas_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'COPAS (Council of Petroleum Accountants Societies) Compliant Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `discount_days` SET TAGS ('dbx_business_glossary_term' = 'Discount Days');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `installment_count` SET TAGS ('dbx_business_glossary_term' = 'Installment Count');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|custom');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `jib_standard_term_flag` SET TAGS ('dbx_business_glossary_term' = 'JIB (Joint Interest Billing) Standard Term Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `late_payment_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Interest Rate');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `net_due_days` SET TAGS ('dbx_business_glossary_term' = 'Net Due Days');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `revenue_recognition_impact` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Impact');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `revenue_recognition_impact` SET TAGS ('dbx_value_regex' = 'none|deferred|accelerated|variable_consideration');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `sap_fi_payment_term_key` SET TAGS ('dbx_business_glossary_term' = 'SAP FI Payment Term Key');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `sap_fi_payment_term_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `term_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `term_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Name');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'standard|early_payment_discount|installment|prepayment|consignment|letter_of_credit');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment_term` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `customer_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `available_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `collateral_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `collateral_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Collateral Expiry Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'letter_of_credit|parent_guarantee|cash_deposit|surety_bond|standby_lc|none');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_account_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Account Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_value_regex' = 'credit_limit_exceeded|payment_overdue|credit_rating_downgrade|bankruptcy_filing|dispute_unresolved|manual_hold');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Coverage Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_insurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Policy Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_limit_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Effective Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_limit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Expiry Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|under_review|closed|defaulted');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `external_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `jib_partner_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Partner Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `past_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Past Due Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Deferring Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Schedule Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferral_date` SET TAGS ('dbx_business_glossary_term' = 'Deferral Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferral_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferral_reason_code` SET TAGS ('dbx_value_regex' = 'advance_payment|take_or_pay|bill_and_hold|minimum_volume_shortfall|performance_obligation_unsatisfied|contract_modification');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferral_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferral_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reference Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferral_status` SET TAGS ('dbx_business_glossary_term' = 'Deferral Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferral_status` SET TAGS ('dbx_value_regex' = 'open|partially_recognized|fully_recognized|reversed|cancelled');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `expected_recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Recognition End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `expected_recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Recognition Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `original_deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Deferred Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Recognition Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time_straight_line|over_time_output_method|over_time_input_method|milestone_based');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `recognized_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized To Date Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `remaining_deferred_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Deferred Balance');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `sec_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `intercompany_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `receiving_entity_company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Entity Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `arms_length_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Arms Length Price Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `beps_country_code` SET TAGS ('dbx_business_glossary_term' = 'Base Erosion and Profit Shifting (BEPS) Country Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `beps_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Billing Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Billing Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|overdue|disputed|cancelled');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'crude_transfer|product_exchange|pipeline_tariff|processing_fee|management_fee|shared_service');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'CUP|RPM|CPM|TNMM|PSM');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MMBTU|MCF|MT|GAL');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `take_or_pay_id` SET TAGS ('dbx_business_glossary_term' = 'Take-or-Pay (TOP) Obligation ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `customer_volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Volume Commitment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `actual_taken_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Taken Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `carryforward_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Carry-Forward Balance Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `carryforward_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `carryforward_balance_volume` SET TAGS ('dbx_business_glossary_term' = 'Carry-Forward Balance Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `contract_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Contract Price per Unit');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `contract_price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `force_majeure_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `makeup_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Make-Up Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `makeup_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Make-Up Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `makeup_volume_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Make-Up Volume Entitlement');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `makeup_volume_utilized` SET TAGS ('dbx_business_glossary_term' = 'Make-Up Volume Utilized');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'meter|allocation|nomination|actual_lifting');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `minimum_contracted_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Contracted Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `obligation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `obligation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'in_compliance|shortfall|makeup_active|makeup_expired|disputed|waived');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_value_regex' = 'deferred|recognized|partially_recognized|reversed');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `revenue_recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognized Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `revenue_recognized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `shortfall_amount` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Payment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `shortfall_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `shortfall_volume` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `top_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Take-or-Pay (TOP) Invoice Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Accruing Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|adjusted|pending');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `accrual_type` SET TAGS ('dbx_value_regex' = 'crude_oil_sales|gas_sales|ngl_sales|lng_sales|petrochemical_sales|tariff_income');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Accrual Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accrual Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `estimated_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_BBL|per_BOE|per_MCF|per_MMCF|per_MT|per_GAL');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|BOE|MCF|MMCF|MT|GAL');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `revenue_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Forecasting Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `revenue_deck_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Deck Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `previous_revenue_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Forecast Basis');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|P10|P50|P90');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Creation Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'budget|rolling|scenario|strategic|operational');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecasted_price` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecasted_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `forecasted_volume` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Volume');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `nri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_BBL|per_MCF|per_MT|per_GAL|per_LB');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Settling Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `reversal_settlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `actual_delivered_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivered Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag Indicator');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `final_price` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Unit Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Gross Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `invoiced_price` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Unit Price');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `invoiced_volume` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `net_revenue_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overdue');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `price_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `price_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `quality_premium_penalty` SET TAGS ('dbx_business_glossary_term' = 'Quality Premium or Penalty Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Transaction Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Document Number');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|disputed|cancelled');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'provisional|final|adjustment|reversal');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `sulfur_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `tax_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `transportation_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost Adjustment');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `volume_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Volume Adjustment Quantity');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `volume_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Volume Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MCF|MMCF|GAL|MT|LB');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` SET TAGS ('dbx_association_edges' = 'revenue.customer_credit,workforce.employee');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `credit_review_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `customer_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review - Customer Credit Id');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review - Employee Id');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `credit_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Authority');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `credit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `credit_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Credit Recommendation');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `review_sequence` SET TAGS ('dbx_business_glossary_term' = 'Review Sequence');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `reviewed_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Credit Limit');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_deck` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_deck` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_deck` ALTER COLUMN `revenue_deck_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Deck Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_deck` ALTER COLUMN `parent_revenue_deck_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` ALTER COLUMN `recognition_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Schedule Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` ALTER COLUMN `parent_recognition_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
