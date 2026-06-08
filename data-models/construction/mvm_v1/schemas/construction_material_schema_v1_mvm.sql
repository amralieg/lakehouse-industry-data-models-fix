-- Schema for Domain: material | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`material` COMMENT 'Materials management domain tracking inventory, stock levels, material receipts, consumption, transfers between sites, and material traceability (batch/lot tracking for concrete, steel, MEP components). Manages BOQ (Bill of Quantities) reconciliation, material specifications, FAT/SAT records, material conformance certificates, and warehouse operations for construction materials and consumables.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`material`.`master` (
    `master_id` BIGINT COMMENT 'Primary key for master',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: In construction ERP systems (SAP, Oracle), material master records carry a valuation GL account for inventory accounting. This account drives automatic posting of inventory movements. A construction f',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Hazardous/regulated material masters (COSHH, REACH, EPA) are governed by specific regulatory obligations. Compliance officers need to identify all materials subject to a given obligation for procureme',
    `substitution_material_master_id` BIGINT COMMENT 'Identifier of an approved substitute material.',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary supplier for this material.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the material record was approved for use.',
    `conformance_certificate_date` DATE COMMENT 'Date the compliance certificate was issued.',
    `conformance_certificate_number` STRING COMMENT 'Reference number of the material’s compliance certificate (e.g., ISO, ASTM).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of one unit of material in the specified currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the material master record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for cost fields.',
    `dimensions_cm` STRING COMMENT 'Length×Width×Height dimensions in centimeters, formatted as LxWxH.',
    `expiration_date` DATE COMMENT 'Calendar date when the material batch expires.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'True if the material is classified as hazardous under OSHA/EPA regulations.',
    `lead_time_days` STRING COMMENT 'Average number of days from order to receipt.',
    `leeds_compliance_flag` BOOLEAN COMMENT 'Indicates whether the material is eligible for LEED credit consideration.',
    `leeds_credit_applicability` STRING COMMENT 'LEED credit categories the material can contribute to.. Valid values are `energy|water|materials|innovation|none`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the material record.. Valid values are `active|inactive|discontinued|draft|pending`',
    `lot_number` STRING COMMENT 'Lot identifier used for quality control and recall management.',
    `manufacturer_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the manufacturer’s country.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactures the material.',
    `master_description` STRING COMMENT 'Detailed textual description of the material, including typical applications.',
    `master_name` STRING COMMENT 'Human‑readable name of the material.',
    `material_code` STRING COMMENT 'Enterprise‑wide unique code or catalogue number for the material.',
    `material_origin_country` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the materials source.',
    `max_order_qty` STRING COMMENT 'Largest quantity that can be ordered in a single purchase.',
    `min_order_qty` STRING COMMENT 'Smallest quantity that can be ordered from the supplier.',
    `minimum_performance_criteria` STRING COMMENT 'Minimum performance thresholds the material must meet (e.g., compressive strength).',
    `reorder_point_qty` STRING COMMENT 'Inventory level that triggers a replenishment order.',
    `safety_stock_qty` STRING COMMENT 'Buffer stock kept to protect against demand variability.',
    `shelf_life_days` STRING COMMENT 'Number of days the material can be stored before it expires.',
    `specification_grade` STRING COMMENT 'Grade or class of the material as defined by the governing standard.',
    `specification_standard` STRING COMMENT 'Reference standard governing the material (e.g., ASTM, BS, ISO, ACI, AISC).',
    `storage_requirements` STRING COMMENT 'Special storage conditions (e.g., temperature, humidity, segregation).',
    `substitution_approval_reference` STRING COMMENT 'Reference to the client/engineer approval document for the substitution.',
    `substitution_reason` STRING COMMENT 'Engineering or client‑approved justification for the substitution.',
    `supplier_part_number` STRING COMMENT 'Supplier‑assigned part number for the material.',
    `technical_specification` STRING COMMENT 'Full technical specification document reference or summary.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for inventory and consumption tracking.. Valid values are `kg|m3|pcs|l|m|ft`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the material record.',
    `version_number` STRING COMMENT 'Incremental version of the material record for change control.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Physical volume of a single unit of material in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of a single unit of material in kilograms.',
    CONSTRAINT pk_master PRIMARY KEY(`master_id`)
) COMMENT 'Authoritative master record for all construction materials and consumables used across projects. Captures material identity, detailed technical specifications (applicable standards — ASTM, BS, ISO, ACI, AISC — grade/class, minimum performance criteria, specification code, specification revision), classification (concrete, steel, MEP components, aggregates, timber, formwork, etc.), unit of measure, approved equivalent substitutes with engineering justification, LEED compliance flags, LEED credit applicability, hazardous material indicators, shelf life, storage requirements, and supplier cross-references. Manages specification lifecycle (draft, approved, superseded) and material qualification status. Records approved substitutions with reason, client/engineer approval reference, cost impact, and affected BOQ lines. This is the SSOT for material identity, technical specifications, and approved substitutes in the construction enterprise — all transactions reference this record.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Primary key for warehouse',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Some warehouses are owned or leased by a client; the FK enables asset ownership and liability tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Construction warehouses are assigned to cost centers for inventory carrying cost allocation and overhead reporting. A construction finance controller expects each warehouse to reference a cost center ',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Warehouses storing hazardous materials must operate under a governing HSE plan defining storage limits, segregation, emergency procedures, and inspection requirements. The warehouse already tracks haz',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Warehouses storing hazardous materials require active environmental/hazardous storage permits. Regulators and site managers must verify the permit authorizing hazardous storage at each warehouse. haza',
    `site_id` BIGINT COMMENT 'Identifier of the construction site or project to which the warehouse is attached.',
    `access_control_method` STRING COMMENT 'Primary method used to control entry to the warehouse.. Valid values are `badge|biometric|keycard|none`',
    `address_line1` STRING COMMENT 'Primary street address of the warehouse.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `capacity_area_sqm` DECIMAL(18,2) COMMENT 'Maximum usable floor area in square metres.',
    `capacity_weight_tonnes` DECIMAL(18,2) COMMENT 'Maximum total weight the warehouse can safely store, expressed in metric tonnes.',
    `certification_expiry_date` DATE COMMENT 'Date on which the hazardous‑material certification expires.',
    `city` STRING COMMENT 'City where the warehouse is located.',
    `climate_control_type` STRING COMMENT 'Specific climate control method applied when temperature_controlled is true.. Valid values are `refrigerated|heated|ambient`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the warehouse location.. Valid values are `USA|CAN|MEX|GBR|AUS`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the warehouse became operational or was officially opened.',
    `effective_until` DATE COMMENT 'Date when the warehouse ceased operations or is scheduled for closure (null if still active).',
    `gps_accuracy_meters` STRING COMMENT 'Estimated positional accuracy of the GPS coordinates, in metres.',
    `gps_latitude` DOUBLE COMMENT 'Latitude coordinate of the warehouse centre point.',
    `gps_longitude` DOUBLE COMMENT 'Longitude coordinate of the warehouse centre point.',
    `inventory_management_system` STRING COMMENT 'Name of the downstream system that tracks inventory within this warehouse (e.g., SAP WM, Procore).',
    `is_hazardous_material_certified` BOOLEAN COMMENT 'Indicates whether the warehouse holds a valid hazardous‑material storage certification.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection.',
    `next_inspection_due` DATE COMMENT 'Planned date for the next required inspection.',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational comments.',
    `operating_hours` STRING COMMENT 'Standard daily operating window (e.g., 08:00‑17:00).',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the warehouse address.',
    `security_level` STRING COMMENT 'Overall security classification of the warehouse.. Valid values are `low|medium|high|critical`',
    `state` STRING COMMENT 'State or province of the warehouse location.',
    `storage_zone_details` STRING COMMENT 'Free‑form description of internal zones, racks, bins, or yard sections.',
    `temperature_controlled` BOOLEAN COMMENT 'True if the warehouse maintains a controlled temperature environment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse record.',
    `warehouse_code` STRING COMMENT 'Business‑visible alphanumeric code used to reference the warehouse in external systems.',
    `warehouse_description` STRING COMMENT 'Narrative description of the warehouse, its purpose, and special characteristics.',
    `warehouse_name` STRING COMMENT 'Human‑readable name of the warehouse or laydown yard.',
    `warehouse_status` STRING COMMENT 'Current operational status of the warehouse.. Valid values are `active|inactive|closed|maintenance`',
    `warehouse_type` STRING COMMENT 'Classification of the warehouse based on construction and regulatory characteristics.. Valid values are `bonded|open_yard|climate_controlled|hazmat_certified|general`',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master record for physical warehouse, laydown yard, and storage locations across construction sites and central depots. Tracks warehouse type (bonded, open yard, climate-controlled, hazmat-certified), capacity (area sqm, weight tonnes), GPS coordinates, site association, custodian, operating hours, hazardous material storage certification, and granular storage locations (rack positions, bin rows, open yard zones). Supports multi-site inventory management, material transfer logistics, and FIFO/FEFO stock management for batch-tracked materials.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`stock_level` (
    `stock_level_id` BIGINT COMMENT 'System-generated unique identifier for each stock level record.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Quality hold management: stock_level.quality_inspection_quantity tracks material on quality hold. Linking to quality.inspection identifies which inspection is clearing the hold, enabling warehouse man',
    `master_id` BIGINT COMMENT 'FK to material.material_master',
    `warehouse_id` BIGINT COMMENT 'FK to material.warehouse',
    `batch_number` STRING COMMENT 'Identifier for the production batch, used for traceability of concrete, steel, etc.',
    `blocked_quantity` DECIMAL(18,2) COMMENT 'Quantity held due to quality issues, holds, or regulatory restrictions.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'Quantity allocated to specific construction activities or contracts.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of a single unit of material in the base currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the stock level record was first created.',
    `expiration_date` DATE COMMENT 'Date after which the material is considered unusable or non‑compliant.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity that has been dispatched but not yet received at the location.',
    `last_movement_date` TIMESTAMP COMMENT 'Date and time of the most recent stock transaction affecting this record.',
    `last_movement_type` STRING COMMENT 'Category of the most recent stock transaction.. Valid values are `receipt|issue|transfer|return|adjustment`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the stock level record.',
    `location_code` STRING COMMENT 'Identifier of the warehouse or storage site where the stock resides.',
    `lot_number` STRING COMMENT 'Identifier for a lot of material, often used for quality tracking.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'Upper threshold for inventory to avoid over‑stocking.',
    `min_stock_level` DECIMAL(18,2) COMMENT 'Lowest permissible inventory level before stock is considered understocked.',
    `quality_inspection_quantity` DECIMAL(18,2) COMMENT 'Quantity currently undergoing quality inspection or testing.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Total amount of material physically present in the location.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment request.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity earmarked for pending work packages or purchase orders.',
    `safety_stock` DECIMAL(18,2) COMMENT 'Buffer quantity maintained to protect against demand variability or supply delays.',
    `stock_level_status` STRING COMMENT 'Current lifecycle status of the stock quantity.. Valid values are `available|blocked|reserved|in_transit|quality_hold|consumed`',
    `supplier_code` STRING COMMENT 'External identifier of the supplier providing the material.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity fields.. Valid values are `kg|m3|pcs|ton|lb|gal`',
    CONSTRAINT pk_stock_level PRIMARY KEY(`stock_level_id`)
) COMMENT 'Current on-hand inventory position for each material at each warehouse/storage location. Captures unrestricted stock, quality-inspection stock, blocked stock, reserved stock, in-transit quantities, and committed (reserved-for-activity) quantities. Tracks reorder point, minimum/maximum stock levels, safety stock thresholds, and last movement date. Updated in real-time by stock movements (receipts, issues, transfers, returns). Critical for BOQ reconciliation, preventing site stoppages due to material shortages, and supporting procurement trigger automation.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Primary key for stock_movement',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Links goods receipt to the activity that triggered the material purchase, enabling receipt‑to‑schedule reconciliation and progress tracking.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Goods receipts are tied to client orders; needed for delivery confirmation and contract compliance.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the receipt.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material receipts in construction are charged to cost centers for project cost control and overhead allocation reporting. Every goods receipt must be attributed to a cost center for financial posting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: In construction job costing, every material receipt is classified by cost code for WBS cost reporting and budget consumption tracking. A domain expert would expect stock_movement to carry a cost_code_',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to material.warehouse. Business justification: stock_movement records the physical destination of received goods using a free-text destination_warehouse_code string. Adding destination_warehouse_id as a proper FK to the warehouse master enables re',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for Inventory Valuation: goods receipt creates a GL entry to record inventory value in the general ledger.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Goods receipt inspection process: incoming materials at site undergo ITP-driven quality inspection recorded in quality.inspection. Linking stock_movement to the inspection record enables material rece',
    `material_delivery_id` BIGINT COMMENT 'Foreign key linking to site.material_delivery. Business justification: Goods receipt matching: material_delivery is the site docket record; stock_movement is the warehouse posting for the same physical receipt. Linking them enables three-way matching (PO, delivery docket',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.master. Business justification: stock_movement records a physical receipt of material against a PO, yet currently stores material_code and material_description as denormalized strings rather than referencing the authoritative materi',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Goods receipts of hazardous or regulated materials on construction sites must be authorized under an active compliance permit (e.g., environmental discharge, hazardous material handling). Compliance a',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Material receipts consume committed project budget in construction. Linking stock_movement to project_budget enables real-time budget vs. actual material cost reporting and supports the three-way matc',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Stock movement records must be linked to the originating purchase order for audit trails, cost allocation, and receipt verification.',
    `site_id` BIGINT COMMENT 'Identifier of the construction site or warehouse where material is received.',
    `test_certificate_id` BIGINT COMMENT 'Foreign key linking to quality.test_certificate. Business justification: Material receipt certification: construction QA requires test certificates accompany material deliveries. stock_movement.quality_certificate_number is a denormalized reference to quality.test_certific',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Goods receipts (stock movements) in construction are posted against WBS elements for actual cost capture and committed-cost tracking. Project controls require WBS-level goods receipt data for cost-at-',
    `accounting_entry_posted` BOOLEAN COMMENT 'True when the financial posting for the receipt has been completed.',
    `actual_delivery_date` DATE COMMENT 'Date on which the material physically arrived at the site.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the received material.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the received material.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `delivery_note_number` STRING COMMENT 'Reference number of the suppliers delivery note accompanying the shipment.',
    `expected_delivery_date` DATE COMMENT 'Planned delivery date as per the purchase order.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost associated with delivering the material.',
    `freight_currency_code` STRING COMMENT 'Currency of the freight cost.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `goods_receipt_type` STRING COMMENT 'Indicates whether the receipt is from a purchase, internal transfer, or return.. Valid values are `purchase|transfer|return`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the received material before taxes and discounts.',
    `inspection_status` STRING COMMENT 'Current status of the quality inspection for the receipt.. Valid values are `pending|passed|failed|rework`',
    `is_critical_material` BOOLEAN COMMENT 'Indicates whether the material is classified as critical for project execution.',
    `is_hazardous` BOOLEAN COMMENT 'True if the material is hazardous and subject to special handling.',
    `lot_number` STRING COMMENT 'Lot identifier used for materials that are tracked by lot.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and any discounts.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the accounting entry was posted.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Amount of material physically received, expressed in the unit of measure.',
    `receipt_number` STRING COMMENT 'Business‑visible identifier assigned to the receipt (e.g., GR‑2023‑000123).',
    `receipt_status` STRING COMMENT 'Overall processing status of the goods receipt.. Valid values are `partial|complete|over_delivery|rejected`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Exact date and time the goods receipt was posted in the system.',
    `remarks` STRING COMMENT 'Free‑text field for additional comments or notes about the receipt.',
    `source_warehouse_code` STRING COMMENT 'Code of the warehouse or location from which the material originated.',
    `storage_location_code` STRING COMMENT 'Code of the warehouse or site location where the material is stored.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the goods receipt.',
    `tax_code` STRING COMMENT 'Tax classification code applied to the receipt.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the received quantity (e.g., kilograms, meters).. Valid values are `kg|m|l|pcs|m2|m3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the goods receipt record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the receipt record.',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of materials physically received at site or warehouse against a Purchase Order (PO). Captures GR date, PO reference, delivery note number, supplier, material, quantity received, unit of measure, batch/lot number, storage location, receiving inspector, and GR status (partial, complete, over-delivery). Triggers quality inspection workflow and updates stock levels. Aligns with SAP S/4HANA MIGO GR posting and Procore material delivery logs.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`goods_issue` (
    `goods_issue_id` BIGINT COMMENT 'System-generated unique identifier for the goods issue transaction.',
    `activity_id` BIGINT COMMENT 'Primavera activity identifier linked to the material consumption.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Required for tracking consumable material issues to specific equipment for cost allocation, compliance, and operational reporting.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Material issues are charged to a specific client; the link supports client cost tracking and invoicing.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the issue.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost Allocation: material issue costs are charged to a cost center for project accounting and financial reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material issues to site in construction are classified by cost code for earned value management and job cost reporting. A construction cost engineer expects every goods issue to carry a cost code to t',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Materials Issue process records which craft worker receives material for job tasks, needed for labor cost allocation and safety compliance.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Materials are issued to crews in construction — the crew foreman signs for bulk material issuances on behalf of the crew. Crew-level goods issue tracking is essential for crew productivity analysis, c',
    `field_progress_id` BIGINT COMMENT 'Foreign key linking to site.field_progress. Business justification: Earned value material reconciliation: field_progress records percent complete and installed quantities; goods_issue records materials consumed. Linking them enables comparison of materials issued vs. ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods issues generate accounting entries (inventory credit, WIP/expense debit) in construction ERP systems. The GL account reference on goods_issue is required for automated journal entry generation a',
    `master_id` BIGINT COMMENT 'Unique identifier of the material being issued.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Issuing hazardous or regulated materials on site must be authorized under an active compliance permit. goods_issue carries compliance_flag and hazard_classification, indicating regulated issuance. Com',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Issuing materials for high-risk activities (hot work, confined space, energised systems) requires a valid active Permit to Work. Storekeepers verify PTW before releasing materials — a standard constru',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to material.requisition. Business justification: A goods_issue (material issued from warehouse to a WBS/cost center) is typically triggered by a material requisition. Linking goods_issue.requisition_id -> requisition establishes the fulfillment trac',
    `return_issue_goods_issue_id` BIGINT COMMENT 'Identifier of the goods issue record that reverses this transaction, if any.',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to site.shift_report. Business justification: Shift-level material consumption reporting: goods issues are raised per shift for materials consumed during that shift. Linking goods_issue to shift_report enables shift-level material reconciliation ',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier that provided the material.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or stock location from which the material was issued.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Goods issues post actual material costs to WBS elements — this is the core actual-cost capture mechanism for EVM in construction. SAP MM/PS integration mandates WBS account assignment on every goods i',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Work-front material issuance tracking: materials are issued to specific work fronts for installation. Linking goods_issue to work_front enables work-front-level cost-at-completion forecasting and mate',
    `approval_status` STRING COMMENT 'Current approval state of the goods issue.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the issue was approved.',
    `batch_number` STRING COMMENT 'Batch or lot identifier for traceability of the material.',
    `comments` STRING COMMENT 'Free‑form notes entered by users regarding the issue.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the issued material complies with project specifications and safety standards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods issue record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `delivery_note_number` STRING COMMENT 'Reference number of the delivery note accompanying the material receipt.',
    `expiration_date` DATE COMMENT 'Date after which the material is no longer usable (if applicable).',
    `goods_issue_status` STRING COMMENT 'Current processing state of the goods issue record.. Valid values are `draft|issued|cancelled|reversed`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the issued material before taxes or discounts.',
    `hazard_classification` STRING COMMENT 'Safety classification of the material for handling and storage.. Valid values are `hazardous|non_hazardous|flammable|toxic|none`',
    `inspection_required` BOOLEAN COMMENT 'True if a post‑issue inspection is mandated for the material.',
    `inspection_status` STRING COMMENT 'Current status of the required inspection.. Valid values are `not_started|in_progress|completed|failed`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `is_returned` BOOLEAN COMMENT 'Indicates whether the issued material was later returned to inventory.',
    `issue_number` STRING COMMENT 'External reference number assigned to the goods issue for tracking and reconciliation.',
    `issue_reason` STRING COMMENT 'Business reason for issuing the material.. Valid values are `construction|maintenance|repair|testing|spare|other`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the material was physically issued from inventory.',
    `material_description` STRING COMMENT 'Human‑readable description of the material (e.g., grade, size).',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and any discounts.',
    `quantity_issued` DECIMAL(18,2) COMMENT 'Amount of material issued, expressed in the selected unit of measure.',
    `receipt_date` DATE COMMENT 'Date the material was received into the warehouse before issuance.',
    `source_document_number` STRING COMMENT 'Reference number of the originating purchase order or requisition.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable tax amount for the issued material.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is measured.. Valid values are `kg|m3|pcs|l|ton|bag`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the goods issue record.',
    CONSTRAINT pk_goods_issue PRIMARY KEY(`goods_issue_id`)
) COMMENT 'Transactional record of materials issued from warehouse/stock to a WBS element, cost center, or work front for construction consumption. Captures issue date, WBS/cost code, material, quantity issued, unit of measure, batch/lot, issuing warehouse, requestor, and issue reason. Drives material cost allocation to project activities and updates stock levels. Supports EVM cost tracking and BOQ consumption reconciliation.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'System-generated unique identifier for the stock transfer transaction.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Tracks material transfers that are initiated for a specific construction project in the Project Transfer Log.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material transfers between construction sites require cost center attribution for internal recharging and overhead allocation. Without this FK, inter-site transfer costs cannot be properly allocated i',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Inter-warehouse material transfers in construction are coded to cost codes for inter-project recharging and cost allocation reporting. A construction project accountant expects transfers to carry cost',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Material Transfer SOP records the crew responsible for moving stock between warehouses, supporting logistics accountability and cost tracking.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage location receiving the material.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Inter-site transfer inspection: materials transferred between warehouses/sites in construction require re-inspection at the destination to confirm condition after transport. Linking stock_transfer to ',
    `master_id` BIGINT COMMENT 'Identifier of the material being transferred (e.g., concrete, steel, MEP component).',
    `source_warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage location from which the material is transferred.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when the material was actually received at the destination warehouse.',
    `batch_number` STRING COMMENT 'Lot or batch identifier for traceability of the material (e.g., concrete batch, steel roll).',
    `carrier_name` STRING COMMENT 'Name of the logistics provider or carrier responsible for moving the material.',
    `comments` STRING COMMENT 'Free‑text field for additional notes or remarks about the transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock transfer record was first created in the system.',
    `document_reference` STRING COMMENT 'Reference to related documents such as transfer orders, packing lists, or customs paperwork.',
    `expected_arrival_date` DATE COMMENT 'Planned date on which the material is expected to arrive at the destination.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material moved in the transfer, expressed in the unit specified by unit_of_measure.',
    `stock_transfer_status` STRING COMMENT 'Current lifecycle state of the stock transfer (e.g., draft, planned, in‑transit, completed, cancelled).. Valid values are `draft|planned|in_transit|completed|cancelled`',
    `transfer_number` STRING COMMENT 'Human‑readable reference number assigned to the stock transfer for tracking and communication.',
    `transfer_reason` STRING COMMENT 'Business reason for the material movement, such as site reallocation or surplus return.. Valid values are `site_reallocation|project_closure|surplus_return|maintenance|other`',
    `transfer_timestamp` TIMESTAMP COMMENT 'Date and time when the material movement was initiated or recorded.',
    `transport_mode` STRING COMMENT 'Mode of transportation used for the transfer.. Valid values are `truck|rail|ship|air|pipeline`',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the quantity (kilograms, cubic meters, pieces, tons, pounds, gallons).. Valid values are `kg|m3|pcs|ton|lb|gal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the stock transfer record.',
    CONSTRAINT pk_stock_transfer PRIMARY KEY(`stock_transfer_id`)
) COMMENT 'Transactional record of material movements between warehouses, sites, or storage locations within the enterprise. Captures transfer date, source warehouse, destination warehouse, material, quantity, batch/lot, transfer reason (site reallocation, project closure, surplus return), transport reference, and transfer status (in-transit, completed, cancelled). Supports multi-site material balancing and inter-project material sharing.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`material_boq_line` (
    `material_boq_line_id` BIGINT COMMENT 'System‑generated unique identifier for the BOQ line item.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Required for BOQ line to be assigned to the scheduled activity that will consume the material, enabling cost‑tracking, schedule integration, and material requirement reports.',
    `boq_id` BIGINT COMMENT 'Identifier of the parent Bill of Quantities (BOQ) record to which this line belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: BOQ lines in construction are budgeted against cost centers for project financial control and budget allocation. A construction quantity surveyor expects each BOQ line to reference a cost center along',
    `estimate_line_id` BIGINT COMMENT 'Foreign key linking to bid.estimate_line. Business justification: Construction cost control requires reconciling material BOQ lines against the specific estimate lines that generated them. This link enables bid-to-actual material cost variance analysis and change or',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Required for BOQ Budgeting: each BOQ line is associated with a cost code to track planned vs. actual costs.',
    `master_id` BIGINT COMMENT 'Identifier of the material or item that this BOQ line represents.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: BOQ lines in construction reference the governing technical specification section (CSI division) for the work item being quantified. Quantity surveyors and cost engineers require this link for cost es',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: BOQ lines are directly tied to WBS elements for cost roll-up, EVM, and contract billing. Every construction cost engineer maps BOQ items to WBS nodes. wbs_code is a denormalized representation of wbs_',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: material_boq_line carries a denormalized wbs_code. BOQ lines are structured by WBS in construction cost management. A direct FK to wbs_node supports WBS-level BOQ cost rollup, budget control reporting',
    `contract_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material that is contractually committed in the BOQ.',
    `is_change_order` BOOLEAN COMMENT 'Indicates whether this line originates from a change order (true) or the original BOQ (false).',
    `item_description` STRING COMMENT 'Narrative description of the material or work item represented by the line.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the BOQ, used for sorting and display.',
    `material_boq_line_status` STRING COMMENT 'Current lifecycle status of the BOQ line.. Valid values are `active|inactive|revised|deleted`',
    `quantity` DECIMAL(18,2) COMMENT 'Planned quantity of the material as defined in the BOQ line, expressed in the unit of measure.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOQ line record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BOQ line record.',
    `revision_number` STRING COMMENT 'Version number of the line after each amendment.',
    `source_system` STRING COMMENT 'Name of the source operational system that supplied the BOQ line (e.g., SAP S/4HANA, Procore).',
    `total_value` DECIMAL(18,2) COMMENT 'Calculated line value (contract_quantity × unit_rate) in the project currency.',
    `trade_discipline` STRING COMMENT 'Construction trade or discipline (e.g., concrete, steel, MEP) associated with the line.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantity (e.g., m3, ton, pcs).',
    `unit_rate` DECIMAL(18,2) COMMENT 'Agreed price per unit of measure for the material.',
    CONSTRAINT pk_material_boq_line PRIMARY KEY(`material_boq_line_id`)
) COMMENT 'Bill of Quantities (BOQ) line item representing material and work quantities baselined for a project, used as the material domains reference for take-off reconciliation, consumption tracking, and procurement planning. Captures BOQ item code, description, unit of measure, contract quantity, unit rate, total value, WBS element, trade/discipline, and revision history. While contractual BOQ ownership may reside in the contract domain, this product serves as the material domains operational view for MTO reconciliation, material consumption variance analysis, and progress measurement against planned quantities.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`mto_line` (
    `mto_line_id` BIGINT COMMENT 'Primary key for mto_line',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Each MTO line is generated from a specific scheduled activitys material demand. Construction procurement scheduling depends on this link to align material required_by_date with activity planned_start',
    `bim_model_id` BIGINT COMMENT 'Identifier of the BIM model version containing the material definition.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with this MTO line.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for MTO Cost Planning: material take‑off quantities are allocated to cost centers for cost estimation and forecasting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: MTO lines drive material procurement cost estimates in construction. Linking to cost_code enables cost code-level material budget tracking and procurement commitment reporting — essential for construc',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: MTO lines are extracted from specific drawings; quantity surveyors and procurement teams must trace MTO quantities back to the source drawing for revision control and re-quantification when drawings a',
    `material_boq_line_id` BIGINT COMMENT 'Foreign key linking to material.material_boq_line. Business justification: An MTO (Material Take-Off) line is derived from engineering drawings and BIM models and represents the engineered quantity of a material. A BOQ (Bill of Quantities) line represents the contracted/base',
    `master_id` BIGINT COMMENT 'Reference to the material master record representing the specific material.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: MTO lines are the basis for material budget line items in construction project budgets. Linking mto_line to project_budget enables direct variance reporting between estimated MTO quantities/costs and ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MTO lines for regulated materials (asbestos, lead, hazardous chemicals) must be tied to the regulatory obligation governing their procurement and use. Procurement planners and compliance teams use thi',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: MTO lines flagged as critical (is_critical) or hazardous (is_hazardous) require a risk assessment reference for procurement approval. Construction procurement teams must confirm a risk assessment exis',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: Scope-to-procurement reconciliation: MTO lines are derived directly from contracted scope of work. Linking mto_line to contract_scope enables quantity surveyors to validate that material take-offs ali',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: MTO lines must reference the governing technical specification to ensure correct material grade and standard is procured. QA and procurement compliance processes require this traceability. material_s',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Material Take-Off lines are generated per WBS element to drive procurement planning and cost-to-complete analysis. Procurement planners and project controls engineers require WBS-level MTO visibility ',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: mto_line carries a denormalized wbs_code. WBS-level material quantity and cost tracking is a standard construction cost management report. Linking MTO lines to wbs_node enables WBS-level material budg',
    `actual_received_date` DATE COMMENT 'Date when the material was received on site.',
    `actual_received_quantity` DECIMAL(18,2) COMMENT 'Quantity of material actually received on site.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved the MTO line.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the MTO line was approved.',
    `compliance_certification` STRING COMMENT 'Applicable certification or standard (e.g., ISO9001, ASTM) that the material meets.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the MTO line record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 code of the currency for cost estimates.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `design_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material calculated from design drawings or BIM models.',
    `discipline` STRING COMMENT 'Engineering discipline associated with the material.. Valid values are `civil|structural|electrical|mechanical|plumbing|hvac`',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated cost per unit of material for procurement planning.',
    `expiry_date` DATE COMMENT 'Date after which the material is no longer usable or compliant.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the material is critical to project schedule or safety.',
    `is_deleted` BOOLEAN COMMENT 'Indicates whether the record has been logically deleted.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous.',
    `lead_time_days` STRING COMMENT 'Estimated number of days from order to delivery for the material.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the MTO header.',
    `lot_number` STRING COMMENT 'Batch or lot identifier for traceability of the material.',
    `mto_status` STRING COMMENT 'Current lifecycle status of the MTO line.. Valid values are `draft|approved|issued|rejected|closed|pending`',
    `net_required_quantity` DECIMAL(18,2) COMMENT 'Total material quantity required after applying wastage factor.',
    `notes` STRING COMMENT 'Free-text field for additional comments or remarks about the MTO line.',
    `procurement_status` STRING COMMENT 'Current status of the procurement process for this material line.. Valid values are `not_started|ordered|received|backordered|canceled|partial`',
    `quantity_uom_factor` DECIMAL(18,2) COMMENT 'Factor to convert between alternative units of measure for the material.',
    `required_by_date` DATE COMMENT 'Date by which the material must be on site to meet construction schedule.',
    `revision_number` STRING COMMENT 'Revision identifier of the drawing or BIM model for this line.',
    `safety_data_sheet_url` STRING COMMENT 'Link to the safety data sheet document for the material.',
    `supplier_preferred` STRING COMMENT 'Name or identifier of the preferred supplier for this material.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost calculated as net_required_quantity multiplied by estimated_unit_price.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the material quantities.. Valid values are `kg|m3|pcs|ton|lb|gal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the MTO line record.',
    `variance_cost` DECIMAL(18,2) COMMENT 'Difference between total_estimated_cost and actual cost incurred.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between net_required_quantity and actual_received_quantity.',
    `wastage_factor` DECIMAL(18,2) COMMENT 'Percentage factor applied to account for material loss during construction.',
    CONSTRAINT pk_mto_line PRIMARY KEY(`mto_line_id`)
) COMMENT 'Material Take-Off (MTO) line item derived from engineering drawings and BIM models, representing the estimated material quantities required for construction. Captures MTO item, material master reference, design quantity, wastage factor, net required quantity, unit of measure, drawing/BIM model reference, discipline (civil, structural, MEP), revision number, and MTO status (draft, approved, issued-for-procurement). Bridges design domain and procurement/inventory planning.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Primary key for requisition',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Material readiness reporting in lookahead planning requires knowing which scheduled activity triggered a requisition. Construction planners use this link to confirm material constraints are resolved b',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Material requisitions in construction are frequently raised for a specific equipment assets maintenance or repair needs (e.g., spare parts for Crane CR-001). Linking requisition to asset enables equi',
    `construction_project_id` BIGINT COMMENT 'Unique identifier of the construction project to which the requisition belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Budget Control: material requisitions are budgeted and approved against a specific cost center.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material requisitions in construction must be coded to cost codes for purchase commitment tracking and budget consumption. A construction procurement controller expects requisitions to carry cost code',
    `master_id` BIGINT COMMENT 'Master data identifier of the material or component being requested.',
    `mto_line_id` BIGINT COMMENT 'Foreign key linking to material.mto_line. Business justification: In construction materials management, site requisitions are typically raised against MTO lines — the engineering-derived material requirements drive procurement requisitions. Linking requisition.mto_l',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Material requisitions for hazardous or environmentally regulated materials must reference the authorizing compliance permit. compliance_document_number is a denormalized permit reference replaced by t',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to safety.permit_to_work. Business justification: Material requisitions for restricted work areas require a valid PTW before approval. The existing safety_review_status field is a denormalized status; the PTW FK enables direct traceability to the spe',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Requisition approval in construction requires budget availability check against the project budget. Linking requisition to project_budget enables automated budget sufficiency validation and commitment',
    `project_engagement_id` BIGINT COMMENT 'Foreign key linking to client.project_engagement. Business justification: Material requisitions must be raised against a specific client contract engagement to ensure correct cost allocation, retention tracking, and procurement authority validation. Construction project con',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order generated when stock is insufficient.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Material requisitions in construction are raised by craft foremen (craft workers with supervisory_role_flag=true) who identify site material needs. Tracking the requesting craft worker is required for',
    `site_id` BIGINT COMMENT 'Identifier of the physical construction site or location where the material is needed.',
    `trade_package_id` BIGINT COMMENT 'Foreign key linking to bid.trade_package. Business justification: Material requisitions in construction are raised against specific trade package scopes to control package budgets and procurement. This link supports trade package budget consumption tracking and pack',
    `warehouse_id` BIGINT COMMENT 'Warehouse or storage location identifier from which the material will be drawn.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Material requisitions are raised against WBS elements for budget commitment and cost charging. This is the fundamental project cost control mechanism in construction — requisitions must be WBS-coded f',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: requisition carries a denormalized wbs_code. WBS-level procurement planning and budget commitment tracking is a core construction cost control process. Linking requisitions to wbs_node enables WBS-lev',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Work-front-driven material demand: site engineers raise material requisitions against a specific work front to ensure materials arrive when and where needed. This link enables work-front-level materia',
    `approval_status` STRING COMMENT 'Status of the managerial or engineering approval workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the approval decision was recorded.',
    `change_order_number` STRING COMMENT 'Associated change order identifier if the requisition results from a scope change.',
    `cost_estimate_gross` DECIMAL(18,2) COMMENT 'Projected total cost of the requested material before taxes and discounts.',
    `cost_estimate_net` DECIMAL(18,2) COMMENT 'Projected net cost after tax and any discounts.',
    `cost_estimate_tax` DECIMAL(18,2) COMMENT 'Estimated tax component applicable to the material cost.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for the cost estimate.',
    `fulfillment_date` DATE COMMENT 'Date on which the material was actually issued to the site or received from a supplier.',
    `fulfillment_status` STRING COMMENT 'Progress state of the material issue or purchase fulfillment.. Valid values are `not_started|in_progress|completed|cancelled`',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether the requisition is an emergency (e.g., safety‑critical) request.',
    `is_stock_available` BOOLEAN COMMENT 'Indicates whether the requested material is currently available in warehouse inventory.',
    `justification` STRING COMMENT 'Narrative explanation for why the material is needed, supporting approval decisions.',
    `notes` STRING COMMENT 'Free‑form comments or additional information supplied by the requester.',
    `priority` STRING COMMENT 'Business priority indicating the urgency of the material request.. Valid values are `low|medium|high|critical`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material requested, expressed in the selected unit of measure.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when the requisition record was first persisted in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the requisition record.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the requisition was initially submitted by the site team.',
    `required_by_date` DATE COMMENT 'Date by which the material must be available on site to avoid schedule impact.',
    `requisition_number` STRING COMMENT 'External business identifier assigned to the requisition (e.g., RQ‑2024‑00123).',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition.. Valid values are `pending|approved|rejected|fulfilled|closed`',
    `safety_review_status` STRING COMMENT 'Result of the safety compliance review required for certain hazardous materials.. Valid values are `pending|cleared|failed`',
    `tax_code` STRING COMMENT 'Tax classification code applied to the material cost.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the requested quantity (e.g., kilograms, cubic meters).. Valid values are `kg|m3|pcs|ton|l`',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Site or project team request for materials to be issued from warehouse stock or procured. Captures requisition number, requesting WBS/work front, required material, quantity, required-by date, priority, justification, approval status (pending, approved, rejected), approver, and fulfilment status. Triggers either a goods issue (if stock available) or a purchase requisition in procurement. Supports site operations planning and material demand management.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`specification` (
    `specification_id` BIGINT COMMENT 'Primary key for specification',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to client.client_framework_agreement. Business justification: Framework agreements with clients mandate specific material grades and standards across all call-off projects. Linking material specifications to the governing framework agreement enables compliance a',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Specification defines technical details for a material; linking to material_master removes duplicate type and grade attributes and connects the spec to its parent material.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Required: Material specifications are tied to Regulatory Obligations that define performance and safety standards; essential for compliance verification.',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: RFP issuances in construction define client-mandated material specifications (grade, standard, compliance). Linking material specifications to the originating RFP enables bid preparation teams to veri',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Material specifications in construction mandate specific skill trades for installation (e.g., structural steel specs require certified welders, HV cable specs require licensed electricians). This spec',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Material specifications must be derived from and comply with the projects design technical specifications. The material approval process requires tracing each material specification back to the gover',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: REQUIRED: Tender documents cite specific material specifications that suppliers must meet; linking enables traceability of spec compliance.',
    `applicable_project_type` STRING COMMENT 'Project categories where this specification may be applied.. Valid values are `highway|bridge|residential|commercial|industrial|airport`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the specification.',
    `compliance_requirements` STRING COMMENT 'Textual description of regulatory or client compliance requirements tied to the specification.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of the material per unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specification record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost per unit.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `effective_from` DATE COMMENT 'Date when the specification becomes effective for use.',
    `effective_until` DATE COMMENT 'Date when the specification expires or is superseded (nullable).',
    `handling_instructions` STRING COMMENT 'Guidelines for safe handling and transport of the material.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this specification is the default for its material type.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the specification record.',
    `lead_time_days` STRING COMMENT 'Expected lead time from order to delivery for the material.',
    `leeds_credit_applicability` STRING COMMENT 'Indicates whether the specification contributes to a LEED credit (yes) or not (no).. Valid values are `yes|no`',
    `material_category` STRING COMMENT 'High‑level category of the material (e.g., concrete, steel, MEP).',
    `min_compressive_strength_mpa` DECIMAL(18,2) COMMENT 'Minimum compressive strength required for the material, expressed in megapascal.',
    `min_modulus_of_elasticity_gpa` DECIMAL(18,2) COMMENT 'Minimum modulus of elasticity required, expressed in gigapascal.',
    `min_tensile_strength_mpa` DECIMAL(18,2) COMMENT 'Minimum tensile strength required for the material, expressed in megapascal.',
    `min_yield_strength_mpa` DECIMAL(18,2) COMMENT 'Minimum yield strength required for the material, expressed in megapascal.',
    `safety_data_sheet_url` STRING COMMENT 'Link to the electronic safety data sheet (SDS) for the material.',
    `specification_code` STRING COMMENT 'Business identifier code assigned to the specification (e.g., SPEC-00123).',
    `specification_description` STRING COMMENT 'Detailed textual description of the specification purpose, scope, and application.',
    `specification_name` STRING COMMENT 'Human‑readable name of the material specification.',
    `specification_status` STRING COMMENT 'Current lifecycle status of the specification.. Valid values are `draft|approved|superseded|retired`',
    `standard_code` STRING COMMENT 'Specific standard code (e.g., ASTM C150, ISO 9001).',
    `standard_reference` STRING COMMENT 'Reference to the governing standard body (e.g., ASTM, ISO, BS, ACI).',
    `storage_requirements` STRING COMMENT 'Special storage conditions required (e.g., temperature, humidity).',
    `substitute_specification_code` STRING COMMENT 'Code of an alternative specification that can be used in place of this one.',
    `supplier_code` STRING COMMENT 'Identifier of the preferred supplier for this material specification.',
    `version_number` STRING COMMENT 'Sequential version number of the specification.',
    `warranty_conditions` STRING COMMENT 'Specific conditions or exclusions that apply to the warranty.',
    `warranty_period_months` STRING COMMENT 'Length of warranty coverage for the material, expressed in months.',
    CONSTRAINT pk_specification PRIMARY KEY(`specification_id`)
) COMMENT 'Technical specification master for construction materials defining approved material standards, grades, and performance requirements for a project or enterprise. Captures specification code, material category, applicable standard (ASTM, BS, ISO, ACI, AISC), grade/class, minimum performance criteria, approved equivalent substitutes, LEED credit applicability, and specification status (draft, approved, superseded). Links design requirements to procurement and QA/QC inspection criteria.';

CREATE OR REPLACE TABLE `construction_ecm`.`material`.`wastage` (
    `wastage_id` BIGINT COMMENT 'Primary key for wastage',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract under which the material was procured.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: REQUIRED: Waste records are allocated to a client for environmental reporting, cost recovery and contractual penalties.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the wastage belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Waste Cost Tracking: waste records must be posted to the responsible cost center for cost control and reporting.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Material wastage costs in construction are classified by cost code for project cost variance reporting and waste reduction analysis. A construction project controller expects wastage records to carry ',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Wastage tracking logs the worker generating waste, required for waste cost attribution and regulatory reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Material wastage generates write-off accounting entries in construction (inventory credit, waste expense debit). The GL account reference on wastage is required for automated journal entry generation ',
    `goods_issue_id` BIGINT COMMENT 'Foreign key linking to material.goods_issue. Business justification: Wastage is generated during construction activities when materials issued from the warehouse are partially or fully wasted/scrapped. The goods_issue record captures the original issuance of that mater',
    `hse_plan_id` BIGINT COMMENT 'Foreign key linking to safety.hse_plan. Business justification: Hazardous waste disposal procedures and reporting obligations are governed by the site HSE plan. Construction sites must demonstrate that wastage disposal methods comply with the applicable HSE plan —',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Hazardous material wastage events (spills, fire damage, structural failure) are directly caused by or associated with safety incidents. Linking wastage to the triggering incident enables incident cost',
    `master_id` BIGINT COMMENT 'Identifier of the material type that was wasted.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Waste disposal on construction sites requires an active environmental/waste disposal permit distinct from the regulatory obligation already linked. Compliance teams must verify each waste disposal eve',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Required: Waste records must be linked to the specific Regulatory Obligation governing disposal; mandatory for reporting and audit.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier that provided the material.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Wastage records are attributed to WBS elements for cost variance analysis, waste factor benchmarking, and regulatory waste reporting per project scope. Construction project controls require WBS-level ',
    `wbs_node_id` BIGINT COMMENT 'Foreign key linking to schedule.wbs_node. Business justification: wastage carries a denormalized wbs_code. WBS-level waste cost variance reporting is a standard construction cost control requirement. Linking wastage to wbs_node enables WBS-level waste cost rollup fo',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Work-front waste reporting: environmental compliance and cost control require waste to be attributed to the specific work front where it occurred. The plain text work_front column on wastage is a de',
    `actual_quantity_consumed` DECIMAL(18,2) COMMENT 'Quantity of material actually used in the activity.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was approved.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the material.',
    `cause` STRING COMMENT 'Root cause of the material wastage.. Valid values are `cutting_loss|breakage|over_pour|theft|weather_damage|other`',
    `cost_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the waste cost values.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wastage record was first created in the system.',
    `disposal_date` DATE COMMENT 'Date on which the waste was actually disposed.',
    `disposal_location` STRING COMMENT 'Physical location where the waste was disposed or processed.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the wasted material.. Valid values are `recycled|landfill|returned|incinerated|other`',
    `hazard_classification` STRING COMMENT 'Hazard class of the material according to regulatory standards.. Valid values are `class_a|class_b|class_c|class_d|class_e|class_f`',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the wasted material is classified as hazardous.',
    `is_recyclable` BOOLEAN COMMENT 'Flag indicating whether the waste material is recyclable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the wastage record.',
    `lot_number` STRING COMMENT 'Lot identifier for the material, used for quality and compliance tracking.',
    `material_code` STRING COMMENT 'Standard code or SKU for the material.',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the waste event.',
    `percentage` DECIMAL(18,2) COMMENT 'Wastage quantity expressed as a percentage of planned quantity.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material originally planned for the activity.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material that was wasted or scrapped.',
    `regulatory_compliance_flag` STRING COMMENT 'Indicates compliance status of waste handling with applicable regulations (e.g., OSHA, EPA).. Valid values are `compliant|non_compliant|exempt`',
    `reporting_period` STRING COMMENT 'Period (e.g., YYYY‑MM) for which the waste is reported.',
    `source_system` STRING COMMENT 'Originating system that supplied the waste data.. Valid values are `SAP|Procore|BIM360|Viewpoint|HCSS|Aconex`',
    `unit_of_measure` STRING COMMENT 'Unit used for quantity fields (e.g., kilograms, cubic meters).. Valid values are `kg|m3|ton|lb`',
    `wastage_date` DATE COMMENT 'Date on which the material wastage event occurred.',
    `wastage_status` STRING COMMENT 'Current lifecycle status of the wastage record.. Valid values are `recorded|reviewed|approved|closed`',
    `waste_cost_adjustment` DECIMAL(18,2) COMMENT 'Adjustments (e.g., rebates, penalties) applied to the gross waste cost.',
    `waste_cost_gross` DECIMAL(18,2) COMMENT 'Total cost associated with the waste before any adjustments.',
    `waste_cost_net` DECIMAL(18,2) COMMENT 'Net cost after adjustments, representing the financial impact of the waste.',
    `waste_record_number` STRING COMMENT 'Human‑readable identifier assigned to the wastage entry for tracking and reference.',
    `waste_type` STRING COMMENT 'Category of material that was wasted.. Valid values are `concrete|steel|mep|wood|plastic|other`',
    CONSTRAINT pk_wastage PRIMARY KEY(`wastage_id`)
) COMMENT 'Transactional record tracking material wastage and scrap generated during construction activities. Captures wastage date, WBS/work front, material, planned quantity, actual quantity consumed, wastage quantity, wastage percentage, wastage cause (cutting loss, breakage, over-pour, theft, weather damage), disposal method (recycled, landfill, returned), and cost impact. Supports waste reduction programs, LEED waste diversion tracking, and project cost control.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`material`.`master` ADD CONSTRAINT `fk_material_master_substitution_material_master_id` FOREIGN KEY (`substitution_material_master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `construction_ecm`.`material`.`requisition`(`requisition_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_return_issue_goods_issue_id` FOREIGN KEY (`return_issue_goods_issue_id`) REFERENCES `construction_ecm`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ADD CONSTRAINT `fk_material_stock_transfer_source_warehouse_id` FOREIGN KEY (`source_warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ADD CONSTRAINT `fk_material_material_boq_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_material_boq_line_id` FOREIGN KEY (`material_boq_line_id`) REFERENCES `construction_ecm`.`material`.`material_boq_line`(`material_boq_line_id`);
ALTER TABLE `construction_ecm`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `construction_ecm`.`material`.`mto_line`(`mto_line_id`);
ALTER TABLE `construction_ecm`.`material`.`requisition` ADD CONSTRAINT `fk_material_requisition_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `construction_ecm`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `construction_ecm`.`material`.`specification` ADD CONSTRAINT `fk_material_specification_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `construction_ecm`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `construction_ecm`.`material`.`wastage` ADD CONSTRAINT `fk_material_wastage_master_id` FOREIGN KEY (`master_id`) REFERENCES `construction_ecm`.`material`.`master`(`master_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`material` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `construction_ecm`.`material` SET TAGS ('dbx_domain' = 'material');
ALTER TABLE `construction_ecm`.`material`.`master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`material`.`master` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Master Identifier');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `substitution_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Material ID');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approved Timestamp');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `conformance_certificate_date` SET TAGS ('dbx_business_glossary_term' = 'Conformance Certificate Date');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `conformance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Conformance Certificate Number');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Dimensions (cm)');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `leeds_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'LEED Compliance Flag');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('dbx_business_glossary_term' = 'LEED Credit Applicability');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('dbx_value_regex' = 'energy|water|materials|innovation|none');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Material Lifecycle Status');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|draft|pending');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `manufacturer_country` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Country');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `master_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `master_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `material_origin_country` SET TAGS ('dbx_business_glossary_term' = 'Material Origin Country');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `max_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `minimum_performance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Minimum Performance Criteria');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `specification_grade` SET TAGS ('dbx_business_glossary_term' = 'Specification Grade');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `specification_standard` SET TAGS ('dbx_business_glossary_term' = 'Specification Standard');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `substitution_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Substitution Approval Reference');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `technical_specification` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|l|m|ft');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `construction_ecm`.`material`.`master` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`material`.`warehouse` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('dbx_business_glossary_term' = 'Access Control Method');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('dbx_value_regex' = 'badge|biometric|keycard|none');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `capacity_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Area Capacity (SQM)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `capacity_weight_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Weight Capacity (TONNES)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_business_glossary_term' = 'Climate Control Type');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `climate_control_type` SET TAGS ('dbx_value_regex' = 'refrigerated|heated|ambient');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO‑3166‑1 Alpha‑3)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|AUS');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (METERS)');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `inventory_management_system` SET TAGS ('dbx_business_glossary_term' = 'Inventory Management System');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `is_hazardous_material_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Certification Flag');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Notes');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `storage_zone_details` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone Details');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature‑Controlled Flag');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_description` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Description');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Status');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|maintenance');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Type');
ALTER TABLE `construction_ecm`.`material`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_value_regex' = 'bonded|open_yard|climate_controlled|hazmat_certified|general');
ALTER TABLE `construction_ecm`.`material`.`stock_level` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`material`.`stock_level` SET TAGS ('dbx_subdomain' = 'stock_control');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `stock_level_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Level ID');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `blocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In‑Transit Quantity');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_value_regex' = 'receipt|issue|transfer|return|adjustment');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `quality_inspection_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Quantity');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `stock_level_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `stock_level_status` SET TAGS ('dbx_value_regex' = 'available|blocked|reserved|in_transit|quality_hold|consumed');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`material`.`stock_level` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` SET TAGS ('dbx_subdomain' = 'stock_control');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Identifier');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `material_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Material Delivery Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `test_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Test Certificate Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `accounting_entry_posted` SET TAGS ('dbx_business_glossary_term' = 'Accounting Entry Posted Flag');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `goods_receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Type');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `goods_receipt_type` SET TAGS ('dbx_value_regex' = 'purchase|transfer|return');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|rework');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `is_critical_material` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'partial|complete|over_delivery|rejected');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `source_warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse Code');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m|l|pcs|m2|m3');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_movement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` SET TAGS ('dbx_subdomain' = 'stock_control');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue ID');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity ID');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `field_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Field Progress Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `return_issue_goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Return Issue ID');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Status');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_value_regex' = 'draft|issued|cancelled|reversed');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (Currency)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|flammable|toxic|none');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Returned Flag');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Number (GI Number)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `issue_reason` SET TAGS ('dbx_business_glossary_term' = 'Issue Reason');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `issue_reason` SET TAGS ('dbx_value_regex' = 'construction|maintenance|repair|testing|spare|other');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (Currency)');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|l|ton|bag');
ALTER TABLE `construction_ecm`.`material`.`goods_issue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'stock_control');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse ID');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `source_warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Source Warehouse ID');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `stock_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `stock_transfer_status` SET TAGS ('dbx_value_regex' = 'draft|planned|in_transit|completed|cancelled');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `transfer_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Number');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `transfer_reason` SET TAGS ('dbx_value_regex' = 'site_reallocation|project_closure|surplus_return|maintenance|other');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ship|air|pipeline');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `construction_ecm`.`material`.`stock_transfer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `material_boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Material BOQ Line ID');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `boq_id` SET TAGS ('dbx_business_glossary_term' = 'BOQ Header ID');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `estimate_line_id` SET TAGS ('dbx_business_glossary_term' = 'Estimate Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `contract_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contract Quantity');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `is_change_order` SET TAGS ('dbx_business_glossary_term' = 'Is Change Order Flag');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `material_boq_line_status` SET TAGS ('dbx_business_glossary_term' = 'BOQ Line Status');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `material_boq_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revised|deleted');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Line Value');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `trade_discipline` SET TAGS ('dbx_business_glossary_term' = 'Trade / Discipline');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `construction_ecm`.`material`.`material_boq_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate (Price per UOM)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`material`.`mto_line` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `mto_line_id` SET TAGS ('dbx_business_glossary_term' = 'Mto Line Identifier');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'BIM Model Identifier (BIM_ID)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `material_boq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Material Boq Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `actual_received_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Received Date');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `actual_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Received Quantity');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `design_quantity` SET TAGS ('dbx_business_glossary_term' = 'Design Quantity (DESIGN_QTY)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `discipline` SET TAGS ('dbx_business_glossary_term' = 'Discipline');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `discipline` SET TAGS ('dbx_value_regex' = 'civil|structural|electrical|mechanical|plumbing|hvac');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price (EST_UNIT_PRICE)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot / Batch Number');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `mto_status` SET TAGS ('dbx_business_glossary_term' = 'MTO Line Status');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `mto_status` SET TAGS ('dbx_value_regex' = 'draft|approved|issued|rejected|closed|pending');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `net_required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Required Quantity (NET_QTY)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `procurement_status` SET TAGS ('dbx_value_regex' = 'not_started|ordered|received|backordered|canceled|partial');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `quantity_uom_factor` SET TAGS ('dbx_business_glossary_term' = 'Quantity UOM Conversion Factor');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `supplier_preferred` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost (EST_TOTAL_COST)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|ton|lb|gal');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `variance_cost` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `construction_ecm`.`material`.`mto_line` ALTER COLUMN `wastage_factor` SET TAGS ('dbx_business_glossary_term' = 'Wastage Factor (WASTAGE_FCTR)');
ALTER TABLE `construction_ecm`.`material`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`material`.`requisition` SET TAGS ('dbx_subdomain' = 'stock_control');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `activity_id` SET TAGS ('dbx_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `mto_line_id` SET TAGS ('dbx_business_glossary_term' = 'Mto Line Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Engagement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `trade_package_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location ID');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `cost_estimate_gross` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Cost');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `cost_estimate_net` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Cost');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `cost_estimate_tax` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cancelled');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Request Flag');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `is_stock_available` SET TAGS ('dbx_business_glossary_term' = 'Stock Availability Flag');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|fulfilled|closed');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Status');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `safety_review_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `construction_ecm`.`material`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|ton|l');
ALTER TABLE `construction_ecm`.`material`.`specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`material`.`specification` SET TAGS ('dbx_subdomain' = 'material_registry');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Identifier');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Framework Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `skill_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `applicable_project_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Project Type');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `applicable_project_type` SET TAGS ('dbx_value_regex' = 'highway|bridge|residential|commercial|industrial|airport');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Specification');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('dbx_business_glossary_term' = 'LEED Credit Applicability');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `leeds_credit_applicability` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `min_compressive_strength_mpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Compressive Strength (MPa)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `min_modulus_of_elasticity_gpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Modulus of Elasticity (GPa)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `min_tensile_strength_mpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tensile Strength (MPa)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `min_yield_strength_mpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Yield Strength (MPa)');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `safety_data_sheet_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `specification_code` SET TAGS ('dbx_business_glossary_term' = 'Specification Code');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `specification_description` SET TAGS ('dbx_business_glossary_term' = 'Specification Description');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `specification_name` SET TAGS ('dbx_business_glossary_term' = 'Specification Name');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_value_regex' = 'draft|approved|superseded|retired');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `substitute_specification_code` SET TAGS ('dbx_business_glossary_term' = 'Substitute Specification Code');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Code');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Specification Version Number');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `warranty_conditions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Conditions');
ALTER TABLE `construction_ecm`.`material`.`specification` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `construction_ecm`.`material`.`wastage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`material`.`wastage` SET TAGS ('dbx_subdomain' = 'stock_control');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `wastage_id` SET TAGS ('dbx_business_glossary_term' = 'Wastage Identifier');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Craft Worker Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `hse_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Plan Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `wbs_node_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Node Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `actual_quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Consumed');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `cause` SET TAGS ('dbx_business_glossary_term' = 'Wastage Cause');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `cause` SET TAGS ('dbx_value_regex' = 'cutting_loss|breakage|over_pour|theft|weather_damage|other');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `disposal_location` SET TAGS ('dbx_business_glossary_term' = 'Disposal Location');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycled|landfill|returned|incinerated|other');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|class_d|class_e|class_f');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `is_recyclable` SET TAGS ('dbx_business_glossary_term' = 'Is Recyclable');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Wastage Percentage');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Wastage Quantity');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Procore|BIM360|Viewpoint|HCSS|Aconex');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|ton|lb');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `wastage_date` SET TAGS ('dbx_business_glossary_term' = 'Wastage Date');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `wastage_status` SET TAGS ('dbx_business_glossary_term' = 'Wastage Record Status');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `wastage_status` SET TAGS ('dbx_value_regex' = 'recorded|reviewed|approved|closed');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `waste_cost_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Waste Cost Adjustment');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `waste_cost_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Waste Cost');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `waste_cost_net` SET TAGS ('dbx_business_glossary_term' = 'Net Waste Cost');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `waste_record_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Number (WRN)');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type');
ALTER TABLE `construction_ecm`.`material`.`wastage` ALTER COLUMN `waste_type` SET TAGS ('dbx_value_regex' = 'concrete|steel|mep|wood|plastic|other');
