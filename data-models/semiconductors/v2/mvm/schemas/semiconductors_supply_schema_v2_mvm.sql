-- Schema for Domain: supply | Business: Semiconductors | Version: v2_mvm
-- Generated on: 2026-06-24 01:59:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_semiconductors_v1`.`supply` COMMENT 'End-to-end semiconductor supply chain including supplier master data, raw material procurement, subcontractor management, OSAT vendor relationships, and inbound logistics. Owns supplier qualification records, approved vendor lists, lead time data, supply risk assessments, and material planning.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'System-generated unique identifier for the supplier record.',
    `address_line1` STRING COMMENT 'First line of the suppliers primary address.',
    `address_line2` STRING COMMENT 'Second line of the suppliers primary address (optional).',
    `approval_date` DATE COMMENT 'Date when the supplier was approved for procurement.',
    `approved_by` STRING COMMENT 'Name of the internal user who approved the supplier onboarding.',
    `city` STRING COMMENT 'City component of the suppliers primary address.',
    `supplier_code` STRING COMMENT '',
    `compliance_status` STRING COMMENT 'Current compliance standing of the supplier with internal and external regulations.. Valid values are `compliant|non_compliant|under_review`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the suppliers primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the supplier.',
    `currency_code` STRING COMMENT 'Default transaction currency used with the supplier.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the supplier organization.. Valid values are `^[0-9]{9,10}$`',
    `ear_controlled` BOOLEAN COMMENT 'Indicates whether the supplier is subject to EAR export controls.',
    `export_control_classification` STRING COMMENT 'Export classification code for the suppliers products or services.. Valid values are `EAR99|ECCN5A|ECCN5B`',
    `financial_rating` STRING COMMENT 'Credit rating assigned to the supplier based on financial health.. Valid values are `A|B|C|D|E`',
    `global_footprint` STRING COMMENT 'Scope of the suppliers operational presence.. Valid values are `Global|Regional|Local`',
    `industry_classification` STRING COMMENT 'Broad industry segment to which the supplier belongs.. Valid values are `Raw Material|Chemical|Equipment|OSAT|Design Service`',
    `is_certified_kga` BOOLEAN COMMENT 'Indicates whether the supplier holds a KGA (Known Good Assembly) certification.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the supplier is subject to ITAR export controls.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier quality or compliance audit.',
    `lead_time_days` STRING COMMENT 'Typical number of days from order placement to delivery.',
    `legal_name` STRING COMMENT 'Full legal registered name of the supplier entity.',
    `supplier_name` STRING COMMENT 'Primary display name of the supplier used in business transactions.',
    `notes` STRING COMMENT 'Additional remarks or comments about the supplier.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier.. Valid values are `Net30|Net45|Net60|Cash`',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the suppliers primary address.',
    `preferred_logistics_partner` STRING COMMENT 'Logistics provider most frequently used for shipments from this supplier.',
    `primary_contact_name` STRING COMMENT 'Name of the main contact person for the supplier.',
    `primary_email` STRING COMMENT 'Email address of the primary supplier contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Telephone number of the primary supplier contact.. Valid values are `^+?[0-9]{7,15}$`',
    `quality_rating` STRING COMMENT 'Overall quality performance rating based on audits and defect data.. Valid values are `Excellent|Good|Fair|Poor`',
    `registration_number` STRING COMMENT 'Official registration number of the suppliers legal entity.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score derived from financial, geopolitical, and operational factors.',
    `state_province` STRING COMMENT 'State or province of the suppliers primary address.',
    `supplier_group` STRING COMMENT 'Business grouping used for strategic sourcing and spend analysis.. Valid values are `Strategic|Preferred|Standard|Transactional`',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier record.. Valid values are `active|inactive|suspended|pending|terminated`',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on strategic importance and spend volume.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers environmental and social responsibility performance.',
    `tax_number` STRING COMMENT 'Government‑issued tax registration number for the supplier.. Valid values are `^[A-Z0-9]{10,15}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the supplier record.',
    `website` STRING COMMENT 'Public website URL of the supplier.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all semiconductor supply chain vendors including raw material suppliers, chemical suppliers, gas suppliers, photomask vendors, OSAT partners, and subcontractors. Captures supplier identity, classification (Tier 1/2/3), business registration, DUNS number, geographic footprint, financial health rating, strategic importance, and ITAR/EAR export control classification. SSOT for supplier identity across the supply domain. Sourced from SAP S/4HANA MM Vendor Master.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` (
    `approved_vendor_id` BIGINT COMMENT 'Primary key for approved_vendor',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — AVL records approve a supplier FOR a specific material category. The material_master is the SSOT for whats being approved.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Each approved vendor record belongs to a single supplier; linking provides parent‑child hierarchy and removes redundant supplier details that may exist in approved_vendor.',
    `supplier_qualification_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_qualification. Business justification: An Approved Vendor List (AVL) entry is the outcome of a formal supplier qualification process. The approved_vendor record should reference the supplier_qualification that authorized the vendors inclu',
    `address_line1` STRING COMMENT 'First line of the vendors street address.',
    `address_line2` STRING COMMENT 'Second line of the vendors street address (optional).',
    `approval_date` DATE COMMENT 'Date on which the vendor was granted approved status.',
    `approval_status` STRING COMMENT 'Current qualification status of the vendor within the Approved Vendor List.. Valid values are `approved|pending|rejected|revoked`',
    `approved_commodity_scope` STRING COMMENT 'List or description of material categories, chemical families, or process inputs the vendor is qualified to supply.',
    `approved_vendor_status` STRING COMMENT 'Overall operational status of the vendor within the enterprise.. Valid values are `active|inactive|expired|suspended|pending`',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical result of the latest audit (0‑100).',
    `city` STRING COMMENT 'City component of the vendors address.',
    `compliance_certifications` STRING COMMENT 'Comma‑separated list of certifications (e.g., ISO 9001, IATF 16949, RoHS) held by the vendor.',
    `country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 country code of the vendors primary location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency` STRING COMMENT 'Currency code used for transactions with the vendor.. Valid values are `^[A-Z]{3}$`',
    `approved_vendor_description` STRING COMMENT 'Free‑form text providing additional context or notes about the vendor.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the vendor organization.',
    `expiry_date` DATE COMMENT 'Date on which the vendors approved status expires unless renewed.',
    `financial_rating` STRING COMMENT 'Credit rating assigned to the vendor based on financial health.. Valid values are `A|B|C|D|E|F`',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from order placement to material receipt for this vendor.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the vendor.. Valid values are `net30|net45|net60|cash|prepay`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendors address.',
    `primary_contact_email` STRING COMMENT 'Email address of the vendors primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the main point of contact for the vendor.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the vendors primary contact.',
    `quality_tier` STRING COMMENT 'Internal quality classification assigned to the vendor based on performance and compliance.. Valid values are `tier1|tier2|tier3|tier4`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the approved vendor record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approved vendor record.',
    `regulatory_status` STRING COMMENT 'Current status of the vendor with respect to applicable semiconductor regulations.. Valid values are `compliant|non_compliant|under_review`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) derived from supply‑risk assessments.',
    `state` STRING COMMENT 'State or province component of the vendors address.',
    `tax_number` STRING COMMENT 'Vendors tax registration number for invoicing and compliance.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vendor_code` STRING COMMENT 'Internal alphanumeric code used to uniquely identify the vendor within the enterprise.',
    `vendor_name` STRING COMMENT 'Full legal name of the supplier organization.',
    `vendor_type` STRING COMMENT 'Category of the vendor based on its role in the semiconductor supply chain.. Valid values are `supplier|subcontractor|osat|service_provider`',
    CONSTRAINT pk_approved_vendor PRIMARY KEY(`approved_vendor_id`)
) COMMENT 'Approved Vendor List (AVL) records establishing which suppliers are qualified and authorized to supply specific material categories, chemical families, or process inputs to the fab. Tracks qualification status, approval date, expiry date, approved commodity scope, quality tier, and the engineering/procurement authority who granted approval. Supports DFM and process qualification gating. Sourced from Oracle Agile PLM and SAP MM.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'System-generated unique identifier for each material master record.',
    `supplier_id` BIGINT COMMENT 'Reference to the approved vendor supplying this material.',
    `base_uom` STRING COMMENT 'Standard unit of measure used for inventory and procurement transactions (e.g., kg, L, pcs).',
    `batch_management` BOOLEAN COMMENT 'True if the material is managed in batches for traceability.',
    `country_of_origin` STRING COMMENT 'Three‑letter ISO country code indicating where the material originates.. Valid values are `USA|CHN|KOR|JPN|DEU|TWN`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency for the standard cost.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `expiration_date` DATE COMMENT 'Date after which the material must not be used.',
    `hazardous_classification` STRING COMMENT 'Regulatory classification indicating the materials hazardous status under RoHS, REACH, and TSCA.. Valid values are `non_hazardous|hazardous|restricted|controlled`',
    `lead_time_days` STRING COMMENT 'Average number of days from purchase order issuance to receipt of the material.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the material record.. Valid values are `active|inactive|discontinued|pending`',
    `lot_size_qty` DECIMAL(18,2) COMMENT 'Standard production or procurement lot size for the material.',
    `material_description` STRING COMMENT 'Detailed textual description of the material, including its purpose and key characteristics.',
    `material_name` STRING COMMENT 'Human‑readable name or title of the material.',
    `material_number` STRING COMMENT 'Business-visible alphanumeric code that uniquely identifies the material across the enterprise.',
    `material_type` STRING COMMENT 'Classification of the material by its functional role in semiconductor manufacturing.. Valid values are `raw|consumable|component|packaging|chemical|gas`',
    `max_order_qty` DECIMAL(18,2) COMMENT 'Largest quantity that can be ordered in a single purchase order.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from a supplier.',
    `procurement_group` STRING COMMENT 'Organizational group responsible for procuring the material.',
    `quality_inspection_required` BOOLEAN COMMENT 'True if incoming or in‑process inspection is mandatory for the material.',
    `reach_compliant` BOOLEAN COMMENT 'True if the material meets the Registration, Evaluation, Authorisation and Restriction of Chemicals (REACH) requirements.',
    `reorder_point_qty` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order.',
    `rohs_compliant` BOOLEAN COMMENT 'True if the material complies with the Restriction of Hazardous Substances (RoHS) directive.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Quantity of material kept on hand to protect against demand or supply variability.',
    `serial_management` BOOLEAN COMMENT 'True if the material is tracked by serial numbers.',
    `shelf_life_days` STRING COMMENT 'Number of days the material can be stored before it expires.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Default cost used for valuation and planning, expressed in the base currency.',
    `storage_humidity_max_pct` DECIMAL(18,2) COMMENT 'Highest permissible relative humidity percentage for storage.',
    `storage_humidity_min_pct` DECIMAL(18,2) COMMENT 'Lowest permissible relative humidity percentage for storage.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Highest permissible storage temperature in degrees Celsius.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Lowest permissible storage temperature in degrees Celsius.',
    `tsca_compliant` BOOLEAN COMMENT 'True if the material is compliant with the US Toxic Substances Control Act (TSCA).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the material master record.',
    `valuation_class` STRING COMMENT 'Key for grouping materials with similar accounting treatment.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Authoritative master record for all procured materials used in semiconductor manufacturing: silicon wafer substrates, process chemicals (slurries, etchants, photoresists), specialty gases (silane, nitrogen, argon), photomasks, packaging substrates, lead frames, bonding wire, and consumables. Captures material number, description, material type, base unit of measure, hazardous material classification (RoHS/REACH/TSCA), storage conditions, shelf life, procurement lead time, safety stock levels, reorder points, and lot sizing parameters. SSOT for material identity and procurement parameters within the supply domain.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'System-generated unique identifier for the purchase order record.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier (vendor) to which the purchase order is issued.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Purchase orders specify destination storage location for delivery in semiconductor ERP. purchase_order has storage_location (plain attr, denormalized). This link enables receiving dock assignment, inv',
    `actual_delivery_date` DATE COMMENT 'Date when goods/services were actually received.',
    `approval_date` DATE COMMENT 'Date when the purchase order was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the purchase order.. Valid values are `pending|approved|rejected`',
    `compliance_flags` STRING COMMENT 'Semicolon‑separated list of compliance indicators (e.g., RoHS, REACH).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was first captured in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts on the PO.',
    `delivery_schedule` STRING COMMENT 'Free‑text description of delivery windows or milestones.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount granted on the gross amount.',
    `expected_delivery_date` DATE COMMENT 'Planned date for goods/services to be delivered.',
    `export_control_classification` STRING COMMENT 'Export classification code (e.g., EAR99, ITAR, ECCN) for the items on the PO.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Monetary cost of freight/shipping.',
    `freight_terms` STRING COMMENT 'Responsibility for freight costs.. Valid values are `prepaid|collect|third_party`',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — 7 candidates stripped; promote to reference product]',
    `is_ear_controlled` BOOLEAN COMMENT 'Indicates whether the PO is subject to U.S. Export Administration Regulations.',
    `lead_time_days` STRING COMMENT 'Planned number of days from PO issuance to expected receipt.',
    `material_description` STRING COMMENT 'Human‑readable description of the material or service.',
    `material_number` STRING COMMENT 'Identifier of the material or service being procured.',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the purchase order was initially created/submitted.',
    `payment_terms` STRING COMMENT 'Agreed payment schedule and conditions for the purchase order.. Valid values are `NET30|NET45|NET60|PREPAID|COD`',
    `plant` STRING COMMENT 'SAP plant code where the goods are to be received.',
    `po_number` STRING COMMENT 'External business identifier assigned to the purchase order by the procurement system.',
    `purchase_group` STRING COMMENT 'Organizational group responsible for the procurement.',
    `purchase_order_status` STRING COMMENT 'Current lifecycle state of the purchase order.. Valid values are `draft|open|released|closed|cancelled|blocked`',
    `purchase_order_type` STRING COMMENT 'Classification of the PO based on its procurement strategy.. Valid values are `standard|blanket|contract|planned`',
    `purchase_supplier_fk` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Every PO is issued TO a supplier. This is a day-1 mandatory FK.',
    `purchasing_org` STRING COMMENT 'SAP purchasing organization that owns the PO.',
    `quantity` BIGINT COMMENT 'Number of units ordered for the material.',
    `release_date` DATE COMMENT 'Date when the purchase order was released to the supplier.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and freight.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after taxes, discounts, and freight.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax amount applied to the purchase order.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the ordered quantity (e.g., EA, KG, L).',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit of the material before taxes and discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the purchase order record.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Procurement purchase orders issued to qualified suppliers for raw materials, process chemicals, gases, photomasks, equipment spare parts, and subcontracted services (OSAT assembly/test). Captures PO number, supplier, line items, ordered quantities, agreed unit price, currency, delivery schedule, Incoterms, payment terms, and export control classification (EAR/ITAR). Represents the legally binding procurement commitment. Sourced from SAP S/4HANA MM (EKKO/EKPO).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique surrogate identifier for the purchase order line record.',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Each PO line procures a specific material. Essential for material traceability and MRP consumption.',
    `purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Header-line pattern: every PO line belongs to exactly one PO. Critical structural relationship.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: PO lines specify the destination storage location for delivery in semiconductor ERP. po_line has storage_location (plain attr, denormalized). This link enables proper goods receipt routing to the corr',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the material.',
    `account_assignment_code` STRING COMMENT 'Identifier of the specific cost center, WBS element, or order linked to this line.',
    `account_assignment_type` STRING COMMENT 'Classification of the cost object (cost center, WBS element, or internal order).. Valid values are `COST_CENTER|WBS|ORDER`',
    `contract_number` STRING COMMENT 'Reference to a framework contract governing this line, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order line record was created.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for the monetary values on the line.. Valid values are `USD|EUR|JPY|CNY|KRW`',
    `currency_code` STRING COMMENT '',
    `delivery_date` DATE COMMENT 'Date by which the supplier should deliver the material.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount value applied to the line.',
    `goods_receipt_status` STRING COMMENT 'Current status of goods receipt for this line.. Valid values are `Not_Received|Partially_Received|Fully_Received|Cancelled`',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities.. Valid values are `EXW|FCA|FOB|CFR|CIF|DDP`',
    `is_final_invoice` BOOLEAN COMMENT 'Indicates whether this line has been invoiced in its final form.',
    `is_service_line` BOOLEAN COMMENT 'True if the line represents a service rather than a material.',
    `lead_time_days` STRING COMMENT 'Planned number of days from order to delivery for this line.',
    `line_number` STRING COMMENT 'Sequential number of the line within the purchase order.',
    `line_status` STRING COMMENT 'Current processing status of the purchase order line.. Valid values are `Open|Closed|Cancelled|On_Hold`',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Gross amount before tax and discount (ordered_quantity * net_price).',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `material_number` STRING COMMENT 'Master data identifier for the material or component being procured.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of the line after tax and discount.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit of the material before taxes and discounts.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material requested on this line.',
    `plant` STRING COMMENT 'Code of the manufacturing plant or site receiving the material.',
    `price_unit` STRING COMMENT 'Number of units that the net price applies to (e.g., price per 1000 pieces).',
    `purchase_group` STRING COMMENT 'Organizational group responsible for the procurement.',
    `quantity` DECIMAL(18,2) COMMENT '',
    `receipt_date` DATE COMMENT 'Date on which the goods were received.',
    `receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that has been received against this line.',
    `supply_risk_score` STRING COMMENT 'Risk rating (0‑100) assessing supplier and material availability risk.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the line.',
    `tax_code` STRING COMMENT 'Tax classification code used to calculate tax for the line.',
    `unit_of_measure` STRING COMMENT 'Unit in which the ordered quantity is expressed.. Valid values are `EA|KG|L|M|PCS`',
    `unit_price` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the line record.',
    `vendor_material_number` STRING COMMENT 'Suppliers own part number for the material.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order, each representing a distinct material or service being procured. Captures line number, material number, ordered quantity, unit of measure, net price, delivery date, plant/storage location destination, account assignment (cost center or WBS element), and goods receipt status. Enables granular tracking of multi-material POs and partial deliveries. Sourced from SAP S/4HANA MM (EKPO).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'System-generated unique identifier for the goods receipt record.',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: A goods receipt is the warehouse/fab confirmation that an inbound shipment has physically arrived and been processed. The inbound_shipment tracks the logistics movement; the goods_receipt records the ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: A goods receipt records the physical receipt of a specific material. material_master is the authoritative record for all procured materials. goods_receipt currently stores material_number and material',
    `po_line_id` BIGINT COMMENT '',
    `purchase_order_id` BIGINT COMMENT 'System identifier of the purchase order associated with the receipt.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Goods receipts post materials to specific storage locations (receiving docks, quarantine areas, cleanrooms) in the fab. goods_receipt has storage_location (plain attr, denormalized). This link enables',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier providing the goods.',
    `accepted_quantity` DECIMAL(18,2) COMMENT '',
    `batch_number` STRING COMMENT 'Identifier for the production batch or lot of the received material.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the material complies with applicable regulations (e.g., RoHS).',
    `compliance_status` STRING COMMENT 'Detailed compliance status of the material.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for monetary values.. Valid values are `^[A-Z]{3}$`',
    `external_reference` STRING COMMENT 'Any external system reference linked to this receipt (e.g., logistics tracking ID).',
    `goods_purchase_order_fk` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Goods receipts are posted against a purchase order. Core three-way match requirement.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the receipt (e.g., posted, reversed, pending).. Valid values are `posted|reversed|pending`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the receipt before taxes and discounts.',
    `inspection_lot_number` STRING COMMENT 'Reference to the quality inspection lot created for this receipt.',
    `inspection_status` STRING COMMENT '',
    `lead_time_days` STRING COMMENT 'Number of calendar days between purchase order issuance and goods receipt.',
    `lot_number` STRING COMMENT '',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the receipt (e.g., 101 = goods receipt).. Valid values are `101|102|201|202`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and discounts.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or observations.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant or fab where receipt is posted.',
    `posting_date` DATE COMMENT 'Date on which the receipt is posted to financial accounting.',
    `quality_status` STRING COMMENT 'Result of the incoming quality inspection for the received material.. Valid values are `passed|failed|rework|pending`',
    `quantity_received` DECIMAL(18,2) COMMENT 'Amount of material physically received, expressed in the unit of measure.',
    `receipt_date` DATE COMMENT 'Calendar date when the goods were physically received.',
    `receipt_number` STRING COMMENT 'Business identifier assigned to the receipt document (e.g., GR number).',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date and time when the receipt was recorded in the system.',
    `received_by` STRING COMMENT 'Name or employee identifier of the person who logged the receipt.',
    `received_quantity` DECIMAL(18,2) COMMENT '',
    `rejected_quantity` DECIMAL(18,2) COMMENT '',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score representing supply risk for the received material (higher = higher risk).',
    `supplier_batch_reference` STRING COMMENT 'Reference supplied by the vendor for the batch (e.g., vendor lot number).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the receipt.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured (e.g., each, kilogram, liter, meter).. Valid values are `EA|KG|L|M`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goods receipt record.',
    `valuation_type` STRING COMMENT 'Valuation category for the material (e.g., S = standard, U = moving average, V = special).. Valid values are `S|U|V`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of materials and goods at the fab or warehouse against a purchase order. Captures GR document number, posting date, received quantity, unit of measure, storage location, batch number, quality inspection lot reference, and movement type. Triggers inventory update and initiates incoming quality inspection. Sourced from SAP S/4HANA MM (MSEG/MKPF — movement type 101).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` (
    `supplier_qualification_id` BIGINT COMMENT 'System-generated unique identifier for each supplier qualification record.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Semiconductor supplier qualifications are frequently scoped at product family level (e.g., a foundry qualified for an entire MCU family under IATF 16949). Supply quality teams track family-level quali',
    `nda_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.nda_agreement. Business justification: Semiconductor supplier qualification requires a valid NDA before sharing process specifications or IP during audits. The NDA-Gated Supplier Qualification process mandates this link to verify NDA cov',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being qualified, linking to the supplier master record.',
    `tertiary_supplier_id` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Qualification records assess a specific supplier. Cannot exist without supplier reference.',
    `approval_date` DATE COMMENT 'Date on which the qualification was formally approved.',
    `audit_date` DATE COMMENT 'Calendar date on which the audit was performed.',
    `audit_score` DECIMAL(18,2) COMMENT '',
    `audit_team` STRING COMMENT 'Comma‑separated list of auditors and subject‑matter experts who conducted the audit.',
    `audit_type` STRING COMMENT 'Classification of the audit execution: initial qualification, routine surveillance, or for‑cause audit.. Valid values are `initial|surveillance|for_cause`',
    `compliance_standards` STRING COMMENT 'Semicolon‑separated list of regulatory or industry standards the qualification satisfies.. Valid values are `IATF16949|ISO9001|SEMI|JEDEC|IEC|ISO14001`',
    `corrective_action_due_date` DATE COMMENT 'Date by which all corrective actions must be completed.',
    `corrective_action_plan` STRING COMMENT 'Detailed plan describing corrective actions required to resolve audit findings.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `open|in_progress|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `expiry_date` DATE COMMENT '',
    `findings_severity` STRING COMMENT 'Highest severity level of audit findings identified during the assessment.. Valid values are `critical|major|minor`',
    `findings_summary` STRING COMMENT 'Narrative summary of audit observations, non‑conformances, and strengths.',
    `notes` STRING COMMENT 'Free‑form comments or additional information captured by the qualification team.',
    `overall_rating` STRING COMMENT 'Result of the qualification audit after considering findings and corrective actions.. Valid values are `pass|fail|conditional`',
    `qualification_date` DATE COMMENT '',
    `qualification_number` STRING COMMENT 'External reference number assigned to the qualification program for tracking and audit purposes.',
    `qualification_program_type` STRING COMMENT 'Type of qualification program: initial onboarding, scheduled periodic review, or change‑triggered re‑qualification.. Valid values are `initial|periodic|change_triggered`',
    `qualification_scope` STRING COMMENT 'Scope of the qualification assessment covering quality system audit, process capability, material certification, or a combination.. Valid values are `quality_system_audit|process_capability|material_certification|combined`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification record.. Valid values are `pending|approved|expired|revoked`',
    `qualification_type` STRING COMMENT '',
    `qualified_by` STRING COMMENT '',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0‑100) derived from supplier risk assessment models.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the qualification record.',
    `validity_end_date` DATE COMMENT 'Date when the supplier qualification expires unless re‑qualified.',
    `validity_start_date` DATE COMMENT 'Date when the supplier qualification becomes effective.',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Formal supplier qualification lifecycle records encompassing the full assessment, audit, and approval process for onboarding new suppliers or re-qualifying existing ones. Captures qualification program type (initial, periodic, change-triggered), assessment scope (quality system audit, process capability, material certification review), on-site and remote audit execution details (audit type — initial qualification, surveillance, for-cause; audit team composition; findings by severity — critical/major/minor; corrective action plans and closure tracking; overall audit rating), qualification criteria and pass/fail results, validity period, and approving engineer. SSOT for all supplier audit and qualification activity within the supply domain. Supports IATF 16949, ISO 9001, and SEMI standards supplier approval requirements.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` (
    `material_requirement_plan_id` BIGINT COMMENT 'Unique surrogate key for each material requirement plan record.',
    `backlog_position_id` BIGINT COMMENT 'Foreign key linking to order.backlog_position. Business justification: MRP planning runs in semiconductors consume backlog snapshots as demand inputs. Linking MRP records to the backlog_position that drove the requirement enables S&OP backlog-to-supply reconciliation, pu',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: MRP gross requirements in semiconductors are driven by customer order line demand. Linking MRP to the originating order line enables S&OP demand-supply gap analysis, backlog-to-plan reconciliation, an',
    `forecast_id` BIGINT COMMENT 'Foreign key linking to sales.sales_forecast. Business justification: S&OP process: MRP runs in semiconductors are driven by sales forecasts as the primary demand signal. Linking MRP to the source sales_forecast enables full demand-to-supply traceability, supports S&OP ',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: MRP execution in semiconductor fabs is driven by demand for specific IC catalog products. Planners trace planned orders to the IC driving demand for capacity allocation, lead-time management, and supp',
    `material_master_id` BIGINT COMMENT 'Surrogate key referencing the material master record.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: MRP run outputs define planned procurement quantities and timing. When procurement acts on an MRP plan, a purchase order is created to fulfill the planned requirement. This FK links the MRP planned or',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: MRP plans are generated specifically for raw materials (silicon wafers, process chemicals) to drive replenishment. Linking MRP to raw_material enables planners to see which raw material record the pla',
    `supplier_id` BIGINT COMMENT 'Reference to the approved supplier that will fulfill the planned order.',
    `tertiary_material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — MRP outputs are calculated for specific materials.',
    `batch_managed_flag` BOOLEAN COMMENT 'Flag indicating if the material requires batch tracking (Y) or not (N).',
    `created_timestamp` TIMESTAMP COMMENT '',
    `creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the MRP system generated this record.',
    `currency_code` STRING COMMENT 'Currency in which the planned cost is expressed.. Valid values are `USD|EUR|JPY|CNY|KRW|GBP`',
    `demand_date` DATE COMMENT 'Date on which the underlying demand (e.g., production start) is scheduled.',
    `demand_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material required by production orders or forecasts.',
    `exception_message` STRING COMMENT 'Textual description of any planning exception (e.g., shortfall, excess).',
    `gross_requirement_qty` DECIMAL(18,2) COMMENT '',
    `is_fixed_lot` BOOLEAN COMMENT 'True if the lot size is fixed by engineering, otherwise False.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification (e.g., quantity change, status update).',
    `lead_time_days` STRING COMMENT 'Number of calendar days from order placement to receipt of material.',
    `lot_sizing_procedure` STRING COMMENT 'Algorithm used to calculate the lot size for the planned order.. Valid values are `EXACT|FOQ|LFL|LOT|MIN|MAX`',
    `material_requirement_plan_status` STRING COMMENT 'Operational status indicating whether the line is still in planning, released to procurement, or flagged.. Valid values are `planned|released|cancelled|exception`',
    `mrp_controller` STRING COMMENT 'Code of the person or system that owns the MRP parameters for the material.',
    `mrp_type` STRING COMMENT 'Classification of the planning method used for this line.. Valid values are `PD|VB|ND|VV|VV|V1`',
    `net_requirement_qty` DECIMAL(18,2) COMMENT '',
    `plan_period` STRING COMMENT '',
    `planned_cost` DECIMAL(18,2) COMMENT 'Estimated monetary cost of the planned quantity based on standard price.',
    `planned_delivery_date` DATE COMMENT 'Target date by which the material must be available for production.',
    `planned_order_qty` DECIMAL(18,2) COMMENT '',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material that the MRP run recommends procuring.',
    `planning_horizon_end` DATE COMMENT 'Last day of the time window considered by the MRP run.',
    `planning_horizon_start` DATE COMMENT 'First day of the time window considered by the MRP run.',
    `planning_run_date` DATE COMMENT 'Calendar date on which the MRP calculation was performed.',
    `planning_run_number` BIGINT COMMENT 'Identifier of the MRP execution that generated this plan.',
    `plant_code` STRING COMMENT 'Identifier of the fabrication plant or site for which the plan is created.',
    `procurement_group` STRING COMMENT 'Organizational unit within supply chain that owns the procurement process.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers a new procurement recommendation.',
    `requirement_date` DATE COMMENT '',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity kept as buffer to protect against demand or supply variability.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the planned quantity is expressed.. Valid values are `kg|pcs|l|m|mol|g`',
    CONSTRAINT pk_material_requirement_plan PRIMARY KEY(`material_requirement_plan_id`)
) COMMENT 'Material Requirements Planning (MRP) run outputs defining planned procurement quantities and timing for all fab materials based on production schedules, wafer start plans, safety stock levels, and reorder points. Captures planning run date, material, plant, planned order quantity, planned delivery date, MRP type, lot sizing procedure, and exception messages (shortfall, excess, rescheduling). Sourced from SAP S/4HANA PP-MRP (MDKP/MDTB).';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` (
    `inbound_shipment_id` BIGINT COMMENT 'System-generated unique identifier for the inbound shipment record.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: An inbound shipment fulfills specific PO line items, not just the PO header. inbound_shipment already has FKs to purchase_order (header level), but line-level traceability is essential in semiconducto',
    `purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Inbound shipments deliver against purchase orders. Required for logistics tracking and landed cost.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Inbound shipments are directed to specific storage locations (receiving docks, quarantine areas) in the fab. Linking inbound_shipment to storage_location enables warehouse slotting, receiving dock ass',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the material.',
    `actual_arrival_date` DATE COMMENT 'Date on which the shipment was physically received.',
    `bill_of_lading_number` STRING COMMENT 'Reference number of the bill of lading document.',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether temperature‑controlled handling is required.',
    `compliance_status` STRING COMMENT 'Overall compliance assessment for the shipment (e.g., compliant, exception, pending).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inbound shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the freight cost.',
    `customs_declaration_number` STRING COMMENT 'Identifier of the customs entry for the shipment.',
    `delivery_window_end` DATE COMMENT 'End date of the agreed delivery window.',
    `delivery_window_start` DATE COMMENT 'Start date of the agreed delivery window.',
    `destination_plant` STRING COMMENT 'Identifier of the fab or warehouse receiving the shipment.',
    `ear_controlled` BOOLEAN COMMENT 'Indicates whether the shipment contains items subject to Export Administration Regulations.',
    `estimated_arrival_date` DATE COMMENT 'Planned date on which the shipment is expected to arrive.',
    `export_control_classification` STRING COMMENT 'Export control classification code (e.g., ECCN) for the shipment.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Total cost charged by the carrier for transporting the shipment.',
    `hazardous_goods_classification` STRING COMMENT 'Classification code for hazardous materials per UN/ADR.',
    `inbound_po_fk` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — Inbound shipments deliver materials against purchase orders. Required for supply continuity monitoring and landed cost calculation.',
    `inbound_shipment_status` STRING COMMENT 'Current lifecycle status of the inbound shipment.. Valid values are `pending|in_transit|arrived|delayed|cancelled`',
    `incoterms` STRING COMMENT 'International commercial term defining responsibility and cost allocation.',
    `itar_controlled` BOOLEAN COMMENT 'Indicates whether the shipment contains items subject to ITAR regulations.',
    `lead_time_days` STRING COMMENT 'Planned number of days from shipment dispatch to arrival.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the shipment.',
    `origin_country` STRING COMMENT 'Three‑letter ISO country code of the shipment origin.. Valid values are `^[A-Z]{3}$`',
    `packaging_type` STRING COMMENT 'Description of the primary packaging used (e.g., pallet, container, drum).',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating for the shipment based on supplier and logistics factors.',
    `ship_date` DATE COMMENT '',
    `shipment_number` STRING COMMENT 'External shipment reference number assigned by the carrier or logistics provider.',
    `shipment_status` STRING COMMENT '',
    `shipment_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary shipment event (e.g., departure from supplier).',
    `temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for the shipment when cold chain is required.',
    `temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for the shipment when cold chain is required.',
    `tracking_number` STRING COMMENT 'Unique tracking identifier provided by the carrier.',
    `transport_mode` STRING COMMENT 'Mode of transport used for the inbound shipment.. Valid values are `air|sea|road|courier`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inbound shipment record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    CONSTRAINT pk_inbound_shipment PRIMARY KEY(`inbound_shipment_id`)
) COMMENT 'Inbound logistics records tracking the physical movement of procured materials from supplier origin to fab or warehouse destination. Captures shipment number, carrier, mode of transport (air, sea, road, courier), origin country, destination plant, estimated and actual arrival dates, freight cost, customs declaration number, Incoterms, hazardous goods classification, and cold chain requirements for temperature-sensitive chemicals. Supports landed cost calculation and supply continuity monitoring.';

CREATE OR REPLACE TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` (
    `material_certification_id` BIGINT COMMENT 'System-generated unique identifier for each material certification record.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Material certifications (CoC, RoHS, REACH, PCN documents) are matched to specific incoming lots at the point of goods receipt. This FK links the certification document to the physical receipt event, e',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Certifications (CoC/CoA) are issued for specific materials. Required for incoming quality release.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier that issued the certification.',
    `tertiary_material_master_id` BIGINT COMMENT 'FK to supply.material_master.material_master_id — Material certifications (CoC/CoA) are issued for specific materials. Required for incoming quality release decisions.',
    `approval_date` DATE COMMENT 'Date the certification was approved for production release.',
    `certification_number` STRING COMMENT '',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `issued|expired|revoked|pending`',
    `certification_type` STRING COMMENT 'Category of certification document, such as Certificate of Conformance, Certificate of Analysis, RoHS compliance, REACH compliance, TSCA certification, or Product Change Notification.. Valid values are `CoC|CoA|RoHS|REACH|TSCA|PCN`',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard to which the certification attests compliance.. Valid values are `RoHS|REACH|TSCA|IEC|ISO|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_reference` STRING COMMENT 'Path or URL to the electronic certification document.',
    `document_version` STRING COMMENT 'Version identifier of the certification document.',
    `expiry_date` DATE COMMENT 'Date the certification expires or becomes invalid.',
    `issue_date` DATE COMMENT 'Date the certification was issued by the supplier.',
    `issuing_body` STRING COMMENT 'Name of the organization or department that issued the certification.',
    `lot_number` STRING COMMENT '',
    `material_lot_number` STRING COMMENT 'Lot identifier assigned to the batch of material covered by the certification.',
    `material_supplier_fk` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Certifications are issued by a specific supplier. Required to trace compliance evidence to its source.',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or observations.',
    `pcn_change_description` STRING COMMENT 'Detailed description of the change communicated in the PCN.',
    `pcn_change_type` STRING COMMENT 'Category of change described in the PCN.. Valid values are `process|material|site|eol|other`',
    `pcn_customer_notification_required` BOOLEAN COMMENT 'Indicates whether the PCN must be communicated to customers.',
    `pcn_effective_date` DATE COMMENT 'Date when the PCN change becomes effective.',
    `pcn_impact_assessment` STRING COMMENT 'Summary of the impact of the PCN on downstream processes and customers.',
    `pcn_number` STRING COMMENT 'Identifier of the PCN associated with this material certification, if applicable.',
    `pcn_requalification_decision` STRING COMMENT 'Decision on whether the material requires re‑qualification after the PCN.. Valid values are `required|not_required|pending`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating associated with the material based on certification and supplier data.',
    `supplier_fk` BIGINT COMMENT 'FK to supply.supplier.supplier_id — Certifications are issued BY a specific supplier for their material lots.',
    `test_result` STRING COMMENT 'Outcome of the compliance test associated with the certification.. Valid values are `pass|fail|conditional`',
    `test_units` STRING COMMENT 'Units of measurement for the test value, such as ppm, mg/kg, or %.',
    `test_value` DECIMAL(18,2) COMMENT 'Quantitative result of the test (e.g., concentration, impurity level).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_material_certification PRIMARY KEY(`material_certification_id`)
) COMMENT 'Supplier-originated material compliance documents including quality certifications and product change notifications. Captures Certificate of Conformance (CoC), Certificate of Analysis (CoA), RoHS compliance declarations, REACH SVHC declarations, TSCA certifications, and Product Change Notifications (PCNs). For certifications: certification type, issuing supplier, material lot number, test results, compliance standard, issue date, expiry date, and document reference. For PCNs: PCN number, supplier, affected material or component, change type (process, material, site, EOL), change description, effective date, impact assessment, required customer notification obligation, and re-qualification decision. SSOT for all supplier-originated material compliance and change documentation within the supply domain. Required for regulatory compliance, incoming quality release, process stability, and customer PCN pass-through obligations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ADD CONSTRAINT `fk_supply_approved_vendor_supplier_qualification_id` FOREIGN KEY (`supplier_qualification_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier_qualification`(`supplier_qualification_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_tertiary_supplier_id` FOREIGN KEY (`tertiary_supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ADD CONSTRAINT `fk_supply_material_requirement_plan_tertiary_material_master_id` FOREIGN KEY (`tertiary_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ADD CONSTRAINT `fk_supply_material_certification_tertiary_material_master_id` FOREIGN KEY (`tertiary_material_master_id`) REFERENCES `vibe_semiconductors_v1`.`supply`.`material_master`(`material_master_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_semiconductors_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_semiconductors_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9,10}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = 'EAR99|ECCN5A|ECCN5B');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `financial_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `global_footprint` SET TAGS ('dbx_business_glossary_term' = 'Global Footprint');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `global_footprint` SET TAGS ('dbx_value_regex' = 'Global|Regional|Local');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `industry_classification` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `industry_classification` SET TAGS ('dbx_value_regex' = 'Raw Material|Chemical|Equipment|OSAT|Design Service');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `is_certified_kga` SET TAGS ('dbx_business_glossary_term' = 'KGA Certified');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net30|Net45|Net60|Cash');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `preferred_logistics_partner` SET TAGS ('dbx_business_glossary_term' = 'Preferred Logistics Partner');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_group` SET TAGS ('dbx_business_glossary_term' = 'Supplier Group');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_group` SET TAGS ('dbx_value_regex' = 'Strategic|Preferred|Standard|Transactional');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,15}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier` ALTER COLUMN `website` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor Identifier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_commodity_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity Scope');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `approved_vendor_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `financial_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash|prepay');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `quality_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`approved_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'supplier|subcontractor|osat|service_provider');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier (MMID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (LIFNR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (MEINS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `batch_management` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Indicator (XCHPF)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (COO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = 'USA|CHN|KOR|JPN|DEU|TWN');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `hazardous_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Classification (HAZ_CLASS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `hazardous_classification` SET TAGS ('dbx_value_regex' = 'non_hazardous|hazardous|restricted|controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (LEAD_TIME_D)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (STAT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `lot_size_qty` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity (LOT_SIZE_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MAKTX_LONG)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name (MAKTX)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MATNR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type (MTART)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw|consumable|component|packaging|chemical|gas');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `max_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAX_ORDER_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MIN_ORDER_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `procurement_group` SET TAGS ('dbx_business_glossary_term' = 'Procurement Group (EKGRP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag (QINSP_REQ)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH Compliance Flag (REACH_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (REORDER_PT_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `rohs_compliant` SET TAGS ('dbx_business_glossary_term' = 'RoHS Compliance Flag (ROHS_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SAFETY_STOCK_Q)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `serial_management` SET TAGS ('dbx_business_glossary_term' = 'Serial Management Indicator (XCHPF_SERIAL)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (SHELF_LIFE_D)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost (STAND_COST)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_humidity_max_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Humidity (HUM_MAX_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_humidity_min_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Humidity (HUM_MIN_PCT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (TEMP_MAX_C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (TEMP_MIN_C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `tsca_compliant` SET TAGS ('dbx_business_glossary_term' = 'TSCA Compliance Flag (TSCA_COMP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class (BKLAS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `is_ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `is_ear_controlled` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MATNR)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Date (PO_DATE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'NET30|NET45|NET60|PREPAID|COD');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NUMBER)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_group` SET TAGS ('dbx_business_glossary_term' = 'Purchase Group');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Status (PO_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_status` SET TAGS ('dbx_value_regex' = 'draft|open|released|closed|cancelled|blocked');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Type (PO_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|planned');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_supplier_fk` SET TAGS ('dbx_business_glossary_term' = 'Purchase Supplier Fk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `purchasing_org` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (PO_GROSS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (PO_NET)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (PO_TAX)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Po Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `account_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `account_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `account_assignment_type` SET TAGS ('dbx_value_regex' = 'COST_CENTER|WBS|ORDER');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'Not_Received|Partially_Received|Fully_Received|Cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DDP');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `is_final_invoice` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `is_service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line Indicator');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'Open|Closed|Cancelled|On_Hold');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `purchase_group` SET TAGS ('dbx_business_glossary_term' = 'Purchase Group');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`po_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_purchase_order_fk` SET TAGS ('dbx_business_glossary_term' = 'Goods Purchase Order Fk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '101|102|201|202');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|rework|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Received By');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `supplier_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Batch Reference');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'S|U|V');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `nda_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Agreement Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `tertiary_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Supplier Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date (AUDIT_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team (AUDIT_TEAM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial|surveillance|for_cause');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standards (COMPLIANCE_STD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `compliance_standards` SET TAGS ('dbx_value_regex' = 'IATF16949|ISO9001|SEMI|JEDEC|IEC|ISO14001');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CAP_DUE_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CAP_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `findings_severity` SET TAGS ('dbx_business_glossary_term' = 'Findings Severity (FIND_SEV)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `findings_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary (FIND_SUM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Rating (QUAL_RATING)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number (QUAL_NUM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_program_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Program Type (QUAL_PROG_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_program_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|change_triggered');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope (QUAL_SCOPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_value_regex' = 'quality_system_audit|process_capability|material_certification|combined');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|approved|expired|revoked');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score (RISK_SCORE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VALID_TO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`supplier_qualification` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VALID_FROM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_requirement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Plan Identifier (MRP_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `backlog_position_id` SET TAGS ('dbx_business_glossary_term' = 'Backlog Position Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Order Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Forecast Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (VEND_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `tertiary_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag (BATCH_FLAG)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|KRW|GBP');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `demand_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Date (DEMAND_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand Quantity (DEMAND_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `exception_message` SET TAGS ('dbx_business_glossary_term' = 'Exception Message (EXC_MSG)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `is_fixed_lot` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Indicator (FIXED_LOT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (LEAD_DAYS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure (LOT_SIZ_PROC)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_value_regex' = 'EXACT|FOQ|LFL|LOT|MIN|MAX');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_requirement_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Line Status (PLAN_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `material_requirement_plan_status` SET TAGS ('dbx_value_regex' = 'planned|released|cancelled|exception');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'MRP Controller (MRP_CTRL)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'MRP Type (MRP_TYP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|ND|VV|VV|V1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost (PLAN_COST)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (PLAN_DELIV_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity (PLAN_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date (HORIZON_END_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date (HORIZON_START_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_run_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Date (RUN_DT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `planning_run_number` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Identifier (RUN_ID)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `procurement_group` SET TAGS ('dbx_business_glossary_term' = 'Procurement Group (PURCH_GRP)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity (ROP_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity (SAFE_STK_QTY)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_requirement_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|pcs|l|m|mol|g');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Purchase Order Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `destination_plant` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `ear_controlled` SET TAGS ('dbx_business_glossary_term' = 'EAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Goods Classification');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_[enum_ref_candidate' = 'class_1');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_2' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_3' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_4' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_5' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_6' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_7' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_8' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_class_9_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_po_fk` SET TAGS ('dbx_business_glossary_term' = 'Inbound Po Fk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `inbound_shipment_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|arrived|delayed|cancelled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_[enum_ref_candidate' = 'exw');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_fca' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_fas' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_fob' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cfr' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cif' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cpt' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_cip' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_dat' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_dap' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_dpu' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `incoterms` SET TAGS ('dbx_ddp_—_promote_to_reference_product]' = 'true');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `itar_controlled` SET TAGS ('dbx_business_glossary_term' = 'ITAR Controlled');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shipment Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `origin_country` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `shipment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipment Event Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|sea|road|courier');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Shipment Volume (m³)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`inbound_shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Shipment Weight (kg)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `tertiary_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Material Master Id');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (CERT_STATUS)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'issued|expired|revoked|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (CERT_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'CoC|CoA|RoHS|REACH|TSCA|PCN');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard (STD)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'RoHS|REACH|TSCA|IEC|ISO|Other');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference (DOC_REF)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version (DOC_VER)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body (ISSUER)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Material Lot Number (LOT_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `material_supplier_fk` SET TAGS ('dbx_business_glossary_term' = 'Material Supplier Fk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_change_description` SET TAGS ('dbx_business_glossary_term' = 'PCN Change Description');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_change_type` SET TAGS ('dbx_business_glossary_term' = 'PCN Change Type (PCN_TYPE)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_change_type` SET TAGS ('dbx_value_regex' = 'process|material|site|eol|other');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'PCN Customer Notification Required');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_effective_date` SET TAGS ('dbx_business_glossary_term' = 'PCN Effective Date');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'PCN Impact Assessment');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Product Change Notification Number (PCN_NO)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_requalification_decision` SET TAGS ('dbx_business_glossary_term' = 'PCN Re‑qualification Decision');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `pcn_requalification_decision` SET TAGS ('dbx_value_regex' = 'required|not_required|pending');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `supplier_fk` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Supplier Fk');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result (TEST_RES)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_units` SET TAGS ('dbx_business_glossary_term' = 'Test Units (TEST_UOM)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `test_value` SET TAGS ('dbx_business_glossary_term' = 'Test Value (TEST_VAL)');
ALTER TABLE `vibe_semiconductors_v1`.`supply`.`material_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
