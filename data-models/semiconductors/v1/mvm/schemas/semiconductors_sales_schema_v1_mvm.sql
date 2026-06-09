-- Schema for Domain: sales | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`sales` COMMENT 'Sales pipeline, opportunities, quotes, design-win campaigns, NRE agreements, pricing, and customer contracts. Manages sales territories, account assignments, forecast accuracy, revenue targets by product family, end market, and geography. Integrates with Salesforce CRM and SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'System-generated unique identifier for the sales opportunity.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account linked to the opportunity.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing or design‑win campaign linked to the opportunity.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Opportunity Management process requires a primary contact person; linking to customer.contact enables accurate follow‑up and reporting.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Opportunities need ECCN classification to identify export restrictions, assess destination country eligibility, and incorporate compliance costs/risks into pricing models and probability scoring in se',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Opportunities for export-controlled semiconductors must reference applicable export licenses to qualify deal feasibility, assess license capacity, and incorporate compliance lead times into expected c',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Opportunities specify target fab for capacity/capability matching and export compliance (ITAR, EAR). Sales qualification checks facility availability, technology readiness, and regulatory clearance. E',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Foundry and custom silicon opportunities require qualification against specific fab tool capabilities (process node compatibility, capacity). Sales engineers must verify tool availability during oppor',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Opportunities target specific process nodes (7nm, 28nm, etc.) for customer designs. Sales qualification process requires checking node availability, capacity, and export compliance. Essential for oppo',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Opportunity pipeline dashboards aggregate by product family to forecast revenue.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Opportunity cost estimation uses a specific process flow; linking enables accurate BOM, yield, and cycle‑time forecasts.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Opportunities target specific IC catalog items for technical qualification and pricing. Technical sales teams track exact part numbers being designed into customer products for accurate forecasting an',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Opportunity tracking for a specific chip design project is required for pipeline reporting and resource planning.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Opportunities for advanced/custom chips reference quality specifications (reliability grades, process tolerances, automotive/aerospace standards) during technical qualification and customer negotiatio',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_contract. Business justification: High-volume opportunities reference existing supply agreements for cost modeling, margin analysis, and deal structuring. Essential for validating pricing and delivery commitments against contracted te',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Opportunities for hub/consignment programs identify target storage locations for customer-managed inventory. Semiconductor sales teams negotiate VMI (vendor-managed inventory) arrangements where stora',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Semiconductor opportunities specify preferred/qualified suppliers (foundry, OSAT) for custom silicon or packaging. Critical for RFQ routing, supplier selection during design-in phase, and feasibility ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Opportunities are owned within a sales territory; FK replaces free‑text field for data integrity.',
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
    `nre_amount` DECIMAL(18,2) COMMENT 'Potential NRE revenue associated with custom design or engineering services.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the opportunity, often reflecting the target product or project.',
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

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`quote` (
    `quote_id` BIGINT COMMENT 'Unique system-generated identifier for the quote record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer or prospect receiving the quote.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Quote generation must record the exact customer contact authorizing the quote; this FK supports compliance and audit trails.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Quotes require ECCN classification to determine export restrictions, calculate compliance handling fees, and include regulatory disclaimers for controlled semiconductor products in customer-facing pri',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Quotes for export-controlled semiconductors must reference valid export licenses to provide accurate lead times, delivery terms, and compliance disclaimers, ensuring quoted terms are legally executabl',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Foundry service quotes specify which fab tool will execute the work for capacity reservation and lead time calculation. Operations planning requires knowing tool allocation at quote stage to commit de',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Quotes specify process node for pricing, lead-time, and feasibility assessment. Quote approval workflow requires node capacity check and yield assumption validation. Critical for quote-to-order conver',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Quote header must be tied to a product family for contract and pricing governance.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Quotes are generated based on a defined process flow; the link supports pricing, lead‑time, and qualification status.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Quotes reference specific IC catalog items for precise pricing, lead times, compliance documentation, and technical specifications. Quote generation requires exact part-level detail beyond family for ',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Quotes are generated for design projects; linking enables financial forecasting of design spend.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Every quote is generated in context of an opportunity — this is the core pipeline-to-commercial conversion link. Engineers need this to trace quote→opportunity for pipeline reporting.',
    `price_list_id` BIGINT COMMENT 'FK to sales.price_list.price_list_id — Quotes reference the applicable price list for base pricing. Essential for pricing compliance and margin analysis.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: Quotes for semiconductor products must reference applicable quality specifications (JEDEC reliability, automotive IATF-16949, KGD certification requirements) to price correctly, set lead times, and es',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_contract. Business justification: Quotes leverage existing supply contracts for pricing accuracy and terms compliance, especially for materials and OSAT services. Critical for margin calculation and contract adherence in semiconductor',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Quotes for packaged/tested semiconductors reference the OSAT or material supplier for accurate lead time and cost. Required for quote generation, supply chain feasibility checks, and customer delivery',
    `conversion_date` TIMESTAMP COMMENT 'Timestamp when the quote was converted to an order, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the quote amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'Additional delivery conditions beyond Incoterms, such as FOB destination or DAP warehouse.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the gross amount.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `is_converted` BOOLEAN COMMENT 'Indicates whether the quote has been converted to a sales order.',
    `lead_time_days` STRING COMMENT 'Estimated number of calendar days from order receipt to delivery.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after discount and tax.',
    `payment_terms` STRING COMMENT 'Standard payment condition attached to the quote.. Valid values are `net30|net45|net60|prepay|cash`',
    `quote_date` TIMESTAMP COMMENT 'Timestamp when the quote was issued to the customer.',
    `quote_description` STRING COMMENT 'Free‑form text describing the scope, special conditions, or notes for the quote.',
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

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`quote_line` (
    `quote_line_id` BIGINT COMMENT 'Unique identifier for the quote line record.',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.ip_core. Business justification: Quote lines often represent IP core licensing; linking tracks IP revenue and compliance.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Quote lines specify technology node for accurate pricing, lead-time calculation, and yield assumptions. Quote generation system pulls node-specific cost structures and capacity constraints. Critical f',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Enables quote‑level reporting and margin analysis by product family.',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Quote line pricing and availability require linking to the specific finished good inventory record for SKU, enabling real-time stock checks during quoting.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Quote lines itemize specific IC catalog products with exact pricing, packaging options, and delivery terms. Line-item quoting requires catalog-level detail including part number, revision, and qualifi',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.price_agreement. Business justification: Quote lines must reference negotiated price agreements for specific parts and volume tiers. Semiconductor pricing involves complex tiered agreements that quote lines must honor for compliance, margin ',
    `quote_id` BIGINT COMMENT 'Identifier of the parent sales quote to which this line belongs.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Quotes for wafer starts or foundry services may specify customer-supplied materials (e.g., epitaxial wafers, SOI substrates, specialty materials). Tracking customer-furnished raw materials in quote li',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Required for accurate pricing, inventory and compliance tracking in quote lines.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Quote lines specify the supplier (foundry, OSAT) for each SKU to ensure accurate lead time, cost, and capacity availability. Essential for line-level supply chain validation and customer commitments.',
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
    `package_type` STRING COMMENT 'Physical packaging of the die (e.g., BGA, QFN, WLCSP).',
    `pricing_tier` STRING COMMENT 'Pricing tier classification that determines discount levels.. Valid values are `tier1|tier2|tier3|tier4|tier5|tier6`',
    `quantity` BIGINT COMMENT 'Number of units of the product requested in this line.',
    `quote_line_status` STRING COMMENT 'Current lifecycle status of the quote line.. Valid values are `draft|sent|accepted|rejected|expired`',
    `sales_channel` STRING COMMENT 'Channel through which the sale is pursued.. Valid values are `direct|distributor|online|partner|reseller|OEM`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the quote.. Valid values are `APAC|EMEA|AMER|APJ|LATAM|CHINA`',
    `source_system` STRING COMMENT 'System of record that originated the quote line (e.g., SAP, Salesforce).',
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

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`sales_design_win` (
    `sales_design_win_id` BIGINT COMMENT 'Unique identifier for the design win record.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Design wins must capture ECCN classification to determine export control requirements, restricted countries, and license exceptions for revenue forecasting and compliance risk assessment in semiconduc',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Design wins for export-controlled semiconductor products require export license tracking to ensure shipments comply with ITAR/EAR regulations and authorized destination countries before production ram',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Design wins must be qualified against available fab tool capacity for production ramp planning. Manufacturing operations allocate specific tools to fulfill design win volume commitments. Essential for',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Design wins lock in specific process node for production. Essential for capacity planning, revenue forecasting, and fab loading models. S&OP process requires node-level design win visibility for multi',
    `finished_good_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_good. Business justification: Design win commits to manufacturing a specific finished good; linking design win to the finished‑good record ties sales commitment to inventory production planning.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Design win records the process flow used for the winning design, required for revenue attribution and capacity planning.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Design wins track which specific IC catalog item won the socket at customer. Revenue forecasting, competitive displacement tracking, and production planning require exact part number identification be',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Design wins track which specific IC design project won the customer engagement. Critical for revenue attribution, project ROI analysis, and design reuse decisions. Semiconductor sales teams must link ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Design wins represent future revenue commitments that must be tracked by legal entity for transfer pricing planning, tax optimization, and statutory revenue forecasting.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — A design win is the successful outcome of an opportunity. This link is critical for pipeline conversion metrics and is the most important FK in semiconductor sales.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who selected the semiconductor device.',
    `sku_id` BIGINT COMMENT 'Identifier of the semiconductor device that won the design.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Design wins drive future revenue streams that must be allocated to profit centers for business unit forecasting, capacity planning, and performance tracking against design win pipeline targets.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: A semiconductor design win is commercially valid only when the process is qualified. Revenue ramp forecasting and design win reporting require linking to the process_qualification record. Sales ops an',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Design wins for automotive, aerospace, or industrial applications trigger or reference qualification programs (IATF-16949, AEC-Q100, MIL-STD) as contractual deliverables. Real process: design win clos',
    `quote_id` BIGINT COMMENT 'Identifier of the sales quote associated with the design win.',
    `sales_nre_agreement_id` BIGINT COMMENT 'Identifier of the Non-Recurring Engineering agreement linked to the design win.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_contract. Business justification: Design wins reference the supply contract governing production terms, pricing, and delivery. Critical for margin tracking, revenue forecasting, and ensuring supply chain commitments align with custome',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Design wins track the qualified supplier (fab, OSAT) fulfilling production for supply chain planning, capacity reservation, and revenue forecasting. Core to semiconductor design-in and production ramp',
    `competitor_displacement_score` DECIMAL(18,2) COMMENT 'Score (0-100) representing the impact of displacing the competitor.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework applicable to the design win. [ENUM-REF-CANDIDATE: ITAR|EAR|RoHS|REACH|ISO9001|ISO14001|ISO45001 — 7 candidates stripped; promote to reference product]',
    `confidentiality_level` STRING COMMENT 'Data classification level for the design win record.. Valid values are `public|internal|confidential|restricted`',
    `contract_end_date` DATE COMMENT 'Contract end date.',
    `contract_start_date` DATE COMMENT 'Contract start date.',
    `contract_term_months` STRING COMMENT 'Length of the contract in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the design win record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for revenue amounts.. Valid values are `^[A-Z]{3}$`',
    `design_win_number` STRING COMMENT 'Unique business identifier for the design win record.',
    `displaced_competitor_code` BIGINT COMMENT 'Identifier of the competitor whose device was displaced.',
    `displaced_device_code` BIGINT COMMENT 'Identifier of the competitors device that was displaced.',
    `displacement_reason` STRING COMMENT 'Reason why the competitors device was displaced.. Valid values are `price|performance|power|integration|availability|other`',
    `estimated_annual_revenue_gross` DECIMAL(18,2) COMMENT 'Projected gross revenue per year from the design win before discounts or adjustments.',
    `estimated_annual_revenue_net` DECIMAL(18,2) COMMENT 'Projected net revenue after adjustments.',
    `estimated_annual_unit_volume` BIGINT COMMENT 'Projected number of units the customer will purchase per year.',
    `export_controlled` BOOLEAN COMMENT 'Indicates if the device is subject to export control regulations.',
    `forecast_accuracy` DECIMAL(18,2) COMMENT 'Percentage indicating forecast accuracy of the revenue estimate.',
    `forecasted_ramp_rate_per_month` DECIMAL(18,2) COMMENT 'Projected increase in unit volume per month during the ramp period.',
    `is_key_account` BOOLEAN COMMENT 'Indicates if the customer is a strategic key account.',
    `last_review_date` DATE COMMENT 'Date when the design win was last reviewed for compliance or forecast updates.',
    `market_segment` STRING COMMENT 'Industry segment of the end product.. Valid values are `consumer|automotive|industrial|communications|data_center|other`',
    `notes` STRING COMMENT 'Free-text notes about the design win.',
    `pricing_model` STRING COMMENT 'Pricing approach applied to the design win.. Valid values are `list|custom|volume|subscription`',
    `region` STRING COMMENT 'Global region of the customer.. Valid values are `APAC|EMEA|NAM|LATAM`',
    `revenue_adjustment` DECIMAL(18,2) COMMENT 'Any discount, rebate, or adjustment applied to the gross revenue.',
    `revenue_ramp_end_date` DATE COMMENT 'End date of the revenue ramp period.',
    `revenue_ramp_start_date` DATE COMMENT 'Start date of the revenue ramp period.',
    `sales_design_win_status` STRING COMMENT 'Current lifecycle status of the design win.. Valid values are `pending|confirmed|closed|cancelled`',
    `sales_territory` STRING COMMENT 'Geographic or market territory responsible for the design win.',
    `target_application` STRING COMMENT 'End product or application where the winning device will be used (e.g., smartphone, automotive ECU).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the design win record.',
    `win_source` STRING COMMENT 'System or source where the design win was recorded.. Valid values are `salesforce|sap|manual|partner`',
    `win_timestamp` TIMESTAMP COMMENT 'Date and time when the design win was officially confirmed.',
    CONSTRAINT pk_sales_design_win PRIMARY KEY(`sales_design_win_id`)
) COMMENT 'Transaction record: Confirmed design-win record capturing the moment a customer selects a semiconductor device for integration into their end product (PCB, module, or SoC platform). Records the winning device, customer design reference, target application, estimated annual unit volume (AUV), revenue ramp timeline, and competitive displacement details (displaced competitor, displaced device, displacement reason). Critical KPI for semiconductor commercial teams. Represents the key conversion event from opportunity to committed design.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` (
    `sales_nre_agreement_id` BIGINT COMMENT 'Surrogate primary key for the NRE agreement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party for whom the NRE work is performed.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: NRE agreements may be subject to CHIPS Act obligations; linking records the specific obligation tied to each agreement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NRE engineering projects must be allocated to cost centers for tracking R&D expenses, project accounting, and cost recovery against customer payments. Essential for project P&L and resource allocation',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: NRE agreements involving technology transfer, design IP, or controlled process nodes require export license references to ensure ITAR/EAR compliance for deemed exports and international customer engag',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: NRE agreements are allocated to product families for cost recovery and reporting.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: NRE agreements fund development of specific IC catalog products (custom ASICs, process variants). Milestone tracking and deliverable acceptance are tied to specific product development programs, not j',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: NRE agreements fund specific IC design projects. Essential for cost recovery tracking, milestone billing validation, and project budget reconciliation. Finance and program management require this link',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — NRE agreements are commercial vehicles arising from ASIC/custom IC opportunities. Required for NRE pipeline tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: NRE revenue and associated costs must be allocated to profit centers for business unit P&L reporting, technology node profitability analysis, and management reporting by product line.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: NRE agreements frequently include custom test program development as contractual deliverable. Milestone payments tied to test program completion, validation, and handoff. Critical for revenue recognit',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: NRE agreements fund and reference specific qualification programs as milestones (e.g., automotive qualification, reliability testing). Real process: NRE milestone payments and revenue recognition tied',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: NRE agreements involve supplier-specific tooling, mask sets, or process qualifications (foundry, OSAT). Essential for NRE cost allocation, supplier coordination, and milestone tracking in custom silic',
    `actual_revenue_recognized` DECIMAL(18,2) COMMENT 'Revenue recognized to date according to accounting standards.',
    `agreement_number` STRING COMMENT 'Unique business identifier for the NRE agreement, used in contracts and invoicing.',
    `agreement_type` STRING COMMENT 'Classification of the NRE agreement type.. Valid values are `custom|standard|partner|internal`',
    `approval_status` STRING COMMENT 'Current approval state of the milestone deliverable.. Valid values are `pending|approved|rejected`',
    `change_order_flag` BOOLEAN COMMENT 'Indicates if a change order has been issued for the agreement.',
    `change_order_number` STRING COMMENT 'Identifier of the change order associated with the agreement.',
    `completed_milestones` STRING COMMENT 'Number of milestones that have been completed.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the agreement content.. Valid values are `public|internal|confidential|restricted`',
    `contract_reference` STRING COMMENT 'Reference to the related SAP SD contract number.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the NRE amount.. Valid values are `[A-Z]{3}`',
    `deliverable_type` STRING COMMENT 'Type of deliverable associated with the milestone.. Valid values are `RTL|GDS|PDK|Tapeout|Documentation`',
    `effective_end_date` DATE COMMENT 'Date when the NRE agreement ends or expires; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the NRE agreement becomes binding.',
    `exclusivity_flag` BOOLEAN COMMENT 'True if the agreement grants exclusive rights to the customer for the developed IP.',
    `forecasted_revenue` DECIMAL(18,2) COMMENT 'Projected revenue from the NRE agreement for forecasting purposes.',
    `invoice_trigger_flag` BOOLEAN COMMENT 'Indicates whether the milestone triggers an invoice generation.',
    `ip_ownership_clause` STRING COMMENT 'Specifies IP ownership rights granted by the agreement.. Valid values are `full|partial|none`',
    `last_milestone_completed_date` DATE COMMENT 'Date of the most recent milestone that has been completed.',
    `milestone_actual_date` DATE COMMENT 'Actual completion date recorded for the milestone.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'Fee associated with the milestone, invoiced upon completion.',
    `milestone_name` STRING COMMENT 'Name of a specific NRE milestone (e.g., RTL Freeze, Tapeout).',
    `milestone_planned_date` DATE COMMENT 'Planned completion date for the milestone.',
    `milestone_sequence` STRING COMMENT 'Order of the milestone within the agreement schedule.',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the agreement.',
    `nre_total_amount` DECIMAL(18,2) COMMENT 'Total contracted NRE fee for the agreement.',
    `payment_terms` STRING COMMENT 'Standard payment terms governing invoicing of NRE fees.. Valid values are `net30|net45|net60|upon_delivery|milestone`',
    `risk_assessment_score` STRING COMMENT 'Internal risk rating (1‑5) for the NRE project.',
    `sales_nre_agreement_status` STRING COMMENT 'Current lifecycle status of the NRE agreement.. Valid values are `draft|active|suspended|terminated|closed`',
    `sales_region` STRING COMMENT 'Geographic sales region associated with the agreement.. Valid values are `APAC|EMEA|AMER|LATAM|JAPAC`',
    `termination_date` DATE COMMENT 'Date on which the agreement was terminated.',
    `termination_reason` STRING COMMENT 'Reason provided if the agreement is terminated before completion.',
    `total_milestones` STRING COMMENT 'Total number of milestones defined in the agreement.',
    `updated_by` STRING COMMENT 'User identifier who last modified the agreement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `created_by` STRING COMMENT 'User identifier who created the agreement record.',
    CONSTRAINT pk_sales_nre_agreement PRIMARY KEY(`sales_nre_agreement_id`)
) COMMENT 'Master record: Non-Recurring Engineering (NRE) agreement governing custom IC or ASIC development engagements. Captures NRE fee structure, milestone payment schedule with individual billing/delivery milestones (RTL freeze, tapeout, first silicon, qualification), deliverables (RTL, GDS, PDK, tapeout), IP ownership terms, exclusivity clauses, and SAP SD contract reference. Contains milestone detail records tracking milestone name, planned/actual completion dates, milestone amounts, invoice trigger flags, approval status, and completion workflow. Enables NRE revenue recognition scheduling and project tracking. SSOT for all NRE commercial terms and milestone execution.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`price_list` (
    `price_list_id` BIGINT COMMENT 'Unique identifier for the price list record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Price lists are defined per product family to enforce consistent pricing policies.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Price lists in semiconductor industry are catalog-specific with volume tiers and customer segments. Pricing teams maintain part-number-level price lists for distributors, OEMs, and direct customers wi',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.customer_segment. Business justification: Price lists are defined for specific market segments; FK to customer_segment supports pricing strategy and segment‑based pricing reports.',
    `superseded_by_price_list_id` BIGINT COMMENT 'Reference to a newer price list that supersedes this one.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the price adjustment.',
    `adjustment_reason` STRING COMMENT 'Business reason or justification for the price adjustment.',
    `adjustment_type` STRING COMMENT 'Type of price adjustment applied to the base price.. Valid values are `rebate|discount|incentive|markdown|none`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list was approved.',
    `audit_trail` STRING COMMENT 'Append-only log of changes to the price list record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the price list record was created.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the price.. Valid values are `[A-Z]{3}`',
    `effective_from` DATE COMMENT 'Date when the price becomes effective.',
    `effective_until` DATE COMMENT 'Date when the price expires or is superseded.',
    `end_market` STRING COMMENT 'Target market segment (e.g., automotive, mobile, data center).',
    `is_default` BOOLEAN COMMENT 'Flag indicating if this price list is the default for its scope.',
    `notes` STRING COMMENT 'Free-form notes or comments about the price list.',
    `price_list_description` STRING COMMENT 'Detailed description of the price list purpose and scope.',
    `price_list_name` STRING COMMENT 'Descriptive name of the price list.',
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

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`customer_contract` (
    `customer_contract_id` BIGINT COMMENT 'Unique system-generated identifier for the customer contract.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party that holds the contract.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Contracts often stipulate mandatory product certifications; linking ensures contractual obligations are tracked against the certification registry.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Long-term supply contracts for export-controlled semiconductors must reference applicable export licenses to authorize ongoing shipments, track license utilization, and manage expiration/renewal oblig',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Long-term supply contracts often include dedicated capacity reservations on specific tool sets or technology nodes. Capacity planning and contract compliance tracking require explicit linkage between ',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Long-term supply contracts specify covered technology nodes for capacity reservation and pricing. Contract compliance tracking and capacity allocation require node-level visibility. Critical for LTA m',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Contracts specify product families covered under volume commitments, pricing terms, supply obligations. Contract management tracks which families are in scope for each customer agreement for complianc',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Customer contracts in semiconductors specify the exact process flow for manufacturing contracted products. PCN obligations, supply scope, and pricing terms are process-flow-specific. A contract manage',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Contracts list specific IC catalog items with negotiated pricing, EOL/LTB terms, supply guarantees. Semiconductor supply agreements reference exact part numbers for long-term commitments and regulator',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Contracts must be signed by specific legal entities for statutory compliance, tax reporting, intercompany transfer pricing, and revenue recognition under local GAAP/IFRS requirements.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Long-term supply contracts often originate from won opportunities. Links contract terms back to the originating sales engagement.',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Long-term supply contracts for automotive, aerospace, or industrial customers reference qualification programs as quality assurance commitments and compliance obligations. Real process: contract compl',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_contract. Business justification: Customer contracts reference underlying supply agreements to ensure margin and delivery commitments are feasible. Critical for contract feasibility analysis, risk mitigation, and aligning customer ter',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Hub and consignment contracts specify customer-owned or vendor-managed inventory storage locations at fab sites, distribution centers, or customer facilities. Essential for managing consignment liabil',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Long-term customer contracts specify approved suppliers for supply continuity and quality assurance. Required for supply chain risk management, contractual obligations, and ensuring multi-year deliver',
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
    `customer_contract_description` STRING COMMENT 'Free‑form text describing the contract purpose and special conditions.',
    `customer_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|suspended|terminated|draft|pending`',
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

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique system-generated identifier for the sales territory.',
    `parent_territory_id` BIGINT COMMENT 'Identifier of the immediate parent territory in the hierarchy, if any.',
    `channel_tier` STRING COMMENT 'Sales channel classification for the territory.. Valid values are `direct|distribution|partner`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the primary country of the territory. [ENUM-REF-CANDIDATE: USA|CAN|MEX|CHN|JPN|KOR|... — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the territory definition expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the territory definition becomes effective for sales activities.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the quota targets apply.',
    `hierarchy_path` STRING COMMENT 'Delimited path representing the territorys position in the global→regional→country→district hierarchy (e.g., "Global>EMEA>Germany>Berlin").',
    `is_overlay` BOOLEAN COMMENT 'Indicates whether the territory is an overlay (true) used for specialist coverage in addition to primary territories.',
    `multi_rep_coverage` BOOLEAN COMMENT 'True if the territory is covered by multiple sales representatives or FAEs.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the territory.',
    `region_code` STRING COMMENT 'Internal code representing the broader region (e.g., EMEA, APAC, AMER) to which the territory belongs.',
    `revenue_target_amount` DECIMAL(18,2) COMMENT 'Fiscal period revenue quota assigned to the territory (in corporate currency).',
    `territory_code` STRING COMMENT 'Business code used to uniquely reference the territory in external systems.',
    `territory_description` STRING COMMENT 'Free‑form description providing additional context about the territory.',
    `territory_name` STRING COMMENT 'Human‑readable name of the sales territory.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory.. Valid values are `active|inactive|planned|retired`',
    `territory_type` STRING COMMENT 'Classification of the territory based on its purpose or focus.. Valid values are `geographic|product|strategic|customer`',
    `unit_target_quantity` STRING COMMENT 'Target number of units (e.g., die, wafers) to be sold from the territory for the fiscal period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the territory record.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Master record: Sales territory definition and quota management assigning geographic regions, end markets, or named accounts to sales representatives and field application engineers (FAEs). Captures territory code, region hierarchy (global→regional→country→district), assigned sales rep, FAE coverage, revenue and unit targets by fiscal period (quarterly, half-year, annual), quota amounts, stretch targets, attainment tracking, and effective dates. Includes account-to-territory assignment details with assignment type (direct, distribution, rep firm), primary/secondary coverage flags, channel tier, and multi-rep coverage models. Supports territory realignment, overlay models (product specialists, strategic account managers), quota assignment workflows, and sales performance management common in semiconductor distribution channels. Used for compensation planning and quarterly business review (QBR) reporting.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`sales_forecast` (
    `sales_forecast_id` BIGINT COMMENT 'System-generated unique identifier for the forecast record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for whom the forecast is created.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Sales forecasts must track ECCN classification mix to plan export compliance capacity, anticipate license application volumes, and assess regulatory risk exposure in semiconductor demand planning.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Sales forecasts are facility-specific for S&OP capacity planning. Forecast allocation to fabs drives loading models, capex decisions, and customer commit dates. Essential for monthly S&OP process and ',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Capacity Planning compares forecasted demand with each fab tools capacity; the Forecast‑vs‑Capacity report needs this FK.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Forecasts are produced per product family for capacity planning and financial reporting.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_flow. Business justification: Semiconductor demand planning requires forecasts at process-flow granularity to drive wafer start scheduling. The sales_forecast already links to process_technology_node but fab capacity planning requ',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Forecasts at IC catalog level enable fab loading, wafer starts, inventory planning. Demand planning requires part-number-level forecasts for production scheduling and capacity allocation across foundr',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Demand forecasts are created per technology node; linking provides node‑specific capacity and yield assumptions.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue forecasts must be allocated to profit centers for business unit planning, budget variance analysis, and executive reporting on product line performance against targets.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Forecasts at SKU level (packaging variants, speed grades) drive assembly/test capacity planning. OSAT planning and finished goods inventory management require SKU-level demand signals for accurate sup',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_contract. Business justification: Forecasts reference supply contracts to validate material availability and pricing assumptions. Critical for demand-supply matching, financial planning, and ensuring forecasted revenue is backed by su',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Forecasts are created for a specific sales territory; replace string with FK to territory for referential integrity.',
    `approval_date` DATE COMMENT 'Date the forecast was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the forecast.',
    `bias` DECIMAL(18,2) COMMENT 'Average signed deviation of forecast from actuals.',
    `confidence_level` STRING COMMENT 'Confidence rating assigned to the forecast.. Valid values are `low|medium|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `effective_end` DATE COMMENT 'Last day of the period the forecast covers.',
    `effective_start` DATE COMMENT 'First day of the period the forecast covers.',
    `end_market` STRING COMMENT 'Target market segment of the forecast.. Valid values are `Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace`',
    `fiscal_period` STRING COMMENT 'Fiscal period identifier (e.g., FY2025Q1).. Valid values are `^FYd{4}Q[1-4]$`',
    `forecast_category` STRING COMMENT 'High‑level category of the forecast (demand, supply, or capacity).. Valid values are `demand|supply|capacity`',
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
    `source_system` STRING COMMENT 'Originating system that supplied the forecast data.. Valid values are `SAP_APO|SAP_IBP|Manual`',
    `submission_date` DATE COMMENT 'Date the forecast was submitted for review.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for forecast_quantity.. Valid values are `units|pcs|die|wafer`',
    `updated_by` STRING COMMENT 'User identifier who last updated the forecast.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the forecast record.',
    `variance_to_actual` DECIMAL(18,2) COMMENT 'Percentage variance between forecast and actual results.',
    `version_number` STRING COMMENT 'Sequential version identifier for the forecast record.',
    `created_by` STRING COMMENT 'User identifier who created the forecast.',
    CONSTRAINT pk_sales_forecast PRIMARY KEY(`sales_forecast_id`)
) COMMENT 'Transaction record: Sales demand forecast capturing expected unit volume and revenue by product family, customer, end market, geography, and fiscal period. Supports rolling 12-month and 18-month forecast horizons used in semiconductor S&OP and wafer-start authorization processes. Tracks forecast version (commit, upside, best-case), submission date, confidence level, and variance against actuals. Integrates with SAP APO/IBP demand planning. Enables forecast accuracy KPI tracking (MAPE, bias) critical for fab capacity planning decisions.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`booking` (
    `booking_id` BIGINT COMMENT 'System-generated unique identifier for the booking record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the booking.',
    `address_id` BIGINT COMMENT 'Identifier of the destination location for shipment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting allocates each sales booking to a finance cost center to track expenses and calculate profitability.',
    `customer_contract_id` BIGINT COMMENT 'Reference to the governing sales contract or NRE agreement.',
    `die_bank_id` BIGINT COMMENT 'Foreign key linking to inventory.die_bank. Business justification: Bookings for KGD (Known Good Die) sales directly reference die bank inventory. Semiconductor customers often purchase bare die for multi-chip modules or hybrid assemblies. Die bank allocation at booki',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Bookings must capture ECCN classification at order entry to trigger export compliance screening, determine license requirements, and calculate compliance costs before order acceptance in semiconductor',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Required for export‑control compliance; each shipment (booking) must be tied to the export license covering the commodities and destination.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Bookings are fulfilled using a defined process flow; the link drives production scheduling and yield tracking.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Booking must reference the exact IC catalog entry to drive manufacturing and compliance checks.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Booking of customer orders triggers allocation of a wafer lot; linking booking to the wafer lot enables production scheduling and traceability.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Bookings must be assigned to legal entities for revenue recognition, statutory accounting, tax reporting, and intercompany reconciliation in multi-entity semiconductor operations.',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Bookings represent the commercial commitment arising from won opportunities. Essential for opportunity-to-revenue traceability.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit‑and‑loss reporting ties booking revenue to a profit center for accurate profit analysis.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Semiconductor bookings require a valid process qualification before delivery commitment. Revenue recognition and customer delivery SLAs depend on confirming the process_qualification is approved. Sale',
    `restricted_party_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.restricted_party_screening. Business justification: Every booking requires restricted party screening against denied parties lists (BIS, OFAC, etc.) before order acceptance to prevent illegal exports and ensure trade compliance in semiconductor sales.',
    `sales_design_win_id` BIGINT COMMENT 'FK to sales.design_win.design_win_id — In semiconductor sales, bookings trace to the design-win that generated the demand. Critical for design-win revenue attribution.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Bookings capture orderable SKU with exact packaging, speed, temperature grade for revenue recognition and fulfillment. Order-to-cash flow requires SKU-level booking detail for shipment planning and in',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_contract. Business justification: Bookings reference the supply contract governing pricing, terms, and delivery for the ordered SKU. Required for revenue recognition, contract compliance, and ensuring booked orders align with supply c',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Bookings specify the supplier (OSAT, foundry) fulfilling the order for traceability, logistics coordination, and shipment tracking. Essential for order fulfillment and supply chain execution in semico',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Production bookings are linked to a tapeout to schedule wafer fabrication and track yield.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Bookings are tied to a sales territory; FK enables consistent territory hierarchy and reporting.',
    `backlog_flag` BOOLEAN COMMENT 'True if the booking is currently in backlog (unfulfilled).',
    `booked_quantity` BIGINT COMMENT 'Number of units (dies) committed in the booking.',
    `booked_revenue_gross` DECIMAL(18,2) COMMENT 'Total revenue amount before discounts and taxes, in the booking currency.',
    `booked_revenue_net` DECIMAL(18,2) COMMENT 'Revenue after discounts and before tax.',
    `booking_number` STRING COMMENT 'External business number assigned to the booking, used in sales and finance processes.',
    `booking_source` STRING COMMENT 'Origin system that created the booking record.. Valid values are `salesforce|sap|manual`',
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
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the net revenue.',
    `total_tax_code` STRING COMMENT 'Tax code used for calculating tax_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the booking record.',
    `warranty_period_months` STRING COMMENT 'Warranty duration provided to the customer, in months.',
    CONSTRAINT pk_booking PRIMARY KEY(`booking_id`)
) COMMENT 'Transaction record: Confirmed sales booking representing a firm customer purchase order commitment for semiconductor devices. Captures booking date, booked revenue, booked units, device part number, customer account, ship-to location, requested delivery date, backlog status, and SAP SD sales order reference. Represents the commercial booking event — distinct from shipment or invoice. SSOT for bookings-to-billings (B2B) ratio, book-to-ship analysis, and revenue waterfall reporting critical to semiconductor quarterly earnings.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`lead` (
    `lead_id` BIGINT COMMENT 'Unique identifier for the lead record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer account associated with the lead.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the lead.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Leads originate from specific contacts at target accounts. Tracking the originating contact enables lead source analysis, contact scoring, campaign attribution, and conversion tracking. The contact_na',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Leads for controlled technology products need ECCN classification to assess export feasibility, qualify opportunities early, and route ITAR-flagged leads to authorized sales teams in semiconductor bus',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.product_family. Business justification: Lead qualification and routing depend on the product family of interest.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Leads express interest in specific IC catalog products for technical evaluation. Lead qualification tracks which specific parts are being evaluated for design-in, enabling targeted technical support a',
    `opportunity_id` BIGINT COMMENT 'FK to sales.opportunity.opportunity_id — Leads convert to opportunities upon qualification. This FK enables lead-to-opportunity conversion funnel analysis.',
    `process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: Leads are qualified against a target technology node; the link supports early feasibility analysis.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Leads for custom silicon or high-volume production capture preferred supplier information for feasibility assessment. Critical for lead qualification, technical feasibility evaluation, and early suppl',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Leads are assigned to a sales territory; FK provides proper linkage to territory hierarchy.',
    `city` STRING COMMENT 'City of the leads organization address.',
    `company_industry` STRING COMMENT 'Industry classification of the leads organization.',
    `company_name` STRING COMMENT 'Name of the organization associated with the lead.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the lead is subject to any regulatory compliance considerations (e.g., ITAR).',
    `conversion_date` DATE COMMENT 'Date when the lead was converted to an opportunity or closed.',
    `conversion_outcome` STRING COMMENT 'Result of the lead conversion attempt.. Valid values are `won|lost|no_decision`',
    `country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the leads organization.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the lead was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated revenue.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `data_classification` STRING COMMENT 'Classification level of the lead data as per corporate policy.. Valid values are `restricted|confidential|internal|public`',
    `device_interest` STRING COMMENT 'Specific type of semiconductor device the lead is interested in (e.g., ASIC, FPGA, SoC).',
    `estimated_quantity` BIGINT COMMENT 'Projected number of units the lead may purchase.',
    `estimated_revenue` DECIMAL(18,2) COMMENT 'Projected monetary value of the lead opportunity.',
    `expected_close_date` DATE COMMENT 'Projected date by which the lead is expected to be closed.',
    `is_nre` BOOLEAN COMMENT 'Flag indicating if the lead is for a Non‑Recurring Engineering (NRE) project.',
    `itar_required` BOOLEAN COMMENT 'Flag indicating whether the lead involves technology subject to ITAR regulations.',
    `last_modified_by` STRING COMMENT 'User identifier who last updated the lead record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the lead record.',
    `lead_number` STRING COMMENT 'External reference number for the lead as used in sales systems.',
    `lead_source` STRING COMMENT 'Origin channel through which the lead was captured.. Valid values are `web|email|event|referral|partner|campaign`',
    `lead_status` STRING COMMENT 'Current lifecycle status of the lead within the sales pipeline.. Valid values are `new|qualified|disqualified|converted|closed`',
    `lead_type` STRING COMMENT 'Classification of the lead based on sales process stage.. Valid values are `design_win|design_in|pre_sales|post_sales`',
    `market_segment` STRING COMMENT 'Target market segment for the lead (e.g., Consumer, Automotive, Data Center).',
    `notes` STRING COMMENT 'Free‑text field for additional comments or observations about the lead.',
    `priority` STRING COMMENT 'Priority level assigned to the lead for follow‑up.. Valid values are `high|medium|low`',
    `rating` STRING COMMENT 'Qualitative rating of the leads potential.. Valid values are `A|B|C|D|E`',
    `region` STRING COMMENT 'Broad geographic region of the lead (e.g., APAC, EMEA, AMER).. Valid values are `APAC|EMEA|AMER`',
    `score` STRING COMMENT 'Numerical score representing lead quality based on qualification criteria.',
    `source_system` STRING COMMENT 'System of record where the lead originated (e.g., Salesforce, web portal).',
    `target_application` STRING COMMENT 'Intended application area for the semiconductor product (e.g., mobile, automotive, AI).',
    `technology_node` STRING COMMENT 'Process technology node of interest (e.g., 7nm, 5nm).',
    `zip_code` STRING COMMENT 'Postal code of the leads organization address.',
    `created_by` STRING COMMENT 'User identifier who created the lead record.',
    CONSTRAINT pk_lead PRIMARY KEY(`lead_id`)
) COMMENT 'Transaction record: Early-stage sales lead representing an unqualified potential customer or design opportunity. Captures lead source, contact information, target application, device interest, estimated opportunity size, lead status, and conversion outcome. Sourced from Salesforce CRM Lead object. Tracks lead-to-opportunity conversion funnel for semiconductor design-in campaigns.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`channel_partner` (
    `channel_partner_id` BIGINT COMMENT 'System-generated unique identifier for the channel partner record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Partner‑related operational costs are tracked in a dedicated finance cost center for cost allocation.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Channel partners transact with specific legal entities for invoicing, payment processing, VAT/GST compliance, and intercompany settlement in multi-country distribution networks.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Distribution agreements require linking each channel partner to its upstream supplier(s) for inventory allocation and contractual compliance.',
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

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` (
    `sales_design_registration_id` BIGINT COMMENT 'Unique system-generated identifier for each design registration transaction.',
    `design_ip_core_id` BIGINT COMMENT 'Foreign key linking to design.design_ip_core. Business justification: Channel design registrations often specify which IP cores are being designed into customer applications for price protection and commission tracking. Critical for semiconductor distribution channel ma',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Design registrations need ECCN classification to determine export eligibility for protected pricing programs, ensure registered designs comply with license restrictions, and track controlled technolog',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Design registrations specify target node for channel partner tracking and price protection. Registration approval checks node availability and capacity. Essential for channel conflict resolution and d',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Design registrations protect specific product families in channel conflicts. Channel conflict resolution and price protection claims require family-level registration tracking for distributor and rep ',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Design registration must reference the process flow to validate compliance and protect pricing.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Design registrations specify exact IC catalog part numbers being designed into end customers product. Registration systems track specific part numbers for price protection, commission allocation, and',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer organization linked to the registration.',
    `channel_partner_id` BIGINT COMMENT 'Unique identifier of the distributor or channel partner.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the underlying IC design or IP core.',
    `sales_channel_partner_id` BIGINT COMMENT 'Identifier of the sales representative firm (partner) that is credited.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Design registrations specify the supplier (OSAT, foundry) for the registered design to prevent channel conflict and ensure supply chain coordination. Essential for design registration validation and p',
    `approval_comments` STRING COMMENT 'Additional remarks or justification provided by the approver.',
    `approval_date` DATE COMMENT 'Date the registration claim received approval.',
    `approved_by` STRING COMMENT 'Name of the internal stakeholder who approved the registration.',
    `audit_trail` STRING COMMENT 'JSON‑encoded history of status changes and key field modifications for compliance.',
    `claim_number` STRING COMMENT 'Unique internal identifier for the design‑win claim.',
    `compliance_iso9001` BOOLEAN COMMENT 'True if the registration adheres to ISO 9001 quality standards.',
    `compliance_itar` BOOLEAN COMMENT 'True if the registration is governed by International Traffic in Arms Regulations.',
    `compliance_rohs` BOOLEAN COMMENT 'True if the device meets Restriction of Hazardous Substances directives.',
    `country_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 code representing the customers country.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the registration record was initially entered.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the protected price.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount off the list price that is part of the protected pricing terms.',
    `effective_end_date` DATE COMMENT 'End date of the protected pricing period; null if indefinite.',
    `effective_start_date` DATE COMMENT 'Start date of the protected pricing period.',
    `end_application` STRING COMMENT 'Description of the final application or market for the registered design.',
    `estimated_annual_volume` STRING COMMENT 'Projected number of units the customer will purchase per year.',
    `expiration_reason` STRING COMMENT 'Explanation for why the registration entered the expired state.',
    `is_channel_conflict` BOOLEAN COMMENT 'True if the registration was flagged for potential double‑claiming.',
    `is_price_protected` BOOLEAN COMMENT 'True if the registration includes protected pricing terms.',
    `last_modified_by` STRING COMMENT 'System user ID of the most recent editor of the registration.',
    `notes` STRING COMMENT 'Supplementary comments or observations related to the registration.',
    `package_type` STRING COMMENT 'Physical packaging style of the registered device.',
    `protected_price_usd` DECIMAL(18,2) COMMENT 'Unit price that is protected for the duration of the registration, expressed in US dollars.',
    `region` STRING COMMENT 'Broad geographic region for the registration claim.. Valid values are `NAM|EMEA|APAC|LATAM|AFR|CAN`',
    `registration_number` STRING COMMENT 'Business identifier assigned to the design registration claim.',
    `registration_type` STRING COMMENT 'Category indicating the purpose of the registration such as design win claim or price protection.. Valid values are `design_win|price_protection|other`',
    `sales_design_registration_status` STRING COMMENT 'Lifecycle status of the registration claim.. Valid values are `pending|approved|rejected|expired`',
    `sales_rep_firm_name` STRING COMMENT 'Legal name of the sales rep firm.',
    `submission_date` DATE COMMENT 'Date the design registration was initially submitted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the registration record.',
    `wafer_size_mm` STRING COMMENT 'Diameter of the wafer used for the design, expressed in millimetres.',
    CONSTRAINT pk_sales_design_registration PRIMARY KEY(`sales_design_registration_id`)
) COMMENT 'Transaction record: Formal design registration submitted by a distributor or rep firm to claim sales credit and price protection for a specific customer design opportunity. Captures registered device, customer, end application, estimated annual volume, registration status (pending, approved, rejected, expired), approval date, and protected pricing terms. Prevents channel conflict and double-claiming in semiconductor distribution channels.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Semiconductor marketing campaigns target specific customer segments (automotive, industrial, consumer, IoT, AI). Segment targeting drives campaign design, content strategy, budget allocation, and ROI ',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total spend recorded against the campaign to date.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the user who approved the campaign budget and plan.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget allocated for the campaign.',
    `campaign_code` STRING COMMENT 'External or legacy code used to reference the campaign in marketing systems.',
    `campaign_description` STRING COMMENT 'Detailed free‑text description of the campaign objectives and scope.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the marketing campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign.',
    `campaign_type` STRING COMMENT 'Category of the campaign indicating its primary purpose.',
    `channel` STRING COMMENT 'Primary marketing channel used to deliver the campaign.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the campaign complies with internal and external regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `end_date` DATE COMMENT 'Planned or actual end date of the campaign.',
    `external_campaign_code` STRING COMMENT 'Identifier of the campaign in an external marketing platform (e.g., Salesforce, Marketo).',
    `kpi_actual` STRING COMMENT 'Actual measured value for the primary KPI of the campaign.',
    `kpi_target` STRING COMMENT 'Target value for the primary KPI of the campaign (e.g., leads, pipeline value).',
    `marketing_platform` STRING COMMENT 'Marketing automation platform used to execute the campaign.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by campaign managers.',
    `objective` STRING COMMENT 'High‑level business objective the campaign aims to achieve (e.g., lead generation, brand awareness).',
    `priority` STRING COMMENT 'Business priority level assigned to the campaign.',
    `region` STRING COMMENT 'Primary geographic region for campaign execution.',
    `risk_level` STRING COMMENT 'Assessed risk level for the campaign execution.',
    `roi_estimate` DECIMAL(18,2) COMMENT 'Projected return on investment for the campaign, expressed as a percentage.',
    `start_date` DATE COMMENT 'Planned or actual start date of the campaign.',
    `target_product_family` STRING COMMENT 'Product family or portfolio the campaign promotes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master reference table for campaign. Referenced by campaign_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `semiconductors_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `semiconductors_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_list_id` FOREIGN KEY (`price_list_id`) REFERENCES `semiconductors_ecm`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `semiconductors_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ADD CONSTRAINT `fk_sales_quote_line_tertiary_quote_id` FOREIGN KEY (`tertiary_quote_id`) REFERENCES `semiconductors_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_quote_id` FOREIGN KEY (`quote_id`) REFERENCES `semiconductors_ecm`.`sales`.`quote`(`quote_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ADD CONSTRAINT `fk_sales_sales_design_win_sales_nre_agreement_id` FOREIGN KEY (`sales_nre_agreement_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_nre_agreement`(`sales_nre_agreement_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ADD CONSTRAINT `fk_sales_sales_nre_agreement_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ADD CONSTRAINT `fk_sales_price_list_superseded_by_price_list_id` FOREIGN KEY (`superseded_by_price_list_id`) REFERENCES `semiconductors_ecm`.`sales`.`price_list`(`price_list_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ADD CONSTRAINT `fk_sales_customer_contract_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_parent_territory_id` FOREIGN KEY (`parent_territory_id`) REFERENCES `semiconductors_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ADD CONSTRAINT `fk_sales_sales_forecast_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `semiconductors_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_customer_contract_id` FOREIGN KEY (`customer_contract_id`) REFERENCES `semiconductors_ecm`.`sales`.`customer_contract`(`customer_contract_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_sales_design_win_id` FOREIGN KEY (`sales_design_win_id`) REFERENCES `semiconductors_ecm`.`sales`.`sales_design_win`(`sales_design_win_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ADD CONSTRAINT `fk_sales_booking_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `semiconductors_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `semiconductors_ecm`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `semiconductors_ecm`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ADD CONSTRAINT `fk_sales_lead_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `semiconductors_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_channel_partner_id` FOREIGN KEY (`channel_partner_id`) REFERENCES `semiconductors_ecm`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ADD CONSTRAINT `fk_sales_sales_design_registration_sales_channel_partner_id` FOREIGN KEY (`sales_channel_partner_id`) REFERENCES `semiconductors_ecm`.`sales`.`channel_partner`(`channel_partner_id`);
ALTER TABLE `semiconductors_ecm`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `semiconductors_ecm`.`sales`.`campaign`(`campaign_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `semiconductors_ecm`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Territory Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `competitive_landscape` SET TAGS ('dbx_business_glossary_term' = 'Competitive Landscape Description');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|terminated');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'nre|license|royalty|subscription');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `end_market` SET TAGS ('dbx_value_regex' = 'automotive|mobile|ai|iot|computing|telecom');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Discount Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Gross Revenue Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `expected_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Net Revenue Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Non‑Recurring Engineering (NRE) Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'fixed|tiered|volume|subscription');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'americas|emea|apac');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|partner');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospecting|design_in|design_win|production_ramp|won|lost');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `stage_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Change Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|chips|dies|wafers');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `win_loss_date` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`opportunity` ALTER COLUMN `win_loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Reason');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Discount Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Quote Conversion Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Quote Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepay|cash');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `quote_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `quote_description` SET TAGS ('dbx_business_glossary_term' = 'Quote Description');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|expired|converted');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `reason_lost` SET TAGS ('dbx_business_glossary_term' = 'Reason for Quote Loss');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Country Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Quote Tax Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Quote Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Quote Expiration Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `volume_tier` SET TAGS ('dbx_value_regex' = '1-99|100-999|1000-9999|10000+');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Win/Loss Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `win_loss_status` SET TAGS ('dbx_value_regex' = 'won|lost|open');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Core Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `customer_requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Requested Delivery Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Expiration Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `internal_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `is_custom` SET TAGS ('dbx_business_glossary_term' = 'Custom Product Indicator');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Lock Indicator');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `line_comment` SET TAGS ('dbx_business_glossary_term' = 'Line Comment');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Price');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5|tier6');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_line_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `quote_line_status` SET TAGS ('dbx_value_regex' = 'draft|sent|accepted|rejected|expired');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|online|partner|reseller|OEM');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER|APJ|LATAM|CHINA');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Line Total Price');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`quote_line` ALTER COLUMN `warranty_years` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Years)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `sales_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Design Win ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `finished_good_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Winning Device ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'NRE Agreement ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `competitor_displacement_score` SET TAGS ('dbx_business_glossary_term' = 'Competitor Displacement Score (DISP_SCORE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation (REG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LEVEL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `design_win_number` SET TAGS ('dbx_business_glossary_term' = 'Design Win Number (DWN)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `displaced_competitor_code` SET TAGS ('dbx_business_glossary_term' = 'Displaced Competitor ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `displaced_device_code` SET TAGS ('dbx_business_glossary_term' = 'Displaced Device ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `displaced_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `displaced_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `displacement_reason` SET TAGS ('dbx_business_glossary_term' = 'Displacement Reason (DISP_REASON)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `displacement_reason` SET TAGS ('dbx_value_regex' = 'price|performance|power|integration|availability|other');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_gross` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Gross Revenue (EAGR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_gross` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_net` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Net Revenue (EANR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_revenue_net` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `estimated_annual_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Unit Volume (AUV)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `export_controlled` SET TAGS ('dbx_business_glossary_term' = 'Export Controlled Flag (EXPORT_CTRL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `forecast_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy (FCST_ACC)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `forecasted_ramp_rate_per_month` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Ramp Rate Per Month');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `is_key_account` SET TAGS ('dbx_business_glossary_term' = 'Key Account Flag (KEY_ACCOUNT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (SEGMENT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'consumer|automotive|industrial|communications|data_center|other');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Design Win Notes (NOTES)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model (PRICING_MODEL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'list|custom|volume|subscription');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region (REGION)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|NAM|LATAM');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `revenue_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Revenue Adjustment (REV_ADJ)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `revenue_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `revenue_adjustment` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `revenue_ramp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ramp End Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `revenue_ramp_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ramp Start Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `sales_design_win_status` SET TAGS ('dbx_business_glossary_term' = 'Design Win Status (DWS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `sales_design_win_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|closed|cancelled');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `sales_territory` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory (TERRITORY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (APP)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `win_source` SET TAGS ('dbx_business_glossary_term' = 'Design Win Source (WIN_SOURCE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `win_source` SET TAGS ('dbx_value_regex' = 'salesforce|sap|manual|partner');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_win` ALTER COLUMN `win_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Design Win Timestamp (DWT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Recurring Engineering (NRE) Agreement ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `actual_revenue_recognized` SET TAGS ('dbx_business_glossary_term' = 'Actual Recognized Revenue');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `actual_revenue_recognized` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'custom|standard|partner|internal');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `change_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `completed_milestones` SET TAGS ('dbx_business_glossary_term' = 'Completed Milestones');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Contract Reference');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `deliverable_type` SET TAGS ('dbx_value_regex' = 'RTL|GDS|PDK|Tapeout|Documentation');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `forecasted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Revenue');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `forecasted_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `invoice_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Trigger Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_business_glossary_term' = 'IP Ownership Clause');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `last_milestone_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Completed Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Actual Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Planned Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `nre_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total NRE Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `nre_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|upon_delivery|milestone');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_nre_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_nre_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER|LATAM|JAPAC');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `total_milestones` SET TAGS ('dbx_business_glossary_term' = 'Total Milestones');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_nre_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `superseded_by_price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price List ID (SBPLID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (AA)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (AR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (ATYP)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|incentive|markdown|none');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (AT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (ATRL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market (EM)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Price List (IDPL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_description` SET TAGS ('dbx_business_glossary_term' = 'Price List Description (PLD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_name` SET TAGS ('dbx_business_glossary_term' = 'Price List Name (PLN)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_business_glossary_term' = 'Price List Status (PLS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `price_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type (PT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'list|distributor|oem|spot');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `pricing_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Code (PCC)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (GR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TC)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `validity_end` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VED)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `validity_start` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VSD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Price List Version (PLV)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `volume_tier_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Tier (VTX)');
ALTER TABLE `semiconductors_ecm`.`sales`.`price_list` ALTER COLUMN `volume_tier_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Tier (VTM)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` SET TAGS ('dbx_subdomain' = 'commercial_agreements');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Identifier (CCI)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (ACNT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `annual_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value (ACV)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause Flag (ACF)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag (ARF)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag (CCF)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Title (CT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type (CTYP)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'supply|service|license|nre');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value (TCV)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (CR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'AAA|AA|A|BBB|BB|B');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CUR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description (DESC)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status (CLS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `customer_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|draft|pending');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (DR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `eol_clause` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Clause (EOL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Frequency (INV_FREQ)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date (LAD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `ltb_provision` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy Provision (LTB)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAXQ)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_T)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|prepaid|upon_delivery');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `pcn_obligation` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification Obligation (PCN)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `pricing_terms` SET TAGS ('dbx_business_glossary_term' = 'Pricing Terms (PT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RO)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SR)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_business_glossary_term' = 'Supply Scope (SS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `supply_scope` SET TAGS ('dbx_value_regex' = 'exclusive|multi_source|global');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days) (TNP_D)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UP)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`customer_contract` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment (VC)');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` SET TAGS ('dbx_subdomain' = 'revenue_planning');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `parent_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `channel_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Tier');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `channel_tier` SET TAGS ('dbx_value_regex' = 'direct|distribution|partner');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective End Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Territory Hierarchy Path');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `is_overlay` SET TAGS ('dbx_business_glossary_term' = 'Overlay Territory Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `multi_rep_coverage` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Representative Coverage Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Territory Notes');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|product|strategic|customer');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `unit_target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Target Quantity');
ALTER TABLE `semiconductors_ecm`.`sales`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` SET TAGS ('dbx_subdomain' = 'revenue_planning');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `sales_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Territory Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `bias` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `effective_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective End Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `effective_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_business_glossary_term' = 'End Market');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `end_market` SET TAGS ('dbx_value_regex' = 'Automotive|Mobile|DataCenter|Consumer|Industrial|Aerospace');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^FYd{4}Q[1-4]$');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'demand|supply|capacity');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'commit|upside|best_case');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography (Country Code)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Months)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Forecast Locked Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `last_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewer');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_value_regex' = 'Base|Optimistic|Pessimistic|Seasonal|NewProduct|Exit');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_APO|SAP_IBP|Manual');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|pcs|die|wafer');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `variance_to_actual` SET TAGS ('dbx_business_glossary_term' = 'Variance to Actual (%)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_forecast` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` SET TAGS ('dbx_subdomain' = 'revenue_planning');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Identifier (BKID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship‑to Location Identifier (SHIP_LOC_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `die_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Die Bank Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `restricted_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Party Screening Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Territory Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `backlog_flag` SET TAGS ('dbx_business_glossary_term' = 'Backlog Indicator (IS_BACKLOG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Booked Quantity (BK_QTY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booked_revenue_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Booked Revenue (BK_REVENUE_GROSS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booked_revenue_net` SET TAGS ('dbx_business_glossary_term' = 'Net Booked Revenue (BK_REVENUE_NET)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Number (BKNO)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booking_source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source System (BK_SOURCE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booking_source` SET TAGS ('dbx_value_regex' = 'salesforce|sap|manual');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status (BK_STATUS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|fulfilled|cancelled|backlog');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Event Timestamp (BK_TS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Booking Comments (BK_COMMENTS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode (DELIVERY_MODE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'air|sea|ground|pickup');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `external_order_ref` SET TAGS ('dbx_business_glossary_term' = 'External Order Reference (EXT_ORDER_REF)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `forecast_flag` SET TAGS ('dbx_business_glossary_term' = 'Forecast Inclusion Flag (IN_FORECAST)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Booking Indicator (IS_CRITICAL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type (ORDER_TYPE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|nre|design_win|service|maintenance');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model (PRICING_MODEL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'list|contract|discounted|custom');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Booking Priority Level (PRIORITY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PFAM)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLAG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DELIV_DATE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date (REV_RECOG_DATE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (SALES_REGION)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship‑to Country Code (SHIP_COUNTRY_CD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `total_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`booking` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months) (WARRANTY_MTHS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead ID');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID (ACCOUNT_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID (CAMPAIGN_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Territory Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `company_industry` SET TAGS ('dbx_business_glossary_term' = 'Company Industry (COMPANY_INDUSTRY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name (COMPANY_NAME)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date (CONVERSION_DATE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_business_glossary_term' = 'Conversion Outcome (CONVERSION_OUTCOME)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_value_regex' = 'won|lost|no_decision');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Creation Timestamp (LEAD_CREATED_TS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification (DATA_CLASSIFICATION)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `device_interest` SET TAGS ('dbx_business_glossary_term' = 'Device Interest (DEVICE_INTEREST)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `estimated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity (EST_QTY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue (EST_REVENUE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `estimated_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date (EXPECTED_CLOSE_DATE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `is_nre` SET TAGS ('dbx_business_glossary_term' = 'Is NRE Lead (IS_NRE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `itar_required` SET TAGS ('dbx_business_glossary_term' = 'ITAR Required (ITAR_REQUIRED)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LAST_MODIFIED_BY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lead Last Modified Timestamp (LEAD_MODIFIED_TS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_number` SET TAGS ('dbx_business_glossary_term' = 'Lead Number (LEAD_NO)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source (LEAD_SRC)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_source` SET TAGS ('dbx_value_regex' = 'web|email|event|referral|partner|campaign');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status (LEAD_STATUS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_value_regex' = 'new|qualified|disqualified|converted|closed');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Type (LEAD_TYPE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_value_regex' = 'design_win|design_in|pre_sales|post_sales');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (MARKET_SEGMENT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lead Notes (LEAD_NOTES)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Lead Priority (LEAD_PRIORITY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Lead Rating (LEAD_RATING)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REGION)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'APAC|EMEA|AMER');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Lead Score (LEAD_SCORE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `target_application` SET TAGS ('dbx_business_glossary_term' = 'Target Application (TARGET_APP)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (TECH_NODE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP_CODE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`lead` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` SET TAGS ('dbx_subdomain' = 'revenue_planning');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `authorized_product_lines` SET TAGS ('dbx_business_glossary_term' = 'Authorized Product Lines');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `channel_partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `contract_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `contract_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Partner Contract Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Contract Status');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|suspended');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 alpha‑3)');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `external_partner_code` SET TAGS ('dbx_business_glossary_term' = 'External Partner Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `hub_consignment_level` SET TAGS ('dbx_business_glossary_term' = 'Consignment Level');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `hub_consignment_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `inventory_reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reporting Obligation Flag');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Notes');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Name');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'distributor|value_added_reseller|system_integrator|rep_firm|online_marketplace');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `price_protection_claims_allowed` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Claims Allowed');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `pricing_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Type');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `pricing_agreement_type` SET TAGS ('dbx_value_regex' = 'fixed|tiered|volume_based|rebate|custom');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `sap_partner_function_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Partner Function Code');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `sell_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Sell‑Through Rate (Percent)');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `stock_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Stock On Hand (Units)');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier Classification');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'authorized|preferred|elite');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`sales`.`channel_partner` ALTER COLUMN `weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `sales_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Design Registration Identifier (SDR_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `design_ip_core_id` SET TAGS ('dbx_business_glossary_term' = 'Design Ip Core Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Identifier (DIST_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Design Identifier (DESIGN_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `sales_channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Firm Identifier (SRF_ID)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments (APPROVAL_CMTS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVER)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (AUDIT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number (CLAIM_NO)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `compliance_iso9001` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Compliance Flag (ISO9001_FLG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `compliance_itar` SET TAGS ('dbx_business_glossary_term' = 'ITAR Compliance Flag (ITAR_FLG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `compliance_rohs` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag (ROHS_FLG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage (DISC_PCT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `end_application` SET TAGS ('dbx_business_glossary_term' = 'End Application (END_APP)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `estimated_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Volume (EST_VOL)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Expiration Reason (EXP_REASON)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `is_channel_conflict` SET TAGS ('dbx_business_glossary_term' = 'Channel Conflict Flag (CHANNEL_CONF_FLG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `is_price_protected` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Flag (PRICE_PROT_FLG)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (MOD_BY)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type (PKG_TYPE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `protected_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Protected Price (USD) (PROT_PRICE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region (REGION)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NAM|EMEA|APAC|LATAM|AFR|CAN');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number (REG_NUM)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type (REG_TYPE)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'design_win|price_protection|other');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `sales_design_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (REG_STATUS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `sales_design_registration_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `sales_rep_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Firm Name (SRF_NAME)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date (SUBMIT_DT)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `semiconductors_ecm`.`sales`.`sales_design_registration` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (MM)');
ALTER TABLE `semiconductors_ecm`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'pipeline_management');
ALTER TABLE `semiconductors_ecm`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `semiconductors_ecm`.`sales`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`sales`.`campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
