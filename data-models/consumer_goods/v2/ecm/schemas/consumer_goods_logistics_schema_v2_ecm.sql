-- Schema for Domain: logistics | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`logistics` COMMENT 'Owns transportation management, freight optimization, and delivery execution across inbound and outbound networks. Manages carrier contracts, shipment planning, route optimization, freight audit, track-and-trace, 3PL coordination, proof of delivery, cold-chain compliance, and transportation cost tracking. Distinct from distribution (warehouse-focused) — logistics covers inter-facility and last-mile movement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Primary key',
    `address_line_1` STRING COMMENT 'Address line 1',
    `address_line_2` STRING COMMENT 'Address line 2',
    `carrier_type` STRING COMMENT 'Type of carrier (LTL, FTL, parcel, etc.)',
    `city` STRING COMMENT 'City',
    `carrier_code` STRING COMMENT 'Unique carrier code',
    `country_code` STRING COMMENT 'ISO country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dot_number` STRING COMMENT 'Department of Transportation number',
    `geographic_coverage` STRING COMMENT 'Geographic coverage area',
    `insurance_certificate_number` STRING COMMENT 'Insurance certificate number',
    `insurance_expiry_date` DATE COMMENT 'Insurance expiry date',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `mc_number` STRING COMMENT 'Motor Carrier number',
    `carrier_name` STRING COMMENT 'Carrier legal name',
    `on_time_performance_pct` DECIMAL(18,2) COMMENT 'On-time performance percentage',
    `postal_code` STRING COMMENT 'Postal code',
    `preferred_carrier_flag` BOOLEAN COMMENT 'Preferred carrier flag',
    `primary_contact_email` STRING COMMENT 'Primary contact email',
    `primary_contact_name` STRING COMMENT 'Primary contact person name',
    `primary_contact_phone` STRING COMMENT 'Primary contact phone',
    `quality_rating` DECIMAL(18,2) COMMENT 'Quality rating score',
    `scac_code` STRING COMMENT 'Standard Carrier Alpha Code',
    `service_modes` STRING COMMENT 'Supported service modes',
    `state_province` STRING COMMENT 'State or province',
    `carrier_status` STRING COMMENT 'Active/Inactive status',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Transportation carrier master data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` (
    `carrier_contract_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `auto_renewal_flag` BOOLEAN COMMENT 'Auto renewal flag',
    `contract_name` STRING COMMENT 'Contract name',
    `contract_number` STRING COMMENT 'Contract number',
    `contract_type` STRING COMMENT 'Contract type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `fuel_surcharge_method` STRING COMMENT 'Fuel surcharge calculation method',
    `insurance_required_flag` BOOLEAN COMMENT 'Insurance required flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `liability_limit_amount` DECIMAL(18,2) COMMENT 'Liability limit amount',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge',
    `notice_period_days` STRING COMMENT 'Notice period in days',
    `payment_terms` STRING COMMENT 'Payment terms',
    `carrier_contract_status` STRING COMMENT 'Contract status',
    `volume_commitment` DECIMAL(18,2) COMMENT 'Volume commitment',
    `volume_commitment_uom` STRING COMMENT 'Volume commitment unit of measure',
    CONSTRAINT pk_carrier_contract PRIMARY KEY(`carrier_contract_id`)
) COMMENT 'Carrier contract agreements';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` (
    `lane_id` BIGINT COMMENT 'Primary key',
    `lane_code` STRING COMMENT 'Lane code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `destination_city` STRING COMMENT 'Destination city',
    `destination_country_code` STRING COMMENT 'Destination country code',
    `destination_location_code` STRING COMMENT 'Destination location code',
    `destination_state_province` STRING COMMENT 'Destination state/province',
    `distance_km` DECIMAL(18,2) COMMENT 'Distance in kilometers',
    `lane_status` STRING COMMENT 'Lane status',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `mode_of_transport` STRING COMMENT 'Mode of transport',
    `origin_city` STRING COMMENT 'Origin city',
    `origin_country_code` STRING COMMENT 'Origin country code',
    `origin_location_code` STRING COMMENT 'Origin location code',
    `origin_state_province` STRING COMMENT 'Origin state/province',
    `service_level` STRING COMMENT 'Service level',
    `transit_time_days` STRING COMMENT 'Transit time in days',
    CONSTRAINT pk_lane PRIMARY KEY(`lane_id`)
) COMMENT 'Transportation lanes between origin and destination';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` (
    `logistics_shipment_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `actual_delivery_date` DATE COMMENT 'Actual delivery date',
    `actual_ship_date` DATE COMMENT 'Actual ship date',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `destination_location_code` STRING COMMENT 'Destination location code',
    `hazmat_flag` BOOLEAN COMMENT 'Hazmat flag',
    `incoterms` STRING COMMENT 'Incoterms',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `origin_location_code` STRING COMMENT 'Origin location code',
    `planned_delivery_date` DATE COMMENT 'Planned delivery date',
    `planned_ship_date` DATE COMMENT 'Planned ship date',
    `pro_number` STRING COMMENT 'PRO number',
    `service_level` STRING COMMENT 'Service level',
    `shipment_number` STRING COMMENT 'Shipment number',
    `shipment_status` STRING COMMENT 'Shipment status',
    `shipment_type` STRING COMMENT 'Shipment type',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Temperature controlled flag',
    `total_freight_cost` DECIMAL(18,2) COMMENT 'Total freight cost',
    `total_volume_cubic_m` DECIMAL(18,2) COMMENT 'Total volume in cubic meters',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kg',
    `tracking_number` STRING COMMENT 'Tracking number',
    CONSTRAINT pk_logistics_shipment PRIMARY KEY(`logistics_shipment_id`)
) COMMENT 'Logistics shipment master record';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` (
    `shipment_leg_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `vehicle_id` BIGINT COMMENT 'Vehicle ID',
    `actual_arrival_date` TIMESTAMP COMMENT 'Actual arrival date',
    `actual_departure_date` TIMESTAMP COMMENT 'Actual departure date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `destination_location_code` STRING COMMENT 'Destination location code',
    `distance_km` DECIMAL(18,2) COMMENT 'Distance in kilometers',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `leg_sequence_number` STRING COMMENT 'Leg sequence number',
    `leg_status` STRING COMMENT 'Leg status',
    `mode_of_transport` STRING COMMENT 'Mode of transport',
    `origin_location_code` STRING COMMENT 'Origin location code',
    `planned_arrival_date` TIMESTAMP COMMENT 'Planned arrival date',
    `planned_departure_date` TIMESTAMP COMMENT 'Planned departure date',
    `tracking_number` STRING COMMENT 'Tracking number',
    CONSTRAINT pk_shipment_leg PRIMARY KEY(`shipment_leg_id`)
) COMMENT 'Individual leg of a multi-leg shipment';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` (
    `shipment_item_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `sku_id` BIGINT COMMENT 'Foreign key to SKU',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `freight_cost` DECIMAL(18,2) COMMENT 'Freight cost',
    `handling_unit_count` STRING COMMENT 'Handling unit count',
    `hazmat_flag` BOOLEAN COMMENT 'Hazmat flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `line_number` STRING COMMENT 'Line number',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity',
    `quantity_uom` STRING COMMENT 'Quantity unit of measure',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Volume in cubic meters',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight in kg',
    CONSTRAINT pk_shipment_item PRIMARY KEY(`shipment_item_id`)
) COMMENT 'Line items within a shipment';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_date` DATE COMMENT 'Delivery date',
    `delivery_number` STRING COMMENT 'Delivery number',
    `delivery_status` STRING COMMENT 'Delivery status',
    `delivery_time` TIMESTAMP COMMENT 'Delivery time',
    `exception_code` STRING COMMENT 'Exception code',
    `exception_description` STRING COMMENT 'Exception description',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `location` STRING COMMENT 'Delivery location',
    `notes` STRING COMMENT 'Delivery notes',
    `recipient_name` STRING COMMENT 'Recipient name',
    `recipient_signature` STRING COMMENT 'Recipient signature',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Delivery record for shipment';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` (
    `proof_of_delivery_id` BIGINT COMMENT 'Primary key',
    `delivery_id` BIGINT COMMENT 'Foreign key to delivery',
    `condition_at_delivery` STRING COMMENT 'Condition at delivery',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_date` DATE COMMENT 'Delivery date',
    `delivery_time` TIMESTAMP COMMENT 'Delivery time',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Notes',
    `photo_url` STRING COMMENT 'Photo URL',
    `pod_number` STRING COMMENT 'POD number',
    `recipient_name` STRING COMMENT 'Recipient name',
    `recipient_title` STRING COMMENT 'Recipient title',
    `signature_image_url` STRING COMMENT 'Signature image URL',
    CONSTRAINT pk_proof_of_delivery PRIMARY KEY(`proof_of_delivery_id`)
) COMMENT 'Proof of delivery documentation';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `delivery_location_code` STRING COMMENT 'Delivery location code',
    `equipment_type` STRING COMMENT 'Equipment type',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost',
    `freight_order_number` STRING COMMENT 'Freight order number',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `order_date` DATE COMMENT 'Order date',
    `order_status` STRING COMMENT 'Order status',
    `pickup_location_code` STRING COMMENT 'Pickup location code',
    `requested_delivery_date` DATE COMMENT 'Requested delivery date',
    `requested_pickup_date` DATE COMMENT 'Requested pickup date',
    `service_level` STRING COMMENT 'Service level',
    `special_instructions` STRING COMMENT 'Special instructions',
    `total_volume_cubic_m` DECIMAL(18,2) COMMENT 'Total volume in cubic meters',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kg',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Freight order for transportation';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`route` (
    `route_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `route_code` STRING COMMENT 'Route code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `end_location_code` STRING COMMENT 'End location code',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `route_name` STRING COMMENT 'Route name',
    `route_status` STRING COMMENT 'Route status',
    `route_type` STRING COMMENT 'Route type',
    `start_location_code` STRING COMMENT 'Start location code',
    `total_distance_km` DECIMAL(18,2) COMMENT 'Total distance in km',
    CONSTRAINT pk_route PRIMARY KEY(`route_id`)
) COMMENT 'Delivery route master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` (
    `route_stop_id` BIGINT COMMENT 'Primary key',
    `route_id` BIGINT COMMENT 'Foreign key to route',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual arrival time',
    `actual_departure_time` TIMESTAMP COMMENT 'Actual departure time',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `dwell_time_minutes` STRING COMMENT 'Dwell time in minutes',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `location_code` STRING COMMENT 'Location code',
    `planned_arrival_time` TIMESTAMP COMMENT 'Planned arrival time',
    `planned_departure_time` TIMESTAMP COMMENT 'Planned departure time',
    `stop_sequence_number` STRING COMMENT 'Stop sequence number',
    `stop_status` STRING COMMENT 'Stop status',
    `stop_type` STRING COMMENT 'Stop type (pickup/delivery)',
    CONSTRAINT pk_route_stop PRIMARY KEY(`route_stop_id`)
) COMMENT 'Individual stop on a route';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` (
    `freight_invoice_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `accessorial_charges` DECIMAL(18,2) COMMENT 'Accessorial charges',
    `base_freight_charge` DECIMAL(18,2) COMMENT 'Base freight charge',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `due_date` DATE COMMENT 'Due date',
    `fuel_surcharge` DECIMAL(18,2) COMMENT 'Fuel surcharge',
    `invoice_date` DATE COMMENT 'Invoice date',
    `invoice_number` STRING COMMENT 'Invoice number',
    `invoice_status` STRING COMMENT 'Invoice status',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `payment_date` DATE COMMENT 'Payment date',
    `payment_terms` STRING COMMENT 'Payment terms',
    `total_invoice_amount` DECIMAL(18,2) COMMENT 'Total invoice amount',
    CONSTRAINT pk_freight_invoice PRIMARY KEY(`freight_invoice_id`)
) COMMENT 'Freight invoice from carrier';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` (
    `freight_audit_result_id` BIGINT COMMENT 'Primary key',
    `freight_invoice_id` BIGINT COMMENT 'Foreign key to freight invoice',
    `approved_amount` DECIMAL(18,2) COMMENT 'Approved amount',
    `audit_date` DATE COMMENT 'Audit date',
    `audit_status` STRING COMMENT 'Audit status',
    `audited_amount` DECIMAL(18,2) COMMENT 'Audited amount',
    `auditor_notes` STRING COMMENT 'Auditor notes',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Invoiced amount',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance amount',
    `variance_reason` STRING COMMENT 'Variance reason',
    CONSTRAINT pk_freight_audit_result PRIMARY KEY(`freight_audit_result_id`)
) COMMENT 'Freight audit results';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` (
    `tracking_event_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `city` STRING COMMENT 'City',
    `country_code` STRING COMMENT 'Country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `event_code` STRING COMMENT 'Event code',
    `event_description` STRING COMMENT 'Event description',
    `event_timestamp` TIMESTAMP COMMENT 'Event timestamp',
    `event_type` STRING COMMENT 'Event type',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude',
    `location_code` STRING COMMENT 'Location code',
    `state_province` STRING COMMENT 'State/province',
    CONSTRAINT pk_tracking_event PRIMARY KEY(`tracking_event_id`)
) COMMENT 'Shipment tracking events';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` (
    `cold_chain_log_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `excursion_flag` BOOLEAN COMMENT 'Excursion flag',
    `excursion_type` STRING COMMENT 'Excursion type',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Humidity percentage',
    `location_code` STRING COMMENT 'Location code',
    `notes` STRING COMMENT 'Notes',
    `reading_timestamp` TIMESTAMP COMMENT 'Reading timestamp',
    `sensor_code` STRING COMMENT 'Sensor ID',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature in Celsius',
    CONSTRAINT pk_cold_chain_log PRIMARY KEY(`cold_chain_log_id`)
) COMMENT 'Temperature monitoring log for cold chain shipments';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` (
    `transport_exception_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `exception_code` STRING COMMENT 'Exception code',
    `exception_description` STRING COMMENT 'Exception description',
    `exception_timestamp` TIMESTAMP COMMENT 'Exception timestamp',
    `exception_type` STRING COMMENT 'Exception type',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `resolution_date` DATE COMMENT 'Resolution date',
    `resolution_notes` STRING COMMENT 'Resolution notes',
    `resolution_status` STRING COMMENT 'Resolution status',
    `severity` STRING COMMENT 'Severity level',
    CONSTRAINT pk_transport_exception PRIMARY KEY(`transport_exception_id`)
) COMMENT 'Transportation exceptions and issues';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` (
    `carrier_performance_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `average_transit_time_days` DECIMAL(18,2) COMMENT 'Average transit time in days',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `damage_rate_pct` DECIMAL(18,2) COMMENT 'Damage rate percentage',
    `damaged_shipments` STRING COMMENT 'Damaged shipments',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `measurement_period_end` DATE COMMENT 'Measurement period end',
    `measurement_period_start` DATE COMMENT 'Measurement period start',
    `on_time_performance_pct` DECIMAL(18,2) COMMENT 'On-time performance percentage',
    `on_time_shipments` STRING COMMENT 'On-time shipments',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality score',
    `total_freight_cost` DECIMAL(18,2) COMMENT 'Total freight cost',
    `total_shipments` STRING COMMENT 'Total shipments',
    CONSTRAINT pk_carrier_performance PRIMARY KEY(`carrier_performance_id`)
) COMMENT 'Carrier performance metrics';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` (
    `third_party_provider_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT 'Address line 1',
    `city` STRING COMMENT 'City',
    `country_code` STRING COMMENT 'Country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `geographic_coverage` STRING COMMENT 'Geographic coverage',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `primary_contact_email` STRING COMMENT 'Primary contact email',
    `primary_contact_name` STRING COMMENT 'Primary contact name',
    `primary_contact_phone` STRING COMMENT 'Primary contact phone',
    `provider_code` STRING COMMENT 'Provider code',
    `provider_name` STRING COMMENT 'Provider name',
    `provider_type` STRING COMMENT 'Provider type (3PL, 4PL, freight forwarder)',
    `services_offered` STRING COMMENT 'Services offered',
    `third_party_provider_status` STRING COMMENT 'Status',
    CONSTRAINT pk_third_party_provider PRIMARY KEY(`third_party_provider_id`)
) COMMENT 'Third-party logistics providers (3PL)';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` (
    `customs_declaration_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `broker_name` STRING COMMENT 'Customs broker name',
    `clearance_date` DATE COMMENT 'Clearance date',
    `clearance_status` STRING COMMENT 'Clearance status',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `declaration_date` DATE COMMENT 'Declaration date',
    `declaration_number` STRING COMMENT 'Declaration number',
    `declaration_type` STRING COMMENT 'Declaration type',
    `declared_value` DECIMAL(18,2) COMMENT 'Declared value',
    `duty_amount` DECIMAL(18,2) COMMENT 'Duty amount',
    `export_country_code` STRING COMMENT 'Export country code',
    `hs_code` STRING COMMENT 'Harmonized System code',
    `import_country_code` STRING COMMENT 'Import country code',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    CONSTRAINT pk_customs_declaration PRIMARY KEY(`customs_declaration_id`)
) COMMENT 'Customs declaration for international shipments';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` (
    `freight_cost_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost amount',
    `cost_category` STRING COMMENT 'Cost category',
    `cost_center_code` STRING COMMENT 'Cost center code',
    `cost_date` DATE COMMENT 'Cost date',
    `cost_type` STRING COMMENT 'Cost type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `gl_account_code` STRING COMMENT 'GL account code',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `notes` STRING COMMENT 'Notes',
    CONSTRAINT pk_freight_cost PRIMARY KEY(`freight_cost_id`)
) COMMENT 'Freight cost breakdown';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` (
    `freight_rate_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `lane_id` BIGINT COMMENT 'Foreign key to lane',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `effective_end_date` DATE COMMENT 'Effective end date',
    `effective_start_date` DATE COMMENT 'Effective start date',
    `equipment_type` STRING COMMENT 'Equipment type',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge',
    `rate_amount` DECIMAL(18,2) COMMENT 'Rate amount',
    `rate_code` STRING COMMENT 'Rate code',
    `rate_status` STRING COMMENT 'Rate status',
    `rate_type` STRING COMMENT 'Rate type',
    `rate_uom` STRING COMMENT 'Rate unit of measure',
    `service_level` STRING COMMENT 'Service level',
    CONSTRAINT pk_freight_rate PRIMARY KEY(`freight_rate_id`)
) COMMENT 'Freight rate master';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` (
    `transport_unit_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `capacity_volume_cubic_m` DECIMAL(18,2) COMMENT 'Capacity volume in cubic meters',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Capacity weight in kg',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `current_location_code` STRING COMMENT 'Current location code',
    `equipment_type` STRING COMMENT 'Equipment type',
    `gps_enabled_flag` BOOLEAN COMMENT 'GPS enabled flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `transport_unit_status` STRING COMMENT 'Status',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Temperature controlled flag',
    `unit_number` STRING COMMENT 'Unit number',
    `unit_type` STRING COMMENT 'Unit type',
    CONSTRAINT pk_transport_unit PRIMARY KEY(`transport_unit_id`)
) COMMENT 'Transport unit (container, trailer, etc.)';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Primary key',
    `carrier_id` BIGINT COMMENT 'Foreign key to carrier',
    `capacity_volume_cubic_m` DECIMAL(18,2) COMMENT 'Capacity volume in cubic meters',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Capacity weight in kg',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `fuel_type` STRING COMMENT 'Fuel type',
    `gps_enabled_flag` BOOLEAN COMMENT 'GPS enabled flag',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `license_plate` STRING COMMENT 'License plate',
    `make` STRING COMMENT 'Make',
    `model` STRING COMMENT 'Model',
    `vehicle_status` STRING COMMENT 'Status',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Temperature controlled flag',
    `vehicle_number` STRING COMMENT 'Vehicle number',
    `vehicle_type` STRING COMMENT 'Vehicle type',
    `vin` STRING COMMENT 'Vehicle identification number',
    `year` STRING COMMENT 'Year',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Vehicle master data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` (
    `consolidation_id` BIGINT COMMENT 'Primary key',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key to distribution facility',
    `consolidation_date` DATE COMMENT 'Consolidation date',
    `consolidation_number` STRING COMMENT 'Consolidation number',
    `consolidation_status` STRING COMMENT 'Consolidation status',
    `consolidation_type` STRING COMMENT 'Consolidation type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `destination_location_code` STRING COMMENT 'Destination location code',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `shipment_count` STRING COMMENT 'Shipment count',
    `total_volume_cubic_m` DECIMAL(18,2) COMMENT 'Total volume in cubic meters',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kg',
    CONSTRAINT pk_consolidation PRIMARY KEY(`consolidation_id`)
) COMMENT 'Shipment consolidation record';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` (
    `handling_unit_id` BIGINT COMMENT 'Primary key',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key to logistics shipment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `current_location_code` STRING COMMENT 'Current location code',
    `handling_unit_number` STRING COMMENT 'Handling unit number',
    `handling_unit_type` STRING COMMENT 'Handling unit type',
    `height_cm` DECIMAL(18,2) COMMENT 'Height in cm',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `length_cm` DECIMAL(18,2) COMMENT 'Length in cm',
    `sscc` STRING COMMENT 'Serial Shipping Container Code',
    `handling_unit_status` STRING COMMENT 'Status',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Volume in cubic meters',
    `weight_kg` DECIMAL(18,2) COMMENT 'Weight in kg',
    `width_cm` DECIMAL(18,2) COMMENT 'Width in cm',
    CONSTRAINT pk_handling_unit PRIMARY KEY(`handling_unit_id`)
) COMMENT 'Handling unit (pallet, carton, etc.)';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` ADD CONSTRAINT `fk_logistics_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ADD CONSTRAINT `fk_logistics_logistics_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` ADD CONSTRAINT `fk_logistics_shipment_leg_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`vehicle`(`vehicle_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` ADD CONSTRAINT `fk_logistics_shipment_item_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ADD CONSTRAINT `fk_logistics_delivery_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ADD CONSTRAINT `fk_logistics_proof_of_delivery_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`delivery`(`delivery_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` ADD CONSTRAINT `fk_logistics_freight_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` ADD CONSTRAINT `fk_logistics_route_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` ADD CONSTRAINT `fk_logistics_route_stop_route_id` FOREIGN KEY (`route_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`route`(`route_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` ADD CONSTRAINT `fk_logistics_freight_audit_result_freight_invoice_id` FOREIGN KEY (`freight_invoice_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`freight_invoice`(`freight_invoice_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ADD CONSTRAINT `fk_logistics_tracking_event_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` ADD CONSTRAINT `fk_logistics_cold_chain_log_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` ADD CONSTRAINT `fk_logistics_transport_exception_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` ADD CONSTRAINT `fk_logistics_carrier_performance_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ADD CONSTRAINT `fk_logistics_third_party_provider_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` ADD CONSTRAINT `fk_logistics_customs_declaration_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` ADD CONSTRAINT `fk_logistics_freight_cost_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` ADD CONSTRAINT `fk_logistics_freight_rate_lane_id` FOREIGN KEY (`lane_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`lane`(`lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` ADD CONSTRAINT `fk_logistics_transport_unit_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` ADD CONSTRAINT `fk_logistics_vehicle_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` ADD CONSTRAINT `fk_logistics_handling_unit_logistics_shipment_id` FOREIGN KEY (`logistics_shipment_id`) REFERENCES `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment`(`logistics_shipment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`logistics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`logistics` SET TAGS ('dbx_domain' = 'logistics');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_contract` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`lane` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` SET TAGS ('dbx_ssot_reference' = 'distribution.distribution_shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_ssot_superseded_by' = 'distribution.distribution_shipment');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`logistics_shipment` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_leg` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`shipment_item` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`proof_of_delivery` ALTER COLUMN `recipient_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_order` SET TAGS ('dbx_subdomain' = 'transportation_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route` SET TAGS ('dbx_subdomain' = 'transportation_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`route_stop` SET TAGS ('dbx_subdomain' = 'transportation_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_invoice` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_audit_result` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`tracking_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`cold_chain_log` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_exception` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`carrier_performance` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `carrier_id` SET TAGS ('dbx_fix_siloed' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `carrier_id` SET TAGS ('dbx_relationship' = 'outgoing');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`third_party_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`customs_declaration` SET TAGS ('dbx_subdomain' = 'shipment_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_cost` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`freight_rate` SET TAGS ('dbx_subdomain' = 'carrier_management');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`transport_unit` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`vehicle` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`consolidation` SET TAGS ('dbx_subdomain' = 'transportation_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`logistics`.`handling_unit` SET TAGS ('dbx_subdomain' = 'asset_registry');
