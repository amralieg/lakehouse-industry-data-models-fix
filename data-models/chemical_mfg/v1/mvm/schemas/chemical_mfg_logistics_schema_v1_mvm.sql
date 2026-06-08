-- Schema for Domain: logistics | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`logistics` COMMENT 'Manages outbound and inbound freight execution including carrier selection, LTL/FTL shipment planning, hazardous materials transport compliance (DOT 49 CFR), route optimization, delivery confirmation, ASN generation, bill of lading, and transport documentation for regulated chemical shipments. Integrates with Oracle Transportation Management (TMS) for logistics cost optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Primary key for shipment',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Direct account link on shipment enables traceability of which customer a shipment belongs to, supporting delivery performance dashboards.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the transportation carrier responsible for the shipment.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Regulatory shipment manifest must link each shipment to the primary chemical product for SDS, GHS labeling and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation report requires each shipment charged to a cost center for accurate freight expense tracking.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Shipment routing in chemical manufacturing depends on site-specific constraints: delivery windows, dock restrictions, hazmat receiving capability, tank farm availability, and temperature control. dest',
    `distributor_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.distributor_agreement. Business justification: Shipments to chemical distributors must reference the governing distributor agreement to enforce SDS distribution obligations, responsible care compliance requirements, and authorized product category',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Shipment-level freight costs (freight_amount_gross/net) must be posted to specific GL accounts for freight expense reporting and P&L in chemical manufacturing SAP environments. Domain experts expect d',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Capital project deliveries and plant construction shipments in chemical manufacturing are tracked against internal orders for project cost settlement. Enables freight cost allocation to specific capit',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Shipment execution report ties each outbound shipment to the originating manufacturing order for traceability and regulatory compliance.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Each shipment fulfills a specific sales order; adding a FK ties the physical shipment to its originating order for end‑to‑end logistics tracking.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: Loading planning needs the precise warehouse location of origin for inventory allocation and temperature control compliance.',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Linking shipment to packaging configuration ensures correct DOT, IATA and hazmat labeling per product packaging for regulatory compliance.',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Chemical manufacturers track shipment volumes against long-term price agreements (take-or-pay, volume commitment contracts) for rebate accrual, volume attainment reporting, and contract compliance. Do',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Production‑to‑Shipment Traceability Report requires linking each shipment to the Production Plan that created the product.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis links each shipment to the profit center that owns the revenue stream.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Needed to associate each shipment with its originating purchase order for inbound receipt verification and logistics cost allocation.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to product.sds. Business justification: DOT, IATA, and IMDG regulations require the SDS version current at time of shipment to be traceable. Chemical manufacturers must document which SDS revision governed a hazmat shipment for incident res',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment was received at destination.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Real date and time when the shipment left the origin facility.',
    `asn_number` STRING COMMENT 'Identifier for the advanced shipping notice sent to the receiver.',
    `bill_of_lading_number` STRING COMMENT 'Reference number of the bill of lading document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for freight amounts.',
    `customs_declaration_number` STRING COMMENT 'Identifier for the customs declaration associated with the shipment.',
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
    `coa_document_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.coa_document. Business justification: Each inbound raw material shipment line must be accompanied by a Certificate of Analysis. coa_reference on shipment_line is a plain-text denormalization of coa_document; a proper FK enables automated ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual shipment lines in chemical manufacturing may be charged to different cost centers (e.g., different plants or product lines). Line-level cost center assignment supports granular freight cost',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Freight charges on shipment lines are cost components in chemical manufacturing product costing. Cost element assignment enables freight to be included in standard cost calculations and variance analy',
    `customer_allocation_id` BIGINT COMMENT 'Foreign key linking to planning.customer_allocation. Business justification: In chemical manufacturing, each shipment line fulfills a specific customer allocation — planners track allocation consumption against shipment execution to manage constrained supply. Allocation fulfil',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: In chemical manufacturing, multi-site customers receive split shipments where individual lines are routed to different customer sites. Line-level site assignment drives site-specific COA generation, S',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: freight_charge_amount on shipment_line requires GL account assignment for line-level freight cost posting in chemical manufacturing ERP. Enables accurate freight expense classification by product or h',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Chemical shipment lines carry a specific product grade (USP, ACS, technical). Grade determines COA requirements, handling instructions, and regulatory classification. Chemical manufacturing domain exp',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Line-level freight charge billing reconciliation: chemical manufacturers bill per shipment line (product, quantity, hazmat surcharge). Linking shipment_line to invoice_line enables line-level revenue ',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Shipment line items correspond to order line items; linking provides detailed fulfillment and billing reconciliation.',
    `shipment_id` BIGINT COMMENT 'Identifier of the parent shipment header.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Regulatory traceability (GHS/REACH) requires each shipment line to reference the exact inventory lot shipped.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Inbound raw material shipment lines must link directly to lot records for chain-of-custody traceability, recall management, and quality disposition. Chemical manufacturers require lot-level traceabili',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or product being shipped.',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Shipment lines ship chemicals in specific packaging configurations (drum, IBC, bulk tanker). Packaging config determines UN packaging code, hazmat certification, weight calculations, and DOT label req',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to planning.planned_order. Business justification: Shipment‑to‑Planned‑Order Traceability links each shipped line back to its originating Planned Order.',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: Chemical shipment lines must trace to the originating process order for batch traceability, COA issuance, and REACH/DOT regulatory audits. A domain expert expects this link to support quality-to-logis',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: In chemical manufacturing, each shipment line for a qualified product must reference the customer qualification record (APL number, COA template, spec deviation flags, max approved volume). This link ',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Enables traceability from shipped items back to the original quoted line for compliance, billing reconciliation, and margin analysis.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: OSHA HazCom and EU CLP require current SDS to accompany each hazardous chemical shipment line. In chemical manufacturing, the shipment_line already tracks ghs_label_required and dot_label_required; li',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Shipment lines execute at SKU level (specific pack size, packaging, grade). COA attachment, hazmat labeling, and weight calculations are SKU-specific. The existing `sku` column is a denormalized strin',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Pick‑by‑position processes need the exact stock position for each line to optimize warehouse operations.',
    `carrier_code` STRING COMMENT 'Code of the carrier responsible for transporting this line.',
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
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: A bill of lading is the legal contract of carriage issued for a freight order execution. bill_of_lading already links to shipment and shipment_plan, but lacks a direct FK to the freight_order that it ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: BOL freight_charge_amount and declared_value_amount require GL account assignment for freight expense and customs duty posting in chemical manufacturing. BOL is the primary financial document for frei',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Bills of lading for bulk chemical shipments must document the loading equipment (loading arms, tank filling stations) used for regulatory traceability and quality chain-of-custody. Chemical manufactur',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Bills of lading for hazardous chemical shipments require a named notify party — a specific customer contact with regulatory_notification_flag or ehs_contact_flag. This is a standard shipping document ',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: BOL is generated to fulfill a customer product order in chemical manufacturing. Order-to-cash traceability requires linking BOL back to the originating product order for invoicing, dispute resolution,',
    `outbound_delivery_id` BIGINT COMMENT 'Foreign key linking to product.outbound_delivery. Business justification: BOL is created from an outbound delivery in chemical manufacturing ERP (SAP SD). The outbound delivery triggers BOL generation; linking them enables freight cost allocation to delivery, proof-of-shipm',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: A bill of lading is generated for a single shipment; adding parent_logistics_shipment_id creates the required child‑to‑parent link.',
    `primary_bill_site_id` BIGINT COMMENT 'Reference to the party that is sending the shipment.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Bills of lading for chemical exports must align with the commercial quote for letter of credit compliance, export documentation accuracy, and customer billing. Customs authorities and banks require BO',
    `sds_id` BIGINT COMMENT 'Foreign key linking to product.sds. Business justification: BOLs for hazardous chemical shipments must reference the SDS for emergency response information (49 CFR 172.604). Chemical manufacturers attach SDS to BOL for first responder access. Regulatory compli',
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
    `billing_party_id` BIGINT COMMENT 'Foreign key linking to billing.party. Business justification: Carrier AP invoice processing: carriers are represented as billing parties for freight invoice payment. Role prefix billing_ used because carrier is a logistics entity distinct from billing.party. E',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Carriers must be qualified to transport specific chemical products based on hazmat class, temperature requirements, and regulatory approvals. Chemical manufacturers maintain carrier qualification matr',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Carrier payments in chemical manufacturing are posted to freight payable and carrier expense GL accounts. Carrier-level GL assignment enables automatic account determination in accounts payable proces',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Carrier AP payment processing: chemical manufacturers negotiate payment terms per carrier contract. Linking carrier to billing.payment_term enables freight invoice due-date calculation, early payment ',
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
    `qualification_status` STRING COMMENT 'Current qualification status (e.g., Approved, Pending, Revoked)',
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
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Freight order execution in chemical manufacturing requires a designated customer contact for delivery scheduling, dock access coordination, and hazmat receiving confirmation. The contacts ehs_contact',
    `site_id` BIGINT COMMENT 'Reference to the location where the shipment is to be delivered.',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_rate. Business justification: A freight order is executed at a specific contracted or spot freight rate. freight_order currently has freight_rate (DECIMAL) as a denormalized rate value. Adding freight_rate_id FK to the freight_rat',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: freight_order.total_amount and accessorial_charges must be posted to GL accounts for freight expense recognition. In chemical manufacturing, freight order GL assignment drives accounts payable posting',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Internal order tracking ties each freight procurement to an internal order for approval workflow and spend control.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Freight Order Planning uses material master data to determine carrier selection, hazmat handling, and temperature requirements; linking to material_master provides the necessary material specification',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: Freight orders are created to execute customer product orders in chemical manufacturing TMS. freight_order has purchase_order_id (supply side) but no sales product_order link. Direct FK enables freigh',
    `origin_location_site_id` BIGINT COMMENT 'Reference to the location where the shipment originates.',
    `outbound_delivery_id` BIGINT COMMENT 'Foreign key linking to product.outbound_delivery. Business justification: Freight orders execute the physical movement initiated by outbound deliveries in chemical manufacturing ERP-TMS integration. Direct FK enables freight cost allocation to specific deliveries, delivery ',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: A freight order is tendered for a specific shipment; linking to shipment provides the parent reference.',
    `primary_freight_site_id` BIGINT COMMENT 'Identifier of the shipper (internal customer) that owns the freight order.',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: Freight orders for finished chemicals are initiated upon process order completion. Linking freight_order to process_order enables cost allocation to the correct production order, supports shipment-to-',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Freight Order Generation Process creates freight orders only after a Production Plan is firmed.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Freight orders represent revenue-generating logistics activity in chemical manufacturing. Profit center assignment enables freight cost and revenue attribution by business segment for segment reportin',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Required for generating freight orders from purchase orders; enables carrier tendering and freight cost tracking per PO.',
    `shipment_plan_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_plan. Business justification: A freight order is executed against a shipment plan that defines the route, load, and cost parameters. freight_order already links to shipment (header) but lacks a direct FK to the shipment_plan that ',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: Freight orders are created to execute supply plan commitments in chemical manufacturing — supply planners monitor freight order status to confirm supply plan execution and identify gaps. Supply plan e',
    `tank_id` BIGINT COMMENT 'Foreign key linking to inventory.tank. Business justification: Bulk liquid chemical freight orders originate from specific tank farm tanks. Logistics coordinators must reference the source tank to schedule tanker truck loading, verify product compatibility, and c',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle. Business justification: A freight order is tendered to a carrier for execution using a specific vehicle or trailer. freight_order currently has trailer_number (STRING) and equipment_type (STRING) as denormalized references. ',
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
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials subject to DOT regulations.',
    `hazmat_class` STRING COMMENT 'DOT classification of hazardous material (e.g., 1, 2, 3, 4, 5, 6, 9).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this freight order record.',
    `load_type` STRING COMMENT 'Classification of the shipment load based on size, hazard, and temperature requirements.. Valid values are `ftl|ltl|partial|hazmat|refrigerated`',
    `number_of_pallets` STRING COMMENT 'Count of pallets included in the freight order.',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: Delivery confirmation for chemical products must reference the batch record to verify correct batch identity, COA validity, expiry date, and quality status at point of delivery. GMP compliance and cus',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Delivery confirmation includes carrier name/scac; carrier_id FK links to carrier master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Delivery confirmation ties actual receipt to the cost center responsible for the inbound logistics spend.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: A delivery confirmation (proof-of-delivery) closes out a freight order upon successful delivery. delivery_confirmation already links to shipment (header) but lacks a direct FK to the freight_order tha',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Proof‑of‑delivery is required for invoice settlement; linking POD to its invoice supports audit and payment release.',
    `logistics_party_id` BIGINT COMMENT 'Identifier of the customer or receiving party that accepted the shipment.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Proof-of-delivery for chemical shipments requires lot-level traceability for CoA matching, recall response, and regulatory compliance (FDA, REACH). Chemical receivers must confirm the exact lot delive',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Raw material delivery confirmations must reference the lot record to trigger incoming inspection, update receipt status, and maintain chain-of-custody. lot_number on delivery_confirmation is a denorma',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: Delivery confirmation closes the order-to-cash cycle. In chemical manufacturing, POD (proof of delivery) is matched to the product order to trigger invoicing and revenue recognition. Direct FK enables',
    `outbound_delivery_id` BIGINT COMMENT 'Foreign key linking to product.outbound_delivery. Business justification: Delivery confirmation is the downstream event that closes an outbound delivery in chemical manufacturing logistics. One outbound delivery generates one delivery confirmation (POD). This link is requir',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Delivery confirmation records proof of delivery for a shipment; linking to shipment ties the POD to its shipment.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Delivery confirmation triggers revenue recognition in chemical manufacturing. Profit center assignment at delivery confirmation enables revenue attribution by business segment, supporting segment P&L ',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: In chemical manufacturing, hazmat deliveries must be received by an authorized customer contact (EHS-certified, with purchase_order_authority_limit). Linking delivery_confirmation to customer.contact ',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Proof-of-delivery reconciliation in chemical manufacturing requires matching the delivery to the specific customer site (dock restrictions, hazmat receiving capability, COA/SDS requirements per site).',
    `condition_on_arrival` STRING COMMENT 'Observed condition of the goods at the time of receipt.. Valid values are `good|damaged|contaminated|shortage`',
    `confirmation_number` STRING COMMENT 'External reference number assigned to the proof‑of‑delivery document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery confirmation record was first created in the system.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Quantity of product actually delivered to the receiver.',
    `delivery_confirmation_status` STRING COMMENT 'Current processing state of the delivery confirmation.. Valid values are `pending|confirmed|rejected|exception`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment was physically received by the customer.',
    `discrepancy_notes` STRING COMMENT 'Free‑text notes describing any shortages, damages, or other issues noted on receipt.',
    `exception_code` STRING COMMENT 'Standardized code indicating the type of exception, if any, associated with the delivery.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'True if the shipment contains hazardous materials subject to DOT 49 CFR.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage measured at the delivery location.',
    `pod_document_url` STRING COMMENT 'Link to the stored electronic proof‑of‑delivery document.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the delivered quantity.. Valid values are `kg|lb|gal|L|units|ton`',
    `receiver_signature` STRING COMMENT 'Electronic representation of the signature captured from the receiver as proof of delivery.',
    `regulatory_compliance_flag` STRING COMMENT 'Indicates whether the delivery met all applicable regulatory requirements.. Valid values are `compliant|non_compliant|exempt`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature recorded at the delivery location, in degrees Celsius.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the shipment.. Valid values are `truck|rail|air|sea|pipeline|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the delivery confirmation record.',
    CONSTRAINT pk_delivery_confirmation PRIMARY KEY(`delivery_confirmation_id`)
) COMMENT 'Record of proof-of-delivery (POD) for completed chemical shipments. Captures actual delivery date and time, receiver name and signature, delivery location, condition of goods on arrival, any noted discrepancies (shortage, damage, contamination), exception codes, and electronic POD document reference. Triggers downstream billing and COA release workflows.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` (
    `hazmat_declaration_id` BIGINT COMMENT 'System‑generated unique identifier for the hazmat declaration record.',
    `carrier_id` BIGINT COMMENT 'Unique identifier for the carrier (e.g., MC/MX number).',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Hazmat declarations are product-specific regulatory documents (DOT 49 CFR, IATA DGR). Direct FK to chemical_product enables product-level hazmat compliance reporting and regulatory audit without joini',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Hazmat surcharge and compliance costs are charged to the cost center responsible for the shipment.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: PSM-covered chemical plants require hazmat declarations to reference the functional location (loading bay, chemical transfer area) where hazardous materials are handled. This supports OSHA PSM complia',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Hazmat compliance costs (PPE, emergency response, regulatory fees) in chemical manufacturing are posted to specific EHS GL accounts. GL assignment on hazmat_declaration enables EHS cost tracking and r',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Hazmat compliance programs in chemical manufacturing track costs (training, PPE, emergency response planning) against internal orders for EHS budget management and regulatory audit trails. Internal or',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: OSHA PSM and EPA RMP require documentation of specific loading/filling equipment used when transferring hazardous chemicals. Hazmat declarations must reference the pump, loading arm, or filling statio',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Hazmat Declaration must reference the exact material to populate UN number, hazard class, and safety data; a material_master_id FK provides the authoritative source.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: SARA Title III and EPA TRI reporting require aggregating hazmat shipment quantities by originating facility annually. Chemical manufacturing EHS teams link hazmat declarations to the EHS facility reco',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: Hazmat declarations under DOT 49 CFR and IATA DGR must be reconcilable with the process order that produced the chemical, confirming hazard classification, UN number, and packing group match productio',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis includes hazmat handling fees allocated to the profit center of the product line.',
    `regulatory_profile_id` BIGINT COMMENT 'Foreign key linking to customer.regulatory_profile. Business justification: DOT/IATA hazmat declaration generation in chemical manufacturing must be validated against the receiving customers regulatory profile (end-use declaration, UN number, hazmat transport class, REACH/TS',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: DOT 49 CFR and OSHA HazCom require the SDS to be the authoritative source for proper shipping name, hazard class, and emergency response info on hazmat declarations. Chemical manufacturing compliance ',
    `sds_id` BIGINT COMMENT 'Foreign key linking to product.sds. Business justification: The SDS is the authoritative source for hazmat declaration data: UN number, hazard class, packing group, proper shipping name, emergency response. Regulatory traceability from hazmat declaration to th',
    `sds_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.sds_record. Business justification: DOT/IATA/IMDG regulations require hazmat declarations to be backed by a current SDS for proper shipping name, UN number, hazard class, packing group, and emergency response data. Chemical logistics ex',
    `shipment_id` BIGINT COMMENT 'Identifier of the shipment to which this hazmat declaration belongs.',
    `shipment_line_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_line. Business justification: The hazmat_declaration product description explicitly states it is a consolidated hazardous materials compliance record for each regulated chemical shipment LINE. The existing FK hazmat_declaration.',
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
    `billing_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.billing_schedule. Business justification: Contract/milestone billing alignment: chemical manufacturers with contract customers bill on schedules tied to planned shipments. Linking shipment_plan to billing_schedule enables milestone billing tr',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to production.campaign. Business justification: Chemical manufacturers plan carrier capacity and route optimization at the campaign level — a production campaign produces a defined volume that drives bulk shipment planning. Linking shipment_plan to',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to the plan.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Planning costs (fuel surcharge, route optimization) are budgeted against the cost center owning the shipment.',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_rate. Business justification: A shipment plan is costed against a contracted or spot freight rate for the applicable lane, mode, and carrier. shipment_plan has cost_gross, cost_net, fuel_surcharge_amount as computed cost fields bu',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: shipment_plan.cost_gross/cost_net/fuel_surcharge_amount require GL account assignment for planned freight cost posting and budget vs. actual freight expense reporting in chemical manufacturing financi',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: Shipment plans are created to fulfill confirmed customer product orders in chemical manufacturing. S&OP and logistics planning processes require direct traceability from shipment plan to the product o',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Shipment planning for chemical facilities must respect EHS facility constraints: permitted hazmat storage quantities, operating permit conditions, and Tier II threshold limits. Linking shipment_plan t',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Shipment plan is created to plan a particular shipment; linking to shipment establishes the parent‑child hierarchy.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Integrated Production & Logistics Scheduling aligns route plans with the Production Schedule for on‑time departures.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis uses planned shipment cost data linked to the profit center of the product line.',
    `site_id` BIGINT COMMENT 'Identifier of the shipper (customer) who owns the shipment.',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: Shipment plans are the logistics execution of supply plans in chemical manufacturing — when a supply plan calls for product movement, a shipment plan is created. Supply-to-logistics traceability repor',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle. Business justification: A shipment plan assigns a specific vehicle for route optimization and load planning. shipment_plan currently has vehicle_type (STRING) and vehicle_capacity_weight_kg/volume_m3 as denormalized fields. ',
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
    CONSTRAINT pk_shipment_plan PRIMARY KEY(`shipment_plan_id`)
) COMMENT 'Consolidated shipment planning record combining route optimization and load planning for one or more shipments. Captures planned route legs, waypoints, estimated transit times, distance, fuel surcharge basis, restricted route flags (tunnel/bridge restrictions for hazmat per DOT 49 CFR §397.71), alternate route options, optimization objective (cost/time/compliance), load consolidation details, vehicle type and capacity assignment, actual loaded weight and volume, load sequence, temperature zone assignments for mixed chemical loads, and loading dock assignment. Supports DOT hazmat routing compliance, freight utilization optimization, and DOT weight compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` (
    `freight_rate_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each freight rate record.',
    `carrier_id` BIGINT COMMENT 'Unique identifier of the carrier (shipping provider) that offers this rate.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Freight rates are cost components in chemical manufacturing product costing. Cost element assignment on freight rate master enables freight cost to be included in standard cost rolls and activity-base',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Freight rate types (base, hazmat surcharge, fuel surcharge) map to specific GL accounts for freight expense classification in chemical manufacturing. GL assignment on rate master enables automatic acc',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: In chemical manufacturing, freight rate contracts are negotiated by customer segment (strategic accounts, hazmat-certified segments, bulk chemical segments). Segment-specific freight rates drive prici',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` (
    `customs_declaration_id` BIGINT COMMENT 'Unique system-generated identifier for the customs declaration record.',
    `carrier_id` BIGINT COMMENT 'System identifier for the carrier entity.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Customs declarations for chemical exports require product-level data: HS code, ECCN, REACH registration, hazard classification. Direct FK to chemical_product enables export control compliance reportin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Customs duties and fees are booked to the cost center that owns the imported material.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Customs duty accrual in chemical manufacturing requires fiscal period assignment for accurate period-end financial close. Import duties must be accrued in the correct fiscal period for GAAP/IFRS compl',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: A customs declaration for international chemical shipments must reference the specific freight order being cleared through customs. customs_declaration already links to shipment (header) and carrier, ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: customs_declaration.duty_amount and freight_cost must be posted to import duty expense and freight GL accounts. In chemical manufacturing with global supply chains, customs duty GL posting is a mandat',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customs duties are billed; linking declaration to invoice enables duty charge aggregation on the same invoice.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Chemical export/import customs declarations require lot-level data for country-of-origin certification, restricted substance declarations (REACH, RoHS), and purity verification. Customs brokers and re',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Customs declaration is filed for a specific shipment; linking provides direct reference to the shipment.',
    `account_id` BIGINT COMMENT 'Identifier of the exporting party (company) responsible for the shipment.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability reporting requires customs cost allocation to the profit center generating the revenue.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to product.sds. Business justification: SDS data (GHS classification, UN number, REACH registration number, hazard statements) is required input for chemical customs declarations. Regulatory traceability from customs declaration to the SDS ',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'System-generated unique identifier for each vehicle or transport equipment record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Vehicles are owned and operated by carriers in chemical logistics. A carrier maintains a fleet of vehicles (trucks, tankers, specialized hazmat transport units). This 1:N relationship (one carrier has',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vehicle operating costs (maintenance, fuel, inspection) in chemical manufacturing are charged to cost centers for fleet cost management reporting. Direct vehicle-to-cost-center assignment is standard ',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Chemical transport vehicles (tankers, ISO containers, rail cars) are registered as maintainable equipment assets subject to PSM inspection schedules, cleaning certifications, and regulatory compliance',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Vehicles in chemical manufacturing are capitalized fixed assets tracked in the fixed asset register for depreciation, insurance, and compliance reporting. Domain experts universally expect vehicle-to-',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` (
    `logistics_party_id` BIGINT COMMENT 'Primary key for party',
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
    `notes` STRING COMMENT 'Free-form notes or comments about the party.',
    `party_name` STRING COMMENT 'Full legal name of the party as registered.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party record.',
    `party_type` STRING COMMENT 'Classification of the partys role in logistics operations.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the party.',
    `phone_number` STRING COMMENT 'Primary telephone number for the party.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the partys address.',
    `preferred_carrier` STRING COMMENT 'Designated carrier preferred by the party for shipments.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for primary communications with the party.',
    `state_province` STRING COMMENT 'State or province of the partys address.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the party is exempt from sales tax.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identifier for the party.',
    `termination_date` DATE COMMENT 'Date when the party relationship was terminated, if applicable.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the partys primary location.',
    `trade_name` STRING COMMENT 'Commonly used name or brand of the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the party record.',
    CONSTRAINT pk_logistics_party PRIMARY KEY(`logistics_party_id`)
) COMMENT 'Master reference table for party. Referenced by receiver_party_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ADD CONSTRAINT `fk_logistics_shipment_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ADD CONSTRAINT `fk_logistics_bill_of_lading_shipment_plan_id` FOREIGN KEY (`shipment_plan_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_plan`(`shipment_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_rate`(`freight_rate_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_shipment_plan_id` FOREIGN KEY (`shipment_plan_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_plan`(`shipment_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_logistics_party_id` FOREIGN KEY (`logistics_party_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`logistics_party`(`logistics_party_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ADD CONSTRAINT `fk_logistics_delivery_confirmation_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ADD CONSTRAINT `fk_logistics_hazmat_declaration_shipment_line_id` FOREIGN KEY (`shipment_line_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment_line`(`shipment_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_freight_rate_id` FOREIGN KEY (`freight_rate_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_rate`(`freight_rate_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ADD CONSTRAINT `fk_logistics_shipment_plan_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`freight_order`(`freight_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `chemical_mfg_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `distributor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Warehouse Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `coa_document_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Document Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `customer_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Header ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `tare_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `un_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'UN Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'kg|l|pcs|gal');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Notify Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `outbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `primary_bill_site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`bill_of_lading` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `billing_party_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Party Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Qualification - Material Master Id');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`carrier` ALTER COLUMN `qualification_status` SET TAGS ('dbx_operational' = 'true');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (FOID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `origin_location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `outbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `primary_freight_site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier (Customer ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `shipment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class (DOT 49 CFR)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type (Full Truck Load, Less Than Truck Load, Partial, Hazardous Material, Refrigerated)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'ftl|ltl|partial|hazmat|refrigerated');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_order` ALTER COLUMN `number_of_pallets` SET TAGS ('dbx_business_glossary_term' = 'Number of Pallets');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `logistics_party_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Party ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `outbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Contact Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `condition_on_arrival` SET TAGS ('dbx_business_glossary_term' = 'Condition on Arrival');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `condition_on_arrival` SET TAGS ('dbx_value_regex' = 'good|damaged|contaminated|shortage');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Number');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Status');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected|exception');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Delivery Humidity (%)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `pod_document_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Document URL');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|gal|L|units|ton');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `receiver_signature` SET TAGS ('dbx_business_glossary_term' = 'Receiver Signature (Electronic)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Delivery Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|sea|pipeline|other');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`delivery_confirmation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `hazmat_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Declaration ID (HAZMAT_DECL_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (CARRIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `regulatory_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Profile Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID (SHIPMENT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`hazmat_declaration` ALTER COLUMN `shipment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Line Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `shipment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `billing_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (CARRIER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper (Customer) Identifier (SHIPPER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`shipment_plan` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`freight_rate` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (CDID)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logistics Shipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Exporter Party Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`customs_declaration` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`vehicle` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` SET TAGS ('dbx_subdomain' = 'freight_operations');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `logistics_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `ein_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `ein_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`logistics`.`logistics_party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
