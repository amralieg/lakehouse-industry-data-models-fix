-- Schema for Domain: sales | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-24 01:59:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`sales` COMMENT 'Sales pipeline, opportunities, quotes, design-win campaigns, NRE agreements, pricing, and customer contracts. Manages sales territories, account assignments, forecast accuracy, revenue targets by product family, end market, and geography. Integrates with Salesforce CRM and SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'System-generated unique identifier for the sales opportunity.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account linked to the opportunity.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to sales.channel_partner. Business justification: Semiconductor design-win opportunities are frequently managed through authorized channel partners (distributors or rep firms). Linking opportunity to channel_partner identifies the primary distributio',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Opportunity Management process requires a primary contact person; linking to customer.contact enables accurate follow‑up and reporting.',
    `nda_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.nda_agreement. Business justification: In semiconductors, sharing technical roadmap details during an opportunity requires an active NDA. Linking opportunity to its governing NDA is a legal compliance requirement, enabling NDA coverage ver',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: In semiconductor design-win sales, opportunities are tied to a specific package type the customer is designing in (e.g., flip-chip BGA for a server CPU). Sales engineers and OSAT capacity planners use',
    `competitive_landscape` STRING COMMENT 'Free‑text description of key competitors and market positioning for the opportunity.',
    `contract_end_date` DATE COMMENT 'Planned end or expiration date of the contract; nullable for open‑ended agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the contract if the opportunity is won.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|pending|expired|terminated`',
    `contract_type` STRING COMMENT 'Nature of the contractual agreement associated with the opportunity.. Valid values are `nre|license|royalty|subscription`',
    `country_code` STRING COMMENT 'Three‑letter country code of the primary customer location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts (e.g., USD, EUR).',
    `end_market` STRING COMMENT 'Primary market segment the opportunity addresses.. Valid values are `automotive|mobile|ai|iot|computing|telecom`',
    `expected_close_date` DATE COMMENT 'Projected date when the opportunity is expected to be closed (won or lost).',
    `expected_discount_amount` DECIMAL(18,2) COMMENT 'Estimated discount or rebate amount applied to the gross revenue.',
    `expected_gross_amount` DECIMAL(18,2) COMMENT 'Projected gross revenue before discounts, taxes, or adjustments.',
    `expected_net_amount` DECIMAL(18,2) COMMENT 'Projected net revenue after discounts and adjustments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the opportunity record.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the opportunity, often reflecting the target product or project.',
    `nre_amount` DECIMAL(18,2) COMMENT 'Potential NRE revenue associated with custom design or engineering services.',
    `opportunity_number` STRING COMMENT 'Human‑readable business identifier assigned to the opportunity (e.g., OPP‑2024‑00123).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price used for revenue calculations, expressed in the selected currency.',
    `pricing_model` STRING COMMENT 'Pricing structure applied to the opportunity.. Valid values are `fixed|tiered|volume|subscription`',
    `probability_percent` STRING COMMENT 'Estimated probability (0‑100) that the opportunity will be won, based on stage and historical data.',
    `region` STRING COMMENT 'Broad geographic region for the opportunity.. Valid values are `americas|emea|apac`',
    `sales_channel` STRING COMMENT 'Channel through which the sale is pursued.. Valid values are `direct|distributor|partner`',
    `stage` STRING COMMENT 'Current pipeline stage of the opportunity.. Valid values are `prospecting|design_in|design_win|production_ramp|won|lost`',
    `stage_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity last moved to its current stage.',
    `target_application` STRING COMMENT 'Intended end‑use or application for the product (e.g., automotive ADAS, AI accelerator).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., units, chips).. Valid values are `units|chips|dies|wafers`',
    `win_loss_date` DATE COMMENT 'Date on which the opportunity outcome (win or loss) was recorded.',
    `win_loss_reason` STRING COMMENT 'Narrative reason why the opportunity was won or lost.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Master record: Core sales opportunity tracking design-win campaigns, pipeline stages (Prospecting→Design-In→Design-Win→Production Ramp→Won/Lost), probability, and expected revenue for semiconductor IC, SoC, ASIC, and FPGA engagements. Sourced from Salesforce CRM Opportunity object. Captures end market (automotive, mobile, AI, IoT, computing), product family, target application, competitive landscape, NRE potential, design-win status, campaign grouping (campaign type, target segment, effectiveness metrics), and stage transition history for pipeline velocity analysis. SSOT for all sales pipeline activity including campaign-level aggregation for design-in programs, product launches, and competitive displacement initiatives.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique system-generated identifier for the quote record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or prospect receiving the quote.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to sales.channel_partner. Business justification: Semiconductor quotes issued through distribution channels must reference the specific channel partner for whom the quote is prepared. Distributor quotes have distinct pricing (distributor price vs. di',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Quote generation must record the exact customer contact authorizing the quote; this FK supports compliance and audit trails.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Quote header must be tied to a product family for contract and pricing governance.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Quote generation requires selecting a package type; linking ensures accurate pricing, compliance, and production planning.',
    `price_list_id` BIGINT COMMENT 'FK to sales.price_list.price_list_id — Quotes reference the applicable price list for base pricing. Essential for pricing compliance and margin analysis.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Quotes are generated in the context of an opportunity. This is the core pipeline-to-commercial link. Required for quote-to-win conversion tracking.',
    `source_opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Every quote is generated in context of an opportunity — this is the core pipeline-to-commercial conversion link. Engineers need this to trace quote→opportunity for pipeline reporting.',
    `conversion_date` TIMESTAMP COMMENT 'Timestamp when the quote was converted to an order, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the quote amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'Additional delivery conditions beyond Incoterms, such as FOB destination or DAP warehouse.',
    `quote_description` STRING COMMENT 'Free‑form text describing the scope, special conditions, or notes for the quote.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the gross amount.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `is_converted` BOOLEAN COMMENT 'Indicates whether the quote has been converted to a sales order.',
    `lead_time_days` STRING COMMENT 'Estimated number of calendar days from order receipt to delivery.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after discount and tax.',
    `payment_terms` STRING COMMENT 'Standard payment condition attached to the quote.. Valid values are `net30|net45|net60|prepay|cash`',
    `quote_date` TIMESTAMP COMMENT 'Timestamp when the quote was issued to the customer.',
    `quote_number` STRING COMMENT 'Human‑readable business identifier for the quotation, often used in communications and tracking.',
    `quote_status` STRING COMMENT 'Current lifecycle state of the quote.. Valid values are `draft|submitted|approved|rejected|expired|converted`',
    `reason_lost` STRING COMMENT 'Textual reason provided when a quote is marked as lost.',
    `sales_region` STRING COMMENT 'Three‑letter country code representing the primary sales region for the quote.. Valid values are `^[A-Z]{3}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax calculated on the gross amount after discount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total quoted amount before discounts, taxes, or adjustments.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per individual unit for the quoted product at the selected volume tier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quote record.',
    `valid_until` DATE COMMENT 'Date after which the quote is no longer valid.',
    `volume_tier` STRING COMMENT 'Quantity bracket that determines unit pricing.. Valid values are `1-99|100-999|1000-9999|10000+`',
    `win_loss_status` STRING COMMENT 'Outcome of the quote after the decision period.. Valid values are `won|lost|open`',
    `valid_from` DATE COMMENT 'Date from which the quoted terms become effective.',
    CONSTRAINT pk_quote PRIMARY KEY(`quote_id`)
) COMMENT 'Transaction record: Commercial price quotation issued to a customer or prospect for semiconductor products including ICs, packaged devices, wafer-level products, and IP licensing. Captures quoted unit price, volume tiers, lead time, validity period, incoterms, currency, and SAP SD quotation reference. Tracks quote-to-order conversion and win/loss outcomes.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique identifier for the quote line record.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: KGD quote lines reference specific die bank lots for pricing (unit cost, bin class) and availability confirmation. Semiconductor KGD sales require quoting against actual die bank inventory to confirm ',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Enables quote‑level reporting and margin analysis by product family.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Quote line pricing and availability require linking to the specific finished good inventory record for SKU, enabling real-time stock checks during quoting.',
    `ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Quote lines often represent IP core licensing; linking tracks IP revenue and compliance.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: quote_line carries a plain-text package_type column — a clear denormalization of packaging.package_type. Multi-line quotes in semiconductors specify different package types per line item. Replacing ',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Quote lines in semiconductors must reference the customer-specific price agreement governing the quoted price for audit traceability and pricing approval workflows. This is distinct from the general p',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: Individual quote line items in semiconductor quoting can reference specific price lists at the line level, particularly when different SKUs on the same quote are priced from different price lists (e.g',
    `quote_id` BIGINT COMMENT 'Identifier of the parent sales quote to which this line belongs.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Semiconductor quote lines for qualified or custom parts must cite the applicable quality spec defining acceptance criteria, test type, and limits. Sales engineers and pricing teams reference quality s',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for accurate pricing, inventory and compliance tracking in quote lines.',
    `tertiary_quote_id` BIGINT COMMENT 'FK to sales.quote.quote_id — Header-detail relationship: quote_line cannot exist without its parent quote. Critical for quote value calculation and line-level pricing analysis.',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the lines revenue is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the quote line was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the quote (e.g., USD, EUR).',
    `customer_requested_delivery_date` DATE COMMENT 'Date the customer expects delivery of the quoted items.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the unit price.',
    `effective_date` DATE COMMENT 'Date on which the quoted terms become effective.',
    `expiration_date` DATE COMMENT 'Date after which the quoted terms are no longer valid.',
    `internal_approval_status` STRING COMMENT 'Status of internal sales or finance approval for the line.. Valid values are `pending|approved|rejected`',
    `is_custom` BOOLEAN COMMENT 'True if the quoted SKU is a custom or engineered product.',
    `is_price_locked` BOOLEAN COMMENT 'True if the quoted price is locked and cannot be changed without re‑quote.',
    `lead_time_days` STRING COMMENT 'Estimated number of calendar days from order to shipment.',
    `line_comment` STRING COMMENT 'Free‑form comment entered by the sales rep for this line.',
    `line_number` STRING COMMENT 'Sequential number of the line within the quote for ordering.',
    `net_price` DECIMAL(18,2) COMMENT 'Unit price after discount, before tax.',
    `pricing_tier` STRING COMMENT 'Pricing tier classification that determines discount levels.. Valid values are `tier1|tier2|tier3|tier4|tier5|tier6`',
    `quantity` BIGINT COMMENT 'Number of units of the product requested in this line.',
    `quote_line_status` STRING COMMENT 'Current lifecycle status of the quote line.. Valid values are `draft|sent|accepted|rejected|expired`',
    `sales_channel` STRING COMMENT 'Channel through which the sale is pursued.. Valid values are `direct|distributor|online|partner|reseller|OEM`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the quote.. Valid values are `APAC|EMEA|AMER|APJ|LATAM|CHINA`',
    `special_handling_instructions` STRING COMMENT 'Any customer‑specific handling, packaging, or shipping notes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax calculated for this line.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `total_price` DECIMAL(18,2) COMMENT 'Gross amount for the line (unit_price * quantity) before tax.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit before discounts, in the quote currency.',
    `uom` STRING COMMENT 'Measurement unit for quantity, typically pcs for pieces.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the quote line.',
    `warranty_years` STRING COMMENT 'Number of years of warranty offered for the product.',
    CONSTRAINT pk_quote_line PRIMARY KEY(`quote_line_id`)
) COMMENT 'Detail record: Individual line item within a sales quotation specifying a single semiconductor SKU, die, or IP core with its quoted quantity, unit price, discount, package type, lead time, and applicable pricing tier. Supports multi-line quotes covering mixed product families and end-market configurations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Price lists are defined per product family to enforce consistent pricing policies.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Price list entries are defined per package type; FK replaces denormalized package_type column for consistency and audit.',
    `superseded_by_price_list_id` BIGINT COMMENT 'Reference to a newer price list that supersedes this one.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the price adjustment.',
    `adjustment_reason` STRING COMMENT 'Business reason or justification for the price adjustment.',
    `adjustment_type` STRING COMMENT 'Type of price adjustment applied to the base price.. Valid values are `rebate|discount|incentive|markdown|none`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list was approved.',
    `audit_trail` STRING COMMENT 'Append-only log of changes to the price list record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list record was created.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the price.. Valid values are `[A-Z]{3}`',
    `price_list_description` STRING COMMENT 'Detailed description of the price list purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the price becomes effective.',
    `effective_until` DATE COMMENT 'Date when the price expires or is superseded.',
    `end_market` STRING COMMENT 'Target market segment (e.g., automotive, mobile, data center).',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this price list is the default for its scope.',
    `price_list_name` STRING COMMENT 'Descriptive name of the price list.',
    `notes` STRING COMMENT 'Free-form notes or comments about the price list.',
    `price_list_status` STRING COMMENT 'Current lifecycle status of the price list.. Valid values are `active|inactive|archived|pending`',
    `price_type` STRING COMMENT 'Category of pricing defined by the list (e.g., standard list, distributor, OEM, spot).. Valid values are `list|distributor|oem|spot`',
    `pricing_condition_code` STRING COMMENT 'SAP SD pricing condition record identifier.',
    `region` STRING COMMENT 'Geographic region for which the price list applies.',
    `tax_code` STRING COMMENT 'Tax code applicable to the price.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit for the defined tier and product.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the price list record.',
    `validity_end` DATE COMMENT 'End date of the price lists validity window.',
    `validity_start` DATE COMMENT 'Start date of the price lists validity window.',
    `version` STRING COMMENT 'Version identifier for the price list.',
    `volume_tier_max` STRING COMMENT 'Maximum quantity for the volume pricing tier.',
    `volume_tier_min` STRING COMMENT 'Minimum quantity for the volume pricing tier.',
    CONSTRAINT pk_price_list PRIMARY KEY(`price_list_id`)
) COMMENT 'Master record: Master pricing repository defining standard and customer-specific pricing for semiconductor products by product family, package type, volume tier, and end market. Supports list price, distributor price, OEM price, and spot price variants. Contains price adjustment records capturing negotiated deviations, special bids, volume rebate adjustments, design-win incentives, and distributor markdowns with adjustment type, approved deviation amount, approval authority, validity windows, and SAP SD pricing condition override references. Integrates with SAP SD condition records and Salesforce CRM pricing engine. Tracks effective dates, supersession history, and full adjustment audit trail. SSOT for all semiconductor product pricing and price deviations.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` (
    `customer_contract_id` BIGINT COMMENT 'Unique system-generated identifier for the customer contract.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party that holds the contract.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Foundry and IDM customer contracts frequently specify the manufacturing facility (e.g., for ITAR compliance, geographic supply chain requirements, or customer-qualified fab site). Contract managers an',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Customer contracts in semiconductors are scoped to product families for EOL notification obligations, PCN requirements, and pricing framework agreements. product_family on customer_contract is a plain',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Contract fulfillment management: semiconductor customer contracts (LTAs, LTB clauses, supply assurance agreements) specify exact materials covered. Linking enables supply commitment validation, PCN ob',
    `nda_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.nda_agreement. Business justification: Semiconductor customer contracts are executed under or alongside an NDA governing confidentiality of pricing, technology, and supply terms. Linking contract to its governing NDA is a standard legal op',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Semiconductor customer contracts frequently specify approved or mandated package types (e.g., ITAR-controlled packages, BGA-only clauses). Contract compliance teams and sales ops need this FK to enfor',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Semiconductor customer contracts reference specific negotiated price agreements that define the pricing terms of the supply relationship. This link enables contract-to-price-agreement traceability for',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: Long-term semiconductor customer contracts define pricing terms that are anchored to a specific price list (or customer-specific price list). Linking customer_contract to price_list normalizes the pri',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Long-term supply contracts often originate from won opportunities. Links contract terms back to the originating sales engagement.',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended.',
    `annual_value` DECIMAL(18,2) COMMENT 'Average yearly revenue expected from the contract.',
    `arbitration_clause` BOOLEAN COMMENT 'Indicates whether disputes are resolved via arbitration.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates if the contract will auto‑renew at the end of its term.',
    `confidentiality_clause` BOOLEAN COMMENT 'Indicates whether a confidentiality clause is present.',
    `contract_name` STRING COMMENT 'Descriptive title of the contract for easy identification.',
    `contract_number` STRING COMMENT 'External contract number assigned by the customer or sales organization.',
    `contract_type` STRING COMMENT 'Category of the contract such as supply, service, license, or NRE.. Valid values are `supply|service|license|nre`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the contract over its full term.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the customer.',
    `credit_rating` STRING COMMENT 'Internal credit rating of the customer.. Valid values are `AAA|AA|A|BBB|BB|B`',
    `currency` STRING COMMENT 'Three‑letter ISO currency code used for all monetary amounts.',
    `customer_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|suspended|terminated|draft|pending`',
    `customer_contract_description` STRING COMMENT 'Free‑form text describing the contract purpose and special conditions.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base unit price.',
    `effective_from` DATE COMMENT 'Date when the contract becomes binding.',
    `effective_until` DATE COMMENT 'Date when the contract expires or is terminated; null for open‑ended contracts.',
    `eol_clause` BOOLEAN COMMENT 'Indicates whether an End‑of‑Life provision is part of the contract.',
    `invoicing_frequency` STRING COMMENT 'How often invoices are issued under the contract.. Valid values are `monthly|quarterly|annually`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `ltb_provision` BOOLEAN COMMENT 'Indicates whether a Last‑Time‑Buy clause is included.',
    `max_order_quantity` BIGINT COMMENT 'Maximum quantity per order allowed under the contract.',
    `min_order_quantity` BIGINT COMMENT 'Minimum quantity per order required by the contract.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the customer.. Valid values are `net30|net45|net60|prepaid|upon_delivery`',
    `pcn_obligation` BOOLEAN COMMENT 'Specifies if the supplier must notify the customer of product changes.',
    `pricing_terms` STRING COMMENT 'Narrative description of pricing structure, discounts, and rebates.',
    `renewal_option` STRING COMMENT 'Specifies whether the contract renews automatically, manually, or not at all.. Valid values are `auto|manual|none`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the contract.',
    `supply_scope` STRING COMMENT 'Scope of supply coverage: exclusive, multi‑source, or global.. Valid values are `exclusive|multi_source|global`',
    `termination_date` DATE COMMENT 'Date on which the contract is formally terminated.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required before contract termination.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit of product or service covered by the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `volume_commitment` BIGINT COMMENT 'Total quantity of units the customer commits to purchase over the contract term.',
    CONSTRAINT pk_customer_contract PRIMARY KEY(`customer_contract_id`)
) COMMENT 'Master record: Long-term commercial contract with a semiconductor customer covering supply commitments, pricing agreements, volume guarantees, last-time-buy (LTB) provisions, product change notification (PCN) obligations, and end-of-life (EOL) terms. Distinct from NRE agreements — governs ongoing product supply rather than development services. Linked to SAP SD outline agreements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`forecast` (
    `forecast_id` BIGINT COMMENT 'System-generated unique identifier for the forecast record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for whom the forecast is created.',
    `design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Semiconductor revenue forecasting is built around design wins. Sales forecasts must reference the specific design win driving projected volume, enabling design-win pipeline forecasting and win-rate-to',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Forecasts are produced per product family for capacity planning and financial reporting.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Semiconductor demand forecasts are maintained at finished good (part number) level for replenishment planning and inventory build decisions. This FK enables forecast accuracy reporting (MAPE by part n',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Semiconductor demand planning and fab loading require part-number-level forecasts. S&OP processes, wafer start planning, and inventory positioning all depend on forecasts tied to specific IC catalog e',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Semiconductor demand planning teams build revenue/volume forecasts against specific design projects to drive wafer start planning and capacity allocation. A sales domain expert expects forecasts to be',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Demand planning: semiconductor sales forecasts must be tied to specific materials for granular MRP input. family_id alone is insufficient for component-level supply planning. This link enables materia',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Sales forecasts in semiconductor design-win pipelines are frequently tied to specific opportunities (e.g., forecasting expected volume for a design-win campaign at a specific end customer). Linking sa',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Semiconductor demand forecasts are broken down by package type to drive OSAT capacity allocation and substrate procurement planning. Demand planners and supply chain teams require package-level foreca',
    `technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Sales forecasts in semiconductors are always segmented by technology node to drive fab capacity planning and wafer start authorizations. Capacity planners and S&OP teams use forecast-by-node to alloca',
    `approval_date` DATE COMMENT 'Date the forecast was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the forecast.',
    `bias` DECIMAL(18,2) COMMENT 'Average signed deviation of forecast from actuals.',
    `forecast_category` STRING COMMENT 'High‑level category of the forecast (demand, supply, or capacity).. Valid values are `demand|supply|capacity`',
    `confidence_level` STRING COMMENT 'Confidence rating assigned to the forecast.. Valid values are `low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `effective_end` DATE COMMENT 'Last day of the period the forecast covers.',
    `effective_start` DATE COMMENT 'First day of the period the forecast covers.',
    `end_market` STRING COMMENT 'Target market segment of the forecast.. Valid values are `Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace`',
    `fiscal_period` STRING COMMENT 'Fiscal period identifier (e.g., FY2025Q1).. Valid values are `^FYd{4}Q[1-4]$`',
    `forecast_number` STRING COMMENT 'Business identifier assigned to the forecast (e.g., F2025Q1-001).',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast.. Valid values are `draft|submitted|approved|rejected`',
    `forecast_type` STRING COMMENT 'Classification of the forecast scenario (commit, upside, or best‑case).. Valid values are `commit|upside|best_case`',
    `geography` STRING COMMENT 'Three‑letter ISO country code representing the forecast geography.. Valid values are `^[A-Z]{3}$`',
    `horizon_months` STRING COMMENT 'Length of the forecast horizon expressed in months.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the forecast is locked from further edits.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the forecast.',
    `last_reviewer` STRING COMMENT 'User identifier who performed the last review.',
    `mape` DECIMAL(18,2) COMMENT 'Statistical measure of forecast accuracy.',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the forecast.',
    `quantity` BIGINT COMMENT 'Projected unit volume for the forecast period.',
    `revenue` DECIMAL(18,2) COMMENT 'Projected revenue amount for the forecast period.',
    `scenario_name` STRING COMMENT 'Named scenario associated with the forecast.. Valid values are `Base|Optimistic|Pessimistic|Seasonal|NewProduct|Exit`',
    `submission_date` DATE COMMENT 'Date the forecast was submitted for review.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for forecast_quantity.. Valid values are `units|pcs|die|wafer`',
    `updated_by` STRING COMMENT 'User identifier who last updated the forecast.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the forecast record.',
    `variance_to_actual` DECIMAL(18,2) COMMENT 'Percentage variance between forecast and actual results.',
    `version_number` STRING COMMENT 'Sequential version identifier for the forecast record.',
    `created_by` STRING COMMENT 'User identifier who created the forecast.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Transaction record: Sales demand forecast capturing expected unit volume and revenue by product family, customer, end market, geography, and fiscal period. Supports rolling 12-month and 18-month forecast horizons used in semiconductor S&OP and wafer-start authorization processes. Tracks forecast version (commit, upside, best-case), submission date, confidence level, and variance against actuals. Integrates with SAP APO/IBP demand planning. Enables forecast accuracy KPI tracking (MAPE, bias) critical for fab capacity planning decisions.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`booking` (
    `booking_id` BIGINT COMMENT 'System-generated unique identifier for the booking record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the booking.',
    `address_id` BIGINT COMMENT 'Identifier of the destination location for shipment.',
    `package_type_id` BIGINT COMMENT 'Foreign key linking to packaging.package_type. Business justification: Booking (order fulfillment) must specify the package type to be produced; needed for manufacturing scheduling and regulatory reporting.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: A confirmed semiconductor booking captures the price list that was in effect at the time of order placement, enabling price list effectiveness analysis, revenue variance attribution, and audit trail f',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Bookings fulfill opportunities. This link closes the pipeline-to-revenue loop essential for forecast accuracy measurement.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: A confirmed booking (firm customer PO) in semiconductor sales is typically placed against a specific quote. The standard sales flow is opportunity → quote → booking. Adding quote_id to booking enables',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Production bookings are linked to a tapeout to schedule wafer fabrication and track yield.',
    `backlog_flag` BOOLEAN COMMENT 'True if the booking is currently in backlog (unfulfilled).',
    `booked_quantity` BIGINT COMMENT 'Number of units (dies) committed in the booking.',
    `booked_revenue_gross` DECIMAL(18,2) COMMENT 'Total revenue amount before discounts and taxes, in the booking currency.',
    `booked_revenue_net` DECIMAL(18,2) COMMENT 'Revenue after discounts and before tax.',
    `booking_number` STRING COMMENT 'External business number assigned to the booking, used in sales and finance processes.',
    `booking_status` STRING COMMENT 'Current lifecycle state of the booking.. Valid values are `draft|confirmed|fulfilled|cancelled|backlog`',
    `booking_timestamp` TIMESTAMP COMMENT 'Timestamp when the booking was created in the source system.',
    `comments` STRING COMMENT 'Free‑form notes entered by sales or operations.',
    `compliance_status` STRING COMMENT 'Current compliance status of the booking with internal and regulatory rules.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the booking amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Preferred logistics mode for shipment.. Valid values are `air|sea|ground|pickup`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the gross revenue.',
    `external_order_ref` STRING COMMENT 'Reference to the original sales order in SAP SD.',
    `forecast_flag` BOOLEAN COMMENT 'True if the booking is included in the sales forecast.',
    `is_critical` BOOLEAN COMMENT 'True if the booking is deemed critical for product launch or revenue targets.',
    `order_type` STRING COMMENT 'Classification of the booking (e.g., standard sale, NRE, design‑win).. Valid values are `standard|nre|design_win|service|maintenance`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the customer.. Valid values are `net30|net45|net60|cash`',
    `pricing_model` STRING COMMENT 'Pricing approach applied to the booking.. Valid values are `list|contract|discounted|custom`',
    `priority_level` STRING COMMENT 'Business priority assigned to the booking.. Valid values are `high|medium|low`',
    `product_family` STRING COMMENT 'High‑level product family (e.g., ASIC, FPGA, SoC) for the booked part.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the booking must be reported under specific regulatory frameworks (e.g., CHIPS Act).',
    `requested_delivery_date` DATE COMMENT 'Date the customer expects the shipment to be delivered.',
    `revenue_recognition_date` DATE COMMENT 'Date when the booked revenue is recognized for accounting.',
    `sales_region` STRING COMMENT 'Geographic sales region for the booking.. Valid values are `APAC|EMEA|AMER`',
    `ship_to_country` STRING COMMENT 'Three‑letter country code of the ship‑to location.. Valid values are `^[A-Z]{3}$`',
    `source` STRING COMMENT 'Origin system that created the booking record.. Valid values are `salesforce|sap|manual`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the net revenue.',
    `total_tax_code` STRING COMMENT 'Tax code used for calculating tax_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the booking record.',
    `warranty_period_months` STRING COMMENT 'Warranty duration provided to the customer, in months.',
    CONSTRAINT pk_booking PRIMARY KEY(`booking_id`)
) COMMENT 'Transaction record: Confirmed sales booking representing a firm customer purchase order commitment for semiconductor devices. Captures booking date, booked revenue, booked units, device part number, customer account, ship-to location, requested delivery date, backlog status, and SAP SD sales order reference. Represents the commercial booking event — distinct from shipment or invoice. SSOT for bookings-to-billings (B2B) ratio, book-to-ship analysis, and revenue waterfall reporting critical to semiconductor quarterly earnings.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` (
    `channel_partner_id` BIGINT COMMENT 'System-generated unique identifier for the channel partner record.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: Authorized semiconductor channel partners (distributors like Arrow, Avnet) operate under specific pricing agreements tied to a designated price list. Linking channel_partner to price_list normalizes t',
    `address_line1` STRING COMMENT 'First line of the partners primary business address.',
    `address_line2` STRING COMMENT 'Second line of the partners primary business address (optional).',
    `authorized_product_lines` STRING COMMENT 'Comma‑separated list of product families the partner may sell.',
    `channel_partner_status` STRING COMMENT 'Current operational status of the partner relationship.. Valid values are `active|inactive|suspended|terminated|pending`',
    `city` STRING COMMENT 'City component of the partners primary address.',
    `contract_effective_from` DATE COMMENT 'Date on which the partner contract becomes effective.',
    `contract_effective_until` DATE COMMENT 'Date on which the partner contract expires or is scheduled to terminate (null if open‑ended).',
    `contract_number` STRING COMMENT 'Unique identifier of the master agreement governing the partner relationship.',
    `contract_status` STRING COMMENT 'Lifecycle state of the partner contract.. Valid values are `draft|active|expired|terminated|suspended`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the partners primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the channel partner record was first created in the lakehouse.',
    `external_partner_code` STRING COMMENT 'Identifier used for the partner in external systems (e.g., third‑party distributor portal).',
    `hub_consignment_level` STRING COMMENT 'Level of consignment inventory maintained at partner hubs.. Valid values are `none|low|medium|high`',
    `inventory_reporting_obligation` BOOLEAN COMMENT 'Indicates whether the partner must provide regular inventory visibility to Semiconductors.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was last reviewed for compliance or data quality.',
    `legal_entity_name` STRING COMMENT 'Full legal entity name as registered for contracts and compliance.',
    `notes` STRING COMMENT 'Free‑form text for internal comments, observations, or special handling instructions.',
    `partner_name` STRING COMMENT 'Legal or trade name of the channel partner organization.',
    `partner_type` STRING COMMENT 'Category of the partner based on its business model and relationship to Semiconductors.. Valid values are `distributor|value_added_reseller|system_integrator|rep_firm|online_marketplace`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the partners primary address.',
    `price_protection_claims_allowed` BOOLEAN COMMENT 'Indicates if the partner can submit price‑protection claims under the agreement.',
    `pricing_agreement_type` STRING COMMENT 'Pricing model governing the partners purchase terms.. Valid values are `fixed|tiered|volume_based|rebate|custom`',
    `primary_contact_email` STRING COMMENT 'Email address used for official communications with the partner.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the main business contact for the partner.',
    `primary_contact_phone` STRING COMMENT 'Telephone number for the primary partner contact.',
    `sap_partner_function_code` STRING COMMENT 'SAP SD code that classifies the partners functional role (e.g., sold‑to, ship‑to, bill‑to).',
    `sell_through_rate` DECIMAL(18,2) COMMENT 'Percentage of partner inventory sold to end customers over a defined period.',
    `state_province` STRING COMMENT 'State or province component of the partners primary address.',
    `stock_on_hand` BIGINT COMMENT 'Current quantity of semiconductor units physically held by the partner.',
    `territory_coverage` STRING COMMENT 'Geographic or market territories the partner is authorized to sell within.',
    `tier_classification` STRING COMMENT 'Strategic tier assigned to the partner reflecting level of authorization and performance expectations.. Valid values are `authorized|preferred|elite`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the channel partner record.',
    `weeks_of_supply` DECIMAL(18,2) COMMENT 'Estimated number of weeks the current stock will satisfy forecasted demand.',
    CONSTRAINT pk_channel_partner PRIMARY KEY(`channel_partner_id`)
) COMMENT 'Master record: Authorized semiconductor sales channel partner including distributors (Arrow, Avnet, WPG), rep firms, value-added resellers (VARs), and system integrators. Captures partner type, authorized product lines, territory coverage, tier classification (authorized, preferred, elite), contract status, inventory reporting obligations (stock on hand, weeks of supply, sell-through, hub/consignment levels), and SAP SD partner function reference. SSOT for channel partner identity and distributor inventory visibility within the sales domain. Supports ship-from-stock-and-debit (SFSD) processing and price protection claim management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_source_opportunity_id` FOREIGN KEY (`source_opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_tertiary_quote_id` FOREIGN KEY (`tertiary_quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_superseded_by_price_list_id` FOREIGN KEY (`superseded_by_price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`quote`(`quote_id`);
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ADD CONSTRAINT `fk_sales_channel_partner_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `vibe_semiconductors_v1`.`sales`.`price_list`(`price_list_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_semiconductors_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_landscape` SET TAGS ('dbx_business_glossary_term' = 'Competitive Landscape Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'nre|license|royalty|subscription');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `end_market` SET TAGS ('dbx_value_regex' = 'automotive|mobile|ai|iot|computing|telecom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Gross Revenue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `expected_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Net Revenue Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Non‑Recurring Engineering (NRE) Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'fixed|tiered|volume|subscription');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'americas|emea|apac');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|partner');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospecting|design_in|design_win|production_ramp|won|lost');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `stage_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Change Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|chips|dies|wafers');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `win_loss_date` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`opportunity` ALTER COLUMN `win_loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Reason');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `source_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_description` SET TAGS ('dbx_business_glossary_term' = 'Quote Description');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Quote Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepay|cash');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|expired|converted');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `reason_lost` SET TAGS ('dbx_business_glossary_term' = 'Reason for Quote Loss');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Quote Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Quote Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_value_regex' = '1-99|100-999|1000-9999|10000+');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Win/Loss Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_value_regex' = 'won|lost|open');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `tertiary_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Quote Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `customer_requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Expiration Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `is_custom` SET TAGS ('dbx_business_glossary_term' = 'Custom Product Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `line_comment` SET TAGS ('dbx_business_glossary_term' = 'Line Comment');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5|tier6');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `quote_line_status` SET TAGS ('dbx_value_regex' = 'draft|sent|accepted|rejected|expired');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|online|partner|reseller|OEM');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER|APJ|LATAM|CHINA');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Line Total Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`quote_line` ALTER COLUMN `warranty_years` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Years)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'commercial_pricing');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `superseded_by_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price List ID (SBPLID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (AA)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (AR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (ATYP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|incentive|markdown|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (ATRL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description (PLD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market (EM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Price List (IDPL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name (PLN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status (PLS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (PT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|distributor|oem|spot');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `pricing_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Code (PCC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (GR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `validity_end` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VED)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `validity_start` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VSD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price List Version (PLV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `volume_tier_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Tier (VTX)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`price_list` ALTER COLUMN `volume_tier_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Tier (VTM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` SET TAGS ('dbx_subdomain' = 'channel_partners');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Identifier (CCI)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (ACNT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `annual_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value (ACV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause Flag (ACF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag (ARF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag (CCF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Title (CT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type (CTYP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'supply|service|license|nre');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (CR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'AAA|AA|A|BBB|BB|B');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CUR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status (CLS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|draft|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description (DESC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (DR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `eol_clause` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Clause (EOL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Frequency (INV_FREQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date (LAD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `ltb_provision` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Provision (LTB)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAXQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_T)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepaid|upon_delivery');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `pcn_obligation` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification Obligation (PCN)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms (PT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RO)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SR)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_business_glossary_term' = 'Supply Scope (SS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_value_regex' = 'exclusive|multi_source|global');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days) (TNP_D)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`customer_contract` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment (VC)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `bias` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'demand|supply|capacity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `effective_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `effective_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_value_regex' = 'Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^FYd{4}Q[1-4]$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'commit|upside|best_case');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography (Country Code)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Months)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Forecast Locked Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `last_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewer');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_value_regex' = 'Base|Optimistic|Pessimistic|Seasonal|NewProduct|Exit');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|pcs|die|wafer');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `updated_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `variance_to_actual` SET TAGS ('dbx_business_glossary_term' = 'Variance to Actual (%)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`forecast` ALTER COLUMN `created_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Identifier (BKID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship‑to Location Identifier (SHIP_LOC_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `package_type_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Package Type Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Opportunity Id');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Indicator (IS_BACKLOG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Booked Quantity (BK_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_revenue_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Booked Revenue (BK_REVENUE_GROSS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booked_revenue_net` SET TAGS ('dbx_business_glossary_term' = 'Net Booked Revenue (BK_REVENUE_NET)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Number (BKNO)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status (BK_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|fulfilled|cancelled|backlog');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Event Timestamp (BK_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Booking Comments (BK_COMMENTS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode (DELIVERY_MODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'air|sea|ground|pickup');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `external_order_ref` SET TAGS ('dbx_business_glossary_term' = 'External Order Reference (EXT_ORDER_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `forecast_flag` SET TAGS ('dbx_business_glossary_term' = 'Forecast Inclusion Flag (IN_FORECAST)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Booking Indicator (IS_CRITICAL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (ORDER_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|nre|design_win|service|maintenance');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model (PRICING_MODEL)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'list|contract|discounted|custom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Booking Priority Level (PRIORITY)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PFAM)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DELIV_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date (REV_RECOG_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SALES_REGION)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship‑to Country Code (SHIP_COUNTRY_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source System (BK_SOURCE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'salesforce|sap|manual');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `total_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`booking` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months) (WARRANTY_MTHS)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` SET TAGS ('dbx_subdomain' = 'channel_partners');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `authorized_product_lines` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Lines');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Lifecycle Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Partner Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Contract Status');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|suspended');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `external_partner_code` SET TAGS ('dbx_business_glossary_term' = 'External Partner Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `hub_consignment_level` SET TAGS ('dbx_business_glossary_term' = 'Consignment Level');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `hub_consignment_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `inventory_reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reporting Obligation Flag');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (LE)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Notes');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'distributor|value_added_reseller|system_integrator|rep_firm|online_marketplace');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `price_protection_claims_allowed` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Claims Allowed');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `pricing_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Type');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `pricing_agreement_type` SET TAGS ('dbx_value_regex' = 'fixed|tiered|volume_based|rebate|custom');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `sap_partner_function_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Partner Function Code');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Sell‑Through Rate (Percent)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `stock_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Stock On Hand (Units)');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Classification');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'authorized|preferred|elite');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`sales`.`channel_partner` ALTER COLUMN `weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply');
