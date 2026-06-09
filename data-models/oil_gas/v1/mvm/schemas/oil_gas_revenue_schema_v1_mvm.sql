-- Schema for Domain: revenue | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`revenue` COMMENT 'Manages revenue recognition, invoicing, payment processing, accounts receivable, JIB (Joint Interest Billing) statements, royalty payments, tariff charges, and cash application for crude oil sales, refined product sales, and petrochemical revenues. Owns invoice data, payment terms, revenue allocation, credit notes, and dispute resolution. Supports COPAS-compliant billing procedures, IFRS/GAAP revenue recognition standards (successful-efforts and full-cost methods), and SOX compliance. Integrates with SAP FI/SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system-generated identifier for the invoice record. Primary key for the invoice entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty being billed. May be an IOC (International Oil Company), NOC (National Oil Company), refiner, trader, industrial consumer, or joint venture partner.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Revenue invoices for joint venture cost recovery, capital project billing, and COPAS billing must reference the AFE budget to ensure proper cost allocation, working interest calculations, and audit tr',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: JV invoices must identify the operator or billing party partner for COPAS-compliant joint interest billing. Required for partner-specific AR aging, credit management, and regulatory audit trails in jo',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Invoices bill cargo liftings per nominations. Critical for cargo billing, bill of lading invoicing, and cargo nomination to invoice reconciliation in crude oil and refined product trading operations.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Invoices must be issued by a legal entity (company code) for GL posting, financial reporting, and SOX compliance. Essential for multi-entity oil & gas operations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue invoices allocated to cost centers for asset-level profitability analysis, AFE tracking, and joint venture accounting in oil & gas operations.',
    `delivery_point_id` BIGINT COMMENT 'FK to customer.delivery_point',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Invoices for royalty payments, government take, and intercompany partner billings in PSA regimes are tied to specific discoveries/fields. Field-level invoice tracking is a standard requirement for gov',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_afe. Business justification: JIB (Joint Interest Billing) invoices in O&G JV operations are issued against specific AFEs. The AFE number authorizes expenditure and is the billing reference for cost recovery invoices sent to non-o',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Well-level revenue reporting and JIB billing require invoices to reference the originating drilling well. O&G operators produce well-level P&L statements linking drilling costs to revenue; this FK ena',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Equipment rental and third-party service invoicing: O&G operators lease compressors, separators, and pumps to third parties or bill equipment-based tariffs. Invoice must reference the specific equipme',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this JIB invoice is issued. Applicable only for invoice_type = jib. Defines the joint venture partnership and cost-sharing rules.',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Invoices for royalty payments, government take, and partner billings in PSA/concession regimes reference the governing license. Required for license obligation tracking, regulatory compliance reportin',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Production and sales invoices must tie to valid operating permits for regulatory validation. Revenue recognition requires proof of permitted operations, especially for offshore and federal leases.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline transportation invoices reference specific segments for regulatory compliance (FERC Form 6), shipper billing, tariff rate application, and segment-level revenue tracking.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Invoices reference pricing agreements for rate basis, differentials, and quality adjustments. Required for invoice pricing accuracy, pricing agreement compliance verification, and pricing audit trails',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Invoices reference pricing benchmarks (Platts, Argus, NYMEX) for index-based contracts. Transparent pricing mechanism requires linking to benchmark definitions for price calculation verification, audi',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Invoices for gas processing fees, facility throughput tariffs, and JIB operator charges are issued against specific production facilities. Invoice has asset_facility_id (asset domain) but not a produc',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Invoices must be assigned to profit centers for segment reporting, P&L analysis by field/basin, and management reporting in oil & gas operations.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Invoices for project work must link to project master for project revenue tracking and billing management. Project accounting and milestone billing require invoice-to-project link for accurate project',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: Product sales invoices originate from specific refineries. Billing entity code/name on invoice are denormalized refinery identifiers. Links invoice to producing facility for revenue attribution, trans',
    `payment_term_id` BIGINT COMMENT 'Standardized code representing the payment terms agreed with the customer (e.g., NET30, NET60, 2/10NET30 for 2% discount if paid within 10 days, net due in 30 days).',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Invoices bill sales orders in the standard order-to-cash cycle. Revenue accounting requires tracing invoices back to originating sales orders for contract compliance, revenue recognition, and audit tr',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Invoices bill spot trades directly (not just sales orders) in physical commodity trading. Required for spot market billing process where trades settle without formal sales orders.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital project invoices bill against WBS elements for project cost recovery. Project accounting and AFE budget tracking require invoice-to-WBS traceability for billing validation and revenue allocati',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well-level invoices for working interest billing, lease operating expenses, or production revenue require direct well attribution for joint interest billing and partner cost allocation.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustments applied to the invoice for pricing corrections, quality adjustments, demurrage charges, or other post-billing modifications. May be positive or negative.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The cumulative amount received from the customer against this invoice to date. Used to calculate outstanding balance and track partial payments.',
    `billing_period_end_date` DATE COMMENT 'The last date of the period covered by this invoice. Defines the temporal scope of the billed activities or deliveries.',
    `billing_period_start_date` DATE COMMENT 'The first date of the period covered by this invoice. For production sales, this is the start of the lifting or delivery period. For JIB invoices, this is the start of the cost accumulation period.',
    `copas_billing_method` STRING COMMENT 'The COPAS-compliant billing method used for JIB invoices. Detailed method provides line-by-line cost breakdowns. Summary method aggregates costs by category. Lump sum method bills a pre-agreed fixed amount. Applicable only for invoice_type = jib.. Valid values are `detailed|summary|lump_sum`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this invoice record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). All monetary amounts on this invoice are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
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
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Cargo lifting invoices reference nominations to reconcile nominated vs actual lifted volumes, quality specifications, and laycan compliance. Critical for crude oil and refined product cargo billing ac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoice lines often need cost center attribution for internal charging and cost allocation beyond invoice header. Management accounting and cost allocation require line-level cost center for accurate ',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude oil invoicing references specific grades (WTI, Brent, Maya, Urals) with grade-specific pricing differentials and quality adjustments. Standard crude trading practice requires grade-level detail ',
    `crude_receipt_id` BIGINT COMMENT 'Foreign key linking to refining.crude_receipt. Business justification: Crude purchase invoice lines must reference the crude receipt for three-way match (PO, receipt, invoice) — a mandatory AP control in oil and gas. The receipt record provides the authoritative volume a',
    `customer_lifting_schedule_id` BIGINT COMMENT 'Foreign key linking to customer.lifting_schedule. Business justification: Invoice lines for crude liftings must link to the specific lifting schedule for volume reconciliation, entitlement tracking, and pricing validation. Required for matching invoiced volumes to actual li',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Invoice lines bill against term contract commitments for pricing, volume tracking, and take-or-pay calculations. Contract compliance reporting and revenue audit trails require direct linkage between b',
    `delivery_point_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_point. Business justification: Invoice lines must track the specific delivery point for custody transfer documentation, tariff calculation, and revenue allocation by location. Critical for reconciling delivered volumes against cont',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Invoice line items for crude/gas sales must be traceable to the originating drilling well for well-level revenue reporting, royalty calculation, and severance tax filings. production_well_id reference',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Invoice lines must post to specific GL accounts for revenue recognition, financial reporting, and audit trail. Essential for oil & gas accounting compliance.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header. Links this line item to the invoice transaction.',
    `lease_id` BIGINT COMMENT 'Unique identifier of the oil and gas lease or production unit associated with this revenue. Supports royalty calculation and revenue distribution.',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: NGL component sales invoicing requires direct link to capture component_type, purity_percent, and pricing_basis specific to NGL trading and petrochemical feedstock sales—distinct from crude or refined',
    `nomination_id` BIGINT COMMENT 'Foreign key linking to customer.nomination. Business justification: Invoice lines for crude oil sales must reference the customer nomination that authorized the lifting. Essential for reconciling nominated volumes against invoiced volumes, validating pricing basis, an',
    `offtake_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.offtake_entitlement. Business justification: Invoice lines for equity crude/gas sales bill against specific entitlement positions. Entitlement reconciliation, overlift/underlift tracking, and partner revenue allocation require linking billed vol',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Individual invoice line items for facility charges, tariffs, or production volumes must reference specific permits. Required for FERC and state regulatory validation of billed services.',
    `petroleum_product_id` BIGINT COMMENT 'FK to product.petroleum_product',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline tariff invoice line itemization: FERC-regulated and commercial pipeline tariff billing requires invoice lines to reference the specific pipeline segment for tariff rate application, regulator',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Invoice lines apply pricing agreements to determine rates, differentials, and quality adjustments. Required for pricing audit trails, contract compliance verification, and retroactive pricing adjustme',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to refining.process_unit. Business justification: Invoice lines for refined products (gasoline, diesel, jet fuel) trace back to producing process unit (FCC, HDS, reformer). Critical for margin analysis by unit, product costing, and operational perfor',
    `product_movement_id` BIGINT COMMENT 'Foreign key linking to refining.product_movement. Business justification: Refined product sale invoice lines are triggered by custody transfer events recorded in product_movement. Linking invoice lines to the movement record enables billing verification, meter ticket reconc',
    `product_quality_test_id` BIGINT COMMENT 'Foreign key linking to refining.product_quality_test. Business justification: Quality-based price adjustments on invoice lines (gravity, sulfur, cetane differentials) must reference the specific lab quality test that determined the measured values. This is the standard quality ',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Invoice lines for gas processing fees, compression tariffs, and water disposal charges are billed at the facility level. Invoice_line has production_well_id but not production_facility_id. Facility-le',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Invoice lines may span multiple profit centers within one invoice. Segment reporting and profitability analysis require line-level profit center for accurate segment revenue attribution and P&L.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Invoice lines reference quality specifications for contractual compliance verification. Off-spec product triggers pricing penalties or rejection; linking to quality specs enables automated compliance ',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product invoicing requires direct link to capture product_grade, excise_duty_category, and harmonized_tariff_code for customs/tax compliance and duty calculations—petroleum_product alone insuf',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Multi-zone producing wells with different ownership interests require zone-level invoice line attribution for accurate royalty billing and working interest splits. Royalty owners and NRI holders in sp',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Invoice lines must track royalty owner entitlements for production revenue distribution, 1099 reporting, and suspense account management - fundamental to oil & gas revenue allocation processes.',
    `run_ticket_id` BIGINT COMMENT 'Foreign key linking to production.run_ticket. Business justification: Run tickets are the legal custody transfer documents for crude oil sales — each crude oil invoice line must reference the run ticket documenting the measured volume. This is a fundamental O&G crude oi',
    `sales_order_line_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order_line. Business justification: Invoice lines detail sales order line items for line-level billing, quantity reconciliation, and pricing verification. Essential for matching billed vs ordered volumes and resolving billing disputes i',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Invoice lines bill spot trade transactions, linking trade execution to revenue recognition. Essential for spot market accounting, trade settlement reconciliation, and regulatory reporting of spot vs t',
    `tank_inventory_id` BIGINT COMMENT 'Foreign key linking to refining.tank_inventory. Business justification: Custody transfer invoicing requires tank-level inventory snapshot at time of sale. Links invoice line to specific tank inventory record for volume reconciliation, opening/closing balance verification,',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Refinery revenue accounting requires tracing invoiced refined product volumes to the specific unit run that produced them. This supports yield-to-revenue reconciliation, production cost allocation per',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Invoice lines for project work bill against specific WBS elements. Project billing and AFE cost recovery require line-level WBS traceability for accurate project billing validation and revenue allocat',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well-level invoice line revenue reporting and division order allocation: O&G invoice lines are tied to specific wells for revenue accounting, NRI/WI distribution, and regulatory reporting. Distinct fr',
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
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty who remitted this payment. Links to the party master for crude oil, refined product, or petrochemical sales customers.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_term_contract. Business justification: Payments settle term contract invoices. Essential for contract payment tracking, payment terms compliance verification, and contract credit risk assessment in long-term oil & gas supply agreements.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payments received by specific legal entities for cash management, bank reconciliation, and financial reporting in multi-entity oil & gas operations.',
    `invoice_id` BIGINT COMMENT 'Reference to the revenue invoice against which this payment is applied. Links payment to the originating billing document.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Payments are posted to GL via journal entries for cash accounting. Cash application reconciliation and bank statement matching require tracing payment to its GL posting document.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Payments for oil & gas revenue must be traceable to the lease/property for lease-level cash reconciliation, revenue accounting by property, and audit trail. Critical for property-level financial repor',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Payments settle offtake agreement invoices. Required for offtake payment tracking, partner cash distribution verification, and production sharing agreement (PSA) cash settlement reconciliation in join',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Payments often received from counterparty treasury (not account-specific), especially in JV/PSA contexts where one entity pays for multiple accounts. Cash application and counterparty-level reconcilia',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Cash receipts from JV partners must track the paying partner for partner netting, cash call reconciliation, and default monitoring. Essential for JV cash management and partner credit risk assessment.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Payments for regulatory fees, filing fees, and PSA government take must reference the specific regulatory filing. Essential for government payment reconciliation and audit compliance.',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Direct payments to royalty owners require owner tracking for suspense clearing, escheatment management, and 1099 tax reporting - essential for royalty payment operations.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Payments settle sales order invoices. Required for sales order payment tracking, order closure verification, and customer payment terms compliance monitoring in oil & gas order-to-cash processes.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Payments settle spot trade invoices. Essential for spot trade settlement tracking, trade date vs settlement date reconciliation, and counterparty payment performance monitoring in oil & gas spot marke',
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
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_term_contract. Business justification: Long-term contracts generate receivables for periodic billing cycles. Essential for contract AR management, take-or-pay enforcement, deficiency payment tracking, and contract-level credit exposure mon',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: AR balances owned by specific legal entities for balance sheet reporting, credit management, and SOX compliance in oil & gas operations.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: AR tracking at counterparty (parent entity) level required for consolidated credit exposure monitoring across multiple operating accounts. Credit committees review counterparty-level receivables for l',
    `account_id` BIGINT COMMENT 'Reference to the customer account that owes this receivable. Links to the customer master data for billing and collections.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: AR aging by JV partner is required for partner credit management, default notice triggers, and netting statement preparation. Supports partner-specific collection strategies and forfeiture risk assess',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice that created this receivable. Links to the invoice transaction for detailed line-item analysis.',
    `jib_statement_id` BIGINT COMMENT 'Reference to the JIB statement for joint venture partner billing. Applicable for receivables arising from joint operating agreements and production sharing agreements.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Receivables must be tracked by lease/property for lease-level AR aging, collection management, and property-level financial reporting. Standard practice in oil & gas revenue accounting to manage recei',
    `lifting_program_id` BIGINT COMMENT 'Foreign key linking to commercial.lifting_program. Business justification: Lifting programs generate receivables for partner billings and entitlement settlements. Essential for joint venture AR tracking, equity entitlement billing, and overlift/underlift receivable managemen',
    `marketing_deal_id` BIGINT COMMENT 'Foreign key linking to commercial.marketing_deal. Business justification: Marketing deals generate receivables for product sales and marketing margin realization. Required for marketing AR tracking, deal profitability analysis, and downstream revenue accounting in oil & gas',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Offtake agreements create receivables for entitlement lifting and take-or-pay obligations. Required for offtake AR tracking, partner billing, underlift/overlift settlement, and production sharing agre',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline tariff AR tracking: FERC-regulated pipeline operators track receivables by pipeline segment for tariff revenue collections, shipper credit risk management, and segment-level revenue reporting',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Pricing agreements govern receivable payment terms, retroactive pricing adjustments, and escalation clauses. Required for AR valuation, expected credit loss calculation, and pricing dispute resolution',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: O&G accounts receivable are tracked at the well level for working interest owner billing (JIB) and royalty owner statements. Well-level AR aging reports and collection tracking are standard O&G accoun',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Unpaid regulatory penalties are tracked as receivables (when company assesses penalties to JV partners) or payables. Links penalty assessment to collections process for joint venture penalty allocatio',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Receivables from royalty owners for cost recoveries, JIB billings, or overpayment recoupment need owner tracking for collections, aging analysis, and credit management.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Receivables track outstanding amounts from sales orders for AR aging, credit management, and collection activities. Required for order-to-cash cycle tracking and customer credit risk assessment in oil',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Spot trades generate receivables for trade settlement. Essential for spot market AR management, trade credit risk monitoring, and reconciliation of trade confirmations to cash receipts in oil & gas tr',
    `trade_confirmation_id` BIGINT COMMENT 'Foreign key linking to commercial.trade_confirmation. Business justification: Trade confirmations generate receivables upon confirmation. Essential for confirmed trade AR tracking, counterparty credit exposure monitoring, and reconciliation of trade confirmations to invoices an',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well-level AR aging and collections management: O&G revenue accountants track receivables at the well level for JIB billing, non-operated well revenue collections, and well-level cash flow reporting. ',
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
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_term_contract. Business justification: Cash applied to term contract invoices for contract-level payment tracking. Essential for contract payment compliance monitoring, take-or-pay settlement verification, and contract credit performance a',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cash applications processed within specific legal entities for GL posting, bank reconciliation, and financial reporting in oil & gas operations.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice or receivable item to which the payment is being applied. May be null for on-account payments.',
    `jib_statement_id` BIGINT COMMENT 'Reference to the JIB statement if this cash application relates to joint venture billing. Links payment to COPAS-compliant joint interest billing processes.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Cash application to invoices/receivables must be traceable to lease for property-level cash reconciliation, revenue assurance, and audit trail. Essential for lease-level financial close and variance a',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Cash applied to offtake invoices for entitlement settlement tracking. Required for offtake payment reconciliation, partner cash distribution, and production sharing agreement (PSA) cash flow accountin',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Cash application at counterparty level needed when payments cover multiple accounts or JV settlements. Treasury operations require counterparty-level cash matching for lockbox processing, especially w',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Cash application to JV partner receivables drives partner netting statements and cash call reconciliation. Required for accurate partner account balancing and dispute resolution in joint operations.',
    `payment_id` BIGINT COMMENT 'Reference to the incoming payment that is being applied to receivables. Links to the payment transaction that triggered this cash application event.',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Cash receipts are applied against regulatory penalty invoices (EPA fines, state penalties, NOVs). Cash application teams match incoming payments to penalty assessments, track partial payments, and rec',
    `payment_term_id` BIGINT COMMENT 'Code representing the payment terms applicable to this cash application. Determines discount eligibility and due date calculations.',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Cash applications may apply to royalty owner payments for suspense clearing, requiring owner tracking for proper payment reconciliation and suspense account resolution.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Cash applied to sales order invoices for payment matching and order closure. Required for order-to-cash reconciliation, sales order payment status tracking, and customer payment behavior analysis in o',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Cash applied to spot trade invoices for trade settlement. Essential for spot market cash reconciliation, trade settlement date compliance, and counterparty payment performance tracking in oil & gas tr',
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
    `commercial_term_contract_id` BIGINT COMMENT 'Identifier of the underlying sales contract or term agreement governing the original transaction. Nullable for spot sales. Supports contractual compliance and price reopener tracking.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Credit notes issued by specific legal entities for revenue adjustments, financial reporting, and audit compliance in oil & gas operations.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Credit notes for quality disputes, measurement adjustments, or pricing corrections in crude trading are often issued at counterparty level (not account-specific). Counterparty credit risk monitoring a',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: JV credit notes must identify the partner receiving credit for accurate partner account reconciliation, netting statement adjustments, and dispute tracking. Essential for partner-specific credit manag',
    `crude_receipt_id` BIGINT COMMENT 'Foreign key linking to refining.crude_receipt. Business justification: Credit notes issued for crude quality disputes or volume shortfalls must reference the original crude receipt. This is standard in crude trading — a receipt discrepancy (BSW, API gravity, volume) trig',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice that this credit note adjusts or reverses. Links to the invoice product for traceability.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Credit notes for JV billing disputes must reference the governing JOA for proper allocation, dispute resolution per JOA terms, and audit compliance. Links credit adjustments to joint operating agreeme',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Credit notes generate GL postings for revenue reversal or adjustment. Finance reconciliation requires tracing credit note to the journal entry that posted it for audit and variance analysis.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Credit notes for production revenue adjustments must reference lease for proper revenue reallocation to working interest and royalty owners per lease terms.',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Credit notes for royalty adjustments, government take corrections, and fiscal term disputes reference the governing license. Required for regulatory compliance, license obligation reconciliation, and ',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: NGL quality claims and purity disputes require direct link to capture component_type, purity_percent deviations, and pricing_basis adjustments for credit processing in NGL trading and petrochemical fe',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Credit notes adjust offtake agreement billing for measurement disputes, quality claims, or pricing corrections. Operational necessity for post-lifting billing adjustments.',
    `original_credit_note_id` BIGINT COMMENT 'Reference to the original credit note if this is a reissue or correction. Nullable for first-time issuances. Supports version tracking and audit trails.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Credit notes adjust billing for specific products due to quality deviations, volume disputes, or pricing corrections. Direct product reference required for quality claim validation and revenue adjustm',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline tariff billing dispute credit notes: Credit notes for pipeline measurement errors, over-billing of tariff charges, or capacity reservation disputes reference the specific pipeline segment for',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Credit notes adjust pricing agreement disputes, retroactive pricing corrections, and quality adjustment errors. Required for pricing dispute resolution, retroactive price adjustment tracking, and cont',
    `product_quality_test_id` BIGINT COMMENT 'Foreign key linking to refining.product_quality_test. Business justification: Quality claim credit notes (credit_note.quality_claim_flag) must reference the specific refining lab quality test that substantiated the claim. This is a standard process — a failed quality test trigg',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Credit notes in O&G are issued for well-level measurement disputes, quality claims, and volume adjustments — credit_note has measurement_dispute_flag and quality_claim_flag. Domain experts expect cred',
    `quality_test_result_id` BIGINT COMMENT 'Foreign key linking to product.quality_test_result. Business justification: Credit notes cite specific lab test results as evidence for quality-based claims. Linking to test results provides audit trail for off-spec product credits, supports dispute resolution, and ensures SO',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product quality disputes and off-spec claims require direct link to capture product_grade deviations, quality specification failures, and excise_duty_category adjustments for credit note proce',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Credit notes for royalty payment corrections/adjustments must link to royalty_owner for owner-specific credit tracking, payment reconciliation, and IRS Form 1099 reporting compliance. Critical for roy',
    `run_ticket_id` BIGINT COMMENT 'Foreign key linking to production.run_ticket. Business justification: Credit notes issued for crude oil measurement disputes directly reference the run ticket containing the disputed measurement. Credit_note has measurement_dispute_flag explicitly indicating run ticket ',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Credit notes issued against sales orders for volume shortfalls, quality claims, or pricing adjustments. Direct operational link for order-level billing corrections.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Credit notes correct spot trade billing errors, volume discrepancies, and quality disputes. Essential for spot trade dispute resolution, trade correction tracking, and spot market revenue adjustment a',
    `trade_confirmation_id` BIGINT COMMENT 'Foreign key linking to commercial.trade_confirmation. Business justification: Credit notes adjust trade confirmation disputes, confirmation errors, and settlement discrepancies. Required for trade confirmation dispute resolution, confirmation correction tracking, and trade sett',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Credit notes issued for billing corrections discovered during compliance audits or violation investigations. Links revenue adjustments to root cause compliance events for audit trail and SOX controls.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Credit notes for project work must tie to WBS for project cost/revenue adjustment tracking. Project accounting and AFE budget management require credit-note-to-WBS link for accurate project financial ',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well production measurement dispute credit notes: O&G credit notes for volume measurement errors, quality claims, or allocation disputes reference the specific producing well. Required for well-level ',
    `accounting_period` STRING COMMENT 'Fiscal period (YYYY-MM format) in which the credit note is recognized for financial reporting purposes. Supports period-end close and revenue reconciliation.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
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
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Production revenue allocation requires direct link to crude_grade to capture api_gravity_band, sulfur_classification, and pricing_differential_usd_per_bbl for accurate partner entitlement calculations',
    `division_order_id` BIGINT COMMENT 'Foreign key linking to land.division_order. Business justification: Revenue allocation follows division order decimal interests as the authoritative source for owner entitlement calculations - required for accurate revenue distribution and regulatory compliance.',
    `jib_statement_id` BIGINT COMMENT 'Identifier for the Joint Interest Billing statement that includes this revenue allocation, used for partner billing and reconciliation.',
    `joa_id` BIGINT COMMENT 'Identifier for the Joint Operating Agreement governing the revenue allocation and cost sharing among partners.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Revenue allocation must reference lease agreements to properly distribute revenue according to lease terms, working interest provisions, and royalty rates - core to production revenue accounting.',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: NGL production revenue allocation requires direct link to capture component_type, shrinkage_factor_percent, and component mol percentages for accurate partner entitlement and cost recovery calculation',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Revenue allocation distributes product-specific entitlements to JV partners and PSA participants. Core joint venture accounting requires linking allocated revenue to exact product grades with their pr',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline tariff revenue allocation among JV partners or shippers: Pipeline revenue sharing under JOAs and tariff agreements requires allocation by pipeline segment. Enables segment-level revenue alloc',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Revenue from pooled/unitized production must allocate across pooling unit participants per unit agreement. Pooling_unit defines participating interests, allocation method, and payout status for unitiz',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue allocations to profit centers for segment P&L reporting, field-level profitability analysis, and management reporting in oil & gas operations.',
    `psa_id` BIGINT COMMENT 'Identifier for the Production Sharing Agreement governing cost recovery and profit oil splits with government or national oil company.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: PSA/JOA revenue allocation requires reservoir-level entitlement calculations for cost recovery, profit oil splits, and working interest distributions. Allocation runs reference reservoir OOIP/OGIP for',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Zone-level revenue allocation is required in multi-zone completions where different zones have distinct royalty rates, working interest owners, or PSA cost recovery pools. JOA billing and royalty stat',
    `royalty_owner_id` BIGINT COMMENT 'Identifier for the working interest owner, royalty owner, or partner receiving the allocated revenue.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well-level revenue distribution for division order settlement: O&G revenue allocation to WI owners and royalty owners is performed at the well level per division orders. Direct well_asset reference is',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`recognition_event` (
    `recognition_event_id` BIGINT COMMENT 'Primary key for recognition_event',
    `account_id` BIGINT COMMENT 'Reference to the customer or commercial counterparty to whom the product was sold.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Facility-level revenue recognition for LNG, gas processing, and terminal throughput: ASC 606 performance obligations for facility-based services (processing, liquefaction, terminalling) are recognized',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Revenue recognized upon cargo lifting/delivery per bill of lading. Critical for cargo revenue recognition timing, performance obligation satisfaction, and ASC 606 compliance in crude oil and refined p',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recognition events need cost center for management accounting and variance analysis. Budget tracking and cost allocation require recognition-to-cost-center link for accurate departmental revenue perfo',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Revenue recognition for crude sales requires direct link to crude_grade to capture grade_classification, pricing_differential_usd_per_bbl, and delivery_point for performance obligation tracking and SE',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Revenue recognition timing driven by term contract performance obligations (delivery, title transfer, acceptance). ASC 606 compliance and SEC reporting require linking recognition events to contracts ',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Revenue recognition events are triggered by commercialization of a discovery. Linking recognition_event to discovery supports SEC ASC 932 reserve-to-revenue reconciliation and IFRS 6 disclosure, a sta',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to reservoir.eor_scheme. Business justification: EOR schemes under PSAs create distinct performance obligations for revenue recognition — incremental EOR production revenue is recognized separately from primary recovery under ASC 606. SEC reporting ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition events post to specific GL accounts per ASC 606, IFRS 15, and oil & gas accounting standards for financial reporting.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice associated with this revenue recognition event.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Revenue recognition for JV operations must tie to specific JOAs for partner-specific revenue allocation, working interest-based recognition, and SEC segment reporting by joint venture.',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or production sharing agreement under which this revenue is earned, if applicable.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Revenue recognition events trigger journal entries for GL posting. Audit trail and SOX controls require linking recognition decision to the journal entry that posted it to the ledger.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Revenue recognition events for production sales must tie to lease agreements for proper revenue stream classification, working interest allocation, and SEC reporting.',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Revenue recognition rules under IFRS 15/ASC 606 in oil & gas are governed by license/concession terms (profit oil splits, royalty obligations). Recognition events must reference the license to apply c',
    `lifting_program_id` BIGINT COMMENT 'Foreign key linking to commercial.lifting_program. Business justification: Revenue recognized per lifting program schedule, entitlement volumes, and partner equity shares. Essential for production sharing agreement (PSA) revenue recognition, joint venture accounting, and par',
    `marketing_deal_id` BIGINT COMMENT 'Foreign key linking to commercial.marketing_deal. Business justification: Revenue recognized upon marketing deal delivery and performance obligation satisfaction. Required for marketing revenue recognition timing, deal profitability tracking, and downstream revenue accounti',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: Revenue recognition for NGL sales requires direct link to capture component_type, pricing_basis, and petrochemical_feedstock_flag for distinct revenue stream tracking and performance obligation identi',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Revenue recognition triggered by offtake agreement lifting/delivery (performance obligation satisfaction). IFRS 15 compliance for production sharing and equity crude sales.',
    `original_event_recognition_event_id` BIGINT COMMENT 'Reference to the original revenue recognition event ID if this record is a reversal or adjustment.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Revenue recognition under IFRS 15 requires tracking performance obligations tied to specific product delivery. Product characteristics (grade, quality specs) determine recognition timing and transacti',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline tariff revenue recognition by segment: FERC-regulated pipeline tariff revenue is recognized as transportation service is performed on specific pipeline segments. Segment-level recognition tra',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Recognition events apply pricing agreements for transaction price determination and variable consideration. Required for revenue recognition accuracy, pricing-based revenue calculation, and ASC 606 tr',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: ASC 606/IFRS 15 revenue recognition in O&G requires tying performance obligations to the producing asset. Recognition events triggered by well production delivery/lifting must reference the producing ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Recognition events drive segment P&L. Segment revenue reporting and profitability analysis require recognition-to-profit-center link for accurate segment performance tracking and management reporting.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Revenue recognition for projects must link to project master for project accounting and performance tracking. Project P&L and milestone tracking require recognition-to-project link for accurate projec',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA cost recovery ceilings and profit oil splits directly drive revenue recognition timing and amount. Required for contractor entitlement calculation and host government revenue allocation under prod',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Revenue recognition by partner share is required for JV partner equity reporting, SEC disclosure by partner, and partner-specific financial statement preparation. Links recognition events to partner e',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Revenue recognition for refined product sales requires direct link to capture product_grade, excise_duty_category, and export_domestic_classification for proper revenue stream categorization and SEC r',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Revenue recognition events for PSA cost recovery and profit oil must tie to regulatory submissions. Required for government audit trail and reconciliation of recognized revenue to reported entitlement',
    `reserves_estimate_id` BIGINT COMMENT 'Foreign key linking to reservoir.reserves_estimate. Business justification: SEC revenue recognition rules require coupling with proved reserves bookings. Revenue recognition events must reference the reserves estimate that supports the transaction price allocation and perform',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Revenue recognition events for royalty obligations must link to royalty_owner for owner-specific revenue recognition timing, SEC reporting by interest owner, and IRS 1099 compliance. Required for accu',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order that triggered this revenue recognition event.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Revenue recognition triggered by spot trade delivery/transfer of control. Required for IFRS 15 compliance to link performance obligation satisfaction to specific spot transactions.',
    `trade_confirmation_id` BIGINT COMMENT 'Foreign key linking to commercial.trade_confirmation. Business justification: Revenue recognized upon trade confirmation and delivery. Essential for trade revenue recognition timing, confirmation-based revenue accounting, and ASC 606 compliance in oil & gas spot and term tradin',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Revenue recognition events for refined product sales are triggered by delivery of production output. ASC 606/IFRS 15 revenue recognition for refinery products requires tracing the recognition trigger ',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: ASC 606/IFRS 15 revenue recognition at well level: Performance obligations satisfied upon delivery of production from a specific well trigger recognition events. SEC reserves reporting requires well-l',
    `well_status_history_id` BIGINT COMMENT 'Foreign key linking to drilling.well_status_history. Business justification: Well status changes (e.g., spud→drilling→producing, suspension, reactivation) are defined revenue recognition triggers under ASC 606 and SEC reporting rules. The recognition_event must reference the s',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` (
    `deferred_revenue_id` BIGINT COMMENT 'Unique identifier for the deferred revenue record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer or joint venture partner who made the advance payment or is subject to the take-or-pay arrangement.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Deferred revenue from take-or-pay contracts, prepaid processing fees, or capacity reservations must track to specific facilities for performance obligation fulfillment and ASC 606 revenue recognition.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Prepaid cargo nominations create deferred revenue until cargo lifting and delivery. Required for cargo prepayment tracking, deferred revenue recognition upon bill of lading, and ASC 606 compliance in ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deferred revenue balances need cost center for management reporting and budget tracking. Cost allocation and departmental balance sheet reporting require deferred-revenue-to-cost-center link for accur',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Deferred revenue for crude prepayments and take-or-pay contracts requires direct link to crude_grade to track grade_classification and pricing_differential for future recognition timing and performanc',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Deferred revenue from prepayments or advance billings under term contracts. Contract-specific deferral schedules and amortization patterns required for revenue recognition compliance (ASC 606), especi',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Deferred revenue by JV partner is needed for partner equity reporting, partner-specific balance sheet preparation, and working interest-based revenue recognition schedules. Supports partner financial ',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Deferred revenue from take-or-pay obligations and advance payments in oil & gas is tied to specific fields/discoveries. Field-level deferred revenue tracking is required for SEC disclosure (ASC 932) a',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Deferred revenue posted to specific GL accounts for balance sheet reporting, revenue recognition schedules, and financial compliance in oil & gas.',
    `invoice_id` BIGINT COMMENT 'Reference to the originating invoice that generated the deferred revenue. Links to the invoice master record in SAP FI.',
    `jib_statement_id` BIGINT COMMENT 'Reference to the JIB statement if the deferred revenue relates to joint venture billing under COPAS standards. Links to joint interest billing records.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Deferred revenue from take-or-pay obligations or prepayments needs lease context for performance obligation tracking and proper revenue recognition timing per lease terms.',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Deferred revenue obligations (take-or-pay, advance payments) are governed by license terms and fiscal regime. Linking deferred_revenue to license supports fiscal compliance, SEC disclosure requirement',
    `lifting_program_id` BIGINT COMMENT 'Foreign key linking to commercial.lifting_program. Business justification: Prepaid lifting entitlements create deferred revenue until actual lifting. Essential for lifting program prepayment tracking, deferred revenue recognition per lifting schedule, and joint venture contr',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Prepaid offtake entitlements create deferred revenue until lifting. Essential for offtake prepayment tracking, deferred revenue recognition upon lifting, and production sharing agreement (PSA) contrac',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Deferred revenue tracks product-specific prepayments and performance obligations under IFRS 15. Revenue recognition schedules depend on product delivery milestones and quality acceptance, requiring di',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline capacity reservation deferred revenue (ship-or-pay): Prepaid pipeline capacity fees are deferred until transportation service is rendered on the specific segment. Required for pipeline segmen',
    `production_forecast_id` BIGINT COMMENT 'Foreign key linking to reservoir.production_forecast. Business justification: Deferred revenue release schedules under take-or-pay and prepaid gas contracts depend on production forecasts to determine when performance obligations will be satisfied. ASC 606/IFRS 15 compliance re',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Deferred revenue from take-or-pay contracts and prepaid offtake agreements must be linked to the well whose production will satisfy the performance obligation. ASC 606 performance obligation tracking ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Deferred revenue by profit center supports segment balance sheet reporting. Segment financial reporting and profitability analysis require deferred-revenue-to-profit-center link for accurate segment l',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Deferred revenue on projects must link to project for project balance sheet and milestone tracking. Project accounting requires deferred-revenue-to-project link for accurate project liability and reve',
    `recognition_event_id` BIGINT COMMENT 'Foreign key linking to revenue.recognition_event. Business justification: Deferred revenue tracks amounts billed or received but not yet recognized under IFRS 15 / ASC 606. When the performance obligation is satisfied and the deferred amount is recognized, a recognition_eve',
    `refinery_schedule_id` BIGINT COMMENT 'Foreign key linking to refining.refinery_schedule. Business justification: Deferred revenue for take-or-pay contracts references the refinery schedule to determine when performance obligations will be satisfied (i.e., when scheduled production will occur). This is a named AS',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Deferred revenue for royalty obligations must link to royalty_owner for owner-specific deferral tracking, revenue recognition timing, and compliance with revenue recognition standards (ASC 606) at the',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Prepayments on sales orders create deferred revenue until delivery. Required for prepaid sales order tracking, deferred revenue amortization, and ASC 606 contract liability accounting in oil & gas sal',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well-level deferred revenue for take-or-pay and prepaid production contracts: Deferred revenue obligations tied to delivery from specific wells (e.g., volumetric production payments, prepaid crude con',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`accrual` (
    `accrual_id` BIGINT COMMENT 'Primary key for accrual',
    `account_id` BIGINT COMMENT 'Identifier of the customer or counterparty to whom the product was sold or delivered. Links the accrual to the commercial relationship.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Revenue accruals by partner share support JV partner equity reporting, working interest-based accrual allocation, and partner-specific financial close processes. Required for accurate partner account ',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Cargo accruals for lifted volumes pending final invoice and settlement. Required for cargo revenue accrual, bill of lading vs invoice timing reconciliation, and period-end revenue matching in crude oi',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Revenue accruals posted to specific legal entities for period-end close, financial reporting, and SOX compliance in oil & gas operations.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Revenue accruals for crude production require direct link to crude_grade to capture api_gravity, sulfur_content_percent, and pricing_differential for estimated revenue calculations before final settle',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Accruals for unbilled revenue under term contracts (delivered but not invoiced at period-end). Contract-specific accrual tracking required for accurate period-end close, revenue cut-off testing, and m',
    `drilling_afe_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_afe. Business justification: Month-end revenue accruals for wells in drilling phase reference the authorizing AFE to accrue expected first-production revenue and JIB cost recovery amounts. afe_budget_id covers the budget entity; ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue accruals posted to specific GL accounts for period-end close, financial reporting, and audit trail in oil & gas operations.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Revenue accruals are period-end estimates that are later matched to actual invoices. accrual currently has actual_invoice_number (STRING) but no proper FK. Adding invoice_id (BIGINT) as FK to invoice.',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Period-end revenue accruals must reflect the fiscal terms of the governing license (royalty rates, government take, NRI). Linking accrual to license ensures correct accrual calculations under the appl',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Offtake deliveries accrued pending final settlement and invoicing. Essential for offtake revenue accrual, entitlement delivery tracking, and production sharing agreement (PSA) period-end accounting in',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Period-end revenue accruals require active permit verification (drilling, operating, environmental permits). Revenue accountants validate permit status before recognizing accrued production revenue to',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Transportation cost accruals require segment-level detail for accurate cost matching to revenue periods, regulatory reporting, and shipper billing reconciliation at period close.',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Month-end revenue accruals in O&G are routinely recorded at the facility level (gas plant throughput, compression, terminal liftings) before invoices are received. Accrual already has production_well_',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue accruals allocated to profit centers for segment P&L reporting, field profitability analysis, and management reporting in oil & gas.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Project revenue accruals must tie to project for accurate project financial status. Project accounting and period-end close require accrual-to-project link for accurate project revenue and variance an',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Revenue accruals for royalty obligations must link to royalty_owner for owner-specific accrual tracking, period-end close, and accurate owner-level revenue reporting. Essential for monthly/quarterly f',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Revenue accrued for delivered but unbilled sales orders. Required for period-end revenue accrual, sales order revenue matching, and ASC 606 contract asset accounting in oil & gas sales.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Month-end accruals are adjusted for known violations (spills, flaring exceedances, quality failures). Controllers assess violation impact on revenue recognition, adjusting accruals for expected penalt',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Accruals for project revenue must link to WBS for project financial reporting. Project accounting and period-end close require accrual-to-WBS traceability for accurate project revenue status.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Well-level month-end revenue accrual: O&G revenue accountants accrue production revenue at the well level for non-operated wells where actual invoices lag. Well-level accruals are standard practice fo',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`revenue`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Unique identifier for the settlement record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty receiving the product and subject to this settlement.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Cargo settlements reconcile nominated vs actual lifted volumes, quality specifications, and demurrage. Critical for cargo lifting final settlement, bill of lading reconciliation, and cargo dispute res',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Settlements processed by specific legal entities for final revenue adjustments, financial reporting, and audit compliance in oil & gas operations.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude settlements adjust for actual grade delivered vs contracted, with quality premiums/penalties based on API gravity and sulfur content. Grade-specific assay data drives settlement calculations for',
    `customer_term_contract_id` BIGINT COMMENT 'Foreign key linking to customer.customer_term_contract. Business justification: Settlements reconcile actual deliveries against term contract commitments. Take-or-pay true-ups, volume shortfall penalties, and contract performance tracking require linking settlement records to gov',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Equipment lease and rental settlement processing: O&G operators settle compressor rental, pump lease, and equipment service agreements referencing the specific equipment asset. Required for equipment ',
    `feedstock_blend_id` BIGINT COMMENT 'Foreign key linking to refining.feedstock_blend. Business justification: Crude feedstock purchase settlements reference the feedstock blend record to reconcile actual vs. invoiced volumes and quality. The feedstock_blend captures the actual crude slate processed, which is ',
    `gas_measurement_id` BIGINT COMMENT 'Foreign key linking to production.gas_measurement. Business justification: Gas settlements are reconciled against gas measurement records (corrected_volume_mcf, energy_content_mmbtu) — the gas equivalent of run_ticket for crude oil. O&G gas accounting requires settlement-to-',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: A settlement record reconciles invoiced amounts against actual delivered volumes and quality adjustments — it is fundamentally tied to the original invoice it is settling. The settlement stores invoic',
    `jib_statement_id` BIGINT COMMENT 'Foreign key linking to venture.jib_statement. Business justification: Settlements in joint operations routinely reconcile against JIB statements to resolve variances between operator billings and actual production revenue. This link supports month-end close, audit trail',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Production settlements reconciling invoiced vs actual volumes/prices must reference lease for proper adjustment allocation to working interest and royalty owners.',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Crude lifting settlements and gas sales settlements are governed by license fiscal terms (royalty rates, NRI, WI percentages). Linking settlement to the originating license is required for fiscal regi',
    `marketing_deal_id` BIGINT COMMENT 'Foreign key linking to commercial.marketing_deal. Business justification: Settlements finalize marketing deal transactions, realized prices, and marketing margins. Required for marketing deal profitability finalization, deal performance tracking, and downstream marketing re',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: NGL settlements require direct link to capture component_type, purity_percent, and shrinkage_factor_percent for volume/value reconciliation and pricing adjustments unique to NGL trading and gas plant ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Final settlements reconcile invoiced vs actual product delivered with quality adjustments (API gravity, sulfur content). Custody transfer accounting requires linking settlement adjustments to product ',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline transportation settlements reconcile invoiced vs actual volumes by segment for shipper balancing, overlift/underlift calculations, and dispute resolution per segment operational performance.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Settlements apply pricing agreements for final price calculation, retroactive adjustments, and quality premiums/penalties. Required for pricing settlement accuracy, contract pricing compliance, and pr',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Settlements use benchmark prices for final price calculation in index-based contracts. Market-based pricing requires linking to benchmark definitions for differential application, price adjustment val',
    `product_quality_test_id` BIGINT COMMENT 'Foreign key linking to refining.product_quality_test. Business justification: Settlement quality premium/penalty calculations (settlement.quality_premium_penalty) must reference the specific quality test that drove the adjustment. This is a named business process in refined pro',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Physical delivery settlements reconcile volume/quality adjustments at facility custody transfer points where measurement occurs. Required for custody transfer reconciliation, measurement dispute resol',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: O&G revenue settlements are executed at the well level — net settlement amounts, NRI%, and volume adjustments are well-specific. Settlement has production_facility_id (existing FK) but not production_',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Settlements for project deliverables must tie to project for project P&L and revenue recognition. Project accounting requires settlement-to-project link for accurate project revenue and performance tr',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Settlements compare delivered quality against contracted specifications for quality adjustment calculations. Premium/penalty amounts depend on spec deviations (API gravity, sulfur, RVP); direct link t',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product delivery settlements require direct link to capture product_grade, quality specifications, and excise_duty_category for final price adjustments, quality premiums/penalties, and duty re',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Final settlements for PSA production entitlements and government take reported to regulatory authorities. Required for PSA annual reconciliation and government audit of entitlement calculations.',
    `reversal_settlement_id` BIGINT COMMENT 'Self-referencing FK on settlement (reversal_settlement_id)',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Settlements for royalty payments must link to royalty_owner for owner-specific settlement calculation, payment tracking, and audit trail. Critical for royalty payment processing and owner statement ge',
    `run_ticket_id` BIGINT COMMENT 'Foreign key linking to production.run_ticket. Business justification: Crude oil settlements are reconciled against run tickets — settlement has actual_delivered_volume and volume_adjustment attributes that are verified against run ticket measurements. O&G crude oil acco',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Settlements reconcile sales order actual delivered volumes/quality vs invoiced amounts. Standard post-delivery adjustment process for measurement ticket vs order confirmation variances.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Final settlements must identify the JV partner receiving or paying adjustments for accurate partner account reconciliation, netting statement finalization, and partner-specific settlement reporting.',
    `unit_run_id` BIGINT COMMENT 'Foreign key linking to refining.unit_run. Business justification: Refined product settlements (price/volume true-ups) must reference the unit run that produced the settled volumes. Settlement calculations for margin, yield variance, and production cost recovery requ',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Partner-specific settlements require direct reference to the working interest position to correctly allocate revenue, apply NRI/WI percentages, and support partner-level financial reporting. This link',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Quality violations, measurement disputes, and environmental incidents trigger settlement adjustments. Settlement teams apply penalties, credits, and volume corrections based on documented violations (',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Settlements for capital projects allocate revenue to WBS elements for project P&L. Project accounting requires settlement-to-WBS link for accurate project revenue recognition and performance tracking.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Final settlements for crude/gas sales require well-level traceability for working interest and net revenue interest calculations mandated by joint operating agreements and production sharing agreement',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `oil_gas_ecm`.`revenue`.`payment_term`(`payment_term_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `oil_gas_ecm`.`revenue`.`payment`(`payment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `oil_gas_ecm`.`revenue`.`payment_term`(`payment_term_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_original_credit_note_id` FOREIGN KEY (`original_credit_note_id`) REFERENCES `oil_gas_ecm`.`revenue`.`credit_note`(`credit_note_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_original_event_recognition_event_id` FOREIGN KEY (`original_event_recognition_event_id`) REFERENCES `oil_gas_ecm`.`revenue`.`recognition_event`(`recognition_event_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_recognition_event_id` FOREIGN KEY (`recognition_event_id`) REFERENCES `oil_gas_ecm`.`revenue`.`recognition_event`(`recognition_event_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_reversal_settlement_id` FOREIGN KEY (`reversal_settlement_id`) REFERENCES `oil_gas_ecm`.`revenue`.`settlement`(`settlement_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`revenue` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`revenue` SET TAGS ('dbx_domain' = 'revenue');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `crude_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Receipt Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `customer_lifting_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `offtake_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `product_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Product Movement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Test Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `run_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `tank_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Inventory Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Debtor Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `trade_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `cash_application_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Application Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Credited Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `crude_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Receipt Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `original_credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Original Credit Note ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Test Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `run_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `trade_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Division Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Event Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Scheme Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `original_event_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Event ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Recognizing Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `reserves_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Reserves Estimate Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `trade_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ALTER COLUMN `well_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Well Status History Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Deferring Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `production_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Production Forecast Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `refinery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Identifier');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Accruing Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `customer_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `feedstock_blend_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Blend Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `gas_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Measurement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Statement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Test Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `reversal_settlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `run_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Run Ticket Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Settling Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `unit_run_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
