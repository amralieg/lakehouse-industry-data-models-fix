-- Schema for Domain: distribution | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`distribution` COMMENT 'Owns warehouse operations, inventory management, and order fulfillment across distribution centers. Manages inbound/outbound logistics within DCs, put-away/picking/packing processes, cycle counting, FEFO/FIFO inventory rotation, WMS integration (Blue Yonder), OTIF performance, OSA metrics, and DSD execution for direct store delivery channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` (
    `distribution_facility_id` BIGINT COMMENT 'Primary key for facility',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each distribution facility operates under a specific legal entity (company code) for statutory reporting, tax compliance, and intercompany stock transfer accounting. Consumer goods multinationals requ',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Distribution facilities are subject to jurisdiction-specific regulatory compliance obligations (GMP certification, hazmat storage regulations, temperature-controlled storage mandates). This link enabl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Distribution facilities are assigned a primary cost center for DC overhead budgeting, labor cost allocation, and utility expense tracking. This facility-level cost center assignment is standard in con',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution centers are assigned to profit centers for DC-level P&L reporting, freight cost allocation, and brand/channel profitability analysis. Consumer goods companies routinely map each DC to a p',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Distribution facilities require their own regulatory registrations (FDA food facility registration, EPA hazmat handler registration, country-specific import/export licenses). Regulatory affairs teams ',
    `address_line_1` STRING COMMENT 'Primary street address line for the distribution center facility. Organizational contact data classified as confidential business information.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information. Organizational contact data classified as confidential business information.',
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
    `dock_doors_inbound` STRING COMMENT 'Number of dock doors designated for inbound receiving operations. Impacts receiving throughput capacity and scheduling.',
    `dock_doors_outbound` STRING COMMENT 'Number of dock doors designated for outbound shipping operations. Impacts shipping throughput capacity and carrier scheduling.',
    `dsd_hub_flag` BOOLEAN COMMENT 'Indicates whether this facility serves as a DSD hub for direct-to-retail delivery operations. DSD hubs bypass traditional distribution channels for faster store replenishment.',
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
    `sap_plant_code` STRING COMMENT 'SAP S/4HANA plant code representing this distribution center in the ERP system. Maps to the SAP MM and WM modules for material management and warehouse management.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_storage_location` STRING COMMENT 'SAP S/4HANA storage location code within the plant. Represents the primary storage location identifier for inventory transactions in SAP WM module.. Valid values are `^[A-Z0-9]{4}$`',
    `shifts_per_day` STRING COMMENT 'Number of operational shifts per day at the facility. Used for labor planning, throughput capacity modeling, and operational cost analysis.',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the facility is located. Organizational contact data classified as confidential business information.',
    `storage_capacity_pallet_positions` STRING COMMENT 'Maximum number of pallet positions available for storage. Key metric for inventory capacity planning and space utilization analysis.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the facility has temperature-controlled storage zones. True for facilities with chilled or frozen capabilities, false for ambient-only.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the distribution center location. Used for scheduling, shift planning, and cross-facility coordination.',
    `total_capacity_sqft` DECIMAL(18,2) COMMENT 'Total warehouse floor space capacity in square feet. Includes all storage, staging, and operational areas within the facility.',
    `wms_site_code` STRING COMMENT 'Unique site identifier in the Blue Yonder WMS system. Used for integration and synchronization between the lakehouse and the operational WMS platform.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    CONSTRAINT pk_distribution_facility PRIMARY KEY(`distribution_facility_id`)
) COMMENT 'Master record for each physical distribution center (DC) or warehouse facility in the CPG network. Captures DC identity, location, type (ambient, chilled, frozen, DSD hub), capacity metrics, WMS integration identifiers (Blue Yonder site codes), SAP plant/storage location mappings, operating hours, and operational status. SSOT for DC facility master data across the distribution domain.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` (
    `distribution_storage_location_id` BIGINT COMMENT 'Primary key for storage_location',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Storage locations for hazmat, temperature-controlled, or controlled substances must comply with specific regulatory obligations (EPA hazmat storage, FDA cold chain, DEA vault requirements). This link ',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the parent distribution center facility where this storage location resides.',
    `abc_classification` STRING COMMENT 'Velocity-based classification of the location for slotting optimization: A (high-velocity/fast-moving), B (medium-velocity), C (low-velocity/slow-moving).. Valid values are `A|B|C`',
    `aisle` STRING COMMENT 'Aisle designation within the warehouse layout for physical navigation and picking route optimization.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bay` STRING COMMENT 'Bay or column position within the aisle for precise horizontal location reference.. Valid values are `^[A-Z0-9]{1,5}$`',
    `bin_position` STRING COMMENT 'Specific bin or slot position within the level for granular inventory placement and retrieval.. Valid values are `^[A-Z0-9]{1,5}$`',
    `blocked_date` DATE COMMENT 'Date when the storage location was blocked or made unavailable for operations.',
    `blocked_reason` STRING COMMENT 'Explanation for why the location is blocked or unavailable, such as maintenance, damage, safety hold, or quality quarantine.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the storage location record was first created in the WMS system.',
    `cycle_count_frequency` STRING COMMENT 'Scheduled frequency for cycle counting inventory at this location to maintain inventory accuracy and compliance.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `distribution_storage_location_level` STRING COMMENT 'Vertical level or shelf position within the bay for height-based slotting and equipment compatibility.. Valid values are `^[A-Z0-9]{1,3}$`',
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
    `pick_face_flag` BOOLEAN COMMENT 'Indicates whether this location is designated as an active pick face for order fulfillment operations.',
    `picking_strategy` STRING COMMENT 'Order fulfillment picking method supported by this location: batch picking, wave picking, zone picking, discrete (single-order), or cluster picking.. Valid values are `batch|wave|zone|discrete|cluster`',
    `putaway_strategy` STRING COMMENT 'Algorithm used to assign incoming inventory to this location: directed (system-assigned), random, fixed (dedicated SKU), or dynamic (velocity-based).. Valid values are `directed|random|fixed|dynamic`',
    `replenishment_priority` STRING COMMENT 'Priority ranking for automated replenishment from reserve to pick locations, with lower numbers indicating higher priority.',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the storage location to ensure product integrity and regulatory compliance (ambient, refrigerated 2-8°C, frozen <-18°C, controlled room temperature).. Valid values are `ambient|refrigerated|frozen|controlled`',
    `volume_capacity_m3` DECIMAL(18,2) COMMENT 'Maximum volume capacity of the storage location in cubic meters for space utilization and slotting algorithms.',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms for safe load management and slotting optimization.',
    `width_cm` DECIMAL(18,2) COMMENT 'Physical width dimension of the storage location in centimeters for dimensional slotting and equipment compatibility.',
    `zone_code` STRING COMMENT 'Logical zone classification within the distribution center for grouping locations by product category, velocity, or operational workflow (e.g., FAST-PICK, SLOW-MOVE, HAZMAT).. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_distribution_storage_location PRIMARY KEY(`distribution_storage_location_id`)
) COMMENT 'Granular storage location master within a distribution center — aisles, bays, levels, bin positions, and pick faces as defined in Blue Yonder WMS. Tracks location type (bulk, pick, reserve, staging, dock), zone classification, temperature zone, weight/volume capacity, and FEFO/FIFO eligibility flags. Enables put-away and picking optimization at the slot level.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` (
    `inbound_receipt_id` BIGINT COMMENT 'Unique identifier for the inbound receipt transaction. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: GMP traceability and recall management require DC inbound receipts to reference the manufacturing batch record. In consumer goods (health/hygiene), regulators and quality teams must trace received inv',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Inbound freight contract compliance: consumer goods supplier routing guides specify which carrier contracts govern inbound shipments. Linking inbound_receipt to carrier_contract enables inbound freigh',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier that delivered the shipment to the distribution center.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Inbound receipts of regulated products must satisfy import compliance obligations (import notification, certificate of conformity, phytosanitary requirements). This link enables compliance verificatio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receiving operations incur expenses (labor, equipment) that are allocated to a cost center for expense tracking and budgeting.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Inbound freight audit: the freight order governs the inbound movement from supplier or manufacturing facility. Linking enables matching of billed freight charges to received goods, discrepancy resolut',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: WMS inbound_receipt and ERP goods_receipt represent the same physical event in dual-system Consumer Goods operations (e.g., SAP + WMS). Linking them enables 3-way match completion, audit trail reconci',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: End-to-end shipment-to-receipt reconciliation: consumer goods DCs match the logistics shipment record (with temperature logs, seal numbers, transit events) to the inbound receipt for cold chain compli',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Receipt-level lot traceability: inbound receipts capture the lot/batch of received goods for FEFO, FIFO, and recall compliance. Consumer goods GS1 traceability standards require linking each receipt t',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Internal transfer receipt: inbound receipts from own plants need the source manufacturing facility to track internal logistics and cost allocation.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: In Consumer Goods WMS/ERP integration, receipts are reconciled at PO line level for per-SKU quantity variance, over/under delivery tolerance checks, and line-level invoice matching. A domain expert wo',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Inbound receipts of recalled products must be flagged and quarantined before entering inventory. This link enables warehouse teams to identify and hold incoming recalled goods at the dock — a core GMP',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: 3-way match (PO/GR/invoice) is a core Consumer Goods procurement control. Linking inbound_receipt to purchase_order enables automated quantity reconciliation, OTIF measurement against PO commitments, ',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Inbound receipts of regulated products (OTC drugs, cosmetics, biocides) must reference the regulatory registration authorizing import/distribution in that jurisdiction. Customs clearance and GMP goods',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Goods receipt process: inbound receipt at a distribution facility triggers an ERP goods receipt stock_movement posting. Consumer goods operations require this link for receipt-to-inventory reconciliat',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Consumer Goods procurement requires contract compliance monitoring — receipts must be validated against contracted quantities, pricing, and delivery terms. Linking inbound_receipt to supplier_contract',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor who shipped the goods, representing the counterparty in this receipt transaction.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the specific warehouse or storage facility within the distribution center where goods were received.',
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
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this receipt record was last updated, supporting audit trail and data lineage requirements.',
    `otif_compliant_flag` BOOLEAN COMMENT 'Indicator of whether this receipt met both on-time delivery and complete quantity requirements, key supplier performance metric.',
    `pallet_count` STRING COMMENT 'Number of pallets received in this inbound shipment, used for dock capacity planning and labor allocation.',
    `putaway_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all received goods were moved from the receiving dock to their designated storage locations, completing the inbound process.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicator of whether formal quality inspection was required for this receipt based on product category, supplier risk profile, or regulatory requirements.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for this receipt, tracking progression through quality control workflow.. Valid values are `not_required|pending|in_progress|passed|failed`',
    `receipt_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all receiving activities (unloading, inspection, put-away) were completed and the receipt was closed in the WMS.',
    `receipt_number` STRING COMMENT 'Externally-known business identifier for the inbound receipt, used for tracking and reference across systems and with suppliers.. Valid values are `^[A-Z0-9]{8,20}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the inbound receipt transaction, tracking progression from scheduling through completion or exception handling.. Valid values are `scheduled|in_progress|completed|discrepancy|cancelled`',
    `receipt_type` STRING COMMENT 'Classification of the inbound receipt based on the source and nature of the goods being received.. Valid values are `supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual total quantity of goods physically received and counted during the receiving process.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods rejected during receiving due to quality issues, damage, or non-conformance to specifications.',
    `scheduled_receipt_date` DATE COMMENT 'Planned date for the inbound shipment to arrive at the distribution center, based on ASN or supplier commitment.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicator of whether the security seal was found intact upon arrival, critical for quality control and loss prevention.',
    `seal_number` STRING COMMENT 'Security seal identifier applied to the trailer or container, verified upon receipt to ensure shipment integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,20}$`',
    `temperature_check_required_flag` BOOLEAN COMMENT 'Indicator of whether temperature verification was required for this receipt due to cold chain or temperature-sensitive product requirements.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Indicator of whether the recorded temperature was within acceptable range per product specifications and cold chain requirements.',
    `temperature_reading_celsius` DECIMAL(18,2) COMMENT 'Actual temperature reading in Celsius recorded during receipt inspection for temperature-sensitive products, critical for cold chain compliance.',
    `trailer_number` STRING COMMENT 'Unique identifier of the trailer or truck that delivered the shipment, used for tracking and carrier performance analysis.. Valid values are `^[A-Z0-9]{4,20}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the quantities recorded in this receipt (Each, Case, Pallet, Kilogram, Pound, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|LT|GL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inbound_receipt PRIMARY KEY(`inbound_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of goods at a DC from suppliers, manufacturing plants, or inter-DC transfers. Records ASN reference, carrier, trailer/container ID, dock door, receipt date/time, received quantity by SKU/lot, temperature check results, and discrepancy flags. Integrates with SAP WM goods receipt and Blue Yonder WMS inbound processing. Drives inventory on-hand updates and FEFO/FIFO lot registration.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` (
    `outbound_order_id` BIGINT COMMENT 'Unique identifier for the outbound fulfillment order. Primary key for the outbound order entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotional campaign fulfillment requires outbound orders to be tied to a specific campaign for inventory allocation and performance tracking.',
    `carrier_contract_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier_contract. Business justification: Routing guide compliance: consumer goods order management selects the carrier contract (routing guide) at order creation to determine service level, OTIF penalty terms, and rate basis. Linking enables',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to deliver the outbound order. Used for freight planning, carrier performance tracking, and proof of delivery.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Outbound orders for regulated product categories (OTC drugs, biocides, restricted substances) must comply with jurisdiction-specific distribution obligations (restricted sale channels, pharmacovigilan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outbound orders incur distribution costs (pick/pack labor, packaging, freight) charged to cost centers for operational cost tracking and variance analysis. Consumer goods companies allocate outbound f',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional order management: outbound orders are directly tied to specific promotion events (e.g., retailer promotional windows). Direct FK enables order-level promotional volume tracking and OTIF-pe',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Freight order creation for every outbound order manages carrier tendering, freight cost tracking, and audit.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level financial and sales reporting aggregates order data by brand, so each outbound order must reference its primary brand.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order document in the ERP system. Links outbound fulfillment to revenue recognition and customer order management.',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center fulfilling the outbound order. Determines inventory source and warehouse operations responsible for order execution.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: During a recall, outbound orders for affected SKUs/lots must be cancelled or placed on hold. This link enables order management to identify and stop shipments of recalled products — a mandatory operat',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Regulatory traceability: outbound orders must reference the production order that generated the shipped product for recall and compliance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for revenue recognition and profit‑center reporting; each outbound orders sales revenue is attributed to a profit center.',
    `route_id` BIGINT COMMENT 'Identifier of the delivery route assigned to the outbound order. Used for DSD (Direct Store Delivery) route optimization and multi-stop delivery planning.',
    `sku_id` BIGINT COMMENT 'FK to product.sku.sku_id — Links distribution outbound orders to product master. Required for product-level fulfillment analytics, category-level DC throughput reporting.',
    `trade_account_id` BIGINT COMMENT 'Identifier of the customer or retail account placing the outbound order. Links to trade account master for customer details, pricing agreements, and delivery preferences.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Trade promotion order fulfillment: outbound orders are generated to fulfill trade promotion volume commitments. Linking enables promotional fill-rate reporting, TPM reconciliation, and OTIF measuremen',
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
    `order_date` DATE COMMENT 'Date when the outbound order was created or received from the customer. Principal business event timestamp for order lifecycle tracking.',
    `order_status` STRING COMMENT 'Current lifecycle status of the outbound order. Draft indicates order creation, released means ready for fulfillment, picking/packing/staged represent warehouse execution phases, shipped indicates in-transit, delivered confirms receipt, cancelled indicates order termination. [ENUM-REF-CANDIDATE: draft|released|picking|packing|staged|shipped|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the outbound order based on fulfillment channel and destination. Retail replenishment serves store orders, DSD (Direct Store Delivery) bypasses DC, ecommerce serves online consumers, inter-DC transfer moves inventory between distribution centers, wholesale serves B2B customers, export serves international markets.. Valid values are `retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export`',
    `otif_commitment_flag` BOOLEAN COMMENT 'Indicates whether this order is subject to formal OTIF performance measurement and customer scorecard reporting. True for orders with contractual delivery commitments.',
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

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`pick_task` (
    `pick_task_id` BIGINT COMMENT 'Unique identifier for the pick task record. Primary key for the pick_task data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pick task labor costs are charged to a cost center; required for labor cost analysis and OTIF performance metrics.',
    `distribution_storage_location_id` BIGINT COMMENT 'Reference to the target location where picked items are staged or packed (e.g., pack station, staging lane, loading dock).',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center or warehouse where the pick task is executed.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the specific lot or batch of inventory being picked. Critical for FEFO (First Expired First Out) and FIFO (First In First Out) rotation compliance.',
    `outbound_order_id` BIGINT COMMENT 'Reference to the parent outbound order or shipment order that generated this pick task.',
    `primary_pick_distribution_storage_location_id` BIGINT COMMENT 'Reference to the warehouse storage location (bin, shelf, pallet position) from which inventory is picked.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: During an active recall, pick tasks for affected SKUs/lots must be immediately suspended in the WMS. This link enables real-time halting of picking operations for recalled inventory — a critical opera',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU being picked or packed in this task.',
    `carton_code` STRING COMMENT 'Unique identifier for the carton or shipping container into which items are packed. May be a license plate number (LPN) or SSCC (Serial Shipping Container Code).. Valid values are `^CTN[0-9A-Z]{8,15}$`',
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
    `picked_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of SKU units picked by the operator. May differ from pick_quantity due to short picks or overages.',
    `picking_strategy` STRING COMMENT 'The picking methodology applied: discrete (single order), batch (multiple orders), zone (by warehouse zone), wave (grouped by wave), cluster (multi-order cart picking).. Valid values are `discrete|batch|zone|wave|cluster`',
    `priority_level` STRING COMMENT 'Priority classification of the pick task for sequencing and resource allocation: urgent (immediate), high (expedited), normal (standard), low (backlog).. Valid values are `urgent|high|normal|low`',
    `sscc` STRING COMMENT '18-digit GS1 Serial Shipping Container Code uniquely identifying the logistics unit (carton or pallet) for tracking through the supply chain.. Valid values are `^[0-9]{18}$`',
    `task_assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was assigned to an operator by the WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the pick task was completed and confirmed by the operator or WMS. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_duration_seconds` STRING COMMENT 'Total elapsed time in seconds from task start to completion. Used for labor productivity analysis and standard time calculation.',
    `task_started_timestamp` TIMESTAMP COMMENT 'Timestamp when the operator began executing the pick task (scanned start or confirmed task initiation). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `task_status` STRING COMMENT 'Current lifecycle status of the pick task: pending (awaiting assignment), assigned (allocated to operator), in_progress (actively being executed), completed (finished successfully), cancelled (voided), on_hold (temporarily suspended).. Valid values are `pending|assigned|in_progress|completed|cancelled|on_hold`',
    `task_type` STRING COMMENT 'Discriminator indicating the type of fulfillment task: pick (picking only), pack (packing only), pick_and_pack (combined operation), or replenishment_pick (internal stock movement).. Valid values are `pick|pack|pick_and_pack|replenishment_pick`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for pick and picked quantities (e.g., EA for each, CS for case, PL for pallet).. Valid values are `^[A-Z]{2,3}$`',
    `wave_code` BIGINT COMMENT 'Reference to the wave batch that groups multiple pick tasks for optimized execution. Supports wave picking strategy.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the packed carton or pallet, measured in centimeters.',
    CONSTRAINT pk_pick_task PRIMARY KEY(`pick_task_id`)
) COMMENT 'Fulfillment task record covering both picking and packing operations within DC outbound execution. For picking: captures pick list reference, source location, SKU, lot, pick quantity, assigned operator, wave/batch reference, pick accuracy flag, and task timestamps. For packing: captures pack station, carton/pallet ID, packed SKUs and quantities, packaging material, gross weight, dimensions, GS1-128/SSCC label, and packer operator. Supports wave picking, batch picking, zone picking, and cartonization strategies in Blue Yonder WMS. Task_type discriminator distinguishes pick vs pack execution steps.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`pack_task` (
    `pack_task_id` BIGINT COMMENT 'Unique identifier for the packing task record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier-specific label generation and packaging compliance (e.g., GS1 label formats, pallet configurations) require knowing the assigned carrier at pack time. carrier_code is a denormalized carrier id',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pack tasks consume labor and packaging materials charged to cost centers. Consumer goods DC operations track packing costs by cost center for productivity reporting, packaging material cost variance a',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Pack tasks are physically executed at a specific distribution center. While pack_task already links to outbound_order (which has distribution_facility_id), a direct FK on pack_task to distribution_fac',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Freight audit process: packed carton/pallet weight and volume must be reconciled against the freight order tender to validate carrier billing. Consumer goods DCs create freight orders before or during',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Lot traceability through packing: pack tasks handle specific lot/batch items requiring FEFO compliance and recall management. Consumer goods regulatory requirements mandate lot-level traceability at e',
    `outbound_order_id` BIGINT COMMENT 'Reference to the outbound order being packed for dispatch.',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: DC cartonization and packing operations: pack tasks execute against authoritative packaging specs to determine carton dimensions, materials, and configurations. DC operations managers reference produc',
    `carton_code` STRING COMMENT 'Unique identifier for the shipping carton or container used for packing.',
    `cartonization_rule_code` BIGINT COMMENT 'Reference to the cartonization algorithm or business rule used to determine optimal packing configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was first created in the system.',
    `destination_facility_code` STRING COMMENT 'Code identifying the destination distribution center, retail store, or customer facility for the packed shipment.',
    `dsd_flag` BOOLEAN COMMENT 'Indicates whether this pack task is for Direct Store Delivery channel bypassing distribution center.',
    `exception_code` STRING COMMENT 'Code identifying any exception or issue encountered during the packing process.',
    `exception_notes` STRING COMMENT 'Free-text notes describing any exceptions, issues, or special handling instructions for the pack task.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the packed container including product and packaging materials, measured in kilograms.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the packed container contains hazardous materials requiring special handling and labeling.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the packed container in centimeters.',
    `label_printed_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipping label was printed for the packed container.',
    `label_type` STRING COMMENT 'Type of shipping label applied to the packed container.. Valid values are `gs1_128|sscc|shipping_label|hazmat|custom`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was last updated in the system.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the packed container in centimeters.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product contents excluding packaging materials, measured in kilograms.',
    `otif_target_ship_date` DATE COMMENT 'Target ship date for OTIF performance measurement and customer service level compliance.',
    `pack_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the packing task was completed and sealed for dispatch.',
    `pack_duration_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes taken to complete the packing task, used for labor productivity analysis.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the packing task was initiated by the operator.',
    `pack_station_code` STRING COMMENT 'Identifier of the physical pack station or workstation where packing occurred.',
    `pack_status` STRING COMMENT 'Current lifecycle status of the packing task.. Valid values are `pending|in_progress|completed|verified|exception|cancelled`',
    `pack_type` STRING COMMENT 'Type of packing configuration used for the task.. Valid values are `carton|pallet|mixed_pallet|overpack|bulk`',
    `pallet_code` STRING COMMENT 'Unique identifier for the pallet if items were packed onto a pallet for shipment.',
    `quality_check_status` STRING COMMENT 'Status of quality verification performed on the packed container before dispatch.. Valid values are `not_required|pending|passed|failed`',
    `sscc` STRING COMMENT 'GS1-128 compliant 18-digit Serial Shipping Container Code applied to the packed unit for supply chain traceability.. Valid values are `^d{18}$`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the packed container requires temperature-controlled transportation and storage.',
    `total_sku_count` STRING COMMENT 'Total number of distinct SKUs packed into the container.',
    `total_unit_quantity` DECIMAL(18,2) COMMENT 'Total quantity of units packed across all SKUs in the container.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment visibility and proof of delivery.',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric capacity of the packed container in cubic meters, used for transportation planning.',
    `wave_code` BIGINT COMMENT 'Reference to the wave or batch grouping of orders for coordinated picking and packing.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the packed container in centimeters.',
    CONSTRAINT pk_pack_task PRIMARY KEY(`pack_task_id`)
) COMMENT 'Packing task record capturing the consolidation and packaging of picked items into shipping cartons or pallets for outbound dispatch. Records pack station ID, outbound order reference, carton/pallet ID, packed SKUs and quantities, packaging material used, gross weight, dimensions, label applied (GS1-128 / SSCC), pack completion timestamp, and packer operator ID. Drives cartonization and pallet build compliance.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` (
    `distribution_shipment_id` BIGINT COMMENT 'Unique identifier for the distribution shipment record. Primary key for the distribution shipment entity.',
    `carrier_id` BIGINT COMMENT 'FK to logistics.carrier',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Cross-border shipments must satisfy jurisdiction-specific compliance obligations (import notification requirements, restricted substance declarations, export license conditions). This link enables com',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for shipment cost allocation report; logistics expenses are charged to a cost center, a standard practice in consumer‑goods distribution.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Shipment Manifest for Promotional Campaigns tracks which shipment fulfills which promotion event, used for logistics planning and compliance reporting.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Freight cost allocation: the freight order is the contractual tender to the carrier; the distribution shipment is the DC execution record. Linking enables freight cost attribution to shipments for tra',
    `freight_rate_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_rate. Business justification: Freight audit and cost variance reporting: consumer goods logistics teams match the applied freight rate to the carrier invoice to identify overbilling. Linking distribution_shipment to the specific f',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to sales.invoice. Business justification: Goods-issue-based billing reconciliation: consumer goods invoices are triggered by shipment events. Linking distribution_shipment to invoice enables freight charge reconciliation, billing accuracy aud',
    `lane_id` BIGINT COMMENT 'Foreign key linking to logistics.lane. Business justification: Costing and transit planning use lane definitions; linking shipment to lane provides distance, rate, and compliance data.',
    `manufacturing_facility_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_facility. Business justification: Shipment origin tracking: linking shipments to the originating manufacturing facility enables performance dashboards and OTIF analysis.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand‑level shipment analytics need each shipment to be associated with the brand whose products are being shipped.',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order. Business justification: Shipment is a child of an outbound order; each shipment fulfills an order. Adding outbound_order_id to distribution_shipment creates the necessary parent link without creating a bidirectional relation',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Recall execution requires identifying all in-transit shipments carrying affected lots. Linking distribution_shipment to product_recall enables rapid shipment quarantine and recovery tracking — a manda',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution shipments are assigned to profit centers for freight cost P&L reporting by brand, channel, or business unit. Consumer goods companies require shipment-level profit center assignment for t',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Cross-border shipments of regulated consumer goods require the applicable regulatory registration to be cited on export/import documentation. Trade compliance and customs clearance processes depend on',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Route-level OTIF and cost analysis: consumer goods DCs assign shipments to delivery routes for DSD and DC-to-store operations. Linking enables route OTIF scoring, fuel cost allocation per shipment, de',
    `distribution_facility_id` BIGINT COMMENT 'FK to distribution.distribution_facility',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Goods issue process: when a distribution shipment departs, an ERP goods issue stock_movement is posted to deduct inventory. Consumer goods WMS/ERP integration requires this link for shipment-to-invent',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle. Business justification: Temperature compliance and capacity utilization reporting: consumer goods shipments (especially cold chain) require tracking which vehicle executed the shipment for regulatory traceability, refrigerat',
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
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment was delivered within the committed delivery window. Component of OTIF calculation.',
    `otif_status` STRING COMMENT 'Calculated OTIF performance status indicating whether the shipment was delivered on time and complete per customer commitment. Key supply chain KPI.. Valid values are `on_time_in_full|late|incomplete|damaged|not_applicable`',
    `pallet_count` STRING COMMENT 'Total number of pallets included in the shipment. Used for handling unit tracking and dock labor planning.',
    `pro_number` STRING COMMENT 'Carrier-assigned progressive number used for tracking and tracing the shipment in the carriers system.',
    `scheduled_delivery_date` DATE COMMENT 'Planned date for the shipment to arrive at the destination. Used for customer commitment and OTIF measurement.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time for the shipment to arrive at the destination. Precision timestamp for delivery window commitments.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time for the shipment to depart from the DC dock. Precision timestamp for appointment scheduling and carrier coordination.',
    `scheduled_ship_date` DATE COMMENT 'Planned date for the shipment to depart from the distribution center. Used for OTIF performance measurement baseline.',
    `seal_number` STRING COMMENT 'Unique identifier of the security seal applied to the trailer or container to ensure shipment integrity and prevent tampering.',
    `shipment_number` STRING COMMENT 'Externally-known unique business identifier for the shipment assigned by the WMS. Used for tracking and reference across systems and with carriers.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment in the outbound fulfillment workflow. Tracks progression from planning through final delivery. [ENUM-REF-CANDIDATE: planned|staged|loading|loaded|departed|in_transit|delivered|cancelled — 8 candidates stripped; promote to reference product]',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on delivery method and business purpose. DSD indicates Direct Store Delivery channel.. Valid values are `standard|expedited|dsd|cross_dock|transfer|return`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this shipment requires temperature-controlled transportation for product integrity.',
    `total_units` STRING COMMENT 'Total quantity of individual sellable units (eaches) included in the shipment across all SKUs.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total cube or volume of the shipment in cubic meters. Critical for trailer utilization and dimensional weight calculations.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms including product and packaging. Used for freight rating and load planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for real-time shipment visibility and customer self-service tracking.',
    `trailer_number` STRING COMMENT 'Identifier of the trailer or container unit used to transport the shipment. Critical for load tracking and yard management.',
    `wave_number` STRING COMMENT 'Identifier of the warehouse picking wave that generated the orders included in this shipment. Links shipment to WMS wave planning.',
    CONSTRAINT pk_distribution_shipment PRIMARY KEY(`distribution_shipment_id`)
) COMMENT 'Outbound shipment record representing the physical dispatch of goods from a DC to a customer, retailer, or downstream DC. Captures shipment number, carrier, trailer/container ID, seal number, dock door, scheduled and actual departure datetime, destination, total weight, total cube, pallet count, carton count, and OTIF status. Integrates with Blue Yonder WMS load planning and SAP SD goods issue. SSOT for DC-level outbound shipment execution distinct from the logistics domains carrier-level shipment tracking.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` (
    `inventory_position_id` BIGINT COMMENT 'Primary key for inventory_position',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Recall management and regulatory traceability in consumer goods (FDA, EU regulations) require DC inventory positions to directly reference the manufacturing batch record. Enables immediate identificat',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Inventory compliance reporting links each inventory position to its applicable regulatory obligation to track deadlines and status.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory positions carry total_inventory_value requiring cost center assignment for inventory write-down accounting, slow-moving stock provisions, and period-end inventory cost reporting. Consumer go',
    `distribution_facility_id` BIGINT COMMENT 'Identifier of the distribution center where the inventory is physically located.',
    `distribution_storage_location_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_storage_location. Business justification: Inventory position records on‑hand quantities at a specific DC location. Linking to distribution_storage_location provides the authoritative location details and removes the generic storage_location_i',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inventory positions map to inventory asset GL accounts (raw materials, finished goods, WIP) for balance sheet reporting. Consumer goods companies require this link for inventory account determination,',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to distribution.inbound_receipt. Business justification: Inventory positions are created or updated as a result of inbound receipts. Linking inventory_position to inbound_receipt provides full traceability from on-hand stock back to the originating receipt ',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Quality Hold Inventory Visibility: inventory positions placed on quality hold or quarantine must reference the inspection lot driving the hold. WMS quality hold management, inventory disposition workf',
    `lot_batch_id` BIGINT COMMENT 'Identifier of the specific lot or batch of the SKU. Critical for traceability, quality control, and FEFO inventory rotation.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Inventory positions holding recalled SKUs/lots must be quarantined and tracked for recovery quantity reporting. This link enables precise lot-level recall inventory management and supports regulatory ',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU for which inventory position is tracked.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Inventory is valued at standard cost in consumer goods (SAP standard price control). inventory_position.cost_per_unit must reference the active standard_cost record for the SKU to ensure consistent in',
    `actual_weight` DECIMAL(18,2) COMMENT 'The actual measured weight of the inventory for catch weight items. Used for billing and compliance when item weight varies.',
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
    `snapshot_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory position snapshot was captured. Used for point-in-time inventory reporting and trend analysis.',
    `storage_zone` STRING COMMENT 'The logical zone within the distribution center where the inventory is stored (e.g., ambient, refrigerated, frozen, hazmat, high-velocity, reserve).',
    `temperature_zone` STRING COMMENT 'The temperature control zone classification for the storage location. Critical for cold chain compliance and product quality.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'The total financial value of the inventory position calculated as quantity_on_hand multiplied by cost_per_unit. Used for balance sheet reporting. Business confidential financial data.',
    `unit_of_measure` STRING COMMENT 'The base unit of measure in which inventory quantities are tracked (Each, Case, Pallet, Pound, Kilogram, Liter, Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    `weight_unit_of_measure` STRING COMMENT 'The unit of measure for actual weight (Pound, Kilogram, Ounce, Gram). Applicable for catch weight items.. Valid values are `LB|KG|OZ|G`',
    CONSTRAINT pk_inventory_position PRIMARY KEY(`inventory_position_id`)
) COMMENT 'Current on-hand inventory position at the DC-location-SKU-lot level within distribution center walls. Captures storage location, SKU, lot number, manufacture and expiry dates, quantity on hand, allocated quantity, available-to-pick (ATP) quantity, quarantine quantity, inventory status (available, hold, damaged, expired), and last cycle count date. This is the operational working inventory view for DC execution — distinct from the inventory domains network-wide planning position which aggregates across all nodes.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` (
    `distribution_cycle_count_id` BIGINT COMMENT 'Unique identifier for the cycle count event record. Primary key for the distribution cycle count entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Cycle counts for regulated products (controlled substances, hazmat) are mandated by compliance obligations specifying count frequency and method. Linking cycle count records to the governing complianc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cycle count variances generate inventory adjustment costs charged to cost centers. Consumer goods DC finance teams track count-driven write-offs and adjustments by cost center for shrinkage reporting,',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Cycle count events are scoped to a specific distribution center. Although distribution_cycle_count links to distribution_storage_location (which in turn links to distribution_facility), a direct FK to',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inventory adjustments from cycle counts post to specific GL accounts (inventory adjustment/shrinkage accounts). Consumer goods finance requires this link to ensure count variances are posted to the co',
    `inventory_cycle_count_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_cycle_count. Business justification: WMS-ERP cycle count reconciliation: distribution WMS cycle counts must be reconciled against ERP inventory_cycle_count records. Consumer goods operations require this cross-system link for variance re',
    `inventory_storage_location_id` BIGINT COMMENT 'Identifier of the specific storage location (bin, rack, aisle) within the DC where the count was performed.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Approved cycle count variances generate journal entries for inventory write-up or write-down. Consumer goods auditors require traceability from physical count results to the corresponding financial po',
    `lot_batch_id` BIGINT COMMENT 'Identifier of the specific lot or batch being counted, critical for FEFO/FIFO inventory rotation and traceability.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Cycle counts are triggered by product recalls to verify recalled inventory quantities on hand. Linking cycle count to product_recall supports recall effectiveness verification and quantity reconciliat',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being counted in this cycle count line.',
    `stock_adjustment_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_adjustment. Business justification: Count variance posting: a distribution cycle count variance triggers a stock_adjustment in the ERP/inventory system. Consumer goods WMS-ERP integration requires this link to trace which WMS count drov',
    `abc_classification` STRING COMMENT 'ABC inventory classification of the SKU at the time of count: A (high value/velocity), B (medium), C (low), D (obsolete/slow-moving).. Valid values are `A|B|C|D`',
    `adjustment_approved_flag` BOOLEAN COMMENT 'Indicates whether the inventory adjustment has been approved by a supervisor or manager.',
    `adjustment_required_flag` BOOLEAN COMMENT 'Indicates whether an inventory adjustment is required based on the variance exceeding tolerance thresholds.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the cycle count adjustment was approved by a supervisor or manager.',
    `count_end_timestamp` TIMESTAMP COMMENT 'The date and time when the physical counting activity was completed.',
    `count_method` STRING COMMENT 'The method used to perform the physical count: manual (paper-based), RF scanner (handheld device), voice picking (voice-directed), or automated (RFID/sensor).. Valid values are `manual|rf_scanner|voice_picking|automated`',
    `count_number` STRING COMMENT 'Business identifier for the cycle count event, typically generated by the WMS. Format: CC-YYYYMMDD-NNNN.. Valid values are `^CC-[0-9]{8}-[0-9]{4}$`',
    `count_reason_code` STRING COMMENT 'The business reason triggering this cycle count: routine (scheduled ABC cycle), discrepancy (prior variance), audit (compliance), quality (QC hold), recall (product recall), transfer (location move).. Valid values are `routine|discrepancy|audit|quality|recall|transfer`',
    `count_start_timestamp` TIMESTAMP COMMENT 'The date and time when the physical counting activity began.',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count event.. Valid values are `planned|in_progress|completed|cancelled|under_review`',
    `count_type` STRING COMMENT 'Classification of the cycle count event: scheduled (routine ABC cycle), ad-hoc (unplanned), exception (triggered by discrepancy), blind (counter does not see system quantity), or targeted (specific SKU/lot focus).. Valid values are `scheduled|ad_hoc|exception|blind|targeted`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The actual physical quantity counted by the warehouse associate during the cycle count event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the inventory value variance amount.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The expiration or best-before date of the lot/batch being counted, critical for FEFO inventory rotation.',
    `inventory_value_variance_amount` DECIMAL(18,2) COMMENT 'The financial impact of the variance, calculated as variance_quantity multiplied by the standard cost of the SKU. Expressed in the DCs functional currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cycle count record was last updated in the system.',
    `recount_number` STRING COMMENT 'Sequential number indicating which recount iteration this represents (1 for first recount, 2 for second, etc.). Null if no recount performed.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether a recount is required due to significant variance or quality control procedures.',
    `scheduled_date` DATE COMMENT 'The date on which the cycle count was scheduled to be performed.',
    `stock_status` STRING COMMENT 'The inventory status of the counted stock: available (unrestricted), hold (QC hold), quarantine (quality review), damaged, expired, or reserved (allocated to orders).. Valid values are `available|hold|quarantine|damaged|expired|reserved`',
    `system_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU/lot recorded in the WMS at the time of the cycle count.',
    `tolerance_threshold_percentage` DECIMAL(18,2) COMMENT 'The acceptable variance percentage threshold. Variances within this percentage may not require adjustment.',
    `tolerance_threshold_quantity` DECIMAL(18,2) COMMENT 'The acceptable variance quantity threshold defined for this SKU/location combination. Variances within this threshold may not require adjustment.',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are expressed: EA (each), CS (case), PL (pallet), LB (pound), KG (kilogram), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|LB|KG|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_notes` STRING COMMENT 'Free-text notes providing additional context or explanation for the variance observed during the cycle count.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the system quantity, calculated as (variance_quantity / system_quantity) * 100.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted quantity and system quantity (counted minus system). Positive indicates overage, negative indicates shortage.',
    `variance_reason_code` STRING COMMENT 'Root cause classification for the variance: picking error, receiving error, damage, theft, system error, location error, expiry, or other. [ENUM-REF-CANDIDATE: picking_error|receiving_error|damage|theft|system_error|location_error|expiry|other — 8 candidates stripped; promote to reference product]',
    `wms_transaction_code` STRING COMMENT 'The unique transaction identifier generated by the WMS for this cycle count event, used for audit trail and system reconciliation.',
    CONSTRAINT pk_distribution_cycle_count PRIMARY KEY(`distribution_cycle_count_id`)
) COMMENT 'Cycle count event record capturing scheduled or ad-hoc physical inventory counts at DC locations, including line-level detail for each SKU/lot counted with system vs. actual quantities and variance calculations.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`distribution`.`otif_event` (
    `otif_event_id` BIGINT COMMENT 'Unique identifier for the OTIF performance measurement event. Primary key for the OTIF event record.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: OTIF penalties (retailer_penalty_amount) are deducted from AR invoices as chargebacks. Consumer goods companies must link OTIF events to AR invoices to process retailer deductions, dispute chargebacks',
    `carrier_id` BIGINT COMMENT 'Reference to the transportation carrier responsible for delivery. Used for carrier performance scorecarding and accountability analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OTIF penalty costs are charged to responsible cost centers (DC operations, carrier management) for accountability and performance management. Consumer goods supply chain finance tracks OTIF penalty sp',
    `delivery_id` BIGINT COMMENT 'Reference to the delivery execution record for Direct Store Delivery (DSD) or carrier delivery. Links to the actual delivery event.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the distribution center that originated the shipment. Used for DC-level OTIF performance accountability and scorecard reporting.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotion event OTIF measurement: OTIF events are measured per promotion event window in consumer goods. Direct FK enables OTIF-per-promotion-event KPI reporting and retailer compliance scoring withou',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: OTIF penalty assessment against freight orders: consumer goods retailers (Walmart, Target) assess OTIF penalties at the freight order level. Linking otif_event to freight_order enables direct penalty ',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: OTIF root cause analysis: consumer goods OTIF programs require tracing failures to the specific shipment leg (carrier transit vs. last-mile delivery). Linking otif_event to logistics_shipment enables ',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: OTIF scorecard reporting: OTIF events measure on-time-in-full compliance at the sales order level. order_number exists as plain text (denormalization). Linking to sales.order enables order-level OTIF ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: OTIF performance and associated penalties impact P&L by profit center (brand/channel). Consumer goods companies report OTIF penalty exposure by profit center for trade investment management, customer ',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: OTIF is measured against PO delivery commitments in Consumer Goods. Linking otif_event to purchase_order enables supplier OTIF scorecards, retailer penalty calculations, and PO-level on-time/in-full p',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store location receiving the delivery. Applicable for Direct Store Delivery (DSD) and store-level OTIF tracking.',
    `route_id` BIGINT COMMENT 'Foreign key linking to logistics.route. Business justification: Route-level OTIF performance reporting: consumer goods DC operations track OTIF by delivery route to identify systemic failures (e.g., specific routes consistently late). Linking otif_event to route e',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Retailer OTIF scorecard compliance: major retailers (Walmart, Target) measure and penalize OTIF at the SKU level. Trade compliance analysts must link each OTIF event to the specific SKU to calculate p',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Supplier OTIF rate is a contractual KPI in Consumer Goods — supplier_scorecard.otif_delivery_rate_pct requires direct supplier attribution on OTIF events. A direct FK enables supplier performance dash',
    `trade_account_id` BIGINT COMMENT 'Reference to the customer trade account receiving the shipment. Used for customer-specific OTIF scorecard and retailer compliance reporting.',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: Trade promotion OTIF compliance: retailers impose OTIF penalties against specific trade promotion commitments. Linking otif_event to trade_promotion enables promotion-level OTIF compliance reporting a',
    `actual_delivery_date` DATE COMMENT 'The actual date the shipment was delivered to the customer location. Used to calculate on-time performance variance.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'The precise timestamp when delivery was completed and proof of delivery was captured. Used for time-window OTIF compliance.',
    `committed_delivery_date` DATE COMMENT 'The delivery date committed to the customer per the Service Level Agreement (SLA) or purchase order terms. Baseline for on-time performance measurement.',
    `committed_delivery_timestamp` TIMESTAMP COMMENT 'The precise delivery date and time committed to the customer, including time window for time-sensitive deliveries. Used for precise OTIF measurement when time windows apply.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'The total quantity committed to the customer per the sales order or purchase order. Baseline for in-full performance measurement. Measured in order unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTIF event record was first created in the system. Audit trail for data lineage and record creation tracking.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'The actual quantity delivered to the customer. Used to calculate in-full performance and quantity variance. Measured in order unit of measure.',
    `delivery_channel` STRING COMMENT 'The logistics channel used for delivery execution. Values include Direct Store Delivery (DSD), Less Than Truckload (LTL) carrier, Full Truckload (FTL) carrier, parcel, customer pickup, or third-party logistics (3PL).. Valid values are `dsd|ltl_carrier|ftl_carrier|parcel|customer_pickup|third_party_logistics`',
    `delivery_variance_days` STRING COMMENT 'The number of days variance between committed and actual delivery date. Negative values indicate early delivery, positive values indicate late delivery, zero indicates on-time.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the OTIF measurement is under dispute by the customer or internal stakeholders. True indicates active dispute, False indicates accepted measurement.',
    `dispute_reason` STRING COMMENT 'Explanation of why the OTIF measurement is disputed. Captures customer or internal objections to the performance assessment.',
    `event_status` STRING COMMENT 'The current lifecycle status of the OTIF event record. Tracks progression from initial measurement through dispute resolution and final closure.. Valid values are `pending|confirmed|disputed|resolved|closed`',
    `failure_category` STRING COMMENT 'The primary root cause category for OTIF failures. Used for operational improvement analysis and accountability assignment. Values include DC pick error, inventory shortage, dock delay, carrier issue, customer refused, weather delay, system error, quality hold, damaged product, address issue, or no failure for successful deliveries. [ENUM-REF-CANDIDATE: dc_pick_error|inventory_shortage|dock_delay|carrier_issue|customer_refused|weather_delay|system_error|quality_hold|damaged_product|address_issue|no_failure — 11 candidates stripped; promote to reference product]',
    `failure_reason_detail` STRING COMMENT 'Detailed explanation of the root cause for OTIF failure. Free-text field capturing specific circumstances, corrective actions, and accountability notes.',
    `in_full_flag` BOOLEAN COMMENT 'Boolean indicator of whether the full committed quantity was delivered. True indicates complete delivery, False indicates short shipment or over shipment outside tolerance.',
    `in_full_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable variance percentage per customer SLA or business policy. Deliveries within this tolerance are considered in-full compliant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this OTIF event record was last updated. Audit trail for change tracking and data quality monitoring.',
    `measurement_date` DATE COMMENT 'The date when the OTIF performance was measured and recorded. Used for reporting period assignment and trend analysis.',
    `on_time_flag` BOOLEAN COMMENT 'Boolean indicator of whether the shipment was delivered on or before the committed delivery date. True indicates on-time delivery, False indicates late delivery.',
    `otif_score` BOOLEAN COMMENT 'Composite OTIF performance indicator. True only when both on_time_flag and in_full_flag are True. Primary KPI for DC operations accountability and retailer scorecard compliance.',
    `penalty_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the retailer penalty amount. Standard currency codes such as USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `pod_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether an electronic or physical signature was captured at delivery. True indicates signature obtained, False indicates delivery without signature capture.',
    `proof_of_delivery_timestamp` TIMESTAMP COMMENT 'The timestamp when proof of delivery was captured, typically via electronic signature, barcode scan, or delivery confirmation. Source of truth for actual delivery time.',
    `quantity_uom` STRING COMMENT 'The unit of measure for committed and delivered quantities. Common values include cases, pallets, eaches, or other standard units.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between delivered quantity and committed quantity. Negative values indicate short shipment, positive values indicate over shipment.',
    `quantity_variance_percent` DECIMAL(18,2) COMMENT 'The percentage variance between delivered and committed quantity, calculated as (delivered - committed) / committed * 100. Used to assess severity of in-full failures.',
    `responsible_party` STRING COMMENT 'The organizational function or external party accountable for the OTIF failure. Used for performance accountability and continuous improvement initiatives.. Valid values are `dc_operations|inventory_planning|transportation|carrier|customer|external_factor`',
    `retailer_penalty_amount` DECIMAL(18,2) COMMENT 'The financial penalty or chargeback amount assessed by the retailer for OTIF non-compliance per the customer contract or retailer compliance program. Zero for compliant deliveries.',
    `shipment_number` STRING COMMENT 'The warehouse management system shipment number or bill of lading number. External business identifier for the shipment.',
    `sla_tier` STRING COMMENT 'The service level tier committed to the customer. Defines the delivery speed and OTIF performance expectations per the customer agreement.. Valid values are `standard|expedited|premium|next_day|same_day`',
    CONSTRAINT pk_otif_event PRIMARY KEY(`otif_event_id`)
) COMMENT 'OTIF (On Time In Full) performance measurement record for each outbound shipment or DSD delivery against committed service levels. Captures shipment/delivery reference, customer/account, committed vs actual delivery date, on-time flag, committed vs delivered quantity, in-full flag, composite OTIF score, root cause category for failures (DC pick error, inventory shortage, dock delay, carrier issue), and retailer penalty exposure amount. Primary KPI entity for DC operations accountability and retailer scorecard compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ADD CONSTRAINT `fk_distribution_distribution_storage_location_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ADD CONSTRAINT `fk_distribution_inbound_receipt_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ADD CONSTRAINT `fk_distribution_outbound_order_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ADD CONSTRAINT `fk_distribution_pick_task_primary_pick_distribution_storage_location_id` FOREIGN KEY (`primary_pick_distribution_storage_location_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ADD CONSTRAINT `fk_distribution_pack_task_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_outbound_order_id` FOREIGN KEY (`outbound_order_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`outbound_order`(`outbound_order_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ADD CONSTRAINT `fk_distribution_distribution_shipment_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_distribution_storage_location_id` FOREIGN KEY (`distribution_storage_location_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_storage_location`(`distribution_storage_location_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ADD CONSTRAINT `fk_distribution_inventory_position_inbound_receipt_id` FOREIGN KEY (`inbound_receipt_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`inbound_receipt`(`inbound_receipt_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ADD CONSTRAINT `fk_distribution_distribution_cycle_count_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ADD CONSTRAINT `fk_distribution_otif_event_distribution_facility_id` FOREIGN KEY (`distribution_facility_id`) REFERENCES `consumer_goods_ecm`.`distribution`.`distribution_facility`(`distribution_facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `consumer_goods_ecm`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency (Days)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `dc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `dc_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) Name');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_inbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors (Inbound)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `dock_doors_outbound` SET TAGS ('dbx_business_glossary_term' = 'Dock Doors (Outbound)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `dsd_hub_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Hub Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|multi_temperature|dsd_hub|cross_dock');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `fsc_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Forest Stewardship Council (FSC) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `inventory_rotation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Rotation Method');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `inventory_rotation_method` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Opened Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekday)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (Weekend)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|seasonal|maintenance');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `osa_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Shelf Availability (OSA) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_logistics');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_business_glossary_term' = 'SAP Storage Location');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `sap_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `shifts_per_day` SET TAGS ('dbx_business_glossary_term' = 'Shifts Per Day');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `storage_capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Pallet Positions)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Square Feet)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `wms_site_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Site Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_facility` ALTER COLUMN `wms_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Velocity Classification');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle Identifier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay Identifier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `bay` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_business_glossary_term' = 'Bin Position Identifier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `bin_position` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Location Blocked Reason');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_business_glossary_term' = 'Rack Level Identifier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `distribution_storage_location_level` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Location Effective Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_business_glossary_term' = 'Material Handling Equipment Type Required');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_value_regex' = 'forklift|reach_truck|order_picker|pallet_jack|manual|automated');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Location Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `fefo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `fifo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Height (Centimeters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Length (Centimeters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|quarantine|damaged');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'bulk|pick|reserve|staging|dock|cross_dock');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `mixed_lot_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Lot/Batch Allowed Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `mixed_sku_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'batch|wave|zone|discrete|cluster');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Strategy');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_value_regex' = 'directed|random|fixed|dynamic');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `replenishment_priority` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Rank');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `volume_capacity_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity (Cubic Meters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Kilograms)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Location Width (Centimeters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_storage_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `actual_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|wrong_product|quality_issue|documentation_error');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `otif_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `putaway_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Put-Away Completion Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Completion Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|discrepancy|cancelled');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'supplier_delivery|plant_transfer|inter_dc_transfer|return_from_customer|production_output');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `scheduled_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Receipt Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Check Required Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliant Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `temperature_reading_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Reading (Celsius)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inbound_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Reference');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `backorder_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `fill_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'retail_replenishment|dsd|ecommerce|inter_dc_transfer|wholesale|export');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `otif_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Commitment Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `packing_slip_number` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `pick_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Pick Ticket Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|critical');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|next_day|two_day|same_day|scheduled');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `total_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Order Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `total_order_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Order Volume (Cubic Meters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `total_order_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Order Weight (Kilograms)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`outbound_order` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `primary_pick_distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_value_regex' = '^CTN[0-9A-Z]{8,15}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `gs1_128_label` SET TAGS ('dbx_business_glossary_term' = 'GS1-128 Label Data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (CM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (CM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (KG)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `otif_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Eligible Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `packaging_material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_value_regex' = '^PLT[0-9A-Z]{8,15}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pick_accuracy_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Accuracy Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_business_glossary_term' = 'Pick List Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pick_list_number` SET TAGS ('dbx_value_regex' = '^PL[0-9]{8,12}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `pick_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pick Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'discrete|batch|zone|wave|cluster');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration in Seconds');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Started Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|assigned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'pick|pack|pick_and_pack|replenishment_pick');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pick_task` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (CM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `cartonization_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Cartonization Rule Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `destination_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `dsd_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (Centimeters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `label_printed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Printed Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'gs1_128|sscc|shipping_label|hazmat|custom');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (Centimeters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `otif_target_ship_date` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Ship Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Completion Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Pack Duration (Minutes)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|verified|exception|cancelled');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_type` SET TAGS ('dbx_business_glossary_term' = 'Pack Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pack_type` SET TAGS ('dbx_value_regex' = 'carton|pallet|mixed_pallet|overpack|bulk');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^d{18}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `total_sku_count` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Keeping Unit (SKU) Count');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `wave_code` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`pack_task` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (Centimeters)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'ground|express|overnight|two_day|economy|premium');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Name');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'retail_store|distribution_center|customer|warehouse|third_party');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `dock_door_number` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Amount');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|fob_origin|fob_destination');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `goods_issue_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `load_number` SET TAGS ('dbx_business_glossary_term' = 'Load Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|incomplete|damaged|not_applicable');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive (PRO) Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|dsd|cross_dock|transfer|return');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_shipment` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `inventory_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Position Identifier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `distribution_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Dc Location Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `actual_weight` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `catch_weight_flag` SET TAGS ('dbx_business_glossary_term' = 'Catch Weight Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `days_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Days On Hand (DOH)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `days_to_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days to Expiry');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_business_glossary_term' = 'Inventory Condition');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `inventory_condition` SET TAGS ('dbx_value_regex' = 'new|refurbished|returned|damaged|expired|recalled');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|allocated|quarantine|hold|damaged|expired');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `last_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `license_plate_number` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number (LPN)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'owned|consignment|customer_owned|vendor_managed');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `pallet_code` SET TAGS ('dbx_business_glossary_term' = 'Pallet ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `pick_face_flag` SET TAGS ('dbx_business_glossary_term' = 'Pick Face Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `putaway_date` SET TAGS ('dbx_business_glossary_term' = 'Putaway Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'Quantity Allocated');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available (ATP - Available to Promise)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `quantity_damaged` SET TAGS ('dbx_business_glossary_term' = 'Quantity Damaged');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `quantity_hold` SET TAGS ('dbx_business_glossary_term' = 'Quantity Hold');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand (QOH)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `quantity_quarantine` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quarantine');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`inventory_position` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = 'LB|KG|OZ|G');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `distribution_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Cycle Count ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `inventory_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `inventory_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot/Batch ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `stock_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Adjustment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `adjustment_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approved Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `adjustment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Required Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count End Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|rf_scanner|voice_picking|automated');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Count Reason Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_reason_code` SET TAGS ('dbx_value_regex' = 'routine|discrepancy|audit|quality|recall|transfer');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|under_review');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Type');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|exception|blind|targeted');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `inventory_value_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Inventory Value Variance Amount');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `inventory_value_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `recount_number` SET TAGS ('dbx_business_glossary_term' = 'Recount Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Count Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'available|hold|quarantine|damaged|expired|reserved');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `tolerance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Percentage');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `tolerance_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`distribution_cycle_count` ALTER COLUMN `wms_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Transaction ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` SET TAGS ('dbx_subdomain' = 'fulfillment_operations');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `otif_event_id` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Event ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `committed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `committed_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Committed Delivery Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Committed Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'dsd|ltl_carrier|ftl_carrier|parcel|customer_pickup|third_party_logistics');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `delivery_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Variance Days');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'OTIF Event Status');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|resolved|closed');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `failure_category` SET TAGS ('dbx_business_glossary_term' = 'OTIF Failure Root Cause Category');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `failure_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'OTIF Failure Reason Detail');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `in_full_flag` SET TAGS ('dbx_business_glossary_term' = 'In Full Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `in_full_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'In Full Tolerance Percent');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'OTIF Measurement Date');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `on_time_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `otif_score` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Score');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `pod_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Captured Flag');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `proof_of_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Timestamp');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `quantity_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance Percent');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'dc_operations|inventory_planning|transportation|carrier|customer|external_factor');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `retailer_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Retailer Penalty Amount');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `retailer_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `consumer_goods_ecm`.`distribution`.`otif_event` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|expedited|premium|next_day|same_day');
