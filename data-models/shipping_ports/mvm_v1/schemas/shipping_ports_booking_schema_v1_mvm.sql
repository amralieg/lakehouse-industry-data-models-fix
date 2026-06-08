-- Schema for Domain: booking | Business: Shipping Ports | Version: v1_mvm
-- Generated on: 2026-05-10 06:53:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `shipping_ports_ecm`.`booking` COMMENT 'Handles booking requests, slot reservations, vessel call appointments, service order lifecycle, and pre-arrival coordination. Manages the commercial intake process from booking to service confirmation. SSOT for service booking and appointment data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`call_booking` (
    `call_booking_id` BIGINT COMMENT 'Primary key for call_booking',
    `contact_person_id` BIGINT COMMENT 'Foreign key linking to customer.contact_person. Business justification: A specific contact person (vessel agent, shipping line rep) is responsible for a call booking and receives ETA alerts, confirmations, and invoices. Port notification workflows and CRM case management ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Vessel call operations (pilotage, towage, berth services) incur direct costs allocated to marine operations cost centres. Essential for operational cost tracking and variance analysis in port P&L repo',
    `facility_security_plan_id` BIGINT COMMENT 'Foreign key linking to security.facility_security_plan. Business justification: ISPS Code requires port to verify vessel call against the active facility security plan before confirming the booking. call_booking.isps_security_level is a snapshot; the FK enables ISPS compliance ve',
    `flag_state_id` BIGINT COMMENT 'Foreign key linking to masterdata.flag_state. Business justification: Flag state determines PSC targeting, ISPS compliance, MARPOL compliance, and sanctions screening — all referenced in call_booking. Port state control and customs clearance processes require flag state',
    `infrastructure_terminal_id` BIGINT COMMENT 'Foreign key linking to infrastructure.terminal. Business justification: A vessel call booking is made for a specific terminal. Terminal resource allocation, port dues calculation, operational scheduling, and billing are all organized at terminal level. Port community syst',
    `un_locode_id` BIGINT COMMENT 'Foreign key linking to masterdata.un_locode. Business justification: last_port_of_call field exists. FK to un_locode master enables port validation, voyage tracking, customs reporting, health declaration processing, and quarantine requirement determination for vessel c',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Call bookings are placed by shipping lines/agents under a participant_account. Port billing, credit limit checks, and account-level vessel call reporting all require this link. A maritime ops expert e',
    `port_community_participant_id` BIGINT COMMENT 'Identifier of the local shipping agent representing the shipping line for this vessel call. Responsible for pre-arrival coordination and documentation.',
    `port_dues_schedule_id` BIGINT COMMENT 'Foreign key linking to tariff.port_dues_schedule. Business justification: Port dues are assessed on every vessel call at berth. call_booking is the primary vessel call record; the port dues schedule governs the specific dues calculation for billing and regulatory reporting.',
    `port_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.port_tariff. Business justification: Vessel call bookings must reference the applicable port tariff schedule to determine vessel dues, berth charges, and service rates. Core business process: tariff application at booking confirmation an',
    `call_id` BIGINT COMMENT 'Foreign key linking to vessel.call. Business justification: Vessel call booking represents the reservation/request for a port call, must link to the actual vessel.call record for berth planning, VTS coordination, and operational execution. Port operations team',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Vessel call revenue (port dues, berth charges, service fees) is tracked by profit centre (container terminal, bulk terminal, marine services) for business unit P&L reporting and performance management',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to tariff.rate_card. Business justification: Commercial vessel calls for regular shipping line customers operate under negotiated rate cards with preferential pricing. Real business process: contracted rate application for vessel services and ca',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Vessel call bookings undergo sanctions screening of vessel, owner, operator, and flag state. Port denies entry to sanctioned vessels. ISPS and national security requirement.',
    `shipping_line_id` BIGINT COMMENT 'Identifier of the shipping line (carrier) operating the vessel for this call. Links to the customer/shipping line master record.',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to customer.sla_profile. Business justification: Port call bookings are governed by SLA profiles defining vessel turnaround time and berth productivity targets. The SLA profile drives penalty calculations and performance measurement for each call. M',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: imo_number exists on call_booking. FK to vessel_master enables vessel specification lookup for berth assignment, pilotage requirement determination, towage calculation, safety compliance verification,',
    `vessel_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_type. Business justification: Vessel type drives pilotage_required, towage_required, berth compatibility, and tariff_category_code — all referenced in call_booking. Port planners use vessel type at booking stage to determine servi',
    `voyage_nomination_id` BIGINT COMMENT 'Foreign key linking to booking.voyage_nomination. Business justification: A call_booking is formally initiated from a voyage_nomination submitted by the shipping line. Linking call_booking.voyage_nomination_id -> voyage_nomination.voyage_nomination_id establishes the upstre',
    `ata` TIMESTAMP COMMENT 'Actual timestamp when the vessel arrived at the port anchorage or pilot boarding area. Populated after arrival event occurs.',
    `atb` TIMESTAMP COMMENT 'Actual timestamp when the vessel berthed at the terminal. Populated after berthing event occurs.',
    `atd` TIMESTAMP COMMENT 'Actual timestamp when the vessel departed from the berth. Populated after departure event occurs.',
    `booking_cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel call booking was cancelled by either the shipping line or port authority.',
    `booking_confirmed_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel call booking was officially confirmed by port operations and berth allocation was finalized.',
    `booking_reference_number` STRING COMMENT 'Externally-known unique booking reference number assigned to the vessel call booking. Used for communication with shipping lines and agents.. Valid values are `^[A-Z0-9]{8,20}$`',
    `booking_status` STRING COMMENT 'Current lifecycle status of the vessel call booking. Tracks progression from initial nomination through confirmation to completion or cancellation.. Valid values are `nominated|pending|confirmed|cancelled|completed|rejected`',
    `booking_submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the vessel call booking request was initially submitted by the shipping line or agent to the port.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the vessel call booking was cancelled (e.g., schedule change, weather, operational constraints).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vessel call booking record was first created in the system.',
    `customs_clearance_status` STRING COMMENT 'Status of customs clearance process for the vessel and its cargo. Determines whether cargo operations can commence.. Valid values are `pending|cleared|inspection_required|hold`',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the vessel is carrying IMDG-classified dangerous goods requiring special handling and safety protocols.',
    `eta` TIMESTAMP COMMENT 'Estimated timestamp when the vessel is expected to arrive at the port anchorage or pilot boarding area.',
    `etb` TIMESTAMP COMMENT 'Estimated timestamp when the vessel is expected to berth at the assigned terminal.',
    `etd` TIMESTAMP COMMENT 'Estimated timestamp when the vessel is expected to depart from the berth and leave the port.',
    `expected_container_moves` STRING COMMENT 'Estimated total number of container handling moves (load + discharge) for this vessel call. Used for resource planning and berth time estimation.',
    `expected_teu` STRING COMMENT 'Estimated total TEU volume (standardized container unit) for this vessel call. Used for yard planning and capacity management.',
    `isps_security_level` STRING COMMENT 'ISPS security level applicable to the vessel call. Level 1 (normal), Level 2 (heightened), Level 3 (exceptional).. Valid values are `level_1|level_2|level_3`',
    `next_port_of_call` STRING COMMENT 'UN/LOCODE of the next port the vessel will visit after departing this port. Used for cargo planning and customs clearance.. Valid values are `^[A-Z]{5}$`',
    `pilotage_required` BOOLEAN COMMENT 'Indicates whether marine pilotage service is required for the vessel to navigate into and out of the port.',
    `reefer_container_count` STRING COMMENT 'Number of refrigerated containers requiring power supply and temperature monitoring during the vessel call.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or coordination details related to the vessel call booking.',
    `service_requirements` STRING COMMENT 'Summary of requested port services for the vessel call (e.g., pilotage, towage, mooring, bunkering, waste disposal, fresh water supply).',
    `service_rotation` STRING COMMENT 'Shipping line service route or rotation code that this vessel call is part of (e.g., Asia-Europe Express, Pacific Loop).',
    `towage_required` BOOLEAN COMMENT 'Indicates whether tug boat assistance is required for berthing and unberthing operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vessel call booking record was last modified in the system.',
    CONSTRAINT pk_call_booking PRIMARY KEY(`call_booking_id`)
) COMMENT 'Core master record for a vessel call booking request submitted by a shipping line or agent. Represents the commercial intake of a vessel visit to the port, capturing vessel identity (IMO number, vessel name), expected arrival/departure windows (ETA/ETD/ETB), requested berth, service requirements summary, voyage details (voyage number, service rotation, last/next port), booking status lifecycle (nominated, pending, confirmed, cancelled, completed), and pre-arrival coordination data. Central SSOT for all vessel call bookings — all other booking domain entities reference this record. Aligned with DCSA booking model concepts. Sourced from Port Community System (PCS) and NAVIS N4.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` (
    `booking_service_order_id` BIGINT COMMENT 'Unique identifier for the booking service order. Primary key for this entity.',
    `berth_id` BIGINT COMMENT 'Foreign key linking to infrastructure.berth. Business justification: Service orders (pilotage, towage, mooring, bunkering) are executed at specific berths. Operations teams dispatch resources and coordinate safety based on berth location. Replaces denormalized berth_co',
    `berth_reservation_id` BIGINT COMMENT 'Foreign key linking to booking.booking_berth_reservation. Business justification: Port services such as pilotage, towage, and mooring are directly tied to a specific berth reservation event. A booking_service_order for these services should reference the booking_berth_reservation i',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Service orders (pilotage, mooring, waste disposal, bunkering) are charged to specific operational cost centres for actual cost tracking, budget variance analysis, and service line profitability report',
    `customs_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_declaration. Business justification: Service orders for customs examination, scanning, or controlled goods handling are mandated by customs declarations. Port operators need to link service orders to the customs declaration that triggere',
    `customs_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_hold. Business justification: Service orders for physical examination, scanning, or fumigation are directly triggered by customs holds. Linking service orders to customs holds enables port operators to track hold-triggered service',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.import_export_permit. Business justification: Service orders for controlled goods handling (hazmat, dual-use goods, CITES species) are conditioned on valid import/export permits. Port operators must reference the permit when executing such servic',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Capital maintenance services (dredging, berth repairs, infrastructure upgrades) triggered by service requirements are tracked via internal orders for capex budget control and project cost accumulation',
    `item_id` BIGINT COMMENT 'Foreign key linking to tariff.tariff_item. Business justification: Each service order (pilotage, towage, mooring, cargo handling) must link to the specific tariff item defining its pricing structure, units, and rates. Core business process: service charge calculation',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Service orders are executed against a participants account for billing and credit control. requesting_party_name and requesting_party_contact are denormalized text fields replaced by this FK. Account',
    `port_gate_id` BIGINT COMMENT 'Foreign key linking to infrastructure.port_gate. Business justification: Service orders for gate inspection services — customs examination, ISPS security checks, OCR scanning — are performed at a specific port gate. Gate-level service billing, throughput SLA tracking, and ',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: service_location field exists. FK to port_location master enables resource dispatch routing, location-based billing rate application, operational zone validation, and equipment positioning for service',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Service orders generate billable revenue attributed to a profit centre for terminal P&L reporting. Port operators require profit centre attribution on service orders for revenue recognition, service l',
    `rate_card_line_id` BIGINT COMMENT 'Foreign key linking to tariff.rate_card_line. Business justification: Service orders under negotiated contracts reference specific rate card lines for pricing with contracted unit rates and SLA targets. Real business process: contracted service pricing and SLA complianc',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Service orders for vessels/cargo require sanctions screening before approval. Port authority validates no sanctioned entities before providing services. OFAC/UN sanctions compliance mandate.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to security.zone. Business justification: Service orders executed in ISPS-restricted security zones require zone-level security authorization distinct from the infrastructure terminal_zone. Port security managers use this link to audit servic',
    `service_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.service_code. Business justification: service_type field exists. FK to service_code master enables billing rate lookup, GL account assignment, SLA target retrieval, tariff schedule reference, and cost estimation for service order processi',
    `service_requirement_id` BIGINT COMMENT 'Foreign key linking to booking.service_requirement. Business justification: A booking_service_order is the operational fulfillment of a declared service_requirement. The service_requirement captures what the shipping line or cargo owner has requested (pilotage, towage, moorin',
    `terminal_zone_id` BIGINT COMMENT 'Foreign key linking to infrastructure.terminal_zone. Business justification: Ground services (container handling, cargo operations, equipment deployment) occur in specific terminal zones. Yard planners and equipment dispatchers require this link to allocate mobile equipment an',
    `call_booking_id` BIGINT COMMENT 'Reference to the parent vessel call booking that this service order is linked to. Establishes the relationship between the service request and the vessel visit.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to infrastructure.warehouse. Business justification: Warehouse services (storage, stuffing/stripping, inspection) are booked against specific warehouse facilities. Warehouse managers track bookings to manage capacity, schedule dock assignments, and allo',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred for the service after completion. Used for final billing and financial reconciliation.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the service execution was completed. Used for billing, performance measurement, and SLA compliance.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the service execution began. Used for operational tracking and Service Level Agreement (SLA) measurement.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this service order requires management or operational approval before confirmation. True if approval is required, False otherwise.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the service order was approved. Used for audit trail and workflow tracking.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the service order. Populated when approval_required_flag is True.',
    `assigned_crew_count` STRING COMMENT 'Number of crew members or personnel assigned to execute the service. Used for resource planning and cost allocation.',
    `cancellation_reason` STRING COMMENT 'Reason provided for cancelling the service order. Populated only when service_status is cancelled or no_show.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the service order was cancelled. Used for audit trail and cancellation fee calculation.',
    `confirmed_end_timestamp` TIMESTAMP COMMENT 'The date and time when the port confirmed the service would be completed. Represents the committed service appointment end.',
    `confirmed_start_timestamp` TIMESTAMP COMMENT 'The date and time when the port confirmed the service would begin. Represents the committed service appointment start.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this service order.. Valid values are `^[A-Z]{3}$`',
    `edi_message_reference` STRING COMMENT 'Reference to the EDI message (e.g., IFTMIN instruction message) that initiated or confirmed this service order. Used for system integration traceability.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the service execution met all environmental compliance requirements (emissions, waste handling, spill prevention). True if compliant, False if non-compliant.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated cost for the service at the time of booking. Used for budgeting and customer quotation purposes.',
    `hazardous_cargo_flag` BOOLEAN COMMENT 'Indicates whether the service involves handling or supporting hazardous cargo as defined by International Maritime Dangerous Goods (IMDG) Code. True if hazardous, False otherwise.',
    `imdg_class` STRING COMMENT 'IMDG classification of hazardous cargo involved in this service. Populated only when hazardous_cargo_flag is True.',
    `isps_security_level` STRING COMMENT 'ISPS security level in effect at the time of service execution. Influences operational procedures and access controls.. Valid values are `level_1|level_2|level_3`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service order record was last updated. Used for audit trail and change tracking.',
    `priority_level` STRING COMMENT 'Business priority assigned to the service order. Influences resource allocation and scheduling decisions.. Valid values are `urgent|high|normal|low`',
    `requested_end_timestamp` TIMESTAMP COMMENT 'The date and time when the customer or vessel agent requested the service to be completed. Defines the requested service window end.',
    `requested_start_timestamp` TIMESTAMP COMMENT 'The date and time when the customer or vessel agent requested the service to begin. Represents the initial service window request.',
    `service_order_number` STRING COMMENT 'Externally visible unique business identifier for the service order. Used for customer communication and operational tracking.. Valid values are `^SO-[0-9]{8}$`',
    `service_quantity` DECIMAL(18,2) COMMENT 'Quantitative measure of the service being provided. Unit depends on service type (e.g., cubic meters for bunkering, hours for pilotage, number of containers for stevedoring).',
    `service_status` STRING COMMENT 'Current lifecycle status of the service order. Tracks the progression from initial request through to completion or cancellation. [ENUM-REF-CANDIDATE: requested|confirmed|scheduled|in_progress|completed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `service_unit_of_measure` STRING COMMENT 'Unit of measure for the service quantity. Defines how the service is quantified for billing and operational tracking. [ENUM-REF-CANDIDATE: hours|cubic_meters|metric_tons|teu|feu|moves|trips|units — 8 candidates stripped; promote to reference product]',
    `sla_actual_completion_minutes` STRING COMMENT 'The actual time in minutes taken to complete the service from the confirmed start time. Used for SLA compliance measurement.',
    `sla_actual_response_minutes` STRING COMMENT 'The actual time in minutes taken to respond to and confirm the service request. Used for SLA compliance measurement.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the service order met all SLA commitments (response time and completion time). True if compliant, False if breached.',
    `sla_target_completion_minutes` STRING COMMENT 'The contractual target time in minutes for the service to be completed from the confirmed start time. Part of the SLA commitment.',
    `sla_target_response_minutes` STRING COMMENT 'The contractual target time in minutes for the port to respond to and confirm the service request. Part of the SLA commitment.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this service order record. Used for data lineage and integration troubleshooting.. Valid values are `NAVIS_N4|VTMS|PCS|MANUAL`',
    `special_instructions` STRING COMMENT 'Free-text field for any special instructions, requirements, or notes related to the service execution. Used for operational coordination.',
    CONSTRAINT pk_booking_service_order PRIMARY KEY(`booking_service_order_id`)
) COMMENT 'Transactional record for a specific port service request (pilotage, towage, mooring, stevedoring, crane allocation, bunkering, fresh water, waste reception) linked to a vessel call booking. Captures service type, requested and confirmed time windows, assigned resources/crew, service status lifecycle (requested, confirmed, scheduled, in-progress, completed, cancelled, no-show), priority, SLA parameters, and actual execution timestamps. Consolidates both the service request and the confirmed appointment into a single lifecycle entity — there is no separate appointment record. Aligned with SMDG port service message standards. Sourced from NAVIS N4 and VTMS.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` (
    `berth_reservation_id` BIGINT COMMENT 'Unique identifier for the berth reservation record. Primary key for the berth reservation entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Berth operations are subject to compliance audits (ISPS, safety, environmental). Audit records link to specific berth reservations for evidence trail. Regulatory audit requirement.',
    `berth_id` BIGINT COMMENT 'Reference to the physical berth asset allocated for this reservation. Identifies the specific berth location within the terminal.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Berth operations costs (utilities, maintenance, labor, equipment) are allocated to berth-specific cost centres for berth utilization profitability analysis and operational cost control.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Berth reservations for special operations (heavy-lift, project cargo, inaugural calls) are tracked against internal orders for CAPEX project cost control. Port finance requires this link to settle ber',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Berth reservations incur wharfage charges based on vessel GRT, LOA, and berth occupancy duration. Port authorities must link invoices to berth reservations for tariff calculation, berth utilization bi',
    `isps_facility_record_id` BIGINT COMMENT 'Foreign key linking to compliance.isps_facility_record. Business justification: Berth reservations validate ISPS security level compatibility between vessel and berth facility. Declaration of Security (DoS) required when security levels differ. ISPS Code mandatory protocol.',
    `marsec_level_change_id` BIGINT COMMENT 'Foreign key linking to security.marsec_level_change. Business justification: Berth reservation security requirements (isps_security_level on the record) are driven by the active MARSEC level change at time of reservation. This FK enables ISPS compliance auditing — port securit',
    `mooring_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.mooring_tariff. Business justification: Berth reservations include mooring services - link to mooring tariff for gang size and time-based charges. Real business process: mooring service charge calculation and gang allocation.',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Berth reservations are made by shipping lines or agents under their participant_account. Berth hire charges, priority allocation, and account-level berth utilisation reporting require this link. No ex',
    `pilotage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.pilotage_tariff. Business justification: Berth reservations requiring pilotage services must reference pilotage tariff for cost calculation based on vessel LOA, GRT, port zone, and time of day. Real business process: pilotage charge estimati',
    `port_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.port_tariff. Business justification: Berth reservations require tariff reference to calculate berth occupancy charges based on vessel LOA, GRT, berth duration, and applicable tariff schedule. Real business process: berth pricing and reve',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Berth reservations generate wharfage and berth hire revenue attributed to a profit centre for terminal P&L reporting. Port operators segment berth revenue by terminal profit centre; this link is requi',
    `quay_wall_id` BIGINT COMMENT 'Foreign key linking to infrastructure.quay_wall. Business justification: Berth reservations must reference the quay wall section for structural load planning, mooring configuration, and crane rail assignment. Port planners allocate quay wall capacity across concurrent rese',
    `towage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.towage_tariff. Business justification: Berth reservations requiring towage must link to towage tariff based on vessel size, number of tugs required, and port zone. Real business process: towage charge estimation and tug resource planning.',
    `call_booking_id` BIGINT COMMENT 'Foreign key linking to booking.call_booking. Business justification: Berth reservations are created as part of vessel call bookings - they represent the physical berth slot allocation for a commercial booking. berth_reservation currently links to vessel_call_id (cross-',
    `call_id` BIGINT COMMENT 'Reference to the vessel call booking that this berth reservation is associated with. Links the berth slot to the broader vessel visit.',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: Berth reservations require vessel master data (LOA, beam, draft, DWT) for berth compatibility validation. Port planners must verify vessel dimensions against berth constraints at reservation time. A d',
    `vessel_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_type. Business justification: Vessel type determines berth compatibility (crane type, fender requirements, STS capability) and mooring gang size. Port planners use vessel type to assign correct berth and equipment. booking_berth_r',
    `weather_tide_window_id` BIGINT COMMENT 'Foreign key linking to marine.weather_tide_window. Business justification: Berth reservations have weather_restriction_flag and tidal_window_required fields that are governed by specific weather/tide windows. Port planners reference weather_tide_window records for go/no-go b',
    `zone_id` BIGINT COMMENT 'Foreign key linking to security.security_zone. Business justification: Berths are located within designated security zones. Access control enforcement, patrol routing, CCTV coverage, and MARSEC-level measures depend on knowing which security zone the berth occupies. Esse',
    `atb` TIMESTAMP COMMENT 'Actual timestamp when the vessel completed berthing and mooring operations. Recorded for performance measurement and billing purposes.',
    `atd` TIMESTAMP COMMENT 'Actual timestamp when the vessel departed the berth and the berth slot was released. Recorded for performance measurement and billing purposes.',
    `beam_meters` DECIMAL(18,2) COMMENT 'Maximum width of the vessel at its widest point in meters. Used to validate berth width constraints and safe maneuvering clearances.',
    `berth_side` STRING COMMENT 'Indicates which side of the vessel will be positioned alongside the berth face. Critical for crane positioning and cargo handling planning.. Valid values are `port|starboard|alongside`',
    `berth_utilization_hours` DECIMAL(18,2) COMMENT 'Planned duration in hours that the berth will be occupied by this vessel. Calculated from ETB to ETD for capacity planning and billing purposes.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the berth reservation was cancelled. Captures business context for cancelled bookings for analysis and dispute resolution.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the berth reservation was cancelled. Used for berth slot release and capacity reallocation.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Timestamp when the berth reservation status was changed to confirmed. Marks the point when the berth slot became a firm commitment.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the vessel is carrying IMDG-classified dangerous goods requiring special berth allocation and safety protocols. True if dangerous cargo is present.',
    `draft_meters` DECIMAL(18,2) COMMENT 'Vertical distance between the waterline and the bottom of the vessel hull in meters. Critical for under-keel clearance calculations.',
    `dwt_tonnes` DECIMAL(18,2) COMMENT 'Total weight capacity of the vessel including cargo, fuel, water, stores, and crew in metric tonnes. Used for berth load capacity validation.',
    `etb` TIMESTAMP COMMENT 'Planned timestamp when the vessel is expected to berth and commence mooring operations. Used for berth slot planning and resource allocation.',
    `etd` TIMESTAMP COMMENT 'Planned timestamp when the vessel is expected to complete cargo operations and depart the berth. Used for berth slot release planning.',
    `expected_teu_volume` STRING COMMENT 'Anticipated number of TEU containers to be handled during this berth visit. Used for resource planning and berth productivity forecasting.',
    `high_tide_time` TIMESTAMP COMMENT 'Timestamp of the next high tide event relevant to this berth reservation. Used for tidal window planning when vessel draft requires maximum water depth.',
    `imdg_class` STRING COMMENT 'IMDG classification code for dangerous goods carried by the vessel. Determines berth safety zone requirements and segregation rules.',
    `isps_security_level` STRING COMMENT 'ISPS security level applicable to this berth reservation. Determines security protocols and access controls during the vessel visit.. Valid values are `level_1|level_2|level_3`',
    `loa_meters` DECIMAL(18,2) COMMENT 'Maximum length of the vessel from bow to stern in meters. Used to validate berth length capacity and ensure adequate berth space allocation.',
    `low_tide_time` TIMESTAMP COMMENT 'Timestamp of the next low tide event relevant to this berth reservation. Used to validate minimum under-keel clearance during the berthing period.',
    `mooring_gang_size` STRING COMMENT 'Number of mooring personnel required for line handling operations during berthing and unberthing. Based on vessel size and mooring configuration.',
    `number_of_tugs` STRING COMMENT 'Number of tugboats required to assist with berthing and unberthing operations. Determined by vessel size, weather conditions, and port regulations.',
    `pilotage_required` BOOLEAN COMMENT 'Indicates whether marine pilotage services are mandatory for this vessel berthing operation based on vessel size, cargo type, or port regulations. True if pilot is required.',
    `planning_source` STRING COMMENT 'Identifies the system or module that created or last updated this berth reservation. Tracks data lineage for berth planning decisions.. Valid values are `NAVIS_N4|TOPS_EXPERT|VTMS|MANUAL`',
    `priority_level` STRING COMMENT 'Business priority assigned to this berth reservation. Influences berth allocation decisions during conflicts or capacity constraints.. Valid values are `urgent|high|normal|low`',
    `remarks` STRING COMMENT 'General free-text notes and comments related to this berth reservation. Used for operational coordination and information sharing among port stakeholders.',
    `reservation_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this berth reservation record was first created in the system. Used for audit trail and booking lead time analysis.',
    `reservation_number` STRING COMMENT 'Human-readable unique business identifier for the berth reservation. Used for external communication and tracking. Format: BR followed by 10 digits.. Valid values are `^BR[0-9]{10}$`',
    `reservation_status` STRING COMMENT 'Current lifecycle status of the berth reservation. Tracks progression from initial booking through vessel departure or cancellation.. Valid values are `tentative|confirmed|occupied|departed|cancelled|no_show`',
    `reservation_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this berth reservation record was last modified. Tracks changes to berth allocation, timing, or status throughout the booking lifecycle.',
    `service_type` STRING COMMENT 'Type of cargo service or vessel operation associated with this berth reservation. Determines required berth facilities and handling equipment.. Valid values are `container|bulk|roro|general_cargo|tanker|cruise`',
    `special_requirements` STRING COMMENT 'Free-text field capturing any special handling, equipment, or operational requirements for this berth reservation. Examples include reefer power, fresh water supply, or security protocols.',
    `tidal_window_required` BOOLEAN COMMENT 'Indicates whether the vessel requires specific tidal conditions for safe berthing or departure due to draft constraints. True if tidal window planning is mandatory.',
    `towage_required` BOOLEAN COMMENT 'Indicates whether tugboat assistance is required for safe berthing or unberthing operations. True if towage services are needed.',
    `under_keel_clearance_meters` DECIMAL(18,2) COMMENT 'Minimum required clearance between the vessel keel and the seabed in meters. Ensures safe navigation and berthing operations considering tidal variations.',
    `weather_restriction_flag` BOOLEAN COMMENT 'Indicates whether this berth reservation is subject to weather-related operational restrictions. True if weather conditions may impact berthing operations.',
    CONSTRAINT pk_berth_reservation PRIMARY KEY(`berth_reservation_id`)
) COMMENT 'Transactional record capturing a berth slot reservation linked to a vessel call booking. Stores the assigned berth identifier, planned and actual berthing/unberthing timestamps (ETB/ATB/ETD/ATD), berth face allocation (port/starboard side-to), LOA and DWT constraints, beam restrictions, tidal window requirements, under-keel clearance parameters, reservation status (tentative, confirmed, occupied, departed, cancelled), and planning source (TOPS Expert or NAVIS N4 berth planner). SSOT for berth slot assignments within the booking lifecycle. Aligned with SMDG berth allocation message standards.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` (
    `cargo_booking_id` BIGINT COMMENT 'Unique identifier for the cargo booking record. Primary key for the cargo booking entity.',
    `cargo_category_id` BIGINT COMMENT 'Foreign key linking to masterdata.cargo_category. Business justification: Cargo category drives tariff group, storage area type, handling method, equipment assignment, and demurrage/detention rules — all cargo_category attributes. The plain-text cargo_type on cargo_booking ',
    `commodity_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.commodity_code. Business justification: hs_code field exists on cargo_booking. FK to commodity_code master enables tariff calculation, customs validation, handling method lookup, storage area assignment, and IMDG compliance checking for car',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to compliance.hs_code. Business justification: Cargo bookings must reference HS codes for tariff classification, duty calculation, and restricted goods screening. HS code column is denormalized lookup. Regulatory requirement for customs processing',
    `contact_person_id` BIGINT COMMENT 'Foreign key linking to customer.contact_person. Business justification: Cargo bookings have a nominated contact person for handling instructions, dangerous goods notifications, and delivery order coordination. CRM integration and operational communication workflows requir',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Cargo bookings generate direct port handling costs (stevedoring, storage, THC) that must be assigned to a cost centre for operational P&L reporting. Port finance teams require cost centre attribution ',
    `demurrage_schedule_id` BIGINT COMMENT 'Foreign key linking to tariff.demurrage_schedule. Business justification: Demurrage is calculated against the cargo booking when containers exceed free time at the terminal. The demurrage schedule governs tiered daily rates and free time days. Maritime experts expect cargo_',
    `detention_schedule_id` BIGINT COMMENT 'Foreign key linking to tariff.detention_schedule. Business justification: Detention charges accrue when containers are kept outside the port beyond free time. The detention schedule governs tiered rates applicable to the cargo booking. Maritime experts expect cargo_booking ',
    `free_time_allowance_id` BIGINT COMMENT 'Foreign key linking to tariff.free_time_allowance. Business justification: Free time allowance determines the grace period before demurrage and detention charges activate on a cargo booking. Maritime experts expect cargo_booking to reference the applicable free time allowanc',
    `imdg_class_id` BIGINT COMMENT 'Foreign key linking to masterdata.imdg_class. Business justification: imdg_class field exists. FK to imdg_class master enables segregation rule enforcement, stowage requirement lookup, handling procedure retrieval, EMS code reference, and SOLAS/MARPOL compliance checkin',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.import_export_permit. Business justification: Cargo bookings for controlled/restricted goods require valid import/export permits. Port operators must verify permit validity before accepting cargo. This is a mandatory regulatory compliance check i',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Project cargo, OOG, or special-handling cargo bookings are tracked against internal orders for CAPEX/OPEX project accounting. Port finance teams link cargo revenue and handling costs to internal order',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Cargo bookings generate container handling, storage, and lift-on/lift-off charges. Terminal operators must link invoices to cargo bookings for accurate billing of THC (Terminal Handling Charges), demu',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.container_type. Business justification: container_size_type field exists. FK to container_type master enables TEU calculation, handling equipment selection, yard block allocation, weight limit validation, and reefer capability checking for ',
    `shipping_line_id` BIGINT COMMENT 'Reference to the shipping line or slot operator who has allocated vessel capacity for this cargo booking.',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Cargo bookings are made against a participant_account governing payment terms, credit utilisation, and tariff schedule. Account-level cargo volume reporting and credit control depend on this link. No ',
    `un_locode_id` BIGINT COMMENT 'Foreign key linking to masterdata.un_locode. Business justification: pol_code field exists. FK to un_locode master enables port of loading validation, origin country identification, routing verification, customs origin documentation, and freight rate zone determination',
    `port_community_participant_id` BIGINT COMMENT 'Reference to the shipper (consignor) party responsible for sending the cargo. Links to customer or stakeholder master data.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Cargo handling revenue (container moves, stevedoring, storage) is tracked by profit centre (container terminal, transshipment hub, bulk terminal) for terminal P&L reporting and business segment perfor',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to tariff.rate_card. Business justification: Cargo bookings for regular customers reference negotiated rate cards for container handling charges (THC, wharfage, storage). Real business process: preferential cargo handling rate application and bi',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Cargo bookings involve shippers, consignees, and notify parties that must be screened against sanctions lists before cargo acceptance. This is a mandatory AML/sanctions compliance step in maritime-log',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to customer.sla_profile. Business justification: Cargo bookings for major shipping lines are governed by SLA profiles specifying crane moves per hour and dwell time targets. Linking cargo_booking to sla_profile enables automated SLA breach detection',
    `storage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.storage_tariff. Business justification: Cargo bookings need storage tariff reference for calculating free storage days and tiered storage charges on containers based on dwell time. Real business process: demurrage/storage billing and free t',
    `terminal_zone_id` BIGINT COMMENT 'Foreign key linking to infrastructure.terminal_zone. Business justification: Import/export cargo bookings specify the terminal zone for container delivery or pickup. This drives yard planning, gate appointment systems, and customs clearance workflows. Essential for container y',
    `tertiary_cargo_notify_party_port_community_participant_id` BIGINT COMMENT 'Reference to the party to be notified upon cargo arrival. May be freight forwarder, customs broker, or consignee representative.',
    `tertiary_quaternary_cargo_freight_forwarder_port_community_participant_id` BIGINT COMMENT 'Reference to the freight forwarder or logistics provider coordinating the cargo movement on behalf of shipper.',
    `thc_schedule_id` BIGINT COMMENT 'Foreign key linking to tariff.thc_schedule. Business justification: Terminal handling charges are fundamental to cargo booking pricing - direct link to applicable THC schedule based on container type, size, cargo category, and movement type. Core business process: THC',
    `trade_restriction_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_restriction. Business justification: Cargo bookings for specific commodities or trade lanes may be subject to active trade restrictions (embargoes, sanctions regimes). Port operators must link cargo bookings to applicable trade restricti',
    `call_booking_id` BIGINT COMMENT 'Foreign key linking to booking.call_booking. Business justification: Cargo bookings are made against vessel call bookings - cargo is booked on a specific vessel voyage that has been commercially booked with the port. cargo_booking currently links to vessel_call_id (cro',
    `call_id` BIGINT COMMENT 'Reference to the vessel call against which this cargo is booked. Links cargo to specific vessel voyage and port call.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to infrastructure.warehouse. Business justification: Break-bulk, LCL, and bonded cargo bookings are assigned to a specific warehouse for storage planning, customs dwell management, and temperature-controlled cargo handling. Port logistics operators trac',
    `wharfage_schedule_id` BIGINT COMMENT 'Foreign key linking to tariff.wharfage_schedule. Business justification: Wharfage (cargo dues) must be calculated per cargo booking based on commodity type, weight, and applicable wharfage schedule. Real business process: wharfage charge calculation and regulatory complian',
    `actual_arrival_date` DATE COMMENT 'Actual date when the cargo arrived at the port of discharge. Used for demurrage calculation and performance tracking.',
    `booking_confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the booking was confirmed by the terminal operator or shipping line.',
    `booking_date` DATE COMMENT 'Date when the cargo booking was initially created or requested by the customer.',
    `booking_number` STRING COMMENT 'Externally-known unique booking reference number issued to customer. Used for tracking and communication across stakeholders.. Valid values are `^[A-Z0-9]{8,20}$`',
    `booking_status` STRING COMMENT 'Current lifecycle status of the cargo booking. Tracks progression from initial request through completion or cancellation.. Valid values are `draft|confirmed|amended|cancelled|completed|no_show`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo booking record was first created in the system. Audit trail for data lineage.',
    `delivery_order_number` STRING COMMENT 'Delivery order number authorizing release of cargo to consignee or designated party. Required for cargo pickup.. Valid values are `^[A-Z0-9]{6,20}$`',
    `estimated_arrival_date` DATE COMMENT 'Estimated date when the cargo will arrive at the port of discharge. Used for planning and customer notification.',
    `feu_count` DECIMAL(18,2) COMMENT 'Number of Forty-foot Equivalent Units for this cargo booking. Alternative measure of container capacity.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo including packaging and container tare weight, measured in kilograms.',
    `handling_instructions` STRING COMMENT 'Special handling instructions or operational notes for terminal operators. May include stacking restrictions, priority handling, or safety precautions.',
    `is_dangerous_goods` BOOLEAN COMMENT 'Indicates whether the cargo contains dangerous goods requiring special handling and compliance with IMDG Code.',
    `is_oversized` BOOLEAN COMMENT 'Indicates whether cargo exceeds standard container dimensions requiring special handling equipment or stowage planning.',
    `is_overweight` BOOLEAN COMMENT 'Indicates whether cargo exceeds standard weight limits requiring heavy-duty handling equipment or special permits.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the cargo requires temperature-controlled (reefer) container with active refrigeration or heating.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cargo booking record was last updated. Audit trail for change tracking and data quality.',
    `payment_terms` STRING COMMENT 'Payment responsibility terms for freight and terminal handling charges. Prepaid (shipper pays), collect (consignee pays), or third-party.. Valid values are `prepaid|collect|third_party`',
    `pod_code` STRING COMMENT 'UN/LOCODE 5-character code for the port where cargo is discharged from the vessel.. Valid values are `^[A-Z]{5}$`',
    `service_type` STRING COMMENT 'Type of port service requested for this cargo booking. Determines operational workflow and billing.. Valid values are `import|export|transshipment|empty_return`',
    `source_system` STRING COMMENT 'Operational system of record that originated this cargo booking data. Used for data lineage and reconciliation.. Valid values are `NAVIS_N4|PCS|TOPS|MANUAL`',
    `stowage_position` STRING COMMENT 'Six-digit stowage position code from BAPLIE message. Format: BBRRTT (Bay-Row-Tier) indicating container location on vessel.. Valid values are `^[0-9]{6}$`',
    `temperature_setpoint_celsius` DECIMAL(18,2) COMMENT 'Target temperature setpoint for reefer cargo in degrees Celsius. Critical for perishable goods and pharmaceuticals.',
    `teu_count` DECIMAL(18,2) COMMENT 'Number of Twenty-foot Equivalent Units for this cargo booking. Standard measure of container capacity.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying dangerous goods substance. Required for IMDG compliance and safety documentation.. Valid values are `^UN[0-9]{4}$`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the cargo measured in cubic meters. Critical for LCL and breakbulk cargo planning.',
    CONSTRAINT pk_cargo_booking PRIMARY KEY(`cargo_booking_id`)
) COMMENT 'Master record for cargo booked against a vessel call, consolidating commercial booking, slot allocation, and pre-arrival manifest declaration into a single cargo-level SSOT. Captures BOL reference, cargo type (FCL/LCL/RoRo/LoLo/bulk), commodity/HS Code, TEU/FEU count, gross weight, POL/POD, shipper/consignee references, IMDG DG class, temperature-controlled flag, stowage position (bay-row-tier from BAPLIE), manifest reference, customs entry status, and booking confirmation status. Aligned with DCSA transport document and UN/EDIFACT IFTMBF booking message standards. Sourced from PCS and NAVIS N4.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` (
    `slot_reservation_id` BIGINT COMMENT 'Unique identifier for the container slot reservation record. Primary key.',
    `cargo_booking_id` BIGINT COMMENT 'Reference to the parent cargo booking for which this slot is reserved. Links the physical slot allocation to the commercial booking contract.',
    `container_id` BIGINT COMMENT 'Foreign key linking to cargo.container. Business justification: Slot reservations allocate specific containers in vessel stowage - direct operational link for slot management, container tracking, and load planning. Slot allocation systems require container_id for ',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.container_type. Business justification: Slot reservations are for specific container types — reefer, OOG, standard — which determine stowage position, equipment requirements, and slot allocation rules. Vessel planners use container type for',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Slot reservation fees and associated container handling costs must be assigned to a cost centre for container terminal cost reporting. Port finance teams track slot revenue and costs by cost centre fo',
    `imdg_class_id` BIGINT COMMENT 'Foreign key linking to masterdata.imdg_class. Business justification: hazmat_class field exists. FK to imdg_class master enables stowage compatibility checking, segregation table enforcement, bay planning validation, and special handling instruction retrieval for hazard',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Slot reservations are made by shipping lines under their participant_account. Slot charges, credit utilisation, and account-level slot allocation reporting require this link. No existing FK to partici',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Slot reservation fees are a distinct container terminal revenue stream attributed to a profit centre for P&L reporting. Port operators require profit centre attribution on slot reservations for revenu',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to tariff.rate_card. Business justification: Slot reservations for regular shipping line customers reference negotiated slot rates and volume commitments in rate cards. Real business process: slot pricing under service contracts and volume commi',
    `shipping_line_id` BIGINT COMMENT 'Foreign key linking to masterdata.shipping_line. Business justification: Slot reservations are made by shipping lines; slot allocation priority, commercial agreements, and EDI COPRAR messages are shipping-line-specific. The plain-text shipping_line_code is a denormalized r',
    `terminal_zone_id` BIGINT COMMENT 'Foreign key linking to infrastructure.terminal_zone. Business justification: Slot reservations map containers to a terminal yard zone for pre-loading staging and post-discharge placement. Terminal planners use zone-level slot allocation for reefer plug management, hazmat segre',
    `call_id` BIGINT COMMENT 'Reference to the specific vessel call on which this slot is reserved. Identifies the voyage and port call for the container stowage.',
    `allocation_priority` STRING COMMENT 'Priority ranking for slot allocation when multiple bookings compete for limited space. Lower numbers indicate higher priority. Typically based on booking time, customer tier, contract terms, or cargo urgency. Used by auto-allocation algorithms.',
    `allocation_source` STRING COMMENT 'Origin of the slot allocation decision. Shipping Line Nomination: slot requested by carrier. Terminal Allocation: terminal assigned slot based on operational optimization. Auto Allocation: system-generated based on rules. Manual Override: planner manually assigned slot. Tracks allocation authority and negotiation outcome.. Valid values are `shipping_line_nomination|terminal_allocation|auto_allocation|manual_override`',
    `bay_position` STRING COMMENT 'Longitudinal bay number on the vessel where the container is stowed. Part of the BAPLIE stowage coordinate system (bay-row-tier). Odd numbers typically indicate 20ft bays, even numbers indicate 40ft bays.',
    `cancelled_at` TIMESTAMP COMMENT 'Date and time when the slot reservation was cancelled. Null if not cancelled. Cancellation releases the slot back to available inventory and may trigger rebooking or penalty assessment.',
    `confirmed_at` TIMESTAMP COMMENT 'Date and time when the shipping line confirmed the slot reservation. Null if not yet confirmed. Confirmation locks the slot and triggers downstream gate and yard planning processes.',
    `created_at` TIMESTAMP COMMENT 'System timestamp when this slot reservation record was first created in the terminal operating system. Used for audit trail and data lineage tracking.',
    `created_by_user` STRING COMMENT 'User ID or system account that created this slot reservation record. Used for audit trail, accountability, and operational quality tracking.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the unconfirmed reservation will automatically expire and be released. Typically set based on terminal policy (e.g., 24-48 hours from reservation). Null for confirmed reservations.',
    `final_destination` STRING COMMENT 'UN/LOCODE of the ultimate destination for the cargo, which may differ from port of discharge if transshipment or inland transport is involved. Used for end-to-end supply chain visibility.',
    `oversize_indicator` STRING COMMENT 'Indicates whether the cargo exceeds standard container dimensions. Standard: fits within ISO container envelope. Out of Gauge: exceeds one or more dimensions. Over Height: exceeds standard height. Over Width: exceeds standard width. Over Length: exceeds standard length. OOG cargo requires special stowage planning and may incur surcharges.. Valid values are `standard|out_of_gauge|over_height|over_width|over_length`',
    `port_of_discharge` STRING COMMENT 'UN/LOCODE of the port where the container will be discharged from the vessel. Five-character code. Determines discharge sequence planning and onward transport coordination.',
    `port_of_loading` STRING COMMENT 'UN/LOCODE of the port where the container will be loaded onto the vessel. Five-character code (2-letter country + 3-letter location). Used for routing, customs, and manifest generation.',
    `reefer_required` BOOLEAN COMMENT 'Indicates whether this slot requires a reefer plug connection for refrigerated container power supply. True for temperature-controlled cargo requiring continuous power during voyage.',
    `reefer_temperature_celsius` DECIMAL(18,2) COMMENT 'Required temperature setting in degrees Celsius for refrigerated containers. Null for non-reefer slots. Typical range: -30°C to +30°C. Critical for perishable cargo integrity.',
    `reservation_number` STRING COMMENT 'Business-facing unique identifier for the slot reservation, used in communications with shipping lines and customers. May follow terminal-specific numbering convention.',
    `reservation_status` STRING COMMENT 'Current lifecycle status of the slot reservation. Reserved: initial allocation pending confirmation. Confirmed: shipping line has confirmed the slot. Cancelled: reservation voided before use. Substituted: replaced by another slot. Released: slot returned to available pool. Expired: reservation lapsed without confirmation. No Show: container did not arrive for loading. [ENUM-REF-CANDIDATE: reserved|confirmed|cancelled|substituted|released|expired|no_show — 7 candidates stripped; promote to reference product]',
    `reserved_at` TIMESTAMP COMMENT 'Date and time when the slot was initially reserved. Marks the start of the reservation lifecycle. Used for reservation expiry calculations and slot utilization analytics.',
    `restow_indicator` BOOLEAN COMMENT 'Indicates whether this container requires restowing (shifting) during the voyage or at an intermediate port to access containers beneath it. True for containers that will be temporarily moved and re-stowed. Impacts operational cost and vessel schedule.',
    `row_position` STRING COMMENT 'Transverse row number on the vessel where the container is stowed. Part of the BAPLIE stowage coordinate system. Odd numbers port side, even numbers starboard side, with 00 at centerline.',
    `seal_number` STRING COMMENT 'Unique seal number applied to the container door to ensure cargo integrity and detect tampering. Recorded at stuffing and verified at unstuffing. Required for customs and security compliance (ISPS, C-TPAT).',
    `slot_rate_amount` DECIMAL(18,2) COMMENT 'Commercial rate charged for this slot reservation. May be per TEU, per container, or per booking depending on tariff structure. Null if slot is allocated under volume contract without per-slot pricing. Used for revenue recognition and billing.',
    `slot_rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the slot rate amount. Examples: USD, EUR, GBP. Null if slot_rate_amount is null.',
    `slot_type` STRING COMMENT 'Physical container type and size for which the slot is allocated. Determines TEU/FEU calculation, stowage constraints, and handling requirements. Standard: dry cargo. High Cube: 9ft 6in height. Reefer: refrigerated. Open Top: removable roof. Flat Rack: collapsible sides. Tank: liquid cargo. Platform: flat base only. [ENUM-REF-CANDIDATE: standard_20|standard_40|high_cube_40|high_cube_45|reefer_20|reefer_40|open_top_20|open_top_40|flat_rack_20|flat_rack_40|tank_20|platform_20|platform_40 — 13 candidates stripped; promote to reference product]',
    `special_handling_instructions` STRING COMMENT 'Free-text field for special stowage, handling, or operational instructions for this slot. Examples: Keep away from heat sources, Load last for priority discharge, Requires customs inspection. Used by vessel planners and stevedores.',
    `stowage_location` STRING COMMENT 'General stowage area classification on the vessel. Below Deck: in cargo holds. On Deck: above deck stacked. Hatch Cover: on top of cargo hold covers. Affects cargo safety, insurance, and handling sequence.. Valid values are `below_deck|on_deck|hatch_cover`',
    `teu_count` DECIMAL(18,2) COMMENT 'TEU equivalent of this slot reservation. 20ft containers = 1.0 TEU, 40ft containers = 2.0 TEU, 45ft containers = 2.25 TEU. Used for vessel capacity planning and terminal throughput metrics.',
    `tier_position` STRING COMMENT 'Vertical tier number on the vessel where the container is stowed. Part of the BAPLIE stowage coordinate system. 02, 04, 06 etc. for below deck; 82, 84, 86 etc. for on deck.',
    `transshipment_indicator` BOOLEAN COMMENT 'Indicates whether this container will be transshipped to another vessel at the port of discharge rather than being delivered to final consignee. True for transshipment cargo requiring onward vessel connection.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for dangerous goods (e.g., UN1203 for gasoline). Null for non-hazardous cargo. Used for regulatory compliance, emergency response, and stowage segregation per IMDG Code.',
    `updated_at` TIMESTAMP COMMENT 'System timestamp when this slot reservation record was last modified. Updated on any field change. Used for change tracking and data synchronization.',
    `updated_by_user` STRING COMMENT 'User ID or system account that last modified this slot reservation record. Used for change audit trail and operational accountability.',
    `verified_gross_mass_kg` DECIMAL(18,2) COMMENT 'Verified Gross Mass of the container in kilograms, as required by SOLAS VGM regulation. Mandatory for all packed containers since July 2016. Used for vessel stability calculations and safe stowage planning.',
    `vgm_method` STRING COMMENT 'Method used to verify the container gross mass per SOLAS VGM regulation. Method 1: weighing the packed container. Method 2: weighing all contents and adding tare weight. Both methods are acceptable; method must be documented.. Valid values are `method_1|method_2`',
    `vgm_verified_at` TIMESTAMP COMMENT 'Date and time when the VGM was verified. Must be before vessel loading per SOLAS requirements. Used for compliance audit trail and operational gate planning.',
    `vgm_verified_by` STRING COMMENT 'Name or identifier of the party responsible for VGM verification (shipper, freight forwarder, or authorized agent). Required for SOLAS VGM compliance and liability tracking.',
    `weight_class` STRING COMMENT 'Weight category of the container for stowage planning. Light: <10 tonnes. Medium: 10-20 tonnes. Heavy: 20-30 tonnes. Super Heavy: >30 tonnes. Determines bottom-tier placement and stack height limits per vessel stability rules.. Valid values are `light|medium|heavy|super_heavy`',
    CONSTRAINT pk_slot_reservation PRIMARY KEY(`slot_reservation_id`)
) COMMENT 'Container slot reservation on a vessel for a specific cargo booking, representing the physical bay-row-tier stowage position (BAPLIE reference) allocated to cargo. Captures slot type (20ft/40ft/HC/RF/OOG), slot status (reserved, confirmed, cancelled, substituted), weight class, reefer plug requirement, and allocation source (shipping line nomination or terminal allocation). Manages the commercial slot allocation negotiation between shipping lines and the terminal operator. Links to cargo_booking as the commercial parent. Sourced from NAVIS N4 vessel planning module.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` (
    `pre_arrival_id` BIGINT COMMENT 'Primary key for pre_arrival',
    `agent_appointment_id` BIGINT COMMENT 'Reference to the shipping agent or vessel representative who submitted the pre-arrival notification on behalf of the vessel owner or operator.',
    `berth_id` BIGINT COMMENT 'Foreign key linking to infrastructure.berth. Business justification: Pre-arrival notifications explicitly designate the intended berth for VTS coordination, pilot boarding planning, and berth readiness checks. Port authorities require berth assignment in pre-arrival su',
    `channel_id` BIGINT COMMENT 'Foreign key linking to infrastructure.channel. Business justification: Pre-arrival notifications include vessel draft and dimensions that must be validated against channel depth and width restrictions. VTS and harbor masters use this for safe passage planning, tidal wind',
    `contact_person_id` BIGINT COMMENT 'Foreign key linking to customer.contact_person. Business justification: submitted_by_name, submitted_by_email, submitted_by_phone are denormalized text fields on pre_arrival. Replacing with a contact_person FK enables proper CRM tracking, port authority notification, and ',
    `customs_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_declaration. Business justification: Pre-arrival notifications trigger advance customs declaration submission (FAL Convention requirement). Port systems validate customs clearance status before vessel arrival. Standard port entry protoco',
    `facility_security_plan_id` BIGINT COMMENT 'Foreign key linking to security.facility_security_plan. Business justification: ISPS Code Regulation XI-2/9 requires pre-arrival security information to be assessed against the port facility security plan. pre_arrival.security_declaration and isps_security_level are snapshots; th',
    `flag_state_id` BIGINT COMMENT 'Foreign key linking to masterdata.flag_state. Business justification: Pre-arrival processing includes PSC targeting, port health clearance, and ISPS security declaration — all directly flag-state-dependent. Port health and customs authorities require flag state on the p',
    `isps_facility_record_id` BIGINT COMMENT 'Foreign key linking to compliance.isps_facility_record. Business justification: Pre-arrival ISPS security declarations must be matched against the receiving port facilitys ISPS record to verify compatible security levels and Declaration of Security requirements. ISPS Code mandat',
    `un_locode_id` BIGINT COMMENT 'Foreign key linking to masterdata.un_locode. Business justification: last_port_of_call field exists. FK to un_locode master enables port health authority notification, customs pre-clearance, voyage validation, quarantine risk assessment, and security level determinatio',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Pre-arrival notifications are submitted by port agents or shipping lines under their participant_account. Port authority dues, pilotage billing, and regulatory reporting require the account reference.',
    `pilotage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.pilotage_tariff. Business justification: Pre-arrival notifications declare pilotage_required and trigger pilotage resource allocation. The applicable pilotage tariff must be identified at pre-arrival stage for port authority charge estimatio',
    `port_dues_schedule_id` BIGINT COMMENT 'Foreign key linking to tariff.port_dues_schedule. Business justification: Port dues liability is established at pre-arrival notification stage based on vessel GRT/NRT/LOA. The port dues schedule must be identified at pre-arrival for financial provisioning and regulatory rep',
    `port_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.port_tariff. Business justification: Pre-arrival notifications trigger tariff applicability assessment for the upcoming vessel call to provide advance cost estimates to vessel agents. Real business process: proforma invoice generation an',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Pre-arrival notifications trigger mandatory sanctions screening of the vessel, operator, and cargo before port entry approval. Port state control and port authority require sanctions clearance as part',
    `towage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.towage_tariff. Business justification: Pre-arrival notifications declare towage_required and trigger tug allocation. The applicable towage tariff must be identified at pre-arrival stage for cost estimation and tug operator billing setup. M',
    `call_booking_id` BIGINT COMMENT 'Foreign key linking to booking.call_booking. Business justification: Pre-arrival notifications (PAN/FAL forms) are submitted as part of the vessel call booking process. pre_arrival currently links to vessel_call_id (cross-domain to vessel.call) but lacks the link to th',
    `call_id` BIGINT COMMENT 'Reference to the scheduled vessel call appointment at the port.',
    `vessel_id` BIGINT COMMENT 'Reference to the vessel submitting the pre-arrival notification.',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: imo_number exists on pre_arrival. FK to vessel_master enables vessel specification validation, compliance certificate checking (ISPS, SOLAS, MARPOL), PSC history lookup, and berth compatibility assess',
    `voyage_id` BIGINT COMMENT 'Reference to the specific voyage for which this pre-arrival notification applies.',
    `voyage_nomination_id` BIGINT COMMENT 'Foreign key linking to booking.voyage_nomination. Business justification: A pre-arrival notification (PAN/FAL form) is submitted for a specific vessel voyage that was formally nominated via a voyage_nomination. Linking pre_arrival.voyage_nomination_id -> voyage_nomination.v',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the port authority or maritime single window acknowledged receipt of the pre-arrival notification.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the pre-arrival notification was approved by the port authority, customs, and other regulatory bodies.',
    `bunker_fuel_required` BOOLEAN COMMENT 'Indicates whether the vessel requires bunker fuel supply services during the port call.',
    `cargo_manifest_summary` STRING COMMENT 'High-level summary of cargo manifest including total TEU, FEU, breakbulk tonnage, and cargo types for customs pre-clearance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this pre-arrival notification record was first created in the system.',
    `crew_count` STRING COMMENT 'Total number of crew members on board the vessel at the time of pre-arrival notification submission.',
    `dangerous_goods_declaration` STRING COMMENT 'Summary declaration of dangerous goods cargo including UN numbers, classes, and quantities as required by IMDG Code.',
    `dangerous_goods_onboard` BOOLEAN COMMENT 'Indicates whether the vessel is carrying dangerous goods as classified under IMDG Code.',
    `eta` TIMESTAMP COMMENT 'Estimated date and time when the vessel is expected to arrive at the port or pilot boarding station.',
    `etb` TIMESTAMP COMMENT 'Estimated date and time when the vessel is expected to berth at the assigned terminal or wharf.',
    `etd` TIMESTAMP COMMENT 'Estimated date and time when the vessel is expected to depart from the port.',
    `fresh_water_required` BOOLEAN COMMENT 'Indicates whether the vessel requires fresh water supply services during the port call.',
    `health_declaration_remarks` STRING COMMENT 'Additional remarks or details regarding the health status of crew, passengers, or sanitary conditions on board.',
    `health_declaration_status` STRING COMMENT 'Health status declaration indicating whether any illness, disease, or health concerns exist on board requiring port health authority attention.. Valid values are `clean|illness_reported|quarantine_required|inspection_pending`',
    `isps_security_level` STRING COMMENT 'Current ISPS security level of the vessel (1=normal, 2=heightened, 3=exceptional) as declared in the pre-arrival notification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this pre-arrival notification record was last updated or amended.',
    `next_port_of_call` STRING COMMENT 'Name or UN/LOCODE of the next port where the vessel will call after departing from this port.',
    `pan_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this pre-arrival notification by the submitting party or port authority.',
    `passenger_count` STRING COMMENT 'Total number of passengers on board the vessel at the time of pre-arrival notification submission.',
    `pilotage_required` BOOLEAN COMMENT 'Indicates whether marine pilotage services are required for this vessel call based on vessel size, cargo type, or port regulations.',
    `port_health_clearance_status` STRING COMMENT 'Current status of port health authority clearance based on the health declaration submitted in the pre-arrival notification.. Valid values are `pending|cleared|inspection_required|quarantine|hold`',
    `rejection_reason` STRING COMMENT 'Detailed reason provided by the port authority or regulatory body if the pre-arrival notification was rejected or requires amendment.',
    `security_declaration` STRING COMMENT 'Security-related declaration including last 10 ports of call, security incidents, and compliance with ISPS Code requirements.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the pre-arrival notification submission. Tracks progression from draft through approval or rejection.. Valid values are `draft|submitted|acknowledged|approved|rejected|amended`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the pre-arrival notification was officially submitted to the port authority or maritime single window.',
    `total_cargo_weight_tonnes` DECIMAL(18,2) COMMENT 'Total weight of all cargo on board in metric tonnes as declared in the pre-arrival notification.',
    `total_teu` DECIMAL(18,2) COMMENT 'Total container capacity in TEU (Twenty-foot Equivalent Units) declared in the cargo manifest for this vessel call.',
    `towage_required` BOOLEAN COMMENT 'Indicates whether towage (tug) services are required for berthing or unberthing operations.',
    `vts_coordination_status` STRING COMMENT 'Status of coordination with Vessel Traffic Service for vessel arrival, pilotage scheduling, and anchorage management.. Valid values are `pending|coordinated|approved|rejected|rescheduled`',
    `waste_disposal_required` BOOLEAN COMMENT 'Indicates whether the vessel requires waste disposal services (garbage, oily waste, sewage) as per MARPOL Convention.',
    CONSTRAINT pk_pre_arrival PRIMARY KEY(`pre_arrival_id`)
) COMMENT 'Captures the formal pre-arrival notification (PAN/FAL forms) submitted by the vessel master, agent, or shipping line prior to port entry, as required by IMO FAL Convention and national maritime authority regulations. Includes vessel IMO number, voyage number, last port of call, next port of call, crew list count, passenger count, dangerous goods declaration (IMDG), health declaration, security declaration (ISPS level), estimated cargo manifest summary, and submission timestamp. Feeds customs pre-clearance, port health, and VTS coordination workflows. Sourced from PCS and Maritime Single Window.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` (
    `truck_gate_booking_id` BIGINT COMMENT 'Unique identifier for the truck gate appointment booking record. Primary key for the truck gate booking entity.',
    `access_credential_id` BIGINT COMMENT 'Foreign key linking to security.access_credential. Business justification: Port gate access requires valid ISPS access credentials for drivers/vehicles. truck_gate_booking stores driver_license_number and driver_name as denormalized plain attributes; linking to access_creden',
    `cargo_booking_id` BIGINT COMMENT 'Foreign key linking to booking.cargo_booking. Business justification: Truck gate appointments are made for container pickup/delivery related to specific cargo bookings. truck_gate_booking currently has delivery_order_number (STRING) which is a denormalized reference. Ad',
    `container_id` BIGINT COMMENT 'Foreign key linking to cargo.container. Business justification: Gate appointments schedule specific container movements - direct operational link for gate operations, container tracking, and yard planning. TOS systems require container_id for gate transaction proc',
    `container_preadvice_id` BIGINT COMMENT 'Foreign key linking to cargo.container_preadvice. Business justification: A truck gate booking is validated against the container pre-advice to confirm the container is expected and authorized for gate entry. Gate control systems cross-reference the pre-advice at check-in t',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.container_type. Business justification: Container type determines gate lane assignment, weighbridge requirements, reefer plug allocation, and OOG handling procedures at truck gate. The plain-text container_size_type is a denormalized refere',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Truck gate operations incur staffing, inspection, and infrastructure costs tracked against cost centres for gate throughput cost reporting. Port operators assign gate handling costs to cost centres fo',
    `customs_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_declaration. Business justification: Gate appointments validate customs clearance before container release. Gate system checks customs status to prevent unauthorized cargo movement. Operational gate control and compliance enforcement.',
    `customs_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_hold. Business justification: Gate operators must check customs hold status before releasing containers to trucks. A container under customs hold must be blocked at the gate. This is a critical operational control — linking truck_',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to cargo.delivery_order. Business justification: A truck gate booking for container pickup must reference the delivery order that authorizes release. Gate officers verify the delivery order at check-in before releasing the container to the trucker. ',
    `imdg_class_id` BIGINT COMMENT 'Foreign key linking to masterdata.imdg_class. Business justification: imdg_class field exists. FK to imdg_class master enables gate safety protocol enforcement, driver certification validation, routing restriction checking, and emergency response procedure lookup for ha',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.import_export_permit. Business justification: Gate operators must verify import/export permit validity for controlled goods before releasing cargo to trucks. This is a mandatory regulatory gate check in maritime-logistics — controlled goods canno',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Gate transactions generate gate fees, container inspection charges, and weighbridge fees. Terminal operators must link invoices to gate bookings for accurate billing of landside services, VGM verifica',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Trucking companies hold participant_accounts; gate bookings are billed to the account and credit utilisation is tracked per account. Gate billing reconciliation and account-level gate activity reports',
    `call_id` BIGINT COMMENT 'Foreign key reference to the vessel call or visit associated with this container movement. Links the gate appointment to the specific vessel voyage for import/export operations.',
    `port_gate_id` BIGINT COMMENT 'Foreign key linking to infrastructure.port_gate. Business justification: Every truck appointment is assigned to a specific gate for entry/exit. Gate operations, traffic management, and appointment systems require this link for lane assignment, RFID processing, and throughp',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: yard_location field exists. FK to port_location master enables gate routing optimization, yard block assignment, customs zone validation, RFID reader mapping, and container positioning for truck gate ',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Gate handling fees and container delivery charges are revenue attributed to a profit centre for terminal P&L. Port operators segment gate revenue by terminal profit centre for financial reporting and ',
    `shipping_line_id` BIGINT COMMENT 'FK to masterdata.shipping_line',
    `storage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.storage_tariff. Business justification: Gate bookings for container pickup/delivery require storage tariff reference to calculate accumulated storage charges based on dwell time and free days. Real business process: storage charge settlemen',
    `terminal_zone_id` BIGINT COMMENT 'Foreign key linking to infrastructure.terminal_zone. Business justification: Trucks are directed to specific terminal zones for container pickup/delivery. Yard planners use this to sequence truck movements, prevent congestion, and coordinate with yard equipment. Essential for ',
    `truck_appointment_id` BIGINT COMMENT 'Foreign key linking to intermodal.truck_appointment. Business justification: A truck gate booking (pre-booked gate slot) is created in response to or in conjunction with a truck appointment. Gate operations teams reconcile gate bookings against truck appointments for no-show t',
    `port_community_participant_id` BIGINT COMMENT 'Foreign key linking to customer.port_community_participant. Business justification: Gate appointments require linking trucking company as port community participant for ISPS access control, billing integration, and customs broker validation. Trucking companies are registered particip',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to infrastructure.warehouse. Business justification: Trucks delivering/collecting cargo from warehouses need explicit warehouse assignment for access control, dock scheduling, and loading bay allocation. Warehouse operations teams use this to manage tru',
    `weighing_station_id` BIGINT COMMENT 'Foreign key linking to infrastructure.weighing_station. Business justification: SOLAS VGM regulations require trucks to be weighed at a certified weighing station during gate-in processing. The truck gate booking must record which weighing station performed the VGM measurement fo',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the truck arrived at the terminal gate. Used for appointment adherence tracking and gate performance KPIs.',
    `appointment_date` DATE COMMENT 'Scheduled date for the truck gate appointment. Used for daily gate capacity planning and slot allocation.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the gate appointment. Tracks progression from initial request through confirmation, arrival, processing, and completion or cancellation. [ENUM-REF-CANDIDATE: requested|confirmed|checked_in|in_progress|completed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `appointment_time_slot_end` TIMESTAMP COMMENT 'End timestamp of the scheduled appointment window. Defines the latest time the truck should arrive to honor the appointment.',
    `appointment_time_slot_start` TIMESTAMP COMMENT 'Start timestamp of the scheduled appointment window. Defines the earliest time the truck should arrive at the gate.',
    `appointment_type` STRING COMMENT 'Classification of the gate appointment based on the transaction purpose. Import delivery (container leaving terminal), export receival (container entering terminal for loading), empty return (returning empty container), empty pickup (collecting empty container), inspection, or repair movements. [ENUM-REF-CANDIDATE: import_delivery|export_receival|empty_return|empty_pickup|inspection|repair_gate_in|repair_gate_out — 7 candidates stripped; promote to reference product]',
    `booking_reference_number` STRING COMMENT 'External booking reference number provided by the shipping line or freight forwarder. Links the gate appointment to the cargo booking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the appointment was cancelled. Captured when appointment_status is set to cancelled for operational analysis and customer service.',
    `cargo_weight_kg` DECIMAL(18,2) COMMENT 'Verified gross mass of the container and cargo in kilograms. Required for SOLAS VGM compliance and safe handling operations.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Timestamp when the truck completed check-in procedures at the gate and was authorized to enter the terminal. Marks the start of gate transaction processing.',
    `container_condition` STRING COMMENT 'Physical and cargo status of the container at the time of gate appointment. Full indicates laden container, empty indicates no cargo, damaged indicates equipment requiring inspection or repair.. Valid values are `full|empty|damaged`',
    `coparn_message_reference` STRING COMMENT 'EDI COPARN message reference number for container pre-advice. Links the gate appointment to the electronic pre-notification received from the shipping line or freight forwarder.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created the appointment booking. Supports audit trail and accountability for appointment management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the gate appointment booking record was first created in the system. Audit trail for appointment request lifecycle.',
    `driver_phone_number` STRING COMMENT 'Mobile phone number of the driver for real-time communication regarding appointment changes, delays, or gate instructions.',
    `dwell_time_minutes` STRING COMMENT 'Total time in minutes the truck spent inside the terminal from check-in to gate-out. Key performance indicator for gate efficiency and truck turnaround time.',
    `gate_out_timestamp` TIMESTAMP COMMENT 'Timestamp when the truck exited the terminal after completing the container transaction. Marks the completion of the gate appointment lifecycle.',
    `iftmin_message_reference` STRING COMMENT 'EDI IFTMIN message reference number for transport instruction. Links the gate appointment to electronic shipping instructions received via EDI.',
    `is_hazardous_cargo` BOOLEAN COMMENT 'Boolean flag indicating whether the container holds dangerous goods requiring special handling and compliance with IMDG Code regulations.',
    `is_oversize` BOOLEAN COMMENT 'Boolean flag indicating whether the container or cargo exceeds standard dimensions, requiring special handling equipment or routing through the terminal.',
    `is_refrigerated` BOOLEAN COMMENT 'Boolean flag indicating whether the container is a reefer unit requiring temperature-controlled handling and power connection at the terminal.',
    `last_modified_by_user` STRING COMMENT 'User identifier or system account that last modified the appointment record. Supports change tracking and operational accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the appointment record. Tracks changes to appointment details, status transitions, or corrections.',
    `no_show_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the truck failed to arrive during the scheduled appointment window. Used for carrier performance tracking and slot utilization analysis.',
    `reefer_temperature_celsius` DECIMAL(18,2) COMMENT 'Target temperature setting in degrees Celsius for refrigerated containers. Critical for maintaining cold chain integrity for perishable cargo.',
    `special_handling_instructions` STRING COMMENT 'Free-text field for operational notes regarding special handling requirements, equipment needs, or safety precautions for this gate appointment.',
    `truck_license_plate` STRING COMMENT 'Vehicle registration license plate number of the truck making the gate appointment. Used for vehicle identification and access control at the terminal gate.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials (e.g., UN1203 for gasoline). Required for dangerous goods shipments per IMDG Code.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_truck_gate_booking PRIMARY KEY(`truck_gate_booking_id`)
) COMMENT 'Manages truck gate appointment bookings for container pickup and delivery at the terminal. Captures truck registration, driver identity, container number, booking reference, appointment window (date/time slot), gate lane assignment, appointment type (import delivery, export receival, empty return, empty pickup), appointment status, and COPARN/IFTMIN EDI reference. Supports controlled gate access and yard pre-planning. Sourced from NAVIS N4 gate module.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` (
    `voyage_nomination_id` BIGINT COMMENT 'Unique identifier for the voyage nomination record. Primary key for the voyage nomination entity.',
    `call_id` BIGINT COMMENT 'Foreign key linking to vessel.call. Business justification: Port planners match voyage nominations to actual port call records for billing reconciliation and performance tracking. A nomination precedes and triggers a call; linking them supports the nomination-',
    `call_schedule_id` BIGINT COMMENT 'Foreign key linking to vessel.call_schedule. Business justification: Shipping line voyage nominations are matched against published call schedules for berth window allocation and resource planning. Port planners validate nomination ETAs against scheduled windows. This ',
    `infrastructure_terminal_id` BIGINT COMMENT 'Foreign key linking to infrastructure.terminal. Business justification: Voyage nominations are submitted to and accepted by a specific terminal operator. Terminal-level nomination routing, acceptance workflow, and capacity planning all require the terminal reference on th',
    `un_locode_id` BIGINT COMMENT 'Foreign key linking to masterdata.un_locode. Business justification: last_port_of_call field exists. FK to un_locode master enables port name resolution, country identification, routing validation, customs origin reporting, and PSC jurisdiction determination for voyage',
    `mooring_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.mooring_tariff. Business justification: Voyage nominations initiate the vessel call lifecycle; mooring is a standard service for every berthing vessel. Identifying the applicable mooring tariff at nomination stage enables proforma disbursem',
    `berth_id` BIGINT COMMENT 'Reference to the preferred berth requested by the shipping line for this vessel call. Subject to port authority approval based on availability and operational constraints.',
    `port_community_participant_id` BIGINT COMMENT 'Foreign key linking to customer.port_community_participant. Business justification: The nominating agent submitting a voyage nomination is a port_community_participant. PCS workflow, credit checks, and nomination acceptance require identifying the nominating party. Distinct from mast',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Voyage nominations are submitted by shipping lines holding participant_accounts. The account governs credit checks, tariff application, and nomination acceptance workflows. No existing FK to participa',
    `pilotage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.pilotage_tariff. Business justification: Voyage nominations declare pilotage_required at the earliest stage of vessel call planning. Identifying the applicable pilotage tariff at nomination stage enables cost estimation for shipping line pro',
    `port_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.port_tariff. Business justification: Voyage nominations are submitted by shipping lines to declare a vessel call; the applicable port tariff regime must be validated at nomination stage for pre-arrival charge estimation and tariff compli',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to tariff.rate_card. Business justification: Voyage nominations from shipping lines operating under service contracts reference applicable rate cards for voyage-level pricing agreements. Real business process: contracted voyage pricing and volum',
    `shipping_line_id` BIGINT COMMENT 'Reference to the shipping line or carrier submitting the voyage nomination.',
    `superseded_by_nomination_voyage_nomination_id` BIGINT COMMENT 'Reference to the newer nomination that replaced this one. Null if this is the current active nomination. Used to track nomination revision history.',
    `terminal_zone_id` BIGINT COMMENT 'Reference to the preferred terminal facility for cargo handling operations. May be specified instead of or in addition to specific berth.',
    `towage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.towage_tariff. Business justification: Voyage nominations declare towage_required at the earliest stage of vessel call planning. Identifying the applicable towage tariff at nomination stage enables cost estimation for proforma disbursement',
    `vessel_id` BIGINT COMMENT 'Reference to the nominated vessel for this port call.',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: imo_number exists on voyage_nomination. FK to vessel_master enables vessel capability validation against nominated cargo volumes, berth compatibility checking, crane reach verification, and compliance',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to vessel.voyage. Business justification: Voyage nomination by shipping lines must link to the actual vessel.voyage record for schedule validation, rotation sequence verification, and cargo manifest reconciliation. Terminal planners match nom',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the port authority accepted the nomination and confirmed the berth allocation. Null if nomination is still pending or was rejected.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this voyage nomination record was first created in the database. Used for audit trail and data lineage tracking.',
    `empty_count` STRING COMMENT 'Number of empty containers nominated for repositioning during this call. Impacts yard utilization and vessel weight distribution.',
    `export_teu` DECIMAL(18,2) COMMENT 'Nominated volume of export containers to be loaded at this port, expressed in TEU. Used for gate planning and vessel stowage preparation.',
    `hazmat_count` STRING COMMENT 'Number of containers carrying dangerous goods (IMDG cargo) nominated for this call. Triggers special handling, segregation, and compliance requirements.',
    `import_teu` DECIMAL(18,2) COMMENT 'Nominated volume of import containers to be discharged at this port, expressed in TEU. Critical for yard planning and equipment allocation.',
    `next_port_of_call` STRING COMMENT 'Next scheduled port in the vessels itinerary after this call. Provides context for transshipment cargo routing and vessel schedule reliability.',
    `nominated_eta` TIMESTAMP COMMENT 'Shipping lines initial estimate of vessel arrival time at port limits. First signal in the vessel scheduling process, typically provided 7-14 days before arrival.',
    `nominated_etb` TIMESTAMP COMMENT 'Requested berthing time window start. Represents the shipping lines preferred time to commence cargo operations.',
    `nominated_etd` TIMESTAMP COMMENT 'Planned departure time from berth as nominated by the shipping line. Used for berth occupancy planning and resource allocation.',
    `nomination_number` STRING COMMENT 'Business identifier for the voyage nomination, typically provided by the shipping line or generated by the Port Community System (PCS). Used for external communication and tracking.',
    `nomination_received_timestamp` TIMESTAMP COMMENT 'Date and time when the nomination was first received by the port system. Used for SLA tracking and nomination lead-time analysis.',
    `nomination_source` STRING COMMENT 'Channel or system through which the nomination was received. Tracks data quality and integration pathway.. Valid values are `edi_coparn|edi_iftmin|pcs_portal|email|manual_entry|api`',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the voyage nomination. Tracks progression from initial nomination through acceptance or rejection by port authority.. Valid values are `nominated|accepted|rejected|superseded|withdrawn|confirmed`',
    `oversized_count` STRING COMMENT 'Number of out-of-gauge or oversized containers (open-top, flat-rack, or containers with cargo exceeding standard dimensions) nominated for this call. Requires special yard slots and handling equipment.',
    `pilotage_required` BOOLEAN COMMENT 'Indicates whether marine pilotage services are required for this vessel call. Drives pilot scheduling and marine services coordination.',
    `reefer_count` STRING COMMENT 'Number of refrigerated containers (reefers) nominated for this call. Requires special yard planning for power plug availability and monitoring.',
    `rejection_reason` STRING COMMENT 'Detailed explanation for why the nomination was rejected (e.g., berth unavailable, vessel dimensions exceed berth capacity, insufficient advance notice). Null if nomination was accepted.',
    `rejection_timestamp` TIMESTAMP COMMENT 'Date and time when the nomination was rejected by the port authority. Null if nomination was accepted or is still pending.',
    `restow_teu` DECIMAL(18,2) COMMENT 'Nominated volume of containers requiring restow operations (discharge and reload on same vessel for improved stowage). Impacts berth time and crane productivity.',
    `special_requirements` STRING COMMENT 'Free-text field capturing any special handling requirements, operational constraints, or service requests submitted with the nomination (e.g., Requires mobile crane for heavy lift, Priority berthing requested).',
    `total_moves` STRING COMMENT 'Total number of container handling moves nominated for this vessel call (sum of all discharge and load operations). Key metric for crane hour estimation and berth productivity planning.',
    `towage_required` BOOLEAN COMMENT 'Indicates whether tug boat assistance is required for berthing and unberthing operations. Drives towage resource planning.',
    `transhipment_teu` DECIMAL(18,2) COMMENT 'Nominated volume of transhipment containers (discharge and reload) at this port, expressed in TEU. Represents containers moving between vessels without leaving port custody.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this voyage nomination record was last modified. Tracks data currency and change frequency for operational monitoring.',
    CONSTRAINT pk_voyage_nomination PRIMARY KEY(`voyage_nomination_id`)
) COMMENT 'Captures the shipping lines formal nomination of a vessel voyage for a port call, representing the earliest commercial signal in the booking lifecycle before a full vessel call booking is confirmed. Includes nominated vessel name, IMO number, voyage number, service rotation, nominated berth window, expected cargo volumes (TEU import/export/transhipment), and nomination acceptance status (nominated, accepted, rejected, superseded). Aligned with DCSA transport plan and COPARN nomination message flows. Sourced from PCS EDI messaging (COPARN/IFTMIN).';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`service_requirement` (
    `service_requirement_id` BIGINT COMMENT 'Unique identifier for the service requirement record. Primary key for the service requirement entity.',
    `berth_id` BIGINT COMMENT 'Foreign key linking to infrastructure.berth. Business justification: Service requirements for mooring, line handling, gangway, and shore power are operationally tied to a specific berth. Resource scheduling and SLA tracking for berth-side services require this link. Th',
    `call_booking_id` BIGINT COMMENT 'Reference to the parent vessel call booking that this service requirement is part of. Links the service requirement to the overall booking context.',
    `contact_person_id` BIGINT COMMENT 'Foreign key linking to customer.contact_person. Business justification: requester_contact_name, requester_contact_email, requester_contact_phone are denormalized text fields on service_requirement. Replacing with a contact_person FK enables CRM notification workflows and ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Service requirements carry estimated_cost and billing_reference, indicating cost-tracked operations. Port operators assign service requirement costs (crane hire, specialist labour, equipment) to cost ',
    `customs_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_declaration. Business justification: Service requirements (fumigation, physical examination, controlled goods handling) are frequently mandated by customs declarations. Port operators need to link the service requirement to the triggerin',
    `customs_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_hold. Business justification: Customs holds directly trigger service requirements — physical examination, scanning, or fumigation services are ordered when customs places a hold. Linking service_requirement to customs_hold enables',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Service requirements with estimated_cost and billing_reference are linked to internal orders for project-based cost tracking (e.g. special equipment mobilisation, OOG handling projects). Port finance ',
    `item_id` BIGINT COMMENT 'Foreign key linking to tariff.item. Business justification: Service requirements reference specific chargeable service items for cost estimation before a service order is raised. Port billing teams need the tariff item to pre-calculate charges and validate ser',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Service requirements are raised by participants against their account for billing and SLA tracking. requester_organization is a plain text denorm; the proper account reference enables credit checks an',
    `port_community_participant_id` BIGINT COMMENT 'Foreign key linking to customer.port_community_participant. Business justification: requester_organization is a plain text denorm on service_requirement. The requesting party is a port_community_participant. Proper FK enables billing, SLA tracking, PCS workflow, and eliminates the de',
    `service_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.service_code. Business justification: service_type field exists. FK to service_code master enables service catalog validation, pricing lookup, billing integration, UOM standardization, and approval workflow routing for service requirement',
    `terminal_zone_id` BIGINT COMMENT 'Foreign key linking to infrastructure.terminal_zone. Business justification: Service requirements for yard equipment, reefer monitoring, and cargo handling are assigned to a terminal zone for resource dispatch and SLA compliance tracking. Zone-level service allocation drives e',
    `vessel_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_type. Business justification: Service requirements are vessel-type-specific — pilotage, towage, mooring gang size, and crane compatibility all depend on vessel type. Service planners use vessel type to validate equipment availabil',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the service requirement was formally approved and authorized for service order creation. Marks the transition from demand signal to committed execution plan.',
    `billing_reference` STRING COMMENT 'Customer-provided reference number for billing and invoicing purposes. Links the service requirement to the customers internal purchase order or cost center for financial reconciliation.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the service requirement was cancelled by the requester or port authority. May cite vessel schedule changes, cargo plan modifications, or force majeure events. Populated only when requirement_status is cancelled.',
    `compliance_notes` STRING COMMENT 'Free-text field documenting regulatory compliance considerations, customs requirements, or trade documentation needs associated with the service requirement. May reference SOLAS, MARPOL, or local port authority regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service requirement record was first created in the system. Represents the initial capture of the demand signal, which may precede formal submission.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost. Typically USD for international maritime transactions, but may vary based on port jurisdiction and customer agreement.. Valid values are `^[A-Z]{3}$`',
    `equipment_type_required` STRING COMMENT 'Specific type of terminal equipment required to fulfill the service. Critical for equipment dispatch planning and capacity validation. STS = Ship-to-Shore crane, MHC = Mobile Harbour Crane, RTG = Rubber Tyred Gantry, AGV = Automated Guided Vehicle.. Valid values are `sts_crane|mhc|rtg|agv|reach_stacker|forklift`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Preliminary cost estimate for the requested service based on tariff schedules and service parameters. Provided for customer budgeting and approval purposes prior to service order confirmation.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Expected duration in hours for completing the requested service. Used for resource scheduling, berth planning, and service order timeline estimation.',
    `external_reference_code` STRING COMMENT 'Identifier from the source system or customer system that originated this service requirement. Enables cross-system traceability and reconciliation with external booking platforms or EDI messages.',
    `imdg_class` STRING COMMENT 'IMDG classification for dangerous goods handling requirements. Mandatory when service_type includes dangerous goods handling. Drives compliance protocols and specialized equipment allocation.. Valid values are `class_1|class_2|class_3|class_4|class_5|class_6`',
    `isps_security_level` STRING COMMENT 'Required ISPS security level for the service execution. Level 1 = normal, Level 2 = heightened, Level 3 = exceptional. Determines access control, screening procedures, and security resource allocation.. Valid values are `level_1|level_2|level_3`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service requirement record was last updated. Tracks the most recent change to any field in the requirement for audit trail and data freshness purposes.',
    `oog_cargo_flag` BOOLEAN COMMENT 'Indicates whether the service requirement involves Out of Gauge cargo that exceeds standard container dimensions. Triggers specialized handling procedures and equipment requirements.',
    `oog_dimensions` STRING COMMENT 'Detailed dimensional specifications for OOG cargo in format Length x Width x Height (meters). Required when oog_cargo_flag is true for safe handling and stowage planning.',
    `priority_level` STRING COMMENT 'Business priority indicator for the service requirement. Influences scheduling sequence and resource allocation decisions in terminal operations.. Valid values are `routine|standard|urgent|critical`',
    `quantity_unit` STRING COMMENT 'Unit of measure for the service quantity field. Defines how the service volume is quantified for billing and resource allocation purposes.. Valid values are `hours|units|moves|teu|containers|trips`',
    `reefer_humidity_required` DECIMAL(18,2) COMMENT 'Target humidity level as percentage for refrigerated container monitoring. Applicable for specific cargo types requiring controlled atmosphere.',
    `reefer_temperature_required` DECIMAL(18,2) COMMENT 'Target temperature setting in Celsius for refrigerated container monitoring service. Critical for maintaining cold chain integrity for perishable cargo.',
    `rejection_reason` STRING COMMENT 'Explanation for why the service requirement was rejected. May cite capacity constraints, regulatory non-compliance, incomplete information, or operational conflicts. Populated only when requirement_status is rejected.',
    `requested_service_date` DATE COMMENT 'Target date when the service is required to be performed, typically aligned with vessel ETB (Estimated Time of Berthing) or cargo operation schedule.',
    `requested_service_time` TIMESTAMP COMMENT 'Precise timestamp when the service is required to commence, providing hour-level scheduling granularity for operational planning.',
    `requirement_number` STRING COMMENT 'Business-facing unique identifier for the service requirement, typically formatted as SR-YYYYMMDD-NNNN for external communication and tracking.. Valid values are `^SR-[0-9]{8}-[0-9]{4}$`',
    `requirement_status` STRING COMMENT 'Current lifecycle state of the service requirement. Tracks progression from initial declaration through approval or rejection.. Valid values are `draft|submitted|under_review|approved|rejected|cancelled`',
    `service_quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of the service required, measured in service-specific units (e.g., number of tugs for towage, number of crane hours for stevedoring, number of containers for reefer monitoring).',
    `source_system` STRING COMMENT 'Identifies the originating system or channel through which the service requirement was submitted. Supports data lineage tracking and integration troubleshooting. EDI = Electronic Data Interchange, PCS = Port Community System.. Valid values are `navis_n4|pcs|manual_entry|edi|api`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing specific operational instructions, safety requirements, or handling procedures that must be followed during service execution. May include temperature settings for reefer cargo, securing requirements for OOG (Out of Gauge) cargo, or IMDG class-specific protocols.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the service requirement was formally submitted by the shipping line or cargo owner for processing. Represents the official business event timestamp for requirement intake.',
    `vessel_dwt` DECIMAL(18,2) COMMENT 'Deadweight Tonnage of the vessel, representing total carrying capacity. Used for berth allocation validation and service fee calculation. DWT = Deadweight Tonnage in metric tons.',
    `vessel_loa` DECIMAL(18,2) COMMENT 'Length Overall of the vessel for which services are being requested. Critical for pilotage and towage resource planning. LOA = Length Overall, measured in meters.',
    CONSTRAINT pk_service_requirement PRIMARY KEY(`service_requirement_id`)
) COMMENT 'Declared service requirements submitted by a shipping line or cargo owner as part of a vessel call booking. Captures required service types (pilotage, towage, mooring, stevedoring, reefer monitoring, dangerous goods handling, OOG cargo handling), quantity, special handling instructions, equipment requirements (STS crane, MHC, RTG), compliance requirements (IMDG class, ISPS security level), and priority indicators. Acts as the demand signal that drives service_order creation and terminal resource planning. Distinct from service_order in that requirements represent declared needs before scheduling, while service_orders represent committed execution plans.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` (
    `anchorage_booking_id` BIGINT COMMENT 'Unique identifier for the anchorage booking record. Primary key for this entity.',
    `agent_appointment_id` BIGINT COMMENT 'Reference to the shipping agent or representative who submitted the anchorage booking request on behalf of the vessel owner or operator.',
    `anchorage_area_id` BIGINT COMMENT 'Reference to the designated anchorage area or zone requested for this booking. Links to anchorage area master data defining capacity and operational constraints.',
    `anchorage_id` BIGINT COMMENT 'Foreign key linking to vessel.anchorage. Business justification: Port control matches anchorage bookings (pre-arrival requests) to actual anchorage assignments for dues billing and operational tracking. The booking_anchorage_booking is the request; vessel.anchorage',
    `berth_reservation_id` BIGINT COMMENT 'Reference to the associated berth reservation if the vessel is anchoring while awaiting berth availability. Links anchorage to the planned berth allocation. Null if no berth reservation exists.',
    `call_booking_id` BIGINT COMMENT 'Foreign key linking to booking.call_booking. Business justification: An anchorage booking is made for a vessel that is awaiting berth availability as part of a port call. The booking_anchorage_booking should directly reference the originating call_booking to establish ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Anchorage services (VTS monitoring, pilot boat operations, buoy maintenance) incur costs allocated to marine services cost centre for anchorage operations cost tracking and anchorage fee pricing.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Anchorage bookings incur anchorage dues calculated by vessel tonnage and duration at anchorage. Port authorities must link invoices to anchorage bookings for statutory charge calculation, compliance w',
    `isps_facility_record_id` BIGINT COMMENT 'Foreign key linking to compliance.isps_facility_record. Business justification: Anchorage area assignments require ISPS security level validation and DoS coordination. Anchorage areas are designated port facilities under ISPS Code. Maritime security requirement.',
    `marsec_level_change_id` BIGINT COMMENT 'Foreign key linking to security.marsec_level_change. Business justification: Anchorage bookings at ISPS-regulated ports apply security measures determined by the active MARSEC level change. The booking_anchorage_booking.security_level attribute is a snapshot; this FK enables p',
    `participant_account_id` BIGINT COMMENT 'Foreign key linking to customer.participant_account. Business justification: Anchorage bookings are made by vessel agents or shipping lines under their participant_account. Anchorage dues billing and credit utilisation tracking require the account reference. No existing FK to ',
    `pilotage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.pilotage_tariff. Business justification: Anchorage bookings include pilot_required_flag for vessels moving to/from anchorage. The pilotage tariff governs charges for these movements. booking_berth_reservation links pilotage_tariff for berth ',
    `port_community_participant_id` BIGINT COMMENT 'Foreign key linking to customer.port_community_participant. Business justification: Anchorage bookings are requested by vessel agents who are port_community_participants. ISPS compliance, billing, and PCS workflow require identifying the requesting participant. No existing FK to port',
    `port_dues_schedule_id` BIGINT COMMENT 'Foreign key linking to tariff.port_dues_schedule. Business justification: Anchorage bookings incur port dues based on vessel GRT, anchorage duration, and applicable port dues schedule. Real business process: anchorage charge calculation and billing to vessel agent.',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Anchorage charges are a distinct port revenue stream that must be attributed to a profit centre for port authority P&L reporting. Finance teams require profit centre attribution on anchorage bookings ',
    `towage_tariff_id` BIGINT COMMENT 'Foreign key linking to tariff.towage_tariff. Business justification: Anchorage bookings include tug_assistance_required_flag for vessels requiring tug assistance at anchorage. The towage tariff governs tug charges. booking_berth_reservation links towage_tariff for bert',
    `call_id` BIGINT COMMENT 'Reference to the specific vessel call or port visit associated with this anchorage booking. Links to the vessel call record.',
    `vessel_id` BIGINT COMMENT 'Reference to the vessel requesting anchorage. Links to the vessel master data.',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: vessel_id FK exists to vessel domain, but imo_number also present. FK to vessel_master enables independent vessel specification lookup for anchorage area compatibility, swinging circle calculation, an',
    `weather_tide_window_id` BIGINT COMMENT 'Foreign key linking to marine.weather_tide_window. Business justification: Anchorage bookings carry weather_restriction_flag and require tidal window coordination. Port VTS and anchorage planners link anchorage bookings to specific weather/tide windows to validate safe ancho',
    `zone_id` BIGINT COMMENT 'Foreign key linking to security.security_zone. Business justification: Anchorage areas are designated security zones with specific MARSEC measures, patrol requirements, and access restrictions. Links booking to zone for security patrol assignment, VTS coordination, and e',
    `actual_anchor_drop_time` TIMESTAMP COMMENT 'Actual recorded date and time when the vessel dropped anchor, as reported by VTS or pilot. Used for billing and performance tracking.',
    `actual_anchorage_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration of anchorage in hours, calculated from actual anchor drop and weigh anchor times. Used for billing and performance analysis.',
    `actual_weigh_anchor_time` TIMESTAMP COMMENT 'Actual recorded date and time when the vessel weighed anchor and departed anchorage, as reported by VTS or pilot. Marks end of anchorage occupancy.',
    `anchorage_charge_amount` DECIMAL(18,2) COMMENT 'Total anchorage fee charged for this booking, calculated based on vessel size, duration, and applicable tariff rates. Excludes additional service charges.',
    `anchorage_charge_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the anchorage charge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `anchorage_reason_code` STRING COMMENT 'Primary reason for the vessel requesting anchorage. Determines operational handling and priority. STS = Ship-to-Ship transfer. [ENUM-REF-CANDIDATE: awaiting_berth|tidal_window|customs_clearance|bunkering|sts_transfer|crew_change|repairs|quarantine|weather|other — 10 candidates stripped; promote to reference product]',
    `anchorage_reason_description` STRING COMMENT 'Free-text detailed explanation of the anchorage reason, providing additional context beyond the reason code.',
    `booking_cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the anchorage booking was cancelled, either by the vessel agent or port authority. Null if booking was not cancelled.',
    `booking_confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the anchorage booking was confirmed and allocated by VTS or port operations. Represents formal acceptance of the request.',
    `booking_reference_number` STRING COMMENT 'Externally-visible unique reference number for the anchorage booking, used in communications with vessel agents and VTS. Format: ANC-YYYYMMDD-XXXX.. Valid values are `^ANC-[0-9]{8}-[A-Z0-9]{4}$`',
    `booking_requested_timestamp` TIMESTAMP COMMENT 'Date and time when the anchorage booking request was initially submitted to the port authority or VTS. Marks the start of the booking lifecycle.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the anchorage booking. Tracks progression from initial request through confirmation, occupation, and departure. [ENUM-REF-CANDIDATE: requested|confirmed|allocated|occupied|departed|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `buoy_number` STRING COMMENT 'Specific buoy or mooring point assigned within the anchorage area, if applicable. Format varies by port (e.g., A-12, NW-5).. Valid values are `^[A-Z]{1,3}-[0-9]{1,3}$`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the anchorage booking was cancelled. Null if booking was not cancelled.',
    `confirmed_anchor_drop_time` TIMESTAMP COMMENT 'VTS-confirmed date and time when the vessel is authorized to drop anchor. May differ from requested time due to capacity or operational constraints.',
    `confirmed_weigh_anchor_time` TIMESTAMP COMMENT 'VTS-confirmed date and time when the vessel is expected or authorized to weigh anchor and depart. Subject to operational adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this anchorage booking record was first created in the database. Used for audit trail and data lineage.',
    `hazmat_cargo_flag` BOOLEAN COMMENT 'Indicates whether the vessel is carrying hazardous or dangerous goods as defined by IMDG Code. True if hazmat cargo is present, requiring special anchorage area assignment and safety protocols.',
    `imdg_class_codes` STRING COMMENT 'Comma-separated list of IMDG hazard class codes for dangerous goods on board (e.g., 1.1, 3, 5.1). Null if no hazmat cargo. Used for anchorage area segregation and emergency response planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this anchorage booking record was last updated. Used for audit trail and change tracking.',
    `pilot_required_flag` BOOLEAN COMMENT 'Indicates whether pilotage service is required for the vessel to navigate to or from the anchorage area. True if pilot is mandatory per port regulations or vessel characteristics.',
    `planned_anchorage_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration of anchorage in hours, calculated from requested anchor drop and weigh anchor times. Used for capacity planning.',
    `priority_level` STRING COMMENT 'Priority classification for the anchorage request. Emergency and urgent requests receive expedited handling and preferential allocation.. Valid values are `routine|priority|urgent|emergency`',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the vessel is under quarantine or health hold, requiring isolation anchorage. True if quarantine is in effect, restricting vessel movement and requiring health authority clearance.',
    `requested_anchor_drop_time` TIMESTAMP COMMENT 'Vessel agents requested date and time for the vessel to drop anchor and commence anchorage. Used for capacity planning and VTS coordination.',
    `requested_weigh_anchor_time` TIMESTAMP COMMENT 'Vessel agents requested date and time for the vessel to weigh anchor and depart anchorage. Used for duration estimation and capacity release planning.',
    `security_level` STRING COMMENT 'Current ISPS security level applicable to this anchorage booking. Level 1 = normal, Level 2 = heightened, Level 3 = exceptional. Affects anchorage area access and monitoring requirements.. Valid values are `level_1|level_2|level_3`',
    `source_system` STRING COMMENT 'Identifies the operational system that originated this anchorage booking record. VTMS = Vessel Traffic Management System, PCS = Port Community System, NAVIS = Terminal Operating System, MANUAL = manually entered.. Valid values are `VTMS|PCS|NAVIS|MANUAL`',
    `special_instructions` STRING COMMENT 'Free-text field for any special operational instructions, requirements, or notes related to this anchorage booking. Used for coordination between vessel agent, VTS, and port operations.',
    `tug_assistance_required_flag` BOOLEAN COMMENT 'Indicates whether tug (towage) assistance is required for the vessel to safely anchor or depart the anchorage area. True if tugs are needed due to vessel size, weather, or operational constraints.',
    `vts_coordination_reference` STRING COMMENT 'Reference number assigned by the Vessel Traffic Service for coordination and tracking of this anchorage event. Links to VTS operational logs.. Valid values are `^VTS-[0-9]{10}$`',
    `weather_restriction_flag` BOOLEAN COMMENT 'Indicates whether the anchorage booking is subject to weather-related restrictions or holds. True if adverse weather conditions (wind, swell, visibility) prevent safe anchoring or departure.',
    CONSTRAINT pk_anchorage_booking PRIMARY KEY(`anchorage_booking_id`)
) COMMENT 'Manages booking and reservation of anchorage positions for vessels awaiting berth availability, tidal windows, customs clearance, or performing at-anchor operations (bunkering, STS transfer). Captures vessel identity, requested anchorage area or designated buoy, planned anchor drop and weigh anchor times, reason for anchorage, anchorage status (requested, confirmed, occupied, departed), and VTS coordination reference. Distinct from berth_reservation as anchorage has separate planning rules and capacity constraints. Sourced from VTMS.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ADD CONSTRAINT `fk_booking_call_booking_voyage_nomination_id` FOREIGN KEY (`voyage_nomination_id`) REFERENCES `shipping_ports_ecm`.`booking`.`voyage_nomination`(`voyage_nomination_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_berth_reservation_id` FOREIGN KEY (`berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`berth_reservation`(`berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_service_requirement_id` FOREIGN KEY (`service_requirement_id`) REFERENCES `shipping_ports_ecm`.`booking`.`service_requirement`(`service_requirement_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ADD CONSTRAINT `fk_booking_booking_service_order_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ADD CONSTRAINT `fk_booking_berth_reservation_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ADD CONSTRAINT `fk_booking_cargo_booking_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ADD CONSTRAINT `fk_booking_slot_reservation_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ADD CONSTRAINT `fk_booking_pre_arrival_voyage_nomination_id` FOREIGN KEY (`voyage_nomination_id`) REFERENCES `shipping_ports_ecm`.`booking`.`voyage_nomination`(`voyage_nomination_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ADD CONSTRAINT `fk_booking_truck_gate_booking_cargo_booking_id` FOREIGN KEY (`cargo_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`cargo_booking`(`cargo_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ADD CONSTRAINT `fk_booking_voyage_nomination_superseded_by_nomination_voyage_nomination_id` FOREIGN KEY (`superseded_by_nomination_voyage_nomination_id`) REFERENCES `shipping_ports_ecm`.`booking`.`voyage_nomination`(`voyage_nomination_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ADD CONSTRAINT `fk_booking_service_requirement_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_berth_reservation_id` FOREIGN KEY (`berth_reservation_id`) REFERENCES `shipping_ports_ecm`.`booking`.`berth_reservation`(`berth_reservation_id`);
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ADD CONSTRAINT `fk_booking_anchorage_booking_call_booking_id` FOREIGN KEY (`call_booking_id`) REFERENCES `shipping_ports_ecm`.`booking`.`call_booking`(`call_booking_id`);

-- ========= TAGS =========
ALTER SCHEMA `shipping_ports_ecm`.`booking` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `shipping_ports_ecm`.`booking` SET TAGS ('dbx_domain' = 'booking');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` SET TAGS ('dbx_subdomain' = 'vessel_scheduling');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `call_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Call Booking Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `contact_person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `facility_security_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Security Plan Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `flag_state_id` SET TAGS ('dbx_business_glossary_term' = 'Flag State Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `infrastructure_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `un_locode_id` SET TAGS ('dbx_business_glossary_term' = 'Last Port Un Locode Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Agent ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `port_dues_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Port Dues Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `port_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Port Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Line ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `vessel_type_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `voyage_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Nomination Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `ata` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Arrival (ATA)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `atb` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Berthing (ATB)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `atd` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Departure (ATD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `booking_cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Cancelled Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `booking_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Confirmed Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'nominated|pending|confirmed|cancelled|completed|rejected');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `booking_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Submitted Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|inspection_required|hold');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `eta` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `etb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Berthing (ETB)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `etd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `expected_container_moves` SET TAGS ('dbx_business_glossary_term' = 'Expected Container Moves');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `expected_teu` SET TAGS ('dbx_business_glossary_term' = 'Expected Twenty-foot Equivalent Units (TEU)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Security Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `next_port_of_call` SET TAGS ('dbx_business_glossary_term' = 'Next Port of Call');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `next_port_of_call` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `pilotage_required` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Required');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `reefer_container_count` SET TAGS ('dbx_business_glossary_term' = 'Reefer Container Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Booking Remarks');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `service_requirements` SET TAGS ('dbx_business_glossary_term' = 'Service Requirements');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `service_rotation` SET TAGS ('dbx_business_glossary_term' = 'Service Rotation');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `towage_required` SET TAGS ('dbx_business_glossary_term' = 'Towage Required');
ALTER TABLE `shipping_ports_ecm`.`booking`.`call_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` SET TAGS ('dbx_subdomain' = 'berth_operations');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `booking_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Service Order Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `berth_id` SET TAGS ('dbx_business_glossary_term' = 'Berth Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `berth_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Berth Reservation Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `customs_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Item Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `port_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Port Gate Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `rate_card_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `service_code_id` SET TAGS ('dbx_business_glossary_term' = 'Service Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `service_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Requirement Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `terminal_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `call_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Booking Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp (ATD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp (ATA)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `assigned_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `confirmed_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed End Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `confirmed_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Start Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `edi_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Reference');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `hazardous_cargo_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Cargo Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `imdg_class` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Class');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Security Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `requested_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requested End Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `requested_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requested Start Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `service_order_number` SET TAGS ('dbx_value_regex' = '^SO-[0-9]{8}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `service_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Service Unit of Measure (UOM)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `sla_actual_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Completion Minutes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `sla_actual_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Response Minutes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `sla_target_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Minutes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `sla_target_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Response Minutes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'NAVIS_N4|VTMS|PCS|MANUAL');
ALTER TABLE `shipping_ports_ecm`.`booking`.`booking_service_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` SET TAGS ('dbx_subdomain' = 'berth_operations');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `berth_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Berth Reservation Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `berth_id` SET TAGS ('dbx_business_glossary_term' = 'Berth Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isps Facility Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `marsec_level_change_id` SET TAGS ('dbx_business_glossary_term' = 'Marsec Level Change Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `mooring_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Mooring Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `pilotage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `port_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Port Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `quay_wall_id` SET TAGS ('dbx_business_glossary_term' = 'Quay Wall Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `towage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Towage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `call_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Booking Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `vessel_type_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `weather_tide_window_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Tide Window Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `atb` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Berthing (ATB)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `atd` SET TAGS ('dbx_business_glossary_term' = 'Actual Time of Departure (ATD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `beam_meters` SET TAGS ('dbx_business_glossary_term' = 'Beam Width in Meters');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `berth_side` SET TAGS ('dbx_business_glossary_term' = 'Berth Side Allocation');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `berth_side` SET TAGS ('dbx_value_regex' = 'port|starboard|alongside');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `berth_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Berth Utilization Hours');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `draft_meters` SET TAGS ('dbx_business_glossary_term' = 'Vessel Draft in Meters');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `dwt_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Deadweight Tonnage (DWT) in Tonnes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `etb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Berthing (ETB)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `etd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `expected_teu_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Twenty-foot Equivalent Unit (TEU) Volume');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `high_tide_time` SET TAGS ('dbx_business_glossary_term' = 'High Tide Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `imdg_class` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Class');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Security Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `loa_meters` SET TAGS ('dbx_business_glossary_term' = 'Length Overall (LOA) in Meters');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `low_tide_time` SET TAGS ('dbx_business_glossary_term' = 'Low Tide Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `mooring_gang_size` SET TAGS ('dbx_business_glossary_term' = 'Mooring Gang Size');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `number_of_tugs` SET TAGS ('dbx_business_glossary_term' = 'Number of Tugs Required');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `pilotage_required` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `planning_source` SET TAGS ('dbx_business_glossary_term' = 'Berth Planning Source System');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `planning_source` SET TAGS ('dbx_value_regex' = 'NAVIS_N4|TOPS_EXPERT|VTMS|MANUAL');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Berth Reservation Priority Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Berth Reservation Remarks');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `reservation_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Berth Reservation Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_value_regex' = '^BR[0-9]{10}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Berth Reservation Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'tentative|confirmed|occupied|departed|cancelled|no_show');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `reservation_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Updated Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Vessel Service Type');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'container|bulk|roro|general_cargo|tanker|cruise');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `tidal_window_required` SET TAGS ('dbx_business_glossary_term' = 'Tidal Window Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `towage_required` SET TAGS ('dbx_business_glossary_term' = 'Towage Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `under_keel_clearance_meters` SET TAGS ('dbx_business_glossary_term' = 'Under-Keel Clearance (UKC) in Meters');
ALTER TABLE `shipping_ports_ecm`.`booking`.`berth_reservation` ALTER COLUMN `weather_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Restriction Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` SET TAGS ('dbx_subdomain' = 'cargo_reservations');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `cargo_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Booking Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `cargo_category_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Category Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `commodity_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hs Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `contact_person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `demurrage_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `detention_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Detention Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `free_time_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Free Time Allowance Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `imdg_class_id` SET TAGS ('dbx_business_glossary_term' = 'Imdg Class Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Container Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Operator Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `un_locode_id` SET TAGS ('dbx_business_glossary_term' = 'Pol Un Locode Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `storage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `terminal_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `tertiary_cargo_notify_party_port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `tertiary_quaternary_cargo_freight_forwarder_port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `thc_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Thc Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `trade_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Restriction Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `call_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Booking Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `wharfage_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Wharfage Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `booking_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Confirmation Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|amended|cancelled|completed|no_show');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order (D/O) Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `delivery_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `feu_count` SET TAGS ('dbx_business_glossary_term' = 'Forty-foot Equivalent Unit (FEU) Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `is_dangerous_goods` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `is_oversized` SET TAGS ('dbx_business_glossary_term' = 'Oversized Cargo Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `is_overweight` SET TAGS ('dbx_business_glossary_term' = 'Overweight Cargo Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `pod_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge (POD) Code');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `pod_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'import|export|transshipment|empty_return');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'NAVIS_N4|PCS|TOPS|MANUAL');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `stowage_position` SET TAGS ('dbx_business_glossary_term' = 'Stowage Position (Bay-Row-Tier)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `stowage_position` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `temperature_setpoint_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint in Celsius');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`cargo_booking` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` SET TAGS ('dbx_subdomain' = 'cargo_reservations');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `slot_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Reservation Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `cargo_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Booking Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `imdg_class_id` SET TAGS ('dbx_business_glossary_term' = 'Imdg Class Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Line Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `terminal_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Rank');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Slot Allocation Source');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'shipping_line_nomination|terminal_allocation|auto_allocation|manual_override');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `bay_position` SET TAGS ('dbx_business_glossary_term' = 'Bay Position');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `cancelled_at` SET TAGS ('dbx_business_glossary_term' = 'Slot Cancelled At Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `confirmed_at` SET TAGS ('dbx_business_glossary_term' = 'Slot Confirmed At Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Expiry Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `final_destination` SET TAGS ('dbx_business_glossary_term' = 'Final Destination UN/LOCODE');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `oversize_indicator` SET TAGS ('dbx_business_glossary_term' = 'Out of Gauge (OOG) Oversize Indicator');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `oversize_indicator` SET TAGS ('dbx_value_regex' = 'standard|out_of_gauge|over_height|over_width|over_length');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `port_of_discharge` SET TAGS ('dbx_business_glossary_term' = 'Port of Discharge (POD) UN/LOCODE');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading (POL) UN/LOCODE');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `reefer_required` SET TAGS ('dbx_business_glossary_term' = 'Reefer Plug Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `reefer_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Reefer Set Temperature in Celsius');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Slot Reservation Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Reservation Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `reserved_at` SET TAGS ('dbx_business_glossary_term' = 'Slot Reserved At Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `restow_indicator` SET TAGS ('dbx_business_glossary_term' = 'Restow Indicator Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `row_position` SET TAGS ('dbx_business_glossary_term' = 'Row Position');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Container Seal Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `slot_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Slot Rate Amount');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `slot_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `slot_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Slot Rate Currency Code');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Container Slot Type');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `stowage_location` SET TAGS ('dbx_business_glossary_term' = 'Stowage Location');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `stowage_location` SET TAGS ('dbx_value_regex' = 'below_deck|on_deck|hatch_cover');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `teu_count` SET TAGS ('dbx_business_glossary_term' = 'Twenty-foot Equivalent Unit (TEU) Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `tier_position` SET TAGS ('dbx_business_glossary_term' = 'Tier Position');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `transshipment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Transshipment Indicator Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `verified_gross_mass_kg` SET TAGS ('dbx_business_glossary_term' = 'Verified Gross Mass (VGM) in Kilograms (kg)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `vgm_method` SET TAGS ('dbx_business_glossary_term' = 'Verified Gross Mass (VGM) Verification Method');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `vgm_method` SET TAGS ('dbx_value_regex' = 'method_1|method_2');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `vgm_verified_at` SET TAGS ('dbx_business_glossary_term' = 'Verified Gross Mass (VGM) Verified At Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `vgm_verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified Gross Mass (VGM) Verified By Party');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `weight_class` SET TAGS ('dbx_business_glossary_term' = 'Container Weight Class');
ALTER TABLE `shipping_ports_ecm`.`booking`.`slot_reservation` ALTER COLUMN `weight_class` SET TAGS ('dbx_value_regex' = 'light|medium|heavy|super_heavy');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` SET TAGS ('dbx_subdomain' = 'vessel_scheduling');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `pre_arrival_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Arrival Identifier');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `agent_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `berth_id` SET TAGS ('dbx_business_glossary_term' = 'Berth Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `contact_person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `facility_security_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Security Plan Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `flag_state_id` SET TAGS ('dbx_business_glossary_term' = 'Flag State Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isps Facility Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `un_locode_id` SET TAGS ('dbx_business_glossary_term' = 'Last Port Un Locode Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `pilotage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `port_dues_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Port Dues Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `port_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Port Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `towage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Towage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `call_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Booking Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `voyage_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Nomination Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `bunker_fuel_required` SET TAGS ('dbx_business_glossary_term' = 'Bunker Fuel Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `cargo_manifest_summary` SET TAGS ('dbx_business_glossary_term' = 'Cargo Manifest Summary');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `crew_count` SET TAGS ('dbx_business_glossary_term' = 'Crew Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `dangerous_goods_declaration` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Declaration');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `dangerous_goods_onboard` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Onboard Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `eta` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `etb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Berthing (ETB)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `etd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Departure (ETD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `fresh_water_required` SET TAGS ('dbx_business_glossary_term' = 'Fresh Water Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `health_declaration_remarks` SET TAGS ('dbx_business_glossary_term' = 'Health Declaration Remarks');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `health_declaration_remarks` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `health_declaration_remarks` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `health_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Health Declaration Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `health_declaration_status` SET TAGS ('dbx_value_regex' = 'clean|illness_reported|quarantine_required|inspection_pending');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `health_declaration_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `health_declaration_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Security Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `next_port_of_call` SET TAGS ('dbx_business_glossary_term' = 'Next Port of Call (POD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `pan_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pre-Arrival Notification (PAN) Reference Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Passenger Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `pilotage_required` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `port_health_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Port Health Clearance Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `port_health_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|inspection_required|quarantine|hold');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `port_health_clearance_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `port_health_clearance_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `security_declaration` SET TAGS ('dbx_business_glossary_term' = 'Security Declaration');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|approved|rejected|amended');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `total_cargo_weight_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Total Cargo Weight (Tonnes)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `total_teu` SET TAGS ('dbx_business_glossary_term' = 'Total Twenty-foot Equivalent Unit (TEU)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `towage_required` SET TAGS ('dbx_business_glossary_term' = 'Towage Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `vts_coordination_status` SET TAGS ('dbx_business_glossary_term' = 'Vessel Traffic Service (VTS) Coordination Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `vts_coordination_status` SET TAGS ('dbx_value_regex' = 'pending|coordinated|approved|rejected|rescheduled');
ALTER TABLE `shipping_ports_ecm`.`booking`.`pre_arrival` ALTER COLUMN `waste_disposal_required` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` SET TAGS ('dbx_subdomain' = 'berth_operations');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `truck_gate_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Gate Booking ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `access_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Access Credential Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `cargo_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Booking Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `container_preadvice_id` SET TAGS ('dbx_business_glossary_term' = 'Container Preadvice Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `customs_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `imdg_class_id` SET TAGS ('dbx_business_glossary_term' = 'Imdg Class Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Visit ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `port_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Port Gate Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `storage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `terminal_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `truck_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Appointment Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Trucking Company Port Community Participant Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `weighing_station_id` SET TAGS ('dbx_business_glossary_term' = 'Weighing Station Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Truck Arrival Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `appointment_time_slot_end` SET TAGS ('dbx_business_glossary_term' = 'Appointment Time Slot End');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `appointment_time_slot_start` SET TAGS ('dbx_business_glossary_term' = 'Appointment Time Slot Start');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Appointment Cancellation Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `cargo_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Cargo Weight in Kilograms (KG)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate Check-In Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `container_condition` SET TAGS ('dbx_business_glossary_term' = 'Container Condition');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `container_condition` SET TAGS ('dbx_value_regex' = 'full|empty|damaged');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `coparn_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Container Pre-Announcement (COPARN) Message Reference');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `driver_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Driver Contact Phone Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `driver_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `driver_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `dwell_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Terminal Dwell Time in Minutes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `gate_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Gate-Out Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `iftmin_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Instruction Message for Transport (IFTMIN) Reference');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `is_hazardous_cargo` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Cargo Indicator');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `is_oversize` SET TAGS ('dbx_business_glossary_term' = 'Oversize Cargo Indicator');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `is_refrigerated` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated Container Indicator');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Indicator');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `reefer_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Reefer Temperature Setting in Celsius');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `truck_license_plate` SET TAGS ('dbx_business_glossary_term' = 'Truck License Plate Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `truck_license_plate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `truck_license_plate` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`truck_gate_booking` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` SET TAGS ('dbx_subdomain' = 'vessel_scheduling');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `voyage_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Nomination Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Call Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `call_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Call Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `infrastructure_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `un_locode_id` SET TAGS ('dbx_business_glossary_term' = 'Last Port Un Locode Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `mooring_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Mooring Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `berth_id` SET TAGS ('dbx_business_glossary_term' = 'Nominated Berth Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Nominating Agent Port Community Participant Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `pilotage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `port_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Port Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Line Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `superseded_by_nomination_voyage_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Nomination Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `terminal_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Nominated Terminal Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `towage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Towage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Nomination Acceptance Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `empty_count` SET TAGS ('dbx_business_glossary_term' = 'Empty Container Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `export_teu` SET TAGS ('dbx_business_glossary_term' = 'Export Twenty-foot Equivalent Unit (TEU) Volume');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `hazmat_count` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials Container Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `import_teu` SET TAGS ('dbx_business_glossary_term' = 'Import Twenty-foot Equivalent Unit (TEU) Volume');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `next_port_of_call` SET TAGS ('dbx_business_glossary_term' = 'Next Port of Call');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nominated_eta` SET TAGS ('dbx_business_glossary_term' = 'Nominated Estimated Time of Arrival (ETA)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nominated_etb` SET TAGS ('dbx_business_glossary_term' = 'Nominated Estimated Time of Berthing (ETB)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nominated_etd` SET TAGS ('dbx_business_glossary_term' = 'Nominated Estimated Time of Departure (ETD)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nomination_number` SET TAGS ('dbx_business_glossary_term' = 'Nomination Reference Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nomination_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Nomination Received Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nomination_source` SET TAGS ('dbx_business_glossary_term' = 'Nomination Source Channel');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nomination_source` SET TAGS ('dbx_value_regex' = 'edi_coparn|edi_iftmin|pcs_portal|email|manual_entry|api');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_business_glossary_term' = 'Nomination Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_value_regex' = 'nominated|accepted|rejected|superseded|withdrawn|confirmed');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `oversized_count` SET TAGS ('dbx_business_glossary_term' = 'Oversized Container Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `pilotage_required` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `reefer_count` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated Container Count');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Nomination Rejection Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Nomination Rejection Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `restow_teu` SET TAGS ('dbx_business_glossary_term' = 'Restow Twenty-foot Equivalent Unit (TEU) Volume');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `special_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Requirements');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `total_moves` SET TAGS ('dbx_business_glossary_term' = 'Total Container Moves');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `towage_required` SET TAGS ('dbx_business_glossary_term' = 'Towage Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `transhipment_teu` SET TAGS ('dbx_business_glossary_term' = 'Transhipment Twenty-foot Equivalent Unit (TEU) Volume');
ALTER TABLE `shipping_ports_ecm`.`booking`.`voyage_nomination` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` SET TAGS ('dbx_subdomain' = 'berth_operations');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `service_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Requirement Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `berth_id` SET TAGS ('dbx_business_glossary_term' = 'Berth Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `call_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `contact_person_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `customs_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Port Community Participant Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `service_code_id` SET TAGS ('dbx_business_glossary_term' = 'Service Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `terminal_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `vessel_type_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `billing_reference` SET TAGS ('dbx_business_glossary_term' = 'Billing Reference Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type Required');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `equipment_type_required` SET TAGS ('dbx_value_regex' = 'sts_crane|mhc|rtg|agv|reach_stacker|forklift');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Service Cost');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Service Duration (Hours)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `imdg_class` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Class');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `imdg_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4|class_5|class_6');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `oog_cargo_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Gauge (OOG) Cargo Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `oog_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Out of Gauge (OOG) Dimensions');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|standard|urgent|critical');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'hours|units|moves|teu|containers|trips');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `reefer_humidity_required` SET TAGS ('dbx_business_glossary_term' = 'Reefer Humidity Required (Percentage)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `reefer_temperature_required` SET TAGS ('dbx_business_glossary_term' = 'Reefer Temperature Required (Celsius)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `requested_service_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `requested_service_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Requirement Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `requirement_number` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|cancelled');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'navis_n4|pcs|manual_entry|edi|api');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `vessel_dwt` SET TAGS ('dbx_business_glossary_term' = 'Vessel Deadweight Tonnage (DWT)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`service_requirement` ALTER COLUMN `vessel_loa` SET TAGS ('dbx_business_glossary_term' = 'Vessel Length Overall (LOA) in Meters');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` SET TAGS ('dbx_subdomain' = 'vessel_scheduling');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Booking Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `agent_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Agent Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Area Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_id` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `berth_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Berth Reservation Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `call_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Call Booking Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isps Facility Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `marsec_level_change_id` SET TAGS ('dbx_business_glossary_term' = 'Marsec Level Change Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `participant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `pilotage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Pilotage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Port Community Participant Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `port_dues_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Port Dues Schedule Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `towage_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Towage Tariff Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `weather_tide_window_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Tide Window Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Security Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `actual_anchor_drop_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Anchor Drop Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `actual_anchorage_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Anchorage Duration (Hours)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `actual_weigh_anchor_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Weigh Anchor Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Charge Amount');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Charge Currency');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Reason Code');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `anchorage_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Reason Description');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `booking_cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Cancelled Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `booking_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Confirmed Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Booking Reference Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `booking_reference_number` SET TAGS ('dbx_value_regex' = '^ANC-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `booking_requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Requested Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Booking Status');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `buoy_number` SET TAGS ('dbx_business_glossary_term' = 'Designated Buoy Number');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `buoy_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}-[0-9]{1,3}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `confirmed_anchor_drop_time` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Anchor Drop Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `confirmed_weigh_anchor_time` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Weigh Anchor Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `hazmat_cargo_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Cargo Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `imdg_class_codes` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Class Codes');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `pilot_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pilot Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `planned_anchorage_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Anchorage Duration (Hours)');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Anchorage Priority Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|priority|urgent|emergency');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `requested_anchor_drop_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Anchor Drop Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `requested_weigh_anchor_time` SET TAGS ('dbx_business_glossary_term' = 'Requested Weigh Anchor Time');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Level');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'VTMS|PCS|NAVIS|MANUAL');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `tug_assistance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Tug Assistance Required Flag');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `vts_coordination_reference` SET TAGS ('dbx_business_glossary_term' = 'Vessel Traffic Service (VTS) Coordination Reference');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `vts_coordination_reference` SET TAGS ('dbx_value_regex' = '^VTS-[0-9]{10}$');
ALTER TABLE `shipping_ports_ecm`.`booking`.`anchorage_booking` ALTER COLUMN `weather_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Restriction Flag');
