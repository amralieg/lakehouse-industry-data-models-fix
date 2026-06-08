-- Schema for Domain: commercial | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`commercial` COMMENT 'Manages upstream and downstream commercial deal-making including term contracts, spot trades, price negotiations, offtake agreements, crude oil marketing, refined product sales, NGL/LNG trading, and petrochemical distribution. Owns trading positions, price differentials, hedging instruments, sales orders, pricing agreements, volume commitments, and commodity marketing aligned with OPEC quota management and WTI/Brent benchmark pricing. Supports revenue recognition and commercial performance tracking. Integrates with SAP SD and trading platforms.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` (
    `commercial_term_contract_id` BIGINT COMMENT 'Unique system identifier for the term contract record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Term contracts are executed with specific customer accounts for billing, credit management, and performance tracking. Required for contract-to-cash processes, account-level volume commitment monitorin',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the external party (buyer, seller, or exchange partner) with whom this term contract is executed.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Term contracts (PSAs, JOAs, offtake agreements) trigger SEC reserves disclosures, OPEC quota filings, and regulatory submissions. Oil-and-gas companies must file contract details for reserves booking,',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract performance reviews, approval authority validation, succession planning, and accountability tracking require linking contract managers to employee records. Currently only text name exists; FK',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Term contracts must be assigned to cost centers for P&L tracking, budget vs actual analysis, and contract profitability measurement. Essential for operational performance management and segment report',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude supply contracts specify grade for API gravity, sulfur content, and pricing differentials. Business process: crude offtake agreement management and pricing formula application.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical or virtual location where commodity delivery or receipt occurs under this contract (pipeline interconnect, terminal, refinery gate, FPSO, LNG terminal).',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to hse.hazardous_substance. Business justification: Contracts specify hazardous materials being handled (H2S-containing crude, NORM-bearing production, hazardous chemicals). SDS management, Tier II reporting (EPCRA), and emergency planning require link',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Term contracts for crude offtake from joint venture production are governed by JOA terms. Links contract to JV operating agreement for working interest allocation, cost recovery, and lifting rights tr',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Term contracts (gas purchase agreements, crude offtake contracts) are tied to production from specific leases for volume commitment tracking, regulatory reporting, and revenue allocation. Essential fo',
    `management_of_change_id` BIGINT COMMENT 'Foreign key linking to hse.management_of_change. Business justification: Contract changes (new delivery points, new product grades, volume changes, new counterparties) trigger MOC process for risk assessment. Process Safety Management (OSHA PSM) and operational risk manage',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Long-term contracts for production/transportation require valid operating permits and environmental permits. Oil-and-gas companies must link contracts to permits to ensure legal authority to perform c',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Long-term supply contracts specify the petroleum product being supplied. Business process: contract management and volume commitment tracking require product identification for quality specs and prici',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Term contracts for government/contractor equity crude under PSA fiscal regimes. Links contract to PSA for profit oil split, cost recovery ceiling, and entitlement volume calculation per PSA terms.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Contracts reference specific quality specifications that delivered product must meet. Business process: contract compliance verification and quality dispute resolution require formal spec reference.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Term contracts in oil & gas specify approved vendors for commodity supply, logistics, or inspection services. Required for vendor qualification tracking, contract compliance audits, and payment reconc',
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
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the external party (buyer or seller) on the opposite side of the spot trade. Links to customer_counterparty master data.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Large spot trades trigger regulatory reporting requirements (CFTC large trader reporting, energy market surveillance, sanctions compliance documentation). Oil-and-gas traders must link trades to regul',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude oil spot trades require specific grade identification (e.g., Brent, WTI, Dubai) for pricing differentials and quality specifications. Business process: crude trading desk operations and price di',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical location or hub where the commodity will be delivered or received. Links to delivery_point master data.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or trading desk personnel who executed the spot trade. Used for performance tracking and compliance monitoring.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Spot trades source equity crude from JV production. Links trade to JOA for partner entitlement verification, underlift/overlift tracking, and cargo allocation compliance with JOA lifting programs.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Every spot trade transaction must specify which petroleum product is being traded. Core business process: trade execution and settlement requires product identification for pricing, quality specs, and',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to commercial.price_index. Business justification: Spot trades reference benchmark price indices for pricing. This FK links a spot trade to the price index it uses. The existing benchmark_index STRING column should be replaced with a structured FK. Nu',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Spot trades can reference pricing agreements for pricing terms. This FK links a spot trade to the pricing agreement governing its pricing. Nullable - spot trades often use ad-hoc pricing but can refer',
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
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the customer or counterparty entity that is obligated to purchase the commodity under this offtake agreement.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Offtake agreements with government entities or NOCs require regulatory filings for reserves booking, production entitlements, and quota compliance. Critical for SEC disclosures and host government rep',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude offtake agreements specify grade for pricing and refinery compatibility. Business process: upstream production allocation and crude marketing require grade-specific commitments.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Offtake agreements require buyer identity linkage for entitlement calculations, lifting schedule coordination, and revenue recognition. Critical for PSA/JOA equity oil marketing and tracking customer-',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Offtake agreements at production facilities include environmental monitoring obligations (air emissions, water discharge, groundwater monitoring). Regulatory permit conditions (NPDES, air permits) req',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: Offtake agreements require facility-level risk assessments (process hazard analysis, quantitative risk assessment for offshore platforms). PSA/JOA partners conduct joint risk assessments for productio',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Offtake agreements specify approved inspection vendors for quality certification and quantity verification at delivery points. Required for vendor coordination, invoice validation, and quality assuran',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Offtake agreements commit production from specific leases/fields to buyers. Critical for PSA/JOA compliance, equity entitlement calculations, and ensuring production volumes match commercial commitmen',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement (JOA) that governs the joint venture producing the commodity under this offtake agreement.',
    `psa_id` BIGINT COMMENT 'Reference to the upstream production sharing agreement (PSA) that governs the production of the commodity being sold under this offtake agreement.',
    `management_of_change_id` BIGINT COMMENT 'Foreign key linking to hse.management_of_change. Business justification: Offtake agreement modifications trigger facility MOC (production rate changes, new processing equipment, new delivery arrangements, partner changes). PSM/OSHA requirement and PSA/JOA governance requir',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Offtake agreements linked to production facilities require valid production permits and export permits. Oil-and-gas companies must verify permit validity before executing offtake agreements to ensure ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Offtake agreements specify which petroleum product the buyer commits to purchase. Business process: production planning and revenue forecasting require product identification for volume commitments.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Offtake agreements represent major revenue streams requiring profit center assignment for segment P&L reporting, reserve-based lending compliance, SEC disclosure, and management performance evaluation',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_quality_spec. Business justification: Offtake agreements include quality specifications for acceptance criteria. Business process: quality assurance and contract compliance require formal spec reference for dispute resolution.',
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
    `certificate_of_quality_id` BIGINT COMMENT 'Foreign key linking to product.certificate_of_quality. Business justification: Sales orders reference quality certificates for custody transfer documentation. Business process: product delivery verification and customer acceptance require CoQ reference.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Export sales orders require regulatory filings (export licenses, customs declarations, sanctions compliance documentation). Oil-and-gas companies must link orders to regulatory submissions for cross-b',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Sales orders require contact person linkage for order confirmation, delivery coordination, and issue resolution. Essential for customer communication tracking, order acknowledgment workflows, and logi',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Sales orders may reference underlying procurement contracts (tolling agreements, processing contracts, transportation contracts) that enable product delivery. Required for margin analysis, cost alloca',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Sales orders in oil & gas often reference AFE numbers for capital project cost allocation and revenue attribution. Required for project economics analysis, variance reporting, and linking revenue to c',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Sales order fulfillment involves physical delivery operations where incidents occur (transportation accidents, loading/unloading incidents). Insurance claims, customer notifications, and liability tra',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Sales orders fulfill from JV production allocated per JOA working interest. Links order to JOA for partner entitlement verification, lifting schedule coordination, and underlift/overlift balance recon',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Sales orders must specify which petroleum product is being sold. Business process: order fulfillment, inventory allocation, and revenue recognition require product identification.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Sales orders use pricing agreements for pricing terms. This FK links a sales order to the pricing agreement governing its pricing. Nullable - some sales orders use ad-hoc pricing rather than formal pr',
    `account_id` BIGINT COMMENT 'Reference to the customer or counterparty who placed this sales order. Links to the customer master data.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for this customer relationship and sales order.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Sales orders for PSA entitlement crude (cost oil, profit oil). Links order to PSA for entitlement calculation, cost recovery tracking, and compliance with government take and domestic supply obligatio',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product sales (gasoline, diesel, jet fuel) require specific grade identification. Business process: downstream marketing and distribution require refined product specs for pricing and logistic',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Sales order processing is a key SOX control area (revenue recognition controls, segregation of duties, pricing approval controls). Oil-and-gas companies must link sales orders to SOX controls for fina',
    `tertiary_sales_bill_to_party_account_id` BIGINT COMMENT 'Reference to the party responsible for payment of the invoice. May differ from the ordering customer or ship-to party.',
    `tertiary_sales_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person or system account that last modified this sales order record.',
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
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to commercial.delivery_schedule. Business justification: Sales order line items link to delivery schedules for fulfillment tracking. This FK links a line item to the delivery schedule it executes. Nullable - not all line items have formal delivery schedules',
    `hedging_instrument_id` BIGINT COMMENT 'Reference to the financial hedging instrument (futures contract, swap, option) used to hedge the price risk for this sales line item. Links physical sales to financial risk management.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Order lines specify individual petroleum products being sold. Business process: line-item fulfillment and inventory picking require product identification for each order line.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Sales order line items can reference line-level pricing agreements. This FK links a line item to the pricing agreement governing its pricing. Nullable - line-level pricing may inherit from header or u',
    `quality_test_result_id` BIGINT COMMENT 'Foreign key linking to product.quality_test_result. Business justification: Order lines reference quality test results for delivered product verification. Business process: quality assurance and customer acceptance require test result documentation for each shipment.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory compliance and internal audit require tracing pricing agreement approvals to specific employee records for authority validation, segregation of duties checks, and approval workflow enforcem',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Pricing agreements with government entities or involving regulated commodities may require regulatory disclosure (FERC tariff filings, government contract disclosures). Oil-and-gas companies must link',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Pricing agreements reference procurement contracts (refining tolling, transportation, storage) that affect cost basis and pricing formulas. Required for cost pass-through calculations, margin analysis',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude pricing agreements specify grade for API/sulfur quality adjustments. Business process: crude pricing formula application requires grade-specific differentials and quality premiums/discounts.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Pricing agreements negotiated with specific customers for formula-based pricing, differentials, and escalation terms. Essential for customer-specific pricing execution, invoice price calculation, and ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Pricing agreements establish revenue recognition patterns requiring GL account mapping for automated revenue accounting, audit trail, SOX compliance, and financial statement preparation. Essential for',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Pricing agreements for JV equity crude reference JOA terms for quality specs, delivery points, and partner-specific pricing formulas. Links agreement to JOA for partner entitlement pricing and lifting',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Pricing agreements specify which petroleum product the pricing formula applies to. Business process: price calculation and invoice generation require product identification for formula application.',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to commercial.price_index. Business justification: Pricing agreements reference benchmark price indices. This FK links a pricing agreement to the price index it uses for pricing. The existing benchmark_reference and benchmark_publication STRING column',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Pricing agreements reference benchmarks (Brent, WTI, Platts) for formula-based pricing. Business process: price calculation requires benchmark index reference for differential application.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Pricing agreements for PSA entitlement crude incorporate PSA fiscal terms (profit oil split, cost recovery). Links agreement to PSA for contractor/government pricing formulas and revenue allocation ca',
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
    `origin_basin` STRING COMMENT 'Geographic basin or production region from which the commodity originates (e.g., Permian Basin, Bakken, Marcellus, Gulf of Mexico), used for basin-specific pricing differentials.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`price_differential` (
    `price_differential_id` BIGINT COMMENT 'Unique identifier for the price differential record.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Price differentials are grade-specific (e.g., Bonny Light vs. Brent). Business process: crude pricing and trading require grade-specific differential tracking for market valuation.',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to commercial.price_index. Business justification: Price differentials are relative to benchmark indices. This FK links a price differential to the price index it references. The existing benchmark_index STRING column should be replaced with a structu',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Differentials are expressed relative to benchmarks. Business process: pricing calculation requires benchmark reference to apply differential for final price determination.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the crude oil grade, a quality adjustment factor affecting the differential. Higher API gravity indicates lighter, more valuable crude.',
    `approval_date` DATE COMMENT 'Date on which the price differential was approved by the commercial pricing authority for use in trade confirmations and revenue calculations.',
    `approved_by` STRING COMMENT 'Name or identifier of the user or role who approved the price differential for commercial use.',
    `commodity_type` STRING COMMENT 'Type of hydrocarbon commodity to which the differential applies (crude oil, natural gas, NGL, LNG, LPG, or refined product).. Valid values are `crude_oil|natural_gas|ngl|lng|lpg|refined_product`',
    `contract_type` STRING COMMENT 'Type of commercial contract or trading instrument to which the differential applies (term contract, spot trade, swap, forward, option).. Valid values are `term|spot|swap|forward|option`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price differential record was first created in the system.',
    `delivery_location` STRING COMMENT 'Physical delivery location, terminal, or trading hub where the differential applies (e.g., Cushing Oklahoma for WTI, Rotterdam for Brent, Houston Ship Channel).',
    `differential_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the differential value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `differential_value` DECIMAL(18,2) COMMENT 'Price differential amount applied to the benchmark price, expressed in currency per unit of measure. Positive values indicate a premium; negative values indicate a discount.',
    `effective_date` DATE COMMENT 'Date from which the price differential becomes applicable for pricing calculations and trade confirmations.',
    `expiration_date` DATE COMMENT 'Date on which the price differential ceases to be applicable. Null indicates an open-ended differential.',
    `hedging_instrument_eligible_flag` BOOLEAN COMMENT 'Indicates whether this differential is eligible for use in financial hedging instruments and derivative contracts.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or validation of the price differential by the commercial pricing team.',
    `market_source` STRING COMMENT 'Source of the market pricing data used to establish the differential (Platts, Argus, OPIS, Reuters, Bloomberg, or internal assessment).. Valid values are `platts|argus|opis|reuters|bloomberg|internal`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the price differential record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the price differential to ensure continued market alignment and accuracy.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding the price differential, including special conditions, market events, or quality considerations.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Indicates whether the differential is influenced by OPEC production quota decisions and supply management policies.',
    `origin_basin` STRING COMMENT 'Geographic basin, field, or production region from which the commodity originates (e.g., Permian Basin, Eagle Ford, Bakken, Marcellus, Gulf of Mexico).',
    `pour_point_celsius` DECIMAL(18,2) COMMENT 'Pour point temperature in Celsius, the lowest temperature at which the crude oil or product will flow. Affects transportation and handling costs.',
    `price_differential_status` STRING COMMENT 'Current lifecycle status of the price differential record (active, inactive, pending approval, expired, superseded by newer differential).. Valid values are `active|inactive|pending|expired|superseded`',
    `pricing_formula` STRING COMMENT 'Textual description of the pricing formula used to calculate the final price, incorporating the benchmark index and differential (e.g., WTI NYMEX + Differential, Platts Brent - Quality Adjustment).',
    `quality_adjustment_factor` DECIMAL(18,2) COMMENT 'Composite quality adjustment multiplier applied to the base differential to account for multiple quality parameters (API gravity, sulfur, TAN, viscosity). A factor of 1.0 indicates no adjustment.',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the differential includes seasonal adjustments for demand fluctuations (e.g., winter heating demand for natural gas, summer driving season for gasoline).',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Sulfur content of the crude oil or product expressed as a percentage by weight. Lower sulfur content (sweet crude) commands a premium; higher sulfur (sour crude) incurs a discount.',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number (TAN) measurement indicating the acidity of the crude oil, expressed in milligrams of potassium hydroxide per gram of oil. High TAN crude is corrosive and typically trades at a discount.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation for the commodity affecting the differential (pipeline, tanker, rail, truck, barge).. Valid values are `pipeline|tanker|rail|truck|barge`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the differential value (BBL for barrels, BOE for barrel of oil equivalent, MCF/MMCF for thousand/million cubic feet, MMBTU for million British thermal units, gallon, tonne, metric ton). [ENUM-REF-CANDIDATE: bbl|boe|mcf|mmcf|mmbtu|gallon|tonne|metric_ton — 8 candidates stripped; promote to reference product]',
    `viscosity_cst` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the crude oil or product measured in centistokes (cSt). Higher viscosity crude requires more processing and may trade at a discount.',
    `volume_tier_maximum_bbl` DECIMAL(18,2) COMMENT 'Maximum volume threshold in barrels for which this differential applies. Null indicates no upper limit for the tier.',
    `volume_tier_minimum_bbl` DECIMAL(18,2) COMMENT 'Minimum volume threshold in barrels for which this differential applies. Used in tiered pricing structures where differentials vary by volume commitment.',
    CONSTRAINT pk_price_differential PRIMARY KEY(`price_differential_id`)
) COMMENT 'Reference record capturing the price differentials applied to crude oil grades and petroleum products relative to benchmark prices (WTI, Brent, Dubai, Henry Hub). Records commodity, grade, origin basin, differential value (positive or negative), effective date range, market source (Platts, Argus, OPIS), and quality adjustment factors (API gravity, sulfur, TAN). Used in pricing agreement calculations, trade confirmations, and commercial performance benchmarking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`trading_position` (
    `trading_position_id` BIGINT COMMENT 'Unique identifier for the trading position record. Primary key.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Trading positions include term contract positions. This FK links a trading position to the specific term contract it represents. Nullable - positions can represent various instrument types or aggregat',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Trading positions above thresholds trigger regulatory reporting (CFTC position limits, large trader reporting). Oil-and-gas companies must link trading positions to regulatory submissions for derivati',
    `employee_id` BIGINT COMMENT 'The unique identifier of the trader or trading desk responsible for managing this position. Used for performance attribution and accountability.',
    `hedging_instrument_id` BIGINT COMMENT 'Foreign key linking to commercial.hedging_instrument. Business justification: Trading positions include hedging instrument positions. This FK links a trading position to the specific hedging instrument it represents. Nullable - positions can represent physical or financial inst',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Trading positions track exposure to JV equity crude commitments. Links position to JOA for partner entitlement volume, underlift/overlift risk, and mark-to-market valuation of JV production.',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to commercial.price_index. Business justification: Trading positions are valued against benchmark price indices. This FK links a trading position to the price index used for valuation. The existing benchmark_index STRING column should be replaced with',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Trading positions reference benchmarks for mark-to-market valuation. Business process: risk management and position valuation require benchmark reference for price exposure calculation.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Trading positions for PSA entitlement crude exposure. Links position to PSA for contractor profit oil volume, cost recovery impact on entitlement, and valuation of government/contractor crude position',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Trading positions include spot trade positions. This FK links a trading position to the specific spot trade it represents. Nullable - positions can represent various instrument types or aggregated por',
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
    `commercial_counterparty_id` BIGINT COMMENT 'Identifier for the financial institution, bank, broker, or trading counterparty with whom the hedging instrument was executed. Links to customer_counterparty master data.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Derivative instruments require regulatory filings (CFTC reporting, EMIR in EU, financial statement disclosures). Oil-and-gas companies must link hedging instruments to regulatory submissions for deriv',
    `employee_id` BIGINT COMMENT 'Identifier for the internal trader or risk manager responsible for executing and managing the hedging instrument.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Hedge instruments must map to specific GL accounts per hedge accounting standards (ASC 815/IFRS 9) for financial statement preparation, hedge effectiveness testing, fair value measurement, and audit t',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Hedging instruments protect JV production revenue. Links hedge to JOA for partner entitlement volume hedged, hedge effectiveness per working interest, and revenue protection for JV equity crude.',
    `pricing_benchmark_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_benchmark. Business justification: Hedging instruments reference benchmarks for strike price and settlement. Business process: hedge accounting and effectiveness testing require benchmark reference for valuation.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Hedges for PSA entitlement crude revenue. Links hedge to PSA for contractor profit oil volume hedged, cost recovery impact, and revenue protection for government/contractor crude sales.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Hedging instruments are executed with financial vendors (banks, trading houses) tracked in procurement vendor master. Required for vendor credit limit monitoring, collateral management, ISDA agreement',
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
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the term contract that this hedge transaction is linked to for exposure coverage.',
    `hedging_instrument_id` BIGINT COMMENT 'Reference to the parent hedge instrument or hedging program under which this transaction was executed.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Hedge transactions for JV production revenue protection. Links transaction to JOA for partner entitlement volume hedged, hedge allocation per working interest, and hedge effectiveness reporting to JV ',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Hedge transactions for PSA entitlement crude. Links transaction to PSA for contractor profit oil hedged, cost recovery impact on hedge allocation, and revenue protection for government/contractor crud',
    `sales_order_id` BIGINT COMMENT 'Reference to the underlying physical sales order or term contract that this hedge transaction is protecting against price risk.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Hedging transactions can hedge spot trades in addition to sales orders and term contracts. This FK links a hedging transaction to the spot trade it hedges. Nullable - hedging can be portfolio-level or',
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
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the buyer or seller counterparty for this cargo nomination.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the term contract or spot trade agreement under which this cargo is nominated.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Cargo liftings trigger regulatory submissions (customs declarations, export/import licenses, marine safety reports, bill of lading filings). Oil-and-gas companies must link nominations to regulatory f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cargo nominations incur logistics costs (demurrage, inspection, handling) requiring cost center allocation for operational cost tracking, JV cost allocation, budget variance analysis, and lifting econ',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Crude cargo nominations specify grade for loading terminal allocation and quality verification. Business process: crude export operations require grade-specific cargo planning.',
    `delivery_preference_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_preference. Business justification: Cargo nominations must respect customer delivery preferences for terminal selection, parcel sizing, and quality specifications. Required for nomination validation, terminal allocation, and ensuring cu',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Cargo operations require terminal-specific emergency response plans (Coast Guard Facility Response Plans, port authority requirements). Each cargo nomination must reference the applicable ERP for the ',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Cargo operations require environmental monitoring (VOC emissions during loading, water quality monitoring during ballast discharge, air quality at terminals). Port authority and EPA requirements link ',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to hse.hazardous_substance. Business justification: Cargo nominations specify exact product grades including hazardous characteristics (H2S content, flash point, NORM levels, vapor pressure). DOT/IMDG shipping documentation and terminal safety planning',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Cargo lifting operations are high-risk activities (vessel incidents, spills, H2S exposure during loading). Every cargo incident investigation references the nomination for liability determination, ins',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Cargo nominations specify inspection vendors for quality/quantity certification at loading/discharge. Required for vendor coordination, invoice reconciliation, and performance tracking. Replaces denor',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Cargo nominations for crude oil liftings must reference source lease to verify equity entitlements, track underlift/overlift positions, and ensure compliance with PSA/JOA lifting rights. Required for ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cargo nomination changes impact lifting schedules and revenue recognition; audit trails must link modifications to employee records for compliance investigations, dispute resolution, and operational a',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Cargo nominations can be made under offtake agreements. This FK allows tracking which offtake agreement a cargo nomination fulfills. Nullable - cargo nominations can be for term contracts, spot trades',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Cargo nominations specify which petroleum product is being lifted. Business process: cargo scheduling and vessel loading require product identification for terminal allocation.',
    `terminal_id` BIGINT COMMENT 'Reference to the terminal or port facility where the cargo will be loaded onto the vessel.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Cargo nominations can be made for spot trades in addition to term contracts. This FK allows tracking which spot trade a cargo nomination fulfills. The attribute does not currently exist and should be ',
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
    `nomination_party` STRING COMMENT 'Indicates which party (buyer or seller) has the contractual right to nominate the cargo under the agreement terms.. Valid values are `buyer|seller`',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the cargo nomination in the commercial and logistics workflow.. Valid values are `nominated|accepted|confirmed|substituted|cancelled|rejected`',
    `price_differential` DECIMAL(18,2) COMMENT 'Premium or discount applied to the benchmark pricing basis for this specific cargo, expressed in currency per unit.',
    `pricing_basis` STRING COMMENT 'Benchmark or index used for pricing this cargo (e.g., WTI, Brent, Dubai, Henry Hub, JKM).',
    `quality_specification_reference` STRING COMMENT 'Reference to the detailed quality specifications document or standard that the cargo must meet (e.g., API gravity, sulfur content, Reid vapor pressure).',
    `remarks` STRING COMMENT 'Free-text field for additional comments, notes, or clarifications related to the cargo nomination.',
    `special_handling_instructions` STRING COMMENT 'Any special requirements or instructions for cargo handling, loading, transportation, or discharge (e.g., temperature control, inert gas blanketing, segregation requirements).',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the nominating party is permitted to substitute the vessel or cargo specifications after initial nomination.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable variance percentage above or below the nominated volume as per contract terms (e.g., +/- 5%).',
    `vessel_imo_number` STRING COMMENT 'Unique seven-digit IMO number assigned to the vessel for permanent identification throughout its operational life.. Valid values are `^IMO[0-9]{7}$`',
    `vessel_name` STRING COMMENT 'Name of the vessel nominated to transport the cargo from loading terminal to discharge port.',
    `vessel_type` STRING COMMENT 'Classification of the vessel by size and cargo capacity (VLCC=Very Large Crude Carrier, Suezmax, Aframax, Panamax, LNG Carrier, LPG Carrier).. Valid values are `vlcc|suezmax|aframax|panamax|lng_carrier|lpg_carrier`',
    `volume_uom` STRING COMMENT 'Unit of measure for the nominated volume (BBL=Barrels, MT=Metric Tons, M3=Cubic Meters, MMBTU=Million British Thermal Units, GAL=Gallons).. Valid values are `BBL|MT|M3|MMBTU|GAL`',
    CONSTRAINT pk_cargo_nomination PRIMARY KEY(`cargo_nomination_id`)
) COMMENT 'Transactional record for the formal nomination of a crude oil, LNG, or refined product cargo under a term contract or spot trade, initiating the physical delivery process. Captures nomination date, laycan window (earliest/latest loading dates), vessel name and IMO number, cargo volume (BBL or MT), loading terminal, discharge port, bill of lading reference, inspector assignment, and nomination status (nominated, accepted, substituted, cancelled). Links commercial obligations to logistics execution and serves as the trigger for cargo scheduling, vessel chartering, and terminal slot allocation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` (
    `commercial_volume_commitment_id` BIGINT COMMENT 'Unique identifier for the commercial volume commitment record. Primary key for this entity.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the parent term contract under which this volume commitment is established.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Volume commitment performance tracking, deficiency payment accountability, and take-or-pay clause management require linking commitment managers to employee records for performance reviews, bonus calc',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Volume commitments made to specific customers under take-or-pay contracts. Required for tracking customer-specific shortfall penalties, makeup rights, and deficiency payment calculations tied to custo',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Volume commitments often tie to capital projects (pipelines, processing facilities) tracked via AFEs. Required for capital project justification, take-or-pay liability valuation, asset retirement obli',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Volume commitments exist under offtake agreements in addition to term contracts. This FK allows tracking which offtake agreement a volume commitment belongs to. Nullable - commitments can be under ter',
    `opec_quota_position_id` BIGINT COMMENT 'Foreign key linking to compliance.opec_quota_position. Business justification: Volume commitments must be reconciled against OPEC quota positions to ensure compliance. Oil-and-gas companies in OPEC countries must link commitments to quota positions to avoid overproduction penalt',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve amendments or waivers to this volume commitment: trader, manager, director, vice president (VP), senior vice president (SVP), or executive.. Valid values are `trader|manager|director|vp|svp|executive`',
    `commitment_number` STRING COMMENT 'Business identifier for the volume commitment, typically referenced in commercial correspondence and invoicing.. Valid values are `^[A-Z0-9]{3,20}$`',
    `commitment_period_end_date` DATE COMMENT 'End date of the period during which the volume commitment is in effect. May be null for evergreen commitments.',
    `commitment_period_start_date` DATE COMMENT 'Start date of the period during which the volume commitment is in effect.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the volume commitment: active (in force), suspended (temporarily paused), fulfilled (completed), defaulted (buyer failed to meet obligation), waived (seller released obligation), or renegotiated (terms under revision).. Valid values are `active|suspended|fulfilled|defaulted|waived|renegotiated`',
    `commitment_type` STRING COMMENT 'Classification of the volume commitment structure: minimum volume obligation (MVO), take-or-pay, ship-or-pay for pipeline capacity, throughput commitment for processing facilities, annual contract quantity (ACQ), or delivery obligation.. Valid values are `minimum_volume_obligation|take_or_pay|ship_or_pay|throughput_commitment|annual_contract_quantity|delivery_obligation`',
    `committed_volume_quantity` DECIMAL(18,2) COMMENT 'The contractual volume quantity that the buyer is obligated to take or pay for during the commitment period. Expressed in the unit specified in committed_volume_uom.',
    `committed_volume_uom` STRING COMMENT 'Unit of measure for the committed volume: barrels (bbl), barrels of oil per day (BOPD), thousand cubic feet (MCF), thousand cubic feet per day (MCFD), million cubic feet (MMCF), million cubic feet per day (MMCFD), barrel of oil equivalent (BOE), metric tons (MT), million British thermal units (MMBTU), or gallons (gal). [ENUM-REF-CANDIDATE: bbl|bopd|mcf|mcfd|mmcf|mmcfd|boe|mt|mmbtu|gal — 10 candidates stripped; promote to reference product]',
    `commodity_type` STRING COMMENT 'Type of hydrocarbon or product covered by this volume commitment: crude oil, natural gas, natural gas liquids (NGL), liquefied natural gas (LNG), liquefied petroleum gas (LPG), condensate, refined product, or petrochemical. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|ngl|lng|lpg|condensate|refined_product|petrochemical — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this volume commitment record was first created in the system.',
    `cumulative_deficiency_payment_amount` DECIMAL(18,2) COMMENT 'Total deficiency payments invoiced or accrued to date for this commitment. Expressed in deficiency_payment_currency_code.',
    `cumulative_deficiency_quantity` DECIMAL(18,2) COMMENT 'Total volume shortfall to date (committed minus delivered) for which deficiency payments have been or will be assessed. Expressed in committed_volume_uom.',
    `cumulative_delivered_quantity` DECIMAL(18,2) COMMENT 'Total volume delivered to date against this commitment since the commitment period start date. Expressed in committed_volume_uom.',
    `cumulative_make_up_quantity` DECIMAL(18,2) COMMENT 'Total volume taken under make-up rights to date, offsetting prior deficiency volumes. Expressed in committed_volume_uom. Null if make-up rights are not granted.',
    `deficiency_payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for deficiency payment rate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deficiency_payment_rate` DECIMAL(18,2) COMMENT 'Rate per unit (in contract currency) that the buyer must pay for any shortfall below the minimum take threshold. This is the penalty for failing to meet the minimum volume obligation.',
    `delivery_performance_percentage` DECIMAL(18,2) COMMENT 'Percentage of committed volume delivered to date (cumulative_delivered_quantity / committed_volume_quantity * 100). Used for performance tracking and compliance reporting.',
    `force_majeure_end_date` DATE COMMENT 'Date on which force majeure suspension ended or is expected to end. Null if force majeure is ongoing or not applicable.',
    `force_majeure_start_date` DATE COMMENT 'Date on which force majeure suspension began. Null if no force majeure event is active.',
    `force_majeure_suspension_flag` BOOLEAN COMMENT 'Indicates whether the volume commitment is currently suspended due to a declared force majeure event. True if suspended, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this volume commitment record was last updated in the system.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review or compliance audit of this volume commitment.',
    `make_up_period_months` STRING COMMENT 'Number of months following a deficiency period during which the buyer may exercise make-up rights to take previously unpaid-for volumes. Null if make-up rights are not granted.',
    `make_up_rights_flag` BOOLEAN COMMENT 'Indicates whether the buyer has the right to make up deficiency volumes in future periods without additional payment. True if make-up rights are granted, False otherwise.',
    `minimum_take_threshold_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of committed volume that must be taken to avoid deficiency payments. Commonly 80% to 90% in take-or-pay contracts.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next performance review or compliance audit of this volume commitment.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this volume commitment.',
    `opec_quota_allocation_flag` BOOLEAN COMMENT 'Indicates whether this volume commitment is subject to OPEC production quota allocation and compliance tracking. True if subject to OPEC quota, False otherwise.',
    `opec_quota_allocation_quantity` DECIMAL(18,2) COMMENT 'Portion of the committed volume allocated under OPEC production quota. Expressed in committed_volume_uom. Null if not subject to OPEC quota.',
    `renegotiation_trigger_date` DATE COMMENT 'Date on which the renegotiation trigger event occurred. Null if no renegotiation trigger is active.',
    `renegotiation_trigger_flag` BOOLEAN COMMENT 'Indicates whether a renegotiation trigger event has occurred (e.g., sustained price movement, regulatory change, or delivery performance breach). True if renegotiation is triggered, False otherwise.',
    `responsible_business_unit` STRING COMMENT 'Name or code of the business unit (e.g., Upstream Marketing, Downstream Sales, LNG Trading) responsible for managing this volume commitment.',
    `tolerance_band_percentage` DECIMAL(18,2) COMMENT 'Allowable variance (plus or minus percentage) from the committed volume before deficiency or excess penalties apply. Typical values range from 5% to 15%.',
    CONSTRAINT pk_commercial_volume_commitment PRIMARY KEY(`commercial_volume_commitment_id`)
) COMMENT 'Master record tracking contractual volume commitments and minimum volume obligations (MVO) under term contracts, offtake agreements, and pipeline transportation agreements. Captures committed volume (BOPD, MMCFD, MT/year), commitment period, tolerance band (±%), take-or-pay threshold, deficiency payment rate, and cumulative delivery performance against commitment. Supports OPEC quota compliance tracking and commercial obligation management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule record. Primary key for the delivery schedule entity.',
    `cargo_nomination_id` BIGINT COMMENT 'Foreign key linking to commercial.cargo_nomination. Business justification: Delivery schedules drive cargo nominations. This FK links a delivery schedule to the cargo nomination it generated. Nullable - not all delivery schedules result in cargo nominations (some may be pipel',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the parent term contract or offtake agreement under which this delivery is scheduled. Links the delivery schedule to the governing commercial agreement.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the contractual delivery point or destination facility where custody transfer and title passage occur. Aligns with contract delivery basis and Incoterms.',
    `terminal_id` BIGINT COMMENT 'Reference to the terminal, platform, or facility from which the commodity will be loaded for delivery. Critical for logistics coordination and SCADA integration with production operations.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Delivery schedules exist for offtake agreements in addition to term contracts. This FK allows tracking which offtake agreement a delivery schedule executes. Nullable - schedules can be for term contra',
    `employee_id` BIGINT COMMENT 'Reference to the commercial trader or account manager responsible for coordinating this delivery schedule with the counterparty and logistics teams.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Delivery schedules can be linked to sales orders for execution tracking. This FK allows tracking which sales order a delivery schedule fulfills. Nullable - schedules can be contract-driven or order-dr',
    `actual_delivery_date` DATE COMMENT 'The actual date on which the delivery was completed and custody transfer occurred. Populated upon delivery completion for performance tracking and revenue recognition.',
    `actual_volume_delivered` DECIMAL(18,2) COMMENT 'The actual quantity of commodity delivered and measured at the delivery point, expressed in the contract unit of measure. Used for variance analysis, deficiency calculations, and revenue recognition.',
    `commodity_type` STRING COMMENT 'Type of petroleum or petrochemical product scheduled for delivery under this schedule. Aligns with contract commodity specifications and product marketing categories. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|lng|lpg|ngl|gasoline|diesel|jet_fuel|fuel_oil|petrochemical — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery schedule record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this delivery schedule, such as USD, EUR, or GBP. Aligns with contract pricing currency.. Valid values are `^[A-Z]{3}$`',
    `deferral_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this delivery schedule has been deferred to a future period by mutual agreement or contractual provision, rather than cancelled.',
    `deferred_to_month` DATE COMMENT 'The future calendar month to which this delivery has been deferred, if applicable. Used for rescheduling and volume commitment tracking across periods.',
    `deficiency_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the actual delivered volume fell below the minimum volume obligation, triggering potential deficiency payment obligations under the term contract.',
    `deficiency_payment_amount` DECIMAL(18,2) COMMENT 'The calculated deficiency payment owed by the seller to the buyer due to underdelivery below the minimum volume obligation, computed per the contract deficiency payment rate.',
    `delivery_mode` STRING COMMENT 'The transportation mode by which the commodity will be delivered. Options include pipeline, tanker (vessel), barge, truck, rail, or FPSO (Floating Production Storage and Offloading) direct transfer.. Valid values are `pipeline|tanker|barge|truck|rail|fpso`',
    `delivery_price` DECIMAL(18,2) COMMENT 'The final price per unit at which the commodity was or will be delivered, incorporating base price, differentials, and any adjustments per the contract pricing formula. Used for revenue calculation.',
    `delivery_value_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the delivery, calculated as actual volume delivered multiplied by delivery price. Represents the revenue or cost associated with this delivery schedule for financial reporting.',
    `delivery_window_end_date` DATE COMMENT 'The latest date within the scheduled month by which delivery must be completed to satisfy contractual obligations and avoid deficiency penalties or force majeure claims.',
    `delivery_window_start_date` DATE COMMENT 'The earliest date within the scheduled month when delivery may commence, defining the opening of the contractual delivery window for logistics planning and terminal scheduling.',
    `force_majeure_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a force majeure event has been declared for this delivery schedule, suspending contractual obligations due to unforeseeable circumstances beyond the control of either party.',
    `force_majeure_reason` STRING COMMENT 'Description of the force majeure event or circumstance that caused the delivery schedule to be suspended or cancelled, such as natural disaster, war, strike, or regulatory action.',
    `grade_specification` STRING COMMENT 'Detailed grade or quality specification of the commodity to be delivered, such as WTI crude, Brent crude, pipeline-quality natural gas, or specific refined product grades per API standards.',
    `incoterms` STRING COMMENT 'The Incoterms rule governing the delivery, defining the allocation of costs, risks, and responsibilities between buyer and seller. Common terms include FOB (Free on Board), CIF (Cost Insurance and Freight), and DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `maximum_volume_tolerance` DECIMAL(18,2) COMMENT 'The maximum acceptable delivery volume above the planned quantity, expressed in the same unit of measure. Defines the upper bound of contractual tolerance before overdelivery penalties or rejection may apply.',
    `minimum_volume_tolerance` DECIMAL(18,2) COMMENT 'The minimum acceptable delivery volume below the planned quantity, expressed in the same unit of measure. Defines the lower bound of contractual tolerance before deficiency penalties apply.',
    `modified_by_user` STRING COMMENT 'The username or user identifier of the person who last modified this delivery schedule record. Used for audit trail and accountability in commercial operations.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery schedule record was last modified in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and change tracking.',
    `nomination_deadline_date` DATE COMMENT 'The date by which the buyer or offtaker must submit a formal nomination or lifting schedule to confirm the delivery. Failure to nominate by this date may result in schedule cancellation or deferral.',
    `nomination_received_date` DATE COMMENT 'The date on which the formal nomination or lifting schedule was received from the counterparty, used for compliance tracking and schedule confirmation workflows.',
    `nomination_received_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a formal nomination or lifting schedule has been received from the counterparty for this delivery schedule.',
    `planned_volume_quantity` DECIMAL(18,2) COMMENT 'The planned quantity of commodity to be delivered during this schedule period, expressed in the unit of measure specified in the contract. Used for production allocation and logistics capacity planning.',
    `planned_volume_uom` STRING COMMENT 'Unit of measure for the planned delivery volume. Common units include BBL (barrels), BOE (barrels of oil equivalent), MMBTU (million British thermal units), MCF (thousand cubic feet), MT (metric tons), or GAL (gallons). [ENUM-REF-CANDIDATE: BBL|BOE|MMBTU|MCF|MMCF|MT|GAL|LTR — 8 candidates stripped; promote to reference product]',
    `pricing_basis` STRING COMMENT 'The pricing mechanism or benchmark index used to determine the delivery price, such as WTI (West Texas Intermediate), Brent, Henry Hub, or fixed contract price. Defines how the delivery will be valued for revenue recognition.',
    `schedule_notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or comments related to this delivery schedule, such as quality concerns, logistics constraints, or counterparty requests.',
    `schedule_number` STRING COMMENT 'Business identifier for the delivery schedule, typically formatted as DS-YYYYMMDD-NNNN for external reference and tracking in commercial operations and logistics systems.. Valid values are `^DS-[0-9]{8}-[0-9]{4}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the delivery schedule indicating whether the delivery is planned, confirmed with logistics, in transit, completed, cancelled, or deferred to a future period.. Valid values are `planned|confirmed|in_transit|delivered|cancelled|deferred`',
    `scheduled_delivery_month` DATE COMMENT 'The calendar month in which the delivery is planned to occur. Used for monthly volume commitment tracking and production coordination under term contracts and Production Sharing Agreements (PSA).',
    `volume_variance_quantity` DECIMAL(18,2) COMMENT 'The difference between planned volume and actual volume delivered (actual minus planned). Positive values indicate overdelivery; negative values indicate underdelivery or deficiency.',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Operational record defining the planned delivery schedule for crude oil, natural gas, LNG, LPG, or refined product volumes under a term contract or offtake agreement. Captures scheduled delivery month, planned volume, delivery window, loading terminal, delivery mode (pipeline, tanker, truck, rail), and schedule status. Enables commercial operations to coordinate with logistics and production for timely fulfillment of contractual obligations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` (
    `trade_confirmation_id` BIGINT COMMENT 'Unique identifier for the trade confirmation record. Primary key for the trade confirmation entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Trade confirmations sent to customer accounts for settlement and reconciliation. Required for matching customer confirmations with internal trade records, resolving discrepancies, and account-level tr',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the counterparty organization involved in this trade transaction. The party receiving or providing the commodity.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the parent term contract if this confirmation is for a term contract delivery rather than a spot trade. Nullable for pure spot transactions.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical location or facility where commodity delivery will occur. Critical for logistics and title transfer.',
    `employee_id` BIGINT COMMENT 'Reference to the internal trader or commercial representative responsible for executing and confirming this trade.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Trade confirmations for JV equity crude sales. Links confirmation to JOA for partner entitlement verification, lifting rights validation, and underlift/overlift balance impact from confirmed trade.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`price_index` (
    `price_index_id` BIGINT COMMENT 'Unique identifier for the price index record. Primary key.',
    `assessment_methodology` STRING COMMENT 'Description of the methodology used by the publication source to assess and calculate the index price (e.g., volume-weighted average, bid-ask midpoint, survey-based).',
    `benchmark_type` STRING COMMENT 'The type of market benchmark this index represents (e.g., spot market price, futures contract price, forward curve price, swap rate, physical delivery price).. Valid values are `spot|futures|forward|swap|physical`',
    `closing_price` DECIMAL(18,2) COMMENT 'The price at the end of the trading period for this index on the price date. Often used as the settlement price for contracts.',
    `commodity_type` STRING COMMENT 'The type of commodity that this price index represents. Crude oil includes WTI and Brent; natural gas includes Henry Hub; NGL includes natural gas liquids; LPG includes liquefied petroleum gas; refined products include gasoline, diesel, jet fuel; petrochemicals include ethylene, propylene.. Valid values are `crude_oil|natural_gas|ngl|lpg|refined_products|petrochemicals`',
    `contract_month` STRING COMMENT 'For futures-based indices, the contract month or delivery period (e.g., January 2024, Q1 2024). Null for spot indices.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this price index record was first created in the system.',
    `data_quality_status` STRING COMMENT 'The quality assurance status of the price data. Verified indicates the data has passed validation checks; anomaly_detected flags outliers; estimated indicates interpolated or imputed values.. Valid values are `verified|pending|anomaly_detected|corrected|estimated`',
    `data_source_system` STRING COMMENT 'The upstream system or data feed from which this price index data is sourced (e.g., Bloomberg Terminal, Reuters Eikon, direct Platts feed, ICE API).',
    `delivery_basis` STRING COMMENT 'The Incoterms delivery basis for the price index (e.g., FOB - Free on Board, CIF - Cost Insurance and Freight, DAP - Delivered at Place). Defines the point at which risk and cost transfer.. Valid values are `fob|cif|dap|exw|fas|cfr`',
    `delivery_location` STRING COMMENT 'The physical delivery point or hub associated with this price index (e.g., Cushing Oklahoma for WTI, North Sea for Brent, Henry Hub Louisiana for natural gas).',
    `effective_date` DATE COMMENT 'The date when this price index definition became effective and started being published.',
    `expiration_date` DATE COMMENT 'The date when this price index was discontinued or replaced. Null for active indices.',
    `grade_specification` STRING COMMENT 'The specific grade or quality specification of the commodity covered by this index (e.g., Light Sweet Crude, Sour Crude, Pipeline Quality Natural Gas). Includes API gravity, sulfur content, and other quality parameters.',
    `hedging_instrument_flag` BOOLEAN COMMENT 'Indicates whether this price index is commonly used as the underlying reference for hedging instruments (futures, options, swaps) in the companys risk management program.',
    `high_price` DECIMAL(18,2) COMMENT 'The highest price observed during the trading period for this index on the price date. Used for volatility analysis and risk management.',
    `index_code` STRING COMMENT 'Short alphanumeric code or ticker symbol for the price index used in trading systems and contracts (e.g., WTI, BRENT, HH).',
    `index_name` STRING COMMENT 'The official name of the commodity price index (e.g., WTI Cushing, Brent Dated, Henry Hub, Platts Dubai, Argus Sour Crude Index). This is the market-recognized identifier for the benchmark.',
    `index_status` STRING COMMENT 'The current operational status of the price index. Active indices are currently published; inactive or discontinued indices are no longer updated but retained for historical reference.. Valid values are `active|inactive|suspended|discontinued`',
    `last_publication_timestamp` TIMESTAMP COMMENT 'The timestamp when the most recent price observation was published by the source. Used to monitor data freshness and detect publication delays.',
    `low_price` DECIMAL(18,2) COMMENT 'The lowest price observed during the trading period for this index on the price date. Used for volatility analysis and risk management.',
    `modified_by_user` STRING COMMENT 'The user ID or system account that last modified this price index record. Used for audit trail and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this price index record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or commentary about the price index or specific price observation, including market conditions, publication source annotations, or data quality remarks.',
    `opec_quota_relevance_flag` BOOLEAN COMMENT 'Indicates whether this price index is relevant for OPEC quota management and production allocation decisions. True for major crude oil benchmarks like Brent and WTI.',
    `opening_price` DECIMAL(18,2) COMMENT 'The price at the start of the trading period for this index on the price date.',
    `price_currency` STRING COMMENT 'The currency in which the price is denominated, using ISO 4217 three-letter currency code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `price_date` DATE COMMENT 'The date for which the price observation is valid. This is the trading date or valuation date for the published price.',
    `price_differential_basis` STRING COMMENT 'The reference index against which differentials are calculated (e.g., WTI Cushing is the basis for many US crude differentials; Brent Dated is the basis for international crude differentials).',
    `price_uom` STRING COMMENT 'The unit of measure for the published price (e.g., USD per barrel for crude oil, USD per MMBtu for natural gas, USD per gallon for refined products, USD per metric ton for petrochemicals).. Valid values are `usd_per_bbl|usd_per_mmbtu|usd_per_gallon|usd_per_mt|usd_per_mcf`',
    `publication_frequency` STRING COMMENT 'How often the price index is published and updated (e.g., daily, weekly, monthly, intraday, real-time).. Valid values are `daily|weekly|monthly|intraday|real_time`',
    `publication_source` STRING COMMENT 'The authoritative organization or exchange that publishes this price index (e.g., Platts, Argus, OPIS, NYMEX, ICE, Reuters, Bloomberg). [ENUM-REF-CANDIDATE: platts|argus|opis|nymex|ice|reuters|bloomberg — 7 candidates stripped; promote to reference product]',
    `published_price` DECIMAL(18,2) COMMENT 'The official published price value for the index on the price date. This is the benchmark price used in pricing agreements and mark-to-market valuations.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this price index is used in regulatory reporting requirements (e.g., SEC reserves disclosure, FERC tariff filings, EPA emissions reporting).',
    `revision_number` STRING COMMENT 'The revision sequence number for this price observation. Publication sources occasionally revise historical prices; this tracks the version.',
    `revision_timestamp` TIMESTAMP COMMENT 'The timestamp when the price observation was last revised by the publication source. Null if never revised.',
    `settlement_price` DECIMAL(18,2) COMMENT 'The official settlement price determined by the exchange or publication source, used for contract settlement and margin calculations.',
    `trading_volume` DECIMAL(18,2) COMMENT 'The total volume of commodity traded at this index price during the trading period, measured in the commoditys standard unit (barrels, MMBtu, gallons, metric tons).',
    CONSTRAINT pk_price_index PRIMARY KEY(`price_index_id`)
) COMMENT 'Reference and time-series record for commodity price indices used as benchmarks in pricing agreements and trade confirmations. Captures index definition (name, commodity type, publication source, frequency) and the daily/monthly published price observations (price date, published value, currency, high/low range). Index names include WTI Cushing, Brent Dated, Henry Hub, Platts Dubai, Argus Sour Crude Index. Sources include Platts, Argus, OPIS, NYMEX, ICE. Serves as the authoritative reference for both benchmark definitions and their historical price data consumed by pricing calculations, mark-to-market valuations, and commercial performance reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`index_price` (
    `index_price_id` BIGINT COMMENT 'Unique identifier for each index price observation record. Primary key for the index price transactional data.',
    `price_index_id` BIGINT COMMENT 'Reference to the price index definition that this observation belongs to. Links to the master price index catalog defining the index name, commodity, publication source, and calculation methodology.',
    `benchmark_flag` BOOLEAN COMMENT 'Indicates whether this index price is a primary benchmark used for contract pricing and hedging. True for WTI, Brent, Henry Hub, and other widely-referenced benchmarks. False for regional or derivative indices.',
    `closing_price` DECIMAL(18,2) COMMENT 'The closing or settlement price at the end of the trading period for this index date. For exchange-traded indices, this is the official settlement price used for contract settlements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this index price record was first created in the system. Used for audit trail and data lineage tracking. Distinct from publication_timestamp which reflects the external publication time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the published price is denominated. Typically USD for WTI and Brent benchmarks, but may vary for regional indices.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'The name of the upstream system or data feed from which this price observation was ingested. Examples include Bloomberg Terminal, Platts eWindow, ICE Data Services, internal trading system. Supports data lineage and troubleshooting.',
    `delivery_location` STRING COMMENT 'The physical delivery point or hub associated with this index price. Examples include Cushing Oklahoma for WTI, Sullom Voe for Brent, Henry Hub Louisiana for natural gas. Critical for basis differential analysis.',
    `delivery_period` STRING COMMENT 'The forward delivery period that this price represents. Prompt indicates immediate delivery, front_month indicates the nearest futures contract month, next_month indicates the following month, quarterly and annual indicate longer-term forward periods.. Valid values are `prompt|front_month|next_month|quarterly|annual`',
    `high_price` DECIMAL(18,2) COMMENT 'The highest price observed during the trading period for this index date. Applicable for indices that publish intraday high/low ranges. Null for indices that publish only a single settlement price.',
    `low_price` DECIMAL(18,2) COMMENT 'The lowest price observed during the trading period for this index date. Applicable for indices that publish intraday high/low ranges. Null for indices that publish only a single settlement price.',
    `modified_by_user` STRING COMMENT 'The user ID or system account that last modified this index price record. Used for audit trail and accountability. May be a human user for manual corrections or a system account for automated data feeds.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this index price record was last modified in the system. Updated whenever a revision, correction, or status change occurs. Used for audit trail and change tracking.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Indicates whether this price observation occurred during a period when OPEC production quotas were in effect and materially influencing market prices. Used for commercial performance analysis and quota compliance tracking.',
    `opening_price` DECIMAL(18,2) COMMENT 'The opening price at the start of the trading period for this index date. Applicable for exchange-traded indices such as NYMEX WTI or ICE Brent futures. Null for non-exchange spot indices.',
    `price_confidence_level` STRING COMMENT 'Assessment of the reliability and market depth supporting this price observation. High indicates deep liquidity and multiple transactions, medium indicates moderate market activity, low indicates thin market or limited data. Used for risk assessment in pricing agreements.. Valid values are `high|medium|low`',
    `price_date` DATE COMMENT 'The business date for which this index price was published or observed. Represents the effective date of the price, not the publication timestamp. Critical for time-series analysis and mark-to-market valuations.',
    `price_differential` DECIMAL(18,2) COMMENT 'The differential or spread between this index price and a reference benchmark, if applicable. Used for regional indices priced as a differential to WTI or Brent. Null for primary benchmarks.',
    `price_notes` STRING COMMENT 'Free-text field for additional context, explanations, or annotations related to this price observation. May include notes on market conditions, data quality issues, revisions, or special circumstances affecting the price.',
    `price_status` STRING COMMENT 'The publication status of this price observation. Published indicates final official price, preliminary indicates initial assessment subject to revision, revised indicates an updated value, corrected indicates a correction to a previously published price, estimated indicates an internal estimate pending official publication.. Valid values are `published|preliminary|revised|corrected|estimated`',
    `price_type` STRING COMMENT 'Classification of the price observation. Spot indicates physical market prices, futures indicates exchange-traded futures contracts, forward indicates OTC forward contracts, assessed indicates third-party price assessments, calculated indicates derived or formula-based prices.. Valid values are `spot|futures|forward|assessed|calculated`',
    `price_uom` STRING COMMENT 'Unit of measure for the published price. Common values include BBL (barrel) for crude oil, MMBTU (million British thermal units) for natural gas, GAL (gallon) for refined products, MT (metric ton) for petrochemicals.. Valid values are `BBL|MMBTU|GAL|MT|KG|LB`',
    `publication_source` STRING COMMENT 'The name of the organization or platform that published this price observation. Examples include Platts, Argus, Bloomberg, NYMEX, ICE, internal trading desk assessments. Critical for audit trail and price verification.',
    `publication_timestamp` TIMESTAMP COMMENT 'The exact date and time when this price was published or received by the system. Distinct from price_date, which is the business effective date. Used for audit trail and data lineage tracking.',
    `published_price` DECIMAL(18,2) COMMENT 'The official price value published by the index source for this observation date. This is the primary price used in pricing agreement calculations, contract settlements, and mark-to-market valuations. Precision supports crude oil, refined products, NGL, LNG, and petrochemical pricing.',
    `quality_grade` STRING COMMENT 'The quality or grade specification for the commodity that this price represents. Examples include WTI Light Sweet Crude (API 39.6, sulfur 0.24%), Brent Blend, pipeline-quality natural gas. Critical for price comparability and contract settlement.',
    `reference_benchmark` STRING COMMENT 'The name of the benchmark index to which the price_differential applies. Examples include WTI, Brent, Henry Hub. Null if this is a primary benchmark or if no differential is applicable.',
    `revision_number` STRING COMMENT 'Sequential revision counter for this price observation. Starts at 0 for the initial publication and increments with each revision or correction. Supports audit trail and price history tracking.',
    `sanctions_screening_flag` BOOLEAN COMMENT 'Indicates whether this price observation has been screened for applicability to sanctioned jurisdictions or counterparties. True if screening has been performed and no sanctions issues identified. Used for regulatory compliance in commercial transactions.',
    `trading_day_flag` BOOLEAN COMMENT 'Indicates whether the price_date was an active trading day for this index. False for weekends, holidays, or days when the market was closed. Used to distinguish null prices due to non-trading days versus missing data.',
    `volume_traded` DECIMAL(18,2) COMMENT 'The total volume of the commodity traded during the observation period, expressed in the indexs standard unit of measure. Applicable for exchange-traded indices. Null for calculated or assessed indices.',
    `volume_uom` STRING COMMENT 'Unit of measure for the volume traded. Aligns with the commodity type and trading venue standards.. Valid values are `BBL|MMBTU|GAL|MT|KG|LB`',
    CONSTRAINT pk_index_price PRIMARY KEY(`index_price_id`)
) COMMENT 'Transactional record storing the daily or monthly published price values for each commodity price index. Captures index reference, price date, published price value, currency, unit of measure, high/low range (where applicable), and source publication. Provides the time-series price data consumed by pricing agreement calculations, mark-to-market valuations, and commercial performance reporting. Distinct from price_index (the definition) — this is the actual price observation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` (
    `quota_allocation_id` BIGINT COMMENT 'Unique identifier for the quota allocation record. Primary key for the quota allocation master data.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Quota allocations can be linked to term contracts for contractual quota management. This FK links a quota allocation to the term contract it supports. Nullable - quota allocations can be regulatory, c',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: OPEC quota allocation creation requires audit trails linking to employee records for regulatory reporting, compliance investigations, and accountability tracking. Text field created_by_user insufficie',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: OPEC/regulatory quotas allocated to customers for compliance tracking and volume allocation. Essential for ensuring customer liftings comply with quota restrictions and reporting quota utilization by ',
    `hierarchy_id` BIGINT COMMENT 'Reference to the upstream asset (field, reservoir, or production facility) to which the quota is allocated for internal production planning and compliance tracking.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: OPEC/government production quotas allocated at JOA level for joint venture fields. Links quota to JOA for partner production allocation, overlift/underlift management, and compliance with quota restri',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: OPEC and regulatory production quotas are allocated to specific leases/fields for compliance monitoring and production planning. Required for regulatory reporting, quota compliance verification, and m',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Quota allocations can be linked to offtake agreements for offtake quota management. This FK links a quota allocation to the offtake agreement it supports. Nullable - quota allocations can be linked to',
    `opec_quota_position_id` BIGINT COMMENT 'Foreign key linking to compliance.opec_quota_position. Business justification: Internal quota allocations must reconcile with OPEC quota positions for compliance tracking. Oil-and-gas companies in OPEC member countries must link allocations to official quota positions for produc',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Production quotas under PSA fiscal regimes affect cost oil/profit oil allocation. Links quota to PSA for government production limits, contractor entitlement calculation, and quota compliance reportin',
    `actual_production_bopd` DECIMAL(18,2) COMMENT 'The actual average daily production volume achieved during the quota period, measured in barrels of oil per day (BOPD). Used to calculate compliance and over/under-lift positions.',
    `adjustment_date` DATE COMMENT 'The date on which the quota allocation was revised or adjusted. Used to track the history of quota changes and support audit trails.',
    `adjustment_reason` STRING COMMENT 'Free-text explanation for any revision or adjustment to the original quota allocation, such as OPEC ministerial decision, force majeure event, asset maintenance shutdown, or partner renegotiation.',
    `allocated_volume_boe` DECIMAL(18,2) COMMENT 'The production volume allocated under this quota, expressed in barrels of oil equivalent (BOE) to normalize oil and gas volumes. Used for multi-commodity allocations.',
    `allocated_volume_bopd` DECIMAL(18,2) COMMENT 'The production volume allocated under this quota, expressed in barrels of oil per day (BOPD). This is the target or ceiling production rate for the allocation period.',
    `allocation_number` STRING COMMENT 'Business identifier for the quota allocation record, formatted as QA-YYYYMMDD for traceability and external reference.. Valid values are `^QA-[0-9]{8}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the quota allocation: draft (pending approval), active (in effect), suspended (temporarily halted), expired (period ended), revised (superseded by new allocation), or cancelled (voided).. Valid values are `draft|active|suspended|expired|revised|cancelled`',
    `allocation_type` STRING COMMENT 'Classification of the quota allocation by organizational or contractual scope: OPEC country-level quota, internal asset allocation, equity partner entitlement, field-level production cap, joint venture allocation, or production sharing agreement allocation.. Valid values are `opec_country|internal_asset|equity_partner|field_level|joint_venture|production_sharing`',
    `approval_authority` STRING COMMENT 'The name or title of the executive or committee that approved the quota allocation (e.g., VP Commercial, OPEC Ministerial Council, Joint Venture Management Committee).',
    `approval_date` DATE COMMENT 'The date on which the quota allocation was formally approved by the designated authority. Marks the transition from draft to active status.',
    `benchmark_reference` STRING COMMENT 'The crude oil pricing benchmark or reference basket used for quota valuation and compliance reporting: OPEC Reference Basket, WTI (West Texas Intermediate), Brent, Dubai, Urals, or other regional benchmark.. Valid values are `opec_basket|wti|brent|dubai|urals|other`',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether actual production is within the compliance threshold. True indicates compliance, False indicates a breach requiring reporting or corrective action.',
    `compliance_threshold_percentage` DECIMAL(18,2) COMMENT 'The allowable tolerance percentage for over-production or under-production relative to the allocated quota before triggering compliance action or penalty. Typically expressed as a percentage (e.g., 5.00 for 5%).',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the country to which the OPEC quota is allocated (e.g., SAU for Saudi Arabia, IRQ for Iraq). Applicable for OPEC country-level allocations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this quota allocation record was first created in the system. Used for audit trail and data lineage tracking.',
    `modified_by_user` STRING COMMENT 'The user ID or name of the individual who last modified this quota allocation record. Supports audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this quota allocation record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to the quota allocation (e.g., seasonal adjustments, partner-specific terms, force majeure declarations).',
    `overlift_position_barrels` DECIMAL(18,2) COMMENT 'Cumulative volume of crude oil produced in excess of the allocated quota during the period, measured in barrels. Used for equity crude balancing and partner settlement.',
    `quota_manager_name` STRING COMMENT 'The name of the individual responsible for day-to-day management and compliance monitoring of this quota allocation.',
    `quota_period_end_date` DATE COMMENT 'The effective end date of the quota allocation period. Null indicates an open-ended allocation subject to revision.',
    `quota_period_start_date` DATE COMMENT 'The effective start date of the quota allocation period, typically aligned with OPEC quota cycle or fiscal planning period.',
    `regulatory_reporting_obligation` STRING COMMENT 'The regulatory or compliance reporting requirement associated with this quota allocation: OPEC monthly production report, SEC annual reserves disclosure, BSEE quarterly offshore production report, internal management reporting only, or no external reporting.. Valid values are `opec_monthly|sec_annual|bsee_quarterly|internal_only|none`',
    `reporting_deadline_date` DATE COMMENT 'The deadline date by which compliance or production data for this quota allocation must be submitted to the relevant regulatory authority (OPEC, SEC, BSEE, etc.).',
    `responsible_business_unit` STRING COMMENT 'The organizational unit or division responsible for managing and monitoring compliance with this quota allocation (e.g., Upstream Commercial, Marketing & Trading, Joint Venture Operations).',
    `underlift_position_barrels` DECIMAL(18,2) COMMENT 'Cumulative volume of crude oil produced below the allocated quota during the period, measured in barrels. Represents unutilized entitlement that may be carried forward or settled.',
    `variance_bopd` DECIMAL(18,2) COMMENT 'The difference between allocated volume and actual production, expressed in BOPD. Positive values indicate over-production (over-lift), negative values indicate under-production (under-lift).',
    CONSTRAINT pk_quota_allocation PRIMARY KEY(`quota_allocation_id`)
) COMMENT 'Master record managing OPEC production quota allocations and internal commercial volume allocations by country, asset, or equity partner. Captures quota period, allocated volume (BOPD), OPEC reference basket, compliance threshold, actual production against quota, over/under-lift position, and regulatory reporting obligation. Supports commercial planning, equity crude lifting scheduling, and OPEC compliance reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`lifting_program` (
    `lifting_program_id` BIGINT COMMENT 'Unique identifier for the lifting program record. Primary key for the lifting program entity.',
    `cargo_nomination_id` BIGINT COMMENT 'Reference to the cargo nomination submitted by the partner for this lifting program. Links to the detailed vessel and cargo specifications.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Lifting programs can be linked to term contracts for equity crude lifting under contractual arrangements. This FK links a lifting program to the term contract it executes. Nullable - lifting programs ',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Lifting programs specify crude grade for equity entitlement allocation. Business process: joint venture crude lifting requires grade-specific volume allocation and pricing.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Lifting programs allocate equity crude volumes to specific customers under PSA/JOA arrangements. Critical for entitlement tracking, overlift/underlift balancing, and coordinating customer lifting sche',
    `field_id` BIGINT COMMENT 'Reference to the oil or gas field from which crude oil or natural gas is being lifted under this program.',
    `h2s_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.h2s_monitoring. Business justification: Lifting operations at sour crude production facilities require H2S monitoring during cargo transfer. Production facility safety requirement links lifting programs to H2S monitoring for personnel safet',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this lifting program is executed. Links to the governing JOA contract.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Lifting programs allocate crude production from specific leases to JV partners based on working interest and net revenue interest. Essential for equity crude entitlement calculations, underlift/overli',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Lifting programs specify approved vendors for marine services (vessel agents, stevedores, surveyors) at export terminals. Required for vendor performance tracking, cost allocation to lifting operation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Lifting program modifications affect JV partner entitlements and revenue allocation; audit trails must link changes to employee records for dispute resolution, compliance investigations, and operation',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Lifting programs execute offtake agreements. This FK links a lifting program to the offtake agreement it fulfills. Nullable - lifting programs can be driven by JOAs, PSAs, or offtake agreements.',
    `opec_quota_position_id` BIGINT COMMENT 'Foreign key linking to compliance.opec_quota_position. Business justification: Lifting programs must comply with OPEC quota positions; production scheduling depends on quota compliance status. Oil-and-gas companies in OPEC countries must link lifting schedules to quota positions',
    `partner_id` BIGINT COMMENT 'Reference to the equity partner or working interest holder entitled to lift crude oil or natural gas under this program. May be an International Oil Company (IOC), National Oil Company (NOC), or other joint venture partner.',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement under which this lifting program is executed. Links to the governing PSA contract.',
    `terminal_id` BIGINT COMMENT 'Reference to the export terminal, loading facility, or Floating Production Storage and Offloading (FPSO) vessel where the partner will lift their crude oil or natural gas.',
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
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage of production revenue the partner is entitled to receive after deducting royalties, overriding royalty interests (ORRI), and other burdens. NRI is typically less than or equal to WI.',
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
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage ownership interest held by the partner in the field or well, representing their share of capital expenditure (CAPEX) and operating expenditure (OPEX) obligations as well as production entitlement.',
    CONSTRAINT pk_lifting_program PRIMARY KEY(`lifting_program_id`)
) COMMENT 'Operational master record defining the monthly or quarterly equity crude oil lifting program for each equity partner or working interest (WI) holder under a joint operating agreement (JOA) or production sharing agreement (PSA). Captures lifting month, partner entity, equity entitlement volume (BOPD), scheduled lifting dates, terminal allocation, and over/under-lift balance. Coordinates commercial entitlements with production allocation and cargo nomination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` (
    `marketing_deal_id` BIGINT COMMENT 'Unique identifier for the marketing deal record. Primary key for the marketing deal entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Marketing deals executed with customer accounts for margin tracking and performance reporting. Required for account-level profitability analysis, marketing margin attribution, and customer relationshi',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the external party (buyer or seller) with whom the marketing deal is executed. May be an IOC, NOC, trading house, refiner, or end consumer.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Marketing deals can be structured under term contracts. This FK links a marketing deal to the parent term contract it executes. Nullable - marketing deals can be standalone or contract-based.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Marketing deals reference transportation or processing procurement contracts that affect netback calculations. Required for margin analysis, cost allocation, and profitability reporting in integrated ',
    `delivery_point_id` BIGINT COMMENT 'Reference to the specific physical location where commodity delivery will occur, such as a pipeline interconnect, marine terminal, storage facility, or refinery gate.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for negotiating and executing the marketing deal. Used for performance tracking, commission calculation, and accountability.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Marketing deals monetize JV equity crude per partner entitlements. Links deal to JOA for working interest allocation, lifting rights verification, and underlift/overlift impact on partner balances.',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: NGL marketing deals specify stream composition (ethane, propane, butane). Business process: NGL marketing requires stream-specific pricing and logistics planning.',
    `refinery_id` BIGINT COMMENT 'Reference to the refinery or processing plant from which the marketed product originates. Applicable for refined product and petrochemical marketing deals where the company is selling output from its downstream facilities.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Marketing deals specify which petroleum product is being marketed. Business process: deal structuring and margin calculation require product identification for pricing and logistics.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Marketing deals reference pricing agreements for pricing terms. This FK links a marketing deal to the pricing agreement governing its pricing. Nullable - some marketing deals use ad-hoc pricing rather',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Marketing deals for PSA contractor/government crude. Links deal to PSA for profit oil entitlement, cost recovery status, and compliance with domestic market obligation and export license requirements.',
    `refined_product_id` BIGINT COMMENT 'Foreign key linking to product.refined_product. Business justification: Refined product marketing deals require specific grade identification. Business process: downstream marketing operations require refined product specs for deal structuring.',
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
    `origin_field_code` BIGINT COMMENT 'Reference to the upstream oil or gas field from which the marketed commodity originates. Applicable for equity crude marketing deals where the company is selling production from its own operated or non-operated fields.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`performance` (
    `performance_id` BIGINT COMMENT 'Unique identifier for the commercial performance record. Primary key for this transactional performance ledger entry.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the buyer or seller counterparty involved in this commercial transaction. Links to the customer.customer_counterparty product.',
    `commercial_term_contract_id` BIGINT COMMENT 'Reference to the underlying term contract for which performance is being tracked. Links to the commercial.term_contract product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Performance reporting accountability requires linking report creators to employee records for data quality investigations, audit trails, and segregation of duties validation. Text field created_by_use',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical delivery location or hub where the commodity was delivered. Links to the customer.delivery_point product.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Commercial performance reporting for JV production sales. Links performance to JOA for partner revenue allocation, lifting performance vs. entitlement, and underlift/overlift financial impact analysis',
    `marketing_deal_id` BIGINT COMMENT 'Foreign key linking to commercial.marketing_deal. Business justification: Commercial performance tracking can measure marketing deal execution. This FK links performance records to the specific marketing deal being tracked. Nullable - performance can track various commercia',
    `offtake_agreement_id` BIGINT COMMENT 'Reference to the offtake agreement for which performance is being tracked. Links to the commercial.offtake_agreement product. Nullable if performance is for a term contract or spot trade.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Performance tracking requires product identification for margin analysis. Business process: commercial performance reporting and variance analysis require product-level metrics.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Commercial performance tracking measures actual pricing vs. agreed pricing terms. This FK links performance records to the pricing agreement being evaluated. Nullable - not all performance tracking in',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Performance reporting for PSA entitlement crude sales. Links performance to PSA for contractor/government revenue split, cost recovery tracking, and profit oil realization vs. PSA fiscal terms.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Commercial performance tracking can measure sales order execution performance. This FK links performance records to the specific sales order being tracked. Nullable - performance can track contracts, ',
    `spot_trade_id` BIGINT COMMENT 'Reference to the spot trade for which performance is being tracked. Links to the commercial.spot_trade product. Nullable if performance is for a term contract or offtake agreement.',
    `actual_delivered_volume_quantity` DECIMAL(18,2) COMMENT 'The actual volume quantity delivered during the reporting period. Represents the realized volume for performance measurement.',
    `actual_revenue_amount` DECIMAL(18,2) COMMENT 'The actual revenue amount realized during the reporting period based on delivered volumes and realized pricing. Represents the achieved revenue for performance measurement.',
    `approved_by_user` STRING COMMENT 'The user ID or name of the person who approved this commercial performance record. Audit trail for approval authority.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this commercial performance record was approved and finalized. Represents the point at which the performance data became official.',
    `benchmark_price` DECIMAL(18,2) COMMENT 'The benchmark reference price (e.g., WTI, Brent, Henry Hub) applicable for the reporting period. Used to calculate price differentials and realized pricing performance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this commercial performance record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this performance record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `hedging_cost_amount` DECIMAL(18,2) COMMENT 'The net cost or benefit of hedging instruments (futures, swaps, options) associated with this commercial transaction during the reporting period.',
    `last_modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified this commercial performance record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this commercial performance record was last modified. Audit trail for record updates.',
    `marketing_margin_amount` DECIMAL(18,2) COMMENT 'The gross marketing margin realized during the reporting period, calculated as revenue minus direct costs (transportation, quality adjustments, hedging costs). Represents the commercial performance contribution.',
    `marketing_margin_per_unit` DECIMAL(18,2) COMMENT 'The marketing margin per unit of volume (e.g., per barrel, per MCF). Calculated as total marketing margin divided by actual delivered volume.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Indicates whether this commercial performance record is subject to or impacted by OPEC production quota management. True if OPEC quota constraints apply, false otherwise.',
    `performance_status` STRING COMMENT 'The current lifecycle status of this performance record: draft (being prepared), submitted (under review), approved (finalized), closed (archived), or adjusted (revised after initial approval).. Valid values are `draft|submitted|approved|closed|adjusted`',
    `period_end_date` DATE COMMENT 'The end date of the reporting period for which commercial performance is being measured. Defines the close of the performance window.',
    `period_start_date` DATE COMMENT 'The start date of the reporting period (monthly or quarterly) for which commercial performance is being measured. Defines the beginning of the performance window.',
    `planned_revenue_amount` DECIMAL(18,2) COMMENT 'The planned or budgeted revenue amount for the reporting period based on contracted pricing and planned volumes. Represents the target revenue for performance measurement.',
    `planned_volume_quantity` DECIMAL(18,2) COMMENT 'The planned or committed volume quantity for the reporting period as per the contract or agreement. Represents the target volume for performance measurement.',
    `price_differential` DECIMAL(18,2) COMMENT 'The difference between the realized price and the benchmark price. Positive indicates a premium, negative indicates a discount.',
    `price_uom` STRING COMMENT 'The unit of measure for pricing: per barrel, per BOE, per MCF, per MMBTU, per metric ton, or per gallon.. Valid values are `per_bbl|per_boe|per_mcf|per_mmbtu|per_mt|per_gal`',
    `quality_adjustment_amount` DECIMAL(18,2) COMMENT 'The total pricing adjustments (positive or negative) applied due to product quality variations from specification (e.g., API gravity, sulfur content, TAN adjustments).',
    `realized_price` DECIMAL(18,2) COMMENT 'The actual realized price per unit achieved during the reporting period, including all adjustments, differentials, and quality premiums or discounts.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this commercial performance record must be included in regulatory reporting (e.g., FERC, SEC, OPEC). True if regulatory reporting is required, false otherwise.',
    `reporting_period_type` STRING COMMENT 'The frequency or type of the reporting period: monthly, quarterly, annual, or spot (for one-time trades).. Valid values are `monthly|quarterly|annual|spot`',
    `responsible_business_unit` STRING COMMENT 'The business unit or division responsible for this commercial performance (e.g., Upstream Marketing, Downstream Sales, LNG Trading). Used for organizational performance tracking.',
    `revenue_variance_amount` DECIMAL(18,2) COMMENT 'The variance between planned and actual revenue (actual minus planned). Positive indicates revenue over-performance, negative indicates revenue under-performance.',
    `settlement_status` STRING COMMENT 'The financial settlement status for this performance period: pending (not yet settled), partial (partially invoiced/paid), complete (fully settled), or disputed (under dispute resolution).. Valid values are `pending|partial|complete|disputed`',
    `trader_name` STRING COMMENT 'The name of the trader or commercial manager responsible for executing and managing this commercial transaction.',
    `trading_book` STRING COMMENT 'The trading book or portfolio to which this commercial performance is allocated for risk management and P&L tracking purposes.',
    `transportation_cost_amount` DECIMAL(18,2) COMMENT 'The total transportation and logistics costs incurred during the reporting period to deliver the commodity to the delivery point.',
    `variance_commentary` STRING COMMENT 'Free-text commentary explaining significant variances between planned and actual performance, including root causes, market conditions, operational issues, or force majeure events.',
    `volume_uom` STRING COMMENT 'The unit of measure for volume quantities: barrels (bbl), Barrel of Oil Equivalent (BOE), thousand cubic feet (MCF), million cubic feet (MMCF), billion cubic feet (BCF), million British thermal units (MMBTU), metric tons (MT), or gallons (gal). [ENUM-REF-CANDIDATE: bbl|boe|mcf|mmcf|bcf|mmbtu|mt|gal — 8 candidates stripped; promote to reference product]',
    `volume_variance_quantity` DECIMAL(18,2) COMMENT 'The variance between planned and actual delivered volume (actual minus planned). Positive indicates over-delivery, negative indicates under-delivery.',
    CONSTRAINT pk_performance PRIMARY KEY(`performance_id`)
) COMMENT 'Transactional record capturing periodic (monthly/quarterly) commercial performance actuals against plan for each term contract, offtake agreement, or marketing deal. Records period, commodity, planned volume, actual delivered volume, planned revenue, actual revenue, realized price vs. benchmark, marketing margin, and variance commentary. Serves as the operational performance ledger for the commercial domain — distinct from financial revenue recognition owned by the revenue domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` (
    `commodity_exposure_id` BIGINT COMMENT 'Unique identifier for the commodity exposure record. Primary key for the commodity exposure transactional snapshot.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Commodity exposure includes term contract positions. This FK links exposure records to specific term contracts. Nullable - exposure can represent various position types or aggregated portfolio exposur',
    `hedging_instrument_id` BIGINT COMMENT 'Foreign key linking to commercial.hedging_instrument. Business justification: Commodity exposure includes hedging instrument positions. This FK links exposure records to specific hedging instruments. Nullable - exposure can represent physical positions, financial hedges, or agg',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Commodity risk exposure from JV production commitments. Links exposure to JOA for partner entitlement volume risk, underlift/overlift exposure, and value-at-risk calculation for JV equity crude.',
    `portfolio_id` BIGINT COMMENT 'Foreign key reference to the trading portfolio or risk management portfolio to which this exposure belongs. Enables portfolio-level aggregation and analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the trader or risk manager responsible for this exposure position. Supports performance attribution and accountability tracking.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Risk exposure from PSA entitlement crude. Links exposure to PSA for contractor profit oil volume risk, cost recovery ceiling impact, and mark-to-market valuation of government/contractor positions.',
    `spot_trade_id` BIGINT COMMENT 'Foreign key linking to commercial.spot_trade. Business justification: Commodity exposure includes spot trade positions. This FK links exposure records to specific spot trades. Nullable - exposure can represent various position types or aggregated portfolio exposure.',
    `trading_position_id` BIGINT COMMENT 'Foreign key linking to commercial.trading_position. Business justification: Commodity exposure is calculated from trading positions. This FK links an exposure calculation to the specific trading position it represents. Nullable - exposure can be aggregated across multiple pos',
    `approval_status` STRING COMMENT 'Approval workflow status for the exposure position: pending (awaiting review), approved (authorized), rejected (not authorized), or under review (in approval process).. Valid values are `pending|approved|rejected|under_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the exposure position was approved by the authorized user. Critical for audit trail and compliance with internal authorization policies.',
    `benchmark_price_reference` STRING COMMENT 'The market benchmark or index used for pricing this exposure (e.g., NYMEX WTI, ICE Brent, Henry Hub, Platts). Defines the pricing basis for valuation.',
    `benchmark_price_usd` DECIMAL(18,2) COMMENT 'Current market price of the benchmark reference at the valuation date, expressed in USD per unit (barrel, MMBtu, gallon). Used for mark-to-market calculations.',
    `business_unit` STRING COMMENT 'The business unit or division responsible for managing this exposure (e.g., Upstream Marketing, Downstream Trading, NGL Trading). Supports organizational reporting and accountability.',
    `calculation_method` STRING COMMENT 'The methodology or model used to calculate the exposure metrics (e.g., Historical Simulation VaR, Monte Carlo VaR, Parametric VaR, Delta-Normal). Documents the risk calculation approach for audit and validation.',
    `commodity_grade` STRING COMMENT 'Specific grade or quality specification of the commodity (e.g., WTI, Brent, Henry Hub, Ethane, Propane). Defines the exact product being traded or hedged.',
    `commodity_type` STRING COMMENT 'The primary commodity category for this exposure position. Aligns with upstream and downstream product classifications. [ENUM-REF-CANDIDATE: crude_oil|natural_gas|ngl|lng|lpg|refined_products|petrochemicals — 7 candidates stripped; promote to reference product]',
    `counterparty_concentration_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) signaling whether this exposure contributes to a counterparty concentration risk that exceeds internal risk limits or regulatory thresholds.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exposure record was first created in the system. Provides audit trail for data lineage and change tracking.',
    `credit_valuation_adjustment_usd` DECIMAL(18,2) COMMENT 'Credit valuation adjustment in USD reflecting the market value of counterparty credit risk. Represents the expected loss due to counterparty default over the life of the exposure.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the exposure valuation (e.g., USD, EUR, GBP). Defines the reporting currency for all monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'The upstream system or trading platform from which the exposure data was sourced (e.g., SAP SD, Endur, Allegro, RightAngle). Provides data lineage for reconciliation and audit.',
    `delta_equivalent_volume_boe` DECIMAL(18,2) COMMENT 'Risk-adjusted exposure volume accounting for option delta and other non-linear instrument sensitivities. Represents the equivalent linear exposure for risk management purposes.',
    `exposure_number` STRING COMMENT 'Business-facing unique reference number for the exposure snapshot, formatted as EXP-YYYYMMDD-XXXXXX for traceability and audit purposes.. Valid values are `^EXP-[0-9]{8}-[A-Z0-9]{6}$`',
    `exposure_status` STRING COMMENT 'Current lifecycle status of the exposure position: active (open position), closed (settled), expired (matured without rollover), rolled (extended to next tenor), or cancelled.. Valid values are `active|closed|expired|rolled|cancelled`',
    `gross_long_exposure_boe` DECIMAL(18,2) COMMENT 'Total long (buy) position exposure expressed in BOE. Represents the aggregate volume the company is committed to purchase or receive across all instruments in this commodity/tenor/instrument combination.',
    `gross_short_exposure_boe` DECIMAL(18,2) COMMENT 'Total short (sell) position exposure expressed in BOE. Represents the aggregate volume the company is committed to deliver or sell across all instruments in this commodity/tenor/instrument combination.',
    `hedge_designation` STRING COMMENT 'Accounting hedge designation status under IFRS 9 or GAAP: cash flow hedge, fair value hedge, net investment hedge, economic hedge (not designated for accounting), or not designated.. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|economic_hedge|not_designated`',
    `hedge_effectiveness_percentage` DECIMAL(18,2) COMMENT 'Measured effectiveness of the hedge relationship, expressed as a percentage. Must typically fall within 80-125% range to qualify for hedge accounting treatment under IFRS 9.',
    `instrument_type` STRING COMMENT 'Classification of the financial or physical instrument contributing to this exposure: physical contracts, exchange-traded futures, OTC swaps, options, basis swaps, crack spreads, or collar structures. [ENUM-REF-CANDIDATE: physical|futures|swaps|options|basis_swaps|crack_spreads|collars — 7 candidates stripped; promote to reference product]',
    `mark_to_market_value_usd` DECIMAL(18,2) COMMENT 'Current fair value of the exposure position based on prevailing market prices at the valuation date. Reflects unrealized gain or loss on the position.',
    `net_exposure_boe` DECIMAL(18,2) COMMENT 'Net commodity exposure calculated as gross long exposure minus gross short exposure, expressed in BOE. Positive values indicate net long position; negative values indicate net short position.',
    `notes` STRING COMMENT 'Free-text field for additional context, commentary, or special instructions related to this exposure position. Used for documenting unusual circumstances or risk management decisions.',
    `notional_value_usd` DECIMAL(18,2) COMMENT 'Total notional value of the exposure position in USD, calculated as net exposure volume multiplied by current market price. Used for portfolio sizing and limit monitoring.',
    `opec_quota_impact_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) identifying whether this exposure is subject to or influenced by OPEC production quota agreements and market coordination decisions.',
    `price_differential_usd` DECIMAL(18,2) COMMENT 'Basis differential or quality adjustment applied to the benchmark price, expressed in USD per unit. Accounts for location, quality, or delivery timing differences.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) signaling whether this exposure must be included in regulatory filings such as SEC disclosures, FERC reports, or CFTC position reports.',
    `risk_limit_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the applicable risk limit consumed by this exposure, calculated as (exposure amount / limit threshold) * 100. Used for limit monitoring and escalation triggers.',
    `stress_test_result_usd` DECIMAL(18,2) COMMENT 'Estimated profit or loss in USD under the specified stress test scenario. Negative values indicate potential losses; positive values indicate potential gains.',
    `stress_test_scenario` STRING COMMENT 'Name or identifier of the stress test scenario applied to this exposure (e.g., WTI Down 30%, OPEC Production Cut, Demand Shock). Links to predefined scenario library.',
    `tenor_bucket` STRING COMMENT 'Time horizon classification for the exposure: spot (immediate delivery), prompt (next month), M1-M3 (monthly buckets), Q1-Q4 (quarterly), CAL (calendar year strips), or long-term (beyond 3 years). [ENUM-REF-CANDIDATE: spot|prompt|m1|m2|m3|q1|q2|q3|q4|cal_1|cal_2|cal_3|long_term — 13 candidates stripped; promote to reference product]',
    `trading_book` STRING COMMENT 'The trading book or portfolio to which this exposure is allocated. Used for P&L attribution, risk limit monitoring, and trader performance evaluation.',
    `valuation_date` DATE COMMENT 'The business date on which this commodity exposure position was calculated and valued. Represents the snapshot date for mark-to-market valuation.',
    `valuation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the exposure calculation was executed, including time zone. Critical for intraday position reconciliation and audit trail.',
    `value_at_risk_usd` DECIMAL(18,2) COMMENT 'Statistical measure of potential loss in USD over a defined time horizon (typically 1-day or 10-day) at a specified confidence level (typically 95% or 99%). Quantifies downside risk exposure.',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'Confidence level used in the VaR calculation, expressed as a percentage (e.g., 95.00, 99.00). Indicates the probability that actual losses will not exceed the VaR estimate.',
    `var_time_horizon_days` STRING COMMENT 'Time horizon in days over which the VaR is calculated (typically 1, 10, or 20 days). Represents the holding period assumption for the risk calculation.',
    CONSTRAINT pk_commodity_exposure PRIMARY KEY(`commodity_exposure_id`)
) COMMENT 'Transactional record quantifying the net commodity price exposure of the commercial portfolio at a given valuation date, broken down by commodity, tenor bucket, and instrument type (physical, futures, swaps, options). Captures gross long exposure, gross short exposure, net exposure in BOE, delta-equivalent volume, value-at-risk (VaR), and stress-test scenario results. Supports commercial risk management and treasury reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` (
    `commercial_counterparty_id` BIGINT COMMENT 'Unique identifier for the commercial counterparty record. Primary key for the commercial counterparty master data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Counterparty relationship management, credit review coordination, and commercial performance tracking require linking relationship managers to employee records for CRM analytics, performance reviews, ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Commercial counterparties (trading houses, refiners) are often also vendors in procurement. Required for master data management, consolidated credit limit tracking, sanctions screening coordination, a',
    `aml_status` STRING COMMENT 'Current Anti-Money Laundering screening status for this counterparty. Cleared (no issues), flagged (potential concern), under review (investigation in progress), or blocked (prohibited from trading).. Valid values are `cleared|flagged|under_review|blocked`',
    `approved_commodity_list` STRING COMMENT 'Comma-separated list of commodity types this counterparty is approved to trade. May include crude oil, LNG, LPG, NGL, refined products (gasoline, diesel, jet fuel), petrochemicals. Restricts trading activity to approved product categories.',
    `approved_credit_limit` DECIMAL(18,2) COMMENT 'The maximum credit exposure amount approved for this counterparty by the credit committee. Expressed in the credit limit currency. Represents the total unsecured exposure the company is willing to accept.',
    `available_credit` DECIMAL(18,2) COMMENT 'The remaining credit capacity available for new transactions with this counterparty. Calculated as approved credit limit minus credit utilization. Used for real-time credit checks during trade execution.',
    `commercial_counterparty_status` STRING COMMENT 'Current operational status of the counterparty relationship. Active (approved for trading), inactive (no current activity but approved), suspended (temporarily restricted), or blocked (prohibited from trading).. Valid values are `active|inactive|suspended|blocked`',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where the counterparty is legally incorporated. Critical for sanctions screening and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this counterparty record was first created in the system. Used for audit trail and data lineage.',
    `credit_limit_currency` STRING COMMENT 'Three-letter ISO currency code for the approved credit limit. Typically USD for international oil and gas trading.. Valid values are `^[A-Z]{3}$`',
    `credit_limit_type` STRING COMMENT 'The type of credit support backing the approved limit. Unsecured (no collateral), letter of credit (LC), parent company guarantee, or cash collateral. Determines risk mitigation approach.. Valid values are `unsecured|letter_of_credit|parent_guarantee|cash_collateral`',
    `credit_rating` STRING COMMENT 'The current credit rating assigned to the counterparty by the specified rating agency. Format varies by agency (e.g., AAA, Baa2, BBB+). Drives credit limit and collateral requirements.',
    `credit_rating_agency` STRING COMMENT 'The agency providing the credit rating for this counterparty. Moodys, S&P (Standard & Poors), Fitch, internal rating, or not rated.. Valid values are `Moodys|SP|Fitch|internal|not_rated`',
    `credit_rating_date` DATE COMMENT 'The date when the current credit rating was assigned or last affirmed. Used to determine if rating is current for credit decisions.',
    `credit_review_frequency` STRING COMMENT 'The scheduled frequency for periodic credit review of this counterparty. Determined by credit rating, exposure level, and risk tier. Higher risk counterparties require more frequent reviews.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `credit_utilization` DECIMAL(18,2) COMMENT 'The current amount of credit exposure utilized by this counterparty across all open transactions and commitments. Expressed in the credit limit currency. Updated in near real-time from trading and invoicing systems.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet identifier for the counterparty. Used for credit assessment and third-party data enrichment.. Valid values are `^[0-9]{9}$`',
    `entity_type` STRING COMMENT 'Classification of the counterparty organization type. IOC (International Oil Company), NOC (National Oil Company), independent trader, refiner, utility, or industrial buyer. Determines credit assessment approach and commercial terms.. Valid values are `IOC|NOC|independent_trader|refiner|utility|industrial_buyer`',
    `headquarters_address` STRING COMMENT 'The full street address of the counterpartys corporate headquarters. Used for legal notices and correspondence.',
    `headquarters_city` STRING COMMENT 'The city where the counterpartys corporate headquarters is located.',
    `headquarters_country` STRING COMMENT 'Three-letter ISO country code for the country where the counterpartys corporate headquarters is located. May differ from country of incorporation.. Valid values are `^[A-Z]{3}$`',
    `isda_agreement_date` DATE COMMENT 'The effective date of the executed ISDA master agreement. Null if no agreement is in place.',
    `isda_agreement_status` STRING COMMENT 'Status of the ISDA master agreement with this counterparty. Executed (in force), pending (under negotiation), not required (no derivatives trading), or expired. Required for hedging and derivative transactions.. Valid values are `executed|pending|not_required|expired`',
    `kyc_completion_date` DATE COMMENT 'The date when the most recent KYC review was completed and approved. Used to determine when the next periodic refresh is due.',
    `kyc_expiration_date` DATE COMMENT 'The date when the current KYC approval expires and a refresh review is required. Typically 12-24 months from completion date based on risk tier.',
    `kyc_status` STRING COMMENT 'Current status of the Know Your Customer due diligence process for this counterparty. Approved (cleared for trading), pending (under review), expired (requires refresh), or rejected (not approved for business).. Valid values are `approved|pending|expired|rejected`',
    `last_credit_review_date` DATE COMMENT 'The date when the most recent credit review was completed by the credit committee. Documents recency of credit assessment.',
    `legal_name` STRING COMMENT 'The full legal name of the counterparty as registered with the governing authority in their country of incorporation. Used for contract execution and regulatory reporting.',
    `modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified this counterparty record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this counterparty record was last modified. Used for audit trail and change tracking.',
    `next_credit_review_date` DATE COMMENT 'The scheduled date for the next periodic credit review. Used to trigger credit committee review workflow.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the counterparty relationship. Used for operational guidance and institutional knowledge.',
    `onboarding_date` DATE COMMENT 'The date when this counterparty was first approved and onboarded for commercial trading. Marks the start of the business relationship.',
    `payment_terms_days` STRING COMMENT 'The standard number of days allowed for payment after invoice date for this counterparty. Common terms are 30, 60, or 90 days. Negotiated based on credit profile and relationship.',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact. Used for trade confirmations, invoicing, and commercial correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The name of the primary business contact at the counterparty organization for commercial and credit matters.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary business contact. Used for urgent commercial and operational communications.',
    `risk_tier` STRING COMMENT 'Internal risk classification tier for this counterparty based on credit rating, country risk, payment history, and exposure. Drives approval authority levels and monitoring intensity.. Valid values are `low|medium|high|critical`',
    `sanctions_screening_date` DATE COMMENT 'The date when the most recent sanctions screening was performed. Screening is typically performed daily or in real-time for active counterparties.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions list screening against OFAC, UN, EU, and other regulatory watchlists. Cleared (no match), flagged (potential match requiring review), or blocked (confirmed match, trading prohibited).. Valid values are `cleared|flagged|blocked`',
    `short_name` STRING COMMENT 'Abbreviated or trading name of the counterparty used for operational reference and reporting displays.',
    `status_reason` STRING COMMENT 'Explanation for the current status, particularly for suspended or blocked counterparties. Documents business justification for status changes.',
    `tax_identification_number` STRING COMMENT 'The counterpartys tax identification number or equivalent (EIN, VAT number, etc.) in their country of incorporation. Used for tax reporting and withholding compliance.',
    `venture_partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Commercial counterparties are often JV partners buying/selling equity crude. Links counterparty to partner for credit limit alignment, netting agreement coordination, and partner-specific commercial t',
    CONSTRAINT pk_commercial_counterparty PRIMARY KEY(`commercial_counterparty_id`)
) COMMENT 'Master record for commercial counterparties and their credit profiles, covering entities engaged in crude oil trading, LNG/LPG sales, refined product distribution, and petrochemical marketing — including IOCs, NOCs, independent traders, refiners, utilities, and industrial buyers. Captures counterparty legal name, entity type, country of incorporation, credit rating, approved credit limit (amount, currency, type — unsecured/LC/parent guarantee), credit utilization and available headroom, approved commodity list, ISDA agreement status, KYC/AML compliance status, and credit review schedule. Scoped to commercial trading relationships and credit risk management; full customer identity master is owned by the customer domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`credit_limit` (
    `credit_limit_id` BIGINT COMMENT 'Unique identifier for the credit limit record. Primary key for the credit limit master data.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the trading counterparty to whom this credit limit is assigned. Links to the customer counterparty master record.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` (
    `commercial_price_index_preference_id` BIGINT COMMENT 'Primary key for commercial_price_index_preference',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to the customer or counterparty who has this price index preference',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to the commodity price index that is preferred by this customer',
    `price_index_preference_price_index_id` BIGINT COMMENT 'Unique surrogate identifier for each customer price index preference record. Primary key.',
    `applicable_product_types` STRING COMMENT 'Comma-separated list of commodity product types to which this price index preference applies (e.g., crude_oil, refined_products, natural_gas). Allows customers to have different index preferences for different product categories.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this price index preference automatically renews at the end of the effective_until period. True means the preference rolls over unless explicitly terminated; false means it expires and requires renegotiation.',
    `ceiling_price_usd` DECIMAL(18,2) COMMENT 'Maximum price in USD per unit that will be charged to this customer regardless of how high the index price rises. Protects the customer from extreme market spikes while allowing the seller to benefit from index-linked pricing. Null if no ceiling is negotiated.',
    `contract_reference` STRING COMMENT 'Reference to the master sales agreement, pricing contract, or framework agreement that governs this price index preference. Links the preference to the legal contract documentation.',
    `differential_usd` DECIMAL(18,2) COMMENT 'Negotiated price differential in USD applied to the published index price for this customer. Positive values indicate a premium above the index; negative values indicate a discount below the index. This differential reflects customer-specific pricing agreements based on volume, relationship, credit terms, or delivery logistics.',
    `effective_from` DATE COMMENT 'The date from which this price index preference becomes effective and can be used in pricing calculations for this customer. Typically aligned with contract effective dates or pricing agreement start dates.',
    `effective_until` DATE COMMENT 'The date until which this price index preference remains valid for this customer. After this date, the preference expires unless renewed. Null indicates an open-ended preference subject to contract terms.',
    `floor_price_usd` DECIMAL(18,2) COMMENT 'Minimum price in USD per unit that will be charged to this customer regardless of how low the index price falls. Protects the seller from extreme market downturns while providing the customer with index-linked pricing benefits. Null if no floor is negotiated.',
    `negotiated_by` STRING COMMENT 'Name or employee identifier of the commercial manager or trader who negotiated this price index preference with the customer. Used for accountability and relationship management.',
    `negotiated_date` DATE COMMENT 'Date on which this price index preference was negotiated and agreed with the customer. May differ from effective_from if there is a lag between agreement and implementation.',
    `notes` STRING COMMENT 'Free-text notes capturing special terms, conditions, or context about this price index preference that are not captured in structured fields. May include references to side letters, special delivery terms, or market conditions at time of negotiation.',
    `preference_rank` BIGINT COMMENT 'Ordinal ranking of this price index preference when a customer has multiple active index preferences for different products or contract types. Rank 1 indicates primary preference, rank 2 secondary, etc. Used to determine which index to apply when multiple are valid.',
    `preference_status` STRING COMMENT 'Current lifecycle status of this price index preference. Active preferences are currently used in pricing calculations. Pending indicates negotiated but not yet effective. Inactive indicates temporarily suspended. Expired indicates the validity period has ended.',
    CONSTRAINT pk_commercial_price_index_preference PRIMARY KEY(`commercial_price_index_preference_id`)
) COMMENT 'This association product represents the pricing preference relationship between customer counterparties and commodity price indices. It captures the customers preferred benchmark indices for pricing agreements, including negotiated differentials, price floors/ceilings, and validity periods. Each record links one customer counterparty to one price index with relationship-specific attributes that govern how that index is applied in commercial transactions with that customer.. Existence Justification: In oil and gas commercial operations, customers negotiate pricing agreements that reference multiple commodity price indices (e.g., Brent for European contracts, WTI for North American contracts, Dubai for Asian contracts) depending on product type, delivery location, and contract terms. Each customer-index combination has relationship-specific attributes including negotiated differentials, price floors/ceilings, and validity periods that cannot be stored on either the customer or the index entity alone. The detection phase explicitly identified an existing price_index_preference association product with these relationship attributes already in the operational model.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` (
    `contract_pricing_term_id` BIGINT COMMENT 'Unique system identifier for this contract pricing term record. Primary key.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to the term contract to which this pricing term applies',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to the pricing agreement that defines the pricing formula and differentials',
    `amendment_reference` STRING COMMENT 'Reference to the contract amendment or addendum that established or modified this pricing term. Links pricing changes to formal contract modifications for audit and compliance purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing term record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this specific pricing term becomes applicable to the contract. May differ from both the contract effective date and the pricing agreement effective date, as pricing terms can be amended or added during contract lifecycle.',
    `expiration_date` DATE COMMENT 'Date when this specific pricing term ceases to apply to the contract. Allows for time-bound pricing arrangements within longer-term contracts (e.g., seasonal pricing, promotional periods, or phased pricing transitions).',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this pricing term record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing term record was last modified.',
    `priority_sequence` STRING COMMENT 'Numeric priority order for applying this pricing term when multiple pricing agreements could apply to the same contract scenario. Lower numbers indicate higher priority. Used to resolve pricing logic when overlapping conditions exist (e.g., general pricing vs. promotional pricing).',
    `product_grade` STRING COMMENT 'Specific product grade or quality specification to which this pricing term applies (e.g., WTI_LIGHT_SWEET, BRENT_CRUDE, HENRY_HUB_GAS, DIESEL_ULSD). A single contract may have different pricing agreements for different product grades.',
    `term_status` STRING COMMENT 'Current lifecycle status of this pricing term: draft (under negotiation), active (currently in effect), suspended (temporarily inactive), expired (past expiration date), superseded (replaced by newer term).',
    `volume_tier_maximum` DECIMAL(18,2) COMMENT 'Maximum volume threshold (in contract UOM) at which this pricing term applies. Null indicates no upper limit for this tier. Used in conjunction with volume_tier_minimum to define tiered pricing bands.',
    `volume_tier_minimum` DECIMAL(18,2) COMMENT 'Minimum volume threshold (in contract UOM) at which this pricing term becomes applicable. Enables tiered pricing structures where different pricing agreements apply at different volume levels (e.g., 0-10K BBL at one price, 10K-50K BBL at another).',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this pricing term record.',
    CONSTRAINT pk_contract_pricing_term PRIMARY KEY(`contract_pricing_term_id`)
) COMMENT 'This association product represents the pricing term relationship between term contracts and pricing agreements in oil & gas commercial operations. It captures the specific pricing arrangement applied to a contract during a defined period, including volume tiers, product grades, and priority sequencing when multiple pricing agreements may apply to the same contract. Each record links one term contract to one pricing agreement with attributes that govern how pricing is calculated for specific delivery scenarios.. Existence Justification: In oil & gas commercial operations, term contracts frequently require multiple pricing agreements to handle different scenarios: seasonal pricing variations, volume-tiered pricing structures, product grade differentials, and time-phased pricing transitions. Conversely, a single master pricing agreement (e.g., a published basin differential or a standard counterparty pricing formula) is routinely applied across multiple term contracts. Commercial teams actively manage these pricing term assignments as contracts are amended, market conditions change, or volume commitments are restructured.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`portfolio` (
    `portfolio_id` BIGINT COMMENT 'Primary key for portfolio',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the portfolio.',
    `manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_portfolio_id` BIGINT COMMENT 'Self-referencing FK on portfolio (parent_portfolio_id)',
    `asset_class` STRING COMMENT 'Classification of assets within the portfolio.',
    `benchmark_index` STRING COMMENT 'Reference index used to measure portfolio performance (e.g., WTI, Brent).',
    `confidentiality_level` STRING COMMENT 'Data classification level for the portfolio information.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the portfolio record was created.',
    `currency` STRING COMMENT 'Currency in which monetary values of the portfolio are expressed.',
    `portfolio_description` STRING COMMENT 'Detailed description of the portfolios purpose and scope.',
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
    `portfolio_name` STRING COMMENT 'Human readable name of the portfolio.',
    `portfolio_type` STRING COMMENT 'Category of portfolio based on its primary purpose.',
    `region` STRING COMMENT 'Primary geographic region of the portfolios assets.',
    `regulatory_status` STRING COMMENT 'Compliance status of the portfolio with relevant regulations.',
    `reporting_category` STRING COMMENT 'Category of reporting applicable to the portfolio.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the portfolio based on exposure and volatility.',
    `portfolio_status` STRING COMMENT 'Current lifecycle status of the portfolio.',
    `total_market_value` DECIMAL(18,2) COMMENT 'Current market value of all assets in the portfolio.',
    `valuation_method` STRING COMMENT 'Method used for the latest valuation of the portfolio.',
    CONSTRAINT pk_portfolio PRIMARY KEY(`portfolio_id`)
) COMMENT 'Master reference table for portfolio. Referenced by portfolio_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Primary key for opportunity',
    `account_id` BIGINT COMMENT 'Identifier of the customer account linked to the opportunity.',
    `campaign_id` BIGINT COMMENT 'Marketing campaign identifier associated with the opportunity.',
    `commercial_counterparty_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_counterparty. Business justification: Opportunity represents a sales prospect with a specific counterparty; adding commercial_counterparty_id creates the required inbound relationship.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales rep owning the opportunity.',
    `product_catalog_id` BIGINT COMMENT 'Identifier of the product or service being pursued in the opportunity.',
    `parent_opportunity_id` BIGINT COMMENT 'Self-referencing FK on opportunity (parent_opportunity_id)',
    `competitor` STRING COMMENT 'Name of the primary competitor involved in the opportunity, if any.',
    `contract_term_months` STRING COMMENT 'Proposed length of the contract in months if the opportunity is won.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the opportunity record was first created in the system.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated amount.',
    `opportunity_description` STRING COMMENT 'Free‑text description of the opportunity, including business context and objectives.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount offered on the estimated amount.',
    `effective_from` DATE COMMENT 'Date when the opportunity is expected to become active or start.',
    `effective_until` DATE COMMENT 'Projected close or expiry date for the opportunity.',
    `estimated_amount` DECIMAL(18,2) COMMENT 'Projected gross revenue value of the opportunity.',
    `expected_margin_percent` DECIMAL(18,2) COMMENT 'Projected profit margin percentage for the opportunity.',
    `forecast_category` STRING COMMENT 'Sales forecast bucket used for revenue planning.',
    `is_cross_border` BOOLEAN COMMENT 'True if the opportunity involves cross‑border trade or regulatory considerations.',
    `is_key_account` BOOLEAN COMMENT 'True if the opportunity is linked to a strategic key account.',
    `is_new_customer` BOOLEAN COMMENT 'True if the opportunity is for a brand‑new customer.',
    `last_activity_date` DATE COMMENT 'Date of the most recent interaction or update on the opportunity.',
    `lead_source` STRING COMMENT 'Origin channel through which the opportunity was generated.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the opportunity, typically reflecting the deal or project.',
    `notes` STRING COMMENT 'Additional remarks, observations, or follow‑up items captured by the sales team.',
    `opportunity_number` STRING COMMENT 'External reference number assigned to the opportunity, used in sales and reporting systems.',
    `pricing_model` STRING COMMENT 'Pricing approach proposed for the opportunity.',
    `priority` STRING COMMENT 'Business priority assigned to the opportunity.',
    `probability_percent` STRING COMMENT 'Estimated likelihood of winning the opportunity expressed as a percentage.',
    `risk_score` STRING COMMENT 'Internal risk rating (0-100) assessing likelihood of loss or issues.',
    `sales_region` STRING COMMENT 'Geographic region associated with the opportunity.',
    `sales_stage` STRING COMMENT 'Current stage of the sales process for the opportunity.',
    `sales_territory` STRING COMMENT 'Specific sales territory or district for the opportunity.',
    `opportunity_status` STRING COMMENT 'Current lifecycle stage of the opportunity.',
    `opportunity_type` STRING COMMENT 'Category of the opportunity indicating its business nature.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the opportunity record.',
    `win_loss_reason` STRING COMMENT 'Reason recorded for winning or losing the opportunity.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Master reference table for opportunity. Referenced by opportunity_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` (
    `tariff_agreement_id` BIGINT COMMENT 'Primary key for tariff_agreement',
    `commercial_counterparty_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_counterparty. Business justification: Tariff Agreement is a pricing contract with a counterparty; adding commercial_counterparty_id links it to the relevant counterparty.',
    `parent_tariff_agreement_id` BIGINT COMMENT 'Self-referencing FK on tariff_agreement (parent_tariff_agreement_id)',
    `agreement_number` STRING COMMENT 'External contract reference number assigned by the commercial team.',
    `agreement_title` STRING COMMENT 'Descriptive title of the tariff agreement for easy identification.',
    `agreement_type` STRING COMMENT 'Classification of the agreement based on commercial purpose.',
    `amendment_count` STRING COMMENT 'Number of times the agreement has been amended.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the agreement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement was approved.',
    `billing_cycle` STRING COMMENT 'Frequency at which billing occurs for the agreement.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the agreement complies with relevant regulatory requirements.',
    `confidentiality_level` STRING COMMENT 'Granular confidentiality classification of the agreement.',
    `contract_category` STRING COMMENT 'Business domain classification of the agreement.',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the agreement over its life.',
    `contract_value_currency` STRING COMMENT 'Currency of the contract value amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for pricing in the agreement.',
    `tariff_agreement_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and key terms of the agreement.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Numeric discount value (percentage or fixed amount) as defined by discount_type.',
    `discount_type` STRING COMMENT 'Category of discount applied under the agreement.',
    `effective_from` DATE COMMENT 'Date when the tariff agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the tariff agreement expires or is scheduled to end; null for open‑ended contracts.',
    `escalation_frequency` STRING COMMENT 'How often price escalations are applied.',
    `escalation_percentage` DECIMAL(18,2) COMMENT 'Percentage increase applied at each escalation interval.',
    `governing_law` STRING COMMENT 'Legal jurisdiction governing the agreement.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the agreement is classified as confidential.',
    `jurisdiction` STRING COMMENT 'Geographic region or country where the agreement is enforceable.',
    `notice_period_days` STRING COMMENT 'Number of days notice required to terminate or not renew.',
    `payment_terms` STRING COMMENT 'Terms governing payment schedule, invoicing, and settlement.',
    `price_basis` STRING COMMENT 'Method used to calculate the price (e.g., fixed, indexed to market).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Base price applied per unit of the commodity.',
    `price_unit_of_measure` STRING COMMENT 'Unit in which the price is expressed (e.g., barrel, MMBtu).',
    `pricing_model` STRING COMMENT 'Model used to calculate pricing under the agreement.',
    `renewal_option` STRING COMMENT 'Specifies if and how the agreement can be renewed.',
    `renewal_period_months` STRING COMMENT 'Length of the renewal term in months.',
    `signed_by` STRING COMMENT 'Name or identifier of the party that signed the agreement.',
    `signed_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement was signed.',
    `tariff_agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.',
    `termination_date` DATE COMMENT 'Date on which the agreement may be terminated by either party.',
    `tiered_pricing_flag` BOOLEAN COMMENT 'Indicates whether the agreement uses tiered pricing structures.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the agreement record.',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Total volume of commodity committed under the agreement.',
    CONSTRAINT pk_tariff_agreement PRIMARY KEY(`tariff_agreement_id`)
) COMMENT 'Master reference table for tariff_agreement. Referenced by tariff_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_index`(`price_index_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `oil_gas_ecm`.`commercial`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_hedging_instrument_id` FOREIGN KEY (`hedging_instrument_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_instrument`(`hedging_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_index`(`price_index_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ADD CONSTRAINT `fk_commercial_price_differential_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_index`(`price_index_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_hedging_instrument_id` FOREIGN KEY (`hedging_instrument_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_instrument`(`hedging_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_index`(`price_index_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_hedging_instrument_id` FOREIGN KEY (`hedging_instrument_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_instrument`(`hedging_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_trading_position_id` FOREIGN KEY (`trading_position_id`) REFERENCES `oil_gas_ecm`.`commercial`.`trading_position`(`trading_position_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ADD CONSTRAINT `fk_commercial_commercial_volume_commitment_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ADD CONSTRAINT `fk_commercial_commercial_volume_commitment_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ADD CONSTRAINT `fk_commercial_delivery_schedule_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ADD CONSTRAINT `fk_commercial_delivery_schedule_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ADD CONSTRAINT `fk_commercial_delivery_schedule_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ADD CONSTRAINT `fk_commercial_delivery_schedule_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ADD CONSTRAINT `fk_commercial_index_price_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_index`(`price_index_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_hedging_instrument_id` FOREIGN KEY (`hedging_instrument_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_instrument`(`hedging_instrument_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `oil_gas_ecm`.`commercial`.`portfolio`(`portfolio_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_trading_position_id` FOREIGN KEY (`trading_position_id`) REFERENCES `oil_gas_ecm`.`commercial`.`trading_position`(`trading_position_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ADD CONSTRAINT `fk_commercial_credit_limit_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ADD CONSTRAINT `fk_commercial_commercial_price_index_preference_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_index`(`price_index_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ADD CONSTRAINT `fk_commercial_commercial_price_index_preference_price_index_preference_price_index_id` FOREIGN KEY (`price_index_preference_price_index_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_index`(`price_index_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ADD CONSTRAINT `fk_commercial_contract_pricing_term_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ADD CONSTRAINT `fk_commercial_contract_pricing_term_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ADD CONSTRAINT `fk_commercial_portfolio_parent_portfolio_id` FOREIGN KEY (`parent_portfolio_id`) REFERENCES `oil_gas_ecm`.`commercial`.`portfolio`(`portfolio_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_parent_opportunity_id` FOREIGN KEY (`parent_opportunity_id`) REFERENCES `oil_gas_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ADD CONSTRAINT `fk_commercial_tariff_agreement_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ADD CONSTRAINT `fk_commercial_tariff_agreement_parent_tariff_agreement_id` FOREIGN KEY (`parent_tariff_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`tariff_agreement`(`tariff_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`commercial` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`commercial` SET TAGS ('dbx_domain' = 'commercial');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management Of Change Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Risk Assessment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management Of Change Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Spec Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `certificate_of_quality_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Quality Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `tertiary_sales_bill_to_party_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Party Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `tertiary_sales_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `tertiary_sales_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ALTER COLUMN `tertiary_sales_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ALTER COLUMN `quality_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Result Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ALTER COLUMN `origin_basin` SET TAGS ('dbx_business_glossary_term' = 'Origin Basin');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `price_differential_id` SET TAGS ('dbx_business_glossary_term' = 'Price Differential Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'API (American Petroleum Institute) Gravity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User or Role');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'crude_oil|natural_gas|ngl|lng|lpg|refined_product');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'term|spot|swap|forward|option');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location or Hub');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `differential_currency` SET TAGS ('dbx_business_glossary_term' = 'Differential Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `differential_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `differential_value` SET TAGS ('dbx_business_glossary_term' = 'Differential Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `hedging_instrument_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `market_source` SET TAGS ('dbx_business_glossary_term' = 'Market Data Source');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `market_source` SET TAGS ('dbx_value_regex' = 'platts|argus|opis|reuters|bloomberg|internal');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Differential Notes and Comments');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OPEC (Organization of the Petroleum Exporting Countries) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `origin_basin` SET TAGS ('dbx_business_glossary_term' = 'Origin Basin or Field');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `pour_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Pour Point in Celsius');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `price_differential_status` SET TAGS ('dbx_business_glossary_term' = 'Differential Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `price_differential_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `pricing_formula` SET TAGS ('dbx_business_glossary_term' = 'Pricing Formula Description');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `quality_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Factor');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `seasonal_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|rail|truck|barge');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `viscosity_cst` SET TAGS ('dbx_business_glossary_term' = 'Viscosity in Centistokes (cSt)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `volume_tier_maximum_bbl` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Maximum in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ALTER COLUMN `volume_tier_minimum_bbl` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Minimum in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `trading_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Position Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Trader ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `pricing_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Benchmark Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedging_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Hedging Transaction Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `delivery_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Preference Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Terminal Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `nomination_party` SET TAGS ('dbx_business_glossary_term' = 'Nomination Party');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `nomination_party` SET TAGS ('dbx_value_regex' = 'buyer|seller');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_business_glossary_term' = 'Vessel International Maritime Organization (IMO) Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_type` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `vessel_type` SET TAGS ('dbx_value_regex' = 'vlcc|suezmax|aframax|panamax|lng_carrier|lpg_carrier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MT|M3|MMBTU|GAL');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commercial_volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Volume Commitment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `opec_quota_position_id` SET TAGS ('dbx_business_glossary_term' = 'Opec Quota Position Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'trader|manager|director|vp|svp|executive');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|fulfilled|defaulted|waived|renegotiated');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'minimum_volume_obligation|take_or_pay|ship_or_pay|throughput_commitment|annual_contract_quantity|delivery_obligation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `committed_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `committed_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `cumulative_deficiency_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Deficiency Payment Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `cumulative_deficiency_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `cumulative_deficiency_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Deficiency Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `cumulative_delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Delivered Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `cumulative_make_up_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Make-Up Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `deficiency_payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Payment Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `deficiency_payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `deficiency_payment_rate` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Payment Rate');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `deficiency_payment_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `delivery_performance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Performance Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `force_majeure_end_date` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `force_majeure_start_date` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `force_majeure_suspension_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Suspension Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `make_up_period_months` SET TAGS ('dbx_business_glossary_term' = 'Make-Up Period Months');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `make_up_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Make-Up Rights Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `minimum_take_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Take Threshold Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `opec_quota_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Allocation Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `opec_quota_allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Allocation Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `renegotiation_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Renegotiation Trigger Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `renegotiation_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Renegotiation Trigger Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ALTER COLUMN `tolerance_band_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Band Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Terminal ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Trader ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `actual_volume_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Delivered');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `deferral_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferral Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `deferred_to_month` SET TAGS ('dbx_business_glossary_term' = 'Deferred To Month');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `deficiency_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Payment Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|barge|truck|rail|fpso');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_price` SET TAGS ('dbx_business_glossary_term' = 'Delivery Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Value Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `delivery_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `force_majeure_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `force_majeure_reason` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Reason');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `grade_specification` SET TAGS ('dbx_business_glossary_term' = 'Product Grade Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `maximum_volume_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Tolerance');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `minimum_volume_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Tolerance');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `nomination_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Deadline Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `nomination_received_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Received Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `nomination_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Nomination Received Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `planned_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `planned_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^DS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|in_transit|delivered|cancelled|deferred');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `scheduled_delivery_month` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Month');
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ALTER COLUMN `volume_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `trade_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_value_regex' = 'spot|futures|forward|swap|physical');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `closing_price` SET TAGS ('dbx_business_glossary_term' = 'Closing Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'crude_oil|natural_gas|ngl|lpg|refined_products|petrochemicals');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `contract_month` SET TAGS ('dbx_business_glossary_term' = 'Contract Month');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'verified|pending|anomaly_detected|corrected|estimated');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_business_glossary_term' = 'Delivery Basis');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `delivery_basis` SET TAGS ('dbx_value_regex' = 'fob|cif|dap|exw|fas|cfr');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `grade_specification` SET TAGS ('dbx_business_glossary_term' = 'Grade Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `hedging_instrument_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedging Instrument Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `high_price` SET TAGS ('dbx_business_glossary_term' = 'High Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `index_code` SET TAGS ('dbx_business_glossary_term' = 'Price Index Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `index_name` SET TAGS ('dbx_business_glossary_term' = 'Price Index Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `index_status` SET TAGS ('dbx_business_glossary_term' = 'Index Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `index_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `last_publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Publication Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `low_price` SET TAGS ('dbx_business_glossary_term' = 'Low Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `opec_quota_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Relevance Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `opening_price` SET TAGS ('dbx_business_glossary_term' = 'Opening Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Price Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `price_differential_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Differential Basis');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'usd_per_bbl|usd_per_mmbtu|usd_per_gallon|usd_per_mt|usd_per_mcf');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Publication Frequency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|intraday|real_time');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `publication_source` SET TAGS ('dbx_business_glossary_term' = 'Publication Source');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `published_price` SET TAGS ('dbx_business_glossary_term' = 'Published Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `revision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revision Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `settlement_price` SET TAGS ('dbx_business_glossary_term' = 'Settlement Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_index` ALTER COLUMN `trading_volume` SET TAGS ('dbx_business_glossary_term' = 'Trading Volume');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `index_price_id` SET TAGS ('dbx_business_glossary_term' = 'Index Price Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `benchmark_flag` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `closing_price` SET TAGS ('dbx_business_glossary_term' = 'Closing Price Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `delivery_period` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `delivery_period` SET TAGS ('dbx_value_regex' = 'prompt|front_month|next_month|quarterly|annual');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `high_price` SET TAGS ('dbx_business_glossary_term' = 'High Price Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `low_price` SET TAGS ('dbx_business_glossary_term' = 'Low Price Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OPEC (Organization of the Petroleum Exporting Countries) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `opening_price` SET TAGS ('dbx_business_glossary_term' = 'Opening Price Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Price Confidence Level');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Price Observation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_notes` SET TAGS ('dbx_business_glossary_term' = 'Price Observation Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'published|preliminary|revised|corrected|estimated');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'spot|futures|forward|assessed|calculated');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'BBL|MMBTU|GAL|MT|KG|LB');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `publication_source` SET TAGS ('dbx_business_glossary_term' = 'Publication Source');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `published_price` SET TAGS ('dbx_business_glossary_term' = 'Published Index Price Value');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `reference_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Reference Benchmark Index');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `sanctions_screening_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `trading_day_flag` SET TAGS ('dbx_business_glossary_term' = 'Trading Day Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `volume_traded` SET TAGS ('dbx_business_glossary_term' = 'Volume Traded');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`index_price` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MMBTU|GAL|MT|KG|LB');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `quota_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `opec_quota_position_id` SET TAGS ('dbx_business_glossary_term' = 'Opec Quota Position Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `actual_production_bopd` SET TAGS ('dbx_business_glossary_term' = 'Actual Production in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Adjustment Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Quota Adjustment Reason');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocated_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocated_volume_bopd` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^QA-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|revised|cancelled');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'opec_country|internal_asset|equity_partner|field_level|joint_venture|production_sharing');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `benchmark_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Reference Index');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `benchmark_reference` SET TAGS ('dbx_value_regex' = 'opec_basket|wti|brent|dubai|urals|other');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `compliance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quota Allocation Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `overlift_position_barrels` SET TAGS ('dbx_business_glossary_term' = 'Over-Lift Position in Barrels');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `quota_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Quota Manager Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `quota_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `quota_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `regulatory_reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Obligation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `regulatory_reporting_obligation` SET TAGS ('dbx_value_regex' = 'opec_monthly|sec_annual|bsee_quarterly|internal_only|none');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `reporting_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Deadline Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `underlift_position_barrels` SET TAGS ('dbx_business_glossary_term' = 'Under-Lift Position in Barrels');
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ALTER COLUMN `variance_bopd` SET TAGS ('dbx_business_glossary_term' = 'Variance in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `cargo_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `h2s_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'H2S Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Marine Services Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `opec_quota_position_id` SET TAGS ('dbx_business_glossary_term' = 'Opec Quota Position Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Entity Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `refinery_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Refinery Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `refined_product_id` SET TAGS ('dbx_business_glossary_term' = 'Refined Product Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ALTER COLUMN `origin_field_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Field Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `performance_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Performance ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `actual_delivered_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivered Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `actual_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `benchmark_price` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `hedging_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Hedging Cost Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `hedging_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `marketing_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Margin Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `marketing_margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `marketing_margin_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Marketing Margin Per Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `marketing_margin_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|closed|adjusted');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `planned_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `planned_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Volume Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `price_differential` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'per_bbl|per_boe|per_mcf|per_mmbtu|per_mt|per_gal');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `quality_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `realized_price` SET TAGS ('dbx_business_glossary_term' = 'Realized Price');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|spot');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `revenue_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Variance Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|disputed');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `trader_name` SET TAGS ('dbx_business_glossary_term' = 'Trader Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `transportation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `variance_commentary` SET TAGS ('dbx_business_glossary_term' = 'Variance Commentary');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ALTER COLUMN `volume_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance Quantity');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `commodity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Exposure Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `hedging_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Instrument Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `spot_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Trade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `trading_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Position Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `benchmark_price_reference` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price Reference');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `benchmark_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `counterparty_concentration_flag` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Concentration Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `credit_valuation_adjustment_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `delta_equivalent_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Delta-Equivalent Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `exposure_number` SET TAGS ('dbx_business_glossary_term' = 'Exposure Reference Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `exposure_number` SET TAGS ('dbx_value_regex' = '^EXP-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_value_regex' = 'active|closed|expired|rolled|cancelled');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `gross_long_exposure_boe` SET TAGS ('dbx_business_glossary_term' = 'Gross Long Exposure in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `gross_short_exposure_boe` SET TAGS ('dbx_business_glossary_term' = 'Gross Short Exposure in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|economic_hedge|not_designated');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `hedge_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `mark_to_market_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market Value in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `net_exposure_boe` SET TAGS ('dbx_business_glossary_term' = 'Net Exposure in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exposure Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `notional_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Notional Value in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `opec_quota_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Organization of the Petroleum Exporting Countries (OPEC) Quota Impact Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `price_differential_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Differential in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `risk_limit_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Utilization Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `stress_test_result_usd` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Result in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `stress_test_scenario` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Scenario Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `tenor_bucket` SET TAGS ('dbx_business_glossary_term' = 'Tenor Bucket');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `value_at_risk_usd` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level Percentage');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Time Horizon in Days');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` SET TAGS ('dbx_subdomain' = 'counterparty_credit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Counterparty Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `aml_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `aml_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|under_review|blocked');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `approved_commodity_list` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity List');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `approved_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `approved_credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `available_credit` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Headroom');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `available_credit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `commercial_counterparty_status` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `commercial_counterparty_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|blocked');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_limit_type` SET TAGS ('dbx_value_regex' = 'unsecured|letter_of_credit|parent_guarantee|cash_collateral');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_value_regex' = 'Moodys|SP|Fitch|internal|not_rated');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Frequency');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_utilization` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Amount');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `credit_utilization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Entity Type');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'IOC|NOC|independent_trader|refiner|utility|industrial_buyer');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `isda_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Agreement Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `isda_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Agreement Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `isda_agreement_status` SET TAGS ('dbx_value_regex' = 'executed|pending|not_required|expired');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `kyc_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|rejected');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `last_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `next_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Onboarding Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Payment Terms Days');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Risk Tier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|blocked');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Short Name');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ALTER COLUMN `venture_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` SET TAGS ('dbx_subdomain' = 'counterparty_credit');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit ID');
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
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
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` SET TAGS ('dbx_association_edges' = 'customer.customer_counterparty,commercial.price_index');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `commercial_price_index_preference_id` SET TAGS ('dbx_business_glossary_term' = 'commercial_price_index_preference Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Preference - Customer Counterparty Id');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Preference - Price Index Id');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `price_index_preference_price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Preference Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `applicable_product_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Types');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `ceiling_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Ceiling');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `differential_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Differential');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective From Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Until Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `floor_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Price Floor');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `negotiated_by` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `negotiated_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `preference_rank` SET TAGS ('dbx_business_glossary_term' = 'Preference Rank');
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` SET TAGS ('dbx_subdomain' = 'pricing_risk');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` SET TAGS ('dbx_association_edges' = 'commercial.term_contract,commercial.pricing_agreement');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `contract_pricing_term_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing Term Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing Term - Term Contract Id');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing Term - Pricing Agreement Id');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `amendment_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Reference');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Term Effective Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Term Expiration Date');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `priority_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pricing Term Priority Sequence');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade Specification');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `term_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Term Status');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `volume_tier_maximum` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Maximum Threshold');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `volume_tier_minimum` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Minimum Threshold');
ALTER TABLE `oil_gas_ecm`.`commercial`.`contract_pricing_term` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ALTER COLUMN `parent_portfolio_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `parent_opportunity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `discount_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `estimated_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `expected_margin_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `expected_margin_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `tariff_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Agreement Identifier');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `parent_tariff_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `contract_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `escalation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `escalation_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`commercial`.`tariff_agreement` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_pii_financial' = 'true');
