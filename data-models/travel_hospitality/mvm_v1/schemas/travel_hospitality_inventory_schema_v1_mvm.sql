-- Schema for Domain: inventory | Business: Travel Hospitality | Version: v1_mvm
-- Generated on: 2026-05-08 06:03:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `travel_hospitality_ecm`.`inventory` COMMENT 'Real-time room inventory management including room types, physical room attributes, availability, room status, housekeeping status, out-of-order designations, and inventory controls. Manages room blocks, allotments, overbooking limits, and LRA (Last Room Availability). Integrates with PMS (Oracle OPERA) and RMS (IDeaS G3) for dynamic inventory allocation across distribution channels. Tracks OCC and supports LOS-based controls.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`room_type` (
    `room_type_id` BIGINT COMMENT 'Primary key for room_type',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand standard compliance audits require knowing which room types belong to which brand portfolio. Brand managers define room type standards (bed configurations, square footage minimums) per brand tie',
    `franchise_agreement_id` BIGINT COMMENT 'Foreign key linking to property.franchise_agreement. Business justification: Franchise agreements specify brand standards for room type configurations (minimum square footage, required amenities, ADA compliance ratios). Brand standard audits verify room types against franchise',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Room types are associated with primary market segments for rate loading, revenue reporting, and RMS segmentation. Revenue management systems use room type-to-segment mapping for demand forecasting and',
    `property_id` BIGINT COMMENT 'Reference to the property where this room type is defined. Room types are property-specific configurations.',
    `accessibility_features` STRING COMMENT 'Comma-separated list of accessibility features available in this room type. Examples: roll-in shower, grab bars, visual alarm, hearing kit, lowered fixtures. Used for guest matching and compliance tracking.',
    `active_status` STRING COMMENT 'Current operational status of the room type. Inactive types are not available for new reservations. Seasonal types are active only during specific periods. Renovation types are temporarily unavailable.. Valid values are `active|inactive|seasonal|renovation`',
    `bathroom_configuration` STRING COMMENT 'Description of bathroom setup. Examples: single full bath, 1.5 bath, dual vanity, separate tub and shower. Used for guest expectations and competitive positioning.',
    `bed_count` STRING COMMENT 'Number of beds in the room type. Used for occupancy calculations and guest preference matching.',
    `bed_type` STRING COMMENT 'Primary bed configuration for the room type. Critical for guest preference matching and inventory allocation. [ENUM-REF-CANDIDATE: king|queen|double|twin|california_king|murphy|sofa_bed — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this room type record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this room type configuration expires or is replaced. Null for currently active configurations. Used for historical tracking and renovation planning.',
    `effective_start_date` DATE COMMENT 'Date when this room type configuration becomes effective. Used for managing room type changes, renovations, and new inventory rollouts.',
    `floor_level_range` STRING COMMENT 'Typical floor range where this room type is located. Examples: 1-5, 6-10, 15-20. Used for guest preference and accessibility planning.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether this room type meets ADA accessibility requirements including mobility, hearing, and visual accommodations. Required for compliance reporting and guest accessibility requests.',
    `is_connecting_eligible` BOOLEAN COMMENT 'Indicates whether this room type can be configured as a connecting room. Used for family and group booking allocation.',
    `is_suite` BOOLEAN COMMENT 'Indicates whether this room type is classified as a suite with separate living and sleeping areas. Used for inventory segmentation and revenue reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this room type record was last updated. Used for change tracking and data synchronization across PMS, RMS, and CRS systems.',
    `lra_eligible` BOOLEAN COMMENT 'Indicates whether this room type participates in Last Room Availability agreements with OTA partners. Critical for channel distribution and rate parity management.',
    `max_occupancy` STRING COMMENT 'Maximum number of guests allowed in this room type per fire code and property standards. Used for reservation validation and yield optimization.',
    `overbooking_allowed` BOOLEAN COMMENT 'Indicates whether this room type can be overbooked as part of revenue management strategy. Used by RMS for yield optimization.',
    `pseudo_room_flag` BOOLEAN COMMENT 'Indicates whether this is a pseudo room type used for inventory management purposes (e.g., house use, out of order, complimentary) rather than a sellable room type. Used for inventory controls and reporting exclusions.',
    `rate_category` STRING COMMENT 'Rate category classification used for revenue management and pricing strategy. Examples: BAR, Corporate, Government, Group, Promotional. Links to rate plan structures.',
    `room_class` STRING COMMENT 'High-level classification of the room type by service tier. Used for segmentation in revenue management and guest experience programs.. Valid values are `standard|deluxe|premium|suite|executive|luxury`',
    `room_features` STRING COMMENT 'Comma-separated list of key room features and amenities. Examples: balcony, kitchenette, fireplace, whirlpool, separate shower, walk-in closet. Used for guest communication and OTA distribution.',
    `room_type_code` STRING COMMENT 'Short alphanumeric code used to identify the room type in PMS and RMS systems. Examples: KING, QQDBL, JSUITE, PRES. This is the operational identifier used across reservations, inventory, and revenue management.. Valid values are `^[A-Z0-9]{2,10}$`',
    `room_type_description` STRING COMMENT 'Detailed marketing description of the room type including amenities, features, and guest experience highlights. Used for guest-facing channels and OTA distribution.',
    `room_type_name` STRING COMMENT 'Full descriptive name of the room type as displayed to guests and staff. Examples: Deluxe King, Queen Queen Double, Junior Suite, Presidential Suite.',
    `sellable_flag` BOOLEAN COMMENT 'Indicates whether this room type is available for sale to guests. Non-sellable types include staff rooms, maintenance rooms, and owner units.',
    `smoking_policy` STRING COMMENT 'Smoking policy for this room type. Most properties are non-smoking; some maintain designated smoking inventory.. Valid values are `non_smoking|smoking|both`',
    `sort_order` STRING COMMENT 'Display sequence for this room type in PMS screens, reports, and guest-facing channels. Lower numbers appear first.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the room type in square feet. Used for guest communication, competitive positioning, and property planning.',
    `standard_occupancy` STRING COMMENT 'Standard number of guests for this room type used for base rate calculations. Additional guests may incur extra person charges.',
    `view_category` STRING COMMENT 'Classification of the view from the room. Impacts pricing strategy and guest satisfaction. Used in revenue management for rate differentiation. [ENUM-REF-CANDIDATE: ocean|city|mountain|garden|pool|courtyard|no_view|partial — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_room_type PRIMARY KEY(`room_type_id`)
) COMMENT 'Master catalog of room types defined per property, including physical configuration (bed type, bed count, view category, square footage), maximum occupancy, accessibility features, ADA compliance status, connecting room eligibility, and suite classification. Serves as the foundational classification entity for all inventory management — availability, controls, blocks, allotments, channel distribution, and demand forecasting all reference room type as their primary dimension. Defined and maintained in Oracle OPERA PMS across luxury, premium, and select-service segments.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`room` (
    `room_id` BIGINT COMMENT 'Unique identifier for the physical room. Primary key. Authoritative SSOT for physical room identity in Oracle OPERA PMS.',
    `connecting_room_id` BIGINT COMMENT 'Identifier of the adjacent room that connects to this room via connecting door. Null if no connecting room.',
    `property_id` BIGINT COMMENT 'Identifier of the property (hotel, resort, or vacation property) where this room is located.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type classification (e.g., Standard King, Deluxe Suite, Executive Double) assigned to this room. Determines rate category and inventory grouping.',
    `ada_accessible` BOOLEAN COMMENT 'Indicates whether the room meets ADA accessibility standards including wheelchair access, grab bars, visual alarms, and accessible bathroom fixtures.',
    `balcony_available` BOOLEAN COMMENT 'Indicates whether the room has a private balcony or terrace. Premium feature used for rate differentiation.',
    `bed_count` STRING COMMENT 'Total number of beds in the room. Used for occupancy capacity and guest preferences.',
    `bed_type` STRING COMMENT 'Primary bed configuration in the room. Critical for guest preferences and room assignment. [ENUM-REF-CANDIDATE: king|queen|double|twin|california_king|murphy|sofa_bed — 7 candidates stripped; promote to reference product]',
    `building_code` STRING COMMENT 'Code identifying the building or tower within a multi-building property. Null for single-building properties.',
    `connecting_room_available` BOOLEAN COMMENT 'Indicates whether this room has a connecting door to an adjacent room. Used for family bookings and group assignments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this room record was first created in the system. Audit trail field.',
    `features` STRING COMMENT 'Comma-separated list of additional room features and amenities (e.g., minibar, safe, coffee maker, smart TV, work desk). Used for guest preference matching and marketing.',
    `ffe_condition_score` DECIMAL(18,2) COMMENT 'Condition assessment score for room furniture, fixtures, and equipment on a scale of 0.00 to 5.00. Used for CapEx planning and PIP prioritization.',
    `floor_number` STRING COMMENT 'The floor level where the room is located within the building. Used for housekeeping routing and guest preferences.',
    `front_office_status` STRING COMMENT 'Current front office occupancy state. Indicates whether the room is vacant, occupied by a guest, reserved for arrival, or blocked.. Valid values are `vacant|occupied|reserved|blocked`',
    `housekeeping_status` STRING COMMENT 'Current housekeeping state of the room. Updated by housekeeping staff and used for room assignment and availability.. Valid values are `clean|dirty|inspected|pickup|do_not_disturb`',
    `kitchenette_available` BOOLEAN COMMENT 'Indicates whether the room includes a kitchenette with cooking facilities. Common in extended-stay properties.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this room record was last updated. Used for change tracking and data synchronization.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent renovation or major refurbishment. Used for PIP (Property Improvement Plan) tracking and FF&E (Furniture Fixtures and Equipment) lifecycle management.',
    `lra_eligible` BOOLEAN COMMENT 'Indicates whether this room is eligible for Last Room Availability distribution to OTA partners. Used for channel distribution controls.',
    `max_occupancy` STRING COMMENT 'Maximum number of guests allowed in the room per fire code and property policy. Used for reservation validation.',
    `operational_status` STRING COMMENT 'Current operational state of the room. Determines whether the room is available for sale and occupancy. Lifecycle status field.. Valid values are `in_service|out_of_order|out_of_inventory|under_renovation`',
    `out_of_order_end_date` DATE COMMENT 'Expected date when the room will return to service. Used for inventory forecasting and revenue management.',
    `out_of_order_reason` STRING COMMENT 'Reason code or description for why the room is out of order. Null when room is in service. Used for maintenance tracking and OCC impact analysis.',
    `out_of_order_start_date` DATE COMMENT 'Date when the room was taken out of order. Used for revenue impact analysis and maintenance duration tracking.',
    `overbooking_eligible` BOOLEAN COMMENT 'Indicates whether this room can be included in overbooking calculations. Used by RMS for yield optimization.',
    `room_number` STRING COMMENT 'The externally-known room number displayed on the door and used for guest communication. Business identifier for the room.',
    `smoking_allowed` BOOLEAN COMMENT 'Indicates whether smoking is permitted in the room. Used for guest preference matching and inventory segmentation.',
    `square_footage` DECIMAL(18,2) COMMENT 'Total interior square footage of the room. Used for marketing, rate positioning, and guest selection criteria.',
    `view_type` STRING COMMENT 'Type of view from the room windows. Impacts rate positioning and guest satisfaction. Used for upsell opportunities. [ENUM-REF-CANDIDATE: ocean|city|mountain|garden|pool|courtyard|no_view — 7 candidates stripped; promote to reference product]',
    `wing_code` STRING COMMENT 'Code identifying the wing or section within a building. Used for operational routing and guest location preferences.',
    CONSTRAINT pk_room PRIMARY KEY(`room_id`)
) COMMENT 'Physical room master record representing each individual guestroom or suite at a property. Captures room number, floor, wing, building, room type assignment, physical attributes (square footage, bed configuration, connecting rooms), ADA accessibility status, smoking designation, view type, and current operational status. The authoritative SSOT for physical room identity in Oracle OPERA PMS.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`room_status` (
    `room_status_id` BIGINT COMMENT 'Primary key for room_status',
    `attendant_id` BIGINT COMMENT 'Identifier of the housekeeping staff member currently assigned to clean or service this room.',
    `guest_group_block_id` BIGINT COMMENT 'Foreign key linking to guest.guest_group_block. Business justification: Group room block management requires tracking which rooms are assigned to which blocks for rooming list fulfillment, pickup tracking, and block-specific housekeeping instructions. Front desk and house',
    `out_of_order_id` BIGINT COMMENT 'Foreign key linking to inventory.out_of_order. Business justification: When a room is placed Out-of-Order or Out-of-Service, the room_status record should reference the specific out_of_order record that caused the OOO designation. This creates a direct operational link b',
    `profile_id` BIGINT COMMENT 'Identifier of the guest currently occupying the room. Null if room is vacant.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the room is located. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the active reservation currently occupying the room. Null if room is vacant.',
    `room_block_id` BIGINT COMMENT 'Foreign key linking to inventory.room_block. Business justification: room_status tracks whether a room is_blocked (BOOLEAN) and has a blocked_reason (STRING). When a room is physically blocked for a group, the room_status record should reference the specific room_block',
    `room_id` BIGINT COMMENT 'Identifier of the physical room. Links to the room inventory master data.',
    `blocked_reason` STRING COMMENT 'Explanation of why the room is administratively blocked from sale (e.g., VIP hold, renovation, inventory control, group block).',
    `cleaning_type` STRING COMMENT 'Type of cleaning service required or last performed. Checkout: full cleaning after guest departure; Stayover: daily service for occupied room; Deep Clean: comprehensive periodic cleaning; Turndown: evening service; Refresh: light touch-up.. Valid values are `checkout|stayover|deep_clean|turndown|refresh`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this room status record was first created in the system.',
    `discrepancy_flag` BOOLEAN COMMENT 'Boolean flag indicating a mismatch between front desk status and housekeeping status (e.g., front desk shows vacant but housekeeping shows occupied). Requires investigation.',
    `discrepancy_notes` STRING COMMENT 'Free-text notes describing the nature of any status discrepancy and actions taken to resolve it.',
    `do_not_disturb_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the guest has activated the do not disturb indicator, preventing housekeeping and other staff from entering.',
    `expected_checkin_date` DATE COMMENT 'The scheduled check-in date for the next arriving guest. Used for due-in planning and housekeeping prioritization.',
    `expected_checkout_date` DATE COMMENT 'The scheduled checkout date for the current guest occupying the room. Used for due-out planning.',
    `front_desk_status` STRING COMMENT 'Current operational status from the front desk perspective. Vacant: unoccupied and available; Occupied: guest currently in residence; Reserved: booked for future arrival; Due Out: guest scheduled to check out today; Due In: guest scheduled to check in today; Out of Order: room unavailable for sale.. Valid values are `vacant|occupied|reserved|due_out|due_in|out_of_order`',
    `housekeeping_status` STRING COMMENT 'Current housekeeping state of the room indicating cleanliness and readiness. Dirty: needs full cleaning; Clean: cleaned but not inspected; Inspected: cleaned and quality-checked; Pickup: minor refresh needed; Out of Service: maintenance required; Do Not Disturb: guest requested no service.. Valid values are `dirty|clean|inspected|pickup|out_of_service|do_not_disturb`',
    `is_blocked` BOOLEAN COMMENT 'Boolean flag indicating whether the room is administratively blocked from sale (e.g., for renovation, VIP hold, or inventory control).',
    `is_clean` BOOLEAN COMMENT 'Boolean flag indicating whether the room has been cleaned and is ready for occupancy. True if housekeeping status is clean or inspected.',
    `is_inspected` BOOLEAN COMMENT 'Boolean flag indicating whether the room has passed housekeeping quality inspection after cleaning.',
    `is_out_of_order` BOOLEAN COMMENT 'Boolean flag indicating whether the room is out of order and unavailable for sale due to maintenance or other operational issues.',
    `last_cleaned_timestamp` TIMESTAMP COMMENT 'Date and time when the room was last cleaned by housekeeping staff.',
    `last_inspected_timestamp` TIMESTAMP COMMENT 'Date and time when the room last passed housekeeping quality inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this room status record was last modified in the system.',
    `last_occupied_timestamp` TIMESTAMP COMMENT 'Date and time when the room was last occupied by a guest (most recent check-in or last known occupancy).',
    `last_vacated_timestamp` TIMESTAMP COMMENT 'Date and time when the room was last vacated by a guest (most recent check-out).',
    `maintenance_status` STRING COMMENT 'Current maintenance condition of the room. Available: no maintenance issues; Minor Repair: small issues not blocking occupancy; Major Repair: significant issues requiring attention; Out of Order: room cannot be occupied; Scheduled Maintenance: planned preventive maintenance.. Valid values are `available|minor_repair|major_repair|out_of_order|scheduled_maintenance`',
    `occupancy_status` STRING COMMENT 'Simple binary occupancy indicator. Vacant: no guest assigned; Occupied: guest currently checked in; Reserved: future reservation exists.. Valid values are `vacant|occupied|reserved`',
    `priority_level` STRING COMMENT 'Housekeeping priority level for servicing this room. Urgent: immediate attention required (e.g., due-in within 1 hour); High: priority cleaning (e.g., VIP guest, early check-in); Normal: standard cleaning schedule; Low: can be deferred.. Valid values are `low|normal|high|urgent`',
    `special_instructions` STRING COMMENT 'Free-text special instructions for housekeeping staff regarding this room (e.g., guest allergies, VIP preferences, extra amenities required).',
    `status_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the room status was last updated in the system. Tracks the most recent status transition.',
    `turndown_service_status` STRING COMMENT 'Status of evening turndown service for the room. Not Requested: no turndown service scheduled; Requested: guest or property standard requires turndown; Completed: turndown service has been performed; Declined: guest declined turndown service.. Valid values are `not_requested|requested|completed|declined`',
    CONSTRAINT pk_room_status PRIMARY KEY(`room_status_id`)
) COMMENT 'Real-time operational status record for each physical room capturing the current housekeeping state (dirty, clean, inspected, pick-up), front-desk status (vacant, occupied, due-out, due-in), and maintenance flags. Tracks status transitions with timestamps, assigned housekeeper, last inspection time, and turndown service status. Integrates with Oracle OPERA PMS housekeeping module for live room status boards.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` (
    `availability_snapshot_id` BIGINT COMMENT 'Unique identifier for the availability snapshot record. Primary key for this entity.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: Availability snapshots capture actual rooms sold/available; demand forecasts predict future demand. Linking actuals to forecasts enables forecast accuracy measurement (MAPE calculation), model perform',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Revenue management and USALI period-close reporting require availability snapshots (occupancy rate, RevPAR inputs) to be aligned to fiscal periods. Finance and revenue teams run period-over-period occ',
    `inventory_control_id` BIGINT COMMENT 'Foreign key linking to revenue.inventory_control. Business justification: Availability snapshots are reconciled against active inventory control records for the same stay date and room type. Revenue managers use this link to verify that snapshot net available rooms align wi',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property for which this availability snapshot is recorded.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type (e.g., Standard King, Deluxe Suite) for which availability is tracked.',
    `closed_to_arrival_flag` BOOLEAN COMMENT 'Indicates whether new reservations are allowed to check in on this date. When true, no new arrivals are accepted, but existing multi-night stays can continue.',
    `closed_to_departure_flag` BOOLEAN COMMENT 'Indicates whether guests are allowed to check out on this date. When true, reservations must extend beyond this date to capture higher-value multi-night stays.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this availability snapshot record was first created in the data warehouse.',
    `discrepancy_notes` STRING COMMENT 'Free-text notes documenting any discrepancies found during reconciliation, including root cause and resolution actions.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether Last Room Availability is enabled for this room type on this date. When true, the property commits to selling rooms at contracted rates even if only one room remains.',
    `max_los_restriction` STRING COMMENT 'Maximum number of nights allowed for a reservation starting on this date. Used to prevent long stays during high-demand periods.',
    `min_los_restriction` STRING COMMENT 'Minimum number of nights required for a reservation starting on this date. Used for demand management and revenue optimization.',
    `net_available_rooms` STRING COMMENT 'Net number of rooms available to sell after accounting for all deductions (OOO, OOS, house use, blocks). Calculated as total physical rooms minus all unavailable and blocked rooms.',
    `occ_rate` DECIMAL(18,2) COMMENT 'Occupancy rate percentage for this room type on this date, calculated as (rooms sold + complimentary rooms) / net available rooms * 100. Key performance metric for revenue management.',
    `overbooking_limit` STRING COMMENT 'Maximum number of rooms that can be overbooked for this room type on this date, based on historical no-show and cancellation patterns. Used for yield optimization.',
    `reconciliation_status` STRING COMMENT 'Status of the nightly reconciliation process for this snapshot. Indicates whether the snapshot has been validated against PMS folios and room status.. Valid values are `reconciled|pending|discrepancy|manual_override`',
    `rooms_blocked_allotment` STRING COMMENT 'Number of rooms allocated to contracted allotments (OTA, wholesaler, corporate contracts) that are held but not yet sold.',
    `rooms_blocked_group` STRING COMMENT 'Number of rooms blocked for group reservations (MICE, corporate blocks) that are not yet sold but are held off general inventory.',
    `rooms_complimentary` STRING COMMENT 'Number of rooms occupied by complimentary guests (e.g., loyalty rewards, service recovery, VIP comps). Counted in occupancy but not in revenue.',
    `rooms_day_use` STRING COMMENT 'Number of rooms sold for day-use only (check-in and check-out on the same day), typically for meetings or short stays.',
    `rooms_house_use` STRING COMMENT 'Number of rooms occupied by hotel staff, contractors, or used for operational purposes (e.g., training, storage). Not available for sale.',
    `rooms_out_of_order` STRING COMMENT 'Number of rooms temporarily unavailable due to maintenance, repair, or refurbishment. These rooms are not available for sale.',
    `rooms_out_of_service` STRING COMMENT 'Number of rooms permanently or long-term unavailable due to major renovation, structural issues, or strategic decisions. Not available for sale.',
    `rooms_overbooked` STRING COMMENT 'Actual number of rooms overbooked (sold beyond physical capacity) for this room type on this date.',
    `rooms_sold` STRING COMMENT 'Number of rooms sold (occupied by paying guests) for this room type on this date. Used in OCC (Occupancy Rate) calculation.',
    `snapshot_date` DATE COMMENT 'The business date for which this availability snapshot is recorded. Represents the stay date, not the snapshot creation date.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The exact date and time when this availability snapshot was captured. Typically recorded during the nightly audit process.',
    `source_system` STRING COMMENT 'The system of record from which this availability snapshot was sourced. Typically Oracle OPERA PMS for operational data or IDeaS G3 RMS for forecasted availability.. Valid values are `OPERA_PMS|IDeaS_RMS|SynXis_CRS|Manual_Entry`',
    `stop_sell_flag` BOOLEAN COMMENT 'Indicates whether this room type is completely closed for sale on this date across all channels. When true, no new reservations are accepted.',
    `total_physical_rooms` STRING COMMENT 'Total number of physical rooms of this room type at the property, representing the maximum inventory capacity.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this availability snapshot record was last updated in the data warehouse.',
    CONSTRAINT pk_availability_snapshot PRIMARY KEY(`availability_snapshot_id`)
) COMMENT 'Date-level inventory availability record per room type per property capturing total physical rooms, rooms sold, rooms blocked (group and allotment), out-of-order rooms, out-of-service rooms, complimentary rooms, house-use rooms, day-use rooms, and net available rooms. The authoritative SSOT for real-time occupancy (OCC) calculation and available-to-sell inventory. Feeds IDeaS G3 RMS for yield optimization and supports LRA (Last Room Availability) flag tracking. Reconciled nightly during night audit against PMS folios and room status. Serves as the foundation for RevPAR, occupancy trending, and inventory reconciliation reporting.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`control` (
    `control_id` BIGINT COMMENT 'Primary key for control',
    `inventory_control_id` BIGINT COMMENT 'Unique identifier for the inventory control record. Primary key for the control entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Inventory controls (stop-sell, CTA/CTD, LOS restrictions) are often campaign-driven (flash sale requires 2-night minimum, member-exclusive rates with specific restrictions). Required for promotional r',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Inventory controls (stop-sell, min-LOS, CTA) are applied at the offer level to enforce promotional terms — e.g., a campaign offer requiring minimum 3-night stay triggers a min_los control. control has',
    `channel_id` BIGINT COMMENT 'Identifier of the distribution channel (OTA, GDS, Direct) to which this control applies. Null indicates control applies to all channels.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: Inventory control parameters (hurdle rates, sell limits) are set directly from demand forecast outputs. Linking control to the source forecast enables traceability of control decisions, forecast accur',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Segment-specific yield management is a core revenue process — hurdle rates, sell limits, and CTA restrictions are applied per guest segment. control.segment_code is a denormalized representation; a pr',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Inventory controls are frequently set at the market segment level (e.g., close group segment, restrict OTA). Revenue managers apply segment-specific controls for yield management; this FK enables segm',
    `property_id` BIGINT COMMENT 'Identifier of the property to which this inventory control applies.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Identifier of the rate plan to which this control applies. Null indicates control applies to all rate plans for the room type and date.',
    `room_block_id` BIGINT COMMENT 'Identifier of the group block that this control is associated with. Null if control is not tied to a specific group reservation.',
    `room_type_id` BIGINT COMMENT 'Identifier of the room type (e.g., Deluxe King, Standard Queen) to which this control applies.',
    `seasonal_calendar_id` BIGINT COMMENT 'Foreign key linking to property.seasonal_calendar. Business justification: Inventory controls (stop-sells, hurdle rates, min/max LOS) are set in direct response to seasonal demand classifications and blackout periods. Revenue managers need to trace which seasonal period drov',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to revenue.strategy. Business justification: Inventory controls (sell limits, hurdle rates, CTA/CTD flags) are set in execution of a revenue strategy. Linking control records to the governing strategy enables strategy performance attribution, au',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Inventory controls (sell limits, hurdles, stop-sell flags) are tier-differentiated in luxury hospitality. Properties set different availability rules for base vs platinum members. Revenue strategy req',
    `advance_booking_limit_days` STRING COMMENT 'Maximum number of days in advance that bookings can be made for this stay date. Null indicates no advance booking restriction.',
    `channel_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of total sell limit allocated to this specific channel. Used for channel-level inventory gating. Sum across all channels for a date should not exceed 100%.',
    `competitive_set_adr` DECIMAL(18,2) COMMENT 'Average Daily Rate of the competitive set (STR comp set) for comparable room types on this stay date. Used for competitive benchmarking.',
    `control_source` STRING COMMENT 'Origin of this control record. RMS indicates generated by IDeaS G3 RMS; manual indicates user override; API indicates external system integration.. Valid values are `rms|manual|api|bulk_upload`',
    `control_status` STRING COMMENT 'Current lifecycle status of this inventory control record. Active controls are enforced by PMS and CRS; inactive controls are ignored.. Valid values are `active|inactive|override|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory control record was first created in the system.',
    `cta_flag` BOOLEAN COMMENT 'Indicates whether new arrivals are prohibited on this date. True means guests cannot check in on this date, but existing reservations spanning this date are allowed.',
    `ctd_flag` BOOLEAN COMMENT 'Indicates whether departures are prohibited on this date. True means guests cannot check out on this date; used to enforce minimum stay through high-demand periods.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this record (hurdle_rate, forecast_adr, competitive_set_adr). Typically matches property base currency.. Valid values are `^[A-Z]{3}$`',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when this control becomes effective. Controls are typically pushed to distribution channels in advance of the stay date.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when this control expires and is no longer enforced. Null indicates control remains effective until explicitly superseded.',
    `hurdle_rate` DECIMAL(18,2) COMMENT 'Minimum acceptable rate (ADR) below which the room type should not be sold for this date. Used by revenue management to protect yield. Expressed in property currency.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether this room type participates in Last Room Availability programs with OTAs. True means OTAs can sell even when inventory is constrained, ensuring rate parity.',
    `max_los` STRING COMMENT 'Maximum number of consecutive nights a guest can book when this date is the arrival date. Null indicates no maximum stay restriction.',
    `min_advance_booking_days` STRING COMMENT 'Minimum number of days in advance that bookings must be made for this stay date. Used to prevent last-minute bookings during high-demand periods.',
    `min_los` STRING COMMENT 'Minimum number of consecutive nights a guest must book when this date is the arrival date. Null or 1 indicates no minimum stay restriction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory control record was last modified. Updated whenever any control parameter changes.',
    `overbooking_limit_absolute` STRING COMMENT 'Absolute number of rooms above physical inventory that can be sold. Alternative to percentage-based overbooking. Null if percentage method is used.',
    `overbooking_limit_pct` DECIMAL(18,2) COMMENT 'Percentage above physical inventory that can be sold to account for expected cancellations and no-shows. For example, 10.00 means allow 110% of physical rooms to be sold.',
    `override_reason` STRING COMMENT 'Free-text explanation provided by the user when manually overriding RMS-generated controls. Required when override_user_id is populated.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this control was last published to distribution channels (OTA, GDS, CRS). Null if control has not yet been distributed.',
    `reason_code` STRING COMMENT 'Business reason code explaining why this control was applied (e.g., HIGH_DEMAND, RENOVATION, GROUP_BLOCK, SEASONAL_CLOSURE). Used for diagnostic and reporting purposes.',
    `rgi_target` DECIMAL(18,2) COMMENT 'Target Revenue Generation Index for this stay date. RGI measures property performance relative to competitive set. Value of 100 means at-market performance.',
    `sell_limit` STRING COMMENT 'Maximum number of rooms of this type that can be sold for the stay date. Null indicates no limit. This is the primary inventory cap enforced by the PMS and CRS.',
    `stay_date` DATE COMMENT 'The specific date for which this inventory control is effective. Controls are date-specific and define sell constraints for a single night of stay.',
    `stop_sell_flag` BOOLEAN COMMENT 'Indicates whether all sales are stopped for this room type on this date. True means no new bookings are accepted regardless of availability. Overrides all other controls.',
    `walk_risk_tolerance` STRING COMMENT 'Revenue management tolerance for walking guests (relocating to another property due to overbooking). Higher tolerance allows more aggressive overbooking.. Valid values are `none|low|medium|high`',
    CONSTRAINT pk_control PRIMARY KEY(`control_id`)
) COMMENT 'Unified inventory control and restriction record defining all sell constraints per room type per stay date: sell limits, hurdle rates, minimum length-of-stay (MinLOS), maximum length-of-stay (MaxLOS), closed-to-arrival (CTA), closed-to-departure (CTD), stop-sell flags, overbooking limits (percentage and absolute), walk risk tolerance, and channel-level inventory gating rules. Generated by IDeaS G3 RMS and enforced in Oracle OPERA PMS and Sabre SynXis CRS. The single diagnostic target for answering why cant this room type be sold on this date? — consolidates all restriction types into one queryable entity. Supports HTNG inventory control message standards and dynamic allocation across OTA, GDS, and direct channels.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`room_block` (
    `room_block_id` BIGINT COMMENT 'Unique identifier for the room block record. Primary key.',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Room blocks originate through a specific booking source (direct sales, GDS, OTA). The plain-text booking_source column is a denormalization of booking_source. A proper FK enables channel-level group b',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Group blocks are often created for marketing campaigns (wedding packages, corporate incentive programs, event promotions). Required for attributing group revenue to campaigns, measuring campaign ROI i',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Group room blocks are frequently created in conjunction with specific promotional offers (group rate packages, meeting planner offers). room_block has campaign_id but not campaign_offer_id. Offer-leve',
    `event_booking_id` BIGINT COMMENT 'Reference to the associated event or group booking that this room block supports.',
    `event_group_block_id` BIGINT COMMENT 'Foreign key linking to event.event_group_block. Business justification: Block reconciliation process: revenue managers must reconcile the inventory-side room_block against the event-side event_group_block to validate contracted vs. available room nights. A direct FK enabl',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Group room block revenue recognition and budget vs. actual group revenue reporting require blocks to be tied to fiscal periods. Finance teams reconcile contracted vs. picked-up group room nights by fi',
    `group_evaluation_id` BIGINT COMMENT 'Foreign key linking to revenue.group_evaluation. Business justification: Group evaluations assess displacement and revenue impact before accepting blocks. Linking blocks to originating evaluations enables post-booking performance review, wash factor validation, and revenue',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Group blocks generate revenue recognition entries, attrition penalty postings, and deposit liability tracking that must post to specific GL accounts per USALI chart of accounts. Revenue managers need ',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Room blocks are classified by market segment (group, SMERF, corporate) for displacement analysis, revenue mix reporting, and pace tracking. Revenue managers require segment attribution on every block ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Group blocks for loyalty events, tier-specific promotions, and member appreciation weekends require tracking the owning member. Revenue management needs this for commission tracking, tier credit alloc',
    `negotiated_rate_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_negotiated_rate. Business justification: Corporate and consortia group blocks are priced against a specific negotiated rate agreement. This FK enables contract compliance tracking, rate loading verification, and committed room night reconcil',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the room block is allocated.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Group block contracting requires linking the block to the specific rate plan used for pricing. Revenue managers load group rates against a rate plan; this FK enables rate compliance auditing and group',
    `seasonal_calendar_id` BIGINT COMMENT 'Foreign key linking to property.seasonal_calendar. Business justification: Group room blocks are evaluated for displacement against seasonal demand forecasts. Revenue managers run group displacement analysis by season to decide whether to accept group business. Linking room_',
    `attrition_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount charged to the group if pickup falls below the attrition threshold. Expressed in property base currency.',
    `attrition_percentage` DECIMAL(18,2) COMMENT 'Contractual percentage threshold below which the group incurs attrition penalties for unmet room night commitments. Expressed as percentage (e.g., 20.00 for 20%).',
    `available_room_nights` STRING COMMENT 'Remaining number of room nights still available for pickup within the block.',
    `block_code` STRING COMMENT 'Unique alphanumeric code identifying the room block, used for reservations and reporting. Externally-known identifier for group bookings.. Valid values are `^[A-Z0-9]{3,20}$`',
    `block_name` STRING COMMENT 'Descriptive name of the room block, typically including the group or event name for easy identification.',
    `block_status` STRING COMMENT 'Current lifecycle status of the room block: tentative (pending confirmation), definite (confirmed and contracted), waitlist (pending availability), cancelled (terminated), released (inventory returned), completed (event concluded).. Valid values are `tentative|definite|waitlist|cancelled|released|completed`',
    `block_type` STRING COMMENT 'Classification of the room block by purpose: group (general group travel), event (MICE events), corporate (business contracts), tour (tour operators), wedding (social events), conference (meeting-focused).. Valid values are `group|event|corporate|tour|wedding|conference`',
    `cancellation_policy` STRING COMMENT 'Text description of the cancellation terms and penalties applicable to the room block.',
    `cancellation_reason` STRING COMMENT 'Text description explaining the reason for room block cancellation, used for lost business analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the room block was cancelled, if applicable.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Commission rate percentage payable to intermediaries or group organizers for the block. Expressed as percentage (e.g., 10.00 for 10%).',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the room block status changed from tentative to definite (confirmed).',
    `contracted_room_nights` STRING COMMENT 'Total number of room nights contracted across all room types and dates in the block agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the room block record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the block (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cutoff_date` DATE COMMENT 'Date by which the group must pick up reserved rooms or release them back to general inventory. Also known as release date.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Monetary deposit amount required to secure the block, expressed in property base currency.',
    `deposit_due_date` DATE COMMENT 'Date by which the deposit payment must be received to maintain the block reservation.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a deposit is required to secure the room block.',
    `end_date` DATE COMMENT 'Last date of the room block period when rooms are reserved for the group or event.',
    `internal_notes` STRING COMMENT 'Confidential internal notes and comments for hotel staff regarding the room block management and service delivery.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether the block has Last Room Availability commitment, meaning the group rate applies even if only one room remains available.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the room block record was last modified.',
    `overbooking_allowed_flag` BOOLEAN COMMENT 'Indicates whether the block allows overbooking beyond contracted room nights.',
    `owner_email` STRING COMMENT 'Primary email address of the block owner for communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Full name of the primary contact or decision-maker responsible for the room block on the client side.',
    `owner_phone` STRING COMMENT 'Primary contact phone number of the block owner.',
    `picked_up_room_nights` STRING COMMENT 'Cumulative number of room nights actually reserved and consumed from the block by guests.',
    `pickup_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of contracted room nights that have been picked up (reserved). Expressed as percentage (e.g., 85.50 for 85.5%).',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requirements, preferences, or requests associated with the room block (e.g., room location preferences, amenities, accessibility needs).',
    `start_date` DATE COMMENT 'First date of the room block period when rooms are reserved for the group or event.',
    CONSTRAINT pk_room_block PRIMARY KEY(`room_block_id`)
) COMMENT 'Group or event room block record reserving a contracted quantity of rooms by room type for a defined date range and pickup period. Captures block code, block name, group/event association, contracted room-nights by type and date, cumulative pickup, release/cutoff dates, attrition percentage and penalty terms, wash factor, and block status lifecycle (tentative, definite, cancelled, released). Links to group reservations and event contracts. Supports group inventory management, attrition tracking, and block release decisions in Oracle OPERA PMS and Delphi by Amadeus.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` (
    `block_pickup_id` BIGINT COMMENT 'Unique identifier for the daily block pickup tracking record.',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Group block pickup must be tracked by booking source for channel-level pickup pace reporting and commission calculations. booking_channel_code is a plain-text denormalization of booking_source; replac',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate or event account that owns this group block contract.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: Block pickup pace reporting compares actual pickup against demand forecast projections for the same stay date and room type. Revenue managers use this link for automated pickup variance calculation an',
    `event_group_block_id` BIGINT COMMENT 'Foreign key linking to event.event_group_block. Business justification: Group pickup pace reporting: event sales managers track daily pickup against the contracted event group block. Linking block_pickup directly to event_group_block enables event-level pickup pace dashbo',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Block pickup pace reporting is performed by fiscal period to compare actual vs. budgeted group room revenue. Finance and revenue management use pickup data aligned to fiscal periods for period-close g',
    `group_evaluation_id` BIGINT COMMENT 'Foreign key linking to revenue.group_evaluation. Business justification: Block pickup tracking measures actual performance against group evaluation forecasts. Linking enables wash factor accuracy measurement, displacement cost validation, and RMS model tuning—essential for',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Block pickup is segmented by market for revenue mix and pace reporting. Revenue managers track group pickup velocity by segment to identify underperforming segments and adjust strategy. `market_segmen',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the block pickup occurred.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Block pickup pace reporting tracks rooms picked up against a specific rate plan to measure group revenue realization. Revenue management systems compare pickup ADR to the contracted rate plan; this FK',
    `room_block_id` BIGINT COMMENT 'Reference to the parent group room block contract for which pickup is being tracked.',
    `room_type_id` BIGINT COMMENT 'Reference to the specific room type (e.g., King Deluxe, Double Queen) for which pickup is tracked.',
    `block_status` STRING COMMENT 'The current lifecycle status of the group block for this stay date and room type.. Valid values are `active|tentative|definite|released|cancelled|completed`',
    `contracted_rooms` STRING COMMENT 'The total number of rooms committed in the original group block contract for this room type and stay date.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this block pickup record was first created in the system.',
    `cumulative_pickup` STRING COMMENT 'The total cumulative number of rooms picked up from the block from contract inception through the current pickup date.',
    `cutoff_date` DATE COMMENT 'The contractual date by which the group must pick up rooms or release unused inventory back to general availability.',
    `days_to_arrival` STRING COMMENT 'The number of days remaining from the pickup date until the stay date, used to assess booking window and release timing.',
    `displacement_cost` DECIMAL(18,2) COMMENT 'The estimated revenue opportunity cost of accepting this group block instead of selling rooms to higher-rated transient guests.',
    `group_code` STRING COMMENT 'The unique alphanumeric code assigned to the group block in the PMS for identification and reservation linking.',
    `is_lra_eligible` BOOLEAN COMMENT 'Indicates whether this block is eligible for Last Room Availability, meaning the group can book rooms even when the hotel is sold out.',
    `net_pickup` STRING COMMENT 'The adjusted pickup count after applying wash factor, representing the expected actual occupied rooms from the block.',
    `pickup_date` DATE COMMENT 'The date on which this pickup measurement was captured or calculated, representing the snapshot date for reporting.',
    `pickup_notes` STRING COMMENT 'Free-text notes or comments regarding pickup performance, release decisions, or special circumstances for this block and stay date.',
    `pickup_pace_variance` STRING COMMENT 'The difference between current year pickup and prior year pickup at the same point in time, indicating booking pace trend.',
    `pickup_percentage` DECIMAL(18,2) COMMENT 'The percentage of contracted rooms that have been picked up, calculated as (rooms_picked_up / contracted_rooms) * 100.',
    `pickup_rate` DECIMAL(18,2) COMMENT 'The negotiated room rate (ADR) for rooms picked up from this block, used for revenue calculation and forecasting.',
    `pickup_revenue` DECIMAL(18,2) COMMENT 'The total room revenue generated from picked-up rooms, calculated as rooms_picked_up multiplied by pickup_rate.',
    `pickup_variance` STRING COMMENT 'The difference between actual rooms picked up and contracted rooms (rooms_picked_up minus contracted_rooms), indicating over or under performance.',
    `prior_year_pickup` STRING COMMENT 'The number of rooms picked up for the same group or comparable group at the same point in time last year, used for pace analysis.',
    `released_rooms` STRING COMMENT 'The number of rooms from the block that have been released back to general inventory due to non-pickup or cutoff date passage.',
    `remaining_block_rooms` STRING COMMENT 'The number of rooms still available in the block that have not yet been picked up (contracted minus picked up).',
    `rooms_picked_up` STRING COMMENT 'The number of rooms from the block that have been reserved or booked by group attendees as of the pickup date.',
    `stay_date` DATE COMMENT 'The specific calendar date for which block pickup is being measured. This is the guest arrival or occupancy date.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this block pickup record was last modified or refreshed.',
    `wash_factor` DECIMAL(18,2) COMMENT 'The percentage of block rooms expected to cancel or no-show, used to adjust net pickup forecasts and overbooking strategies.',
    CONSTRAINT pk_block_pickup PRIMARY KEY(`block_pickup_id`)
) COMMENT 'Daily pickup tracking record for group room blocks capturing rooms picked up per room type per stay date against the contracted block. Tracks cumulative pickup, remaining block availability, pickup pace versus prior year, and variance to contracted rooms. Supports group revenue management decisions and block release timing in Oracle OPERA PMS and IDeaS G3.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` (
    `out_of_order_id` BIGINT COMMENT 'Primary key for out_of_order',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: OOO room financial impact (lost revenue estimates, actual repair costs, insurance claims) must be reported by fiscal period for period-close financial statements. Finance teams require OOO records tie',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: OOO room records are frequently caused by a specific fixed asset failure (HVAC, plumbing, elevator). Linking OOO to fixed_asset enables capex/maintenance cost tracking, asset impairment analysis, and ',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the room is located.',
    `room_id` BIGINT COMMENT 'Identifier of the specific physical room that is out-of-order or out-of-service.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: OOO records triggered by guest complaints (guest_impacted_flag, relocation_required_flag) reference the originating service case. Facilities and guest services teams use this link for SLA compliance r',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for repairs, maintenance, or renovation work. Captured upon work order completion for financial reconciliation and FF&E tracking.',
    `actual_return_date` DATE COMMENT 'Actual date when the room was returned to sellable inventory and made available for guest occupancy. Null if still out-of-order.',
    `actual_return_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the room was returned to sellable inventory, including time of day for accurate inventory restoration tracking.',
    `ada_compliance_flag` BOOLEAN COMMENT 'Indicates whether the out-of-order condition affects an ADA-compliant accessible room, requiring special handling for guest accommodation and compliance tracking.',
    `approved_by_name` STRING COMMENT 'Name of the manager or supervisor who approved the out-of-order designation for audit trail and accountability.',
    `closed_by_name` STRING COMMENT 'Name of the staff member who closed the out-of-order record and verified the room is ready for guest occupancy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this out-of-order record was first created in the system. Used for audit trail and operational reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duration_days` STRING COMMENT 'Total number of days the room was out-of-order or out-of-service, calculated from start date to actual return date. Used for RevPAR and occupancy impact analysis.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost in local currency for repairs, maintenance, or renovation work required to return the room to service. Used for CapEx and OpEx planning.',
    `expected_return_date` DATE COMMENT 'Planned or estimated date when the room is expected to be returned to sellable inventory after repairs or maintenance are completed.',
    `guest_impacted_flag` BOOLEAN COMMENT 'Indicates whether a guest reservation was impacted by this out-of-order designation (True if guest had to be relocated or reservation cancelled).',
    `impact_on_occ` DECIMAL(18,2) COMMENT 'Percentage point impact on property occupancy rate due to this room being out-of-order. Used for STR reporting and competitive benchmarking.',
    `impact_on_revpar` DECIMAL(18,2) COMMENT 'Calculated impact on property RevPAR due to this room being out-of-order. Critical metric for revenue management and performance analysis.',
    `lost_revenue_estimate` DECIMAL(18,2) COMMENT 'Estimated revenue loss due to the room being unavailable for sale during the out-of-order period. Calculated using ADR and occupancy forecasts for RevPAR impact analysis.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the out-of-order condition and repair work.',
    `ooo_code` STRING COMMENT 'Standardized code representing the reason category for the room being out-of-order or out-of-service (e.g., MAINT, REPAIR, RENO, DAMAGE, INSPECT).',
    `ooo_reason` STRING COMMENT 'Detailed textual description of the specific reason the room is out-of-order or out-of-service (e.g., plumbing leak, HVAC failure, carpet replacement, pest control treatment).',
    `ooo_status` STRING COMMENT 'Designation type: OOO (Out-of-Order - not counted in available inventory) or OOS (Out-of-Service - counted in inventory but not sold). Follows USALI standards for inventory accounting.. Valid values are `OOO|OOS`',
    `priority_level` STRING COMMENT 'Urgency level assigned to the repair or maintenance work (Critical, High, Medium, Low). Critical priority indicates immediate revenue impact or safety concern.. Valid values are `Critical|High|Medium|Low`',
    `record_status` STRING COMMENT 'Current lifecycle status of the out-of-order record (Open - newly reported, In Progress - work underway, Completed - room returned to service, Cancelled - designation reversed).. Valid values are `Open|In Progress|Completed|Cancelled`',
    `relocation_required_flag` BOOLEAN COMMENT 'Indicates whether guest relocation to another room or property was required due to this out-of-order condition. Used for service recovery tracking.',
    `reported_by_name` STRING COMMENT 'Name of the staff member who reported the out-of-order condition for operational tracking and accountability.',
    `responsible_department` STRING COMMENT 'Department responsible for addressing the issue and returning the room to service (e.g., Housekeeping, Maintenance, Engineering, Facilities, Renovation). [ENUM-REF-CANDIDATE: Housekeeping|Maintenance|Engineering|Facilities|Renovation|Pest Control|Safety|Quality Assurance — 8 candidates stripped; promote to reference product]',
    `safety_concern_flag` BOOLEAN COMMENT 'Indicates whether the out-of-order condition involves a safety or health hazard requiring immediate attention per OSHA or local safety regulations.',
    `start_date` DATE COMMENT 'Date when the room was first designated as out-of-order or out-of-service and removed from sellable inventory.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the room was designated as out-of-order or out-of-service, including time of day for accurate inventory impact tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this out-of-order record was last modified. Used for audit trail and change tracking.',
    `work_order_number` STRING COMMENT 'Reference number of the maintenance or repair work order associated with this out-of-order designation. Links to work order management system.',
    CONSTRAINT pk_out_of_order PRIMARY KEY(`out_of_order_id`)
) COMMENT 'Out-of-Order (OOO) and Out-of-Service (OOS) designation record for individual rooms removed from sellable inventory. Captures OOO/OOS reason code, start date, expected return-to-service date, actual return date, responsible department, work order reference, and impact on RevPAR. Distinguishes between OOO (not counted in available inventory) and OOS (counted but not sold) per USALI standards. Managed in Oracle OPERA PMS.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`allotment` (
    `allotment_id` BIGINT COMMENT 'Unique identifier for the channel or partner allotment record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Channel allotments are frequently tied to co-marketing campaigns with OTAs or wholesalers (Expedia exclusive inventory for joint promotions). Essential for tracking channel partnership performance, re',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Promotional allotments are created for specific campaign offers (e.g., early-bird packages, seasonal promotions). allotment already has campaign_id but not campaign_offer_id. Offer-level allotment tra',
    `channel_contract_id` BIGINT COMMENT 'Foreign key linking to channel.channel_contract. Business justification: Allotments are contractually governed by channel agreements (e.g., wholesale allotments defined in OTA or travel agent contracts). Linking allotment to channel_contract enables contract compliance tra',
    `channel_id` BIGINT COMMENT 'Reference to the distribution channel, Online Travel Agency (OTA), Global Distribution System (GDS), tour operator, wholesale partner, or corporate account to which this allotment is allocated.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Travel agency and corporate allotments are contracted with specific accounts. Revenue management needs this link for contract compliance monitoring, allotment utilization reporting, commission calcula',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Channel allotments are managed by sales/distribution departments with dedicated cost center budgets for channel management labor, technology costs, and commission expenses. Essential for departmental ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Allotment performance (sold vs. allocated rooms, commission accruals) is reviewed by fiscal period for channel revenue recognition and period-close reporting. Finance teams reconcile allotment-driven ',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Allotments are created for specific guest segments (leisure, corporate, wholesale). Linking allotment to guest_segment supports segment-level allotment performance reporting and enables marketing team',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Allotments are assigned to market segments (wholesale, consortia, corporate) for channel revenue reporting and segment mix analysis. Revenue managers require segment attribution on allotments to produ',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Room allotments are created to protect inventory capacity for specific experience programs (e.g., honeymoon suite packages, wellness retreat allotments). Revenue management and experience operations t',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Loyalty promotions (e.g., Double Points Weekend, Stay 3 Pay 2) require dedicated room allotments to guarantee inventory availability for qualifying members. Revenue management creates allotments d',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this allotment applies.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Reference to the rate plan associated with this allotment, defining the pricing structure and rate rules for bookings made through this channel or partner. Nullable if rate is managed separately.',
    `room_type_id` BIGINT COMMENT 'Reference to the room type (e.g., Standard King, Deluxe Suite) for which this allotment is defined.',
    `seasonal_calendar_id` BIGINT COMMENT 'Foreign key linking to property.seasonal_calendar. Business justification: Allotments are negotiated and structured around seasonal demand periods. Revenue managers tie allotment contracts to seasonal calendar periods to evaluate performance against seasonal demand classific',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Tier-restricted allotments are a core loyalty benefit fulfillment mechanism — certain room allotments (e.g., suite blocks) are reserved exclusively for Platinum/Gold tier members as part of guaranteed',
    `activated_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment was activated and made available for bookings. Nullable if not yet activated.',
    `adjustment_trigger_enabled` BOOLEAN COMMENT 'Indicates whether performance-based automatic adjustment of the allotment quantity is enabled (True) or disabled (False). When enabled, the allotment quantity may be increased or decreased based on sell-through performance.',
    `allocated_quantity` STRING COMMENT 'The total number of rooms pre-allocated to the channel or partner for the specified room type and date range.',
    `allotment_code` STRING COMMENT 'Unique business identifier or code for the allotment, used for tracking and reporting purposes in the Central Reservation System (CRS) and Property Management System (PMS).. Valid values are `^[A-Z0-9]{3,20}$`',
    `allotment_name` STRING COMMENT 'Descriptive name for the allotment (e.g., Expedia Summer Block, Corporate XYZ Annual Contract).',
    `allotment_status` STRING COMMENT 'Current lifecycle status of the allotment: active (currently in use), inactive (not currently active), suspended (temporarily halted), expired (past end date), or pending (awaiting activation).. Valid values are `active|inactive|suspended|expired|pending`',
    `allotment_type` STRING COMMENT 'Classification of the allotment by partner type: channel (generic distribution channel), OTA (Online Travel Agency), GDS (Global Distribution System), wholesale (wholesale partner), corporate (corporate account), group (group booking block), or tour_operator (tour operator allocation). [ENUM-REF-CANDIDATE: channel|ota|gds|wholesale|corporate|group|tour_operator — 7 candidates stripped; promote to reference product]',
    `auto_release_enabled` BOOLEAN COMMENT 'Indicates whether unsold allotment inventory is automatically released back to general inventory when the release period is reached (True) or requires manual release (False).',
    `available_quantity` STRING COMMENT 'The number of rooms remaining available in this allotment (calculated as allocated_quantity minus sold_quantity).',
    `booking_window_end_days` STRING COMMENT 'The maximum number of days before arrival that bookings can be made from this allotment. For example, 365 means bookings can be made up to 365 days in advance. Nullable if no maximum booking window applies.',
    `booking_window_start_days` STRING COMMENT 'The minimum number of days before arrival that bookings can be made from this allotment. For example, 1 means bookings can be made starting 1 day before arrival. Nullable if no minimum booking window applies.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'The commission percentage paid to the channel or partner for bookings made through this allotment. For example, 15.00 represents a 15% commission.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the legal contract or agreement governing this allotment arrangement with the channel or partner.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment record was first created in the Central Reservation System (CRS).',
    `end_date` DATE COMMENT 'The last date on which this allotment is effective. Nullable for open-ended allotments.',
    `expired_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment expired and was no longer available for bookings. Nullable if not yet expired.',
    `freesale_enabled` BOOLEAN COMMENT 'Indicates whether the channel or partner can sell beyond the allocated quantity by accessing general inventory (True) or is restricted to the allocated quantity only (False). Freesale allows partners to sell from the hotels available inventory without a fixed allotment limit.',
    `freesale_threshold_quantity` STRING COMMENT 'The minimum number of rooms that must remain available in general inventory before freesale access is restricted or disabled for this allotment. Nullable if freesale is not enabled.',
    `lra_enabled` BOOLEAN COMMENT 'Indicates whether Last Room Availability (LRA) is enabled for this allotment, allowing the channel or partner to sell the last available room at the property (True) or restricting access when inventory is low (False).',
    `max_los` STRING COMMENT 'The maximum number of nights a guest can book when reserving from this allotment. Nullable if no maximum Length of Stay (LOS) restriction applies.',
    `min_los` STRING COMMENT 'The minimum number of nights a guest must book when reserving from this allotment. Nullable if no minimum Length of Stay (LOS) restriction applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this allotment, including special terms, conditions, or operational instructions.',
    `overbooking_limit` STRING COMMENT 'The maximum number of rooms that can be overbooked for this allotment beyond the allocated quantity, used for yield optimization and revenue management. Nullable if overbooking is not permitted.',
    `performance_threshold_percent` DECIMAL(18,2) COMMENT 'The minimum sell-through percentage required to maintain or increase the allotment quantity. For example, 80.00 means the partner must sell at least 80% of the allocated rooms to avoid reduction. Nullable if no performance threshold applies.',
    `priority_rank` STRING COMMENT 'The priority ranking of this allotment relative to other allotments for the same room type and date range. Lower numbers indicate higher priority for inventory allocation. Used by Revenue Management System (RMS) for dynamic allocation.',
    `release_period_days` STRING COMMENT 'The number of days before the arrival date by which unsold allotment inventory must be released back to general inventory. For example, a 7-day release period means unsold rooms are returned to the hotel 7 days before arrival.',
    `sold_quantity` STRING COMMENT 'The number of rooms from this allotment that have been sold or reserved by the channel or partner.',
    `start_date` DATE COMMENT 'The first date on which this allotment becomes effective and inventory is allocated to the channel or partner.',
    `suspended_timestamp` TIMESTAMP COMMENT 'The date and time when this allotment was suspended or temporarily halted. Nullable if never suspended.',
    CONSTRAINT pk_allotment PRIMARY KEY(`allotment_id`)
) COMMENT 'Channel or partner allotment record defining a pre-allocated inventory quota for a specific distribution channel, OTA, tour operator, wholesale partner, or corporate account. Captures allotment quantity by room type and date range, release period (days before arrival), auto-release rules, sell-through/freesale thresholds, performance-based adjustment triggers, and channel-specific rate linkage. Managed in Sabre SynXis CRS for real-time channel distribution and inventory allocation across OTA, GDS, and wholesale partners.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` (
    `room_amenity_id` BIGINT COMMENT 'Unique identifier for the room amenity record. Primary key for the room amenity catalog.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand standard audits require tracking which amenities are mandated per brand. Brand managers define amenity standards (toiletry brands, pillow menus, technology) per brand tier. Linking room_amenity ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Premium room amenities (TVs, furniture, artwork) meeting capitalization thresholds are tracked as fixed assets requiring depreciation schedules, useful life tracking, and CapEx budget management. Esse',
    `inventory_item_id` BIGINT COMMENT 'Foreign key linking to fnb.inventory_item. Business justification: Minibar replenishment and in-room F&B cost tracking: room amenities that are consumable F&B items (minibar stock) must reference the fnb inventory_item catalog to trigger stock depletion transactions,',
    `parent_room_amenity_id` BIGINT COMMENT 'Self-referencing FK on room_amenity (parent_room_amenity_id)',
    `property_id` BIGINT COMMENT 'Identifier of the property where this amenity is available. Links to the property master data.',
    `room_id` BIGINT COMMENT 'Identifier of the specific physical room where this amenity is installed. Null if amenity is defined at room type level only.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: room_amenity product description states amenities are available by room type and individual room. Currently only has FK to room (room_id). Many amenities are defined at room_type level (e.g., all De',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Premium amenities (welcome gifts, pillow menus, turndown service) are tier-gated benefits in loyalty programs. Housekeeping and front desk operations require knowing which amenities are restricted to ',
    `amenity_category` STRING COMMENT 'High-level classification of the amenity type for inventory management and guest preference tracking. [ENUM-REF-CANDIDATE: technology|bathroom|bedding|minibar|furniture|climate_control|entertainment|connectivity — 8 candidates stripped; promote to reference product]',
    `amenity_code` STRING COMMENT 'Standardized code identifying the amenity type. Used for system integration and reporting consistency across properties.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `amenity_description` STRING COMMENT 'Detailed description of the amenity including brand, model, features, and guest-facing benefits. Used for marketing and guest communication.',
    `amenity_name` STRING COMMENT 'Business-friendly name of the amenity as displayed to guests and staff. Examples: Smart TV, Minibar, Espresso Machine, Premium Bedding.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Price charged to guest if amenity is consumed or used. Null for complimentary amenities. Used for minibar items and premium services.',
    `condition_status` STRING COMMENT 'Current physical condition of the amenity as assessed during last inspection. Drives maintenance and replacement decisions.. Valid values are `excellent|good|fair|poor|needs_replacement`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Required when unit_cost is populated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this amenity record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Required when charge_amount is populated.. Valid values are `^[A-Z]{3}$`',
    `display_sequence` STRING COMMENT 'Sort order for displaying amenities in guest-facing interfaces and reports. Lower numbers appear first.',
    `effective_end_date` DATE COMMENT 'Date after which this amenity configuration is no longer active. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this amenity configuration becomes active and available for guest use or booking display.',
    `guest_visible_flag` BOOLEAN COMMENT 'Indicates whether this amenity is displayed in guest-facing channels such as booking engines, mobile apps, and property websites. Used for marketing and distribution.',
    `installation_date` DATE COMMENT 'Date when the amenity was installed or placed in the room. Used for tracking asset age and planning replacement cycles.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether the amenity meets ADA accessibility requirements. Critical for compliance and guest accommodation matching.',
    `is_complimentary` BOOLEAN COMMENT 'Indicates whether the amenity is provided at no additional charge to the guest. False indicates a chargeable amenity such as minibar items.',
    `is_eco_friendly` BOOLEAN COMMENT 'Indicates whether the amenity meets environmental sustainability standards. Used for green certification programs and guest preference matching.',
    `is_premium_amenity` BOOLEAN COMMENT 'Indicates whether this amenity is considered a premium or luxury feature that differentiates the room type and justifies higher ADR (Average Daily Rate).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or condition assessment of the amenity. Critical for quality assurance and guest satisfaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this amenity record was most recently updated. Used for change tracking and synchronization.',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between scheduled maintenance or inspection cycles for this amenity. Used for preventive maintenance scheduling.',
    `model_number` STRING COMMENT 'Manufacturer model number or SKU for the amenity. Used for procurement, warranty tracking, and replacement ordering.',
    `next_scheduled_replacement_date` DATE COMMENT 'Planned date for replacing or refreshing the amenity based on lifecycle policy. Supports proactive FF&E capital planning.',
    `operational_status` STRING COMMENT 'Current operational availability of the amenity. Inactive or out_of_service amenities are not available to guests.. Valid values are `active|inactive|out_of_service|pending_installation|removed`',
    `purchase_order_number` STRING COMMENT 'Purchase order reference number for the amenity acquisition. Used for financial reconciliation and audit trails.',
    `quantity` STRING COMMENT 'Number of units of this amenity present in the room or room type. Example: 2 for pillows, 1 for minibar.',
    `special_instructions` STRING COMMENT 'Free-text field for operational notes, handling instructions, or guest communication guidelines related to the amenity.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Acquisition cost per unit of the amenity. Used for CapEx (Capital Expenditure) tracking and ROI (Return on Investment) analysis.',
    `unit_of_measure` STRING COMMENT 'Unit in which the amenity quantity is measured. Used for inventory tracking and replenishment.. Valid values are `each|set|pair|bottle|package`',
    `warranty_expiration_date` DATE COMMENT 'Date when manufacturer warranty coverage expires. Important for cost planning and vendor relationship management.',
    CONSTRAINT pk_room_amenity PRIMARY KEY(`room_amenity_id`)
) COMMENT 'Master catalog of in-room amenities and features available by room type and individual room, including minibar contents, technology amenities (smart TV, Bluetooth speaker), bathroom fixtures, and premium bedding configurations. Tracks amenity installation date, condition, and replacement schedule.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_connecting_room_id` FOREIGN KEY (`connecting_room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ADD CONSTRAINT `fk_inventory_room_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_out_of_order_id` FOREIGN KEY (`out_of_order_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`out_of_order`(`out_of_order_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ADD CONSTRAINT `fk_inventory_room_status_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ADD CONSTRAINT `fk_inventory_availability_snapshot_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ADD CONSTRAINT `fk_inventory_control_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_room_block_id` FOREIGN KEY (`room_block_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_block`(`room_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ADD CONSTRAINT `fk_inventory_block_pickup_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ADD CONSTRAINT `fk_inventory_out_of_order_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ADD CONSTRAINT `fk_inventory_allotment_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_parent_room_amenity_id` FOREIGN KEY (`parent_room_amenity_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_amenity`(`room_amenity_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_room_id` FOREIGN KEY (`room_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room`(`room_id`);
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ADD CONSTRAINT `fk_inventory_room_amenity_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `travel_hospitality_ecm`.`inventory`.`room_type`(`room_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `travel_hospitality_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `travel_hospitality_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Identifier');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `franchise_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|renovation');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `bathroom_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bathroom Configuration');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `floor_level_range` SET TAGS ('dbx_business_glossary_term' = 'Floor Level Range');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is ADA (Americans with Disabilities Act) Compliant');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `is_connecting_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Connecting Eligible');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `is_suite` SET TAGS ('dbx_business_glossary_term' = 'Is Suite');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `lra_eligible` SET TAGS ('dbx_business_glossary_term' = 'LRA (Last Room Availability) Eligible');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `overbooking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `pseudo_room_flag` SET TAGS ('dbx_business_glossary_term' = 'Pseudo Room Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `rate_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Category');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_class` SET TAGS ('dbx_business_glossary_term' = 'Room Class');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_class` SET TAGS ('dbx_value_regex' = 'standard|deluxe|premium|suite|executive|luxury');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_features` SET TAGS ('dbx_business_glossary_term' = 'Room Features');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_type_description` SET TAGS ('dbx_business_glossary_term' = 'Room Type Description');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `room_type_name` SET TAGS ('dbx_business_glossary_term' = 'Room Type Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `sellable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sellable Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_business_glossary_term' = 'Smoking Policy');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `smoking_policy` SET TAGS ('dbx_value_regex' = 'non_smoking|smoking|both');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `standard_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupancy');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_type` ALTER COLUMN `view_category` SET TAGS ('dbx_business_glossary_term' = 'View Category');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `connecting_room_id` SET TAGS ('dbx_business_glossary_term' = 'Connecting Room ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `ada_accessible` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Accessible');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `balcony_available` SET TAGS ('dbx_business_glossary_term' = 'Balcony Available');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `bed_type` SET TAGS ('dbx_business_glossary_term' = 'Bed Type');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `connecting_room_available` SET TAGS ('dbx_business_glossary_term' = 'Connecting Room Available');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `features` SET TAGS ('dbx_business_glossary_term' = 'Room Features');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `ffe_condition_score` SET TAGS ('dbx_business_glossary_term' = 'FF&E (Furniture Fixtures and Equipment) Condition Score');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `front_office_status` SET TAGS ('dbx_business_glossary_term' = 'Front Office Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `front_office_status` SET TAGS ('dbx_value_regex' = 'vacant|occupied|reserved|blocked');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_value_regex' = 'clean|dirty|inspected|pickup|do_not_disturb');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `kitchenette_available` SET TAGS ('dbx_business_glossary_term' = 'Kitchenette Available');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `lra_eligible` SET TAGS ('dbx_business_glossary_term' = 'LRA (Last Room Availability) Eligible');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_order|out_of_inventory|under_renovation');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `out_of_order_end_date` SET TAGS ('dbx_business_glossary_term' = 'Out of Order End Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `out_of_order_reason` SET TAGS ('dbx_business_glossary_term' = 'Out of Order Reason');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `out_of_order_start_date` SET TAGS ('dbx_business_glossary_term' = 'Out of Order Start Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `overbooking_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Eligible');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `smoking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Smoking Allowed');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `view_type` SET TAGS ('dbx_business_glossary_term' = 'View Type');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room` ALTER COLUMN `wing_code` SET TAGS ('dbx_business_glossary_term' = 'Wing Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `room_status_id` SET TAGS ('dbx_business_glossary_term' = 'Room Status Identifier');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Housekeeper ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `out_of_order_id` SET TAGS ('dbx_business_glossary_term' = 'Out Of Order Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Current Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Current Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Room Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Type');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_value_regex' = 'checkout|stayover|deep_clean|turndown|refresh');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `do_not_disturb_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Disturb (DND) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `expected_checkin_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Check-In Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `expected_checkout_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Checkout Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `front_desk_status` SET TAGS ('dbx_business_glossary_term' = 'Front Desk Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `front_desk_status` SET TAGS ('dbx_value_regex' = 'vacant|occupied|reserved|due_out|due_in|out_of_order');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `housekeeping_status` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|pickup|out_of_service|do_not_disturb');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Blocked Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `is_clean` SET TAGS ('dbx_business_glossary_term' = 'Is Clean Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `is_inspected` SET TAGS ('dbx_business_glossary_term' = 'Is Inspected Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `is_out_of_order` SET TAGS ('dbx_business_glossary_term' = 'Is Out of Order (OOO) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `last_cleaned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaned Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `last_inspected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inspected Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `last_occupied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Occupied Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `last_vacated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Vacated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'available|minor_repair|major_repair|out_of_order|scheduled_maintenance');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'vacant|occupied|reserved');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `status_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `turndown_service_status` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_status` ALTER COLUMN `turndown_service_status` SET TAGS ('dbx_value_regex' = 'not_requested|requested|completed|declined');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `availability_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Availability Snapshot ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `inventory_control_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Control Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `closed_to_arrival_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Arrival (CTA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `closed_to_departure_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Departure (CTD) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `max_los_restriction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS) Restriction');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `min_los_restriction` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS) Restriction');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `net_available_rooms` SET TAGS ('dbx_business_glossary_term' = 'Net Available Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `occ_rate` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Rate (OCC)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy|manual_override');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_blocked_allotment` SET TAGS ('dbx_business_glossary_term' = 'Rooms Blocked for Allotment');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_blocked_group` SET TAGS ('dbx_business_glossary_term' = 'Rooms Blocked for Groups');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_day_use` SET TAGS ('dbx_business_glossary_term' = 'Day Use Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_house_use` SET TAGS ('dbx_business_glossary_term' = 'House Use Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_out_of_order` SET TAGS ('dbx_business_glossary_term' = 'Rooms Out of Order (OOO)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_out_of_service` SET TAGS ('dbx_business_glossary_term' = 'Rooms Out of Service (OOS)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_overbooked` SET TAGS ('dbx_business_glossary_term' = 'Rooms Overbooked');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `rooms_sold` SET TAGS ('dbx_business_glossary_term' = 'Rooms Sold');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OPERA_PMS|IDeaS_RMS|SynXis_CRS|Manual_Entry');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `stop_sell_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Sell Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `total_physical_rooms` SET TAGS ('dbx_business_glossary_term' = 'Total Physical Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`availability_snapshot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` SET TAGS ('dbx_subdomain' = 'availability_control');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `inventory_control_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Control ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `seasonal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Calendar Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Strategy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `advance_booking_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Limit Days');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `channel_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Channel Allocation Percentage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `competitive_set_adr` SET TAGS ('dbx_business_glossary_term' = 'Competitive Set Average Daily Rate (ADR)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `control_source` SET TAGS ('dbx_business_glossary_term' = 'Control Source');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `control_source` SET TAGS ('dbx_value_regex' = 'rms|manual|api|bulk_upload');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|override|suspended');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `cta_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Arrival (CTA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `ctd_flag` SET TAGS ('dbx_business_glossary_term' = 'Closed to Departure (CTD) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Hurdle Rate');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `max_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (MaxLOS)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `min_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking Days');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `min_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (MinLOS)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `overbooking_limit_absolute` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Absolute');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `overbooking_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit Percentage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Control Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `rgi_target` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generation Index (RGI) Target');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `sell_limit` SET TAGS ('dbx_business_glossary_term' = 'Sell Limit');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `stay_date` SET TAGS ('dbx_business_glossary_term' = 'Stay Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `stop_sell_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Sell Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `walk_risk_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Walk Risk Tolerance');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`control` ALTER COLUMN `walk_risk_tolerance` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Room Block ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `event_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Event Group Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `group_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Group Evaluation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `negotiated_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Negotiated Rate Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `seasonal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Calendar Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `attrition_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Attrition Penalty Amount');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `attrition_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Percentage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `available_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Available Room Nights');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Block Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `block_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'tentative|definite|waitlist|cancelled|released|completed');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'group|event|corporate|tour|wedding|conference');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `cancellation_policy` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `contracted_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Contracted Room Nights');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Block End Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `overbooking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Email');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Phone');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `picked_up_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Picked Up Room Nights');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pickup Percentage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_block` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Block Start Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `block_pickup_id` SET TAGS ('dbx_business_glossary_term' = 'Block Pickup ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `event_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Event Group Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `group_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Group Evaluation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'active|tentative|definite|released|cancelled|completed');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `contracted_rooms` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `cumulative_pickup` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Pickup');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `days_to_arrival` SET TAGS ('dbx_business_glossary_term' = 'Days to Arrival (DTA)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `displacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Displacement Cost');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `is_lra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `net_pickup` SET TAGS ('dbx_business_glossary_term' = 'Net Pickup');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `pickup_date` SET TAGS ('dbx_business_glossary_term' = 'Pickup Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `pickup_notes` SET TAGS ('dbx_business_glossary_term' = 'Pickup Notes');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `pickup_pace_variance` SET TAGS ('dbx_business_glossary_term' = 'Pickup Pace Variance');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `pickup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pickup Percentage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `pickup_rate` SET TAGS ('dbx_business_glossary_term' = 'Pickup Rate');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `pickup_revenue` SET TAGS ('dbx_business_glossary_term' = 'Pickup Revenue');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `pickup_variance` SET TAGS ('dbx_business_glossary_term' = 'Pickup Variance');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `prior_year_pickup` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Pickup');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `released_rooms` SET TAGS ('dbx_business_glossary_term' = 'Released Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `remaining_block_rooms` SET TAGS ('dbx_business_glossary_term' = 'Remaining Block Rooms');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `rooms_picked_up` SET TAGS ('dbx_business_glossary_term' = 'Rooms Picked Up');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `stay_date` SET TAGS ('dbx_business_glossary_term' = 'Stay Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`block_pickup` ALTER COLUMN `wash_factor` SET TAGS ('dbx_business_glossary_term' = 'Wash Factor');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `out_of_order_id` SET TAGS ('dbx_business_glossary_term' = 'Out Of Order Identifier');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return-to-Service Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `actual_return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Return-to-Service Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `ada_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Manager Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `closed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Closed By Staff Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Duration in Days');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return-to-Service Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `guest_impacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Impacted Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `impact_on_occ` SET TAGS ('dbx_business_glossary_term' = 'Impact on Occupancy (OCC) Percentage');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `impact_on_revpar` SET TAGS ('dbx_business_glossary_term' = 'Impact on Revenue Per Available Room (RevPAR)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `lost_revenue_estimate` SET TAGS ('dbx_business_glossary_term' = 'Lost Revenue Estimate');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `lost_revenue_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Notes');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `ooo_code` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `ooo_reason` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Reason Description');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `ooo_status` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Status Type');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `ooo_status` SET TAGS ('dbx_value_regex' = 'OOO|OOS');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'Open|In Progress|Completed|Cancelled');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `relocation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Relocation Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Staff Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `safety_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Concern Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Start Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Order (OOO) Start Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`out_of_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` SET TAGS ('dbx_subdomain' = 'block_allotment');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allotment_id` SET TAGS ('dbx_business_glossary_term' = 'Allotment Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `channel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Contract Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Allotment Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `seasonal_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Calendar Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `adjustment_trigger_enabled` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Trigger Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allotment_code` SET TAGS ('dbx_business_glossary_term' = 'Allotment Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allotment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allotment_name` SET TAGS ('dbx_business_glossary_term' = 'Allotment Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allotment_status` SET TAGS ('dbx_business_glossary_term' = 'Allotment Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allotment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `allotment_type` SET TAGS ('dbx_business_glossary_term' = 'Allotment Type');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `auto_release_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Release Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `booking_window_end_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End (Days)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `booking_window_start_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start (Days)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (Percent)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allotment End Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `expired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expired Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `freesale_enabled` SET TAGS ('dbx_business_glossary_term' = 'Freesale Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `freesale_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Freesale Threshold Quantity');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `lra_enabled` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `max_los` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `min_los` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allotment Notes');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `performance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold (Percent)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `release_period_days` SET TAGS ('dbx_business_glossary_term' = 'Release Period (Days)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `sold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sold Quantity');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allotment Start Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`allotment` ALTER COLUMN `suspended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Suspended Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` SET TAGS ('dbx_subdomain' = 'room_configuration');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `inventory_item_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Item Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `parent_room_amenity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `amenity_category` SET TAGS ('dbx_business_glossary_term' = 'Amenity Category');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `amenity_code` SET TAGS ('dbx_business_glossary_term' = 'Amenity Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `amenity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `amenity_description` SET TAGS ('dbx_business_glossary_term' = 'Amenity Description');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `amenity_name` SET TAGS ('dbx_business_glossary_term' = 'Amenity Name');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|needs_replacement');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `guest_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Visible Flag');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is ADA (Americans with Disabilities Act) Compliant');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `is_complimentary` SET TAGS ('dbx_business_glossary_term' = 'Is Complimentary');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `is_eco_friendly` SET TAGS ('dbx_business_glossary_term' = 'Is Eco-Friendly');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `is_premium_amenity` SET TAGS ('dbx_business_glossary_term' = 'Is Premium Amenity');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Days');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `next_scheduled_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Replacement Date');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|out_of_service|pending_installation|removed');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|set|pair|bottle|package');
ALTER TABLE `travel_hospitality_ecm`.`inventory`.`room_amenity` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
