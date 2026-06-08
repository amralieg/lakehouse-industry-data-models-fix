-- Schema for Domain: collection | Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`collection` COMMENT 'Core operational domain managing all waste collection, hauling, and transfer operations including residential/commercial pickup routes, transfer station consolidation, driver assignments, container placements, weight tickets, and outbound haul dispatch to disposal facilities.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`route` (
    `route_id` BIGINT COMMENT 'Unique identifier for the waste collection route. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Routes are assigned to service areas for franchise compliance, SLA on-time reporting, and revenue allocation by jurisdiction. Dispatchers and operations managers need to filter routes by service area.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Routes execute service commitments defined in customer contracts. Route planning, pricing validation, and SLA compliance reporting require linking routes to their governing agreements. Essential for c',
    `facility_id` BIGINT COMMENT 'Reference to the primary disposal facility (landfill, transfer station, Materials Recovery Facility (MRF), or Waste-to-Energy (WTE) plant) where collected waste is delivered.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Route planning requires direct reference to the landfill site to validate permitted waste types, daily receipt limits, and tipping fee schedules before dispatch. Dispatchers and route planners need th',
    `district_id` BIGINT COMMENT 'Reference to the operational district or region to which this route is assigned.',
    `dot_hazmat_classification_id` BIGINT COMMENT 'Foreign key linking to hazmat.dot_hazmat_classification. Business justification: DOT hazmat routes require specific placarding, tunnel/bridge routing restrictions, and vehicle type requirements based on hazard class. Linking route to dot_hazmat_classification enables automated rou',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.franchise_agreement. Business justification: Routes operate within franchise territories authorized by franchise agreements with municipalities. Linking routes to franchise agreements enables franchise compliance reporting (service scope, divers',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Routes are organized by service line (residential, commercial, industrial) for operational planning, fleet assignment, and pricing model selection. Essential for route optimization and resource alloca',
    `mrf_facility_id` BIGINT COMMENT 'Foreign key linking to recycling.mrf_facility. Business justification: A recycling collection route is designated to deliver material to a specific MRF. Route planning, material flow forecasting, MRF capacity scheduling, and diversion reporting all depend on knowing whic',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Collection routes operate under facility operating permits defining service areas, waste types, and operational constraints. Routes must comply with permitted activities and capacity limits. Essential',
    `driver_id` BIGINT COMMENT 'Reference to the driver typically assigned to this route. Actual daily assignments may vary and are tracked in route execution records.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Hazmat and special waste routes must comply with PHMSA routing regulations and state hazardous materials transport requirements. route has requires_hazmat_certification; linking to the governing regul',
    `route_optimization_run_id` BIGINT COMMENT 'Foreign key linking to collection.route_optimization_run. Business justification: A route is often created or updated as the output of a route_optimization_run. route has optimization_score (DECIMAL) which is a result of optimization, indicating a direct relationship exists. Adding',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Routes are designed for specific customer segments (residential, commercial, industrial). Normalizing customer_segment to a FK on segment enables segment-level route performance reporting, pricing tie',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Routes are governed by SLA definitions specifying on-time targets, service windows, and penalty thresholds. SLA breach reporting and auto-credit triggering require this link. Replaces denormalized sla',
    `vehicle_class_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_class. Business justification: Route planning and dispatch require matching routes to vehicle classes for capacity, CDL, and equipment requirements. truck_type_required is a denormalized vehicle_class reference. Fleet planners use ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Route planning, vehicle selection, permit requirements, and diversion reporting all depend on the waste stream a route serves (MSW vs recycling vs organics). A domain expert expects routes to referenc',
    `capacity_constraint_tons` DECIMAL(18,2) COMMENT 'Maximum tonnage capacity for this route based on truck payload limits and disposal facility constraints.',
    `container_type_primary` STRING COMMENT 'Primary type of waste container serviced on this route: cart (residential curbside), bin (small commercial), dumpster (large commercial), compactor, or roll-off container.. Valid values are `cart|bin|dumpster|compactor|roll_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this route configuration is no longer effective. Null indicates the route is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this route configuration became or will become effective for scheduling and execution.',
    `end_location_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the route end location (typically a disposal facility, transfer station, or return depot).',
    `end_location_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the route end location (typically a disposal facility, transfer station, or return depot).',
    `estimated_duration_minutes` STRING COMMENT 'Planned duration in minutes to complete the entire route under normal conditions, including drive time and service time.',
    `estimated_fuel_consumption_gallons` DECIMAL(18,2) COMMENT 'Estimated fuel consumption in gallons for a typical execution of this route, used for budgeting and environmental reporting.',
    `estimated_ghg_emissions_co2e_kg` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions in kilograms of Carbon Dioxide Equivalent (CO2e) for a typical execution of this route, supporting sustainability and EPA reporting.',
    `estimated_tonnage` DECIMAL(18,2) COMMENT 'Expected total tonnage of waste to be collected on a typical execution of this route, used for capacity planning.',
    `fuel_type_required` STRING COMMENT 'Type of fuel required for vehicles assigned to this route: diesel, Compressed Natural Gas (CNG), Renewable Natural Gas (RNG), electric, or hybrid.. Valid values are `diesel|CNG|RNG|electric|hybrid`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was last updated, reflecting any changes to route configuration, status, or attributes.',
    `notes` STRING COMMENT 'Free-text operational notes for drivers and dispatchers, including special instructions, access restrictions, or customer service considerations.',
    `optimization_score` DECIMAL(18,2) COMMENT 'Efficiency score (0-100) assigned by route optimization algorithms, reflecting factors such as mileage efficiency, stop density, and time utilization.',
    `priority` STRING COMMENT 'Business priority level for this route, used in dispatch and resource allocation decisions: critical (must-run, high-value customers), high, normal, or low.. Valid values are `critical|high|normal|low`',
    `requires_cdl` BOOLEAN COMMENT 'Indicates whether a Commercial Driver License (CDL) is required to operate the vehicle type assigned to this route.',
    `requires_hazmat_certification` BOOLEAN COMMENT 'Indicates whether hazardous materials handling certification is required for drivers on this route due to the nature of waste collected.',
    `route_code` STRING COMMENT 'Business identifier for the route, used in operational systems and driver communications. Typically alphanumeric code assigned by dispatch.. Valid values are `^[A-Z0-9]{4,12}$`',
    `route_name` STRING COMMENT 'Human-readable name or description of the route, often including geographic area or customer segment (e.g., Downtown Commercial MSW Monday).',
    `route_status` STRING COMMENT 'Current lifecycle status of the route: active (in regular operation), inactive (temporarily not scheduled), suspended (on hold), planned (designed but not yet operational), or retired (permanently discontinued).. Valid values are `active|inactive|suspended|planned|retired`',
    `scheduled_day_of_week` STRING COMMENT 'Primary day of the week this route is scheduled to run (for weekly/biweekly routes). Multiple days may result in multiple route records or a separate schedule table.. Valid values are `monday|tuesday|wednesday|thursday|friday|saturday`',
    `service_frequency` STRING COMMENT 'How often this route is executed: daily, weekly, biweekly, monthly, or on-demand.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `start_location_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the route start location (typically a depot or transfer station).',
    `start_location_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the route start location (typically a depot or transfer station).',
    `total_mileage` DECIMAL(18,2) COMMENT 'Total planned mileage for the route in miles, including travel to first stop, between stops, and return to facility.',
    `total_stops` STRING COMMENT 'Total number of scheduled service stops (customer pickup points) on this route.',
    `zone_code` STRING COMMENT 'Sub-district zone code for finer geographic segmentation within a district.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_route PRIMARY KEY(`route_id`)
) COMMENT 'Master record for a defined waste collection route, representing a named geographic sequence of stops assigned to a specific truck type (ASL, FEL, REL) and service line (MSW, C&D, bulk). Captures route code, district, zone, day-of-week schedule, estimated duration, total stops, total mileage, truck type requirement, service frequency, capacity constraints, and active status. Sourced from AMCS Platform route master. This is the canonical route definition — the template from which daily route executions are generated. One route may produce multiple executions per week depending on service frequency.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`route_execution` (
    `route_execution_id` BIGINT COMMENT 'Unique identifier for a single days execution of a route. Primary key representing the operational instance of a route on a specific service date.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Regulatory inspectors observe route executions during field inspections to verify collection protocols, safety standards, and permit compliance. Direct inspection-to-operation link for enforcement and',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Route executions fulfill contractual service obligations. Performance obligation satisfaction, revenue recognition, and SLA compliance measurement require linking executions to contracts. Critical for',
    `facility_id` BIGINT COMMENT 'Reference to the landfill, transfer station, or disposal facility where collected waste was delivered.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Route executions disposing directly at landfills (vs. transfer stations) need landfill site FK for operational tracking, capacity planning, waste flow analysis, and route-to-disposal reporting. Real d',
    `driver_id` BIGINT COMMENT 'Reference to the driver assigned to execute this route on the service date.',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Route executions transporting hazardous waste generate manifests for RCRA compliance. Essential for regulatory tracking of hazmat collection routes and proof-of-transport documentation required by EPA',
    `route_id` BIGINT COMMENT 'Reference to the master route definition that was executed. Links to the planned route template.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station used for waste consolidation during this route execution, if applicable.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection truck assigned to this route execution.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: When a vehicle or equipment failure occurs during a route execution, a corrective maintenance work order is generated. Linking route_execution to work_order enables operational reporting on maintenanc',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when the route execution was completed or terminated. Captured from GPS or driver mobile device.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when the driver began executing the route. Captured from GPS or driver mobile device.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the route execution was cancelled, if applicable. Null for completed routes.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of planned stops that were successfully completed. Calculated as (total_stops_completed / total_stops_planned) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route execution record was first created in the system. Audit trail for data lineage.',
    `customer_complaint_flag` BOOLEAN COMMENT 'Indicates whether any customer complaints were logged against this route execution. True if service quality issues were reported.',
    `dispatch_notes` STRING COMMENT 'Free-text notes from dispatch regarding special instructions, route changes, or operational considerations for this execution.',
    `distance_traveled_miles` DECIMAL(18,2) COMMENT 'Total distance traveled during route execution measured in miles. Captured from GPS telematics.',
    `driver_notes` STRING COMMENT 'Free-text notes entered by the driver regarding route conditions, exceptions, or issues encountered during execution.',
    `execution_status` STRING COMMENT 'Current lifecycle status of the route execution. Tracks progression from scheduled through completion or cancellation.. Valid values are `scheduled|in_progress|completed|incomplete|cancelled|suspended`',
    `fuel_consumed_gallons` DECIMAL(18,2) COMMENT 'Total fuel consumed by the vehicle during this route execution measured in gallons. Sourced from telematics or fuel card data.',
    `helper_assigned_flag` BOOLEAN COMMENT 'Indicates whether a helper or second crew member was assigned to assist with this route execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this route execution record was last updated. Audit trail for change tracking.',
    `number_of_dumps` STRING COMMENT 'Count of times the vehicle dumped its load at a disposal or transfer facility during this route execution.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether the route execution resulted in driver overtime hours. True if actual duration exceeded standard shift length.',
    `planned_end_time` TIMESTAMP COMMENT 'Scheduled completion time for the route execution as defined in the dispatch plan.',
    `planned_start_time` TIMESTAMP COMMENT 'Scheduled start time for the route execution as defined in the dispatch plan.',
    `route_duration_minutes` STRING COMMENT 'Total elapsed time from actual start to actual end of route execution measured in minutes.',
    `route_type` STRING COMMENT 'Classification of the route based on customer segment and waste stream. Determines service characteristics and equipment requirements.. Valid values are `residential|commercial|industrial|recycling|bulk|special`',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during this route execution. True if any OSHA-reportable or internal safety event was logged.',
    `service_date` DATE COMMENT 'The calendar date on which this route execution occurred. Represents the business event date for collection operations.',
    `service_frequency` STRING COMMENT 'Scheduled frequency of service for this route. Defines the recurring collection pattern.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `source_system` STRING COMMENT 'Identifies the operational system that originated this route execution record. Primary sources are AMCS Platform and Locus Dispatch.. Valid values are `AMCS|Locus|Geotab|Manual`',
    `total_stops_completed` STRING COMMENT 'Number of collection stops successfully serviced during this route execution.',
    `total_stops_missed` STRING COMMENT 'Number of planned stops that were not serviced during this route execution. Includes skipped, inaccessible, and cancelled stops.',
    `total_stops_planned` STRING COMMENT 'Number of collection stops scheduled for this route execution based on the route definition and service calendar.',
    `total_tonnage_collected` DECIMAL(18,2) COMMENT 'Total weight of waste collected during this route execution measured in tons. Key operational metric for capacity planning and billing.',
    `total_volume_collected_cubic_yards` DECIMAL(18,2) COMMENT 'Total volume of waste collected during this route execution measured in cubic yards. Used for capacity utilization analysis.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition during route execution. Impacts safety, efficiency, and completion rates. [ENUM-REF-CANDIDATE: clear|rain|snow|ice|fog|wind|extreme_heat — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_route_execution PRIMARY KEY(`route_execution_id`)
) COMMENT 'Transactional record capturing a single days actual execution of a route. Represents the operational instance of a route on a specific date, including assigned driver, assigned truck, planned vs. actual start/end times, total stops completed, total stops missed, total tonnage collected (TPD), route completion percentage, fuel consumed, and execution status (in-progress, completed, incomplete, cancelled). Sourced from AMCS Platform and Locus Dispatch. One record per route per service date.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`stop` (
    `stop_id` BIGINT COMMENT 'Unique identifier for the service stop. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.asset_container. Business justification: Route execution and driver mobile apps must directly identify the container at each stop for RFID scanning, contamination reporting, and service verification. Currently the stop-to-container relations',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Collection stops specify container type for vehicle compatibility, lift mechanism matching, and service pricing. Operations and billing depend on the canonical container type catalog. Replaces denorma',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Stops serve customer locations under specific service agreements. Billing validation, service commitment verification, and contract scope audits require linking stops to their governing contracts. Fun',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account being serviced at this stop.',
    `driver_id` BIGINT COMMENT 'Reference to the driver assigned to service this stop.',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Stops at hazmat generator sites reference EPA ID for regulatory tracking and service authorization. Required for verifying generator permit status at point of service.',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazardous_waste_generator. Business justification: RCRA compliance requires tracking generator category (LQG/SQG/VSQG) and accumulation deadlines at each stop. The hazardous_waste_generator record holds compliance status and accumulation limits that d',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Each stop represents delivery of a specific service offering (weekly MSW, bi-weekly recycling, bulk pickup). Critical for service fulfillment tracking, billing validation, SLA compliance monitoring, a',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Service stops must comply with permit conditions regarding acceptable waste types, service frequencies, and operational hours. Permit violations at stops trigger compliance actions and service restric',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Collection stops handling regulated waste streams (hazmat, medical, universal waste) must reference the applicable regulatory requirement governing handling procedures, PPE, and documentation. This li',
    `route_id` BIGINT COMMENT 'Reference to the route this stop belongs to. Links stop to its parent collection route.',
    `service_address_id` BIGINT COMMENT 'Reference to the physical service address where collection occurs.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection vehicle assigned to service this stop.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Collection stops at hazmat generator sites must reference the approved waste profile to enforce container type, PPE requirements, and special handling at the point of service. The stops special_handl',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Each collection stop is configured for a specific waste stream (recycling, MSW, organics). Contamination tracking, diversion rate reporting, and billing all require waste stream classification at the ',
    `access_instructions` STRING COMMENT 'Special instructions for accessing the service location, such as gate codes, key locations, or entry procedures.',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual timestamp when the collection vehicle arrived at this stop, captured via GPS telematics or driver input.',
    `actual_service_end_time` TIMESTAMP COMMENT 'Timestamp when service activity was completed at this stop.',
    `actual_service_start_time` TIMESTAMP COMMENT 'Timestamp when service activity began at this stop.',
    `cid_tag_identifiers` STRING COMMENT 'Comma-separated list of CID or RFID tag identifiers for containers at this stop, used for automated container tracking.',
    `container_count` STRING COMMENT 'Number of containers serviced at this stop during the visit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stop record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this stop was deactivated or service was terminated. Null for currently active stops.',
    `effective_start_date` DATE COMMENT 'Date when this stop became active and eligible for service.',
    `estimated_service_duration_minutes` STRING COMMENT 'Expected time in minutes required to complete service at this stop, used for route time calculations.',
    `geofence_radius_meters` STRING COMMENT 'Radius in meters defining the geofence boundary around the stop location, used to trigger automated arrival/departure events.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this stop is currently active and scheduled for service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stop record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the stop location in decimal degrees, used for GPS navigation and route optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the stop location in decimal degrees, used for GPS navigation and route optimization.',
    `planned_arrival_time` TIMESTAMP COMMENT 'Scheduled timestamp when the collection vehicle is expected to arrive at this stop, based on route optimization.',
    `planned_service_window_end` TIMESTAMP COMMENT 'End of the time window during which service is scheduled to occur.',
    `planned_service_window_start` TIMESTAMP COMMENT 'Beginning of the time window during which service is scheduled to occur, often used for commercial SLA commitments.',
    `requires_backup` BOOLEAN COMMENT 'Flag indicating whether the collection vehicle must back up to access this stop, relevant for safety and route planning.',
    `requires_ppe` BOOLEAN COMMENT 'Flag indicating whether specialized personal protective equipment is required for service at this stop due to hazardous materials or safety concerns.',
    `sequence_number` STRING COMMENT 'Ordinal position of this stop within the route. Determines the order in which the driver visits stops.',
    `service_day_of_week` STRING COMMENT 'Designated day of the week when this stop is scheduled for service. [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `service_frequency` STRING COMMENT 'Recurring schedule pattern for service at this stop.. Valid values are `daily|weekly|biweekly|monthly|on_demand|seasonal`',
    `skip_reason_code` STRING COMMENT 'Standardized code indicating why service was not completed at this stop, if applicable. [ENUM-REF-CANDIDATE: no_access|blocked|weather|customer_request|equipment_failure|safety_concern|no_waste_out — 7 candidates stripped; promote to reference product]',
    `skip_reason_notes` STRING COMMENT 'Free-text explanation providing additional context for why service was skipped.',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this stop record originated.. Valid values are `amcs|waste_logics|locus|manual`',
    `stop_number` STRING COMMENT 'Business identifier for the stop, often used in driver manifests and dispatch communications.',
    `stop_status` STRING COMMENT 'Current operational status of the stop within its service lifecycle.. Valid values are `scheduled|in_progress|completed|skipped|cancelled|suspended`',
    `stop_type` STRING COMMENT 'Classification of the stop based on customer segment and service characteristics.. Valid values are `residential|commercial|industrial|municipal|temporary|special_event`',
    `volume_collected_cubic_yards` DECIMAL(18,2) COMMENT 'Estimated volume in cubic yards of waste collected at this stop.',
    `weight_collected_lbs` DECIMAL(18,2) COMMENT 'Total weight in pounds of waste collected at this stop, captured via onboard scales or estimated.',
    CONSTRAINT pk_stop PRIMARY KEY(`stop_id`)
) COMMENT 'Master record for an individual service stop on a route, representing a physical service location (residential address or commercial site) with a defined sequence position. Captures stop sequence number, planned arrival window, estimated service duration, service address, customer account reference, container count, service type (curbside, alley, drive-in), access notes, CID/RFID tag identifiers for containers at this stop, special instructions (gate codes, back-up required), and stop status. Sourced from AMCS Platform and Waste Logics. SSOT for the stop-level service assignment and sequencing within a route.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`pickup_event` (
    `pickup_event_id` BIGINT COMMENT 'Unique identifier for the pickup event. Primary key for the pickup_event data product.',
    `asset_container_id` BIGINT COMMENT 'Identifier of the primary container serviced during this pickup event. Container Identification (CID) is the unique identifier assigned to each waste container for tracking and service verification.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Inspectors witness individual pickup events to verify proper handling procedures, contamination controls, and safety compliance. Direct observation relationship for regulatory verification and enforce',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Pickup events are billable service transactions governed by contracts. Invoice generation, overage charge calculation, and proof-of-service documentation require linking events to contracts. Essential',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this pickup event.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who performed the pickup service.',
    `ehs_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.ehs_incident. Business justification: Pickup events with safety_incident_flag=true must link to the EHS incident record for OSHA recordkeeping and regulatory reporting. The pickup event provides precise GPS location, timestamp, and waste ',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazardous_waste_generator. Business justification: Each hazmat pickup event updates the generators accumulation tracking under RCRA. A direct FK from pickup_event to hazardous_waste_generator enables real-time accumulation clock management, complianc',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Individual hazmat pickup events require manifest documentation per RCRA regulations. Links proof-of-service at container level to regulatory chain-of-custody for hazardous waste generators.',
    `route_execution_id` BIGINT COMMENT 'Identifier linking this pickup event to the parent route execution instance during which the pickup occurred.',
    `service_address_id` BIGINT COMMENT 'Identifier of the service address where the pickup occurred.',
    `service_schedule_id` BIGINT COMMENT 'Foreign key linking to collection.service_schedule. Business justification: A pickup_event is the actual execution of a scheduled service defined in service_schedule. Linking pickup_event to service_schedule enables SLA compliance tracking (was the scheduled service actually ',
    `stop_id` BIGINT COMMENT 'Foreign key linking to collection.collection_stop. Business justification: A pickup_event is the transactional execution of a service at a specific collection_stop. The pickup_event already has route_execution_id (the route-level parent) but lacks a direct FK to the stop-lev',
    `vehicle_id` BIGINT COMMENT 'Identifier of the collection vehicle used to perform the pickup.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Pickup events must be classified by waste stream for diversion reporting, contamination tracking, and billing. Regulatory compliance reports aggregate pickup events by waste stream. Replaces denormali',
    `arrival_timestamp` TIMESTAMP COMMENT 'Timestamp when the collection vehicle arrived at the service stop, captured from GPS telemetry.',
    `billable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this pickup event is billable to the customer account, used for revenue recognition and invoicing.',
    `compaction_ratio` DECIMAL(18,2) COMMENT 'Volume reduction ratio achieved by the compaction mechanism during this pickup, calculated as original volume divided by compacted volume.',
    `contamination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether contamination was detected in the waste stream, requiring special handling or customer notification.',
    `contamination_type` STRING COMMENT 'Type of contamination detected in the waste stream, if any, used for customer education and compliance tracking.. Valid values are `non_recyclable_material|hazardous_waste|liquid_waste|oversized_items|prohibited_material|none`',
    `customer_signature_captured_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a customer signature was captured as proof of service delivery, typically for special waste or high-value services.',
    `driver_notes` STRING COMMENT 'Free-text notes entered by the driver regarding service conditions, customer interactions, or issues encountered during pickup.',
    `estimated_weight_lbs` DECIMAL(18,2) COMMENT 'Estimated weight of waste collected in pounds, derived from onboard scale sensors or volumetric calculations.',
    `exception_code` STRING COMMENT 'Standardized code indicating the reason for service exception or non-completion, used for operational reporting and customer communication.. Valid values are `^[A-Z]{2,4}[0-9]{2,4}$`',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Accuracy of the GPS reading in meters, indicating the precision of the location capture.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the vehicle location at the time of service completion, used for proof of service and route verification.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the vehicle location at the time of service completion, used for proof of service and route verification.',
    `lift_confirmation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the Power Take-Off (PTO) sensor confirmed that the container was physically lifted and emptied.',
    `lift_count` STRING COMMENT 'Number of container lifts performed during this pickup event. Typically 1, but may be higher for multiple containers at a single stop.',
    `overage_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge amount in USD for overage conditions such as excess weight or extra containers, applied per contract terms.',
    `photo_captured_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a photo was captured during service for proof of service or documentation of service issues.',
    `photo_storage_url` STRING COMMENT 'URL reference to the stored photo image in the document management system, if a photo was captured.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pickup event record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pickup event record was last updated in the data platform.',
    `rfid_scan_status` STRING COMMENT 'Status of the RFID scan attempt indicating whether the container tag was successfully read, failed to read, or encountered other issues.. Valid values are `successful_read|no_read|damaged_tag|tag_missing|multiple_reads`',
    `rfid_tag_number` STRING COMMENT 'The Radio Frequency Identification (RFID) tag number scanned from the container at time of service, providing automated proof of service.. Valid values are `^[A-Z0-9]{10,20}$`',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a safety incident occurred during this pickup event, requiring incident reporting and investigation.',
    `scheduled_pickup_time` TIMESTAMP COMMENT 'The originally scheduled time for this pickup as planned in the route optimization system.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Monetary charge amount for this pickup service in USD, used for billing and revenue tracking.',
    `service_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the pickup service was completed and the vehicle departed the stop.',
    `service_duration_seconds` STRING COMMENT 'Total time in seconds spent at the stop from arrival to departure, used for route efficiency analysis.',
    `service_outcome` STRING COMMENT 'Final outcome of the pickup attempt indicating whether service was completed successfully or the reason for non-completion.. Valid values are `completed|skipped|contaminated|blocked|overweight|customer_not_ready`',
    `source_system` STRING COMMENT 'System of record that originated this pickup event data, used for data lineage and quality tracking.. Valid values are `locus_dispatch|amcs_platform|geotab|manual_entry`',
    `stop_sequence_number` STRING COMMENT 'Sequential order of this stop within the route execution, used for route optimization and performance analysis.',
    `truck_loader_type` STRING COMMENT 'Type of loading mechanism on the collection vehicle. ASL (Automated Side Loader), FEL (Front End Loader), REL (Rear End Loader), Roll-Off, or Side-Load.. Valid values are `asl|fel|rel|roll_off|side_load`',
    `weather_condition` STRING COMMENT 'Weather condition at the time of service, captured for safety analysis and route performance evaluation.. Valid values are `clear|rain|snow|ice|fog|wind`',
    CONSTRAINT pk_pickup_event PRIMARY KEY(`pickup_event_id`)
) COMMENT 'Transactional record capturing the actual execution of a single waste pickup at a stop during a route execution, including container-level proof of service via RFID. Records timestamp of arrival, timestamp of service completion, driver ID, truck ID, container(s) serviced (by CID/RFID), RFID scan result (successful read, no read, damaged tag), lift confirmation from PTO sensor, waste stream type (MSW, recycling, C&D, bulk), estimated weight or lift count, GPS coordinates at time of service, compaction ratio recorded, and service outcome (completed, skipped, contaminated). Sourced from Locus Dispatch, Geotab telemetry, and AMCS Platform RFID readers. Core operational event of the collection domain — SSOT for both service execution and container-level proof-of-service.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`service_exception` (
    `service_exception_id` BIGINT COMMENT 'Unique identifier for the service exception record. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Reference to the specific container involved in the exception event, tracked via Container Identification (CID) system.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to customer.complaint. Business justification: Service exceptions frequently generate customer complaints. Linking service_exception to the resulting complaint enables root cause analysis, repeat exception tracking, and regulatory escalation corre',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Compliance inspections at customer sites or transfer stations directly generate service exceptions (e.g., contaminated loads, improper waste segregation). Linking the triggering inspection to the serv',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Service exceptions may trigger SLA penalties, credits, or breach notifications defined in contracts. Exception resolution, penalty calculation, and contract compliance reporting require linking except',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account affected by this service exception.',
    `driver_id` BIGINT COMMENT 'Reference to the driver who reported or encountered the service exception.',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazardous_waste_generator. Business justification: Missed pickups at LQG/SQG sites can trigger RCRA accumulation time violations. Service exceptions at hazmat generator sites must reference the generator record to assess regulatory impact, trigger com',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Service exceptions (container damage, equipment failure at stop, access issues requiring physical changes) often trigger maintenance work orders for corrective action. Tracking the resulting WO enable',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Service exceptions involving hazmat loads (rejected pickup, contamination, discrepancy) must reference the RCRA manifest for regulatory chain-of-custody documentation. Manifest discrepancy reporting u',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service exceptions are tracked against specific offerings for SLA breach analysis, credit issuance, and service quality monitoring. Critical for customer satisfaction management, operational performan',
    `pickup_event_id` BIGINT COMMENT 'Foreign key linking to collection.pickup_event. Business justification: A service_exception is often triggered by or associated with a specific pickup_event (e.g., a contamination flag raised during a pickup, a missed lift recorded as an exception). Linking service_except',
    `route_id` BIGINT COMMENT 'Reference to the collection route where the exception occurred.',
    `regulatory_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_corrective_action. Business justification: Repeat contamination or hazmat service exceptions trigger regulatory corrective actions under EPA/state waste regulations. Operations managers must link service exceptions to their assigned corrective',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: A service_exception occurs during a specific route execution (a missed pickup, contamination event, etc.). service_exception already has primary_service_route_id -> route (the master route) but lacks ',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service address where the exception occurred.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Service exceptions (missed pickups, contamination events) occur against a specific enrolled service. Linking exceptions to enrollment enables SLA breach rate analysis per enrollment and supports credi',
    `service_request_id` BIGINT COMMENT 'Reference to the originating service request that this exception is associated with.',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Service exceptions that breach SLA must reference the governing SLA definition to calculate penalties, trigger auto-credits, and generate SLA breach reports. sla_breach_flag alone is insufficient — th',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: Service exceptions are SLA breach events measured against specific SLA terms. Linking exceptions to the breached sla_term enables penalty calculation, SLA performance reporting, and customer credit pr',
    `stop_id` BIGINT COMMENT 'Foreign key linking to collection.collection_stop. Business justification: A service_exception is tied to a specific collection_stop (e.g., missed pickup at stop #47, contamination at a specific address). service_exception has service_address_id (cross-domain) but no in-doma',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection vehicle involved in the exception event.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Service exceptions involving contamination, improper disposal, or safety violations trigger formal violation notices from regulatory agencies. Direct enforcement link between operational exceptions an',
    `contamination_severity` STRING COMMENT 'Severity level of contamination requiring different handling or customer education responses.. Valid values are `LOW|MODERATE|HIGH|CRITICAL`',
    `contamination_type` STRING COMMENT 'Specific type of contamination found in the container when exception type is contamination-related. [ENUM-REF-CANDIDATE: HAZARDOUS_WASTE|NON_RECYCLABLE|LIQUID|ELECTRONICS|BATTERIES|MEDICAL_WASTE|CONSTRUCTION_DEBRIS|OTHER — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service exception record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of credit issued to customer account due to service exception, in USD.',
    `credit_issued_flag` BOOLEAN COMMENT 'Indicates whether a billing credit was issued to the customer as a result of this exception.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified about the service exception.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified about the service exception.',
    `estimated_weight_lbs` DECIMAL(18,2) COMMENT 'Driver-estimated or system-calculated weight of material involved in the exception, measured in pounds.',
    `exception_description` STRING COMMENT 'Detailed narrative description of the service exception event, circumstances, and any relevant observations from the field.',
    `exception_number` STRING COMMENT 'Business-facing unique exception tracking number displayed to customers and service personnel.. Valid values are `^EXC-[0-9]{8}$`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the service exception indicating resolution progress.. Valid values are `OPEN|ACKNOWLEDGED|IN_PROGRESS|RESOLVED|CLOSED|CANCELLED`',
    `exception_timestamp` TIMESTAMP COMMENT 'Date and time when the service exception was encountered or reported by the driver in the field.',
    `exception_type_code` STRING COMMENT 'Standardized code categorizing the type of service exception encountered during collection operations. [ENUM-REF-CANDIDATE: MISSED_PICKUP|CONTAMINATION|BLOCKED_ACCESS|OVERWEIGHT|OVERFILLED|WRONG_MATERIAL|NO_CONTAINER|DAMAGED_CONTAINER|SAFETY_HAZARD|WEATHER_DELAY|EQUIPMENT_FAILURE|CUSTOMER_NOT_READY — 12 candidates stripped; promote to reference product]',
    `follow_up_scheduled_date` DATE COMMENT 'Scheduled date for follow-up service or resolution action related to this exception.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate where the exception occurred, captured from vehicle GPS system.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate where the exception occurred, captured from vehicle GPS system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service exception record was last updated or modified.',
    `photo_captured_flag` BOOLEAN COMMENT 'Indicates whether photographic evidence of the exception was captured by the driver or system.',
    `photo_storage_path` STRING COMMENT 'File system or cloud storage path reference to exception documentation photos.',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the exception was preventable through operational improvements or customer education.',
    `priority_level` STRING COMMENT 'Priority classification for exception resolution based on customer impact and service requirements.. Valid values are `LOW|MEDIUM|HIGH|URGENT`',
    `repeat_exception_flag` BOOLEAN COMMENT 'Indicates whether this is a recurring exception at the same service address or for the same customer.',
    `reported_by_source` STRING COMMENT 'Indicates the source or channel through which the exception was initially reported.. Valid values are `DRIVER|CUSTOMER|DISPATCHER|AUTOMATED_SYSTEM|SUPERVISOR`',
    `requires_follow_up_flag` BOOLEAN COMMENT 'Indicates whether this exception requires additional follow-up action or customer contact.',
    `reschedule_required_flag` BOOLEAN COMMENT 'Indicates whether the missed or incomplete service requires rescheduling on a future route.',
    `resolution_notes` STRING COMMENT 'Documentation of actions taken to resolve the exception and any follow-up required.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the service exception was marked as resolved or closed.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the underlying root cause of the service exception for trend analysis. [ENUM-REF-CANDIDATE: CUSTOMER_ERROR|DRIVER_ERROR|EQUIPMENT_FAILURE|ROUTE_PLANNING|WEATHER|ACCESS_ISSUE|CONTAMINATION|OTHER — 8 candidates stripped; promote to reference product]',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this exception resulted in a breach of the customer Service Level Agreement.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this service exception record.. Valid values are `AMCS|LOCUS|SALESFORCE|WASTE_LOGICS|GEOTAB`',
    CONSTRAINT pk_service_exception PRIMARY KEY(`service_exception_id`)
) COMMENT 'Transactional record for any non-standard service event during collection operations including missed pickups, contamination events, blocked access, overweight containers, and other exceptions requiring documentation and potential customer follow-up';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`container_placement` (
    `container_placement_id` BIGINT COMMENT 'Unique identifier for the container placement record. Primary key for tracking the assignment of a container to a specific service location.',
    `asset_container_id` BIGINT COMMENT 'Foreign key linking to asset.container. Business justification: Container placements track deployment/retrieval of specific container assets. Link to container master required for asset ownership verification, depreciation calculation, condition assessment, and ca',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Container placements must reference the canonical container type catalog for asset tracking, maintenance scheduling, and equipment inventory management. Replaces denormalized container_type plain colu',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Container placements fulfill service commitments in customer contracts. Equipment deployment tracking, billable placement charges, and contract scope verification require linking placements to agreeme',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that is assigned this container placement. Links the container to the billing and service account.',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazardous_waste_generator. Business justification: RCRA requires containers at LQG sites be removed within 90 days of accumulation start. Container placements at hazmat generator sites must reference the generator to enforce accumulation time limits, ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Container placements fulfill specific service offerings (temporary dumpster rental, permanent cart deployment). Essential for asset deployment tracking, service initiation billing, container inventory',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Container placements must comply with permit conditions regarding container types, waste streams, and placement locations. Permit restrictions govern placement activities and container management prog',
    `driver_id` BIGINT COMMENT 'Reference to the driver who performed the container removal. Links to the workforce employee record.',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle used to remove the container. Links to the fleet asset master record.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that authorized and tracked the container removal activity. Links to the work order management system.',
    `rfid_tag_id` BIGINT COMMENT 'Unique RFID tag identifier embedded in or attached to the container for automated tracking and identification during collection operations.',
    `route_id` BIGINT COMMENT 'Reference to the collection route assigned to service this container placement. Links to the route master record for dispatch and optimization.',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service location where the container is physically placed. Links to the service address master record.',
    `service_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_service_commitment. Business justification: Container placements physically fulfill contract service commitments specifying container type, size, and quantity. Linking placements to commitments enables contract fulfillment tracking, equipment d',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Container placements are triggered by service enrollments (container delivered when service starts). Linking placement to enrollment enables asset lifecycle tracking per enrollment and supports billin',
    `stop_id` BIGINT COMMENT 'Foreign key linking to collection.collection_stop. Business justification: A container_placement records the physical placement of a container at a service location. container_placement has route_id -> route and service_address_id (cross-domain) but no direct FK to the colle',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Hazmat container placements must match approved waste profiles to ensure proper container type, labeling, and compatibility. Prevents unauthorized waste accumulation and ensures RCRA compliance.',
    `actual_removal_date` DATE COMMENT 'Actual date when the container was physically removed from the service location. Marks the end of the container assignment lifecycle.',
    `cid` STRING COMMENT 'Unique Container Identification number assigned to the physical container. Industry-standard identifier used for tracking and asset management across the waste collection lifecycle.. Valid values are `^[A-Z0-9]{8,12}$`',
    `container_condition_at_placement` STRING COMMENT 'Physical condition assessment of the container at the time of placement. Used for asset lifecycle tracking and maintenance planning.. Valid values are `new|good|fair|damaged|needs-repair`',
    `container_condition_at_removal` STRING COMMENT 'Physical condition assessment of the container at the time of removal. Used for asset lifecycle tracking, maintenance planning, and loss tracking.. Valid values are `good|fair|damaged|needs-repair|lost|stolen`',
    `container_size` STRING COMMENT 'Physical capacity of the container expressed with unit of measure (e.g., 2-yd, 4-yd, 6-yd, 8-yd, 96-gal, 10-cu-yd, 20-cu-yd, 30-cu-yd, 40-cu-yd). Critical for route planning and capacity management.. Valid values are `^[0-9]+(yd|gal|cu-yd)$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this container placement record was first created in the source system. Audit trail for record lifecycle.',
    `is_billable` BOOLEAN COMMENT 'Flag indicating whether this container placement generates billable charges to the customer account. Some placements may be promotional, warranty replacements, or non-revenue generating.',
    `is_temporary_placement` BOOLEAN COMMENT 'Flag indicating whether this is a temporary container placement (e.g., roll-off for construction project, event-based service) versus a permanent ongoing service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this container placement record was last updated in the source system. Audit trail for record lifecycle.',
    `placement_accuracy_meters` DECIMAL(18,2) COMMENT 'GPS accuracy radius in meters for the placement coordinates. Indicates the precision of the recorded location.',
    `placement_date` DATE COMMENT 'Date when the container was physically placed at the service location. Marks the start of the container assignment lifecycle.',
    `placement_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the container placement location. Used for route optimization, asset tracking, and geospatial analytics.',
    `placement_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the container placement location. Used for route optimization, asset tracking, and geospatial analytics.',
    `placement_notes` STRING COMMENT 'Free-text notes recorded by the driver or dispatcher at the time of placement. Captures special instructions, access issues, or site-specific details.',
    `placement_reason` STRING COMMENT 'Business reason for the container placement. Indicates whether this is a new service, replacement, additional container, temporary placement, seasonal service, or event-based service.. Valid values are `new-service|replacement|additional|temporary|seasonal|event`',
    `placement_status` STRING COMMENT 'Current lifecycle status of the container placement. Tracks whether the container is actively in service, pending placement, pending removal, removed, relocated, damaged, or under repair. [ENUM-REF-CANDIDATE: active|pending-placement|pending-removal|removed|relocated|damaged|under-repair — 7 candidates stripped; promote to reference product]',
    `placement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the container was placed at the service location. Captured from GPS-enabled fleet telematics or driver mobile application.',
    `removal_notes` STRING COMMENT 'Free-text notes recorded by the driver or dispatcher at the time of removal. Captures condition issues, access problems, or other relevant observations.',
    `removal_reason` STRING COMMENT 'Business reason for the container removal. Indicates whether this is due to service termination, replacement, relocation, end of temporary service, seasonal end, customer request, non-payment, or damage. [ENUM-REF-CANDIDATE: service-termination|replacement|relocation|temporary-end|seasonal-end|customer-request|non-payment|damaged — 8 candidates stripped; promote to reference product]',
    `removal_timestamp` TIMESTAMP COMMENT 'Precise date and time when the container was removed from the service location. Captured from GPS-enabled fleet telematics or driver mobile application.',
    `scheduled_removal_date` DATE COMMENT 'Planned date for container removal from the service location. Used for temporary placements such as roll-off boxes or event-based service.',
    `service_frequency` STRING COMMENT 'Scheduled collection frequency for this container placement. Determines routing and service planning.. Valid values are `on-demand|daily|weekly|bi-weekly|monthly|quarterly`',
    `source_system` STRING COMMENT 'Operational system that originated this container placement record. Typically AMCS Platform or Waste Logics customer portal, but may include Salesforce CRM or manual entry.. Valid values are `amcs|waste-logics|salesforce|manual`',
    `source_system_code` STRING COMMENT 'Unique identifier for this container placement record in the source operational system. Used for data lineage and reconciliation.',
    CONSTRAINT pk_container_placement PRIMARY KEY(`container_placement_id`)
) COMMENT 'Master record tracking the physical placement and assignment of a container (dumpster, cart, roll-off box) at a customer service location. Captures container CID (Container Identification number), RFID tag ID, container type (2-yd dumpster, 4-yd, 6-yd, 8-yd, 96-gal cart, roll-off), size, material stream (MSW, recycling, organics, C&D), placement date, removal date, service address, customer account reference, placement status (active, pending removal, removed), and GPS coordinates of placement. Sourced from AMCS Platform and Waste Logics. SSOT for container-to-location assignment.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`driver_assignment` (
    `driver_assignment_id` BIGINT COMMENT 'Unique identifier for the driver assignment record. Primary key for this transactional entity capturing the assignment of a CDL-licensed driver to a specific route execution.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Driver assignments are scoped to service areas for dispatch management, SLA compliance tracking, and labor cost allocation by franchise area. Replaces denormalized service_area_code plain column with ',
    `facility_id` BIGINT COMMENT 'Identifier of the operations depot (facility) from which the driver and truck are dispatched for this route execution. Links to the facility master record.',
    `hos_log_id` BIGINT COMMENT 'Foreign key linking to fleet.hos_log. Business justification: Dispatch compliance requires linking driver assignments to the governing HOS log record for DOT Hours of Service verification. hos_available_drive_hours and hos_available_duty_hours are denormalized f',
    `pre_post_trip_inspection_id` BIGINT COMMENT 'Foreign key linking to fleet.pre_post_trip_inspection. Business justification: DOT FMCSA requires driver assignments to reference actual pre-trip inspection records. pre_trip_inspection_status and pre_trip_inspection_timestamp are denormalized from pre_post_trip_inspection. Safe',
    `driver_id` BIGINT COMMENT 'Identifier of the Commercial Driver License (CDL) licensed driver assigned to execute the route. Links to the driver master record in Workday HCM.',
    `route_execution_id` BIGINT COMMENT 'Identifier of the specific route execution instance that the driver is assigned to perform. Links to the route execution transactional record.',
    `training_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.training_certification. Business justification: Driver assignments for hazmat, CDL-required, or specialized routes require verification of active training certifications. driver_assignment has cdl_class_required and cdl_endorsements_required; linki',
    `transporter_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.transporter_registration. Business justification: RCRA and DOT require that drivers transporting hazardous waste work for a registered transporter with valid EPA ID and DOT operating authority. Driver assignments for hazmat routes must verify transpo',
    `vehicle_id` BIGINT COMMENT 'Identifier of the collection vehicle (truck) assigned to the driver for this route execution. Links to the fleet asset master record.',
    `absence_reason_code` STRING COMMENT 'Standardized code indicating the reason for driver absence if assignment status is absent. Sick for illness, vacation for planned time off, personal for personal leave, injury for work-related injury, no_show for unexcused absence, other for miscellaneous reasons. Null if driver reported for duty.. Valid values are `sick|vacation|personal|injury|no_show|other`',
    `actual_end_time` TIMESTAMP COMMENT 'The actual timestamp when the driver completed their shift and returned to the depot. Captured from Geotab Fleet Telematics GPS tracking or driver mobile app check-out. Used for performance analysis and variance reporting against scheduled end time.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual timestamp when the driver began their shift and commenced route execution. Captured from Geotab Fleet Telematics GPS tracking or driver mobile app check-in. Used for performance analysis and variance reporting against scheduled start time.',
    `assignment_created_by` STRING COMMENT 'Username or identifier of the dispatcher or system user who created this driver assignment record. Used for accountability and audit trail.',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this driver assignment record was first created in the Locus Dispatch system. Used for audit trail and assignment lead time analysis.',
    `assignment_modified_by` STRING COMMENT 'Username or identifier of the dispatcher or system user who last modified this driver assignment record. Used for accountability and audit trail.',
    `assignment_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this driver assignment record was last modified in the Locus Dispatch system. Used for audit trail and change tracking.',
    `assignment_notes` STRING COMMENT 'Free-text operational notes and special instructions for the driver assignment. May include route-specific guidance, customer alerts, safety warnings, or equipment requirements.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for the driver assignment, formatted as DA- followed by 10 digits. Used for operational tracking and communication.. Valid values are `^DA-[0-9]{10}$`',
    `assignment_priority` STRING COMMENT 'Priority classification of the driver assignment indicating urgency and importance. Critical for time-sensitive routes or service level agreement (SLA) commitments, high for premium customers, normal for standard service, low for flexible/deferred routes.. Valid values are `critical|high|normal|low`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the driver assignment. Scheduled indicates future planned assignment, active indicates driver is currently executing the route, completed indicates route execution finished, absent indicates driver did not report, cancelled indicates assignment was voided before execution.. Valid values are `scheduled|active|completed|absent|cancelled`',
    `assignment_type` STRING COMMENT 'Classification of the driver assignment indicating the role and responsibility level. Primary indicates regular assigned driver, relief indicates substitute coverage, trainee indicates driver under training supervision, backup indicates standby assignment, temporary indicates short-term fill-in.. Valid values are `primary|relief|trainee|backup|temporary`',
    `cdl_class_required` STRING COMMENT 'The minimum Commercial Driver License (CDL) class required to operate the assigned truck and execute the route. Class A for combination vehicles over 26,001 lbs, Class B for single vehicles over 26,001 lbs, Class C for vehicles designed to transport 16+ passengers or hazardous materials.. Valid values are `class_a|class_b|class_c`',
    `cdl_endorsements_required` STRING COMMENT 'Comma-separated list of CDL endorsements required for the assignment. Common endorsements include H (Hazardous Materials), N (Tank Vehicle), P (Passenger), S (School Bus), T (Double/Triple Trailers). Empty if no special endorsements required.',
    `dispatch_sequence` STRING COMMENT 'The sequential order in which this driver assignment was dispatched from the depot on the service date. Used for operational tracking and first-out/last-in analysis.',
    `dot_hos_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether the driver assignment complies with DOT hours-of-service regulations at the time of assignment. True indicates the driver has sufficient available hours and rest periods to legally execute the route, false indicates a compliance violation or risk.',
    `estimated_route_duration_hours` DECIMAL(18,2) COMMENT 'The estimated total duration in hours required to complete the assigned route execution, including driving time, service stops, and breaks. Used for scheduling and DOT hours-of-service compliance planning.',
    `helper_assigned_flag` BOOLEAN COMMENT 'Boolean indicator of whether a helper (second crew member) is assigned to assist the driver on this route execution. True indicates a two-person crew, false indicates solo driver operation. Common for residential rear-loader routes and heavy commercial pickups.',
    `route_type` STRING COMMENT 'Classification of the route type that the driver is assigned to execute. Residential for curbside household collection, commercial for business waste pickup, roll_off for large container haul, recycling for materials recovery collection, hazardous for special waste handling.. Valid values are `residential|commercial|roll_off|recycling|hazardous`',
    `service_date` DATE COMMENT 'The calendar date on which the driver is assigned to execute the route. This is the business event date for the assignment and the primary date dimension for operational reporting.',
    `shift_end_time` TIMESTAMP COMMENT 'The scheduled timestamp when the driver is expected to complete their shift and return to the depot. Used for workforce scheduling and DOT hours-of-service compliance tracking.',
    `shift_start_time` TIMESTAMP COMMENT 'The scheduled timestamp when the driver is expected to begin their shift and commence route execution. Used for workforce scheduling and Department of Transportation (DOT) hours-of-service compliance tracking.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this driver assignment record. Locus_dispatch for automated dispatch assignments, workday_hcm for workforce management initiated assignments, manual_entry for dispatcher-created assignments.. Valid values are `locus_dispatch|workday_hcm|manual_entry`',
    `source_system_record_code` STRING COMMENT 'The unique record identifier from the source operational system (Locus Dispatch or Workday HCM). Used for data lineage tracking and reconciliation with source systems.',
    CONSTRAINT pk_driver_assignment PRIMARY KEY(`driver_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a CDL-licensed driver to a specific route execution on a given service date. Records driver ID, route execution reference, truck ID, assignment type (primary, relief, trainee), shift start time, shift end time, pre-trip inspection status, DOT hours-of-service compliance flag, and assignment status (scheduled, active, completed, absent). Sourced from Locus Dispatch and Workday HCM. Enables driver performance tracking, DOT compliance, and route coverage management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`truck_assignment` (
    `truck_assignment_id` BIGINT COMMENT 'Unique identifier for the truck assignment record. Primary key for this transactional entity capturing the assignment of a collection vehicle to a route execution on a specific service date.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: truck_assignment records pre-trip and post-trip inspection statuses. When an inspection fails, a maintenance work order is generated to remediate the defect before dispatch. This link enables DOT comp',
    `pre_post_trip_inspection_id` BIGINT COMMENT 'Foreign key linking to fleet.pre_post_trip_inspection. Business justification: DOT FMCSA mandates linking vehicle assignments to actual inspection records. pre_trip_inspection_status/timestamp and post_trip_inspection_status/timestamp on truck_assignment are denormalized from pr',
    `facility_id` BIGINT COMMENT 'Reference to the facility or yard from which the truck was dispatched for this route execution. Typically a collection operations center, transfer station, or regional depot.',
    `route_execution_id` BIGINT COMMENT 'Reference to the specific route execution instance that this truck is assigned to perform. Links to the route_execution transactional record.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection vehicle (truck) assigned to this route execution. Links to the fleet vehicle master record.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the truck completed the route execution and returned to the facility or disposal site. Captured from Geotab GPS tracking or driver mobile app check-out.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the truck departed the facility or yard to begin route execution. Captured from Geotab GPS tracking or driver mobile app check-in.',
    `assignment_number` STRING COMMENT 'Business-readable identifier for this truck assignment, typically formatted as a combination of date, route, and sequence number for operational tracking and dispatch communication.',
    `assignment_priority` STRING COMMENT 'Priority classification for this truck assignment. Emergency assignments for service failures or complaints; special event for large-scale temporary collections; routine for standard scheduled service.. Valid values are `routine|priority|emergency|special_event`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the truck assignment. Tracks progression from initial scheduling through dispatch, execution, and completion or cancellation.. Valid values are `scheduled|dispatched|in_progress|completed|cancelled|reassigned`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the truck was assigned to the route execution. Represents the business event time when dispatch confirmed the vehicle-to-route pairing.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the truck assignment was cancelled before or during execution. Captures operational context for weather delays, vehicle failures, route cancellations, or customer service suspensions.',
    `capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Rated capacity of the assigned truck in cubic yards. Represents the maximum volume of waste the vehicle can carry per load, used for route optimization and load planning.',
    `capacity_tons` DECIMAL(18,2) COMMENT 'Rated weight capacity of the assigned truck in tons. Represents the maximum weight the vehicle can legally and safely carry, constrained by DOT regulations and vehicle GVWR.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this truck assignment record was first created in the system. Audit trail for record creation, distinct from the business assignment timestamp.',
    `environmental_incident_flag` BOOLEAN COMMENT 'Indicates whether an environmental incident occurred during this truck assignment. True if a spill, leak, unauthorized discharge, or EPA-reportable event was logged during route execution.',
    `fuel_type` STRING COMMENT 'Primary fuel or energy source for the assigned vehicle. CNG (Compressed Natural Gas), RNG (Renewable Natural Gas), diesel, electric, or hybrid powertrain. Critical for sustainability reporting and GHG emissions tracking.. Valid values are `diesel|CNG|RNG|electric|hybrid`',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether real-time GPS tracking was active for this truck assignment. True if Geotab telematics was operational and transmitting location data during route execution.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this truck assignment record was last modified. Audit trail for tracking updates to assignment status, times, or other attributes throughout the assignment lifecycle.',
    `notes` STRING COMMENT 'Free-text operational notes or comments related to this truck assignment. Captures dispatcher instructions, driver feedback, route conditions, or any contextual information relevant to the assignment execution.',
    `odometer_end` DECIMAL(18,2) COMMENT 'Odometer reading in miles at the time the truck completed the route execution and returned. Used to calculate route mileage and update vehicle lifecycle metrics.',
    `odometer_start` DECIMAL(18,2) COMMENT 'Odometer reading in miles at the time the truck was assigned and departed for route execution. Used for mileage tracking, fuel efficiency analysis, and preventive maintenance scheduling.',
    `reassignment_reason` STRING COMMENT 'Free-text explanation for why the truck was reassigned during route execution. Captures operational context for vehicle breakdowns, driver changes, route adjustments, or emergency redeployment.',
    `route_deviation_flag` BOOLEAN COMMENT 'Indicates whether the truck deviated from the planned route during execution. True if GPS tracking detected significant off-route travel, triggering operational review or customer service follow-up.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during this truck assignment. True if an accident, injury, near-miss, or OSHA-reportable event was logged during route execution.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned date and time when the truck is scheduled to begin the route execution. Used for dispatch planning and driver coordination.',
    `truck_type` STRING COMMENT 'Classification of the collection vehicle by body configuration and loading mechanism. ASL (Automated Side Loader), FEL (Front End Loader), REL (Rear End Loader), roll-off for container hauling, compactor for transfer operations. [ENUM-REF-CANDIDATE: ASL|FEL|REL|roll_off|compactor|hook_lift|grapple|flatbed — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_truck_assignment PRIMARY KEY(`truck_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a specific collection vehicle (ASL, FEL, REL, roll-off, CNG/RNG unit) to a route execution on a given service date. Records vehicle ID, route execution reference, truck type, fuel type (diesel, CNG, RNG), odometer at assignment, pre-trip inspection pass/fail, assigned capacity (cubic yards), and assignment status. Sourced from AMCS Platform and Geotab Fleet Telematics. Distinct from driver_assignment — a truck and driver are assigned independently and may change mid-route.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`service_schedule` (
    `service_schedule_id` BIGINT COMMENT 'Unique identifier for the service schedule record. Primary key.',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Service schedules specify container type for capacity planning, vehicle routing, and pricing. The canonical container type catalog governs lift compatibility and maintenance intervals. Replaces denorm',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owns this service schedule. Links to the customer account master record.',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Schedules reference standardized frequency plans (weekly, bi-weekly, on-demand) for consistent service delivery. Critical for route optimization, capacity planning, customer contract fulfillment, and ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service schedules define recurring delivery of specific offerings to customers. Essential for subscription management, automated billing, contract fulfillment tracking, and service level agreement enf',
    `program_id` BIGINT COMMENT 'Foreign key linking to recycling.recycling_program. Business justification: A service schedule for recycling collection fulfills a specific recycling program. Program compliance reporting, diversion target tracking, and schedule management all require knowing which recycling ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: State and local regulations mandate minimum collection frequencies for certain waste streams (e.g., weekly MSW collection, monthly hazardous waste pickup). Linking service_schedule to the governing re',
    `route_id` BIGINT COMMENT 'Foreign key linking to collection.route. Business justification: A service_schedule defines the recurring service schedule for a customer stop and must be associated with the route that services it. service_schedule has collection_stop_id -> collection_stop (and co',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service address where collection occurs. Links to the service address master record.',
    `service_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_service_commitment. Business justification: Service schedules operationalize contract service commitments — the commitment defines what is contracted (frequency, container type, waste stream); the schedule is the operational implementation. Thi',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Service schedules are operationalized from service enrollments. Billing reconciliation and SLA tracking require tracing each scheduled pickup back to the enrollment that contracted it. A waste managem',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Service schedules are governed by SLA definitions specifying on-time targets, service windows, and missed-pickup credit rules. Auto-credit triggering and SLA compliance reporting require this direct l',
    `sla_term_id` BIGINT COMMENT 'Reference to the SLA governing this service schedule. Defines performance commitments, response times, and service guarantees.',
    `stop_id` BIGINT COMMENT 'Reference to the collection stop associated with this schedule. Links to the stop master record.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Service schedules for hazmat generators must be validated against the approved waste profile to enforce container type, service frequency, and handling requirements. Profile expiration dates must trig',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Service schedules are waste-stream-specific — a customer may have separate schedules for recycling, MSW, and organics. Diversion reporting, billing, and route assignment all depend on waste stream at ',
    `access_requirements` STRING COMMENT 'Special access conditions required to service this stop. Used for driver preparation and route planning.. Valid values are `none|gate_code|key_required|escort_required|restricted_hours|call_ahead`',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether this schedule automatically renews at the end of its term. True if the schedule continues indefinitely unless cancelled.',
    `billing_frequency` STRING COMMENT 'Frequency at which the customer is billed for this scheduled service. May differ from service frequency.. Valid values are `per_service|weekly|monthly|quarterly|annual`',
    `container_quantity` STRING COMMENT 'Number of containers serviced at this stop per scheduled pickup. Used for capacity planning and billing calculations.',
    `container_size` DECIMAL(18,2) COMMENT 'Capacity of the container in cubic yards or gallons, depending on container type. Used for capacity planning and billing.',
    `container_size_unit` STRING COMMENT 'Unit of measure for the container size. Standardizes capacity reporting across different container types.. Valid values are `cubic_yards|gallons|liters`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service schedule record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this service schedule expires or is terminated. Nullable for open-ended schedules. Marks the end of the schedule validity period.',
    `effective_start_date` DATE COMMENT 'Date when this service schedule becomes active and service delivery begins. Marks the beginning of the schedule validity period.',
    `external_schedule_code` STRING COMMENT 'Unique identifier from the source operational system. Used for cross-system reconciliation and integration.',
    `friday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Fridays. True if Friday is a scheduled service day.',
    `holiday_handling_rule` STRING COMMENT 'Defines how service is adjusted when a scheduled day falls on a recognized holiday. Determines whether service is skipped, rescheduled, or delivered as normal.. Valid values are `skip|next_business_day|prior_business_day|same_day|no_adjustment`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service schedule record was last updated. Used for change tracking and audit trail.',
    `monday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Mondays. True if Monday is a scheduled service day.',
    `priority_level` STRING COMMENT 'Priority classification for service delivery. High and critical priorities receive preferential routing and must-complete status.. Valid values are `standard|high|critical|low`',
    `route_assignment_method` STRING COMMENT 'Method used to assign this schedule to collection routes. Fixed schedules are always on the same route; dynamic schedules are optimized daily.. Valid values are `fixed|dynamic|optimized|manual`',
    `saturday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Saturdays. True if Saturday is a scheduled service day.',
    `schedule_code` STRING COMMENT 'Business identifier for the service schedule. Human-readable code used in operations and customer communications.. Valid values are `^[A-Z0-9]{4,12}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the service schedule. Determines whether the schedule is operational and service should be delivered.. Valid values are `active|suspended|cancelled|pending|expired|on_hold`',
    `service_window_end_time` TIMESTAMP COMMENT 'Latest time of day when service can be performed at this stop. Format HH:MM in 24-hour notation. Used for route optimization and customer expectations.',
    `service_window_start_time` TIMESTAMP COMMENT 'Earliest time of day when service can be performed at this stop. Format HH:MM in 24-hour notation. Used for route optimization and customer expectations.',
    `source_system` STRING COMMENT 'Operational system that originated this service schedule record. Used for data lineage and reconciliation.. Valid values are `waste_logics|amcs|salesforce|manual_entry|data_migration`',
    `special_instructions` STRING COMMENT 'Free-text field for operational notes, access instructions, safety requirements, or customer-specific handling procedures. Displayed to drivers and dispatchers.',
    `sunday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Sundays. True if Sunday is a scheduled service day.',
    `suspension_reason` STRING COMMENT 'Reason code or description explaining why the schedule is suspended. Populated only when schedule_status is suspended. Used for customer service and reactivation workflows.',
    `thursday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Thursdays. True if Thursday is a scheduled service day.',
    `tuesday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Tuesdays. True if Tuesday is a scheduled service day.',
    `wednesday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Wednesdays. True if Wednesday is a scheduled service day.',
    CONSTRAINT pk_service_schedule PRIMARY KEY(`service_schedule_id`)
) COMMENT 'Master record defining the recurring service schedule for a customer stop — the days of week, frequency (weekly, bi-weekly, monthly, on-call), effective date range, and service windows. Captures customer account reference, stop reference, service frequency code, scheduled days of week, start date, end date, holiday handling rule, and schedule status. Sourced from Waste Logics and AMCS Platform. SSOT for when a customer is supposed to receive service — distinct from route_stop_sequence which defines the order within a route.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`route_optimization_run` (
    `route_optimization_run_id` BIGINT COMMENT 'Unique identifier for each execution of the route optimization algorithm. Primary key.',
    `area_id` BIGINT COMMENT 'Reference to the geographic service area for which this optimization was executed.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Route optimization runs are scoped to a specific waste stream — separate optimization runs are executed for MSW, recycling, and organics routes to ensure correct vehicle/container matching and regulat',
    `acceptance_decision` STRING COMMENT 'Indicates whether the optimized route plan was accepted for deployment (accepted), rejected by operations (rejected), awaiting management review (pending_review), or partially implemented (partially_accepted).. Valid values are `accepted|rejected|pending_review|partially_accepted`',
    `acceptance_decision_timestamp` TIMESTAMP COMMENT 'The date and time when the acceptance decision was made. Nullable if decision is still pending.',
    `algorithm_version` STRING COMMENT 'Version number of the route optimization algorithm used for this run, formatted as major.minor.patch (e.g., 3.2.1).. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `baseline_total_miles` DECIMAL(18,2) COMMENT 'Total route miles from the previous or baseline plan, used for comparison to measure optimization improvement. Nullable if no baseline exists.',
    `configuration_profile_code` BIGINT COMMENT 'Reference to the optimization configuration profile (parameter set) used for this run, defining weights, constraints, and objectives.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this optimization run record was first created in the system.',
    `effective_date` DATE COMMENT 'The target date for which the optimized routes were planned. This is the date the routes are intended to be executed in the field.',
    `error_message` STRING COMMENT 'Detailed error or exception message if the optimization run failed or encountered issues. Nullable if run completed successfully.',
    `execution_mode` STRING COMMENT 'Indicates how the optimization run was initiated: manual (user-triggered), scheduled (automated on schedule), automatic (event-driven), or api_triggered (external system integration).. Valid values are `manual|scheduled|automatic|api_triggered`',
    `input_driver_count` STRING COMMENT 'Total number of drivers available and included as input to the optimization algorithm.',
    `input_stop_count` STRING COMMENT 'Total number of customer stops (service locations) included as input to the optimization algorithm.',
    `input_truck_count` STRING COMMENT 'Total number of collection vehicles (trucks) available and included as input to the optimization algorithm.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this optimization run record was last updated in the system.',
    `miles_improvement_percentage` DECIMAL(18,2) COMMENT 'Percentage reduction in total route miles compared to the baseline plan. Positive values indicate improvement (fewer miles). Nullable if no baseline exists.',
    `notes` STRING COMMENT 'Free-text notes or comments added by operations staff regarding this optimization run, such as special considerations, manual adjustments, or business context.',
    `optimization_duration_seconds` STRING COMMENT 'Total elapsed time in seconds for the optimization algorithm to complete execution.',
    `optimization_end_timestamp` TIMESTAMP COMMENT 'The date and time when the optimization algorithm execution completed or terminated.',
    `optimization_quality_score` DECIMAL(18,2) COMMENT 'Algorithm-generated quality score (0-100) indicating how well the optimized solution meets the defined objectives and constraints. Higher scores indicate better optimization results.',
    `optimization_run_number` STRING COMMENT 'Business-friendly identifier for the optimization run, typically formatted as OPT-YYYYMMDD-HHMMSS for traceability.. Valid values are `^OPT-[0-9]{8}-[0-9]{6}$`',
    `optimization_scenario_type` STRING COMMENT 'The business scenario or trigger that initiated this optimization run, such as daily re-optimization, seasonal rebalancing, new customer onboarding, emergency reroute, capacity expansion, or service area change.. Valid values are `daily_reoptimization|seasonal_rebalancing|new_customer_onboarding|emergency_reroute|capacity_expansion|service_area_change`',
    `optimization_start_timestamp` TIMESTAMP COMMENT 'The date and time when the optimization algorithm execution began.',
    `optimization_status` STRING COMMENT 'Current lifecycle status of the optimization run: queued (awaiting execution), running (in progress), completed (successfully finished), failed (encountered errors), cancelled (manually stopped), or partially_accepted (some routes accepted, others rejected).. Valid values are `queued|running|completed|failed|cancelled|partially_accepted`',
    `output_average_hours_per_route` DECIMAL(18,2) COMMENT 'Average estimated time in hours per route in the optimized plan.',
    `output_average_miles_per_route` DECIMAL(18,2) COMMENT 'Average distance in miles per route in the optimized plan.',
    `output_average_stops_per_route` DECIMAL(18,2) COMMENT 'Average number of customer stops per route in the optimized plan.',
    `output_route_count` STRING COMMENT 'Total number of optimized routes generated by the algorithm as output.',
    `output_total_route_hours` DECIMAL(18,2) COMMENT 'Total estimated time in hours across all optimized routes, including drive time, service time, and breaks.',
    `output_total_route_miles` DECIMAL(18,2) COMMENT 'Total distance in miles across all optimized routes generated by the algorithm.',
    `output_unassigned_stop_count` STRING COMMENT 'Number of customer stops that could not be assigned to any route due to constraints (capacity, time windows, or other limitations).',
    `primary_optimization_objective` STRING COMMENT 'The primary business objective the optimization algorithm was configured to achieve: minimize total route miles, minimize total route time, maximize compaction efficiency, balance workload across drivers, minimize operational cost, or maximize service quality.. Valid values are `minimize_miles|minimize_time|maximize_compaction|balance_workload|minimize_cost|maximize_service_quality`',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by operations when the optimized plan was rejected or partially accepted. Nullable if plan was fully accepted or decision is pending.',
    `time_window_enforcement_flag` BOOLEAN COMMENT 'Indicates whether customer-specific time window constraints were enforced during optimization (True) or relaxed (False).',
    `vehicle_capacity_constraint_flag` BOOLEAN COMMENT 'Indicates whether vehicle capacity constraints (weight and volume limits) were enforced during optimization (True) or relaxed (False).',
    CONSTRAINT pk_route_optimization_run PRIMARY KEY(`route_optimization_run_id`)
) COMMENT 'Transactional record capturing each execution of the route optimization algorithm in AMCS Platform, including the optimization scenario (daily re-optimization, seasonal rebalancing, new customer onboarding), input parameters (number of stops, truck count, time windows, vehicle capacities), optimization objectives (minimize miles, minimize time, maximize compaction), output metrics (total route miles, total route hours, stops per truck), and whether the optimized plan was accepted or rejected. Sourced from AMCS Platform. Enables optimization performance tracking and scenario comparison.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`district` (
    `district_id` BIGINT COMMENT 'Primary key for district',
    `facility_id` BIGINT COMMENT 'Unique identifier of the depot or yard facility that services this district. References facility master data.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Collection districts operate under municipal solid waste collection permits issued by state/local agencies. The district-level permit governs collection frequency, waste types, and service area bounda',
    `transfer_station_id` BIGINT COMMENT 'Unique identifier of the primary transfer station where collected waste from this district is consolidated before outbound haul. References facility master data.',
    `area_square_miles` DECIMAL(18,2) COMMENT 'Geographic area of the district in square miles. Used for route density analysis and operational efficiency metrics.',
    `collection_frequency` STRING COMMENT 'Standard collection frequency for this district. Values: daily, weekly, biweekly, monthly, on_demand.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `commercial_account_count` STRING COMMENT 'Number of commercial customer accounts served in this district. Used for route planning and revenue forecasting.',
    `container_type_supported` STRING COMMENT 'Types of waste containers supported in this district (e.g., 96-gallon cart, 2-yard dumpster, 8-yard compactor). Comma-separated list.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was first created in the system.',
    `depot_location` STRING COMMENT 'Name or identifier of the primary depot or yard location that services this district.',
    `district_code` STRING COMMENT 'Business identifier code for the collection district used in operational systems and reporting. Typically alphanumeric, 2-10 characters.. Valid values are `^[A-Z0-9]{2,10}$`',
    `district_name` STRING COMMENT 'Human-readable name of the collection district (e.g., North Metro District, Downtown Commercial Zone).',
    `district_status` STRING COMMENT 'Current operational status of the district. Values: active (currently serviced), inactive (no longer serviced), planned (future service area), suspended (temporarily not serviced).. Valid values are `active|inactive|planned|suspended`',
    `diversion_rate_target` DECIMAL(18,2) COMMENT 'Target percentage of waste diverted from landfill through recycling, composting, and other programs. Expressed as a percentage (0.00 to 100.00).',
    `effective_date` DATE COMMENT 'Date when this district configuration became effective and operational.',
    `end_time` TIMESTAMP COMMENT 'Standard end time for collection operations in this district (HH:MM format, 24-hour clock).',
    `expiration_date` DATE COMMENT 'Date when this district configuration expires or is scheduled to be deactivated. Null if no expiration is planned.',
    `fuel_type` STRING COMMENT 'Primary fuel type used by collection vehicles in this district. Values: diesel, compressed_natural_gas (CNG), renewable_natural_gas (RNG), electric, hybrid.. Valid values are `diesel|compressed_natural_gas|renewable_natural_gas|electric|hybrid`',
    `geographic_boundary_description` STRING COMMENT 'Textual description of the geographic boundaries of the district (e.g., Bounded by Main St to the north, Highway 101 to the south).',
    `hazmat_collection_allowed` BOOLEAN COMMENT 'Indicates whether hazardous waste collection is permitted in this district. True if allowed, False if not. Subject to RCRA and DOT regulations.',
    `household_count` STRING COMMENT 'Number of residential households served in this district. Used for route planning and service level analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was last updated in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments about this district, including special operational considerations, historical context, or configuration details.',
    `organics_program_active` BOOLEAN COMMENT 'Indicates whether an organics/composting collection program is active in this district. True if active, False if not.',
    `population_served` STRING COMMENT 'Estimated population count served by this collection district. Used for capacity planning and regulatory reporting.',
    `recycling_program_active` BOOLEAN COMMENT 'Indicates whether a recycling collection program is active in this district. True if active, False if not.',
    `route_count` STRING COMMENT 'Number of active collection routes operating within this district. Used for resource allocation and performance tracking.',
    `service_days` STRING COMMENT 'Days of the week when collection service is provided in this district (e.g., Monday, Wednesday, Friday).',
    `service_type` STRING COMMENT 'Primary type of waste collection service supported in this district. Values: residential (single-family/multi-family), commercial (business/retail), industrial (manufacturing/warehouse), construction_demolition (C&D waste), mixed (multiple service types).. Valid values are `residential|commercial|industrial|construction_demolition|mixed`',
    `source_system` STRING COMMENT 'Name of the source system from which this district record originated (e.g., AMCS Platform, SAP S/4HANA).',
    `start_time` TIMESTAMP COMMENT 'Standard start time for collection operations in this district (HH:MM format, 24-hour clock).',
    `vehicle_type_required` STRING COMMENT 'Primary type of collection vehicle required for this district. Values: automated_side_loader (ASL), front_end_loader (FEL), rear_end_loader (REL), roll_off, mixed.. Valid values are `automated_side_loader|front_end_loader|rear_end_loader|roll_off|mixed`',
    `zone_code` STRING COMMENT 'Sub-district zone code used for finer geographic segmentation within the district. Alphanumeric, 1-6 characters.. Valid values are `^[A-Z0-9]{1,6}$`',
    CONSTRAINT pk_district PRIMARY KEY(`district_id`)
) COMMENT 'Master reference entity defining the geographic collection districts and zones used to organize route planning and operational management. Captures district code, district name, zone code, municipality or jurisdiction, geographic boundary description, service type supported (residential, commercial, C&D), assigned operations manager, and active status. Sourced from AMCS Platform geographic configuration. Enables geographic reporting, district-level performance management, and regulatory jurisdiction alignment.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`on_demand_request` (
    `on_demand_request_id` BIGINT COMMENT 'Unique identifier for the on-demand collection request. Primary key for this transactional entity.',
    `driver_id` BIGINT COMMENT 'Reference to the driver assigned to fulfill this on-demand request. Links to workforce management system for labor tracking and performance metrics.',
    `route_id` BIGINT COMMENT 'Reference to the collection route to which this on-demand request has been assigned for fulfillment. Used for driver dispatch and operational tracking.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection vehicle assigned to fulfill this request. Used for fleet utilization tracking and capacity validation.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: On-demand requests are placed by a specific contact person at the customer account. Linking to contact enables CRM tracking of request history per contact, supports communication preferences for sched',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: On-demand requests specify container type for equipment dispatch, pricing, and vehicle compatibility. The canonical container type catalog is required for accurate billing and asset assignment. Replac',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: On-demand requests may be governed by master service agreements defining pricing, terms, and SLAs. Pricing validation, contract entitlement verification, and ad-hoc service billing require linking req',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that initiated this on-demand request. Links to the customer master data.',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazardous_waste_generator. Business justification: On-demand hazmat pickup requests must verify generator compliance status and accumulation deadlines before scheduling. Generator category determines manifest requirements and approved service types. T',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: On-demand requests are for specific service offerings (bulk pickup, special waste collection, extra pickup). Essential for ad-hoc service fulfillment, dynamic pricing calculation, resource dispatch, a',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: On-demand requests for special waste streams (hazardous, construction debris, medical) require permit verification before service dispatch. Operations must confirm the applicable permit is active and ',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: When an on_demand_request is fulfilled, it is executed as part of a specific route_execution. on_demand_request has assigned_route_id -> route (the planned route) but lacks a FK to the actual route_ex',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service location where the on-demand collection will occur.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: On-demand pickups are placed against an active service enrollment to apply correct contracted rate codes and verify service eligibility. Billing and contract compliance require linking each on-demand ',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to customer.service_request. Business justification: A customer service_request (e.g., extra pickup request) generates an operational on_demand_request for dispatch. Linking them enables end-to-end tracing from customer-initiated request to operational ',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: On-demand requests are governed by SLA definitions specifying response time targets and completion windows. sla_met_flag evaluation and penalty calculation require the governing SLA definition. Replac',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: On-demand requests have sla_met_flag and sla_target_hours — the target hours are a denormalized copy of the contracted SLA term. Linking to sla_term enables SLA compliance reporting for on-demand serv',
    `special_waste_approval_id` BIGINT COMMENT 'Foreign key linking to landfill.special_waste_approval. Business justification: On-demand requests for special or industrial waste disposal require a landfill special waste pre-approval before scheduling. Customer service and compliance workflows depend on this link to verify app',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: On-demand hazmat pickup requests require waste profile matching to verify approved handling procedures, PPE requirements, and disposal facility acceptance before dispatching crew.',
    `actual_weight_tons` DECIMAL(18,2) COMMENT 'Actual weight of material collected in tons, measured at disposal facility or transfer station. Used for final billing calculation and operational reporting.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the on-demand request was cancelled or rejected. Populated when request_status is cancelled or rejected. Used for customer service analysis and process improvement.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the request was cancelled or rejected. Used for SLA tracking and operational metrics.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the on-demand collection service was completed by the driver. Captured from mobile device or telematics system at point of service.',
    `container_quantity` STRING COMMENT 'Number of containers or items to be collected for this on-demand request. Used for capacity planning and pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this on-demand request record was first created in the system. Used for SLA tracking and request aging analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this request. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `customer_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether customer signature was captured at time of service. Used for proof of delivery and billing validation.',
    `customer_signature_required_flag` BOOLEAN COMMENT 'Indicates whether customer signature is required to confirm service completion. True for high-value services or contractual requirements.',
    `disposal_fee_amount` DECIMAL(18,2) COMMENT 'Tipping fee or disposal cost charged for processing the collected material at landfill or transfer station in USD. Weight-based or flat fee depending on waste stream and facility.',
    `estimated_weight_tons` DECIMAL(18,2) COMMENT 'Estimated weight of material to be collected in tons. Used for vehicle capacity planning and preliminary billing calculation. Actual weight captured separately at disposal facility.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the service location where collection occurred. Captured from driver mobile device or vehicle telematics at time of service for location verification and route optimization analysis.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the service location where collection occurred. Captured from driver mobile device or vehicle telematics at time of service for location verification and route optimization analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this on-demand request record was last updated. Tracks any status changes, assignments, or data corrections throughout the request lifecycle.',
    `photo_captured_flag` BOOLEAN COMMENT 'Indicates whether driver captured photo documentation at time of service. Used for quality assurance and dispute resolution.',
    `photo_required_flag` BOOLEAN COMMENT 'Indicates whether photographic documentation is required for this request. True for high-value items, disputed services, or compliance documentation needs.',
    `priority_level` STRING COMMENT 'Service priority classification. Standard for normal scheduling, high for expedited service within 48 hours, urgent for same-day or next-day service, emergency for immediate health or safety hazards requiring rapid response.. Valid values are `standard|high|urgent|emergency`',
    `request_number` STRING COMMENT 'Externally visible unique business identifier for the on-demand request, formatted as ODR-NNNNNNNN. Used for customer communication and tracking.. Valid values are `^ODR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the on-demand request. Pending indicates awaiting review, scheduled means assigned to a route, dispatched means driver notified, in_progress means driver en route or on site, completed means service fulfilled, cancelled means customer or system cancelled, rejected means request denied due to service constraints or policy. [ENUM-REF-CANDIDATE: pending|scheduled|dispatched|in_progress|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `requested_service_date` DATE COMMENT 'Date requested by the customer for the on-demand collection service. May differ from actual scheduled date based on route availability and operational constraints.',
    `scheduled_service_date` DATE COMMENT 'Actual date scheduled for the collection service after route optimization and capacity planning. Confirmed date communicated to customer.',
    `scheduled_time_window_end` TIMESTAMP COMMENT 'End of the time window when the collection service is scheduled to occur. Defines customer expectation window for service completion.',
    `scheduled_time_window_start` TIMESTAMP COMMENT 'Beginning of the time window when the collection service is scheduled to occur. Provides customer with expected arrival timeframe.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Base service charge for the on-demand collection in USD. Calculated based on request type, container quantity, and rate schedule. Excludes taxes and additional fees.',
    `service_duration_minutes` STRING COMMENT 'Actual time spent by driver at service location in minutes, from arrival to departure. Used for labor costing, route optimization, and productivity analysis.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the service was completed within the SLA target timeframe. True if completion_timestamp minus created_timestamp is less than or equal to sla_target_hours. Used for performance reporting and customer satisfaction tracking.',
    `source_channel` STRING COMMENT 'Channel through which the on-demand request was initiated. Customer portal for self-service web, mobile app for customer mobile application, call center for phone requests, email for email submissions, field sales for in-person requests, CRM for internal service team entries.. Valid values are `customer_portal|mobile_app|call_center|email|field_sales|crm`',
    `special_instructions` STRING COMMENT 'Customer-provided or dispatcher-added instructions for the collection crew. May include access codes, placement details, safety notes, or material descriptions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax, VAT, or other applicable taxes charged on this on-demand service in USD. Calculated based on service address jurisdiction.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Total amount charged to customer for this on-demand request in USD, including service charge, disposal fee, additional fees, and taxes. Used for billing and revenue recognition.',
    CONSTRAINT pk_on_demand_request PRIMARY KEY(`on_demand_request_id`)
) COMMENT 'Transactional record for customer-initiated on-demand or special collection requests outside the standard recurring schedule — including bulk item pickup, extra bag/sticker service, special event cleanup, and on-call commercial pickups (excludes roll-off orders which have their own lifecycle). Captures request type, customer account reference, service address, requested service date, container type if applicable, waste stream, priority level, fulfillment status (pending, scheduled, completed, cancelled), assigned route or driver, and completion timestamp. Sourced from Waste Logics customer portal and Salesforce CRM service requests.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`rolloff_order` (
    `rolloff_order_id` BIGINT COMMENT 'Unique identifier for the roll-off container order. Primary key for this transactional record.',
    `asset_container_id` BIGINT COMMENT 'Reference to the specific roll-off container asset delivered for this order. Tracked via Container Identification (CID) system or RFID.',
    `driver_id` BIGINT COMMENT 'Reference to the driver assigned to deliver and pull this roll-off container. Driver must hold a valid Commercial Driver License (CDL).',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Rolloff orders are placed by a specific contact at the customer account. Linking to contact enables tracking of who authorized the order, supports delivery confirmation communications to the right per',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Rolloff containers require inspection, cleaning, or repair work orders before deployment to customer sites. Linking rolloff_order to the container preparation work order supports container readiness t',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Roll-off orders specify container type (10-yd, 20-yd, 40-yd roll-off) for equipment dispatch, rental pricing, and vehicle compatibility. The canonical container type catalog governs weight limits and ',
    `contract_id` BIGINT COMMENT 'Reference to the master service agreement or contract under which this roll-off order was placed. May be null for one-time orders.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that placed this roll-off order.',
    `facility_id` BIGINT COMMENT 'Reference to the landfill, transfer station, or Materials Recovery Facility (MRF) where the waste was disposed or processed.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Rolloff orders for construction/industrial waste are directed to specific landfill sites. Landfill site reference is required for tipping fee calculation, permitted waste type validation, and special ',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazardous_waste_generator. Business justification: Rolloff orders for hazmat generators must reference the generator record to verify generator category, accumulation limits, and manifest requirements before scheduling. Generator category (LQG vs SQG)',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Rolloff pulls of hazardous waste generate manifests for transport to TSDF facilities. Required for RCRA compliance when removing filled hazmat rolloff containers from generator sites.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Rolloff orders represent a distinct service offering type (temporary container rental) with specific pricing, handling, and billing rules. Critical for project-based service management, rental billing',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Rolloff orders for C&D debris, hazardous, or special waste require permit verification. rolloff_order stores permit_number as a denormalized string; replacing with a proper FK to compliance.permit ena',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: A rolloff_order (delivery, pull, or swap of a roll-off container) is executed as part of a route_execution. rolloff_order has assigned_driver_id and vehicle_id (cross-domain) but no FK to the route_ex',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the roll-off container will be delivered, serviced, and pulled.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Rolloff orders are placed under an active service enrollment for pricing and contract compliance. Linking rolloff orders to their governing enrollment enables enrollment-level revenue tracking and con',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to customer.service_request. Business justification: A customer service_request for rolloff delivery or pull generates a rolloff_order for operational dispatch. Linking them enables SLA compliance tracking from customer request submission to order compl',
    `special_waste_approval_id` BIGINT COMMENT 'Foreign key linking to landfill.special_waste_approval. Business justification: Rolloff orders for construction debris, industrial, or special waste require a landfill special waste pre-approval before disposal. Regulatory compliance and landfill gate acceptance depend on this ap',
    `vehicle_id` BIGINT COMMENT 'Reference to the roll-off truck (typically a Front End Loader or FEL) assigned to deliver and pull this container.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Rolloff orders for hazardous waste require pre-approved waste profiles before service authorization. Ensures proper container type, handling requirements, and TSDF acceptance before deployment.',
    `weight_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.weight_ticket. Business justification: rolloff_order has a denormalized weight_ticket_number (STRING) attribute that is a textual reference to the weight ticket. Replacing this with a proper FK weight_ticket_id -> weight_ticket.weight_tick',
    `actual_weight_tons` DECIMAL(18,2) COMMENT 'Actual weight of the loaded roll-off container in tons, captured at the disposal facility scale or transfer station.',
    `base_rental_charge` DECIMAL(18,2) COMMENT 'Base rental fee in USD for the roll-off container for the authorized rental duration.',
    `cancellation_reason` STRING COMMENT 'Reason code or description if the roll-off order was cancelled. Used for operational analysis and customer service improvement.',
    `container_size_yards` STRING COMMENT 'Size of the roll-off container in cubic yards. Common sizes: 10, 20, 30, 40 yards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this roll-off order record was first created in the operational system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts. Waste Management primarily operates in USD.. Valid values are `USD`',
    `delivery_actual_timestamp` TIMESTAMP COMMENT 'Actual date and time when the roll-off container was delivered to the service address. Captured via driver mobile app or GPS telematics.',
    `delivery_scheduled_date` DATE COMMENT 'Scheduled date for initial delivery of the roll-off container to the service address.',
    `disposal_charge` DECIMAL(18,2) COMMENT 'Charge in USD for disposal of the waste at the landfill or transfer station, based on actual weight and tipping fee schedule.',
    `environmental_fee` DECIMAL(18,2) COMMENT 'Regulatory environmental fee in USD assessed per order or per ton, as required by state or local environmental agencies.',
    `invoice_date` DATE COMMENT 'Date when the invoice for this roll-off order was generated and sent to the customer.',
    `invoice_number` STRING COMMENT 'Reference to the invoice generated for this roll-off order. Links order to accounts receivable and revenue recognition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this roll-off order record was last updated in the operational system.',
    `order_number` STRING COMMENT 'Externally-visible business identifier for the roll-off order. Used on customer communications, work orders, and invoices.. Valid values are `^RO-[0-9]{8,12}$`',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the customer placed the roll-off order. Principal business event timestamp for this transaction.',
    `order_status` STRING COMMENT 'Current lifecycle status of the roll-off order. Tracks progression from order placement through delivery, service, pull, and invoicing. [ENUM-REF-CANDIDATE: pending|scheduled|delivered|on_site|swapped|pulled|invoiced|cancelled — 8 candidates stripped; promote to reference product]',
    `overage_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge in USD for weight exceeding the authorized limit. Calculated as overage_weight_tons multiplied by per-ton overage rate.',
    `overage_weight_tons` DECIMAL(18,2) COMMENT 'Weight in tons exceeding the authorized weight limit. Used to calculate overage charges.',
    `payment_terms` STRING COMMENT 'Payment terms for this roll-off order, specifying the number of days until payment is due or prepayment requirement.. Valid values are `net_15|net_30|net_45|net_60|due_on_receipt|prepaid`',
    `permit_expiration_date` DATE COMMENT 'Expiration date of the placement permit. Container must be pulled before this date to maintain compliance.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a municipal or right-of-way permit is required for placement of the roll-off container at the service address.',
    `pull_actual_timestamp` TIMESTAMP COMMENT 'Actual date and time when the roll-off container was pulled from the service address. Captured via driver mobile app or GPS telematics.',
    `pull_scheduled_date` DATE COMMENT 'Scheduled date for final pull (removal) of the roll-off container from the service address.',
    `rental_duration_days` STRING COMMENT 'Number of days the roll-off container is authorized to remain on-site before additional rental charges apply.',
    `source_system` STRING COMMENT 'Operational system of record where this roll-off order was originally created. Used for data lineage and reconciliation.. Valid values are `AMCS|Waste_Logics|Salesforce|Manual`',
    `special_instructions` STRING COMMENT 'Free-text field for customer-provided or dispatcher-added special instructions for delivery, placement, or pull (e.g., gate code, placement location, access restrictions).',
    `swap_count` STRING COMMENT 'Number of times the roll-off container was swapped (full container pulled and empty container delivered) during the rental period.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Total charge in USD for the roll-off order, including base rental, disposal, overage, environmental fees, and taxes.',
    `weight_limit_tons` DECIMAL(18,2) COMMENT 'Maximum authorized weight in tons for the roll-off container. Overage charges apply if exceeded.',
    CONSTRAINT pk_rolloff_order PRIMARY KEY(`rolloff_order_id`)
) COMMENT 'Transactional record managing the full lifecycle of a roll-off container order for C&D, commercial, or industrial customers. Captures order number, customer account reference, service address, container size (10-yd, 20-yd, 30-yd, 40-yd), waste stream (C&D, MSW, clean fill, metal), delivery date, swap date(s), pull date, rental duration, weight limit, overage terms, permit required flag, permit number, assigned truck and driver, and order status (pending, delivered, on-site, swapped, pulled, invoiced). Sourced from Waste Logics and AMCS Platform. Distinct from standard recurring pickup — roll-off has its own delivery/swap/pull workflow.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`weight_ticket` (
    `weight_ticket_id` BIGINT COMMENT 'Unique identifier for the weight ticket record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Weight tickets must be attributed to service areas for franchise fee calculations, regulatory tonnage reporting by jurisdiction, and revenue allocation. Replaces denormalized service_area_code plain c',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Incoming loads at transfer stations and landfills are subject to compliance load inspections (waste characterization, prohibited materials checks). The weight ticket generated at the scale is the prim',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Weight tickets document tonnage against volume commitments and minimum tonnage guarantees in contracts. Volume commitment true-ups, shortfall penalty calculation, and contract performance reporting re',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account to be billed for tipping fees or disposal charges. May be null for internal company loads.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Weight tickets record tonnage delivered under disposal agreements. Linking weight tickets to disposal agreements enables minimum tonnage guarantee tracking, tipping fee billing reconciliation, and reg',
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Weight tickets record tonnage at disposal. Airspace consumption calculations and regulatory reporting require cell-level tonnage attribution. Existing FK covers landfill.site only. Landfill engineers ',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Weight tickets from collection routes disposing at landfills require landfill site reference for disposal tracking, regulatory reporting, tipping fee reconciliation, and landfill capacity management. ',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who delivered the load. Used for driver performance tracking and compliance verification.',
    `facility_id` BIGINT COMMENT 'Identifier of the disposal or transfer facility where the load was weighed and received (landfill, transfer station, MRF, WTE facility).',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazardous_waste_generator. Business justification: RCRA biennial reports require total waste generated by generator, aggregated from weight tickets. A direct FK from weight_ticket to hazardous_waste_generator enables accurate generator-level waste qua',
    `inbound_load_id` BIGINT COMMENT 'Foreign key linking to recycling.inbound_load. Business justification: Weight tickets from collection routes delivering recyclables to MRFs become inbound loads at the facility. This link enables material flow reconciliation, revenue allocation between collection and pro',
    `landfill_tipping_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to landfill.landfill_tipping_fee_schedule. Business justification: Weight tickets record tipping fees at disposal. Linking to the landfill fee schedule normalizes the denormalized tipping_fee_rate column and enables fee schedule auditing and billing reconciliation. F',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Weight tickets for hazardous waste loads must link to the official manifest record for regulatory compliance. Currently only manifest_number (string) exists; adding manifest_id FK enables proper track',
    `outbound_haul_id` BIGINT COMMENT 'Foreign key linking to collection.outbound_haul. Business justification: A weight_ticket is generated when a collection vehicle or outbound haul vehicle is weighed at a disposal facility. When an outbound_haul arrives at a destination facility, a weight_ticket is generated',
    `route_execution_id` BIGINT COMMENT 'Reference to the route execution record that generated this load. Links the weight ticket to the specific collection route run.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Weight tickets record tonnage collected under a specific service. Weight-based billing requires linking each weight ticket to the governing service enrollment to apply correct rate tiers and generate ',
    `transfer_station_id` BIGINT COMMENT 'Foreign key linking to collection.transfer_station. Business justification: Weight tickets are generated at disposal or transfer facilities. weight_ticket has facility_id (cross-domain to asset.facility) but no direct in-domain FK to transfer_station. When a collection vehicl',
    `vehicle_id` BIGINT COMMENT 'Identifier of the collection vehicle that delivered the load. Used for fleet performance tracking and tonnage attribution.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Weight tickets for hazardous waste loads require waste profile reference for LDR compliance verification, approved disposal method confirmation, and accurate billing. The profiles treatment standards',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Weight tickets must classify waste by regulatory waste stream for proper disposal routing, tipping fee calculation, and EPA compliance reporting. Essential for facility acceptance validation, environm',
    `billing_date` DATE COMMENT 'Date when this weight ticket was included in customer billing. Used for revenue recognition and accounts receivable aging.',
    `comments` STRING COMMENT 'Free-text comments or notes about this weight ticket entered by scale operator, driver, or facility supervisor. May include special handling instructions, load observations, or operational notes.',
    `contamination_flag` BOOLEAN COMMENT 'Indicates whether the load was flagged for contamination (prohibited materials in recycling stream, hazardous materials in MSW, etc.). True = contaminated, False = clean load.',
    `contamination_type` STRING COMMENT 'Description of contamination found in the load (e.g., non-recyclables in recycling stream, hazardous materials, prohibited items). Populated only if contamination_flag is True.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this weight ticket record was first created in the system. Used for audit trail and data lineage.',
    `facility_type` STRING COMMENT 'Type of facility that received the load. Landfill = final disposal site, Transfer Station = consolidation point, MRF = Materials Recovery Facility for recycling, WTE = Waste-to-Energy plant, TSDF = Treatment Storage and Disposal Facility for hazardous waste.. Valid values are `landfill|transfer_station|mrf|wte|tsdf|other`',
    `gross_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of the loaded vehicle in pounds, measured at weigh-in. Includes vehicle tare weight plus waste payload.',
    `invoice_number` STRING COMMENT 'Reference to the customer invoice that includes charges for this weight ticket. Populated after billing cycle completion.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `load_type` STRING COMMENT 'Classification of the load delivery. Full Route = completed collection route, Partial Route = mid-route dump, Direct Haul = single-customer large load, Emergency = unscheduled service, Special Waste = pre-approved non-standard material, Return Trip = second trip from same route.. Valid values are `full_route|partial_route|direct_haul|emergency|special_waste|return_trip`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this weight ticket record was last modified. Used for audit trail and change tracking.',
    `net_weight_lbs` DECIMAL(18,2) COMMENT 'Calculated net weight of waste payload in pounds (gross weight minus tare weight). Used for tonnage reporting and billing.',
    `net_weight_tons` DECIMAL(18,2) COMMENT 'Net weight of waste payload converted to US short tons (net_weight_lbs / 2000). Primary unit for TPD reporting, tipping fee calculation, and regulatory compliance.',
    `origin_type` STRING COMMENT 'Source classification of the waste collected. Used for waste characterization studies and regulatory reporting.. Valid values are `residential|commercial|industrial|municipal|construction|special_event`',
    `rejection_flag` BOOLEAN COMMENT 'Indicates whether the load was rejected and not accepted for disposal. True = rejected, False = accepted. Rejected loads must be redirected to appropriate facility.',
    `rejection_reason` STRING COMMENT 'Explanation for load rejection (e.g., hazardous materials present, wrong facility, no authorization, facility at capacity). Populated only if rejection_flag is True.',
    `source_system` STRING COMMENT 'System that originated this weight ticket record. Facility Scale = automated scale integration, AMCS = route management system, SAP SD = sales and distribution module, Manual Entry = scale operator input, Mobile App = driver mobile application.. Valid values are `facility_scale|amcs|sap_sd|manual_entry|mobile_app`',
    `source_system_code` STRING COMMENT 'Unique identifier of this weight ticket in the source system. Used for data lineage and reconciliation.',
    `tare_weight_lbs` DECIMAL(18,2) COMMENT 'Weight of the empty vehicle in pounds, measured at weigh-out. Subtracted from gross weight to determine net waste tonnage.',
    `ticket_number` STRING COMMENT 'Externally visible unique ticket number printed on the weight ticket document. Used for cross-reference with facility records and customer billing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `ticket_status` STRING COMMENT 'Current lifecycle status of the weight ticket. Draft = initial capture, Validated = scale operator approved, Billed = sent to customer billing, Disputed = under review, Voided = cancelled, Corrected = amended after issuance.. Valid values are `draft|validated|billed|disputed|voided|corrected`',
    `tipping_fee_amount` DECIMAL(18,2) COMMENT 'Total tipping fee charged for this load in USD (net_weight_tons × tipping_fee_rate). Feeds into customer billing and revenue recognition.',
    `validation_flag` BOOLEAN COMMENT 'Indicates whether the weight ticket has passed automated validation checks (weight reasonableness, vehicle capacity limits, duplicate detection). True = passed, False = requires manual review.',
    `validation_notes` STRING COMMENT 'Free-text notes documenting validation issues, manual overrides, or special circumstances related to this weight ticket.',
    `weigh_in_timestamp` TIMESTAMP COMMENT 'Date and time when the vehicle entered the scale for gross weight measurement. Represents the official transaction time for the weight ticket.',
    `weigh_out_timestamp` TIMESTAMP COMMENT 'Date and time when the vehicle exited the scale for tare weight measurement after unloading.',
    CONSTRAINT pk_weight_ticket PRIMARY KEY(`weight_ticket_id`)
) COMMENT 'Transactional record capturing the official weight measurement of a collection vehicle at a disposal or transfer facility upon completion of a route or partial load. Records truck ID, route execution reference, facility received at (landfill, transfer station, MRF, WTE), gross weight, tare weight, net weight (tons), waste stream, ticket number, scale operator ID, timestamp, and disposal authorization number. Sourced from facility scale systems and SAP SD. SSOT for tonnage data used in billing (tipping fees), regulatory reporting (TPD), and route performance measurement.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`transfer_station` (
    `transfer_station_id` BIGINT COMMENT 'Unique identifier for the transfer station facility. Primary key for the transfer station master record.',
    `mrf_facility_id` BIGINT COMMENT 'Foreign key linking to recycling.mrf_facility. Business justification: Transfer stations route segregated recyclables to a designated MRF. Diversion flow tracking, outbound load planning, and regulatory diversion rate reporting require knowing which MRF a transfer statio',
    `facility_id` BIGINT COMMENT 'FK to asset.facility.facility_id — Transfer stations are physical facilities tracked in the asset domain. This FK enables joining transfer operations to facility maintenance, inspections, and capital planning.',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Transfer stations are regulated facilities subject to comprehensive environmental permitting and oversight. Core facility registration relationship linking operational facilities to regulatory complia',
    `accepts_commercial_waste` BOOLEAN COMMENT 'Indicates whether the transfer station accepts commercial waste from business and industrial customers.',
    `accepts_construction_debris` BOOLEAN COMMENT 'Indicates whether the transfer station accepts construction and demolition waste materials.',
    `accepts_hazardous_waste` BOOLEAN COMMENT 'Indicates whether the transfer station is permitted and equipped to handle hazardous waste materials under RCRA regulations.',
    `accepts_recyclables` BOOLEAN COMMENT 'Indicates whether the transfer station accepts recyclable materials for processing or transfer to MRF facilities.',
    `accepts_residential_waste` BOOLEAN COMMENT 'Indicates whether the transfer station accepts residential MSW from collection routes.',
    `address_line_1` STRING COMMENT 'Primary street address line for the transfer station facility location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information for the transfer station facility.',
    `city` STRING COMMENT 'City or municipality where the transfer station facility is located.',
    `closure_date` DATE COMMENT 'Date when the transfer station ceased operations or was decommissioned. Null for active facilities.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the transfer station is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer station master record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this transfer station record became effective and the facility began operations or was added to the system.',
    `environmental_compliance_officer` STRING COMMENT 'Name of the environmental compliance officer responsible for regulatory compliance at this transfer station.',
    `facility_type` STRING COMMENT 'Classification of the transfer station by primary waste stream handled. MSW = Municipal Solid Waste, C&D = Construction and Demolition Waste.. Valid values are `MSW|C&D|mixed|recycling|organics|hazmat`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection by LEA or state environmental agency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer station master record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the transfer station facility in decimal degrees for GPS routing and geospatial analysis.',
    `lea_jurisdiction` STRING COMMENT 'Name of the Local Enforcement Agency with regulatory oversight and inspection authority over this transfer station.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the transfer station facility in decimal degrees for GPS routing and geospatial analysis.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required regulatory inspection of the transfer station.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for the transfer station on weekdays, typically in format HH:MM-HH:MM.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for the transfer station on weekends, typically in format HH:MM-HH:MM.',
    `operational_capacity_tpd` DECIMAL(18,2) COMMENT 'Actual operational throughput capacity in tons per day based on equipment, staffing, and facility configuration.',
    `operational_status` STRING COMMENT 'Current operational state of the transfer station facility in its lifecycle.. Valid values are `active|inactive|suspended|under_construction|decommissioned|seasonal`',
    `ownership_type` STRING COMMENT 'Legal ownership structure of the transfer station facility.. Valid values are `owned|leased|operated_under_contract|joint_venture`',
    `permit_expiration_date` DATE COMMENT 'Date when the current operating permit expires and renewal is required to continue operations.',
    `permit_number` STRING COMMENT 'Primary operating permit number issued by the regulatory authority authorizing waste transfer operations at this facility.',
    `permitted_capacity_tpd` DECIMAL(18,2) COMMENT 'Maximum daily throughput capacity in tons per day authorized by the operating permit for waste processing at this transfer station.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the transfer station facility address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `scale_count` STRING COMMENT 'Number of truck scales installed at the transfer station for weighing incoming and outgoing vehicles.',
    `scale_type` STRING COMMENT 'Primary type of weighing scale configuration used at the transfer station for weight ticket generation.. Valid values are `truck_scale|axle_scale|portable_scale|mixed`',
    `state_province` STRING COMMENT 'Two-letter state or province code where the transfer station is located.. Valid values are `^[A-Z]{2}$`',
    `station_code` STRING COMMENT 'Business identifier code for the transfer station facility used in operational systems and reporting. Externally-known unique code for the facility.. Valid values are `^[A-Z0-9]{4,12}$`',
    `station_name` STRING COMMENT 'Official business name of the transfer station facility as registered with regulatory authorities and used in customer communications.',
    `tipping_floor_area_sqft` DECIMAL(18,2) COMMENT 'Total area of the tipping floor in square feet where incoming waste is unloaded and staged for processing.',
    CONSTRAINT pk_transfer_station PRIMARY KEY(`transfer_station_id`)
) COMMENT 'Master record for each transfer station facility operated by Waste Management. Captures facility identity, physical address, geographic coordinates, permitted capacity (TPD), operating hours, facility type (MSW, C&D, mixed), regulatory permit numbers, EPA/state facility ID, LEA jurisdiction, scale configuration, tipping floor dimensions, and operational status. This is the SSOT for transfer station facility master data and serves as the anchor entity for all inbound/outbound operations at the facility.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`load_ticket` (
    `load_ticket_id` BIGINT COMMENT 'Unique identifier for the inbound load ticket record. Primary key for the load ticket entity.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Load tickets must be attributed to service areas for franchise fee allocation, regulatory tonnage reporting by jurisdiction, and revenue recognition. waste_origin_jurisdiction is a regulatory string w',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Load tickets at disposal facilities record gate-level load inspections (pre_entry_inspection_result exists on load_ticket). Linking to the formal compliance_inspection record enables regulatory audit ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer or municipal account responsible for this load. Used for tipping fee billing and revenue allocation.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Load tickets track tonnage delivered under disposal agreements with landfills/WTE facilities. Contracted capacity utilization, tipping fee reconciliation, and disposal agreement compliance reporting r',
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Load tickets record actual waste disposal events. Landfill regulatory reporting (airspace consumption, permitted capacity tracking) requires cell-level attribution of each load. Existing FK covers lan',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Transfer station load tickets for outbound hauls to landfills require landfill site reference for waste tracking, regulatory chain-of-custody, and transfer-to-landfill flow reporting. Core transfer st',
    `driver_id` BIGINT COMMENT 'Reference to the driver who delivered this load. Used for performance tracking and compliance verification.',
    `inbound_load_id` BIGINT COMMENT 'Foreign key linking to recycling.inbound_load. Business justification: Transfer station load tickets for recyclable material correspond to MRF inbound loads when material is transferred for processing. This link is essential for end-to-end material tracking, tipping fee ',
    `landfill_tipping_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to landfill.landfill_tipping_fee_schedule. Business justification: Load tickets record tipping fees charged at landfill disposal. Linking to the fee schedule normalizes the denormalized tipping_fee_rate column and supports fee schedule auditing, billing reconciliatio',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Load tickets for hazardous waste must be traceable to the RCRA manifest for chain-of-custody compliance. The load_ticket has manifest_number as denormalized text; a proper FK enables regulatory audit ',
    `facility_id` BIGINT COMMENT 'Reference to the final disposal facility (landfill, WTE plant, MRF) where this load will be hauled after transfer station consolidation.',
    `outbound_haul_id` BIGINT COMMENT 'Foreign key linking to collection.outbound_haul. Business justification: A load_ticket is the inbound tipping ticket at a transfer station. After consolidation, the material from multiple load_tickets is dispatched as an outbound_haul. Linking load_ticket to outbound_haul ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Load tickets document waste acceptance under specific permit authorizations. Permits define acceptable waste types, quantities, and handling requirements for each load received at transfer stations.',
    `route_execution_id` BIGINT COMMENT 'Reference to the originating route execution if this load was collected on a scheduled route. Null for third-party haulers or direct customer deliveries.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Load tickets at transfer stations record material received from a customers service. Linking to service_enrollment enables per-enrollment disposal tracking, tipping fee allocation, and diversion rate',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station facility where this load was received and weighed.',
    `vehicle_id` BIGINT COMMENT 'Reference to the truck or vehicle that delivered this load to the transfer station.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Transfer station gate acceptance of hazardous waste loads requires verifying the load matches the approved waste profile before entry. Load ticket gate-check process depends on this link to enforce pr',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Load tickets at transfer stations classify inbound waste by regulatory stream for proper handling, outbound haul planning, and disposal routing. Critical for transfer station operations, regulatory co',
    `acceptance_decision` STRING COMMENT 'Final decision on whether the load was accepted for disposal, rejected, or conditionally accepted with restrictions or additional fees.. Valid values are `accepted|rejected|conditional`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this load ticket is eligible for customer billing. False for rejected loads, voided tickets, or internal transfers.',
    `contamination_level` STRING COMMENT 'Assessment of contamination or prohibited materials in the load. High contamination may trigger rejection or additional processing fees.. Valid values are `none|low|moderate|high|rejected`',
    `contamination_type` STRING COMMENT 'Description of specific contaminants identified in the load (e.g., hazardous materials in MSW, non-recyclables in recycling stream, liquids in C&D).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this load ticket record was first created in the database. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this ticket. Typically USD for US operations.. Valid values are `USD|CAD|MXN`',
    `disposal_authorization_number` STRING COMMENT 'Pre-authorization or permit number authorizing disposal of this specific load. Required for certain waste streams or customer contracts.',
    `driver_cdl_number` STRING COMMENT 'The drivers Commercial Driver License number verified at gate entry. Required for DOT compliance and hazardous waste handling authorization.',
    `environmental_fee_amount` DECIMAL(18,2) COMMENT 'Additional environmental surcharge or regulatory fee applied to this load based on jurisdiction requirements or waste stream type.',
    `gate_entry_timestamp` TIMESTAMP COMMENT 'Date and time when the vehicle entered the transfer station gate. Used for queue time analysis and facility throughput metrics.',
    `gate_exit_timestamp` TIMESTAMP COMMENT 'Date and time when the vehicle exited the transfer station gate. Used for total facility dwell time calculation.',
    `gross_weight_tons` DECIMAL(18,2) COMMENT 'Total weight of the vehicle with load measured at weigh-in, expressed in tons. Used to calculate net payload weight.',
    `hauler_type` STRING COMMENT 'Classification of the entity that delivered this load: company-owned fleet, third-party contractor, municipal vehicle, or customer self-haul.. Valid values are `company_fleet|third_party_contractor|municipal|customer_self_haul`',
    `invoice_number` STRING COMMENT 'Reference to the customer invoice that includes charges from this load ticket. Populated after billing cycle completion.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this load ticket record was last updated. Used for change tracking and audit compliance.',
    `measurement_accuracy_grade` STRING COMMENT 'Quality classification of the weight measurement: certified (calibrated scale), standard (operational scale), or estimated (manual or backup method).. Valid values are `certified|standard|estimated`',
    `net_weight_tons` DECIMAL(18,2) COMMENT 'Calculated net payload weight (gross minus tare) expressed in tons. Primary basis for tipping fee calculation and tonnage reporting.',
    `notes` STRING COMMENT 'Free-text notes from the scale operator documenting special circumstances, observations, or issues related to this load.',
    `pre_entry_inspection_result` STRING COMMENT 'Result of the pre-entry safety and load inspection conducted at the gate before allowing vehicle entry. Failed inspections may result in rejection.. Valid values are `passed|failed|waived|not_required`',
    `rejection_disposition_instructions` STRING COMMENT 'Instructions provided to the driver for proper disposal of rejected loads, including alternative facility recommendations or remediation requirements.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for load rejection (e.g., prohibited materials, excessive contamination, unauthorized waste stream, permit violation).',
    `rfid_transponder_scan` STRING COMMENT 'RFID tag or transponder identifier scanned from the vehicle at gate entry. Used for automated vehicle identification and access control.',
    `scale_calibration_date` DATE COMMENT 'Date of the most recent calibration for the scale used to weigh this load. Required for measurement accuracy validation and regulatory compliance.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this load ticket record (e.g., AMCS Platform, legacy scale system, manual entry portal).',
    `tare_weight_tons` DECIMAL(18,2) COMMENT 'Weight of the empty vehicle measured at weigh-out, expressed in tons. Subtracted from gross weight to determine net payload.',
    `ticket_number` STRING COMMENT 'Externally-visible unique ticket number generated at the scale house for this inbound load. Used for customer billing, dispute resolution, and cross-system reconciliation.',
    `ticket_status` STRING COMMENT 'Current lifecycle status of this load ticket record. Completed tickets are eligible for billing; voided tickets are excluded from revenue reporting.. Valid values are `draft|completed|voided|disputed|adjusted`',
    `tipping_fee_amount` DECIMAL(18,2) COMMENT 'Total tipping fee charged for this load (net weight multiplied by tipping fee rate). Primary revenue component for transfer station operations.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Total billable amount for this load including tipping fees, environmental fees, and any additional charges. Used for invoice generation.',
    `waste_characterization_method` STRING COMMENT 'Method used to determine the waste stream type and material composition: visual inspection, manifest declaration, physical sampling, customer declaration, or default profile.. Valid values are `visual_inspection|manifest_declaration|sampling|customer_declaration|default_profile`',
    `waste_origin_jurisdiction` STRING COMMENT 'Municipality, county, or jurisdiction where the waste was collected. Required for regulatory reporting and flow control compliance.',
    `weigh_in_timestamp` TIMESTAMP COMMENT 'Date and time when the loaded vehicle was weighed at the inbound scale. Primary transaction timestamp for this load ticket.',
    `weigh_out_timestamp` TIMESTAMP COMMENT 'Date and time when the empty vehicle was weighed at the outbound scale after unloading. Used to calculate tare weight and cycle time.',
    CONSTRAINT pk_load_ticket PRIMARY KEY(`load_ticket_id`)
) COMMENT 'Inbound load ticket (tipping ticket) generated at the transfer station scale house for each vehicle delivering waste. Captures ticket number, originating route or hauler, vehicle/truck ID, driver ID and CDL number, waste stream type (MSW, C&D, recyclables, organics), waste characterization method, contamination level, gross/tare/net weight (tons), tipping fee rate applied, customer or municipal account reference, waste origin jurisdiction, time-in/time-out at scale, gate entry/exit timestamps, pre-entry inspection result, scale operator ID, acceptance/rejection decision with reason code, rejection disposition instructions, and RFID/transponder scan reference. Primary transactional record for all inbound activity at the transfer station — from gate check-in through weighing to acceptance or rejection. Integrates with AMCS and SAP SD for tipping fee billing.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`scale_transaction` (
    `scale_transaction_id` BIGINT COMMENT 'Unique identifier for the scale transaction record. Primary key for the scale transaction entity.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Scale transactions at regulated facilities are subject to compliance inspections (weighmaster certification audits, scale calibration verification, load characterization inspections). Linking scale tr',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this scale transaction. Used for billing and revenue allocation.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver operating the vehicle during the scale transaction.',
    `facility_id` BIGINT COMMENT 'Identifier of the transfer station or disposal facility where the scale transaction occurred.',
    `load_ticket_id` BIGINT COMMENT 'Associated load ticket identifier linking this scale transaction to the broader load documentation. Used for cross-referencing with dispatch and billing records.',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Scale transactions for hazardous waste loads must reference the RCRA manifest for regulatory chain-of-custody and weight reconciliation. The scale_transaction has manifest_number as denormalized text;',
    `route_execution_id` BIGINT COMMENT 'Identifier of the route execution associated with this scale transaction, if the load originated from a collection route.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Weights and measures regulations require traceable scale calibration records. scale_transaction already stores scale_calibration_date and scale_calibration_record_number as denormalized fields. Linkin',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Weighmaster regulatory compliance and scale calibration audit trails require each transaction to reference the specific certified scale equipment (fixed_asset). scale_transaction has scale_calibration',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Scale transactions record weight at facility entry per customer load. Linking to service_enrollment enables per-enrollment weight-based billing reconciliation and diversion reporting — critical for co',
    `transfer_station_id` BIGINT COMMENT 'Foreign key linking to collection.transfer_station. Business justification: A scale_transaction is a weighing event at a transfer station scale house. scale_transaction has facility_id (cross-domain to asset.facility) but no direct in-domain FK to transfer_station. Adding tra',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle being weighed. Links to the fleet vehicle master record.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Scale transactions must be classified by waste stream for tipping fee rate application, diversion reporting, and regulatory compliance. Waste stream determines the applicable tipping fee rate. Replace',
    `billing_date` DATE COMMENT 'Date when the scale transaction was included in customer billing. Used for revenue recognition and accounts receivable tracking.',
    `cid` STRING COMMENT 'Container Identification number for the container being weighed, if applicable. Used for tracking specific container loads.',
    `comments` STRING COMMENT 'Free-text comments or notes recorded by the scale operator regarding special circumstances, observations, or instructions related to the transaction.',
    `contamination_flag` BOOLEAN COMMENT 'Indicates whether the load was flagged for contamination. True indicates contamination detected, False indicates clean load.',
    `contamination_type` STRING COMMENT 'Description of the type of contamination detected in the load, if applicable. Examples include hazardous materials, prohibited items, or cross-contamination of waste streams.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scale transaction record was first created in the data platform. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tipping fee amount. Typically USD for US operations, CAD for Canadian operations, MXN for Mexican operations.. Valid values are `USD|CAD|MXN`',
    `disposal_authorization_number` STRING COMMENT 'Authorization or permit number allowing disposal of the waste at this facility. Required for certain waste types and regulatory compliance.',
    `gross_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of the vehicle and load combined, measured in pounds. Captured during the first weighing event.',
    `invoice_number` STRING COMMENT 'Invoice number associated with this scale transaction for billing purposes. Links the transaction to the customer billing record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scale transaction record was last updated in the data platform. Used for change tracking and audit trail.',
    `load_type` STRING COMMENT 'Classification of the load source. Indicates whether the load originated from collection routes, transfer operations, commercial customers, residential service, rolloff containers, or special waste handling.. Valid values are `collection|transfer|commercial|residential|rolloff|special_waste`',
    `material_type` STRING COMMENT 'Detailed description of the specific material type within the waste stream. Provides granular classification for disposal and recycling operations.',
    `net_weight_lbs` DECIMAL(18,2) COMMENT 'Net weight of the load only, calculated as gross weight minus tare weight, measured in pounds.',
    `net_weight_tons` DECIMAL(18,2) COMMENT 'Net weight of the load converted to tons. Primary unit for billing, reporting, and regulatory compliance. Calculated as net_weight_lbs divided by 2000.',
    `rejection_flag` BOOLEAN COMMENT 'Indicates whether the load was rejected and not accepted for disposal. True indicates rejected load, False indicates accepted load.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the load was rejected, if applicable. Includes reasons such as contamination, unauthorized waste type, or facility capacity constraints.',
    `scale_calibration_date` DATE COMMENT 'Date of the most recent scale calibration prior to this transaction. Used to verify measurement validity and compliance with calibration frequency requirements.',
    `scale_calibration_record_number` STRING COMMENT 'Reference to the most recent scale calibration record at the time of transaction. Ensures measurement accuracy and regulatory compliance.',
    `source_system` STRING COMMENT 'Name of the source system that generated this scale transaction record. Typically AMCS Platform scale integration module.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this record in the source system. Used for data lineage tracking and reconciliation with operational systems.',
    `tare_weight_lbs` DECIMAL(18,2) COMMENT 'Weight of the empty vehicle without load, measured in pounds. Used to calculate net payload weight.',
    `ticket_number` STRING COMMENT 'Externally-known unique scale ticket number assigned to this weighing transaction. Used for customer communication, dispute resolution, and audit trail.',
    `tipping_fee_amount` DECIMAL(18,2) COMMENT 'Total tipping fee charged for this transaction, calculated as net weight in tons multiplied by the tipping fee rate.',
    `tipping_fee_rate` DECIMAL(18,2) COMMENT 'Rate charged per ton for waste disposal at the facility. Used to calculate the tipping fee amount for billing.',
    `transaction_date` DATE COMMENT 'Business date of the scale transaction. Used for daily reporting, billing cycles, and operational analytics.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the scale transaction. Tracks whether the transaction is completed, pending validation, voided, under dispute, corrected, or rejected.. Valid values are `completed|pending|voided|disputed|corrected|rejected`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the scale transaction was recorded. Primary business event timestamp for the weighing event.',
    `transaction_type` STRING COMMENT 'Type of scale transaction. Inbound indicates waste arriving at facility, outbound indicates waste leaving facility, tare-only captures vehicle weight without load, reweigh indicates a correction transaction.. Valid values are `inbound|outbound|tare_only|reweigh`',
    `validation_flag` BOOLEAN COMMENT 'Indicates whether the scale transaction has been validated and approved for billing. True indicates validated, False indicates pending validation or rejected.',
    `validation_notes` STRING COMMENT 'Notes recorded during the validation process. Captures reasons for rejection, corrections made, or special circumstances requiring review.',
    `vehicle_plate_number` STRING COMMENT 'License plate number of the vehicle being weighed. Used for manual verification and cross-reference.',
    `weighmaster_certification_number` STRING COMMENT 'Certification number of the licensed weighmaster who validated the transaction. Required for regulatory compliance in jurisdictions with weighmaster certification requirements.',
    CONSTRAINT pk_scale_transaction PRIMARY KEY(`scale_transaction_id`)
) COMMENT 'Detailed scale house weighing transaction record capturing each individual scale event at the transfer station. Records scale ID, transaction timestamp, vehicle plate/CID, gross weight, tare weight, net weight (tons), scale operator, weighmaster certification reference, scale calibration record reference, transaction type (inbound, outbound, tare-only), and associated load ticket ID. Supports regulatory weighmaster compliance and audit trail for tipping fee disputes. Sourced from AMCS Platform scale integration.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` (
    `tipping_fee_rate_id` BIGINT COMMENT 'Unique identifier for the tipping fee rate record. Primary key.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Tipping fee rates at transfer stations are governed by disposal agreements that define contracted rates, tonnage tiers, and billing terms. Rate validation and invoice reconciliation require linking ea',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Tipping fee rate management requires associating rates with specific disposal and processing facilities (MRFs, WTE plants, landfills) beyond just transfer stations. tipping_fee_rate links only to tran',
    `landfill_tipping_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to landfill.landfill_tipping_fee_schedule. Business justification: Transfer station tipping fee rates are set based on downstream landfill tipping fee schedules to ensure cost pass-through alignment. Financial reconciliation and rate-setting processes require this li',
    `mrf_facility_id` BIGINT COMMENT 'Foreign key linking to recycling.mrf_facility. Business justification: MRFs charge tipping fees for inbound recyclable loads, distinct from transfer station tipping rates. MRF tipping fee rate management, buyer contract pricing, and inbound load billing all require MRF-s',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tipping fee rates are subject to permit conditions and regulatory rate caps established by permitting authorities. Permits define maximum allowable rates and rate adjustment procedures.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Tipping fee rates are often capped or mandated by state/local regulatory requirements (tipping_fee_rate has regulatory_rate_cap and regulatory_authority). Linking to the specific regulatory_requiremen',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Tipping fee rates are segment-specific (residential vs. commercial vs. industrial). Normalizing customer_segment to a FK on segment enables accurate rate lookup by customer segment during billing and ',
    `superseded_by_rate_tipping_fee_rate_id` BIGINT COMMENT 'Reference to the new rate that replaces this rate when status is superseded. Nullable for active rates. Maintains rate version history.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station where this tipping fee rate applies. Links to the facility master data.',
    `vehicle_class_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_class. Business justification: Tipping fee structures in waste management are often vehicle-class-specific — roll-off trucks, rear-loaders, and transfer trailers carry different rates. Linking tipping_fee_rate to vehicle_class enab',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_code. Business justification: Hazardous waste tipping fees are set by EPA/state waste code — different waste codes carry different disposal costs and regulatory fees. Linking tipping_fee_rate to waste_code enables waste-code-speci',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Tipping fee rates are waste-stream-specific — MSW, recyclables, C&D, and organics carry different rates. Rate lookup for billing and regulatory fee reporting requires this link. Replaces denormalized ',
    `approval_status` STRING COMMENT 'Approval workflow status for the rate. Tracks regulatory or management approval process before rate activation.. Valid values are `not_submitted|pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this tipping fee rate was approved. Nullable if not yet approved.',
    `contamination_penalty_rate` DECIMAL(18,2) COMMENT 'Additional fee per ton charged for contaminated loads that do not meet material stream specifications. Nullable if no contamination penalty applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this tipping fee rate record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate record.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when this tipping fee rate becomes active and applicable for billing. Start of the rate validity period.',
    `environmental_fee` DECIMAL(18,2) COMMENT 'Additional environmental surcharge per ton applied on top of base tipping fee. Used for environmental compliance and remediation programs.',
    `expiration_date` DATE COMMENT 'Date when this tipping fee rate ceases to be active. Nullable for open-ended rates. End of the rate validity period.',
    `fuel_surcharge_applicable_flag` BOOLEAN COMMENT 'Indicates whether a fuel surcharge can be applied to this rate. True if fuel surcharge is allowed, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this tipping fee rate record was last updated. Audit trail field for change tracking.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum tipping fee charged regardless of tonnage. Applied when calculated tonnage-based fee falls below this threshold. Expressed in local currency.',
    `rate_adjustment_percentage` DECIMAL(18,2) COMMENT 'Percentage adjustment applied to base rate for special circumstances. Positive for surcharges, negative for discounts. Nullable if no adjustment applies.',
    `rate_basis` STRING COMMENT 'Unit of measure for rate calculation. Determines how the tipping fee is computed and applied to weight tickets.. Valid values are `per_ton|per_load|per_cubic_yard|per_trip|flat_rate`',
    `rate_code` STRING COMMENT 'Unique business identifier for the tipping fee rate schedule. Used for rate lookup and billing system integration.. Valid values are `^[A-Z0-9]{4,12}$`',
    `rate_name` STRING COMMENT 'Descriptive name for the tipping fee rate schedule. Human-readable identifier used in billing and reporting.',
    `rate_notes` STRING COMMENT 'Additional notes, terms, conditions, or special instructions related to this tipping fee rate. Free-text field for operational guidance.',
    `rate_per_ton` DECIMAL(18,2) COMMENT 'Tipping fee charged per ton of waste disposed. Primary pricing metric for tonnage-based billing. Expressed in local currency.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the tipping fee rate. Controls whether the rate can be applied to new transactions.. Valid values are `draft|pending_approval|active|suspended|expired|superseded`',
    `rate_tier` STRING COMMENT 'Pricing tier classification for this rate. Used for rate card segmentation and pricing strategy analysis.. Valid values are `standard|premium|economy|negotiated|promotional`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or local enforcement agency that governs this rate. Used for compliance tracking and audit trails.',
    `regulatory_rate_cap` DECIMAL(18,2) COMMENT 'Maximum tipping fee allowed by local regulatory authority. Nullable if no cap applies. Ensures compliance with local solid waste authority rate limits.',
    `seasonal_rate_flag` BOOLEAN COMMENT 'Indicates whether this is a seasonal rate with time-limited applicability. True for seasonal rates, False for year-round rates.',
    `source_system` STRING COMMENT 'Operational system of record that originated this tipping fee rate. SAP_SD = SAP Sales and Distribution, ORACLE_RM = Oracle Revenue Management.. Valid values are `SAP_SD|ORACLE_RM|AMCS|MANUAL|LEGACY`',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this rate record in the source operational system. Used for data lineage and reconciliation.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this rate is exempt from sales tax. True for tax-exempt customers such as government entities, False otherwise.',
    `volume_discount_rate_per_ton` DECIMAL(18,2) COMMENT 'Discounted rate per ton applied when volume threshold is exceeded. Nullable if no volume discount applies.',
    `volume_discount_threshold_tons` DECIMAL(18,2) COMMENT 'Minimum tonnage required to qualify for volume-based discount pricing. Nullable if no volume discount applies.',
    CONSTRAINT pk_tipping_fee_rate PRIMARY KEY(`tipping_fee_rate_id`)
) COMMENT 'Reference table defining tipping fee rate schedules applied at each transfer station. Captures rate ID, transfer station reference, waste stream type (MSW, C&D, special waste, hazardous), customer segment (residential, commercial, municipal, self-haul), rate per ton, minimum charge, effective date, expiration date, rate basis (per ton, per load, per yard), regulatory rate cap reference, and approval status. Used by SAP SD and Oracle Revenue Management for tipping fee invoice generation. Distinct from billing domain rate schedules — this is the operational rate reference owned by transfer operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`outbound_haul` (
    `outbound_haul_id` BIGINT COMMENT 'Unique identifier for the outbound haul assignment record. Primary key for tracking consolidated waste loads dispatched from transfer stations to destination facilities.',
    `destination_facility_id` BIGINT COMMENT 'Identifier of the destination facility receiving the outbound haul load (landfill, MRF, WTE, or TSDF).',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Outbound hauls from transfer stations to disposal facilities are executed under disposal agreements that define the destination facility, tipping fee, and contracted tonnage. Linking outbound hauls to',
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Outbound hauls from transfer stations are directed to specific landfill cells. Cell-level tracking is required for airspace consumption reporting, regulatory compliance, and capacity planning. Existin',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Outbound hauls from transfer stations to landfills need direct landfill site FK (destination_facility_id is generic facility reference) for landfill-specific logistics, capacity coordination, and wast',
    `driver_id` BIGINT COMMENT 'Identifier of the driver assigned to execute the outbound haul transport.',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Outbound hauls execute third-party hauling agreements for transfer station-to-disposal transport. Hauling cost reconciliation, carrier performance tracking, and agreement compliance verification requi',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Outbound hauls from transfer stations to TSDF facilities require manifests for hazardous waste. Role-prefixed to distinguish from internal tracking; removes denormalized manifest_number text field.',
    `landfill_tipping_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to landfill.landfill_tipping_fee_schedule. Business justification: Each outbound haul from a transfer station to a landfill incurs a tipping fee per the landfills fee schedule. Linking to the specific schedule record supports invoice reconciliation, cost allocation,',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Outbound hauls must comply with transportation permits and manifest requirements for waste movement between facilities. Permits authorize specific waste types and destination facilities for haul opera',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Outbound hauls of RCRA-regulated or state-regulated waste streams must be reported to regulatory agencies. Linking each outbound haul to its regulatory submission enables compliance officers to verify',
    `special_waste_approval_id` BIGINT COMMENT 'Foreign key linking to landfill.special_waste_approval. Business justification: Outbound hauls of special waste (indicated by epa_waste_code and rcra_classification on outbound_haul) require a landfill special waste pre-approval. Operations and compliance teams need this link to ',
    `transfer_station_id` BIGINT COMMENT 'Identifier of the transfer station origin facility where consolidated waste is loaded for outbound transport.',
    `transporter_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.transporter_registration. Business justification: RCRA requires all hazardous waste transport to use EPA-registered transporters. Outbound hauls of hazardous waste must reference the transporter registration to verify EPA ID, DOT authority, and insur',
    `vehicle_id` BIGINT COMMENT 'Identifier of the transfer trailer or vehicle assigned to transport the outbound haul load.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Outbound hauls of hazardous waste require waste profile reference for LDR treatment standard compliance, approved TSDF routing, and RCRA regulatory reporting. The outbound_haul has epa_waste_code and ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Outbound hauls are classified by waste stream for disposal routing decisions, regulatory manifesting, and diversion tracking. RCRA classification and EPA waste code assignment depend on waste stream. ',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the vehicle arrived at the destination facility. Used for delivery confirmation and facility gate operations.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the vehicle departed the transfer station. Used for on-time performance tracking and DOT compliance.',
    `actual_tonnage` DECIMAL(18,2) COMMENT 'Actual weight of the waste load in tons as measured at the destination facility scale. Used for billing and disposal fee calculation.',
    `bol_number` STRING COMMENT 'Bill of Lading document number for the outbound haul shipment. Required for DOT compliance and chain-of-custody tracking.',
    `contamination_flag` BOOLEAN COMMENT 'Indicates whether the load was identified as contaminated with prohibited materials or improperly sorted waste streams.',
    `contamination_type` STRING COMMENT 'Classification of the contamination found in the load (e.g., hazardous materials in MSW, non-recyclables in recycling stream, prohibited items).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound haul record was first created in the system. Used for audit trail and data lineage tracking.',
    `destination_facility_type` STRING COMMENT 'Classification of the destination facility type. MRF = Materials Recovery Facility, WTE = Waste-to-Energy, TSDF = Treatment Storage and Disposal Facility.. Valid values are `landfill|mrf|wte|tsdf|other`',
    `dispatch_notes` STRING COMMENT 'Operational notes from dispatch personnel regarding special handling instructions, route conditions, or coordination requirements.',
    `driver_notes` STRING COMMENT 'Notes entered by the driver regarding delivery conditions, facility operations, delays, or issues encountered during the haul.',
    `environmental_fee_amount` DECIMAL(18,2) COMMENT 'Environmental surcharge or regulatory fee assessed on the waste load for environmental compliance programs and remediation funds.',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Estimated date and time for the vehicle to arrive at the destination facility based on route planning and traffic conditions.',
    `estimated_fuel_consumption_gallons` DECIMAL(18,2) COMMENT 'Estimated fuel consumption in gallons for the outbound haul based on vehicle type, load weight, and route distance.',
    `estimated_tonnage` DECIMAL(18,2) COMMENT 'Estimated weight of the consolidated waste load in tons based on transfer station scale readings or volume calculations.',
    `generator_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether the waste generator signature was captured on the manifest or BOL for chain-of-custody compliance.',
    `haul_number` STRING COMMENT 'Externally-known business identifier for the outbound haul assignment. Used for operational tracking and communication with drivers, facilities, and regulatory agencies.',
    `haul_status` STRING COMMENT 'Current lifecycle status of the outbound haul assignment in the dispatch and delivery workflow.. Valid values are `scheduled|dispatched|in_transit|delivered|rejected|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound haul record was last updated. Used for audit trail and change tracking.',
    `load_rejection_flag` BOOLEAN COMMENT 'Indicates whether the destination facility rejected the load due to contamination, improper classification, or facility capacity constraints.',
    `receiver_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether the destination facility receiver signature was captured on the manifest or BOL for chain-of-custody completion.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the destination facility rejected the load. Includes contamination type, classification errors, or operational issues.',
    `route_distance_miles` DECIMAL(18,2) COMMENT 'Total distance in miles from transfer station origin to destination facility. Used for fuel cost allocation and route optimization.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during the outbound haul (accident, spill, injury, near-miss). Triggers incident reporting workflow.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time for the vehicle to depart the transfer station with the consolidated load.',
    `seal_number` STRING COMMENT 'Tamper-evident seal identifier applied to the trailer or container. Used for security and chain-of-custody verification, especially for hazardous waste.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this outbound haul record (e.g., AMCS Platform, Locus Dispatch, SAP S/4HANA).',
    `tipping_fee_amount` DECIMAL(18,2) COMMENT 'Total tipping fee amount charged for the haul based on actual tonnage and facility rate. Primary disposal cost component.',
    `tipping_fee_rate` DECIMAL(18,2) COMMENT 'Per-ton disposal fee rate charged by the destination facility for accepting the waste load. Used for cost allocation and billing.',
    `transporter_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether the transporter (driver) signature was captured on the manifest or BOL for chain-of-custody compliance.',
    CONSTRAINT pk_outbound_haul PRIMARY KEY(`outbound_haul_id`)
) COMMENT 'Outbound haul assignment and manifest record dispatching consolidated waste loads from the transfer station to a destination facility (landfill, MRF, WTE, TSDF). Captures haul ID, transfer station origin, destination facility type and ID, assigned transfer trailer/vehicle, driver assignment, scheduled and actual departure datetimes, estimated arrival, waste stream type, estimated tonnage, BOL number, manifest number (if hazardous), waste classification codes (EPA/RCRA), seal numbers, carrier DOT number, chain-of-custody signatures, haul contractor reference, and haul status (scheduled, in-transit, delivered, rejected). Core operational record bridging transfer to landfill/recycling/energy domains. Supports DOT compliance on all outbound loads and RCRA manifest requirements for special/hazardous waste streams.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`haul_manifest` (
    `haul_manifest_id` BIGINT COMMENT 'Unique identifier for the haul manifest record. Primary key.',
    `destination_facility_id` BIGINT COMMENT 'Disposal or processing facility to which this haul is destined. May be landfill, WTE facility, or other disposal site.',
    `cell_id` BIGINT COMMENT 'Foreign key linking to landfill.cell. Business justification: Haul manifests document chain of custody for waste transport. RCRA and state regulations require cell-level disposal tracking on manifests for special and hazardous waste. Existing FK covers landfill.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Haul manifests for waste transported to landfills require landfill site reference for regulatory compliance, manifest-based waste tracking, and chain-of-custody documentation. Core regulatory and oper',
    `driver_id` BIGINT COMMENT 'Driver responsible for transporting this haul from origin to destination.',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Haul manifests document waste transport under hauling agreements, including BOL terms and carrier obligations. Regulatory compliance, carrier liability verification, and hauling agreement audit trails',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Links operational haul tracking to authoritative regulatory manifest system. Role-prefixed to distinguish from local manifest_number field; removes denormalized manifest_tracking_number for 3NF.',
    `transfer_station_id` BIGINT COMMENT 'Transfer station facility from which this haul originated. Starting point of the outbound shipment.',
    `outbound_haul_id` BIGINT COMMENT 'Reference to the outbound haul execution record that this manifest documents.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Manifests document compliance with permitted waste transportation and disposal activities. Permits define manifest requirements, waste codes, and authorized transportation routes for regulatory compli',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Haul manifests for RCRA-regulated waste must reference the specific regulatory requirement (40 CFR Part 262 or state equivalent) governing manifest preparation and retention. haul_manifest has rcra_ma',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: RCRA hazardous waste manifests are regulatory submissions filed with EPA and state agencies. haul_manifest has rcra_manifest_required_flag; linking to the regulatory_submission record enables complian',
    `special_waste_approval_id` BIGINT COMMENT 'Foreign key linking to landfill.special_waste_approval. Business justification: Haul manifests for special waste must reference the landfills pre-approval record for regulatory compliance. RCRA and state regulations require the approval number on the manifest. Compliance officer',
    `transporter_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.transporter_registration. Business justification: RCRA manifests must identify the registered transporter by EPA ID. Haul manifests for hazardous waste transport must reference the transporter registration record. The haul_manifest has carrier_dot_nu',
    `vehicle_id` BIGINT COMMENT 'Transport vehicle (truck or tractor) used to haul this shipment.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Haul manifests for hazardous waste transport must reference the waste profile for LDR certification, treatment standard compliance, and approved TSDF verification. The haul_manifest has epa_waste_code',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Haul manifests must specify waste stream for regulatory compliance (EPA, RCRA), facility gate acceptance, and proper disposal routing. Essential for hazmat tracking, environmental reporting, and inter',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the haul arrived at the destination facility. Used for transit time tracking and SLA compliance.',
    `bol_reference_number` STRING COMMENT 'Bill of Lading reference number accompanying this haul manifest. Links manifest to shipping documentation.',
    `container_count` STRING COMMENT 'Number of containers or trailers included in this haul shipment.',
    `container_type` STRING COMMENT 'Type of container or trailer used for this haul. Describes the physical configuration of the transport equipment.. Valid values are `compactor|open_top|roll_off|transfer_trailer|walking_floor`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was first created in the system.',
    `departure_timestamp` TIMESTAMP COMMENT 'Date and time when the haul departed from the origin transfer station. Marks the beginning of the transport chain-of-custody.',
    `destination_signature_name` STRING COMMENT 'Name of the destination facility representative who signed the manifest upon receipt, confirming delivery and acceptance.',
    `destination_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the destination facility representative signed the manifest acknowledging receipt.',
    `driver_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether the driver signature was captured on the manifest document. Required for DOT compliance.',
    `driver_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the driver signed the manifest document acknowledging receipt and transport responsibility.',
    `emergency_contact_name` STRING COMMENT 'Name of the emergency response contact person or organization for incidents involving this haul. Required for hazardous waste shipments.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency response phone number for incidents involving this haul. Required for hazardous waste shipments.',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time when the haul is expected to arrive at the destination facility.',
    `gross_weight_tons` DECIMAL(18,2) COMMENT 'Total gross weight of the loaded vehicle including waste payload and vehicle tare weight, measured in tons.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether this haul contains hazardous materials requiring special handling and RCRA manifest compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this manifest record was last updated in the system.',
    `manifest_issued_timestamp` TIMESTAMP COMMENT 'Date and time when the manifest document was officially issued and became active for this haul.',
    `manifest_number` STRING COMMENT 'Externally-known unique manifest tracking number assigned to this outbound haul shipment. Required for DOT compliance and chain-of-custody documentation.',
    `manifest_status` STRING COMMENT 'Current lifecycle status of the haul manifest in the shipping and tracking workflow.. Valid values are `draft|issued|in_transit|delivered|rejected|voided`',
    `origin_signature_name` STRING COMMENT 'Name of the transfer station representative who signed the manifest at origin, certifying the shipment details.',
    `origin_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the origin facility representative signed the manifest.',
    `rcra_manifest_required_flag` BOOLEAN COMMENT 'Indicates whether this haul requires a formal RCRA hazardous waste manifest under federal regulations.',
    `rejection_flag` BOOLEAN COMMENT 'Indicates whether this haul was rejected at the destination facility due to contamination, incorrect classification, or other non-compliance issues.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the haul was rejected at the destination facility. Populated only when rejection_flag is true.',
    `seal_numbers` STRING COMMENT 'Security seal identification numbers applied to containers or trailer doors. Multiple seals may be comma-separated. Required for chain-of-custody integrity.',
    `source_system` STRING COMMENT 'Name of the operational system from which this manifest record originated (e.g., AMCS Platform, SAP EHS).',
    `special_handling_instructions` STRING COMMENT 'Additional instructions for handling, transporting, or unloading this haul. May include safety precautions, equipment requirements, or facility-specific procedures.',
    `tare_weight_tons` DECIMAL(18,2) COMMENT 'Empty weight of the transport vehicle and containers without waste payload, measured in tons.',
    `total_net_weight_tons` DECIMAL(18,2) COMMENT 'Total net weight of waste material in this haul measured in tons. Calculated as gross weight minus tare weight.',
    CONSTRAINT pk_haul_manifest PRIMARY KEY(`haul_manifest_id`)
) COMMENT 'Shipping and tracking manifest accompanying each outbound haul from the transfer station. Captures manifest number, BOL reference, outbound haul ID, origin transfer station, destination facility, waste description, waste classification codes (EPA/RCRA), total net weight (tons), number of containers/trailers, seal numbers, driver signature, carrier DOT number, departure timestamp, and chain-of-custody signatures. Required for DOT compliance on all outbound loads and RCRA manifest requirements for special/hazardous waste streams.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`facility_capacity` (
    `facility_capacity_id` BIGINT COMMENT 'Unique identifier for the facility capacity tracking record. Primary key for daily and period-level capacity and throughput tracking at transfer stations.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Facility capacity records track actual daily tonnage against permitted and contracted limits. Disposal agreements define contracted daily tonnage capacity (tpd_capacity). Linking capacity records to d',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Facility capacity reporting and permit compliance require tracking actual vs. permitted tonnage for any facility type (MRF, WTE plant, transfer station). facility_capacity currently only links via tra',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Daily capacity utilization must stay within permitted limits. Capacity records demonstrate permit compliance and support regulatory reporting of throughput against permitted daily tonnage limits.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Transfer station daily/monthly capacity reports are mandatory regulatory submissions under state solid waste regulations. facility_capacity stores regulatory_report_reference and report_submission_dat',
    `transfer_station_id` BIGINT COMMENT 'Identifier of the transfer station for which capacity is being tracked. Links to the facility master data.',
    `actual_inbound_tonnage` DECIMAL(18,2) COMMENT 'Total tonnage of waste received at the transfer station during the record date or period. Represents all incoming waste streams before sorting or processing.',
    `actual_outbound_tonnage` DECIMAL(18,2) COMMENT 'Total tonnage of waste dispatched from the transfer station to disposal or processing facilities during the record date or period.',
    `average_daily_tonnage` DECIMAL(18,2) COMMENT 'Average daily tonnage processed during the record period. For daily records, equals actual_inbound_tonnage. For period records, represents the mean daily throughput.',
    `capacity_status` STRING COMMENT 'Operational status of the transfer station capacity. Normal indicates utilization within acceptable range, near_capacity indicates approaching permit limits, over_capacity indicates permit exceedance, under_capacity indicates significantly below normal throughput.. Valid values are `normal|near_capacity|over_capacity|under_capacity`',
    `capacity_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of permitted daily capacity utilized, calculated as (actual_inbound_tonnage / permitted_daily_capacity_tpd) * 100. Key performance indicator for capacity management.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented in response to capacity exceedance or operational issues. Documents compliance response for regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity record was first created in the system. Part of the standard audit trail for all transactional records.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Quality score (0.00 to 1.00) indicating the completeness and accuracy of the capacity record. Based on presence of required fields, validation checks, and data source reliability.',
    `diversion_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of waste diverted from landfill disposal through recycling, composting, or waste-to-energy. Calculated as ((outbound_mrf_tonnage + outbound_wte_tonnage + outbound_organics_tonnage) / actual_inbound_tonnage) * 100. Key sustainability metric.',
    `exceedance_reason` STRING COMMENT 'Explanation for why the permitted capacity was exceeded, if applicable. Includes operational circumstances, emergency conditions, or unplanned events that led to the exceedance.',
    `exceedance_tonnage` DECIMAL(18,2) COMMENT 'Tonnage by which the actual inbound tonnage exceeded the permitted daily capacity. Null if no exceedance occurred. Used for regulatory violation reporting and corrective action planning.',
    `floor_storage_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of waste remaining on the transfer station floor at the end of the record date. Represents inventory not yet dispatched for disposal or processing.',
    `inbound_cd_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of construction and demolition (C&D) waste received during the record date or period. C&D includes debris from building, renovation, and demolition activities.',
    `inbound_load_count` STRING COMMENT 'Total count of inbound collection vehicles or loads received at the transfer station during the record date or period. Used for operational throughput analysis.',
    `inbound_msw_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of municipal solid waste (MSW) received during the record date or period. MSW includes residential and commercial non-hazardous waste.',
    `inbound_organics_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of organic waste (food waste, yard waste, compostables) received during the record date or period. Tracked separately for diversion rate calculation.',
    `inbound_recyclable_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of recyclable materials received during the record date or period. Includes materials destined for Materials Recovery Facility (MRF) processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity record was last updated. Part of the standard audit trail for all transactional records.',
    `operational_notes` STRING COMMENT 'Free-text notes documenting operational conditions, equipment issues, weather impacts, or other factors affecting capacity and throughput during the record date or period.',
    `outbound_haul_count` STRING COMMENT 'Total count of outbound haul trucks dispatched from the transfer station to disposal or processing facilities during the record date or period.',
    `outbound_landfill_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of waste hauled to landfill disposal facilities during the record date or period. Used for diversion rate calculation.',
    `outbound_mrf_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of recyclable materials sent to Materials Recovery Facility (MRF) for processing during the record date or period. Contributes to diversion rate.',
    `outbound_wte_tonnage` DECIMAL(18,2) COMMENT 'Tonnage of waste sent to waste-to-energy (WTE) facilities for energy recovery during the record date or period. Contributes to diversion rate.',
    `peak_hour_throughput_tons` DECIMAL(18,2) COMMENT 'Maximum tonnage processed during any single hour of the record date. Used to identify operational bottlenecks and peak demand periods.',
    `peak_hour_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the peak hour throughput occurred during the record date. Supports operational planning and resource allocation.',
    `permit_exceedance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the actual inbound tonnage exceeded the permitted daily capacity. True indicates a regulatory compliance issue requiring immediate attention and reporting.',
    `permitted_daily_capacity_tpd` DECIMAL(18,2) COMMENT 'The maximum daily throughput capacity in tons per day (TPD) as authorized by the facilitys operating permit. This is the regulatory limit that cannot be exceeded without permit violation.',
    `record_date` DATE COMMENT 'The specific date for which this capacity record applies. Used for daily capacity tracking and regulatory reporting.',
    `record_period` STRING COMMENT 'The reporting period for aggregated capacity tracking (e.g., 2024-Q1, 2024-03). Supports both monthly and quarterly period-level reporting.. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `record_status` STRING COMMENT 'Current status of the capacity record in the reporting workflow. Draft indicates preliminary data, validated indicates quality checks passed, submitted indicates included in regulatory reporting, archived indicates historical record.. Valid values are `draft|validated|submitted|archived`',
    `source_system` STRING COMMENT 'Name of the operational system from which the capacity data originated (e.g., AMCS Platform, Waste Logics, manual entry). Supports data lineage and troubleshooting.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity record was validated and approved for regulatory reporting. Part of the audit trail for compliance documentation.',
    CONSTRAINT pk_facility_capacity PRIMARY KEY(`facility_capacity_id`)
) COMMENT 'Daily and period-level capacity and throughput tracking record for each transfer station. Captures capacity record ID, transfer station, record date/period, permitted daily capacity (TPD), actual inbound tonnage by waste stream, actual outbound tonnage by destination type, floor storage tonnage at end of day, capacity utilization percentage, number of inbound loads, number of outbound hauls, peak hour/day throughput, diversion rate (percentage diverted from landfill), average daily tonnage, capacity status (normal, near-capacity, over-capacity), regulatory capacity exceedance flags, and reporting submission reference. Enables proactive capacity management, regulatory compliance reporting, state solid waste reporting, and internal KPI tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`destination_facility` (
    `destination_facility_id` BIGINT COMMENT 'Unique identifier for the destination facility record. Primary key.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Destination facilities in outbound haul operations are physical landfills, WTE plants, or MRFs requiring linkage to asset facility master for permit tracking, capacity management, insurance, environme',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: destination_facility is a collection-domain abstraction for disposal destinations. When a destination facility IS a landfill, it must reference the landfill.site record for capacity validation, tippin',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Destination facilities receiving waste from transfer stations are regulated facilities with permits and compliance obligations. Links outbound haul destinations to regulatory compliance tracking.',
    `tsdf_facility_id` BIGINT COMMENT 'Foreign key linking to hazmat.tsdf_facility. Business justification: Destination facilities that are TSDFs must be linked for hazmat disposal routing decisions and manifest compliance. The destination_facility has requires_manifest_flag and permitted_capacity_tpd but n',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Destination facilities accept specific waste streams; disposal routing decisions and hauling agreement matching depend on this. Dispatchers query destination facilities by waste stream to find valid d',
    `address_line_1` STRING COMMENT 'Primary street address of the destination facility. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or unit number. Organizational contact data classified as confidential.',
    `city` STRING COMMENT 'City where the destination facility is located. Organizational contact data classified as confidential.',
    `contract_reference_number` STRING COMMENT 'Reference number for the disposal services contract or Service Level Agreement (SLA) governing the relationship with this destination facility.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the destination facility is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this destination facility record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for tipping fees and financial transactions at this facility.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this destination facility record became inactive or was closed. Null for currently active facilities.',
    `effective_start_date` DATE COMMENT 'Date when this destination facility record became active and available for receiving waste hauls.',
    `environmental_fee_per_ton` DECIMAL(18,2) COMMENT 'Additional environmental surcharge per ton assessed by the destination facility for regulatory compliance and environmental programs.',
    `estimated_travel_time_minutes` STRING COMMENT 'Average travel time in minutes from the primary transfer station to this destination facility under normal traffic conditions.',
    `facility_status` STRING COMMENT 'Current operational status of the destination facility indicating availability for receiving waste hauls.. Valid values are `active|inactive|suspended|closed|seasonal`',
    `facility_type` STRING COMMENT 'Classification of the destination facility. MRF = Materials Recovery Facility, WTE = Waste-to-Energy, TSDF = Treatment Storage and Disposal Facility.. Valid values are `landfill|mrf|wte|tsdf|composting|transfer_station`',
    `fuel_surcharge_applicable_flag` BOOLEAN COMMENT 'Indicates whether the destination facility applies a fuel surcharge to tipping fees. True if surcharge applies, False otherwise.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the destination facility entrance or scale house for routing and navigation.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the destination facility entrance or scale house for routing and navigation.',
    `haul_distance_miles` DECIMAL(18,2) COMMENT 'Estimated road distance in miles from the primary transfer station to this destination facility, used for route optimization and cost planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this destination facility record was most recently updated in the system.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, access requirements, or restrictions for this destination facility.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for the destination facility on weekdays (Monday-Friday), formatted as start-end time range.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for the destination facility on weekends (Saturday-Sunday), formatted as start-end time range.',
    `permit_expiration_date` DATE COMMENT 'Date when the current operating permit expires and requires renewal to continue receiving waste.',
    `permit_number` STRING COMMENT 'Primary environmental or operating permit number issued by the regulatory authority for this destination facility.',
    `permitted_capacity_tpd` DECIMAL(18,2) COMMENT 'Maximum daily tonnage the facility is permitted to receive by regulatory authorities. TPD = Tons Per Day.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the destination facility address. Organizational contact data classified as confidential.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `preferred_facility_flag` BOOLEAN COMMENT 'Indicates whether this destination facility is designated as a preferred routing target for cost or operational efficiency. True if preferred, False otherwise.',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the regulatory authority or Local Enforcement Agency (LEA) with oversight of this destination facility.',
    `requires_manifest_flag` BOOLEAN COMMENT 'Indicates whether the destination facility requires hazardous waste manifests or Bills of Lading (BOL) for incoming loads. True if manifests required, False otherwise.',
    `scale_available_flag` BOOLEAN COMMENT 'Indicates whether the destination facility has certified scales for weighing incoming loads. True if scales are available, False otherwise.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this destination facility data originated (e.g., AMCS Platform, SAP S/4HANA).',
    `state_province` STRING COMMENT 'Two-letter state or province code where the destination facility is located.. Valid values are `^[A-Z]{2}$`',
    `tipping_fee_per_ton` DECIMAL(18,2) COMMENT 'Standard disposal charge per ton of waste received at the destination facility. Business-sensitive pricing information.',
    CONSTRAINT pk_destination_facility PRIMARY KEY(`destination_facility_id`)
) COMMENT 'Reference master for all downstream destination facilities that receive outbound hauls from transfer stations. Captures facility ID, facility name, facility type (landfill, MRF, WTE, TSDF, composting), physical address, GPS coordinates, operating company, accepted waste streams, permitted capacity, tipping fee at destination, haul distance (miles), travel time estimate, permit number, regulatory jurisdiction, facility contact, and operational status. Enables routing optimization and disposal cost management for outbound haul planning.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_route_optimization_run_id` FOREIGN KEY (`route_optimization_run_id`) REFERENCES `waste_management_ecm`.`collection`.`route_optimization_run`(`route_optimization_run_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_service_schedule_id` FOREIGN KEY (`service_schedule_id`) REFERENCES `waste_management_ecm`.`collection`.`service_schedule`(`service_schedule_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district` ADD CONSTRAINT `fk_collection_district_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_outbound_haul_id` FOREIGN KEY (`outbound_haul_id`) REFERENCES `waste_management_ecm`.`collection`.`outbound_haul`(`outbound_haul_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_outbound_haul_id` FOREIGN KEY (`outbound_haul_id`) REFERENCES `waste_management_ecm`.`collection`.`outbound_haul`(`outbound_haul_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_superseded_by_rate_tipping_fee_rate_id` FOREIGN KEY (`superseded_by_rate_tipping_fee_rate_id`) REFERENCES `waste_management_ecm`.`collection`.`tipping_fee_rate`(`tipping_fee_rate_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_destination_facility_id` FOREIGN KEY (`destination_facility_id`) REFERENCES `waste_management_ecm`.`collection`.`destination_facility`(`destination_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_destination_facility_id` FOREIGN KEY (`destination_facility_id`) REFERENCES `waste_management_ecm`.`collection`.`destination_facility`(`destination_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_outbound_haul_id` FOREIGN KEY (`outbound_haul_id`) REFERENCES `waste_management_ecm`.`collection`.`outbound_haul`(`outbound_haul_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`collection` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`collection` SET TAGS ('dbx_domain' = 'collection');
ALTER TABLE `waste_management_ecm`.`collection`.`route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`route` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `dot_hazmat_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Dot Hazmat Classification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Mrf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Driver Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_optimization_run_id` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Run Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `capacity_constraint_tons` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint in Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `container_type_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Type');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `container_type_primary` SET TAGS ('dbx_value_regex' = 'cart|bin|dumpster|compactor|roll_off');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `end_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'End Location Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `end_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `end_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `end_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'End Location Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `end_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `end_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Minutes');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `estimated_fuel_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fuel Consumption in Gallons');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `estimated_ghg_emissions_co2e_kg` SET TAGS ('dbx_business_glossary_term' = 'Estimated Greenhouse Gas (GHG) Emissions in Carbon Dioxide Equivalent (CO2e) Kilograms');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `estimated_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `fuel_type_required` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type Required');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `fuel_type_required` SET TAGS ('dbx_value_regex' = 'diesel|CNG|RNG|electric|hybrid');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Route Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `optimization_score` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Score');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Route Priority');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `requires_cdl` SET TAGS ('dbx_business_glossary_term' = 'Requires Commercial Driver License (CDL)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `requires_hazmat_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Hazardous Materials (HAZMAT) Certification');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|retired');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `scheduled_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Day of Week');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `scheduled_day_of_week` SET TAGS ('dbx_value_regex' = 'monday|tuesday|wednesday|thursday|friday|saturday');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `total_mileage` SET TAGS ('dbx_business_glossary_term' = 'Total Mileage');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `total_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Stops');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Route Completion Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `customer_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `dispatch_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `distance_traveled_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance Traveled (Miles)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `driver_notes` SET TAGS ('dbx_business_glossary_term' = 'Driver Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Status');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|incomplete|cancelled|suspended');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `fuel_consumed_gallons` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (Gallons)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `helper_assigned_flag` SET TAGS ('dbx_business_glossary_term' = 'Helper Assigned Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `number_of_dumps` SET TAGS ('dbx_business_glossary_term' = 'Number of Dumps');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `route_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Route Duration (Minutes)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|recycling|bulk|special');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'AMCS|Locus|Geotab|Manual');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `total_stops_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Stops Completed');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `total_stops_missed` SET TAGS ('dbx_business_glossary_term' = 'Total Stops Missed');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `total_stops_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Stops Planned');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `total_tonnage_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Tonnage Collected (Tons Per Day - TPD)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `total_volume_collected_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Collected (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `stop_id` SET TAGS ('dbx_business_glossary_term' = 'Stop Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `access_instructions` SET TAGS ('dbx_business_glossary_term' = 'Access Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `access_instructions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `actual_service_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Service End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `actual_service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `cid_tag_identifiers` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID) Tag Identifiers');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `estimated_service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Service Duration (Minutes)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `geofence_radius_meters` SET TAGS ('dbx_business_glossary_term' = 'Geofence Radius (Meters)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `planned_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Time');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `planned_service_window_end` SET TAGS ('dbx_business_glossary_term' = 'Planned Service Window End');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `planned_service_window_start` SET TAGS ('dbx_business_glossary_term' = 'Planned Service Window Start');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `requires_backup` SET TAGS ('dbx_business_glossary_term' = 'Requires Backup');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `requires_ppe` SET TAGS ('dbx_business_glossary_term' = 'Requires Personal Protective Equipment (PPE)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `service_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Service Day of Week');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand|seasonal');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `skip_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Code');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `skip_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amcs|waste_logics|locus|manual');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `stop_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Number');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_business_glossary_term' = 'Stop Status');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|skipped|cancelled|suspended');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_business_glossary_term' = 'Stop Type');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|temporary|special_event');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `volume_collected_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Volume Collected (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ALTER COLUMN `weight_collected_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Collected (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `pickup_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Event ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `ehs_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Ehs Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `stop_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Stop Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Truck ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `compaction_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `contamination_type` SET TAGS ('dbx_value_regex' = 'non_recyclable_material|hazardous_waste|liquid_waste|oversized_items|prohibited_material|none');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `customer_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `driver_notes` SET TAGS ('dbx_business_glossary_term' = 'Driver Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `estimated_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Estimated Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}[0-9]{2,4}$');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Accuracy (Meters)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `lift_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Lift Confirmation Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `lift_count` SET TAGS ('dbx_business_glossary_term' = 'Lift Count');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `overage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Overage Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `photo_storage_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Storage Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `photo_storage_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `rfid_scan_status` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Scan Status');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `rfid_scan_status` SET TAGS ('dbx_value_regex' = 'successful_read|no_read|damaged_tag|tag_missing|multiple_reads');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `rfid_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Number');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `rfid_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `scheduled_pickup_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Pickup Time');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Duration (Seconds)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_outcome` SET TAGS ('dbx_business_glossary_term' = 'Service Outcome');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_outcome` SET TAGS ('dbx_value_regex' = 'completed|skipped|contaminated|blocked|overweight|customer_not_ready');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'locus_dispatch|amcs_platform|geotab|manual_entry');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `stop_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Sequence Number');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `truck_loader_type` SET TAGS ('dbx_business_glossary_term' = 'Truck Loader Type');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `truck_loader_type` SET TAGS ('dbx_value_regex' = 'asl|fel|rel|roll_off|side_load');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|ice|fog|wind');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Service Exception Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `pickup_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `regulatory_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Corrective Action Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `stop_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Stop Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `contamination_severity` SET TAGS ('dbx_business_glossary_term' = 'Contamination Severity');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `contamination_severity` SET TAGS ('dbx_value_regex' = 'LOW|MODERATE|HIGH|CRITICAL');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `credit_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Issued Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `estimated_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Estimated Weight in Pounds (lbs)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_value_regex' = '^EXC-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'OPEN|ACKNOWLEDGED|IN_PROGRESS|RESOLVED|CLOSED|CANCELLED');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `exception_type_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Type Code');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `follow_up_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Scheduled Date');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `photo_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Photo Storage Path');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `photo_storage_path` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|URGENT');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `repeat_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Exception Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `reported_by_source` SET TAGS ('dbx_business_glossary_term' = 'Reported By Source');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `reported_by_source` SET TAGS ('dbx_value_regex' = 'DRIVER|CUSTOMER|DISPATCHER|AUTOMATED_SYSTEM|SUPERVISOR');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `requires_follow_up_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Follow-Up Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `reschedule_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reschedule Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'AMCS|LOCUS|SALESFORCE|WASTE_LOGICS|GEOTAB');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Container Placement ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Commitment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `stop_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Stop Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `actual_removal_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Removal Date');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `cid` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID) Number');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `cid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_condition_at_placement` SET TAGS ('dbx_business_glossary_term' = 'Container Condition at Placement');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_condition_at_placement` SET TAGS ('dbx_value_regex' = 'new|good|fair|damaged|needs-repair');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_condition_at_removal` SET TAGS ('dbx_business_glossary_term' = 'Container Condition at Removal');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_condition_at_removal` SET TAGS ('dbx_value_regex' = 'good|fair|damaged|needs-repair|lost|stolen');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_size` SET TAGS ('dbx_value_regex' = '^[0-9]+(yd|gal|cu-yd)$');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `is_temporary_placement` SET TAGS ('dbx_business_glossary_term' = 'Is Temporary Placement');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Placement Accuracy (Meters)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Date');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_latitude` SET TAGS ('dbx_business_glossary_term' = 'Placement Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_longitude` SET TAGS ('dbx_business_glossary_term' = 'Placement Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_notes` SET TAGS ('dbx_business_glossary_term' = 'Placement Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_reason` SET TAGS ('dbx_business_glossary_term' = 'Placement Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_reason` SET TAGS ('dbx_value_regex' = 'new-service|replacement|additional|temporary|seasonal|event');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Placement Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `removal_notes` SET TAGS ('dbx_business_glossary_term' = 'Removal Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `removal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Removal Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `scheduled_removal_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Removal Date');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'on-demand|daily|weekly|bi-weekly|monthly|quarterly');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amcs|waste-logics|salesforce|manual');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `driver_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `hos_log_id` SET TAGS ('dbx_business_glossary_term' = 'Hos Log Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `pre_post_trip_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Trip Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `training_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Truck ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `absence_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Driver Absence Reason Code');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `absence_reason_code` SET TAGS ('dbx_value_regex' = 'sick|vacation|personal|injury|no_show|other');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_created_by` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created By User');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified By User');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment Number');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Level');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment Status');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'scheduled|active|completed|absent|cancelled');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Driver Assignment Type');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|relief|trainee|backup|temporary');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `cdl_class_required` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class Required');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `cdl_class_required` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `cdl_endorsements_required` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Endorsements Required');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `dispatch_sequence` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Sequence Number');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `dot_hos_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hours-of-Service (HOS) Compliant Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `estimated_route_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Route Duration Hours');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `helper_assigned_flag` SET TAGS ('dbx_business_glossary_term' = 'Helper Assigned Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type Classification');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|roll_off|recycling|hazardous');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'locus_dispatch|workday_hcm|manual_entry');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `truck_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Assignment ID');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `pre_post_trip_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Post Trip Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'routine|priority|emergency|special_event');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'scheduled|dispatched|in_progress|completed|cancelled|reassigned');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `environmental_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|CNG|RNG|electric|hybrid');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Tracking Enabled');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `odometer_end` SET TAGS ('dbx_business_glossary_term' = 'Odometer End (Miles)');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `odometer_start` SET TAGS ('dbx_business_glossary_term' = 'Odometer Start (Miles)');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `reassignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `route_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Route Deviation Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `truck_type` SET TAGS ('dbx_business_glossary_term' = 'Truck Type');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Schedule ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Service Commitment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `stop_id` SET TAGS ('dbx_business_glossary_term' = 'Stop ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `access_requirements` SET TAGS ('dbx_business_glossary_term' = 'Site Access Requirements');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `access_requirements` SET TAGS ('dbx_value_regex' = 'none|gate_code|key_required|escort_required|restricted_hours|call_ahead');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'per_service|weekly|monthly|quarterly|annual');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_quantity` SET TAGS ('dbx_business_glossary_term' = 'Container Quantity');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Container Size Unit of Measure');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_size_unit` SET TAGS ('dbx_value_regex' = 'cubic_yards|gallons|liters');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `external_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'External Schedule Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `friday_flag` SET TAGS ('dbx_business_glossary_term' = 'Friday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `holiday_handling_rule` SET TAGS ('dbx_business_glossary_term' = 'Holiday Handling Rule');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `holiday_handling_rule` SET TAGS ('dbx_value_regex' = 'skip|next_business_day|prior_business_day|same_day|no_adjustment');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `monday_flag` SET TAGS ('dbx_business_glossary_term' = 'Monday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Service Priority Level');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|critical|low');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `route_assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Route Assignment Method');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `route_assignment_method` SET TAGS ('dbx_value_regex' = 'fixed|dynamic|optimized|manual');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `saturday_flag` SET TAGS ('dbx_business_glossary_term' = 'Saturday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Service Schedule Code');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Service Schedule Status');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|pending|expired|on_hold');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Window Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'waste_logics|amcs|salesforce|manual_entry|data_migration');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Service Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `sunday_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Schedule Suspension Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `thursday_flag` SET TAGS ('dbx_business_glossary_term' = 'Thursday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `tuesday_flag` SET TAGS ('dbx_business_glossary_term' = 'Tuesday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `wednesday_flag` SET TAGS ('dbx_business_glossary_term' = 'Wednesday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `route_optimization_run_id` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Run Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `acceptance_decision` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Decision');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `acceptance_decision` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending_review|partially_accepted');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `acceptance_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Decision Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Version');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `algorithm_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `baseline_total_miles` SET TAGS ('dbx_business_glossary_term' = 'Baseline Total Miles');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `configuration_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Profile Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `execution_mode` SET TAGS ('dbx_business_glossary_term' = 'Execution Mode');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `execution_mode` SET TAGS ('dbx_value_regex' = 'manual|scheduled|automatic|api_triggered');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `input_driver_count` SET TAGS ('dbx_business_glossary_term' = 'Input Driver Count');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `input_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Input Stop Count');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `input_truck_count` SET TAGS ('dbx_business_glossary_term' = 'Input Truck Count');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `miles_improvement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Miles Improvement Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Optimization Duration in Seconds');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Optimization End Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Optimization Quality Score');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_run_number` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run Number');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_run_number` SET TAGS ('dbx_value_regex' = '^OPT-[0-9]{8}-[0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Optimization Scenario Type');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_scenario_type` SET TAGS ('dbx_value_regex' = 'daily_reoptimization|seasonal_rebalancing|new_customer_onboarding|emergency_reroute|capacity_expansion|service_area_change');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Optimization Start Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_status` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run Status');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `optimization_status` SET TAGS ('dbx_value_regex' = 'queued|running|completed|failed|cancelled|partially_accepted');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `output_average_hours_per_route` SET TAGS ('dbx_business_glossary_term' = 'Output Average Hours Per Route');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `output_average_miles_per_route` SET TAGS ('dbx_business_glossary_term' = 'Output Average Miles Per Route');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `output_average_stops_per_route` SET TAGS ('dbx_business_glossary_term' = 'Output Average Stops Per Route');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `output_route_count` SET TAGS ('dbx_business_glossary_term' = 'Output Route Count');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `output_total_route_hours` SET TAGS ('dbx_business_glossary_term' = 'Output Total Route Hours');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `output_total_route_miles` SET TAGS ('dbx_business_glossary_term' = 'Output Total Route Miles');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `output_unassigned_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Output Unassigned Stop Count');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `primary_optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Primary Optimization Objective');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `primary_optimization_objective` SET TAGS ('dbx_value_regex' = 'minimize_miles|minimize_time|maximize_compaction|balance_workload|minimize_cost|maximize_service_quality');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `time_window_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Time Window Enforcement Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `vehicle_capacity_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Capacity Constraint Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`district` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`district` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `area_square_miles` SET TAGS ('dbx_business_glossary_term' = 'Area Square Miles');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Collection Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `collection_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `commercial_account_count` SET TAGS ('dbx_business_glossary_term' = 'Commercial Account Count');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `container_type_supported` SET TAGS ('dbx_business_glossary_term' = 'Container Type Supported');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `depot_location` SET TAGS ('dbx_business_glossary_term' = 'Depot Location');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'District Code');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_name` SET TAGS ('dbx_business_glossary_term' = 'District Name');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_status` SET TAGS ('dbx_business_glossary_term' = 'District Status');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|suspended');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `diversion_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Target');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Service End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|compressed_natural_gas|renewable_natural_gas|electric|hybrid');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `geographic_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Description');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `hazmat_collection_allowed` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Collection Allowed');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `organics_program_active` SET TAGS ('dbx_business_glossary_term' = 'Organics Program Active');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `recycling_program_active` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Active');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `route_count` SET TAGS ('dbx_business_glossary_term' = 'Route Count');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `service_days` SET TAGS ('dbx_business_glossary_term' = 'Service Days');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|construction_demolition|mixed');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `vehicle_type_required` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type Required');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `vehicle_type_required` SET TAGS ('dbx_value_regex' = 'automated_side_loader|front_end_loader|rear_end_loader|roll_off|mixed');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `on_demand_request_id` SET TAGS ('dbx_business_glossary_term' = 'On-Demand Request ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Route ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `special_waste_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Special Waste Approval Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `actual_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `container_quantity` SET TAGS ('dbx_business_glossary_term' = 'Container Quantity');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `customer_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `customer_signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `disposal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Disposal Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `estimated_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `photo_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `photo_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Photo Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|emergency');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^ODR-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `requested_service_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `scheduled_service_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `scheduled_time_window_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Time Window End');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `scheduled_time_window_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Time Window Start');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration (Minutes)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Met Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'customer_portal|mobile_app|call_center|email|field_sales|crm');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `rolloff_order_id` SET TAGS ('dbx_business_glossary_term' = 'Roll-Off Order ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Container Prep Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `special_waste_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Special Waste Approval Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Truck ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `actual_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `base_rental_charge` SET TAGS ('dbx_business_glossary_term' = 'Base Rental Charge');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `container_size_yards` SET TAGS ('dbx_business_glossary_term' = 'Container Size (Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `delivery_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Actual Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `delivery_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Scheduled Date');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `disposal_charge` SET TAGS ('dbx_business_glossary_term' = 'Disposal Charge');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `environmental_fee` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Roll-Off Order Number');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^RO-[0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `overage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Overage Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `overage_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Overage Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|due_on_receipt|prepaid');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `pull_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pull Actual Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `pull_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Pull Scheduled Date');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `rental_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Rental Duration (Days)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'AMCS|Waste_Logics|Salesforce|Manual');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `swap_count` SET TAGS ('dbx_business_glossary_term' = 'Swap Count');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `weight_limit_tons` SET TAGS ('dbx_business_glossary_term' = 'Weight Limit (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Generator Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `inbound_load_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Load Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `landfill_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Tipping Fee Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `outbound_haul_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'landfill|transfer_station|mrf|wte|tsdf|other');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `gross_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'full_route|partial_route|direct_haul|emergency|special_waste|return_trip');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `net_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `net_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `origin_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Type');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `origin_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|construction|special_event');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Rejection Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'facility_scale|amcs|sap_sd|manual_entry|mobile_app');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `tare_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'draft|validated|billed|disputed|voided|corrected');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `tipping_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Amount (USD)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `tipping_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `validation_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `weigh_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-In Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `weigh_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-Out Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Mrf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `accepts_commercial_waste` SET TAGS ('dbx_business_glossary_term' = 'Accepts Commercial Waste Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `accepts_construction_debris` SET TAGS ('dbx_business_glossary_term' = 'Accepts Construction and Demolition (C&D) Debris Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `accepts_hazardous_waste` SET TAGS ('dbx_business_glossary_term' = 'Accepts Hazardous Waste Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `accepts_recyclables` SET TAGS ('dbx_business_glossary_term' = 'Accepts Recyclables Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `accepts_residential_waste` SET TAGS ('dbx_business_glossary_term' = 'Accepts Residential Waste Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `environmental_compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Officer Name');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'MSW|C&D|mixed|recycling|organics|hazmat');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `lea_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Local Enforcement Agency (LEA) Jurisdiction');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `operational_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Operational Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_construction|decommissioned|seasonal');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|operated_under_contract|joint_venture');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Number');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `permitted_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `scale_count` SET TAGS ('dbx_business_glossary_term' = 'Scale Count');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `scale_type` SET TAGS ('dbx_business_glossary_term' = 'Scale Type');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `scale_type` SET TAGS ('dbx_value_regex' = 'truck_scale|axle_scale|portable_scale|mixed');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station Code');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station Name');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `tipping_floor_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Tipping Floor Area Square Feet');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `inbound_load_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Load Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `landfill_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Tipping Fee Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `outbound_haul_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `acceptance_decision` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Decision');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `acceptance_decision` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditional');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `contamination_level` SET TAGS ('dbx_business_glossary_term' = 'Contamination Level');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `contamination_level` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high|rejected');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `disposal_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Authorization Number');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `driver_cdl_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `environmental_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `gate_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate Entry Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `gate_exit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate Exit Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `gross_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `hauler_type` SET TAGS ('dbx_business_glossary_term' = 'Hauler Type');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `hauler_type` SET TAGS ('dbx_value_regex' = 'company_fleet|third_party_contractor|municipal|customer_self_haul');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `measurement_accuracy_grade` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy Grade');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `measurement_accuracy_grade` SET TAGS ('dbx_value_regex' = 'certified|standard|estimated');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `net_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `pre_entry_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Pre-Entry Inspection Result');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `pre_entry_inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|waived|not_required');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `rejection_disposition_instructions` SET TAGS ('dbx_business_glossary_term' = 'Rejection Disposition Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `rfid_transponder_scan` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Transponder Scan');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `scale_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Scale Calibration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `tare_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'draft|completed|voided|disputed|adjusted');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `tipping_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_characterization_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Characterization Method');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_characterization_method` SET TAGS ('dbx_value_regex' = 'visual_inspection|manifest_declaration|sampling|customer_declaration|default_profile');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_origin_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin Jurisdiction');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `weigh_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-In Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `weigh_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-Out Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `scale_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Transaction ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Calibration Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `cid` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Transaction Comments');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `disposal_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Authorization Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `gross_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `load_type` SET TAGS ('dbx_business_glossary_term' = 'Load Type');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `load_type` SET TAGS ('dbx_value_regex' = 'collection|transfer|commercial|residential|rolloff|special_waste');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `net_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `net_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Rejection Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `scale_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Scale Calibration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `scale_calibration_record_number` SET TAGS ('dbx_business_glossary_term' = 'Scale Calibration Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `tare_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Scale Ticket Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `tipping_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `tipping_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|voided|disputed|corrected|rejected');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|tare_only|reweigh');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `validation_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `vehicle_plate_number` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Plate Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `weighmaster_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Weighmaster Certification Number');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `tipping_fee_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `landfill_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Tipping Fee Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Mrf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `superseded_by_rate_tipping_fee_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `vehicle_class_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Code Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `contamination_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Contamination Penalty Rate');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `environmental_fee` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `fuel_surcharge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'per_ton|per_load|per_cubic_yard|per_trip|flat_rate');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Name');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Ton');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|superseded');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `rate_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|economy|negotiated|promotional');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `regulatory_rate_cap` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Cap');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `seasonal_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Rate Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_SD|ORACLE_RM|AMCS|MANUAL|LEGACY');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `volume_discount_rate_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Rate Per Ton');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `volume_discount_threshold_tons` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Threshold Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `outbound_haul_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `landfill_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Tipping Fee Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `special_waste_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Special Waste Approval Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `actual_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Actual Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Type');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_value_regex' = 'landfill|mrf|wte|tsdf|other');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `dispatch_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `driver_notes` SET TAGS ('dbx_business_glossary_term' = 'Driver Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `environmental_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `estimated_fuel_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fuel Consumption Gallons');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `estimated_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `generator_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Generator Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `haul_number` SET TAGS ('dbx_business_glossary_term' = 'Haul Number');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `haul_status` SET TAGS ('dbx_business_glossary_term' = 'Haul Status');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `haul_status` SET TAGS ('dbx_value_regex' = 'scheduled|dispatched|in_transit|delivered|rejected|cancelled');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `load_rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Load Rejection Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `receiver_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Receiver Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `route_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Route Distance Miles');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `tipping_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `tipping_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `transporter_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Transporter Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `haul_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Manifest ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cell Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `outbound_haul_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `special_waste_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Special Waste Approval Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `transporter_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Transporter Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `bol_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'compactor|open_top|roll_off|transfer_trailer|walking_floor');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Departure Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `destination_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Signature Name');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `destination_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Destination Signature Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `driver_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Driver Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `driver_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Driver Signature Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `gross_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `manifest_issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifest Issued Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_business_glossary_term' = 'Manifest Status');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `manifest_status` SET TAGS ('dbx_value_regex' = 'draft|issued|in_transit|delivered|rejected|voided');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `origin_signature_name` SET TAGS ('dbx_business_glossary_term' = 'Origin Signature Name');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `origin_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Origin Signature Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `rcra_manifest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Manifest Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Rejection Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `seal_numbers` SET TAGS ('dbx_business_glossary_term' = 'Seal Numbers');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `tare_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `total_net_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `facility_capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Capacity Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `actual_inbound_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Actual Inbound Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `actual_outbound_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Actual Outbound Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `average_daily_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Status');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_value_regex' = 'normal|near_capacity|over_capacity|under_capacity');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `capacity_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `diversion_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversion Rate Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `exceedance_reason` SET TAGS ('dbx_business_glossary_term' = 'Permit Exceedance Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `exceedance_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Permit Exceedance Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `floor_storage_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Floor Storage Tonnage End of Day');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `inbound_cd_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Inbound Construction and Demolition (C&D) Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `inbound_load_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Inbound Loads');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `inbound_msw_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Inbound Municipal Solid Waste (MSW) Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `inbound_organics_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Inbound Organics Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `inbound_recyclable_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Inbound Recyclable Material Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `operational_notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `outbound_haul_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Outbound Hauls');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `outbound_landfill_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Outbound Landfill Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `outbound_mrf_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Outbound Materials Recovery Facility (MRF) Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `outbound_wte_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Outbound Waste-to-Energy (WTE) Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `peak_hour_throughput_tons` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Throughput Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `peak_hour_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `permit_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Exceedance Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `permitted_daily_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Daily Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Record Date');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `record_period` SET TAGS ('dbx_business_glossary_term' = 'Capacity Record Period');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `record_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Record Status');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|validated|submitted|archived');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` SET TAGS ('dbx_subdomain' = 'transfer_handling');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Tsdf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `environmental_fee_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Per Ton');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `estimated_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Travel Time in Minutes');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Operational Status');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|seasonal');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'landfill|mrf|wte|tsdf|composting|transfer_station');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `fuel_surcharge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `haul_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Haul Distance in Miles');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Facility Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Number');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `permitted_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity Tons Per Day (TPD)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `preferred_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Facility Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `requires_manifest_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Manifest Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `scale_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Scale Available Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `tipping_fee_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Per Ton');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `tipping_fee_per_ton` SET TAGS ('dbx_confidential' = 'true');
