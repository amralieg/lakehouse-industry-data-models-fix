-- Schema for Domain: sales | Business: Agriculture | Version: v1_mvm
-- Generated on: 2026-05-01 18:45:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `agriculture_ecm`.`sales` COMMENT 'Manages the commercial revenue cycle from farm-gate to customer delivery — encompassing sales orders (SO), quotes, contracts, pricing strategies (spot, forward, futures-linked), FOB/CIF terms, BOL generation, COOL compliance, and revenue opportunities. Tracks sales pipeline, customer negotiations, seasonal demand forecasting, distribution channel performance, and partner/broker relationships. Integrates with SAP S/4HANA SD module and Salesforce CRM for opportunity management and market pricing signals from DTN/WASDE feeds.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Primary key for opportunity',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Sales pipeline management requires every opportunity to be tied to a customer account for account-level revenue forecasting, CRM pipeline reporting, and quota tracking. Agriculture sales orgs track op',
    `broker_id` BIGINT COMMENT 'Reference to the external agricultural commodity broker or trading partner facilitating this opportunity, if applicable. Relevant for grain, livestock, and commodity brokerage arrangements.',
    `commodity_id` BIGINT COMMENT 'Reference to the agricultural commodity (e.g., corn, soybeans, wheat, cattle) that is the subject of this sales opportunity.',
    `contact_id` BIGINT COMMENT 'Reference to the primary buyer or decision-maker contact at the customer account who is the key stakeholder for this opportunity.',
    `delivery_location_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_location. Business justification: Opportunity qualification in agriculture requires a specific delivery point to assess logistics feasibility, freight cost, and incoterms. The existing plain-text delivery_location column is denormal',
    `distribution_channel_id` BIGINT COMMENT 'Foreign key linking to sales.distribution_channel. Business justification: The opportunity table has a `distribution_channel` STRING column that is a denormalized reference to the distribution_channel master table. In agricultural sales, opportunities are pursued through spe',
    `employee_id` BIGINT COMMENT 'Reference to the internal sales representative or account manager responsible for managing and progressing this opportunity through the pipeline.',
    `farm_unit_id` BIGINT COMMENT 'Foreign key linking to land.farm_unit. Business justification: Farm-level sales pipeline tracking: ag sales reps manage opportunities against specific farm units to forecast production volumes and plan input/grain contracts. A domain expert expects opportunities ',
    `gmo_declaration_id` BIGINT COMMENT 'Foreign key linking to product.gmo_declaration. Business justification: Sales opportunities for non-GMO commodities (food manufacturers, EU export) require reference to the specific GMO declaration — BE Act and export market qualification. The existing gmo_flag boolean is',
    `growing_season_id` BIGINT COMMENT 'Foreign key linking to crop.growing_season. Business justification: Commodity sales opportunities are scoped to a specific crop year and growing season (e.g., selling 2024 corn harvest). Sales pipeline reporting, seasonal volume forecasting, and pre-harvest forward ',
    `master_id` BIGINT COMMENT 'Foreign key linking to product.product_master. Business justification: Seed, input, and processed goods sales opportunities are tracked at SKU level in agriculture CRM. Sales reps manage pipeline for specific product SKUs. Existing commodity_id FK is insufficient for bra',
    `organic_certification_id` BIGINT COMMENT 'Foreign key linking to product.organic_certification. Business justification: Sales opportunities for organic commodities reference the specific NOP certification — buyers require certification identity to validate organic premium pricing and supply eligibility. The existing or',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: Sales opportunities in agricultural commodity trading are managed within a specific sales organization (SAP SD sales org). The existing `sales_division` STRING column is a denormalized representation ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Agriculture sales pipeline reporting requires opportunities attributed to profit centers for segment-level revenue forecasting and P&L ownership. Sales managers and finance teams jointly track pipelin',
    `quality_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_certification. Business justification: Sales opportunities targeting certified markets (organic, GlobalG.A.P.) are qualified based on held certifications. CRM pipeline management requires linking opportunity to the certification that quali',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Sales opportunities are managed within defined sales territories for pipeline tracking and quota management. opportunity carries sales_territory (STRING) but no FK to the territory master. Adding sale',
    `seed_variety_id` BIGINT COMMENT 'Foreign key linking to product.seed_variety. Business justification: Seed sales pipeline management tracks opportunities by specific variety. Sales reps forecast demand and manage competitive positioning at variety level. Variety-level opportunity tracking drives produ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Agriculture sales pipeline reporting segments opportunities by customer tier (organic processor, commodity trader, export buyer) to drive targeted pricing strategies and campaign eligibility. Segment-',
    `actual_close_date` DATE COMMENT 'Date on which the opportunity was actually closed, either as won (converted to SO) or lost. Populated upon final disposition of the opportunity.',
    `close_probability_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0.00–100.00%) that this opportunity will be successfully closed and converted to a sales order (SO). Used for weighted pipeline revenue forecasting.',
    `competitor_name` STRING COMMENT 'Name of the primary competing supplier or trader identified in this opportunity. Supports competitive intelligence tracking and win/loss analysis.',
    `converted_so_number` STRING COMMENT 'SAP S/4HANA Sales Order (SO) number generated upon successful conversion of this opportunity to a confirmed order. Provides traceability from pipeline to order execution.',
    `cool_country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country of origin of the commodity, required for Country of Origin Labeling (COOL) compliance under USDA Agricultural Marketing Act regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was first created in the system. Supports audit trail, data lineage, and pipeline age analysis.',
    `crm_opportunity_code` STRING COMMENT 'External opportunity identifier sourced from Salesforce CRM, used to cross-reference and reconcile pipeline records between the lakehouse and the CRM system of record.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this opportunity (e.g., USD, EUR, CAD). Supports multi-currency international agricultural trade.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'International commercial terms (Incoterms) governing the delivery obligations, risk transfer, and cost responsibilities between buyer and seller for this opportunity. FOB (Free On Board) and CIF (Cost Insurance and Freight) are most common in agricultural commodity trade.. Valid values are `FOB|CIF|EXW|DAP|DDP|FCA`',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'Projected gross revenue for this opportunity, calculated as estimated volume multiplied by target price. Used for weighted pipeline revenue reporting and seasonal financial forecasting. Expressed in transaction currency.',
    `estimated_volume` DECIMAL(18,2) COMMENT 'Estimated quantity of the commodity to be sold under this opportunity, expressed in the volume unit of measure (e.g., bushels, metric tons, hundredweight). Core input for revenue forecasting and supply planning.',
    `expected_close_date` DATE COMMENT 'Anticipated date by which the opportunity is expected to be closed (won or lost). Used for seasonal demand forecasting and pipeline milestone tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was most recently updated. Supports change tracking, data freshness monitoring, and incremental lakehouse processing.',
    `lead_source` STRING COMMENT 'Origin channel through which this opportunity was identified or generated. Supports marketing ROI analysis and pipeline source attribution. DTN signal indicates market-data-driven lead generation. [ENUM-REF-CANDIDATE: inbound|referral|trade_show|broker|cold_outreach|existing_account|dtn_signal — 7 candidates stripped; promote to reference product]',
    `loss_reason` STRING COMMENT 'Reason code explaining why a closed-lost opportunity was not won. Populated only when pipeline_stage = closed_lost. Drives win/loss analysis and commercial strategy improvement. [ENUM-REF-CANDIDATE: price|competitor|volume|timing|quality|relationship|no_decision — 7 candidates stripped; promote to reference product]',
    `next_action` STRING COMMENT 'Description of the next planned commercial action or follow-up step required to advance this opportunity (e.g., Send price proposal, Schedule farm visit, Submit COA). Supports sales rep activity management.',
    `next_action_date` DATE COMMENT 'Scheduled date for the next planned commercial action on this opportunity. Used for sales rep task management and pipeline velocity tracking.',
    `notes` STRING COMMENT 'Free-text field for capturing additional commercial context, negotiation notes, customer requirements, or competitive intelligence relevant to this opportunity.',
    `open_date` DATE COMMENT 'Date on which the sales opportunity was formally opened and entered into the pipeline. Marks the start of the commercial engagement lifecycle.',
    `opportunity_name` STRING COMMENT 'Human-readable descriptive name or title of the sales opportunity, typically including the customer name, commodity, and season (e.g., Acme Foods – Corn Q3 2025 Forward Contract).',
    `pipeline_stage` STRING COMMENT 'Current stage of the sales opportunity within the commercial pipeline lifecycle, from initial prospecting through to close. Drives pipeline reporting and revenue forecasting. [ENUM-REF-CANDIDATE: prospecting|qualification|needs_analysis|proposal|negotiation|closed_won|closed_lost — promote to reference product]',
    `price_uom` STRING COMMENT 'Unit of measure against which the target price is quoted. Common agricultural units include BU (Bushel), MT (Metric Ton), CWT (Hundredweight), LB (Pound), KG (Kilogram), TON (Short Ton).. Valid values are `BU|MT|CWT|LB|KG|TON`',
    `pricing_strategy` STRING COMMENT 'The pricing mechanism applied to this opportunity. Spot pricing reflects current market rates; forward pricing locks in a future delivery price; futures-linked pricing ties to exchange-traded commodity futures (e.g., CBOT); basis pricing reflects the differential to a futures benchmark; contract pricing is pre-agreed; negotiated is bespoke. Integrates with DTN/WASDE market data feeds.. Valid values are `spot|forward|futures_linked|basis|contract|negotiated`',
    `quality_grade` STRING COMMENT 'USDA or industry-standard quality grade of the commodity offered in this opportunity (e.g., US No. 1, US No. 2, Choice, Prime). Directly impacts pricing and customer acceptance criteria.',
    `requested_delivery_date` DATE COMMENT 'Customers requested date for commodity delivery. Drives harvest scheduling, logistics planning, and supply chain coordination from farm gate to customer.',
    `target_price` DECIMAL(18,2) COMMENT 'The desired or negotiated unit price for the commodity in this opportunity, expressed in the transaction currency per unit of measure (e.g., USD per bushel, USD per metric ton). Sensitive commercial pricing data.',
    `volume_uom` STRING COMMENT 'Unit of measure for the estimated and committed volumes in this opportunity. Common agricultural units: BU (Bushel), MT (Metric Ton), CWT (Hundredweight), LB (Pound), KG (Kilogram), TON (Short Ton).. Valid values are `BU|MT|CWT|LB|KG|TON`',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Sales opportunity record tracking the full pipeline from lead qualification through close — capturing commodity type, estimated volume (BU/MT/CWT), target price, pricing strategy (spot, forward, futures-linked), probability of close, expected close date, assigned broker/sales rep, pipeline stage, and competitive intelligence. SSOT for revenue opportunity management in the agricultural commercial cycle. Integrates with Salesforce CRM for pipeline visibility and SAP S/4HANA SD for order conversion.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique system-generated identifier for the agricultural commodity price quotation record in the Silver Layer lakehouse.',
    `account_id` BIGINT COMMENT 'Reference to the customer or broker entity to whom this price quotation is issued. Links to the customer master in Salesforce CRM and SAP S/4HANA SD.',
    `broker_id` BIGINT COMMENT 'Reference to the agricultural broker or trading partner intermediary involved in this quotation, if applicable. Supports broker commission tracking and partner relationship management in Salesforce CRM.',
    `certification_record_id` BIGINT COMMENT 'Foreign key linking to customer.certification_record. Business justification: Quoting organic, GlobalG.A.P., or FSMA-regulated commodities requires verification of the buyers active certification record to justify quality premiums and confirm trade eligibility. Agriculture pri',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: A sales quote in agriculture is fundamentally tied to a specific commodity (corn, soybeans, wheat). The existing commodity_code is a denormalized field; a proper FK to commodity enables pricing, gradi',
    `price_basis_id` BIGINT COMMENT 'Foreign key linking to invoice.price_basis. Business justification: A commodity quote in agriculture is built on a specific price basis (futures month, delivery point, basis adjustment). Linking quote to the canonical price_basis record ensures pricing consistency fro',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Quote delivery and negotiation: ag commodity quotes are sent to a specific buyer/procurement contact for approval and signature. Enables quote-to-contact audit trail and targeted follow-up communicati',
    `delivery_location_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_location. Business justification: Quote pricing is location-specific: freight allowances, incoterms, and COOL compliance requirements vary by delivery location. Ag commodity quotes must reference the ship-to facility to compute accura',
    `employee_id` BIGINT COMMENT 'Reference to the internal sales representative or account manager responsible for preparing and managing this quotation. Links to the workforce/employee master in SAP SuccessFactors.',
    `gmo_declaration_id` BIGINT COMMENT 'Foreign key linking to product.gmo_declaration. Business justification: Quotes for non-GMO or GMO commodities must reference the specific GMO declaration — BE Act disclosure requirement and export market compliance (EU, Japan). The existing gmo_status string is denormaliz',
    `grading_standard_id` BIGINT COMMENT 'Foreign key linking to product.grading_standard. Business justification: Agricultural commodity quotes specify grade requirements that determine price. Quotes are issued before contracts and independently reference grading standards for accurate price calculation. Formaliz',
    `master_id` BIGINT COMMENT 'Foreign key linking to product.product_master. Business justification: Seed and input product quoting requires referencing specific SKUs in product_master. Seed dealers quote specific variety/formulation SKUs, not just commodities. Supports accurate pricing, availability',
    `mrl_threshold_id` BIGINT COMMENT 'Foreign key linking to product.mrl_threshold. Business justification: Quotes for export commodities must reference the applicable MRL threshold for the destination market — food safety regulatory compliance. Ag sales teams quote against specific MRL limits (EU, Japan, U',
    `opportunity_id` BIGINT COMMENT 'Reference to the Salesforce CRM sales opportunity that originated this quotation, enabling pipeline tracking and win/loss analysis.',
    `organic_certification_id` BIGINT COMMENT 'Foreign key linking to product.organic_certification. Business justification: Quotes for organic commodities must reference the specific NOP certification — buyers require certificate number and certifying agent for USDA NOP chain-of-custody compliance. The existing organic_cer',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: The quote table has `sales_org_code` typed as BIGINT, which is clearly intended as a foreign key reference to the sales_organization master table (aligned with SAP SD quotation structure). The column ',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: quote has payment_terms_code as a plain denormalized text field. A proper FK to invoice.payment_term enforces standardized payment terms on quotes, supports quote-to-order payment term inheritance, an',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Commodity quotes in agriculture are attributed to profit centers for margin analysis and revenue recognition planning. Finance teams run quote-conversion-to-revenue reports by profit center to assess ',
    `quality_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_certification. Business justification: Quotes for certified commodities (organic, GlobalG.A.P.) must reference the applicable certification to substantiate the certified status and premium pricing claimed. Buyers in certified markets requi',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Formal price quotations in agricultural commodity sales are based on negotiated price agreements. quote carries unit_price and pricing_basis but no FK to the governing price agreement. Adding sales_pr',
    `seed_variety_id` BIGINT COMMENT 'Foreign key linking to product.seed_variety. Business justification: Seed dealers quote specific varieties (e.g., Pioneer P1197AM) with trait packages and yield ratings. Seed variety quoting is a major ag sales process — the variety identity drives pricing, availabilit',
    `commodity_grade` STRING COMMENT 'The USDA or industry-standard grade or class designation of the quoted commodity (e.g., US No. 2 Yellow Corn, Hard Red Winter Wheat Grade 1). Directly impacts pricing and MRL/PHI compliance requirements.',
    `cool_origin_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code designating the country of origin of the quoted commodity, as required by USDA Country of Origin Labeling (COOL) regulations. Mandatory for covered commodities sold in the US market.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the quotation record was first created in the Silver Layer lakehouse. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this quotation (e.g., USD, EUR, BRL). Enables multi-currency agricultural commodity trading across international markets.. Valid values are `^[A-Z]{3}$`',
    `delivery_end_date` DATE COMMENT 'The latest date by which the quoted commodity must be delivered. Together with delivery_start_date, defines the delivery window. Critical for seasonal harvest scheduling and logistics planning.',
    `delivery_start_date` DATE COMMENT 'The earliest date on which the quoted commodity can be delivered to the buyer under the agreed Incoterms. Defines the start of the delivery window for forward and contract pricing.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary discount applied to the quotation, reducing the gross quoted value. May reflect volume rebates, grade discounts, or negotiated commercial terms.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) defining the delivery obligations, risk transfer point, and cost allocation between seller and buyer. FOB (Free On Board) and CIF (Cost Insurance and Freight) are most common in agricultural commodity trading.. Valid values are `FOB|CIF|EXW|DAP|DDP|FCA`',
    `incoterms_location` STRING COMMENT 'The named port, terminal, or delivery location associated with the Incoterms code (e.g., FOB Gulf of Mexico Port, CIF Rotterdam). Required by INCOTERMS 2020 to complete the delivery term specification.',
    `mrl_compliant` BOOLEAN COMMENT 'Indicates whether the quoted commodity meets the Maximum Residue Limit (MRL) requirements for pesticide residues applicable to the destination market. True = compliant; False = non-compliant or not verified. Required for export quotations and food safety compliance.',
    `multi_commodity_flag` BOOLEAN COMMENT 'Indicates whether this quotation covers multiple commodity types or grades across its line items. True = multi-commodity quote (common in grain trading); False = single commodity. Drives downstream processing logic for line item aggregation.',
    `net_price` DECIMAL(18,2) COMMENT 'The final quoted price per unit after applying all discounts, premiums, and basis adjustments. This is the price the customer will pay per unit of measure if the quote is accepted.',
    `notes` STRING COMMENT 'Free-text field for additional commercial terms, special conditions, quality specifications, or negotiation remarks associated with this quotation. Sourced from SAP S/4HANA SD quotation header text or Salesforce CRM opportunity notes.',
    `phi_days` STRING COMMENT 'The minimum number of days required between the last pesticide application and harvest, as mandated by EPA label requirements (Pre-Harvest Interval). Ensures MRL compliance and food safety for the quoted commodity lot.',
    `quote_date` DATE COMMENT 'The business date on which the formal price quotation was issued to the customer or broker. Represents the principal real-world event date for this transaction.',
    `quote_number` STRING COMMENT 'Externally-visible, human-readable quotation reference number used in customer communications, SAP S/4HANA SD quotation documents, and Salesforce CRM. Format: QT-YYYY-NNNNNN.. Valid values are `^QT-[0-9]{4}-[0-9]{6}$`',
    `quote_status` STRING COMMENT 'Current lifecycle state of the quotation. Drives workflow in SAP S/4HANA SD and Salesforce CRM: draft (being prepared), submitted (sent to customer), accepted (customer confirmed), rejected (customer declined), expired (validity lapsed), cancelled (withdrawn by seller).. Valid values are `draft|submitted|accepted|rejected|expired|cancelled`',
    `quote_type` STRING COMMENT 'Classification of the quotation by pricing basis: spot (current market price), forward (agreed future delivery price), futures_linked (price tied to exchange futures contract via DTN/WASDE), contract (against a standing supply agreement), indicative (non-binding price indication). [ENUM-REF-CANDIDATE: spot|forward|futures_linked|contract|indicative — promote to reference product]. Valid values are `spot|forward|futures_linked|contract|indicative`',
    `salesforce_opportunity_ref` STRING COMMENT 'The Salesforce CRM Opportunity ID or reference number linked to this quotation, enabling cross-system traceability between the SAP S/4HANA SD quotation and the CRM sales pipeline record.',
    `sap_quotation_ref` STRING COMMENT 'The SAP S/4HANA Sales and Distribution (SD) module quotation document number, providing the authoritative source system reference for this record in the Silver Layer.',
    `total_quantity` DECIMAL(18,2) COMMENT 'The total volume of commodity or product quoted across all line items, expressed in the unit of measure (uom_code). For multi-commodity quotes, this represents the aggregate volume.',
    `total_quoted_value` DECIMAL(18,2) COMMENT 'The total monetary value of the quotation (net_price × total_quantity), expressed in the quote currency. Represents the gross revenue opportunity if the quote is fully accepted.',
    `unit_price` DECIMAL(18,2) COMMENT 'The quoted price per unit of measure (e.g., per bushel, per metric ton, per hundredweight) for the commodity or product. Represents the gross base price before any adjustments or discounts.',
    `uom_code` STRING COMMENT 'Standard unit of measure for quantity fields in this quotation. BU (Bushel), MT (Metric Ton), CWT (Hundredweight), LB (Pound), KG (Kilogram), TON (Short Ton). Aligned with USDA and commodity exchange standards.. Valid values are `BU|MT|CWT|LB|KG|TON`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the quotation record. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `valid_from_date` DATE COMMENT 'The date from which the quoted price and terms become effective and binding. Marks the start of the quotation validity window.',
    `valid_to_date` DATE COMMENT 'The date on which the quotation expires and the quoted price is no longer binding. After this date, quote_status transitions to expired. Critical for seasonal commodity pricing windows.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Formal price quotation issued to a customer or broker for agricultural commodities or products — capturing quoted price per unit (FOB/CIF basis), commodity grade, total volume, validity period, pricing basis (spot vs. forward vs. futures-linked DTN/WASDE), incoterms, and quote status. Contains individual line items each specifying commodity code, grade/class, quantity (BU/MT/CWT), unit price, pricing basis, applicable MRL/PHI compliance flags, GMO status, and COOL origin designation. Supports multi-commodity quotes common in agricultural trading where a single quotation covers multiple grain types or product grades. Linked to SAP S/4HANA SD quotation and Salesforce CRM opportunity.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`order` (
    `order_id` BIGINT COMMENT 'Primary key for order',
    `account_id` BIGINT COMMENT 'Reference to the customer (buyer) who placed this sales order. Links to the customer master data product for account details, credit terms, and COOL (Country of Origin Labeling) compliance information.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to invoice.billing_account. Business justification: Sales orders in agriculture are billed to specific billing accounts. Direct FK supports order-level credit checking at order entry, billing account routing for invoice generation, and AR aging by orde',
    `broker_id` BIGINT COMMENT 'Reference to the external broker or agent who facilitated this order, if applicable. Nullable for direct sales. Used for broker commission tracking, partner performance analytics, and regulatory disclosure in commodity trading.',
    `certification_record_id` BIGINT COMMENT 'Foreign key linking to customer.certification_record. Business justification: Sales orders for organic, non-GMO, or GlobalG.A.P. commodities must reference the buyers active certification record for FSMA chain-of-custody compliance and organic integrity verification. Agricultu',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Sales orders in grain/commodity trading are placed at the commodity level for pricing, futures hedging, and USDA reporting. The existing commodity_code is denormalized; a proper FK enables commodity-l',
    `price_basis_id` BIGINT COMMENT 'Foreign key linking to invoice.price_basis. Business justification: A sales orders price is governed by a price basis record (futures contract month, delivery location basis). This FK enables order-to-invoice price reconciliation and supports basis-price fixation wor',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales orders must be assigned to a legal entity (company code) for revenue recognition, statutory reporting, and intercompany billing. Agriculture companies operate multiple legal entities; every orde',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order confirmation and FSMA traceability: purchase orders in agriculture are placed by a specific buyer contact. Customer service communications, shipment notifications, and FSMA traceability alerts a',
    `contract_id` BIGINT COMMENT 'Reference to the governing sales contract or forward agreement under which this order is placed. Nullable for spot market orders. Links to the contract master product for pricing terms, volume commitments, and delivery schedules.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales orders are assigned to cost centers for contribution margin and profitability analysis by business unit or commodity desk. This is standard management accounting in agricultural trading — requir',
    `delivery_location_id` BIGINT COMMENT 'Reference to the physical delivery destination for this order (e.g., customer grain elevator, processing plant, port terminal). Used for logistics routing in TMS, BOL generation, and COOL (Country of Origin Labeling) compliance tracking.',
    `distribution_channel_id` BIGINT COMMENT 'FK to sales.distribution_channel',
    `employee_id` BIGINT COMMENT 'Reference to the internal sales representative or account manager responsible for this order. Used for sales performance reporting, commission calculation, and Salesforce CRM pipeline attribution.',
    `farm_unit_id` BIGINT COMMENT 'Foreign key linking to land.farm_unit. Business justification: Grain origination tracking: sales orders for harvested commodities must reference the sourcing farm unit for supply chain traceability, farm-level fulfillment reporting, and FSMA lot documentation. Ag',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: In agriculture (especially fresh produce), the harvest/packing crew assigned to fulfill a sales order is tracked for FSMA food safety traceability — linking a foodborne illness event back to the speci',
    `gmo_declaration_id` BIGINT COMMENT 'Foreign key linking to product.gmo_declaration. Business justification: Sales orders for export must reference the GMO declaration for BE Act compliance and phytosanitary certificates. The existing gmo_status string is denormalized; the FK links the order to the verified ',
    `grading_standard_id` BIGINT COMMENT 'Foreign key linking to product.grading_standard. Business justification: Commodity sales orders specify a grading standard (USDA Grade 2 Yellow Corn) that governs acceptance criteria, price adjustments, and delivery terms. This is a core ag operations process — the grading',
    `organic_certification_id` BIGINT COMMENT 'Foreign key linking to product.organic_certification. Business justification: USDA NOP requires organic chain-of-custody documentation on sales orders — the specific certification must be referenced for organic premium billing and audit trails. The existing organic_certified bo',
    `organization_id` BIGINT COMMENT 'SAP sales organization code representing the legal entity or business unit responsible for this sales transaction. Determines the applicable pricing procedures, revenue accounts, and regulatory reporting jurisdiction.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: order has payment_terms_code as a plain denormalized text field. A proper FK to invoice.payment_term enforces standardized payment terms at order level, drives invoice due date calculation, and suppor',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales orders in agriculture require profit center assignment for SAP SD-CO integration, revenue recognition, and P&L reporting by business segment. Standard SAP agriculture implementation mandates pro',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Back-to-back commodity trading: a sales order triggers a corresponding purchase order from the grower/supplier. This link enables trade-level P&L, supply coverage reporting, and FSMA lot traceability ',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Sales orders in agricultural commodity trading are routinely created from accepted quotes. Adding order.quote_id → sales.quote.quote_id enables quote-to-order conversion tracking and supports revenue ',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Sales orders in agricultural commodity trading are priced under customer-specific or channel-specific price agreements. order carries price_per_unit and pricing_basis but no FK to the governing price ',
    `opportunity_id` BIGINT COMMENT 'Cross-reference identifier linking this confirmed sales order back to the originating Salesforce CRM opportunity record. Enables pipeline-to-revenue traceability and sales performance analytics.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Sales orders in agricultural commodity trading are associated with a sales territory for commission calculation, performance reporting, and territory-level revenue tracking. The order table currently ',
    `bol_number` STRING COMMENT 'Bill of Lading number issued for the shipment associated with this sales order. Serves as the legal document of title for the goods in transit. Required for FSMA traceability, COOL compliance, and customs documentation for export orders.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the seller after availability check (ATP — Available to Promise) in SAP S/4HANA. May differ from the requested delivery date. Used for customer commitment management and logistics execution.',
    `cool_country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country of origin of the agricultural commodity per USDA COOL regulations (7 U.S.C. § 1638). Mandatory for covered commodities (beef, pork, lamb, chicken, fish, perishable agricultural commodities, peanuts, pecans, ginseng, macadamia nuts). Required on customer invoices and shipping documents.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales order record was first created in the source system (SAP S/4HANA SD). Captured in ISO 8601 format with timezone offset. Used for audit trail, data lineage, and SLA measurement from order creation to fulfillment.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the order transaction (e.g., USD, EUR, CAD). All monetary amounts on this order are denominated in this currency. Required for multi-currency reporting and foreign exchange (FX) revaluation in SAP FI.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary discount applied to the order, including volume rebates, seasonal promotions, and negotiated trade discounts. Denominated in the transaction currency. Used for margin analysis and trade spend reporting.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight and transportation charges billed to the customer as part of this order, consistent with the agreed Incoterms. Denominated in the transaction currency. Relevant for CIF orders where freight is included in the sellers price.',
    `fsma_traceability_lot` STRING COMMENT 'Lot number (LOT) or batch tracking identifier assigned to the commodity in this order for FSMA Food Traceability Rule compliance. Enables farm-to-fork traceability for covered foods listed on the Food Traceability List (FTL). Required for FDA recall readiness and HACCP documentation.',
    `futures_contract_reference` STRING COMMENT 'Exchange-traded futures contract identifier used as the pricing benchmark for futures-linked or basis-priced orders (e.g., CBOT-ZC-DEC24 for December 2024 CBOT Corn futures). Nullable for fixed-price and index-priced orders. Supports commodity risk management and hedge accounting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross value of the sales order before application of discounts, freight charges, and taxes. Calculated as the sum of all line item gross values. Denominated in the transaction currency. Used for revenue pipeline reporting and EBITDA forecasting.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the transfer of risk, cost, and responsibility between seller and buyer. FOB (Free On Board) and CIF (Cost Insurance and Freight) are most common in agricultural commodity trade. Determines freight cost allocation and insurance obligations. [ENUM-REF-CANDIDATE: FOB|CIF|EXW|DAP|DDP|FCA|CFR|CPT|CIP|DAT — 10 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code (e.g., FOB Gulf Port, MS or CIF Rotterdam). Required by ICC Incoterms 2020 to complete the delivery term definition and determine the precise point of risk transfer.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net value of the sales order after deducting discounts and adding freight and tax charges. This is the total amount invoiced to the customer. Denominated in the transaction currency. Primary metric for revenue recognition under IFRS 15 / GAAP.',
    `order_date` DATE COMMENT 'The business date on which the sales order was officially placed and confirmed by the customer. This is the principal commercial event date used for revenue period attribution, seasonal demand analysis, and WASDE reporting alignment.',
    `order_status` STRING COMMENT 'Current lifecycle state of the sales order from creation through fulfillment and closure. Drives workflow routing in SAP S/4HANA SD, WMS pick/pack operations in Manhattan Associates, and revenue recognition milestones. [ENUM-REF-CANDIDATE: draft|open|confirmed|in_fulfillment|shipped|delivered|invoiced|closed|cancelled — promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the pricing and commitment mechanism for this order. Spot orders are priced at current market rates; contract orders reference a pre-negotiated agreement; forward orders lock in future delivery prices; futures-linked orders are priced against commodity exchange benchmarks (e.g., CBOT, CME). Drives pricing logic and revenue recognition treatment.. Valid values are `spot|contract|forward|futures_linked`',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Agreed unit price for the primary commodity in this order, denominated in the transaction currency per unit of measure (e.g., USD/MT, USD/BU). For futures-linked orders, this reflects the basis-adjusted exchange price. Core input for margin and COGS analysis.',
    `quality_grade` STRING COMMENT 'USDA or customer-specified quality grade of the commodity (e.g., US No. 1, US No. 2, Premium, Feed Grade). Determines pricing differentials, contract compliance, and eligibility for specific end-use markets. Sourced from COA (Certificate of Analysis) at point of origin.',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer has requested delivery of the ordered goods. Used for logistics scheduling, TMS route planning, and on-time delivery KPI measurement. May differ from the confirmed delivery date after supply chain feasibility checks.',
    `shipping_point_code` STRING COMMENT 'SAP shipping point code identifying the farm-gate, warehouse, or grain elevator from which the goods will be dispatched. Determines the outbound logistics route and BOL origin. Aligns with Manhattan Associates WMS facility codes.',
    `so_number` STRING COMMENT 'Externally-known, human-readable sales order number generated by SAP S/4HANA SD module (e.g., SO-0000123456). Used for customer-facing communication, BOL references, and cross-system reconciliation with Salesforce CRM and Oracle NetSuite.. Valid values are `^SO-[0-9]{10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the order, including applicable sales tax, VAT, or excise duties. Denominated in the transaction currency. Populated from SAP tax determination procedures and used for tax compliance reporting.',
    `total_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods ordered across all line items, expressed in the order unit of measure (e.g., 500 MT of corn, 10,000 BU of soybeans). Used for inventory reservation, harvest planning, and supply chain capacity management.',
    `unit_of_measure` STRING COMMENT 'The primary unit of measure for the total order quantity (e.g., MT — Metric Ton, BU — Bushel, CWT — Hundredweight). Aligns with commodity trading conventions and USDA reporting standards. Drives weight-based pricing and logistics planning. [ENUM-REF-CANDIDATE: MT|BU|CWT|LB|KG|TON|BBL — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sales order record in the source system. Used for incremental data pipeline processing, change data capture (CDC), and audit compliance under SOX.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Authoritative sales order (SO) record aligned with SAP S/4HANA SD module — capturing order number, customer, order date, requested delivery date, incoterms (FOB/CIF), payment terms, total order value, currency, order type (spot, contract, forward), delivery location, and order status lifecycle. SSOT for confirmed commercial sales transactions from farm-gate to customer delivery.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line item on a sales order within the agricultural commodity sales system. Primary key for the order_line entity.',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: In grain/produce commodity trade, each sales order line requires a Certificate of Analysis per lot. Buyers mandate COA attachment for release; this FK enables COA-to-order-line traceability for custom',
    `price_basis_id` BIGINT COMMENT 'Foreign key linking to invoice.price_basis. Business justification: Individual order lines in split-shipment or multi-origin grain contracts can carry distinct price bases (different delivery points, different futures months). Line-level price_basis FK is required for',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Order lines in agricultural commodity trading are assigned to cost centers for line-level contribution margin analysis by product grade, crop year, or commodity type. Required for detailed management ',
    `field_id` BIGINT COMMENT 'Foreign key linking to land.field. Business justification: FSMA Subpart S traceability requires linking order line lots to the originating field. Ag traceability experts expect order lines for fresh produce and grain to carry field-of-origin for food safety i',
    `gmo_declaration_id` BIGINT COMMENT 'Foreign key linking to product.gmo_declaration. Business justification: Lot-level GMO traceability at order line level is required for BE Act compliance and export documentation. Mixed orders may have GMO and non-GMO lines; each line must reference its specific declaratio',
    `growing_season_id` BIGINT COMMENT 'Foreign key linking to crop.growing_season. Business justification: Grain order traceability by season: order lines for grain always reference a specific crop year. The existing crop_year plain string is a denormalization. Linking enables traceability from sold grain ',
    `master_id` BIGINT COMMENT 'Reference to the agricultural product or commodity being sold on this line item (e.g., corn, soybeans, wheat, livestock feed). Links to the product master for commodity specifications, SKU, and pricing data.',
    `mrl_threshold_id` BIGINT COMMENT 'Foreign key linking to product.mrl_threshold. Business justification: FSMA Produce Safety Rule and food safety compliance require that each order line referencing mrl_compliant and phi_cleared be traceable to the specific MRL threshold verified. Enables regulatory audit',
    `organic_certification_id` BIGINT COMMENT 'Foreign key linking to product.organic_certification. Business justification: Mixed orders (organic and conventional lines) require line-level organic certification tracking for NOP chain-of-custody and organic premium billing. Each organic order line must reference the specifi',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Order lines in commodity sales carry profit center assignments for granular revenue and COGS allocation in SAP CO-PA profitability analysis. Agriculture finance requires line-level profit center to sp',
    `order_id` BIGINT COMMENT 'Reference to the parent sales order header to which this line item belongs. Establishes the header-to-line relationship for multi-commodity orders. Aligns with SAP S/4HANA SD VBAK (order header) to VBAP (order item) linkage.',
    `seed_variety_id` BIGINT COMMENT 'Foreign key linking to product.seed_variety. Business justification: Seed sales order lines must reference the specific variety sold for agronomic support, replant guarantees, variety performance tracking, and seed licensing compliance. Seed dealers and distributors tr',
    `yield_record_id` BIGINT COMMENT 'Foreign key linking to crop.yield_record. Business justification: FSMA lot traceability: each order line for grain must be traceable to the specific harvest lot (yield record) it was fulfilled from. The existing lot_number plain string is insufficient for full trace',
    `bol_number` STRING COMMENT 'Reference number for the Bill of Lading (BOL) document associated with the shipment of this sales order line. The BOL serves as the contract of carriage, receipt of goods, and document of title in agricultural commodity transport. Generated upon goods issue from warehouse or elevator.',
    `class_code` STRING COMMENT 'Commodity class or variety classification within the grade (e.g., Hard Red Winter, Soft Red Winter for wheat; Yellow Dent for corn; Roundup Ready for soybeans). Provides sub-grade differentiation for specialty or identity-preserved commodity sales.',
    `commodity_code` STRING COMMENT 'Standardized commodity classification code identifying the agricultural product type (e.g., USDA commodity code, HS tariff code, or internal commodity identifier). Used for regulatory reporting, COOL compliance, and market pricing alignment with DTN/WASDE feeds.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the seller after availability check and logistics scheduling. Represents the committed delivery commitment to the customer for this line item. Drives BOL scheduling and carrier booking.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity of the commodity confirmed for delivery by the seller after inventory allocation and availability check. May differ from ordered quantity due to stock availability, crop yield constraints, or partial fulfillment agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales order line record was first created in the system, in ISO 8601 format with timezone offset. Used for audit trail, data lineage, and SLA tracking. Sourced from SAP S/4HANA SD order entry timestamp.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary values on this line item (e.g., USD for US Dollar, EUR for Euro, BRL for Brazilian Real). Supports multi-currency international agricultural commodity trade.. Valid values are `^[A-Z]{3}$`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the commodity physically delivered or shipped against this sales order line, as recorded upon BOL generation or warehouse goods issue. Used for revenue recognition and invoice reconciliation.',
    `delivery_location_code` STRING COMMENT 'Code identifying the specific delivery point or destination for this line item (e.g., elevator code, port terminal code, warehouse location code). Used for logistics planning, BOL generation, and TMS routing. May reference a grain elevator, export terminal, or customer facility.',
    `delivery_terms` STRING COMMENT 'International commercial terms (Incoterms) governing the transfer of risk and cost responsibility for this commodity line item. FOB (Free On Board) and CIF (Cost Insurance Freight) are most common in agricultural commodity trade. Determines logistics cost allocation and revenue recognition point.. Valid values are `FOB|CIF|DAP|DDP|EXW|FCA`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary discount applied to this sales order line, including quality discounts (moisture, test weight, foreign material), volume discounts, and commercial negotiation discounts. Reduces the gross line value to arrive at the net line amount. Expressed in transaction currency.',
    `futures_contract_ref` STRING COMMENT 'Reference identifier for the commodity futures contract (e.g., CBOT corn December 2024 — ZCZ24) linked to this sales order line when pricing_basis is futures_linked or basis_contract. Enables hedge accounting reconciliation and mark-to-market valuation.',
    `grade_code` STRING COMMENT 'USDA or industry-standard grade designation for the commodity on this line (e.g., US No. 1, US No. 2, Sample Grade for grains; Choice, Select for livestock). Determines pricing differentials and buyer acceptance criteria. Sourced from Certificate of Analysis (COA) or grain inspection.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this sales order line record, in ISO 8601 format with timezone offset. Tracks changes to quantity, price, delivery dates, or status throughout the order lifecycle. Essential for change data capture (CDC) in the Databricks Silver layer.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of this sales order line calculated as confirmed quantity multiplied by unit price, before taxes and after applicable discounts. Used for revenue recognition, invoice generation, and financial reporting under IFRS 15 / GAAP.',
    `line_number` STRING COMMENT 'Sequential position of this line item within the parent sales order, used for ordering and referencing individual items (e.g., line 10, 20, 30 per SAP SD item numbering convention). Enables multi-commodity order management.',
    `line_status` STRING COMMENT 'Current processing status of this individual sales order line item within the order fulfillment lifecycle. Tracks progression from open through delivery and invoicing. Aligns with SAP SD overall delivery status at item level.. Valid values are `open|confirmed|partially_delivered|delivered|invoiced|cancelled`',
    `lot_number` STRING COMMENT 'Batch or lot identifier assigned to the specific quantity of commodity on this sales order line, enabling end-to-end traceability from field/farm through delivery. Critical for FSMA traceability requirements, recall management, and HACCP compliance. Aligns with SAP batch management (CHARG).',
    `moisture_pct` DECIMAL(18,2) COMMENT 'Moisture content of the commodity expressed as a percentage of total weight at time of sale or delivery. A critical quality parameter for grain pricing — moisture above standard (e.g., 15.5% for corn) results in drying charges or price discounts. Sourced from grain inspection or COA.',
    `mrl_compliant` BOOLEAN COMMENT 'Indicates whether the commodity on this line has been verified to meet Maximum Residue Limit (MRL) requirements for pesticide and chemical residues as mandated by the destination market (EPA, EU, Codex Alimentarius). True = MRL compliance confirmed; False = non-compliant or pending verification. Blocks shipment if False.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of the commodity originally requested by the customer on this sales order line, expressed in the line unit of measure (BU, MT, CWT, etc.). Represents the buyers demand commitment before confirmation or allocation.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country where the agricultural commodity was produced or harvested. Required for Country of Origin Labeling (COOL) compliance under USDA AMS regulations and international trade documentation. Supports export certificate and phytosanitary documentation.. Valid values are `^[A-Z]{3}$`',
    `phi_cleared` BOOLEAN COMMENT 'Indicates whether the mandatory Pre-Harvest Interval (PHI) — the minimum number of days between last pesticide/chemical application and harvest — has been satisfied for the commodity on this line. True = PHI interval elapsed and cleared; False = PHI not yet met. Required for food safety compliance and MRL verification.',
    `quantity_uom` STRING COMMENT 'Unit of measure in which ordered, confirmed, and delivered quantities are expressed for this line item. Agricultural commodities use industry-standard units: BU (Bushel), MT (Metric Ton), CWT (Hundredweight), LB (Pound), KG (Kilogram), TON (Short Ton), BAG. Aligns with USDA and international trade conventions. [ENUM-REF-CANDIDATE: BU|MT|CWT|LB|KG|TON|BAG — 7 candidates stripped; promote to reference product]',
    `rejection_reason_code` STRING COMMENT 'Code indicating the reason this sales order line was cancelled or rejected (e.g., customer cancellation, out of stock, quality failure, pricing dispute, regulatory hold). Populated only when line_status is cancelled. Used for sales analytics and demand planning. [ENUM-REF-CANDIDATE: customer_cancel|out_of_stock|quality_failure|pricing_dispute|regulatory_hold|force_majeure|duplicate — promote to reference product]',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer requests delivery of the commodity on this line item. Used for production scheduling, harvest planning, and logistics coordination. May differ from confirmed delivery date based on availability and transportation capacity.',
    `test_weight` DECIMAL(18,2) COMMENT 'Weight per bushel (lb/bu) or per hectoliter (kg/hL) of the commodity, indicating grain density and quality. Test weight below minimum standard (e.g., 56 lb/bu for corn) results in grade discounts. A primary quality determinant in grain trading and pricing.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of measure for this commodity line item, expressed in the transaction currency. Reflects the negotiated or market-based price at time of order. May be spot, forward, or futures-linked depending on pricing_basis. Commercially sensitive.',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line item on a confirmed sales order specifying a single commodity or product — capturing commodity code, crop year, grade/class, quantity ordered and confirmed (BU/MT/CWT), unit price, pricing basis (spot/forward/futures), lot number, GMO status, COOL country of origin, MRL compliance flag, PHI clearance status, and line-level delivery schedule. Supports multi-commodity orders and per-line regulatory compliance tracking common in agricultural commodity sales.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `account_id` BIGINT COMMENT 'Reference to the buyer/customer party who is the counterparty to this sales contract. Links to the customer master.',
    `agrochemical_product_id` BIGINT COMMENT 'Foreign key linking to product.agrochemical_product. Business justification: Agrochemical supply contracts (pesticide, herbicide, fertilizer) reference a specific registered product — EPA registration number, application rates, and pre-harvest intervals are contractual terms. ',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to invoice.billing_account. Business justification: Agriculture sales contracts are associated with specific billing accounts for invoicing and credit management. Direct FK enables contract-level credit limit checking, AR account setup at contract crea',
    `broker_id` BIGINT COMMENT 'Reference to the agricultural broker or sales agent who facilitated or is managing this contract. Null for direct sales contracts. Used for broker commission calculation and partner relationship tracking in Salesforce CRM.',
    `certification_record_id` BIGINT COMMENT 'Foreign key linking to customer.certification_record. Business justification: Multi-year supply contracts for organic, non-GMO, or GlobalG.A.P. commodities must reference the buyers certification record to enforce contract conditions and ensure certification remains valid thro',
    `commodity_id` BIGINT COMMENT 'Reference to the agricultural commodity (e.g., corn, soybeans, wheat) that is the subject of this contract. Links to the commodity master.',
    `price_basis_id` BIGINT COMMENT 'Foreign key linking to invoice.price_basis. Business justification: A forward sales contract in agriculture is priced against a canonical price basis (exchange, futures month, delivery location). Linking contract to price_basis enables consistent basis-price applicati',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales contracts are legally binding under a specific company code for revenue recognition, tax jurisdiction, and intercompany settlement. Agriculture multi-entity structures require this link for cons',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Contract execution: ag commodity contracts are signed and managed by a specific buyer contact (grain procurement manager). Linking contract to the signing contact is standard in commodity trading for ',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Agricultural sales contracts are the formal outcome of won opportunities. contract carries salesforce_opportunity_id (STRING) as a CRM reference but has no FK to the in-domain opportunity record. Addi',
    `contract_salesforce_opportunity_id` BIGINT COMMENT 'The Salesforce CRM Opportunity record ID that originated or is linked to this contract. Enables bidirectional traceability between the sales pipeline and executed contracts for revenue forecasting and pipeline analytics.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales contracts are assigned to cost centers for profitability tracking by commodity desk or business unit. Agricultural trading companies require contract-level cost center assignment for management ',
    `delivery_location_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_location. Business justification: Contract delivery terms: ag commodity contracts specify a delivery location (elevator, processing plant, port). Proper FK replaces the denormalized delivery_location text field and drives logistics pl',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sales contracts in agriculture are negotiated and owned by specific sales employees. Contract performance reporting by employee (volume fulfilled, revenue realized per rep) is a standard sales managem',
    `farm_unit_id` BIGINT COMMENT 'Foreign key linking to land.farm_unit. Business justification: Sales contracts in grain/commodity agriculture are executed by the operating farm entity as the seller. Grain merchandisers and FSA reporting require knowing which farm unit is the producing counterpa',
    `field_id` BIGINT COMMENT 'Foreign key linking to land.field. Business justification: Identity-preserved and organic grain contracts are written at the field level to ensure certified-field sourcing. Ag contract managers and auditors require field-level traceability on contracts for or',
    `gmo_declaration_id` BIGINT COMMENT 'Foreign key linking to product.gmo_declaration. Business justification: Export commodity contracts to EU and other markets require a referenced GMO declaration as a contractual compliance term. The existing gmo_status string is denormalized; the FK links the contract to t',
    `government_program_id` BIGINT COMMENT 'Foreign key linking to finance.government_program. Business justification: USDA commodity program enrollment (ARC, PLC, CRP) directly affects sales contract terms, payment limitations, and revenue reporting. Linking sales contracts to government programs ensures payment limi',
    `grading_standard_id` BIGINT COMMENT 'Foreign key linking to product.grading_standard. Business justification: Commodity contracts formally specify which USDA grading standard governs acceptance/rejection. Contract disputes hinge on the applicable grading standard. Formalizes moisture_max_pct, test_weight_min,',
    `growing_season_id` BIGINT COMMENT 'Foreign key linking to crop.growing_season. Business justification: Grain contract management: every grain sales contract is tied to a specific crop year/season (new crop vs. old crop). The existing crop_year plain string is a denormalization. Linking enables season-l',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.haccp_plan. Business justification: Agricultural supply contracts with food manufacturers specify which HACCP plan governs production of the contracted commodity. Regulators and buyers require HACCP plan reference in contracts for FSMA ',
    `mrl_threshold_id` BIGINT COMMENT 'Foreign key linking to product.mrl_threshold. Business justification: Export commodity contracts specify MRL compliance requirements for the destination market — EU, Japan, and other markets have different MRL thresholds. Contracts must reference the applicable threshol',
    `organization_id` BIGINT COMMENT 'Reference to the internal sales organization unit responsible for managing and executing this contract.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: contract has payment_terms as a plain denormalized text field. A proper FK to invoice.payment_term enforces standardized payment terms on contracts, supports seasonal deferral term application for agr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Forward commodity contracts in agriculture are assigned to profit centers for margin tracking, period-close accruals, and deferred revenue reporting. Finance requires profit center on contracts to att',
    `quality_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_certification. Business justification: Buyers contractually require suppliers to hold specific certifications (GlobalG.A.P., organic, SQF). Linking contract to quality_certification enables automated compliance verification at contract exe',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: In agricultural commodity sales, the pipeline flows opportunity → quote → contract. The contract table already links back to opportunity (via opportunity_id and salesforce_opportunity_id) but has no d',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Long-term agricultural sales contracts are governed by negotiated price agreements that define base prices, basis adjustments, and volume thresholds. contract carries contract_price and basis_level bu',
    `seed_variety_id` BIGINT COMMENT 'Foreign key linking to product.seed_variety. Business justification: Seed sales contracts are negotiated per variety — a grower contracts to purchase a specific seed variety (with trait package, maturity rating) for the season. This is a primary ag sales process; varie',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Long-term supply contracts in agriculture are negotiated within the customers segment framework (volume commitments, pricing tiers, incoterms defaults defined on segment). Segment-level contract port',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contract. Business justification: Back-to-back contract management: in commodity grain/ag trading, each sales contract is paired with a procurement vendor contract to track supply coverage, margin per trade, and fulfillment risk. Agri',
    `cancellation_date` DATE COMMENT 'The date on which the contract was formally cancelled, if applicable. Null for active or fulfilled contracts. Required for revenue recognition reversal and regulatory audit trail under IFRS 15 and SOX.',
    `cancellation_reason` STRING COMMENT 'Reason code for contract cancellation. Used for commercial dispute analysis, counterparty risk scoring, and regulatory reporting. Null for non-cancelled contracts. [ENUM-REF-CANDIDATE: buyer_default|seller_default|force_majeure|mutual_agreement|price_dispute|quality_dispute|regulatory — promote to reference product]',
    `contract_number` STRING COMMENT 'Externally-known, human-readable contract reference number used in buyer communications, BOL documentation, and SAP SD. Serves as the business identifier across all operational systems.. Valid values are `^SC-[A-Z0-9]{6,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the sales contract. Drives workflow routing in SAP SD and Salesforce CRM. partially_fulfilled indicates some but not all delivery call-offs have been completed. [ENUM-REF-CANDIDATE: draft|active|partially_fulfilled|fulfilled|cancelled|expired|suspended — promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the pricing mechanism governing this contract. forward = price agreed for future delivery; futures_linked = price tied to exchange futures; fixed_price = locked price at signing; basis = price set as a differential to a futures benchmark; spot = current market price at delivery.. Valid values are `forward|futures_linked|fixed_price|basis|spot`',
    `contracted_volume` DECIMAL(18,2) COMMENT 'Total quantity of the commodity committed under this contract, expressed in the contract unit of measure (e.g., bushels, metric tons, hundredweight). This is the headline obligation against which call-off fulfillment is tracked.',
    `cool_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country of origin required for COOL compliance labeling on commodity shipments under this contract. Mandatory for applicable commodities under USDA COOL regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was first created in the lakehouse silver layer. Serves as the audit trail creation marker for data lineage and SOX compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the contract price and total value are denominated (e.g., USD, EUR, BRL). Required for multi-currency reporting under IFRS.. Valid values are `^[A-Z]{3}$`',
    `delivery_end_date` DATE COMMENT 'The latest date by which all contracted commodity deliveries must be completed. Defines the closing of the contracted delivery window and triggers penalty or renegotiation clauses if unfulfilled.',
    `delivery_start_date` DATE COMMENT 'The earliest date on which commodity deliveries may commence under this contract. Defines the opening of the contracted delivery window for call-off scheduling.',
    `effective_date` DATE COMMENT 'The date on which the contract becomes legally binding and commercially effective. Used to determine when pricing terms and delivery obligations commence.',
    `expiry_date` DATE COMMENT 'The date on which the contract expires and all delivery obligations must be fulfilled or rolled over. Nullable for open-ended evergreen contracts.',
    `fsma_compliant` BOOLEAN COMMENT 'Indicates whether this contract requires full FSMA compliance documentation including Produce Safety Rule, Preventive Controls, and traceability records. True = FSMA compliance is a contractual obligation.',
    `fulfilled_volume` DECIMAL(18,2) COMMENT 'Cumulative volume of commodity actually delivered and accepted against this contract to date, expressed in the contract volume UOM. Compared against contracted_volume to determine fulfillment percentage and open position.',
    `futures_contract_month` STRING COMMENT 'The CME/CBOT futures delivery month to which this contracts basis or futures-linked price is pegged (e.g., DEC-2024, MAR-2025). Null for fixed-price and spot contracts.. Valid values are `^[A-Z]{3}-[0-9]{4}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) governing the transfer of risk and responsibility for freight, insurance, and delivery between seller and buyer. FOB = Free On Board; CIF = Cost Insurance and Freight. [ENUM-REF-CANDIDATE: FOB|CIF|EXW|DAP|DDP|FCA|CPT|CIP|DAT|CFR — promote to reference product]',
    `moisture_max_pct` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content (%) of the commodity at point of delivery as specified in the contract quality terms. Deliveries exceeding this threshold are subject to dockage or rejection per USDA grain standards.',
    `price` DECIMAL(18,2) COMMENT 'The agreed unit price per volume UOM for fixed-price and forward contracts. For basis and futures-linked contracts, this field captures the locked price once fixation occurs; otherwise null until price fixation date.',
    `price_fixation_date` DATE COMMENT 'The date by which the buyer must fix the price on a basis or futures-linked contract. After this date, the price defaults to the prevailing market price per contract terms. Null for fixed-price contracts.',
    `quality_grade` STRING COMMENT 'The minimum USDA commodity grade or quality specification required for delivery acceptance under this contract (e.g., US No. 1, US No. 2, US Grade A). Drives quality inspection and COA requirements at delivery.',
    `sap_contract_number` STRING COMMENT 'The SAP S/4HANA SD module contract document number (10-digit) that is the system-of-record identifier for this contract in the ERP. Used for cross-system reconciliation between the lakehouse and SAP.. Valid values are `^[0-9]{10}$`',
    `signed_date` DATE COMMENT 'The date on which the contract was formally executed and signed by both parties. Represents the business event timestamp of contract inception. May differ from effective_date if there is a retroactive or future effective period.',
    `special_conditions` STRING COMMENT 'Free-text field capturing any non-standard contractual terms, addenda, or special conditions agreed between the parties (e.g., custom dockage schedules, force majeure clauses, sustainability requirements, organic certification obligations).',
    `test_weight_min` DECIMAL(18,2) COMMENT 'Minimum test weight (lbs/bushel) required for grain commodity deliveries under this contract. Test weight is a key USDA grade determinant for corn, soybeans, and wheat. Deliveries below this threshold are subject to grade discount.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract record was most recently modified in the lakehouse silver layer. Used for incremental data pipeline processing and audit trail maintenance.',
    `volume_uom` STRING COMMENT 'Unit of measure for the contracted volume. BU = Bushel, MT = Metric Ton, CWT = Hundredweight, LB = Pound, KG = Kilogram, TON = Short Ton. Aligns with CME Group and USDA commodity reporting standards.. Valid values are `BU|MT|CWT|LB|KG|TON`',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Long-term or seasonal agricultural sales contract governing the commercial relationship between the enterprise and a buyer — capturing contract number, contract type (forward, futures-linked, fixed-price, basis), commodity, total contracted volume, price formula, crop year, incoterms, GLOBALG.A.P. certification requirements, FSMA compliance obligations, and contract status. Includes the planned delivery call-off schedule (delivery windows, scheduled volumes per call-off, delivery locations, pricing fixation dates, basis levels, and fulfillment status) enabling tracking of contract execution against committed delivery obligations across the crop marketing season. SSOT for both commercial contract terms and delivery execution planning.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`price_agreement` (
    `price_agreement_id` BIGINT COMMENT 'Primary key for price_agreement',
    `account_id` BIGINT COMMENT 'Reference to the customer (buyer, distributor, food manufacturer, or broker) for whom this pricing agreement is established. Links to the customer master.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Price agreement approval in agriculture commodity sales is a formal governance step requiring an identified approving employee for pricing audit trails and delegation-of-authority compliance. approve',
    `certification_record_id` BIGINT COMMENT 'Foreign key linking to customer.certification_record. Business justification: Price agreements for certified commodities (organic, GlobalG.A.P.) include quality premiums that require verification of the buyers active certification. Agriculture pricing teams link price agreemen',
    `commodity_id` BIGINT COMMENT 'Reference to the agricultural commodity or product (e.g., corn, soybeans, wheat, cattle) covered by this pricing agreement. Links to the commodity or product master.',
    `price_basis_id` BIGINT COMMENT 'Foreign key linking to invoice.price_basis. Business justification: A price agreement in commodity agriculture defines the basis and pricing method for a customer relationship. Linking to the canonical price_basis record ensures that all invoices generated under the a',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Price agreement negotiation audit trail: pricing agreements in ag commodity sales are negotiated with a specific buyer contact. This link enables audit trail of who approved the pricing arrangement an',
    `delivery_location_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_location. Business justification: Agriculture price agreements include freight allowances and basis adjustments tied to a specific delivery point. The price_agreement.freight_allowance column is meaningless without knowing the deliver',
    `distribution_channel_id` BIGINT COMMENT 'Foreign key linking to sales.distribution_channel. Business justification: The price_agreement table has `sales_channel_code` typed as BIGINT, which is clearly intended as a FK reference to the distribution_channel table (channel-specific pricing is a core SAP SD condition r',
    `grading_standard_id` BIGINT COMMENT 'Foreign key linking to product.grading_standard. Business justification: Grade-based price premiums and discounts in agriculture require formal reference to the applicable grading standard. Price agreements specify commodity_grade; formalizing this as a grading_standard FK',
    `market_price_id` BIGINT COMMENT 'Foreign key linking to sales.market_price. Business justification: Price agreements in agricultural commodity trading reference market price indices (DTN, CME futures, WASDE) as their pricing basis. price_agreement carries market_reference_index (STRING) but no FK to',
    `master_id` BIGINT COMMENT 'Foreign key linking to product.product_master. Business justification: Price agreements for seeds, crop protection products, and processed goods are negotiated at SKU level, not commodity level. Dealer and distributor price agreements for branded ag inputs require produc',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: Price agreements in SAP SD are always scoped to a sales organization — the sales org is a key dimension of the condition record key. The price_agreement table currently has no sales_organization_id FK',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to invoice.payment_term. Business justification: price_agreement has payment_terms_code as a plain denormalized text field. A proper FK to invoice.payment_term links negotiated payment terms to the price agreement master, supporting early payment di',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Price agreements in agriculture (annual supply contracts with food manufacturers) are tied to profit centers for margin management and pricing authority delegation. Finance uses this link to report co',
    `quality_certification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_certification. Business justification: Price agreements in agriculture include certification-based premiums (organic premium, GlobalG.A.P. surcharge). Linking price_agreement to quality_certification enables automated premium calculation a',
    `opportunity_id` BIGINT COMMENT 'The Salesforce CRM Opportunity or Contract record ID associated with this pricing agreement. Enables traceability between the CRM sales pipeline and the executed pricing agreement in SAP S/4HANA SD.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Segment-based pricing: ag price agreements are structured by customer segment tier (pricing_tier_code). This link enables segment-level pricing analytics, renewal workflows, and ensures pricing consis',
    `agreement_number` STRING COMMENT 'Externally-known, human-readable identifier for the pricing agreement as assigned by SAP S/4HANA SD or Salesforce CRM. Used in customer communications, contract references, and audit trails (e.g., PA-2024-00123).',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the pricing agreement. draft = under preparation; pending_approval = submitted for authorization; active = currently in force; suspended = temporarily halted; expired = past effective end date; terminated = cancelled before expiry.. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `agreement_type` STRING COMMENT 'Classification of the pricing strategy governing this agreement. spot = current market price at time of transaction; forward = fixed price for future delivery; futures_linked = price tied to exchange futures contract (e.g., CBOT); contract = negotiated fixed-term contract price; index_based = price derived from a market index such as DTN or WASDE. [ENUM-REF-CANDIDATE: spot|forward|futures_linked|contract|index_based|basis — promote to reference product if additional types emerge]. Valid values are `spot|forward|futures_linked|contract|index_based`',
    `approval_date` DATE COMMENT 'The date on which the pricing agreement received final business authorization. Used for audit trail, compliance reporting, and determining when the agreement became actionable.',
    `approval_status` STRING COMMENT 'Authorization workflow status indicating whether the pricing agreement has been reviewed and approved by the required business authority (e.g., Sales Manager, Pricing Committee). Distinct from agreement_status which reflects the overall lifecycle.. Valid values are `pending|approved|rejected|revision_required`',
    `base_price` DECIMAL(18,2) COMMENT 'The negotiated base unit price for the commodity under this agreement, expressed in the agreement currency per unit of measure (e.g., USD per bushel, USD per metric ton, USD per CWT). This is the gross price before basis adjustments or discounts.',
    `commodity_grade` STRING COMMENT 'Quality grade or specification of the agricultural commodity covered by this agreement (e.g., US No. 1, US No. 2, Choice, Prime, Organic). Determines eligibility and price differentials. Aligns with USDA grading standards.',
    `cool_country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country of origin of the commodity as required by COOL (Country of Origin Labeling) regulations. Mandatory for USDA COOL compliance on covered commodities (e.g., USA, BRA, ARG, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pricing agreement record was first created in the system. Used for audit trail, data lineage, and compliance reporting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the base price and all monetary values in this agreement are denominated (e.g., USD, EUR, BRL, CAD).. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base price for this agreement, expressed as a decimal (e.g., 0.0250 = 2.50%). Represents negotiated rebates, volume discounts, or promotional allowances. Stored as a rate; the monetary discount amount is computed at order time.',
    `effective_end_date` DATE COMMENT 'The date on which this pricing agreement ceases to be binding. Nullable for open-ended agreements. Aligns with the SAP S/4HANA condition record validity end date.',
    `effective_start_date` DATE COMMENT 'The date from which this pricing agreement becomes binding and applicable to sales orders (SO). Aligns with the SAP S/4HANA condition record validity start date.',
    `flat_discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount per unit applied to the base price under this agreement (e.g., USD 0.05 per bushel). Used when the discount is a fixed amount rather than a percentage. Expressed in currency_code per price_uom.',
    `freight_allowance` DECIMAL(18,2) COMMENT 'Negotiated freight cost allowance or deduction included in the pricing agreement, expressed in currency_code per price_uom. Relevant for FOB vs. delivered pricing structures where freight responsibility is shared or subsidized.',
    `futures_contract_month` STRING COMMENT 'The exchange futures contract delivery month used as the pricing reference for futures-linked or basis agreements (e.g., Z24 = December 2024 CBOT corn). Applicable when agreement_type is futures_linked or pricing_basis includes basis_cbot/kcbt/mgex.. Valid values are `^[A-Z]{1}[0-9]{2}$`',
    `gmo_status` STRING COMMENT 'Indicates the GMO identity preservation status of the commodity covered by this agreement. gmo = conventional GMO commodity; non_gmo = non-GMO but not certified; ip_non_gmo = identity-preserved non-GMO with full chain-of-custody documentation; organic = USDA NOP certified organic (inherently non-GMO).. Valid values are `gmo|non_gmo|ip_non_gmo|organic`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the delivery obligations, risk transfer point, and cost responsibilities between seller and buyer under this pricing agreement (e.g., FOB, CIF, DAP). [ENUM-REF-CANDIDATE: EXW|FCA|FAS|FOB|CFR|CIF|CPT|CIP|DAP|DPU|DDP — 11 candidates stripped; promote to reference product]',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether this pricing agreement grants the customer exclusive pricing rights for the specified commodity, grade, and channel — preventing the same terms from being offered to competing buyers during the effective period.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this pricing agreement record was most recently modified. Supports change tracking, delta processing in the lakehouse silver layer, and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `market_reference_index` STRING COMMENT 'The external market data source or price index used as the benchmark for index-based or futures-linked pricing (e.g., DTN ProphetX, WASDE, CME CBOT, Reuters Commodities). Supports traceability of price derivation.',
    `max_volume_threshold` DECIMAL(18,2) COMMENT 'The maximum quantity of the commodity covered under this pricing agreement tier. Purchases exceeding this threshold may trigger a different price tier or require renegotiation. Expressed in the price_uom.',
    `min_volume_threshold` DECIMAL(18,2) COMMENT 'The minimum quantity of the commodity the customer must purchase to qualify for this pricing agreement tier. Expressed in the price_uom. Used for volume-tiered pricing and commitment enforcement.',
    `notes` STRING COMMENT 'Free-text field for capturing additional negotiation context, special conditions, broker instructions, or exceptions not captured in structured fields. Examples include harvest season constraints, force majeure clauses, or specific delivery window requirements.',
    `price_uom` STRING COMMENT 'The unit of measure against which the base price is quoted. Common agricultural units include BU (Bushel), MT (Metric Ton), CWT (Hundredweight), LB (Pound), KG (Kilogram), TON (Short Ton), BBL (Barrel), DOZ (Dozen). [ENUM-REF-CANDIDATE: BU|MT|CWT|LB|KG|TON|BBL|DOZ — 8 candidates stripped; promote to reference product]',
    `quality_premium` DECIMAL(18,2) COMMENT 'Additional price premium per unit awarded for above-standard commodity quality attributes (e.g., high protein content, organic certification, non-GMO identity preservation, low moisture). Expressed in currency_code per price_uom.',
    `renewal_type` STRING COMMENT 'Indicates how this pricing agreement is renewed upon expiry. manual = requires explicit renegotiation; auto_renew = automatically renews for the same term; evergreen = continues indefinitely until terminated; one_time = single-use agreement with no renewal.. Valid values are `manual|auto_renew|evergreen|one_time`',
    `sap_condition_record_number` STRING COMMENT 'The SAP S/4HANA SD condition record number (KNUMH) that corresponds to this pricing agreement. Provides direct traceability to the source system pricing master data for reconciliation and audit.',
    `volume_uom` STRING COMMENT 'The unit of measure in which volume thresholds (min/max) are expressed. May differ from price_uom in some commodity contracts (e.g., price per MT but volume commitment in BU). [ENUM-REF-CANDIDATE: BU|MT|CWT|LB|KG|TON|BBL|DOZ — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_price_agreement PRIMARY KEY(`price_agreement_id`)
) COMMENT 'Customer-specific or channel-specific pricing agreement defining negotiated price levels, volume tiers, basis adjustments, and discount structures for agricultural commodities and products — capturing effective date range, commodity, grade, pricing basis (FOB elevator, CIF port, DTN market reference), volume thresholds, and approval status. Supports spot, forward, and futures-linked pricing strategies.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`market_price` (
    `market_price_id` BIGINT COMMENT 'Unique surrogate identifier for each market price record in the silver layer lakehouse. Primary key for the market_price data product.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Market prices are fundamentally prices FOR specific commodities. commodity_code and commodity_name are denormalized on market_price. Formal FK enables price-to-commodity joins for basis calculations, ',
    `grading_standard_id` BIGINT COMMENT 'Foreign key linking to product.grading_standard. Business justification: Market prices in agriculture are grade-specific — USDA #2 Yellow Corn trades at a different price than #1. The existing grade_or_quality string is denormalized; a FK to grading_standard enables price-',
    `growing_season_id` BIGINT COMMENT 'Foreign key linking to crop.growing_season. Business justification: Season-based price analysis: grain market prices are always associated with a specific crop year (e.g., Dec 2024 corn). The existing crop_year plain string is a denormalization. Linking enables season',
    `ask_price` DECIMAL(18,2) COMMENT 'The price at which a seller is willing to sell the commodity per unit of measure on the price date. Used alongside bid_price to determine the bid-ask spread for market liquidity assessment and quote ceiling setting.',
    `basis_value` DECIMAL(18,2) COMMENT 'The difference between the local cash price and the nearby futures contract price (cash price minus futures price), expressed in the same currency and unit of measure. Basis reflects local supply/demand conditions, transportation costs, and storage premiums. Critical for sales teams performing basis calculations, forward contract pricing, and local market competitiveness analysis.',
    `bid_price` DECIMAL(18,2) COMMENT 'The price at which a buyer is willing to purchase the commodity per unit of measure on the price date. Used by sales teams for pricing validation, quote floor setting, and basis calculation. Expressed in the currency and unit of measure specified in this record.',
    `close_price` DECIMAL(18,2) COMMENT 'The last traded price at the close of the market session on the price date. Distinct from settlement_price which may be calculated differently by the exchange. Used for end-of-day reporting, trend analysis, and daily price comparison across periods.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the market or exchange location where this price was observed (e.g., USA, BRA, ARG, CAN, AUS). Required for international trade pricing, COOL (Country of Origin Labeling) compliance, and multi-country revenue benchmarking.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this market price record was first ingested and created in the silver layer lakehouse. Used for data freshness monitoring, SLA compliance tracking, and audit trail maintenance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the price is denominated (e.g., USD for US Dollar, EUR for Euro, CAD for Canadian Dollar, BRL for Brazilian Real). Required for multi-currency operations, international trade pricing (CIF/FOB), and IFRS/GAAP financial reporting compliance.. Valid values are `^[A-Z]{3}$`',
    `delivery_point` STRING COMMENT 'The specific geographic delivery location or terminal associated with this price (e.g., Gulf of Mexico — New Orleans, Pacific Northwest — Portland, Chicago Delivery, On-Farm — Iowa). Relevant for FOB and CIF price types. Used in logistics cost modeling, transportation benchmarking, and BOL generation.',
    `effective_from` TIMESTAMP COMMENT 'The timestamp from which this price record is considered valid and applicable for use in sales quotes, procurement benchmarking, and financial reporting. Supports slowly changing dimension (SCD) patterns in the silver layer for historical price tracking and point-in-time analysis.',
    `effective_to` TIMESTAMP COMMENT 'The timestamp until which this price record is valid. Null indicates the record is currently active (open-ended validity). Used in conjunction with effective_from for SCD Type 2 historical price tracking, enabling point-in-time price lookups for audit, contract dispute resolution, and retrospective margin analysis.',
    `exchange_code` STRING COMMENT 'Standardized exchange or market identifier code where the price was quoted or traded (e.g., CBOT — Chicago Board of Trade, CME — Chicago Mercantile Exchange, KCBT — Kansas City Board of Trade, MGE — Minneapolis Grain Exchange, ICE — Intercontinental Exchange). Null for non-exchange sources such as elevator bids or broker quotes.',
    `futures_contract_month` STRING COMMENT 'The delivery month and year code for the futures contract being referenced (e.g., Z25 for December 2025, H26 for March 2026). Uses standard CME/CBOT contract month letter codes (F=Jan, G=Feb, H=Mar, J=Apr, K=May, M=Jun, N=Jul, Q=Aug, U=Sep, V=Oct, X=Nov, Z=Dec). Null for cash or non-futures price types.. Valid values are `^[A-Z]{1,3}[0-9]{2}$`',
    `high_price` DECIMAL(18,2) COMMENT 'The highest price at which the commodity traded during the market session on the price date. Used for price range analysis, volatility reporting, and sales opportunity identification when prices reach favorable levels.',
    `is_holiday` BOOLEAN COMMENT 'Indicates whether the price date falls on a market holiday or exchange closure day (True = holiday/no trading, False = regular trading day). Used to identify non-trading days in price series analysis, gap-filling logic, and seasonal demand forecasting models.',
    `low_price` DECIMAL(18,2) COMMENT 'The lowest price at which the commodity traded during the market session on the price date. Used alongside high_price for daily price range analysis, risk assessment, and procurement cost benchmarking.',
    `market_location` STRING COMMENT 'The geographic market location, elevator name, port, or exchange venue associated with this price (e.g., Chicago Board of Trade, Gulf of Mexico Export Terminal, Kansas City, Minneapolis Grain Exchange, Local Elevator — Ames IA). Used for basis calculation, regional price comparison, and logistics cost benchmarking.',
    `open_interest` BIGINT COMMENT 'The total number of outstanding futures or options contracts that have not been settled or closed as of the price date. A key indicator of market participation and hedging activity. Used by finance and sales teams for market sentiment analysis and forward pricing strategy.',
    `open_price` DECIMAL(18,2) COMMENT 'The price at which the commodity first traded at the opening of the market session on the price date. Used for intraday price movement analysis, volatility assessment, and sales team market briefings.',
    `price_change` DECIMAL(18,2) COMMENT 'The net change in price from the previous trading sessions settlement or close price to the current sessions settlement or close price. Expressed as a signed decimal (positive = price increase, negative = price decrease). Used for daily market movement reporting and sales team briefings.',
    `price_date` DATE COMMENT 'The calendar date for which this market price record is valid. Represents the trading or reporting date of the price observation. Used by sales teams for daily pricing validation, basis calculation, and quote generation aligned with market conditions on a specific date.',
    `price_frequency` STRING COMMENT 'The temporal frequency or granularity of this price observation. Values: intraday (tick or interval price within a trading session), daily (end-of-day or daily summary), weekly (weekly average or closing price), monthly (monthly average, used for WASDE and long-term planning). Determines how the record is used in analytics and forecasting pipelines.. Valid values are `intraday|daily|weekly|monthly`',
    `price_qualifier` STRING COMMENT 'Additional qualifier describing the nature or timing of the price within its type. Values: nearby (nearest active futures contract month), deferred (future delivery month beyond nearby), spot (immediate delivery cash price), forward (agreed future delivery price), indicative (non-binding market indication), firm (binding quoted price). Used to distinguish pricing intent for quote generation and contract negotiation.. Valid values are `nearby|deferred|spot|forward|indicative|firm`',
    `price_source` STRING COMMENT 'The originating data source or market feed from which this price record was obtained. Values: DTN (Data Transmission Network market data), CME (Chicago Mercantile Exchange futures), WASDE (World Agricultural Supply and Demand Estimates — USDA monthly report), elevator_bid (local grain elevator posted bid), USDA_AMS (USDA Agricultural Marketing Service daily reports), broker (broker or dealer quote). Critical for data lineage, source credibility weighting, and audit compliance.. Valid values are `DTN|CME|WASDE|elevator_bid|USDA_AMS|broker`',
    `price_status` STRING COMMENT 'Lifecycle status of this price record indicating its current validity and usability. Values: active (current valid price for use), superseded (replaced by a corrected or updated record), preliminary (provisional price pending final confirmation), final (confirmed and authoritative), cancelled (withdrawn price record). Ensures sales teams only use validated prices for quote generation.. Valid values are `active|superseded|preliminary|final|cancelled`',
    `price_timestamp` TIMESTAMP COMMENT 'The precise date and time of the intraday price observation or quote capture (ISO 8601 format with timezone offset). Applicable for intraday price feeds from CME futures or DTN real-time data. Null for end-of-day or daily summary records.',
    `price_type` STRING COMMENT 'Classification of the price observation indicating the commercial pricing mechanism. Values: cash (spot/local elevator cash price), futures (exchange-traded futures contract price), basis (difference between local cash and futures), fob (Free On Board — seller loads at origin), cif (Cost Insurance and Freight — seller delivers to destination). [ENUM-REF-CANDIDATE: cash|futures|basis|fob|cif|forward|settlement — promote to reference product]. Valid values are `cash|futures|basis|fob|cif`',
    `settlement_price` DECIMAL(18,2) COMMENT 'The official end-of-day settlement price established by the exchange or market authority for the commodity on the price date. Used as the authoritative reference for daily mark-to-market, margin calculations, forward contract valuation, and revenue benchmarking by finance and procurement teams.',
    `source_record_reference` STRING COMMENT 'The original record identifier or message ID from the upstream source system (DTN feed ID, CME market data message ID, WASDE report record reference, SAP S/4HANA SD pricing condition record key). Used for data lineage tracing, duplicate detection, and reconciliation between the silver layer and source systems.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the price is expressed. Values: BU (Bushel — standard for corn, soybeans, wheat), CWT (Hundredweight — standard for cotton, rice, livestock), MT (Metric Ton — international trade standard), LB (Pound — livestock and some specialty crops), TON (Short Ton), OZ (Troy Ounce — precious metals), KG (Kilogram — international). Critical for price comparison, quote generation, and cross-commodity benchmarking. [ENUM-REF-CANDIDATE: BU|CWT|MT|LB|TON|OZ|KG — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this market price record was last modified or updated in the silver layer lakehouse (e.g., price correction, status change, source data revision). Used for change tracking, data quality monitoring, and audit compliance.',
    `volume` BIGINT COMMENT 'Total number of contracts or units traded for this commodity on the price date. Indicates market liquidity and trading activity. Used by sales and procurement teams to assess market depth and execution feasibility for large volume transactions.',
    `wasde_report_month` STRING COMMENT 'The YYYY-MM formatted month of the USDA WASDE report from which this price or supply/demand context was sourced. Applicable only when price_source = WASDE. The WASDE report is published monthly by USDA and is a primary reference for global commodity supply/demand balance sheets used in revenue benchmarking and seasonal forecasting.. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    CONSTRAINT pk_market_price PRIMARY KEY(`market_price_id`)
) COMMENT 'Daily or intraday commodity market price reference sourced from DTN, CME futures, WASDE reports, and local elevator bids — capturing commodity code, price date, price type (cash, futures, basis, FOB, CIF), market location or exchange, unit of measure, bid/ask/settlement values, crop year, and data source. Primary reference for sales teams performing pricing validation, basis calculation, quote generation, and revenue benchmarking. Also consumed by procurement and finance for cost benchmarking and margin analysis.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`delivery_order` (
    `delivery_order_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying each delivery order record in the silver layer lakehouse. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer (buyer, food manufacturer, distributor) receiving this delivery. Supports customer-level delivery tracking and COOL compliance.',
    `carrier_id` BIGINT COMMENT 'Reference to the assigned transportation carrier (trucking company, rail operator, vessel operator) responsible for executing the physical delivery.',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: A COA must accompany every commodity delivery in agriculture trade. Linking delivery_order to certificate_of_analysis enables COA-to-delivery traceability, supports customer acceptance/rejection decis',
    `certification_record_id` BIGINT COMMENT 'Foreign key linking to customer.certification_record. Business justification: Physical delivery of organic or GlobalG.A.P.-certified commodities requires the delivery order to reference the buyers active certification for chain-of-custody documentation and FSMA traceability au',
    `commodity_id` BIGINT COMMENT 'Reference to the agricultural commodity (e.g., corn, soybeans, wheat, cotton) being delivered. Drives grade, quality, and regulatory compliance requirements.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Proof-of-delivery confirmation in ag operations requires tracking which internal employee (warehouse/logistics staff) signed off on the delivery. This supports FSMA traceability, delivery dispute reso',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Delivery coordination: the receiving contact at the delivery location must be notified of scheduled shipment dates, BOL numbers, and appointment requirements. Standard ag logistics process; distinct f',
    `contract_id` BIGINT COMMENT 'Reference to the underlying forward or spot commodity contract governing the terms of this delivery, if applicable. Supports contract-based delivery scheduling.',
    `delivery_location_id` BIGINT COMMENT 'Reference to the customer delivery destination (plant, distribution center, port terminal) where the commodity is to be received.',
    `facility_id` BIGINT COMMENT 'Reference to the originating location (farm, grain elevator, warehouse, or processing facility) from which the commodity is dispatched.',
    `farm_unit_id` BIGINT COMMENT 'Foreign key linking to land.farm_unit. Business justification: FSMA grain origination traceability: delivery orders must reference the sourcing farm unit to satisfy food safety documentation requirements and enable farm-level delivery performance reporting. Ag lo',
    `field_id` BIGINT COMMENT 'Foreign key linking to land.field. Business justification: FSMA Subpart S and COOL compliance require delivery orders for fresh produce and identity-preserved grain to reference the originating field. Ag food safety auditors expect field-level sourcing on del',
    `gmo_declaration_id` BIGINT COMMENT 'Foreign key linking to product.gmo_declaration. Business justification: Delivery documentation for export shipments must reference the GMO declaration for phytosanitary certificates and BE Act compliance. The existing is_gmo boolean is denormalized; the FK links the deliv',
    `grading_standard_id` BIGINT COMMENT 'Foreign key linking to product.grading_standard. Business justification: Delivery acceptance/rejection decisions are made against a specific grading standard — dock sampling, moisture testing, and foreign material checks are all governed by the referenced standard. The gra',
    `harvest_event_id` BIGINT COMMENT 'Foreign key linking to crop.harvest_event. Business justification: FSMA traceability and commodity lot tracking require linking delivery orders to the specific harvest event that produced the grain being shipped. Grain merchandisers and logistics coordinators trace e',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: In agriculture commodity trade, incoming goods inspections are performed at delivery receipt. Linking delivery_order to inspection enables traceability from delivery to inspection outcome (acceptance,',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: In ag commodity delivery, a specific loading/unloading crew is assigned to each delivery event at the facility. This supports labor cost allocation per delivery, H-2A crew tracking, and piece-rate pay',
    `mrl_threshold_id` BIGINT COMMENT 'Foreign key linking to product.mrl_threshold. Business justification: At delivery, MRL compliance must be verified against the specific threshold for the destination market — FSMA and import country regulatory requirement. The delivery_order must reference the applicabl',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to sales.order_line. Business justification: A delivery order executes fulfillment at the line-item level — each delivery instruction corresponds to a specific commodity line on the sales order. Currently delivery_order only FKs to the order hea',
    `organic_certification_id` BIGINT COMMENT 'Foreign key linking to product.organic_certification. Business justification: Organic commodity deliveries require chain-of-custody documentation referencing the specific NOP certification — USDA NOP requires certification identity at each transfer point. The existing is_organi',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Delivery orders trigger revenue recognition events in agriculture commodity logistics. Profit center assignment on delivery orders is required for SAP goods issue posting and revenue accrual, enabling',
    `order_id` BIGINT COMMENT 'Reference to the confirmed sales order against which this delivery order is issued. Links the physical logistics execution back to the commercial sales transaction.',
    `seed_variety_id` BIGINT COMMENT 'Foreign key linking to product.seed_variety. Business justification: Seed deliveries must track the specific variety for seed certification, lot traceability, and variety purity compliance. Seed certification programs (AOSCA) require variety identity on delivery docume',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: FSMA traceability and COOL compliance: in direct-ship grower-to-buyer flows, the delivery order must identify the vendor/grower as the physical commodity source. Regulators and food safety auditors re',
    `yield_record_id` BIGINT COMMENT 'Foreign key linking to crop.yield_record. Business justification: FSMA/COOL delivery traceability: a delivery order ships grain from a specific harvest lot. Linking delivery_order to yield_record enables farm-to-delivery traceability required by FSMA and COOL regula',
    `actual_delivery_date` DATE COMMENT 'The actual calendar date on which the commodity was received and confirmed at the customer destination. Used for revenue recognition, invoice triggering, and on-time delivery reporting.',
    `actual_shipment_date` DATE COMMENT 'The actual calendar date on which the commodity physically departed the ship-from location. Compared against scheduled shipment date for on-time performance KPI tracking.',
    `bol_number` STRING COMMENT 'The Bill of Lading reference number issued by the carrier upon pickup of the commodity. Serves as the legal contract of carriage and title transfer document for the shipment.',
    `commodity_grade` STRING COMMENT 'The USDA or contractually specified quality grade of the commodity being delivered (e.g., US No. 1, US No. 2, Sample Grade for grains). Determines pricing, acceptance criteria, and end-use suitability. [ENUM-REF-CANDIDATE: US_No1|US_No2|US_No3|US_No4|US_No5|Sample_Grade|Premium|Standard — promote to reference product]',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the commodity was produced or harvested. Mandatory for Country of Origin Labeling (COOL) compliance under USDA AMS regulations.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction (e.g., USD, EUR, BRL). Supports multi-currency international agricultural trade reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_channel` STRING COMMENT 'The sales and distribution channel through which this delivery is executed — direct to customer, via broker/agent, through a distributor, export channel, or intercompany transfer. Supports channel performance analytics.. Valid values are `direct|broker|distributor|export|intercompany`',
    `delivery_order_number` STRING COMMENT 'Externally visible, human-readable delivery order reference number used in communications with carriers, customers, and logistics partners. Follows the format DO-YYYY-NNNNNN.. Valid values are `^DO-[0-9]{4}-[0-9]{6}$`',
    `delivery_status` STRING COMMENT 'Current workflow state of the delivery order across its lifecycle from creation through physical delivery or cancellation.. Valid values are `draft|confirmed|in_transit|delivered|cancelled|on_hold`',
    `grn_number` STRING COMMENT 'The Goods Receipt Note number issued by the customer or receiving warehouse upon acceptance of the delivery. Confirms quantity and quality acceptance and initiates the accounts receivable process.',
    `gross_weight_mt` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in metric tons, including packaging and container tare weight. Required for carrier weight compliance, freight billing, and customs documentation.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the point of risk and cost transfer between seller and buyer (e.g., FOB — Free On Board, CIF — Cost Insurance and Freight). Governs title transfer and insurance obligations.. Valid values are `FOB|CIF|EXW|DAP|DDP|FCA`',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code (e.g., FOB Gulf Port, MS or CIF Rotterdam). Specifies the exact point of risk transfer as required by ICC Incoterms 2020.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery order record was most recently modified. Supports change tracking, data lineage, and incremental ETL processing in the lakehouse.',
    `net_weight_mt` DECIMAL(18,2) COMMENT 'Net weight of the commodity in metric tons, excluding packaging and tare. Used for commodity quantity reconciliation, invoice verification, and USDA reporting.',
    `pricing_basis` STRING COMMENT 'The pricing mechanism applied to this delivery — spot (current market price), forward (agreed future price), futures-linked (tied to CBOT/CME futures contract), contract fixed (pre-agreed fixed price), or basis (futures price plus/minus a basis differential).. Valid values are `spot|forward|futures_linked|contract_fixed|basis`',
    `proof_of_delivery_received` BOOLEAN COMMENT 'Indicates whether a signed Proof of Delivery (POD) document has been received from the customer or carrier, confirming physical receipt of the commodity. Triggers invoice release in SAP SD.',
    `quantity` DECIMAL(18,2) COMMENT 'The ordered quantity of the commodity to be delivered, expressed in the unit of measure specified in the unit_of_measure field (BU, MT, CWT, etc.).',
    `rejection_reason` STRING COMMENT 'Reason code or description for delivery rejection or partial acceptance by the customer (e.g., grade non-conformance, quantity discrepancy, contamination, late delivery). Populated when delivery_status is cancelled or on_hold.',
    `scheduled_delivery_date` DATE COMMENT 'The planned calendar date on which the commodity is expected to arrive at the ship-to customer location. Used for customer commitment and demand planning.',
    `scheduled_shipment_date` DATE COMMENT 'The planned calendar date on which the commodity is scheduled to depart from the ship-from location. Used for carrier booking and logistics coordination.',
    `source_system_reference` STRING COMMENT 'The originating system document reference for this delivery order (e.g., SAP outbound delivery document number, Manhattan WMS shipment ID). Supports data lineage and cross-system reconciliation in the lakehouse.',
    `special_instructions` STRING COMMENT 'Free-text field capturing any special handling, delivery, or unloading instructions communicated to the carrier or receiving facility (e.g., temperature requirements, fumigation status, unloading sequence).',
    `transport_mode` STRING COMMENT 'The mode of transportation used to execute the delivery (truck, rail, barge, ocean vessel, air freight, or intermodal combination). Drives carrier selection, BOL type, and freight cost.. Valid values are `truck|rail|barge|vessel|air|intermodal`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the delivery quantity is expressed. BU (Bushel) for grains, MT (Metric Ton) for international trade, CWT (Hundredweight) for livestock products.. Valid values are `BU|MT|CWT|LB|KG|TON`',
    `unit_price` DECIMAL(18,2) COMMENT 'The agreed price per unit of measure for the commodity in this delivery, expressed in the transaction currency. Confidential commercial pricing data.',
    CONSTRAINT pk_delivery_order PRIMARY KEY(`delivery_order_id`)
) COMMENT 'Delivery instruction issued against a confirmed sales order or contract — capturing delivery order number, ship-from location (farm, elevator, warehouse), ship-to customer location, scheduled shipment date, commodity, grade, quantity (BU/MT/CWT), transport mode, carrier assignment, BOL reference, and delivery status. Bridges the sales order to physical logistics execution.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`broker` (
    `broker_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the broker master record. Primary key for the broker entity in the sales domain Silver layer.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each ag broker relationship is managed by an internal employee (account manager/broker liaison) responsible for commission oversight, contract renewals, and performance reviews. This is a standard CRM',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Brokers operate within defined sales territories for agricultural commodity distribution. broker carries geographic_territory (STRING free-text) but no FK to the territory master. Adding sales_territo',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Broker commission AP payment processing: agriculture brokers receiving commissions must be registered as vendors in the procurement/AP system for payment. Linking broker to vendor enables unified part',
    `annual_volume_target_mt` DECIMAL(18,2) COMMENT 'Agreed annual commodity volume target in Metric Tons (MT) that the broker is expected to facilitate. Used for performance tracking, tiered commission threshold evaluation, and seasonal demand forecasting. Supports YPM (Yield Per Acre Metric) analytics.',
    `broker_category` STRING COMMENT 'Operational category indicating the primary commodity segment the broker specializes in. Supports routing of sales opportunities and commission rule assignment. [ENUM-REF-CANDIDATE: commodity|grain|livestock|produce|specialty_crop|multi_commodity|feed|fiber — promote to reference product if expanded]. Valid values are `commodity|grain|livestock|produce|specialty_crop|multi_commodity`',
    `broker_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the broker, used in SAP S/4HANA SD partner function records and Salesforce CRM for cross-system reference. Unique across all broker records.. Valid values are `^BRK-[A-Z0-9]{4,12}$`',
    `broker_type` STRING COMMENT 'Classification of the broker entity: individual independent agent, brokerage firm, agricultural cooperative acting as intermediary, or industry association. Drives commission structure and contract template selection.. Valid values are `individual|firm|cooperative|association`',
    `business_address_line1` STRING COMMENT 'Primary street address of the brokers registered business location. Used for commission payment remittance, legal correspondence, and USDA registration verification.',
    `business_city` STRING COMMENT 'City of the brokers registered business address. Used in geographic territory assignment and regulatory jurisdiction determination.',
    `business_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the brokers primary business country. Determines applicable regulatory framework (USDA, FDA, COOL compliance) and currency for commission payments.. Valid values are `^[A-Z]{3}$`',
    `business_state_province` STRING COMMENT 'Two-letter US state or Canadian province code for the brokers primary business location. Drives state licensing compliance checks and territory assignment logic.. Valid values are `^[A-Z]{2}$`',
    `commission_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which broker commissions are calculated and paid (e.g., USD, CAD, EUR). Supports multi-currency commission settlement for international brokers.. Valid values are `^[A-Z]{3}$`',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'Standard commission rate expressed as a percentage of the net sales order value earned by the broker for facilitating a transaction. Used as the default rate in commission calculation rules. Stored as a decimal (e.g., 0.0250 = 2.50%). Negotiated per broker agreement.',
    `commission_structure_type` STRING COMMENT 'Type of commission calculation structure applicable to this broker: flat rate (fixed percentage), tiered (rate varies by volume band), volume bonus (additional payment at threshold), spot-linked (tied to spot market price), or futures-linked (tied to futures contract price). Drives commission engine logic.. Valid values are `flat_rate|tiered|volume_bonus|spot_linked|futures_linked`',
    `contract_end_date` DATE COMMENT 'Date on which the broker agreement expires or is terminated. Null indicates an open-ended agreement. Used to enforce commission eligibility cutoffs and trigger renewal workflows in Salesforce CRM.',
    `contract_start_date` DATE COMMENT 'Date on which the broker agreement becomes legally effective and the broker is authorized to transact on behalf of the enterprise. Used for commission eligibility validation and contract lifecycle management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker master record was first created in the Silver layer data product. Serves as the audit trail creation marker per SOX and GDPR data lineage requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the broker holds an exclusive territory or commodity agreement with the enterprise, preventing assignment of competing brokers to the same territory or commodity segment. True = exclusive arrangement.',
    `federal_tax_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number (TIN) for the broker entity. Required for IRS 1099 commission reporting and SAP FI vendor master setup for commission payments.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `gfsi_scheme` STRING COMMENT 'GFSI-recognized food safety certification scheme held by the broker or their represented suppliers, such as SQF (Safe Quality Food), BRC (British Retail Consortium), IFS (International Featured Standards), or FSSC 22000. Relevant for brokers handling food-grade commodities requiring supply chain food safety compliance.. Valid values are `SQF|BRC|IFS|FSSC_22000|none`',
    `globalg_ap_certified` BOOLEAN COMMENT 'Indicates whether the broker holds a valid GLOBALG.A.P. (Global Good Agricultural Practices) certification, confirming adherence to internationally recognized agricultural standards. True = currently certified. Relevant for premium commodity channels and export markets.',
    `incoterms_preference` STRING COMMENT 'Preferred International Commercial Terms (Incoterms) used by the broker in sales transactions, such as FOB (Free On Board) or CIF (Cost Insurance and Freight). Defaults to sales order Incoterms when broker is assigned. Relevant for BOL generation and logistics cost allocation.. Valid values are `FOB|CIF|EXW|DAP|FCA`',
    `last_review_date` DATE COMMENT 'Date of the most recent formal performance and compliance review conducted for this broker. Used to trigger periodic review workflows and ensure ongoing USDA, FDA, and GLOBALG.A.P. compliance.',
    `legal_name` STRING COMMENT 'Full legal registered name of the broker individual or brokerage firm as it appears on USDA registration, state licensing documents, and contractual agreements.',
    `onboarding_date` DATE COMMENT 'Date on which the broker completed the enterprise onboarding process, including USDA registration verification, license validation, SAP vendor master creation, and Salesforce CRM partner record activation.',
    `payment_terms` STRING COMMENT 'Standard payment terms governing when earned commissions are disbursed to the broker after a sales order or contract is settled. Aligns with SAP S/4HANA FI payment terms configuration for vendor commission payments.. Valid values are `net_15|net_30|net_45|net_60|upon_settlement`',
    `preferred_sales_channel` STRING COMMENT 'Primary sales channel through which the broker facilitates transactions: spot market (immediate delivery pricing), forward contract, futures-linked pricing, auction, or direct negotiation. Aligns with pricing strategy configuration in SAP S/4HANA SD and DTN market data feeds.. Valid values are `spot_market|forward_contract|futures_linked|auction|direct_negotiation`',
    `primary_contact_email` STRING COMMENT 'Primary email address for the broker contact used for sales order notifications, commission statements, and regulatory correspondence. Sourced from Salesforce CRM partner record.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the brokerage firm or the individual broker. Used for sales correspondence, contract execution, and commission dispute resolution.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the broker contact. Used for urgent sales negotiations, logistics coordination, and commission payment inquiries.. Valid values are `^+?[1-9][0-9]{7,14}$`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the broker relationship with the enterprise. Controls whether the broker can be assigned to new sales orders, contracts, or commission transactions. Managed in Salesforce CRM partner lifecycle workflow.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `salesforce_partner_code` STRING COMMENT 'External system identifier linking this broker master record to the corresponding partner account record in Salesforce CRM. Enables bidirectional synchronization of broker profile, opportunity assignments, and relationship status between the Silver layer and Salesforce.',
    `sap_vendor_number` STRING COMMENT 'SAP S/4HANA FI/MM vendor master record number assigned to the broker for commission payment processing via Accounts Payable. Required for 1099 reporting and commission disbursement through SAP FI payment runs.',
    `settlement_period` STRING COMMENT 'Frequency at which broker commission statements are generated and payments are settled. Determines the commission aggregation window in the commission lifecycle management process.. Valid values are `weekly|bi_weekly|monthly|quarterly|per_transaction`',
    `termination_reason` STRING COMMENT 'Reason code for the termination of the broker relationship when relationship_status is set to terminated. Used for audit trail, regulatory compliance documentation, and broker performance analytics.. Valid values are `contract_expiry|performance|compliance_violation|mutual_agreement|bankruptcy|other`',
    `trading_name` STRING COMMENT 'Doing-business-as (DBA) or trade name used by the broker in commercial transactions, if different from the legal name. Used in sales order documentation and BOL generation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the broker master record in the Silver layer. Used for change data capture (CDC), incremental load processing, and audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `usda_registration_number` STRING COMMENT 'Official USDA registration or license number issued to the broker under the Agricultural Marketing Act or Packers and Stockyards Act. Required for compliance with USDA AMS and APHIS regulations when brokering regulated commodities.',
    `ytd_volume_facilitated_mt` DECIMAL(18,2) COMMENT 'Cumulative commodity volume in Metric Tons (MT) facilitated by the broker in the current calendar or fiscal year. Used for performance monitoring against annual volume targets and tiered commission threshold evaluation. Refreshed from SAP S/4HANA SD sales order data.',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master record for agricultural commodity brokers and independent sales agents who act as intermediaries in the sales channel. Captures broker code, name, brokerage firm, license number, USDA registration, commodity specializations, commission rate structure, geographic territory, and relationship status. Includes commission transaction management: calculation rules, earned amounts per sales order/contract, payment status, settlement periods, and commission history. Brokers facilitate transactions between the enterprise and buyers but are neither customers nor suppliers. SSOT for broker identity, performance, and commission lifecycle.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Primary key for territory',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Sales territories in agriculture are organized by primary commodity (corn belt, cotton territory, specialty crops region) — territory performance reporting, volume targets, and market penetration metr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales territories map to cost centers for revenue and selling expense allocation in management accounting. Agricultural sales organizations use territory-to-cost-center mapping for regional P&L report',
    `parent_territory_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent territory in a hierarchical territory structure (e.g., a sub-territory rolls up to a regional territory). Enables multi-level territory hierarchy for management reporting and quota aggregation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales territories in agriculture are mapped to profit centers for regional P&L reporting and annual budget allocation. Territory managers are accountable to a profit center; finance uses this link for',
    `employee_id` BIGINT COMMENT 'Identifier of the primary sales representative assigned to this territory. Links to the workforce/employee master for performance tracking, commission calculation, and sales force alignment reporting.',
    `territory_sales_manager_employee_id` BIGINT COMMENT 'Identifier of the sales manager responsible for overseeing this territory. Supports management hierarchy reporting, escalation routing, and regional performance roll-ups.',
    `territory_sales_rep_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `annual_revenue_target_usd` DECIMAL(18,2) COMMENT 'Annual revenue target for this territory in US Dollars. Used for financial planning, sales performance measurement, and EBITDA contribution tracking. Supports GAAP and IFRS revenue recognition reporting requirements.',
    `annual_volume_target_bu` DECIMAL(18,2) COMMENT 'Annual sales volume target expressed in Bushels (BU) for grain commodity territories. Complements the MT target for territories where bushel-based pricing and CBOT futures-linked contracts are the primary commercial unit.',
    `annual_volume_target_mt` DECIMAL(18,2) COMMENT 'Annual sales volume target for this territory expressed in Metric Tons (MT). Used for quota setting, performance tracking against WASDE market share benchmarks, and sales force incentive plan calculations. Aligns with Granular Farm Management financial planning.',
    `channel_coverage` STRING COMMENT 'Primary distribution channel(s) served by this territory. Indicates whether the territory covers direct farm-gate sales, distributor networks, broker relationships, agricultural cooperatives, retail channels, or export markets. Integrates with SAP S/4HANA SD channel determination.. Valid values are `direct|distributor|broker|cooperative|retail|export`',
    `cool_compliance_required` BOOLEAN COMMENT 'Indicates whether Country of Origin Labeling (COOL) compliance is mandatory for sales in this territory. True for territories covering retail and food service channels subject to USDA AMS COOL regulations under the Agricultural Marketing Act.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the primary country covered by this territory (e.g., USA, CAN, MEX). Supports COOL (Country of Origin Labeling) compliance and international sales reporting.. Valid values are `^[A-Z]{3}$`',
    `county_district` STRING COMMENT 'County or USDA agricultural district designation(s) within the territory. Supports precision-level geographic coverage tracking aligned with USDA NASS (National Agricultural Statistics Service) reporting districts.',
    `crm_territory_code` STRING COMMENT 'External identifier for this territory as recorded in Salesforce CRM Territory Management module. Enables cross-system reconciliation between the lakehouse Silver Layer and the CRM system of record for opportunity pipeline and partner relationship management.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary transaction currency used in this territory (e.g., USD, EUR, CAD). Drives currency determination in SAP S/4HANA SD pricing and Oracle NetSuite AR invoicing.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Primary customer segment targeted by this territory. Classifies the dominant buyer type to align product portfolio, pricing, and service levels. Integrates with Salesforce CRM account segmentation for pipeline management.. Valid values are `large_grower|cooperative|distributor|food_manufacturer|retailer|government`',
    `effective_from` DATE COMMENT 'Date from which this territory definition becomes operationally effective. Used for territory realignment tracking, historical coverage analysis, and sales quota proration during mid-year territory changes.',
    `effective_until` DATE COMMENT 'Date on which this territory definition expires or is superseded. Null indicates an open-ended, currently active territory. Used for territory version management and historical coverage auditing.',
    `export_zone` STRING COMMENT 'Designated export zone or international trade region for territories covering cross-border agricultural commodity sales (e.g., NAFTA, EU, Asia-Pacific). Relevant for FOB/CIF pricing terms and export compliance under USDA APHIS and FDA regulations.',
    `fsma_compliance_required` BOOLEAN COMMENT 'Indicates whether FDA Food Safety Modernization Act (FSMA) compliance requirements apply to sales activities in this territory, particularly for territories covering food manufacturers and processors subject to FSMA Produce Safety Rule and Preventive Controls.',
    `gis_boundary_reference` STRING COMMENT 'Reference identifier or URL to the GIS boundary layer in Esri ArcGIS that defines the precise geographic polygon of this territory. Enables spatial analysis, field mapping, and precision agriculture alignment with John Deere Operations Center field boundaries.',
    `globalg_ap_required` BOOLEAN COMMENT 'Indicates whether GLOBALG.A.P. (Global Good Agricultural Practices) certification is required for customers or products sold within this territory. Relevant for export territories and territories serving European retail chains with GLOBALG.A.P. mandates.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this territory within the sales territory hierarchy (e.g., 1=National, 2=Regional, 3=District, 4=Local). Supports hierarchical roll-up reporting and quota cascading.',
    `incoterms` STRING COMMENT 'Standard trade terms (Incoterms) governing delivery responsibility and risk transfer for sales in this territory. FOB (Free On Board) and CIF (Cost Insurance and Freight) are most common in agricultural commodity export territories. Drives BOL generation and logistics cost allocation.. Valid values are `FOB|CIF|EXW|DAP|DDP|FCA`',
    `is_export_territory` BOOLEAN COMMENT 'Flag indicating whether this territory covers international/export sales. When true, additional export compliance requirements apply including USDA APHIS phytosanitary certificates, FDA prior notice, and COOL labeling obligations.',
    `last_realignment_date` DATE COMMENT 'Date of the most recent territory boundary or assignment realignment. Tracks when the territory was last restructured for sales force optimization, market coverage adjustments, or organizational changes.',
    `market_penetration_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of the addressable market within this territory currently served by the company. Calculated as current customer base acreage divided by total farmland acres. Used for strategic market coverage planning and sales force sizing.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, strategic context, or special instructions relevant to managing this territory (e.g., seasonal access restrictions, key account relationships, competitive landscape notes).',
    `pricing_strategy` STRING COMMENT 'Primary pricing strategy applied to sales within this territory. spot = current market price; forward = pre-agreed future delivery price; futures_linked = price tied to CBOT/CME futures contracts via DTN feed; contract = fixed-price annual contract; negotiated = case-by-case negotiation.. Valid values are `spot|forward|futures_linked|contract|negotiated`',
    `region` STRING COMMENT 'Broad geographic sales region to which this territory belongs (e.g., Midwest, Southeast, Great Plains, Pacific Northwest, International). Used for regional roll-up reporting and management hierarchy.',
    `sap_distribution_channel` STRING COMMENT 'Two-character SAP S/4HANA SD Distribution Channel code for this territory. Determines pricing procedures, order types, and delivery conditions applicable to sales transactions originating from this territory.. Valid values are `^[A-Z0-9]{2}$`',
    `sap_sales_org_code` STRING COMMENT 'Four-character SAP S/4HANA SD Sales Organization code associated with this territory. Aligns the territory to the SAP organizational structure for pricing, order management, and revenue reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `state_province` STRING COMMENT 'State or province code(s) covered by this territory (e.g., IA, IL, MN). May contain a comma-separated list for multi-state territories. Used for geographic coverage mapping in Esri ArcGIS and regulatory jurisdiction alignment.',
    `territory_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the sales territory, used in SAP S/4HANA SD and Salesforce CRM for cross-system reference and reporting. Serves as the business identifier for the territory across operational systems.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `territory_description` STRING COMMENT 'Detailed narrative description of the territorys geographic scope, customer segments covered, and strategic purpose within the sales organization.',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory (e.g., Midwest Grain Belt, Southeast Poultry Region). Used in reporting, dashboards, and sales force alignment communications.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the sales territory. active indicates the territory is currently assigned and operational; inactive indicates it has been decommissioned; pending indicates it is being set up; suspended indicates temporarily paused coverage.. Valid values are `active|inactive|pending|suspended`',
    `territory_type` STRING COMMENT 'Classification of the territory by its primary segmentation basis — geographic (state/county boundary), customer segment (large grower, cooperative, distributor), commodity focus, distribution channel, or export zone. Drives sales force alignment strategy.. Valid values are `geographic|customer_segment|commodity|channel|export_zone`',
    `total_farmland_acres` DECIMAL(18,2) COMMENT 'Total estimated farmland acreage within the territory boundary. Sourced from USDA FSA records and Esri ArcGIS land mapping. Used for market penetration analysis, yield potential estimation (YPM), and variable rate application (VRA) planning.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Sales territory master defining geographic and customer-segment-based sales coverage areas — capturing territory code, territory name, geographic boundaries (state, county, region, export zone), assigned sales representative, commodity focus, channel coverage, annual volume target, and active status. Supports sales force alignment, performance tracking, and market coverage planning.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for sales_organization',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Sales organizations in SAP are always assigned to exactly one company code — this is a foundational SAP SD configuration requirement. The existing plain-text company_code attribute is a denormalized r',
    `parent_sales_organization_id` BIGINT COMMENT 'Reference to the parent sales organization in a hierarchical structure, if this is a subsidiary or regional sales organization.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Sales organizations in agriculture holding companies are mapped to profit centers for consolidated revenue reporting across legal entities. Finance uses this link to aggregate sales organization perfo',
    `address_line_1` STRING COMMENT 'Primary street address line for the sales organization headquarters or main office.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or additional location details.',
    `billing_block_flag` BOOLEAN COMMENT 'Indicates whether billing is blocked for this sales organization pending approval or data validation.',
    `city` STRING COMMENT 'City or municipality where the sales organization is located.',
    `cool_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether this sales organization must comply with USDA Country of Origin Labeling requirements for agricultural products.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary country of operation for this sales organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sales organization record was first created in the system.',
    `credit_control_area` STRING COMMENT 'SAP credit control area code used to manage customer credit limits and risk for this sales organization.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the default transactional currency for this sales organization.',
    `delivery_block_flag` BOOLEAN COMMENT 'Indicates whether deliveries are blocked for this sales organization pending resolution of compliance or payment issues.',
    `distribution_channel` STRING COMMENT 'Primary distribution channel through which this sales organization delivers products to customers.',
    `division` STRING COMMENT 'Product division or business unit that this sales organization represents, such as crops, livestock, or specialty products.',
    `effective_end_date` DATE COMMENT 'Date when this sales organization ceased operations or was deactivated. Null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this sales organization became active and authorized to process sales transactions.',
    `email_address` STRING COMMENT 'Primary email address for business correspondence with the sales organization.',
    `fax_number` STRING COMMENT 'Fax number for the sales organization, if applicable.',
    `incoterms_default` STRING COMMENT 'Default International Commercial Terms (Incoterms) used by this sales organization for defining delivery responsibilities and costs.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sales organization record was last updated.',
    `order_block_flag` BOOLEAN COMMENT 'Indicates whether new sales orders are blocked for this sales organization due to credit, compliance, or operational reasons.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the sales organization.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the sales organization address.',
    `pricing_procedure` STRING COMMENT 'SAP pricing procedure code that defines the sequence of pricing conditions applied to sales orders in this organization.',
    `region_code` STRING COMMENT 'Geographic region code where this sales organization operates, such as state, province, or multi-country region.',
    `sales_group_code` STRING COMMENT 'Code identifying the sales group or team responsible for managing sales activities within this organization.',
    `sales_office_code` STRING COMMENT 'Code identifying the primary sales office or branch location associated with this sales organization.',
    `sales_organization_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the sales organization in business transactions and reporting. Used in SAP S/4HANA SD module as the sales organization key.',
    `sales_organization_description` STRING COMMENT 'Detailed textual description of the sales organization, its scope, and operational focus.',
    `sales_organization_name` STRING COMMENT 'Full legal or business name of the sales organization.',
    `sales_organization_status` STRING COMMENT 'Current lifecycle status of the sales organization indicating whether it is operational and can process sales transactions.',
    `sales_organization_type` STRING COMMENT 'Classification of the sales organization by operational scope and market focus.',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the sales organization used in reports and user interfaces.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the sales organization is located.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction under which this sales organization operates for sales tax and VAT purposes.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master reference table for sales_organization. Referenced by sales_org_id.';

CREATE OR REPLACE TABLE `agriculture_ecm`.`sales`.`distribution_channel` (
    `distribution_channel_id` BIGINT COMMENT 'Primary key for distribution_channel',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Distribution channels (direct farm sales, export, co-op) are managed by a named internal employee. channel_manager_name and channel_manager_email are denormalized representations of this employee. Rep',
    `organization_id` BIGINT COMMENT 'Reference to the sales organization that owns and manages this distribution channel. Aligns with SAP S/4HANA organizational structure.',
    `parent_distribution_channel_id` BIGINT COMMENT 'Self-referencing FK on distribution_channel (parent_distribution_channel_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution channels in agriculture (export, domestic wholesale, direct farm) are assigned to profit centers for channel profitability analysis. Finance teams report gross margin by distribution chan',
    `bol_generation_required` BOOLEAN COMMENT 'Indicates whether Bill of Lading documents must be automatically generated for shipments in this channel. Typically true for wholesale and export channels.',
    `channel_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the distribution channel in external systems and business documents. Used in SAP S/4HANA SD module for channel classification.',
    `channel_description` STRING COMMENT 'Detailed business description of the distribution channel, including its purpose, target customers, and operational characteristics.',
    `channel_name` STRING COMMENT 'Full business name of the distribution channel used for reporting and user interfaces.',
    `channel_status` STRING COMMENT 'Current operational status of the distribution channel in the sales lifecycle. Controls whether new orders can be placed through this channel.',
    `channel_type` STRING COMMENT 'Classification of the distribution channel by business model. Determines pricing strategy, contract terms, and fulfillment processes.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission percentage paid to brokers, distributors, or sales representatives for transactions in this channel. Business-sensitive pricing information.',
    `cool_compliance_required` BOOLEAN COMMENT 'Indicates whether Country of Origin Labeling compliance documentation is mandatory for shipments through this channel. Required for certain retail and export channels under USDA regulations.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary country of operation for this distribution channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution channel record was first created in the system.',
    `credit_check_required` BOOLEAN COMMENT 'Indicates whether customer credit verification is mandatory before order acceptance in this channel. Typically true for wholesale and broker channels.',
    `crm_integration_enabled` BOOLEAN COMMENT 'Indicates whether this channel is integrated with Salesforce CRM for opportunity management and pipeline tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the default transaction currency in this distribution channel.',
    `effective_end_date` DATE COMMENT 'Date when this distribution channel was or will be deactivated. Null for currently active channels with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this distribution channel became active and available for sales transactions.',
    `geographic_region` STRING COMMENT 'Primary geographic region or territory served by this distribution channel. Used for regional sales analysis and demand forecasting.',
    `incoterms_default` STRING COMMENT 'Default Incoterms rule for this distribution channel, defining responsibility for shipping costs, insurance, and risk transfer. Critical for export channels and international trade.',
    `is_default_channel` BOOLEAN COMMENT 'Indicates whether this is the default distribution channel for the sales organization. Used in order entry when no specific channel is selected.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution channel record was last updated. Used for change tracking and audit purposes.',
    `lead_time_days` STRING COMMENT 'Standard number of days from order placement to delivery for this distribution channel. Used in demand forecasting and customer promise date calculation.',
    `market_pricing_feed_source` STRING COMMENT 'External market data source used for pricing signals in this channel. DTN and WASDE are common sources for agricultural commodity pricing.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity (in base unit of measure) required for orders placed through this distribution channel. Used to enforce channel-specific order policies.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required for orders in this channel. Enforced at order entry to maintain channel profitability.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this distribution channel record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or business context related to this distribution channel.',
    `partner_broker_network` STRING COMMENT 'Description of the partner and broker relationships associated with this distribution channel. Used for relationship management and commission tracking.',
    `payment_terms_default` STRING COMMENT 'Standard payment terms applied to transactions in this channel (e.g., Net 30, Net 60, COD, prepayment). Used as default in sales order creation.',
    `pricing_strategy` STRING COMMENT 'Default pricing methodology applied to sales through this channel. Determines how commodity prices are calculated and whether market indices (DTN/WASDE) are referenced.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method used to recognize revenue for sales through this channel. Determines when revenue is recorded in financial systems.',
    `sap_sd_channel_code` STRING COMMENT 'Two-character distribution channel code used in SAP S/4HANA SD module. Used for system integration and data synchronization.',
    `seasonal_demand_pattern` STRING COMMENT 'Description of the seasonal demand characteristics for this channel (e.g., peak harvest season, holiday demand). Used in sales forecasting and inventory planning.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code applicable to transactions in this distribution channel. Used for sales tax calculation and compliance reporting.',
    CONSTRAINT pk_distribution_channel PRIMARY KEY(`distribution_channel_id`)
) COMMENT 'Master reference table for distribution_channel. Referenced by distribution_channel_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `agriculture_ecm`.`sales`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `agriculture_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `agriculture_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `agriculture_ecm`.`sales`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `agriculture_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `agriculture_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `agriculture_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `agriculture_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_contract_salesforce_opportunity_id` FOREIGN KEY (`contract_salesforce_opportunity_id`) REFERENCES `agriculture_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `agriculture_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `agriculture_ecm`.`sales`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `agriculture_ecm`.`sales`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_market_price_id` FOREIGN KEY (`market_price_id`) REFERENCES `agriculture_ecm`.`sales`.`market_price`(`market_price_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `agriculture_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ADD CONSTRAINT `fk_sales_organization_parent_sales_organization_id` FOREIGN KEY (`parent_sales_organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ADD CONSTRAINT `fk_sales_distribution_channel_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `agriculture_ecm`.`sales`.`organization`(`organization_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ADD CONSTRAINT `fk_sales_distribution_channel_parent_distribution_channel_id` FOREIGN KEY (`parent_distribution_channel_id`) REFERENCES `agriculture_ecm`.`sales`.`distribution_channel`(`distribution_channel_id`);

-- ========= TAGS =========
ALTER SCHEMA `agriculture_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `agriculture_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `delivery_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `gmo_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Gmo Declaration Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `growing_season_id` SET TAGS ('dbx_business_glossary_term' = 'Growing Season Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Ag Product Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `organic_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `seed_variety_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Variety Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `close_probability_pct` SET TAGS ('dbx_business_glossary_term' = 'Close Probability Percentage');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `converted_so_number` SET TAGS ('dbx_business_glossary_term' = 'Converted Sales Order (SO) Number');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `cool_country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Labeling (COOL) Country of Origin');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `cool_country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DAP|DDP|FCA');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `estimated_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Notes');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Open Date');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'BU|MT|CWT|LB|KG|TON');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'spot|forward|futures_linked|basis|contract|negotiated');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `target_price` SET TAGS ('dbx_business_glossary_term' = 'Target Price');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `target_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BU|MT|CWT|LB|KG|TON');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker / Partner ID');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Record Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `price_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Basis Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `delivery_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `gmo_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Gmo Declaration Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `grading_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Grading Standard Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Ag Product Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `mrl_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Mrl Threshold Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `organic_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Price Agreement Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `seed_variety_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Variety Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade / Class');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `cool_origin_country` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Labeling (COOL) Country Code');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `cool_origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DAP|DDP|FCA');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Named Place / Location');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `mrl_compliant` SET TAGS ('dbx_business_glossary_term' = 'Maximum Residue Limit (MRL) Compliance Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `multi_commodity_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Commodity Quote Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `net_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes / Commercial Remarks');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `phi_days` SET TAGS ('dbx_business_glossary_term' = 'Pre-Harvest Interval (PHI) Days');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Date');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_value_regex' = '^QT-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|expired|cancelled');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'spot|forward|futures_linked|contract|indicative');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `salesforce_opportunity_ref` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity Reference');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `sap_quotation_ref` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA SD Quotation Reference');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Quantity');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `total_quoted_value` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Value');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `total_quoted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `uom_code` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure Code (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `uom_code` SET TAGS ('dbx_value_regex' = 'BU|MT|CWT|LB|KG|TON');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity Start Date');
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity End Date');
ALTER TABLE `agriculture_ecm`.`sales`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`sales`.`order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker / Agent ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Record Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `price_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Basis Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `delivery_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Crew Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `gmo_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Gmo Declaration Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `grading_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Grading Standard Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `organic_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Price Agreement Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `cool_country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Labeling (COOL) Country Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `cool_country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Discount Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `fsma_traceability_lot` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Modernization Act (FSMA) Traceability Lot Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `futures_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Futures Contract Reference');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Order Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Named Place / Location');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Order Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Date');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Status');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Type');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'spot|contract|forward|futures_linked');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Quality Grade');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `shipping_point_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `so_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) Number');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `so_number` SET TAGS ('dbx_value_regex' = '^SO-[0-9]{10}$');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Tax Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Order Quantity');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `price_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Basis Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `gmo_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Gmo Declaration Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `growing_season_id` SET TAGS ('dbx_business_glossary_term' = 'Growing Season Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `mrl_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Mrl Threshold Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `organic_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `seed_variety_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Variety Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Class Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|DAP|DDP|EXW|FCA');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `futures_contract_ref` SET TAGS ('dbx_business_glossary_term' = 'Futures Contract Reference');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `grade_code` SET TAGS ('dbx_business_glossary_term' = 'Grade Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Order Line Status');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|partially_delivered|delivered|invoiced|cancelled');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `moisture_pct` SET TAGS ('dbx_business_glossary_term' = 'Moisture Percentage');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `mrl_compliant` SET TAGS ('dbx_business_glossary_term' = 'Maximum Residue Limit (MRL) Compliant Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code (COOL)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `phi_cleared` SET TAGS ('dbx_business_glossary_term' = 'Pre-Harvest Interval (PHI) Cleared Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `test_weight` SET TAGS ('dbx_business_glossary_term' = 'Test Weight');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `agrochemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Agrochemical Product Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker / Agent ID');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Record Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `price_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Basis Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_salesforce_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Opportunity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `delivery_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `gmo_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Gmo Declaration Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `government_program_id` SET TAGS ('dbx_business_glossary_term' = 'Government Program Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `grading_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Grading Standard Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `growing_season_id` SET TAGS ('dbx_business_glossary_term' = 'Growing Season Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `mrl_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Mrl Threshold Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization ID');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Price Agreement Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `seed_variety_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Variety Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Cancellation Date');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Cancellation Reason');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Number');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^SC-[A-Z0-9]{6,20}$');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'forward|futures_linked|fixed_price|basis|spot');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contracted_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Volume');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `contracted_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `cool_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Labeling (COOL) Country Code');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `cool_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `fsma_compliant` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Modernization Act (FSMA) Compliance Required');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `fulfilled_volume` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Volume');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `futures_contract_month` SET TAGS ('dbx_business_glossary_term' = 'Futures Contract Month');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `futures_contract_month` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `moisture_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Moisture Percentage');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `price_fixation_date` SET TAGS ('dbx_business_glossary_term' = 'Price Fixation Date');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Contracted Quality Grade');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales Contract Number');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `sap_contract_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Conditions');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `special_conditions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `test_weight_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Test Weight');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BU|MT|CWT|LB|KG|TON');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Identifier');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Record Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Basis Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `delivery_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `grading_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Grading Standard Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `market_price_id` SET TAGS ('dbx_business_glossary_term' = 'Market Price Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Ag Product Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `quality_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Number');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Status');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Type');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'spot|forward|futures_linked|contract|index_based');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `cool_country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Labeling (COOL) Country Code');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `cool_country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `flat_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Discount Amount');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `flat_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `freight_allowance` SET TAGS ('dbx_business_glossary_term' = 'Freight Allowance');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `freight_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `futures_contract_month` SET TAGS ('dbx_business_glossary_term' = 'Futures Contract Month');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `futures_contract_month` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}[0-9]{2}$');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `gmo_status` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Status');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `gmo_status` SET TAGS ('dbx_value_regex' = 'gmo|non_gmo|ip_non_gmo|organic');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Agreement Indicator');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `market_reference_index` SET TAGS ('dbx_business_glossary_term' = 'Market Reference Index');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `max_volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Threshold');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `min_volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Threshold');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `quality_premium` SET TAGS ('dbx_business_glossary_term' = 'Quality Premium');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `quality_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `renewal_type` SET TAGS ('dbx_business_glossary_term' = 'Renewal Type');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `renewal_type` SET TAGS ('dbx_value_regex' = 'manual|auto_renew|evergreen|one_time');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `sap_condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Condition Record Number');
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `market_price_id` SET TAGS ('dbx_business_glossary_term' = 'Market Price ID');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `grading_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Grading Standard Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `growing_season_id` SET TAGS ('dbx_business_glossary_term' = 'Growing Season Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `ask_price` SET TAGS ('dbx_business_glossary_term' = 'Ask Price');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `ask_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `basis_value` SET TAGS ('dbx_business_glossary_term' = 'Basis Value');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `basis_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `bid_price` SET TAGS ('dbx_business_glossary_term' = 'Bid Price');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `bid_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `close_price` SET TAGS ('dbx_business_glossary_term' = 'Close Price');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `close_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `futures_contract_month` SET TAGS ('dbx_business_glossary_term' = 'Futures Contract Month');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `futures_contract_month` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{2}$');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `high_price` SET TAGS ('dbx_business_glossary_term' = 'High Price');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `high_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `is_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `low_price` SET TAGS ('dbx_business_glossary_term' = 'Low Price');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `low_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `market_location` SET TAGS ('dbx_business_glossary_term' = 'Market Location');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `open_interest` SET TAGS ('dbx_business_glossary_term' = 'Open Interest');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `open_price` SET TAGS ('dbx_business_glossary_term' = 'Open Price');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `open_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_change` SET TAGS ('dbx_business_glossary_term' = 'Price Change');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Price Date');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_frequency` SET TAGS ('dbx_business_glossary_term' = 'Price Frequency');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_frequency` SET TAGS ('dbx_value_regex' = 'intraday|daily|weekly|monthly');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Price Qualifier');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_qualifier` SET TAGS ('dbx_value_regex' = 'nearby|deferred|spot|forward|indicative|firm');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'DTN|CME|WASDE|elevator_bid|USDA_AMS|broker');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|superseded|preliminary|final|cancelled');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Price Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'cash|futures|basis|fob|cif');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `settlement_price` SET TAGS ('dbx_business_glossary_term' = 'Settlement Price');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `settlement_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Trading Volume');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `wasde_report_month` SET TAGS ('dbx_business_glossary_term' = 'World Agricultural Supply and Demand Estimates (WASDE) Report Month');
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ALTER COLUMN `wasde_report_month` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Record Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Employee Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-From Location ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `farm_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Farm Unit Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `gmo_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Gmo Declaration Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `grading_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Grading Standard Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `harvest_event_id` SET TAGS ('dbx_business_glossary_term' = 'Harvest Event Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Crew Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `mrl_threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Mrl Threshold Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `organic_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `seed_variety_id` SET TAGS ('dbx_business_glossary_term' = 'Seed Variety Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `actual_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Shipment Date');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `commodity_grade` SET TAGS ('dbx_business_glossary_term' = 'Commodity Grade');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COOL)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'direct|broker|distributor|export|intercompany');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Number');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_value_regex' = '^DO-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Status');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|in_transit|delivered|cancelled|on_hold');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `grn_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Note (GRN) Number');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `gross_weight_mt` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (MT)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DAP|DDP|FCA');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Named Place');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `net_weight_mt` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (MT)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'spot|forward|futures_linked|contract_fixed|basis');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `proof_of_delivery_received` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Received Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivery Quantity');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Delivery Rejection Reason');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `scheduled_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shipment Date');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Delivery Instructions');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|barge|vessel|air|intermodal');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'BU|MT|CWT|LB|KG|TON');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `annual_volume_target_mt` SET TAGS ('dbx_business_glossary_term' = 'Broker Annual Volume Target (Metric Ton)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `annual_volume_target_mt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `broker_category` SET TAGS ('dbx_business_glossary_term' = 'Broker Category');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `broker_category` SET TAGS ('dbx_value_regex' = 'commodity|grain|livestock|produce|specialty_crop|multi_commodity');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `broker_code` SET TAGS ('dbx_business_glossary_term' = 'Broker Code');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `broker_code` SET TAGS ('dbx_value_regex' = '^BRK-[A-Z0-9]{4,12}$');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_value_regex' = 'individual|firm|cooperative|association');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Broker Business Address Line 1');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Broker Business City');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Broker Business Country Code');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Broker Business State or Province Code');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `business_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency Code (ISO 4217)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `commission_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission Rate Percentage');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `commission_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission Structure Type');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `commission_structure_type` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|volume_bonus|spot_linked|futures_linked');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Contract Effective End Date');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Contract Effective Start Date');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Broker Exclusivity Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Identification Number (EIN/TIN)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `federal_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `gfsi_scheme` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certification Scheme');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `gfsi_scheme` SET TAGS ('dbx_value_regex' = 'SQF|BRC|IFS|FSSC_22000|none');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `globalg_ap_certified` SET TAGS ('dbx_business_glossary_term' = 'GLOBALG.A.P. Certification Flag');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `incoterms_preference` SET TAGS ('dbx_business_glossary_term' = 'Broker Incoterms Preference (FOB/CIF)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `incoterms_preference` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DAP|FCA');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Last Performance Review Date');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Legal Name');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Broker Onboarding Date');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission Payment Terms');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|upon_settlement');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `preferred_sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Broker Preferred Sales Channel');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `preferred_sales_channel` SET TAGS ('dbx_value_regex' = 'spot_market|forward_contract|futures_linked|auction|direct_negotiation');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Broker Primary Contact Email Address');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Primary Contact Name');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Broker Primary Contact Phone Number');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9][0-9]{7,14}$');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Broker Relationship Status');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `salesforce_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Partner Record ID');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `sap_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Master Number');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Broker Commission Settlement Period');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `settlement_period` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|monthly|quarterly|per_transaction');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Broker Relationship Termination Reason');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'contract_expiry|performance|compliance_violation|mutual_agreement|bankruptcy|other');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Trading Name (DBA)');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `usda_registration_number` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Registration Number');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `usda_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ALTER COLUMN `ytd_volume_facilitated_mt` SET TAGS ('dbx_business_glossary_term' = 'Broker Year-to-Date (YTD) Volume Facilitated (Metric Ton)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory ID');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_sales_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Manager ID');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_sales_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_sales_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_sales_rep_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `annual_revenue_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target (USD)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `annual_revenue_target_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `annual_volume_target_bu` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Target (Bushel)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `annual_volume_target_bu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `annual_volume_target_mt` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Target (Metric Ton)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `annual_volume_target_mt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `channel_coverage` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Coverage');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `channel_coverage` SET TAGS ('dbx_value_regex' = 'direct|distributor|broker|cooperative|retail|export');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `cool_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Labeling (COOL) Compliance Required');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `county_district` SET TAGS ('dbx_business_glossary_term' = 'County or Agricultural District');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `crm_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Territory ID');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Currency Code');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'large_grower|cooperative|distributor|food_manufacturer|retailer|government');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective From Date');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Until Date');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `export_zone` SET TAGS ('dbx_business_glossary_term' = 'Export Zone');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `fsma_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Modernization Act (FSMA) Compliance Required');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `gis_boundary_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Reference');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `globalg_ap_required` SET TAGS ('dbx_business_glossary_term' = 'GLOBALG.A.P. Certification Required');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Territory Hierarchy Level');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DAP|DDP|FCA');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `is_export_territory` SET TAGS ('dbx_business_glossary_term' = 'Export Territory Indicator');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `last_realignment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Territory Realignment Date');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `market_penetration_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Penetration Percentage');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `market_penetration_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'spot|forward|futures_linked|contract|negotiated');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `sap_distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'SAP Distribution Channel Code');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `sap_distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `sap_sales_org_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Sales Organization Code');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `sap_sales_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Code');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Description');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Name');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Type');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|customer_segment|commodity|channel|export_zone');
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ALTER COLUMN `total_farmland_acres` SET TAGS ('dbx_business_glossary_term' = 'Total Farmland Acres');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Identifier');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`organization` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Identifier');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Manager Employee Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ALTER COLUMN `parent_distribution_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
