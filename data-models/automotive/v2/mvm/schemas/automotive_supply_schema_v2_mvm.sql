-- Schema for Domain: supply | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`supply` COMMENT 'Governs the inbound supply chain from tier-1 and tier-2 suppliers through to plant receiving. Owns supplier master data, RFQ (Request for Quotation) events, PPAP (Production Part Approval Process) records, JIT/JIS delivery schedules, inbound logistics, supplier performance metrics (PPM - Parts Per Million defect rates, OTD - On-Time Delivery), and CKD/SKD kit management for global assembly operations. Integrates with SAP MM and PTC Windchill.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Primary key',
    `jurisdiction_id` BIGINT COMMENT 'FK to jurisdiction',
    `city` STRING COMMENT 'City',
    `supplier_code` STRING COMMENT 'Supplier code',
    `country_code` STRING COMMENT 'Country code',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `duns_number` STRING COMMENT 'DUNS number',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `supplier_name` STRING COMMENT 'Supplier name',
    `onboarding_date` DATE COMMENT 'Onboarding date',
    `quality_rating` STRING COMMENT 'Quality rating',
    `supplier_type` STRING COMMENT 'Supplier type',
    `tier_level` STRING COMMENT 'Tier level',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all tier-1 and tier-2 suppliers in the automotive supply chain. Captures supplier identity, classification (direct/indirect, tier level), IATF 16949 certification status, DUNS number, geographic footprint, commodity codes, preferred currency, payment terms, and supplier lifecycle status (active, probation, disqualified). SSOT for supplier identity within the supply domain; integrates with SAP MM vendor master and PTC Windchill supplier collaboration.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`supplier_plant` (
    `supplier_plant_id` BIGINT COMMENT 'Primary key',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: A supplier plant operates under a specific jurisdictions regulatory framework, determining which homologation, emissions, and safety standards apply to parts produced there. Sourcing and compliance t',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `capacity_units_per_day` STRING COMMENT 'Daily capacity',
    `city` STRING COMMENT 'City',
    `country_code` STRING COMMENT 'Country code',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `iatf_certified` BOOLEAN COMMENT 'IATF 16949 certified',
    `is_active` BOOLEAN COMMENT 'Active flag',
    `plant_code` STRING COMMENT 'Plant code',
    `plant_name` STRING COMMENT 'Plant name',
    CONSTRAINT pk_supplier_plant PRIMARY KEY(`supplier_plant_id`)
) COMMENT 'Represents the specific manufacturing or distribution plant/site of a supplier that ships parts to an OEM assembly plant. Captures plant address, plant code, production capabilities, capacity constraints, dock-to-dock lead time, customs zone, and plant-level quality certifications. Enables JIT/JIS scheduling at the plant-to-plant level and supports CKD/SKD kit origin tracking.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`inbound_part` (
    `inbound_part_id` BIGINT COMMENT 'System-generated unique identifier for the inbound part record.',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Inbound parts are procured to a specific design specification revision level. When engineering releases a new spec revision, supply must identify affected inbound parts for re-sourcing or PPAP re-subm',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: Inbound parts in automotive are sourced via defined logistics lanes (supplier plant → OEM plant). Lane assignment drives freight rate selection, customs routing, and lead time calculation. Supply chai',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Inbound receipt process matches each received part to the engineering part master for quality verification and BOM reconciliation.',
    `product_bom_line_id` BIGINT COMMENT 'Foreign key linking to product.product_bom_line. Business justification: Inbound parts are the supply-side realization of BOM line components. Linking to product_bom_line enables direct traceability from supply receipt to BOM position — critical for PPAP compliance, engine',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory Requirement Mapping report links each inbound part to the regulatory requirement it must satisfy for emissions and safety compliance.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Receiving process matches inbound parts to SKU master to create accurate stock records; essential for inventory posting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Connect inbound part to internal supplier master for analytics',
    `supplier_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_plant. Business justification: A purchased part is manufactured and shipped from a specific supplier plant, not just a supplier entity. inbound_part currently links to supply_supplier (entity level) but lacks plant-level granularit',
    `average_cost` DECIMAL(18,2) COMMENT 'Weighted average purchase cost per unit of the part.',
    `commodity_group` STRING COMMENT 'High‑level classification of the part for procurement and reporting.. Valid values are `engine|transmission|chassis|electrical|interior|exterior`',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO code of the country where the part was manufactured.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inbound part record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the parts cost.. Valid values are `^[A-Z]{3}$`',
    `customs_tariff_code` STRING COMMENT 'HS‑8 tariff classification code used for import duties.. Valid values are `^[0-9]{8}$`',
    `effective_from` DATE COMMENT 'Date from which the part information is considered valid.',
    `effective_until` DATE COMMENT 'Date after which the part information is no longer valid (nullable).',
    `engineering_change_level` STRING COMMENT 'Level of engineering change applied to the part (e.g., A‑E).. Valid values are `A|B|C|D|E`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the part is classified as hazardous under regulatory rules.',
    `height_mm` DECIMAL(18,2) COMMENT 'Physical height of the part in millimetres.',
    `last_received_date` DATE COMMENT 'Date when the part was most recently received at the plant.',
    `last_received_quantity` STRING COMMENT 'Quantity of the part received on the most recent receipt.',
    `lead_time_days` STRING COMMENT 'Planned number of days from order placement to receipt.',
    `length_mm` DECIMAL(18,2) COMMENT 'Physical length of the part in millimetres.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the part within the supply chain.. Valid values are `active|inactive|discontinued|pending`',
    `lot_size` STRING COMMENT 'Standard production batch size for the part.',
    `material_type` STRING COMMENT 'Category indicating whether the part is raw material, sub‑assembly, CKD kit, finished good, or service item.. Valid values are `raw|sub-assembly|ckd_kit|finished|service`',
    `minimum_order_quantity` STRING COMMENT 'Smallest quantity that can be ordered from the supplier.',
    `oem_part_number` STRING COMMENT 'Original Equipment Manufacturer part number used internally for cross‑reference.',
    `part_name` STRING COMMENT 'Human‑readable name or description of the purchased part.',
    `ppap_status` STRING COMMENT 'Current status of the Production Part Approval Process for the part.. Valid values are `approved|rejected|pending|under_review`',
    `price_uom` STRING COMMENT 'Unit of measure used for the price (e.g., each, kilogram).. Valid values are `EA|KG|L|M|SET`',
    `reorder_point_quantity` STRING COMMENT 'Inventory level that triggers a new purchase order.',
    `safety_stock_quantity` STRING COMMENT 'Buffer inventory quantity maintained to protect against supply variability.',
    `supplier_part_number` STRING COMMENT 'Identifier assigned by the external supplier to the part.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for ordering and inventory management.. Valid values are `EA|KG|L|M|SET`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the record.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the part in kilograms.',
    `width_mm` DECIMAL(18,2) COMMENT 'Physical width of the part in millimetres.',
    CONSTRAINT pk_inbound_part PRIMARY KEY(`inbound_part_id`)
) COMMENT 'Master record for every purchased part number sourced from external suppliers. Captures OEM part number, supplier part number cross-reference, commodity group, material type (raw, sub-assembly, CKD kit), unit of measure, PPAP approval status, engineering change level, hazardous material flag, country of origin, and customs tariff code. Bridges SAP MM material master and PTC Windchill parts classification for supply-domain-owned purchased parts.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` (
    `sourcing_nomination_id` BIGINT COMMENT 'System-generated unique identifier for each sourcing nomination record.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Supplier nomination for new programs: sourcing nominations are made within APQP program context before RFQ issuance. Commodity managers nominate suppliers against specific APQP plans to ensure quality',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Sourcing nominations are created for specific vehicle programs defined by a BOM. Linking to bom_header enables program-level sourcing strategy tied to exact BOM revision, model year, and variant — ess',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Sourcing nominations are triggered by engineering changes (new parts, design changes requiring new supplier qualification). Linking nominations to the originating ECO enables engineering change cost i',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: A sourcing nomination formally designates a supplier for a specific purchased part. inbound_part is the supply-domain master record for purchased parts. Adding inbound_part_id normalizes the part refe',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: Sourcing nominations in automotive are issued per vehicle platform/program. Linking to platform enables platform-level commodity sourcing reports, supplier nomination tracking by platform, and program',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Link sourcing nomination to internal supplier master',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Sourcing nominations are created per vehicle program to establish commodity supply strategy. Program-level sourcing decisions (SOR, nominated volumes, JIT/JIS flags) are driven by vehicle program requ',
    `comments` STRING COMMENT 'Additional notes or remarks entered by the buyer or sourcing team.',
    `commodity` STRING COMMENT 'High‑level classification of the part or commodity being nominated (e.g., ENGINE, HVAC, ELECTRICAL).',
    `commodity_index_linked_flag` BOOLEAN COMMENT 'Whether the sourcing nomination pricing is linked to a commodity index.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the nomination record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the target piece price.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `effective_end_date` DATE COMMENT 'Optional date when the nomination expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date from which the nomination becomes effective for planning purposes.',
    `is_jis` BOOLEAN COMMENT 'Indicates whether the nominated part is required under a JIS delivery strategy.',
    `is_jit` BOOLEAN COMMENT 'Indicates whether the nominated part is required under a JIT delivery strategy.',
    `kit_type` STRING COMMENT 'Specifies whether the part is supplied as a Completely Knocked Down (CKD) or Semi‑Knocked Down (SKD) kit, or not a kit.. Valid values are `CKD|SKD|none`',
    `model_year` STRING COMMENT 'Model year for which the part nomination applies.',
    `nominated_volume` DECIMAL(18,2) COMMENT 'Total quantity of the part the supplier is expected to deliver for the program.',
    `nomination_date` TIMESTAMP COMMENT 'Timestamp when the OEM formally recorded the nomination.',
    `nomination_number` STRING COMMENT 'Human‑readable business code assigned to the nomination for tracking and reference.',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the nomination.. Valid values are `nominated|confirmed|withdrawn|rejected`',
    `priority` STRING COMMENT 'Business priority assigned to the nomination for execution planning.. Valid values are `high|medium|low`',
    `region` STRING COMMENT 'Region code indicating the primary supply geography for the nominated part.. Valid values are `NAM|EME|APAC|LATAM|AFR`',
    `risk_rating` STRING COMMENT 'Qualitative assessment of supply risk for the nominated part.. Valid values are `low|medium|high`',
    `sor_reference` STRING COMMENT 'Reference code linking to the SOR document that defines functional and performance requirements.',
    `target_piece_price` DECIMAL(18,2) COMMENT 'Target unit price (per piece) the OEM aims to achieve with the nominated supplier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the nomination record.',
    CONSTRAINT pk_sourcing_nomination PRIMARY KEY(`sourcing_nomination_id`)
) COMMENT 'Records the formal OEM decision to nominate a specific supplier for a given part or commodity within a model year program. Captures nomination date, program/platform code, nominated supplier, awarded annual volume, target piece price, SOR (Statement of Requirements) reference, nomination status (nominated, confirmed, withdrawn), and the responsible commodity buyer. Precedes the RFQ and PPAP process. SSOT for sourcing award decisions; distinct from procurement domains strategic sourcing strategy — this is the operational award record.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`rfq` (
    `rfq_id` BIGINT COMMENT 'System‑generated unique identifier for the RFQ record.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Program sourcing: RFQs for new vehicle programs are issued under APQP plans that define quality requirements suppliers must meet. Sourcing teams reference the APQP plan to set compliance_requirements ',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: RFQs are issued for parts within a specific vehicle program BOM. Linking rfq to bom_header enables BOM-level cost rollup and sourcing cost analysis per program. program_model_year is a denormalized re',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering change orders (ECOs) frequently trigger new or revised RFQs when part specifications change. ECO-to-RFQ traceability is a standard automotive sourcing process requirement for cost impact a',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: RFQs must reference the specific design specification revision suppliers are quoting against. Issuing an RFQ without a spec revision reference is an automotive sourcing process gap — suppliers cannot ',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: An RFQ is issued for a specific purchased part. inbound_part is the supply-domain master for purchased parts, capturing OEM part number, supplier part number, lead time, MOQ, and other supply-specific',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: RFQ generation is driven by engineering part definitions; linking to part_master enables accurate pricing and specification alignment.',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: RFQs in automotive are issued for parts destined for a specific vehicle platform. This FK enables platform-level sourcing spend analysis, RFQ tracking by platform, and supplier selection reports per p',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: RFQs for powertrain-specific parts (battery cells, engine components, e-motors) are issued per powertrain variant. This FK enables powertrain-level sourcing cost analysis, supplier selection for speci',
    `sourcing_nomination_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_nomination. Business justification: In automotive procurement, an RFQ event is typically triggered by and traceable to a sourcing nomination decision. Linking rfq to sourcing_nomination establishes the procurement lifecycle chain: nomin',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Associate RFQ with internal supplier master',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: RFQs are issued for specific vehicle programs; suppliers need full program context (platform, targets, segment) to quote accurately. Program-level RFQ reporting and spend analysis require this link. p',
    `approval_status` STRING COMMENT 'Current status of internal approval workflow.. Valid values are `PENDING|APPROVED|REJECTED`',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether supporting documents are attached to the RFQ.',
    `commodity_code` STRING COMMENT 'Standard industry code classifying the type of material or service requested.',
    `commodity_index_reference` STRING COMMENT 'Reference to commodity price index for material cost escalation.',
    `compliance_requirements` STRING COMMENT 'Regulatory or quality standards the supplier must meet (e.g., IATF 16949, ISO 14001).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ record was first created in the system.',
    `delivery_schedule_type` STRING COMMENT 'Preferred delivery methodology (Just‑In‑Time, Just‑In‑Sequence, or standard).. Valid values are `JIT|JIS|STANDARD`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount the supplier proposes relative to the target price.',
    `eprocurement_portal_code` BIGINT COMMENT 'FK to the e-procurement portal through which this RFQ was issued.',
    `issue_timestamp` TIMESTAMP COMMENT 'Date‑time when the RFQ was issued to suppliers.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the RFQ status.',
    `net_price_amount` DECIMAL(18,2) COMMENT 'Net price after discounts, taxes, and fees.',
    `notes` STRING COMMENT 'Free‑form notes entered by the buyer.',
    `priority` STRING COMMENT 'Business priority assigned to the RFQ.. Valid values are `HIGH|MEDIUM|LOW`',
    `quantity_estimate` BIGINT COMMENT 'Projected annual volume the buyer expects to purchase.',
    `regulatory_approval_required` BOOLEAN COMMENT 'True if the part requires regulatory sign‑off before purchase.',
    `required_delivery_date` DATE COMMENT 'Date by which the part must be delivered to the plant.',
    `response_due_date` DATE COMMENT 'Last date on which suppliers may submit their quotations.',
    `rfq_number` STRING COMMENT 'Business‑visible RFQ number assigned by the sourcing system.',
    `rfq_status` STRING COMMENT 'Current lifecycle state of the RFQ.. Valid values are `draft|open|closed|awarded|cancelled|pending`',
    `rfq_type` STRING COMMENT 'Classification of the RFQ request.. Valid values are `NEW_PART|EXISTING_PART|SERVICE|MATERIAL`',
    `target_price_amount` DECIMAL(18,2) COMMENT 'Maximum price the buyer is willing to pay for the quoted item (gross).',
    `target_price_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the target price.',
    `tooling_description` STRING COMMENT 'Details of the tooling requirements, if any.',
    `tooling_required` BOOLEAN COMMENT 'Indicates whether new tooling is needed for the part.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is expressed.. Valid values are `EA|KG|L|M|SET|BOX`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the RFQ record.',
    `created_by` STRING COMMENT 'User identifier of the employee who created the RFQ.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Transactional record of a Request for Quotation event issued to one or more suppliers for a specific part, assembly, or service. Captures RFQ number, issue date, response due date, commodity, target price, annual volume estimate, program/model year, tooling requirements, and RFQ status (open, closed, awarded, cancelled). Integrates with SAP MM RFQ (ME41) and PTC Windchill supplier collaboration portal.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`rfq_response` (
    `rfq_response_id` BIGINT COMMENT 'System-generated unique identifier for the RFQ response record.',
    `rfq_id` BIGINT COMMENT 'Identifier of the original Request for Quotation to which this response belongs.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Associate RFQ response with internal supplier master',
    `amortization_term_months` STRING COMMENT 'Number of months over which the tooling cost is amortized.',
    `capacity_commitment` DECIMAL(18,2) COMMENT 'Maximum production capacity the supplier commits to deliver per period.',
    `capacity_unit` STRING COMMENT 'Unit for the capacity commitment (e.g., units_per_month).',
    `commodity_surcharge_amount` DECIMAL(18,2) COMMENT 'Commodity surcharge amount included in the quoted price.',
    `compliance_certifications` STRING COMMENT 'List of regulatory or industry certifications attached to the quotation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ response record was first created in the system.',
    `delivery_address` STRING COMMENT 'Physical address where the supplier will deliver the goods.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered on the quoted unit price.',
    `exceptions_to_sor` STRING COMMENT 'Supplier‑provided deviations or exceptions to the original SOR.',
    `freight_included` BOOLEAN COMMENT 'True if freight costs are included in the total price.',
    `is_preferred_supplier` BOOLEAN COMMENT 'Indicates whether the supplier is marked as a preferred source for this part.',
    `lead_time_days` STRING COMMENT 'Number of calendar days the supplier needs to deliver the quoted items after order confirmation.',
    `payment_terms` STRING COMMENT 'Standard payment condition offered by the supplier.. Valid values are `net30|net45|net60`',
    `portal_submission_flag` BOOLEAN COMMENT 'Whether this response was submitted via e-procurement portal.',
    `quoted_currency` STRING COMMENT 'ISO 4217 currency code of the quoted price.',
    `quoted_quantity` DECIMAL(18,2) COMMENT 'Quantity of items the supplier is quoting for.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Price per unit quoted by the supplier.',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory approvals for the quoted part.. Valid values are `pending|approved|rejected`',
    `remarks` STRING COMMENT 'Additional free‑form comments from the supplier.',
    `response_number` STRING COMMENT 'External reference number assigned to the suppliers quotation response.',
    `response_source` STRING COMMENT 'Channel through which the supplier submitted the quotation.. Valid values are `email|portal|api`',
    `rfq_response_status` STRING COMMENT 'Current lifecycle status of the RFQ response.. Valid values are `submitted|under_review|accepted|rejected`',
    `shipping_method` STRING COMMENT 'Mode of transportation for delivering the goods.. Valid values are `air|sea|land`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier submitted the quotation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax component included in the quotation.',
    `tooling_cost` DECIMAL(18,2) COMMENT 'One‑time cost for tooling or molds required to produce the part.',
    `total_price` DECIMAL(18,2) COMMENT 'Total amount for the quoted quantity (unit price multiplied by quantity).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quoted quantity.. Valid values are `EA|KG|L`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the RFQ response record.',
    `validity_end_date` DATE COMMENT 'Last date on which the quoted terms are valid.',
    `validity_start_date` DATE COMMENT 'First date on which the quoted terms are valid.',
    `warranty_period_months` STRING COMMENT 'Length of warranty coverage offered by the supplier.',
    `warranty_type` STRING COMMENT 'Type of warranty provided.. Valid values are `standard|extended`',
    CONSTRAINT pk_rfq_response PRIMARY KEY(`rfq_response_id`)
) COMMENT 'Captures a suppliers formal quotation response to an RFQ. Records quoted unit price, tooling cost, amortization terms, lead time, capacity commitment, exceptions to SOR, validity period, and response status (submitted, under review, accepted, rejected). Supports competitive bid analysis and supplier selection decisions. One RFQ may have multiple responses from competing suppliers.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Dealers order parts and accessories from the OEM supply chain via purchase orders (dealer parts procurement process). Linking supply_purchase_order to dealership enables dealer parts spend reporting, ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Purchase orders are raised by and for a specific manufacturing plant in multi-plant OEM operations. Plant-level procurement reporting, budget control, and goods receipt routing all require knowing whi',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.price_agreement. Business justification: A purchase orders pricing is governed by a formally agreed price agreement. Linking supply_purchase_order to price_agreement enables header-level price compliance validation and commercial traceabili',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: MRP/ERP procurement-to-production linkage: purchase orders are raised to fulfill specific production order material requirements. Multi-plant automotive OEMs (SAP PP-MM integration) require this link ',
    `scheduling_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.scheduling_agreement. Business justification: In automotive JIT/JIS supply chains, purchase orders are frequently issued as call-off releases against a long-term scheduling agreement. Linking supply_purchase_order to scheduling_agreement establis',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `delivery_date` DATE COMMENT 'Expected delivery date',
    `incoterms` STRING COMMENT 'Incoterms',
    `order_date` DATE COMMENT 'Order date',
    `payment_terms` STRING COMMENT 'Payment terms',
    `po_number` STRING COMMENT 'PO number',
    `po_status` STRING COMMENT 'PO status',
    `po_type` STRING COMMENT 'PO type',
    `total_amount` DECIMAL(18,2) COMMENT 'Total PO amount',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Legally binding procurement document issued to a supplier authorizing delivery of parts or materials at agreed price and schedule. Captures PO number, PO type (standard, blanket, scheduling agreement), supplier, plant, delivery terms (Incoterms), payment terms, total value, currency, and PO status (open, partially delivered, closed, cancelled). SSOT for purchase commitments; sourced from SAP MM (ME21N/ME22N).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Primary key',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: A PO line authorizes delivery of a specific purchased part. inbound_part is the supply-domain master for purchased parts. supply_po_line currently carries denormalized part_number and part_description',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.price_agreement. Business justification: A PO lines unit price is governed by a formally agreed price agreement between the OEM and supplier. Linking supply_po_line to price_agreement enables price compliance validation — comparing the PO l',
    `purchase_order_id` BIGINT COMMENT 'FK to PO',
    `scheduling_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.scheduling_agreement. Business justification: In JIT/JIS automotive supply chains, purchase order lines are frequently issued as releases against a long-term scheduling agreement. Linking supply_po_line to scheduling_agreement establishes the con',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `delivery_date` DATE COMMENT 'Delivery date',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'GR quantity',
    `line_number` STRING COMMENT 'Line number',
    `line_status` STRING COMMENT 'Line status',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount',
    `quantity` DECIMAL(18,2) COMMENT 'Order quantity',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line item within a purchase order representing a specific part number, quantity, unit price, delivery date, and plant destination. Captures line number, material number, ordered quantity, confirmed quantity, net price, delivery date, goods receipt quantity, and invoice quantity. Enables line-level tracking of delivery performance and invoice matching (3-way match) in SAP MM.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` (
    `scheduling_agreement_id` BIGINT COMMENT 'System generated unique identifier for the scheduling agreement record.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: New model launch: scheduling agreements for new-program parts are established under APQP plans that define quality targets (target_ppm, target_otd_percent already on scheduling_agreement). Procurement',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Scheduling agreements govern long-term supply of parts for specific vehicle programs. Linking to bom_header enables program-level supply coverage analysis, ensures agreements align with the correct BO',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: Scheduling agreements in automotive define long-term supply contracts including delivery rhythm and logistics parameters. Lane assignment to a scheduling agreement enables freight cost estimation, lea',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Scheduling agreements are created per engineering part to lock volume, price, and delivery cadence with the supplier.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Scheduling agreements in automotive OEM procurement are plant-specific (SAP ME31L). A part approved and priced for one plant is a separate agreement for another. Plant-level SA management is required ',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: Scheduling agreements are negotiated per vehicle platform/program in automotive. This FK supports platform-level supply continuity planning, contract management by program, and production volume commi',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Scheduling agreements for safety-critical or regulated parts carry compliance_approval_status and compliance_document_ref fields, indicating a real dependency on a specific regulatory requirement. Pro',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Link scheduling agreement to internal supplier master',
    `supplier_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_plant. Business justification: A scheduling agreement for JIT/JIS delivery is with a specific supplier plant, not just the supplier entity. The plants capacity (capacity_units_per_day) and IATF certification status (iatf_certified',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Scheduling agreements define delivery volumes and rhythm for a vehicle programs production lifecycle. Program-level supply planning, capacity allocation, and end-of-life management all require linkin',
    `actual_otd_percent` DECIMAL(18,2) COMMENT 'Measured on‑time delivery performance for the agreement period.',
    `actual_ppm` DECIMAL(18,2) COMMENT 'Measured defect rate for parts delivered under the agreement.',
    `agreement_number` STRING COMMENT 'External business identifier assigned to the scheduling agreement (e.g., contract number).',
    `agreement_type` STRING COMMENT 'Classification of the scheduling agreement (e.g., framework, spot, consignment).. Valid values are `framework|spot|consignment|service|lease`',
    `approval_date` DATE COMMENT 'Date on which the agreement received formal approval.',
    `commodity_escalation_clause_flag` BOOLEAN COMMENT 'Whether the scheduling agreement includes a commodity price escalation clause.',
    `compliance_approval_status` STRING COMMENT 'Regulatory or quality compliance status of the agreement.. Valid values are `pending|approved|rejected`',
    `compliance_document_ref` STRING COMMENT 'Reference number of the attached compliance documentation.',
    `contract_scope` STRING COMMENT 'High‑level description of the parts, services, or components covered.',
    `contract_version` STRING COMMENT 'Version identifier for the agreement when amendments are made.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scheduling agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for pricing.. Valid values are `USD|EUR|JPY|CNY|GBP`',
    `delivery_rhythm` STRING COMMENT 'Scheduled frequency of deliveries defined in the agreement.. Valid values are `daily|weekly|biweekly|monthly`',
    `scheduling_agreement_description` STRING COMMENT 'Free‑text description of the purpose, scope and key terms of the agreement.',
    `early_termination_allowed` BOOLEAN COMMENT 'Flag indicating whether the agreement can be terminated before the end date.',
    `end_date` DATE COMMENT 'Date on which the agreement expires or is terminated (nullable for open‑ended contracts).',
    `kanban_flag` BOOLEAN COMMENT 'Indicates whether the agreement uses a Kanban pull system for JIT deliveries.',
    `part_description` STRING COMMENT 'Human‑readable description of the part covered by the agreement.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the supplier.. Valid values are `net30|net45|net60|cash|prepaid`',
    `penalty_clause` STRING COMMENT 'Text describing penalties for missed deliveries or quality breaches.',
    `portal_managed_flag` BOOLEAN COMMENT 'Whether this scheduling agreement is managed via e-procurement portal.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Agreed price for one unit of the supplied part.',
    `release_horizon_weeks` STRING COMMENT 'Number of weeks in advance that delivery forecasts must be submitted.',
    `renewal_notice_period_days` STRING COMMENT 'Notice period required to exercise renewal option.',
    `renewal_option` BOOLEAN COMMENT 'Indicates if the agreement includes an automatic renewal provision.',
    `scheduling_agreement_status` STRING COMMENT 'Current lifecycle status of the scheduling agreement.. Valid values are `draft|active|suspended|terminated|expired`',
    `start_date` DATE COMMENT 'Date on which the agreement becomes binding.',
    `target_otd_percent` DECIMAL(18,2) COMMENT 'Target percentage for on‑time deliveries defined in the agreement.',
    `target_ppm` DECIMAL(18,2) COMMENT 'Maximum allowable defect rate for supplied parts.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required to terminate the agreement early.',
    `total_annual_volume` DECIMAL(18,2) COMMENT 'Planned total quantity of parts to be supplied over the contract year.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the volume (e.g., pieces, kilograms).. Valid values are `pcs|kg|liter|meter|unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the scheduling agreement record.',
    CONSTRAINT pk_scheduling_agreement PRIMARY KEY(`scheduling_agreement_id`)
) COMMENT 'Long-term supply agreement with a supplier defining the framework for JIT/JIS delivery of parts over a model year or contract period. Captures agreement number, validity start/end dates, target annual volume, release horizon (firm/forecast weeks), delivery rhythm (daily, weekly), Kanban flag, and agreement status. The scheduling agreement is the backbone of JIT supply in SAP MM (ME31L/ME32L).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Primary key',
    `mrp_requirement_id` BIGINT COMMENT 'Foreign key linking to inventory.mrp_requirement. Business justification: In automotive JIT/JIS operations, MRP requirements are the demand signals that generate delivery schedule releases. Supply planners reconcile open MRP requirements against scheduled deliveries to iden',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Every delivery schedule targets a specific receiving manufacturing plant. Multi-plant OEM logistics require plant-level delivery tracking for dock scheduling, inbound logistics planning, and plant-lev',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: JIS (Just-In-Sequence) delivery schedules are tied to specific production lines, not just plants. Automotive JIS call-offs specify the exact line and sequence position; this link is essential for line',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: JIT/JIS delivery schedules are triggered by specific production orders. Automotive OEMs require this link to confirm parts arrive in time for the production orders planned start, enabling MRP excepti',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_schedule. Business justification: Production schedules are the upstream trigger for supplier delivery scheduling in JIT automotive supply chains. This link enables supply planners to align delivery windows with frozen production sched',
    `purchase_order_id` BIGINT COMMENT 'FK to PO',
    `scheduling_agreement_id` BIGINT COMMENT 'Foreign key linking to supply.scheduling_agreement. Business justification: supply_delivery_schedule is explicitly described as a JIT/JIS delivery schedule line issued against a scheduling agreement. The scheduling_agreement is the parent framework document; delivery schedule',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: JIT/JIS delivery schedule lines in automotive are fulfilled by specific inbound shipments. Linking enables OTD tracking, schedule adherence reporting, and supplier delivery performance measurement — a',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Automotive JIT delivery schedules specify the exact unloading point and destination storage location (line-side, sequencing area, supermarket). Logistics coordinators use this to pre-assign dock doors',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `actual_delivery_date` DATE COMMENT 'Actual delivery date',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity delivered',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `delivery_status` STRING COMMENT 'Delivery status',
    `schedule_type` STRING COMMENT 'Schedule type',
    `scheduled_date` DATE COMMENT 'Scheduled delivery date',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Scheduled quantity',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'JIT/JIS delivery schedule line issued against a scheduling agreement, specifying exact quantities and delivery dates/times for a part to a plant dock. Captures schedule line date, time, required quantity, cumulative quantity, schedule type (firm, forecast, JIS sequence), dock door, and transmission status (sent, acknowledged, revised). Drives supplier production and logistics planning. Sourced from SAP MM schedule lines (EKET).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` (
    `ppap_submission_id` BIGINT COMMENT 'Primary key',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: AIAG PPAP process: every PPAP submission is executed under a specific APQP plan phase (Phase 4/5). Quality engineers use this link to verify PPAP submissions satisfy APQP gate requirements. Automotive',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: PPAP submissions are required for parts entering production on a specific vehicle program BOM. Linking to bom_header enables program-level PPAP status tracking, regulatory compliance reporting, and la',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: Control plan is one of the 18 mandatory PPAP elements per AIAG standard. PPAP Level 3+ submissions must reference the approved control plan. Supplier quality engineers track which control plan version',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: AIAG PPAP requirements mandate that submissions reference the approved design record/specification revision. Linking PPAP submissions to design_specification enables engineering to verify suppliers ar',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: AIAG PPAP Level 3+ submissions require the supplier to reference the DFMEA/PFMEA record as a mandatory element. Linking supply_ppap_submission to fmea_record enables engineering to verify PPAP package',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: A PPAP submission is the formal approval of a suppliers manufacturing process for a specific purchased part. inbound_part is the supply-domain master for purchased parts, and its ppap_status field di',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: PPAP submissions are tied to a specific vehicle platform/program in automotive. This FK enables platform launch readiness dashboards, regulatory PPAP compliance tracking per program, and supplier qual',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: PPAP approvals are plant-specific in automotive: a part approved for Plant A is NOT automatically approved for Plant B (AIAG PPAP 4th edition). The receiving plant must be recorded on each PPAP submis',
    `regulatory_body_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_body. Business justification: PPAP level 3/4/5 submissions in automotive are mandated by specific regulatory bodies (NHTSA, EU type-approval authorities). Linking PPAP submissions to the governing regulatory body enables complianc',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `supplier_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_plant. Business justification: PPAP (Production Part Approval Process) approves a suppliers manufacturing process at a specific plant. The approval is plant-specific — a supplier may have multiple plants, each requiring separate P',
    `approval_date` DATE COMMENT 'Approval date',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `disposition` STRING COMMENT 'Disposition',
    `reason_for_submission` STRING COMMENT 'Reason for submission',
    `reviewer_name` STRING COMMENT 'Reviewer name',
    `submission_date` DATE COMMENT 'Submission date',
    `submission_level` STRING COMMENT 'PPAP submission level',
    `submission_status` STRING COMMENT 'Submission status',
    CONSTRAINT pk_ppap_submission PRIMARY KEY(`ppap_submission_id`)
) COMMENT 'Production Part Approval Process submission record tracking the formal approval of a suppliers manufacturing process for a specific part. Captures PPAP level (1–5), submission date, part number, supplier, engineering change level, submission reason (new part, engineering change, tooling move), PPAP elements checklist status, PSW (Part Submission Warrant) status, and approval/rejection date. Integrates with PTC Windchill and SAP QM. SSOT for PPAP compliance.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key',
    `goods_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_movement. Business justification: Every supplier goods receipt generates an inventory goods movement posting (e.g., movement type 101 in SAP). Supply chain controllers reconcile goods receipts against inventory postings for GR/IR clea',
    `in_transit_inventory_id` BIGINT COMMENT 'Foreign key linking to logistics.in_transit_inventory. Business justification: When inbound parts are receipted in automotive, the corresponding in-transit inventory record must be closed/resolved. Direct FK from GR to in_transit_inventory supports the inbound logistics closure ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inbound quality process: goods receipt triggers creation of an inspection lot for incoming part inspection. This direct link enables receiving teams to navigate from goods receipt to inspection status',
    `movement_type_id` BIGINT COMMENT 'Foreign key linking to inventory.movement_type. Business justification: Goods receipts must reference a movement type that governs accounting determination, quality inspection triggers, and stock category (unrestricted, quality hold, blocked). Automotive receiving operati',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Goods receipts occur at a specific manufacturing plant (receiving plant). Required for plant-level inventory posting, storage location assignment, and multi-plant inbound logistics reporting. Fundamen',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.supply_po_line. Business justification: A goods receipt confirms physical delivery of parts against a specific PO line item. supply_goods_receipt currently links to supply_purchase_order (header level) but lacks line-level granularity. Addi',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Goods receipts fulfill material requirements for production orders (SAP movement type 101 against production order). This link is required for production order cost settlement, material availability c',
    `purchase_order_id` BIGINT COMMENT 'FK to PO',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Goods receipts are posted to a specific storage location (receiving dock, quality hold area). The existing plain-text storage_location column is a denormalization of inventory.storage_location. Ware',
    `supplier_id` BIGINT COMMENT 'FK to supplier',
    `supplier_plant_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier_plant. Business justification: Goods are physically received FROM a specific supplier plant. supply_goods_receipt currently links to supply_supplier (entity level) but lacks plant-level granularity. Adding supply_supplier_plant_id ',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'Accepted quantity',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `inspection_status` STRING COMMENT 'Inspection status',
    `receipt_date` DATE COMMENT 'Receipt date',
    `receipt_number` STRING COMMENT 'Receipt number',
    `received_quantity` DECIMAL(18,2) COMMENT 'Received quantity',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Rejected quantity',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt and system confirmation of parts delivered by a supplier to an OEM plant. Captures GR document number, posting date, received quantity, accepted quantity, rejected quantity, storage location, batch number, GR type (standard, return, subsequent delivery), and posting status. Triggers inventory update and initiates 3-way invoice matching in SAP MM (MIGO). SSOT for inbound goods confirmation.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` (
    `supplier_scorecard_id` BIGINT COMMENT 'System-generated unique identifier for each supplier scorecard record.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Supplier performance is evaluated per receiving plant in multi-plant OEM operations — a supplier may have excellent OTD at one plant and poor performance at another. Plant-level scorecards are standar',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Connect supplier scorecard to internal supplier master',
    `commodity_price_competitiveness_score` DECIMAL(18,2) COMMENT 'Score measuring supplier commodity price competitiveness vs market indices.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Score measuring adherence to regulatory and internal compliance requirements.',
    `corrective_action_description` STRING COMMENT 'Free‑text description of actions the supplier must take to address deficiencies.',
    `corrective_action_flag` BOOLEAN COMMENT 'True when the supplier must undertake corrective actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the scorecard record was first created in the system.',
    `delivery_quantity_accuracy_pct` DECIMAL(18,2) COMMENT 'Ratio of delivered quantity to ordered quantity, expressed as a percent.',
    `evaluation_date` TIMESTAMP COMMENT 'Exact timestamp when the scorecard was completed.',
    `evaluation_period_end` DATE COMMENT 'Last calendar day of the period covered by the scorecard.',
    `evaluation_period_start` DATE COMMENT 'First calendar day of the period covered by the scorecard.',
    `evaluator_name` STRING COMMENT 'Full name of the internal evaluator responsible for the scorecard.',
    `notes` STRING COMMENT 'Additional comments or observations captured during the evaluation.',
    `otd_percentage` DECIMAL(18,2) COMMENT 'Percentage of deliveries that arrived on or before the agreed delivery date.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated weighted score combining all KPI values for the evaluation period.',
    `performance_tier` STRING COMMENT 'Categorical tier assigned based on the overall score.. Valid values are `preferred|approved|conditional|disqualified`',
    `ppap_on_time_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of PPAP submissions completed within the agreed timeframe.',
    `ppm_defect_rate` DECIMAL(18,2) COMMENT 'Defect rate expressed in parts per million for supplied parts during the period.',
    `quality_ppm` DECIMAL(18,2) COMMENT '',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers responsiveness to inquiries and change requests.',
    `review_status` STRING COMMENT 'Indicates whether the scorecard is still being drafted, has been finalized, or has been reviewed by management.. Valid values are `draft|finalized|reviewed`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk rating derived from financial, operational, and compliance factors.',
    `scorecard_number` STRING COMMENT 'Human‑readable identifier assigned to the scorecard, used for reporting and audit trails.',
    `scorecard_period` STRING COMMENT '',
    `scoring_methodology_version` STRING COMMENT 'Identifier of the scoring model version used for this evaluation.',
    `supplier_scorecard_status` STRING COMMENT 'Current state of the scorecard in its lifecycle.. Valid values are `pending|completed|archived`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers environmental and sustainability initiatives.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the scorecard.',
    CONSTRAINT pk_supplier_scorecard PRIMARY KEY(`supplier_scorecard_id`)
) COMMENT 'Periodic (monthly/quarterly) performance evaluation record for a supplier across key KPIs including PPM (Parts Per Million defect rate), OTD (On-Time Delivery percentage), delivery quantity accuracy, PPAP on-time completion rate, responsiveness score, and overall supplier rating. Captures evaluation period, scoring methodology version, individual KPI values, weighted total score, performance tier (preferred, approved, conditional, disqualified), and corrective action flag.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`supply`.`price_agreement` (
    `price_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the price agreement record.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Price agreements are negotiated per SKU, supporting cost management and contract compliance.',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: A price agreement defines the formally agreed piece price for a specific purchased part. inbound_part is the supply-domain master for purchased parts. price_agreement currently carries a denormalized ',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Price agreements in automotive are negotiated at the engineering part level (drawing number, revision). Direct link to part_master enables cost target vs. actual price reconciliation — a standard comm',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: Supplier price agreements in automotive are negotiated at platform/program level. This FK supports platform-level cost management, should-cost analysis by program, and annual price reduction tracking ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Price agreements carry compliance_approval_status and compliance_document_ref, indicating regulated-part pricing requires approval against a specific regulatory requirement. Linking directly enables c',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: Price agreements are negotiated per part/SKU; linking provides pricing data for inventory valuation and costing.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Associate price agreement with internal supplier master',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Price agreements are scoped to vehicle programs for annual price reduction commitments and program cost-down tracking. A commodity manager reporting program-level material cost performance requires th',
    `actual_otd_percent` DECIMAL(18,2) COMMENT 'Measured on‑time delivery performance of the supplier for the current period.',
    `actual_ppm` DECIMAL(18,2) COMMENT 'Measured defect rate of supplied parts for the current period.',
    `agreement_number` STRING COMMENT 'External business identifier assigned to the price agreement by the OEM.',
    `agreement_type` STRING COMMENT 'Classification of the agreement indicating its primary purpose (e.g., price, cost, service, tooling).. Valid values are `price|cost|service|tooling`',
    `annual_price_reduction_commitment` DECIMAL(18,2) COMMENT 'Percentage reduction in price committed by the supplier each year.',
    `commodity_index_linked_flag` BOOLEAN COMMENT 'Whether the price agreement is linked to a commodity price index.',
    `commodity_index_name` STRING COMMENT 'Name of the commodity index used for price escalation (e.g., LME Aluminum).',
    `compliance_approval_status` STRING COMMENT 'Status of internal compliance review for the agreement.. Valid values are `approved|pending|rejected`',
    `compliance_document_ref` STRING COMMENT 'Reference identifier for the compliance documentation attached to the agreement.',
    `contract_scope` STRING COMMENT 'Narrative defining the parts, volumes, and geographic regions covered by the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the price agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the unit price.. Valid values are `^[A-Z]{3}$`',
    `price_agreement_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and any special conditions of the agreement.',
    `early_termination_allowed` BOOLEAN COMMENT 'Indicates whether the agreement may be terminated before the end date without penalty.',
    `effective_end_date` DATE COMMENT 'Date on which the price agreement expires or is terminated; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the price agreement becomes binding.',
    `escalation_formula` STRING COMMENT 'Formula for commodity-based price escalation/de-escalation.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed for invoices under this price agreement.. Valid values are `net30|net45|net60|net90`',
    `penalty_clause` STRING COMMENT 'Text describing penalties for non‑compliance such as late delivery or quality breaches.',
    `price_adjustment_trigger` STRING COMMENT 'Condition that can trigger a price change during the agreement (material index, foreign exchange, or none).. Valid values are `material_index|foreign_exchange|none`',
    `price_agreement_status` STRING COMMENT 'Current lifecycle status of the price agreement.. Valid values are `active|expired|under_negotiation|draft|suspended`',
    `renewal_notice_period_days` STRING COMMENT 'Number of days notice required to exercise a renewal option.',
    `renewal_option` STRING COMMENT 'Specifies if the agreement auto‑renews, requires manual renewal, or does not renew.. Valid values are `auto|manual|none`',
    `target_otd_percent` DECIMAL(18,2) COMMENT 'Contractual target for supplier on‑time delivery performance.',
    `target_ppm` DECIMAL(18,2) COMMENT 'Maximum acceptable defect rate for supplied parts under the agreement.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required to terminate the agreement early.',
    `tooling_amortization_terms` STRING COMMENT 'Terms describing how tooling costs are amortized over the agreement period.',
    `total_annual_volume` DECIMAL(18,2) COMMENT 'Maximum total quantity of the part that may be purchased under the agreement each year.',
    `unit_of_measure` STRING COMMENT 'Measurement unit used for the agreed price and volume (e.g., piece, kilogram).. Valid values are `piece|kg|liter|meter`',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated price per unit of the part for the agreement period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the price agreement record.',
    `version_number` STRING COMMENT 'Sequential version number of the agreement reflecting amendments.',
    CONSTRAINT pk_price_agreement PRIMARY KEY(`price_agreement_id`)
) COMMENT 'Formally agreed piece price and commercial terms between the OEM and a supplier for a specific part over a defined period. Captures agreement number, part number, supplier, effective date, expiry date, agreed unit price, currency, annual price reduction commitment (APR), tooling amortization terms, price adjustment triggers (material index, FX), and agreement status (active, expired, under negotiation). Distinct from the purchase order — this is the commercial price framework.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_plant` ADD CONSTRAINT `fk_supply_supplier_plant_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ADD CONSTRAINT `fk_supply_inbound_part_supplier_plant_id` FOREIGN KEY (`supplier_plant_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier_plant`(`supplier_plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ADD CONSTRAINT `fk_supply_sourcing_nomination_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_sourcing_nomination_id` FOREIGN KEY (`sourcing_nomination_id`) REFERENCES `vibe_automotive_v1`.`supply`.`sourcing_nomination`(`sourcing_nomination_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ADD CONSTRAINT `fk_supply_rfq_response_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_automotive_v1`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ADD CONSTRAINT `fk_supply_rfq_response_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_automotive_v1`.`supply`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_scheduling_agreement_id` FOREIGN KEY (`scheduling_agreement_id`) REFERENCES `vibe_automotive_v1`.`supply`.`scheduling_agreement`(`scheduling_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `vibe_automotive_v1`.`supply`.`price_agreement`(`price_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_automotive_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_scheduling_agreement_id` FOREIGN KEY (`scheduling_agreement_id`) REFERENCES `vibe_automotive_v1`.`supply`.`scheduling_agreement`(`scheduling_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ADD CONSTRAINT `fk_supply_scheduling_agreement_supplier_plant_id` FOREIGN KEY (`supplier_plant_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier_plant`(`supplier_plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_automotive_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_scheduling_agreement_id` FOREIGN KEY (`scheduling_agreement_id`) REFERENCES `vibe_automotive_v1`.`supply`.`scheduling_agreement`(`scheduling_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ADD CONSTRAINT `fk_supply_ppap_submission_supplier_plant_id` FOREIGN KEY (`supplier_plant_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier_plant`(`supplier_plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_automotive_v1`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_automotive_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_plant_id` FOREIGN KEY (`supplier_plant_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier_plant`(`supplier_plant_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ADD CONSTRAINT `fk_supply_supplier_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_inbound_part_id` FOREIGN KEY (`inbound_part_id`) REFERENCES `vibe_automotive_v1`.`supply`.`inbound_part`(`inbound_part_id`);
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ADD CONSTRAINT `fk_supply_price_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_automotive_v1`.`supply`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_plant` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_plant` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `product_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `supplier_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `average_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Cost');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `commodity_group` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `commodity_group` SET TAGS ('dbx_value_regex' = 'engine|transmission|chassis|electrical|interior|exterior');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO‑3)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO‑4217)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Tariff Code');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `engineering_change_level` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Level');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `engineering_change_level` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `height_mm` SET TAGS ('dbx_business_glossary_term' = 'Height (mm)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `last_received_date` SET TAGS ('dbx_business_glossary_term' = 'Last Received Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `last_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Last Received Quantity');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `length_mm` SET TAGS ('dbx_business_glossary_term' = 'Length (mm)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw|sub-assembly|ckd_kit|finished|service');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `oem_part_number` SET TAGS ('dbx_business_glossary_term' = 'OEM Part Number (OPN)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Part Name');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `ppap_status` SET TAGS ('dbx_business_glossary_term' = 'PPAP Approval Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `ppap_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|under_review');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `price_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|SET');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number (SPN)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|SET');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`inbound_part` ALTER COLUMN `width_mm` SET TAGS ('dbx_business_glossary_term' = 'Width (mm)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` SET TAGS ('dbx_subdomain' = 'sourcing_procurement');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `sourcing_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Nomination ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity (Part Category)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `commodity_index_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Commodity Index Linked');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `is_jis` SET TAGS ('dbx_business_glossary_term' = 'Just‑In‑Sequence Requirement Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `is_jit` SET TAGS ('dbx_business_glossary_term' = 'Just‑In‑Time Requirement Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `kit_type` SET TAGS ('dbx_business_glossary_term' = 'Kit Type');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `kit_type` SET TAGS ('dbx_value_regex' = 'CKD|SKD|none');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year (MY)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `nomination_number` SET TAGS ('dbx_business_glossary_term' = 'Nomination Number');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_business_glossary_term' = 'Nomination Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_value_regex' = 'nominated|confirmed|withdrawn|rejected');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Nomination Priority');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Supply Region');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NAM|EME|APAC|LATAM|AFR');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `sor_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Requirements Reference');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `target_piece_price` SET TAGS ('dbx_business_glossary_term' = 'Target Piece Price');
ALTER TABLE `vibe_automotive_v1`.`supply`.`sourcing_nomination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` SET TAGS ('dbx_subdomain' = 'sourcing_procurement');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `sourcing_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Nomination Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'RFQ Approval Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|REJECTED');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `commodity_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Commodity Index Reference');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFQ Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `delivery_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Type');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `delivery_schedule_type` SET TAGS ('dbx_value_regex' = 'JIT|JIS|STANDARD');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `eprocurement_portal_code` SET TAGS ('dbx_business_glossary_term' = 'E-Procurement Portal ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFQ Issue Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `net_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Price Amount');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RFQ Notes');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'RFQ Priority');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'HIGH|MEDIUM|LOW');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `quantity_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Quantity');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'RFQ Response Due Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation Number');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'RFQ Lifecycle Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|open|closed|awarded|cancelled|pending');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'RFQ Type');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'NEW_PART|EXISTING_PART|SERVICE|MATERIAL');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `target_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Price Amount');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `target_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Target Price Currency');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `tooling_description` SET TAGS ('dbx_business_glossary_term' = 'Tooling Description');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `tooling_required` SET TAGS ('dbx_business_glossary_term' = 'Tooling Required Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|SET|BOX');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFQ Record Last Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` SET TAGS ('dbx_subdomain' = 'sourcing_procurement');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `rfq_response_id` SET TAGS ('dbx_business_glossary_term' = 'RFQ Response ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'RFQ ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `amortization_term_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Term (Months)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `capacity_commitment` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment (CC)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `commodity_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Commodity Surcharge');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `exceptions_to_sor` SET TAGS ('dbx_business_glossary_term' = 'Exceptions to Statement of Requirements');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `freight_included` SET TAGS ('dbx_business_glossary_term' = 'Freight Included Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `is_preferred_supplier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `portal_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Portal Submission');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `quoted_currency` SET TAGS ('dbx_business_glossary_term' = 'Quoted Currency (QC)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `quoted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity (QQ)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price (QUP)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'RFQ Response Number (RN)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `response_source` SET TAGS ('dbx_business_glossary_term' = 'Response Source');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `response_source` SET TAGS ('dbx_value_regex' = 'email|portal|api');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `rfq_response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `rfq_response_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|accepted|rejected');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|sea|land');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TA)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `tooling_cost` SET TAGS ('dbx_business_glossary_term' = 'Tooling Cost (TC)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Price (TQP)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_automotive_v1`.`supply`.`rfq_response` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'standard|extended');
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'sourcing_procurement');
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`purchase_order` ALTER COLUMN `scheduling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` SET TAGS ('dbx_subdomain' = 'sourcing_procurement');
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`po_line` ALTER COLUMN `scheduling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` SET TAGS ('dbx_subdomain' = 'delivery_scheduling');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `scheduling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `supplier_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `actual_otd_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual On‑Time Delivery (%)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `actual_ppm` SET TAGS ('dbx_business_glossary_term' = 'Actual Parts‑Per‑Million (PPM)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'framework|spot|consignment|service|lease');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `commodity_escalation_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Commodity Escalation Clause');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `compliance_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `contract_scope` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `delivery_rhythm` SET TAGS ('dbx_business_glossary_term' = 'Delivery Rhythm');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `delivery_rhythm` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `scheduling_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `early_termination_allowed` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Allowed');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `kanban_flag` SET TAGS ('dbx_business_glossary_term' = 'Kanban Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash|prepaid');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `portal_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Portal Managed');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `release_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Release Horizon (Weeks)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `scheduling_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `scheduling_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `target_otd_percent` SET TAGS ('dbx_business_glossary_term' = 'Target On‑Time Delivery (%)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `target_ppm` SET TAGS ('dbx_business_glossary_term' = 'Target Parts‑Per‑Million (PPM)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `total_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Annual Volume');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pcs|kg|liter|meter|unit');
ALTER TABLE `vibe_automotive_v1`.`supply`.`scheduling_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'delivery_scheduling');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `mrp_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `scheduling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`delivery_schedule` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` SET TAGS ('dbx_subdomain' = 'quality_performance');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `regulatory_body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`ppap_submission` ALTER COLUMN `supplier_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'delivery_scheduling');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `in_transit_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'In Transit Inventory Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Po Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`goods_receipt` ALTER COLUMN `supplier_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'quality_performance');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `commodity_price_competitiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Competitiveness');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (CS)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `corrective_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `delivery_quantity_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Delivery Quantity Accuracy Percentage (DQAP)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date (Timestamp)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name (EN)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Notes');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `otd_percentage` SET TAGS ('dbx_business_glossary_term' = 'On‑Time Delivery Percentage (OTD)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Supplier Score (OSS)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier (PT)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|disqualified');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `ppap_on_time_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'PPAP On‑Time Completion Rate (PPAP‑OTC)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `ppm_defect_rate` SET TAGS ('dbx_business_glossary_term' = 'Parts‑Per‑Million Defect Rate (PPM)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score (RS)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (RS)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|finalized|reviewed');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Score (SRS)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number (SCN)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `scoring_methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Scoring Methodology Version (SMV)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Lifecycle Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_status` SET TAGS ('dbx_value_regex' = 'pending|completed|archived');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score (SS)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`supplier_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` SET TAGS ('dbx_subdomain' = 'sourcing_procurement');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement ID');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `actual_otd_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual On‑Time Delivery Percentage');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `actual_ppm` SET TAGS ('dbx_business_glossary_term' = 'Actual Parts‑Per‑Million Defect Rate');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'price|cost|service|tooling');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `annual_price_reduction_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Price Reduction Commitment (APR)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `commodity_index_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Commodity Index Linked');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `commodity_index_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Index Name');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `compliance_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `contract_scope` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `price_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `early_termination_allowed` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Allowed');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `escalation_formula` SET TAGS ('dbx_business_glossary_term' = 'Escalation Formula');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|net90');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `price_adjustment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Trigger');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `price_adjustment_trigger` SET TAGS ('dbx_value_regex' = 'material_index|foreign_exchange|none');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `price_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `price_agreement_status` SET TAGS ('dbx_value_regex' = 'active|expired|under_negotiation|draft|suspended');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `target_otd_percent` SET TAGS ('dbx_business_glossary_term' = 'Target On‑Time Delivery Percentage');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `target_ppm` SET TAGS ('dbx_business_glossary_term' = 'Target Parts‑Per‑Million Defect Rate');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `tooling_amortization_terms` SET TAGS ('dbx_business_glossary_term' = 'Tooling Amortization Terms');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `total_annual_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Annual Volume');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'piece|kg|liter|meter');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Agreed Unit Price');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`supply`.`price_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version Number');
