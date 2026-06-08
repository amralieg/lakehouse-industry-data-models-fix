-- Schema for Domain: collection | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`collection` COMMENT 'Core operational domain managing all waste collection, hauling, and transfer operations including residential/commercial pickup routes, transfer station consolidation, driver assignments, container placements, weight tickets, and outbound haul dispatch to disposal facilities.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`route` (
    `route_id` BIGINT COMMENT 'Unique identifier for the waste collection route. Primary key.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_initiative. Business justification: Route optimization and electrification initiatives directly target collection route emissions. Tracking which routes participate in carbon reduction programs enables initiative performance measurement',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Routes execute service commitments defined in customer contracts. Route planning, pricing validation, and SLA compliance reporting require linking routes to their governing agreements. Essential for c',
    `facility_id` BIGINT COMMENT 'Reference to the primary disposal facility (landfill, transfer station, Materials Recovery Facility (MRF), or Waste-to-Energy (WTE) plant) where collected waste is delivered.',
    `district_id` BIGINT COMMENT 'Reference to the operational district or region to which this route is assigned.',
    `fuel_purchase_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_purchase. Business justification: Routes plan fuel consumption; operations reconcile planned vs. actual fuel purchases for cost allocation and efficiency analysis. Fleet managers use this to validate fuel budgets per route and detect ',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Routes are organized by service line (residential, commercial, industrial) for operational planning, fleet assignment, and pricing model selection. Essential for route optimization and resource alloca',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Collection routes operate under facility operating permits defining service areas, waste types, and operational constraints. Routes must comply with permitted activities and capacity limits. Essential',
    `driver_id` BIGINT COMMENT 'Reference to the driver typically assigned to this route. Actual daily assignments may vary and are tracked in route execution records.',
    `capacity_constraint_tons` DECIMAL(18,2) COMMENT 'Maximum tonnage capacity for this route based on truck payload limits and disposal facility constraints.',
    `container_type_primary` STRING COMMENT 'Primary type of waste container serviced on this route: cart (residential curbside), bin (small commercial), dumpster (large commercial), compactor, or roll-off container.. Valid values are `cart|bin|dumpster|compactor|roll_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this route record was first created in the system.',
    `customer_segment` STRING COMMENT 'Primary customer segment served by this route: residential, commercial, industrial, or municipal accounts.. Valid values are `residential|commercial|industrial|municipal`',
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
    `sla_on_time_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of stops that must be serviced within the scheduled time window to meet Service Level Agreement (SLA) commitments.',
    `start_location_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the route start location (typically a depot or transfer station).',
    `start_location_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the route start location (typically a depot or transfer station).',
    `total_mileage` DECIMAL(18,2) COMMENT 'Total planned mileage for the route in miles, including travel to first stop, between stops, and return to facility.',
    `total_stops` STRING COMMENT 'Total number of scheduled service stops (customer pickup points) on this route.',
    `truck_type_required` STRING COMMENT 'Type of collection vehicle required for this route: Automated Side Loader (ASL), Front End Loader (FEL), Rear End Loader (REL), roll-off truck, or compactor truck.. Valid values are `ASL|FEL|REL|roll_off|compactor`',
    `zone_code` STRING COMMENT 'Sub-district zone code for finer geographic segmentation within a district.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_route PRIMARY KEY(`route_id`)
) COMMENT 'Master record for a defined waste collection route, representing a named geographic sequence of stops assigned to a specific truck type (ASL, FEL, REL) and service line (MSW, C&D, bulk). Captures route code, district, zone, day-of-week schedule, estimated duration, total stops, total mileage, truck type requirement, service frequency, capacity constraints, and active status. Sourced from AMCS Platform route master. This is the canonical route definition — the template from which daily route executions are generated. One route may produce multiple executions per week depending on service frequency.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`route_execution` (
    `route_execution_id` BIGINT COMMENT 'Unique identifier for a single days execution of a route. Primary key representing the operational instance of a route on a specific service date.',
    `air_emission_event_id` BIGINT COMMENT 'Foreign key linking to compliance.air_emission_event. Business justification: Route executions generate emissions events when vehicles experience mechanical failures, fuel spills, or exhaust system malfunctions requiring regulatory notification and emissions reporting.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: Safety audits are conducted on active route executions to verify driver behavior, vehicle condition, and operational compliance. Real-world safety programs audit routes in progress for behavioral obse',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Regulatory inspectors observe route executions during field inspections to verify collection protocols, safety standards, and permit compliance. Direct inspection-to-operation link for enforcement and',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Route executions fulfill contractual service obligations. Performance obligation satisfaction, revenue recognition, and SLA compliance measurement require linking executions to contracts. Critical for',
    `facility_id` BIGINT COMMENT 'Reference to the landfill, transfer station, or disposal facility where collected waste was delivered.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Route executions disposing directly at landfills (vs. transfer stations) need landfill site FK for operational tracking, capacity planning, waste flow analysis, and route-to-disposal reporting. Real d',
    `driver_id` BIGINT COMMENT 'Reference to the driver assigned to execute this route on the service date.',
    `fuel_purchase_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_purchase. Business justification: Route executions consume fuel tracked in fuel purchases. Finance reconciles fuel_consumed_gallons against fuel_purchase records for cost accounting, variance analysis, and GL posting. Core operational',
    `inbound_load_id` BIGINT COMMENT 'Foreign key linking to recycling.inbound_load. Business justification: Collection route executions delivering recyclables directly to MRFs need linkage to the resulting inbound load for operational reconciliation, driver accountability, and diversion reporting. This supp',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Route executions transporting hazardous waste generate manifests for RCRA compliance. Essential for regulatory tracking of hazmat collection routes and proof-of-transport documentation required by EPA',
    `route_id` BIGINT COMMENT 'Reference to the master route definition that was executed. Links to the planned route template.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Route supervisors monitor daily execution performance, approve route deviations, handle driver escalations, and ensure SLA compliance—core operational oversight in waste collection operations.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station used for waste consolidation during this route execution, if applicable.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection truck assigned to this route execution.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Collection routes deliver MSW to WTE facilities for energy recovery. Route execution tracks actual disposal destination. Enables tonnage-to-energy correlation analysis, route planning optimization to ',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`collection_stop` (
    `collection_stop_id` BIGINT COMMENT 'Unique identifier for the service stop. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Stops serve customer locations under specific service agreements. Billing validation, service commitment verification, and contract scope audits require linking stops to their governing contracts. Fun',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account being serviced at this stop.',
    `driver_id` BIGINT COMMENT 'Reference to the driver assigned to service this stop.',
    `epa_id_registration_id` BIGINT COMMENT 'Foreign key linking to hazmat.epa_id_registration. Business justification: Stops at hazmat generator sites reference EPA ID for regulatory tracking and service authorization. Required for verifying generator permit status at point of service.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Each stop represents delivery of a specific service offering (weekly MSW, bi-weekly recycling, bulk pickup). Critical for service fulfillment tracking, billing validation, SLA compliance monitoring, a',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Service stops must comply with permit conditions regarding acceptable waste types, service frequencies, and operational hours. Permit violations at stops trigger compliance actions and service restric',
    `route_id` BIGINT COMMENT 'Reference to the route this stop belongs to. Links stop to its parent collection route.',
    `service_address_id` BIGINT COMMENT 'Reference to the physical service address where collection occurs.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Stops requiring special handling (restricted access, hazmat, customer escalation) need supervisor assignment for field resolution authority and customer communication during service delivery.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection vehicle assigned to service this stop.',
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
    `special_handling_notes` STRING COMMENT 'Additional instructions for service delivery, such as backup required, hazardous materials present, or customer preferences.',
    `stop_number` STRING COMMENT 'Business identifier for the stop, often used in driver manifests and dispatch communications.',
    `stop_status` STRING COMMENT 'Current operational status of the stop within its service lifecycle.. Valid values are `scheduled|in_progress|completed|skipped|cancelled|suspended`',
    `stop_type` STRING COMMENT 'Classification of the stop based on customer segment and service characteristics.. Valid values are `residential|commercial|industrial|municipal|temporary|special_event`',
    `volume_collected_cubic_yards` DECIMAL(18,2) COMMENT 'Estimated volume in cubic yards of waste collected at this stop.',
    `waste_stream_type` STRING COMMENT 'Classification of the waste material collected at this stop. MSW = Municipal Solid Waste, C&D = Construction and Demolition Waste.. Valid values are `msw|recycling|organics|c_and_d|hazardous|e_waste`',
    `weight_collected_lbs` DECIMAL(18,2) COMMENT 'Total weight in pounds of waste collected at this stop, captured via onboard scales or estimated.',
    CONSTRAINT pk_collection_stop PRIMARY KEY(`collection_stop_id`)
) COMMENT 'Master record for an individual service stop on a route, representing a physical service location (residential address or commercial site) with a defined sequence position. Captures stop sequence number, planned arrival window, estimated service duration, service address, customer account reference, container count, service type (curbside, alley, drive-in), access notes, CID/RFID tag identifiers for containers at this stop, special instructions (gate codes, back-up required), and stop status. Sourced from AMCS Platform and Waste Logics. SSOT for the stop-level service assignment and sequencing within a route.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`pickup_event` (
    `pickup_event_id` BIGINT COMMENT 'Unique identifier for the pickup event. Primary key for the pickup_event data product.',
    `asset_container_id` BIGINT COMMENT 'Identifier of the primary container serviced during this pickup event. Container Identification (CID) is the unique identifier assigned to each waste container for tracking and service verification.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Inspectors witness individual pickup events to verify proper handling procedures, contamination controls, and safety compliance. Direct observation relationship for regulatory verification and enforce',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Pickup events are billable service transactions governed by contracts. Invoice generation, overage charge calculation, and proof-of-service documentation require linking events to contracts. Essential',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this pickup event.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who performed the pickup service.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Incidents during pickup (container tip-over, spill, injury) must link to the specific pickup event for root cause analysis, liability determination, workers compensation claims, and service quality tr',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Individual hazmat pickup events require manifest documentation per RCRA regulations. Links proof-of-service at container level to regulatory chain-of-custody for hazardous waste generators.',
    `route_execution_id` BIGINT COMMENT 'Identifier linking this pickup event to the parent route execution instance during which the pickup occurred.',
    `service_address_id` BIGINT COMMENT 'Identifier of the service address where the pickup occurred.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Exception pickups (contamination flags, safety incidents, customer disputes) require supervisor review and approval in real-time for service recovery and billing adjustments.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the collection vehicle used to perform the pickup.',
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
    `waste_stream_type` STRING COMMENT 'Type of waste stream collected during this pickup. MSW (Municipal Solid Waste), Recycling, C&D (Construction and Demolition Waste), Bulk, Yard Waste, or Hazardous.. Valid values are `msw|recycling|c_and_d|bulk|yard_waste|hazardous`',
    `weather_condition` STRING COMMENT 'Weather condition at the time of service, captured for safety analysis and route performance evaluation.. Valid values are `clear|rain|snow|ice|fog|wind`',
    CONSTRAINT pk_pickup_event PRIMARY KEY(`pickup_event_id`)
) COMMENT 'Transactional record capturing the actual execution of a single waste pickup at a stop during a route execution, including container-level proof of service via RFID. Records timestamp of arrival, timestamp of service completion, driver ID, truck ID, container(s) serviced (by CID/RFID), RFID scan result (successful read, no read, damaged tag), lift confirmation from PTO sensor, waste stream type (MSW, recycling, C&D, bulk), estimated weight or lift count, GPS coordinates at time of service, compaction ratio recorded, and service outcome (completed, skipped, contaminated). Sourced from Locus Dispatch, Geotab telemetry, and AMCS Platform RFID readers. Core operational event of the collection domain — SSOT for both service execution and container-level proof-of-service.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`service_exception` (
    `service_exception_id` BIGINT COMMENT 'Unique identifier for the service exception record. Primary key.',
    `asset_container_id` BIGINT COMMENT 'Reference to the specific container involved in the exception event, tracked via Container Identification (CID) system.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Service exceptions may trigger SLA penalties, credits, or breach notifications defined in contracts. Exception resolution, penalty calculation, and contract compliance reporting require linking except',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account affected by this service exception.',
    `driver_id` BIGINT COMMENT 'Reference to the driver who reported or encountered the service exception.',
    `emergency_response_incident_id` BIGINT COMMENT 'Foreign key linking to hazmat.emergency_response_incident. Business justification: Service exceptions involving hazmat spills or releases trigger emergency response incidents requiring NRC notification. Links operational exception tracking to regulatory incident reporting and remedi',
    `employee_id` BIGINT COMMENT 'Reference to the system user or employee who resolved and closed the exception.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Service exceptions (access blocked, contamination, equipment failure) can escalate to safety incidents. Tracking this relationship is essential for identifying systemic hazards, preventing recurrence,',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Service exceptions (container damage, equipment failure at stop, access issues requiring physical changes) often trigger maintenance work orders for corrective action. Tracking the resulting WO enable',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service exceptions are tracked against specific offerings for SLA breach analysis, credit issuance, and service quality monitoring. Critical for customer satisfaction management, operational performan',
    `route_id` BIGINT COMMENT 'Reference to the collection route where the exception occurred.',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service address where the exception occurred.',
    `service_request_id` BIGINT COMMENT 'Reference to the originating service request that this exception is associated with.',
    `spill_release_id` BIGINT COMMENT 'Foreign key linking to compliance.spill_release. Business justification: Service exceptions involving spills or releases of hazardous materials trigger spill_release incident reporting and regulatory notification to environmental agencies per CERCLA and state requirements.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection vehicle involved in the exception event.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Service exceptions may be caused by vendor performance issues (vendor-operated equipment failure, vendor driver issues). Operations tracks exception root causes to vendors for contract compliance and ',
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
    `driver_id` BIGINT COMMENT 'Reference to the driver who performed the container placement. Links to the workforce employee record.',
    `vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle used to deliver and place the container. Links to the fleet asset master record.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that authorized and tracked the container placement activity. Links to the work order management system.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Container placements fulfill service commitments in customer contracts. Equipment deployment tracking, billable placement charges, and contract scope verification require linking placements to agreeme',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that is assigned this container placement. Links the container to the billing and service account.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Container placements fulfill specific service offerings (temporary dumpster rental, permanent cart deployment). Essential for asset deployment tracking, service initiation billing, container inventory',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Container placements must comply with permit conditions regarding container types, waste streams, and placement locations. Permit restrictions govern placement activities and container management prog',
    `primary_container_removal_driver_id` BIGINT COMMENT 'Reference to the driver who performed the container removal. Links to the workforce employee record.',
    `primary_container_removal_vehicle_id` BIGINT COMMENT 'Reference to the fleet vehicle used to remove the container. Links to the fleet asset master record.',
    `primary_container_removal_work_order_id` BIGINT COMMENT 'Reference to the work order that authorized and tracked the container removal activity. Links to the work order management system.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Container placements may be fulfilled via purchase orders for container rental or delivery services from third-party vendors. Operations reconciles placement_work_order_id against POs for billing vali',
    `rfid_tag_id` BIGINT COMMENT 'Unique RFID tag identifier embedded in or attached to the container for automated tracking and identification during collection operations.',
    `route_id` BIGINT COMMENT 'Reference to the collection route assigned to service this container placement. Links to the route master record for dispatch and optimization.',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service location where the container is physically placed. Links to the service address master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Container placements/removals requiring site assessment, customer coordination, or permit verification need supervisor authorization for asset accountability and customer billing accuracy.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Hazmat container placements must match approved waste profiles to ensure proper container type, labeling, and compatibility. Prevents unauthorized waste accumulation and ensures RCRA compliance.',
    `actual_removal_date` DATE COMMENT 'Actual date when the container was physically removed from the service location. Marks the end of the container assignment lifecycle.',
    `cid` STRING COMMENT 'Unique Container Identification number assigned to the physical container. Industry-standard identifier used for tracking and asset management across the waste collection lifecycle.. Valid values are `^[A-Z0-9]{8,12}$`',
    `container_condition_at_placement` STRING COMMENT 'Physical condition assessment of the container at the time of placement. Used for asset lifecycle tracking and maintenance planning.. Valid values are `new|good|fair|damaged|needs-repair`',
    `container_condition_at_removal` STRING COMMENT 'Physical condition assessment of the container at the time of removal. Used for asset lifecycle tracking, maintenance planning, and loss tracking.. Valid values are `good|fair|damaged|needs-repair|lost|stolen`',
    `container_size` STRING COMMENT 'Physical capacity of the container expressed with unit of measure (e.g., 2-yd, 4-yd, 6-yd, 8-yd, 96-gal, 10-cu-yd, 20-cu-yd, 30-cu-yd, 40-cu-yd). Critical for route planning and capacity management.. Valid values are `^[0-9]+(yd|gal|cu-yd)$`',
    `container_type` STRING COMMENT 'Classification of the container by form factor and collection mechanism (e.g., dumpster, cart, roll-off box, compactor, toter, bin).. Valid values are `dumpster|cart|roll-off|compactor|toter|bin`',
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
    `facility_id` BIGINT COMMENT 'Identifier of the operations depot (facility) from which the driver and truck are dispatched for this route execution. Links to the facility master record.',
    `hazwoper_training_id` BIGINT COMMENT 'Foreign key linking to hazmat.hazwoper_training. Business justification: Drivers assigned to hazmat collection routes must have current HAZWOPER certification per OSHA 1910.120. Links assignment to training verification for regulatory compliance and safety qualification.',
    `observation_id` BIGINT COMMENT 'Foreign key linking to safety.safety_observation. Business justification: Safety observations are made on specific driver assignments during their shift. Observers need to link observations to the assignment context (route type, vehicle, shift conditions) for meaningful beh',
    `employee_id` BIGINT COMMENT 'Identifier of the helper (second crew member) assigned to assist the driver on this route execution. Links to the workforce employee master record. Null if no helper assigned.',
    `driver_id` BIGINT COMMENT 'Identifier of the Commercial Driver License (CDL) licensed driver assigned to execute the route. Links to the driver master record in Workday HCM.',
    `route_execution_id` BIGINT COMMENT 'Identifier of the specific route execution instance that the driver is assigned to perform. Links to the route execution transactional record.',
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
    `hos_available_drive_hours` DECIMAL(18,2) COMMENT 'The number of driving hours available to the driver under DOT hours-of-service regulations at the time of assignment. Calculated from the drivers electronic logging device (ELD) data and used to ensure compliance with the 11-hour driving limit.',
    `hos_available_duty_hours` DECIMAL(18,2) COMMENT 'The number of on-duty hours available to the driver under DOT hours-of-service regulations at the time of assignment. Calculated from the drivers electronic logging device (ELD) data and used to ensure compliance with the 14-hour on-duty limit.',
    `pre_trip_inspection_status` STRING COMMENT 'Status of the mandatory pre-trip vehicle inspection conducted by the driver before route execution. Passed indicates inspection completed with no defects, failed indicates defects found requiring maintenance, pending indicates inspection not yet completed, not_required indicates inspection waived for specific assignment type, waived indicates management override.. Valid values are `passed|failed|pending|not_required|waived`',
    `pre_trip_inspection_timestamp` TIMESTAMP COMMENT 'The timestamp when the pre-trip vehicle inspection was completed and recorded by the driver. Used for DOT compliance documentation and audit trail.',
    `route_type` STRING COMMENT 'Classification of the route type that the driver is assigned to execute. Residential for curbside household collection, commercial for business waste pickup, roll_off for large container haul, recycling for materials recovery collection, hazardous for special waste handling.. Valid values are `residential|commercial|roll_off|recycling|hazardous`',
    `service_area_code` STRING COMMENT 'Geographic service area code where the route is executed. Formatted as 2-3 letter region code followed by 3-digit zone number (e.g., NE-001, SW-042). Used for territory management and performance reporting.. Valid values are `^[A-Z]{2,3}-[0-9]{3}$`',
    `service_date` DATE COMMENT 'The calendar date on which the driver is assigned to execute the route. This is the business event date for the assignment and the primary date dimension for operational reporting.',
    `shift_end_time` TIMESTAMP COMMENT 'The scheduled timestamp when the driver is expected to complete their shift and return to the depot. Used for workforce scheduling and DOT hours-of-service compliance tracking.',
    `shift_start_time` TIMESTAMP COMMENT 'The scheduled timestamp when the driver is expected to begin their shift and commence route execution. Used for workforce scheduling and Department of Transportation (DOT) hours-of-service compliance tracking.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this driver assignment record. Locus_dispatch for automated dispatch assignments, workday_hcm for workforce management initiated assignments, manual_entry for dispatcher-created assignments.. Valid values are `locus_dispatch|workday_hcm|manual_entry`',
    `source_system_record_code` STRING COMMENT 'The unique record identifier from the source operational system (Locus Dispatch or Workday HCM). Used for data lineage tracking and reconciliation with source systems.',
    CONSTRAINT pk_driver_assignment PRIMARY KEY(`driver_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a CDL-licensed driver to a specific route execution on a given service date. Records driver ID, route execution reference, truck ID, assignment type (primary, relief, trainee), shift start time, shift end time, pre-trip inspection status, DOT hours-of-service compliance flag, and assignment status (scheduled, active, completed, absent). Sourced from Locus Dispatch and Workday HCM. Enables driver performance tracking, DOT compliance, and route coverage management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`truck_assignment` (
    `truck_assignment_id` BIGINT COMMENT 'Unique identifier for the truck assignment record. Primary key for this transactional entity capturing the assignment of a collection vehicle to a route execution on a specific service date.',
    `fuel_purchase_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_purchase. Business justification: Truck assignments determine which vehicle consumed fuel on which date. Fleet managers reconcile fuel purchases against assignments to detect unauthorized usage, validate fuel efficiency by vehicle, an',
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
    `post_trip_inspection_status` STRING COMMENT 'Result of the post-trip vehicle inspection performed after route completion. Identifies any defects or maintenance needs discovered during route execution.. Valid values are `pass|fail|conditional|not_performed`',
    `post_trip_inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the post-trip inspection was completed. Used for maintenance work order generation and fleet safety tracking.',
    `pre_trip_inspection_status` STRING COMMENT 'Result of the mandatory DOT pre-trip vehicle inspection performed before route execution. Pass indicates vehicle is safe for operation; fail or conditional requires maintenance intervention before dispatch.. Valid values are `pass|fail|conditional|not_performed`',
    `pre_trip_inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the pre-trip inspection was completed. Required for DOT compliance documentation and OSHA safety audit trails.',
    `reassignment_reason` STRING COMMENT 'Free-text explanation for why the truck was reassigned during route execution. Captures operational context for vehicle breakdowns, driver changes, route adjustments, or emergency redeployment.',
    `route_deviation_flag` BOOLEAN COMMENT 'Indicates whether the truck deviated from the planned route during execution. True if GPS tracking detected significant off-route travel, triggering operational review or customer service follow-up.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during this truck assignment. True if an accident, injury, near-miss, or OSHA-reportable event was logged during route execution.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned date and time when the truck is scheduled to begin the route execution. Used for dispatch planning and driver coordination.',
    `truck_type` STRING COMMENT 'Classification of the collection vehicle by body configuration and loading mechanism. ASL (Automated Side Loader), FEL (Front End Loader), REL (Rear End Loader), roll-off for container hauling, compactor for transfer operations. [ENUM-REF-CANDIDATE: ASL|FEL|REL|roll_off|compactor|hook_lift|grapple|flatbed — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_truck_assignment PRIMARY KEY(`truck_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of a specific collection vehicle (ASL, FEL, REL, roll-off, CNG/RNG unit) to a route execution on a given service date. Records vehicle ID, route execution reference, truck type, fuel type (diesel, CNG, RNG), odometer at assignment, pre-trip inspection pass/fail, assigned capacity (cubic yards), and assignment status. Sourced from AMCS Platform and Geotab Fleet Telematics. Distinct from driver_assignment — a truck and driver are assigned independently and may change mid-route.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`service_schedule` (
    `service_schedule_id` BIGINT COMMENT 'Unique identifier for the service schedule record. Primary key.',
    `collection_stop_id` BIGINT COMMENT 'Reference to the collection stop associated with this schedule. Links to the stop master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Service schedules track which employee created them for audit trail, training assessment, and accountability in customer service setup—complements modified_by_user for change tracking.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owns this service schedule. Links to the customer account master record.',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Schedules reference standardized frequency plans (weekly, bi-weekly, on-demand) for consistent service delivery. Critical for route optimization, capacity planning, customer contract fulfillment, and ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service schedules define recurring delivery of specific offerings to customers. Essential for subscription management, automated billing, contract fulfillment tracking, and service level agreement enf',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service address where collection occurs. Links to the service address master record.',
    `sla_term_id` BIGINT COMMENT 'Reference to the SLA governing this service schedule. Defines performance commitments, response times, and service guarantees.',
    `access_requirements` STRING COMMENT 'Special access conditions required to service this stop. Used for driver preparation and route planning.. Valid values are `none|gate_code|key_required|escort_required|restricted_hours|call_ahead`',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether this schedule automatically renews at the end of its term. True if the schedule continues indefinitely unless cancelled.',
    `billing_frequency` STRING COMMENT 'Frequency at which the customer is billed for this scheduled service. May differ from service frequency.. Valid values are `per_service|weekly|monthly|quarterly|annual`',
    `container_quantity` STRING COMMENT 'Number of containers serviced at this stop per scheduled pickup. Used for capacity planning and billing calculations.',
    `container_size` DECIMAL(18,2) COMMENT 'Capacity of the container in cubic yards or gallons, depending on container type. Used for capacity planning and billing.',
    `container_size_unit` STRING COMMENT 'Unit of measure for the container size. Standardizes capacity reporting across different container types.. Valid values are `cubic_yards|gallons|liters`',
    `container_type` STRING COMMENT 'Type of waste container used for this scheduled service. Determines collection equipment and handling procedures. [ENUM-REF-CANDIDATE: cart|bin|dumpster|compactor|roll_off|bag|toter — 7 candidates stripped; promote to reference product]',
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
    `waste_stream` STRING COMMENT 'Classification of the waste material being collected. Determines disposal routing, processing requirements, and regulatory compliance obligations. MSW = Municipal Solid Waste, C&D = Construction and Demolition. [ENUM-REF-CANDIDATE: msw|recycling|organics|yard_waste|construction_demolition|hazardous|special — 7 candidates stripped; promote to reference product]',
    `wednesday_flag` BOOLEAN COMMENT 'Indicates whether service is scheduled on Wednesdays. True if Wednesday is a scheduled service day.',
    CONSTRAINT pk_service_schedule PRIMARY KEY(`service_schedule_id`)
) COMMENT 'Master record defining the recurring service schedule for a customer stop — the days of week, frequency (weekly, bi-weekly, monthly, on-call), effective date range, and service windows. Captures customer account reference, stop reference, service frequency code, scheduled days of week, start date, end date, holiday handling rule, and schedule status. Sourced from Waste Logics and AMCS Platform. SSOT for when a customer is supposed to receive service — distinct from route_stop_sequence which defines the order within a route.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`route_optimization_run` (
    `route_optimization_run_id` BIGINT COMMENT 'Unique identifier for each execution of the route optimization algorithm. Primary key.',
    `area_id` BIGINT COMMENT 'Reference to the geographic service area for which this optimization was executed.',
    `carbon_initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_initiative. Business justification: Route optimization directly supports carbon reduction initiatives through mileage reduction and fuel efficiency. Linking optimization runs to initiatives enables ROI measurement, carbon credit validat',
    `employee_id` BIGINT COMMENT 'Reference to the user (operations manager or dispatcher) who made the acceptance decision. Nullable if decision is still pending.',
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
    `secondary_optimization_objective` STRING COMMENT 'The secondary business objective applied as a tie-breaker or secondary goal when the primary objective is met. Nullable if only one objective was used.. Valid values are `minimize_miles|minimize_time|maximize_compaction|balance_workload|minimize_cost|maximize_service_quality`',
    `time_window_enforcement_flag` BOOLEAN COMMENT 'Indicates whether customer-specific time window constraints were enforced during optimization (True) or relaxed (False).',
    `vehicle_capacity_constraint_flag` BOOLEAN COMMENT 'Indicates whether vehicle capacity constraints (weight and volume limits) were enforced during optimization (True) or relaxed (False).',
    CONSTRAINT pk_route_optimization_run PRIMARY KEY(`route_optimization_run_id`)
) COMMENT 'Transactional record capturing each execution of the route optimization algorithm in AMCS Platform, including the optimization scenario (daily re-optimization, seasonal rebalancing, new customer onboarding), input parameters (number of stops, truck count, time windows, vehicle capacities), optimization objectives (minimize miles, minimize time, maximize compaction), output metrics (total route miles, total route hours, stops per truck), and whether the optimized plan was accepted or rejected. Sourced from AMCS Platform. Enables optimization performance tracking and scenario comparison.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`district` (
    `district_id` BIGINT COMMENT 'Primary key for district',
    `employee_id` BIGINT COMMENT 'Unique identifier of the operations manager assigned to this district. References employee master data.',
    `district_operations_manager_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `facility_id` BIGINT COMMENT 'Unique identifier of the depot or yard facility that services this district. References facility master data.',
    `reduction_target_id` BIGINT COMMENT 'Foreign key linking to sustainability.reduction_target. Business justification: Collection districts are operational units for carbon reduction target setting. District-level targets (e.g., 20% emission reduction by 2030) require linking to corporate sustainability targets for ca',
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
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction or local enforcement agency governing this district (e.g., county, regional authority).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was last updated in the system.',
    `municipality` STRING COMMENT 'Name of the municipality, city, or township that this district serves. Used for regulatory jurisdiction alignment.',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`compaction_measurement` (
    `compaction_measurement_id` BIGINT COMMENT 'Primary key for compaction_measurement',
    `area_id` BIGINT COMMENT 'Identifier of the geographic collection zone where this measurement was captured.',
    `driver_id` BIGINT COMMENT 'Identifier of the driver operating the truck during this compaction measurement.',
    `ghg_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.ghg_emission. Business justification: Compaction cycles consume hydraulic power and fuel. Detailed Scope 1 emission accounting for collection operations requires linking compaction events to emission calculations for carbon intensity anal',
    `route_execution_id` BIGINT COMMENT 'Reference to the specific route execution during which this compaction measurement was captured.',
    `shift_log_id` BIGINT COMMENT 'Identifier of the operational shift during which this measurement was recorded.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the collection truck that performed the compaction measurement.',
    `ambient_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient air temperature at measurement time in Fahrenheit, which can affect waste density and compaction efficiency.',
    `anomaly_reason` STRING COMMENT 'Explanation of why this measurement was flagged as an anomaly, if applicable. Null for valid measurements.',
    `compaction_cycles_count` STRING COMMENT 'Number of compaction cycles performed by the truck mechanism up to this measurement point during the route.',
    `compaction_ratio` DECIMAL(18,2) COMMENT 'Calculated ratio of compacted volume to original volume, indicating the efficiency of the trucks compaction mechanism. Higher ratios indicate better compaction performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compaction measurement record was first created in the system.',
    `data_source_system` STRING COMMENT 'Source system that captured and transmitted this compaction measurement record.. Valid values are `geotab|amcs|onboard_scale|manual|locus`',
    `estimated_volume_cubic_yards` DECIMAL(18,2) COMMENT 'Estimated volume of waste material in the truck at measurement time, expressed in cubic yards. Used to calculate compaction ratio.',
    `gross_weight_tons` DECIMAL(18,2) COMMENT 'Total combined weight of truck and payload in tons at measurement time.',
    `hydraulic_pressure_psi` DECIMAL(18,2) COMMENT 'Hydraulic system pressure in pounds per square inch at measurement time, indicating compaction mechanism performance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compaction measurement record was last updated or modified.',
    `load_weight_tons` DECIMAL(18,2) COMMENT 'Total weight of waste material loaded in the truck at the time of measurement, expressed in tons. Critical for Tons Per Day (TPD) reporting and payload optimization.',
    `measurement_accuracy_grade` STRING COMMENT 'Quality grade of the measurement indicating reliability level. Certified measurements meet regulatory standards, calibrated are from maintained equipment, estimated use algorithms, approximate are visual assessments.. Valid values are `certified|calibrated|estimated|approximate`',
    `measurement_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate where the compaction measurement was captured, sourced from GPS telemetry.',
    `measurement_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate where the compaction measurement was captured, sourced from GPS telemetry.',
    `measurement_method` STRING COMMENT 'Method used to capture the compaction measurement. Onboard scale provides real-time weight data, estimated uses algorithmic calculation, weigh station uses certified scales, manual entry is driver-reported, telematics uses Geotab sensor data, visual inspection is operator assessment.. Valid values are `onboard_scale|estimated|weigh_station|manual_entry|telematics|visual_inspection`',
    `measurement_notes` STRING COMMENT 'Free-text notes or comments about this compaction measurement, typically used to document unusual conditions or manual adjustments.',
    `measurement_status` STRING COMMENT 'Quality status of the measurement record. Valid measurements pass all validation rules, flagged require review, anomaly indicates outlier values, under review is being investigated, rejected are excluded from reporting.. Valid values are `valid|flagged|anomaly|under_review|rejected`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the compaction measurement was recorded.',
    `net_payload_tons` DECIMAL(18,2) COMMENT 'Calculated net weight of waste payload only, derived by subtracting tare weight from gross weight.',
    `payload_capacity_percentage` DECIMAL(18,2) COMMENT 'Percentage of the trucks maximum payload capacity currently utilized at measurement time. Enables truck utilization analysis and route optimization.',
    `route_segment_sequence` STRING COMMENT 'Sequential position of this measurement within the route execution, indicating progression through the collection route.',
    `scale_calibration_date` DATE COMMENT 'Date when the onboard scale used for this measurement was last calibrated, ensuring measurement accuracy and regulatory compliance.',
    `service_type` STRING COMMENT 'Classification of the collection service being performed during this measurement.. Valid values are `residential|commercial|industrial|municipal|roll_off`',
    `tare_weight_tons` DECIMAL(18,2) COMMENT 'Empty weight of the truck in tons, used to calculate net payload weight by subtracting from gross weight.',
    `truck_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the truck body in cubic yards. Used for volume-based utilization calculations.',
    `truck_capacity_tons` DECIMAL(18,2) COMMENT 'Maximum rated payload capacity of the collection truck in tons. Used as denominator for payload percentage calculation.',
    `truck_type` STRING COMMENT 'Type of collection vehicle. ASL is Automated Side Loader, FEL is Front End Loader, REL is Rear End Loader.. Valid values are `ASL|FEL|REL|roll_off|transfer`',
    `validation_flag` BOOLEAN COMMENT 'Boolean indicator whether this measurement passed automated validation rules for accuracy and completeness.',
    `waste_type` STRING COMMENT 'Type of waste material being collected and compacted. MSW is Municipal Solid Waste, C&D is Construction and Demolition waste.. Valid values are `MSW|recycling|yard_waste|bulky|C&D|mixed`',
    CONSTRAINT pk_compaction_measurement PRIMARY KEY(`compaction_measurement_id`)
) COMMENT 'Transactional record capturing compaction ratio measurements for a collection truck during a route execution. Records truck ID, route execution reference, measurement timestamp, load weight at measurement (tons), estimated volume (cubic yards), compaction ratio calculated, payload percentage of truck capacity, and measurement method (onboard scale, estimated, weigh station). Sourced from onboard truck scales and Geotab telemetry. Enables payload optimization, truck utilization analysis, and TPD reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`on_demand_request` (
    `on_demand_request_id` BIGINT COMMENT 'Unique identifier for the on-demand collection request. Primary key for this transactional entity.',
    `driver_id` BIGINT COMMENT 'Reference to the driver assigned to fulfill this on-demand request. Links to workforce management system for labor tracking and performance metrics.',
    `route_id` BIGINT COMMENT 'Reference to the collection route to which this on-demand request has been assigned for fulfillment. Used for driver dispatch and operational tracking.',
    `vehicle_id` BIGINT COMMENT 'Reference to the collection vehicle assigned to fulfill this request. Used for fleet utilization tracking and capacity validation.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: On-demand requests may be governed by master service agreements defining pricing, terms, and SLAs. Pricing validation, contract entitlement verification, and ad-hoc service billing require linking req',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that initiated this on-demand request. Links to the customer master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this on-demand request record. Customer portal user ID, call center agent ID, or system integration account.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: On-demand requests are for specific service offerings (bulk pickup, special waste collection, extra pickup). Essential for ad-hoc service fulfillment, dynamic pricing calculation, resource dispatch, a',
    `service_address_id` BIGINT COMMENT 'Reference to the specific service location where the on-demand collection will occur.',
    `supervisor_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: On-demand service requests outside standard routes require supervisor approval for resource allocation, pricing authorization, and route disruption management.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: On-demand hazmat pickup requests require waste profile matching to verify approved handling procedures, PPE requirements, and disposal facility acceptance before dispatching crew.',
    `actual_weight_tons` DECIMAL(18,2) COMMENT 'Actual weight of material collected in tons, measured at disposal facility or transfer station. Used for final billing calculation and operational reporting.',
    `additional_fees_amount` DECIMAL(18,2) COMMENT 'Sum of any additional charges such as fuel surcharge, environmental fees, special handling fees, or expedited service premiums in USD.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the on-demand request was cancelled or rejected. Populated when request_status is cancelled or rejected. Used for customer service analysis and process improvement.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the request was cancelled or rejected. Used for SLA tracking and operational metrics.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the on-demand collection service was completed by the driver. Captured from mobile device or telematics system at point of service.',
    `container_quantity` STRING COMMENT 'Number of containers or items to be collected for this on-demand request. Used for capacity planning and pricing.',
    `container_type` STRING COMMENT 'Type of container or collection method for this request. Cart sizes in gallons, bag for loose bagged waste, bulk item for uncontainerized large objects, temporary dumpster for short-term placement, none for requests not requiring specific container. [ENUM-REF-CANDIDATE: cart_32_gal|cart_64_gal|cart_96_gal|bag|bulk_item|temporary_dumpster|none — 7 candidates stripped; promote to reference product]',
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
    `sla_target_hours` STRING COMMENT 'Service level agreement target for request fulfillment in hours from request creation. Based on priority level and customer contract terms.',
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
    `contract_id` BIGINT COMMENT 'Reference to the master service agreement or contract under which this roll-off order was placed. May be null for one-time orders.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that placed this roll-off order.',
    `facility_id` BIGINT COMMENT 'Reference to the landfill, transfer station, or Materials Recovery Facility (MRF) where the waste was disposed or processed.',
    `diversion_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.diversion_record. Business justification: Rolloff containers serve C&D and commercial customers. Material-specific diversion tracking (C&D recycling, organics) requires linking orders to diversion outcomes for customer sustainability reportin',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Rolloff operations (delivery/pickup of large containers) have distinct safety risks (tip-overs, property damage, traffic incidents). Linking incidents to orders enables risk assessment by container si',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Rolloff pulls of hazardous waste generate manifests for transport to TSDF facilities. Required for RCRA compliance when removing filled hazmat rolloff containers from generator sites.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Rolloff orders represent a distinct service offering type (temporary container rental) with specific pricing, handling, and billing rules. Critical for project-based service management, rental billing',
    `service_address_id` BIGINT COMMENT 'Reference to the service address where the roll-off container will be delivered, serviced, and pulled.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rolloff orders (large containers, construction sites) need supervisor oversight for site safety assessment, permit compliance, logistics coordination, and weight limit enforcement.',
    `vehicle_id` BIGINT COMMENT 'Reference to the roll-off truck (typically a Front End Loader or FEL) assigned to deliver and pull this container.',
    `waste_profile_id` BIGINT COMMENT 'Foreign key linking to hazmat.waste_profile. Business justification: Rolloff orders for hazardous waste require pre-approved waste profiles before service authorization. Ensures proper container type, handling requirements, and TSDF acceptance before deployment.',
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
    `permit_number` STRING COMMENT 'Municipal or right-of-way permit number authorizing placement of the roll-off container. Required when permit_required_flag is true.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a municipal or right-of-way permit is required for placement of the roll-off container at the service address.',
    `pull_actual_timestamp` TIMESTAMP COMMENT 'Actual date and time when the roll-off container was pulled from the service address. Captured via driver mobile app or GPS telematics.',
    `pull_scheduled_date` DATE COMMENT 'Scheduled date for final pull (removal) of the roll-off container from the service address.',
    `rental_duration_days` STRING COMMENT 'Number of days the roll-off container is authorized to remain on-site before additional rental charges apply.',
    `source_system` STRING COMMENT 'Operational system of record where this roll-off order was originally created. Used for data lineage and reconciliation.. Valid values are `AMCS|Waste_Logics|Salesforce|Manual`',
    `special_instructions` STRING COMMENT 'Free-text field for customer-provided or dispatcher-added special instructions for delivery, placement, or pull (e.g., gate code, placement location, access restrictions).',
    `swap_count` STRING COMMENT 'Number of times the roll-off container was swapped (full container pulled and empty container delivered) during the rental period.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Total charge in USD for the roll-off order, including base rental, disposal, overage, environmental fees, and taxes.',
    `weight_limit_tons` DECIMAL(18,2) COMMENT 'Maximum authorized weight in tons for the roll-off container. Overage charges apply if exceeded.',
    `weight_ticket_number` STRING COMMENT 'Unique identifier for the weight ticket issued at the disposal facility scale. Used for weight verification and billing reconciliation.',
    CONSTRAINT pk_rolloff_order PRIMARY KEY(`rolloff_order_id`)
) COMMENT 'Transactional record managing the full lifecycle of a roll-off container order for C&D, commercial, or industrial customers. Captures order number, customer account reference, service address, container size (10-yd, 20-yd, 30-yd, 40-yd), waste stream (C&D, MSW, clean fill, metal), delivery date, swap date(s), pull date, rental duration, weight limit, overage terms, permit required flag, permit number, assigned truck and driver, and order status (pending, delivered, on-site, swapped, pulled, invoiced). Sourced from Waste Logics and AMCS Platform. Distinct from standard recurring pickup — roll-off has its own delivery/swap/pull workflow.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`weight_ticket` (
    `weight_ticket_id` BIGINT COMMENT 'Unique identifier for the weight ticket record. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Weight tickets document tonnage against volume commitments and minimum tonnage guarantees in contracts. Volume commitment true-ups, shortfall penalty calculation, and contract performance reporting re',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account to be billed for tipping fees or disposal charges. May be null for internal company loads.',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Weight tickets document waste delivered to third-party disposal facilities under disposal purchase orders. AP reconciles actual tonnage against PO terms for invoice validation. EPA regulations require',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Weight tickets from collection routes disposing at landfills require landfill site reference for disposal tracking, regulatory reporting, tipping fee reconciliation, and landfill capacity management. ',
    `diversion_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.diversion_record. Business justification: Weight tickets document material flows through facilities. Diversion rate calculation requires linking inbound waste tickets to diversion pathway outcomes (recycling, composting, WTE vs landfill) for ',
    `driver_id` BIGINT COMMENT 'Identifier of the driver who delivered the load. Used for driver performance tracking and compliance verification.',
    `employee_id` BIGINT COMMENT 'Identifier of the facility employee who operated the scale and issued the weight ticket. Used for accountability and audit purposes.',
    `facility_id` BIGINT COMMENT 'Identifier of the disposal or transfer facility where the load was weighed and received (landfill, transfer station, MRF, WTE facility).',
    `inbound_load_id` BIGINT COMMENT 'Foreign key linking to recycling.inbound_load. Business justification: Weight tickets from collection routes delivering recyclables to MRFs become inbound loads at the facility. This link enables material flow reconciliation, revenue allocation between collection and pro',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Incidents at scale facilities (vehicle accidents, load shifts, exposure to hazardous materials) must link to the weight ticket for regulatory reporting, insurance claims processing, and facility safet',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Weight tickets for hazardous waste loads must link to the official manifest record for regulatory compliance. Currently only manifest_number (string) exists; adding manifest_id FK enables proper track',
    `modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified this weight ticket record. Used for accountability and audit purposes.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Weight tickets provide source data for regulatory submissions including tonnage reports, waste characterization reports, and capacity utilization filings required by environmental agencies.',
    `route_execution_id` BIGINT COMMENT 'Reference to the route execution record that generated this load. Links the weight ticket to the specific collection route run.',
    `scale_equipment_id` BIGINT COMMENT 'Identifier of the specific scale equipment used for weighing. Used for calibration tracking and measurement audit trails.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the collection vehicle that delivered the load. Used for fleet performance tracking and tonnage attribution.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Weight tickets must classify waste by regulatory waste stream for proper disposal routing, tipping fee calculation, and EPA compliance reporting. Essential for facility acceptance validation, environm',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Weight tickets document MSW deliveries to disposal facilities. When facility is WTE plant, this link enables feedstock tonnage verification for energy generation calculations, tipping fee reconciliati',
    `billing_date` DATE COMMENT 'Date when this weight ticket was included in customer billing. Used for revenue recognition and accounts receivable aging.',
    `comments` STRING COMMENT 'Free-text comments or notes about this weight ticket entered by scale operator, driver, or facility supervisor. May include special handling instructions, load observations, or operational notes.',
    `contamination_flag` BOOLEAN COMMENT 'Indicates whether the load was flagged for contamination (prohibited materials in recycling stream, hazardous materials in MSW, etc.). True = contaminated, False = clean load.',
    `contamination_type` STRING COMMENT 'Description of contamination found in the load (e.g., non-recyclables in recycling stream, hazardous materials, prohibited items). Populated only if contamination_flag is True.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this weight ticket record was first created in the system. Used for audit trail and data lineage.',
    `disposal_authorization_number` STRING COMMENT 'Authorization or permit number allowing disposal of this load at the facility. Required for special waste, hazardous waste, or out-of-jurisdiction loads.. Valid values are `^[A-Z0-9-]{6,25}$`',
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
    `service_area_code` STRING COMMENT 'Geographic service area or district code where the waste was collected. Used for regional tonnage reporting and service performance analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `source_system` STRING COMMENT 'System that originated this weight ticket record. Facility Scale = automated scale integration, AMCS = route management system, SAP SD = sales and distribution module, Manual Entry = scale operator input, Mobile App = driver mobile application.. Valid values are `facility_scale|amcs|sap_sd|manual_entry|mobile_app`',
    `source_system_code` STRING COMMENT 'Unique identifier of this weight ticket in the source system. Used for data lineage and reconciliation.',
    `tare_weight_lbs` DECIMAL(18,2) COMMENT 'Weight of the empty vehicle in pounds, measured at weigh-out. Subtracted from gross weight to determine net waste tonnage.',
    `ticket_number` STRING COMMENT 'Externally visible unique ticket number printed on the weight ticket document. Used for cross-reference with facility records and customer billing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `ticket_status` STRING COMMENT 'Current lifecycle status of the weight ticket. Draft = initial capture, Validated = scale operator approved, Billed = sent to customer billing, Disputed = under review, Voided = cancelled, Corrected = amended after issuance.. Valid values are `draft|validated|billed|disputed|voided|corrected`',
    `tipping_fee_amount` DECIMAL(18,2) COMMENT 'Total tipping fee charged for this load in USD (net_weight_tons × tipping_fee_rate). Feeds into customer billing and revenue recognition.',
    `tipping_fee_rate` DECIMAL(18,2) COMMENT 'Disposal fee rate in USD per ton charged for this load. Rate varies by waste stream, customer contract, and facility. Used for revenue calculation.',
    `validation_flag` BOOLEAN COMMENT 'Indicates whether the weight ticket has passed automated validation checks (weight reasonableness, vehicle capacity limits, duplicate detection). True = passed, False = requires manual review.',
    `validation_notes` STRING COMMENT 'Free-text notes documenting validation issues, manual overrides, or special circumstances related to this weight ticket.',
    `weigh_in_timestamp` TIMESTAMP COMMENT 'Date and time when the vehicle entered the scale for gross weight measurement. Represents the official transaction time for the weight ticket.',
    `weigh_out_timestamp` TIMESTAMP COMMENT 'Date and time when the vehicle exited the scale for tare weight measurement after unloading.',
    CONSTRAINT pk_weight_ticket PRIMARY KEY(`weight_ticket_id`)
) COMMENT 'Transactional record capturing the official weight measurement of a collection vehicle at a disposal or transfer facility upon completion of a route or partial load. Records truck ID, route execution reference, facility received at (landfill, transfer station, MRF, WTE), gross weight, tare weight, net weight (tons), waste stream, ticket number, scale operator ID, timestamp, and disposal authorization number. Sourced from facility scale systems and SAP SD. SSOT for tonnage data used in billing (tipping fees), regulatory reporting (TPD), and route performance measurement.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` (
    `container_rfid_scan_id` BIGINT COMMENT 'Unique identifier for each RFID scan event record. Primary key for the container RFID scan transaction.',
    `asset_container_id` BIGINT COMMENT 'Foreign key reference to the container master record that was scanned during collection operations.',
    `collection_stop_id` BIGINT COMMENT 'Foreign key reference to the specific planned stop on the route where this container scan occurred. Enables stop-level service verification and SLA compliance tracking.',
    `customer_account_id` BIGINT COMMENT 'Foreign key reference to the customer account associated with this container at the time of the scan. Enables customer-level service reporting and billing verification.',
    `driver_id` BIGINT COMMENT 'Foreign key reference to the driver who was operating the collection vehicle at the time of the RFID scan event.',
    `rfid_tag_id` BIGINT COMMENT 'The unique hexadecimal identifier encoded in the RFID tag chip. This is the raw tag serial number read by the RFID scanner hardware.',
    `route_execution_id` BIGINT COMMENT 'Foreign key reference to the specific route execution instance during which this RFID scan occurred. Links the scan to the daily route assignment and schedule.',
    `service_address_id` BIGINT COMMENT 'Foreign key reference to the service location where this container is placed and was scanned. Links scan events to specific customer service addresses.',
    `vehicle_id` BIGINT COMMENT 'Foreign key reference to the collection vehicle that performed the RFID scan and container service.',
    `billing_eligible_flag` BOOLEAN COMMENT 'Boolean indicator showing whether this scan event qualifies for billing based on service completion, lift confirmation, and contract terms. True indicates billable service.',
    `cid` STRING COMMENT 'The unique Container Identification Number physically marked on the container and encoded in the RFID tag. Industry-standard identifier for tracking individual containers across collection operations.. Valid values are `^[A-Z0-9]{8,20}$`',
    `container_size_gallons` STRING COMMENT 'The volumetric capacity of the scanned container measured in gallons. Captured to support service billing verification and capacity planning.',
    `container_type` STRING COMMENT 'The physical type of container that was scanned. Captured at scan time to support container type verification and service validation.. Valid values are `cart|bin|dumpster|compactor|roll_off`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score from 0.00 to 1.00 representing the overall quality and completeness of this scan record based on signal strength, GPS accuracy, and data completeness. Higher scores indicate higher quality data.',
    `exception_code` STRING COMMENT 'A code indicating any service exception or issue encountered during the scan event. Used for operational troubleshooting and customer communication. [ENUM-REF-CANDIDATE: none|contamination|blocked_access|overweight|damaged_container|missed_scan|weather_delay — 7 candidates stripped; promote to reference product]',
    `exception_notes` STRING COMMENT 'Free-text field for driver or system to record additional details about service exceptions, scan issues, or operational notes related to this scan event.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'The estimated accuracy of the GPS coordinates in meters. Lower values indicate higher precision of the location data captured during the scan event.',
    `gps_latitude` DECIMAL(18,2) COMMENT 'The geographic latitude coordinate captured at the moment of the RFID scan, providing precise location verification of the service event.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'The geographic longitude coordinate captured at the moment of the RFID scan, providing precise location verification of the service event.',
    `lift_confirmed_flag` BOOLEAN COMMENT 'Boolean indicator confirming whether the container was physically lifted and emptied based on PTO (Power Take-Off) sensor data correlated with the RFID scan event. True indicates confirmed service completion.',
    `proof_of_service_flag` BOOLEAN COMMENT 'Boolean indicator confirming this scan event serves as valid proof of service delivery for customer SLA and dispute resolution purposes. True indicates verified service completion.',
    `pto_activation_timestamp` TIMESTAMP COMMENT 'The timestamp when the vehicle PTO system was activated to lift and empty the container. Used to correlate RFID scan with physical service completion.',
    `reader_device_code` STRING COMMENT 'The unique identifier of the RFID reader hardware device that captured this scan. Used for device performance tracking and troubleshooting.. Valid values are `^[A-Z0-9]{8,16}$`',
    `reader_firmware_version` STRING COMMENT 'The firmware version of the RFID reader device at the time of the scan. Captured to support device maintenance and performance analysis.. Valid values are `^[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,3}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFID scan record was first inserted into the data platform. Used for data lineage tracking and audit purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this RFID scan record was last modified in the data platform. Tracks data refresh cycles and correction events.',
    `scan_date` DATE COMMENT 'The calendar date of the RFID scan event, derived from scan_timestamp for simplified date-based reporting and partitioning.',
    `scan_result_status` STRING COMMENT 'The outcome status of the RFID scan attempt indicating whether the tag was successfully read or if any issues occurred during the scan operation.. Valid values are `successful_read|no_read|weak_signal|damaged_tag|duplicate_read|invalid_tag`',
    `scan_source_system` STRING COMMENT 'The operational system that originated and transmitted this RFID scan record. Identifies the data lineage and integration source.. Valid values are `amcs_platform|geotab_telematics|locus_dispatch|mobile_app`',
    `scan_timestamp` TIMESTAMP COMMENT 'The precise date and time when the RFID tag was scanned by the collection vehicle reader. Represents the proof-of-service event time for this container.',
    `scheduled_service_time` TIMESTAMP COMMENT 'The planned timestamp for servicing this container based on the route schedule. Used to calculate service timeliness and SLA compliance.',
    `service_type` STRING COMMENT 'The category of waste collection service being performed at the time of the scan. Distinguishes between residential, commercial, and other service classifications.. Valid values are `residential|commercial|industrial|municipal|roll_off|temporary`',
    `service_variance_minutes` STRING COMMENT 'The difference in minutes between the scheduled service time and actual scan timestamp. Positive values indicate late service, negative values indicate early service.',
    `signal_strength` DECIMAL(18,2) COMMENT 'The radio frequency signal strength measured in decibels-milliwatts (dBm) at the time of the scan. Indicates the quality of the RFID tag read and can help diagnose tag or reader issues.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator showing whether this scan event occurred within the contracted service window defined in the customer SLA. True indicates on-time service delivery.',
    `source_system_timestamp` TIMESTAMP COMMENT 'The timestamp when this scan record was created in the originating operational system (AMCS or Geotab). Used to measure data latency and support data reconciliation.',
    `truck_number` STRING COMMENT 'The human-readable fleet identification number of the collection vehicle that performed the scan. Used for operational reporting and driver communication.. Valid values are `^[A-Z0-9]{4,12}$`',
    `waste_stream_type` STRING COMMENT 'The category of waste material collected from this container. MSW (Municipal Solid Waste), recycling, organics, or other specialized waste streams.. Valid values are `msw|recycling|organics|yard_waste|bulk|hazardous`',
    CONSTRAINT pk_container_rfid_scan PRIMARY KEY(`container_rfid_scan_id`)
) COMMENT 'Transactional record capturing each RFID tag scan event for a container during collection operations — recording proof of service at the container level. Captures CID (Container Identification number), RFID tag ID, scan timestamp, GPS coordinates at scan, truck ID, route execution reference, stop reference, scan result (successful read, no read, damaged tag), and lift confirmation flag from PTO sensor. Sourced from AMCS Platform RFID readers and Geotab PTO data. Enables container-level proof-of-service, SLA compliance, and container utilization tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`transfer_station` (
    `transfer_station_id` BIGINT COMMENT 'Unique identifier for the transfer station facility. Primary key for the transfer station master record.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to sustainability.emission_source. Business justification: Transfer stations are stationary emission sources with equipment, flares, and fugitive emissions. EPA GHGRP Subpart HH requires facility-level emission source registration and continuous monitoring.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Transfer stations may be operated by third-party vendors under service contracts. Asset management and procurement teams track which stations are vendor-operated for contract management, performance m',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Transfer stations are regulated facilities subject to comprehensive environmental permitting and oversight. Core facility registration relationship linking operational facilities to regulatory complia',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Each transfer station implements specific safety programs based on operational characteristics, waste streams handled, and regulatory requirements. Essential for OSHA compliance, program auditing, and',
    `facility_id` BIGINT COMMENT 'FK to asset.facility.facility_id — Transfer stations are physical facilities tracked in the asset domain. This FK enables joining transfer operations to facility maintenance, inspections, and capital planning.',
    `transfer_outbound_disposal_facility_id` BIGINT COMMENT 'Identifier of the primary landfill or disposal facility where waste is hauled from this transfer station.',
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
    `district_id` BIGINT COMMENT 'Identifier of the collection district or service area that this transfer station primarily serves.',
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
    `customer_account_id` BIGINT COMMENT 'Reference to the customer or municipal account responsible for this load. Used for tipping fee billing and revenue allocation.',
    `disposal_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.disposal_agreement. Business justification: Load tickets track tonnage delivered under disposal agreements with landfills/WTE facilities. Contracted capacity utilization, tipping fee reconciliation, and disposal agreement compliance reporting r',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Transfer station load tickets for outbound hauls to landfills require landfill site reference for waste tracking, regulatory chain-of-custody, and transfer-to-landfill flow reporting. Core transfer st',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Load tickets at transfer stations document waste sent to contracted disposal facilities. AP teams perform three-way match: load_ticket tonnage vs. disposal_purchase_order terms vs. vendor_invoice. Sta',
    `diversion_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.diversion_record. Business justification: Transfer station load tickets capture material characterization and final disposition. Diversion reporting requires linking loads to diversion pathways (diverted vs disposed) for regulatory and ESG re',
    `driver_id` BIGINT COMMENT 'Reference to the driver who delivered this load. Used for performance tracking and compliance verification.',
    `employee_id` BIGINT COMMENT 'Reference to the scale house operator who processed this ticket. Used for quality control and training purposes.',
    `inbound_load_id` BIGINT COMMENT 'Foreign key linking to recycling.inbound_load. Business justification: Transfer station load tickets for recyclable material correspond to MRF inbound loads when material is transferred for processing. This link is essential for end-to-end material tracking, tipping fee ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Incidents during load acceptance at transfer stations (rejected loads, spills, exposure events) must link to the load ticket for regulatory compliance, billing disputes, safety trend analysis, and cor',
    `facility_id` BIGINT COMMENT 'Reference to the final disposal facility (landfill, WTE plant, MRF) where this load will be hauled after transfer station consolidation.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Load tickets document waste acceptance under specific permit authorizations. Permits define acceptable waste types, quantities, and handling requirements for each load received at transfer stations.',
    `route_execution_id` BIGINT COMMENT 'Reference to the originating route execution if this load was collected on a scheduled route. Null for third-party haulers or direct customer deliveries.',
    `scale_equipment_id` BIGINT COMMENT 'Reference to the specific weighing scale used to measure this load. Required for calibration tracking and measurement accuracy audits.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station facility where this load was received and weighed.',
    `vehicle_id` BIGINT COMMENT 'Reference to the truck or vehicle that delivered this load to the transfer station.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Load tickets at transfer stations classify inbound waste by regulatory stream for proper handling, outbound haul planning, and disposal routing. Critical for transfer station operations, regulatory co',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Transfer station load tickets track outbound hauls to final disposal. When destination is WTE facility, enables tracking MSW feedstock supply chain from transfer station to energy recovery. Supports t',
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
    `manifest_number` STRING COMMENT 'Hazardous waste tracking manifest number if this load contains regulated hazardous materials. Required for RCRA compliance and chain of custody.',
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
    `tipping_fee_rate` DECIMAL(18,2) COMMENT 'Per-ton disposal fee rate applied to this load based on waste stream type, customer contract, and jurisdiction. Expressed in currency per ton.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Total billable amount for this load including tipping fees, environmental fees, and any additional charges. Used for invoice generation.',
    `waste_characterization_method` STRING COMMENT 'Method used to determine the waste stream type and material composition: visual inspection, manifest declaration, physical sampling, customer declaration, or default profile.. Valid values are `visual_inspection|manifest_declaration|sampling|customer_declaration|default_profile`',
    `waste_origin_jurisdiction` STRING COMMENT 'Municipality, county, or jurisdiction where the waste was collected. Required for regulatory reporting and flow control compliance.',
    `weigh_in_timestamp` TIMESTAMP COMMENT 'Date and time when the loaded vehicle was weighed at the inbound scale. Primary transaction timestamp for this load ticket.',
    `weigh_out_timestamp` TIMESTAMP COMMENT 'Date and time when the empty vehicle was weighed at the outbound scale after unloading. Used to calculate tare weight and cycle time.',
    CONSTRAINT pk_load_ticket PRIMARY KEY(`load_ticket_id`)
) COMMENT 'Inbound load ticket (tipping ticket) generated at the transfer station scale house for each vehicle delivering waste. Captures ticket number, originating route or hauler, vehicle/truck ID, driver ID and CDL number, waste stream type (MSW, C&D, recyclables, organics), waste characterization method, contamination level, gross/tare/net weight (tons), tipping fee rate applied, customer or municipal account reference, waste origin jurisdiction, time-in/time-out at scale, gate entry/exit timestamps, pre-entry inspection result, scale operator ID, acceptance/rejection decision with reason code, rejection disposition instructions, and RFID/transponder scan reference. Primary transactional record for all inbound activity at the transfer station — from gate check-in through weighing to acceptance or rejection. Integrates with AMCS and SAP SD for tipping fee billing.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`scale_transaction` (
    `scale_transaction_id` BIGINT COMMENT 'Unique identifier for the scale transaction record. Primary key for the scale transaction entity.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with this scale transaction. Used for billing and revenue allocation.',
    `diversion_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.diversion_record. Business justification: Scale transactions at MRFs and transfer stations document material sorting outcomes. Diversion rate calculation and material flow analysis require transaction-to-pathway linkage for sustainability rep',
    `driver_id` BIGINT COMMENT 'Identifier of the driver operating the vehicle during the scale transaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the scale house operator who recorded the transaction. Used for accountability and audit trail.',
    `facility_id` BIGINT COMMENT 'Identifier of the transfer station or disposal facility where the scale transaction occurred.',
    `load_ticket_id` BIGINT COMMENT 'Associated load ticket identifier linking this scale transaction to the broader load documentation. Used for cross-referencing with dispatch and billing records.',
    `route_execution_id` BIGINT COMMENT 'Identifier of the route execution associated with this scale transaction, if the load originated from a collection route.',
    `scale_equipment_id` BIGINT COMMENT 'Identifier of the scale equipment used for this transaction. Links to the specific scale house weighing system.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the vehicle being weighed. Links to the fleet vehicle master record.',
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
    `manifest_number` STRING COMMENT 'Hazardous waste manifest tracking document number, if applicable. Required for RCRA-regulated hazardous waste shipments.',
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
    `waste_stream_code` STRING COMMENT 'Code identifying the type of waste material being weighed. Examples include MSW (Municipal Solid Waste), C&D (Construction and Demolition), recyclables, organics, hazardous waste.',
    `weighmaster_certification_number` STRING COMMENT 'Certification number of the licensed weighmaster who validated the transaction. Required for regulatory compliance in jurisdictions with weighmaster certification requirements.',
    CONSTRAINT pk_scale_transaction PRIMARY KEY(`scale_transaction_id`)
) COMMENT 'Detailed scale house weighing transaction record capturing each individual scale event at the transfer station. Records scale ID, transaction timestamp, vehicle plate/CID, gross weight, tare weight, net weight (tons), scale operator, weighmaster certification reference, scale calibration record reference, transaction type (inbound, outbound, tare-only), and associated load ticket ID. Supports regulatory weighmaster compliance and audit trail for tipping fee disputes. Sourced from AMCS Platform scale integration.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` (
    `tipping_fee_rate_id` BIGINT COMMENT 'Unique identifier for the tipping fee rate record. Primary key.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tipping fee rates are subject to permit conditions and regulatory rate caps established by permitting authorities. Permits define maximum allowable rates and rate adjustment procedures.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this tipping fee rate. Nullable if not yet approved.',
    `superseded_by_rate_tipping_fee_rate_id` BIGINT COMMENT 'Reference to the new rate that replaces this rate when status is superseded. Nullable for active rates. Maintains rate version history.',
    `tertiary_tipping_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this tipping fee rate record. Used for audit trail and accountability.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station where this tipping fee rate applies. Links to the facility master data.',
    `approval_status` STRING COMMENT 'Approval workflow status for the rate. Tracks regulatory or management approval process before rate activation.. Valid values are `not_submitted|pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this tipping fee rate was approved. Nullable if not yet approved.',
    `contamination_penalty_rate` DECIMAL(18,2) COMMENT 'Additional fee per ton charged for contaminated loads that do not meet material stream specifications. Nullable if no contamination penalty applies.',
    `contract_reference_number` STRING COMMENT 'Reference to the service agreement or contract that defines this rate. Nullable for standard published rates not tied to specific contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this tipping fee rate record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate record.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Customer classification this rate applies to. Determines pricing tier and service level agreements.. Valid values are `residential|commercial|municipal|self_haul|industrial|institutional`',
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
    `waste_stream_type` STRING COMMENT 'Type of waste material this rate applies to. MSW = Municipal Solid Waste, C&D = Construction and Demolition Waste. Determines applicable disposal regulations and handling requirements.. Valid values are `MSW|C&D|special_waste|hazardous|recyclable|organics`',
    CONSTRAINT pk_tipping_fee_rate PRIMARY KEY(`tipping_fee_rate_id`)
) COMMENT 'Reference table defining tipping fee rate schedules applied at each transfer station. Captures rate ID, transfer station reference, waste stream type (MSW, C&D, special waste, hazardous), customer segment (residential, commercial, municipal, self-haul), rate per ton, minimum charge, effective date, expiration date, rate basis (per ton, per load, per yard), regulatory rate cap reference, and approval status. Used by SAP SD and Oracle Revenue Management for tipping fee invoice generation. Distinct from billing domain rate schedules — this is the operational rate reference owned by transfer operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`outbound_haul` (
    `outbound_haul_id` BIGINT COMMENT 'Unique identifier for the outbound haul assignment record. Primary key for tracking consolidated waste loads dispatched from transfer stations to destination facilities.',
    `destination_facility_id` BIGINT COMMENT 'Identifier of the destination facility receiving the outbound haul load (landfill, MRF, WTE, or TSDF).',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Outbound hauls from transfer stations to landfills need direct landfill site FK (destination_facility_id is generic facility reference) for landfill-specific logistics, capacity coordination, and wast',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Outbound hauls execute against disposal purchase orders. Operations tracks haul performance (tonnage, timing, costs) against PO terms for contract compliance and vendor performance management. Procure',
    `driver_id` BIGINT COMMENT 'Identifier of the driver assigned to execute the outbound haul transport.',
    `hauler_account_id` BIGINT COMMENT 'Identifier of the third-party hauling contractor if the haul is subcontracted. Null if performed by internal fleet.',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Outbound hauls execute third-party hauling agreements for transfer station-to-disposal transport. Hauling cost reconciliation, carrier performance tracking, and agreement compliance verification requi',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Outbound hauls from transfer stations to TSDF facilities require manifests for hazardous waste. Role-prefixed to distinguish from internal tracking; removes denormalized manifest_number text field.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Outbound hauls involve highway transport of large loads with distinct safety risks (load securement, traffic accidents, rollover). Incident linkage is essential for carrier safety management, DOT comp',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Outbound hauls must comply with transportation permits and manifest requirements for waste movement between facilities. Permits authorize specific waste types and destination facilities for haul opera',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Outbound hauls from transfer stations to disposal facilities need supervisor coordination for scheduling, manifesting, carrier management, and load rejection handling.',
    `transfer_station_id` BIGINT COMMENT 'Identifier of the transfer station origin facility where consolidated waste is loaded for outbound transport.',
    `vehicle_id` BIGINT COMMENT 'Identifier of the transfer trailer or vehicle assigned to transport the outbound haul load.',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Outbound hauls from transfer stations to WTE facilities are core waste-to-energy supply chain operations. Enables WTE feedstock logistics tracking, haul cost allocation to energy operations, and suppl',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the vehicle arrived at the destination facility. Used for delivery confirmation and facility gate operations.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the vehicle departed the transfer station. Used for on-time performance tracking and DOT compliance.',
    `actual_tonnage` DECIMAL(18,2) COMMENT 'Actual weight of the waste load in tons as measured at the destination facility scale. Used for billing and disposal fee calculation.',
    `bol_number` STRING COMMENT 'Bill of Lading document number for the outbound haul shipment. Required for DOT compliance and chain-of-custody tracking.',
    `carrier_dot_number` STRING COMMENT 'Department of Transportation carrier identification number for the hauling company or contractor. Required for interstate commerce compliance.',
    `contamination_flag` BOOLEAN COMMENT 'Indicates whether the load was identified as contaminated with prohibited materials or improperly sorted waste streams.',
    `contamination_type` STRING COMMENT 'Classification of the contamination found in the load (e.g., hazardous materials in MSW, non-recyclables in recycling stream, prohibited items).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound haul record was first created in the system. Used for audit trail and data lineage tracking.',
    `destination_facility_type` STRING COMMENT 'Classification of the destination facility type. MRF = Materials Recovery Facility, WTE = Waste-to-Energy, TSDF = Treatment Storage and Disposal Facility.. Valid values are `landfill|mrf|wte|tsdf|other`',
    `dispatch_notes` STRING COMMENT 'Operational notes from dispatch personnel regarding special handling instructions, route conditions, or coordination requirements.',
    `driver_notes` STRING COMMENT 'Notes entered by the driver regarding delivery conditions, facility operations, delays, or issues encountered during the haul.',
    `environmental_fee_amount` DECIMAL(18,2) COMMENT 'Environmental surcharge or regulatory fee assessed on the waste load for environmental compliance programs and remediation funds.',
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste classification code(s) for the load. Required for RCRA-regulated waste streams. Multiple codes may be comma-separated.',
    `estimated_arrival_timestamp` TIMESTAMP COMMENT 'Estimated date and time for the vehicle to arrive at the destination facility based on route planning and traffic conditions.',
    `estimated_fuel_consumption_gallons` DECIMAL(18,2) COMMENT 'Estimated fuel consumption in gallons for the outbound haul based on vehicle type, load weight, and route distance.',
    `estimated_tonnage` DECIMAL(18,2) COMMENT 'Estimated weight of the consolidated waste load in tons based on transfer station scale readings or volume calculations.',
    `generator_signature_captured_flag` BOOLEAN COMMENT 'Indicates whether the waste generator signature was captured on the manifest or BOL for chain-of-custody compliance.',
    `haul_number` STRING COMMENT 'Externally-known business identifier for the outbound haul assignment. Used for operational tracking and communication with drivers, facilities, and regulatory agencies.',
    `haul_status` STRING COMMENT 'Current lifecycle status of the outbound haul assignment in the dispatch and delivery workflow.. Valid values are `scheduled|dispatched|in_transit|delivered|rejected|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound haul record was last updated. Used for audit trail and change tracking.',
    `load_rejection_flag` BOOLEAN COMMENT 'Indicates whether the destination facility rejected the load due to contamination, improper classification, or facility capacity constraints.',
    `rcra_classification` STRING COMMENT 'Resource Conservation and Recovery Act classification for the waste load. Determines regulatory handling and disposal requirements.',
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
    `waste_stream_type` STRING COMMENT 'Classification of the waste material stream being transported. MSW = Municipal Solid Waste, C&D = Construction and Demolition Waste.. Valid values are `msw|recycling|organics|cnd|hazardous|special`',
    CONSTRAINT pk_outbound_haul PRIMARY KEY(`outbound_haul_id`)
) COMMENT 'Outbound haul assignment and manifest record dispatching consolidated waste loads from the transfer station to a destination facility (landfill, MRF, WTE, TSDF). Captures haul ID, transfer station origin, destination facility type and ID, assigned transfer trailer/vehicle, driver assignment, scheduled and actual departure datetimes, estimated arrival, waste stream type, estimated tonnage, BOL number, manifest number (if hazardous), waste classification codes (EPA/RCRA), seal numbers, carrier DOT number, chain-of-custody signatures, haul contractor reference, and haul status (scheduled, in-transit, delivered, rejected). Core operational record bridging transfer to landfill/recycling/energy domains. Supports DOT compliance on all outbound loads and RCRA manifest requirements for special/hazardous waste streams.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`haul_manifest` (
    `haul_manifest_id` BIGINT COMMENT 'Unique identifier for the haul manifest record. Primary key.',
    `destination_facility_id` BIGINT COMMENT 'Disposal or processing facility to which this haul is destined. May be landfill, WTE facility, or other disposal site.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Haul manifests for waste transported to landfills require landfill site reference for regulatory compliance, manifest-based waste tracking, and chain-of-custody documentation. Core regulatory and oper',
    `disposal_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.disposal_purchase_order. Business justification: Haul manifests provide regulatory documentation for waste shipments under disposal purchase orders. EPA RCRA regulations require linking manifests to disposal contracts for hazardous waste. Compliance',
    `driver_id` BIGINT COMMENT 'Driver responsible for transporting this haul from origin to destination.',
    `hauling_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.hauling_agreement. Business justification: Haul manifests document waste transport under hauling agreements, including BOL terms and carrier obligations. Regulatory compliance, carrier liability verification, and hauling agreement audit trails',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to hazmat.manifest. Business justification: Links operational haul tracking to authoritative regulatory manifest system. Role-prefixed to distinguish from local manifest_number field; removes denormalized manifest_tracking_number for 3NF.',
    `transfer_station_id` BIGINT COMMENT 'Transfer station facility from which this haul originated. Starting point of the outbound shipment.',
    `outbound_haul_id` BIGINT COMMENT 'Reference to the outbound haul execution record that this manifest documents.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Manifests document compliance with permitted waste transportation and disposal activities. Permits define manifest requirements, waste codes, and authorized transportation routes for regulatory compli',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Hazardous waste manifests require supervisor signature for regulatory compliance (RCRA, DOT), liability acceptance, and emergency response authority—critical for legal accountability.',
    `vehicle_id` BIGINT COMMENT 'Transport vehicle (truck or tractor) used to haul this shipment.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Haul manifests must specify waste stream for regulatory compliance (EPA, RCRA), facility gate acceptance, and proper disposal routing. Essential for hazmat tracking, environmental reporting, and inter',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Manifests document waste shipments to final destination. When destination is WTE facility, supports regulatory compliance (waste characterization for combustion permits), feedstock quality tracking, a',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the haul arrived at the destination facility. Used for transit time tracking and SLA compliance.',
    `bol_reference_number` STRING COMMENT 'Bill of Lading reference number accompanying this haul manifest. Links manifest to shipping documentation.',
    `carrier_dot_number` STRING COMMENT 'DOT registration number of the carrier company responsible for transporting this haul. Required for interstate commerce compliance.',
    `carrier_name` STRING COMMENT 'Legal name of the carrier company transporting this haul. May be internal fleet or third-party contractor.',
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
    `epa_waste_code` STRING COMMENT 'EPA hazardous waste code(s) applicable to this shipment. Multiple codes may be comma-separated. Required for RCRA manifest compliance.',
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
    `employee_id` BIGINT COMMENT 'Identifier of the user who validated and approved the capacity record for regulatory reporting. Supports audit trail and accountability.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Daily capacity utilization must stay within permitted limits. Capacity records demonstrate permit compliance and support regulatory reporting of throughput against permitted daily tonnage limits.',
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
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier for the regulatory report submission that includes this capacity data. Links capacity records to state SWIS reporting, EPA reporting, or local enforcement agency submissions.',
    `report_submission_date` DATE COMMENT 'Date when the regulatory report containing this capacity data was submitted to the governing authority. Used for compliance tracking and audit trail.',
    `source_system` STRING COMMENT 'Name of the operational system from which the capacity data originated (e.g., AMCS Platform, Waste Logics, manual entry). Supports data lineage and troubleshooting.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the capacity record was validated and approved for regulatory reporting. Part of the audit trail for compliance documentation.',
    CONSTRAINT pk_facility_capacity PRIMARY KEY(`facility_capacity_id`)
) COMMENT 'Daily and period-level capacity and throughput tracking record for each transfer station. Captures capacity record ID, transfer station, record date/period, permitted daily capacity (TPD), actual inbound tonnage by waste stream, actual outbound tonnage by destination type, floor storage tonnage at end of day, capacity utilization percentage, number of inbound loads, number of outbound hauls, peak hour/day throughput, diversion rate (percentage diverted from landfill), average daily tonnage, capacity status (normal, near-capacity, over-capacity), regulatory capacity exceedance flags, and reporting submission reference. Enables proactive capacity management, regulatory compliance reporting, state solid waste reporting, and internal KPI tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`transfer_trailer` (
    `transfer_trailer_id` BIGINT COMMENT 'Unique identifier for the transfer trailer. Primary key for this entity.',
    `transfer_station_id` BIGINT COMMENT 'Identifier of the transfer station to which this trailer is currently assigned or based.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Trailers undergo compliance inspections for DOT standards, safety requirements, and environmental controls. Inspections verify equipment compliance with transportation and environmental regulations.',
    `facility_id` BIGINT COMMENT 'Identifier of the disposal facility (landfill or waste-to-energy plant) where this trailer typically delivers loads.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Transfer trailers are capital assets requiring depreciation, insurance valuation, impairment testing, and financial reporting. Link to fixed_asset master enables asset lifecycle management, book value',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Transfer trailers are mobile assets requiring DOT inspections, brake repairs, tire replacements, and unscheduled maintenance. Linking the current or most recent work order to transfer_trailer enables ',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_schedule. Business justification: Transfer trailers require scheduled PM (annual DOT inspections, quarterly brake checks, tire rotations per mileage intervals). Linking transfer_trailer to its PM schedule enables compliance-driven mai',
    `rfid_tag_id` BIGINT COMMENT 'Unique identifier of the RFID tag attached to the trailer for automated tracking and gate access.',
    `acquisition_cost_amount` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the trailer, including purchase price or initial lease payment.',
    `acquisition_date` DATE COMMENT 'Date the trailer was acquired by the company through purchase, lease, or contract.',
    `axle_count` STRING COMMENT 'Number of axles on the trailer, relevant for weight distribution and DOT compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer trailer record was first created in the system.',
    `current_location_latitude` DECIMAL(18,2) COMMENT 'Most recent GPS latitude coordinate of the trailers location.',
    `current_location_longitude` DECIMAL(18,2) COMMENT 'Most recent GPS longitude coordinate of the trailers location.',
    `dot_registration_number` STRING COMMENT 'DOT registration number required for interstate commercial hauling operations.. Valid values are `^[A-Z0-9]{7,10}$`',
    `gps_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether the trailer is equipped with active GPS tracking for real-time location monitoring.',
    `in_service_date` DATE COMMENT 'Date the trailer was placed into active operational service.',
    `insurance_expiration_date` DATE COMMENT 'Date when the current insurance policy for the trailer expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the insurance coverage on this trailer.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection performed on the trailer.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent inspection indicating whether the trailer passed, failed, or received conditional approval.. Valid values are `passed|failed|conditional`',
    `last_location_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent GPS location update received from the trailer.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance service performed on the trailer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer trailer record was most recently updated.',
    `license_plate` STRING COMMENT 'State-issued license plate number for the transfer trailer.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the transfer trailer.',
    `model_name` STRING COMMENT 'Manufacturers model designation for the trailer.',
    `model_year` STRING COMMENT 'Year the trailer was manufactured, used for depreciation and compliance tracking.',
    `next_dot_inspection_due_date` DATE COMMENT 'Scheduled date for the next required DOT annual inspection to maintain compliance.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service based on time or usage intervals.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special handling instructions, or maintenance history comments.',
    `odometer_miles` DECIMAL(18,2) COMMENT 'Current odometer reading in miles, used for maintenance scheduling and utilization tracking.',
    `ownership_type` STRING COMMENT 'Indicates whether the trailer is owned by the company, leased from a third party, or contracted through a hauling agreement.. Valid values are `owned|leased|contracted`',
    `payload_capacity_tons` DECIMAL(18,2) COMMENT 'Maximum allowable payload weight in tons that the trailer can legally and safely carry.',
    `registration_expiration_date` DATE COMMENT 'Date when the current state registration for the trailer expires.',
    `registration_state` STRING COMMENT 'Two-letter state code where the trailer is registered for operation.. Valid values are `^[A-Z]{2}$`',
    `retirement_date` DATE COMMENT 'Date the trailer was retired from active service and removed from the operational fleet.',
    `retirement_reason` STRING COMMENT 'Reason the trailer was retired from service (e.g., end of useful life, accident damage, sold, lease termination).. Valid values are `end_of_life|accident|sold|lease_end|regulatory`',
    `source_system` STRING COMMENT 'Name of the operational system from which this transfer trailer record originated (e.g., AMCS Platform, Infor EAM).',
    `tare_weight_tons` DECIMAL(18,2) COMMENT 'Empty weight of the transfer trailer in tons, used to calculate net payload from gross weight.',
    `tire_size` STRING COMMENT 'Standard tire size specification for the trailer, used for maintenance and replacement planning.',
    `trailer_number` STRING COMMENT 'Externally-known unique identifier or asset tag for the transfer trailer, used for operational tracking and dispatch.. Valid values are `^[A-Z0-9]{6,12}$`',
    `trailer_status` STRING COMMENT 'Current operational status of the transfer trailer indicating availability and location state.. Valid values are `available|loaded|in_transit|maintenance|out_of_service|retired`',
    `trailer_type` STRING COMMENT 'Classification of the transfer trailer by its unloading mechanism and design (e.g., walking floor, end-dump, live-bottom, compactor trailer).. Valid values are `walking_floor|end_dump|live_bottom|compactor|roll_off|open_top`',
    `vin` STRING COMMENT '17-character Vehicle Identification Number assigned by the manufacturer, used for registration and compliance tracking.. Valid values are `^[A-HJ-NPR-Z0-9]{17}$`',
    `volume_capacity_cubic_yards` DECIMAL(18,2) COMMENT 'Maximum volume capacity of the trailer in cubic yards, relevant for low-density waste streams.',
    CONSTRAINT pk_transfer_trailer PRIMARY KEY(`transfer_trailer_id`)
) COMMENT 'Master record for transfer trailers and long-haul vehicles assigned to or operating from transfer stations. Captures trailer ID, trailer type (walking floor, end-dump, live-bottom, compactor trailer), VIN, license plate, DOT registration number, tare weight, payload capacity (tons), volume capacity (cubic yards), assigned transfer station, current status (available, loaded, in-transit, maintenance), last inspection date, next DOT inspection due date, and ownership type (owned, leased, contracted). Distinct from fleet domain vehicles — these are transfer-specific haul assets.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`scale_equipment` (
    `scale_equipment_id` BIGINT COMMENT 'Unique identifier for the weighing scale equipment record. Primary key for the scale equipment master data.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Scale equipment undergoes compliance inspections for calibration, certification, and accuracy standards. Regulatory inspections verify scales meet weights and measures requirements for commercial tran',
    `lockout_tagout_procedure_id` BIGINT COMMENT 'Foreign key linking to safety.lockout_tagout_procedure. Business justification: Scale equipment requires LOTO procedures for maintenance and calibration. This is a regulatory requirement under OSHA 1910.147 for servicing equipment with electrical, hydraulic, and mechanical energy',
    `loto_execution_id` BIGINT COMMENT 'Foreign key linking to safety.loto_execution. Business justification: When scale equipment undergoes maintenance, the actual LOTO execution must be tracked for compliance verification, audit trail, and incident investigation if equipment-related injuries occur during or',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Scale equipment requires calibration, repair, and compliance-driven maintenance work orders. Linking the most recent or active work order to scale_equipment enables real-time operational status tracki',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_schedule. Business justification: Scales require scheduled preventive maintenance (calibration every 90 days, annual certification inspections) per state weights-and-measures regulations. Linking scale_equipment to its PM schedule ena',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station facility where this scale equipment is installed and operated.',
    `accuracy_class` STRING COMMENT 'NIST accuracy classification for the scale equipment. Class I (precision laboratory), Class II (precision commercial), Class III (commercial/vehicle scales - most common for waste operations), Class IIII (wheel-load weighers). Determines acceptable tolerance and verification requirements.. Valid values are `class_i|class_ii|class_iii|class_iiii`',
    `acquisition_cost_amount` DECIMAL(18,2) COMMENT 'Total capital cost of acquiring and installing the scale equipment, including hardware, foundation, installation labor, and initial calibration. Used for asset valuation and depreciation calculations.',
    `calibration_authority` STRING COMMENT 'Name of the organization or agency that performed the most recent calibration. Typically a state weights and measures department or certified third-party calibration service provider.',
    `calibration_certificate_number` STRING COMMENT 'Unique identifier for the most recent calibration certificate issued by the authorized calibration service provider or weights and measures authority. Required for audit and compliance verification.',
    `camera_system_installed_flag` BOOLEAN COMMENT 'Indicates whether the scale is equipped with camera systems for license plate recognition, load verification, or security monitoring. True if cameras are installed, false otherwise.',
    `capacity_tons` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the scale equipment measured in tons. Represents the upper limit for safe and accurate weighing operations. Critical for operational planning and load management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scale equipment record was first created in the system. Used for data lineage and audit trail purposes.',
    `division_size_lbs` DECIMAL(18,2) COMMENT 'The smallest unit of weight that the scale can display and measure, expressed in pounds. Also known as scale increment or readability. Determines the precision of weight measurements.',
    `environmental_protection_rating` STRING COMMENT 'IP (Ingress Protection) rating or equivalent environmental protection classification for the scale electronics and load cells. Indicates resistance to dust, moisture, and harsh conditions typical in waste operations.',
    `foundation_type` STRING COMMENT 'Type of foundation construction for the scale installation. Concrete pit is below-grade installation, above ground is surface-mounted, shallow pit is partially recessed, modular is prefabricated foundation system. Affects maintenance access and drainage requirements.. Valid values are `concrete_pit|above_ground|shallow_pit|modular`',
    `inbound_outbound_designation` STRING COMMENT 'Indicates whether the scale is designated for inbound collection vehicles, outbound transfer haul vehicles, or bidirectional use for both traffic flows. Critical for operational flow management and weight ticket routing.. Valid values are `inbound|outbound|bidirectional`',
    `indicator_model` STRING COMMENT 'Model designation of the digital weight indicator (display and processing unit) connected to the scale. The indicator converts load cell signals to weight readings and interfaces with ticketing systems.',
    `indicator_serial_number` STRING COMMENT 'Unique serial number of the weight indicator unit. Required for NTEP certification tracking and service documentation.',
    `installation_date` DATE COMMENT 'Date when the scale equipment was installed and commissioned at the transfer station. Used for tracking equipment age, warranty periods, and depreciation schedules.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration performed on the scale equipment. Calibration ensures measurement accuracy and is required for regulatory compliance with state weights and measures authorities.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent operational inspection or preventive maintenance check performed on the scale equipment. Distinct from regulatory calibration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scale equipment record was most recently updated. Used for change tracking and data synchronization.',
    `load_cell_count` STRING COMMENT 'Number of load cells (weight sensors) installed in the scale system. Typical configurations range from 4 to 12 load cells depending on platform size and capacity. Critical for maintenance planning and troubleshooting.',
    `maintenance_contract_number` STRING COMMENT 'Reference number for the active preventive maintenance or service contract covering this scale equipment. Links to vendor service agreements and scheduled maintenance activities.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the scale equipment. Critical for warranty claims, parts sourcing, and technical support.',
    `model_number` STRING COMMENT 'Manufacturers model designation for the scale equipment. Used for identifying compatible parts, specifications, and service procedures.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration of the scale equipment. Used for preventive maintenance planning and regulatory compliance tracking. Typically annual or semi-annual based on jurisdiction requirements.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information, special handling requirements, known issues, or operational considerations specific to this scale equipment.',
    `ntep_certificate_number` STRING COMMENT 'Certificate number issued by the National Conference on Weights and Measures (NCWM) National Type Evaluation Program, certifying that the scale design meets NIST Handbook 44 requirements. Required for commercial weighing applications in most U.S. jurisdictions.',
    `operational_status` STRING COMMENT 'Current operational state of the scale equipment. Active indicates in-service and available for weighing operations, inactive for temporarily offline, maintenance for scheduled service, out_of_service for equipment failures, decommissioned for permanently retired units.. Valid values are `active|inactive|maintenance|out_of_service|decommissioned`',
    `platform_length_feet` DECIMAL(18,2) COMMENT 'Length of the scale weighing platform measured in feet. Determines the maximum vehicle length that can be accommodated for single-draft weighing. Typical truck scales range from 40 to 100 feet.',
    `platform_width_feet` DECIMAL(18,2) COMMENT 'Width of the scale weighing platform measured in feet. Standard truck scale widths are typically 10 to 12 feet to accommodate commercial vehicle axle spacing.',
    `printer_integration_type` STRING COMMENT 'Method by which weight ticket printers are connected to the scale system. Direct serial for RS-232 connection, network for TCP/IP, USB for local connection, none if no printer is integrated.. Valid values are `direct_serial|network|usb|none`',
    `remote_display_enabled_flag` BOOLEAN COMMENT 'Indicates whether the scale is equipped with remote weight displays visible to drivers. True if remote displays are installed and operational, false otherwise. Enhances transparency and reduces disputes.',
    `rfid_reader_installed_flag` BOOLEAN COMMENT 'Indicates whether the scale is equipped with RFID readers for automated vehicle or container identification. True if RFID capability is installed, false otherwise. Enables touchless weighing workflows.',
    `scale_house_location` STRING COMMENT 'Physical location description of the scale house or weighing station within the transfer station facility. Used for operational routing and driver instructions.',
    `scale_number` STRING COMMENT 'Business identifier for the scale equipment, used for operational reference and reporting. Externally visible scale designation.',
    `scale_type` STRING COMMENT 'Classification of the scale equipment based on its design and intended use. Truck scales are for full vehicle weighing, axle scales for individual axle measurement, floor scales for smaller loads, platform scales for container weighing, portable scales for temporary installations, and rail scales for rail car weighing.. Valid values are `truck_scale|axle_scale|floor_scale|platform_scale|portable_scale|rail_scale`',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific scale unit. Required for warranty registration, service tracking, and regulatory compliance documentation.',
    `software_system_integration` STRING COMMENT 'Name of the enterprise software system that the scale is integrated with for automated weight ticket generation and data capture. Typically ERP, billing, or waste management platform.',
    `source_system` STRING COMMENT 'Name of the operational system from which this scale equipment record originated. Typically asset management system, ERP, or facility management platform.',
    `unattended_operation_enabled_flag` BOOLEAN COMMENT 'Indicates whether the scale is configured for unattended self-service operation by drivers. True if kiosk or automated systems allow operation without scale house attendant, false for attended-only operation.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage expires for the scale equipment. Used for maintenance planning and cost forecasting.',
    `weighmaster_certification_status` STRING COMMENT 'Indicates whether the scale location has current weighmaster certification as required by state regulations. Certified means valid certification is in place, expired means renewal is needed, not_required for jurisdictions without this requirement, pending for applications in process.. Valid values are `certified|expired|not_required|pending`',
    CONSTRAINT pk_scale_equipment PRIMARY KEY(`scale_equipment_id`)
) COMMENT 'Master record for weighing scale equipment installed at transfer station scale houses. Captures scale ID, transfer station, scale type (truck scale, axle scale, floor scale), manufacturer, model, serial number, capacity (tons), installation date, last calibration date, next calibration due date, calibration certificate number, weighmaster certification status, NTEP certification number, operational status, and maintenance history reference. Required for regulatory compliance with state weights and measures authorities.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`hauler_account` (
    `hauler_account_id` BIGINT COMMENT 'Unique identifier for the hauler account record. Primary key for external haulers, contractors, and self-haul customers authorized to deliver waste to transfer stations.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `hazardous_waste_generator_id` BIGINT COMMENT 'EPA-issued identification number for hazardous waste generators, required for haulers delivering hazardous waste streams under RCRA regulations.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Hauler accounts may represent regulated facilities when the hauler operates their own transfer stations or disposal facilities. Links third-party haulers to regulatory compliance tracking.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Hauler accounts represent third-party haulers who are vendors in the vendor master. Procurement manages vendor relationships, tracks certifications and insurance, and processes invoices. AP reconciles',
    `account_number` STRING COMMENT 'Externally-visible unique account number assigned to the hauler for billing and operational reference. Used in manifests and weight tickets.. Valid values are `^[A-Z0-9]{8,15}$`',
    `account_status` STRING COMMENT 'Current operational status of the hauler account. Active: authorized to deliver. Inactive: not currently delivering. Suspended: temporarily blocked. Pending approval: awaiting authorization. Terminated: permanently closed. Delinquent: payment issues.. Valid values are `active|inactive|suspended|pending_approval|terminated|delinquent`',
    `account_type` STRING COMMENT 'Classification of the hauler relationship. Contracted hauler: long-term service agreement. Municipal hauler: government entity. Self-haul: individual or business delivering own waste. Broker: intermediary. Third-party contractor: subcontracted hauler. Private hauler: independent commercial hauler.. Valid values are `contracted_hauler|municipal_hauler|self_haul|broker|third_party_contractor|private_hauler`',
    `approved_waste_streams` STRING COMMENT 'Comma-separated list of waste stream types the hauler is authorized to deliver (e.g., MSW, C&D, recyclables, organics, hazardous). Determines acceptance at transfer station gates.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the hauler contract automatically renews upon expiration without requiring explicit re-negotiation.',
    `business_address_line1` STRING COMMENT 'Primary street address line for the hauler business location.',
    `business_address_line2` STRING COMMENT 'Secondary address line for suite, unit, or building information.',
    `business_city` STRING COMMENT 'City name for the hauler business address.',
    `business_country_code` STRING COMMENT 'Three-letter ISO country code for the hauler business address.. Valid values are `^[A-Z]{3}$`',
    `business_postal_code` STRING COMMENT 'ZIP or postal code for the hauler business address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `business_state` STRING COMMENT 'Two-letter state or province code for the hauler business address.. Valid values are `^[A-Z]{2}$`',
    `contract_effective_date` DATE COMMENT 'Start date of the current contract or service agreement with the hauler.',
    `contract_expiration_date` DATE COMMENT 'End date of the current contract or service agreement. Null indicates an evergreen or month-to-month arrangement.',
    `contract_reference_number` STRING COMMENT 'Reference number for the master service agreement or contract governing the hauler relationship, if applicable. Links to contract management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hauler account record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the hauler account before requiring payment or suspension. Null indicates no credit limit or prepay-only account.',
    `credit_terms` STRING COMMENT 'Payment terms extended to the hauler account. Net_15/30/45/60: payment due within specified days. Prepay: payment required before service. COD: cash on delivery.. Valid values are `net_15|net_30|net_45|net_60|prepay|cod`',
    `dot_carrier_number` STRING COMMENT 'USDOT carrier identification number issued by the Federal Motor Carrier Safety Administration for commercial haulers operating interstate.. Valid values are `^[0-9]{6,8}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the hauler account record was most recently updated.',
    `originating_jurisdiction` STRING COMMENT 'Primary municipality, county, or jurisdiction where the hauler collects waste, used for regulatory reporting and flow control compliance.',
    `rfid_tag_required` BOOLEAN COMMENT 'Indicates whether hauler vehicles must have RFID tags for automated gate entry and tracking at transfer stations.',
    `source_system` STRING COMMENT 'Operational system of record where this hauler account was originally created (AMCS Platform, SAP S/4HANA, Salesforce CRM, or Manual entry).. Valid values are `AMCS|SAP|Salesforce|Manual`',
    `special_handling_instructions` STRING COMMENT 'Free-text notes for transfer station operators regarding special requirements, restrictions, or procedures for this hauler (e.g., requires escort, hazmat certified, pre-inspection required).',
    `suspension_reason` STRING COMMENT 'Reason code or description if account status is suspended (e.g., insurance lapse, payment delinquency, contamination violations, safety incident).',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax ID for the hauler entity, used for billing and tax reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `termination_reason` STRING COMMENT 'Reason code or description if account status is terminated (e.g., contract expiration, business closure, regulatory violation, mutual agreement).',
    `tipping_fee_rate_tier` STRING COMMENT 'Rate tier classification determining the per-ton tipping fee charged to this hauler. Standard: published rate. Contracted: negotiated rate. Municipal: government rate. Volume discount: high-volume rate. Spot: one-time rate.. Valid values are `standard|contracted|municipal|volume_discount|spot`',
    `vehicle_pre_authorization_required` BOOLEAN COMMENT 'Indicates whether hauler vehicles must be pre-registered in AMCS before being allowed entry to transfer stations. True for contracted haulers, typically false for self-haul.',
    CONSTRAINT pk_hauler_account PRIMARY KEY(`hauler_account_id`)
) COMMENT 'Master record for external haulers, contractors, and self-haul customers authorized to deliver waste to Waste Management transfer stations. Captures hauler account ID, company name, account type (contracted hauler, municipal hauler, self-haul, broker), DOT carrier number, EPA generator ID (if applicable), insurance certificate reference, approved waste streams, credit terms, tipping fee rate tier, account status, primary contact, and originating jurisdiction. Distinct from the customer domain — this is the operational hauler/vendor relationship specific to transfer station intake. Integrates with AMCS for vehicle pre-authorization.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`destination_facility` (
    `destination_facility_id` BIGINT COMMENT 'Unique identifier for the destination facility record. Primary key.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Destination facilities in outbound haul operations are physical landfills, WTE plants, or MRFs requiring linkage to asset facility master for permit tracking, capacity management, insurance, environme',
    `regulated_facility_id` BIGINT COMMENT 'Foreign key linking to compliance.regulated_facility. Business justification: Destination facilities receiving waste from transfer stations are regulated facilities with permits and compliance obligations. Links outbound haul destinations to regulatory compliance tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Disposal destination facilities have relationship managers for contract negotiation, rate management, service coordination, and dispute resolution—replaces denormalized facility_contact_name/phone/ema',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Destination facilities (landfills, WTE plants, MRFs) are third-party vendors. Procurement manages vendor relationships, tracks performance against SLAs, and reconciles invoices. AP processes tipping f',
    `wte_facility_id` BIGINT COMMENT 'Foreign key linking to energy.wte_facility. Business justification: Collection destination_facility lookup table lists disposal destinations including WTE plants. This link identifies which destinations are energy recovery facilities vs landfills, enabling route optim',
    `accepted_waste_streams` STRING COMMENT 'Comma-separated list of waste stream types accepted at this destination facility (e.g., MSW, C&D, recyclables, organics, hazardous). MSW = Municipal Solid Waste, C&D = Construction and Demolition Waste.',
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

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`operating_permit` (
    `operating_permit_id` BIGINT COMMENT 'Unique identifier for the operating permit record. Primary key for the operating permit entity.',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.franchise_agreement. Business justification: Operating permits implement permit conditions mandated by franchise agreements with municipalities. Franchise compliance verification, permit-to-contract reconciliation, and municipal audit support re',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Transfer station operating permits are compliance permits and should reference the central compliance.permit table. This consolidates permit management across all facility types. Removes redundant per',
    `superseded_permit_operating_permit_id` BIGINT COMMENT 'Reference to the previous operating permit that this permit replaces or supersedes, if applicable. Used for tracking permit lineage.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station facility to which this operating permit applies.',
    `appeal_status` STRING COMMENT 'Status of any appeals or challenges to permit conditions or denial. Tracks legal or administrative proceedings related to the permit.. Valid values are `none|pending|approved|denied|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'The date from which the permit becomes legally binding and enforceable. May differ from issue date if there is a grace period.',
    `environmental_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires ongoing environmental monitoring such as air quality, water quality, or noise level monitoring.',
    `expiration_date` DATE COMMENT 'The date on which the permit expires and is no longer valid unless renewed. Critical for compliance tracking and renewal planning.',
    `financial_assurance_amount` DECIMAL(18,2) COMMENT 'Required amount of financial assurance in US dollars to be maintained as a condition of the permit. Covers potential closure, remediation, and post-closure costs.',
    `financial_assurance_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires financial assurance instruments such as bonds, letters of credit, or insurance to cover closure and post-closure costs.',
    `insurance_policy_number` STRING COMMENT 'Policy number for environmental liability insurance or financial assurance instrument associated with this permit.',
    `issue_date` DATE COMMENT 'The date on which the permit was officially issued by the regulatory authority. Marks the beginning of permit validity.',
    `issuing_agency` STRING COMMENT 'Name of the regulatory authority that issued the permit. May include EPA, state environmental agencies, or Local Enforcement Agency (LEA).',
    `issuing_agency_code` STRING COMMENT 'Standardized code or abbreviation for the issuing regulatory agency for system integration and reporting purposes.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection conducted by the issuing agency.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent regulatory inspection. Indicates whether the facility was found to be in compliance with permit conditions.. Valid values are `compliant|non_compliant|conditional|pending`',
    `last_modification_date` DATE COMMENT 'Date of the most recent modification or amendment to the permit terms or conditions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last updated in the system. Used for audit trail and change tracking.',
    `modification_count` STRING COMMENT 'Total number of modifications or amendments made to the permit since original issuance. Used for tracking permit change history.',
    `monitoring_frequency` STRING COMMENT 'Required frequency of environmental monitoring and compliance reporting as specified in the permit conditions.. Valid values are `daily|weekly|monthly|quarterly|annual|continuous`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next regulatory inspection by the issuing agency. Used for compliance planning and preparation.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the permit. May include internal operational guidance or historical context.',
    `operating_hours_restriction` STRING COMMENT 'Specific operating hours or time-of-day restrictions imposed by the permit. May limit facility operations to certain days or hours to minimize community impact.',
    `permit_conditions` STRING COMMENT 'Detailed text description of specific conditions, restrictions, and operational requirements imposed by the regulatory authority as part of the permit. May include operating hours, noise limits, traffic restrictions, or environmental monitoring requirements.',
    `permit_document_storage_path` STRING COMMENT 'File system path or document management system reference to the official permit document and supporting materials.',
    `permitted_annual_tonnage_limit` DECIMAL(18,2) COMMENT 'Maximum annual tonnage of waste authorized for processing or transfer at the facility under this permit. Used for long-term capacity planning and annual compliance reporting.',
    `permitted_daily_tonnage_limit` DECIMAL(18,2) COMMENT 'Maximum daily tonnage of waste authorized for processing or transfer at the facility under this permit, measured in Tons Per Day (TPD). Critical operational constraint for capacity planning and compliance.',
    `permitted_waste_types` STRING COMMENT 'Comma-separated list or description of waste types authorized for handling under this permit. May include Municipal Solid Waste (MSW), Construction and Demolition (C&D), recyclables, or other specific waste streams.',
    `public_notice_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires public notice or community notification for certain operational changes or permit modifications.',
    `renewal_due_date` DATE COMMENT 'The date by which the permit renewal application must be submitted to the regulatory authority to avoid lapse in coverage.',
    `renewal_status` STRING COMMENT 'Current status of the permit renewal process. Tracks whether renewal is required and the stage of the renewal application.. Valid values are `not_required|pending|submitted|approved|denied`',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting compliance reports to the regulatory authority as specified in the permit.. Valid values are `monthly|quarterly|semi_annual|annual|as_required`',
    `responsible_party_contact_email` STRING COMMENT 'Primary email address for the responsible party or permit holder for regulatory correspondence and compliance notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_contact_phone` STRING COMMENT 'Primary phone number for the responsible party or permit holder for regulatory correspondence and emergency notifications.',
    `responsible_party_name` STRING COMMENT 'Name of the individual or organization legally responsible for compliance with this permit. Typically the facility operator or permit holder.',
    `source_system` STRING COMMENT 'Name of the source system from which this permit record originated. Typically Enviance EHS or similar environmental compliance management system.',
    `violation_count` STRING COMMENT 'Total number of permit violations recorded against this permit since issuance. Used for compliance tracking and risk assessment.',
    CONSTRAINT pk_operating_permit PRIMARY KEY(`operating_permit_id`)
) COMMENT 'Regulatory operating permit records specific to each transfer station facility. Captures permit ID, transfer station reference, permit type (solid waste facility permit, air quality permit, stormwater permit, conditional use permit), issuing regulatory agency (EPA, state environmental agency, LEA), permit number, issue date, expiration date, permitted waste types, permitted daily tonnage limit (TPD), permit conditions and restrictions, renewal status, and compliance monitoring requirements. Distinct from the compliance domain — this is the operational permit reference owned by transfer station management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`shift_log` (
    `shift_log_id` BIGINT COMMENT 'Unique identifier for the transfer station shift log record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the supervisor responsible for overseeing operations during this shift.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station facility where this shift occurred.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when shift operations concluded, may differ from scheduled end due to operational conditions.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when shift operations commenced, may differ from scheduled start due to operational conditions.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift log was formally approved by management or compliance personnel.',
    `contamination_incident_count` STRING COMMENT 'Number of contamination incidents identified during the shift where prohibited materials were detected in waste streams.',
    `contamination_incident_summary` STRING COMMENT 'Description of contamination incidents including material types, sources, and corrective actions taken to address the contamination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift log record was first created in the system.',
    `equipment_deployed` STRING COMMENT 'Comma-separated list of equipment units deployed during the shift, including loaders, compactors, and other machinery with asset identifiers.',
    `equipment_issues_noted` STRING COMMENT 'Narrative description of any equipment malfunctions, breakdowns, or performance issues observed during the shift requiring maintenance attention.',
    `floor_clearance_timestamp` TIMESTAMP COMMENT 'Timestamp when the tipping floor was cleared of all waste material and ready for the next shift or end-of-day closure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift log record was most recently updated or modified.',
    `log_number` STRING COMMENT 'Human-readable business identifier for the shift log, typically formatted as station code, date, and shift sequence.',
    `operational_anomaly_description` STRING COMMENT 'Detailed narrative of operational anomalies, unusual events, or deviations from standard operating procedures encountered during the shift.',
    `operational_anomaly_flag` BOOLEAN COMMENT 'Boolean indicator of whether any operational anomalies or deviations from normal procedures occurred during the shift.',
    `operational_hold_duration_minutes` STRING COMMENT 'Total duration in minutes that operations were on hold or stopped during the shift.',
    `operational_hold_flag` BOOLEAN COMMENT 'Boolean indicator of whether operations were placed on hold or stopped during the shift due to safety, equipment, or regulatory reasons.',
    `operational_hold_reason` STRING COMMENT 'Explanation of why operations were placed on hold, including safety concerns, equipment failure, regulatory inspection, or other causes.',
    `outbound_haul_count` STRING COMMENT 'Number of outbound haul trips dispatched from the transfer station to disposal facilities during the shift.',
    `regulatory_inspection_summary` STRING COMMENT 'Summary of the regulatory inspection including areas reviewed, findings, citations issued, and follow-up actions required.',
    `regulatory_inspector_agency` STRING COMMENT 'Name of the regulatory agency or local enforcement authority whose inspector visited the facility during the shift.',
    `regulatory_inspector_visit_flag` BOOLEAN COMMENT 'Boolean indicator of whether a regulatory inspector from EPA, state environmental agency, or local enforcement authority visited the facility during the shift.',
    `safety_incident_count` STRING COMMENT 'Number of safety incidents reported during the shift, including injuries, near-misses, and hazardous conditions.',
    `safety_incident_summary` STRING COMMENT 'Brief summary of safety incidents that occurred during the shift, including nature, location, and immediate response actions taken.',
    `shift_date` DATE COMMENT 'Calendar date on which the shift occurred.',
    `shift_end_time` TIMESTAMP COMMENT 'Scheduled end timestamp for the shift.',
    `shift_handover_notes` STRING COMMENT 'Narrative notes provided by the shift supervisor to the incoming shift, documenting ongoing issues, pending tasks, and operational status for continuity.',
    `shift_start_time` TIMESTAMP COMMENT 'Scheduled start timestamp for the shift.',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift log record indicating whether it is in draft, active, completed, under review, or approved state.. Valid values are `draft|active|completed|reviewed|approved`',
    `shift_type` STRING COMMENT 'Classification of the shift period: day shift, evening shift, night shift, weekend shift, or holiday shift.. Valid values are `day|evening|night|weekend|holiday`',
    `source_system` STRING COMMENT 'Name of the operational system from which this shift log record originated, such as AMCS Platform or Locus Dispatch.',
    `staffing_headcount` STRING COMMENT 'Total number of personnel assigned and present during the shift, including operators, spotters, and support staff.',
    `tipping_floor_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of tipping floor capacity utilized during the shift, calculated as occupied area divided by total available area.',
    `total_loads_received` STRING COMMENT 'Total count of waste loads received at the transfer station during this shift from collection vehicles and other sources.',
    `total_tonnage_processed` DECIMAL(18,2) COMMENT 'Total weight in tons of waste material processed through the transfer station during this shift, measured via scale tickets.',
    `weather_condition` STRING COMMENT 'Prevailing weather conditions during the shift that may have impacted operations, safety, or throughput. [ENUM-REF-CANDIDATE: clear|rain|snow|fog|wind|extreme_heat|extreme_cold — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_shift_log PRIMARY KEY(`shift_log_id`)
) COMMENT 'Operational shift log maintained by transfer station supervisors for each work shift. Captures log ID, transfer station, shift date, shift type (day, evening, night), shift supervisor ID, shift start/end times, total loads received, total tonnage processed, tipping floor utilization percentage, equipment deployed (loaders, compactors), equipment issues noted, safety incidents reported, contamination incidents, staffing headcount, weather conditions, operational anomalies, floor clearance timestamps, operational holds or stoppages, regulatory inspector visits, and shift handover notes. Provides the operational narrative record supporting incident investigation, compliance audits, performance reviews, and tipping floor activity tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`haul_rate` (
    `haul_rate_id` BIGINT COMMENT 'Unique identifier for the haul rate record. Primary key.',
    `destination_facility_id` BIGINT COMMENT 'Reference to the destination disposal or processing facility where waste is delivered. May be a landfill, waste-to-energy plant, materials recovery facility, or treatment storage and disposal facility.',
    `hauler_account_id` BIGINT COMMENT 'Reference to the third-party hauling contractor or internal fleet division responsible for outbound transportation. Used for invoice validation and cost allocation.',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station from which waste is hauled. Identifies the consolidation facility where waste is loaded for outbound transportation.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this haul rate. Provides audit trail for rate authorization.',
    `superseded_by_rate_haul_rate_id` BIGINT COMMENT 'Reference to the newer haul rate record that replaces this rate. Used to maintain rate history and version control. Null for current active rates.',
    `tertiary_haul_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this haul rate record. Part of audit trail for rate changes.',
    `approval_status` STRING COMMENT 'Workflow approval state for rate changes. Tracks management authorization before rate becomes active.. Valid values are `not_submitted|pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the haul rate was approved. Part of audit trail for rate management.',
    `contract_reference_number` STRING COMMENT 'Reference to the master service agreement or purchase order governing this haul rate. Links rate to contractual terms and conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this haul rate record was first created in the system. Part of audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amount. Typically USD for US operations.. Valid values are `^[A-Z]{3}$`',
    `distance_miles` DECIMAL(18,2) COMMENT 'Standard route distance in miles between origin transfer station and destination facility. Used for per-mile rate calculations and route planning.',
    `effective_date` DATE COMMENT 'Date when this haul rate becomes active and applicable for transportation cost calculations and invoicing. Start of rate validity period.',
    `environmental_fee_amount` DECIMAL(18,2) COMMENT 'Additional environmental compliance fee per unit added to base haul rate. May be mandated by state or local regulations for waste transportation.',
    `estimated_transit_time_minutes` STRING COMMENT 'Expected travel time in minutes for haul route under normal traffic conditions. Used for scheduling and per-hour rate calculations.',
    `expiration_date` DATE COMMENT 'Date when this haul rate ceases to be valid. Null for open-ended rates. End of rate validity period.',
    `fuel_surcharge_formula` STRING COMMENT 'Mathematical formula or reference to fuel surcharge calculation method applied to base rate. May reference DOT fuel price index or fixed percentage. Used to adjust transportation costs based on fuel price volatility.',
    `fuel_surcharge_percentage` DECIMAL(18,2) COMMENT 'Fixed percentage fuel surcharge applied to base rate if using percentage-based surcharge method. Null if formula-based surcharge is used.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this haul rate record was last updated. Part of audit trail for tracking rate changes.',
    `maximum_charge_amount` DECIMAL(18,2) COMMENT 'Maximum transportation charge cap per haul. May be imposed by municipal contracts or regulatory rate caps.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum transportation charge per haul regardless of calculated rate. Ensures cost recovery for small loads or short hauls.',
    `permit_number` STRING COMMENT 'Regulatory permit or authorization number required for this haul route. Applicable for hazardous waste manifests or special transportation permits.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether special hauling permits are required for this route. True for hazardous waste, overweight loads, or restricted routes.',
    `rate_adjustment_percentage` DECIMAL(18,2) COMMENT 'Annual or periodic percentage adjustment applied to base rate for inflation or cost escalation per contract terms. Null if no automatic adjustment applies.',
    `rate_amount` DECIMAL(18,2) COMMENT 'Base transportation rate amount per unit as defined by rate basis. Expressed in currency per ton, per load, per mile, or other unit. Excludes fuel surcharges and additional fees.',
    `rate_basis` STRING COMMENT 'Unit of measure on which the haul rate is calculated. Determines how transportation costs are computed for invoicing and cost accounting.. Valid values are `per_ton|per_load|per_mile|per_hour|flat_rate|per_cubic_yard`',
    `rate_code` STRING COMMENT 'Business identifier code for the haul rate used in contracts and invoicing. Unique alphanumeric code assigned to each rate schedule.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rate_name` STRING COMMENT 'Descriptive name for the haul rate schedule for business user identification and reporting purposes.',
    `rate_notes` STRING COMMENT 'Free-text field for additional rate information, special conditions, or business context not captured in structured fields.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the haul rate. Controls whether rate is available for use in cost calculations and invoicing.. Valid values are `draft|pending_approval|active|suspended|expired|superseded`',
    `rate_tier` STRING COMMENT 'Classification of rate type based on contract structure. Spot = one-time market rate, Contracted = long-term agreement rate, Municipal = government contract rate, Emergency = premium rate for urgent hauls, Seasonal = time-period specific rate.. Valid values are `spot|contracted|municipal|emergency|seasonal`',
    `regulatory_rate_cap` DECIMAL(18,2) COMMENT 'Maximum rate amount imposed by regulatory authority or municipal contract. Null if no regulatory cap applies.',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this haul rate record originated. Typically SAP MM for rate management or Oracle Revenue Management for billing rates.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether this haul rate is exempt from sales tax. True for municipal contracts or tax-exempt waste streams.',
    `toll_charges_included_flag` BOOLEAN COMMENT 'Indicates whether toll road charges are included in the base rate or billed separately. True if tolls are included in rate amount.',
    `vehicle_type_required` STRING COMMENT 'Specification of truck or trailer type required for this haul route based on waste stream and facility requirements. Examples: transfer trailer, roll-off truck, walking floor trailer.',
    `volume_discount_rate` DECIMAL(18,2) COMMENT 'Discounted rate amount applied when volume threshold is met. Null if no volume discount applies.',
    `volume_discount_threshold_tons` DECIMAL(18,2) COMMENT 'Minimum tonnage threshold per period to qualify for volume-based rate discount. Null if no volume discount applies.',
    `waste_stream_type` STRING COMMENT 'Classification of waste material being hauled. MSW = Municipal Solid Waste, C&D = Construction and Demolition Waste. Determines applicable regulatory requirements and disposal methods.. Valid values are `MSW|C&D|recyclables|organics|hazardous|special_waste`',
    `weight_limit_tons` DECIMAL(18,2) COMMENT 'Maximum payload weight in tons allowed for this haul route based on DOT regulations, vehicle capacity, and facility restrictions.',
    CONSTRAINT pk_haul_rate PRIMARY KEY(`haul_rate_id`)
) COMMENT 'Reference rate schedule for outbound haul transportation costs from transfer stations to destination facilities. Captures haul rate ID, origin transfer station, destination facility reference, haul contractor reference, waste stream type, rate basis (per ton, per load, per mile), rate amount, fuel surcharge formula, effective date, expiration date, contract reference, rate tier (spot, contracted, municipal), and approval status. Used for outbound disposal cost accounting and haul contractor invoice validation in SAP MM/FI.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` (
    `collection_environmental_monitoring_id` BIGINT COMMENT 'Unique identifier for the environmental monitoring record. Primary key for this entity.',
    `compliance_environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_environmental_monitoring. Business justification: Collection-side environmental monitoring at transfer stations feeds compliance monitoring programs required by permits. Links operational monitoring data to regulatory compliance tracking for air, wat',
    `environmental_sample_id` BIGINT COMMENT 'Unique identifier assigned to the environmental sample collected for laboratory analysis, enabling chain of custody tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Environmental monitoring (air quality, water discharge, noise) at transfer stations requires supervisor review for regulatory reporting, corrective action authorization, and permit compliance verifica',
    `transfer_station_id` BIGINT COMMENT 'Reference to the transfer station facility where the environmental monitoring was conducted.',
    `agency_report_date` DATE COMMENT 'Date when the monitoring result was submitted to the regulatory agency in compliance with reporting requirements.',
    `agency_report_reference` STRING COMMENT 'Reference number or tracking identifier assigned by the regulatory agency upon receipt of the monitoring report.',
    `ambient_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Fahrenheit at the time of monitoring, relevant for temperature-dependent measurements and regulatory context.',
    `certified_lab_reference` STRING COMMENT 'Reference number or identifier for the certified environmental laboratory that performed the analysis, if applicable. Required for regulatory reporting of laboratory-analyzed samples.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions taken or planned in response to the monitoring result, including timeline and responsible parties.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required based on the monitoring result, either due to regulatory exceedance or operational best practices.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this environmental monitoring record was first created in the data system.',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the measured value exceeded the regulatory threshold, triggering potential compliance action or corrective measures.',
    `lab_certification_number` STRING COMMENT 'State or federal certification number of the environmental laboratory that conducted the analysis, demonstrating compliance with quality assurance requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this environmental monitoring record was last updated or modified.',
    `measured_parameter` STRING COMMENT 'Specific environmental parameter being measured, such as pH, total suspended solids, particulate matter PM10, hydrogen sulfide concentration, decibel level, or biochemical oxygen demand.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value of the environmental parameter measurement as recorded by the monitoring equipment or certified laboratory analysis.',
    `monitoring_date` DATE COMMENT 'Calendar date when the environmental monitoring measurement or observation was taken.',
    `monitoring_equipment_code` STRING COMMENT 'Identifier for the monitoring equipment or instrument used to collect the measurement, enabling traceability and calibration verification.',
    `monitoring_frequency_required` STRING COMMENT 'Frequency at which this type of environmental monitoring is required to be conducted per permit conditions or regulatory requirements. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annual|event_based|continuous — 7 candidates stripped; promote to reference product]',
    `monitoring_location` STRING COMMENT 'Specific location on the transfer station site where the environmental monitoring was conducted, such as perimeter fence line, tipping floor, stormwater outfall, or property boundary.',
    `monitoring_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring location in decimal degrees format.',
    `monitoring_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring location in decimal degrees format.',
    `monitoring_method` STRING COMMENT 'Standardized method or protocol used to conduct the environmental monitoring, such as EPA Method 9040B for pH or EPA Method 1664A for oil and grease.',
    `monitoring_status` STRING COMMENT 'Current status of the environmental monitoring record in its lifecycle, from scheduling through completion and regulatory reporting.. Valid values are `scheduled|completed|in_progress|cancelled|overdue`',
    `monitoring_technician_certification` STRING COMMENT 'Professional certification or qualification held by the monitoring technician, such as Certified Environmental Professional (CEP) or state-specific certifications.',
    `monitoring_technician_name` STRING COMMENT 'Name of the technician or environmental specialist who conducted the monitoring or collected the sample.',
    `monitoring_timestamp` TIMESTAMP COMMENT 'Precise date and time when the environmental monitoring measurement was recorded, including time zone information for regulatory compliance.',
    `monitoring_type` STRING COMMENT 'Category of environmental monitoring being performed at the transfer station. Determines the regulatory framework and compliance requirements applicable to this record. [ENUM-REF-CANDIDATE: stormwater_runoff|air_emissions|odor_complaint|noise_level|leachate|dust|vector_control — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional notes, observations, or contextual information recorded by the monitoring technician that may be relevant for interpretation or compliance documentation.',
    `permit_condition_reference` STRING COMMENT 'Specific permit condition, section, or requirement that mandates this environmental monitoring activity, linking the record to regulatory obligations.',
    `permit_number` STRING COMMENT 'Permit number issued by the regulatory authority under which this monitoring is required, such as NPDES permit for stormwater or air quality permit.',
    `record_number` STRING COMMENT 'Business identifier for the environmental monitoring record, typically used for external reporting and permit compliance documentation.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory agency or local enforcement agency (LEA) with jurisdiction over this environmental monitoring requirement.',
    `regulatory_threshold` DECIMAL(18,2) COMMENT 'Maximum allowable value or regulatory limit for the measured parameter as defined by the applicable environmental permit or regulatory standard.',
    `reported_to_agency_flag` BOOLEAN COMMENT 'Indicates whether this monitoring result has been reported to the regulatory authority as required by permit conditions or compliance obligations.',
    `source_system` STRING COMMENT 'Name of the operational system from which this environmental monitoring record originated, such as Enviance EHS or environmental monitoring equipment system.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measurement for the recorded value, such as mg/L (milligrams per liter), ppm (parts per million), dBA (decibels A-weighted), or µg/m³ (micrograms per cubic meter).',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of monitoring, which may impact environmental measurements such as stormwater runoff or air quality.',
    `wind_direction` STRING COMMENT 'Cardinal or intercardinal direction from which the wind is blowing at the time of monitoring, relevant for odor complaint investigations and air quality assessments.',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed in miles per hour at the time of monitoring, relevant for air quality and odor dispersion assessments.',
    CONSTRAINT pk_collection_environmental_monitoring PRIMARY KEY(`collection_environmental_monitoring_id`)
) COMMENT 'Environmental monitoring records specific to transfer station operations including stormwater, air quality, odor, and leachate monitoring. Captures monitoring record ID, transfer station, monitoring type (stormwater runoff, air emissions, odor complaint, noise, leachate), monitoring date, monitoring location on site, measured parameter, measured value, unit of measure, regulatory threshold, exceedance flag, corrective action required flag, monitoring method, certified lab reference, and permit condition reference. Supports Clean Air Act, Clean Water Act, and state permit compliance for transfer station facilities.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`hauler_authorization` (
    `hauler_authorization_id` BIGINT COMMENT 'Unique identifier for this hauler-station authorization record. Primary key for the association.',
    `hauler_account_id` BIGINT COMMENT 'Foreign key linking to the hauler account authorized to deliver waste to the transfer station',
    `transfer_station_id` BIGINT COMMENT 'Foreign key linking to the transfer station facility where the hauler is authorized to deliver',
    `authorization_date` DATE COMMENT 'Date when the hauler was authorized to deliver waste to this specific transfer station. Marks the start of the authorization relationship.',
    `authorization_expiration_date` DATE COMMENT 'Date when this station-specific authorization expires and requires renewal. Null indicates no expiration (evergreen authorization subject to ongoing compliance).',
    `authorization_status` STRING COMMENT 'Current lifecycle status of this station-specific authorization. Pending: application submitted. Active: authorized to deliver. Suspended: temporarily blocked. Revoked: permanently terminated. Expired: authorization period ended.',
    `authorized_transfer_stations` STRING COMMENT 'Comma-separated list of transfer station facility IDs where this hauler is authorized to deliver waste. Used for gate access control and vehicle pre-authorization. [Moved from hauler_account: This denormalized STRING field in hauler_account contains a comma-separated list of transfer station IDs. It should be replaced by the proper hauler_authorization association table, which provides full relationship lifecycle management, station-specific attributes, and historical tracking. The denormalized field cannot capture authorization dates, statuses, station-specific rates, or suspension reasons.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hauler-station authorization record was first created in the system.',
    `last_delivery_date` DATE COMMENT 'Date of the most recent waste delivery by this hauler to this specific transfer station. Used for monitoring active vs. dormant authorizations and compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hauler-station authorization record was most recently updated.',
    `pre_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether this hauler must pre-register each vehicle delivery in AMCS before arriving at THIS specific transfer station. Station-specific operational requirement.',
    `revocation_reason` STRING COMMENT 'Reason code or description if this station-specific authorization status is revoked (e.g., repeated violations at this station, contract termination for this station, regulatory prohibition).',
    `rfid_transponder_required_flag` BOOLEAN COMMENT 'Indicates whether this haulers vehicles must have RFID transponders for automated gate entry at THIS specific transfer station. Station-specific requirement that may differ from haulers global RFID settings.',
    `station_specific_tipping_rate_tier` STRING COMMENT 'Rate tier classification determining the per-ton tipping fee charged to this hauler at THIS specific transfer station. May differ from the haulers global rate tier based on station-specific contracts or volume commitments.',
    `station_specific_waste_streams_allowed` STRING COMMENT 'Comma-separated list of waste stream types this hauler is authorized to deliver to THIS specific transfer station. May be more restrictive than the haulers global approved_waste_streams based on station capabilities and hauler-station agreement.',
    `suspension_reason` STRING COMMENT 'Reason code or description if this station-specific authorization status is suspended (e.g., contamination violations at this station, unpaid invoices for this station, station-specific safety incident).',
    `ytd_tonnage_delivered` DECIMAL(18,2) COMMENT 'Total tons of waste delivered by this hauler to this specific transfer station in the current calendar year. Used for volume-based rate tier adjustments and contract compliance monitoring.',
    CONSTRAINT pk_hauler_authorization PRIMARY KEY(`hauler_authorization_id`)
) COMMENT 'This association product represents the authorization contract between a hauler account and a transfer station facility. It captures the station-specific permissions, rates, waste stream restrictions, and operational requirements that govern a haulers ability to deliver waste to a specific transfer station. Each record links one hauler account to one transfer station with attributes that exist only in the context of this authorization relationship, including authorization lifecycle dates, station-specific tipping rates, allowed waste streams, RFID requirements, and delivery history metrics.. Existence Justification: In waste management transfer station operations, haulers must be explicitly authorized to deliver waste to specific transfer stations, with each hauler-station relationship governed by station-specific permissions, rates, waste stream restrictions, and operational requirements. A single hauler account can be authorized to deliver to multiple transfer stations (e.g., a regional contractor authorized at 5 different WM facilities), and each transfer station accepts waste from hundreds of different hauler accounts (contracted haulers, municipal haulers, self-haul customers, brokers). The authorization relationship is actively managed by station operators and compliance staff, with lifecycle states (pending, active, suspended, revoked), station-specific tipping rates, allowed waste streams, RFID requirements, and delivery history tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` (
    `hauler_site_authorization_id` BIGINT COMMENT 'Unique identifier for this hauler-site authorization record. Primary key.',
    `hauler_account_id` BIGINT COMMENT 'Foreign key linking to the hauler account authorized to deliver waste',
    `site_id` BIGINT COMMENT 'Foreign key linking to the landfill site where the hauler is authorized to deliver',
    `approved_waste_streams` STRING COMMENT 'Comma-separated list of waste stream types this hauler is authorized to deliver to this specific site (MSW, C&D, recyclables, yard_waste, etc.). May differ from haulers global approved streams based on site-specific permits and contracts.',
    `authorization_status` STRING COMMENT 'Current operational status of this specific hauler-site authorization. Active: hauler authorized to deliver to this site. Suspended: temporarily restricted. Expired: authorization period ended. Revoked: authorization terminated.',
    `contract_reference` STRING COMMENT 'Reference number or identifier for the contract or agreement governing this specific hauler-site authorization. May reference master service agreement or site-specific addendum.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hauler-site authorization record was first created in the system.',
    `effective_date` DATE COMMENT 'Start date when this hauler-site authorization becomes active. Corresponds to contract effective date or site-specific authorization approval.',
    `expiration_date` DATE COMMENT 'End date when this hauler-site authorization expires. Null indicates evergreen authorization subject to contract terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hauler-site authorization record was most recently updated.',
    `site_specific_instructions` STRING COMMENT 'Free-text notes for site operators regarding special requirements, restrictions, or handling procedures for this hauler at this specific site (e.g., designated unloading area, inspection requirements, prohibited materials).',
    `tipping_fee_rate_tier` STRING COMMENT 'Rate tier classification determining the per-ton tipping fee charged to this hauler at this specific site. Negotiated per hauler-site combination based on volume commitments and contract terms.',
    `volume_commitment_tons` DECIMAL(18,2) COMMENT 'Contractual volume commitment in tons that the hauler has agreed to deliver to this specific site within the contract period. Used for rate negotiation and capacity planning.',
    CONSTRAINT pk_hauler_site_authorization PRIMARY KEY(`hauler_site_authorization_id`)
) COMMENT 'This association product represents the authorization contract between hauler accounts and landfill sites. It captures the operational authorization for a specific hauler to deliver waste to a specific site, including approved waste streams, negotiated tipping rates, volume commitments, and contract terms that exist only in the context of this hauler-site relationship. Each record represents a distinct disposal agreement governing one haulers access to one site.. Existence Justification: In waste management operations, hauler accounts are authorized to deliver waste to multiple landfill sites based on negotiated contracts, and each landfill site accepts waste from multiple authorized haulers. The authorization relationship is actively managed with site-specific terms: approved waste streams may vary by site based on permits, tipping fee rates are negotiated per hauler-site combination based on volume commitments, and authorization status is tracked per site (a hauler may be active at Site A but suspended at Site B). This is an operational business entity called Hauler Site Authorization or Disposal Agreement that humans create, update, and manage.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` (
    `route_driver_qualification_id` BIGINT COMMENT 'Unique identifier for this route-driver qualification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee (driver) master record',
    `qualification_verified_by_employee_id` BIGINT COMMENT 'Employee ID of the supervisor or training coordinator who verified this drivers qualification for this route. Foreign key to workforce.employee.',
    `route_id` BIGINT COMMENT 'Foreign key linking to the collection route master record',
    `assignment_status` STRING COMMENT 'Current status of this qualification record: active (driver is qualified and available), inactive (qualification expired or driver no longer assigned), pending_qualification (driver in training/verification), suspended (temporarily not available for this route).',
    `assignment_type` STRING COMMENT 'Classification of the drivers assignment to this route: primary (regular assigned driver), backup (secondary coverage), vacation_coverage (temporary fill-in), seasonal (peak season support), or training (driver in qualification process).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this driver qualification for this route is no longer effective. Null indicates the qualification is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this driver qualification for this route became or will become effective. Used for planning future assignments and tracking qualification history.',
    `last_assignment_date` DATE COMMENT 'Most recent date this driver was actually assigned to execute this route. Used for rotation scheduling and ensuring drivers maintain route familiarity.',
    `notes` STRING COMMENT 'Free-text notes about this driver-route qualification, such as special considerations, restrictions, or performance observations.',
    `primary_backup_flag` STRING COMMENT 'Indicates whether this driver is the primary assigned driver or a backup driver for this route. Used by dispatch to prioritize driver assignments.',
    `qualification_verified_date` DATE COMMENT 'Date when the drivers qualification for this route was verified by a supervisor or training coordinator. Used for compliance tracking and audit purposes.',
    `qualification_verified_flag` BOOLEAN COMMENT 'Indicates whether the drivers qualifications (CDL class, endorsements, truck type experience) have been verified as meeting the requirements for this specific route. Set to true after supervisor ride-along or qualification check.',
    `total_assignments_count` STRING COMMENT 'Total number of times this driver has been assigned to execute this route. Used for experience tracking and performance analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated.',
    CONSTRAINT pk_route_driver_qualification PRIMARY KEY(`route_driver_qualification_id`)
) COMMENT 'This association product represents the qualification and assignment relationship between collection routes and drivers. It captures which drivers are qualified to operate specific routes, including primary/backup designation, qualification verification, and effective date ranges. Each record links one route to one employee (driver) with attributes that exist only in the context of this qualification relationship. This is the operational matrix used by dispatch to assign drivers to routes based on CDL requirements, truck type qualifications, and coverage needs.. Existence Justification: In waste collection operations, routes require multiple qualified drivers for coverage (primary, backup, vacation relief, seasonal support), and drivers are qualified to operate multiple routes based on CDL class, truck type experience, and geographic familiarity. Dispatch actively manages this qualification matrix to ensure daily route coverage, track driver-route experience, verify qualifications, and manage rotation schedules. This is an operational business entity called Route Driver Qualification that dispatch teams create, update, and query daily.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`disposal_routing` (
    `disposal_routing_id` BIGINT COMMENT 'Unique identifier for this transfer station to landfill disposal routing relationship. Primary key.',
    `site_id` BIGINT COMMENT 'Foreign key linking to the landfill site that receives waste from the transfer station',
    `transfer_station_id` BIGINT COMMENT 'Foreign key linking to the transfer station facility that is routing waste outbound for disposal',
    `contracted_capacity_tpd` DECIMAL(18,2) COMMENT 'Contracted or allocated daily disposal capacity in tons per day reserved for this transfer station at this landfill site. Used for capacity planning and load balancing across disposal sites.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this disposal routing agreement record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this disposal routing agreement became effective and operational. Used for historical tracking and agreement lifecycle management.',
    `estimated_transit_time_minutes` STRING COMMENT 'Estimated one-way transit time in minutes from transfer station to landfill site under normal traffic conditions. Used for scheduling, driver shift planning, and turnaround time estimation.',
    `expiration_date` DATE COMMENT 'Date when this disposal routing agreement expires or is scheduled for renewal. Null indicates an ongoing agreement with no fixed expiration.',
    `haul_distance_miles` DECIMAL(18,2) COMMENT 'Road distance in miles from the transfer station to the landfill site. Used for haul cost calculation, route optimization, and logistics planning.',
    `preferred_disposal_flag` BOOLEAN COMMENT 'Indicates whether this landfill site is the preferred/primary disposal destination for this transfer station. Used for routing optimization and load balancing decisions.',
    `routing_status` STRING COMMENT 'Current operational status of this disposal routing agreement. active = currently in use, suspended = temporarily inactive, expired = past expiration date, pending = approved but not yet effective.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this disposal routing agreement record was last modified.',
    `waste_stream_routing_rules` STRING COMMENT 'Business rules defining which waste streams from the transfer station are routed to this landfill site. May specify MSW only, C&D only, mixed streams, or conditional routing based on waste classification and site permits.',
    CONSTRAINT pk_disposal_routing PRIMARY KEY(`disposal_routing_id`)
) COMMENT 'This association product represents the operational routing agreement between transfer stations and landfill sites. It captures the business rules, capacity allocations, and logistics parameters that govern where waste from each transfer station is disposed. Each record links one transfer station to one landfill site with routing preferences, contracted capacity, haul logistics, and waste stream rules that exist only in the context of this disposal relationship.. Existence Justification: In waste management operations, transfer stations actively manage disposal routing to multiple landfill sites for capacity balancing, waste stream specialization (MSW vs C&D), redundancy planning, and cost optimization. Simultaneously, landfill sites receive waste from multiple transfer stations across their service territory. The business manages these routing relationships as operational agreements with contracted capacity allocations, haul logistics parameters, waste stream routing rules, and effective/expiration dates that belong to neither the transfer station nor the landfill site alone.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`district_program_participation` (
    `district_program_participation_id` BIGINT COMMENT 'Unique identifier for this district-program participation record. Primary key.',
    `circular_economy_program_id` BIGINT COMMENT 'Foreign key to sustainability.circular_economy_program.circular_economy_program_id',
    `district_id` BIGINT COMMENT 'Foreign key linking to the collection district participating in the circular economy program',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing this programs operations in this specific district. May be the district operations manager or a dedicated program coordinator.',
    `actual_diversion_tons` DECIMAL(18,2) COMMENT 'The actual volume of material diverted from landfill through this program in this district. Explicitly identified in detection phase relationship data. Used for performance tracking and ESG reporting.',
    `annual_diversion_target_tons` DECIMAL(18,2) COMMENT 'The target volume of material to be diverted from landfill annually through this program in this specific district. Explicitly identified in detection phase relationship data. District-level target that rolls up to program-level target.',
    `customer_enrollment_count` STRING COMMENT 'The number of customers in this district who are enrolled in this circular economy program. Explicitly identified in detection phase relationship data. Used to calculate participation rate and track program adoption.',
    `marketing_campaign_code` BIGINT COMMENT 'Reference to the marketing campaign used to promote this program in this district. Different districts may use different marketing approaches.',
    `notes` STRING COMMENT 'Free-text field for district-specific program notes, operational considerations, or performance commentary.',
    `participation_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of eligible customers in this district who are actively participating in this program. Explicitly identified in detection phase relationship data. Used for program performance measurement.',
    `program_end_date` DATE COMMENT 'The date when this program concluded or is scheduled to conclude in this specific district. May differ from the overall program end date if the program is phased out district-by-district.',
    `program_launch_date` DATE COMMENT 'The date when this circular economy program was launched in this specific collection district. Explicitly identified in detection phase relationship data.',
    `program_status` STRING COMMENT 'Current operational status of this program in this specific district. Explicitly identified in detection phase relationship data. Values: planned (approved but not yet launched), active (currently operating), suspended (temporarily paused), completed (successfully concluded), cancelled (terminated before completion).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this district-program participation record was created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this district-program participation record was last updated.',
    CONSTRAINT pk_district_program_participation PRIMARY KEY(`district_program_participation_id`)
) COMMENT 'This association product represents the operational participation of a collection district in a circular economy program. It captures district-level program launch, enrollment tracking, diversion performance measurement, and participation status. Each record links one collection district to one circular economy program with attributes that exist only in the context of this district-program relationship, enabling geographic program performance reporting and ESG compliance tracking.. Existence Justification: In Waste Management operations, collection districts participate in multiple circular economy programs simultaneously (e.g., a district may run organics composting, C&D recycling, and e-waste programs concurrently), and each circular economy program operates across multiple geographic districts to achieve scale and regional coverage. The business actively manages district-level program participation, tracking launch dates, customer enrollment, participation rates, and diversion performance for each district-program combination to support ESG reporting and program optimization.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` (
    `hazmat_service_schedule_id` BIGINT COMMENT 'Unique identifier for this route-generator service schedule record. Primary key.',
    `hazardous_waste_generator_id` BIGINT COMMENT 'Foreign key linking to the hazardous waste generator being served by this route',
    `route_id` BIGINT COMMENT 'Foreign key linking to the collection route that serves this hazardous waste generator',
    `container_count` STRING COMMENT 'Number of hazardous waste containers assigned to this generator for collection on this route. Used for capacity planning and route optimization.',
    `effective_end_date` DATE COMMENT 'Date when this route stopped or will stop servicing this generator. Null indicates ongoing service.',
    `effective_start_date` DATE COMMENT 'Date when this route began or will begin servicing this generator. Used for service history and billing.',
    `estimated_pickup_time_minutes` STRING COMMENT 'Estimated time in minutes required to complete pickup at this generator location, including container handling, manifest completion, and safety procedures. Used for route time planning.',
    `last_service_date` DATE COMMENT 'The most recent date this generator was actually serviced by this route. Used for tracking service history and calculating next service due date.',
    `manifest_required_flag` BOOLEAN COMMENT 'Indicates whether a hazardous waste manifest is required for this specific route-generator service (depends on waste type and generator category).',
    `next_service_date` DATE COMMENT 'The next planned service date for this generator on this route. Calculated based on service frequency and last service date, adjusted for regulatory accumulation limits.',
    `scheduled_day_of_week` STRING COMMENT 'The specific day of the week this generator is scheduled for pickup on this route. May differ from other generators on the same route due to regulatory or operational constraints.',
    `service_frequency` STRING COMMENT 'How often this specific generator is serviced by this route: weekly, biweekly, monthly, quarterly, on-demand, or as-needed. This is generator-specific and may differ from the routes overall frequency.',
    `service_status` STRING COMMENT 'Current operational status of this route-generator service arrangement: active (regular service), suspended (temporarily paused), pending (scheduled to start), or cancelled (service terminated).',
    `special_handling_requirements` STRING COMMENT 'Any special handling, equipment, or procedural requirements specific to collecting this waste stream from this generator on this route (e.g., PPE requirements, spill containment, temperature control).',
    `waste_stream_type` STRING COMMENT 'The specific type of hazardous waste stream collected from this generator on this route (e.g., flammable liquids, corrosive materials, toxic substances). A generator may have multiple waste streams served by different routes.',
    CONSTRAINT pk_hazmat_service_schedule PRIMARY KEY(`hazmat_service_schedule_id`)
) COMMENT 'This association product represents the scheduled service relationship between collection routes and hazardous waste generators. It captures the operational scheduling, container assignments, and service frequency for each route-generator pairing. Each record links one route to one hazardous waste generator with attributes that exist only in the context of this specific service arrangement.. Existence Justification: In waste management operations, collection routes serve multiple hazardous waste generators, and individual generators are often served by multiple routes depending on waste stream type, service frequency, and regulatory requirements. For example, a single hazmat generator may have flammable liquids collected weekly on Route 101 and corrosive materials collected monthly on Route 205. The business actively manages these service schedules as operational entities with specific attributes like container assignments, pickup timing, and waste stream specifications.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` (
    `station_waste_code_permit_id` BIGINT COMMENT 'Unique identifier for this transfer station waste code permit authorization record. Primary key.',
    `transfer_station_id` BIGINT COMMENT 'Foreign key linking to the transfer station facility that holds this waste code permit authorization',
    `waste_code_id` BIGINT COMMENT 'Foreign key linking to the EPA or state hazardous waste code covered by this permit authorization',
    `acceptance_status` STRING COMMENT 'Current regulatory status of this waste code at this transfer station. AUTHORIZED = fully permitted, RESTRICTED = permitted with conditions, SUSPENDED = temporarily not accepting, PROHIBITED = not permitted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit authorization record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this waste code authorization became effective at this transfer station under the operating permit.',
    `expiration_date` DATE COMMENT 'Date when this waste code authorization expires at this transfer station and requires renewal or re-permitting.',
    `handling_restrictions` STRING COMMENT 'Specific operational restrictions or handling requirements for this waste code at this transfer station (e.g., segregated storage required, no mixing with other waste streams, trained personnel only).',
    `maximum_daily_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity in tons per day of this specific waste code that this transfer station is permitted to accept under regulatory limits.',
    `permit_reference` STRING COMMENT 'Specific permit amendment, condition number, or regulatory reference that authorizes acceptance of this waste code at this facility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit authorization record was last modified.',
    CONSTRAINT pk_station_waste_code_permit PRIMARY KEY(`station_waste_code_permit_id`)
) COMMENT 'This association product represents the regulatory permit authorization between transfer_station and waste_code. It captures the specific permit conditions, acceptance restrictions, and handling requirements that govern which hazardous waste codes each transfer station is authorized to accept. Each record links one transfer station to one waste code with permit-specific attributes that exist only in the context of this regulatory authorization relationship.. Existence Justification: Transfer stations in waste management operations are issued regulatory permits that authorize acceptance of specific EPA hazardous waste codes, with each station-code combination having unique permit conditions, quantity limits, and handling restrictions. A transfer station accepts multiple waste codes (MSW facilities may handle D-codes, F-codes, etc.), and each waste code is accepted at multiple transfer stations across the network. The business actively manages these permit authorizations as operational constraints that gate daily acceptance decisions at the facility level.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` (
    `facility_staffing_assignment_id` BIGINT COMMENT 'Unique identifier for the facility staffing assignment record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the transfer station facility',
    `transfer_station_id` BIGINT COMMENT 'Foreign key linking to the transfer station facility where the employee is assigned',
    `assignment_end_date` DATE COMMENT 'Date when the employee assignment to this transfer station facility ended. Null for active assignments. Used for historical tracking and rotation analysis.',
    `assignment_start_date` DATE COMMENT 'Date when the employee assignment to this transfer station facility became effective. Critical for tracking assignment history and coverage periods.',
    `assignment_status` STRING COMMENT 'Current status of the facility staffing assignment. ACTIVE = currently assigned and working, SUSPENDED = temporarily not working at facility, COMPLETED = assignment ended, PENDING_CERTIFICATION = assigned but awaiting facility-specific certification verification.',
    `certification_required` STRING COMMENT 'Facility-specific certification or training required for this role at this transfer station. May vary by facility type (MSW vs C&D vs hazmat-permitted facilities). Examples: Hazmat Handler Certification, Scale Operator Certification, Facility-Specific Safety Training.',
    `certification_verified_date` DATE COMMENT 'Date when the required facility-specific certification was verified for this employee at this facility. Used for compliance audits and assignment eligibility validation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility staffing assignment record was created in the system.',
    `primary_facility_flag` BOOLEAN COMMENT 'Indicates whether this transfer station is the employees primary/home facility. An employee may be assigned to multiple facilities for cross-training or coverage, but typically has one primary facility. Used for reporting and scheduling prioritization.',
    `role` STRING COMMENT 'Specific operational role the employee performs at this transfer station facility. Same employee may have different roles at different facilities. Examples: WEIGHMASTER (operates truck scales), TIPPING_FLOOR_OPERATOR (manages waste unloading), FACILITY_SUPERVISOR (oversees operations), SCALE_OPERATOR, EQUIPMENT_OPERATOR (loader/compactor), SPOTTER (directs truck traffic), SAFETY_COORDINATOR.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern for this employee at this facility. Used for scheduling and coverage planning. Values: DAY_SHIFT (typically 6am-2pm), NIGHT_SHIFT (2pm-10pm), SWING_SHIFT (10pm-6am), ROTATING (alternates between shifts), WEEKEND_ONLY, ON_CALL (backup coverage).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility staffing assignment record was last updated.',
    CONSTRAINT pk_facility_staffing_assignment PRIMARY KEY(`facility_staffing_assignment_id`)
) COMMENT 'This association product represents the operational staffing assignment between transfer stations and employees. It captures the assignment of employees to specific transfer station facilities with role-specific responsibilities, shift patterns, and facility-specific certifications. Each record links one transfer station to one employee with attributes that exist only in the context of this assignment relationship, enabling cross-training tracking, coverage management, and compliance verification.. Existence Justification: In Waste Management operations, transfer stations require multiple employees across different roles (weighmasters, tipping floor operators, supervisors, equipment operators) and shifts to maintain continuous operations. Simultaneously, employees are cross-trained and assigned to multiple transfer station facilities to provide coverage during absences, peak periods, and staff rotations. The business actively manages these assignments with facility-specific roles, shift patterns, and certifications that vary by facility type (MSW vs C&D vs hazmat-permitted).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`environmental_sample` (
    `environmental_sample_id` BIGINT COMMENT 'Primary key for environmental_sample',
    `employee_id` BIGINT COMMENT 'Reference to the employee who physically collected the environmental sample.',
    `facility_id` BIGINT COMMENT 'Reference to the waste management facility where the sample was collected.',
    `laboratory_id` BIGINT COMMENT 'Reference to the certified laboratory performing analysis on the sample.',
    `monitoring_point_id` BIGINT COMMENT 'Reference to the specific monitoring location or well where the sample was collected.',
    `sampling_event_id` BIGINT COMMENT 'Reference to the broader sampling event or monitoring round of which this sample is a part.',
    `resample_environmental_sample_id` BIGINT COMMENT 'Self-referencing FK on environmental_sample (resample_environmental_sample_id)',
    `analysis_complete_timestamp` TIMESTAMP COMMENT 'Date and time when laboratory analysis of the sample was completed.',
    `analysis_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of laboratory analysis for this sample, measured in US dollars.',
    `analysis_start_timestamp` TIMESTAMP COMMENT 'Date and time when laboratory analysis of the sample began.',
    `analyte_list` STRING COMMENT 'Comma-separated list of target analytes or contaminants to be tested in this sample (e.g., VOCs, metals, pesticides).',
    `blank_indicator` BOOLEAN COMMENT 'Flag indicating whether this sample is a field or trip blank used for quality control.',
    `chain_of_custody_number` STRING COMMENT 'Unique tracking number documenting the transfer and handling of the sample from collection to analysis.',
    `collection_method` STRING COMMENT 'Standardized procedure or protocol used to collect the environmental sample.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental sample was physically collected in the field.',
    `composite_indicator` BOOLEAN COMMENT 'Flag indicating whether this sample is a composite of multiple sub-samples (true) or a discrete grab sample (false).',
    `container_type` STRING COMMENT 'Type of container used to store and transport the sample (e.g., glass bottle, plastic vial, Tedlar bag).',
    `cost_center_code` STRING COMMENT 'Internal accounting code for the cost center responsible for the sampling and analysis expenses.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this environmental sample record was first created in the system.',
    `duplicate_indicator` BOOLEAN COMMENT 'Flag indicating whether this sample is a quality control duplicate collected for quality assurance purposes.',
    `field_observations` STRING COMMENT 'Free-text notes documenting field observations, anomalies, or conditions relevant to sample collection.',
    `hold_time_exceeded_indicator` BOOLEAN COMMENT 'Flag indicating whether the sample was analyzed after the maximum allowable hold time had expired.',
    `hold_time_hours` STRING COMMENT 'Maximum allowable time between sample collection and analysis, measured in hours, as specified by the analytical method.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this environmental sample record was last modified in the system.',
    `permit_number` STRING COMMENT 'Environmental permit number associated with the monitoring requirement that triggered this sample collection.',
    `ph_at_collection` DECIMAL(18,2) COMMENT 'pH measurement of the sample taken at the time of collection in the field.',
    `preservative_used` STRING COMMENT 'Chemical preservative added to the sample to maintain stability during transport and storage (e.g., HCl, H2SO4, HNO3).',
    `priority_indicator` BOOLEAN COMMENT 'Flag indicating whether this sample requires expedited or priority analysis due to regulatory deadlines or operational urgency.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was received at the laboratory for analysis.',
    `regulatory_program` STRING COMMENT 'Federal or state environmental regulatory program under which the sample is being collected and analyzed.',
    `sample_depth_meters` DECIMAL(18,2) COMMENT 'Depth below surface at which the sample was collected, measured in meters. Applicable to groundwater, soil, and subsurface samples.',
    `sample_matrix` STRING COMMENT 'Detailed description of the sample matrix or substrate (e.g., sandy soil, clay, municipal solid waste leachate).',
    `sample_number` STRING COMMENT 'Externally-known unique business identifier for the environmental sample, typically formatted with facility prefix and sequential number.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the environmental sample from collection through analysis completion.',
    `sample_type` STRING COMMENT 'Classification of the environmental sample by medium being tested.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the environmental sample collected, measured in milliliters.',
    `temperature_at_collection_celsius` DECIMAL(18,2) COMMENT 'Ambient or sample temperature at the time of collection, measured in degrees Celsius.',
    `voided_reason` STRING COMMENT 'Explanation for why the sample was voided or invalidated (e.g., broken container, contamination, lost in transit).',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sample collection (e.g., clear, rainy, windy).',
    CONSTRAINT pk_environmental_sample PRIMARY KEY(`environmental_sample_id`)
) COMMENT 'Master reference table for environmental_sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Primary key for laboratory',
    `parent_laboratory_id` BIGINT COMMENT 'Self-referencing FK on laboratory (parent_laboratory_id)',
    `accreditation_body` STRING COMMENT 'Name of the regulatory or certification body that has accredited the laboratory (e.g., EPA, state environmental agency, A2LA, NELAC).',
    `accreditation_effective_date` DATE COMMENT 'Date when the laboratory accreditation became effective or was last renewed.',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current laboratory accreditation expires and requires renewal.',
    `accreditation_number` STRING COMMENT 'Official accreditation certificate or registration number issued by the accrediting body.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the laboratory indicating its certification standing with regulatory bodies.',
    `address_line_1` STRING COMMENT 'Primary street address line of the laboratory facility location.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information of the laboratory facility.',
    `capacity_samples_per_day` STRING COMMENT 'Maximum number of samples the laboratory can process per day under normal operating conditions.',
    `city` STRING COMMENT 'City where the laboratory facility is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the laboratory facility is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory record was first created in the system.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency contact telephone number for urgent laboratory matters or hazardous material incidents.',
    `epa_id_number` STRING COMMENT 'EPA-issued identification number for laboratories handling hazardous waste testing and analysis.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the laboratory is certified to handle and test hazardous waste materials.',
    `is_preferred` BOOLEAN COMMENT 'Flag indicating whether this laboratory is a preferred or primary testing facility for the organization.',
    `laboratory_code` STRING COMMENT 'Unique business identifier code assigned to the laboratory for operational reference and reporting.',
    `laboratory_name` STRING COMMENT 'Official business name of the laboratory facility.',
    `laboratory_type` STRING COMMENT 'Classification of the laboratory based on its primary testing and analysis focus within waste management operations.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at the laboratory facility.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the laboratory facility location for mapping and routing purposes.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the laboratory facility location for mapping and routing purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the laboratory record was last updated or modified.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit of the laboratory facility.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about the laboratory, including special handling requirements, restrictions, or operational considerations.',
    `operating_hours` STRING COMMENT 'Standard business hours during which the laboratory accepts samples and provides services (e.g., Monday-Friday 8:00 AM - 5:00 PM).',
    `operational_status` STRING COMMENT 'Current operational state of the laboratory facility indicating its availability for testing services.',
    `ownership_type` STRING COMMENT 'Classification indicating whether the laboratory is owned and operated internally by Waste Management or is an external third-party facility.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the laboratory facility location.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary laboratory contact for operational communications and sample coordination.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person or laboratory director responsible for laboratory operations.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the laboratory contact during business hours.',
    `quality_rating` STRING COMMENT 'Internal quality performance rating assigned to the laboratory based on accuracy, timeliness, and compliance with testing standards.',
    `state_province` STRING COMMENT 'State or province code where the laboratory facility is located.',
    `testing_capabilities` STRING COMMENT 'Comma-separated list or description of the types of tests and analyses the laboratory is equipped and certified to perform (e.g., TCLP, VOC, metals analysis, pH testing).',
    `turnaround_time_days` STRING COMMENT 'Standard number of business days required for the laboratory to complete testing and deliver results from sample receipt.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier record if the laboratory is an external contracted facility.',
    `website_url` STRING COMMENT 'Web address of the laboratorys official website for information and services.',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master reference table for laboratory. Referenced by laboratory_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`collection`.`sampling_event` (
    `sampling_event_id` BIGINT COMMENT 'Primary key for sampling_event',
    `resample_sampling_event_id` BIGINT COMMENT 'Self-referencing FK on sampling_event (resample_sampling_event_id)',
    `actual_date` DATE COMMENT 'The actual date when the sampling event was conducted. May differ from scheduled date due to operational constraints or weather conditions.',
    `actual_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sample was collected, critical for time-sensitive analysis and regulatory compliance documentation.',
    `analysis_completed_date` DATE COMMENT 'The actual date when laboratory analysis was completed.',
    `analysis_due_date` DATE COMMENT 'The date by which laboratory analysis must be completed to comply with holding time requirements.',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who reviewed and approved the sampling event documentation and results.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the sampling event was approved by the reviewing authority.',
    `chain_of_custody_number` STRING COMMENT 'Unique tracking number for the chain-of-custody documentation that accompanies the sample from collection through analysis, ensuring sample integrity and regulatory compliance.',
    `collection_route_id` BIGINT COMMENT 'Reference to the waste collection route where the sampling event occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling event record was first created in the system.',
    `duplicate_sample_collected` BOOLEAN COMMENT 'Indicates whether a duplicate sample was collected for quality control purposes.',
    `event_number` STRING COMMENT 'Business-facing unique identifier for the sampling event, used for tracking and reference in operational systems and regulatory reporting.',
    `event_status` STRING COMMENT 'Current lifecycle status of the sampling event indicating its progression through the sampling workflow.',
    `event_type` STRING COMMENT 'Classification of the sampling event based on its purpose and trigger (routine monitoring, regulatory compliance, incident investigation, customer complaint, quality assurance, or special study).',
    `facility_id` BIGINT COMMENT 'Reference to the facility (landfill, transfer station, recycling center, or waste-to-energy plant) where the sampling event took place.',
    `field_blank_collected` BOOLEAN COMMENT 'Indicates whether a field blank sample was collected to detect potential contamination during sampling.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time in hours between sample collection and analysis, as specified by the analytical method and regulatory requirements.',
    `laboratory_id` BIGINT COMMENT 'Reference to the analytical laboratory where the sample will be or was analyzed.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the sampling location in decimal degrees format.',
    `location_description` STRING COMMENT 'Detailed textual description of the specific location within the facility or route where the sample was collected (e.g., North cell active face, Transfer station tipping floor, Residential route truck #245).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the sampling location in decimal degrees format.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling event record was last modified.',
    `monitoring_point_id` STRING COMMENT 'Identifier for the specific monitoring point or well where the sample was collected, as designated in facility permits and monitoring plans.',
    `notes` STRING COMMENT 'Free-text field for recording additional observations, anomalies, or contextual information about the sampling event.',
    `permit_number` STRING COMMENT 'The permit or license number under which this sampling event is conducted, linking the sample to specific regulatory obligations.',
    `quality_control_level` STRING COMMENT 'The quality control level applied to this sampling event, indicating the rigor of QA/QC procedures (Level 1: field screening, Level 2: standard analysis, Level 3: enhanced QC, Level 4: forensic-grade).',
    `regulatory_program` STRING COMMENT 'The specific regulatory program or permit requirement that mandates this sampling event (e.g., RCRA Subtitle D, Clean Water Act NPDES, State Groundwater Monitoring).',
    `sample_matrix` STRING COMMENT 'The physical medium or material type being sampled (solid waste, leachate, groundwater, surface water, air emissions, soil, or landfill gas).',
    `sample_method` STRING COMMENT 'The standardized sampling methodology or protocol used to collect the sample (e.g., EPA Method 1311, ASTM D5092, grab sample, composite sample).',
    `sample_preservation_method` STRING COMMENT 'The preservation technique applied to the sample to maintain its integrity during transport and storage (e.g., refrigerated at 4°C, acidified with HNO3, no preservation required).',
    `sample_volume` DECIMAL(18,2) COMMENT 'The volume of the sample collected, measured in the unit specified in sample_volume_unit.',
    `sample_volume_unit` STRING COMMENT 'Unit of measure for the sample volume (milliliters, liters, gallons, cubic feet, or cubic meters).',
    `sample_weight` DECIMAL(18,2) COMMENT 'The weight of the sample collected, measured in the unit specified in sample_weight_unit. Applicable primarily for solid waste samples.',
    `sample_weight_unit` STRING COMMENT 'Unit of measure for the sample weight (grams, kilograms, pounds, or tons).',
    `sampler_certification_number` STRING COMMENT 'Professional certification or license number of the sampler, required for certain regulated sampling activities.',
    `sampler_employee_id` BIGINT COMMENT 'Reference to the employee who physically collected the sample.',
    `sampler_name` STRING COMMENT 'Full name of the individual who collected the sample, required for regulatory chain-of-custody documentation.',
    `scheduled_date` DATE COMMENT 'The planned date for conducting the sampling event.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient air temperature at the time of sampling, measured in degrees Celsius.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sampling (e.g., clear, rain, snow), which may affect sample characteristics and analysis.',
    CONSTRAINT pk_sampling_event PRIMARY KEY(`sampling_event_id`)
) COMMENT 'Master reference table for sampling_event. Referenced by sampling_event_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ADD CONSTRAINT `fk_collection_collection_stop_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_collection_stop_id` FOREIGN KEY (`collection_stop_id`) REFERENCES `waste_management_ecm`.`collection`.`collection_stop`(`collection_stop_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district` ADD CONSTRAINT `fk_collection_district_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ADD CONSTRAINT `fk_collection_compaction_measurement_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ADD CONSTRAINT `fk_collection_compaction_measurement_shift_log_id` FOREIGN KEY (`shift_log_id`) REFERENCES `waste_management_ecm`.`collection`.`shift_log`(`shift_log_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_scale_equipment_id` FOREIGN KEY (`scale_equipment_id`) REFERENCES `waste_management_ecm`.`collection`.`scale_equipment`(`scale_equipment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_collection_stop_id` FOREIGN KEY (`collection_stop_id`) REFERENCES `waste_management_ecm`.`collection`.`collection_stop`(`collection_stop_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ADD CONSTRAINT `fk_collection_container_rfid_scan_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_scale_equipment_id` FOREIGN KEY (`scale_equipment_id`) REFERENCES `waste_management_ecm`.`collection`.`scale_equipment`(`scale_equipment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_scale_equipment_id` FOREIGN KEY (`scale_equipment_id`) REFERENCES `waste_management_ecm`.`collection`.`scale_equipment`(`scale_equipment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_superseded_by_rate_tipping_fee_rate_id` FOREIGN KEY (`superseded_by_rate_tipping_fee_rate_id`) REFERENCES `waste_management_ecm`.`collection`.`tipping_fee_rate`(`tipping_fee_rate_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_destination_facility_id` FOREIGN KEY (`destination_facility_id`) REFERENCES `waste_management_ecm`.`collection`.`destination_facility`(`destination_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_hauler_account_id` FOREIGN KEY (`hauler_account_id`) REFERENCES `waste_management_ecm`.`collection`.`hauler_account`(`hauler_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_destination_facility_id` FOREIGN KEY (`destination_facility_id`) REFERENCES `waste_management_ecm`.`collection`.`destination_facility`(`destination_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_outbound_haul_id` FOREIGN KEY (`outbound_haul_id`) REFERENCES `waste_management_ecm`.`collection`.`outbound_haul`(`outbound_haul_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ADD CONSTRAINT `fk_collection_transfer_trailer_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ADD CONSTRAINT `fk_collection_scale_equipment_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ADD CONSTRAINT `fk_collection_operating_permit_superseded_permit_operating_permit_id` FOREIGN KEY (`superseded_permit_operating_permit_id`) REFERENCES `waste_management_ecm`.`collection`.`operating_permit`(`operating_permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ADD CONSTRAINT `fk_collection_operating_permit_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ADD CONSTRAINT `fk_collection_shift_log_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ADD CONSTRAINT `fk_collection_haul_rate_destination_facility_id` FOREIGN KEY (`destination_facility_id`) REFERENCES `waste_management_ecm`.`collection`.`destination_facility`(`destination_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ADD CONSTRAINT `fk_collection_haul_rate_hauler_account_id` FOREIGN KEY (`hauler_account_id`) REFERENCES `waste_management_ecm`.`collection`.`hauler_account`(`hauler_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ADD CONSTRAINT `fk_collection_haul_rate_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ADD CONSTRAINT `fk_collection_haul_rate_superseded_by_rate_haul_rate_id` FOREIGN KEY (`superseded_by_rate_haul_rate_id`) REFERENCES `waste_management_ecm`.`collection`.`haul_rate`(`haul_rate_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ADD CONSTRAINT `fk_collection_collection_environmental_monitoring_environmental_sample_id` FOREIGN KEY (`environmental_sample_id`) REFERENCES `waste_management_ecm`.`collection`.`environmental_sample`(`environmental_sample_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ADD CONSTRAINT `fk_collection_collection_environmental_monitoring_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ADD CONSTRAINT `fk_collection_hauler_authorization_hauler_account_id` FOREIGN KEY (`hauler_account_id`) REFERENCES `waste_management_ecm`.`collection`.`hauler_account`(`hauler_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ADD CONSTRAINT `fk_collection_hauler_authorization_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ADD CONSTRAINT `fk_collection_hauler_site_authorization_hauler_account_id` FOREIGN KEY (`hauler_account_id`) REFERENCES `waste_management_ecm`.`collection`.`hauler_account`(`hauler_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ADD CONSTRAINT `fk_collection_route_driver_qualification_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ADD CONSTRAINT `fk_collection_disposal_routing_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ADD CONSTRAINT `fk_collection_district_program_participation_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ADD CONSTRAINT `fk_collection_hazmat_service_schedule_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ADD CONSTRAINT `fk_collection_station_waste_code_permit_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ADD CONSTRAINT `fk_collection_facility_staffing_assignment_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ADD CONSTRAINT `fk_collection_environmental_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `waste_management_ecm`.`collection`.`laboratory`(`laboratory_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ADD CONSTRAINT `fk_collection_environmental_sample_sampling_event_id` FOREIGN KEY (`sampling_event_id`) REFERENCES `waste_management_ecm`.`collection`.`sampling_event`(`sampling_event_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ADD CONSTRAINT `fk_collection_environmental_sample_resample_environmental_sample_id` FOREIGN KEY (`resample_environmental_sample_id`) REFERENCES `waste_management_ecm`.`collection`.`environmental_sample`(`environmental_sample_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ADD CONSTRAINT `fk_collection_laboratory_parent_laboratory_id` FOREIGN KEY (`parent_laboratory_id`) REFERENCES `waste_management_ecm`.`collection`.`laboratory`(`laboratory_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`sampling_event` ADD CONSTRAINT `fk_collection_sampling_event_resample_sampling_event_id` FOREIGN KEY (`resample_sampling_event_id`) REFERENCES `waste_management_ecm`.`collection`.`sampling_event`(`sampling_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`collection` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `waste_management_ecm`.`collection` SET TAGS ('dbx_domain' = 'collection');
ALTER TABLE `waste_management_ecm`.`collection`.`route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`route` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `fuel_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Driver Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `capacity_constraint_tons` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint in Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `container_type_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Type');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `container_type_primary` SET TAGS ('dbx_value_regex' = 'cart|bin|dumpster|compactor|roll_off');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal');
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
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `sla_on_time_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Target Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Start Location Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `start_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `total_mileage` SET TAGS ('dbx_business_glossary_term' = 'Total Mileage');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `total_stops` SET TAGS ('dbx_business_glossary_term' = 'Total Stops');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `truck_type_required` SET TAGS ('dbx_business_glossary_term' = 'Truck Type Required');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `truck_type_required` SET TAGS ('dbx_value_regex' = 'ASL|FEL|REL|roll_off|compactor');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `waste_management_ecm`.`collection`.`route` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `air_emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Air Emission Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `fuel_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `inbound_load_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Load Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Disposal Facility Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `collection_stop_id` SET TAGS ('dbx_business_glossary_term' = 'Stop Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Epa Id Registration Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `access_instructions` SET TAGS ('dbx_business_glossary_term' = 'Access Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `access_instructions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `actual_service_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Service End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `actual_service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `cid_tag_identifiers` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID) Tag Identifiers');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `estimated_service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Service Duration (Minutes)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `geofence_radius_meters` SET TAGS ('dbx_business_glossary_term' = 'Geofence Radius (Meters)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `planned_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Arrival Time');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `planned_service_window_end` SET TAGS ('dbx_business_glossary_term' = 'Planned Service Window End');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `planned_service_window_start` SET TAGS ('dbx_business_glossary_term' = 'Planned Service Window Start');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `requires_backup` SET TAGS ('dbx_business_glossary_term' = 'Requires Backup');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `requires_ppe` SET TAGS ('dbx_business_glossary_term' = 'Requires Personal Protective Equipment (PPE)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `service_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Service Day of Week');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `service_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand|seasonal');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `skip_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Code');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `skip_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amcs|waste_logics|locus|manual');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `stop_number` SET TAGS ('dbx_business_glossary_term' = 'Stop Number');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_business_glossary_term' = 'Stop Status');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `stop_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|skipped|cancelled|suspended');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_business_glossary_term' = 'Stop Type');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `stop_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|temporary|special_event');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `volume_collected_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Volume Collected (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'msw|recycling|organics|c_and_d|hazardous|e_waste');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_stop` ALTER COLUMN `weight_collected_lbs` SET TAGS ('dbx_business_glossary_term' = 'Weight Collected (Pounds)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `pickup_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Event ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Identification (CID)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Truck ID');
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
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'msw|recycling|c_and_d|bulk|yard_waste|hazardous');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|ice|fog|wind');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Service Exception Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `emergency_response_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `spill_release_id` SET TAGS ('dbx_business_glossary_term' = 'Spill Release Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `primary_container_removal_driver_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `primary_container_removal_vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `primary_container_removal_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'dumpster|cart|roll-off|compactor|toter|bin');
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
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `hazwoper_training_id` SET TAGS ('dbx_business_glossary_term' = 'Hazwoper Training Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Helper ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
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
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `hos_available_drive_hours` SET TAGS ('dbx_business_glossary_term' = 'Hours-of-Service (HOS) Available Drive Hours');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `hos_available_duty_hours` SET TAGS ('dbx_business_glossary_term' = 'Hours-of-Service (HOS) Available Duty Hours');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `pre_trip_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trip Inspection Status');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `pre_trip_inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required|waived');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `pre_trip_inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trip Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type Classification');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|roll_off|recycling|hazardous');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `service_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'locus_dispatch|workday_hcm|manual_entry');
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `truck_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Assignment ID');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `fuel_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `post_trip_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Trip Inspection Status');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `post_trip_inspection_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_performed');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `post_trip_inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post-Trip Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `pre_trip_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trip Inspection Status');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `pre_trip_inspection_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_performed');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `pre_trip_inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trip Inspection Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `reassignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `route_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Route Deviation Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ALTER COLUMN `truck_type` SET TAGS ('dbx_business_glossary_term' = 'Truck Type');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Schedule ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `collection_stop_id` SET TAGS ('dbx_business_glossary_term' = 'Stop ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) ID');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `access_requirements` SET TAGS ('dbx_business_glossary_term' = 'Site Access Requirements');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `access_requirements` SET TAGS ('dbx_value_regex' = 'none|gate_code|key_required|escort_required|restricted_hours|call_ahead');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'per_service|weekly|monthly|quarterly|annual');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_quantity` SET TAGS ('dbx_business_glossary_term' = 'Container Quantity');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_size` SET TAGS ('dbx_business_glossary_term' = 'Container Size');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Container Size Unit of Measure');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_size_unit` SET TAGS ('dbx_value_regex' = 'cubic_yards|gallons|liters');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
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
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `waste_stream` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Classification');
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ALTER COLUMN `wednesday_flag` SET TAGS ('dbx_business_glossary_term' = 'Wednesday Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `route_optimization_run_id` SET TAGS ('dbx_business_glossary_term' = 'Route Optimization Run Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `carbon_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Initiative Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Decision By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `secondary_optimization_objective` SET TAGS ('dbx_business_glossary_term' = 'Secondary Optimization Objective');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `secondary_optimization_objective` SET TAGS ('dbx_value_regex' = 'minimize_miles|minimize_time|maximize_compaction|balance_workload|minimize_cost|maximize_service_quality');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `time_window_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Time Window Enforcement Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ALTER COLUMN `vehicle_capacity_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Capacity Constraint Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`district` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`district` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operations Manager ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `district_operations_manager_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Depot ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `reduction_target_id` SET TAGS ('dbx_business_glossary_term' = 'Reduction Target Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`district` ALTER COLUMN `municipality` SET TAGS ('dbx_business_glossary_term' = 'Municipality');
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
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `compaction_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Compaction Measurement Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Zone ID');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `ghg_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Ghg Emission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `shift_log_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Truck ID');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `ambient_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `anomaly_reason` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `compaction_cycles_count` SET TAGS ('dbx_business_glossary_term' = 'Compaction Cycles Count');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `compaction_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compaction Ratio');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'geotab|amcs|onboard_scale|manual|locus');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `estimated_volume_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Estimated Volume (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `gross_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `hydraulic_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Hydraulic Pressure (PSI)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `load_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Load Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_accuracy_grade` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy Grade');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_accuracy_grade` SET TAGS ('dbx_value_regex' = 'certified|calibrated|estimated|approximate');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'onboard_scale|estimated|weigh_station|manual_entry|telematics|visual_inspection');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|flagged|anomaly|under_review|rejected');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `net_payload_tons` SET TAGS ('dbx_business_glossary_term' = 'Net Payload (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `payload_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `route_segment_sequence` SET TAGS ('dbx_business_glossary_term' = 'Route Segment Sequence');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `scale_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Scale Calibration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|roll_off');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `tare_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `truck_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Truck Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `truck_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Truck Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `truck_type` SET TAGS ('dbx_business_glossary_term' = 'Truck Type');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `truck_type` SET TAGS ('dbx_value_regex' = 'ASL|FEL|REL|roll_off|transfer');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `validation_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type');
ALTER TABLE `waste_management_ecm`.`collection`.`compaction_measurement` ALTER COLUMN `waste_type` SET TAGS ('dbx_value_regex' = 'MSW|recycling|yard_waste|bulky|C&D|mixed');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `on_demand_request_id` SET TAGS ('dbx_business_glossary_term' = 'On-Demand Request ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Route ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `actual_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `additional_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Additional Fees Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `container_quantity` SET TAGS ('dbx_business_glossary_term' = 'Container Quantity');
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
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
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Target (Hours)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `diversion_record_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Truck ID');
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `waste_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Profile Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
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
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ALTER COLUMN `weight_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket Number');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `diversion_record_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Operator ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `inbound_load_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Load Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `scale_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Scale ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `disposal_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Authorization Number');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `disposal_authorization_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
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
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `service_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
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
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `tipping_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate (USD per Ton)');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `tipping_fee_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `validation_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `weigh_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-In Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ALTER COLUMN `weigh_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-Out Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `container_rfid_scan_id` SET TAGS ('dbx_business_glossary_term' = 'Container RFID (Radio Frequency Identification) Scan ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `collection_stop_id` SET TAGS ('dbx_business_glossary_term' = 'Route Stop ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Tag ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Truck ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `billing_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Eligible Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `cid` SET TAGS ('dbx_business_glossary_term' = 'CID (Container Identification Number)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `cid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `container_size_gallons` SET TAGS ('dbx_business_glossary_term' = 'Container Size (Gallons)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `container_type` SET TAGS ('dbx_business_glossary_term' = 'Container Type');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `container_type` SET TAGS ('dbx_value_regex' = 'cart|bin|dumpster|compactor|roll_off');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Accuracy (Meters)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `lift_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Lift Confirmed Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `proof_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Service Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `pto_activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PTO (Power Take-Off) Activation Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_business_glossary_term' = 'Reader Device ID');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `reader_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `reader_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Reader Firmware Version');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `reader_firmware_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `scan_date` SET TAGS ('dbx_business_glossary_term' = 'Scan Date');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `scan_result_status` SET TAGS ('dbx_business_glossary_term' = 'Scan Result Status');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `scan_result_status` SET TAGS ('dbx_value_regex' = 'successful_read|no_read|weak_signal|damaged_tag|duplicate_read|invalid_tag');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `scan_source_system` SET TAGS ('dbx_business_glossary_term' = 'Scan Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `scan_source_system` SET TAGS ('dbx_value_regex' = 'amcs_platform|geotab_telematics|locus_dispatch|mobile_app');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scan Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `scheduled_service_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Time');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|roll_off|temporary');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `service_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Variance (Minutes)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `signal_strength` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength (dBm)');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Compliance Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `source_system_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `truck_number` SET TAGS ('dbx_business_glossary_term' = 'Truck Number');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `truck_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`collection`.`container_rfid_scan` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'msw|recycling|organics|yard_waste|bulk|hazardous');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `transfer_outbound_disposal_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Outbound Disposal Facility ID');
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
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'Collection District ID');
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
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `disposal_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `diversion_record_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Operator ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `inbound_load_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Load Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `scale_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Scale ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Outbound Facility Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number');
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
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `tipping_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_characterization_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Characterization Method');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_characterization_method` SET TAGS ('dbx_value_regex' = 'visual_inspection|manifest_declaration|sampling|customer_declaration|default_profile');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `waste_origin_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin Jurisdiction');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `weigh_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-In Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ALTER COLUMN `weigh_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Weigh-Out Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `scale_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Transaction ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `diversion_record_id` SET TAGS ('dbx_business_glossary_term' = 'Diversion Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Operator ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `scale_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Scale ID');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
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
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number');
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
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `waste_stream_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Code');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ALTER COLUMN `weighmaster_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Weighmaster Certification Number');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `tipping_fee_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `superseded_by_rate_tipping_fee_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `tertiary_tipping_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `tertiary_tipping_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `tertiary_tipping_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `contamination_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Contamination Penalty Rate');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|municipal|self_haul|industrial|institutional');
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
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'MSW|C&D|special_waste|hazardous|recyclable|organics');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `outbound_haul_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `hauler_account_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Contractor ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Destination Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `actual_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Actual Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `carrier_dot_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier DOT Number');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Type');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_value_regex' = 'landfill|mrf|wte|tsdf|other');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `dispatch_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `driver_notes` SET TAGS ('dbx_business_glossary_term' = 'Driver Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `environmental_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Waste Code');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `estimated_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `estimated_fuel_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Fuel Consumption Gallons');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `estimated_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tonnage');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `generator_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Generator Signature Captured Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `haul_number` SET TAGS ('dbx_business_glossary_term' = 'Haul Number');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `haul_status` SET TAGS ('dbx_business_glossary_term' = 'Haul Status');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `haul_status` SET TAGS ('dbx_value_regex' = 'scheduled|dispatched|in_transit|delivered|rejected|cancelled');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `load_rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Load Rejection Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `rcra_classification` SET TAGS ('dbx_business_glossary_term' = 'RCRA Classification');
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
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'msw|recycling|organics|cnd|hazardous|special');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `haul_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Manifest ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `hauling_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Hauling Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `outbound_haul_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Destination Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `bol_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `carrier_dot_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Department of Transportation (DOT) Number');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
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
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code');
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
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `facility_capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Capacity Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
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
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Submission Reference');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `transfer_trailer_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Trailer ID');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `axle_count` SET TAGS ('dbx_business_glossary_term' = 'Axle Count');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `current_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Current Location Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `current_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `current_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `current_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Current Location Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `current_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `current_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `dot_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Registration Number');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `dot_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7,10}$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `gps_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Tracking Enabled Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `last_location_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Location Update Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `license_plate` SET TAGS ('dbx_business_glossary_term' = 'License Plate Number');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `next_dot_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Department of Transportation (DOT) Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `odometer_miles` SET TAGS ('dbx_business_glossary_term' = 'Odometer Reading (Miles)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|contracted');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `payload_capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Payload Capacity (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `registration_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `registration_state` SET TAGS ('dbx_business_glossary_term' = 'Registration State Code');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `registration_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'end_of_life|accident|sold|lease_end|regulatory');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `tare_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (Tons)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `tire_size` SET TAGS ('dbx_business_glossary_term' = 'Tire Size Specification');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `trailer_status` SET TAGS ('dbx_business_glossary_term' = 'Trailer Status');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `trailer_status` SET TAGS ('dbx_value_regex' = 'available|loaded|in_transit|maintenance|out_of_service|retired');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `trailer_type` SET TAGS ('dbx_business_glossary_term' = 'Trailer Type');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `trailer_type` SET TAGS ('dbx_value_regex' = 'walking_floor|end_dump|live_bottom|compactor|roll_off|open_top');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `vin` SET TAGS ('dbx_value_regex' = '^[A-HJ-NPR-Z0-9]{17}$');
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_trailer` ALTER COLUMN `volume_capacity_cubic_yards` SET TAGS ('dbx_business_glossary_term' = 'Volume Capacity (Cubic Yards)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `scale_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Equipment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `lockout_tagout_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Lockout Tagout Procedure Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `loto_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Loto Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Scale Accuracy Class');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii|class_iiii');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `calibration_authority` SET TAGS ('dbx_business_glossary_term' = 'Calibration Authority');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `camera_system_installed_flag` SET TAGS ('dbx_business_glossary_term' = 'Camera System Installed Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `capacity_tons` SET TAGS ('dbx_business_glossary_term' = 'Scale Capacity in Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `division_size_lbs` SET TAGS ('dbx_business_glossary_term' = 'Scale Division Size in Pounds (lbs)');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `environmental_protection_rating` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Rating');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `foundation_type` SET TAGS ('dbx_business_glossary_term' = 'Foundation Type');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `foundation_type` SET TAGS ('dbx_value_regex' = 'concrete_pit|above_ground|shallow_pit|modular');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `inbound_outbound_designation` SET TAGS ('dbx_business_glossary_term' = 'Inbound Outbound Designation');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `inbound_outbound_designation` SET TAGS ('dbx_value_regex' = 'inbound|outbound|bidirectional');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `indicator_model` SET TAGS ('dbx_business_glossary_term' = 'Weight Indicator Model');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `indicator_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Weight Indicator Serial Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `load_cell_count` SET TAGS ('dbx_business_glossary_term' = 'Load Cell Count');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `maintenance_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Scale Manufacturer');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scale Equipment Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `ntep_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'National Type Evaluation Program (NTEP) Certificate Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|out_of_service|decommissioned');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `platform_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Platform Length in Feet');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `platform_width_feet` SET TAGS ('dbx_business_glossary_term' = 'Platform Width in Feet');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `printer_integration_type` SET TAGS ('dbx_business_glossary_term' = 'Printer Integration Type');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `printer_integration_type` SET TAGS ('dbx_value_regex' = 'direct_serial|network|usb|none');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `remote_display_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Display Enabled Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `rfid_reader_installed_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Reader Installed Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `scale_house_location` SET TAGS ('dbx_business_glossary_term' = 'Scale House Location');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `scale_number` SET TAGS ('dbx_business_glossary_term' = 'Scale Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `scale_type` SET TAGS ('dbx_business_glossary_term' = 'Scale Type');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `scale_type` SET TAGS ('dbx_value_regex' = 'truck_scale|axle_scale|floor_scale|platform_scale|portable_scale|rail_scale');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `software_system_integration` SET TAGS ('dbx_business_glossary_term' = 'Software System Integration');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `unattended_operation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Unattended Operation Enabled Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `weighmaster_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Weighmaster Certification Status');
ALTER TABLE `waste_management_ecm`.`collection`.`scale_equipment` ALTER COLUMN `weighmaster_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|not_required|pending');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `hauler_account_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Account ID');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Generator ID');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Hauler Account Number');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Hauler Account Status');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|delinquent');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Hauler Account Type');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'contracted_hauler|municipal_hauler|self_haul|broker|third_party_contractor|private_hauler');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `approved_waste_streams` SET TAGS ('dbx_business_glossary_term' = 'Approved Waste Streams');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_state` SET TAGS ('dbx_business_glossary_term' = 'Business State');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `business_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `credit_terms` SET TAGS ('dbx_business_glossary_term' = 'Credit Terms');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `credit_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|prepay|cod');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `dot_carrier_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Carrier Number');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `dot_carrier_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `originating_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Originating Jurisdiction');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `rfid_tag_required` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'AMCS|SAP|Salesforce|Manual');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Identification Number');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Termination Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `tipping_fee_rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate Tier');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `tipping_fee_rate_tier` SET TAGS ('dbx_value_regex' = 'standard|contracted|municipal|volume_discount|spot');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_account` ALTER COLUMN `vehicle_pre_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Pre-Authorization Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `regulated_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Regulated Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `wte_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wte Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ALTER COLUMN `accepted_waste_streams` SET TAGS ('dbx_business_glossary_term' = 'Accepted Waste Streams');
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
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit ID');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `superseded_permit_operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Permit ID');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Appeal Status');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'none|pending|approved|denied|withdrawn');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `environmental_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `financial_assurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `financial_assurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Assurance Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `issuing_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|pending');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `last_modification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Permit Modification Date');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `modification_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Modification Count');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|continuous');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Regulatory Inspection Due Date');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `operating_hours_restriction` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Restriction');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions and Restrictions');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `permit_document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Permit Document Storage Path');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `permitted_annual_tonnage_limit` SET TAGS ('dbx_business_glossary_term' = 'Permitted Annual Tonnage Limit');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `permitted_daily_tonnage_limit` SET TAGS ('dbx_business_glossary_term' = 'Permitted Daily Tonnage Limit (Tons Per Day / TPD)');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `permitted_waste_types` SET TAGS ('dbx_business_glossary_term' = 'Permitted Waste Types');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `public_notice_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Due Date');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Status');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|approved|denied');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reporting Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_required');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact Email');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact Phone');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`operating_permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Violation Count');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_log_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Log Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Supervisor Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `contamination_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Contamination Incident Count');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `contamination_incident_summary` SET TAGS ('dbx_business_glossary_term' = 'Contamination Incident Summary');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `equipment_deployed` SET TAGS ('dbx_business_glossary_term' = 'Equipment Deployed');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `equipment_issues_noted` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issues Noted');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `floor_clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Floor Clearance Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `log_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Log Number');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `operational_anomaly_description` SET TAGS ('dbx_business_glossary_term' = 'Operational Anomaly Description');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `operational_anomaly_flag` SET TAGS ('dbx_business_glossary_term' = 'Operational Anomaly Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `operational_hold_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operational Hold Duration Minutes');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `operational_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Operational Hold Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `operational_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Operational Hold Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `outbound_haul_count` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul Count');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `regulatory_inspection_summary` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Summary');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `regulatory_inspector_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspector Agency');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `regulatory_inspector_visit_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspector Visit Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `safety_incident_summary` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Summary');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_handover_notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Handover Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Log Status');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|reviewed|approved');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|weekend|holiday');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `staffing_headcount` SET TAGS ('dbx_business_glossary_term' = 'Staffing Headcount');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `tipping_floor_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Tipping Floor Utilization Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `total_loads_received` SET TAGS ('dbx_business_glossary_term' = 'Total Loads Received');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `total_tonnage_processed` SET TAGS ('dbx_business_glossary_term' = 'Total Tonnage Processed');
ALTER TABLE `waste_management_ecm`.`collection`.`shift_log` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `haul_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Rate ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `destination_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `hauler_account_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Contractor ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `superseded_by_rate_haul_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `tertiary_haul_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `tertiary_haul_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `tertiary_haul_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Distance Miles');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `environmental_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `estimated_transit_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Time Minutes');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `fuel_surcharge_formula` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Formula');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `fuel_surcharge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `maximum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'per_ton|per_load|per_mile|per_hour|flat_rate|per_cubic_yard');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Name');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|superseded');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `rate_tier` SET TAGS ('dbx_value_regex' = 'spot|contracted|municipal|emergency|seasonal');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `regulatory_rate_cap` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Cap');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `toll_charges_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Toll Charges Included Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `vehicle_type_required` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Type Required');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `volume_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Rate');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `volume_discount_threshold_tons` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Threshold Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_value_regex' = 'MSW|C&D|recyclables|organics|hazardous|special_waste');
ALTER TABLE `waste_management_ecm`.`collection`.`haul_rate` ALTER COLUMN `weight_limit_tons` SET TAGS ('dbx_business_glossary_term' = 'Weight Limit Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `collection_environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Record ID');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `compliance_environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `environmental_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sample ID');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station ID');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `agency_report_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Report Submission Date');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `agency_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Agency Report Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `ambient_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `certified_lab_reference` SET TAGS ('dbx_business_glossary_term' = 'Certified Laboratory Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exceedance Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `lab_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `measured_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measured Environmental Parameter');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Date');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Equipment Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_frequency_required` SET TAGS ('dbx_business_glossary_term' = 'Required Monitoring Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_location` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Description');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Latitude');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Longitude');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Method');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Record Status');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|in_progress|cancelled|overdue');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_technician_certification` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Technician Certification');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_technician_name` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Technician Name');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_technician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Type');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `permit_condition_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Reference');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Record Number');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `regulatory_threshold` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Value');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `reported_to_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to Regulatory Agency Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions at Monitoring');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `wind_direction` SET TAGS ('dbx_business_glossary_term' = 'Wind Direction');
ALTER TABLE `waste_management_ecm`.`collection`.`collection_environmental_monitoring` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Miles Per Hour)');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` SET TAGS ('dbx_association_edges' = 'collection.hauler_account,collection.transfer_station');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `hauler_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Authorization ID');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `hauler_account_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Authorization - Hauler Account Id');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Authorization - Transfer Station Id');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `authorization_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `authorized_transfer_stations` SET TAGS ('dbx_business_glossary_term' = 'Authorized Transfer Stations');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `last_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Last Delivery Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `pre_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Authorization Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `rfid_transponder_required_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID Transponder Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `station_specific_tipping_rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Station-Specific Tipping Rate Tier');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `station_specific_waste_streams_allowed` SET TAGS ('dbx_business_glossary_term' = 'Station-Specific Waste Streams Allowed');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_authorization` ALTER COLUMN `ytd_tonnage_delivered` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date Tonnage Delivered');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` SET TAGS ('dbx_association_edges' = 'collection.hauler_account,landfill.site');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `hauler_site_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Site Authorization ID');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `hauler_account_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Site Authorization - Hauler Account Id');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Site Authorization - Site Id');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `approved_waste_streams` SET TAGS ('dbx_business_glossary_term' = 'Approved Waste Streams');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hauler Site Authorization - Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hauler Site Authorization - Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `site_specific_instructions` SET TAGS ('dbx_business_glossary_term' = 'Site Specific Instructions');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `tipping_fee_rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate Tier');
ALTER TABLE `waste_management_ecm`.`collection`.`hauler_site_authorization` ALTER COLUMN `volume_commitment_tons` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` SET TAGS ('dbx_association_edges' = 'collection.route,workforce.employee');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `route_driver_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Route Driver Qualification ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Route Driver Qualification - Employee Id');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `qualification_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Verified By Employee ID');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `qualification_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `qualification_verified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Driver Qualification - Route Id');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `last_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assignment Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `primary_backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Backup Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `qualification_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Verified Date');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `qualification_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualification Verified Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `total_assignments_count` SET TAGS ('dbx_business_glossary_term' = 'Total Assignments Count');
ALTER TABLE `waste_management_ecm`.`collection`.`route_driver_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` SET TAGS ('dbx_association_edges' = 'collection.transfer_station,landfill.site');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `disposal_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Routing Agreement Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Routing - Site Id');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Routing - Transfer Station Id');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `contracted_capacity_tpd` SET TAGS ('dbx_business_glossary_term' = 'Contracted Daily Capacity Allocation');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Routing Agreement Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `estimated_transit_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transit Time');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Routing Agreement Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `haul_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Haul Distance');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `preferred_disposal_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Disposal Site Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Agreement Status');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`disposal_routing` ALTER COLUMN `waste_stream_routing_rules` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Routing Rules');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` SET TAGS ('dbx_association_edges' = 'collection.district,sustainability.circular_economy_program');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `district_program_participation_id` SET TAGS ('dbx_business_glossary_term' = 'District Program Participation ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `circular_economy_program_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Economy Program ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Program Participation - Collection District Id');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'District Program Manager Employee ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `actual_diversion_tons` SET TAGS ('dbx_business_glossary_term' = 'Actual Diversion Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `annual_diversion_target_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Diversion Target Tons');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `customer_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Enrollment Count');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `participation_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Participation Rate Percentage');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `program_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`district_program_participation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` SET TAGS ('dbx_subdomain' = 'route_operations');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` SET TAGS ('dbx_association_edges' = 'collection.route,hazmat.hazardous_waste_generator');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `hazmat_service_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Service Schedule Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `hazardous_waste_generator_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Service Schedule - Hazardous Waste Generator Id');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Service Schedule - Route Id');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `estimated_pickup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Pickup Duration');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `manifest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manifest Required Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `next_service_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Service Date');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `scheduled_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Day');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `service_frequency` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `waste_management_ecm`.`collection`.`hazmat_service_schedule` ALTER COLUMN `waste_stream_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Type');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` SET TAGS ('dbx_association_edges' = 'collection.transfer_station,hazmat.waste_code');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `station_waste_code_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Station Waste Code Permit ID');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Waste Code Permit - Transfer Station Id');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `waste_code_id` SET TAGS ('dbx_business_glossary_term' = 'Station Waste Code Permit - Waste Code Id');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `handling_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Handling Restrictions');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `maximum_daily_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Quantity');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit Reference Number');
ALTER TABLE `waste_management_ecm`.`collection`.`station_waste_code_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` SET TAGS ('dbx_subdomain' = 'transfer_facilities');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` SET TAGS ('dbx_association_edges' = 'collection.transfer_station,workforce.employee');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `facility_staffing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Staffing Assignment ID');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Staffing Assignment - Employee Id');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Staffing Assignment - Transfer Station Id');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `certification_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Verified Date');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `primary_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Facility Flag');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Facility Role');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `waste_management_ecm`.`collection`.`facility_staffing_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ALTER COLUMN `environmental_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sample Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ALTER COLUMN `resample_environmental_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`environmental_sample` ALTER COLUMN `analysis_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `parent_laboratory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`laboratory` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`sampling_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`collection`.`sampling_event` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `waste_management_ecm`.`collection`.`sampling_event` ALTER COLUMN `sampling_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Event Identifier');
ALTER TABLE `waste_management_ecm`.`collection`.`sampling_event` ALTER COLUMN `resample_sampling_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`sampling_event` ALTER COLUMN `sampler_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`collection`.`sampling_event` ALTER COLUMN `sampler_name` SET TAGS ('dbx_pii_name' = 'true');
