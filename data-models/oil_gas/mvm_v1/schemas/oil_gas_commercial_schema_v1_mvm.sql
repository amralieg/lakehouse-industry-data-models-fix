-- Schema for Domain: commercial | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`commercial` COMMENT 'Manages upstream and downstream commercial deal-making including term contracts, spot trades, price negotiations, offtake agreements, crude oil marketing, refined product sales, NGL/LNG trading, and petrochemical distribution. Owns trading positions, price differentials, hedging instruments, sales orders, pricing agreements, volume commitments, and commodity marketing aligned with OPEC quota management and WTI/Brent benchmark pricing. Supports revenue recognition and commercial performance tracking. Integrates with SAP SD and trading platforms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` (
    `commercial_term_contract_id` BIGINT COMMENT 'Unique system identifier for the term contract record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Term contracts are executed with specific customer accounts for billing, credit management, and performance tracking. Required for contract-to-cash processes, account-level volume commitment monitorin',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to commercial.credit_limit. Business justification: A commercial term contract is executed within the credit limit framework established for the counterparty. In oil & gas trading, every term contract is governed by a credit limit that caps the maximum',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude supply contracts specify grade for API gravity, sulfur content, and pricing differentials. Business process: crude offtake agreement management and pricing formula application.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical or virtual location where commodity delivery or receipt occurs under this contract (pipeline interconnect, terminal, refinery gate, FPSO, LNG terminal).',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Term crude sale contracts are tied to specific production blocks, particularly in PSA regimes where block-level production determines contract supply volumes. Regulatory export compliance, domestic su',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Term contracts for crude offtake from joint venture production are governed by JOA terms. Links contract to JV operating agreement for working interest allocation, cost recovery, and lifting rights tr',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Term contracts (gas purchase agreements, crude offtake contracts) are tied to production from specific leases for volume commitment tracking, regulatory reporting, and revenue allocation. Essential fo',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Term crude sale contracts must reference the production license under which the crude is produced for export compliance, regulatory reporting, and fiscal regime adherence. License expiry, renewal stat',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Term contracts must identify the operator responsible for lease operations and field management. Critical for contract execution, operational coordination, and joint venture accounting in oil & gas op',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Long-term contracts for production/transportation require valid operating permits and environmental permits. Oil-and-gas companies must link contracts to permits to ensure legal authority to perform c',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Pipeline capacity/transportation term contracts are directly tied to specific pipeline segments. FERC/regulatory filings, tariff management, and capacity allocation reports require linking the commerc',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Term contracts for pooled production must reference the pooling unit for volume allocation among unit participants and proper interest calculations. Essential for unitized field development and produc',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Term contracts for government/contractor equity crude under PSA fiscal regimes. Links contract to PSA for profit oil split, cost recovery ceiling, and entitlement volume calculation per PSA terms.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Contracts reference specific quality specifications that delivered product must meet. Business process: contract compliance verification and quality dispute resolution require formal spec reference.',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Term contracts often reference specific tracts for production sourcing, acreage dedication clauses, and area of mutual interest (AMI) provisions. Tract-level detail is essential for contract complianc',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_qualification. Business justification: Term contracts with vendors must reference current qualification status to ensure contracted vendors maintain required certifications, insurance, and HSE ratings—critical for contract compliance and r',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: In E&P, term sales contracts are often negotiated against specific well production (especially for gas). Production forecasting, reserves-based lending, and revenue recognition require linking the ter',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or addenda executed since the original contract effective date, tracking contract evolution over time.',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve this contract based on value, risk, or strategic importance: manager, director, vice president, executive committee, or board of directors.. Valid values are `manager|director|vice_president|executive|board`',
    `arbitration_clause` STRING COMMENT 'Text or reference to the dispute resolution mechanism: arbitration body (ICC, LCIA, AAA), seat of arbitration, and procedural rules governing commercial disputes.',
    `base_price` DECIMAL(18,2) COMMENT 'Fixed or reference price per unit (per barrel, per MMBTU, per metric ton) before adjustments, differentials, or escalations are applied. Nullable for index-only pricing.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the term contract, used in all commercial correspondence and legal documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the term contract: draft (under negotiation), pending_approval (awaiting executive sign-off), active (in force), suspended (temporarily halted), terminated (ended early), expired (reached natural end), or amended (modification in progress). [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|amended — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the commercial agreement structure: supply (seller obligation), offtake (buyer obligation with take-or-pay), purchase (buyer-initiated), exchange (commodity swap), processing (fee-based conversion), or tolling (third-party processing).. Valid values are `supply|offtake|purchase|exchange|processing|tolling`',
    `contract_value_estimate` DECIMAL(18,2) COMMENT 'Estimated total monetary value of the contract over its full term, calculated as committed volume multiplied by base price, used for revenue forecasting and financial planning.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this term contract record was first created in the source system.',
    `cumulative_deficiency_payments` DECIMAL(18,2) COMMENT 'Total deficiency or shortfall payments invoiced to date due to under-delivery or under-lifting relative to minimum volume obligations.',
    `cumulative_delivered_quantity` DECIMAL(18,2) COMMENT 'Total volume delivered or lifted to date under this contract since the effective date, used to track performance against volume commitments.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which contract pricing and payments are denominated. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AED|CAD — 7 candidates stripped; promote to reference product]',
    `deficiency_payment_rate` DECIMAL(18,2) COMMENT 'Per-unit penalty rate charged when actual delivery or offtake falls below the minimum volume obligation, typically a percentage of the contract price.',
    `delivery_basis` STRING COMMENT 'International Commercial Terms (Incoterms) defining the point at which title and risk transfer: FOB (Free On Board), CIF (Cost Insurance Freight), DES (Delivered Ex Ship), DAP (Delivered At Place), EXW (Ex Works), FCA (Free Carrier).. Valid values are `FOB|CIF|DES|DAP|EXW|FCA`',
    `delivery_schedule_frequency` STRING COMMENT 'Cadence at which deliveries or liftings occur under this contract: daily (continuous flow), weekly, monthly (batch), quarterly, annual, or on-demand (nomination-based).. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `early_termination_penalty` DECIMAL(18,2) COMMENT 'Fixed monetary penalty or liquidated damages payable by the terminating party if the contract is ended before the expiration date without cause.',
    `effective_date` DATE COMMENT 'Date when the term contract becomes legally binding and delivery obligations commence.',
    `expiration_date` DATE COMMENT 'Date when the term contract naturally ends and all obligations cease, unless renewed or extended. Nullable for evergreen contracts.',
    `force_majeure_clause` STRING COMMENT 'Text or reference to the contractual provision that excuses performance due to unforeseeable events (natural disasters, war, regulatory changes, pandemics) beyond the parties control.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law under which the contract is interpreted and disputes are resolved (e.g., State of Texas, English Law, UNCITRAL Arbitration).',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or addendum to the contract. Nullable if no amendments have been executed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this term contract record was most recently updated, tracking data lineage and audit trail.',
    `maximum_volume_limit` DECIMAL(18,2) COMMENT 'Maximum quantity that can be taken or delivered per period without triggering renegotiation or penalty. Defines the upper tolerance band.',
    `minimum_volume_obligation` DECIMAL(18,2) COMMENT 'Minimum quantity that must be taken or delivered per period (monthly, quarterly, annually) under take-or-pay or ship-or-pay provisions. Failure triggers deficiency payments.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date or delivery date within which payment is due, per the contract terms (e.g., Net 30, Net 60).',
    `price_differential` DECIMAL(18,2) COMMENT 'Fixed adjustment (premium or discount) applied to the pricing basis to reflect quality, location, or market conditions. Positive for premium, negative for discount.',
    `pricing_basis` STRING COMMENT 'Benchmark or mechanism used to determine contract price: WTI (West Texas Intermediate), Brent, Dubai crude, Henry Hub (natural gas), Platts index, Argus index, fixed price, or custom formula. [ENUM-REF-CANDIDATE: WTI|Brent|Dubai|Henry_Hub|Platts|Argus|fixed|formula — 8 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration by which either party must provide written notice to exercise or decline the renewal option. Nullable if no renewal option exists.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes an automatic renewal provision or option to extend upon expiration. True if renewal clause exists, False otherwise.',
    `responsible_business_unit` STRING COMMENT 'Internal organizational division or business unit accountable for managing and executing this term contract (e.g., Upstream Marketing, Downstream Sales, LNG Trading).',
    `signed_date` DATE COMMENT 'Date when the contract was formally executed by all parties, establishing legal enforceability.',
    `termination_clause` STRING COMMENT 'Text or reference describing conditions under which either party may terminate the contract early: breach, insolvency, regulatory prohibition, or mutual agreement.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable variance (plus or minus) from committed volume before deficiency or excess charges apply, expressed as a percentage of the commitment.',
    `volume_commitment_quantity` DECIMAL(18,2) COMMENT 'Total contracted volume obligation over the contract term, expressed in the unit of measure specified (barrels, MMBTU, metric tons, cubic meters).',
    `volume_commitment_uom` STRING COMMENT 'Unit of measure for volume commitments: BBL (barrels), MMBTU (million British thermal units), MT (metric tons), MCF (thousand cubic feet), GAL (gallons), M3 (cubic meters).. Valid values are `BBL|MMBTU|MT|MCF|GAL|M3`',
    CONSTRAINT pk_commercial_term_contract PRIMARY KEY(`commercial_term_contract_id`)
) COMMENT 'Master record for long-term commercial agreements governing the sale, purchase, or exchange of crude oil, natural gas, LNG, LPG, NGLs, and refined products — including supply contracts, offtake agreements (take-or-pay), exchange agreements, and processing deals. Captures contract type (supply, offtake, purchase, exchange), delivery basis (FOB, CIF, DES), tenure, volume commitments and minimum volume obligations (MVO), pricing basis (WTI, Brent, Platts), delivery schedule, counterparty, amendment history, and contract status. Includes contractual volume commitment tracking with tolerance bands, deficiency payment rates, and cumulative delivery performance. Serves as the SSOT for all term-based commercial obligations across upstream and downstream operations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`spot_trade` (
    `spot_trade_id` BIGINT COMMENT 'Unique identifier for the spot market trade transaction. Primary key for the spot trade entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Spot trades executed with customer accounts for settlement, invoicing, and credit utilization tracking. Essential for account-level P&L reporting, credit limit monitoring, and reconciling trade confir',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to commercial.credit_limit. Business justification: Spot trades are executed against counterparties who have assigned credit limits. The credit limit governs whether a spot trade can be approved and executed. This FK links spot_trade to the credit_limi',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude oil spot trades require specific grade identification (e.g., Brent, WTI, Dubai) for pricing differentials and quality specifications. Business process: crude trading desk operations and price di',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical location or hub where the commodity will be delivered or received. Links to delivery_point master data.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Spot trades source equity crude from JV production. Links trade to JOA for partner entitlement verification, underlift/overlift tracking, and cargo allocation compliance with JOA lifting programs.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Spot trades of petroleum products require export/import permits for cross-border transactions and environmental permits for handling regulated commodities. Permit validation is mandatory before trade ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Every spot trade transaction must specify which petroleum product is being traded. Core business process: trade execution and settlement requires product identification for pricing, quality specs, and',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Spot trades generate immediate P&L requiring profit center allocation for trading book performance measurement, trader evaluation, and segment reporting. Essential for risk management and financial pe',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Spot trades for contractor/government entitlement crude under PSA. Links trade to PSA for profit oil allocation, cost recovery status verification, and compliance with domestic market obligation requi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Spot trades often involve vendors as service providers (freight forwarders, inspection companies, brokers). Required for vendor payment reconciliation, trade settlement tracking, and vendor performanc',
    `agreed_price` DECIMAL(18,2) COMMENT 'The final negotiated price per unit for the spot trade. This is the absolute price agreed between buyer and seller.',
    `broker_reference` STRING COMMENT 'External broker or intermediary reference number if the spot trade was executed through a broker. Null for direct trades.',
    `confirmation_date` DATE COMMENT 'The date on which the spot trade was formally confirmed by both parties. Used for audit trail and dispute resolution.',
    `confirmation_number` STRING COMMENT 'Trade confirmation reference number exchanged between counterparties to validate the terms of the spot trade.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the spot trade record was first created in the ETRM/CTRM platform. Used for audit trail and data lineage.',
    `delivery_end_date` DATE COMMENT 'The last date of the delivery period for the spot trade. For single-day spot trades, this equals delivery_start_date.',
    `delivery_start_date` DATE COMMENT 'The first date of the delivery period for the spot trade. For single-day spot trades, this equals delivery_end_date.',
    `hedging_instrument_flag` BOOLEAN COMMENT 'Indicates whether this spot trade is designated as a hedging instrument for accounting purposes under IFRS 9 or ASC 815.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining the responsibilities of buyer and seller for transportation, insurance, and risk transfer. FOB=Free On Board, CIF=Cost Insurance Freight, CFR=Cost and Freight, DES=Delivered Ex Ship, DAP=Delivered At Place, EXW=Ex Works.. Valid values are `FOB|CIF|CFR|DES|DAP|EXW`',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the spot trade record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the spot trade record was last updated. Used for change tracking and audit compliance.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Indicates whether this spot trade impacts the companys OPEC production quota compliance tracking. Relevant for NOC (National Oil Company) entities subject to OPEC quotas.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the agreed price. Most oil and gas spot trades are denominated in USD.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `price_differential` DECIMAL(18,2) COMMENT 'The premium or discount relative to the benchmark index (e.g., WTI +2.50 or Brent -1.25). Positive values indicate premium, negative indicate discount. Critical for margin analysis.',
    `price_uom` STRING COMMENT 'Unit of measure basis for the agreed price (e.g., USD per barrel, USD per MMBTU). Must align with volume_uom for P&L calculation.. Valid values are `per_BBL|per_BOE|per_MMBTU|per_MCF|per_MT|per_GAL`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this spot trade must be reported to regulatory authorities such as FERC, CFTC, or EMIR for market transparency and oversight.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions and compliance screening for the counterparty and trade. Ensures compliance with OFAC, EU, and UN sanctions lists.. Valid values are `cleared|pending|flagged|blocked`',
    `settlement_date` DATE COMMENT 'The date on which financial settlement and payment for the spot trade is due. Typically T+2 or T+3 from trade date.',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement process for the spot trade.. Valid values are `pending|partial|complete|disputed`',
    `total_trade_value` DECIMAL(18,2) COMMENT 'The gross monetary value of the spot trade calculated as volume_quantity multiplied by agreed_price. Denominated in price_currency.',
    `trade_date` DATE COMMENT 'The date on which the spot trade was executed and agreed upon between parties. This is the principal business event timestamp for the transaction.',
    `trade_direction` STRING COMMENT 'Indicates whether the company is buying or selling the commodity in this spot trade. Used for position netting and P&L calculation.. Valid values are `buy|sell`',
    `trade_notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to the spot trade. Used for non-standard conditions or trader annotations.',
    `trade_number` STRING COMMENT 'Externally-known business identifier for the spot trade, used for confirmation workflows and counterparty communication. Typically generated by ETRM/CTRM platform.',
    `trade_status` STRING COMMENT 'Current lifecycle status of the spot trade in the trade capture and settlement workflow.. Valid values are `pending|confirmed|settled|cancelled|failed`',
    `trade_timestamp` TIMESTAMP COMMENT 'Precise date and time when the spot trade was struck, including time zone. Used for intraday position management and regulatory reporting.',
    `trading_book` STRING COMMENT 'The internal trading book or portfolio to which this spot trade is allocated. Used for P&L aggregation and risk management.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'The contracted volume of the commodity being traded in the spot transaction. Numeric value paired with volume_uom.',
    `volume_uom` STRING COMMENT 'Unit of measure for the traded volume. BBL=Barrels, BOE=Barrel of Oil Equivalent, MMBTU=Million British Thermal Units, MCF=Thousand Cubic Feet, MMCF=Million Cubic Feet, MT=Metric Tons, GAL=Gallons. [ENUM-REF-CANDIDATE: BBL|BOE|MMBTU|MCF|MMCF|MT|GAL — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_spot_trade PRIMARY KEY(`spot_trade_id`)
) COMMENT 'Transactional record capturing individual spot market trades for crude oil, natural gas, LNG, LPG, NGLs, and refined petroleum products. Records trade date, commodity, grade/specification, volume (BOE, MMCFD, MT), agreed price, price differential to benchmark (WTI/Brent/Henry Hub), counterparty, delivery point, Incoterms, and settlement status. Supports real-time trading position management, P&L tracking, and daily position reporting for the commercial trading desk. Integrates with ETRM/CTRM platforms for trade capture and confirmation workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` (
    `offtake_agreement_id` BIGINT COMMENT 'Unique system identifier for the offtake agreement record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Offtake agreements specify the production facility from which contracted volumes will be sourced. Critical for production allocation, facility capacity planning, and matching commercial commitments to',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Offtake agreements incur operating costs (terminal fees, quality inspection, contract administration) that must be tracked to cost centers for agreement profitability analysis.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Offtake agreements require buyer identity linkage for entitlement calculations, lifting schedule coordination, and revenue recognition. Critical for PSA/JOA equity oil marketing and tracking customer-',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to commercial.credit_limit. Business justification: Offtake agreements involve significant long-term volume and financial commitments that require credit support. The credit_limit record for the buyer/counterparty governs the maximum exposure under the',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude offtake agreements specify grade for pricing and refinery compatibility. Business process: upstream production allocation and crude marketing require grade-specific commitments.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Offtake agreements specify approved inspection vendors for quality certification and quantity verification at delivery points. Required for vendor coordination, invoice validation, and quality assuran',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_qualification. Business justification: Offtake agreements requiring inspection services must track inspector qualification status (API certifications, scope approvals) to ensure quality assurance vendors meet contractual and regulatory req',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Offtake agreements commit production from specific leases/fields to buyers. Critical for PSA/JOA compliance, equity entitlement calculations, and ensuring production volumes match commercial commitmen',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Offtake agreements are legally grounded in the production license that grants the right to produce and sell hydrocarbons. Government-mandated domestic supply obligations, export license requirements, ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Offtake agreements in JV contexts specify which partner has contractual rights to purchase production under PSA/JOA frameworks. The offtake_partner_id identifies the JV partner exercising offtake righ',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Offtake agreements require operator identification to coordinate production delivery from operated leases. Essential for production scheduling, quality assurance, and custody transfer from operator-ma',
    `refinery_id` BIGINT COMMENT 'Foreign key linking to refining.refinery. Business justification: Offtake agreements are facility-specific — they commit production from a named refinery to the offtake buyer. Refinery-level offtake reporting, capacity planning, and force majeure assessment require ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Offtake agreements linked to production facilities require valid production permits and export permits. Oil-and-gas companies must verify permit validity before executing offtake agreements to ensure ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Offtake agreements specify which petroleum product the buyer commits to purchase. Business process: production planning and revenue forecasting require product identification for volume commitments.',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Offtake agreements from pooled units require pooling unit reference for proper entitlement calculations among unit participants. Critical for production allocation in unitized reservoirs with multiple',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Offtake agreements represent major revenue streams requiring profit center assignment for segment P&L reporting, reserve-based lending compliance, SEC disclosure, and management performance evaluation',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Offtake agreements include quality specifications for acceptance criteria. Business process: quality assurance and contract compliance require formal spec reference for dispute resolution.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Offtake agreements with government entities or NOCs require regulatory filings for reserves booking, production entitlements, and quota compliance. Critical for SEC disclosures and host government rep',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Offtake agreements may be tract-specific for dedicated production areas, especially in PSA/concession arrangements where production rights are tied to specific geographic tracts with distinct fiscal t',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Offtake agreements in E&P operations are frequently negotiated at the well or field level, governing volumes produced from a specific well. Production accounting, revenue allocation, and NRI/WI calcul',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the offtake agreement, used in contracts and commercial correspondence.. Valid values are `^[A-Z0-9]{8,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the offtake agreement indicating its operational state and enforceability.. Valid values are `draft|active|suspended|terminated|expired|under_negotiation`',
    `agreement_type` STRING COMMENT 'Classification of the commodity covered by the offtake agreement: crude oil, liquefied natural gas (LNG), liquefied petroleum gas (LPG), natural gas liquids (NGL), refined products, or petrochemicals.. Valid values are `crude_oil|lng|lpg|ngl|refined_products|petrochemicals`',
    `approval_date` DATE COMMENT 'Date when the offtake agreement was formally approved by authorized signatories.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or commercial manager who approved the execution of this offtake agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews for successive periods unless terminated by either party.',
    `contract_document_reference` STRING COMMENT 'File path, document management system identifier, or URL reference to the signed legal contract document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake agreement record was first created in the system.',
    `credit_support_amount` DECIMAL(18,2) COMMENT 'Monetary value of credit support required from the buyer, expressed in the agreement currency.',
    `credit_support_required` BOOLEAN COMMENT 'Indicates whether the buyer is required to provide credit support such as a letter of credit, parent guarantee, or cash collateral.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in the agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_point_location` STRING COMMENT 'Physical location or terminal where the commodity is delivered or lifted, including coordinates, facility name, or port designation.',
    `delivery_schedule_frequency` STRING COMMENT 'Frequency at which commodity deliveries or liftings are scheduled under the agreement.. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `dispute_resolution_method` STRING COMMENT 'Mechanism for resolving disputes arising from the agreement: litigation in specified courts, arbitration under ICC or LCIA rules, or mediation.. Valid values are `litigation|arbitration|mediation`',
    `effective_date` DATE COMMENT 'Date when the offtake agreement becomes legally binding and obligations commence.',
    `environmental_compliance_clause` STRING COMMENT 'Text of provisions requiring compliance with environmental regulations, greenhouse gas (GHG) emissions standards, and environmental social and governance (ESG) commitments.',
    `expiration_date` DATE COMMENT 'Date when the offtake agreement terminates and obligations cease. Nullable for evergreen or indefinite agreements.',
    `force_majeure_clause` STRING COMMENT 'Text of the force majeure provision defining events (natural disasters, war, regulatory changes, pandemics) that excuse non-performance without penalty.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to the interpretation and enforcement of the offtake agreement (e.g., State of Texas, English Law, Singapore Law).',
    `hedging_strategy` STRING COMMENT 'Description of financial hedging instruments (futures, swaps, options) used to manage price risk associated with this offtake agreement.',
    `incoterms` STRING COMMENT 'Incoterms code defining the allocation of costs, risks, and responsibilities between buyer and seller for delivery: Ex Works (EXW), Free on Board (FOB), Cost Insurance and Freight (CIF), Delivered at Place (DAP), or Delivered Duty Paid (DDP).. Valid values are `exw|fob|cif|dap|ddp`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this offtake agreement record was most recently updated.',
    `maximum_volume_commitment` DECIMAL(18,2) COMMENT 'Maximum quantity of commodity that the buyer may purchase under the agreement, establishing an upper bound for offtake obligations.',
    `minimum_volume_commitment` DECIMAL(18,2) COMMENT 'Minimum quantity of commodity that the buyer is obligated to purchase over the agreement period, expressed in barrels of oil equivalent (BOE), thousand cubic feet (MCF), or metric tons.',
    `opec_quota_linkage` STRING COMMENT 'Description of how the offtake agreement volume commitments are coordinated with OPEC production quota allocations, if applicable.',
    `price_benchmark` STRING COMMENT 'Primary market benchmark or index used as the base for pricing: West Texas Intermediate (WTI), Brent, Dubai, Henry Hub for natural gas, Japan Korea Marker (JKM) for LNG, or published indices from Platts or Argus. [ENUM-REF-CANDIDATE: wti|brent|dubai|henry_hub|jkm|platts|argus — 7 candidates stripped; promote to reference product]',
    `price_differential` DECIMAL(18,2) COMMENT 'Fixed adjustment (positive or negative) applied to the benchmark price to reflect quality, location, or market conditions, expressed in currency per unit.',
    `pricing_formula` STRING COMMENT 'Mathematical formula defining how the commodity price is calculated, typically referencing benchmark indices such as West Texas Intermediate (WTI), Brent, or Henry Hub, plus differentials and adjustments.',
    `renewal_term_months` STRING COMMENT 'Duration in months of each automatic renewal period if auto-renewal is enabled.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method for recognizing revenue from this offtake agreement under IFRS 15 or GAAP: point in time (upon delivery), over time (as produced), or bill and hold (invoiced but not yet delivered).. Valid values are `point_in_time|over_time|bill_and_hold`',
    `sanctions_compliance_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes provisions for compliance with international trade sanctions and export controls (OFAC, EU, UN).',
    `seller_entity` STRING COMMENT 'Legal name of the Oil Gas entity or subsidiary that is the seller under this offtake agreement.',
    `take_or_pay_percentage` DECIMAL(18,2) COMMENT 'Percentage of the minimum volume commitment that must be paid for regardless of actual offtake, typically ranging from 70% to 100%.',
    `take_or_pay_provision` BOOLEAN COMMENT 'Indicates whether the agreement includes a take-or-pay clause requiring the buyer to pay for minimum volumes even if not physically lifted.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement, if early termination is permitted.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for volume commitments: barrels (BBL), barrels of oil equivalent (BOE), thousand cubic feet (MCF), million cubic feet (MMCF), metric tons (MT), or million British thermal units (MMBTU).. Valid values are `bbl|boe|mcf|mmcf|mt|mmbtu`',
    CONSTRAINT pk_offtake_agreement PRIMARY KEY(`offtake_agreement_id`)
) COMMENT 'Master record for offtake agreements that obligate a buyer to purchase a specified volume of crude oil, LNG, LPG, or refined products from a producer or facility over a defined period. Captures minimum volume commitments (MVC), take-or-pay provisions, pricing formula, delivery schedule, force majeure clauses, and linkage to upstream production sharing agreements (PSA) or joint operating agreements (JOA). Critical for revenue assurance and production monetization planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`sales_order` (
    `sales_order_id` BIGINT COMMENT 'Unique system identifier for the sales order record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Sales orders for refined or processed products originate from specific facilities (refineries, gas plants). Facility-level revenue reporting, production-to-sales reconciliation, and profit center allo',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Sales orders require contact person linkage for order confirmation, delivery coordination, and issue resolution. Essential for customer communication tracking, order acknowledgment workflows, and logi',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Sales orders may reference underlying procurement contracts (tolling agreements, processing contracts, transportation contracts) that enable product delivery. Required for margin analysis, cost alloca',
    `division_order_id` BIGINT COMMENT 'Foreign key linking to land.division_order. Business justification: Sales orders must reference division orders to ensure proper revenue allocation among working interest owners, royalty owners, and overriding royalty interest holders. Critical for revenue distributio',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Sales orders fulfill from JV production allocated per JOA working interest. Links order to JOA for partner entitlement verification, lifting schedule coordination, and underlift/overlift balance recon',
    `marketing_deal_id` BIGINT COMMENT 'Foreign key linking to commercial.marketing_deal. Business justification: Sales orders are the transactional execution of marketing deals. A marketing deal negotiated by the commercial marketing team results in one or more sales orders for physical delivery. This FK links t',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Sales orders in petroleum product marketing are frequently generated to fulfill specific offtake agreement delivery obligations. The offtake agreement defines the volume commitment and pricing framewo',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Sales orders for petroleum products require permits for transportation, export, and environmental compliance. Permit verification during order fulfillment is a standard business process to ensure regu',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Sales orders must specify which petroleum product is being sold. Business process: order fulfillment, inventory allocation, and revenue recognition require product identification.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Sales orders use pricing agreements for pricing terms. This FK links a sales order to the pricing agreement governing its pricing. Nullable - some sales orders use ad-hoc pricing rather than formal pr',
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty who placed this sales order. Links to the customer master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue recognition requires profit center assignment for segment reporting, management accounting, and performance evaluation. Essential for oil & gas business unit P&L.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Sales orders for PSA entitlement crude (cost oil, profit oil). Links order to PSA for entitlement calculation, cost recovery tracking, and compliance with government take and domestic supply obligatio',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Buy-sell transactions where sales orders reference upstream procurement POs enable margin tracking and cost-of-goods-sold calculation for resold petroleum products—critical for trading operations prof',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product sales (gasoline, diesel, jet fuel) require specific grade identification. Business process: downstream marketing and distribution require refined product specs for pricing and logistic',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Export sales orders require regulatory filings (export licenses, customs declarations, sanctions compliance documentation). Oil-and-gas companies must link orders to regulatory submissions for cross-b',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Sales orders may fulfill royalty-in-kind (RIK) obligations where royalty owners take physical delivery instead of cash payments. Direct link enables RIK tracking, title transfer documentation, and roy',
    `tertiary_sales_bill_to_party_account_id` BIGINT COMMENT 'Reference to the party responsible for payment of the invoice. May differ from the ordering customer or ship-to party.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Sales orders for crude production must be traceable to the producing well for production accounting, royalty calculation, and revenue allocation by working interest. E&P revenue recognition and produc',
    `blocked_for_billing` BOOLEAN COMMENT 'Indicates whether this sales order is currently blocked from invoicing due to pricing disputes, documentation issues, or other business reasons.',
    `blocked_for_delivery` BOOLEAN COMMENT 'Indicates whether this sales order is currently blocked from delivery due to credit hold, compliance review, or other business reasons.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for order cancellation if the order status is cancelled. Null for active orders.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by supply chain and logistics based on product availability and transportation scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this sales order record was first created in the system.',
    `credit_status` STRING COMMENT 'Credit approval status for this sales order indicating whether the customer has sufficient credit limit and the order is approved for fulfillment.. Valid values are `approved|pending|on_hold|rejected`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'The physical location or delivery point where the commodity will be transferred to the customer (e.g., terminal name, pipeline interconnect, port facility).',
    `distribution_channel` STRING COMMENT 'The channel through which the product is sold and distributed (e.g., wholesale, retail, direct, spot market, term contract).',
    `export_license_required` BOOLEAN COMMENT 'Indicates whether an export license or regulatory approval is required for this sales order due to destination country or product classification.',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities, costs, and risks between buyer and seller for delivery (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this sales order record was last updated.',
    `net_order_value` DECIMAL(18,2) COMMENT 'The final net value of the sales order after applying taxes, discounts, and other adjustments. Represents the total amount to be invoiced.',
    `order_date` DATE COMMENT 'The date on which the sales order was created or confirmed with the customer. Represents the business event timestamp for the commercial commitment.',
    `order_number` STRING COMMENT 'Externally visible unique business identifier for the sales order. Used in customer communications, invoicing, and logistics documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order indicating its position in the order-to-cash workflow. [ENUM-REF-CANDIDATE: draft|confirmed|in_progress|shipped|delivered|invoiced|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the sales order based on commercial structure: spot trade, term contract delivery, offtake agreement fulfillment, commodity swap, or product exchange.. Valid values are `spot|term_contract|offtake|swap|exchange`',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this sales order (e.g., Net 30, Net 60, COD, Letter of Credit, prepayment).',
    `price_differential` DECIMAL(18,2) COMMENT 'The premium or discount applied to the pricing basis to arrive at the final unit price. Can be positive (premium) or negative (discount).',
    `pricing_basis` STRING COMMENT 'The benchmark or index used for pricing (e.g., WTI, Brent, Henry Hub, NYMEX, fixed price, cost-plus). Defines how the unit price is determined or adjusted.',
    `regulatory_classification` STRING COMMENT 'Regulatory or compliance classification applicable to this sales order (e.g., export-controlled, sanctioned jurisdiction, EPA-regulated product).',
    `requested_delivery_date` DATE COMMENT 'The delivery date requested by the customer or specified in the commercial agreement.',
    `sales_office` STRING COMMENT 'The specific sales office or regional office that originated or manages this sales order.',
    `sales_organization` STRING COMMENT 'The internal sales organization or business unit responsible for this sales order (e.g., Upstream Marketing, Downstream Retail, LNG Trading).',
    `shipping_priority` STRING COMMENT 'Priority level assigned to this sales order for logistics and delivery scheduling.. Valid values are `standard|expedited|urgent|scheduled`',
    `special_instructions` STRING COMMENT 'Free-text field capturing any special handling, delivery, or documentation instructions specific to this sales order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this sales order based on jurisdiction and product tax classification.',
    `total_order_value` DECIMAL(18,2) COMMENT 'The total monetary value of the sales order calculated as volume quantity multiplied by unit price, before taxes and adjustments.',
    `transportation_mode` STRING COMMENT 'The primary mode of transportation used to deliver the commodity to the customer (pipeline, tanker truck, rail car, barge, ocean vessel).. Valid values are `pipeline|tanker|rail|truck|barge|vessel`',
    `unit_price` DECIMAL(18,2) COMMENT 'The agreed price per unit of measure for the commodity at the time of order confirmation.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'The contracted volume or quantity of the commodity to be delivered under this sales order.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume quantity: Barrels (BBL), Million British Thermal Units (MMBTU), Metric Tons (MT), Gallons (GAL), Cubic Meters (M3), Thousand Cubic Feet (MCF), Million Cubic Feet (MMCF), or Tons (TON). [ENUM-REF-CANDIDATE: BBL|MMBTU|MT|GAL|M3|MCF|MMCF|TON — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sales_order PRIMARY KEY(`sales_order_id`)
) COMMENT 'Transactional record representing a confirmed commercial sales order for petroleum products, crude oil grades, natural gas, LNG, LPG, NGLs, or petrochemicals. Captures order date, commodity, volume, unit of measure (BBL, MMBTU, MT), agreed price, pricing basis, delivery terms (Incoterms), ship-to location, billing party, and order status. Sourced from SAP SD sales order module. Serves as the primary commercial fulfillment trigger linking commercial agreements to logistics and revenue.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` (
    `sales_order_line_id` BIGINT COMMENT 'Unique identifier for the sales order line item. Primary key for the sales order line entity.',
    `cargo_nomination_id` BIGINT COMMENT 'Reference to the lifting nomination or cargo nomination that initiated this sales order line. Used in crude oil and refined product marketing to track nomination-to-order flow.',
    `division_order_id` BIGINT COMMENT 'Foreign key linking to land.division_order. Business justification: Individual sales order lines may have different division order requirements for multi-product shipments or multi-source cargoes with distinct ownership structures. Enables line-level revenue allocatio',
    `hedging_instrument_id` BIGINT COMMENT 'Reference to the financial hedging instrument (futures contract, swap, option) used to hedge the price risk for this sales line item. Links physical sales to financial risk management.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Sales order lines must reference standardized material definitions for order fulfillment, inventory allocation, and logistics planning—material master provides the single source of truth for material ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Order lines specify individual petroleum products being sold. Business process: line-item fulfillment and inventory picking require product identification for each order line.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Sales order line items can reference line-level pricing agreements. This FK links a line item to the pricing agreement governing its pricing. Nullable - line-level pricing may inherit from header or u',
    `sales_order_id` BIGINT COMMENT 'Foreign key reference to the parent sales order header. Links this line item to its containing order.',
    `vessel_id` BIGINT COMMENT 'FK to logistics.vessel',
    `allocation_priority` STRING COMMENT 'Priority ranking for product allocation when supply is constrained. Lower numbers indicate higher priority. Used in supply allocation and scheduling processes.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number issued for this shipment. Serves as the receipt and title document for the cargo.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Confirmed quantity for delivery after allocation, scheduling, and capacity confirmation. This is the committed volume that will be delivered and invoiced.',
    `contract_reference` STRING COMMENT 'Reference to the master contract, term agreement, or Production Sharing Agreement (PSA) that governs the terms of this sale. Links the line item to its contractual framework.',
    `cost_center` STRING COMMENT 'Cost center or profit center to which this sales line item is allocated for financial reporting and performance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales order line record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line item. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|JPY|CNY|AUD — 7 candidates stripped; promote to reference product]',
    `delivery_date` DATE COMMENT 'Scheduled date for commodity delivery or lifting. Represents the target date when the product will be transferred to the customer.',
    `delivery_window_end` TIMESTAMP COMMENT 'End of the delivery time window. Defines the latest acceptable delivery time for this line item.',
    `delivery_window_start` TIMESTAMP COMMENT 'Start of the delivery time window for precise scheduling. Used for cargo loading, pipeline scheduling, and terminal operations coordination.',
    `discharge_port` STRING COMMENT 'Name or code of the discharge port, terminal, or delivery destination where the commodity will be delivered to the customer. Applicable for marine cargo, pipeline destination, or terminal discharge operations.',
    `distribution_channel` STRING COMMENT 'Distribution channel through which the product is sold (e.g., wholesale, retail, spot market, term contract, trading platform). Defines the go-to-market route.',
    `incoterm` STRING COMMENT 'Standard INCOTERMS code defining the delivery terms, risk transfer point, and cost responsibilities between seller and buyer. Common terms: Free On Board (FOB), Cost Insurance and Freight (CIF), Delivered At Place (DAP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `line_amount` DECIMAL(18,2) COMMENT 'Total monetary value for this line item. Calculated as confirmed_quantity multiplied by net_unit_price. Represents the gross revenue for this line before taxes and adjustments.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent sales order. Determines the ordering and position of this line in the order.',
    `line_status` STRING COMMENT 'Current lifecycle status of this sales order line item. Tracks the progression from order creation through delivery and invoicing. [ENUM-REF-CANDIDATE: DRAFT|CONFIRMED|SCHEDULED|IN_TRANSIT|DELIVERED|INVOICED|CANCELLED|ON_HOLD — 8 candidates stripped; promote to reference product]',
    `loading_port` STRING COMMENT 'Name or code of the loading port, terminal, or facility where the commodity will be picked up. Applicable for marine cargo, pipeline origin, or terminal loading operations.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this sales order line record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales order line record was last modified. Audit trail for record updates.',
    `net_unit_price` DECIMAL(18,2) COMMENT 'Final net unit price after applying price differential. Calculated as unit_price plus price_differential. This is the actual price per unit used for revenue calculation.',
    `plant_code` STRING COMMENT 'Code identifying the production plant, refinery, or storage facility from which the product will be sourced for this line item.',
    `price_differential` DECIMAL(18,2) COMMENT 'Price adjustment (premium or discount) applied to the base unit price based on quality, location, delivery terms, or market conditions. Can be positive (premium) or negative (discount).',
    `pricing_basis` STRING COMMENT 'Pricing benchmark or index used to determine the unit price. Common benchmarks: West Texas Intermediate (WTI), Brent, Dubai, Henry Hub (natural gas), New York Mercantile Exchange (NYMEX), Intercontinental Exchange (ICE), Platts, Argus, or fixed contract price. [ENUM-REF-CANDIDATE: WTI|BRENT|DUBAI|HENRY_HUB|NYMEX|ICE|PLATTS|ARGUS|FIXED|INDEX — 10 candidates stripped; promote to reference product]',
    `pricing_date` DATE COMMENT 'Date on which the pricing index or benchmark is applied to determine the final unit price. Used for index-based pricing where the price is set based on market rates on a specific date.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the quantity fields. Common units: Barrel (BBL), Thousand Barrels (MBBL), Million Barrels (MMBBL), Thousand Cubic Feet (MCF), Million Cubic Feet (MMCF), Billion Cubic Feet (BCF), Metric Ton (MT), Kilogram (KG), Gallon (GAL), Thousand Gallons (MGAL), Pound (LB), Ton (TON). [ENUM-REF-CANDIDATE: BBL|MBBL|MMBBL|MCF|MMCF|BCF|MT|KG|GAL|MGAL|LB|TON — 12 candidates stripped; promote to reference product]',
    `remarks` STRING COMMENT 'Free-text remarks, notes, or special instructions specific to this sales order line item. Captures additional context not covered by structured fields.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line item is recognized in the financial statements. Determined by delivery terms, risk transfer, and accounting policy (IFRS 15 or ASC 606).',
    `sales_organization` STRING COMMENT 'Sales organization or business unit responsible for this sales transaction. Used for organizational reporting and commission allocation.',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Originally scheduled or nominated quantity for this line item. Represents the initial volume commitment at order creation time.',
    `storage_location` STRING COMMENT 'Specific storage location, tank, or inventory location within the plant or facility where the product is held prior to delivery.',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable taxes, duties, and levies for this line item. Varies by jurisdiction and product type.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base unit price per unit of measure for this commodity line item. Represents the benchmark or contract price before differentials and adjustments.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this sales order line record.',
    CONSTRAINT pk_sales_order_line PRIMARY KEY(`sales_order_line_id`)
) COMMENT 'Line-item detail of a commercial sales order, representing individual commodity deliveries or product line items within a parent sales order. Captures line number, commodity code, product grade, scheduled quantity, confirmed quantity, unit price, price differential, delivery date, loading port, discharge port, and line status. Enables granular tracking of multi-commodity or multi-delivery orders and supports cargo-level revenue recognition.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` (
    `pricing_agreement_id` BIGINT COMMENT 'Unique identifier for the pricing agreement record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Pricing agreements are often facility-specific (e.g., field-gate pricing, plant-gate pricing). origin_basin is a plain-text denormalization of the source location. Differential pricing analysis and fa',
    `basin_id` BIGINT COMMENT 'Foreign key linking to exploration.basin. Business justification: Pricing agreements are basin-specific: North Sea Brent-linked, Gulf of Mexico WTI-linked, West African Dated Brent differentials. origin_basin is a denormalized text field. A proper FK enables basin-l',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Pricing agreements reference procurement contracts (refining tolling, transportation, storage) that affect cost basis and pricing formulas. Required for cost pass-through calculations, margin analysis',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Pricing agreements negotiated with specific customers for formula-based pricing, differentials, and escalation terms. Essential for customer-specific pricing execution, invoice price calculation, and ',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude pricing agreements specify grade for API/sulfur quality adjustments. Business process: crude pricing formula application requires grade-specific differentials and quality premiums/discounts.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pricing agreements establish revenue recognition patterns requiring GL account mapping for automated revenue accounting, audit trail, SOX compliance, and financial statement preparation. Essential for',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Pricing agreements specify materials with standardized definitions for pricing administration, quality-based differentials, and contract execution—material master provides consistent material classifi',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Pricing agreements often vary by operator due to different lease terms, transportation infrastructure, and quality specifications from operated fields. Operator-specific pricing differentials are comm',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Pricing agreements for regulated commodities require permits for production, transportation, or export. Permit validation during agreement approval ensures compliance with regulatory constraints on pr',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pricing agreements specify which petroleum product the pricing formula applies to. Business process: price calculation and invoice generation require product identification for formula application.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Pricing agreements for PSA entitlement crude incorporate PSA fiscal terms (profit oil split, cost recovery). Links agreement to PSA for contractor/government pricing formulas and revenue allocation ca',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Pricing differentials often vary by tract due to crude quality variations, transportation distances to delivery points, and infrastructure access. Tract-specific pricing is common in fields with heter',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the pricing agreement for business reference and reporting.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the pricing agreement, used in contracts and commercial documentation.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the pricing agreement: draft (under negotiation), active (in force), suspended (temporarily inactive), expired (past expiration date), terminated (cancelled before expiration), or superseded (replaced by newer agreement).. Valid values are `draft|active|suspended|expired|terminated|superseded`',
    `approval_date` DATE COMMENT 'Date on which the pricing agreement was formally approved by authorized commercial management.',
    `basis_differential` DECIMAL(18,2) COMMENT 'Fixed differential (positive or negative) applied to the benchmark price to arrive at the contract price, expressed in currency per unit (e.g., USD per barrel). Positive values indicate premium; negative values indicate discount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the pricing agreement is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_point` STRING COMMENT 'Physical location or hub where the commodity is delivered and priced (e.g., Cushing Oklahoma for WTI, Rotterdam for Brent, Henry Hub for natural gas).',
    `differential_unit` STRING COMMENT 'Unit of measure for the basis differential: USD per barrel (BBL), USD per thousand cubic feet (MCF), USD per million BTU (MMBTU), USD per gallon, USD per metric ton (MT), or USD per kilogram (KG).. Valid values are `usd_per_bbl|usd_per_mcf|usd_per_mmbtu|usd_per_gallon|usd_per_mt|usd_per_kg`',
    `effective_date` DATE COMMENT 'Date on which this pricing agreement becomes effective and applicable to transactions.',
    `escalation_clause` STRING COMMENT 'Description of any automatic price escalation or de-escalation provisions tied to inflation indices, market conditions, or time-based adjustments.',
    `escalation_frequency` STRING COMMENT 'Frequency at which escalation adjustments are applied: monthly, quarterly, semi-annual, annual, or none (no escalation).. Valid values are `monthly|quarterly|semi_annual|annual|none`',
    `escalation_index` STRING COMMENT 'Specific index used for escalation calculations (e.g., CPI, PPI, GDP deflator, custom commodity index).',
    `expiration_date` DATE COMMENT 'Date on which this pricing agreement expires or terminates. Null for open-ended agreements.',
    `freight_adjustment` DECIMAL(18,2) COMMENT 'Fixed or formula-based freight cost adjustment applied to the pricing, covering transportation from origin to delivery point. May be positive (buyer pays) or negative (seller absorbs).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing agreement record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional commercial terms, special conditions, or clarifications related to the pricing agreement.',
    `pricing_formula` STRING COMMENT 'Complete mathematical formula or algorithm used to calculate the final price, including benchmark, differentials, quality adjustments, and freight. Stored as text expression for audit and transparency.',
    `pricing_type` STRING COMMENT 'Classification of the pricing mechanism: fixed (flat price), floating (market-linked), index-linked (benchmark-based), formula-based (calculated), negotiated (bilateral), or spot (one-time market price).. Valid values are `fixed|floating|index_linked|formula_based|negotiated|spot`',
    `quality_adjustment_api` DECIMAL(18,2) COMMENT 'Price adjustment factor based on API gravity of crude oil. Positive or negative differential per degree API variance from the benchmark specification.',
    `quality_adjustment_sulfur` DECIMAL(18,2) COMMENT 'Price adjustment factor based on sulfur content (weight percent). Typically a discount for higher sulfur (sour crude) relative to benchmark (sweet crude).',
    `quality_adjustment_tan` DECIMAL(18,2) COMMENT 'Price adjustment factor based on Total Acid Number, a measure of acidity in crude oil. Higher TAN typically results in price discount due to corrosion risk.',
    `retroactive_period_days` STRING COMMENT 'Number of days after delivery during which retroactive pricing adjustments may be applied, if retroactive pricing is enabled.',
    `retroactive_pricing_flag` BOOLEAN COMMENT 'Indicates whether pricing can be adjusted retroactively after delivery based on final benchmark settlement or quality assay results. True if retroactive adjustments are allowed; False otherwise.',
    `volume_commitment_max` DECIMAL(18,2) COMMENT 'Maximum volume commitment (if any) allowed under this pricing agreement, expressed in the unit of measure specified.',
    `volume_commitment_min` DECIMAL(18,2) COMMENT 'Minimum volume commitment (if any) required under this pricing agreement, expressed in the unit of measure specified.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume commitments: BBL (barrels), BOE (barrels of oil equivalent), MCF (thousand cubic feet), MMCF (million cubic feet), MMBTU (million BTU), gallon, MT (metric ton), KG (kilogram), or M3 (cubic meter). [ENUM-REF-CANDIDATE: bbl|boe|mcf|mmcf|mmbtu|gallon|mt|kg|m3 — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_pricing_agreement PRIMARY KEY(`pricing_agreement_id`)
) COMMENT 'Master record for commercial pricing agreements and benchmark differentials that define the price formula, benchmark reference (WTI, Brent, Platts, NYMEX, Henry Hub), basis differential (positive or negative to benchmark), quality adjustments (API gravity, sulfur content, TAN), freight adjustments, escalation clauses, and validity period applicable to a counterparty or contract. Captures pricing basis type (fixed, floating, index-linked), origin basin differentials, market source (Platts, Argus, OPIS), retroactive pricing provisions, and effective date ranges. Serves as the SSOT for all price determination logic — including published market differentials — used in sales orders, term contracts, and trade confirmations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`trading_position` (
    `trading_position_id` BIGINT COMMENT 'Unique identifier for the trading position record. Primary key.',
    `hedging_instrument_id` BIGINT COMMENT 'Foreign key linking to commercial.hedging_instrument. Business justification: Trading positions include hedging instrument positions. This FK links a trading position to the specific hedging instrument it represents. Nullable - positions can represent physical or financial inst',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Trading positions track exposure to JV equity crude commitments. Links position to JOA for partner entitlement volume, underlift/overlift risk, and mark-to-market valuation of JV production.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to commercial.portfolio. Business justification: Trading positions are organized into portfolios for risk management, P&L attribution, and regulatory reporting. A portfolio aggregates multiple trading positions to compute net exposure, VaR, and mark',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Trading positions reference benchmarks for mark-to-market valuation. Business process: risk management and position valuation require benchmark reference for price exposure calculation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Trading P&L (mark-to-market gains/losses, realized profits) must roll up to profit centers for risk management reporting and trader performance evaluation.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Trading positions for PSA entitlement crude exposure. Links position to PSA for contractor profit oil volume, cost recovery impact on entitlement, and valuation of government/contractor crude position',
    `average_price` DECIMAL(18,2) COMMENT 'The volume-weighted average price of the net position, calculated across all constituent trades, contracts, and hedges. Represents the effective entry price for the position.',
    `boe_equivalent_volume` DECIMAL(18,2) COMMENT 'The net position volume converted to Barrel of Oil Equivalent (BOE) for standardized reporting and aggregation across different commodity types. Uses standard conversion factors (e.g., 6,000 cubic feet of natural gas = 1 BOE).',
    `business_unit` STRING COMMENT 'The business unit or division that owns this position (e.g., Upstream Marketing, Downstream Trading, Midstream Commercial). Used for divisional reporting and performance tracking.',
    `commodity_code` STRING COMMENT 'The standardized code identifying the commodity or product being traded (e.g., WTI crude, Brent crude, natural gas, NGL, LNG, refined products, petrochemicals). Aligns with internal product master and exchange commodity codes.. Valid values are `^[A-Z0-9]{3,10}$`',
    `commodity_grade` STRING COMMENT 'The specific grade, quality, or specification of the commodity (e.g., API gravity for crude oil, sulfur content, octane rating for gasoline). Used to differentiate pricing and valuation.',
    `commodity_name` STRING COMMENT 'The human-readable name of the commodity or product (e.g., West Texas Intermediate Crude Oil, Liquefied Natural Gas, Propane, Gasoline).',
    `counterparty_concentration_pct` DECIMAL(18,2) COMMENT 'The percentage of the position volume concentrated with the largest counterparty. Used to assess counterparty credit risk concentration and diversification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trading position record was first created in the system. Used for audit trail and data lineage.',
    `delivery_location` STRING COMMENT 'The specific delivery location, hub, or terminal for physical commodity delivery (e.g., Cushing Oklahoma for WTI, Rotterdam for Brent, Henry Hub for natural gas). Affects pricing differentials and logistics.',
    `delta_equivalent_volume` DECIMAL(18,2) COMMENT 'The delta-adjusted volume of the position, accounting for the price sensitivity of options and other non-linear instruments. For physical and futures positions, delta is 1.0; for options, delta ranges from 0 to 1. Used for aggregated risk reporting.',
    `financial_hedge_volume` DECIMAL(18,2) COMMENT 'The net volume of financial hedging instruments (futures, swaps, options) contributing to the position. Used to assess the degree of hedging and residual exposure.',
    `geographic_region` STRING COMMENT 'The primary geographic region or market where the commodity is sourced, delivered, or traded (e.g., North America, Middle East, Asia-Pacific, Europe). Used for regional risk analysis and market segmentation.',
    `hedge_effectiveness_ratio` DECIMAL(18,2) COMMENT 'The ratio of financial hedge volume to physical volume, expressed as a percentage. Indicates the degree to which the physical position is hedged. A ratio of 100% indicates full hedging; below 100% indicates under-hedging; above 100% indicates over-hedging.',
    `instrument_type` STRING COMMENT 'The type of trading instrument contributing to the position (e.g., physical trade, futures contract, swap, option, forward contract). Used to segment risk by instrument class.. Valid values are `physical|futures|swap|option|forward`',
    `last_valuation_timestamp` TIMESTAMP COMMENT 'The timestamp when the position was last revalued and mark-to-market calculations were performed. Used for audit trail and data freshness verification.',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'The current fair value of the net position calculated by multiplying the net volume by the current market price. Represents the unrealized gain or loss on the position.',
    `market_price` DECIMAL(18,2) COMMENT 'The current market price or spot price of the commodity at the position date, used for mark-to-market valuation. Sourced from benchmark indices or market data providers.',
    `net_volume` DECIMAL(18,2) COMMENT 'The net open volume of the commodity position after netting all long and short physical trades, term contracts, and financial hedges. Positive for long positions, negative for short positions.',
    `opec_quota_allocation` DECIMAL(18,2) COMMENT 'The OPEC production quota allocation applicable to this position, if relevant. Used for compliance monitoring and production planning in OPEC member countries or joint ventures subject to OPEC quotas.',
    `opec_quota_utilization_pct` DECIMAL(18,2) COMMENT 'The percentage of the OPEC quota allocation utilized by this position, calculated as (net volume / quota allocation) * 100. Used for OPEC compliance reporting.',
    `physical_volume` DECIMAL(18,2) COMMENT 'The net volume of physical commodity trades (spot and term contracts) contributing to the position, excluding financial hedges. Used to separate physical exposure from financial hedging activity.',
    `position_date` DATE COMMENT 'The business date on which this trading position snapshot was captured and valued. Represents the as-of date for mark-to-market valuation and risk exposure calculation.',
    `position_status` STRING COMMENT 'The current lifecycle status of the trading position (e.g., open for active positions, closed for fully settled positions, settled for positions awaiting final reconciliation, cancelled for voided positions).. Valid values are `open|closed|settled|cancelled`',
    `position_type` STRING COMMENT 'Indicates whether the net position is long (net buyer), short (net seller), or flat (balanced). Determines directional price exposure.. Valid values are `long|short|flat`',
    `price_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the average price and mark-to-market value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `price_unit` STRING COMMENT 'The unit of measure for pricing (e.g., USD per barrel, USD per MMBTU, USD per metric ton). Defines the denominator for the average price.',
    `stress_test_result` DECIMAL(18,2) COMMENT 'The estimated profit or loss on the position under the specified stress test scenario. Negative values indicate losses; positive values indicate gains.',
    `stress_test_scenario` STRING COMMENT 'The name or identifier of the stress test scenario applied to the position (e.g., Oil Price Crash -30%, OPEC Production Cut, Geopolitical Crisis). Used to assess position resilience under extreme market conditions.',
    `tenor_bucket` STRING COMMENT 'The time-to-maturity bucket for the position, used to classify exposure by delivery or settlement period (e.g., spot, 1 month, 3 months, 6 months, 1 year, 2 years, 3 years, 5 years, 10 years). Supports term structure risk analysis. [ENUM-REF-CANDIDATE: spot|1M|3M|6M|1Y|2Y|3Y|5Y|10Y — 9 candidates stripped; promote to reference product]',
    `trading_book` STRING COMMENT 'The trading book or portfolio to which this position is assigned (e.g., Crude Trading, Gas Marketing, Refined Products, Petrochemicals). Used for book-level risk aggregation and P&L reporting.',
    `unrealized_pnl` DECIMAL(18,2) COMMENT 'The unrealized profit or loss on the position, calculated as the difference between the mark-to-market value and the cost basis (average price times net volume). Positive for gains, negative for losses.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this trading position record was last modified. Used for change tracking and audit trail.',
    `valuation_method` STRING COMMENT 'The method used to value the position (e.g., market for observable market prices, model for model-derived valuations, cost for cost-basis valuation). Aligns with IFRS 13 fair value hierarchy.. Valid values are `market|model|cost`',
    `value_at_risk` DECIMAL(18,2) COMMENT 'The estimated maximum potential loss on the position over a specified time horizon (typically 1 day or 10 days) at a given confidence level (typically 95% or 99%). Calculated using historical simulation, variance-covariance, or Monte Carlo methods.',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'The confidence level used for the VaR calculation, expressed as a percentage (e.g., 95.00, 99.00). Indicates the probability that actual losses will not exceed the VaR estimate.',
    `var_time_horizon_days` STRING COMMENT 'The time horizon over which the VaR is calculated, expressed in days (e.g., 1, 10). Represents the holding period assumption for the risk estimate.',
    `volume_unit` STRING COMMENT 'The unit of measure for the net volume (e.g., BOE for Barrel of Oil Equivalent, BBL for barrels, MMBTU for million British thermal units, MCF for thousand cubic feet, MMCF for million cubic feet, MT for metric tons, GAL for gallons). [ENUM-REF-CANDIDATE: BOE|BBL|MMBTU|MCF|MMCF|MT|GAL — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_trading_position PRIMARY KEY(`trading_position_id`)
) COMMENT 'Transactional record representing the net open commercial trading position and commodity price exposure for a commodity, grade, or product across all physical trades, term contracts, and financial hedging instruments at a given valuation date. Captures long/short position, commodity, volume in BOE or MMCFD, average price, mark-to-market value, position date, delta-equivalent volume, value-at-risk (VaR), stress-test scenario results, and risk exposure by tenor bucket and instrument type (physical, futures, swaps, options). Supports daily position reporting, OPEC quota compliance monitoring, commercial risk management, and treasury reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` (
    `hedging_instrument_id` BIGINT COMMENT 'Primary key for hedging_instrument',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Hedge instruments must map to specific GL accounts per hedge accounting standards (ASC 815/IFRS 9) for financial statement preparation, hedge effectiveness testing, fair value measurement, and audit t',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Hedging instruments protect JV production revenue. Links hedge to JOA for partner entitlement volume hedged, hedge effectiveness per working interest, and revenue protection for JV equity crude.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to commercial.portfolio. Business justification: Hedging instruments are managed within portfolios for hedge accounting, effectiveness testing, and risk reporting. A portfolio may contain both physical trading positions and financial hedging instrum',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Hedging instruments reference benchmarks for strike price and settlement. Business process: hedge accounting and effectiveness testing require benchmark reference for valuation.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Hedges for PSA entitlement crude revenue. Links hedge to PSA for contractor profit oil volume hedged, cost recovery impact, and revenue protection for government/contractor crude sales.',
    `business_unit` STRING COMMENT 'The organizational division or business segment that owns the hedged exposure (e.g., Upstream E&P, Downstream Refining, Midstream Marketing).',
    `ceiling_price` DECIMAL(18,2) COMMENT 'The maximum price capped by the hedging instrument, applicable to collars and call options. Limits upside participation in exchange for downside protection.',
    `collateral_amount` DECIMAL(18,2) COMMENT 'The amount of cash or securities posted as collateral or margin to support the hedging instrument position.',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether the hedging instrument requires posting of collateral or margin with the counterparty or clearinghouse.',
    `contract_reference` STRING COMMENT 'External contract or confirmation number provided by the counterparty or trading platform for reconciliation and audit purposes.',
    `cost_center` STRING COMMENT 'The accounting cost center to which hedging gains, losses, and premiums are allocated for financial reporting and performance measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this hedging instrument record was first created in the system. Used for audit trail and data lineage.',
    `cumulative_gain_loss` DECIMAL(18,2) COMMENT 'The total realized and unrealized gain or loss on the hedging instrument since inception. Used for performance tracking and financial reporting.',
    `effective_date` DATE COMMENT 'The date from which the hedging instrument becomes active and hedge accounting treatment begins, if designated.',
    `effectiveness_test_result` STRING COMMENT 'Outcome of the most recent hedge effectiveness test. Highly effective hedges qualify for hedge accounting treatment; ineffective hedges require mark-to-market through profit and loss.. Valid values are `highly_effective|ineffective|not_tested`',
    `fair_value_amount` DECIMAL(18,2) COMMENT 'The current mark-to-market valuation of the hedging instrument based on observable market prices or valuation models. Updated regularly for financial reporting.',
    `fair_value_as_of_date` DATE COMMENT 'The valuation date for the fair value amount. Typically month-end or quarter-end for financial reporting purposes.',
    `fair_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the fair value amount.. Valid values are `^[A-Z]{3}$`',
    `floor_price` DECIMAL(18,2) COMMENT 'The minimum price guaranteed by the hedging instrument, applicable to collars and put options. Protects against downside price risk.',
    `hedge_designation` STRING COMMENT 'Accounting classification of the hedge relationship under IFRS 9 or ASC 815. Determines whether gains/losses flow through profit and loss or other comprehensive income.. Valid values are `fair_value_hedge|cash_flow_hedge|net_investment_hedge|economic_hedge_no_designation`',
    `hedge_effectiveness_method` STRING COMMENT 'The quantitative or qualitative method used to assess whether the hedging relationship meets the effectiveness criteria under IFRS 9 or ASC 815 (80-125% effectiveness range).. Valid values are `dollar_offset|regression_analysis|variance_reduction|critical_terms_match`',
    `hedge_purpose` STRING COMMENT 'Business rationale for the hedging instrument, such as protecting production revenue, locking in refining margins, managing feedstock costs, or stabilizing cash flows for capital expenditure (CAPEX) planning.',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'The proportion of the underlying exposure that is hedged by this instrument, expressed as a decimal (e.g., 0.8000 represents 80% hedged). Used in hedge effectiveness testing.',
    `hedge_status` STRING COMMENT 'Current lifecycle state of the hedging instrument. Active instruments are monitored for effectiveness testing and mark-to-market valuation.. Valid values are `active|matured|terminated|cancelled|suspended`',
    `ineffectiveness_amount` DECIMAL(18,2) COMMENT 'The portion of the hedging instruments gain or loss that does not qualify for hedge accounting treatment and must be recognized immediately in profit and loss.',
    `instrument_number` STRING COMMENT 'External business identifier for the hedging instrument, typically assigned by the trading platform or counterparty. Used for reconciliation and external reporting.',
    `instrument_type` STRING COMMENT 'Classification of the hedging instrument by derivative structure. Determines valuation methodology and accounting treatment under IFRS 9 and ASC 815. [ENUM-REF-CANDIDATE: futures|options|swaps|collars|forwards|basis_swaps|swaptions — 7 candidates stripped; promote to reference product]',
    `last_effectiveness_test_date` DATE COMMENT 'The most recent date on which hedge effectiveness testing was performed. Required quarterly or more frequently under hedge accounting standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this hedging instrument record was most recently updated. Used for audit trail and change tracking.',
    `maturity_date` DATE COMMENT 'The date on which the hedging instrument expires or settles. Determines the hedging horizon and effectiveness testing period.',
    `netting_agreement_flag` BOOLEAN COMMENT 'Indicates whether a master netting agreement (e.g., ISDA Master Agreement) is in place with the counterparty, allowing offsetting of exposures for credit risk purposes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or contextual information about the hedging instrument that does not fit structured fields.',
    `notional_volume` DECIMAL(18,2) COMMENT 'The quantity of the underlying commodity covered by the hedging instrument, expressed in the unit of measure specified. Represents the exposure being hedged.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The upfront cost paid to acquire the hedging instrument, typically for options. Amortized over the life of the instrument or expensed based on accounting policy.',
    `premium_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the premium amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the hedging instrument must be reported to regulatory authorities such as CFTC, SEC, or FERC under derivatives reporting requirements.',
    `settlement_date` DATE COMMENT 'The actual date on which the hedging instrument was settled and cash flows exchanged. May differ from maturity date for early terminations.',
    `strike_price` DECIMAL(18,2) COMMENT 'The fixed price at which the hedging instrument can be exercised (for options) or the reference price for settlement (for swaps and collars). Expressed in currency per volume unit.',
    `trade_date` DATE COMMENT 'The date on which the hedging instrument was executed and the contract was entered into with the counterparty.',
    `trading_platform` STRING COMMENT 'The exchange or over-the-counter (OTC) platform where the hedging instrument was traded (e.g., NYMEX, ICE, CME, bilateral OTC).',
    `underlying_commodity` STRING COMMENT 'The commodity or product that the hedging instrument references. Aligns with WTI (West Texas Intermediate), Brent crude benchmarks, Henry Hub natural gas pricing, and refined product markets. [ENUM-REF-CANDIDATE: crude_oil_wti|crude_oil_brent|natural_gas_henry_hub|ngl|lpg|gasoline|diesel|jet_fuel|heating_oil|residual_fuel — 10 candidates stripped; promote to reference product]',
    `volume_unit` STRING COMMENT 'Unit of measure for the notional volume. BBL (Barrels), BOE (Barrel of Oil Equivalent), MCF (Thousand Cubic Feet), MMCF (Million Cubic Feet), MMBTU (Million British Thermal Units) are standard oil and gas units. [ENUM-REF-CANDIDATE: bbl|boe|mcf|mmcf|mmbtu|gallons|metric_tons — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hedging_instrument PRIMARY KEY(`hedging_instrument_id`)
) COMMENT 'Master record for financial hedging instruments used to manage commodity price risk, including futures contracts, options, swaps, and collars on crude oil (WTI, Brent), natural gas (Henry Hub), and refined products. Captures instrument type, underlying commodity, notional volume, strike price, premium, hedge ratio, maturity date, counterparty (bank/broker), hedge designation (fair value vs. cash flow hedge), and IFRS 9 / ASC 815 hedge accounting classification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` (
    `hedging_transaction_id` BIGINT COMMENT 'Primary key for hedging_transaction',
    `hedging_instrument_id` BIGINT COMMENT 'Reference to the parent hedge instrument or hedging program under which this transaction was executed.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Hedge transactions for JV production revenue protection. Links transaction to JOA for partner entitlement volume hedged, hedge allocation per working interest, and hedge effectiveness reporting to JV ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Hedging P&L (realized and unrealized gains/losses) must be allocated to profit centers for hedge effectiveness reporting and segment performance measurement.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Hedge transactions for PSA entitlement crude. Links transaction to PSA for contractor profit oil hedged, cost recovery impact on hedge allocation, and revenue protection for government/contractor crud',
    `sales_order_id` BIGINT COMMENT 'Reference to the underlying physical sales order or term contract that this hedge transaction is protecting against price risk.',
    `trading_position_id` BIGINT COMMENT 'Foreign key linking to commercial.trading_position. Business justification: Hedging transactions affect trading positions. This FK links a hedging transaction to the trading position it impacts. Nullable - hedging can be position-specific or portfolio-level.',
    `benchmark_index` STRING COMMENT 'The pricing benchmark or index against which the hedge transaction is referenced (e.g., WTI, Brent, Henry Hub, NYMEX).',
    `broker_name` STRING COMMENT 'Name of the broker or intermediary who facilitated the execution of this hedge transaction.',
    `business_unit` STRING COMMENT 'The business unit or division responsible for this hedge transaction (e.g., Upstream Marketing, Downstream Trading, NGL Trading).',
    `ceiling_price` DECIMAL(18,2) COMMENT 'The ceiling price for collar hedge structures, representing the maximum price participation level.',
    `commodity_grade` STRING COMMENT 'Specific grade or quality specification of the commodity being hedged (e.g., WTI, Brent, Henry Hub, RBOB gasoline).',
    `commodity_type` STRING COMMENT 'The type of commodity being hedged: crude oil, natural gas, Natural Gas Liquids (NGL), Liquefied Natural Gas (LNG), Liquefied Petroleum Gas (LPG), refined product, or petrochemical. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|ngl|lng|lpg|refined_product|petrochemical — 7 candidates stripped; promote to reference product]',
    `cost_center` STRING COMMENT 'The cost center code to which the hedge transaction costs and gains/losses are allocated.',
    `counterparty_name` STRING COMMENT 'Name of the counterparty on the other side of the hedge transaction, particularly relevant for OTC trades.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hedge transaction record was first created in the system.',
    `exchange_name` STRING COMMENT 'Name of the exchange where the hedge transaction was executed, if applicable (e.g., NYMEX, ICE, CME).',
    `executed_price` DECIMAL(18,2) COMMENT 'The price at which the hedge transaction was executed, representing the locked-in or strike price for the hedged volume.',
    `execution_date` DATE COMMENT 'The date on which the hedge transaction was executed and booked in the market.',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the hedge transaction was executed, including time zone information.',
    `floor_price` DECIMAL(18,2) COMMENT 'The floor price for collar hedge structures, representing the minimum price protection level.',
    `hedge_accounting_designation` STRING COMMENT 'The hedge accounting designation under IFRS 9 or ASC 815: cash flow hedge, fair value hedge, net investment hedge, or not designated for hedge accounting.. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `hedge_effectiveness_ratio` DECIMAL(18,2) COMMENT 'The calculated hedge effectiveness ratio, expressed as a percentage, used to determine hedge accounting qualification under IFRS 9 or ASC 815.',
    `hedge_effectiveness_test_method` STRING COMMENT 'The method used to test hedge effectiveness for accounting purposes: dollar offset method, regression analysis, or variance reduction method.. Valid values are `dollar_offset|regression_analysis|variance_reduction`',
    `hedge_instrument_type` STRING COMMENT 'The type of derivative instrument used for this hedge transaction: futures contract, swap agreement, option contract, collar structure, or forward contract.. Valid values are `futures|swap|option|collar|forward`',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'The current mark-to-market valuation of the hedge transaction, representing unrealized gain or loss.',
    `mtm_valuation_date` DATE COMMENT 'The date as of which the mark-to-market value was calculated.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the hedge transaction, including special terms, execution rationale, or operational remarks.',
    `notional_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the notional value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `notional_value` DECIMAL(18,2) COMMENT 'The total notional value of the hedge transaction, calculated as volume hedged multiplied by executed price.',
    `premium_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the premium amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `premium_paid` DECIMAL(18,2) COMMENT 'The premium amount paid for option-based hedge instruments (e.g., call options, put options, collars). Null for futures and swaps.',
    `premium_received` DECIMAL(18,2) COMMENT 'The premium amount received for option-based hedge instruments where the company sold an option (e.g., collar structures). Null for futures and swaps.',
    `price_uom` STRING COMMENT 'Unit of measure for the executed price: USD per barrel, USD per BOE, USD per MCF, USD per MMBTU, USD per gallon, or USD per tonne.. Valid values are `usd_per_bbl|usd_per_boe|usd_per_mcf|usd_per_mmbtu|usd_per_gallon|usd_per_tonne`',
    `profit_center` STRING COMMENT 'The profit center code to which the hedge transaction revenue and margin are attributed.',
    `settlement_date` DATE COMMENT 'The date on which the hedge transaction will be settled and cash flows exchanged.',
    `strike_price` DECIMAL(18,2) COMMENT 'The strike price for option-based hedge instruments, representing the price at which the option can be exercised.',
    `trader_name` STRING COMMENT 'Name of the trader or trading desk personnel who executed this hedge transaction.',
    `transaction_number` STRING COMMENT 'Externally-known unique business identifier for this hedge transaction, typically assigned by the trading platform or broker.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the hedge transaction in the trading and settlement workflow.. Valid values are `executed|settled|cancelled|pending|expired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this hedge transaction record was last updated in the system.',
    `venue_type` STRING COMMENT 'Indicates whether the hedge transaction was executed on a regulated exchange or over-the-counter (OTC).. Valid values are `exchange|otc`',
    `volume_hedged` DECIMAL(18,2) COMMENT 'The quantity of commodity volume covered by this hedge transaction.',
    `volume_uom` STRING COMMENT 'Unit of measure for the hedged volume: barrels (BBL), Barrel of Oil Equivalent (BOE), thousand cubic feet (MCF), million cubic feet (MMCF), million British thermal units (MMBTU), gallon, tonne, or metric tonne (MT). [ENUM-REF-CANDIDATE: bbl|boe|mcf|mmcf|mmbtu|gallon|tonne|mt — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hedging_transaction PRIMARY KEY(`hedging_transaction_id`)
) COMMENT 'Transactional record capturing individual hedge execution events — the actual booking of a futures, swap, option, or collar trade against a specific hedge instrument or hedging program. Records execution date, exchange or OTC venue, broker, volume hedged, executed price, premium paid/received, settlement date, and linkage to the underlying physical exposure (sales order or term contract). Supports hedge effectiveness testing and mark-to-market valuation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` (
    `cargo_nomination_id` BIGINT COMMENT 'Unique identifier for the cargo nomination record. Primary key for the cargo nomination entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Cargo nominations reference the source production or processing facility (distinct from the loading terminal). Production scheduling, quality certification, and customs export documentation require li',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the term contract or spot trade agreement under which this cargo is nominated.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cargo nominations incur logistics costs (demurrage, inspection, handling) requiring cost center allocation for operational cost tracking, JV cost allocation, budget variance analysis, and lifting econ',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude cargo nominations specify grade for loading terminal allocation and quality verification. Business process: crude export operations require grade-specific cargo planning.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Cargo operations require terminal-specific emergency response plans (Coast Guard Facility Response Plans, port authority requirements). Each cargo nomination must reference the applicable ERP for the ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Cargo nominations specify inspection vendors for quality/quantity certification at loading/discharge. Required for vendor coordination, invoice reconciliation, and performance tracking. Replaces denor',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Cargo nominations specify materials being lifted and require standardized material definitions for quality specifications, handling procedures, and hazmat classification—essential for safe cargo opera',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Cargo nominations in JV operations must track which partner is exercising their lifting rights under the JOA/PSA. The nominating_partner_id links the cargo to the specific JV partner entitled to lift,',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Cargo nominations must specify the operator managing production source for lifting coordination, production allocation verification, and operational contact for loading operations at operator-controll',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Cargo nominations specify which petroleum product is being lifted. Business process: cargo scheduling and vessel loading require product identification for terminal allocation.',
    `terminal_id` BIGINT COMMENT 'Reference to the terminal or port facility where the cargo will be loaded onto the vessel.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Cargo revenue must be allocated to profit centers for crude marketing P&L, enabling field-level profitability tracking and netback pricing analysis.',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Royalty-in-kind cargo nominations require explicit royalty owner identification for production allocation, cargo title transfer, and delivery instructions when royalty owners elect to take physical vo',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to logistics.vessel. Business justification: Cargo nominations specify the assigned vessel. cargo_nomination has denormalized vessel_name and vessel_imo_number plain attributes. A proper FK to vessel enables vessel vetting status checks, SIRE in',
    `bill_of_lading_number` STRING COMMENT 'Reference number for the bill of lading document that serves as receipt, contract of carriage, and document of title for the cargo.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cargo nomination record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing and settlement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether customs clearance procedures are required for this cargo movement based on origin and destination jurisdictions.',
    `demurrage_rate` DECIMAL(18,2) COMMENT 'Daily rate charged for delays beyond the agreed laytime at loading or discharge terminals.',
    `discharge_port_code` STRING COMMENT 'Five-character UN/LOCODE for the destination discharge port where the cargo will be unloaded.. Valid values are `^[A-Z]{5}$`',
    `export_license_number` STRING COMMENT 'Reference number for any required export license or authorization from the origin country regulatory authority.',
    `freight_rate` DECIMAL(18,2) COMMENT 'Transportation cost per unit for shipping the cargo from loading port to discharge port, if applicable under the contract terms.',
    `import_license_number` STRING COMMENT 'Reference number for any required import license or authorization from the destination country regulatory authority.',
    `incoterm` STRING COMMENT 'Incoterm defining the division of costs and risks between buyer and seller (FOB=Free On Board, CFR=Cost and Freight, CIF=Cost Insurance and Freight, DES=Delivered Ex Ship, DEQ=Delivered Ex Quay).. Valid values are `FOB|CFR|CIF|DES|DEQ`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cargo nomination record was most recently updated or modified.',
    `laycan_end_date` DATE COMMENT 'Latest date within the laycan window when the vessel must arrive at the loading terminal, beyond which the nomination may be cancelled.',
    `laycan_start_date` DATE COMMENT 'Earliest date within the laycan window (lay days cancelling) when the vessel may arrive at the loading terminal for cargo operations.',
    `laytime_hours` DECIMAL(18,2) COMMENT 'Total number of hours allowed for loading and/or discharge operations before demurrage charges apply.',
    `lifting_window_end` TIMESTAMP COMMENT 'Precise date and time when the cargo lifting window closes, after which loading operations must be completed.',
    `lifting_window_start` TIMESTAMP COMMENT 'Precise date and time when the cargo lifting window opens for loading operations to commence.',
    `loading_port_code` STRING COMMENT 'Five-character UN/LOCODE (United Nations Code for Trade and Transport Locations) for the loading port.. Valid values are `^[A-Z]{5}$`',
    `nominated_volume` DECIMAL(18,2) COMMENT 'The quantity of product nominated for loading and shipment, expressed in the unit of measure specified.',
    `nomination_date` DATE COMMENT 'The date on which the cargo nomination was formally submitted by the nominating party.',
    `nomination_number` STRING COMMENT 'Externally-known business identifier for the cargo nomination, used for communication with counterparties, terminals, and logistics partners.',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the cargo nomination in the commercial and logistics workflow.. Valid values are `nominated|accepted|confirmed|substituted|cancelled|rejected`',
    `price_differential` DECIMAL(18,2) COMMENT 'Premium or discount applied to the benchmark pricing basis for this specific cargo, expressed in currency per unit.',
    `pricing_basis` STRING COMMENT 'Benchmark or index used for pricing this cargo (e.g., WTI, Brent, Dubai, Henry Hub, JKM).',
    `quality_specification_reference` STRING COMMENT 'Reference to the detailed quality specifications document or standard that the cargo must meet (e.g., API gravity, sulfur content, Reid vapor pressure).',
    `remarks` STRING COMMENT 'Free-text field for additional comments, notes, or clarifications related to the cargo nomination.',
    `special_handling_instructions` STRING COMMENT 'Any special requirements or instructions for cargo handling, loading, transportation, or discharge (e.g., temperature control, inert gas blanketing, segregation requirements).',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the nominating party is permitted to substitute the vessel or cargo specifications after initial nomination.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable variance percentage above or below the nominated volume as per contract terms (e.g., +/- 5%).',
    `vessel_type` STRING COMMENT 'Classification of the vessel by size and cargo capacity (VLCC=Very Large Crude Carrier, Suezmax, Aframax, Panamax, LNG Carrier, LPG Carrier).. Valid values are `vlcc|suezmax|aframax|panamax|lng_carrier|lpg_carrier`',
    `volume_uom` STRING COMMENT 'Unit of measure for the nominated volume (BBL=Barrels, MT=Metric Tons, M3=Cubic Meters, MMBTU=Million British Thermal Units, GAL=Gallons).. Valid values are `BBL|MT|M3|MMBTU|GAL`',
    CONSTRAINT pk_cargo_nomination PRIMARY KEY(`cargo_nomination_id`)
) COMMENT 'Transactional record for the formal nomination of a crude oil, LNG, or refined product cargo under a term contract or spot trade, initiating the physical delivery process. Captures nomination date, laycan window (earliest/latest loading dates), vessel name and IMO number, cargo volume (BBL or MT), loading terminal, discharge port, bill of lading reference, inspector assignment, and nomination status (nominated, accepted, substituted, cancelled). Links commercial obligations to logistics execution and serves as the trigger for cargo scheduling, vessel chartering, and terminal slot allocation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` (
    `trade_confirmation_id` BIGINT COMMENT 'Unique identifier for the trade confirmation record. Primary key for the trade confirmation entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Trade confirmations sent to customer accounts for settlement and reconciliation. Required for matching customer confirmations with internal trade records, resolving discrepancies, and account-level tr',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Trade confirmations in crude oil trading are often issued in conjunction with or in reference to a specific cargo nomination. The confirmation formalizes the commercial terms for a cargo delivery. Lin',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the parent term contract if this confirmation is for a term contract delivery rather than a spot trade. Nullable for pure spot transactions.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical location or facility where commodity delivery will occur. Critical for logistics and title transfer.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Trade confirmations for JV equity crude sales. Links confirmation to JOA for partner entitlement verification, lifting rights validation, and underlift/overlift balance impact from confirmed trade.',
    `marketing_deal_id` BIGINT COMMENT 'Foreign key linking to commercial.marketing_deal. Business justification: Trade confirmations formalize the commercial terms of marketing deals. When a marketing deal is executed, a trade confirmation is issued to the counterparty confirming the agreed price, volume, and de',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Trade confirmations reference pricing agreements for pricing terms. This FK links a confirmation to the pricing agreement governing its pricing. Nullable - confirmations may use ad-hoc pricing or inhe',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Confirmations for PSA entitlement crude trades. Links confirmation to PSA for contractor/government entitlement validation, cost recovery status, and compliance with PSA lifting and export terms.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Trade confirmations can generate sales orders. This FK links a confirmation to the sales order it creates. Nullable - not all confirmations result in sales orders (some are purely financial or hedging',
    `spot_trade_id` BIGINT COMMENT 'Reference to the underlying spot trade or term contract transaction that this confirmation documents.',
    `agreed_price` DECIMAL(18,2) COMMENT 'Confirmed unit price for the commodity as agreed between parties. Forms the basis for invoice calculation and settlement.',
    `amendment_count` STRING COMMENT 'Number of amendments or revisions made to this trade confirmation since original issuance. Tracks confirmation change history.',
    `arbitration_clause` STRING COMMENT 'Text of the arbitration clause specifying dispute resolution mechanism, venue, and governing rules (e.g., ICC, LCIA, AAA arbitration).',
    `benchmark_index` STRING COMMENT 'Reference pricing index used for this trade (e.g., WTI, Brent, Henry Hub). Critical for price differential calculations and market alignment.',
    `broker_reference` STRING COMMENT 'Reference number from the broker or intermediary who facilitated this trade, if applicable. Used for commission reconciliation.',
    `commodity_grade` STRING COMMENT 'Detailed grade or quality specification of the commodity (e.g., WTI, Brent, API gravity, sulfur content). Critical for pricing and quality assurance.',
    `commodity_type` STRING COMMENT 'High-level classification of the commodity being traded. Aligns with major product categories in oil and gas commercial operations. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|ngl|lng|lpg|refined_products|petrochemicals — 7 candidates stripped; promote to reference product]',
    `confirmation_date` DATE COMMENT 'Date when the trade confirmation was formally issued to the counterparty. Represents the principal business event timestamp for this confirmation.',
    `confirmation_notes` STRING COMMENT 'Free-text field for additional terms, conditions, or clarifications specific to this trade confirmation. Used for special instructions or exceptions.',
    `confirmation_number` STRING COMMENT 'Externally-known unique confirmation reference number assigned to this trade confirmation. Used for counterparty communication and legal documentation.. Valid values are `^TC-[0-9]{8}-[A-Z0-9]{6}$`',
    `confirmation_status` STRING COMMENT 'Current lifecycle status of the trade confirmation. Tracks progression from initial issuance through counterparty acceptance or dispute resolution.. Valid values are `pending|confirmed|disputed|amended|cancelled|superseded`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the trade confirmation was generated and issued, including time zone information.',
    `counterparty_confirmation_number` STRING COMMENT 'The counterpartys own confirmation reference number for this trade. Used for reconciliation and dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade confirmation record was first created in the system. Audit trail for data lineage.',
    `delivery_end_date` DATE COMMENT 'Final date of the delivery window for this confirmed trade. Defines the end of the performance period.',
    `delivery_start_date` DATE COMMENT 'First date of the delivery window for this confirmed trade. Defines the beginning of the performance period.',
    `force_majeure_clause` STRING COMMENT 'Text of the force majeure provision defining circumstances under which parties are excused from performance due to unforeseeable events.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern this trade confirmation and any disputes arising from it. Critical for contract enforceability.',
    `hedging_instrument_flag` BOOLEAN COMMENT 'Indicates whether this trade confirmation is associated with a hedging instrument or derivative position for risk management purposes.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and seller. Governed by ICC Incoterms rules. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to this trade confirmation. Nullable if no amendments have been made.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this trade confirmation record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade confirmation record was last modified. Audit trail for change tracking.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Indicates whether this trade impacts OPEC production quota compliance tracking. Relevant for NOC and IOC quota management.',
    `payment_terms_days` STRING COMMENT 'Number of days from delivery or invoice date within which payment is due. Standard commercial credit terms.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the agreed price (e.g., USD, EUR, GBP). Essential for multi-currency trading operations.. Valid values are `^[A-Z]{3}$`',
    `price_differential` DECIMAL(18,2) COMMENT 'Plus or minus adjustment to the benchmark index price. Reflects quality, location, and market condition adjustments.',
    `price_uom` STRING COMMENT 'Unit basis for the agreed price (e.g., per barrel, per MMBTU). Must align with volume UOM for proper valuation. [ENUM-REF-CANDIDATE: PER_BBL|PER_BOE|PER_MMBTU|PER_MCF|PER_MT|PER_GAL|PER_TONNE — 7 candidates stripped; promote to reference product]',
    `quality_specification` STRING COMMENT 'Detailed quality parameters and acceptance criteria for the commodity (e.g., API gravity range, sulfur content, water content, sediment limits).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this trade confirmation requires regulatory reporting to authorities such as FERC, CFTC, or other energy market regulators.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions compliance screening for this trade and counterparty. Ensures compliance with OFAC, EU, and UN sanctions regimes.. Valid values are `pending|cleared|flagged|blocked`',
    `settlement_date` DATE COMMENT 'Date when financial settlement and payment for this trade is scheduled to occur. May differ from delivery date based on payment terms.',
    `settlement_status` STRING COMMENT 'Current status of financial settlement for this confirmed trade. Tracks payment lifecycle from invoice through final payment.. Valid values are `pending|invoiced|paid|partially_paid|overdue|disputed`',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable percentage variance above or below the confirmed volume quantity. Standard commercial tolerance for operational flexibility.',
    `total_trade_value` DECIMAL(18,2) COMMENT 'Total monetary value of the confirmed trade calculated as volume multiplied by agreed price. Represents the gross transaction amount before adjustments.',
    `trading_book` STRING COMMENT 'Internal trading book or portfolio to which this confirmed trade is allocated. Used for position management and P&L tracking.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'Confirmed quantity of commodity to be delivered under this trade confirmation. Represents the legally binding volume commitment.',
    `volume_uom` STRING COMMENT 'Unit of measure for the confirmed volume. Common units include Barrels (BBL), Barrel of Oil Equivalent (BOE), Million British Thermal Units (MMBTU), Thousand Cubic Feet (MCF), Metric Tonnes (MT). [ENUM-REF-CANDIDATE: BBL|BOE|MMBTU|MCF|MMCF|MT|GAL|TONNE — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_trade_confirmation PRIMARY KEY(`trade_confirmation_id`)
) COMMENT 'Transactional record representing the formal confirmation of a spot trade or term contract transaction between counterparties. Captures confirmation date, trade reference number, commodity, volume, price, delivery terms, payment terms, governing law, and confirmation status (pending, confirmed, disputed). Serves as the legally binding commercial document for each trade and is the basis for invoice generation and settlement. Integrates with ETRM/CTRM platforms.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`lifting_program` (
    `lifting_program_id` BIGINT COMMENT 'Unique identifier for the lifting program record. Primary key for the lifting program entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Lifting programs schedule crude liftings from specific production or processing facilities. Production entitlement calculations, over/underlift tracking, and equity oil scheduling require linking the ',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Lifting programs can be linked to term contracts for equity crude lifting under contractual arrangements. This FK links a lifting program to the term contract it executes. Nullable - lifting programs ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lifting operations incur terminal, marine, and inspection costs that must be allocated to cost centers for entitlement accounting and partner billing.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Lifting programs allocate equity crude volumes to specific customers under PSA/JOA arrangements. Critical for entitlement tracking, overlift/underlift balancing, and coordinating customer lifting sche',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Lifting programs specify crude grade for equity entitlement allocation. Business process: joint venture crude lifting requires grade-specific volume allocation and pricing.',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Lifting programs schedule equity entitlement liftings from specific producing discoveries/fields. Overlift/underlift balance tracking, equity entitlement calculations, and partner lifting reconciliati',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Lifting programs schedule crude liftings from specific producing wells. Lifting schedulers and JV equity allocation reports require direct well-level traceability to reconcile entitlement volumes, API',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Lifting programs are scheduled at the block level in JOA/PSA structures. Block-level working interest percentages, net revenue interest, and cost recovery limits directly determine each partners equi',
    `forecast_id` BIGINT COMMENT 'Foreign key linking to production.forecast. Business justification: Lifting programs are built from production forecasts to schedule cargo liftings. The forecast provides the available volume basis for the lifting schedule. Linking enables variance analysis between fo',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this lifting program is executed. Links to the governing JOA contract.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Lifting programs allocate crude production from specific leases to JV partners based on working interest and net revenue interest. Essential for equity crude entitlement calculations, underlift/overli',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Lifting programs specify approved vendors for marine services (vessel agents, stevedores, surveyors) at export terminals. Required for vendor performance tracking, cost allocation to lifting operation',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Lifting programs execute offtake agreements. This FK links a lifting program to the offtake agreement it fulfills. Nullable - lifting programs can be driven by JOAs, PSAs, or offtake agreements.',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Lifting programs allocate production volumes by operator across joint ventures. Operator identification is fundamental to equity entitlement calculations, production balancing, and overlift/underlift ',
    `partner_id` BIGINT COMMENT 'Reference to the equity partner or working interest holder entitled to lift crude oil or natural gas under this program. May be an International Oil Company (IOC), National Oil Company (NOC), or other joint venture partner.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Lifting programs require permits for crude oil export, marine terminal operations, and environmental compliance. Permit validation before lifting authorization is mandatory to ensure regulatory compli',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Lifting operations require work permits for vessel operations, hot work, confined space activities, and SIMOPS during scheduled lifting windows. Tracks permit authorization for programmed lifting acti',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Lifting programs reference pricing agreements to determine the value of equity crude oil liftings. The pricing agreement defines the benchmark differential and pricing formula used to calculate the li',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Lifting revenue from equity crude sales must be allocated to profit centers for field-level P&L and production sharing agreement (PSA) revenue recognition.',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement under which this lifting program is executed. Links to the governing PSA contract.',
    `terminal_id` BIGINT COMMENT 'Reference to the export terminal, loading facility, or Floating Production Storage and Offloading (FPSO) vessel where the partner will lift their crude oil or natural gas.',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Lifting programs allocate production volumes based on specific working interest positions in JV operations. The venture_working_interest_id links the lifting schedule to the exact WI record (partner +',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: In PSA/JOA equity oil contexts, lifting programs are allocated against specific well production. Working interest and net revenue interest calculations for lifting entitlements require linking the lif',
    `api_gravity` DECIMAL(18,2) COMMENT 'The API gravity of the crude oil being lifted, a measure of how heavy or light the petroleum liquid is compared to water. Higher API gravity indicates lighter crude oil.',
    `approval_authority` STRING COMMENT 'The name or title of the individual or committee that approved this lifting program. Used for governance and audit trail purposes.',
    `approved_date` DATE COMMENT 'The date when this lifting program was formally approved by the authorized authority.',
    `balance_volume_uom` STRING COMMENT 'The unit of measure for underlift, overlift, and net balance volumes. Must be consistent with entitlement volume unit of measure.. Valid values are `BBL|BOE|MMBTU|MCF|MMCF`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lifting program record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for pricing and settlement of this lifting program (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `entitlement_volume_uom` STRING COMMENT 'The unit of measure for the equity entitlement volume. Common units include BBL (barrels) for crude oil, BOE (barrel of oil equivalent), MMBTU (million British thermal units), MCF (thousand cubic feet), or MMCF (million cubic feet) for natural gas.. Valid values are `BBL|BOE|MMBTU|MCF|MMCF`',
    `equity_entitlement_volume` DECIMAL(18,2) COMMENT 'The total volume of crude oil or natural gas the partner is entitled to lift during this program period, calculated based on their net revenue interest and the field production allocation.',
    `estimated_lifting_value` DECIMAL(18,2) COMMENT 'The estimated total commercial value of the crude oil or natural gas to be lifted under this program, calculated based on entitlement volume, benchmark price, and price differential.',
    `lifting_month` STRING COMMENT 'The calendar month for which this lifting program applies, formatted as YYYY-MM. Used for monthly lifting schedule coordination.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `lifting_period_end_date` DATE COMMENT 'The last date of the lifting period covered by this program, typically the last day of a calendar month or quarter.',
    `lifting_period_start_date` DATE COMMENT 'The first date of the lifting period covered by this program, typically the first day of a calendar month or quarter.',
    `lifting_quarter` STRING COMMENT 'The calendar quarter for which this lifting program applies (Q1, Q2, Q3, Q4). Used for quarterly lifting schedule coordination.. Valid values are `Q1|Q2|Q3|Q4`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this lifting program record was last modified. Used for audit trail and change tracking.',
    `net_balance_volume` DECIMAL(18,2) COMMENT 'The net cumulative lifting balance for the partner, calculated as underlift balance minus overlift balance. A positive value indicates underlift, a negative value indicates overlift.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Indicates whether this lifting program is subject to OPEC production quota restrictions. True if the field production is constrained by OPEC quota management.',
    `overlift_balance_volume` DECIMAL(18,2) COMMENT 'The cumulative volume by which the partner has lifted more than their equity entitlement in prior periods. A positive overlift balance indicates the partner must reduce future liftings or compensate other partners.',
    `price_differential` DECIMAL(18,2) COMMENT 'The premium or discount applied to the benchmark price for this specific crude grade or delivery point, expressed in currency per barrel or per unit. Used to calculate the actual lifting price.',
    `pricing_benchmark` STRING COMMENT 'The market benchmark index used for pricing the crude oil or natural gas lifted under this program. Common benchmarks include WTI (West Texas Intermediate), Brent, Dubai for crude oil, and Henry Hub or JKM (Japan Korea Marker) for natural gas.. Valid values are `WTI|Brent|Dubai|OPEC_Basket|Henry_Hub|JKM`',
    `program_notes` STRING COMMENT 'Free-text field for capturing additional operational notes, special instructions, or comments related to this lifting program. May include coordination details, exceptions, or partner-specific requirements.',
    `program_number` STRING COMMENT 'Business identifier for the lifting program, typically formatted as LP- followed by numeric sequence. Used for external communication and operational reference.. Valid values are `^LP-[0-9]{6,10}$`',
    `program_status` STRING COMMENT 'Current lifecycle status of the lifting program. Draft indicates planning phase, approved indicates authorization received, active indicates execution in progress, completed indicates all liftings fulfilled, cancelled indicates program terminated, suspended indicates temporary hold.. Valid values are `draft|approved|active|completed|cancelled|suspended`',
    `scheduled_lifting_end_date` DATE COMMENT 'The planned date when the partner will complete lifting their equity crude oil or natural gas under this program.',
    `scheduled_lifting_start_date` DATE COMMENT 'The planned date when the partner will begin lifting their equity crude oil or natural gas under this program.',
    `sulfur_content_percentage` DECIMAL(18,2) COMMENT 'The percentage of sulfur content in the crude oil being lifted. Low sulfur content (sweet crude) is more valuable than high sulfur content (sour crude).',
    `terminal_allocation_slot` STRING COMMENT 'The specific time slot or berth allocation assigned to the partner for loading operations at the terminal. Used for coordinating vessel scheduling and avoiding conflicts.',
    `underlift_balance_volume` DECIMAL(18,2) COMMENT 'The cumulative volume by which the partner has lifted less than their equity entitlement in prior periods. A positive underlift balance indicates the partner is owed additional volume in future liftings.',
    CONSTRAINT pk_lifting_program PRIMARY KEY(`lifting_program_id`)
) COMMENT 'Operational master record defining the monthly or quarterly equity crude oil lifting program for each equity partner or working interest (WI) holder under a joint operating agreement (JOA) or production sharing agreement (PSA). Captures lifting month, partner entity, equity entitlement volume (BOPD), scheduled lifting dates, terminal allocation, and over/under-lift balance. Coordinates commercial entitlements with production allocation and cargo nomination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` (
    `marketing_deal_id` BIGINT COMMENT 'Unique identifier for the marketing deal record. Primary key for the marketing deal entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Marketing deals executed with customer accounts for margin tracking and performance reporting. Required for account-level profitability analysis, marketing margin attribution, and customer relationshi',
    `basin_id` BIGINT COMMENT 'Foreign key linking to exploration.basin. Business justification: Marketing deals for crude are structured by basin of origin (e.g., West African basin deals, North Sea basin deals) because basin determines crude quality, logistics, and benchmark pricing. Basin-leve',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to commercial.credit_limit. Business justification: Marketing deals are executed within the credit limit framework for the counterparty. Before a marketing deal is approved, the counterpartys available credit limit is checked. This FK links the market',
    `delivery_point_id` BIGINT COMMENT 'Reference to the specific physical location where commodity delivery will occur, such as a pipeline interconnect, marine terminal, storage facility, or refinery gate.',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: marketing_deal.origin_field_code is a denormalized text reference to production.field. Marketing deals originate from specific fields production. Replacing with a proper FK enables field-level market',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Marketing deals monetize JV equity crude per partner entitlements. Links deal to JOA for working interest allocation, lifting rights verification, and underlift/overlift impact on partner balances.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Marketing deals involving petroleum products require permits for handling, transportation, or export. Permit compliance check during deal structuring is essential to ensure regulatory authorization fo',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Marketing deals for gas or crude specify the pipeline delivery infrastructure. Transportation cost allocation, capacity utilization reporting, and deal P&L attribution require linking the marketing de',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Marketing deal revenue and margins must be allocated to profit centers for business unit performance measurement and strategic portfolio decisions.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Marketing deals for PSA contractor/government crude. Links deal to PSA for profit oil entitlement, cost recovery status, and compliance with domestic market obligation and export license requirements.',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve the marketing deal based on deal value, risk exposure, or strategic importance. Trader for routine deals; desk head for moderate deals; VP Commercial for large deals; CFO for very large deals; board for strategic transactions.. Valid values are `trader|desk_head|vp_commercial|cfo|board`',
    `approval_date` DATE COMMENT 'Date when the marketing deal received final approval from the designated authority. Required before deal execution can commence.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who provided final approval for the marketing deal. Used for audit trail and accountability.',
    `benchmark_price` DECIMAL(18,2) COMMENT 'Reference price from the selected pricing basis at the time of deal execution or settlement. Expressed in currency per unit (e.g., USD per barrel for crude oil, USD per MMBtu for natural gas).',
    `business_unit` STRING COMMENT 'Organizational business unit responsible for the marketing deal. Typically aligns with upstream (E&P), midstream (pipelines, storage), or downstream (refining, marketing) divisions.',
    `confirmation_date` DATE COMMENT 'Date when the marketing deal terms were confirmed and agreed upon by both parties. Marks the transition from negotiating to confirmed status.',
    `contract_reference_number` STRING COMMENT 'Reference to the master term contract or framework agreement under which this marketing deal is executed, if applicable. Null for standalone spot deals.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the marketing deal record was first created in the system. Used for audit trail and data lineage tracking.',
    `deal_end_date` DATE COMMENT 'Date when commodity delivery or performance under the marketing deal is scheduled to complete. Marks the end of the execution phase.',
    `deal_notes` STRING COMMENT 'Free-text field for capturing additional context, special terms, or operational notes related to the marketing deal. Used for trader handoff, audit trail, and institutional knowledge capture.',
    `deal_number` STRING COMMENT 'Externally-known unique business identifier for the marketing deal, formatted as MD-YYYYNNNN where YYYY is year and NNNN is sequence number. Used for communication with counterparties and internal tracking.. Valid values are `^MD-[0-9]{8}$`',
    `deal_start_date` DATE COMMENT 'Date when commodity delivery or performance under the marketing deal begins. Marks the start of the execution phase.',
    `deal_status` STRING COMMENT 'Current lifecycle status of the marketing deal. Negotiating indicates terms are being discussed; confirmed indicates agreement reached; executing indicates active delivery; closed indicates completed; cancelled indicates terminated before completion; suspended indicates temporarily halted.. Valid values are `negotiating|confirmed|executing|closed|cancelled|suspended`',
    `deal_type` STRING COMMENT 'Classification of the marketing deal by transaction structure. Crude marketing covers equity crude sales; product marketing covers refined product sales; exchange covers product swaps; buy-back covers temporary sales with repurchase obligation; NGL marketing covers natural gas liquids sales; LNG marketing covers liquefied natural gas sales.. Valid values are `crude_marketing|product_marketing|exchange|buy_back|ngl_marketing|lng_marketing`',
    `destination_market` STRING COMMENT 'Geographic market or region where the commodity will be delivered or consumed. Examples include US Gulf Coast, Northwest Europe, Asia Pacific, or specific trading hubs like Rotterdam or Singapore.',
    `hedging_instrument_flag` BOOLEAN COMMENT 'Indicates whether the marketing deal is paired with a financial hedging instrument (futures, swaps, options) to mitigate price risk. True if hedged; false if unhedged spot exposure.',
    `incoterms` STRING COMMENT 'Standard trade terms defining the responsibilities of buyer and seller for transportation, insurance, and risk transfer. FOB is Free on Board; CIF is Cost Insurance and Freight; CFR is Cost and Freight; DES is Delivered Ex Ship; DAP is Delivered at Place; EXW is Ex Works.. Valid values are `FOB|CIF|CFR|DES|DAP|EXW`',
    `marketing_margin` DECIMAL(18,2) COMMENT 'Gross profit margin earned on the marketing deal, calculated as the difference between realized sales price and acquisition or production cost, multiplied by volume. Expressed in the deal currency. Business-confidential metric used for trader performance evaluation.',
    `modified_by_user` STRING COMMENT 'User identifier or name of the individual who last modified the marketing deal record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the marketing deal record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `negotiation_start_date` DATE COMMENT 'Date when commercial negotiations for the marketing deal were initiated. Used for tracking deal cycle time and trader efficiency.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Indicates whether the marketing deal involves crude oil production subject to OPEC production quota management. True if the deal impacts quota compliance; false otherwise. Relevant for NOCs and IOCs operating in OPEC member countries.',
    `payment_terms_days` STRING COMMENT 'Number of days after delivery or invoice date within which payment is due. Common terms include 30, 60, or 90 days. Used for cash flow forecasting and credit risk management.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the pricing and settlement of the deal. Most oil and gas transactions are denominated in USD, but regional deals may use EUR, GBP, JPY, or other currencies.. Valid values are `^[A-Z]{3}$`',
    `price_differential` DECIMAL(18,2) COMMENT 'Premium or discount applied to the benchmark price to arrive at the realized transaction price. Reflects quality adjustments, location basis, and market conditions. Positive values indicate premium; negative values indicate discount.',
    `price_uom` STRING COMMENT 'Unit of measure for the pricing. Per_bbl is per barrel for crude and refined products; per_mmbtu is per million British thermal units for natural gas; per_mt is per metric ton for petrochemicals; per_gallon is per gallon for retail products.. Valid values are `per_bbl|per_mmbtu|per_mt|per_gallon`',
    `pricing_basis` STRING COMMENT 'Benchmark or pricing mechanism used to determine the deal price. WTI is West Texas Intermediate crude; Brent is North Sea crude; Dubai and Oman are Middle East crudes; Henry Hub is US natural gas; JKM is Japan Korea Marker for LNG; fixed indicates a set price; formula indicates a custom calculation. [ENUM-REF-CANDIDATE: wti|brent|dubai|oman|henry_hub|jkm|fixed|formula — 8 candidates stripped; promote to reference product]',
    `realized_price` DECIMAL(18,2) COMMENT 'Final transaction price per unit achieved in the marketing deal, calculated as benchmark price plus price differential. This is the actual price at which the commodity was sold or purchased.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the marketing deal is subject to mandatory regulatory reporting requirements (e.g., FERC for natural gas, CFTC for derivatives, SEC for material transactions). True if reporting required; false otherwise.',
    `sanctions_screening_status` STRING COMMENT 'Result of screening the counterparty and transaction against international sanctions lists (OFAC, UN, EU). Cleared indicates no sanctions concerns; pending indicates screening in progress; flagged indicates potential match requiring review; blocked indicates prohibited transaction.. Valid values are `cleared|pending|flagged|blocked`',
    `total_deal_value` DECIMAL(18,2) COMMENT 'Total monetary value of the marketing deal, calculated as volume quantity multiplied by realized price. Represents the gross revenue or cost associated with the transaction. Expressed in the deal currency.',
    `trading_book` STRING COMMENT 'Internal trading desk or book to which the marketing deal is assigned. Used for P&L attribution, risk management, and organizational reporting. Examples include Crude Trading, Products Trading, NGL Trading, International Marketing.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'Total volume of commodity covered by the marketing deal. Measured in barrels for crude oil and refined products, cubic feet or cubic meters for natural gas, or metric tons for petrochemicals.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume quantity. BBL is barrels, MMBBL is million barrels, MCF is thousand cubic feet, MMCF is million cubic feet, BCF is billion cubic feet, MT is metric tons, KMT is thousand metric tons. [ENUM-REF-CANDIDATE: BBL|MMBBL|MCF|MMCF|BCF|MT|KMT — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_marketing_deal PRIMARY KEY(`marketing_deal_id`)
) COMMENT 'Master record for crude oil and petroleum product marketing deals negotiated by the commercial marketing team, covering equity crude marketing, third-party trading, and product exchange arrangements. Captures deal type (crude marketing, product marketing, exchange, buy-back), commodity, origin field or refinery, destination market, counterparty, volume, pricing basis and realized differential, marketing margin, deal status (negotiating, confirmed, executing, closed), trader responsible, and deal approval chain. Supports commercial performance tracking, marketing revenue attribution, and trader performance benchmarking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`credit_limit` (
    `credit_limit_id` BIGINT COMMENT 'Unique identifier for the credit limit record. Primary key for the credit limit master data.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Credit limits for counterparties require regulatory filings for credit risk reporting and sanctions compliance. Quarterly credit exposure reporting to regulators and sanctions screening documentation ',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Credit limits for JV partners in commercial crude transactions. Links credit limit to partner for partner-specific credit terms, netting agreement impact, and credit risk management in JV equity crude',
    `approval_date` DATE COMMENT 'Date on which the credit limit was formally approved by the designated authority. Used for audit trail and compliance verification.',
    `approved_limit_amount` DECIMAL(18,2) COMMENT 'Maximum financial exposure the company is willing to accept from this counterparty, expressed in the limit currency. Represents the ceiling for outstanding receivables and open trade positions.',
    `approving_authority` STRING COMMENT 'Name or title of the individual or committee that approved this credit limit. Reflects delegation of authority based on limit size and counterparty risk rating.',
    `available_amount` DECIMAL(18,2) COMMENT 'Remaining credit headroom available for new transactions, calculated as approved limit minus utilized amount. Used for pre-trade credit checks.',
    `breach_count` STRING COMMENT 'Number of times this credit limit has been exceeded. Triggers escalation and potential limit suspension.',
    `business_unit` STRING COMMENT 'Business unit or trading desk responsible for managing this credit relationship. Typically aligned with commodity type (crude, NGL, LNG, refined products).',
    `collateral_amount` DECIMAL(18,2) COMMENT 'Value of collateral or credit support posted by the counterparty to secure this limit. Null for unsecured limits.',
    `collateral_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the collateral or credit support. May differ from the limit currency.. Valid values are `^[A-Z]{3}$`',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether this credit limit requires cash collateral, letter of credit, or other credit support. True for secured limits, false for unsecured.',
    `created_by_user` STRING COMMENT 'User ID or name of the individual who created this credit limit record. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit limit record was first created in the system. Supports audit trail and data lineage.',
    `credit_manager_name` STRING COMMENT 'Name of the credit risk manager responsible for monitoring this counterparty relationship and limit utilization.',
    `credit_rating` STRING COMMENT 'Current credit rating assigned to the counterparty by the specified rating agency or internal credit team. Influences limit size and collateral requirements.',
    `credit_rating_agency` STRING COMMENT 'External rating agency whose assessment was used in the credit limit determination. Internal indicates proprietary credit scoring; none indicates unrated counterparty.. Valid values are `SP|Moodys|Fitch|internal|none`',
    `effective_date` DATE COMMENT 'Date from which this credit limit becomes active and available for trading operations. Aligns with credit approval and documentation completion.',
    `expiration_date` DATE COMMENT 'Date on which this credit limit expires and must be renewed or replaced. Null for evergreen limits subject to periodic review.',
    `guarantor_credit_rating` STRING COMMENT 'Credit rating of the guarantor entity. Must be equal to or better than the counterparty rating to provide credit enhancement.',
    `guarantor_name` STRING COMMENT 'Legal name of the parent company or third party providing the credit guarantee. Null if no guarantee is in place.',
    `kyc_expiration_date` DATE COMMENT 'Date on which the current KYC documentation expires and must be refreshed. Triggers compliance workflow.',
    `kyc_status` STRING COMMENT 'Status of the counterparty KYC due diligence process. Approved status is required before credit limit activation.. Valid values are `approved|pending|expired|rejected`',
    `last_breach_date` DATE COMMENT 'Date of the most recent credit limit breach. Used for risk reporting and counterparty performance tracking.',
    `last_utilization_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent credit utilization calculation. Updated by real-time pre-trade credit checking system.',
    `limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the credit limit is denominated. Typically USD for international crude oil and LNG trading.. Valid values are `^[A-Z]{3}$`',
    `limit_reference_number` STRING COMMENT 'External business identifier for the credit limit assignment, used in credit approval documentation and commercial correspondence.',
    `limit_status` STRING COMMENT 'Current lifecycle state of the credit limit. Active limits are available for pre-trade credit checking; suspended or revoked limits block new trading activity.. Valid values are `active|suspended|expired|revoked|under_review|pending_approval`',
    `limit_type` STRING COMMENT 'Classification of the credit support mechanism backing this limit. Unsecured limits rely on counterparty creditworthiness; secured limits require collateral or third-party guarantees.. Valid values are `unsecured|letter_of_credit|parent_guarantee|cash_collateral|surety_bond|corporate_guarantee`',
    `modified_by_user` STRING COMMENT 'User ID or name of the individual who last modified this credit limit record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this credit limit record. Updated on any field change.',
    `netting_agreement_flag` BOOLEAN COMMENT 'Indicates whether a master netting agreement is in place, allowing offsetting of payables and receivables to reduce net credit exposure.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or exceptions related to this credit limit. Used for audit trail and knowledge transfer.',
    `parent_guarantee_flag` BOOLEAN COMMENT 'Indicates whether this credit limit is backed by a parent company guarantee. Common for subsidiaries of major IOCs and NOCs.',
    `review_date` DATE COMMENT 'Scheduled date for the next periodic credit review. Triggers reassessment of counterparty creditworthiness and limit adequacy.',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory credit reviews. Typically 12 months for investment-grade counterparties, 6 months for sub-investment grade.',
    `sanctions_screening_date` DATE COMMENT 'Date of the most recent sanctions screening. Must be refreshed periodically per compliance policy.',
    `sanctions_screening_status` STRING COMMENT 'Result of screening the counterparty against OFAC, EU, and UN sanctions lists. Flagged status blocks credit limit activation.. Valid values are `cleared|flagged|pending|not_screened`',
    `utilized_amount` DECIMAL(18,2) COMMENT 'Current amount of credit exposure consumed by outstanding invoices, open trades, and unsettled transactions. Updated in real-time by the trading and billing systems.',
    CONSTRAINT pk_credit_limit PRIMARY KEY(`credit_limit_id`)
) COMMENT 'Master record managing the commercial credit limits assigned to each trading counterparty, defining the maximum financial exposure the company is willing to accept. Captures counterparty reference, approved credit limit amount, currency, credit limit type (unsecured, letter of credit, parent guarantee), utilization amount, available headroom, review date, approving authority, and credit limit status. Supports pre-trade credit checking and commercial risk controls.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`portfolio` (
    `portfolio_id` BIGINT COMMENT 'Primary key for portfolio',
    `parent_portfolio_id` BIGINT COMMENT 'Self-referencing FK on portfolio (parent_portfolio_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Portfolio P&L must roll up to profit centers for business unit performance reporting and capital allocation decisions across trading and marketing portfolios.',
    `asset_class` STRING COMMENT 'Classification of assets within the portfolio.',
    `benchmark_index` STRING COMMENT 'Reference index used to measure portfolio performance (e.g., WTI, Brent).',
    `confidentiality_level` STRING COMMENT 'Data classification level for the portfolio information.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the portfolio record was created.',
    `currency` STRING COMMENT 'Currency in which monetary values of the portfolio are expressed.',
    `effective_end_date` DATE COMMENT 'Date when the portfolio expires or is terminated (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the portfolio becomes effective.',
    `hedging_strategy` STRING COMMENT 'Approach used to hedge market risk for the portfolio.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the portfolio is currently active.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the portfolio record.',
    `last_valuation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent portfolio valuation.',
    `market` STRING COMMENT 'Market segment the portfolio operates in.',
    `notes` STRING COMMENT 'Additional free-text notes about the portfolio.',
    `performance_mtd_percent` DECIMAL(18,2) COMMENT 'MTD performance as a percentage.',
    `performance_qtd_percent` DECIMAL(18,2) COMMENT 'QTD performance as a percentage.',
    `performance_ytd_percent` DECIMAL(18,2) COMMENT 'YTD performance as a percentage.',
    `portfolio_code` STRING COMMENT 'Business code used to identify the portfolio externally.',
    `portfolio_description` STRING COMMENT 'Detailed description of the portfolios purpose and scope.',
    `portfolio_name` STRING COMMENT 'Human readable name of the portfolio.',
    `portfolio_status` STRING COMMENT 'Current lifecycle status of the portfolio.',
    `portfolio_type` STRING COMMENT 'Category of portfolio based on its primary purpose.',
    `region` STRING COMMENT 'Primary geographic region of the portfolios assets.',
    `regulatory_status` STRING COMMENT 'Compliance status of the portfolio with relevant regulations.',
    `reporting_category` STRING COMMENT 'Category of reporting applicable to the portfolio.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the portfolio based on exposure and volatility.',
    `total_market_value` DECIMAL(18,2) COMMENT 'Current market value of all assets in the portfolio.',
    `valuation_method` STRING COMMENT 'Method used for the latest valuation of the portfolio.',
    CONSTRAINT pk_portfolio PRIMARY KEY(`portfolio_id`)
) COMMENT 'Master reference table for portfolio. Referenced by portfolio_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `oil_gas_ecm`.`commercial`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `oil_gas_ecm`.`commercial`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `oil_gas_ecm`.`commercial`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_hedging_instrument_id` FOREIGN KEY (`hedging_instrument_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_instrument`(`hedging_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_hedging_instrument_id` FOREIGN KEY (`hedging_instrument_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_instrument`(`hedging_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `oil_gas_ecm`.`commercial`.`portfolio`(`portfolio_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `oil_gas_ecm`.`commercial`.`portfolio`(`portfolio_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_hedging_instrument_id` FOREIGN KEY (`hedging_instrument_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_instrument`(`hedging_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_trading_position_id` FOREIGN KEY (`trading_position_id`) REFERENCES `oil_gas_ecm`.`commercial`.`trading_position`(`trading_position_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `oil_gas_ecm`.`commercial`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ADD CONSTRAINT `fk_commercial_portfolio_parent_portfolio_id` FOREIGN KEY (`parent_portfolio_id`) REFERENCES `oil_gas_ecm`.`commercial`.`portfolio`(`portfolio_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`commercial` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`commercial` SET TAGS ('dbx_domain' = 'commercial');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'manager|director|vice_president|executive|board');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'supply|offtake|purchase|exchange|processing|tolling');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `contract_value_estimate` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Estimate');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `contract_value_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `cumulative_deficiency_payments` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Deficiency Payments');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `cumulative_deficiency_payments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `cumulative_delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Delivered Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `deficiency_payment_rate` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Payment Rate');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_value_regex' = 'FOB|CIF|DES|DAP|EXW|FCA');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `delivery_schedule_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Frequency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `delivery_schedule_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `early_termination_penalty` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Penalty');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `early_termination_penalty` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `maximum_volume_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Limit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `minimum_volume_obligation` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Obligation (MVO)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice (Days)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `volume_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_value_regex' = 'BBL|MMBTU|MT|MCF|GAL|M3');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `agreed_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `broker_reference` SET TAGS ('dbx_business_glossary_term' = 'Broker Reference');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `hedging_instrument_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|CFR|DES|DAP|EXW');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OPEC (Organization of the Petroleum Exporting Countries) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_BBL|per_BOE|per_MMBTU|per_MCF|per_MT|per_GAL');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|blocked');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|disputed');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `total_trade_value` SET TAGS ('dbx_business_glossary_term' = 'Total Trade Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_direction` SET TAGS ('dbx_business_glossary_term' = 'Trade Direction');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_direction` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_notes` SET TAGS ('dbx_business_glossary_term' = 'Trade Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|failed');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trade_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trade Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Qualification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Refinery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|under_negotiation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'crude_oil|lng|lpg|ngl|refined_products|petrochemicals');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `credit_support_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `credit_support_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `credit_support_required` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Required Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `delivery_point_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Location');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `delivery_schedule_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Frequency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `delivery_schedule_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `environmental_compliance_clause` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `hedging_strategy` SET TAGS ('dbx_business_glossary_term' = 'Hedging Strategy');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `hedging_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'exw|fob|cif|dap|ddp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `maximum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Commitment');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `minimum_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Commitment (MVC)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `opec_quota_linkage` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Linkage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `price_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Price Benchmark Index');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `price_differential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `pricing_formula` SET TAGS ('dbx_business_glossary_term' = 'Pricing Formula');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `pricing_formula` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|bill_and_hold');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `sanctions_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `seller_entity` SET TAGS ('dbx_business_glossary_term' = 'Seller Entity Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `take_or_pay_percentage` SET TAGS ('dbx_business_glossary_term' = 'Take-or-Pay Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `take_or_pay_provision` SET TAGS ('dbx_business_glossary_term' = 'Take-or-Pay Provision Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'bbl|boe|mcf|mmcf|mt|mmbtu');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Division Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `tertiary_sales_bill_to_party_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Party Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `blocked_for_billing` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Billing Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `blocked_for_delivery` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Delivery Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|pending|on_hold|rejected');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `export_license_required` SET TAGS ('dbx_business_glossary_term' = 'Export License Required Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Delivery Terms');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'spot|term_contract|offtake|swap|exchange');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `shipping_priority` SET TAGS ('dbx_business_glossary_term' = 'Shipping Priority');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `shipping_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent|scheduled');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|rail|truck|barge|vessel');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `division_order_id` SET TAGS ('dbx_business_glossary_term' = 'Division Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `vessel_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `discharge_port` SET TAGS ('dbx_business_glossary_term' = 'Discharge Port or Destination');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Item Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `loading_port` SET TAGS ('dbx_business_glossary_term' = 'Loading Port or Terminal');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `net_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant or Facility Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis or Benchmark');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Line Item Remarks');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|superseded');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `basis_differential` SET TAGS ('dbx_business_glossary_term' = 'Basis Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `differential_unit` SET TAGS ('dbx_business_glossary_term' = 'Differential Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `differential_unit` SET TAGS ('dbx_value_regex' = 'usd_per_bbl|usd_per_mcf|usd_per_mmbtu|usd_per_gallon|usd_per_mt|usd_per_kg');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Escalation Frequency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|none');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `escalation_index` SET TAGS ('dbx_business_glossary_term' = 'Escalation Index');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `freight_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Freight Adjustment');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `pricing_formula` SET TAGS ('dbx_business_glossary_term' = 'Pricing Formula');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `pricing_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `pricing_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|index_linked|formula_based|negotiated|spot');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `quality_adjustment_api` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment API (American Petroleum Institute) Gravity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `quality_adjustment_sulfur` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Sulfur Content');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `quality_adjustment_tan` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment TAN (Total Acid Number)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `retroactive_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Period Days');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `retroactive_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Pricing Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `volume_commitment_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Maximum');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `volume_commitment_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Minimum');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `trading_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Position Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `average_price` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Position Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `boe_equivalent_volume` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE) Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit or Division');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Product Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade or Quality Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `commodity_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Product Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `counterparty_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Concentration Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location or Hub');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `delta_equivalent_volume` SET TAGS ('dbx_business_glossary_term' = 'Delta-Equivalent Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `financial_hedge_volume` SET TAGS ('dbx_business_glossary_term' = 'Financial Hedge Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region or Market');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `hedge_effectiveness_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Ratio');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'physical|futures|swap|option|forward');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `last_valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `market_price` SET TAGS ('dbx_business_glossary_term' = 'Current Market Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `net_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Position Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `opec_quota_allocation` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Allocation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `opec_quota_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Utilization Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `physical_volume` SET TAGS ('dbx_business_glossary_term' = 'Physical Trade Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `position_date` SET TAGS ('dbx_business_glossary_term' = 'Position Valuation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|closed|settled|cancelled');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'long|short|flat');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `stress_test_result` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Result Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `stress_test_scenario` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Scenario Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `tenor_bucket` SET TAGS ('dbx_business_glossary_term' = 'Tenor Bucket or Maturity Bucket');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book or Portfolio');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `unrealized_pnl` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Profit and Loss (P&L)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'market|model|cost');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `value_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Time Horizon in Days');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `collateral_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `collateral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `cumulative_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Gain or Loss');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `effectiveness_test_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Test Result');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `effectiveness_test_result` SET TAGS ('dbx_value_regex' = 'highly_effective|ineffective|not_tested');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `fair_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `fair_value_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Fair Value As-Of Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `fair_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `fair_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Floor Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'fair_value_hedge|cash_flow_hedge|net_investment_hedge|economic_hedge_no_designation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_effectiveness_method` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Testing Method');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_effectiveness_method` SET TAGS ('dbx_value_regex' = 'dollar_offset|regression_analysis|variance_reduction|critical_terms_match');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_purpose` SET TAGS ('dbx_business_glossary_term' = 'Hedge Purpose');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_status` SET TAGS ('dbx_business_glossary_term' = 'Hedge Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedge_status` SET TAGS ('dbx_value_regex' = 'active|matured|terminated|cancelled|suspended');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `ineffectiveness_amount` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ineffectiveness Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `last_effectiveness_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Effectiveness Test Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `notional_volume` SET TAGS ('dbx_business_glossary_term' = 'Notional Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `trading_platform` SET TAGS ('dbx_business_glossary_term' = 'Trading Platform');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `underlying_commodity` SET TAGS ('dbx_business_glossary_term' = 'Underlying Commodity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedging_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Hedging Transaction Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `trading_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Position Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `exchange_name` SET TAGS ('dbx_business_glossary_term' = 'Exchange Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `executed_price` SET TAGS ('dbx_business_glossary_term' = 'Executed Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Floor Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Accounting Designation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedge_effectiveness_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Ratio');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedge_effectiveness_test_method` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Test Method');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedge_effectiveness_test_method` SET TAGS ('dbx_value_regex' = 'dollar_offset|regression_analysis|variance_reduction');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedge_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedge_instrument_type` SET TAGS ('dbx_value_regex' = 'futures|swap|option|collar|forward');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `mtm_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `notional_currency` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `notional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `notional_value` SET TAGS ('dbx_business_glossary_term' = 'Notional Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `premium_paid` SET TAGS ('dbx_business_glossary_term' = 'Premium Paid');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `premium_received` SET TAGS ('dbx_business_glossary_term' = 'Premium Received');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'usd_per_bbl|usd_per_boe|usd_per_mcf|usd_per_mmbtu|usd_per_gallon|usd_per_tonne');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `trader_name` SET TAGS ('dbx_business_glossary_term' = 'Trader Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'executed|settled|cancelled|pending|expired');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `venue_type` SET TAGS ('dbx_business_glossary_term' = 'Venue Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `venue_type` SET TAGS ('dbx_value_regex' = 'exchange|otc');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `volume_hedged` SET TAGS ('dbx_business_glossary_term' = 'Volume Hedged');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Nominating Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Terminal Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `customs_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Required Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `demurrage_rate` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Rate');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `discharge_port_code` SET TAGS ('dbx_business_glossary_term' = 'Discharge Port Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `discharge_port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `export_license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `freight_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `import_license_number` SET TAGS ('dbx_business_glossary_term' = 'Import License Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = 'FOB|CFR|CIF|DES|DEQ');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `laytime_hours` SET TAGS ('dbx_business_glossary_term' = 'Laytime Hours');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `lifting_window_end` SET TAGS ('dbx_business_glossary_term' = 'Lifting Window End Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `lifting_window_start` SET TAGS ('dbx_business_glossary_term' = 'Lifting Window Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `loading_port_code` SET TAGS ('dbx_business_glossary_term' = 'Loading Port Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `loading_port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `nomination_number` SET TAGS ('dbx_business_glossary_term' = 'Nomination Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_business_glossary_term' = 'Nomination Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_value_regex' = 'nominated|accepted|confirmed|substituted|cancelled|rejected');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `price_differential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `quality_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Reference');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Nomination Remarks');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_type` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_type` SET TAGS ('dbx_value_regex' = 'vlcc|suezmax|aframax|panamax|lng_carrier|lpg_carrier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MT|M3|MMBTU|GAL');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `trade_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `agreed_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Trade Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price Index');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `broker_reference` SET TAGS ('dbx_business_glossary_term' = 'Broker Reference Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `confirmation_notes` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^TC-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|amended|cancelled|superseded');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `counterparty_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Trade Confirmation Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `hedging_instrument_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `quality_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|blocked');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Settlement Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Settlement Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|invoiced|paid|partially_paid|overdue|disputed');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `total_trade_value` SET TAGS ('dbx_business_glossary_term' = 'Total Trade Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `total_trade_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Trade Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Marine Services Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Entity Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `balance_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Balance Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `balance_volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|BOE|MMBTU|MCF|MMCF');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `entitlement_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `entitlement_volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|BOE|MMBTU|MCF|MMCF');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `equity_entitlement_volume` SET TAGS ('dbx_business_glossary_term' = 'Equity Entitlement Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `estimated_lifting_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Lifting Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `estimated_lifting_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_month` SET TAGS ('dbx_business_glossary_term' = 'Lifting Month');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_month` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lifting Period End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lifting Period Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Lifting Quarter');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `net_balance_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Balance Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `overlift_balance_volume` SET TAGS ('dbx_business_glossary_term' = 'Overlift Balance Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `price_differential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `pricing_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Pricing Benchmark');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `pricing_benchmark` SET TAGS ('dbx_value_regex' = 'WTI|Brent|Dubai|OPEC_Basket|Henry_Hub|JKM');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `program_number` SET TAGS ('dbx_value_regex' = '^LP-[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|completed|cancelled|suspended');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `scheduled_lifting_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Lifting End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `scheduled_lifting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Lifting Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `sulfur_content_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `terminal_allocation_slot` SET TAGS ('dbx_business_glossary_term' = 'Terminal Allocation Slot');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `underlift_balance_volume` SET TAGS ('dbx_business_glossary_term' = 'Underlift Balance Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'trader|desk_head|vp_commercial|cfo|board');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `benchmark_price` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Deal End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^MD-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_value_regex' = 'negotiating|confirmed|executing|closed|cancelled|suspended');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'crude_marketing|product_marketing|exchange|buy_back|ngl_marketing|lng_marketing');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `destination_market` SET TAGS ('dbx_business_glossary_term' = 'Destination Market');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `hedging_instrument_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|CFR|DES|DAP|EXW');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `marketing_margin` SET TAGS ('dbx_business_glossary_term' = 'Marketing Margin');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `marketing_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_bbl|per_mmbtu|per_mt|per_gallon');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `realized_price` SET TAGS ('dbx_business_glossary_term' = 'Realized Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|blocked');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `total_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Total Deal Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `total_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Approval Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `approved_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `approved_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Approving Authority');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Limit Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `available_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Breach Count');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `collateral_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `collateral_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `collateral_currency` SET TAGS ('dbx_business_glossary_term' = 'Collateral Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `collateral_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `collateral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `credit_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Manager Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Credit Rating');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_value_regex' = 'SP|Moodys|Fitch|internal|none');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `guarantor_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Credit Rating');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `guarantor_credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `guarantor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `kyc_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|rejected');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `last_breach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Limit Breach Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `last_utilization_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Utilization Check Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `limit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Reference Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|under_review|pending_approval');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'unsecured|letter_of_credit|parent_guarantee|cash_collateral|surety_bond|corporate_guarantee');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `parent_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Parent Guarantee Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Review Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Frequency (Months)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `utilized_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Utilized Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `utilized_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ALTER COLUMN `parent_portfolio_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
