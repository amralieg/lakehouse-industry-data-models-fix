-- Schema for Domain: distribution | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-24 01:55:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`distribution` COMMENT 'Owns warehouse operations, inventory management, and order fulfillment across distribution centers. Manages inbound/outbound logistics within DCs, put-away/picking/packing processes, cycle counting, FEFO/FIFO inventory rotation, WMS integration (Blue Yonder), OTIF performance, OSA metrics, and DSD execution for direct store delivery channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` (
    `distribution_facility_id` BIGINT COMMENT 'Primary key for facility',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each distribution facility operates under a legal entity (company code) for statutory reporting, tax compliance, and intercompany billing in multi-entity consumer goods companies. Required for goods m',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each distribution facility is a cost center in consumer goods — facility operating costs (labor, utilities, lease, maintenance) are tracked against a cost center for budget control and facility-level ',
    `manufacturing_facility_id` BIGINT COMMENT 'FK to manufacturing facility if co-located',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution facilities in multi-brand consumer goods companies are mapped to profit centers for regional/channel P&L reporting. Facility throughput and logistics costs are attributed to a profit cent',
    `network_node_id` BIGINT COMMENT 'Links DC to supply network node; distinct from manufacturing_facility which is a production site',
    `address_line1` STRING COMMENT '',
    `address_line_1` STRING COMMENT 'Primary street address line for the distribution center facility. Organizational contact data classified as confidential business information.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential business information.',
    `capacity_sqft` DECIMAL(18,2) COMMENT '',
    `city` STRING COMMENT 'City or municipality where the distribution center is located. Organizational contact data classified as confidential business information.',
    `closed_date` DATE COMMENT 'Date when the distribution center ceased operations. Null for active facilities. Used for historical analysis and network optimization studies.',
    `contact_email` STRING COMMENT 'Primary contact email address for the distribution center. Organizational contact data classified as confidential business information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the distribution center. Organizational contact data classified as confidential business information.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the distribution center is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution center record was first created in the system. Audit trail for data lineage and compliance.',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'Indicates whether the facility supports cross-docking operations where inbound goods are directly transferred to outbound shipments with minimal storage time.',
    `cycle_count_frequency_days` STRING COMMENT 'Standard frequency in days for cycle counting inventory at this facility. Used for inventory accuracy management and audit compliance.',
    `dc_code` STRING COMMENT 'Business identifier code for the distribution center used across operational systems. Externally-known unique code for the facility.. Valid values are `^[A-Z0-9]{4,12}$`',
    `dc_name` STRING COMMENT 'Official business name of the distribution center or warehouse facility.',
    `distribution_facility_status` STRING COMMENT '',
    `dock_doors_inbound` STRING COMMENT 'Number of dock doors designated for inbound receiving operations. Impacts receiving throughput capacity and scheduling.',
    `dock_doors_outbound` STRING COMMENT 'Number of dock doors designated for outbound shipping operations. Impacts shipping throughput capacity and carrier scheduling.',
    `dsd_hub_flag` BOOLEAN COMMENT 'Indicates whether this facility serves as a DSD hub for direct-to-retail delivery operations. DSD hubs bypass traditional distribution channels for faster store replenishment.',
    `facility_code` STRING COMMENT '',
    `facility_name` STRING COMMENT '',
    `facility_type` STRING COMMENT 'Classification of the distribution center based on temperature control and operational model. Ambient for room temperature, chilled for refrigerated, frozen for sub-zero, multi-temperature for mixed zones, DSD hub for Direct Store Delivery operations, cross-dock for flow-through distribution.. Valid values are `ambient|chilled|frozen|multi_temperature|dsd_hub|cross_dock`',
    `fsc_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified under FSC chain of custody standards for sustainable sourcing. Required for handling FSC-certified paper and wood-based products.',
    `gmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified under Good Manufacturing Practice standards. Required for handling cosmetics, personal care, and certain consumer goods products.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the facility is certified to handle and store hazardous materials. Required for distribution of products with EPA or OSHA regulated substances.',
    `inventory_rotation_method` STRING COMMENT 'Primary inventory rotation method used at this facility. FIFO (First In First Out) for standard goods, FEFO (First Expired First Out) for perishables and date-sensitive products, LIFO (Last In First Out) for specific use cases.. Valid values are `fifo|fefo|lifo`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the distribution center in decimal degrees. Used for geospatial analytics, route optimization, and logistics planning.',
    `lease_expiration_date` DATE COMMENT 'Expiration date of the facility lease agreement. Null for owned facilities. Used for lease renewal planning and facility strategy.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the distribution center in decimal degrees. Used for geospatial analytics, route optimization, and logistics planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution center record was last modified. Audit trail for change tracking and data quality monitoring.',
    `opened_date` DATE COMMENT 'Date when the distribution center commenced operations. Used for facility age analysis and depreciation calculations.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for weekdays in format HH:MM-HH:MM. Used for scheduling inbound deliveries, outbound shipments, and workforce planning.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for weekends in format HH:MM-HH:MM. Used for scheduling weekend operations and carrier coordination.',
    `operational_status` STRING COMMENT 'Current operational state of the distribution center in its lifecycle. Active indicates full operations, inactive for temporarily closed, under construction for new facilities being built, decommissioned for permanently closed, seasonal for facilities operating only during peak periods, maintenance for temporary closure due to upgrades or repairs.. Valid values are `active|inactive|under_construction|decommissioned|seasonal|maintenance`',
    `osa_target_percentage` DECIMAL(18,2) COMMENT 'Target OSA performance percentage for stores served by this distribution center. OSA measures product availability at retail shelf level.',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'Target OTIF performance percentage for this distribution center. OTIF measures the percentage of orders delivered on time and in full, a key supply chain KPI.',
    `ownership_type` STRING COMMENT 'Classification of facility ownership model. Owned for company-owned facilities, leased for long-term leased properties, third-party logistics for 3PL-operated warehouses.. Valid values are `owned|leased|third_party_logistics`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the distribution center address. Organizational contact data classified as confidential business information.',
    `purpose` STRING COMMENT 'Purpose classification: distribution, cross-dock, hub',
    `sap_plant_code` STRING COMMENT 'SAP S/4HANA plant code representing this distribution center in the ERP system. Maps to the SAP MM and WM modules for material management and warehouse management.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_storage_location` STRING COMMENT 'SAP S/4HANA storage location code within the plant. Represents the primary storage location identifier for inventory transactions in SAP WM module.. Valid values are `^[A-Z0-9]{4}$`',
    `shifts_per_day` STRING COMMENT 'Number of operational shifts per day at the facility. Used for labor planning, throughput capacity modeling, and operational cost analysis.',
    `source_system_code` STRING COMMENT '',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the facility is located. Organizational contact data classified as confidential business information.',
    `storage_capacity_pallet_positions` STRING COMMENT 'Maximum number of pallet positions available for storage. Key metric for inventory capacity planning and space utilization analysis.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the facility has temperature-controlled storage zones. True for facilities with chilled or frozen capabilities, false for ambient-only.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the distribution center location. Used for scheduling, shift planning, and cross-facility coordination.',
    `total_capacity_sqft` DECIMAL(18,2) COMMENT 'Total warehouse floor space capacity in square feet. Includes all storage, staging, and operational areas within the facility.',
    `wms_site_code` STRING COMMENT 'Unique site identifier in the Blue Yonder WMS system. Used for integration and synchronization between the lakehouse and the operational WMS platform.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    CONSTRAINT pk_distribution_facility PRIMARY KEY(`distribution_facility_id`)
) COMMENT 'Physical distribution center or warehouse used for storing and shipping finished goods to customers. SSOT owner for distribution/logistics facility master. Distinct from manufacturing_facility which represents production plants.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Primary key for storage_location',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the parent distribution center facility where this storage location resides.',
    `abc_classification` STRING COMMENT 'Velocity-based classification of the location for slotting optimization: A (high-velocity/fast-moving), B (medium-velocity), C (low-velocity/slow-moving).. Valid values are `A|B|C`',
    `aisle` STRING COMMENT 'Aisle designation within the warehouse layout for physical navigation and picking route optimization.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bay` STRING COMMENT 'Bay or column position within the aisle for precise horizontal location reference.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bin_position` STRING COMMENT 'Specific bin or slot position within the level for granular inventory placement and retrieval.. Valid values are `^[A-Z0-9]{1,5}$`',
    `blocked_date` DATE COMMENT 'Date when the storage location was blocked or made unavailable for operations.',
    `blocked_flag` BOOLEAN COMMENT '',
    `blocked_reason` STRING COMMENT 'Explanation for why the location is blocked or unavailable, such as maintenance, damage, safety hold, or quality quarantine.',
    `capacity_units` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the storage location record was first created in the WMS system.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for cycle counting inventory at this location to maintain inventory accuracy and compliance.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `distribution_storage_location_level` STRING COMMENT 'Vertical level or shelf position within the bay for height-based slotting and equipment compatibility.. Valid values are `^[A-Z0-9]{1,3}$`',
    `distribution_storage_location_status` STRING COMMENT '',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether the location is designated for DSD operations where products bypass the DC and are delivered directly to retail stores.',
    `effective_date` DATE COMMENT 'Date when the storage location became active and available for warehouse operations.',
    `equipment_type_required` STRING COMMENT 'Type of material handling equipment required to access this storage location for put-away and picking operations.. Valid values are `forklift|reach_truck|order_picker|pallet_jack|manual|automated`',
    `expiration_date` DATE COMMENT 'Date when the storage location is scheduled to be decommissioned or removed from active use. Null for indefinite locations.',
    `fefo_eligible_flag` BOOLEAN COMMENT 'Indicates whether the location supports FEFO inventory rotation logic for expiry-sensitive products (pharmaceuticals, food, cosmetics).',
    `fifo_eligible_flag` BOOLEAN COMMENT 'Indicates whether the location supports FIFO inventory rotation logic for age-based stock management.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the location is certified and equipped for storing hazardous materials per OSHA and EPA regulations.',
    `height_cm` DECIMAL(18,2) COMMENT 'Physical height dimension of the storage location in centimeters for vertical clearance and equipment reach validation.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent cycle count was performed at this storage location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the storage location record was most recently updated in the WMS system.',
    `length_cm` DECIMAL(18,2) COMMENT 'Physical length dimension of the storage location in centimeters for dimensional slotting and equipment compatibility.',
    `location_code` STRING COMMENT 'Business identifier for the storage location as defined in Blue Yonder WMS. Typically formatted as aisle-bay-level-bin (e.g., A01-B05-L03-P12).. Valid values are `^[A-Z0-9]{2,20}$`',
    `location_name` STRING COMMENT 'Human-readable name or description of the storage location for operational reference.',
    `location_status` STRING COMMENT 'Current operational status of the storage location indicating availability for inventory placement and retrieval.. Valid values are `active|inactive|blocked|maintenance|quarantine|damaged`',
    `location_type` STRING COMMENT 'Classification of the storage location by operational function: bulk storage, active pick face, reserve inventory, staging area, dock door, or cross-dock zone.. Valid values are `bulk|pick|reserve|staging|dock|cross_dock`',
    `mixed_lot_allowed_flag` BOOLEAN COMMENT 'Indicates whether the location permits storage of multiple lot or batch numbers for the same SKU or requires lot segregation.',
    `mixed_sku_allowed_flag` BOOLEAN COMMENT 'Indicates whether the location permits storage of multiple SKUs simultaneously or requires single-SKU dedication.',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether this location is designated as an active pick face for order fulfillment operations.',
    `picking_strategy` STRING COMMENT 'Order fulfillment picking method supported by this location: batch picking, wave picking, zone picking, discrete (single-order), or cluster picking.. Valid values are `batch|wave|zone|discrete|cluster`',
    `putaway_strategy` STRING COMMENT 'Algorithm used to assign incoming inventory to this location: directed (system-assigned), random, fixed (dedicated SKU), or dynamic (velocity-based).. Valid values are `directed|random|fixed|dynamic`',
    `replenishment_priority` STRING COMMENT 'Priority ranking for automated replenishment from reserve to pick locations, with lower numbers indicating higher priority.',
    `source_system_code` STRING COMMENT '',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the storage location to ensure product integrity and regulatory compliance (ambient, refrigerated 2-8°C, frozen <-18°C, controlled room temperature).. Valid values are `ambient|refrigerated|frozen|controlled`',
    `volume_capacity_m3` DECIMAL(18,2) COMMENT 'Maximum volume capacity of the storage location in cubic meters for space utilization and slotting algorithms.',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms for safe load management and slotting optimization.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width dimension of the storage location in centimeters for dimensional slotting and equipment compatibility.',
    `zone_code` STRING COMMENT 'Logical zone classification within the distribution center for grouping locations by product category, velocity, or operational workflow (e.g., FAST-PICK, SLOW-MOVE, HAZMAT).. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Physical storage bin/slot/rack within a distribution facility (WMS-managed). SSOT for physical DC location layout. Distinct from inventory.inventory_storage_location which is the logical inventory holding location.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` (
    `inbound_receipt_id` BIGINT COMMENT 'Unique identifier for the inbound receipt transaction. Primary key for this entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Inbound receipts must be posted to a specific company code for goods receipt accounting in multi-entity consumer goods companies. Drives intercompany inventory transfer postings, statutory inventory r',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving operations incur expenses (labor, equipment) that are allocated to a cost center for expense tracking and budgeting.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: WMS-to-ERP reconciliation: the distribution inbound_receipt (WMS physical receipt) must be matched to the procurement goods_receipt (ERP posting) for accounts payable three-way match and audit complia',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Goods receipt quality inspection process: when inbound_receipt triggers quality inspection (quality_inspection_required_flag=true), an inspection_lot is created. This FK links the receipt to its quali',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Internal transfer receipt: inbound receipts from own plants need the source manufacturing facility to track internal logistics and cost allocation.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Supplier nonconformance management: when received goods fail inspection, a nonconformance record is raised against the receipt. This FK enables supplier quality tracking, CAPA initiation from receipt ',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center facility where the goods were received.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Plant-to-DC finished goods transfer: when a production orders output is shipped to a distribution center, the inbound receipt at the DC must reference the originating production order for OTIF tracki',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Goods receipt postings in consumer goods must be attributed to a profit center for inventory valuation and COGS tracking by business segment. Procurement and supply chain teams report inbound receipt ',
    `purchase_order_id` BIGINT COMMENT '',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: Inbound receipts are the physical fulfillment of supply replenishment orders. Receiving teams reconcile receipts against replenishment orders for OTIF compliance, discrepancy management, and goods rec',
    `return_order_id` BIGINT COMMENT 'Foreign key linking to sales.return_order. Business justification: Reverse logistics / returns processing: when a retailer returns goods, a return_order is raised in sales and an inbound_receipt is created in distribution to physically receive returned stock. Linking',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor who shipped the goods, representing the counterparty in this receipt transaction.',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: Goods receipt disposition process: after inspection, a usage_decision (accept/reject/rework) determines whether received goods proceed to putaway or are returned to supplier. This FK links the receipt',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods accepted into inventory after quality inspection, excluding rejected or damaged items.',
    `actual_receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical goods arrived and were checked in at the receiving dock, representing the principal business event for this transaction.',
    `asn_number` STRING COMMENT 'Reference to the Advanced Shipping Notice document sent by the supplier prior to shipment arrival, enabling pre-receipt planning and dock scheduling.. Valid values are `^[A-Z0-9]{8,30}$`',
    `case_count` STRING COMMENT 'Number of cases or cartons received in this inbound shipment.',
    `container_number` STRING COMMENT 'ISO standard container identifier for ocean freight shipments, following the BIC (Bureau International des Containers) format.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt record was first created in the system, representing the audit trail start point.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicator of whether any discrepancies (quantity, quality, or documentation) were identified during the receiving process.',
    `discrepancy_notes` STRING COMMENT 'Free-text description providing additional details about any discrepancies identified during the receiving process.',
    `discrepancy_reason` STRING COMMENT 'Classification of the type of discrepancy identified during receiving, used for root cause analysis and supplier performance management.. Valid values are `overage|shortage|damage|wrong_product|quality_issue|documentation_error`',
    `dock_door_number` STRING COMMENT 'Physical dock door location where the inbound shipment was unloaded, used for labor planning and dock utilization tracking.. Valid values are `^[A-Z0-9]{1,10}$`',
    `expected_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods expected to be received based on the ASN or purchase order, used for discrepancy detection.',
    `inbound_receipt_status` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt record was last updated, supporting audit trail and data lineage requirements.',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `otif_compliant_flag` BOOLEAN COMMENT 'Indicator of whether this receipt met both on-time delivery and complete quantity requirements, key supplier performance metric.',
    `pallet_count` STRING COMMENT 'Number of pallets received in this inbound shipment, used for dock capacity planning and labor allocation.',
    `putaway_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all received goods were moved from the receiving dock to their designated storage locations, completing the inbound process.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicator of whether formal quality inspection was required for this receipt based on product category, supplier risk profile, or regulatory requirements.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for this receipt, tracking progression through quality control workflow.. Valid values are `not_required|pending|in_progress|passed|failed`',
    `receipt_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all receiving activities (unloading, inspection, put-away) were completed and the receipt was closed in the WMS.',
    `receipt_date` DATE COMMENT '',
    `receipt_number` STRING COMMENT 'Externally-known business identifier for the inbound receipt, used for tracking and reference across systems and with suppliers.. Valid values are `^[A-Z0-9]{8,20}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the inbound receipt transaction, tracking progression from scheduling through completion or exception handling.. Valid values are `scheduled|in_progress|completed|discrepancy|cancelled`',
    `receipt_type` STRING COMMENT 'Classification of the inbound receipt based on the source and nature of the goods being received.. Valid values are `supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual total quantity of goods physically received and counted during the receiving process.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods rejected during receiving due to quality issues, damage, or non-conformance to specifications.',
    `scheduled_receipt_date` DATE COMMENT 'Planned date for the inbound shipment to arrive at the distribution center, based on ASN or supplier commitment.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicator of whether the security seal was found intact upon arrival, critical for quality control and loss prevention.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the trailer or container, verified upon receipt to ensure shipment integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,20}$`',
    `source_system_code` STRING COMMENT '',
    `temperature_check_required_flag` BOOLEAN COMMENT 'Indicator of whether temperature verification was required for this receipt due to cold chain or temperature-sensitive product requirements.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicator of whether the recorded temperature was within acceptable range per product specifications and cold chain requirements.',
    `temperature_reading_celsius` DECIMAL(18,2) COMMENT 'Actual temperature reading in Celsius recorded during receipt inspection for temperature-sensitive products, critical for cold chain compliance.',
    `total_quantity` DECIMAL(18,2) COMMENT '',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or truck that delivered the shipment, used for tracking and carrier performance analysis.. Valid values are `^[A-Z0-9]{4,20}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantities recorded in this receipt (Each, Case, Pallet, Kilogram, Pound, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inbound_receipt PRIMARY KEY(`inbound_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of goods at a DC from suppliers, manufacturing plants, or inter-DC transfers. Records ASN reference, carrier, trailer/container ID, dock door, receipt date/time, received quantity by SKU/lot, temperature check results, and discrepancy flags. Integrates with SAP WM goods receipt and Blue Yonder WMS inbound processing. Drives inventory on-hand updates and FEFO/FIFO lot registration.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` (
    `inbound_receipt_line_id` BIGINT COMMENT 'Unique identifier for the inbound receipt line. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: GMP and FDA traceability require linking each received line item to its manufacturing batch record. Consumer goods DCs receiving finished goods from plants must validate batch/lot against the batch re',
    `inbound_receipt_id` BIGINT COMMENT 'Reference to the parent inbound receipt header transaction. Links this line to the overall receipt event.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Line-level goods receipt quality inspection: each receipt line (specific SKU/lot) may generate a distinct inspection_lot. This FK enables granular traceability from received line to quality result, su',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Three-way match (PO qty vs. received qty vs. invoice qty) is a core procurement control in consumer goods. Linking receipt lines to PO lines enables automated variance detection, OTIF measurement at l',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Each inbound receipt line is put away to a specific storage location within the DC. This FK captures the physical putaway destination at the line level, enabling FEFO/FIFO rotation tracking, cycle cou',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Link receipt line to SKU master for traceability and quality inspection; required by receipt processing and compliance audit reports.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who shipped the goods. Used for supplier performance tracking and procurement analytics.',
    `asn_line_number` STRING COMMENT 'Line number within the ASN document corresponding to this receipt line. Enables automated matching between ASN and physical receipt.',
    `asn_number` STRING COMMENT 'Advanced Shipping Notice document number sent by the supplier prior to shipment arrival. Used for pre-receipt planning and variance detection.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `condition_code` STRING COMMENT 'Quality condition assessment of the received goods. Determines whether product can be put away into available inventory or requires special handling.. Valid values are `good|damaged|expired|quarantine|rejected|hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was first created in the warehouse management system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost and extended cost. Supports multi-currency procurement operations.. Valid values are `^[A-Z]{3}$`',
    `damage_description` STRING COMMENT 'Free-text description of any damage, defects, or quality issues observed during receipt inspection. Used for claims and supplier performance tracking.',
    `expected_quantity_cases` DECIMAL(18,2) COMMENT 'Expected quantity in cases as specified in the Advanced Shipping Notice (ASN) or purchase order. Used for variance detection.',
    `expected_quantity_eaches` DECIMAL(18,2) COMMENT 'Expected quantity in eaches as specified in the Advanced Shipping Notice (ASN) or purchase order. Used for variance detection.',
    `expiration_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT 'Date when the product expires and can no longer be sold or used. Critical for FEFO rotation and inventory management in consumer goods.',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost for this receipt line calculated as unit cost multiplied by received quantity. Used for inventory valuation and financial reconciliation.',
    `gtin` STRING COMMENT 'Global Trade Item Number uniquely identifying the product in the supply chain. May be GTIN-8, GTIN-12, GTIN-13, or GTIN-14 format.. Valid values are `^[0-9]{8,14}$`',
    `inbound_receipt_line_status` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt line record was last updated. Audit trail for tracking changes to receipt data.',
    `line_number` STRING COMMENT 'Sequential line number within the inbound receipt. Used for ordering and referencing specific lines in the receipt document.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number assigned by the supplier. Critical for traceability, quality control, and recall management in consumer goods.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `manufacture_date` DATE COMMENT 'Date when the product was manufactured by the supplier. Used for shelf-life calculations and FEFO inventory rotation.',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet or handling unit containing this receipt line. Used for put-away and storage location assignment.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `put_away_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were put away into their assigned storage location. Used for warehouse productivity and cycle time measurement.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this receipt line requires quality inspection before being released to available inventory. True for regulated or high-risk products.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection for this receipt line. Determines whether goods can be released to available inventory or must remain in quarantine.. Valid values are `not_required|pending|in_progress|passed|failed|conditional`',
    `receipt_status` STRING COMMENT 'Current processing status of this receipt line within the warehouse workflow. Tracks progression from initial receipt through put-away completion.. Valid values are `pending|received|inspected|put_away|discrepancy|rejected`',
    `received_quantity` DECIMAL(18,2) COMMENT '',
    `received_quantity_cases` DECIMAL(18,2) COMMENT 'Quantity of product received measured in cases. Represents the outer packaging unit typically used for warehouse handling.',
    `received_quantity_eaches` DECIMAL(18,2) COMMENT 'Quantity of product received measured in individual units (eaches). Represents the consumer-facing unit count.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were physically received at the warehouse dock. Critical for OTIF performance measurement and cycle time analytics.',
    `sscc` STRING COMMENT '18-digit Serial Shipping Container Code identifying the logistics unit. Global standard for tracking pallets and containers in the supply chain.. Valid values are `^[0-9]{18}$`',
    `temperature_at_receipt_celsius` DECIMAL(18,2) COMMENT 'Temperature measurement in Celsius recorded at the time of receipt. Critical for cold chain compliance and product quality verification.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for the received goods as specified in the purchase order. Used for inventory valuation and COGS calculation.',
    `unit_of_measure` STRING COMMENT 'Primary unit of measure for the received quantity. Defines the counting and handling unit for warehouse operations.. Valid values are `case|each|pallet|layer|inner_pack|display_unit`',
    `uom` STRING COMMENT '',
    `upc` STRING COMMENT 'Universal Product Code barcode identifier for the received item. Standard 12-digit UPC-A format used in North American retail.. Valid values are `^[0-9]{12}$`',
    `variance_quantity_cases` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in cases. Positive values indicate overages, negative values indicate shortages.',
    `variance_quantity_eaches` DECIMAL(18,2) COMMENT 'Difference between expected and received quantity in eaches. Positive values indicate overages, negative values indicate shortages.',
    `warehouse_code` STRING COMMENT 'Code identifying the distribution center or warehouse facility where the receipt occurred. Used for multi-site inventory management.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_inbound_receipt_line PRIMARY KEY(`inbound_receipt_line_id`)
) COMMENT 'Line-level detail for each SKU/lot received within an inbound receipt transaction. Captures SKU code, GTIN, lot number, manufacture date, expiry date, received quantity (cases and eaches), unit of measure, pallet ID, temperature at receipt, and variance from expected ASN quantity. Supports FEFO/FIFO lot registration and discrepancy resolution workflows.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` (
    `outbound_order_id` BIGINT COMMENT 'Unique identifier for the outbound fulfillment order. Primary key for the outbound order entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Outbound orders are booked under a company code for revenue recognition and statutory reporting in multi-entity consumer goods organizations. Required for order-to-cash financial posting, intercompany',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outbound order fulfillment incurs warehouse labor and operational costs charged to a cost center for internal cost accounting. Consumer goods DC operations track order processing costs by cost center ',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order document in the ERP system. Links outbound fulfillment to revenue recognition and customer order management.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center fulfilling the outbound order. Determines inventory source and warehouse operations responsible for order execution.',
    `primary_outbound_sales_order_id` BIGINT COMMENT '',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for revenue recognition and profit‑center reporting; each outbound orders sales revenue is attributed to a profit center.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: DSD (Direct Store Delivery) and store-level OTIF tracking require linking outbound orders to the specific retail store being fulfilled. Enables store-level fill-rate reporting, DSD route planning, and',
    `trade_account_id` BIGINT COMMENT 'Identifier of the customer or retail account placing the outbound order. Links to trade account master for customer details, pricing agreements, and delivery preferences.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Trade promotion execution reporting in consumer goods requires linking outbound orders directly to the parent trade promotion for OTIF-by-promotion, fill-rate-by-promotion, and deduction management re',
    `actual_delivery_date` DATE COMMENT 'Date when the order was actually delivered to the customer destination. Used to calculate OTIF performance and delivery lead time.',
    `actual_ship_date` DATE COMMENT 'Date when the order was actually shipped from the distribution center. Used to measure warehouse execution performance against requested ship date.',
    `backorder_flag` BOOLEAN COMMENT 'Indicates whether any line items on the order are backordered due to insufficient inventory. True when ordered quantity exceeds available stock.',
    `bill_of_lading_number` STRING COMMENT 'Carrier-issued document number serving as receipt of goods and contract of carriage. Required for freight claims and proof of delivery.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the order was cancelled. Examples include customer request, inventory shortage, credit hold, or duplicate order. Used for root cause analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the order was cancelled. Null for active orders. Used for cancellation rate analysis and order lifecycle reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order record was first created in the system. Audit field for data lineage and order lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value. Typically USD for domestic US operations, but may vary for export orders.. Valid values are `^[A-Z]{3}$`',
    `fill_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity that was fulfilled from available inventory. Calculated as (shipped quantity / ordered quantity) * 100. Key metric for inventory availability and customer service.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the order contains hazardous materials requiring special handling, labeling, and transportation compliance. True for products regulated under DOT hazmat rules.',
    `incoterm` STRING COMMENT 'International Commercial Terms defining the division of costs and risks between buyer and seller. Critical for export orders and freight responsibility determination. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order record was last updated. Audit field for change tracking and data quality monitoring.',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `order_date` DATE COMMENT 'Date when the outbound order was created or received from the customer. Principal business event timestamp for order lifecycle tracking.',
    `order_status` STRING COMMENT 'Current lifecycle status of the outbound order. Draft indicates order creation, released means ready for fulfillment, picking/packing/staged represent warehouse execution phases, shipped indicates in-transit, delivered confirms receipt, cancelled indicates order termination. [ENUM-REF-CANDIDATE: draft|released|picking|packing|staged|shipped|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the outbound order based on fulfillment channel and destination. Retail replenishment serves store orders, DSD (Direct Store Delivery) bypasses DC, ecommerce serves online consumers, inter-DC transfer moves inventory between distribution centers, wholesale serves B2B customers, export serves international markets.. Valid values are `retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export`',
    `otif_commitment_flag` BOOLEAN COMMENT 'Indicates whether this order is subject to formal OTIF performance measurement and customer scorecard reporting. True for orders with contractual delivery commitments.',
    `outbound_order_status` STRING COMMENT '',
    `packing_slip_number` STRING COMMENT 'Document number for the packing slip accompanying the shipment. Used for customer receiving and invoice reconciliation.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the customer for this order. Examples include Net 30, Net 60, COD (Cash on Delivery), or prepaid. Impacts accounts receivable and cash flow management.',
    `pick_ticket_number` STRING COMMENT 'Warehouse document number used to direct picking operations for this order. Generated by WMS when order is released to the warehouse floor.',
    `priority_code` STRING COMMENT 'Priority level assigned to the outbound order for warehouse sequencing and resource allocation. Critical orders receive highest priority, rush orders are expedited, expedited orders have faster processing, standard orders follow normal flow.. Valid values are `standard|expedited|rush|critical`',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when delivery was confirmed by the recipient. Captured from carrier POD or customer signature. Used for OTIF measurement and freight audit.',
    `purchase_order_number` STRING COMMENT 'Customers purchase order number provided for order tracking and invoice reconciliation. Required for EDI (Electronic Data Interchange) transactions with retail customers.',
    `requested_ship_date` DATE COMMENT 'Date when the customer or system requests the order to be shipped from the distribution center. Used for warehouse planning and scheduling.',
    `required_delivery_date` DATE COMMENT 'Date by which the order must be delivered to the customer destination. Critical for OTIF (On Time In Full) performance measurement and SLA compliance.',
    `service_level` STRING COMMENT 'Delivery speed commitment for the outbound order. Determines carrier selection, freight cost, and OTIF measurement criteria.. Valid values are `standard|next_day|two_day|same_day|scheduled`',
    `shipping_method` STRING COMMENT 'Transportation mode used for order delivery. Ground for truck, air for expedited freight, ocean for international, rail for bulk, parcel for small packages, LTL (Less Than Truckload) for partial loads, FTL (Full Truckload) for full loads. [ENUM-REF-CANDIDATE: ground|air|ocean|rail|parcel|ltl|ftl — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT '',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for warehouse and logistics teams regarding special handling requirements. May include temperature control, fragile handling, hazmat procedures, or customer-specific delivery instructions.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the order requires temperature-controlled storage and transportation. True for cold chain products requiring refrigeration or freezing.',
    `total_order_quantity` DECIMAL(18,2) COMMENT 'Total quantity of units across all line items in the outbound order. Used for warehouse capacity planning and OTIF fill rate calculation.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the outbound order before taxes and freight charges. Used for order prioritization, credit limit checks, and revenue forecasting.',
    `total_order_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the outbound order in cubic meters. Used for warehouse space planning, truck cube utilization, and pallet configuration.',
    `total_order_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the outbound order in kilograms. Used for freight cost calculation, carrier capacity planning, and vehicle loading optimization.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and customer self-service tracking. Used for parcel and LTL shipments.',
    `wave_code` BIGINT COMMENT 'Identifier of the warehouse wave that includes this order. Wave picking groups orders for efficient batch picking and resource optimization.',
    CONSTRAINT pk_outbound_order PRIMARY KEY(`outbound_order_id`)
) COMMENT 'Master outbound fulfillment order record representing a customer or retailer replenishment request to be fulfilled from a DC. Captures order number, order type (retail replenishment, DSD, e-commerce, inter-DC transfer), customer/account reference, requested ship date, required delivery date, priority, OTIF commitment, and order status lifecycle. Sourced from SAP SD and Salesforce Consumer Goods Cloud order management.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` (
    `outbound_order_line_id` BIGINT COMMENT 'Unique identifier for the outbound order line item.',
    `atp_record_id` BIGINT COMMENT 'Foreign key linking to supply.atp_record. Business justification: ATP checks are performed at the order line level when confirming outbound order lines. Linking each outbound_order_line to the ATP record that confirmed availability enables fulfillment traceability a',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Batch-level shipment traceability: consumer goods companies must track which manufacturing batch was shipped on each order line for recall notification to customers, regulatory reporting, and FEFO com',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: Batch-level outbound traceability: each order line ships a specific batch that must have an approved batch_release. This FK enables lot traceability reporting, recall readiness (which customers receiv',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound fulfillment order header.',
    `sku_id` BIGINT COMMENT '',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Outbound order line items are stored in a DC location before picking. Adding a FK to distribution_storage_location enables location lookup and normalizes location data.',
    `actual_ship_date` DATE COMMENT 'Actual date the line was shipped from the distribution center.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity allocated from warehouse inventory to this order line.',
    `base_unit_quantity` DECIMAL(18,2) COMMENT 'Quantity converted to base unit of measure for standardized reporting and inventory tracking.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed available for fulfillment after ATP (Available to Promise) check.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound order line record was first created in the system.',
    `customer_po_line_number` STRING COMMENT 'Customers purchase order line number for cross-reference and reconciliation.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this line is part of a direct store delivery order bypassing retailer distribution centers.',
    `edi_line_reference` STRING COMMENT 'EDI transaction line reference number for electronic order processing and ASN generation.',
    `expiry_date` DATE COMMENT 'Product expiration date for FEFO inventory rotation and shelf-life management.',
    `gtin` STRING COMMENT 'Global trade item number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) for the product being shipped.. Valid values are `^[0-9]{8,14}$`',
    `handling_unit_code` STRING COMMENT 'Serial shipping container code (SSCC) or handling unit identifier for the container holding this line item.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this line contains hazardous materials requiring special handling and documentation.',
    `line_number` STRING COMMENT 'Sequential line number within the outbound order for ordering and identification.',
    `line_status` STRING COMMENT 'Current fulfillment status of the order line in the warehouse execution lifecycle. [ENUM-REF-CANDIDATE: open|allocated|picked|packed|shipped|cancelled|short_shipped — 7 candidates stripped; promote to reference product]',
    `line_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the shipped quantity for this line in cubic meters.',
    `line_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipped quantity for this line in kilograms.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for traceability and quality control.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU originally requested by the customer in the order.',
    `otif_status` STRING COMMENT 'Line-level OTIF performance status indicating whether the line was delivered on time and in full quantity.. Valid values are `on_time_in_full|late_in_full|on_time_partial|late_partial`',
    `outbound_order_line_status` STRING COMMENT '',
    `pack_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was packed into shipping containers.',
    `packed_quantity` DECIMAL(18,2) COMMENT 'Quantity packed into shipping containers and ready for dispatch.',
    `pallet_code` STRING COMMENT 'Pallet identifier if the line item was shipped on a palletized load.',
    `pick_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was picked from warehouse inventory.',
    `pick_zone` STRING COMMENT 'Warehouse pick zone designation for labor management and routing optimization.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'Quantity physically picked from warehouse storage locations during fulfillment.',
    `requested_ship_date` DATE COMMENT 'Customer-requested or system-calculated target ship date for this line.',
    `serial_numbers` STRING COMMENT 'Comma-separated list of serial numbers for serialized inventory items shipped on this line.',
    `ship_timestamp` TIMESTAMP COMMENT 'Date and time when the line item was shipped from the distribution center.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Quantity actually shipped to the customer, may differ from ordered due to short-ship scenarios.',
    `short_ship_flag` BOOLEAN COMMENT 'Indicates whether this line was short-shipped (shipped quantity less than ordered quantity).',
    `short_ship_reason_code` STRING COMMENT 'Reason code for short shipment (OOS=Out of Stock, DAMAGE=Damaged Inventory, RECALL=Product Recall, EXPIRED=Expired Product, ALLOCATION=Allocation Constraint).. Valid values are `OOS|DAMAGE|RECALL|EXPIRED|ALLOCATION`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this line requires temperature-controlled storage and transportation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities (EA=Each, CS=Case, PL=Pallet, BX=Box, KG=Kilogram, LB=Pound, LT=Liter, GL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|BX|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    `unit_volume_m3` DECIMAL(18,2) COMMENT 'Volume per unit of the SKU in cubic meters for space utilization and load planning.',
    `unit_weight_kg` DECIMAL(18,2) COMMENT 'Weight per unit of the SKU in kilograms for freight calculation and capacity planning.',
    `uom` STRING COMMENT '',
    `upc` STRING COMMENT 'Universal product code (UPC-A) for retail scanning and point-of-sale identification.. Valid values are `^[0-9]{12}$`',
    `warehouse_location_code` STRING COMMENT 'Distribution center or warehouse location code from which this line was fulfilled.',
    CONSTRAINT pk_outbound_order_line PRIMARY KEY(`outbound_order_line_id`)
) COMMENT 'Line-level detail for each SKU within an outbound fulfillment order. Records SKU code, GTIN, ordered quantity, confirmed quantity, allocated quantity, picked quantity, shipped quantity, unit of measure, lot number, expiry date, and line-level OTIF status. Enables order fill rate tracking, short-ship identification, and OSA impact analysis at the SKU-customer level.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` (
    `pick_task_id` BIGINT COMMENT 'Unique identifier for the pick task record. Primary key for the pick_task data product.',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pick task labor costs are charged to a cost center; required for labor cost analysis and OTIF performance metrics.',
    `storage_location_id` BIGINT COMMENT 'Reference to the target location where picked items are staged or packed (e.g., pack station, staging lane, loading dock).',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse where the pick task is executed.',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound order or shipment order that generated this pick task.',
    `outbound_order_line_id` BIGINT COMMENT '',
    `primary_pick_distribution_storage_location_id` BIGINT COMMENT 'Reference to the warehouse storage location (bin, shelf, pallet position) from which inventory is picked.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: Pick and pack tasks are the operational execution units that feed into outbound shipments. Many pick tasks are consolidated into a single distribution shipment (one shipment = many cartons/tasks). Thi',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU being picked or packed in this task.',
    `carton_code` STRING COMMENT 'Unique identifier for the carton or shipping container into which items are packed. May be a license plate number (LPN) or SSCC (Serial Shipping Container Code).. Valid values are `^CTN[0-9A-Z]{8,15}$`',
    `completed_timestamp` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task record was first created in the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dsd_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pick task is part of a Direct Store Delivery (DSD) execution workflow (true = DSD, false = standard distribution).',
    `exception_code` STRING COMMENT 'Code identifying any exception or issue encountered during task execution (e.g., short pick, damaged goods, location discrepancy). Null if no exception.. Valid values are `^[A-Z0-9]{2,6}$`',
    `exception_notes` STRING COMMENT 'Free-text notes entered by the operator or supervisor describing the exception or issue encountered during task execution.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the packed carton or pallet including product and packaging materials, measured in kilograms.',
    `gs1_128_label` STRING COMMENT 'The GS1-128 barcode label data applied to the carton or pallet, encoding SSCC, GTIN, lot, expiry, and other supply chain attributes.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the packed carton or pallet, measured in centimeters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task record was last updated in the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the packed carton or pallet, measured in centimeters.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product content only (excluding packaging), measured in kilograms.',
    `otif_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pick task is subject to OTIF (On Time In Full) performance measurement (true = OTIF tracked, false = not tracked).',
    `pack_station_code` BIGINT COMMENT 'Reference to the packing station where the packing operation is performed. Applicable when task_type includes packing.',
    `packaging_material_code` STRING COMMENT 'Code identifying the type of packaging material used (e.g., corrugated box, poly bag, shrink wrap). Used for cartonization and sustainability tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet onto which cartons or items are loaded. Typically an SSCC or internal LPN.. Valid values are `^PLT[0-9A-Z]{8,15}$`',
    `pick_accuracy_flag` BOOLEAN COMMENT 'Boolean indicator of whether the pick was accurate (true = picked quantity matches requested quantity and correct SKU/lot; false = discrepancy detected).',
    `pick_list_number` STRING COMMENT 'Human-readable pick list reference number assigned by the WMS for operator identification and tracking.. Valid values are `^PL[0-9]{8,12}$`',
    `pick_quantity` DECIMAL(18,2) COMMENT 'The quantity of SKU units to be picked for this task, measured in the SKUs base unit of measure.',
    `pick_task_status` STRING COMMENT '',
    `picked_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of SKU units picked by the operator. May differ from pick_quantity due to short picks or overages.',
    `picking_strategy` STRING COMMENT 'The picking methodology applied: discrete (single order), batch (multiple orders), zone (by warehouse zone), wave (grouped by wave), cluster (multi-order cart picking).. Valid values are `discrete|batch|zone|wave|cluster`',
    `priority_level` STRING COMMENT 'Priority classification of the pick task for sequencing and resource allocation: urgent (immediate), high (expedited), normal (standard), low (backlog).. Valid values are `urgent|high|normal|low`',
    `quantity` DECIMAL(18,2) COMMENT '',
    `sscc` STRING COMMENT '18-digit GS1 Serial Shipping Container Code uniquely identifying the logistics unit (carton or pallet) for tracking through the supply chain.. Valid values are `^[0-9]{18}$`',
    `task_assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was assigned to an operator by the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was completed and confirmed by the operator or WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from task start to completion. Used for labor productivity analysis and standard time calculation.',
    `task_number` STRING COMMENT '',
    `task_started_timestamp` TIMESTAMP COMMENT 'Timestamp when the operator began executing the pick task (scanned start or confirmed task initiation). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_status` STRING COMMENT 'Current lifecycle status of the pick task: pending (awaiting assignment), assigned (allocated to operator), in_progress (actively being executed), completed (finished successfully), cancelled (voided), on_hold (temporarily suspended).. Valid values are `pending|assigned|in_progress|completed|cancelled|on_hold`',
    `task_type` STRING COMMENT 'Discriminator indicating the type of fulfillment task: pick (picking only), pack (packing only), pick_and_pack (combined operation), or replenishment_pick (internal stock movement).. Valid values are `pick|pack|pick_and_pack|replenishment_pick`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for pick and picked quantities (e.g., EA for each, CS for case, PL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    `wave_code` BIGINT COMMENT 'Reference to the wave batch that groups multiple pick tasks for optimized execution. Supports wave picking strategy.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the packed carton or pallet, measured in centimeters.',
    CONSTRAINT pk_pick_task PRIMARY KEY(`pick_task_id`)
) COMMENT 'Fulfillment task record covering both picking and packing operations within DC outbound execution. For picking: captures pick list reference, source location, SKU, lot, pick quantity, assigned operator, wave/batch reference, pick accuracy flag, and task timestamps. For packing: captures pack station, carton/pallet ID, packed SKUs and quantities, packaging material, gross weight, dimensions, GS1-128/SSCC label, and packer operator. Supports wave picking, batch picking, zone picking, and cartonization strategies in Blue Yonder WMS. Task_type discriminator distinguishes pick vs pack execution steps.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the distribution shipment record. Primary key for the distribution shipment entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Recall management and GMP regulatory compliance require direct batch-to-shipment traceability. Consumer goods regulators (FDA, EU GMP) mandate knowing which shipments distributed a specific manufactur',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: GMP shipment compliance: finished goods shipments require confirmed batch release before dispatch. This FK links the shipment to its batch_release record, enabling pre-shipment quality gate checks, re',
    `certificate_of_analysis_id` BIGINT COMMENT 'Foreign key linking to quality.certificate_of_analysis. Business justification: CoA shipment documentation: consumer goods shipments (food, beverage, OTC, personal care) routinely require a Certificate of Analysis to accompany the delivery. This FK links the shipment to its CoA, ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Shipments in multi-entity consumer goods companies are posted under a company code for revenue recognition (goods issue) and intercompany billing. Required for statutory financial reporting and cross-',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for shipment cost allocation report; logistics expenses are charged to a cost center, a standard practice in consumer‑goods distribution.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Shipment origin tracking: linking shipments to the originating manufacturing facility enables performance dashboards and OTIF analysis.',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to supply.network_lane. Business justification: Each distribution shipment travels a defined supply network lane. Linking shipments to network lanes enables lane performance analytics — actual vs. planned transit time, freight cost per lane, OTIF b',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order. Business justification: Shipment is a child of an outbound order; each shipment fulfills an order. Adding outbound_order_id to distribution_shipment creates the necessary parent link without creating a bidirectional relation',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Freight cost and OTIF performance reporting in consumer goods requires shipment costs attributed to a profit center for channel/regional P&L. Distribution logistics costs must roll up to profit center',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: OTIF reporting requires tying each shipment to its originating purchase order to measure delivery performance against contractual commitments.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: Distribution shipments execute supply replenishment orders. Supply planners track in-transit shipment status against open replenishment orders for ATP updates and in-transit inventory visibility — a c',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Shipment proof-of-delivery, store-level service metrics, and retail compliance reporting require linking each shipment to the destination retail store. Consumer goods logistics teams track on-time del',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment was delivered and received at the destination. Used for final OTIF calculation.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment departed the DC. Critical for OTIF calculation and carrier performance tracking.',
    `bill_of_lading_number` STRING COMMENT 'Unique identifier of the bill of lading document issued by the carrier. Legal document for freight movement and proof of shipment.',
    `carrier_service_level` STRING COMMENT 'Service tier selected for this shipment defining speed and handling requirements.. Valid values are `ground|express|overnight|two_day|economy|premium`',
    `carton_count` STRING COMMENT 'Total number of cartons or cases included in the shipment. Used for piece-level tracking and receiving verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was first created in the WMS. Audit trail for shipment lifecycle tracking.',
    `destination_address_line1` STRING COMMENT 'Primary street address line of the shipment destination. Organizational contact data classified as confidential.',
    `destination_city` STRING COMMENT 'City name of the shipment destination address.',
    `destination_code` STRING COMMENT 'Business identifier of the destination location (store number, DC code, customer account number) where goods are being delivered.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the shipment destination for customs and routing purposes.. Valid values are `^[A-Z]{3}$`',
    `destination_name` STRING COMMENT 'Human-readable name of the destination location for display and confirmation purposes.',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the shipment destination. Organizational contact data classified as confidential.',
    `destination_state_province` STRING COMMENT 'State or province code of the shipment destination address.',
    `destination_type` STRING COMMENT 'Classification of the shipment destination entity type for routing and handling purposes.. Valid values are `retail_store|distribution_center|customer|warehouse|third_party`',
    `distribution_shipment_status` STRING COMMENT '',
    `dock_door_number` STRING COMMENT 'Identifier of the loading dock door at the source DC where the shipment was staged and loaded.',
    `estimated_delivery_timestamp` TIMESTAMP COMMENT 'Current estimated delivery date and time based on real-time tracking and carrier updates. Updated dynamically during transit.',
    `freight_charge_amount` DECIMAL(18,2) COMMENT 'Total freight cost charged for this shipment in the transaction currency. Used for logistics cost analysis and freight audit.',
    `freight_currency_code` STRING COMMENT 'Three-letter ISO currency code for the freight charge amount.. Valid values are `^[A-Z]{3}$`',
    `freight_terms` STRING COMMENT 'Terms defining which party is responsible for freight payment and at what point ownership transfers. Critical for cost allocation.. Valid values are `prepaid|collect|third_party|fob_origin|fob_destination`',
    `goods_issue_document_number` STRING COMMENT 'SAP SD goods issue document number linking the physical shipment to the ERP inventory transaction. Critical for inventory accuracy.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator of whether this shipment contains hazardous materials requiring special handling and documentation per DOT regulations.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment was delivered complete with all ordered quantities. Component of OTIF calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was last updated. Audit trail for change tracking and data freshness verification.',
    `line_item_count` STRING COMMENT 'Total number of distinct SKU line items included in the shipment. Used for picking complexity and receiving planning.',
    `load_number` STRING COMMENT 'Identifier of the load plan that consolidated multiple orders or shipments into this trailer. Used for load optimization tracking.',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment was delivered within the committed delivery window. Component of OTIF calculation.',
    `otif_status` STRING COMMENT 'Calculated OTIF performance status indicating whether the shipment was delivered on time and complete per customer commitment. Key supply chain KPI.. Valid values are `on_time_in_full|late|incomplete|damaged|not_applicable`',
    `pallet_count` STRING COMMENT 'Total number of pallets included in the shipment. Used for handling unit tracking and dock labor planning.',
    `pro_number` STRING COMMENT 'Carrier-assigned progressive number used for tracking and tracing the shipment in the carriers system.',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for the shipment to arrive at the destination. Used for customer commitment and OTIF measurement.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for the shipment to arrive at the destination. Precision timestamp for delivery window commitments.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time for the shipment to depart from the DC dock. Precision timestamp for appointment scheduling and carrier coordination.',
    `scheduled_ship_date` DATE COMMENT 'Planned date for the shipment to depart from the distribution center. Used for OTIF performance measurement baseline.',
    `seal_number` STRING COMMENT 'Unique identifier of the security seal applied to the trailer or container to ensure shipment integrity and prevent tampering.',
    `ship_date` DATE COMMENT '',
    `shipment_number` STRING COMMENT 'Externally-known unique business identifier for the shipment assigned by the WMS. Used for tracking and reference across systems and with carriers.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment in the outbound fulfillment workflow. Tracks progression from planning through final delivery. [ENUM-REF-CANDIDATE: planned|staged|loading|loaded|departed|in_transit|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on delivery method and business purpose. DSD indicates Direct Store Delivery channel.. Valid values are `standard|expedited|dsd|cross_dock|transfer|return`',
    `source_system_code` STRING COMMENT '',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this shipment requires temperature-controlled transportation for product integrity.',
    `total_units` STRING COMMENT 'Total quantity of individual sellable units (eaches) included in the shipment across all SKUs.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total cube or volume of the shipment in cubic meters. Critical for trailer utilization and dimensional weight calculations.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms including product and packaging. Used for freight rating and load planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for real-time shipment visibility and customer self-service tracking.',
    `trailer_number` STRING COMMENT 'Identifier of the trailer or container unit used to transport the shipment. Critical for load tracking and yard management.',
    `wave_number` STRING COMMENT 'Identifier of the warehouse picking wave that generated the orders included in this shipment. Links shipment to WMS wave planning.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Outbound shipment dispatched from a distribution center to a customer/store. SSOT for DC-originated shipment records. Distinct from logistics.logistics_shipment which tracks carrier-level transport execution.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` (
    `inventory_position_id` BIGINT COMMENT 'Primary key for inventory_position',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Batch-level inventory management: consumer goods companies track on-hand inventory by manufacturing batch for FEFO rotation, shelf-life expiry management, and recall isolation. Linking inventory_posit',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: Released inventory confirmation: in GMP consumer goods (OTC, supplements, cosmetics), inventory_position must reference its batch_release record to confirm the stock is quality-released and available ',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory carrying costs (storage, handling, cycle count labor) are allocated to cost centers in consumer goods management accounting. Linking inventory position to cost center enables inventory cost ',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center where the inventory is physically located.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inventory quarantine management: inventory_position tracks quantity_quarantine and quantity_hold. Linking to the active inspection_lot identifies WHY inventory is held, enabling warehouse teams to man',
    `inventory_policy_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_policy. Business justification: Inventory policy governs reorder points, min/max levels, and replenishment methods for each SKU at a node. Linking inventory_position to inventory_policy enables automated replenishment triggering and',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Consumer goods companies allocate inventory value to profit centers for segment/brand P&L and working capital reporting. Inventory position by profit center is required for balance sheet inventory seg',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: Inventory position must be compared against the safety stock target for each SKU/node to trigger replenishment alerts and measure stockout risk. This link enables real-time safety stock compliance mon',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU for which inventory position is tracked.',
    `standard_cost_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Inventory valuation in consumer goods uses standard costs. Linking inventory_position to standard_cost enables real-time inventory value calculation (on_hand_quantity × standard cost) for balance shee',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Inventory position records on‑hand quantities at a specific DC location. Linking to distribution_storage_location provides the authoritative location details and removes the generic storage_location_i',
    `actual_weight` DECIMAL(18,2) COMMENT 'The actual measured weight of the inventory for catch weight items. Used for billing and compliance when item weight varies.',
    `allocated_quantity` DECIMAL(18,2) COMMENT '',
    `as_of_date` DATE COMMENT '',
    `available_quantity` DECIMAL(18,2) COMMENT '',
    `catch_weight_flag` BOOLEAN COMMENT 'Indicates whether the SKU is a catch weight item requiring actual weight capture at transaction time (true) or standard weight (false).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The unit cost of the inventory lot. Used for inventory valuation and cost of goods sold calculations. Business confidential financial data.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for inventory valuation (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `days_on_hand` STRING COMMENT 'The number of days the inventory has been on hand since receipt. Calculated as current date minus receipt date. Used for aging analysis.',
    `days_to_expiry` STRING COMMENT 'The number of days remaining until the inventory lot expires. Calculated as expiry date minus current date. Critical for FEFO rotation and markdown decisions.',
    `expiry_date` DATE COMMENT 'The date on which the product lot expires and can no longer be sold or distributed. Critical for FEFO inventory management and regulatory compliance.',
    `inventory_condition` STRING COMMENT 'The physical condition classification of the inventory. Used for disposition decisions and channel restrictions.. Valid values are `new|refurbished|returned|damaged|expired|recalled`',
    `inventory_status` STRING COMMENT 'The current operational status of the inventory position. Determines availability for picking and order fulfillment.. Valid values are `available|allocated|quarantine|hold|damaged|expired`',
    `last_cycle_count_date` DATE COMMENT 'The date when this inventory position was last physically counted during a cycle count operation. Used to schedule next count and assess inventory accuracy.',
    `last_movement_date` DATE COMMENT 'The date when inventory was last moved into or out of this storage location. Used for slow-moving inventory identification.',
    `last_movement_type` STRING COMMENT 'The type of the last inventory movement transaction that affected this position (receipt, putaway, pick, replenishment, transfer, adjustment, return). [ENUM-REF-CANDIDATE: receipt|putaway|pick|replenishment|transfer|adjustment|return — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position record was last modified. Used for change tracking and data freshness assessment.',
    `license_plate_number` STRING COMMENT 'The warehouse management system license plate number assigned to the handling unit. Used for tracking and automated material handling.',
    `lot_number` STRING COMMENT 'The alphanumeric lot or batch number assigned during manufacturing. Used for traceability and recall management.',
    `manufacture_date` DATE COMMENT 'The date on which the product lot was manufactured. Used for shelf-life calculations and FEFO rotation.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT '',
    `owner_type` STRING COMMENT 'Indicates the ownership model of the inventory (owned by company, consignment from supplier, customer-owned for returns, vendor-managed inventory).. Valid values are `owned|consignment|customer_owned|vendor_managed`',
    `pallet_code` STRING COMMENT 'The unique identifier of the pallet or handling unit on which the inventory is stored. Used for warehouse automation and tracking.',
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether this inventory position is in a primary pick face location (true) or reserve storage (false). Pick face locations are optimized for order picking efficiency.',
    `putaway_date` DATE COMMENT 'The date when the inventory was put away into this storage location after receiving. Used for aging analysis and FEFO compliance.',
    `quantity_allocated` DECIMAL(18,2) COMMENT 'The quantity of on-hand inventory that has been allocated to outbound orders or reservations but not yet picked. Reduces available-to-pick quantity.',
    `quantity_available` DECIMAL(18,2) COMMENT 'The quantity available for new order allocation and picking. Calculated as quantity_on_hand minus quantity_allocated minus quantity_quarantine minus quantity_hold.',
    `quantity_damaged` DECIMAL(18,2) COMMENT 'The quantity of inventory identified as damaged and not suitable for sale or distribution. Typically awaiting disposal or return to supplier.',
    `quantity_hold` DECIMAL(18,2) COMMENT 'The quantity of inventory placed on hold due to quality issues, customer complaints, or pending investigation. Not available for picking.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The total physical quantity of the SKU-lot currently present in the storage location. Measured in the SKUs base unit of measure.',
    `quantity_quarantine` DECIMAL(18,2) COMMENT 'The quantity of inventory placed in quarantine status pending quality inspection or regulatory clearance. Not available for picking.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'The quantity of inventory reserved for specific customers, channels, or promotional programs. Subset of allocated quantity with additional business constraints.',
    `receipt_date` DATE COMMENT 'The date when the inventory lot was received into the distribution center. Used for inventory aging and supplier performance tracking.',
    `replenishment_flag` BOOLEAN COMMENT 'Indicates whether this inventory position requires replenishment from reserve to pick face (true) or not (false). Triggers automated replenishment tasks.',
    `reserved_quantity` DECIMAL(18,2) COMMENT '',
    `snapshot_date` DATE COMMENT '',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position snapshot was captured. Used for point-in-time inventory reporting and trend analysis.',
    `storage_zone` STRING COMMENT 'The logical zone within the distribution center where the inventory is stored (e.g., ambient, refrigerated, frozen, hazmat, high-velocity, reserve).',
    `temperature_zone` STRING COMMENT 'The temperature control zone classification for the storage location. Critical for cold chain compliance and product quality.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'The total financial value of the inventory position calculated as quantity_on_hand multiplied by cost_per_unit. Used for balance sheet reporting. Business confidential financial data.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure in which inventory quantities are tracked (Each, Case, Pallet, Pound, Kilogram, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    `uom` STRING COMMENT '',
    `weight_unit_of_measure` STRING COMMENT 'The unit of measure for actual weight (Pound, Kilogram, Ounce, Gram). Applicable for catch weight items.. Valid values are `LB|KG|OZ|G`',
    CONSTRAINT pk_inventory_position PRIMARY KEY(`inventory_position_id`)
) COMMENT 'Current on-hand inventory position at the DC-location-SKU-lot level within distribution center walls. Captures storage location, SKU, lot number, manufacture and expiry dates, quantity on hand, allocated quantity, available-to-pick (ATP) quantity, quarantine quantity, inventory status (available, hold, damaged, expired), and last cycle count date. This is the operational working inventory view for DC execution — distinct from the inventory domains network-wide planning position which aggregates across all nodes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ADD CONSTRAINT `fk_distribution_storage_location_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ADD CONSTRAINT `fk_distribution_inbound_receipt_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ADD CONSTRAINT `fk_distribution_outbound_order_line_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_line_id` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line`(`outbound_order_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_primary_pick_distribution_storage_location_id` FOREIGN KEY (`primary_pick_distribution_storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`shipment`(`shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ADD CONSTRAINT `fk_distribution_shipment_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `vibe_consumer_goods_v1`.`distribution`.`storage_location`(`storage_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `network_node_id` SET TAGS ('dbx_ssot_owner' = 'distribution');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dc_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_inbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors (Inbound)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_outbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors (Outbound)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `dsd_hub_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Hub Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|multi_temperature|dsd_hub|cross_dock');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `fsc_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `inventory_rotation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `inventory_rotation_method` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekday)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekend)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|maintenance');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `osa_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_logistics');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_business_glossary_term' = 'SAP Storage Location');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `shifts_per_day` SET TAGS ('dbx_business_glossary_term' = 'Shifts Per Day');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Pallet Positions)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Square Feet)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `wms_site_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Site Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`distribution_facility` ALTER COLUMN `wms_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Velocity Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_business_glossary_term' = 'Bin Position Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Rack Level Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Location Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_business_glossary_term' = 'Material Handling Equipment Type Required');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_value_regex' = 'forklift|reach_truck|order_picker|pallet_jack|manual|automated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Location Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `fefo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `fifo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Height (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Length (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|quarantine|damaged');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|pick|reserve|staging|dock|cross_dock');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `mixed_lot_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Lot/Batch Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `mixed_sku_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'batch|wave|zone|discrete|cluster');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_value_regex' = 'directed|random|fixed|dynamic');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `replenishment_priority` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `volume_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Width (Centimeters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `return_order_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `actual_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|wrong_product|quality_issue|documentation_error');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `putaway_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|discrepancy|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `scheduled_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Check Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_reading_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (Celsius)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` SET TAGS ('dbx_subdomain' = 'inbound_receiving');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_line_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Putaway Distribution Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_line_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'good|damaged|expired|quarantine|rejected|hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expected_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expected_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `put_away_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Put Away Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|conditional');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'pending|received|inspected|put_away|discrepancy|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `temperature_at_receipt_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt Celsius');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'case|each|pallet|layer|inner_pack|display_unit');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_cases` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Cases');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `variance_quantity_eaches` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity Eaches');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inbound_receipt_line` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `otif_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Commitment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `pick_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Pick Ticket Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|next_day|two_day|same_day|scheduled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Order Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `total_order_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Order Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `atp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `base_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `customer_po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `edi_line_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Line Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `handling_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Line Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `line_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Line Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late_in_full|on_time_partial|late_partial');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `pick_zone` SET TAGS ('dbx_business_glossary_term' = 'Pick Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Serial Numbers');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_flag` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Short Ship Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `short_ship_reason_code` SET TAGS ('dbx_value_regex' = 'OOS|DAMAGE|RECALL|EXPIRED|ALLOCATION');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Unit Volume (Cubic Meters)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `unit_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Unit Weight (Kilograms)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`outbound_order_line` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `primary_pick_distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Distribution Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_value_regex' = '^CTN[0-9A-Z]{8,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `gs1_128_label` SET TAGS ('dbx_business_glossary_term' = 'GS1-128 Label Data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `otif_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^PLT[0-9A-Z]{8,15}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_accuracy_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Accuracy Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_business_glossary_term' = 'Pick List Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_value_regex' = '^PL[0-9]{8,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `pick_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pick Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'discrete|batch|zone|wave|cluster');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration in Seconds');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Started Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'pick|pack|pick_and_pack|replenishment_pick');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`pick_task` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (CM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` SET TAGS ('dbx_subdomain' = 'outbound_fulfillment');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `certificate_of_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Analysis Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'ground|express|overnight|two_day|economy|premium');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Name');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'retail_store|distribution_center|customer|warehouse|third_party');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|fob_origin|fob_destination');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `goods_issue_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `load_number` SET TAGS ('dbx_business_glossary_term' = 'Load Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|incomplete|damaged|not_applicable');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|dsd|cross_dock|transfer|return');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`shipment` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Dc Location Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `actual_weight` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `catch_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `days_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Days On Hand (DOH)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_business_glossary_term' = 'Inventory Condition');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_value_regex' = 'new|refurbished|returned|damaged|expired|recalled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|allocated|quarantine|hold|damaged|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `license_plate_number` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number (LPN)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'owned|consignment|customer_owned|vendor_managed');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `putaway_date` SET TAGS ('dbx_business_glossary_term' = 'Putaway Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'Quantity Allocated');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available (ATP - Available to Promise)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_damaged` SET TAGS ('dbx_business_glossary_term' = 'Quantity Damaged');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_hold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Hold');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand (QOH)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_quarantine` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quarantine');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = 'LB|KG|OZ|G');
