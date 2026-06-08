-- Schema for Domain: fulfillment | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`fulfillment` COMMENT 'Physical execution of order fulfillment across DCs, MFCs, and store backrooms. Manages pick-pack-ship workflows, wave planning, WMS task management, putaway and slotting logic, carrier selection and assignment, last-mile delivery dispatch, and SLA compliance. Tracks fill rates and cold chain integrity during shipment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`wave` (
    `wave_id` BIGINT COMMENT 'Unique identifier for the wave planning record. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the warehouse supervisor responsible for overseeing this wave execution. Used for accountability and escalation.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to ship orders from this wave. Used for carrier coordination and last-mile delivery dispatch.',
    `created_by_user_associate_id` BIGINT COMMENT 'Identifier of the user or system process that created this wave record. Used for audit trail and accountability.',
    `node_id` BIGINT COMMENT 'Identifier of the facility (DC, MFC, or store backroom) where this wave is executed.',
    `modified_by_user_associate_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this wave record. Used for audit trail and change management.',
    `promo_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_calendar. Business justification: Wave scheduling uses the promotional calendar to align wave start/end dates with campaign calendars.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Promotion‑driven wave planning report requires linking each wave to the active promo_campaign to allocate inventory.',
    `transport_route_id` BIGINT COMMENT 'Identifier of the delivery route assigned to this wave. Used for route optimization and last-mile delivery planning.',
    `sla_policy_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla_policy. Business justification: Associating a wave with its SLA policy provides clear policy enforcement per wave and introduces needed inbound relationship for sla_policy.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when wave picking was completed. Used for cycle time analysis and SLA compliance measurement.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when wave picking began. Used for performance analysis and variance tracking against planned start time.',
    `cancelled_line_count` STRING COMMENT 'Number of order lines cancelled during wave execution due to inventory issues, quality problems, or customer cancellations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this wave record was first created in the system. Used for audit trail and wave planning analysis.',
    `equipment_type` STRING COMMENT 'Primary material handling equipment type used for this wave: pallet jack, forklift, order picker, reach truck, cart, or automated system (AS/RS, AMR).. Valid values are `pallet_jack|forklift|order_picker|reach_truck|cart|automated`',
    `facility_zone` STRING COMMENT 'Physical zone or area within the facility where this wave is executed (e.g., ambient zone, refrigerated zone, freezer zone, backroom section).',
    `fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of order lines successfully picked and fulfilled in this wave. Calculated as (lines picked / total lines) × 100. Key metric for inventory availability and fulfillment performance.',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether this wave maintained required temperature controls throughout execution per HACCP standards. True if compliant, False if temperature excursions occurred.',
    `is_rush_wave` BOOLEAN COMMENT 'Boolean flag indicating whether this is an expedited rush wave requiring immediate processing outside of normal wave planning cycles. True for rush waves, False for standard waves.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this wave record was last modified. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text operational notes or comments about this wave execution, including special handling instructions, issues encountered, or process deviations.',
    `pick_method` STRING COMMENT 'Picking methodology used for this wave: discrete (single order at a time), batch (multiple orders picked together), zone (pickers assigned to zones), wave (coordinated multi-zone), or cluster (cart-based multi-order).. Valid values are `discrete|batch|zone|wave|cluster`',
    `picker_count` STRING COMMENT 'Number of warehouse pickers assigned to execute this wave. Used for labor productivity analysis and staffing optimization.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when wave picking is planned to be completed. Used for SLA tracking and downstream process coordination.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when wave picking is planned to begin. Used for labor scheduling and capacity planning.',
    `priority_tier` STRING COMMENT 'Business priority level assigned to this wave for resource allocation and sequencing. Urgent waves are processed first, followed by high, normal, and low priority waves.. Valid values are `urgent|high|normal|low`',
    `released_timestamp` TIMESTAMP COMMENT 'Date and time when the wave was released to the warehouse floor for execution. Marks the transition from planned to active status.',
    `short_pick_count` STRING COMMENT 'Number of order lines that could not be fully picked due to insufficient inventory (out-of-stock or OOS). Used for inventory accuracy and replenishment analysis.',
    `sla_cutoff_timestamp` TIMESTAMP COMMENT 'Service level agreement deadline by which this wave must be completed to meet customer delivery commitments. Used for on-time performance tracking.',
    `temperature_zone` STRING COMMENT 'Temperature control classification for this wave: ambient (room temperature), refrigerated (cold chain 0-4°C), frozen (below 0°C), or multi-temp (mixed temperature requirements). Critical for cold chain integrity tracking.. Valid values are `ambient|refrigerated|frozen|multi_temp`',
    `total_lines` BIGINT COMMENT 'Total number of order lines (SKU-level picks) across all orders in this wave. Used for pick task generation and labor allocation.',
    `total_orders` BIGINT COMMENT 'Total number of distinct orders included in this wave. Used for batch size optimization and order fulfillment tracking.',
    `total_units` BIGINT COMMENT 'Total number of individual units (eaches) to be picked in this wave across all orders and SKUs. Used for workload estimation and productivity tracking.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total cubic volume in cubic meters of all items to be picked in this wave. Used for container and vehicle capacity planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of all items to be picked in this wave. Used for equipment planning (forklifts, pallet jacks) and carrier capacity allocation.',
    `wave_number` STRING COMMENT 'Business-facing wave identifier used for operational tracking and communication. Externally-known unique code for this wave.. Valid values are `^[A-Z0-9]{6,20}$`',
    `wave_status` STRING COMMENT 'Current lifecycle status of the wave: planned (created but not released), released (active for picking), in-progress (picking underway), completed (all tasks finished), cancelled (aborted), or on-hold (temporarily suspended).. Valid values are `planned|released|in_progress|completed|cancelled|on_hold`',
    `wave_type` STRING COMMENT 'Classification of the wave based on fulfillment purpose: replenishment (store restocking), ecommerce (online order fulfillment), DSD (Direct Store Delivery), store transfer, bulk pick, or cross-dock operations.. Valid values are `replenishment|ecommerce|dsd|store_transfer|bulk_pick|cross_dock`',
    `wms_wave_identifier` STRING COMMENT 'Native wave identifier from the source WMS system (Manhattan Associates, SAP WM, or other). Used for system integration and cross-reference.',
    CONSTRAINT pk_wave PRIMARY KEY(`wave_id`)
) COMMENT 'Wave planning record representing a batch of pick tasks grouped for coordinated execution within a DC, MFC, or store backroom. Captures wave number, planned start/end times, wave type (replenishment, e-commerce, DSD), facility zone, total units, total orders, wave status (planned, released, in-progress, completed, cancelled), priority tier, and WMS wave identifier. Waves are the primary unit of work orchestration in fulfillment — all picking activity flows through wave release.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`wms_task` (
    `wms_task_id` BIGINT COMMENT 'Primary key for wms_task',
    `associate_id` BIGINT COMMENT 'Reference to the warehouse associate assigned to execute this task. Used for labor tracking and productivity analysis.',
    `node_id` BIGINT COMMENT 'Reference to the distribution center, micro-fulfillment center, or store backroom where this task is executed.',
    `planogram_id` BIGINT COMMENT 'Foreign key linking to assortment.planogram. Business justification: PICK TASK PLANNING: WMS pick tasks use the stores planogram to locate items; linking enables task generation and audit of planogram adherence.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Traceability reports link each pick task to the underlying product item for allergen, temperature, and regulatory compliance.',
    `product_order_id` BIGINT COMMENT 'Reference to the customer or replenishment order that originated this task. Links warehouse execution back to order fulfillment.',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Needed for Pick Task Detail Report; ties each WMS pick task to the exact order line it fulfills.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Pick task execution requires the exact SKU to locate inventory; the WMS picking process uses SKU for routing and allocation.',
    `slot_location_id` BIGINT COMMENT 'Foreign key linking to fulfillment.slot_location. Business justification: Linking each WMS task to its exact slot location enables precise location tracking and removes redundant location attributes from wms_task.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Pick task must reference the exact stock position to locate items for picking, required for the Pick Execution process and inventory accuracy reports.',
    `wave_id` BIGINT COMMENT 'Reference to the wave planning batch that grouped this task with other tasks for optimized execution. Wave planning consolidates orders by shipping window, carrier, or zone.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Quantity actually picked, put away, or counted by the warehouse associate. Variance from target quantity triggers exception handling.',
    `cold_chain_flag` BOOLEAN COMMENT 'Indicates whether this task involves temperature-controlled inventory requiring cold chain integrity monitoring. True for frozen, refrigerated, or temperature-sensitive pharmaceutical products.',
    `cycle_time_seconds` STRING COMMENT 'Total elapsed time in seconds from task start to completion. Key performance indicator for labor productivity and process efficiency analysis.',
    `damage_flag` BOOLEAN COMMENT 'Indicates whether damaged goods were encountered during task execution. True when product damage was identified, triggering shrink recording and disposition workflows.',
    `equipment_code` BIGINT COMMENT 'Reference to the material handling equipment used for task execution, such as forklift, pallet jack, or RF scanner device.',
    `exception_code` STRING COMMENT 'Standardized code indicating the reason for task exception or variance. Examples include location full, damaged goods, wrong item, out of stock, quantity mismatch, or label discrepancy.. Valid values are `^[A-Z0-9]{2,10}$`',
    `exception_reason` STRING COMMENT 'Detailed explanation of the exception or variance encountered during task execution. Provides context for root cause analysis and process improvement.',
    `expiration_date` DATE COMMENT 'Date after which the product should not be sold or consumed. Used for FEFO (First Expired First Out) putaway and picking logic to minimize shrink from spoilage.',
    `lot_number` STRING COMMENT 'Manufacturer batch or lot identifier for traceability and recall management. Critical for perishable goods and regulatory compliance.. Valid values are `^[A-Z0-9]{4,20}$`',
    `pick_method` STRING COMMENT 'Strategy used for pick task execution. Single pick processes one order at a time; batch pick consolidates multiple orders; cluster pick uses carts for multiple orders simultaneously; zone pick assigns associates to specific warehouse zones; wave pick groups tasks by time window.. Valid values are `single|batch|cluster|zone|wave`',
    `priority_level` STRING COMMENT 'Numeric priority ranking for task execution sequencing, with lower numbers indicating higher priority. Used by WMS to optimize task assignment and ensure time-sensitive orders are processed first.',
    `putaway_strategy` STRING COMMENT 'Logic used to determine target location for putaway tasks. Directed assigns specific slots; random uses any available location; FIFO (First In First Out) prioritizes oldest inventory; LIFO (Last In First Out) prioritizes newest; FEFO (First Expired First Out) prioritizes by expiration date; fixed location assigns dedicated slots per SKU.. Valid values are `directed|random|fifo|lifo|fefo|fixed_location`',
    `sla_target_completion_time` TIMESTAMP COMMENT 'Target timestamp by which the task must be completed to meet service level commitments. Used for on-time fulfillment tracking and carrier cutoff management.',
    `source_location` STRING COMMENT 'Origin location for putaway and replenishment tasks. For putaway, this is the receiving dock door or staging area. For replenishment, this is the reserve storage location.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `substituted_sku` STRING COMMENT 'SKU of the substitute product picked when the original item was out of stock. Used for order fulfillment accuracy tracking and customer communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether a product substitution was made during picking due to out-of-stock conditions. True when a substitute item was picked instead of the originally requested SKU.',
    `target_location` STRING COMMENT 'Destination location for putaway and replenishment tasks. For putaway, this is the assigned storage slot. For replenishment, this is the forward pick location.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `target_quantity` DECIMAL(18,2) COMMENT 'Expected quantity to be picked, put away, or counted as specified by the WMS. Measured in the items unit of measure.',
    `task_assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the task was assigned to a warehouse associate. Used to measure queue time and assignment efficiency.',
    `task_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the task was successfully completed by the associate. Used for productivity measurement and SLA compliance tracking.',
    `task_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the WMS task was generated by the system. Marks the beginning of the task lifecycle for cycle time measurement.',
    `task_method` STRING COMMENT 'Technology or interface used by the associate to receive and complete the task. Voice uses voice-directed picking; RF scanner uses handheld terminals; paper uses printed pick lists; mobile app uses smartphone applications; automated uses robotics or conveyor systems.. Valid values are `voice|rf_scanner|paper|mobile_app|automated`',
    `task_started_timestamp` TIMESTAMP COMMENT 'Timestamp when the associate began actively working on the task. Marks the transition from assigned to in-progress status.',
    `task_status` STRING COMMENT 'Current lifecycle state of the WMS task. Pending tasks await assignment; assigned tasks have been allocated to an associate; in-progress tasks are actively being worked; completed tasks are finished; cancelled tasks were aborted; exception tasks encountered issues; suspended tasks are temporarily paused. [ENUM-REF-CANDIDATE: pending|assigned|in_progress|completed|cancelled|exception|suspended — 7 candidates stripped; promote to reference product]',
    `task_type` STRING COMMENT 'Classification of the warehouse task indicating the primary operation to be performed. Pick tasks retrieve inventory for orders; putaway tasks store received goods; replenishment tasks move inventory to forward pick locations; cycle count tasks verify inventory accuracy; cross-dock tasks transfer goods without storage; returns processing tasks handle customer returns.. Valid values are `pick|putaway|replenishment|cycle_count|cross_dock|returns_processing`',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the task location and product. Ambient for room temperature; refrigerated for 32-40°F; frozen for below 0°F; pharmacy controlled for prescription medications requiring specific temperature ranges.. Valid values are `ambient|refrigerated|frozen|pharmacy_controlled`',
    `travel_distance_feet` DECIMAL(18,2) COMMENT 'Total distance traveled by the associate in feet during task execution. Used for warehouse layout optimization and labor standards development.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the quantity is expressed. Each represents individual items; case represents manufacturer cases; pallet represents full pallet quantities; inner pack represents intermediate packaging; display unit represents shelf-ready packaging.. Valid values are `each|case|pallet|inner_pack|display_unit`',
    `wms_task_number` STRING COMMENT 'Externally visible business identifier for the WMS task, used for tracking and reference across systems and by warehouse associates.. Valid values are `^[A-Z0-9]{8,20}$`',
    CONSTRAINT pk_wms_task PRIMARY KEY(`wms_task_id`)
) COMMENT 'Unified warehouse management system task representing any directed work assignment within a DC, MFC, or store backroom — including picking, putaway, replenishment, and cycle count tasks. For pick tasks: tracks task type (single, batch, cluster, zone), assigned associate, pick location (aisle, bay, level, bin), target quantity, actual quantity picked, pick method (voice, RF, paper), start and completion timestamps, exception reason (OOS, damaged, substituted), and WMS task ID. For putaway tasks: tracks task type (directed, random, cross-dock), source location (dock door, staging area), target slot location, SKU/UPC, quantity, lot number, expiration date, putaway method (FIFO, LIFO, FEFO), assigned associate, and exception code (location full, damaged goods, wrong item). All task types share common attributes: task status, priority, wave reference, facility zone, and completion metrics.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`pack_task` (
    `pack_task_id` BIGINT COMMENT 'Unique identifier for the pack task record. Primary key.',
    `node_id` BIGINT COMMENT 'Reference to the distribution center, micro-fulfillment center, or store backroom where packing occurred. Used for location-based performance analysis.',
    `order_header_id` BIGINT COMMENT 'Reference to the customer order being packed. Links to the originating order for traceability and fulfillment tracking.',
    `associate_id` BIGINT COMMENT 'Reference to the warehouse associate who performed the packing task. Used for labor tracking and productivity analysis.',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Supports Packing Accuracy Audit by linking each pack task to the specific order line being packed.',
    `tote_id` BIGINT COMMENT 'Identifier of the tote or container used during picking that is now being packed. Tracks the physical container through the fulfillment workflow.',
    `wave_id` BIGINT COMMENT 'Reference to the fulfillment wave that generated this pack task. Links to the wave planning and batch orchestration process.',
    `carrier_code` STRING COMMENT 'Code identifying the shipping carrier assigned to transport this packed order. Links to carrier master data for routing and delivery management.',
    `cold_chain_flag` STRING COMMENT 'Temperature control classification for the packed items. Critical for maintaining food safety and quality during fulfillment and delivery.. Valid values are `ambient|refrigerated|frozen`',
    `container_dimensions` STRING COMMENT 'Physical dimensions of the packed container in format length x width x height (cm). Used for carrier selection and vehicle load optimization.',
    `container_type` STRING COMMENT 'Type of container or packaging used for packing the order items. Determines handling requirements and shipping method compatibility.. Valid values are `bag|box|tote|cooler_bag|insulated_box|crate`',
    `container_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the packed container in kilograms including items and packaging. Used for carrier selection, freight calculation, and load planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the pack task record was created in the system. Used for audit trail and data lineage tracking.',
    `gift_message_flag` BOOLEAN COMMENT 'Indicates whether a gift message was included in this packed order. Requires special handling during packing process.',
    `label_print_timestamp` TIMESTAMP COMMENT 'Date and time when the shipping label was printed. Used for tracking label generation and shipment preparation timing.',
    `label_printed_flag` BOOLEAN COMMENT 'Indicates whether the shipping label was successfully printed for this pack task. Required for shipment readiness verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the pack task record was last updated. Used for audit trail and change tracking.',
    `pack_duration_seconds` STRING COMMENT 'Total time in seconds taken to complete the pack task. Key performance indicator for labor efficiency and process optimization.',
    `pack_end_timestamp` TIMESTAMP COMMENT 'Date and time when the packing task was completed. Used to calculate pack duration and throughput metrics.',
    `pack_exception_code` STRING COMMENT 'Code identifying any exception or issue encountered during packing (e.g., damaged item, missing item, wrong item). Used for exception management and root cause analysis. [ENUM-REF-CANDIDATE: damaged_item|missing_item|wrong_item|quantity_mismatch|container_shortage|label_error|system_error — promote to reference product]',
    `pack_exception_notes` STRING COMMENT 'Free-text notes describing the pack exception or special handling instructions. Provides context for exception resolution and quality improvement.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Date and time when the packing task was started by the associate. Used for labor productivity analysis and SLA tracking.',
    `pack_station_code` STRING COMMENT 'Identifier of the physical pack station or workstation where the packing activity occurred. Used for capacity planning and performance tracking.',
    `pack_task_number` STRING COMMENT 'Human-readable business identifier for the pack task. Used for operational tracking and communication.',
    `pack_task_status` STRING COMMENT 'Current lifecycle status of the pack task. Tracks progression through the packing workflow from assignment to completion or exception handling.. Valid values are `assigned|in_progress|completed|exception|cancelled`',
    `packed_item_count` STRING COMMENT 'Total number of individual items packed into the container for this task. Used for quality control verification and productivity metrics.',
    `packed_unit_count` STRING COMMENT 'Total number of units (quantity) packed across all items. Distinguishes between line count and total quantity for bulk items.',
    `qc_check_status` STRING COMMENT 'Status of quality control inspection for this pack task. Indicates whether the packed order passed quality verification before shipment.. Valid values are `not_required|pending|passed|failed`',
    `qc_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control check was performed. Used for compliance reporting and process timing analysis.',
    `service_level_code` STRING COMMENT 'Code identifying the shipping service level (e.g., same-day, next-day, standard). Determines delivery speed and cost.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the pack task was completed within the SLA target time. Key metric for operational performance and customer satisfaction.',
    `sla_target_pack_time` TIMESTAMP COMMENT 'Target completion timestamp for this pack task based on order SLA and delivery commitments. Used for on-time performance tracking.',
    `special_handling_code` STRING COMMENT 'Code identifying any special handling requirements for this pack task (e.g., fragile, hazmat, gift wrap, alcohol verification). Ensures proper handling and compliance.',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether any items in this pack task were substituted due to out-of-stock conditions. Impacts customer satisfaction and requires communication.',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the packed shipment. Enables end-to-end shipment visibility and customer communication.',
    CONSTRAINT pk_pack_task PRIMARY KEY(`pack_task_id`)
) COMMENT 'Pack task record capturing the packing of picked items into containers or bags for a specific order or tote. Tracks pack station ID, packer associate, container type (bag, box, tote, cooler bag), cold chain flag (ambient, refrigerated, frozen), packed item count, pack start and end timestamps, label printed flag, pack exception codes, and QC check status. Linked to the originating wave and order.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the driver assigned to deliver this shipment for last-mile delivery or internal fleet operations.',
    `carrier_id` BIGINT COMMENT 'FK to fulfillment.carrier',
    `node_id` BIGINT COMMENT 'Identifier of the facility or customer address to which the shipment is being delivered.',
    `food_safety_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.food_safety_violation. Business justification: Food safety incident reporting requires each shipment that triggers a violation to be linked to the violation record for traceability, recall, and regulatory reporting.',
    `fulfillment_delivery_route_id` BIGINT COMMENT 'Reference to the optimized delivery route that includes this shipment, used for last-mile delivery planning and driver dispatch.',
    `order_header_id` BIGINT COMMENT 'Reference to the originating order that this shipment fulfills. Links shipment to customer order or replenishment order.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Shipment cost allocation and reporting need the promo_campaign that generated the shipment for financial reconciliation.',
    `shipment_fulfillment_node_id` BIGINT COMMENT 'Identifier of the facility (DC, MFC, or store) from which the shipment originates.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Needed for Store Receiving and Inventory Reconciliation report, associating each inbound shipment with the destination store for receiving, inventory updates, and compliance reporting.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle (truck, van, or delivery vehicle) used to transport this shipment.',
    `wave_id` BIGINT COMMENT 'Reference to the warehouse wave planning batch that this shipment was assigned to for picking and packing optimization.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment was successfully delivered to the destination and accepted by the recipient.',
    `actual_ship_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment departed the origin facility and was handed to the carrier.',
    `bill_of_lading_number` STRING COMMENT 'Legal document number issued by the carrier acknowledging receipt of cargo for shipment. Required for freight shipments.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this shipment contains temperature-sensitive perishable goods requiring refrigerated or frozen transportation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was first created in the system, marking the start of the fulfillment lifecycle.',
    `delivery_attempt_count` STRING COMMENT 'Number of delivery attempts made by the carrier before successful delivery or final failure. Used for last-mile delivery performance analysis.',
    `delivery_instructions` STRING COMMENT 'Special instructions provided by the customer or receiving location for delivery (e.g., gate code, leave at door, call upon arrival).',
    `delivery_outcome` STRING COMMENT 'Final result of the delivery attempt. Delivered indicates successful handoff, failed outcomes require follow-up, returned indicates shipment sent back to origin. [ENUM-REF-CANDIDATE: delivered|failed_no_access|failed_refused|failed_damaged|returned_to_sender|left_at_door|left_with_neighbor — 7 candidates stripped; promote to reference product]',
    `destination_location_type` STRING COMMENT 'Classification of the destination type. Customer address for last-mile delivery, store for replenishment, DC for inter-facility transfer.. Valid values are `customer_address|store|distribution_center|vendor`',
    `estimated_delivery_timestamp` TIMESTAMP COMMENT 'Carrier-provided estimated time of arrival at the destination, updated in real-time during transit.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total transportation cost charged by the carrier for this shipment, used for freight audit and cost allocation.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this shipment contains hazardous materials requiring special handling, labeling, and carrier certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the shipment record was last updated, used for change tracking and data synchronization.',
    `max_temperature_f` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Fahrenheit for cold chain shipments. Violations trigger quality alerts and potential product rejection.',
    `min_temperature_f` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Fahrenheit for cold chain shipments. Violations trigger quality alerts and potential product rejection.',
    `origin_location_type` STRING COMMENT 'Classification of the origin facility type. DC is large regional distribution center, MFC is micro-fulfillment center for rapid local delivery, store is retail location fulfilling online orders.. Valid values are `distribution_center|micro_fulfillment_center|store|vendor`',
    `package_count` STRING COMMENT 'Total number of individual packages, cartons, or pallets included in this shipment.',
    `pro_number` STRING COMMENT 'Freight bill number assigned by the carrier for less-than-truckload (LTL) shipments, used for tracking and billing.',
    `proof_of_delivery_photo_captured_flag` BOOLEAN COMMENT 'Indicates whether a photo of the delivered shipment was captured at the delivery location as proof of delivery.',
    `proof_of_delivery_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether a customer signature was captured at delivery as proof of receipt.',
    `scheduled_delivery_date` DATE COMMENT 'Planned delivery date committed to the customer or receiving location, used for SLA tracking.',
    `scheduled_ship_date` DATE COMMENT 'Planned date when the shipment is scheduled to leave the origin facility, based on wave planning and carrier pickup schedule.',
    `shipment_number` STRING COMMENT 'Externally-visible business identifier for the shipment, used for tracking and customer communication.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment in the fulfillment workflow. Tracks progression from creation through final delivery or exception resolution. [ENUM-REF-CANDIDATE: created|wave_assigned|picked|packed|staged|loaded|in_transit|out_for_delivery|delivered|failed|returned|cancelled — 12 candidates stripped; promote to reference product]',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on its purpose and destination type. Last-mile delivery serves end customers, store replenishment moves inventory from DC to stores, inter-DC transfer moves goods between distribution centers, DSD is direct vendor delivery to stores.. Valid values are `last_mile_delivery|store_replenishment|inter_dc_transfer|vendor_return|customer_return|direct_store_delivery`',
    `stop_sequence_number` STRING COMMENT 'Order of this delivery stop within the assigned route. Used for route optimization and driver navigation.',
    `temperature_zone` STRING COMMENT 'Required temperature control zone for the shipment. Ambient is room temperature, refrigerated is 32-40°F, frozen is 0-32°F, deep frozen is below 0°F.. Valid values are `ambient|refrigerated|frozen|deep_frozen`',
    `total_volume_cubic_ft` DECIMAL(18,2) COMMENT 'Total cubic volume of the shipment in cubic feet, used for truck loading optimization and dimensional weight calculations.',
    `total_weight_lbs` DECIMAL(18,2) COMMENT 'Total physical weight of the shipment in pounds, including all items and packaging materials. Used for carrier rating and capacity planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier used for shipment visibility and customer tracking queries.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Outbound shipment record representing the complete lifecycle of a physical dispatch of goods from a DC, MFC, or store to a customer or store location. Header: shipment type (last-mile, store replenishment, inter-DC transfer), carrier SCAC, tracking number, BOL, ship/delivery dates, weight, volume, cold chain requirements, temperature range, and status. Line detail: each SKU in the shipment with GTIN/UPC, quantities (ordered vs shipped), lot number, expiration date, temperature zone, FIFO flag, unit of measure, and exception codes (short-shipped, substituted, damaged). Last-mile dispatch: driver ID, vehicle ID, delivery route reference, ETA, actual delivery timestamp, delivery attempt count, outcome (delivered, failed, returned), proof-of-delivery (signature, photo, PIN), customer signature captured flag, and LMD carrier name (Instacart, DoorDash, internal fleet). Consolidates the full shipment lifecycle from creation through line-level fulfillment and last-mile delivery completion.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` (
    `pickup_staging_id` BIGINT COMMENT 'Unique identifier for the pickup staging record. Primary key for the pickup staging entity.',
    `member_offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.member_offer. Business justification: Supports In‑Store Pickup Offer Redemption tracking, a business rule that records which member offer was applied at the pickup stage.',
    `order_header_id` BIGINT COMMENT 'Reference to the customer order being staged for pickup. Links to the omnichannel order that is being fulfilled via BOPIS (Buy Online Pickup In Store) or curbside pickup.',
    `associate_id` BIGINT COMMENT 'Reference to the store associate who staged the order for pickup. Used for performance tracking and accountability.',
    `primary_pickup_handoff_associate_id` BIGINT COMMENT 'Reference to the store associate who delivered the order to the customer. Used for performance tracking and customer service quality measurement.',
    `rx_patient_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_patient. Business justification: Supports in‑store prescription pickup audit: linking the staged order to the patient record for verification, HIPAA compliance, and refill eligibility checks.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who placed the pickup order. Links to the shopper profile for loyalty and personalization.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the pickup is staged. Identifies the physical retail location fulfilling the pickup order.',
    `age_verified_flag` BOOLEAN COMMENT 'Indicates whether customer age was verified for restricted items (alcohol, tobacco, pharmacy). Required for regulatory compliance.',
    `alcohol_verification_required_flag` BOOLEAN COMMENT 'Indicates whether the order contains alcohol and requires age verification at handoff. Ensures compliance with state and federal alcohol sales regulations.',
    `check_in_method` STRING COMMENT 'Channel or method used by the customer to notify the store of their arrival for pickup. Tracks customer preference and digital adoption.. Valid values are `mobile_app|text_message|kiosk|phone_call|walk_in`',
    `cold_chain_tote_count` STRING COMMENT 'Number of temperature-controlled totes containing perishable items (frozen, refrigerated, fresh produce). Critical for food safety and cold chain integrity compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the pickup staging record was first created in the system. Audit trail for record creation.',
    `customer_arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the customer arrived at the store or checked in for pickup. Used to calculate customer wait time and handoff speed.',
    `customer_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether customer signature or digital acknowledgment was captured at handoff. Used for proof of delivery and dispute resolution.',
    `customer_wait_time_minutes` STRING COMMENT 'Calculated time in minutes between customer arrival and order handoff. Key performance indicator for curbside and BOPIS service quality and NPS impact.',
    `handoff_timestamp` TIMESTAMP COMMENT 'Date and time when the order was physically handed off to the customer. Marks completion of the pickup fulfillment process and is a key NPS (Net Promoter Score) driver.',
    `loyalty_member_flag` BOOLEAN COMMENT 'Indicates whether the customer is an active loyalty program member. Used for personalized service and loyalty point accrual.',
    `order_ready_timestamp` TIMESTAMP COMMENT 'Date and time when the order was fully staged and marked ready for customer pickup. Critical SLA (Service Level Agreement) metric for BOPIS fulfillment speed.',
    `parking_spot_number` STRING COMMENT 'Designated curbside parking spot number where the customer is waiting. Used for efficient order delivery to the correct vehicle.',
    `payment_method` STRING COMMENT 'Payment instrument used for the pickup order. Tracks payment type for financial reconciliation and tender mix analysis. [ENUM-REF-CANDIDATE: credit_card|debit_card|ebt|snap|wic|gift_card|store_credit|cash — 8 candidates stripped; promote to reference product]',
    `prescription_included_flag` BOOLEAN COMMENT 'Indicates whether the order includes pharmacy prescription items. Requires special handling and HIPAA compliance for patient privacy.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the staging SLA target was achieved. Key metric for operational performance and customer experience.',
    `sla_target_minutes` STRING COMMENT 'Target time in minutes for order staging completion from the time the order is assigned. Defines the service level commitment for pickup readiness.',
    `special_handling_instructions` STRING COMMENT 'Special instructions for staging or handoff (e.g., fragile items, customer accessibility needs, contactless delivery). Ensures proper care and customer accommodation.',
    `staging_bay_number` STRING COMMENT 'Physical staging bay or holding area identifier where the order is placed for customer pickup. Used for curbside parking spot or in-store pickup zone designation.',
    `staging_duration_minutes` STRING COMMENT 'Calculated time in minutes from staging start to order ready. Measures staging efficiency and associate productivity.',
    `staging_exception_notes` STRING COMMENT 'Free-text notes describing the staging exception or issue. Provides context for operational review and customer service follow-up.',
    `staging_exception_type` STRING COMMENT 'Type of exception or issue encountered during the staging or handoff process. Used for root cause analysis and process improvement.. Valid values are `missing_item|wrong_item|damaged_item|late_staging|customer_no_show|order_cancelled`',
    `staging_start_timestamp` TIMESTAMP COMMENT 'Date and time when the staging associate began preparing the order for pickup. Marks the beginning of the staging workflow.',
    `staging_status` STRING COMMENT 'Current lifecycle status of the pickup staging process. Tracks progression from initial staging through customer handoff.. Valid values are `pending|in_progress|ready|handed_off|cancelled|exception`',
    `substitution_count` STRING COMMENT 'Number of items in the order that were substituted due to out-of-stock (OOS) conditions. Impacts customer satisfaction and requires customer approval.',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether cold chain temperature requirements were maintained throughout staging. Critical for food safety and HACCP compliance.',
    `tote_count` STRING COMMENT 'Total number of totes or containers used to stage the order. Indicates order size and complexity for staging logistics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the pickup staging record was last modified. Audit trail for record changes and status updates.',
    `vehicle_description` STRING COMMENT 'Description of the customer vehicle for curbside pickup identification (make, model, color). Helps associates quickly locate the customer in the parking lot.',
    CONSTRAINT pk_pickup_staging PRIMARY KEY(`pickup_staging_id`)
) COMMENT 'Curbside and click-and-collect pickup staging record tracking the readiness and handoff of a customer order at a store pickup location. Captures order ready timestamp, staging bay number, tote count, cold chain tote count, customer arrival timestamp, staging associate, customer check-in method (app, text, kiosk), handoff timestamp, handoff associate, and staging exception (missing item, wrong order, late staging). Pickup staging is the final fulfillment touchpoint for BOPIS/curbside orders — staging time and handoff speed directly impact customer NPS.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` (
    `fulfillment_order_id` BIGINT COMMENT 'Unique identifier for the fulfillment order. This is the primary key for the fulfillment domain representation of an order released for physical execution.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier assigned to deliver this fulfillment order for home delivery or ship-to-store scenarios. Maps to the carrier master data in the transportation management system.',
    `node_id` BIGINT COMMENT 'Identifier of the specific facility (distribution center, micro-fulfillment center, or store) responsible for executing this fulfillment order. Maps to the facility master data.',
    `order_header_id` BIGINT COMMENT 'Reference to the commercial order in the order domain that originated this fulfillment order. Links the fulfillment execution back to the customer-facing order.',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Required for Prescription Order Fulfillment process: each fulfillment order must reference the originating prescription for compliance and patient tracking.',
    `associate_id` BIGINT COMMENT 'Identifier of the warehouse associate who performed the picking operations for this fulfillment order. Used for productivity tracking and quality accountability.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: Order‑level promotion attribution is required for margin analysis and rebate calculations.',
    `store_location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Required for Store Pickup Fulfillment Order Assignment report, linking each fulfillment order to the store that fulfills the in‑store pickup, enabling inventory allocation and SLA tracking.',
    `wave_id` BIGINT COMMENT 'Identifier of the pick wave to which this fulfillment order has been assigned. Wave planning groups orders for efficient batch picking and resource optimization in the warehouse.',
    `alcohol_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order contains alcoholic beverages requiring age verification at delivery and compliance with state alcohol shipping regulations. True if alcohol is present, false otherwise.',
    `cancellation_reason` STRING COMMENT 'The reason why this fulfillment order was cancelled. Customer request for customer-initiated cancellation, inventory unavailable for stockout after release, address issue for undeliverable address, payment failure for payment authorization problems, fraud detected for suspected fraudulent orders, system error for technical failures.. Valid values are `customer_request|inventory_unavailable|address_issue|payment_failure|fraud_detected|system_error`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when this fulfillment order was cancelled. Applicable when the order is cancelled after release to fulfillment but before completion.',
    `carrier_service_level` STRING COMMENT 'The transportation service level selected for this fulfillment order delivery. Same-day for ultra-fast delivery, next-day for overnight service, two-day for expedited service, standard for 3-5 day ground, economy for 5-7 day low-cost delivery.. Valid values are `same_day|next_day|two_day|standard|economy`',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order contains temperature-sensitive perishable items requiring cold chain integrity throughout pick, pack, and delivery. True if cold chain handling is required, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fulfillment order record was first created in the fulfillment system. Represents the initial receipt of the order from the order management system.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when this fulfillment order was successfully delivered to the customer or confirmed as picked up by the customer. Marks the completion of the end-to-end fulfillment process.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'The date and time when this fulfillment order was dispatched from the fulfillment node and handed over to the carrier or made available for customer pickup. Marks the completion of warehouse operations.',
    `exception_code` STRING COMMENT 'Code identifying the type of fulfillment exception or issue encountered during order execution. Examples include damaged inventory, address validation failure, delivery attempt failure, or customer unavailable. Used for exception management and root cause analysis.',
    `exception_notes` STRING COMMENT 'Free-text notes describing the fulfillment exception or issue in detail. Provides context for exception resolution and customer service follow-up.',
    `fulfillment_channel` STRING COMMENT 'The physical fulfillment channel through which this order is being executed. DC (Distribution Center) for traditional warehouse fulfillment, MFC (Micro-Fulfillment Center) for automated urban fulfillment, store backroom for in-store pickup or local delivery, DSD (Direct Store Delivery) for vendor-managed delivery, cross-dock for transfer without storage, or vendor direct for drop-ship scenarios.. Valid values are `dc|mfc|store_backroom|dsd|cross_dock|vendor_direct`',
    `fulfillment_order_number` STRING COMMENT 'Human-readable business identifier for the fulfillment order, used for tracking and operational reference across warehouse management systems and transportation systems.. Valid values are `^FO[0-9]{10}$`',
    `fulfillment_status` STRING COMMENT 'Current lifecycle status of the fulfillment order in the warehouse management system workflow. Received indicates order accepted by WMS, waving indicates wave planning in progress, picking indicates active pick task execution, packing indicates items being packed, staged indicates ready for dispatch, dispatched indicates handed to carrier, in-transit indicates en route to customer, delivered indicates successful delivery, completed indicates fulfillment closed, cancelled indicates order cancelled, exception indicates fulfillment issue requiring intervention. [ENUM-REF-CANDIDATE: received|waving|picking|packing|staged|dispatched|in_transit|delivered|completed|cancelled|exception — 11 candidates stripped; promote to reference product]',
    `fulfillment_type` STRING COMMENT 'The method by which the order will be delivered to the customer. Home delivery for last-mile delivery to customer address, curbside pickup for click-and-collect at store parking, in-store pickup for customer collection inside store, ship-to-store for transfer to another location, or locker pickup for automated pickup point.. Valid values are `home_delivery|curbside_pickup|in_store_pickup|ship_to_store|locker_pickup`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order contains hazardous materials requiring special handling, packaging, labeling, and transportation compliance. True if hazmat items are present, false otherwise.',
    `oms_release_timestamp` TIMESTAMP COMMENT 'The date and time when the order management system released this order to the fulfillment domain for physical execution. Marks the handoff from order orchestration to warehouse operations.',
    `pack_complete_timestamp` TIMESTAMP COMMENT 'The date and time when packing operations were completed for this fulfillment order. Marks the order as ready for staging and dispatch.',
    `package_count` STRING COMMENT 'The number of physical packages or parcels into which this fulfillment order was packed for shipment. Used for shipping cost calculation and carrier manifest generation.',
    `pick_complete_timestamp` TIMESTAMP COMMENT 'The date and time when all picking tasks for this fulfillment order were completed. Used for pick cycle time calculation and throughput analysis.',
    `pick_start_timestamp` TIMESTAMP COMMENT 'The date and time when picking operations began for this fulfillment order in the warehouse. Used for cycle time analysis and picker productivity measurement.',
    `prescription_flag` BOOLEAN COMMENT 'Indicates whether this fulfillment order contains prescription medications requiring pharmacy fulfillment, HIPAA-compliant handling, and controlled substance tracking. True if prescriptions are included, false otherwise.',
    `priority_code` STRING COMMENT 'The fulfillment priority level assigned to this order based on SLA requirements, customer tier, order value, or business rules. Urgent for same-day or critical orders, high for premium customers or tight SLAs, standard for regular fulfillment, low for backorders or flexible delivery windows.. Valid values are `urgent|high|standard|low`',
    `short_pick_count` STRING COMMENT 'The number of line items in this fulfillment order where the picked quantity was less than the ordered quantity due to inventory discrepancies or stockouts. Used for fill rate calculation and inventory accuracy tracking.',
    `sla_due_timestamp` TIMESTAMP COMMENT 'The target date and time by which this fulfillment order must be completed to meet the customer promise and service level agreement. Used for SLA compliance tracking and priority sequencing in wave planning.',
    `special_instructions` STRING COMMENT 'Customer-provided or system-generated special handling instructions for this fulfillment order. Examples include delivery instructions, gift wrapping requests, or handling precautions.',
    `substitution_count` STRING COMMENT 'The number of line items in this fulfillment order where a substitute product was picked due to out-of-stock conditions on the originally ordered item. Used for substitution rate analytics and customer experience tracking.',
    `temperature_zone` STRING COMMENT 'The temperature control requirement for this fulfillment order. Ambient for shelf-stable products, chilled for refrigerated items (0-4°C), frozen for frozen products (-18°C or below), multi-temp for orders containing items across multiple temperature zones requiring specialized handling.. Valid values are `ambient|chilled|frozen|multi_temp`',
    `total_line_count` STRING COMMENT 'The total number of distinct line items (SKUs) in this fulfillment order. Used for complexity assessment, wave planning, and picker productivity analysis.',
    `total_unit_count` STRING COMMENT 'The total number of individual units (eaches) across all line items in this fulfillment order. Represents the total pick quantity for the order.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'The total cubic volume of all items in this fulfillment order measured in cubic meters. Used for capacity planning, vehicle loading optimization, and dimensional weight calculations.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total weight of all items in this fulfillment order measured in kilograms. Used for carrier selection, freight cost calculation, and load planning.',
    `tracking_number` STRING COMMENT 'The carrier-provided tracking number for this fulfillment order shipment. Used for customer shipment visibility and delivery status tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this fulfillment order record was last modified. Used for change tracking and data synchronization across systems.',
    CONSTRAINT pk_fulfillment_order PRIMARY KEY(`fulfillment_order_id`)
) COMMENT 'Fulfillment-domain representation of an order released for physical execution, distinct from the commercial order in the order domain. Captures fulfillment order number, source order reference, fulfillment channel (DC, MFC, store backroom, DSD), fulfillment node (facility ID), fulfillment type (delivery, pickup, ship-to-store), SLA due timestamp, fulfillment status (received, waving, picking, packing, staged, dispatched, completed, cancelled), substitution count, and OMS release timestamp. Fill rate is computed from order_line picked vs ordered quantities rather than stored as a static attribute.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` (
    `fulfillment_order_line_id` BIGINT COMMENT 'Unique identifier for the fulfillment order line. Primary key for this entity.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to assortment.assortment_item. Business justification: ASSORTMENT VERIFICATION: Order‑line fulfillment is validated against the specific assortment item (SKU, store cluster, planogram) to ensure correct placement and inventory allocation.',
    `category_id` BIGINT COMMENT 'Foreign key linking to assortment.category. Business justification: CATEGORY COMPLIANCE: Picking and packing must verify perishable/organic category rules; reports require linking each order line to its category for temperature and handling compliance.',
    `drug_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug. Business justification: Needed for Inventory Reconciliation and regulatory reporting: line items must link to the master drug record to verify NDC, dosage, and controlled‑substance status.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order header. Links this line to the overall order being fulfilled.',
    `associate_id` BIGINT COMMENT 'Identifier of the warehouse or store associate assigned to pick this line. Used for labor tracking and accountability.',
    `product_order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Required for Fulfillment Line Allocation Report linking each order line to its fulfillment order line for pick/pack tracking.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Line‑level offer redemption tracking enables detailed discount impact and GMROI reporting.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Order‑line fulfillment must reference the SKU to drive picking, pricing, and inventory deduction in the fulfillment workflow.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Order line allocation uses a specific stock position to fulfill items, essential for the Order Allocation process and audit of pick locations.',
    `wave_id` BIGINT COMMENT 'Identifier for the picking wave this line is assigned to. Groups lines for efficient batch picking operations.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity allocated from inventory for this line. May differ from ordered quantity based on inventory availability.',
    `cancel_reason_code` STRING COMMENT 'Reason code if this line was cancelled during fulfillment. OOS indicates out of stock condition.. Valid values are `oos|damaged|expired|customer_request|system_error|other`',
    `carton_code` STRING COMMENT 'Identifier of the shipping carton or tote this line was packed into. Links line to physical container for tracking.',
    `cold_chain_zone` STRING COMMENT 'Temperature control zone required for this item during fulfillment and delivery. Critical for food safety and quality.. Valid values are `ambient|refrigerated|frozen`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment order line record was created in the system. Audit trail for record creation.',
    `expiration_date` DATE COMMENT 'Expiration or best-by date of the picked item. Ensures FIFO compliance and food safety for perishable goods.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this item is classified as hazardous material requiring special handling and shipping compliance.',
    `item_description` STRING COMMENT 'Human-readable description of the item being fulfilled. Includes brand, size, and key product attributes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment order line record was last updated. Audit trail for tracking changes.',
    `line_number` STRING COMMENT 'Sequential line number within the fulfillment order. Used for ordering and referencing specific lines.',
    `line_status` STRING COMMENT 'Current status of the fulfillment order line in the pick-pack-ship workflow. OOS indicates out of stock condition. [ENUM-REF-CANDIDATE: open|allocated|picking|picked|packing|packed|staged|shipped|delivered|cancelled|oos|substituted|short_picked — promote to reference product]',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total amount for this line calculated as picked quantity times unit price. Excludes taxes and fees.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the picked item. Critical for traceability and recall management.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item originally ordered by the customer. Represents the customer demand for this line.',
    `pack_timestamp` TIMESTAMP COMMENT 'Timestamp when this line was packed into shipping containers. Marks completion of fulfillment processing.',
    `packed_quantity` DECIMAL(18,2) COMMENT 'Quantity packed into shipping containers or bags. Final quantity prepared for delivery or pickup.',
    `pick_complete_timestamp` TIMESTAMP COMMENT 'Timestamp when picking was completed for this line. Used to calculate pick time and throughput metrics.',
    `pick_location` STRING COMMENT 'Warehouse or store location where the item should be picked from. Includes aisle, bay, shelf, and bin coordinates from WMS.',
    `pick_start_timestamp` TIMESTAMP COMMENT 'Timestamp when picking began for this line. Used for labor productivity analysis and SLA tracking.',
    `pick_zone` STRING COMMENT 'Logical zone within the fulfillment facility assigned for picking this item. Used for wave planning and task assignment.',
    `picked_quantity` DECIMAL(18,2) COMMENT 'Actual quantity picked by warehouse or store associate. Reflects what was physically retrieved from inventory.',
    `short_pick_reason` STRING COMMENT 'Explanation for why the picked quantity was less than the allocated quantity. Used for inventory accuracy analysis.',
    `special_handling_instructions` STRING COMMENT 'Special instructions for picking, packing, or handling this item. May include fragile, keep upright, or temperature requirements.',
    `substitute_sku` STRING COMMENT 'SKU of the substitute item picked when the original item was out of stock. Null if no substitution occurred.. Valid values are `^[A-Z0-9]{6,20}$`',
    `substitute_upc` STRING COMMENT 'UPC of the substitute item picked. Null if no substitution occurred.. Valid values are `^[0-9]{12}$`',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the customer has allowed product substitutions for this line if the original item is out of stock.',
    `substitution_made_flag` BOOLEAN COMMENT 'Indicates whether a product substitution was actually made during fulfillment due to out of stock condition.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the item quantity. Defines how the item is counted or weighed during fulfillment.. Valid values are `each|case|pound|kilogram|ounce|liter`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit for this line item at the time of fulfillment. Used for order pricing and invoicing.',
    `weight_actual` DECIMAL(18,2) COMMENT 'Actual weight of the picked item in pounds. Captured for variable-weight items like produce and meat.',
    CONSTRAINT pk_fulfillment_order_line PRIMARY KEY(`fulfillment_order_line_id`)
) COMMENT 'Line-level detail of a fulfillment order representing each SKU to be picked and packed. Tracks UPC, GTIN, PLU (for produce), item description, ordered quantity, allocated quantity, picked quantity, packed quantity, unit of measure, substitution flag, substitute UPC, cold chain zone (ambient, refrigerated, frozen), line status (open, picked, substituted, cancelled, OOS), and pick location assigned.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Primary key for carrier',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Carriers must meet compliance program requirements (e.g., hazardous‑material handling); linking records which program a carrier is certified under for compliance monitoring.',
    `api_integration_flag` BOOLEAN COMMENT 'Indicates whether the carrier provides API connectivity for real-time rate quotes, shipment booking, and tracking.',
    `average_transit_time_days` DECIMAL(18,2) COMMENT 'Mean number of days from shipment pickup to delivery across all service levels for this carrier.',
    `carrier_name` STRING COMMENT 'Legal business name of the carrier or delivery service provider.',
    `carrier_status` STRING COMMENT 'Current operational status of the carrier relationship in the fulfillment network.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `carrier_type` STRING COMMENT 'Classification of carrier based on service model: parcel (small package), LTL (Less Than Truckload), FTL (Full Truckload), last-mile (final delivery leg), gig-economy (on-demand platform), or courier (express delivery).. Valid values are `parcel|ltl|ftl|last_mile|gig_economy|courier`',
    `cold_chain_certified_flag` BOOLEAN COMMENT 'Indicates whether the carrier is certified to handle temperature-controlled shipments for perishable goods and pharmacy products, maintaining cold chain integrity per HACCP standards.',
    `contract_effective_date` DATE COMMENT 'Date when the carrier service contract becomes active and rates/terms take effect.',
    `contract_expiration_date` DATE COMMENT 'Date when the carrier service contract expires and requires renewal or renegotiation.',
    `contract_reference_number` STRING COMMENT 'Reference identifier for the master service agreement or transportation contract governing the carrier relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier record was first created in the system.',
    `damage_claim_rate_percent` DECIMAL(18,2) COMMENT 'Historical performance metric representing the percentage of shipments resulting in damage claims or loss incidents.',
    `dot_number` STRING COMMENT 'Unique identifier assigned by the U.S. Department of Transportation to carriers operating commercial motor vehicles, required for regulatory compliance and safety monitoring.',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the carrier supports EDI integration for automated shipment notifications, tracking updates, and invoicing.',
    `fuel_surcharge_applicable_flag` BOOLEAN COMMENT 'Indicates whether the carrier applies variable fuel surcharges to shipment costs based on market fuel prices.',
    `geographic_coverage_zones` STRING COMMENT 'Comma-separated list of geographic zones or regions where this carrier operates (e.g., Northeast, West Coast, National, International).',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the carrier is certified to transport hazardous materials in compliance with DOT and EPA regulations.',
    `headquarters_address_line1` STRING COMMENT 'First line of the carriers corporate headquarters street address.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the carriers corporate headquarters street address (suite, floor, building).',
    `headquarters_city` STRING COMMENT 'City where the carriers corporate headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the carriers headquarters location.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code of the carriers corporate headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State or province where the carriers corporate headquarters is located.',
    `insurance_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cargo insurance coverage amount (in USD) provided by the carrier per shipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier record was most recently updated.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent carrier performance evaluation and scorecard review.',
    `mc_number` STRING COMMENT 'Operating authority number issued by the Federal Motor Carrier Safety Administration (FMCSA) for interstate commerce carriers.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or carrier-specific requirements.',
    `on_time_delivery_rate_percent` DECIMAL(18,2) COMMENT 'Historical performance metric representing the percentage of shipments delivered within the committed service level agreement (SLA) window.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for carrier invoices (e.g., Net 30, Net 45, prepaid, collect).',
    `preferred_carrier_tier` STRING COMMENT 'Internal classification indicating carrier preference level for routing decisions: tier_1 (primary preferred), tier_2 (secondary), tier_3 (tertiary), backup (emergency use only).. Valid values are `tier_1|tier_2|tier_3|backup`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary carrier contact for operational communications and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary account representative or contact person at the carrier organization.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary carrier contact for urgent operational matters.',
    `scac_code` STRING COMMENT 'Four-letter unique identifier assigned by the National Motor Freight Traffic Association (NMFTA) for transportation companies.. Valid values are `^[A-Z]{2,4}$`',
    `service_level_offered` STRING COMMENT 'Comma-separated list of delivery service levels this carrier provides (e.g., same-day, next-day, two-day, standard, economy).',
    `tracking_url_template` STRING COMMENT 'URL template for customer shipment tracking, with placeholder for tracking number substitution (e.g., https://carrier.com/track?id={TRACKING_NUMBER}).',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record of carriers and delivery service providers used for outbound shipments and last-mile delivery. Captures carrier name, SCAC code, carrier type (parcel, LTL, FTL, last-mile, gig-economy), service levels offered, geographic coverage zones, EDI capability flag, API integration flag, cold chain certified flag, insurance limit, preferred carrier tier, and contract reference. Sourced from JDA TMS carrier master.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` (
    `fulfillment_delivery_route_id` BIGINT COMMENT 'Unique identifier for the delivery route. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the driver assigned to execute this delivery route.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier responsible for executing this route, applicable for third-party Last Mile Delivery (LMD) providers.',
    `node_id` BIGINT COMMENT 'Identifier of the originating facility (Distribution Center, Micro-Fulfillment Center, or store) from which this route departs.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle assigned to this delivery route.',
    `wave_id` BIGINT COMMENT 'Identifier of the warehouse wave planning batch that generated the orders for this route.',
    `actual_distance_miles` DECIMAL(18,2) COMMENT 'Actual distance traveled for the route measured in miles, captured from vehicle telematics or driver reporting.',
    `actual_duration_minutes` STRING COMMENT 'Actual total duration taken to complete the route in minutes, measured from start to end time.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual time the driver completed the route and returned to the facility.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual time the driver departed the facility to begin the route.',
    `completed_stops` STRING COMMENT 'Number of stops successfully completed on this route.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery route record was first created in the system.',
    `dispatch_time` TIMESTAMP COMMENT 'Time when the route was dispatched and assigned to the driver for execution.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated total duration for completing the route in minutes, calculated during route optimization.',
    `failed_stops` STRING COMMENT 'Number of stops that failed delivery on this route.',
    `fuel_cost_amount` DECIMAL(18,2) COMMENT 'Fuel cost incurred for this route based on distance traveled and fuel consumption rate.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery route record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or special instructions for the driver or dispatcher regarding this route.',
    `on_time_delivery_percentage` DECIMAL(18,2) COMMENT 'Percentage of stops on this route that met their scheduled delivery window, calculated as (on-time stops / total stops) * 100.',
    `optimization_source` STRING COMMENT 'System or method used to optimize and plan this route (JDA Transportation Management System, manual planning, or other optimization engine).. Valid values are `jda_tms|manual|blue_yonder|third_party`',
    `planned_end_time` TIMESTAMP COMMENT 'Scheduled end time for the route completion and return to facility.',
    `planned_start_time` TIMESTAMP COMMENT 'Scheduled start time for the route departure from the originating facility.',
    `route_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for executing this route, including labor, fuel, vehicle, and carrier charges.',
    `route_date` DATE COMMENT 'The scheduled date for this delivery route execution.',
    `route_number` STRING COMMENT 'Business identifier for the delivery route, externally known and used for operational tracking and communication.',
    `route_status` STRING COMMENT 'Current lifecycle status of the delivery route indicating its execution state.. Valid values are `planned|in_progress|completed|partial|cancelled`',
    `route_type` STRING COMMENT 'Classification of the route based on delivery purpose and destination type.. Valid values are `home_delivery|curbside_pickup|store_transfer|vendor_return`',
    `service_level` STRING COMMENT 'Delivery service level commitment for this route, determining Service Level Agreement (SLA) targets.. Valid values are `same_day|next_day|two_day|standard`',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the route met all Service Level Agreement (SLA) commitments for on-time delivery across all stops.',
    `temperature_zone` STRING COMMENT 'Temperature control requirement for this route to maintain cold chain integrity for perishable goods.. Valid values are `ambient|refrigerated|frozen|multi_temp`',
    `total_distance_miles` DECIMAL(18,2) COMMENT 'Total planned distance for the route measured in miles.',
    `total_order_count` STRING COMMENT 'Total number of customer orders included in this route across all stops.',
    `total_stops` STRING COMMENT 'Total number of delivery stops planned on this route.',
    `total_volume_cubic_feet` DECIMAL(18,2) COMMENT 'Total volume of all shipments on this route measured in cubic feet.',
    `total_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of all shipments on this route measured in pounds.',
    CONSTRAINT pk_fulfillment_delivery_route PRIMARY KEY(`fulfillment_delivery_route_id`)
) COMMENT 'Planned delivery route for last-mile dispatch representing a complete sequence of delivery stops assigned to a driver or vehicle for a given shift. Route header: route date, facility origin, total stops, total miles, estimated duration, actual start/end times, route status (planned, in-progress, completed, partial), driver ID, vehicle ID, and optimization source (JDA TMS, manual). Stop detail: stop sequence number, customer address, planned arrival time, actual arrival time, dwell time (minutes), delivery outcome (delivered, failed, partial, returned), failure reason code, proof-of-delivery method (signature, photo, PIN), and stop-level SLA met flag. Enables route-level and stop-level SLA compliance tracking, driver performance analytics, and delivery density optimization.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`slot_location` (
    `slot_location_id` BIGINT COMMENT 'Unique identifier for the physical slot or bin location within a warehouse, distribution center, micro-fulfillment center, or store backroom. Primary key.',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the facility (DC, MFC, or store) where this slot location resides. Links to the facility master data.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Slot locations map to physical storage locations for put‑away and picking, required by the Warehouse Slotting operational report.',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the slot is currently active and available for warehouse operations. Inactive slots are excluded from putaway and picking logic, typically due to decommissioning, reconfiguration, or permanent removal.',
    `aisle_number` STRING COMMENT 'Aisle identifier within the warehouse zone. Used for navigation and pick path optimization.. Valid values are `^[A-Z0-9]{1,10}$`',
    `barcode` STRING COMMENT 'Barcode identifier printed on the slot label for scanning during warehouse operations. Used by handheld devices for location verification during putaway, picking, and cycle counting.. Valid values are `^[0-9]{8,20}$`',
    `bay_number` STRING COMMENT 'Bay or section number within the aisle. Represents a vertical or horizontal segment of shelving or racking.. Valid values are `^[A-Z0-9]{1,10}$`',
    `bin_number` STRING COMMENT 'Individual bin or slot identifier within the level. Represents the smallest addressable storage unit.. Valid values are `^[A-Z0-9]{1,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the slot location record was first created in the WMS. Used for audit trail and tracking warehouse layout changes over time.',
    `deactivation_date` DATE COMMENT 'Date when the slot location was deactivated and removed from active warehouse operations. Nullable for active slots. Used for historical analysis of warehouse layout evolution and capacity planning.',
    `deactivation_reason` STRING COMMENT 'Reason code explaining why the slot was deactivated. Used for root cause analysis of capacity changes and warehouse optimization initiatives.. Valid values are `reconfiguration|damage|consolidation|obsolete|relocation`',
    `depth_inches` DECIMAL(18,2) COMMENT 'Front-to-back depth dimension of the slot in inches. Used for slotting optimization to ensure product dimensions fit within slot constraints.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the slot is certified and equipped for storing hazardous materials. Slots must meet EPA and OSHA requirements for ventilation, containment, and segregation before hazmat products can be assigned.',
    `height_inches` DECIMAL(18,2) COMMENT 'Vertical height dimension of the slot in inches. Used for slotting optimization to ensure product dimensions fit within slot constraints.',
    `last_cycle_count_date` DATE COMMENT 'Date when the slot location was last physically counted during cycle count operations. Used to schedule recurring cycle counts and maintain inventory accuracy compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the slot location record was last updated. Captures changes to slot attributes, status, or configuration. Critical for change tracking and SOX compliance in financial reporting environments.',
    `last_pick_timestamp` TIMESTAMP COMMENT 'Timestamp when inventory was last picked from this slot location. Used for slot velocity analysis and slotting optimization to position fast-moving SKUs in ergonomic, accessible locations.',
    `last_putaway_timestamp` TIMESTAMP COMMENT 'Timestamp when inventory was last placed into this slot location. Used for slot utilization analytics and identifying slow-moving or stagnant inventory locations.',
    `level_number` STRING COMMENT 'Vertical level or shelf position within the bay (e.g., ground, 1, 2, 3, mezzanine). Impacts picking ergonomics and slotting strategy.. Valid values are `^[A-Z0-9]{1,5}$`',
    `pharmacy_controlled_substance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the slot is authorized for storing DEA-controlled substances (Schedule II-V medications). Requires enhanced security controls including locked cages, access logging, and surveillance per DEA regulations.',
    `pick_sequence` STRING COMMENT 'Numeric sequence number used to optimize pick path routing. Lower numbers are visited first during wave-based picking operations to minimize travel time and improve productivity.',
    `planogram_slot_reference` STRING COMMENT 'Reference identifier linking this physical slot to a planogram definition. Used in store backrooms and retail display areas to ensure compliance with visual merchandising plans and category management strategies.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `replenishment_trigger_quantity` STRING COMMENT 'Inventory quantity threshold that triggers automatic replenishment from reserve or bulk storage to the pick face. Used to maintain optimal pick face inventory levels and prevent stockouts during high-volume picking.',
    `rfid_tag_code` STRING COMMENT 'Unique identifier of the RFID tag affixed to the slot location for automated inventory tracking and real-time location verification. Enables hands-free scanning during putaway and picking operations.. Valid values are `^[A-Z0-9]{10,30}$`',
    `slot_code` STRING COMMENT 'Human-readable unique code for the slot location, typically formatted as zone-aisle-bay-level-bin (e.g., A-12-05-03-B). Used by warehouse associates for picking and putaway operations.. Valid values are `^[A-Z0-9]{1,20}$`',
    `slot_status` STRING COMMENT 'Current operational status of the slot location. Empty indicates available for putaway, occupied indicates inventory present, blocked indicates temporarily unavailable, reserved indicates allocated for specific operation, maintenance indicates under repair or inspection.. Valid values are `empty|occupied|blocked|reserved|maintenance`',
    `slot_type` STRING COMMENT 'Functional classification of the slot indicating its intended use in warehouse operations. Bulk slots hold large quantities for replenishment, pick face slots are optimized for order picking, reserve slots hold overflow inventory, and endcap slots are promotional display locations. [ENUM-REF-CANDIDATE: bulk|pick_face|reserve|endcap|pallet|case|each — 7 candidates stripped; promote to reference product]',
    `slot_velocity_classification` STRING COMMENT 'Classification of the slot based on pick frequency and throughput velocity. Fast-moving slots are positioned in golden zones (waist-to-shoulder height, near shipping) while slow-moving slots are placed in less accessible areas. Recalculated periodically based on historical pick activity.. Valid values are `fast|medium|slow|inactive`',
    `temperature_max_fahrenheit` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for the slot location in Fahrenheit. Critical for cold chain compliance and perishable inventory management. Monitored continuously in refrigerated and frozen zones.',
    `temperature_min_fahrenheit` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for the slot location in Fahrenheit. Critical for cold chain compliance and perishable inventory management. Monitored continuously in refrigerated and frozen zones.',
    `volume_cubic_feet` DECIMAL(18,2) COMMENT 'Total volumetric capacity of the slot in cubic feet, calculated as height × width × depth. Used for space utilization analytics and slotting optimization.',
    `weight_capacity_lbs` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the slot in pounds. Critical for safety compliance and preventing structural damage to racking systems. Enforced during putaway operations.',
    `width_inches` DECIMAL(18,2) COMMENT 'Horizontal width dimension of the slot in inches. Used for slotting optimization to ensure product dimensions fit within slot constraints.',
    `zone_code` STRING COMMENT 'Warehouse zone identifier indicating the environmental or functional area (e.g., ambient, refrigerated, frozen, pharmacy, hazmat, returns, cross-dock). Critical for temperature-controlled cold chain compliance and product segregation.. Valid values are `^[A-Z0-9]{1,10}$`',
    `zone_type` STRING COMMENT 'Classification of the environmental or functional zone type. Determines storage requirements and handling protocols for products assigned to this slot.. Valid values are `ambient|refrigerated|frozen|pharmacy|hazmat|returns`',
    CONSTRAINT pk_slot_location PRIMARY KEY(`slot_location_id`)
) COMMENT 'Physical slot or bin location within a DC, MFC, or store backroom used for putaway and pick operations. Captures facility ID, zone (ambient, refrigerated, frozen, pharmacy), aisle, bay, level, bin, slot type (bulk, pick face, reserve, endcap), slot dimensions (height, width, depth), weight capacity, RFID tag ID, current occupancy status (empty, occupied, blocked), and planogram slot reference. Sourced from Manhattan Associates WMS slotting module.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` (
    `transit_temp_event_id` BIGINT COMMENT 'Unique identifier for the temperature monitoring event. Primary key.',
    `carrier_id` BIGINT COMMENT 'Identifier of the third-party carrier responsible for transportation when the temperature event occurred. Supports carrier performance evaluation.',
    `node_id` BIGINT COMMENT 'Identifier of the distribution center, micro-fulfillment center, or store where the temperature event was recorded.',
    `order_header_id` BIGINT COMMENT 'Identifier of the customer order associated with this temperature monitoring event, if applicable. Links cold chain data to specific fulfillment transactions.',
    `product_item_id` BIGINT COMMENT 'Foreign key linking to product.product_item. Business justification: Cold‑chain temperature events must be associated with the exact product item to satisfy HACCP and compliance audit trails.',
    `shipment_id` BIGINT COMMENT 'Identifier of the shipment or delivery associated with this temperature event. Supports last-mile delivery cold chain tracking.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the delivery vehicle or refrigerated truck where the temperature event was recorded during transit.',
    `wave_id` BIGINT COMMENT 'Identifier of the warehouse picking wave during which this temperature event was recorded. Links temperature monitoring to WMS task execution.',
    `affected_product_lot_numbers` STRING COMMENT 'Comma-separated list of product lot numbers that were exposed to the temperature conditions during this event. Enables targeted recalls if needed.',
    `alert_recipient` STRING COMMENT 'Email address or identifier of the person or system that received the temperature alert. Used for accountability and response tracking.',
    `alert_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated alert was sent to operations staff when this temperature event was recorded. Supports real-time intervention.',
    `breach_duration_minutes` STRING COMMENT 'Duration in minutes that the temperature remained outside acceptable range. Null if no breach occurred. Critical for determining product disposition.',
    `breach_flag` BOOLEAN COMMENT 'Indicates whether the recorded temperature exceeded acceptable thresholds for the temperature zone. Triggers corrective action workflows.',
    `breach_severity` STRING COMMENT 'Classification of the temperature breach severity based on duration and deviation magnitude. Drives escalation and corrective action protocols.. Valid values are `minor|moderate|critical`',
    `calibration_status` STRING COMMENT 'Calibration status of the sensor at the time of the reading. Sensors with failed or overdue calibration may produce unreliable data.. Valid values are `calibrated|overdue|failed`',
    `corrective_action_taken` STRING COMMENT 'Description of corrective action taken in response to a temperature breach. Required for HACCP compliance and FDA audit readiness.',
    `corrective_action_timestamp` TIMESTAMP COMMENT 'Date and time when corrective action was initiated or completed. Demonstrates timely response to food safety incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this temperature event record was first created in the system. Audit trail for data lineage.',
    `data_source` STRING COMMENT 'Source system or method by which the temperature data was captured. Distinguishes automated IoT readings from manual logs.. Valid values are `iot_sensor|manual_entry|wms_integration|tms_integration|vehicle_telematics`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the temperature reading was recorded. Critical for HACCP audit trails and FSMA preventive controls recordkeeping.',
    `haccp_control_point` STRING COMMENT 'Reference to the specific HACCP critical control point associated with this monitoring event. Required for regulatory audit trails.',
    `humidity_percentage` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of the temperature reading. Important for produce quality and certain pharmaceutical products.',
    `last_calibration_date` DATE COMMENT 'Date when the temperature sensor was last calibrated. Required for validating measurement accuracy and regulatory compliance.',
    `location_identifier` STRING COMMENT 'Specific identifier of the location (slot number, tote barcode, vehicle license plate, bay number) where the event occurred. Enables precise traceability.',
    `location_type` STRING COMMENT 'Type of physical location where the temperature event was recorded. Supports cold chain integrity tracking across the fulfillment network. [ENUM-REF-CANDIDATE: slot|tote|vehicle|staging_bay|dock|cooler|freezer|backroom|mfc_zone|dc_zone — 10 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this temperature event record was last modified. Tracks updates to corrective actions or breach classifications.',
    `notes` STRING COMMENT 'Free-text notes or comments about the temperature event, corrective actions, or special circumstances. Supports audit documentation.',
    `product_category` STRING COMMENT 'High-level category of perishable products being monitored during this event. Different categories have different temperature requirements. [ENUM-REF-CANDIDATE: fresh_produce|dairy|frozen_food|meat_poultry|seafood|deli|bakery|pharmacy|floral — 9 candidates stripped; promote to reference product]',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this temperature event meets all applicable FDA, USDA, and HACCP regulatory requirements. False indicates a compliance issue requiring investigation.',
    `sensor_code` STRING COMMENT 'Unique identifier of the temperature sensor or monitoring device that captured the reading. Used for device calibration tracking and maintenance scheduling.. Valid values are `^[A-Z0-9]{8,20}$`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Recorded temperature in degrees Celsius. Core measurement for cold chain compliance and food safety validation.',
    `temperature_zone` STRING COMMENT 'Classification of the temperature control zone: frozen (below -18°C), refrigerated (0-4°C), cool (4-10°C), or ambient (above 10°C). Used for compliance validation.. Valid values are `frozen|refrigerated|cool|ambient`',
    CONSTRAINT pk_transit_temp_event PRIMARY KEY(`transit_temp_event_id`)
) COMMENT 'Temperature monitoring event recorded during storage, picking, packing, or transit of perishable and refrigerated items. Captures event timestamp, location type (slot, tote, vehicle, staging bay), sensor ID, recorded temperature (Celsius), humidity percentage, temperature zone (refrigerated 0-4°C, frozen below -18°C, ambient), breach flag, breach duration (minutes), HACCP control point reference, corrective action taken, and affected product lot numbers. Required for FDA food safety compliance, HACCP audit trails, and FSMA preventive controls recordkeeping.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`sla_policy` (
    `sla_policy_id` BIGINT COMMENT 'Unique identifier for the SLA policy record. Primary key.',
    `approved_by` STRING COMMENT 'Name or identifier of the business owner or manager who approved this SLA policy.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA policy was approved for activation.',
    `auto_compensation_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic customer compensation (refund, credit, discount) is triggered on breach.',
    `breach_escalation_threshold_minutes` STRING COMMENT 'Number of minutes overdue before a breach triggers escalation to management.',
    `breach_notification_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic customer notifications are sent when this SLA is breached.',
    `business_days_only_flag` BOOLEAN COMMENT 'Indicates whether SLA time calculations exclude weekends and holidays (true) or include all calendar days (false).',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount of compensation provided to customer when this SLA is breached.',
    `compensation_percentage` DECIMAL(18,2) COMMENT 'Percentage of order value provided as compensation when this SLA is breached.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA policy record was first created in the system.',
    `customer_tier` STRING COMMENT 'Customer tier or segment this SLA policy applies to (standard, premium, VIP, wholesale, employee).. Valid values are `standard|premium|vip|wholesale|employee`',
    `cutoff_time` TIMESTAMP COMMENT 'Daily cutoff time (HH:MM format) for orders to qualify for this SLA (e.g., 14:00 for 2 PM cutoff for same-day).',
    `delivery_sla_hours` DECIMAL(18,2) COMMENT 'Maximum allowed time in hours from dispatch to final delivery to customer (for delivery orders only).',
    `dispatch_sla_minutes` STRING COMMENT 'Maximum allowed time in minutes from pack completion to dispatch/handoff to carrier or customer.',
    `effective_end_date` DATE COMMENT 'Date when this SLA policy expires or is no longer active. Null indicates open-ended policy.',
    `effective_start_date` DATE COMMENT 'Date when this SLA policy becomes active and enforceable.',
    `exclusion_rules` STRING COMMENT 'Text description of conditions under which this SLA does not apply (e.g., weather events, system outages, force majeure).',
    `facility_type` STRING COMMENT 'Type of fulfillment facility this SLA applies to (DC - Distribution Center, MFC - Micro-Fulfillment Center, store backroom, pharmacy). [ENUM-REF-CANDIDATE: dc|mfc|store_backroom|pharmacy|dark_store|cross_dock|hub — promote to reference product]',
    `fulfillment_channel` STRING COMMENT 'The fulfillment channel this SLA policy applies to (delivery, pickup, ship-to-store, curbside, in-store).. Valid values are `delivery|pickup|ship_to_store|curbside|in_store`',
    `measurement_end_event` STRING COMMENT 'The business event that marks successful SLA completion (delivered, ready for pickup, dispatched, customer notified).. Valid values are `delivered|ready_for_pickup|dispatched|customer_notified`',
    `measurement_start_event` STRING COMMENT 'The business event that triggers the start of SLA time measurement (order placed, order confirmed, payment authorized, inventory allocated).. Valid values are `order_placed|order_confirmed|payment_authorized|inventory_allocated`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA policy record was last modified.',
    `order_type` STRING COMMENT 'Type of order this SLA policy applies to (standard, express, same-day, next-day, scheduled).. Valid values are `standard|express|same_day|next_day|scheduled`',
    `order_value_maximum` DECIMAL(18,2) COMMENT 'Maximum order value threshold for this SLA policy to apply. Null indicates no maximum.',
    `order_value_minimum` DECIMAL(18,2) COMMENT 'Minimum order value threshold for this SLA policy to apply. Null indicates no minimum.',
    `pack_sla_minutes` STRING COMMENT 'Maximum allowed time in minutes from pick completion to pack completion.',
    `pick_sla_minutes` STRING COMMENT 'Maximum allowed time in minutes from order receipt to pick completion.',
    `policy_code` STRING COMMENT 'Unique business identifier code for the SLA policy used in operational systems and reporting.',
    `policy_description` STRING COMMENT 'Detailed business description of the SLA policy, including scope, applicability, and special conditions.',
    `policy_name` STRING COMMENT 'Business-friendly name of the SLA policy (e.g., Express Delivery SLA, Same-Day Pickup SLA).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the SLA policy.. Valid values are `active|inactive|draft|suspended|archived`',
    `priority_level` STRING COMMENT 'Numeric priority ranking for this SLA policy when multiple policies could apply (lower number = higher priority).',
    `service_area_type` STRING COMMENT 'Geographic service area classification this SLA policy applies to (local, regional, national, metro, rural).. Valid values are `local|regional|national|metro|rural`',
    `temperature_zone` STRING COMMENT 'Temperature control requirement this SLA applies to (ambient, refrigerated, frozen, all). Critical for cold chain compliance.. Valid values are `ambient|refrigerated|frozen|all`',
    `total_fulfillment_sla_hours` DECIMAL(18,2) COMMENT 'Total end-to-end fulfillment time commitment in hours from order placement to delivery or pickup availability.',
    `version_number` STRING COMMENT 'Version number of this SLA policy for change tracking and audit purposes.',
    CONSTRAINT pk_sla_policy PRIMARY KEY(`sla_policy_id`)
) COMMENT 'Unified SLA management product encompassing policy definitions and breach event tracking for all fulfillment time commitments. Policy side: SLA name, fulfillment channel (delivery, pickup, ship-to-store), order type (standard, express, same-day, next-day), customer tier, pick/pack/dispatch SLA minutes, total fulfillment SLA hours, effective date range, and active flag. Breach side: individual breach event records where fulfillment orders, tasks, or deliveries failed to meet committed service levels — capturing breach ID, breach type (pick SLA, pack SLA, dispatch SLA, delivery SLA), breach timestamp, minutes overdue, root cause category (OOS, staffing, carrier delay, system outage, weather), impacted order count, customer notification sent flag, escalation level, resolution timestamp, and corrective action. Enables SLA compliance reporting, real-time breach alerting, root cause analysis, and continuous improvement.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`substitution` (
    `substitution_id` BIGINT COMMENT 'Primary key for substitution',
    `associate_id` BIGINT COMMENT 'Reference to the associate who performed the substitution during picking.',
    `node_id` BIGINT COMMENT 'Reference to the fulfillment facility (DC, MFC, or store) where the substitution was made.',
    `order_header_id` BIGINT COMMENT 'Reference to the parent order in which this substitution occurred.',
    `product_order_line_id` BIGINT COMMENT 'Reference to the specific order line item that was substituted.',
    `wave_id` BIGINT COMMENT 'Reference to the picking wave during which this substitution occurred.',
    `brand_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute item is from the same brand as the original item.',
    `category_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute item is from the same product category as the original item.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this substitution record was first created in the system.',
    `customer_acceptance_status` STRING COMMENT 'The customers response to the substitution (accepted, rejected, pending, auto-accepted, or not notified).. Valid values are `accepted|rejected|pending|auto_accepted|not_notified`',
    `customer_feedback` STRING COMMENT 'Free-text feedback provided by the customer regarding the substitution.',
    `customer_notification_method` STRING COMMENT 'The method used to notify the customer about the substitution (mobile app, SMS, email, phone call, or none).. Valid values are `mobile_app|sms|email|phone_call|none`',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the customer was notified about the substitution.',
    `customer_response_timestamp` TIMESTAMP COMMENT 'The date and time when the customer responded to the substitution notification.',
    `customer_satisfaction_rating` STRING COMMENT 'Numeric rating (1-5) provided by the customer indicating their satisfaction with the substitution.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this substitution record was last modified.',
    `original_item_description` STRING COMMENT 'Full product description of the originally ordered item.',
    `original_quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of the original item that was ordered by the customer.',
    `original_sku` STRING COMMENT 'The SKU of the originally ordered product that was unavailable.',
    `original_unit_price` DECIMAL(18,2) COMMENT 'The unit price of the originally ordered item at the time of order placement.',
    `original_upc` STRING COMMENT 'The UPC of the originally ordered product that was unavailable.. Valid values are `^[0-9]{12,14}$`',
    `picker_notes` STRING COMMENT 'Free-text notes entered by the picker explaining the substitution decision or providing additional context.',
    `price_difference_amount` DECIMAL(18,2) COMMENT 'The price difference between the original and substitute items (positive if substitute is more expensive, negative if cheaper).',
    `quality_tier_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute item is from the same quality tier (e.g., premium, standard, value) as the original item.',
    `reason` STRING COMMENT 'The reason why the original item was substituted (OOS, damaged, expired, recalled, discontinued, quality issue).. Valid values are `out_of_stock|damaged|expired|recalled|discontinued|quality_issue`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The amount refunded to the customer if the substitution was rejected or if the substitute was cheaper.',
    `rule_code` BIGINT COMMENT 'Reference to the specific substitution rule configuration that was applied.',
    `rule_type` STRING COMMENT 'The type of substitution rule that was applied (auto-approved by system, associate-selected, customer-approved, system-recommended).. Valid values are `auto_approved|associate_selected|customer_approved|system_recommended`',
    `size_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute item has the same size or quantity as the original item.',
    `substitute_item_description` STRING COMMENT 'Full product description of the substitute item provided.',
    `substitute_quantity_provided` DECIMAL(18,2) COMMENT 'The quantity of the substitute item that was provided to the customer.',
    `substitute_sku` STRING COMMENT 'The SKU of the substitute product that was provided to the customer.',
    `substitute_unit_price` DECIMAL(18,2) COMMENT 'The unit price of the substitute item at the time of substitution.',
    `substitute_upc` STRING COMMENT 'The UPC of the substitute product that was provided to the customer.. Valid values are `^[0-9]{12,14}$`',
    `substitution_status` STRING COMMENT 'The current lifecycle status of the substitution (proposed, approved, rejected, fulfilled, refunded).. Valid values are `proposed|approved|rejected|fulfilled|refunded`',
    `substitution_timestamp` TIMESTAMP COMMENT 'The date and time when the substitution was performed during the picking process.',
    CONSTRAINT pk_substitution PRIMARY KEY(`substitution_id`)
) COMMENT 'Record of a product substitution made during fulfillment when the originally ordered SKU is unavailable (OOS). Captures original UPC, original item description, substitute UPC, substitute item description, substitution reason (OOS, damaged, expired), substitution rule applied (auto-approved, associate-selected, customer-approved), customer notification method (app, SMS, email), customer acceptance status (accepted, rejected, pending), price difference, and substitution timestamp.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`node` (
    `node_id` BIGINT COMMENT 'Primary key for node',
    `dc_facility_id` BIGINT COMMENT 'Reference to the parent distribution center that supplies this fulfillment node. Null for top-level DCs.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Each fulfillment node (store or DC) participates in one or more compliance programs; linking enables program‑specific audit, reporting, and certification tracking per node.',
    `store_location_id` BIGINT COMMENT 'Reference to the associated store master record if this fulfillment node is a store backroom or dark store. Null for standalone DCs and MFCs.',
    `active_from_date` DATE COMMENT 'Date when the fulfillment node became operational and started accepting orders.',
    `active_to_date` DATE COMMENT 'Date when the fulfillment node ceased operations. Null for currently active nodes.',
    `address_line1` STRING COMMENT 'Primary street address of the fulfillment node facility.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, floor) for the fulfillment node.',
    `automation_level` STRING COMMENT 'Degree of automation in the fulfillment node operations: manual (human-only), semi_automated (mix of human and automation), fully_automated (automated systems with human oversight), robotic (advanced robotics and AI).. Valid values are `manual|semi_automated|fully_automated|robotic`',
    `average_pick_time_minutes` DECIMAL(18,2) COMMENT 'Average time in minutes to pick a standard order at this fulfillment node, used for capacity planning and SLA estimation.',
    `city` STRING COMMENT 'City where the fulfillment node is located.',
    `cold_chain_capability` STRING COMMENT 'Temperature control capabilities of the fulfillment node: ambient_only (no refrigeration), refrigerated (chilled products), frozen (frozen products), multi_temp (all temperature zones).. Valid values are `ambient_only|refrigerated|frozen|multi_temp`',
    `contact_email` STRING COMMENT 'Primary contact email address for the fulfillment node operations team.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the fulfillment node operations team.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the fulfillment node location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment node record was first created in the system.',
    `daily_order_capacity` STRING COMMENT 'Maximum number of orders the fulfillment node can process per day under normal operating conditions.',
    `facility_square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the fulfillment node facility, used for capacity planning and space utilization analysis.',
    `fulfillment_channels_supported` STRING COMMENT 'Comma-separated list of fulfillment channels this node supports (e.g., delivery,pickup,ship_to_store). [ENUM-REF-CANDIDATE: delivery|pickup|ship_to_store|curbside|locker|same_day|next_day — promote to reference product]',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment node is certified to handle hazardous materials per DOT and EPA regulations.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the fulfillment node for routing and distance calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the fulfillment node for routing and distance calculations.',
    `manager_name` STRING COMMENT 'Name of the operations manager responsible for this fulfillment node.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment node record was last modified.',
    `node_code` STRING COMMENT 'Externally-known unique business identifier for the fulfillment node, used in WMS and OMS integrations.. Valid values are `^[A-Z0-9]{4,12}$`',
    `node_name` STRING COMMENT 'Human-readable name of the fulfillment node (e.g., Atlanta Regional DC, Store 1234 Backroom, Brooklyn MFC).',
    `node_type` STRING COMMENT 'Classification of the fulfillment node: DC (Distribution Center), MFC (Micro-Fulfillment Center), store_backroom (store backroom authorized for fulfillment), dark_store (dedicated fulfillment-only location), cross_dock (transfer without storage), vendor_direct (DSD fulfillment point).. Valid values are `DC|MFC|store_backroom|dark_store|cross_dock|vendor_direct`',
    `notes` STRING COMMENT 'Free-text notes capturing special operational considerations, constraints, or configuration details for this fulfillment node.',
    `operates_holidays_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment node operates on recognized holidays.',
    `operates_weekends_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment node operates on weekends (Saturday and Sunday).',
    `operating_hours_end` STRING COMMENT 'Daily operating end time for the fulfillment node in HH:MM format (24-hour clock).. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Daily operating start time for the fulfillment node in HH:MM format (24-hour clock).. Valid values are `^([01][0-9]|2[0-3]):[0-5][0-9]$`',
    `operational_status` STRING COMMENT 'Current operational state of the fulfillment node in its lifecycle.. Valid values are `active|inactive|suspended|under_construction|decommissioned|seasonal`',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment node is certified for organic product handling and storage per USDA National Organic Program standards.',
    `pharmacy_licensed_flag` BOOLEAN COMMENT 'Indicates whether the fulfillment node holds a pharmacy license and can fulfill prescription orders.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the fulfillment node address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_area_radius_miles` DECIMAL(18,2) COMMENT 'Maximum delivery radius in miles that this fulfillment node serves for last-mile delivery.',
    `sla_cutoff_time` TIMESTAMP COMMENT 'Daily cutoff time in HH:MM format (24-hour clock) for same-day fulfillment orders at this node.',
    `state_province` STRING COMMENT 'Two-letter state or province code for the fulfillment node location.. Valid values are `^[A-Z]{2}$`',
    `storage_capacity_cubic_feet` DECIMAL(18,2) COMMENT 'Total storage capacity of the fulfillment node measured in cubic feet, used for inventory planning.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the fulfillment node location (e.g., America/New_York), used for scheduling and SLA calculations.',
    `wms_system_instance` STRING COMMENT 'Identifier of the WMS system instance managing this fulfillment node, used for system integration and troubleshooting.',
    CONSTRAINT pk_node PRIMARY KEY(`node_id`)
) COMMENT 'Master record of physical fulfillment nodes including DCs, MFCs, and store backrooms authorized to execute order fulfillment. Captures node name, node type (DC, MFC, store backroom, dark store), address, facility square footage, fulfillment channels supported (delivery, pickup, ship-to-store), daily order capacity, cold chain capability (ambient, refrigerated, frozen), WMS system instance, operating hours, and active status. Distinct from the store master in the store domain — focused on fulfillment operational attributes.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`tote` (
    `tote_id` BIGINT COMMENT 'Unique identifier for the tote container. Primary key.',
    `associate_id` BIGINT COMMENT 'Reference to the warehouse associate or picker currently assigned to this tote for order fulfillment. Null when tote is not actively being picked.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or delivery service provider responsible for transporting this tote. Null for in-store pickup orders.',
    `created_by_user_associate_id` BIGINT COMMENT 'Identifier of the system user or process that created this tote record. Supports audit trail and accountability.',
    `fulfillment_delivery_route_id` BIGINT COMMENT 'Reference to the delivery route this tote is assigned to for last-mile delivery. Links tote to carrier and route optimization.',
    `node_id` BIGINT COMMENT 'Reference to the distribution center, micro-fulfillment center, or store backroom where the tote is currently located.',
    `modified_by_user_associate_id` BIGINT COMMENT 'Identifier of the system user or process that last modified this tote record. Supports audit trail and accountability.',
    `order_header_id` BIGINT COMMENT 'Reference to the customer order currently assigned to this tote. Null when tote is available or not assigned to a specific order.',
    `wave_id` BIGINT COMMENT 'Reference to the fulfillment wave this tote is assigned to. Enables batch processing and wave-based pick optimization.',
    `acquisition_date` DATE COMMENT 'Date when the tote was first acquired and entered into inventory. Used for asset lifecycle tracking and depreciation.',
    `barcode` STRING COMMENT 'Scannable barcode identifier printed on the tote for tracking and identification during pick, pack, stage, and dispatch operations.. Valid values are `^[A-Z0-9]{8,20}$`',
    `capacity_liters` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the tote measured in liters. Used for load planning and space optimization.',
    `color_code` STRING COMMENT 'Color identifier used for visual sorting and temperature zone identification (e.g., blue for frozen, green for ambient, red for pharmacy).. Valid values are `^[A-Z]{3,10}$`',
    `condition` STRING COMMENT 'Physical condition assessment of the tote. Determines whether the tote is suitable for reuse or requires cleaning, repair, or disposal.. Valid values are `clean|soiled|damaged|needs_inspection|quarantined`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this tote record was first created in the system. Audit trail for data lineage.',
    `current_weight_kg` DECIMAL(18,2) COMMENT 'Current actual weight of the tote and its contents in kilograms. Updated during picking and packing operations.',
    `dispatched_timestamp` TIMESTAMP COMMENT 'Date and time when the tote was loaded onto a delivery vehicle and dispatched for last-mile delivery. Marks the start of the delivery phase.',
    `is_cold_chain_compliant` BOOLEAN COMMENT 'Indicates whether the tote has maintained required temperature controls throughout the fulfillment process. Critical for food safety and regulatory compliance.',
    `is_insulated` BOOLEAN COMMENT 'Indicates whether the tote has insulation for temperature-sensitive items. Used for cold chain segregation and routing decisions.',
    `is_reusable` BOOLEAN COMMENT 'Indicates whether the tote is designed for multiple uses and must be returned to the facility. False for single-use disposable bags.',
    `item_count` STRING COMMENT 'Total number of individual items currently contained in the tote. Updated during picking operations and used for accuracy verification.',
    `last_cleaned_timestamp` TIMESTAMP COMMENT 'Date and time when the tote was last cleaned and sanitized. Critical for food safety compliance and HACCP requirements.',
    `last_inspected_timestamp` TIMESTAMP COMMENT 'Date and time when the tote was last inspected for damage or wear. Ensures tote quality and safety standards are maintained.',
    `last_scanned_location` STRING COMMENT 'Physical location identifier where the tote was last scanned. Provides real-time tracking of tote movement through the fulfillment process.',
    `last_scanned_timestamp` TIMESTAMP COMMENT 'Date and time when the tote was last scanned at a location checkpoint. Critical for tracking tote movement and dwell time.',
    `line_count` STRING COMMENT 'Total number of distinct order lines or Stock Keeping Units (SKUs) contained in the tote. Used for pick complexity assessment.',
    `material_type` STRING COMMENT 'Material composition of the tote. Impacts durability, cleaning requirements, and environmental sustainability.. Valid values are `plastic|fabric|paper|composite`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this tote record was last modified. Audit trail for data lineage and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or incident documentation related to the tote.',
    `pack_complete_timestamp` TIMESTAMP COMMENT 'Date and time when packing operations were completed for this tote. Indicates the tote is ready for staging or dispatch.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Date and time when packing operations began for this tote. Tracks the transition from pick to pack workflow stage.',
    `pick_complete_timestamp` TIMESTAMP COMMENT 'Date and time when all items were successfully picked into this tote. Marks completion of the picking phase.',
    `pick_start_timestamp` TIMESTAMP COMMENT 'Date and time when picking operations began for this tote. Used to calculate pick cycle time and labor productivity.',
    `returned_timestamp` TIMESTAMP COMMENT 'Date and time when the tote was returned to the facility after delivery completion or failed delivery attempt. Enables tote reuse cycle tracking.',
    `staged_timestamp` TIMESTAMP COMMENT 'Date and time when the tote was moved to the staging area awaiting dispatch. Critical for tracking Service Level Agreement (SLA) compliance.',
    `temperature_zone` STRING COMMENT 'Temperature control zone classification for the tote. Aligns with cold chain requirements and ensures proper storage conditions for perishable items.. Valid values are `ambient|chilled|frozen|pharmacy_controlled`',
    `total_use_count` STRING COMMENT 'Cumulative number of times the tote has been used for order fulfillment. Tracks tote utilization and helps predict replacement needs.',
    `tote_status` STRING COMMENT 'Current lifecycle status of the tote in the fulfillment workflow. Tracks tote availability and location in the pick-pack-ship process.. Valid values are `available|in_use|staged|dispatched|returned|damaged`',
    `tote_type` STRING COMMENT 'Classification of the tote based on temperature control requirements. Critical for cold chain segregation in grocery fulfillment.. Valid values are `ambient|refrigerated|frozen|insulated_bag|dry_goods|pharmacy`',
    `weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the tote in kilograms. Ensures safe handling and prevents overloading during fulfillment operations.',
    `zone_code` STRING COMMENT 'Code identifying the specific zone or area within the facility where the tote is currently located (e.g., pick zone, staging zone, loading dock).. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_tote PRIMARY KEY(`tote_id`)
) COMMENT 'Physical tote or container used to consolidate picked items for a specific order or batch during fulfillment. Captures tote barcode, tote type (ambient, refrigerated, frozen, insulated bag), tote capacity (liters), current assignment (order, wave), tote status (available, in-use, staged, dispatched, returned, damaged), last scanned location, last scanned timestamp, and tote condition (clean, soiled, damaged). Totes are the primary unit of physical custody transfer between pick, pack, stage, and dispatch — critical for cold chain segregation in grocery.';

CREATE OR REPLACE TABLE `grocery_ecm`.`fulfillment`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Primary key for vehicle',
    `associate_id` BIGINT COMMENT 'Identifier of the driver currently assigned to the vehicle.',
    `replaced_vehicle_id` BIGINT COMMENT 'Self-referencing FK on vehicle (replaced_vehicle_id)',
    `capacity_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum cargo volume the vehicle can hold.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum cargo weight the vehicle can carry.',
    `compliance_certification` STRING COMMENT 'Regulatory certification(s) applicable to the vehicle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vehicle record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the vehicle was retired from service.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the vehicle.',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `emission_standard` STRING COMMENT 'Regulatory emission compliance classification.',
    `fuel_efficiency_l_per_100km` DECIMAL(18,2) COMMENT 'Average fuel consumption measured in liters per 100 kilometers.',
    `fuel_type` STRING COMMENT 'Primary fuel used by the vehicle.',
    `gps_device_code` STRING COMMENT 'Identifier of the GPS tracking unit installed on the vehicle.',
    `gps_last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent GPS location transmission.',
    `insurance_expiry_date` DATE COMMENT 'Date when the current insurance policy expires.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the vehicles insurance coverage.',
    `is_cold_chain_capable` BOOLEAN COMMENT 'Indicates whether the vehicle is equipped for temperature‑controlled transport.',
    `last_maintenance_date` DATE COMMENT 'Date the vehicle most recently underwent scheduled maintenance.',
    `license_plate` STRING COMMENT 'State‑issued license plate identifier.',
    `maintenance_status` STRING COMMENT 'Current maintenance condition of the vehicle.',
    `make` STRING COMMENT 'Manufacturer of the vehicle.',
    `max_cold_temp_celsius` DECIMAL(18,2) COMMENT 'Highest temperature the refrigerated compartment can maintain.',
    `max_speed_kmh` DECIMAL(18,2) COMMENT 'Maximum legal or rated speed of the vehicle.',
    `min_cold_temp_celsius` DECIMAL(18,2) COMMENT 'Lowest temperature the refrigerated compartment can maintain.',
    `model` STRING COMMENT 'Model designation of the vehicle.',
    `vehicle_name` STRING COMMENT 'Human‑readable name or designation of the vehicle.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next maintenance activity.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the vehicle.',
    `odometer_km` BIGINT COMMENT 'Total distance traveled by the vehicle, in kilometers.',
    `operational_region_code` STRING COMMENT 'Code representing the primary geographic region where the vehicle operates.',
    `payload_weight_limit_kg` DECIMAL(18,2) COMMENT 'Maximum payload weight the vehicle is rated to carry.',
    `purchase_date` DATE COMMENT 'Date the vehicle was acquired by Grocery.',
    `registration_expiry_date` DATE COMMENT 'Date when the vehicles registration expires.',
    `registration_number` STRING COMMENT 'Official registration identifier assigned by the motor vehicle authority.',
    `registration_state` STRING COMMENT 'State or province that issued the vehicle registration.',
    `vehicle_status` STRING COMMENT 'Current operational status of the vehicle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vehicle record.',
    `vehicle_type` STRING COMMENT 'Category of vehicle used for fulfillment operations.',
    `vin` STRING COMMENT 'Manufacturer‑assigned unique vehicle identifier.',
    `year` STRING COMMENT 'Year the vehicle was manufactured.',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Master reference table for vehicle. Referenced by vehicle_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ADD CONSTRAINT `fk_fulfillment_wave_sla_policy_id` FOREIGN KEY (`sla_policy_id`) REFERENCES `grocery_ecm`.`fulfillment`.`sla_policy`(`sla_policy_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_slot_location_id` FOREIGN KEY (`slot_location_id`) REFERENCES `grocery_ecm`.`fulfillment`.`slot_location`(`slot_location_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ADD CONSTRAINT `fk_fulfillment_wms_task_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_tote_id` FOREIGN KEY (`tote_id`) REFERENCES `grocery_ecm`.`fulfillment`.`tote`(`tote_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_fulfillment_delivery_route_id` FOREIGN KEY (`fulfillment_delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`(`fulfillment_delivery_route_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_shipment_fulfillment_node_id` FOREIGN KEY (`shipment_fulfillment_node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `grocery_ecm`.`fulfillment`.`vehicle`(`vehicle_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_line_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_route_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_route_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `grocery_ecm`.`fulfillment`.`vehicle`(`vehicle_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ADD CONSTRAINT `fk_fulfillment_fulfillment_delivery_route_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ADD CONSTRAINT `fk_fulfillment_transit_temp_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ADD CONSTRAINT `fk_fulfillment_transit_temp_event_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ADD CONSTRAINT `fk_fulfillment_transit_temp_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `grocery_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ADD CONSTRAINT `fk_fulfillment_transit_temp_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `grocery_ecm`.`fulfillment`.`vehicle`(`vehicle_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ADD CONSTRAINT `fk_fulfillment_transit_temp_event_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ADD CONSTRAINT `fk_fulfillment_substitution_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ADD CONSTRAINT `fk_fulfillment_substitution_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `grocery_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_fulfillment_delivery_route_id` FOREIGN KEY (`fulfillment_delivery_route_id`) REFERENCES `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route`(`fulfillment_delivery_route_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_node_id` FOREIGN KEY (`node_id`) REFERENCES `grocery_ecm`.`fulfillment`.`node`(`node_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ADD CONSTRAINT `fk_fulfillment_tote_wave_id` FOREIGN KEY (`wave_id`) REFERENCES `grocery_ecm`.`fulfillment`.`wave`(`wave_id`);
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` ADD CONSTRAINT `fk_fulfillment_vehicle_replaced_vehicle_id` FOREIGN KEY (`replaced_vehicle_id`) REFERENCES `grocery_ecm`.`fulfillment`.`vehicle`(`vehicle_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`fulfillment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `grocery_ecm`.`fulfillment` SET TAGS ('dbx_domain' = 'fulfillment');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Supervisor ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `created_by_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `created_by_user_associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `created_by_user_associate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `modified_by_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `modified_by_user_associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `modified_by_user_associate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `promo_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Calendar Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `transport_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Policy Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `cancelled_line_count` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Line Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'pallet_jack|forklift|order_picker|reach_truck|cart|automated');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `facility_zone` SET TAGS ('dbx_business_glossary_term' = 'Facility Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `is_cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Cold Chain Compliant Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `is_rush_wave` SET TAGS ('dbx_business_glossary_term' = 'Is Rush Wave Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Wave Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `pick_method` SET TAGS ('dbx_value_regex' = 'discrete|batch|zone|wave|cluster');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `picker_count` SET TAGS ('dbx_business_glossary_term' = 'Picker Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned End Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `short_pick_count` SET TAGS ('dbx_business_glossary_term' = 'Short Pick Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `sla_cutoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Cutoff Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_lines` SET TAGS ('dbx_business_glossary_term' = 'Total Lines');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Orders');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_number` SET TAGS ('dbx_business_glossary_term' = 'Wave Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_business_glossary_term' = 'Wave Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_status` SET TAGS ('dbx_value_regex' = 'planned|released|in_progress|completed|cancelled|on_hold');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_business_glossary_term' = 'Wave Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wave_type` SET TAGS ('dbx_value_regex' = 'replenishment|ecommerce|dsd|store_transfer|bulk_pick|cross_dock');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wave` ALTER COLUMN `wms_wave_identifier` SET TAGS ('dbx_business_glossary_term' = 'WMS (Warehouse Management System) Wave Identifier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `wms_task_id` SET TAGS ('dbx_business_glossary_term' = 'Wms Task Identifier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Associate ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `planogram_id` SET TAGS ('dbx_business_glossary_term' = 'Planogram Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `slot_location_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `cold_chain_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Seconds');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `pick_method` SET TAGS ('dbx_business_glossary_term' = 'Pick Method');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `pick_method` SET TAGS ('dbx_value_regex' = 'single|batch|cluster|zone|wave');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_business_glossary_term' = 'Putaway Strategy');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_value_regex' = 'directed|random|fifo|lifo|fefo|fixed_location');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `sla_target_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `source_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_business_glossary_term' = 'Substituted Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `target_location` SET TAGS ('dbx_business_glossary_term' = 'Target Location');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `target_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_method` SET TAGS ('dbx_business_glossary_term' = 'Task Method');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_method` SET TAGS ('dbx_value_regex' = 'voice|rf_scanner|paper|mobile_app|automated');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Started Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'pick|putaway|replenishment|cycle_count|cross_dock|returns_processing');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|pharmacy_controlled');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `travel_distance_feet` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance Feet');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|inner_pack|display_unit');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `wms_task_number` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Task Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`wms_task` ALTER COLUMN `wms_task_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` SET TAGS ('dbx_subdomain' = 'packing_shipping');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Task ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Packer Associate ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `tote_id` SET TAGS ('dbx_business_glossary_term' = 'Tote ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `cold_chain_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `cold_chain_flag` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `container_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Container Dimensions');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'bag|box|tote|cooler_bag|insulated_box|crate');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `container_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Container Weight Kilograms (KG)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `gift_message_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Message Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `label_print_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Print Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `label_printed_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Printed Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Pack Duration Seconds');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack End Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Exception Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Pack Exception Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_station_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Station ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_number` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|completed|exception|cancelled');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packed_item_count` SET TAGS ('dbx_business_glossary_term' = 'Packed Item Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packed_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Packed Unit Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `qc_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Check Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `qc_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `qc_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `sla_target_pack_time` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Pack Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` SET TAGS ('dbx_subdomain' = 'packing_shipping');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `food_safety_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Violation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `fulfillment_delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `actual_ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `delivery_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `delivery_outcome` SET TAGS ('dbx_business_glossary_term' = 'Delivery Outcome');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_value_regex' = 'customer_address|store|distribution_center|vendor');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `estimated_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Timestamp (ETA)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `max_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `min_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Fahrenheit)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `origin_location_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `origin_location_type` SET TAGS ('dbx_value_regex' = 'distribution_center|micro_fulfillment_center|store|vendor');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `proof_of_delivery_photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Photo Captured Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `proof_of_delivery_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Signature Captured Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `scheduled_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Ship Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'last_mile_delivery|store_replenishment|inter_dc_transfer|vendor_return|customer_return|direct_store_delivery');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `stop_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|deep_frozen');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `total_volume_cubic_ft` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Feet)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `total_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Pounds)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` SET TAGS ('dbx_subdomain' = 'packing_shipping');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `pickup_staging_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Staging ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `member_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Staging Associate ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `primary_pickup_handoff_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Handoff Associate ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `rx_patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `age_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Verified Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `alcohol_verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Verification Required Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `check_in_method` SET TAGS ('dbx_business_glossary_term' = 'Check-In Method');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `check_in_method` SET TAGS ('dbx_value_regex' = 'mobile_app|text_message|kiosk|phone_call|walk_in');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `cold_chain_tote_count` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Tote Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `customer_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Arrival Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `customer_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Captured Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `customer_wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Customer Wait Time Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `handoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Handoff Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `loyalty_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `order_ready_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Ready Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `parking_spot_number` SET TAGS ('dbx_business_glossary_term' = 'Parking Spot Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `prescription_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Included Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `prescription_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `prescription_included_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_bay_number` SET TAGS ('dbx_business_glossary_term' = 'Staging Bay Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Staging Duration Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Staging Exception Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_exception_type` SET TAGS ('dbx_business_glossary_term' = 'Staging Exception Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_exception_type` SET TAGS ('dbx_value_regex' = 'missing_item|wrong_item|damaged_item|late_staging|customer_no_show|order_cancelled');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Staging Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_status` SET TAGS ('dbx_business_glossary_term' = 'Staging Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `staging_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|ready|handed_off|cancelled|exception');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `substitution_count` SET TAGS ('dbx_business_glossary_term' = 'Substitution Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `tote_count` SET TAGS ('dbx_business_glossary_term' = 'Tote Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`pickup_staging` ALTER COLUMN `vehicle_description` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Description');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Source Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Picker ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `alcohol_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|inventory_unavailable|address_issue|payment_failure|fraud_detected|system_error');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_value_regex' = 'same_day|next_day|two_day|standard|economy');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'dc|mfc|store_backroom|dsd|cross_dock|vendor_direct');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_number` SET TAGS ('dbx_value_regex' = '^FO[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'home_delivery|curbside_pickup|in_store_pickup|ship_to_store|locker_pickup');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `oms_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Management System (OMS) Release Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `pack_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Complete Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `pick_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Complete Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `prescription_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `prescription_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `prescription_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'urgent|high|standard|low');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `short_pick_count` SET TAGS ('dbx_business_glossary_term' = 'Short Pick Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `substitution_count` SET TAGS ('dbx_business_glossary_term' = 'Substitution Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (M3)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `fulfillment_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Line ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `drug_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Picker ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `cancel_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancel Reason Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `cancel_reason_code` SET TAGS ('dbx_value_regex' = 'oos|damaged|expired|customer_request|system_error|other');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `carton_code` SET TAGS ('dbx_business_glossary_term' = 'Carton ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `cold_chain_zone` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `cold_chain_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `packed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Packed Quantity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Complete Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_location` SET TAGS ('dbx_business_glossary_term' = 'Pick Location');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `pick_zone` SET TAGS ('dbx_business_glossary_term' = 'Pick Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `picked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `short_pick_reason` SET TAGS ('dbx_business_glossary_term' = 'Short Pick Reason');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substitute_sku` SET TAGS ('dbx_business_glossary_term' = 'Substitute Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substitute_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substitute_upc` SET TAGS ('dbx_business_glossary_term' = 'Substitute Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substitute_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `substitution_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Made Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pound|kilogram|ounce|liter');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_order_line` ALTER COLUMN `weight_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` SET TAGS ('dbx_subdomain' = 'logistics_planning');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `api_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `average_transit_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Transit Time in Days');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'parcel|ltl|ftl|last_mile|gig_economy|courier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `cold_chain_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Certified Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `damage_claim_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Damage Claim Rate Percentage');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `dot_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `fuel_surcharge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `geographic_coverage_zones` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Zones');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `insurance_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Limit Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `mc_number` SET TAGS ('dbx_business_glossary_term' = 'Motor Carrier (MC) Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Carrier Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `on_time_delivery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `preferred_carrier_tier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Tier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `preferred_carrier_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|backup');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `service_level_offered` SET TAGS ('dbx_business_glossary_term' = 'Service Level Offered');
ALTER TABLE `grocery_ecm`.`fulfillment`.`carrier` ALTER COLUMN `tracking_url_template` SET TAGS ('dbx_business_glossary_term' = 'Tracking URL Template');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` SET TAGS ('dbx_subdomain' = 'logistics_planning');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `fulfillment_delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Delivery Route ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `actual_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Actual Distance Miles');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `completed_stops` SET TAGS ('dbx_business_glossary_term' = 'Completed Stops');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `dispatch_time` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `failed_stops` SET TAGS ('dbx_business_glossary_term' = 'Failed Stops');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `fuel_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `fuel_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `on_time_delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Percentage');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `optimization_source` SET TAGS ('dbx_business_glossary_term' = 'Optimization Source');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `optimization_source` SET TAGS ('dbx_value_regex' = 'jda_tms|manual|blue_yonder|third_party');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Route Cost Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_date` SET TAGS ('dbx_business_glossary_term' = 'Route Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_number` SET TAGS ('dbx_business_glossary_term' = 'Route Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|partial|cancelled');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'home_delivery|curbside_pickup|store_transfer|vendor_return');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'same_day|next_day|two_day|standard');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `total_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Distance Miles');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `total_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Order Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `total_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Stops');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `total_volume_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Cubic Feet');
ALTER TABLE `grocery_ecm`.`fulfillment`.`fulfillment_delivery_route` ALTER COLUMN `total_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Pounds');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` SET TAGS ('dbx_subdomain' = 'logistics_planning');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_location_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Location ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Slot Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `aisle_number` SET TAGS ('dbx_business_glossary_term' = 'Aisle Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `aisle_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Slot Location Barcode');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `bay_number` SET TAGS ('dbx_business_glossary_term' = 'Bay Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `bay_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bin Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Location Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Slot Deactivation Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Slot Deactivation Reason');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_value_regex' = 'reconfiguration|damage|consolidation|obsolete|relocation');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Slot Depth in Inches');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Slot Height in Inches');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Slot Location Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `last_pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Pick Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `last_putaway_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Putaway Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `level_number` SET TAGS ('dbx_business_glossary_term' = 'Level Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `level_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `pharmacy_controlled_substance_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Controlled Substance Storage Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `pick_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pick Sequence Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `planogram_slot_reference` SET TAGS ('dbx_business_glossary_term' = 'Planogram Slot Reference');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `planogram_slot_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `replenishment_trigger_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Quantity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Tag ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `rfid_tag_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_code` SET TAGS ('dbx_business_glossary_term' = 'Slot Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'empty|occupied|blocked|reserved|maintenance');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_velocity_classification` SET TAGS ('dbx_business_glossary_term' = 'Slot Velocity Classification');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `slot_velocity_classification` SET TAGS ('dbx_value_regex' = 'fast|medium|slow|inactive');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `temperature_max_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature in Fahrenheit');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `temperature_min_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature in Fahrenheit');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `volume_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Slot Volume in Cubic Feet');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `weight_capacity_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity in Pounds');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `width_inches` SET TAGS ('dbx_business_glossary_term' = 'Slot Width in Inches');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`slot_location` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|pharmacy|hazmat|returns');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `transit_temp_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transit Temperature Event ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `product_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Item Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `affected_product_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Lot Numbers');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `alert_recipient` SET TAGS ('dbx_business_glossary_term' = 'Alert Recipient');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `alert_recipient` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `alert_recipient` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `alert_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `breach_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration (Minutes)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|critical');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|overdue|failed');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `corrective_action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'iot_sensor|manual_entry|wms_integration|tms_integration|vehicle_telematics');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `haccp_control_point` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) Control Point');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `humidity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Humidity Percentage');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `location_identifier` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `sensor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`transit_temp_event` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'frozen|refrigerated|cool|ambient');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `sla_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Policy ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `auto_compensation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Compensation Enabled Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `auto_compensation_enabled_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `auto_compensation_enabled_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `breach_escalation_threshold_minutes` SET TAGS ('dbx_business_glossary_term' = 'Breach Escalation Threshold Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `breach_notification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Enabled Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `business_days_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Days Only Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `compensation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compensation Percentage');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `compensation_percentage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `compensation_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `customer_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `customer_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|vip|wholesale|employee');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `delivery_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Delivery Service Level Agreement (SLA) Hours');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `dispatch_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Service Level Agreement (SLA) Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `exclusion_rules` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rules');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'delivery|pickup|ship_to_store|curbside|in_store');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `measurement_end_event` SET TAGS ('dbx_business_glossary_term' = 'Measurement End Event');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `measurement_end_event` SET TAGS ('dbx_value_regex' = 'delivered|ready_for_pickup|dispatched|customer_notified');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `measurement_start_event` SET TAGS ('dbx_business_glossary_term' = 'Measurement Start Event');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `measurement_start_event` SET TAGS ('dbx_value_regex' = 'order_placed|order_confirmed|payment_authorized|inventory_allocated');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|express|same_day|next_day|scheduled');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `order_value_maximum` SET TAGS ('dbx_business_glossary_term' = 'Order Value Maximum');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `order_value_minimum` SET TAGS ('dbx_business_glossary_term' = 'Order Value Minimum');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `pack_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Pack Service Level Agreement (SLA) Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `pick_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Pick Service Level Agreement (SLA) Minutes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Description');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Name');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Policy Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|archived');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'local|regional|national|metro|rural');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|all');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `total_fulfillment_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Fulfillment Service Level Agreement (SLA) Hours');
ALTER TABLE `grocery_ecm`.`fulfillment`.`sla_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Identifier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Picker ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `product_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `brand_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Match Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `category_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Match Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending|auto_accepted|not_notified');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_notification_method` SET TAGS ('dbx_value_regex' = 'mobile_app|sms|email|phone_call|none');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `original_item_description` SET TAGS ('dbx_business_glossary_term' = 'Original Item Description');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `original_quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Original Quantity Ordered');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `original_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Original Unit Price');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `original_upc` SET TAGS ('dbx_business_glossary_term' = 'Original Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `original_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `picker_notes` SET TAGS ('dbx_business_glossary_term' = 'Picker Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `price_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Difference Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `quality_tier_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Match Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'out_of_stock|damaged|expired|recalled|discontinued|quality_issue');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rule ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rule Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'auto_approved|associate_selected|customer_approved|system_recommended');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `size_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Size Match Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitute_item_description` SET TAGS ('dbx_business_glossary_term' = 'Substitute Item Description');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitute_quantity_provided` SET TAGS ('dbx_business_glossary_term' = 'Substitute Quantity Provided');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitute_sku` SET TAGS ('dbx_business_glossary_term' = 'Substitute Stock Keeping Unit (SKU)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitute_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Substitute Unit Price');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitute_upc` SET TAGS ('dbx_business_glossary_term' = 'Substitute Universal Product Code (UPC)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitute_upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_value_regex' = 'proposed|approved|rejected|fulfilled|refunded');
ALTER TABLE `grocery_ecm`.`fulfillment`.`substitution` ALTER COLUMN `substitution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Substitution Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Node Identifier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Distribution Center (DC) ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|robotic');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `average_pick_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Pick Time (Minutes)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `cold_chain_capability` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capability');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `cold_chain_capability` SET TAGS ('dbx_value_regex' = 'ambient_only|refrigerated|frozen|multi_temp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `daily_order_capacity` SET TAGS ('dbx_business_glossary_term' = 'Daily Order Capacity');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `facility_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Facility Square Footage');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `fulfillment_channels_supported` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channels Supported');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'DC|MFC|store_backroom|dark_store|cross_dock|vendor_direct');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operates_holidays_flag` SET TAGS ('dbx_business_glossary_term' = 'Operates Holidays Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operates_weekends_flag` SET TAGS ('dbx_business_glossary_term' = 'Operates Weekends Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_construction|decommissioned|seasonal');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `pharmacy_licensed_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Licensed Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `service_area_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Service Area Radius (Miles)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `sla_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Cutoff Time');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `storage_capacity_cubic_feet` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Cubic Feet)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`node` ALTER COLUMN `wms_system_instance` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Instance');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` SET TAGS ('dbx_subdomain' = 'packing_shipping');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `tote_id` SET TAGS ('dbx_business_glossary_term' = 'Tote Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Picker Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `created_by_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `created_by_user_associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `created_by_user_associate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `fulfillment_delivery_route_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Route Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `modified_by_user_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `modified_by_user_associate_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `modified_by_user_associate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Identifier (ID)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Tote Acquisition Date');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Tote Barcode');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `capacity_liters` SET TAGS ('dbx_business_glossary_term' = 'Tote Capacity (Liters)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Tote Color Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `color_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Tote Condition');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'clean|soiled|damaged|needs_inspection|quarantined');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `current_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Current Weight (Kilograms)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `dispatched_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatched Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `is_cold_chain_compliant` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `is_insulated` SET TAGS ('dbx_business_glossary_term' = 'Insulated Tote Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `is_reusable` SET TAGS ('dbx_business_glossary_term' = 'Reusable Tote Flag');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `last_cleaned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaned Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `last_inspected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inspected Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `last_scanned_location` SET TAGS ('dbx_business_glossary_term' = 'Last Scanned Location');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `last_scanned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Scanned Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `line_count` SET TAGS ('dbx_business_glossary_term' = 'Line Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Tote Material Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'plastic|fabric|paper|composite');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tote Notes');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `pack_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Complete Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `pick_complete_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Complete Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `pick_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Start Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `returned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Returned Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `staged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Staged Timestamp');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|pharmacy_controlled');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `total_use_count` SET TAGS ('dbx_business_glossary_term' = 'Total Use Count');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `tote_status` SET TAGS ('dbx_business_glossary_term' = 'Tote Status');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `tote_status` SET TAGS ('dbx_value_regex' = 'available|in_use|staged|dispatched|returned|damaged');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `tote_type` SET TAGS ('dbx_business_glossary_term' = 'Tote Type');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `tote_type` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|insulated_bag|dry_goods|pharmacy');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `weight_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Capacity (Kilograms)');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Zone Code');
ALTER TABLE `grocery_ecm`.`fulfillment`.`tote` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` SET TAGS ('dbx_subdomain' = 'logistics_planning');
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` ALTER COLUMN `replaced_vehicle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`fulfillment`.`vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_financial' = 'true');
