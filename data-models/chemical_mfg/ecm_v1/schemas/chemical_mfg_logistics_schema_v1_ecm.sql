-- Schema for Domain: logistics | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`logistics` COMMENT 'Manages outbound and inbound freight execution including carrier selection, LTL/FTL shipment planning, hazardous materials transport compliance (DOT 49 CFR), route optimization, delivery confirmation, ASN generation, bill of lading, and transport documentation for regulated chemical shipments. Integrates with Oracle Transportation Management (TMS) for logistics cost optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Primary key for shipment',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Direct account link on shipment enables traceability of which customer a shipment belongs to, supporting delivery performance dashboards.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the transportation carrier responsible for the shipment.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Regulatory shipment manifest must link each shipment to the primary chemical product for SDS, GHS labeling and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation report requires each shipment charged to a cost center for accurate freight expense tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Driver assignment for each shipment is needed for DOT compliance and safety incident reporting; logistics tracks driver via employee_id.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Shipment traceability mandates recording the exact formula version used to produce the shipped batch, supporting recalls and quality audits.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Shipment execution report ties each outbound shipment to the originating manufacturing order for traceability and regulatory compliance.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: Loading planning needs the precise warehouse location of origin for inventory allocation and temperature control compliance.',
    `outbound_delivery_id` BIGINT COMMENT 'FK to order.outbound_delivery.outbound_delivery_id — Shipment-to-order fulfillment linkage is required for delivery confirmation and proof-of-delivery workflows. Without this FK, logistics cannot confirm which sales order deliveries have shipped.',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Linking shipment to packaging configuration ensures correct DOT, IATA and hazmat labeling per product packaging for regulatory compliance.',
    `product_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Each shipment fulfills a specific sales order; adding a FK ties the physical shipment to its originating order for end‑to‑end logistics tracking.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Production‑to‑Shipment Traceability Report requires linking each shipment to the Production Plan that created the product.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis links each shipment to the profit center that owns the revenue stream.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Needed to associate each shipment with its originating purchase order for inbound receipt verification and logistics cost allocation.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: R&D material delivery tracking report requires linking each shipment to the research project that requested the material.',
    `transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.transfer_order. Business justification: Transfer orders are fulfilled via shipments; linking them enables end‑to‑end tracking of inter‑plant movements.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment was received at destination.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment left the origin facility.',
    `asn_number` STRING COMMENT 'Identifier for the advanced shipping notice sent to the receiver.',
    `bill_of_lading_number` STRING COMMENT 'Reference number of the bill of lading document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for freight amounts.',
    `customs_declaration_number` STRING COMMENT 'Identifier for the customs declaration associated with the shipment.',
    `destination_facility_code` STRING COMMENT 'Internal code identifying the facility where the shipment is destined.',
    `dot_compliance_status` STRING COMMENT 'Compliance status with DOT 49 CFR shipping paper requirements.. Valid values are `compliant|non_compliant|pending`',
    `equipment_number` STRING COMMENT 'Identifier of the trailer, container, or railcar used for the shipment.',
    `estimated_transit_days` STRING COMMENT 'Planned number of days from departure to arrival.',
    `export_control_status` STRING COMMENT 'Export control clearance status for the shipment.. Valid values are `approved|denied|pending`',
    `freight_amount_discount` DECIMAL(18,2) COMMENT 'Discounts applied to the gross freight charge.',
    `freight_amount_gross` DECIMAL(18,2) COMMENT 'Total freight charge before discounts or adjustments.',
    `freight_amount_net` DECIMAL(18,2) COMMENT 'Net freight charge after discounts.',
    `freight_terms` STRING COMMENT 'Payment responsibility for freight charges.. Valid values are `prepaid|collect|third_party`',
    `hazardous_materials_indicator` BOOLEAN COMMENT 'True if the shipment contains hazardous materials.',
    `hazmat_class` STRING COMMENT 'DOT hazardous material classification code (1‑9). [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `number_of_packages` STRING COMMENT 'Total count of individual packages or units in the shipment.',
    `package_type` STRING COMMENT 'Standard classification of packaging (e.g., pallet, drum, barrel).',
    `regulatory_documentation_status` STRING COMMENT 'Status of required regulatory paperwork for the shipment.. Valid values are `complete|incomplete|pending`',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time for shipment arrival at destination.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time for shipment departure from origin.',
    `shipment_number` STRING COMMENT 'External shipment reference number used in logistics and customer communications.',
    `shipment_status` STRING COMMENT 'Current lifecycle state of the shipment.. Valid values are `planned|in_transit|delivered|cancelled|exception`',
    `shipment_type` STRING COMMENT 'Category of shipment based on mode of transport.. Valid values are `LTL|FTL|INTERMODAL|AIR|RAIL`',
    `special_handling_instructions` STRING COMMENT 'Additional instructions for handling, e.g., fragile, keep upright.',
    `temperature_control_required` BOOLEAN COMMENT 'Indicates whether the shipment must be temperature‑controlled.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for the shipment.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for the shipment.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Aggregate volume of the shipment in cubic meters.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of the shipment in kilograms.',
    `tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for real‑time status lookup.',
    `un_number` STRING COMMENT 'United Nations identification number for hazardous substances.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Core master record for every outbound or inbound freight movement of chemical products. Captures shipment type (LTL/FTL/intermodal), origin and destination facilities, scheduled and actual departure/arrival dates, total weight, volume, hazmat class, UN number, DOT 49 CFR compliance status, carrier assignment, freight terms (prepaid/collect), shipment status, and Oracle TMS shipment reference. Serves as the primary operational entity for all logistics execution activities. Supports DOT 49 CFR §172.200 shipping paper requirements and §177.817 driver document requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` (
    `shipment_line_id` BIGINT COMMENT 'Unique identifier for the shipment line record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: Batch traceability report requires linking each shipped line to its batch record for quality recall and compliance.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Each shipment line needs the specific chemical product to generate product‑specific hazard documentation, traceability and batch control.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Batch traceability matrix ties each shipped line to the experimental formulation it fulfills, needed for QA and scale‑up decisions.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Shipment line items correspond to order line items; linking provides detailed fulfillment and billing reconciliation.',
    `shipment_id` BIGINT COMMENT 'Identifier of the parent shipment header.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Regulatory traceability (GHS/REACH) requires each shipment line to reference the exact inventory lot shipped.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or product being shipped.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to planning.planned_order. Business justification: Shipment‑to‑Planned‑Order Traceability links each shipped line back to its originating Planned Order.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Enables traceability from shipped items back to the original quoted line for compliance, billing reconciliation, and margin analysis.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Pick‑by‑position processes need the exact stock position for each line to optimize warehouse operations.',
    `carrier_code` STRING COMMENT 'Code of the carrier responsible for transporting this line.',
    `coa_reference` STRING COMMENT 'Reference to the Certificate of Analysis associated with the material.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment line record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `customs_declaration_required` BOOLEAN COMMENT 'Flag indicating if a customs declaration is required.',
    `customs_document_number` STRING COMMENT 'Customs document number for international shipments.',
    `dot_label_required` BOOLEAN COMMENT 'Indicates if DOT labeling is required for this line.',
    `expiration_date` DATE COMMENT 'Expiration date of the material, if applicable.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Freight charge amount for this line.',
    `freight_class` STRING COMMENT 'Freight class for LTL/FTL billing purposes.',
    `ghs_label_required` BOOLEAN COMMENT 'Indicates if GHS labeling is required for this line.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight including packaging in kilograms.',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether the line contains hazardous material.',
    `is_freight_chargeable` BOOLEAN COMMENT 'Indicates whether freight charges apply to this line.',
    `line_sequence` STRING COMMENT 'Sequence number of the line within the shipment.',
    `line_status` STRING COMMENT 'Current processing status of the shipment line.. Valid values are `pending|picked|packed|shipped|delivered|exception`',
    `manufacturing_date` DATE COMMENT 'Manufacturing date of the material.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the shipped items (excluding packaging) in kilograms.',
    `package_count` STRING COMMENT 'Number of packages of this type in the line.',
    `package_height_cm` DECIMAL(18,2) COMMENT 'Height of the package in centimeters.',
    `package_length_cm` DECIMAL(18,2) COMMENT 'Length of the package in centimeters.',
    `package_type` STRING COMMENT 'Type of packaging used for the line item.. Valid values are `drum|ibc|tote|iso_tank|box|pallet`',
    `package_width_cm` DECIMAL(18,2) COMMENT 'Width of the package in centimeters.',
    `packing_group` STRING COMMENT 'Packing group indicating degree of danger.. Valid values are `I|II|III|IV`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the material shipped in the line.',
    `seal_number` STRING COMMENT 'Seal or closure identifier for verification.',
    `seal_verified` BOOLEAN COMMENT 'Indicates whether the package seal has been verified.',
    `sku` STRING COMMENT 'Stock Keeping Unit code for the shipped product.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the empty packaging in kilograms.',
    `temperature_control_required` BOOLEAN COMMENT 'Indicates if temperature control is required for the shipment.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius for temperature‑controlled shipment.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius for temperature‑controlled shipment.',
    `un_hazard_class` STRING COMMENT 'UN hazard class for hazardous material. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — 9 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT 'Unit of measure for the quantity.. Valid values are `kg|l|pcs|gal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment line record.',
    CONSTRAINT pk_shipment_line PRIMARY KEY(`shipment_line_id`)
) COMMENT 'Line-level detail for each product, material, or package included in a shipment. Records the finished chemical SKU or raw material, ordered and shipped quantities, unit of measure, lot number, batch number, hazmat indicator, UN hazard class, packing group, net and gross weight, COA reference, package count, package type (drum/IBC/tote/ISO tank), package dimensions, tare weight, GHS/DOT label requirements per 49 CFR §172.400, seal or closure verification, and packing list documentation for customs clearance. Supports multi-product chemical shipments, regulatory manifest line-item traceability, receiving verification, and international customs documentation requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` (
    `bill_of_lading_id` BIGINT COMMENT 'System generated surrogate primary key for the Bill of Lading record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Bill of lading should reference carrier entity; carrier_scac is redundant once carrier_id FK is added.',
    `site_id` BIGINT COMMENT 'Reference to the location where the shipment is destined.',
    `origin_location_site_id` BIGINT COMMENT 'Reference to the location where the shipment originates.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: A bill of lading is generated for a single shipment; adding parent_logistics_shipment_id creates the required child‑to‑parent link.',
    `primary_bill_site_id` BIGINT COMMENT 'Reference to the party that is sending the shipment.',
    `shipment_plan_id` BIGINT COMMENT 'Reference to the planned transportation route.',
    `bill_of_lading_status` STRING COMMENT 'Current lifecycle state of the Bill of Lading.. Valid values are `draft|issued|in_transit|delivered|cancelled|closed`',
    `bol_number` STRING COMMENT 'Unique business identifier printed on the legal transport document.',
    `bol_type` STRING COMMENT 'Indicates whether the document is a master BOL or a house BOL.. Valid values are `master|house`',
    `compliance_flags` STRING COMMENT 'Pipe‑separated list of compliance indicators (e.g., REACH|TSCA|GHS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the Bill of Lading record was first created in the system.',
    `customs_declaration_number` STRING COMMENT 'Identifier of the customs filing associated with the shipment.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Monetary value declared for the shipment for liability and customs purposes.',
    `declared_value_currency` STRING COMMENT 'Three‑letter ISO currency code for the declared value.. Valid values are `USD|EUR|CAD|GBP|JPY|CNY`',
    `dot_certification_statement` STRING COMMENT 'Legal statement required by DOT 49 CFR confirming compliance.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact listed on the Bill of Lading.',
    `equipment_number` STRING COMMENT 'Identifier (e.g., container number) of the equipment.',
    `equipment_type` STRING COMMENT 'Type of equipment used to move the shipment.. Valid values are `container|trailer|tank|refrigerated|flatbed|bulk`',
    `export_control_classification` STRING COMMENT 'Regulatory classification for export control compliance.. Valid values are `EAR99|ECCN|ITAR|CCL|NLR|SENSITIVE`',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged by the carrier for transportation.',
    `freight_charge_currency` STRING COMMENT 'Three‑letter ISO currency code for the freight charge.. Valid values are `USD|EUR|CAD|GBP|JPY|CNY`',
    `freight_class` STRING COMMENT 'Freight classification used for rate calculation. [ENUM-REF-CANDIDATE: 50|55|60|65|70|77.5|85|92.5|100|110|125|150|175|200|250|300|400|500 — promote to reference product]',
    `hazmat_class` STRING COMMENT 'Regulatory class of the hazardous material, per DOT.. Valid values are `explosive|flammable|toxic|corrosive|radioactive|oxidizer`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials.',
    `hazmat_un_number` STRING COMMENT 'United Nations identification number for the hazardous material.',
    `incoterms` STRING COMMENT 'International commercial term governing responsibility and cost allocation.. Valid values are `EXW|FCA|FOB|CFR|CIF|DAP`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the Bill of Lading was issued to the carrier.',
    `number_of_packages` STRING COMMENT 'Total count of individual packages or units in the shipment.',
    `package_type` STRING COMMENT 'Standard classification of the packaging used.. Valid values are `pallet|box|drum|bag|barrel|crate`',
    `reference_number` STRING COMMENT 'External reference such as purchase order or sales order number linked to the shipment.',
    `seal_number` STRING COMMENT 'Identifier of the security seal applied to the transport unit.',
    `special_handling_instructions` STRING COMMENT 'Free‑text instructions for handling the shipment (e.g., keep upright, no stacking).',
    `temperature_control_required` BOOLEAN COMMENT 'Indicates if the shipment must be kept within a temperature range.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Upper bound of the required temperature range in Celsius.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Lower bound of the required temperature range in Celsius.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment.. Valid values are `truck|rail|air|sea|pipeline|intermodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the Bill of Lading record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the shipment in kilograms.',
    CONSTRAINT pk_bill_of_lading PRIMARY KEY(`bill_of_lading_id`)
) COMMENT 'Legal transport document issued for each chemical shipment, serving as the contract of carriage between shipper and carrier. Captures BOL number, shipper and consignee details, carrier SCAC code, freight class, declared value, hazmat emergency contact, special handling instructions, seal numbers, and DOT 49 CFR certification statement. Required for all regulated chemical transport under DOT and IATA rules.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'System-generated unique identifier for the carrier master record.',
    `approved_hazard_classes` STRING COMMENT 'Comma‑separated list of GHS/UN hazard classes the carrier is authorized to transport.',
    `average_load_capacity_tons` DECIMAL(18,2) COMMENT 'Typical maximum payload per vehicle expressed in metric tons.',
    `benchmark_comparison` STRING COMMENT 'Result of comparing carrier performance against internal benchmarks.. Valid values are `above|below|meets|exceeds`',
    `carrier_description` STRING COMMENT 'Free‑form description of the carriers capabilities and services.',
    `carrier_name` STRING COMMENT 'Legal or trade name of the freight carrier.',
    `carrier_type` STRING COMMENT 'Primary mode of transport the carrier provides.. Valid values are `LTL|FTL|Rail|Intermodal|Tanker|ISO_Tank`',
    `contract_end_date` DATE COMMENT 'Effective end date of the carrier service contract (null if open‑ended).',
    `contract_start_date` DATE COMMENT 'Effective start date of the carrier service contract.',
    `corrective_action_flag` BOOLEAN COMMENT 'True if any corrective actions were issued for the carrier during the measurement period.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier record was first created.',
    `ctpat_certified` BOOLEAN COMMENT 'True if the carrier is certified under the C‑TPAT program.',
    `damage_claim_rate` DECIMAL(18,2) COMMENT 'Proportion of shipments resulting in damage claims.',
    `dot_carrier_number` STRING COMMENT 'Federal Motor Carrier Safety Administration (FMCSA) registration number for the carrier.',
    `fleet_size` STRING COMMENT 'Total number of vehicles or units operated by the carrier.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the carrier holds a valid hazmat certification for regulated chemical shipments.',
    `hazmat_incident_count` STRING COMMENT 'Number of hazardous‑material incidents recorded for the carrier in the measurement period.',
    `insurance_certificate_number` STRING COMMENT 'Unique identifier of the carriers insurance certificate.',
    `insurance_expiry_date` DATE COMMENT 'Date on which the carriers liability insurance coverage expires.',
    `insurance_provider_name` STRING COMMENT 'Name of the insurance carrier providing liability coverage.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Proportion of carrier invoices that match agreed rates and terms.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or performance audit of the carrier.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the carrier record.. Valid values are `active|inactive|suspended|pending|terminated`',
    `mc_number` STRING COMMENT 'Unique identifier for the carriers operating authority.',
    `measurement_period_end` DATE COMMENT 'Last day of the reporting window for carrier KPIs.',
    `measurement_period_start` DATE COMMENT 'First day of the reporting window for carrier KPIs.',
    `oracle_tms_carrier_code` STRING COMMENT 'Carrier identifier used within Oracle Transportation Management.',
    `performance_on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries made on schedule during the measurement period.',
    `performance_on_time_pickup_rate` DECIMAL(18,2) COMMENT 'Percentage of pickups completed within the agreed time window during the measurement period.',
    `preferred_lanes` STRING COMMENT 'Typical origin‑to‑destination lane pairs where the carrier is preferred.',
    `primary_contact_email` STRING COMMENT 'Main email address used for carrier communications.',
    `primary_contact_phone` STRING COMMENT 'Main telephone number for carrier communications.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance standing with DOT, EPA, and other applicable regulations.. Valid values are `compliant|non_compliant|under_review`',
    `safety_rating_score` DECIMAL(18,2) COMMENT 'Composite safety score (0‑5) derived from audit results and incident history.',
    `scac_code` STRING COMMENT 'Four‑character code assigned to the carrier by the National Motor Freight Traffic Association.',
    `tender_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of carrier tenders accepted versus offered.',
    `termination_date` DATE COMMENT 'Date on which the carrier relationship was terminated, if applicable.',
    `tier_rating` STRING COMMENT 'Internal tier classification based on performance and strategic importance.. Valid values are `Tier1|Tier2|Tier3|Tier4|Tier5`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the carrier record.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for all approved freight carriers used to transport chemical products, including qualification status, contractual terms, and periodic performance scorecards. Stores carrier name, SCAC code, DOT carrier number, MC number, carrier type (LTL/FTL/rail/intermodal/tanker/ISO tank), hazmat certification status, insurance certificate expiry, approved chemical hazard classes, preferred lanes, carrier tier rating, CTPAT certification status, Oracle TMS carrier ID, and performance KPIs (on-time pickup/delivery rates, damage and claim rates, hazmat compliance incidents, tender acceptance rate, invoice accuracy, measurement period, corrective action flags, benchmark comparison). Supports carrier qualification reviews, contract renewal decisions, tier classification, and compliance vetting per DOT 49 CFR §172.800 security plan requirements for regulated chemical transport.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'System-generated unique identifier for the freight order.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Freight order reporting and cost allocation per customer account requires direct account reference; enables financial reconciliation and compliance reporting.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier selected to execute the shipment.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Freight orders must reference the chemical product to calculate hazardous‑material surcharges and produce compliance reports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight order budgeting is recorded against the responsible cost center for budgeting and variance analysis.',
    `site_id` BIGINT COMMENT 'Reference to the location where the shipment is to be delivered.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Internal order tracking ties each freight procurement to an internal order for approval workflow and spend control.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Freight Order Planning uses material master data to determine carrier selection, hazmat handling, and temperature requirements; linking to material_master provides the necessary material specification',
    `origin_location_site_id` BIGINT COMMENT 'Reference to the location where the shipment originates.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: A freight order is tendered for a specific shipment; linking to shipment provides the parent reference.',
    `primary_freight_site_id` BIGINT COMMENT 'Identifier of the shipper (internal customer) that owns the freight order.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Freight Order Generation Process creates freight orders only after a Production Plan is firmed.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Required for generating freight orders from purchase orders; enables carrier tendering and freight cost tracking per PO.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Freight cost allocation to R&D projects is required for project budgeting and cost‑to‑complete analysis.',
    `accessorial_charges` DECIMAL(18,2) COMMENT 'Additional charges (e.g., liftgate, detention) applied to the freight order.',
    `asn_number` STRING COMMENT 'Identifier for the electronic shipping notice sent to the receiver.',
    `bill_of_lading_number` STRING COMMENT 'Document number issued by the carrier confirming receipt of the shipment.',
    `carrier_acceptance_status` STRING COMMENT 'Current acceptance response from the carrier.. Valid values are `accepted|rejected|pending`',
    `carrier_mode` STRING COMMENT 'Mode of transport used by the carrier for this freight order.. Valid values are `truck|rail|air|sea`',
    `compliance_status` STRING COMMENT 'Overall compliance assessment of the freight order with DOT/EPA regulations.. Valid values are `compliant|non_compliant|pending`',
    `contract_number` STRING COMMENT 'Reference to the carrier contract governing rates and terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first captured in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary amounts.',
    `delivery_window_end` TIMESTAMP COMMENT 'Latest time the carrier must complete delivery at the destination.',
    `delivery_window_start` TIMESTAMP COMMENT 'Earliest time the carrier may deliver to the destination.',
    `dot_regulation_code` STRING COMMENT 'Code referencing applicable DOT transportation regulations for the shipment.',
    `epa_regulation_code` STRING COMMENT 'Code referencing applicable EPA environmental regulations for the shipment.',
    `equipment_type` STRING COMMENT 'Type of trailer or equipment required for the shipment.',
    `freight_order_status` STRING COMMENT 'Current lifecycle state of the freight order.. Valid values are `draft|open|in_transit|delivered|cancelled|closed`',
    `freight_rate` DECIMAL(18,2) COMMENT 'Base rate charged by the carrier before accessorials.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials subject to DOT regulations.',
    `hazmat_class` STRING COMMENT 'DOT classification of hazardous material (e.g., 1, 2, 3, 4, 5, 6, 9).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this freight order record.',
    `load_type` STRING COMMENT 'Classification of the shipment load based on size, hazard, and temperature requirements.. Valid values are `ftl|ltl|partial|hazmat|refrigerated`',
    `number_of_pallets` STRING COMMENT 'Count of pallets included in the freight order.',
    `order_number` STRING COMMENT 'External reference number assigned to the freight order for tracking and communication.',
    `order_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight order was created in the TMS.',
    `pickup_window_end` TIMESTAMP COMMENT 'Latest time the carrier must complete loading at the origin.',
    `pickup_window_start` TIMESTAMP COMMENT 'Earliest time the carrier may begin loading at the origin.',
    `po_number` STRING COMMENT 'Customer purchase order linked to this freight shipment.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the freight order meets all required regulatory checks.',
    `temperature_requirement_c` DECIMAL(18,2) COMMENT 'Required temperature control for temperature-sensitive chemicals.',
    `tender_method` STRING COMMENT 'Method used to tender the freight order to carriers.. Valid values are `spot|contract|load_board`',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary amount payable for the freight order (rate + accessorials).',
    `trailer_number` STRING COMMENT 'Identifier of the specific trailer assigned to the freight order.',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Aggregate volume of the freight order in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of the freight order in kilograms.',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Operational freight order tendered to a carrier for execution of a shipment or consolidated load. Captures freight order number, tendering method (spot/contract/load board), carrier acceptance status, agreed freight rate, accessorial charges, pickup and delivery windows, load type, temperature requirements for temperature-sensitive chemicals (e.g., epoxy resins, catalysts), and TMS order reference. Represents the contractual execution unit between Chemical Mfg and the carrier per DOT 49 CFR §172.204 shipper certification requirements. Supports multi-stop and pool-point distribution common in chemical distribution networks.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` (
    `delivery_confirmation_id` BIGINT COMMENT 'System-generated unique identifier for the delivery confirmation record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Associating delivery confirmations with the customer account is required for receipt acknowledgment reporting and SLA compliance.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Delivery confirmation includes carrier name/scac; carrier_id FK links to carrier master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Delivery confirmation ties actual receipt to the cost center responsible for the inbound logistics spend.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Proof‑of‑delivery is required for invoice settlement; linking POD to its invoice supports audit and payment release.',
    `lab_experiment_id` BIGINT COMMENT 'Foreign key linking to research.lab_experiment. Business justification: Proof‑of‑delivery for samples ties confirmation records to the specific lab experiment that consumes them.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Delivery confirmation records proof of delivery for a shipment; linking to shipment ties the POD to its shipment.',
    `party_id` BIGINT COMMENT 'Identifier of the customer or receiving party that accepted the shipment.',
    `condition_on_arrival` STRING COMMENT 'Observed condition of the goods at the time of receipt.. Valid values are `good|damaged|contaminated|shortage`',
    `confirmation_number` STRING COMMENT 'External reference number assigned to the proof‑of‑delivery document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery confirmation record was first created in the system.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Quantity of product actually delivered to the receiver.',
    `delivery_address` STRING COMMENT 'Physical address where the shipment was delivered.',
    `delivery_confirmation_status` STRING COMMENT 'Current processing state of the delivery confirmation.. Valid values are `pending|confirmed|rejected|exception`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was physically received by the customer.',
    `discrepancy_notes` STRING COMMENT 'Free‑text notes describing any shortages, damages, or other issues noted on receipt.',
    `exception_code` STRING COMMENT 'Standardized code indicating the type of exception, if any, associated with the delivery.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'True if the shipment contains hazardous materials subject to DOT 49 CFR.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage measured at the delivery location.',
    `lot_number` STRING COMMENT 'Manufacturing lot identifier of the product batch delivered.',
    `pod_document_url` STRING COMMENT 'Link to the stored electronic proof‑of‑delivery document.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the delivered quantity.. Valid values are `kg|lb|gal|L|units|ton`',
    `received_by_name` STRING COMMENT 'Name of the individual who signed for the delivery.',
    `receiver_signature` STRING COMMENT 'Electronic representation of the signature captured from the receiver as proof of delivery.',
    `regulatory_compliance_flag` STRING COMMENT 'Indicates whether the delivery met all applicable regulatory requirements.. Valid values are `compliant|non_compliant|exempt`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature recorded at the delivery location, in degrees Celsius.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment.. Valid values are `truck|rail|air|sea|pipeline|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the delivery confirmation record.',
    CONSTRAINT pk_delivery_confirmation PRIMARY KEY(`delivery_confirmation_id`)
) COMMENT 'Record of proof-of-delivery (POD) for completed chemical shipments. Captures actual delivery date and time, receiver name and signature, delivery location, condition of goods on arrival, any noted discrepancies (shortage, damage, contamination), exception codes, and electronic POD document reference. Triggers downstream billing and COA release workflows.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` (
    `advance_ship_notice_id` BIGINT COMMENT 'Primary key for advance_ship_notice',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Advance ship notice stores carrier information as free text; adding carrier_id normalizes to carrier table.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: ASN generation includes SKU and hazard details; linking to material_master guarantees accurate material identification and regulatory compliance for the shipment.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Advance Ship Notice (ASN) is sent for a specific shipment; linking provides the parent relationship.',
    `site_id` BIGINT COMMENT 'Identifier of the customer or receiving facility for the shipment.',
    `trial_batch_id` BIGINT COMMENT 'Foreign key linking to research.trial_batch. Business justification: ASN processing for pilot‑scale batches requires linking the notice to the trial batch record for scheduling and compliance.',
    `asn_id` BIGINT COMMENT 'Foreign key linking to supply.asn. Business justification: Links internal ASN record to supplier‑provided ASN for reconciliation and compliance reporting.',
    `advance_ship_notice_status` STRING COMMENT 'Current lifecycle status of the ASN.. Valid values are `pending|sent|acknowledged|error|cancelled`',
    `asn_acknowledged_timestamp` TIMESTAMP COMMENT 'Timestamp when the receiving party acknowledged receipt of the ASN.',
    `asn_number` STRING COMMENT 'External ASN identifier exchanged with trading partners.',
    `asn_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN was transmitted to the trading partner.',
    `asn_type` STRING COMMENT 'Classification of the ASN purpose.. Valid values are `shipment|return|rework|transfer|sample`',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier for the shipped product.',
    `carrier_contact_phone` STRING COMMENT 'Primary phone number for carrier communications.',
    `carrier_pro_number` STRING COMMENT 'Carriers shipment tracking number (PRO number).',
    `carrier_scac_code` STRING COMMENT 'Standard Carrier Alpha Code identifying the carrier.',
    `compliance_document_number` STRING COMMENT 'Reference number for regulatory compliance documentation (e.g., DOT manifest).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for freight amounts.',
    `delivery_window_end` DATE COMMENT 'Latest date the receiver can accept the shipment.',
    `delivery_window_start` DATE COMMENT 'Earliest date the receiver is prepared to accept the shipment.',
    `expected_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time when the shipment is expected to arrive at the destination.',
    `freight_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustments, discounts, or surcharges applied to the freight charge.',
    `freight_gross_amount` DECIMAL(18,2) COMMENT 'Total freight charge before any adjustments.',
    `freight_net_amount` DECIMAL(18,2) COMMENT 'Final freight charge after adjustments.',
    `freight_terms` STRING COMMENT 'Incoterm governing freight cost responsibilities.. Valid values are `FOB|CIF|EXW|DAP|DDP|FCA`',
    `hazmat_classification` STRING COMMENT 'Hazard class of the hazardous material per DOT 49 CFR.. Valid values are `class_1|class_2|class_3|class_4|class_5|class_6`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains regulated hazardous materials.',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of the shipped product batch.',
    `number_of_packages` STRING COMMENT 'Count of individual packages or containers in the shipment.',
    `package_type_code` STRING COMMENT 'Standard code describing the type of packaging used.. Valid values are `box|pallet|drum|IBC|bag|crate`',
    `po_number` STRING COMMENT 'Purchase order identifier associated with the shipment.',
    `product_description` STRING COMMENT 'Brief description of the product(s) shipped.',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the primary product in the shipment.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the shipment requires additional regulatory reporting.',
    `route_optimization_flag` BOOLEAN COMMENT 'True if the shipment route was generated by an optimization engine.',
    `sales_order_number` STRING COMMENT 'Sales order identifier linked to the ASN.',
    `shipping_instructions` STRING COMMENT 'Special handling or delivery instructions for the carrier.',
    `shipping_mode` STRING COMMENT 'Logistics shipping mode indicating load planning strategy.. Valid values are `LTL|FTL|Air|Sea|Rail|Intermodal`',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Aggregate volume of all items in the shipment.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all items in the shipment.',
    `transport_mode` STRING COMMENT 'Primary mode of transport used for the shipment.. Valid values are `truck|rail|air|sea|pipeline|intermodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ASN record.',
    CONSTRAINT pk_advance_ship_notice PRIMARY KEY(`advance_ship_notice_id`)
) COMMENT 'Advanced Shipping Notice (ASN) transmitted to customers or receiving facilities prior to shipment arrival. Contains ASN number, expected arrival date/time, shipment contents summary, lot and batch details, packing list reference, carrier and PRO number, hazmat pre-notification flag, and EDI 856 transaction reference. Enables receiving facilities to prepare for regulated chemical receipt and FEFO inventory management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` (
    `hazmat_declaration_id` BIGINT COMMENT 'System‑generated unique identifier for the hazmat declaration record.',
    `carrier_id` BIGINT COMMENT 'Unique identifier for the carrier (e.g., MC/MX number).',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Regulatory reporting links hazardous shipment declarations to the registered compound for accurate SDS and compliance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Hazmat surcharge and compliance costs are charged to the cost center responsible for the shipment.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the compliance review.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: Regulatory shipping compliance requires linking each hazmat declaration to the formula that defines the products hazardous properties for accurate reporting and traceability.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Hazmat Declaration must reference the exact material to populate UN number, hazard class, and safety data; a material_master_id FK provides the authoritative source.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis includes hazmat handling fees allocated to the profit center of the product line.',
    `shipment_id` BIGINT COMMENT 'Identifier of the shipment to which this hazmat declaration belongs.',
    `applicable_regulation` STRING COMMENT 'Regulatory framework governing the shipment (DOT, IATA, or IMDG).. Valid values are `DOT|IATA|IMDG`',
    `compliance_review_date` DATE COMMENT 'Date when the declaration was last reviewed for compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the declaration record was created.',
    `effective_date` DATE COMMENT 'Date when the hazmat declaration becomes effective.',
    `emergency_response_guide_number` STRING COMMENT 'Reference number of the applicable Emergency Response Guide.',
    `expiration_date` DATE COMMENT 'Date after which the declaration is no longer valid (if applicable).',
    `hazard_class` STRING COMMENT 'Hazard class of the material (e.g., 1, 2, 3, …). [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — promote to reference product]',
    `hazard_division` STRING COMMENT 'Division within the hazard class, if applicable (e.g., 1A, 1B).',
    `hazmat_declaration_status` STRING COMMENT 'Current approval status of the hazmat declaration.. Valid values are `pending|approved|rejected|revoked`',
    `is_exempt` BOOLEAN COMMENT 'Indicates if the shipment is exempt from certain regulations.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous.',
    `line_number` STRING COMMENT 'Sequential line number of the declaration within the shipment.',
    `notes` STRING COMMENT 'Free‑form field for any additional information or comments.',
    `packaging_type` STRING COMMENT 'Type of packaging used for the hazardous material.. Valid values are `drum|barrel|tank|pallet|bag|cylinder`',
    `packing_group` STRING COMMENT 'Packing group indicating the degree of danger (I, II, or III).. Valid values are `I|II|III`',
    `ppe_requirements` STRING COMMENT 'Required PPE for personnel handling the shipment.',
    `proper_shipping_name` STRING COMMENT 'Official shipping name as defined in the UN Model Regulations.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of hazardous material declared.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the quantity (kilograms, liters, gallons, pounds).. Valid values are `kg|L|gal|lb`',
    `regulation_section` STRING COMMENT 'Specific section of the regulation that applies (e.g., 49 CFR 172.200).',
    `segregation_requirements` STRING COMMENT 'Special segregation or incompatibility requirements for transport.',
    `shipper_certification` STRING COMMENT 'Indicates whether the shipper is certified for the material.. Valid values are `certified|not_certified`',
    `spill_response_instructions` STRING COMMENT 'Procedures to follow in case of a spill during transport.',
    `temperature_limit_max` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for transport.',
    `temperature_limit_min` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for transport.',
    `temperature_uom` STRING COMMENT 'Unit of measure for temperature limits (Celsius or Fahrenheit).. Valid values are `C|F`',
    `transport_mode` STRING COMMENT 'Mode of transport used for the shipment.. Valid values are `road|air|sea|rail`',
    `un_number` STRING COMMENT 'UN numeric identifier for the hazardous material.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the declaration.',
    CONSTRAINT pk_hazmat_declaration PRIMARY KEY(`hazmat_declaration_id`)
) COMMENT 'Consolidated hazardous materials compliance record for each regulated chemical shipment line, combining SDS-derived transport requirements with DOT 49 CFR, IATA DGR, and IMDG Code shipping declarations. Records UN number, proper shipping name, hazard class and division, packing group, quantity and type of packaging, emergency response guide number (ERG), shipper certification, segregation requirements for incompatible chemicals, temperature limits during transport, PPE requirements for drivers, spill response instructions, and applicable transport regulation. Serves as the single source of truth for all hazmat transport compliance data — from SDS-sourced chemical properties through to regulatory declaration filing. Mandatory for all chemical shipments involving hazardous materials per DOT 49 CFR §172.200-204.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` (
    `shipment_plan_id` BIGINT COMMENT 'Primary key for shipment_plan',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to the plan.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Planning costs (fuel surcharge, route optimization) are budgeted against the cost center owning the shipment.',
    `loading_dock_id` BIGINT COMMENT 'Identifier of the dock where loading is scheduled.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Shipment plan is created to plan a particular shipment; linking to shipment establishes the parent‑child hierarchy.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Integrated Production & Logistics Scheduling aligns route plans with the Production Schedule for on‑time departures.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis uses planned shipment cost data linked to the profit center of the product line.',
    `site_id` BIGINT COMMENT 'Identifier of the shipper (customer) who owns the shipment.',
    `alternate_route_options` STRING COMMENT 'Text description of alternate routes considered during planning.',
    `arrival_date` DATE COMMENT 'Scheduled date for shipment arrival.',
    `bridge_restriction_flag` BOOLEAN COMMENT 'True if the route is prohibited for certain hazmat due to bridge weight/height restrictions.',
    `compliance_volume_limit_m3` DECIMAL(18,2) COMMENT 'Maximum allowable volume per DOT regulations for the selected route.',
    `compliance_weight_limit_kg` DECIMAL(18,2) COMMENT 'Maximum allowable weight per DOT regulations for the selected route.',
    `cost_adjustments` DECIMAL(18,2) COMMENT 'Sum of all cost adjustments (fees, discounts, surcharges) applied to the shipment.',
    `cost_gross` DECIMAL(18,2) COMMENT 'Total gross cost of the shipment before any adjustments.',
    `cost_net` DECIMAL(18,2) COMMENT 'Final net cost after applying adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the shipment cost.',
    `departure_date` DATE COMMENT 'Scheduled date for shipment departure.',
    `estimated_transit_time_minutes` STRING COMMENT 'Projected total transit time for the route, in minutes.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the fuel surcharge applied to the shipment.',
    `fuel_surcharge_basis` STRING COMMENT 'Method used to calculate fuel surcharge.. Valid values are `percentage|fixed|none`',
    `hazmat_route_flag` BOOLEAN COMMENT 'True when the route is designated for hazardous material transport.',
    `is_expedited` BOOLEAN COMMENT 'True if the shipment is marked for expedited handling.',
    `load_volume_m3` DECIMAL(18,2) COMMENT 'Actual volume loaded onto the vehicle after consolidation.',
    `load_weight_kg` DECIMAL(18,2) COMMENT 'Actual weight loaded onto the vehicle after consolidation.',
    `notes` STRING COMMENT 'Free‑form field for any special instructions or comments.',
    `optimization_objective` STRING COMMENT 'Primary objective used for route and load optimization.. Valid values are `cost|time|compliance`',
    `plan_number` STRING COMMENT 'External business identifier assigned to the shipment plan.',
    `plan_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment plan was generated.',
    `planned_arrival_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the shipment is expected to reach the destination.',
    `planned_departure_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the shipment is expected to leave the origin.',
    `restricted_route_flag` BOOLEAN COMMENT 'Indicates if the route includes any regulatory restrictions (e.g., tunnel/bridge limits).',
    `route_description` STRING COMMENT 'Human‑readable description of the planned route, including waypoints.',
    `route_distance_km` DECIMAL(18,2) COMMENT 'Total distance of the planned route, in kilometers.',
    `shipment_plan_status` STRING COMMENT 'Current lifecycle status of the shipment plan.. Valid values are `draft|approved|executed|cancelled`',
    `temperature_zone` STRING COMMENT 'Temperature control requirement for the shipment load.. Valid values are `ambient|refrigerated|heated`',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Aggregate volume of all items in the shipment plan.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Aggregate weight of all items in the shipment plan.',
    `tunnel_restriction_flag` BOOLEAN COMMENT 'True if the route is prohibited for certain hazmat due to tunnel restrictions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the shipment plan record.',
    `vehicle_capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum volume the vehicle can carry, in cubic meters.',
    `vehicle_capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight the vehicle can carry, in kilograms.',
    `vehicle_type` STRING COMMENT 'Type of vehicle assigned to execute the shipment.. Valid values are `truck|trailer|reefer|tank|flatbed`',
    CONSTRAINT pk_shipment_plan PRIMARY KEY(`shipment_plan_id`)
) COMMENT 'Consolidated shipment planning record combining route optimization and load planning for one or more shipments. Captures planned route legs, waypoints, estimated transit times, distance, fuel surcharge basis, restricted route flags (tunnel/bridge restrictions for hazmat per DOT 49 CFR §397.71), alternate route options, optimization objective (cost/time/compliance), load consolidation details, vehicle type and capacity assignment, actual loaded weight and volume, load sequence, temperature zone assignments for mixed chemical loads, and loading dock assignment. Supports DOT hazmat routing compliance, freight utilization optimization, and DOT weight compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` (
    `freight_rate_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each freight rate record.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier (shipping provider) that offers this rate.',
    `commodity_class` STRING COMMENT 'Chemical commodity classification (e.g., petrochemical, specialty, bulk) for which the rate is negotiated.',
    `compliance_hazmat_flag` BOOLEAN COMMENT 'Indicates whether the rate complies with hazardous material transport regulations.',
    `contract_type` STRING COMMENT 'Classification of the rate contract (e.g., contracted, spot, dynamic pricing).. Valid values are `contracted|spot|dynamic`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the freight rate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|CNY`',
    `destination_zone` STRING COMMENT 'Destination geographic or tariff zone code used in rate calculations.',
    `effective_from` DATE COMMENT 'Date when the rate becomes effective and may be used for cost calculations.',
    `effective_until` DATE COMMENT 'Date when the rate expires; null if the rate is open‑ended.',
    `freight_rate_description` STRING COMMENT 'Free‑form text describing special conditions, lane details, or notes.',
    `freight_rate_status` STRING COMMENT 'Current lifecycle status of the rate record.. Valid values are `active|inactive|expired|pending|draft`',
    `fuel_surcharge_percent` DECIMAL(18,2) COMMENT 'Fuel surcharge expressed as a percentage of the base rate.',
    `hazmat_surcharge` DECIMAL(18,2) COMMENT 'Additional surcharge for transporting hazardous chemicals, per regulatory requirements (DOT 49 CFR).',
    `is_contractual` BOOLEAN COMMENT 'True if the rate is part of a contracted agreement; false for spot rates.',
    `lane_type` STRING COMMENT 'Description of the shipment lane configuration.. Valid values are `door_to_door|port_to_port|door_to_port|port_to_door`',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge that applies regardless of distance or weight.',
    `mode` STRING COMMENT 'Mode of transport for which the rate applies.. Valid values are `truck|rail|air|ocean|intermodal|pipeline`',
    `origin_zone` STRING COMMENT 'Origin geographic or tariff zone code used in rate calculations.',
    `rate_code` STRING COMMENT 'Business identifier or code used by logistics planners to reference the rate.',
    `rate_source_system` STRING COMMENT 'System of record that originated the rate (e.g., OTM, SAP, custom).. Valid values are `otm|sap|custom`',
    `rate_type` STRING COMMENT 'Classification of the rate (e.g., base, accessorial, fuel surcharge).. Valid values are `base|accessorial|fuel_surcharge|minimum|hazmat|other`',
    `rate_value` DECIMAL(18,2) COMMENT 'Numeric value of the rate expressed in the selected unit of measure.',
    `regulatory_reference` STRING COMMENT 'Reference to the regulatory rule or document governing the rate (e.g., DOT 49 CFR, REACH).',
    `unit_of_measure` STRING COMMENT 'Unit in which the rate value is expressed (e.g., CWT per mile, flat fee).. Valid values are `cwt|mile|flat|kg|ton`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the freight rate record.',
    `volume_limit_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum volume for which the rate applies; null if unlimited.',
    `weight_limit_kg` DECIMAL(18,2) COMMENT 'Maximum weight for which the rate applies; null if unlimited.',
    CONSTRAINT pk_freight_rate PRIMARY KEY(`freight_rate_id`)
) COMMENT 'Contracted or spot freight rate records negotiated with carriers for specific lanes, modes, and chemical commodity types. Stores rate type (base/accessorial/fuel surcharge), origin and destination zone, carrier, effective and expiry dates, rate per unit (CWT/mile/flat), minimum charge, hazmat surcharge, and Oracle TMS rate table reference. Drives freight cost calculation and carrier selection optimization.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Unique system-generated identifier for each freight invoice.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Linking invoices to the owning customer account is required for financial audit trails and customer billing statements.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier that issued the freight invoice.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoice posting requires the cost center to allocate freight charges in the general ledger.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Linking invoice to internal order enables reconciliation of invoiced amount with approved spend.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability reporting needs freight invoice amounts linked to the profit center generating the sale.',
    `shipment_id` BIGINT COMMENT 'Identifier of the shipment to which this invoice relates.',
    `shipment_plan_id` BIGINT COMMENT 'Unique identifier of the transportation route applied to the shipment.',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Sum of all ancillary service fees on the invoice.',
    `approved_payment_amount` DECIMAL(18,2) COMMENT 'Final amount authorized for payment to the carrier.',
    `audit_pass_flag` BOOLEAN COMMENT 'True if the invoice passed the freight audit; false otherwise.',
    `audit_variance_amount` DECIMAL(18,2) COMMENT 'Dollar amount of variance between invoiced charges and audited rates.',
    `base_freight_amount` DECIMAL(18,2) COMMENT 'Core transportation charge before surcharges and accessorials.',
    `bill_of_lading_number` STRING COMMENT 'Carrier‑issued document number confirming shipment receipt.',
    `currency_code` STRING COMMENT 'Three‑letter code of the currency used for the invoice (e.g., USD, EUR).',
    `demurrage_detention_amount` DECIMAL(18,2) COMMENT 'Charges incurred for delayed loading/unloading or container detention.',
    `dispute_status` STRING COMMENT 'Current dispute handling state for the invoice.. Valid values are `none|open|resolved`',
    `due_date` DATE COMMENT 'Date by which Chemical Mfg must remit payment for the freight invoice.',
    `freight_contract_number` STRING COMMENT 'Identifier of the rate contract governing the freight service.',
    `freight_order_number` STRING COMMENT 'Internal order number used for rate agreement and planning of the freight movement.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional charge reflecting fuel price adjustments.',
    `hazardous_material_flag` BOOLEAN COMMENT 'True when the freight includes hazardous chemicals subject to DOT/REACH regulations.',
    `hazmat_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for transporting regulated hazardous chemicals.',
    `invoice_date` DATE COMMENT 'Calendar date on which the carrier generated the freight invoice.',
    `invoice_number` STRING COMMENT 'External invoice number provided by the carrier for this freight transaction.',
    `invoice_status` STRING COMMENT 'Workflow status of the freight invoice within the AP process.. Valid values are `pending|approved|paid|disputed|cancelled`',
    `invoice_type` STRING COMMENT 'Category of freight service reflected by the invoice.. Valid values are `standard|express|hazmat|temperature_controlled`',
    `payment_date` DATE COMMENT 'Calendar date on which the invoice was paid.',
    `payment_method` STRING COMMENT 'Payment instrument selected for settling the invoice.. Valid values are `credit_card|bank_transfer|check|account_credit`',
    `purchase_order_number` STRING COMMENT 'Internal PO number that triggered the freight movement.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the freight invoice record was first inserted into the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the freight invoice record.',
    `remarks` STRING COMMENT 'Additional notes or comments related to the invoice.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable tax levied on the freight charges.',
    `total_invoice_amount` DECIMAL(18,2) COMMENT 'Aggregate amount of all charges before tax.',
    `variance_reason_code` STRING COMMENT 'Standard code indicating the root cause of the audit variance.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total cubic meter volume of the shipment.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Carrier-issued freight invoice submitted to Chemical Mfg for transportation services rendered, incorporating automated freight audit results. Captures invoice number, carrier, shipment and freight order references, billed charges (base freight, fuel surcharge, accessorials, hazmat fees, demurrage/detention charges), invoice date, payment due date, dispute status, audit variance amount, audit pass/fail flag, variance reason codes, and approved payment amount. Feeds into finance domain for AP processing and logistics cost accounting. Supports three-way match validation (freight order rate vs delivery confirmation vs invoice) per chemical industry freight payment best practices.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` (
    `customs_declaration_id` BIGINT COMMENT 'Unique system-generated identifier for the customs declaration record.',
    `carrier_id` BIGINT COMMENT 'System identifier for the carrier entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Customs duties and fees are booked to the cost center that owns the imported material.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customs duties are billed; linking declaration to invoice enables duty charge aggregation on the same invoice.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Customs declaration is filed for a specific shipment; linking provides direct reference to the shipment.',
    `account_id` BIGINT COMMENT 'Identifier of the exporting party (company) responsible for the shipment.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability reporting requires customs cost allocation to the profit center generating the revenue.',
    `asn_number` STRING COMMENT 'Reference number for the ASN generated for the outbound shipment.',
    `bill_of_lading_number` STRING COMMENT 'Identifier of the bill of lading associated with the shipment.',
    `clearance_date` DATE COMMENT 'Date on which customs clearance was completed or finalized.',
    `clearance_status` STRING COMMENT 'Current status of the customs clearance process.. Valid values are `pending|cleared|rejected|held`',
    `compliance_notes` STRING COMMENT 'Free‑text field for any additional compliance observations or remarks.',
    `country_of_origin` STRING COMMENT 'Three‑letter country code where the chemical product was manufactured or sourced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the customs declaration record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the declared value (e.g., USD, EUR).',
    `customs_broker_name` STRING COMMENT 'Name of the licensed customs broker handling the declaration.',
    `declaration_date` DATE COMMENT 'Date the customs declaration was filed with the authority.',
    `declaration_number` STRING COMMENT 'External reference number assigned to the customs declaration by the logistics or customs system.',
    `declaration_status` STRING COMMENT 'Overall processing status of the customs declaration.. Valid values are `draft|submitted|cleared|rejected|cancelled`',
    `declaration_type` STRING COMMENT 'Indicates whether the declaration is for an export shipment or an import shipment.. Valid values are `export|import`',
    `declared_value` DECIMAL(18,2) COMMENT 'Monetary value declared for customs assessment, expressed in the transaction currency.',
    `destination_country` STRING COMMENT 'Three‑letter country code of the final destination for the shipment.',
    `duty_amount` DECIMAL(18,2) COMMENT 'Monetary amount of customs duty assessed on the shipment.',
    `duty_currency` STRING COMMENT 'Currency in which the duty amount is expressed.',
    `eccn` STRING COMMENT 'Alphanumeric code used by U.S. export control to classify dual‑use items.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total freight charge for the shipment.',
    `freight_currency` STRING COMMENT 'Currency of the freight cost (ISO 4217).',
    `hazardous_classification` STRING COMMENT 'UN number or class describing the hazardous nature of the chemical.',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the shipment contains hazardous chemicals subject to DOT 49 CFR.',
    `hs_code` STRING COMMENT 'Six- to ten-digit code that classifies the goods for customs duties and statistical purposes.',
    `import_permit_reference` STRING COMMENT 'Reference number of the import permit required for regulated chemicals.',
    `incoterms` STRING COMMENT 'Standard trade term defining responsibility for costs, risks, and logistics between seller and buyer.. Valid values are `EXW|FOB|CIF|DDP`',
    `is_lcl` BOOLEAN COMMENT 'True if the shipment is less than a full container load (LCL).',
    `number_of_packages` STRING COMMENT 'Count of individual packages or containers in the shipment.',
    `package_type` STRING COMMENT 'Standard packaging type used for the shipment.. Valid values are `box|drum|pallet`',
    `reach_compliance_flag` BOOLEAN COMMENT 'Indicates whether the chemical product complies with EU REACH regulations (true = compliant).',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory authority overseeing the customs process (e.g., CBP, EPA).',
    `tariff_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tariff rate expressed as a percentage of the declared value.',
    `transport_mode` STRING COMMENT 'Primary mode of transport used for the shipment.. Valid values are `air|sea|road|rail`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the customs declaration record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the shipment in kilograms.',
    CONSTRAINT pk_customs_declaration PRIMARY KEY(`customs_declaration_id`)
) COMMENT 'Export or import customs declaration for international chemical shipments. Records declaration type (export/import), HS tariff code, country of origin, declared value, currency, Incoterms, export control classification number (ECCN), REACH compliance flag, import permit reference, customs broker details, and clearance status. Required for cross-border movement of chemicals under TSCA, REACH, and national customs regulations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` (
    `freight_claim_id` BIGINT COMMENT 'System-generated unique identifier for the freight claim record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Claims must be attributed to the responsible customer account for liability tracking and regulatory reporting.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier responsible for the shipment.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product that was affected by the incident.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Tracking the internal employee who files a freight claim supports accountability, audit trails, and internal cost recovery processes.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight claim reimbursements are charged back to the cost center that incurred the loss.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Loss or damage claims on experimental material must reference the specific formulation to assess impact on R&D outcomes.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Freight claim resolution must reference the original invoice to reconcile claim amount against billed freight.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Freight Claim processing for damaged or lost goods needs the material master to identify the product, its regulatory status, and traceability for reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability impact of freight claims is tracked against the profit center responsible for the shipment.',
    `shipment_id` BIGINT COMMENT 'Identifier of the shipment to which this claim relates.',
    `bill_of_lading_number` STRING COMMENT 'Reference number of the Bill of Lading for the shipment.',
    `carrier_response_status` STRING COMMENT 'Current status of the carriers response to the claim.. Valid values are `pending|responded|rejected`',
    `cas_number` STRING COMMENT 'Unique CAS registry number identifying the chemical substance.',
    `claim_amount_adjustments` DECIMAL(18,2) COMMENT 'Sum of adjustments, fees, or deductions applied to the claim.',
    `claim_amount_gross` DECIMAL(18,2) COMMENT 'Total claimed amount before any adjustments.',
    `claim_amount_net` DECIMAL(18,2) COMMENT 'Final claim amount after adjustments, representing the amount payable.',
    `claim_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the claim amounts.. Valid values are `^[A-Z]{3}$`',
    `claim_filed_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim was initially filed by the claimant.',
    `claim_number` STRING COMMENT 'External claim number assigned by the logistics team for tracking and reference.',
    `claim_status` STRING COMMENT 'Current processing state of the claim within the claims workflow.. Valid values are `open|under_review|approved|rejected|settled|closed`',
    `claim_type` STRING COMMENT 'Category of the claim describing the nature of the loss during transport.. Valid values are `loss|damage|shortage|contamination|theft`',
    `claimant_code` BIGINT COMMENT 'Identifier of the party (shipper, customer, or internal unit) filing the claim.',
    `hazard_class` STRING COMMENT 'Regulatory hazard class of the chemical product per GHS/OSHA.. Valid values are `explosive|flammable|corrosive|toxic|oxidizer|gas`',
    `incident_country` STRING COMMENT 'Three‑letter ISO country code of the incident location.. Valid values are `^[A-Z]{3}$`',
    `incident_date` DATE COMMENT 'Date on which the loss, damage, or other incident occurred during transport.',
    `incident_location` STRING COMMENT 'Physical address or site where the incident was reported.',
    `loss_description` STRING COMMENT 'Narrative description of the loss, damage, or contamination event.',
    `lot_number` STRING COMMENT 'Batch or lot number of the chemical product involved in the claim.',
    `photos_attached_flag` BOOLEAN COMMENT 'Indicates whether photographic evidence has been provided.',
    `proof_of_delivery_number` STRING COMMENT 'Reference number of the Proof of Delivery document.',
    `quantity_affected` DECIMAL(18,2) COMMENT 'Amount of product (in the unit specified) that was lost, damaged, or contaminated.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim record.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Amount settled with the carrier after claim resolution.',
    `settlement_date` DATE COMMENT 'Date on which the settlement payment was made.',
    `supporting_documents_flag` BOOLEAN COMMENT 'Indicates whether supporting documentation (e.g., photos, BOL) has been attached to the claim.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity affected.. Valid values are `kg|l|gal|lb|m3`',
    CONSTRAINT pk_freight_claim PRIMARY KEY(`freight_claim_id`)
) COMMENT 'Formal freight claim filed against a carrier for loss, damage, shortage, or contamination of chemical goods during transport. Records claim number, claim type, shipment reference, claimed amount, damage description, chemical product affected, supporting documentation (photos, BOL, POD), carrier response, settlement amount, and claim status. Tracks financial recovery and carrier liability for chemical cargo incidents.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` (
    `dock_appointment_id` BIGINT COMMENT 'Unique identifier for the dock appointment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Dock appointment scheduling is often tied to a specific customer account for capacity planning and billing.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Dock appointment records carrier name/scac; carrier_id FK provides authoritative reference.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dock appointment fees and handling charges are allocated to the cost center that scheduled the appointment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Dock appointments must link to the certified driver employee to verify training, licensing, and safety compliance.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Dock Appointment scheduling for hazardous loads requires the material master to verify handling procedures and compliance, so a material_master_id FK ensures correct dock resource allocation.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Dock appointment is scheduled for a particular shipment; the free‑text shipment_reference becomes redundant once the FK is added.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Dock Appointment Scheduling uses the Production Schedule to allocate dock slots for outbound loads.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Dock scheduling for R&D material receipt is tied to the owning research project to coordinate lab readiness.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle (e.g., license plate or internal fleet number).',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the plant or warehouse location where the dock appointment occurs.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: Dock scheduling ties appointments to the responsible production work center for loading coordination and labor planning.',
    `appointment_date` DATE COMMENT 'Calendar date on which the appointment is scheduled.',
    `appointment_fee` DECIMAL(18,2) COMMENT 'Monetary charge associated with the dock appointment (e.g., dock usage fee).',
    `appointment_number` STRING COMMENT 'Business identifier assigned to the appointment, used for tracking and communication.',
    `appointment_type` STRING COMMENT 'Indicates whether the appointment is for inbound (receiving) or outbound (shipping) freight.. Valid values are `inbound|outbound`',
    `check_in_timestamp` TIMESTAMP COMMENT 'Actual time the carrier/check‑in event occurred at the dock.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Actual time the carrier/check‑out event occurred at the dock.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the appointment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the appointment fee.. Valid values are `USD|EUR|CAD|GBP|JPY|CNY`',
    `dock_appointment_status` STRING COMMENT 'Current lifecycle status of the appointment.. Valid values are `scheduled|checked_in|checked_out|cancelled|no_show`',
    `dock_door_code` STRING COMMENT 'Identifier of the dock door assigned to the appointment.',
    `hazmat_class` STRING COMMENT 'Hazard class of the material per DOT regulations. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|9 — promote to reference product]',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials.',
    `hazmat_pre_staging_required` BOOLEAN COMMENT 'True if the hazardous material must be pre‑staged in a designated area before loading/unloading.',
    `party_code` BIGINT COMMENT 'Identifier of the business party (shipper or receiver) associated with the appointment.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date and time of the dock window.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time of the dock window.',
    `segregation_area` STRING COMMENT 'Designated dock or yard area where segregated hazardous material is handled.',
    `segregation_required` BOOLEAN COMMENT 'Indicates whether the appointment requires segregation of the material from other loads.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the appointment record.',
    `wait_time_minutes` STRING COMMENT 'Total minutes the carrier waited between scheduled start and actual check‑in.',
    CONSTRAINT pk_dock_appointment PRIMARY KEY(`dock_appointment_id`)
) COMMENT 'Scheduled loading or unloading appointment at a plant or warehouse dock for a specific chemical shipment or carrier. Records appointment date and time window, dock door assignment, carrier and driver details, shipment reference, appointment type (inbound/outbound), check-in and check-out timestamps, wait time, appointment status, and hazmat pre-staging requirements. Manages dock throughput, coordinates with SAP EWM for warehouse execution, and ensures proper hazmat segregation at dock level per DOT 49 CFR §177.848 segregation and separation requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'System-generated unique identifier for each vehicle or transport equipment record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUIRED: Assigning a primary driver to each vehicle enables fleet management, driver‑vehicle audit trails, and regulatory safety checks.',
    `annual_inspection_due_date` DATE COMMENT 'Scheduled date by which the next annual DOT inspection must be completed.',
    `cleaning_certification_date` DATE COMMENT 'Date when the vehicle received its most recent cleaning certification for cross‑contamination prevention.',
    `cleaning_certification_status` STRING COMMENT 'Current status of the vehicles cleaning certification.. Valid values are `certified|expired|pending`',
    `compliance_documentation_status` STRING COMMENT 'Overall status of required regulatory documentation for the vehicle.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle record was first created in the data lake.',
    `cross_contamination_prevention` BOOLEAN COMMENT 'Indicates whether cleaning procedures have been completed to prevent cross‑contamination before the next load.',
    `dedicated` BOOLEAN COMMENT 'True if the vehicle is dedicated to a single customer or product line; false if shared.',
    `emission_class` STRING COMMENT 'Regulatory emission classification (e.g., Euro6, EPA Tier 4).',
    `fuel_type` STRING COMMENT 'Primary fuel used by the vehicle.. Valid values are `diesel|gasoline|electric|hydrogen|natural_gas`',
    `gps_enabled` BOOLEAN COMMENT 'True if the vehicle is equipped with active GPS tracking.',
    `gps_last_update` TIMESTAMP COMMENT 'Timestamp of the most recent GPS location transmission.',
    `gps_latitude` DOUBLE COMMENT 'Most recent latitude coordinate reported by the vehicles GPS.',
    `gps_longitude` DOUBLE COMMENT 'Most recent longitude coordinate reported by the vehicles GPS.',
    `hazmat_placard_capability` BOOLEAN COMMENT 'Indicates whether the vehicle is equipped and approved to display DOT hazmat placards.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.. Valid values are `passed|failed|pending|exempt`',
    `insurance_expiry_date` DATE COMMENT 'Date when the vehicles insurance coverage expires.',
    `insurance_policy_number` STRING COMMENT 'Identifier of the liability insurance policy covering the vehicle.',
    `last_cargo_code` STRING COMMENT 'CAS or internal product code of the most recent cargo carried, used for contamination tracking.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent DOT‑required safety inspection.',
    `license_plate` STRING COMMENT 'State‑issued license plate identifier.',
    `maintenance_cycle_km` DECIMAL(18,2) COMMENT 'Mileage interval after which scheduled maintenance is required.',
    `manufacturer` STRING COMMENT 'Company that manufactured the vehicle.',
    `max_payload_kg` DECIMAL(18,2) COMMENT 'Maximum allowable cargo weight for the vehicle.',
    `model` STRING COMMENT 'Model designation of the vehicle.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance activity.',
    `odometer_km` DECIMAL(18,2) COMMENT 'Cumulative distance traveled by the vehicle.',
    `registration_number` STRING COMMENT 'U.S. Department of Transportation registration identifier for the vehicle.',
    `tare_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the empty vehicle without cargo.',
    `temperature_control_capability` BOOLEAN COMMENT 'True if the vehicle can maintain a controlled temperature environment for temperature‑sensitive chemicals.',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Highest temperature the vehicle can maintain when temperature control is enabled.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Lowest temperature the vehicle can maintain when temperature control is enabled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vehicle record.',
    `vehicle_code` STRING COMMENT 'Internal alphanumeric code used to reference the vehicle within the enterprise system.',
    `vehicle_name` STRING COMMENT 'Human‑readable name or designation for the vehicle (e.g., "West Coast Tanker 12").',
    `vehicle_status` STRING COMMENT 'Current operational state of the vehicle.. Valid values are `in_service|retired|maintenance|out_of_service`',
    `vehicle_type` STRING COMMENT 'Category of transport equipment, aligned with DOT hazardous‑material classifications.. Valid values are `tanker|flatbed|dry_van|iso_container|railcar|ibc_chassis`',
    `vin_number` STRING COMMENT 'Globally unique identifier assigned by the vehicle manufacturer.',
    `year_of_manufacture` STRING COMMENT 'Calendar year the vehicle was built.',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Master record for vehicles and transport equipment used in chemical product logistics, including owned fleet assets and carrier-provided equipment. Stores vehicle ID, vehicle type (tanker, flatbed, dry van, ISO container, railcar, IBC chassis), license plate or equipment number, DOT registration number, hazmat placard capability per DOT 49 CFR §172.500-§172.560, last inspection date, annual DOT inspection status per 49 CFR §396.17, temperature control capability and range, dedicated/non-dedicated status, last cargo carried (for contamination prevention), cleaning certification date, tare weight, and maximum payload. Supports equipment assignment, DOT compliance tracking, and chemical cross-contamination prevention through last-cargo verification.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` (
    `carrier_qualification_id` BIGINT COMMENT 'Primary key for the carrier_qualification association',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master',
    `qualification_status` STRING COMMENT 'Current qualification status (e.g., Approved, Pending, Revoked)',
    CONSTRAINT pk_carrier_qualification PRIMARY KEY(`carrier_qualification_id`)
) COMMENT 'Represents the qualification relationship between a raw material and a freight carrier. Each record captures the status and date of qualification for a specific material-carrier pair.. Existence Justification: A material can be qualified with multiple approved carriers, and each carrier can be qualified for multiple materials. The qualification status and date are managed as a distinct business process, with humans creating, updating, and retiring these records.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` (
    `carrier_pricing_agreement_id` BIGINT COMMENT 'Primary key for the CarrierPricingAgreement association',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the carrier master record',
    `contract_number` STRING COMMENT 'Unique identifier of the carrier‑price‑list contract',
    `effective_from` DATE COMMENT 'Start date of the contracts validity',
    `effective_to` DATE COMMENT 'End date of the contracts validity (null if open‑ended)',
    CONSTRAINT pk_carrier_pricing_agreement PRIMARY KEY(`carrier_pricing_agreement_id`)
) COMMENT 'Represents the contractual agreement between a freight carrier and a price list. Each record links one carrier to one price list and stores contract‑specific data such as contract number and validity period.. Existence Justification: Carriers negotiate distinct pricing agreements (price lists) that are valid for specific periods. A single carrier can have multiple active price‑list contracts, and a single price list can be applied to multiple carriers. The business tracks each contract with its own contract number and effective dates, making the relationship an operational M:N entity.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `active_since` DATE COMMENT 'Date when the party became active in the system.',
    `address_line1` STRING COMMENT 'First line of the partys street address.',
    `address_line2` STRING COMMENT 'Second line of the partys street address, if applicable.',
    `business_unit` STRING COMMENT 'Internal business unit responsible for the party relationship.',
    `city` STRING COMMENT 'City component of the partys address.',
    `classification` STRING COMMENT 'High-level classification indicating internal or external relationship.',
    `compliance_documentation_url` STRING COMMENT 'Link to stored compliance documentation for the party.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the partys location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the party record was first created in the system.',
    `credit_rating` STRING COMMENT 'Creditworthiness rating assigned to the party.',
    `default_currency` STRING COMMENT 'Primary currency used for transactions with the party.',
    `dot_compliance_status` STRING COMMENT 'Current compliance status with Department of Transportation regulations.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the party.',
    `ein_number` STRING COMMENT 'US federal tax identification number for the party.',
    `email_address` STRING COMMENT 'Primary email address for electronic communications.',
    `external_reference_code` STRING COMMENT 'External system reference code for the party.',
    `hazardous_material_certified` BOOLEAN COMMENT 'Indicates whether the party is certified to handle hazardous materials.',
    `insurance_expiration_date` DATE COMMENT 'Date when the partys insurance coverage expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the partys liability insurance.',
    `insurance_provider` STRING COMMENT 'Name of the insurance company covering the partys liabilities.',
    `language_preference` STRING COMMENT 'Preferred language for communications with the party.',
    `last_contact_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent contact with the party.',
    `party_name` STRING COMMENT 'Full legal name of the party as registered.',
    `notes` STRING COMMENT 'Free-form notes or comments about the party.',
    `party_type` STRING COMMENT 'Classification of the partys role in logistics operations.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the party.',
    `phone_number` STRING COMMENT 'Primary telephone number for the party.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the partys address.',
    `preferred_carrier` STRING COMMENT 'Designated carrier preferred by the party for shipments.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for primary communications with the party.',
    `state_province` STRING COMMENT 'State or province of the partys address.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party record.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the party is exempt from sales tax.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identifier for the party.',
    `termination_date` DATE COMMENT 'Date when the party relationship was terminated, if applicable.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the partys primary location.',
    `trade_name` STRING COMMENT 'Commonly used name or brand of the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by receiver_party_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` (
    `loading_dock_id` BIGINT COMMENT 'Primary key for loading_dock',
    `paired_loading_dock_id` BIGINT COMMENT 'Self-referencing FK on loading_dock (paired_loading_dock_id)',
    `access_control_method` STRING COMMENT 'Mechanism used to control entry to the dock area.',
    `address_line` STRING COMMENT 'Street address of the loading dock facility.',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum cargo volume the dock can accommodate, in cubic meters.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum gross weight the dock can support, in kilograms.',
    `city` STRING COMMENT 'City where the dock is located.',
    `loading_dock_code` STRING COMMENT 'Unique alphanumeric code used in operational systems to reference the dock.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the dock resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the dock record was first created.',
    `loading_dock_description` STRING COMMENT 'Free‑form description of the dock, including any special notes.',
    `dock_leveler_type` STRING COMMENT 'Type of dock leveler installed.',
    `dot_compliance` BOOLEAN COMMENT 'True when the dock meets Department of Transportation 49 CFR requirements.',
    `gps_accuracy_m` DOUBLE COMMENT 'Estimated positional accuracy of the GPS coordinates, in meters.',
    `hazardous_material_capable` BOOLEAN COMMENT 'Indicates if the dock is approved for hazardous material handling (DOT 49 CFR).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety/operational inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the dock (decimal degrees).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the dock (decimal degrees).',
    `manager_email` STRING COMMENT 'Primary email address for the dock manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for dock operations.',
    `manager_phone` STRING COMMENT 'Primary contact phone number for the dock manager.',
    `max_vehicle_height_m` DECIMAL(18,2) COMMENT 'Maximum vehicle height that can be accommodated.',
    `max_vehicle_length_m` DECIMAL(18,2) COMMENT 'Longest vehicle length that can be accommodated.',
    `loading_dock_name` STRING COMMENT 'Human‑readable name of the loading dock.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `operating_hours` STRING COMMENT 'Standard daily operating window (e.g., 08:00-17:00).',
    `postal_code` STRING COMMENT 'Postal code for the dock address.',
    `power_available` BOOLEAN COMMENT 'Indicates whether electrical power is supplied at the dock.',
    `safety_certification` STRING COMMENT 'Safety certification held by the dock facility.',
    `security_level` STRING COMMENT 'Security classification of the dock facility.',
    `shift_schedule` STRING COMMENT 'Number of work shifts the dock operates per day.',
    `state` STRING COMMENT 'State or province of the dock location.',
    `loading_dock_status` STRING COMMENT 'Current operational status of the dock.',
    `temperature_control` BOOLEAN COMMENT 'True if the dock area has temperature regulation.',
    `loading_dock_type` STRING COMMENT 'Category of dock based on physical configuration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the dock record.',
    `water_available` BOOLEAN COMMENT 'Indicates whether water service is available at the dock.',
    CONSTRAINT pk_loading_dock PRIMARY KEY(`loading_dock_id`)
) COMMENT 'Master reference table for loading_dock. Referenced by loading_dock_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_shipment_plan_id` FOREIGN KEY (`shipment_plan_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_plan`(`shipment_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_party_id` FOREIGN KEY (`party_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`party`(`party_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ADD CONSTRAINT `fk_logistics_advance_ship_notice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ADD CONSTRAINT `fk_logistics_advance_ship_notice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_loading_dock_id` FOREIGN KEY (`loading_dock_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`loading_dock`(`loading_dock_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_shipment_plan_id` FOREIGN KEY (`shipment_plan_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_plan`(`shipment_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ADD CONSTRAINT `fk_logistics_freight_claim_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ADD CONSTRAINT `fk_logistics_dock_appointment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` ADD CONSTRAINT `fk_logistics_carrier_qualification_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` ADD CONSTRAINT `fk_logistics_carrier_pricing_agreement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ADD CONSTRAINT `fk_logistics_loading_dock_paired_loading_dock_id` FOREIGN KEY (`paired_loading_dock_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`loading_dock`(`loading_dock_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Warehouse Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `destination_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `dot_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'DOT Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `dot_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `equipment_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `estimated_transit_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Days');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `export_control_status` SET TAGS ('dbx_business_glossary_term' = 'Export Control Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `export_control_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_amount_discount` SET TAGS ('dbx_business_glossary_term' = 'Freight Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount Gross');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_amount_net` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount Net');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `hazardous_materials_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Indicator');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `regulatory_documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Documentation Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `regulatory_documentation_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|pending');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|delivered|cancelled|exception');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'LTL|FTL|INTERMODAL|AIR|RAIL');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (m³)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Header ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `coa_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `customs_declaration_required` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `customs_document_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `dot_label_required` SET TAGS ('dbx_business_glossary_term' = 'DOT Label Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `ghs_label_required` SET TAGS ('dbx_business_glossary_term' = 'GHS Label Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `is_freight_chargeable` SET TAGS ('dbx_business_glossary_term' = 'Freight Chargeable Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'pending|picked|packed|shipped|delivered|exception');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `package_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Height (cm)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `package_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Length (cm)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'drum|ibc|tote|iso_tank|box|pallet');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `package_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Width (cm)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III|IV');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Shipped');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `seal_verified` SET TAGS ('dbx_business_glossary_term' = 'Seal Verified');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `un_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'UN Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'kg|l|pcs|gal');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `origin_location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `primary_bill_site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_status` SET TAGS ('dbx_value_regex' = 'draft|issued|in_transit|delivered|cancelled|closed');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bol_type` SET TAGS ('dbx_value_regex' = 'master|house');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|CNY');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `dot_certification_statement` SET TAGS ('dbx_business_glossary_term' = 'DOT Certification Statement');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `equipment_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'container|trailer|tank|refrigerated|flatbed|bulk');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN|ITAR|CCL|NLR|SENSITIVE');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Currency');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_charge_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|CNY');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_class` SET TAGS ('dbx_business_glossary_term' = 'Freight Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_value_regex' = 'explosive|flammable|toxic|corrosive|radioactive|oxidizer');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `hazmat_un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DAP');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'pallet|box|drum|bag|barrel|crate');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|sea|pipeline|intermodal');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `approved_hazard_classes` SET TAGS ('dbx_business_glossary_term' = 'Approved Hazard Classes');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `average_load_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Average Load Capacity (tons)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `benchmark_comparison` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Comparison');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `benchmark_comparison` SET TAGS ('dbx_value_regex' = 'above|below|meets|exceeds');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_description` SET TAGS ('dbx_business_glossary_term' = 'Carrier Description');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'LTL|FTL|Rail|Intermodal|Tanker|ISO_Tank');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract End Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Start Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `corrective_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'C‑TPAT Certification Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `damage_claim_rate` SET TAGS ('dbx_business_glossary_term' = 'Damage Claim Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `dot_carrier_number` SET TAGS ('dbx_business_glossary_term' = 'DOT Carrier Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `fleet_size` SET TAGS ('dbx_business_glossary_term' = 'Fleet Size');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Certification');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `hazmat_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Incident Count');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `insurance_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider Name');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `oracle_tms_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle TMS Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `performance_on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On‑Time Delivery Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `performance_on_time_pickup_rate` SET TAGS ('dbx_business_glossary_term' = 'On‑Time Pickup Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `preferred_lanes` SET TAGS ('dbx_business_glossary_term' = 'Preferred Lanes');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `safety_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating Score');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `tender_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Tender Acceptance Rate (%)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Termination Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `tier_rating` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tier Rating');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `tier_rating` SET TAGS ('dbx_value_regex' = 'Tier1|Tier2|Tier3|Tier4|Tier5');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (FOID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `origin_location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `primary_freight_site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier (Customer ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `accessorial_charges` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges (USD)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice Number (ASN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number (BOL)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Acceptance Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_mode` SET TAGS ('dbx_business_glossary_term' = 'Carrier Mode of Transport (e.g., Truck, Rail, Air, Sea)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|sea');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `dot_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'DOT Regulation Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `epa_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Regulation Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type (e.g., Dry Van, Reefer)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_transit|delivered|cancelled|closed');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_rate` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate (USD)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class (DOT 49 CFR)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type (Full Truck Load, Less Than Truck Load, Partial, Hazardous Material, Refrigerated)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'ftl|ltl|partial|hazmat|refrigerated');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `number_of_pallets` SET TAGS ('dbx_business_glossary_term' = 'Number of Pallets');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number (FON)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_end` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `pickup_window_start` SET TAGS ('dbx_business_glossary_term' = 'Pickup Window Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Indicator');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `temperature_requirement_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature Requirement (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `tender_method` SET TAGS ('dbx_business_glossary_term' = 'Tender Method (Spot, Contract, Load Board)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `tender_method` SET TAGS ('dbx_value_regex' = 'spot|contract|load_board');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Amount (USD)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Volume (cubic meters)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `lab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Experiment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Party ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `condition_on_arrival` SET TAGS ('dbx_business_glossary_term' = 'Condition on Arrival');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `condition_on_arrival` SET TAGS ('dbx_value_regex' = 'good|damaged|contaminated|shortage');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Address');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected|exception');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Delivery Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `pod_document_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Document URL');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|gal|L|units|ton');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `received_by_name` SET TAGS ('dbx_business_glossary_term' = 'Receiver Name');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `received_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `received_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `receiver_signature` SET TAGS ('dbx_business_glossary_term' = 'Receiver Signature (Electronic)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Delivery Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|sea|pipeline|other');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `advance_ship_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Ship Notice Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Party Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `trial_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Research Trial Batch Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Asn Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `advance_ship_notice_status` SET TAGS ('dbx_business_glossary_term' = 'ASN Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `advance_ship_notice_status` SET TAGS ('dbx_value_regex' = 'pending|sent|acknowledged|error|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `asn_acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ASN Acknowledged Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice Number (ASN Number)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `asn_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ASN Sent Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `asn_type` SET TAGS ('dbx_business_glossary_term' = 'ASN Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `asn_type` SET TAGS ('dbx_value_regex' = 'shipment|return|rework|transfer|sample');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `carrier_pro_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier PRO Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier SCAC Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `compliance_document_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `expected_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `freight_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Adjustment Amount (USD)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `freight_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Gross Amount (USD)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `freight_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Net Amount (USD)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DAP|DDP|FCA');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Classification');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4|class_5|class_6');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `package_type_code` SET TAGS ('dbx_business_glossary_term' = 'Package Type Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `package_type_code` SET TAGS ('dbx_value_regex' = 'box|pallet|drum|IBC|bag|crate');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `route_optimization_flag` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `shipping_instructions` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instructions');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_business_glossary_term' = 'Shipping Mode');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_value_regex' = 'LTL|FTL|Air|Sea|Rail|Intermodal');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Volume (m3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|sea|pipeline|intermodal');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`advance_ship_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `hazmat_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Declaration ID (HAZMAT_DECL_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (CARRIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID (REVIEWER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID (SHIPMENT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation (REGULATION)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_value_regex' = 'DOT|IATA|IMDG');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date (COMPLIANCE_REVIEW_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date of Declaration (EFFECTIVE_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `emergency_response_guide_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Guide Number (ERG_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date of Declaration (EXPIRATION_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class (HAZARD_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `hazard_division` SET TAGS ('dbx_business_glossary_term' = 'Hazard Division (HAZARD_DIVISION)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `hazmat_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status (DECL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `hazmat_declaration_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Exempt from Regulation Flag (IS_EXEMPT)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Flag (IS_HAZARDOUS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (LINE_SEQ)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type (PACKAGING_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'drum|barrel|tank|pallet|bag|cylinder');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group (PACKING_GROUP)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment Requirements (PPE_REQ)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name (PROPER_SHIPPING_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity of Hazardous Material (QUANTITY)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|L|gal|lb');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `regulation_section` SET TAGS ('dbx_business_glossary_term' = 'Regulation Section Reference (REG_SECTION)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `segregation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Segregation Requirements (SEGREGATION_REQ)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `shipper_certification` SET TAGS ('dbx_business_glossary_term' = 'Shipper Certification Status (SHIPPER_CERT_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `shipper_certification` SET TAGS ('dbx_value_regex' = 'certified|not_certified');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `spill_response_instructions` SET TAGS ('dbx_business_glossary_term' = 'Spill Response Instructions (SPILL_RESPONSE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `temperature_limit_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Limit (TEMP_LIMIT_MAX)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `temperature_limit_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Limit (TEMP_LIMIT_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure (TEMP_UOM)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_value_regex' = 'C|F');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode (TRANSPORT_MODE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|air|sea|rail');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number (UN_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `shipment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (CARRIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `loading_dock_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock Identifier (DOCK_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper (Customer) Identifier (SHIPPER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `alternate_route_options` SET TAGS ('dbx_business_glossary_term' = 'Alternate Route Options Description (ALT_ROUTE_OPTS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Date (ARR_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `bridge_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Bridge Restriction Flag (BRIDGE_RESTRICTION)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `compliance_volume_limit_m3` SET TAGS ('dbx_business_glossary_term' = 'DOT Volume Compliance Limit (CUBIC METERS) (COMPL_VOL_LIMIT_M3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `compliance_weight_limit_kg` SET TAGS ('dbx_business_glossary_term' = 'DOT Weight Compliance Limit (KG) (COMPL_WGT_LIMIT_KG)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `cost_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Shipment Cost Adjustments (COST_ADJ)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `cost_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Shipment Cost (COST_GROSS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `cost_net` SET TAGS ('dbx_business_glossary_term' = 'Net Shipment Cost (COST_NET)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Date (DEP_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `estimated_transit_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Time (MINUTES) (EST_TRANSIT_MIN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount (CURRENCY) (FUEL_SURCH_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Basis (FUEL_SURCH_BASIS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `fuel_surcharge_basis` SET TAGS ('dbx_value_regex' = 'percentage|fixed|none');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `hazmat_route_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Route Flag (HAZMAT_ROUTE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Shipment Flag (EXPEDITED_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `load_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Loaded Volume (CUBIC METERS) (LOAD_VOL_M3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `load_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Loaded Weight (KG) (LOAD_WGT_KG)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Optimization Objective (OPT_OBJ)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `optimization_objective` SET TAGS ('dbx_value_regex' = 'cost|time|compliance');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Plan Number (PLAN_NO)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `plan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipment Plan Creation Timestamp (PLAN_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `planned_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Timestamp (PLAN_ARR_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `planned_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Departure Timestamp (PLAN_DEP_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `restricted_route_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Route Flag (RESTRICTED_ROUTE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `route_description` SET TAGS ('dbx_business_glossary_term' = 'Route Description (ROUTE_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `route_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Planned Route Distance (KM) (ROUTE_DIST_KM)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `shipment_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Plan Status (PLAN_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `shipment_plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|executed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Assignment (TEMP_ZONE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|heated');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Volume (CUBIC METERS) (TOTAL_VOL_M3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight (KG) (TOTAL_WGT_KG)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `tunnel_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Tunnel Restriction Flag (TUNNEL_RESTRICTION)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `vehicle_capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Volume Capacity (CUBIC METERS) (VEH_CAP_VOL_M3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `vehicle_capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Weight Capacity (KG) (VEH_CAP_WGT_KG)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type for Shipment (VEH_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_value_regex' = 'truck|trailer|reefer|tank|flatbed');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `commodity_class` SET TAGS ('dbx_business_glossary_term' = 'Commodity Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `compliance_hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'contracted|spot|dynamic');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CNY');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `destination_zone` SET TAGS ('dbx_business_glossary_term' = 'Destination Zone');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_description` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Description');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending|draft');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `fuel_surcharge_percent` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percent');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `hazmat_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Surcharge');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `is_contractual` SET TAGS ('dbx_business_glossary_term' = 'Is Contractual Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `lane_type` SET TAGS ('dbx_value_regex' = 'door_to_door|port_to_port|door_to_port|port_to_door');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal|pipeline');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `origin_zone` SET TAGS ('dbx_business_glossary_term' = 'Origin Zone');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_source_system` SET TAGS ('dbx_business_glossary_term' = 'Rate Source System');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_source_system` SET TAGS ('dbx_value_regex' = 'otm|sap|custom');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'base|accessorial|fuel_surcharge|minimum|hazmat|other');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'cwt|mile|flat|kg|ton');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `volume_limit_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume Limit (cubic meters)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `weight_limit_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Limit (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `shipment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `approved_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Payment Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `audit_pass_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Pass Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `audit_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Variance Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `base_freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Freight Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `demurrage_detention_amount` SET TAGS ('dbx_business_glossary_term' = 'Demurrage/Detention Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|open|resolved');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `hazmat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Fee Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|disputed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|express|hazmat|temperature_controlled');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|account_credit');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Invoice Remarks');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `total_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Shipment Volume (cubic meters)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_invoice` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (CDID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Exporter Party Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice Number (ASN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number (BOL)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|rejected|held');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166-1 Alpha-3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `customs_broker_name` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Name');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Filing Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number (CDN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|cleared|rejected|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type (Export/Import)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'export|import');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `declared_value` SET TAGS ('dbx_business_glossary_term' = 'Declared Value (Monetary Amount)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `duty_currency` SET TAGS ('dbx_business_glossary_term' = 'Duty Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `eccn` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `freight_currency` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `hazardous_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Classification');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `import_permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Import Permit Reference');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `is_lcl` SET TAGS ('dbx_business_glossary_term' = 'Less Than Container Load Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'box|drum|pallet');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `reach_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `tariff_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (m³)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `freight_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Claim ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (CARRIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PRODUCT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (SHIP_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number (BOL_NO)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `carrier_response_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Response Status (CARRIER_RESP)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `carrier_response_status` SET TAGS ('dbx_value_regex' = 'pending|responded|rejected');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service Number (CAS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_amount_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustments Amount (CLAIM_ADJ)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Claim Gross Amount (CLAIM_GROSS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_amount_net` SET TAGS ('dbx_business_glossary_term' = 'Claim Net Amount (CLAIM_NET)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freight Claim Filed Timestamp (FCFT)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Claim Number (FCN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Claim Status (FCS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'open|under_review|approved|rejected|settled|closed');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Freight Claim Type (FCT)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'loss|damage|shortage|contamination|theft');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `claimant_code` SET TAGS ('dbx_business_glossary_term' = 'Claimant Party Identifier (CLAIMANT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class (HAZ_CLASS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = 'explosive|flammable|corrosive|toxic|oxidizer|gas');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `incident_country` SET TAGS ('dbx_business_glossary_term' = 'Incident Country Code (ISO 3166-1 alpha-3)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `incident_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date (INC_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Address (INC_LOC)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `incident_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `incident_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description (LOSS_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `photos_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Photos Attached Flag (PHOTOS_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `proof_of_delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Number (POD_NO)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected (QTY_AFFECTED)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount (SETTLEMENT_AMT)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date (SETTLEMENT_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `supporting_documents_flag` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Attached Flag (SUPP_DOC_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_claim` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|l|gal|lb|m3');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `dock_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Dock Appointment ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `appointment_fee` SET TAGS ('dbx_business_glossary_term' = 'Appointment Fee');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check‑In Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check‑Out Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|CNY');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `dock_appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `dock_appointment_status` SET TAGS ('dbx_value_regex' = 'scheduled|checked_in|checked_out|cancelled|no_show');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `dock_door_code` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `hazmat_pre_staging_required` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Pre‑Staging Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `party_code` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `segregation_area` SET TAGS ('dbx_business_glossary_term' = 'Segregation Area');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `segregation_required` SET TAGS ('dbx_business_glossary_term' = 'Segregation Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`dock_appointment` ALTER COLUMN `wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Wait Time (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `annual_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Inspection Due Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `cleaning_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Certification Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `cleaning_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Certification Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `cleaning_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `compliance_documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `compliance_documentation_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `cross_contamination_prevention` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Contamination Prevention Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `dedicated` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Equipment Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `emission_class` SET TAGS ('dbx_business_glossary_term' = 'Emission Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|gasoline|electric|hydrogen|natural_gas');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPS Tracking Enabled');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_last_update` SET TAGS ('dbx_business_glossary_term' = 'GPS Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `hazmat_placard_capability` SET TAGS ('dbx_business_glossary_term' = 'Hazardous‑Material Placard Capability');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|exempt');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `last_cargo_code` SET TAGS ('dbx_business_glossary_term' = 'Last Cargo Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `license_plate` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `maintenance_cycle_km` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (km)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Manufacturer');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `max_payload_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payload (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Model');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `odometer_km` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (km)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'DOT Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `temperature_control_capability` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Capability');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_name` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Name');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_status` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Operational Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|out_of_service');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_type` SET TAGS ('dbx_value_regex' = 'tanker|flatbed|dry_van|iso_container|railcar|ibc_chassis');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vin_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `year_of_manufacture` SET TAGS ('dbx_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` SET TAGS ('dbx_association_edges' = 'rawmaterial.material_master,logistics.carrier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` ALTER COLUMN `carrier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Qualification - Carrier Qualification Id');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Qualification - Carrier Id');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Qualification - Material Master Id');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` SET TAGS ('dbx_association_edges' = 'logistics.carrier,pricing.price_list');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` ALTER COLUMN `carrier_pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrierpricingagreement - Carrier Pricing Agreement Id');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrierpricingagreement - Carrier Id');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective From');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier_pricing_agreement` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective To');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` SET TAGS ('dbx_subdomain' = 'freight_management');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `ein_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `ein_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` SET TAGS ('dbx_subdomain' = 'transport_execution');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `loading_dock_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Dock Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `paired_loading_dock_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `address_line` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `address_line` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`loading_dock` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
