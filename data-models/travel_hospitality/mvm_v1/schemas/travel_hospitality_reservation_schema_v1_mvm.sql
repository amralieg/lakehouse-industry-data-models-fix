-- Schema for Domain: reservation | Business: Travel Hospitality | Version: v1_mvm
-- Generated on: 2026-05-08 06:03:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `travel_hospitality_ecm`.`reservation` COMMENT 'Core transactional domain managing the full booking lifecycle from inquiry through confirmation, modification, cancellation, and no-show management. Handles individual reservations, group blocks, and corporate bookings across all channels (direct, OTA, GDS, CRS). Tracks booking status, arrival/departure dates, room types, rate codes, special requests, and guarantee methods. Integrates with Oracle OPERA PMS and Sabre SynXis CRS.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` (
    `reservation_booking_id` BIGINT COMMENT 'Unique identifier for the reservation booking record. Primary key for the reservation_booking product. System-generated surrogate key used across all downstream systems and analytics.',
    `booking_source_id` BIGINT COMMENT 'Foreign key reference to the booking source channel through which this reservation was created (direct website, OTA, GDS, phone, walk-in, corporate portal, etc.). Used for channel attribution and commission calculation.',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Reservations made under promotional offers (advance purchase, member exclusive) must be directly linked to the offer for offer performance reporting, yield management, and compliance with offer terms.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: reservation_booking currently stores cancellation_policy_code as a denormalized STRING. The cancellation_policy table is the authoritative reference master for cancellation terms in this domain. Addin',
    `corporate_account_id` BIGINT COMMENT 'Foreign key reference to the corporate account if this reservation is booked under a negotiated corporate rate agreement. Used for corporate billing and rate compliance auditing.',
    `market_segment_id` BIGINT COMMENT 'Foreign key reference to the market segment classification for this reservation (transient, group, corporate, leisure, government, etc.). Used for revenue management segmentation and forecasting.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty points posting, tier-based rate eligibility, and VIP service delivery at booking all require a direct FK to the loyalty member record. loyalty_member_number is a denormalized surrogate; replac',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the guest master record who is the primary guest on this reservation. Links to guest profile containing contact information, preferences, and loyalty status.',
    `property_id` BIGINT COMMENT 'Foreign key reference to the property where this reservation is booked. Links to property master containing location, brand, segment, and operational details.',
    `reservation_group_block_id` BIGINT COMMENT 'Foreign key reference to the group block if this reservation is part of a group booking (conference, wedding, corporate event, etc.). Null for individual FIT reservations.',
    `reservation_rate_plan_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_rate_plan. Business justification: A reservation booking is made under a specific reservation-domain rate plan (the bookable rate plan catalog presented to guests and agents). reservation_booking already has a cross-domain revenue_rate',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Booking-to-room-type FK is essential for availability checking, rate loading, upgrade eligibility, and RevPAR reporting by room type. Every PMS links a booking to the requested room type as a proper F',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to revenue.strategy. Business justification: Bookings are made under an active revenue strategy (compression, shoulder-night push, etc.). Linking booking to strategy enables strategy effectiveness reporting — did bookings materialize at target A',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Tier at time of booking drives upgrade eligibility, benefit entitlement, and points multiplier application. Revenue management and front-desk systems require the members tier captured at booking to a',
    `travel_agent_id` BIGINT COMMENT 'Foreign key linking to reservation.travel_agent. Business justification: Reservation_booking currently references travel agent via travel_agent_iata_number (string business key). Normalizing to FK using travel_agent_id allows joining to get full agent details (agency_name,',
    `accessibility_required_flag` BOOLEAN COMMENT 'Indicates whether the guest has requested an ADA-compliant accessible room. Used for room assignment and compliance with Americans with Disabilities Act requirements.',
    `arrival_date` DATE COMMENT 'Scheduled date the guest is expected to check in to the property. Used for occupancy forecasting, revenue projections, and operational planning (housekeeping, staffing).',
    `average_daily_rate` DECIMAL(18,2) COMMENT 'Average nightly room rate for this reservation, calculated as total_room_revenue divided by (length_of_stay * number_of_rooms). Core KPI for revenue management and competitive benchmarking.',
    `booking_date` DATE COMMENT 'Date the reservation was originally created in the system. Used to calculate booking lead time, pickup analysis, and demand forecasting accuracy.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the reservation. Tracks progression from initial booking through completion or cancellation. Updated by PMS based on guest actions and property operations. [ENUM-REF-CANDIDATE: confirmed|tentative|waitlisted|cancelled|no_show|checked_in|checked_out — 7 candidates stripped; promote to reference product]',
    `booking_timestamp` TIMESTAMP COMMENT 'Precise date and time the reservation was created, including timezone. Principal business event timestamp for this transaction. Used for channel performance analysis and real-time availability updates.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time the reservation was cancelled, if applicable. Null for active reservations. Used to calculate cancellation rates and revenue displacement analysis.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total commission payable to the booking channel or travel agent for this reservation. Calculated based on commission schedule and total room revenue.',
    `confirmation_number` STRING COMMENT 'Externally-facing alphanumeric confirmation code provided to the guest at time of booking. Used by guests to retrieve, modify, or cancel their reservation. Unique across all properties and channels.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this reservation record was first created in the data warehouse. Used for data lineage and audit trail. Distinct from booking_timestamp which represents the business event time.',
    `crs_confirmation_number` STRING COMMENT 'Confirmation number generated by Sabre SynXis CRS for reservations originating through the central reservation system. Used for cross-system reconciliation and channel attribution.. Valid values are `^[A-Z0-9]{8,16}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this reservation (e.g., USD, EUR, GBP). Used for multi-currency reporting and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `departure_date` DATE COMMENT 'Scheduled date the guest is expected to check out from the property. Used to calculate length of stay and room availability for subsequent bookings.',
    `early_checkin_requested_flag` BOOLEAN COMMENT 'Indicates whether the guest has requested early check-in (before standard check-in time). Used for operational planning and guest service recovery.',
    `guarantee_method` STRING COMMENT 'Method by which the reservation is guaranteed against no-show. Determines cancellation policy enforcement and revenue recognition timing.. Valid values are `credit_card|deposit|corporate_account|travel_agent_voucher|prepaid|none`',
    `late_checkout_requested_flag` BOOLEAN COMMENT 'Indicates whether the guest has requested late check-out (after standard check-out time). Used for housekeeping scheduling and room availability management.',
    `length_of_stay` STRING COMMENT 'Number of nights the guest is booked to stay, calculated as departure_date minus arrival_date. Key metric for revenue management, ALOS calculation, and yield optimization.',
    `modification_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to this reservation (date change, rate change, guest change, etc.). Used for audit trail and change tracking.',
    `number_of_adults` STRING COMMENT 'Count of adult guests (typically age 18+) included in this reservation. Used for occupancy reporting, F&B forecasting, and compliance with fire safety regulations.',
    `number_of_children` STRING COMMENT 'Count of child guests (typically under age 18) included in this reservation. Used for amenity planning, F&B forecasting, and family-friendly service delivery.',
    `number_of_rooms` STRING COMMENT 'Count of rooms reserved under this booking. Typically 1 for individual reservations; may be greater than 1 for multi-room bookings or small groups.',
    `package_code` STRING COMMENT 'Code representing a bundled package offering if this reservation includes additional services beyond room only (e.g., breakfast included, spa credit, parking, resort fee). Null for room-only bookings.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payment_method` STRING COMMENT 'Primary payment instrument used to guarantee or settle this reservation. Distinct from payment channel (web, mobile, front desk). [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|bank_transfer|mobile_payment|loyalty_points|corporate_billing — 7 candidates stripped; promote to reference product]',
    `pms_reservation_code` STRING COMMENT 'Native reservation identifier from Oracle OPERA PMS. Used for operational lookups and integration with front desk, housekeeping, and cashiering modules.. Valid values are `^[A-Z0-9]{8,20}$`',
    `points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this reservation. Calculated based on room revenue, member tier, and promotional multipliers.',
    `special_requests` STRING COMMENT 'Free-text field capturing guest special requests at time of booking (e.g., high floor, near elevator, extra pillows, early check-in). Used by operations to enhance guest experience.',
    `total_room_revenue` DECIMAL(18,2) COMMENT 'Total room revenue for this reservation across all nights, before taxes and fees. Calculated as nightly rate multiplied by length of stay and number of rooms. Key component of RevPAR and ADR calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this reservation record was last updated in the data warehouse. Used for incremental ETL processing and change data capture.',
    `vip_status_flag` BOOLEAN COMMENT 'Indicates whether this reservation is flagged for VIP treatment (high-value guest, loyalty elite member, celebrity, executive, etc.). Triggers enhanced service protocols and amenities.',
    CONSTRAINT pk_reservation_booking PRIMARY KEY(`reservation_booking_id`)
) COMMENT 'Core master record for an individual guest reservation across all booking channels (direct, OTA, GDS, CRS via Sabre SynXis). Captures the full booking lifecycle from inquiry through confirmation, modification, cancellation, and no-show. Stores arrival/departure dates, LOS (Length of Stay), room type requested, rate code, BAR/LRA/NRR rate plan, guarantee method, booking status, source channel, CRS confirmation number, OPERA PMS reservation ID, number of adults/children, and special request flags. SSOT for reservation identity across the enterprise.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` (
    `booking_status_history_id` BIGINT COMMENT 'Primary key for booking_status_history',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key reference to the parent reservation record. Links this status history event to the specific booking being tracked.',
    `agent_name` STRING COMMENT 'The name of the agent or system user who performed the action. Denormalized for audit trail completeness and reporting convenience.',
    `booking_source_code` STRING COMMENT 'The specific source within the channel (e.g., EXPEDIA, BOOKING_COM, BRAND_WEBSITE, CALL_CENTER). Provides granular attribution for the event.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `cancellation_reason_code` STRING COMMENT 'For cancellation events, the specific reason code (e.g., GUEST_CANCEL, WEATHER, EMERGENCY, DUPLICATE_BOOKING, RATE_ISSUE). Null for non-cancellation events.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `channel_code` STRING COMMENT 'The distribution channel through which this event was initiated (e.g., DIRECT, OTA, GDS, CRS, VOICE, WALK_IN, MOBILE_APP). Denormalized for audit completeness.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `confirmation_number` STRING COMMENT 'The externally-known unique confirmation number for the reservation. Denormalized from parent reservation for audit trail completeness and query performance.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this history record was created in the data warehouse. This is the ETL load time, distinct from event_timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this event is associated with a guest dispute or service recovery case. True if disputed, False otherwise.',
    `event_date` DATE COMMENT 'The calendar date of the event, extracted from event_timestamp for simplified date-based reporting and partitioning.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when this lifecycle event occurred in the source system. This is the business event time, not the ETL load time.',
    `event_type` STRING COMMENT 'Discriminator indicating the category of lifecycle event: status_change (status transition only), modification (booking amendment), cancellation (booking cancelled), no_show (guest did not arrive), check_in (guest arrived), check_out (guest departed).. Valid values are `status_change|modification|cancellation|no_show|check_in|check_out`',
    `guest_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated notification (email, SMS, push) was sent to the guest for this event. True if sent, False otherwise.',
    `guest_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the guest notification was sent. Null if no notification was sent.',
    `ip_address` STRING COMMENT 'The IP address from which the event was initiated. Captured for security audit, fraud detection, and compliance purposes. May be considered PII in some jurisdictions.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `modification_field_name` STRING COMMENT 'For modification events, the specific field or attribute that was changed (e.g., arrival_date, room_type_code, rate_code, number_of_adults). Enables granular change tracking.',
    `modification_type` STRING COMMENT 'For modification events, specifies the category of amendment: date_change (arrival/departure dates), room_type_change (upgrade/downgrade), rate_plan_change (rate code switch), occupancy_change (number of guests), special_request_update (preferences), guest_name_change (name correction), payment_method_change (guarantee method), package_change (package modification), add_on_change (ancillary services). Null for non-modification events. [ENUM-REF-CANDIDATE: date_change|room_type_change|rate_plan_change|occupancy_change|special_request_update|guest_name_change|payment_method_change|package_change|add_on_change — 9 candidates stripped; promote to reference product]',
    `new_status` STRING COMMENT 'The reservation status after this event. Represents the current state of the booking at the time of this history record. [ENUM-REF-CANDIDATE: inquiry|tentative|waitlisted|confirmed|guaranteed|modified|cancelled|no_show|checked_in|checked_out|due_in|due_out — 12 candidates stripped; promote to reference product]',
    `new_value` DECIMAL(18,2) COMMENT 'For modification events, the value of the field after the change. Stored as string to accommodate various data types. Null for non-modification events.',
    `no_show_reason_code` STRING COMMENT 'For no-show events, the reason code (e.g., NO_CONTACT, FLIGHT_DELAY, GUEST_FORGOT, DUPLICATE_BOOKING). Null for non-no-show events.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `original_value` DECIMAL(18,2) COMMENT 'For modification events, the value of the field before the change. Stored as string to accommodate various data types. Null for non-modification events.',
    `penalty_fee_amount` DECIMAL(18,2) COMMENT 'For cancellation or modification events, any penalty or change fee assessed per the rate plan rules. Zero if no penalty applies.',
    `previous_status` STRING COMMENT 'The reservation status immediately before this event. Null for the initial status record. Values align with Oracle OPERA PMS reservation status codes. [ENUM-REF-CANDIDATE: inquiry|tentative|waitlisted|confirmed|guaranteed|modified|cancelled|no_show|checked_in|checked_out|due_in|due_out — 12 candidates stripped; promote to reference product]',
    `property_code` STRING COMMENT 'The unique code identifying the hotel or resort property where this reservation event occurred. Denormalized for partition key and audit completeness.. Valid values are `^[A-Z0-9]{3,10}$`',
    `rate_difference_amount` DECIMAL(18,2) COMMENT 'For modification events, the monetary difference between the original and new rate (positive for increase, negative for decrease). Null for non-rate-change events.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the status change or modification (e.g., GUEST_REQUEST, RATE_CHANGE, OVERBOOKING, NO_SHOW, EARLY_DEPARTURE, SYSTEM_AUTO). Aligns with property-defined reason code tables.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `reason_description` STRING COMMENT 'Free-text explanation or additional context for the status change or modification. Captures agent notes or system-generated descriptions.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'The estimated revenue impact of this event (positive for revenue gain, negative for revenue loss). Calculated based on rate changes, cancellations, and penalties.',
    `sla_actual_minutes` STRING COMMENT 'The actual processing time in minutes from event initiation to completion. Used to measure SLA performance.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether this event met the defined Service Level Agreement (SLA) for processing time. True if compliant, False if SLA was breached.',
    `sla_target_minutes` STRING COMMENT 'The target processing time in minutes defined by the SLA for this event type. Used to calculate SLA compliance.',
    `system_source` STRING COMMENT 'The source system or interface that generated this event (e.g., OPERA_PMS for front desk, SYNXIS_CRS for central reservations, MOBILE_APP for guest self-service).. Valid values are `OPERA_PMS|SYNXIS_CRS|MOBILE_APP|KIOSK|INTERFACE|BATCH`',
    `transaction_reference` STRING COMMENT 'The unique transaction or session identifier from the source system. Enables correlation with source system logs for troubleshooting and dispute resolution.. Valid values are `^[A-Z0-9-]{10,50}$`',
    `user_agent` STRING COMMENT 'The browser or application user agent string for web/mobile-initiated events. Supports device analytics and troubleshooting.',
    CONSTRAINT pk_booking_status_history PRIMARY KEY(`booking_status_history_id`)
) COMMENT 'Immutable audit trail of all reservation lifecycle events including status transitions (Inquiry → Tentative → Confirmed → Modified → Cancelled → No-Show → Checked-In → Checked-Out) and all booking modifications. For status changes, captures previous status, new status, transition timestamp, triggering agent/system, and reason code. For modifications (the SSOT for all amendment records), captures amendment type (date change, room type upgrade/downgrade, rate plan switch, occupancy change, special request update), original values, new values, modification channel, modification timestamp, agent ID, and any associated rate difference or penalty fee. Enables lifecycle analytics, SLA compliance tracking, revenue impact analysis, dispute resolution, and guest service recovery workflows. Sourced from Oracle OPERA PMS status change and modification events.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` (
    `cancellation_id` BIGINT COMMENT 'Unique identifier for the cancellation or no-show event. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Cancellations trigger revenue reversals, refund processing, and penalty charges that must link to the original AR invoice for accurate revenue recognition, refund authorization, and financial reportin',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Cancellations require booking source attribution for channel-specific cancellation policy enforcement, commission reversal calculations, and OTA penalty assessment. Currently only links to ota_partner',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Cancellation currently references policy via cancellation_policy_code (string). Normalizing to FK allows joining to get full policy details (policy_name, policy_description, penalty_type, penalty_amou',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Segment-level cancellation analysis (cancellation propensity, revenue lost by segment) is a standard revenue management report. Cancellation records need direct segment attribution for standalone canc',
    `ota_partner_id` BIGINT COMMENT 'Reference to the OTA partner if the cancellation was initiated by or processed through an OTA channel.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who held the cancelled or no-show reservation.',
    `property_id` BIGINT COMMENT 'Reference to the property where the cancellation or no-show occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation that was cancelled or resulted in a no-show.',
    `confirmation_number` STRING COMMENT 'The externally-known reservation confirmation number associated with the cancelled or no-show reservation.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was first created in the system.',
    `dispute_date` DATE COMMENT 'Date when the guest initiated a dispute of the cancellation penalty or no-show fee.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the guest has disputed the cancellation penalty or no-show fee charge.',
    `dispute_resolution_status` STRING COMMENT 'Current status of the dispute resolution process (open, resolved in guest favor, resolved in property favor, or withdrawn by guest).. Valid values are `open|resolved_guest_favor|resolved_property_favor|withdrawn`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the cancellation or no-show event occurred. For cancellations: when the cancellation was processed. For no-shows: the date/time the guest failed to arrive.',
    `event_type` STRING COMMENT 'Type of non-fulfillment event: guest-initiated cancellation, property-initiated cancellation, OTA-initiated cancellation, or no-show (non-arrival).. Valid values are `guest_cancellation|property_cancellation|ota_cancellation|no_show`',
    `guarantee_charge_processed_flag` BOOLEAN COMMENT 'Indicates whether the guarantee charge (penalty or no-show fee) was successfully processed against the guarantee method.',
    `guarantee_method` STRING COMMENT 'Method used to guarantee the reservation (credit card, deposit, corporate guarantee, travel agent guarantee, or none). Critical for no-show charge processing.. Valid values are `credit_card|deposit|corporate_guarantee|travel_agent_guarantee|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cancellation record was last updated.',
    `original_arrival_date` DATE COMMENT 'The scheduled arrival date of the cancelled or no-show reservation.',
    `original_departure_date` DATE COMMENT 'The scheduled departure date of the cancelled or no-show reservation.',
    `ota_chargeback_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged back to the OTA for commission recovery on this cancellation or no-show.',
    `ota_chargeback_eligible_flag` BOOLEAN COMMENT 'Indicates whether the property is eligible to charge back the commission to the OTA for this cancellation or no-show per the OTA contract terms.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fee charged for the cancellation or no-show, in the propertys base currency.',
    `penalty_applicable_flag` BOOLEAN COMMENT 'Indicates whether a cancellation penalty or no-show fee is applicable based on the policy and timing of the event.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `posting_status` STRING COMMENT 'Status of the penalty charge posting to the guest folio or account (posted, pending, reversed, or failed).. Valid values are `posted|pending|reversed|failed`',
    `processing_channel` STRING COMMENT 'Channel through which the cancellation or no-show was processed (PMS - Property Management System, CRS - Central Reservation System, OTA - Online Travel Agency, GDS - Global Distribution System, call center, mobile app, web). [ENUM-REF-CANDIDATE: pms|crs|ota|gds|call_center|mobile_app|web — 7 candidates stripped; promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for cancellation (e.g., CHANGE_PLANS, DUPLICATE_BOOKING, PRICE_ISSUE, EMERGENCY, OTHER). Null for no-show events.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `reason_description` STRING COMMENT 'Free-text description or additional details about the cancellation reason provided by the guest or agent.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the guest after applicable penalties, in the propertys base currency.',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether the guest is eligible for a refund of any prepaid amounts after penalty deduction.',
    `revenue_lost_amount` DECIMAL(18,2) COMMENT 'Total room revenue lost due to the cancellation or no-show, calculated from the original reservation rate and length of stay.',
    `reversal_date` DATE COMMENT 'Date when the penalty charge was reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether the cancellation penalty or no-show fee charge was subsequently reversed.',
    `reversal_reason` STRING COMMENT 'Explanation or reason for reversing the cancellation penalty or no-show fee charge.',
    `room_nights_lost` STRING COMMENT 'Number of room nights lost due to the cancellation or no-show, calculated as the difference between arrival and departure dates.',
    `waiver_authorized_by` STRING COMMENT 'Name or identifier of the manager or agent who authorized the penalty waiver.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the cancellation penalty or no-show fee was waived by the property.',
    `waiver_reason_code` STRING COMMENT 'Standardized code indicating the reason for waiving the penalty (e.g., LOYALTY_STATUS, EMERGENCY, SERVICE_RECOVERY, MANAGER_DISCRETION).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `window_hours` STRING COMMENT 'Number of hours before arrival that the cancellation occurred, used to evaluate penalty applicability per the cancellation policy.',
    CONSTRAINT pk_cancellation PRIMARY KEY(`cancellation_id`)
) COMMENT 'Transactional record capturing all reservation non-fulfillment events including guest cancellations, property-initiated cancellations, OTA-initiated cancellations, and no-show (non-arrival) events. For cancellations: records event date/time, reason code, applicable cancellation policy, penalty/fee amount, cancellation window evaluation, refund eligibility, and processing channel. For no-shows: records no-show date, no-show fee charged, guarantee method used for charge, automatic guarantee charge processing, and OTA chargeback eligibility. Common fields: waiver flag, waiver reason, posting status to guest folio, processing agent/channel, and any subsequent dispute or reversal. Critical for revenue leakage analysis, NRR policy enforcement, revenue recovery operations, OTA chargeback management, and CPOR (Cost Per Occupied Room) reporting.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` (
    `reservation_group_block_id` BIGINT COMMENT 'Unique identifier for the group room block record. Primary key.',
    `booking_source_id` BIGINT COMMENT 'Reference to the channel or booking source through which the group block was created.',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: reservation_group_block currently stores cancellation_policy as a free-text STRING, which is a denormalized representation of the cancellation terms governing the group block. The cancellation_policy ',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account or travel agency associated with this group block, if applicable.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to revenue.demand_forecast. Business justification: Group blocks are evaluated against demand forecasts for displacement analysis. Linking the contracted block to the forecast used during evaluation supports post-stay attrition and displacement accurac',
    `event_booking_id` BIGINT COMMENT 'Reference to the associated event or meeting record if this group block is linked to a MICE event managed in the event domain.',
    `group_evaluation_id` BIGINT COMMENT 'Foreign key linking to revenue.group_evaluation. Business justification: Group blocks are contracted only after a formal revenue management group evaluation (displacement analysis, proposed rate, RM decision). Linking the contracted block to its originating evaluation is e',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Group blocks for conferences/events are anchored to specific meeting spaces. Sales and convention services teams need this link to manage space inventory allocation, generate BEOs, and produce group p',
    `property_id` BIGINT COMMENT 'Reference to the property where the group block is held.',
    `reservation_rate_plan_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_rate_plan. Business justification: reservation_group_block currently stores rate_code as a denormalized STRING representing the rate plan under which the group block is contracted. The reservation_rate_plan table is the authoritative r',
    `room_block_id` BIGINT COMMENT 'Foreign key linking to inventory.room_block. Business justification: A reservation group block must reference its corresponding inventory room block to reconcile contracted room nights, track attrition penalties, and manage cutoff releases. This cross-domain link betwe',
    `arrival_date` DATE COMMENT 'The first date of the group block period when guests are expected to check in.',
    `attrition_clause_flag` BOOLEAN COMMENT 'Indicates whether the group block contract includes an attrition clause requiring minimum room pickup or penalties.',
    `attrition_threshold_percentage` DECIMAL(18,2) COMMENT 'The minimum percentage of contracted rooms that must be picked up to avoid attrition penalties, if applicable.',
    `available_room_count` STRING COMMENT 'The number of rooms remaining available in the block for booking, calculated as contracted minus pickup.',
    `billing_instruction` STRING COMMENT 'Instructions for billing and invoicing the group, including payment terms and responsible party details.',
    `block_code` STRING COMMENT 'Externally-known unique code or identifier for the group block, used for booking and reference purposes across systems.',
    `block_name` STRING COMMENT 'Human-readable name or title of the group block, typically reflecting the event, corporate account, or travel agency name.',
    `block_status` STRING COMMENT 'Current lifecycle status of the group block indicating its booking stage and commitment level.. Valid values are `tentative|definite|cancelled|waitlist|inquiry|contracted`',
    `block_type` STRING COMMENT 'Classification of the group block by business segment or purpose, such as corporate meeting, MICE (Meetings Incentives Conferences Exhibitions), tour operator, or wedding. [ENUM-REF-CANDIDATE: corporate|leisure_group|mice|tour_operator|wholesale|airline_crew|wedding — 7 candidates stripped; promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Free-text explanation or code describing the reason for group block cancellation.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the group block was cancelled, if applicable.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'The commission rate percentage payable to the booking agent or intermediary for this group block.',
    `contact_email` STRING COMMENT 'The email address of the primary contact person for the group block.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'The full name of the primary contact person for the group block.',
    `contact_phone` STRING COMMENT 'The phone number of the primary contact person for the group block.',
    `contract_signed_date` DATE COMMENT 'The date on which the group block contract was signed by both parties.',
    `contracted_room_count` STRING COMMENT 'The total number of rooms contracted or committed in the group block agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the group block record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the group rate amount.. Valid values are `^[A-Z]{3}$`',
    `cutoff_date` DATE COMMENT 'The deadline date by which the group must pick up rooms from the block before unbooked rooms are released back to general inventory.',
    `departure_date` DATE COMMENT 'The last date of the group block period when guests are expected to check out.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The monetary deposit amount required for the group block, if applicable.',
    `deposit_due_date` DATE COMMENT 'The date by which the deposit payment must be received.',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a deposit is required to secure the group block.',
    `group_rate_amount` DECIMAL(18,2) COMMENT 'The negotiated nightly room rate amount for the group block, typically in the propertys base currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the group block record was last updated or modified.',
    `lra_flag` BOOLEAN COMMENT 'Indicates whether the group block has Last Room Availability (LRA) status, meaning rooms are available at the group rate even when the property is sold out.',
    `notes` STRING COMMENT 'General free-text notes or comments related to the group block for internal reference.',
    `pickup_room_count` STRING COMMENT 'The number of rooms from the block that have been booked or picked up by the group as of the current date.',
    `revenue_forecast_amount` DECIMAL(18,2) COMMENT 'The forecasted total revenue expected from this group block based on contracted rooms and rates.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or requirements from the group, such as room setup, amenities, or services.',
    `wash_schedule_date` DATE COMMENT 'The date on which the group block inventory is scheduled to be washed or adjusted based on pickup performance.',
    CONSTRAINT pk_reservation_group_block PRIMARY KEY(`reservation_group_block_id`)
) COMMENT 'Master record for a group room block associated with a corporate account, travel agency, or event. Manages the contracted room block size, pickup count, cutoff date, group rate code, block status (tentative/definite/cancelled), attrition clause, and wash schedule. Links to the event domain for MICE group blocks and to the channel domain for wholesale/tour operator blocks. Sourced from Oracle OPERA PMS Group Block module and Delphi by Amadeus for event-linked groups.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` (
    `group_block_pickup_id` BIGINT COMMENT 'Unique identifier for the group block pickup transaction. Primary key for this entity.',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Group block pickup channel-mix reporting and commission calculation require knowing which booking source (OTA, GDS, direct) picked up each room from the block. Drives attrition forecasting by channel ',
    `campaign_execution_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_execution. Business justification: Group room pickups driven by targeted B2B or MICE campaign executions (e.g., email blast to corporate segment) must be linked to the execution for group marketing ROI analysis. Revenue and group sales',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: group_block_pickup carries denormalized market_segment_code. Normalizing via FK enables direct segment-level group pickup velocity reporting — a standard revenue management report tracking which segme',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Group block pickup tracks individual attendee bookings; linking to loyalty.member enables points posting for group attendees and tier recognition at check-in. loyalty_member_number is a denormalized s',
    `property_id` BIGINT COMMENT 'Reference to the property where the group block pickup occurred. Enables property-level group performance analysis.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the individual reservation that consumed inventory from the group block. Links to the transactional reservation record.',
    `reservation_group_block_id` BIGINT COMMENT 'Reference to the parent group block from which this pickup was made. Links to the master group block allocation.',
    `reservation_rate_plan_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_rate_plan. Business justification: group_block_pickup currently stores rate_code as a denormalized STRING representing the rate at which an individual pickup was booked against the group block. The reservation_rate_plan table is the au',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Group block pickup tracking by room type is a core revenue management process — attrition analysis, wash scheduling, and pickup pace reporting all require a proper FK to room_type. room_type_code an',
    `arrival_date` DATE COMMENT 'Scheduled check-in date for the pickup reservation. Used for occupancy forecasting and group block utilization analysis.',
    `block_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total group block consumed at the time of this pickup. Calculated as (total_block_rooms - remaining_block_rooms) / total_block_rooms * 100.',
    `booking_channel_code` STRING COMMENT 'Code identifying the channel through which the pickup was made (e.g., DIRECT, GDS, OTA, CRS). Enables channel attribution analysis for group blocks.',
    `cancellation_date` DATE COMMENT 'Date when this pickup reservation was cancelled, if applicable. Used for attrition analysis and wash factor calculation.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for cancellation. Supports root cause analysis of group block attrition.',
    `company_name` STRING COMMENT 'Name of the company or organization associated with this pickup. Links individual reservations to corporate accounts.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this pickup record was first created in the data platform. Supports data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amount (e.g., USD, EUR, GBP). Essential for multi-currency group block management.. Valid values are `^[A-Z]{3}$`',
    `cutoff_date` DATE COMMENT 'Date by which the group block inventory must be picked up or released back to general inventory. Critical for attrition management.',
    `departure_date` DATE COMMENT 'Scheduled check-out date for the pickup reservation. Used to calculate Length of Stay (LOS) and room night consumption.',
    `group_attendee_type` STRING COMMENT 'Classification of the attendee role within the group event. Supports rooming list segmentation and billing allocation. [ENUM-REF-CANDIDATE: attendee|speaker|organizer|exhibitor|sponsor|staff|guest — 7 candidates stripped; promote to reference product]',
    `guarantee_type` STRING COMMENT 'Method used to guarantee the pickup reservation. Critical for no-show risk assessment and revenue assurance.. Valid values are `credit_card|deposit|corporate|travel_agent|none`',
    `guest_email` STRING COMMENT 'Primary email address for the guest on this pickup reservation. Used for confirmation and pre-arrival communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `guest_name` STRING COMMENT 'Full name of the guest associated with this pickup reservation. Used for rooming list management and guest communication.',
    `guest_phone` STRING COMMENT 'Primary contact phone number for the guest. Critical for day-of-arrival communication and service recovery.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this pickup record was last updated. Enables change tracking and data quality monitoring.',
    `nights` STRING COMMENT 'Total number of room nights consumed by this pickup. Calculated as departure_date minus arrival_date. Key metric for group block utilization.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the guest failed to arrive for this pickup reservation. Critical for no-show rate tracking and revenue recovery.',
    `pickup_before_cutoff_flag` BOOLEAN COMMENT 'Indicates whether this pickup occurred before the group block cutoff date. Used to assess on-time pickup performance.',
    `pickup_number` STRING COMMENT 'Business-readable identifier for the pickup transaction, typically generated by the Property Management System (PMS) or Central Reservation System (CRS).',
    `pickup_status` STRING COMMENT 'Current lifecycle status of the pickup reservation. Tracks progression from initial booking through completion or cancellation. [ENUM-REF-CANDIDATE: confirmed|tentative|cancelled|no_show|checked_in|checked_out|waitlisted — 7 candidates stripped; promote to reference product]',
    `pickup_timestamp` TIMESTAMP COMMENT 'Date and time when the individual reservation was booked against the group block inventory. Critical for tracking pickup velocity and cutoff date management.',
    `rate_amount` DECIMAL(18,2) COMMENT 'Nightly room rate applied to this pickup reservation. Used to calculate total room revenue and compare against Best Available Rate (BAR).',
    `remaining_block_rooms` STRING COMMENT 'Number of rooms remaining in the group block after this pickup. Snapshot metric for real-time utilization monitoring.',
    `source_system` STRING COMMENT 'Operational system of record that originated this pickup transaction. Supports data lineage and system integration troubleshooting.. Valid values are `OPERA|SYNXIS|DELPHI|SALESFORCE|MICROS`',
    `source_system_code` STRING COMMENT 'Unique identifier for this pickup record in the source operational system. Enables cross-system reconciliation and data traceability.',
    `special_requests` STRING COMMENT 'Free-text field capturing guest special requests for this pickup (e.g., high floor, accessible room, early check-in). Supports service delivery.',
    `total_room_revenue` DECIMAL(18,2) COMMENT 'Total room revenue generated by this pickup, calculated as rate_amount multiplied by nights. Excludes taxes and fees.',
    `vip_indicator` BOOLEAN COMMENT 'Flag indicating whether this pickup is for a VIP guest requiring special handling. Drives service prioritization and amenity allocation.',
    CONSTRAINT pk_group_block_pickup PRIMARY KEY(`group_block_pickup_id`)
) COMMENT 'Transactional record tracking individual reservation pickups against a group block, capturing the booking reference, pickup date, room type consumed, rate applied, and remaining block inventory. Enables real-time group block utilization monitoring, attrition risk assessment, and cutoff date management. Supports revenue management decisions on releasing unsold group inventory back to transient availability.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` (
    `reservation_rate_plan_id` BIGINT COMMENT 'Unique identifier for the reservation rate plan record. Primary key for this entity.',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Rate plans are frequently created to operationalize a campaign offer (e.g., a Book Direct Save 20% rate plan tied to a specific offer). Linking rate plan to campaign_offer enables offer-to-rate-plan',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Reservation_rate_plan currently references policy via cancellation_policy_code (string). Normalizing to FK allows joining to get full policy details. Rate plans are defined with specific cancellation ',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Each rate plan maps to specific GL accounts for USALI revenue recognition (e.g., transient rooms revenue vs. package revenue vs. wholesale). Night audit posting and revenue recognition require rate pl',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: reservation_rate_plan carries denormalized market_segment_code. Rate plans are segment-specific (corporate, leisure, group). Normalizing via FK enables direct rate plan to segment reporting for revenu',
    `advance_purchase_days` STRING COMMENT 'Number of days in advance that a booking must be made to qualify for this rate plan. Common for promotional and non-refundable rates (e.g., 7-day, 14-day, 21-day advance purchase). Null or 0 indicates no advance purchase requirement.',
    `booking_window_end_days` STRING COMMENT 'Number of days before arrival when this rate plan is no longer available for booking. Used to close last-minute bookings for certain rate plans. Null indicates no end restriction.',
    `booking_window_start_days` STRING COMMENT 'Number of days before arrival when this rate plan becomes available for booking. Used to control early booking windows for promotional rates. Null indicates no start restriction.',
    `channel_corporate_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through corporate direct billing channels. Requires corporate account setup and negotiated rate agreement.',
    `channel_direct_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through direct channels (property website, call center, front desk). True for most rate plans; false for channel-exclusive rates.',
    `channel_gds_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through GDS channels (Sabre, Amadeus, Galileo, Worldspan). Typically used for corporate and travel agent bookings.',
    `channel_group_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for group block bookings through MICE and event sales channels. Managed via Delphi by Amadeus for group inventory allocation.',
    `channel_ota_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is available for booking through OTA channels (Expedia, Booking.com, etc.). Subject to rate parity agreements and channel management rules.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'The percentage of the room rate paid as commission to the booking channel or agent. Typically 10-25% for OTAs, 10% for travel agents. Null if commissionable_flag is false.',
    `commissionable_flag` BOOLEAN COMMENT 'Indicates whether bookings under this rate plan are eligible for travel agent or OTA commission. True for most OTA and GDS rates; false for net rates and direct promotional rates.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rate plan record was first created in the system. Used for audit trail and lifecycle tracking.',
    `display_sequence` STRING COMMENT 'The order in which this rate plan should be displayed to guests and agents in the booking interface. Lower numbers appear first. Used to prioritize high-value or strategic rate plans.',
    `effective_end_date` DATE COMMENT 'The date after which this rate plan is no longer available for booking or stay dates. Nullable for evergreen rate plans like BAR. Used for promotional and seasonal rate plan expiration.',
    `effective_start_date` DATE COMMENT 'The date from which this rate plan becomes available for booking and stay dates. Aligns with revenue management strategy and seasonal pricing windows.',
    `guarantee_method` STRING COMMENT 'The method by which the reservation must be guaranteed. Credit card: hold on card; Deposit: partial payment required; Prepayment: full payment required; Direct bill: corporate account billing; None: no guarantee required.. Valid values are `credit_card|deposit|prepayment|direct_bill|none`',
    `guarantee_required_flag` BOOLEAN COMMENT 'Indicates whether a payment guarantee (credit card, deposit, or prepayment) is required at the time of booking for this rate plan. True for most rate plans; false for select corporate or group rates with direct billing arrangements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rate plan record was last updated. Used for change tracking and synchronization across systems.',
    `loyalty_eligible_flag` BOOLEAN COMMENT 'Indicates whether stays booked under this rate plan are eligible for loyalty program points accrual and elite benefits. True for most direct and qualified rates; false for opaque and deeply discounted rates.',
    `loyalty_points_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to base loyalty points earned for stays under this rate plan. Standard rates typically have 1.0x; promotional rates may have 0.5x or 2.0x multipliers. Null if loyalty_eligible_flag is false.',
    `maximum_length_of_stay` STRING COMMENT 'Maximum number of nights allowed for a booking under this rate plan. Used to prevent long-stay bookings from blocking high-value short-stay demand. Null indicates no maximum restriction.',
    `member_only_flag` BOOLEAN COMMENT 'Indicates whether this rate plan is exclusively available to loyalty program members. True for member-exclusive rates; false for public rates.',
    `minimum_length_of_stay` STRING COMMENT 'Minimum number of nights required for a booking under this rate plan. Used for revenue optimization during high-demand periods. Null or 1 indicates no minimum restriction.',
    `package_description` STRING COMMENT 'Detailed description of the amenities, services, or F&B components included in the package rate. Examples: Daily breakfast for two, $50 spa credit, complimentary parking, welcome amenity. Null for non-package rates.',
    `package_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this rate plan includes bundled amenities, services, or F&B components (e.g., breakfast included, spa credit, parking). True for package rates; false for room-only rates.',
    `rate_plan_category` STRING COMMENT 'High-level classification of the rate plan type for segmentation and reporting. Standard includes BAR and rack rates; corporate includes negotiated business rates; promotional includes limited-time offers; package includes bundled F&B or amenities; group includes MICE block rates; wholesale includes tour operator allotments; opaque includes non-branded OTA rates; member includes loyalty program rates; government includes public sector rates. [ENUM-REF-CANDIDATE: standard|corporate|promotional|package|group|wholesale|opaque|member|government — 9 candidates stripped; promote to reference product]',
    `rate_plan_code` STRING COMMENT 'Unique business identifier for the rate plan as configured in the CRS and PMS. Examples: BAR, CORP, AAA, PKG, NRF. This is the externally-known code used across all distribution channels.. Valid values are `^[A-Z0-9]{3,10}$`',
    `rate_plan_description` STRING COMMENT 'Detailed business description of the rate plan, including terms, conditions, restrictions, and benefits. Used for guest communication and agent training.',
    `rate_plan_name` STRING COMMENT 'Human-readable name of the rate plan displayed to guests and agents. Examples: Best Available Rate, Corporate Negotiated Rate, AAA Member Rate, Romance Package, Non-Refundable Rate.',
    `rate_plan_status` STRING COMMENT 'Current lifecycle status of the rate plan. Active: available for booking; Inactive: not available for new bookings; Suspended: temporarily disabled; Pending: awaiting approval or activation; Expired: past effective end date.. Valid values are `active|inactive|suspended|pending|expired`',
    `source_system_code` STRING COMMENT 'Identifies the system of record where this rate plan was originally configured. SYNXIS: Sabre SynXis CRS; OPERA: Oracle OPERA PMS; IDEAS: IDeaS G3 RMS strategy output; MANUAL: manually configured rate plan.. Valid values are `SYNXIS|OPERA|IDEAS|MANUAL`',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions governing the rate plan, including cancellation penalties, modification rules, no-show charges, and guest obligations. Must comply with consumer protection regulations.',
    CONSTRAINT pk_reservation_rate_plan PRIMARY KEY(`reservation_rate_plan_id`)
) COMMENT 'Reservation-scoped reference master for the bookable rate plan catalog presented to guests and agents via CRS and PMS. Includes BAR (Best Available Rate), LRA (Last Room Availability), NRR (Non-Refundable Rate), corporate negotiated rates, package rates, and promotional rates. Stores rate plan code, rate plan name, rate category, cancellation policy reference, guarantee requirements, minimum LOS restrictions, advance purchase requirements, and channel eligibility flags. SSOT BOUNDARY: This domain owns the bookable rate plan catalog (what can be sold and under what terms). The revenue domain owns rate strategy, pricing optimization, yield management, and dynamic rate amounts. Rate plan records here are synchronized from Sabre SynXis CRS rate configuration and reflect IDeaS G3 RMS rate strategy outputs as read-only pricing inputs.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` (
    `cancellation_policy_id` BIGINT COMMENT 'Unique identifier for the cancellation policy. Primary key.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Cancellation penalty revenue and no-show fees post to specific GL accounts under USALI. Linking cancellation_policy to ledger enables automated penalty revenue posting to the correct account during ni',
    `allows_modification` BOOLEAN COMMENT 'Indicates whether reservations under this policy allow date or room type modifications without cancellation. False for most non-refundable policies.',
    `applies_to_corporate_bookings` BOOLEAN COMMENT 'Indicates whether this policy can be applied to corporate negotiated rate bookings. Corporate accounts may have special cancellation terms.',
    `applies_to_group_bookings` BOOLEAN COMMENT 'Indicates whether this policy can be applied to group block reservations. Group policies often have different terms than individual FIT (Free Independent Traveler) bookings.',
    `channel_restrictions` STRING COMMENT 'Comma-separated list of booking channels where this policy applies or is restricted. Examples: direct_only, ota_excluded, gds_only. Null indicates no channel restrictions.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this cancellation policy. Part of audit trail for policy governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cancellation policy record was first created in the system. Part of audit trail for policy lifecycle management.',
    `deposit_due_days_before_arrival` STRING COMMENT 'Number of days before arrival date by which the deposit must be received. Null indicates deposit due at time of booking.',
    `deposit_percentage` DECIMAL(18,2) COMMENT 'Percentage of total reservation value required as deposit when deposit_required is true. Value stored as decimal (e.g., 100.00 for full prepayment).',
    `deposit_required` BOOLEAN COMMENT 'Indicates whether an advance deposit payment is required at time of booking under this policy. Common for non-refundable and group bookings.',
    `display_order` STRING COMMENT 'Numeric sequence for ordering policies in user interfaces and booking engines. Lower numbers appear first. Used for presenting policies from most to least flexible.',
    `effective_end_date` DATE COMMENT 'Date after which this cancellation policy is no longer active for new reservations. Null indicates policy is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this cancellation policy becomes active and can be applied to new reservations. Part of policy lifecycle management.',
    `free_cancellation_window_days` STRING COMMENT 'Number of days before scheduled arrival date during which a guest can cancel without penalty. Alternative to hours-based window for longer lead-time policies.',
    `free_cancellation_window_hours` STRING COMMENT 'Number of hours before scheduled arrival time during which a guest can cancel without penalty. Null indicates no free cancellation window.',
    `guarantee_required` BOOLEAN COMMENT 'Indicates whether a payment guarantee (credit card, deposit, or prepayment) is required to book under this cancellation policy. Typically true for stricter policies.',
    `guest_facing_summary` STRING COMMENT 'Concise, guest-friendly summary of the cancellation policy displayed during booking process. Typically 1-2 sentences highlighting key terms.',
    `internal_notes` STRING COMMENT 'Internal staff notes and operational guidance for applying this cancellation policy. Not visible to guests. Used for training and exception handling.',
    `is_non_refundable` BOOLEAN COMMENT 'Indicates whether this policy represents a non-refundable rate where no refund is provided under any circumstances. True for NRR (Non-Refundable Rate) policies.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this cancellation policy. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cancellation policy record was last updated. Tracks policy changes for revenue management analysis and compliance audit.',
    `legal_terms_text` STRING COMMENT 'Full legal terms and conditions text for the cancellation policy, including jurisdiction-specific consumer protection disclosures required by GDPR, CCPA, and local regulations.',
    `modification_fee` DECIMAL(18,2) COMMENT 'Fixed fee charged for modifying a reservation when allows_modification is true. Null if no modification fee applies. Currency is property base currency.',
    `no_show_penalty_amount` DECIMAL(18,2) COMMENT 'Fixed monetary penalty charged for no-show when no_show_penalty_type is flat_fee. Currency is property base currency per USALI standards.',
    `no_show_penalty_percentage` DECIMAL(18,2) COMMENT 'Percentage of total reservation value charged as penalty for no-show when no_show_penalty_type is percentage_of_stay. Value stored as decimal.',
    `no_show_penalty_type` STRING COMMENT 'Type of penalty applied when a guest fails to arrive (no-show). May differ from standard cancellation penalty to account for lost revenue opportunity.. Valid values are `first_night|full_stay|flat_fee|percentage_of_stay|same_as_cancellation`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Fixed monetary penalty amount charged for cancellation when penalty_type is flat_fee. Currency is property base currency per USALI standards.',
    `penalty_nights_count` STRING COMMENT 'Number of nights charged as penalty when penalty_type is first_night or nights_based. Typically 1 for first night penalty, can be higher for stricter policies.',
    `penalty_percentage` DECIMAL(18,2) COMMENT 'Percentage of total reservation value charged as penalty when penalty_type is percentage_of_stay. Value stored as decimal (e.g., 50.00 for 50%).',
    `penalty_type` STRING COMMENT 'Type of penalty applied when cancellation occurs outside the free cancellation window. Determines how the cancellation charge is calculated.. Valid values are `first_night|percentage_of_stay|flat_fee|full_stay|no_penalty|nights_based`',
    `policy_code` STRING COMMENT 'Unique business identifier code for the cancellation policy used in PMS (Property Management System) and CRS (Central Reservation System) systems. Examples: FLEX, MOD, STRICT, NRF.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `policy_description` STRING COMMENT 'Detailed description of the cancellation policy terms and conditions, including guest-facing language explaining cancellation rules, deadlines, and penalties.',
    `policy_name` STRING COMMENT 'Human-readable name of the cancellation policy displayed to guests and staff. Examples: Flexible Cancellation, Moderate Cancellation, Strict Cancellation, Non-Refundable.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the cancellation policy. Only active policies can be assigned to rate plans and reservations.. Valid values are `active|inactive|draft|archived|suspended`',
    `policy_tier` STRING COMMENT 'Classification tier of the cancellation policy indicating the level of flexibility offered to guests. Aligned with revenue management strategy and rate plan positioning.. Valid values are `flexible|moderate|strict|non_refundable|super_flexible|custom`',
    `seasonal_override_allowed` BOOLEAN COMMENT 'Indicates whether this policy can be overridden by seasonal or event-specific cancellation rules during high-demand periods.',
    `source_system` STRING COMMENT 'Operational system of record where this cancellation policy was originally configured. Typically Oracle OPERA PMS (Property Management System) or Sabre SynXis CRS (Central Reservation System).. Valid values are `OPERA|SynXis|IDeaS|Manual|Legacy`',
    `source_system_code` STRING COMMENT 'Unique identifier of this cancellation policy in the source operational system. Used for data lineage and reconciliation with PMS (Property Management System) or CRS (Central Reservation System).',
    CONSTRAINT pk_cancellation_policy PRIMARY KEY(`cancellation_policy_id`)
) COMMENT 'Reference master defining the terms and conditions for reservation cancellation, including the policy code, policy name, free cancellation window (hours/days before arrival), penalty structure (first night, percentage of stay, flat fee), non-refundable flag, and applicable rate plan associations. Manages multiple policy tiers (flexible, moderate, strict, non-refundable) aligned with revenue management strategy. Sourced from Oracle OPERA PMS policy configuration.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` (
    `reservation_special_request_id` BIGINT COMMENT 'Unique identifier for the special request record. Primary key for the reservation special request entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Special requests with charges (e.g., rollaway beds, early check-in fees, amenity setups) must be posted to the guest folio. Linking reservation_special_request to ar_invoice enables charge reconciliat',
    `benefit_entitlement_id` BIGINT COMMENT 'Foreign key linking to loyalty.benefit_entitlement. Business justification: Pre-authorized loyalty benefits (guaranteed suite upgrades, complimentary breakfast for Platinum members) are operationalized as special requests. Linking to benefit_entitlement enables fulfillment te',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who made the special request. Enables tracking of guest preferences across multiple stays.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Special requests (spa, pool cabana, fitness center) are routed to and fulfilled by specific property facilities. Operations teams need this FK to track fulfillment SLAs by facility, measure facility-l',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where the special request is to be fulfilled. Supports multi-property operations and reporting.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: F&B and dining special requests (in-room dining, restaurant reservations, amenity deliveries) are fulfilled by specific property outlets. This FK enables outlet-level fulfillment tracking, revenue att',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the parent reservation to which this special request is attached. Links the request to the booking record in Oracle OPERA PMS.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was acknowledged by the assigned department or staff member. Tracks response time for Service Level Agreement (SLA) compliance.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred by the property to fulfill the special request. Supports Cost Per Occupied Room (CPOR) analysis and operational efficiency measurement.',
    `assigned_department` STRING COMMENT 'Operational department responsible for fulfilling the special request. Routes the request to the appropriate team for action. [ENUM-REF-CANDIDATE: front_desk|housekeeping|food_beverage|concierge|maintenance|guest_services|spa|transportation|events|other — 10 candidates stripped; promote to reference product]',
    `charge_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged to the guest for fulfilling the special request. Posted to the guest folio in the Property Management System (PMS).',
    `charge_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Supports multi-currency operations for international properties.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the special request record was first created in the database. Used for audit trail and data lineage tracking.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Internal estimated cost to the property for fulfilling the special request. Used for operational expense tracking and profitability analysis.',
    `failure_category` STRING COMMENT 'Classification of the reason for request non-fulfillment. Enables root cause analysis and operational improvement initiatives. [ENUM-REF-CANDIDATE: unavailable|capacity_constraint|policy_restriction|cost_prohibitive|timing_conflict|guest_cancelled|system_error|other — 8 candidates stripped; promote to reference product]',
    `failure_reason` STRING COMMENT 'Explanation of why the special request could not be fulfilled or was only partially fulfilled. Supports service recovery and guest communication.',
    `fulfillment_status` STRING COMMENT 'Current state of the special request in the fulfillment workflow. Tracks progress from initial submission through completion or cancellation. [ENUM-REF-CANDIDATE: pending|acknowledged|in_progress|fulfilled|partially_fulfilled|unable_to_fulfill|cancelled — 7 candidates stripped; promote to reference product]',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was completed or fulfilled. Used for cycle time analysis and guest experience measurement.',
    `guest_feedback_text` STRING COMMENT 'Free-form guest comments or feedback regarding the special request fulfillment. Captured through post-stay surveys or direct communication.',
    `guest_notified_flag` BOOLEAN COMMENT 'Indicates whether the guest has been notified of the fulfillment status or any issues with the special request. Tracks communication completion.',
    `guest_satisfaction_rating` STRING COMMENT 'Guest-provided satisfaction rating for how the special request was handled, typically on a scale of 1-5 or 1-10. Feeds into Guest Satisfaction Score (GSS) and Net Promoter Score (NPS) calculations.',
    `impacts_loyalty_points` BOOLEAN COMMENT 'Indicates whether fulfillment or non-fulfillment of this special request affects the guest loyalty program points or status. Used for loyalty program integration.',
    `internal_notes` STRING COMMENT 'Staff-only notes and comments regarding the special request fulfillment process. Not visible to guests; used for operational coordination.',
    `is_pre_arrival` BOOLEAN COMMENT 'Indicates whether the special request was submitted before the guest arrival date. Pre-arrival requests enable proactive preparation and enhanced guest experience.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this is a recurring preference that should be applied to future reservations for the same guest. Supports loyalty program personalization.',
    `is_vip_request` BOOLEAN COMMENT 'Indicates whether the special request is associated with a VIP (Very Important Person) guest requiring elevated attention and priority handling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the special request record was last updated. Supports change tracking and audit compliance.',
    `notification_method` STRING COMMENT 'Communication channel used to notify the guest about the special request status. Supports omnichannel guest communication tracking. [ENUM-REF-CANDIDATE: email|sms|phone_call|mobile_app|in_person|letter|none — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Urgency classification of the special request indicating the importance for guest satisfaction and operational sequencing. Critical requests require immediate attention.. Valid values are `critical|high|medium|low`',
    `request_category` STRING COMMENT 'High-level grouping of the request type for operational planning and resource allocation. Used for departmental workload distribution. [ENUM-REF-CANDIDATE: room_setup|service_timing|accessibility|amenity|food_beverage|transportation|special_event|general — 8 candidates stripped; promote to reference product]',
    `request_code` STRING COMMENT 'Standardized code identifying the type of special request in the Property Management System (PMS). Used for system processing and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `request_source` STRING COMMENT 'Channel or method through which the special request was submitted. Supports channel performance analysis and guest experience tracking. [ENUM-REF-CANDIDATE: guest_direct|reservation_agent|online_booking|mobile_app|call_center|email|walk_in|loyalty_program|group_coordinator|travel_agent|ota|gds|other — 13 candidates stripped; promote to reference product]',
    `request_text` STRING COMMENT 'Free-form text description of the special request as entered by the guest or reservation agent. Captures detailed instructions and context for fulfillment.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the special request was originally submitted by the guest or agent. Represents the business event time for the request creation.',
    `request_type` STRING COMMENT 'Category of the special request indicating the nature of the guest need. Supports operational routing to appropriate departments (housekeeping, front desk, food and beverage, concierge). [ENUM-REF-CANDIDATE: bed_configuration|floor_preference|accessibility_need|early_check_in|late_check_out|amenity_delivery|dietary_requirement|room_location|view_preference|temperature_preference|pillow_preference|transportation|special_occasion|other — 14 candidates stripped; promote to reference product]',
    `requires_charge` BOOLEAN COMMENT 'Indicates whether fulfilling the special request incurs an additional charge to the guest folio. Used for revenue tracking and billing integration.',
    `source_system` STRING COMMENT 'Operational system of record where the special request was originally captured. Supports data lineage and system integration tracking. [ENUM-REF-CANDIDATE: OPERA_PMS|SYNXIS_CRS|SALESFORCE_CRM|MOBILE_APP|WEB_PORTAL|CALL_CENTER|OTHER — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Unique identifier of the special request in the source operational system. Enables traceability and reconciliation with upstream systems.',
    `target_fulfillment_date` DATE COMMENT 'Planned date by which the special request should be fulfilled. Often aligned with guest arrival date or specific event timing.',
    CONSTRAINT pk_reservation_special_request PRIMARY KEY(`reservation_special_request_id`)
) COMMENT 'Transactional record capturing guest special requests attached to a reservation, including request type (bed configuration, floor preference, accessibility needs, early check-in, late check-out, amenity delivery, dietary requirement), request text, fulfillment status, assigned department, fulfillment timestamp, and failure reason if unmet. Supports pre-arrival operations, housekeeping coordination, and guest experience personalization. Sourced from Oracle OPERA PMS traces and requests module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` (
    `travel_agent_id` BIGINT COMMENT 'Primary key for travel_agent',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Travel agents operate through specific distribution channels (GDS, direct connect, portal) requiring channel assignment for connectivity fee allocation, commission schedule application, and channel-sp',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Travel agents are classified by market segment (wholesale, consortia, leisure TA) for commission management and production reporting. Linking travel_agent to market_segment enables segment-level TA pr',
    `parent_agency_reservation_travel_agent_id` BIGINT COMMENT 'Reference to the parent travel agency if this agent is part of a franchise, consortium, or multi-branch organization. Enables hierarchical reporting of agency performance.',
    `address_line1` STRING COMMENT 'First line of the travel agencys physical or mailing address, typically containing street number and street name.',
    `address_line2` STRING COMMENT 'Second line of the travel agencys address for suite, floor, building, or additional location details.',
    `agency_name` STRING COMMENT 'Legal or trading name of the travel agency or travel management company (TMC). Primary human-readable identifier.',
    `agency_type` STRING COMMENT 'Classification of the travel agency business model. Retail agencies serve individual travelers, corporate TMCs manage business travel programs, OTAs operate online platforms, tour operators package travel products, consortiums are agency networks, and wholesalers distribute bulk inventory.. Valid values are `retail|corporate_tmc|online_travel_agency|tour_operator|consortium|wholesaler`',
    `arc_number` STRING COMMENT 'Seven or eight-digit ARC accreditation number for US-based travel agencies. Used for commission processing and booking attribution in the North American market.. Valid values are `^[0-9]{7,8}$`',
    `booking_volume_tier` STRING COMMENT 'Tiered classification based on the travel agents historical booking volume or revenue contribution. Higher tiers may receive preferential commission rates, priority support, or marketing benefits.. Valid values are `bronze|silver|gold|platinum|diamond`',
    `city` STRING COMMENT 'City or municipality where the travel agency is located.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Default commission percentage paid to the travel agent on qualifying bookings. Expressed as a percentage (e.g., 10.00 for 10%). May be overridden by specific rate plans or negotiated contracts.',
    `contact_email` STRING COMMENT 'Primary email address for the travel agency contact. Used for booking confirmations, commission statements, and operational notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Full name of the primary contact person at the travel agency for operational communication, booking inquiries, and relationship management.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the travel agency contact. Used for urgent booking issues, reservation modifications, and relationship management.',
    `contract_end_date` DATE COMMENT 'Date when the travel agent contract expires or was terminated. Null for open-ended relationships. Used to enforce commission eligibility windows.',
    `contract_start_date` DATE COMMENT 'Date when the travel agent relationship or contract became effective. Marks the beginning of the commission-earning period.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the travel agencys location (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this travel agent record was first created in the system. Used for audit trail and data lineage.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the travel agent on direct bill or net remit payment terms. Expressed in the propertys base currency. Used for credit risk management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for commission payments and credit limits (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `gds_identifier` STRING COMMENT 'Unique identifier or pseudo city code (PCC) assigned to the travel agent within the Global Distribution System (Amadeus, Sabre, Galileo, Worldspan). Used to attribute bookings originating from GDS channels.',
    `iata_number` STRING COMMENT 'Eight-digit IATA accreditation number assigned to the travel agency by the International Air Transport Association. Primary industry identifier for accredited travel agencies.. Valid values are `^[0-9]{8}$`',
    `last_booking_date` DATE COMMENT 'Date of the most recent reservation created by this travel agent. Used to identify inactive agents and trigger re-engagement campaigns.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, relationship history, or internal comments about the travel agent. Used by sales and reservations teams.',
    `onboarding_completed_date` DATE COMMENT 'Date when the travel agent completed all onboarding requirements (contract signing, profile setup, training, system access). Marks readiness to begin booking.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the travel agencys address.',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code for the travel agents preferred communication language (e.g., en, es, fr, de).. Valid values are `^[a-z]{2}$`',
    `preferred_payment_method` STRING COMMENT 'Default payment instrument used by the travel agent for booking guarantees and deposits. Credit card for immediate authorization, bank transfer for wire payments, check for paper payments, direct bill for invoiced accounts, virtual card for single-use card numbers, net remit for commission offset against payment.. Valid values are `credit_card|bank_transfer|check|direct_bill|virtual_card|net_remit`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the travel agency is located.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number (TIN, EIN, VAT number) for the travel agency. Used for commission payment reporting and tax compliance.',
    `total_bookings_count` STRING COMMENT 'Cumulative count of all reservations created by this travel agent since relationship inception. Used for performance reporting and tier qualification.',
    `total_revenue_generated` DECIMAL(18,2) COMMENT 'Cumulative room revenue generated by all bookings attributed to this travel agent since relationship inception. Expressed in the propertys base currency. Used for tier qualification and ROI analysis.',
    `travel_agent_status` STRING COMMENT 'Current lifecycle status of the travel agent relationship. Active agents can make bookings and earn commissions. Inactive agents are temporarily disabled. Suspended agents are under review. Pending approval agents await onboarding completion. Terminated agents have ended their relationship. Blacklisted agents are permanently banned.. Valid values are `active|inactive|suspended|pending_approval|terminated|blacklisted`',
    `updated_by` STRING COMMENT 'Username or system identifier of the user or process that last modified this travel agent record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this travel agent record was last modified. Used for audit trail and change tracking.',
    `website_url` STRING COMMENT 'Primary website URL for the travel agency. Used for agency verification and marketing partnership opportunities.',
    `created_by` STRING COMMENT 'Username or system identifier of the user or process that created this travel agent record. Used for audit trail and accountability.',
    CONSTRAINT pk_travel_agent PRIMARY KEY(`travel_agent_id`)
) COMMENT 'Master record for travel agencies and travel management companies (TMCs) authorized to book on behalf of guests, including IATA/ARC number, agency name, agency type, commission rate, preferred payment method, GDS identifier, and active status. Manages the agency relationship for commission processing, booking attribution, and channel performance reporting. Sourced from Oracle OPERA PMS travel agent profile module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` (
    `room_assignment_id` BIGINT COMMENT 'Primary key for room_assignment',
    `connected_room_assignment_id` BIGINT COMMENT 'Reference to the room assignment ID of the connecting room, if applicable. Null if not part of a connecting room arrangement.',
    `property_id` BIGINT COMMENT 'Reference to the property where the room is located. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'FK to reservation.booking.booking_id — MUST-HAVE: Room assignment must link to the reservation it fulfills. Core operational join for check-in, room move, and folio management workflows.',
    `room_id` BIGINT COMMENT 'Reference to the specific physical room assigned to this reservation. Links to the room inventory master data.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Room assignment must reference the assigned room type as a proper FK for housekeeping planning, upgrade tracking, and room type inventory reconciliation. room_type_code is a denormalized text repres',
    `assignment_date` DATE COMMENT 'Business date on which the room assignment was made. Used for operational reporting and day-level analytics.',
    `assignment_method` STRING COMMENT 'Method by which the room was assigned. Indicates whether assignment was automated, manual, or driven by guest preference.. Valid values are `auto_assigned|manually_assigned|guest_requested|loyalty_preference|group_block|pre_arrival_selection`',
    `assignment_source_system` STRING COMMENT 'Name of the system or channel through which the room assignment was made (e.g., OPERA PMS, Mobile Check-In, Kiosk, Front Desk Terminal).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the room assignment. Tracks progression from initial assignment through guest departure.. Valid values are `assigned|confirmed|checked_in|checked_out|cancelled|reassigned`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the room was assigned to the reservation. Represents the moment the assignment was committed in the PMS.',
    `bed_configuration` STRING COMMENT 'Bed type and configuration in the assigned room. Critical for matching guest preferences and group requirements. [ENUM-REF-CANDIDATE: king|queen|double_queen|twin|double_twin|murphy|sofa_bed — 7 candidates stripped; promote to reference product]',
    `building_code` STRING COMMENT 'Code identifying the building or tower within a multi-building property (e.g., MAIN, TOWER-A, VILLA). Null for single-building properties.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this room assignment record was first created in the system. Used for audit trail and data lineage.',
    `early_checkin_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment was made to accommodate an early check-in request (arrival before standard check-in time).',
    `floor_number` STRING COMMENT 'The floor level where the assigned room is located. Used for guest preferences and operational logistics.',
    `guest_preference_match_score` DECIMAL(18,2) COMMENT 'Calculated score (0-100) indicating how well this room assignment matches the guests stated preferences (floor, view, location, amenities). Used for service quality measurement.',
    `is_accessible_room` BOOLEAN COMMENT 'Boolean flag indicating whether the assigned room meets ADA accessibility requirements. Used for compliance reporting and guest matching.',
    `is_connecting_room` BOOLEAN COMMENT 'Boolean flag indicating whether this room is part of a connecting room pair or group. Used for family and group bookings.',
    `is_guest_requested` BOOLEAN COMMENT 'Boolean flag indicating whether the guest specifically requested this room or room type during pre-arrival or at check-in.',
    `is_upgrade` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment represents an upgrade from the originally booked room type.',
    `key_created_timestamp` TIMESTAMP COMMENT 'Date and time when the room key (physical or digital) was created for this assignment. Indicates actual guest check-in readiness.',
    `key_type` STRING COMMENT 'Type of room key issued to the guest for this assignment. Used for technology adoption tracking and guest preference analysis.. Valid values are `physical|mobile|rfid|magnetic_stripe`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this room assignment record was last updated. Used for change tracking and audit purposes.',
    `late_checkout_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this assignment includes a late check-out accommodation (departure after standard check-out time).',
    `lock_status` STRING COMMENT 'Status indicating whether the room assignment is locked (cannot be changed) or unlocked (can be reassigned). Used to prevent accidental changes during check-in.. Valid values are `unlocked|locked|pending_release`',
    `locked_timestamp` TIMESTAMP COMMENT 'Date and time when the room assignment was locked. Null if assignment is not locked.',
    `original_room_type_code` STRING COMMENT 'The room type code that was originally booked by the guest. Used to calculate upgrade value and track displacement.',
    `previous_room_number` STRING COMMENT 'The room number from which the guest was reassigned, if applicable. Null for initial assignments. Used for reassignment tracking.',
    `reassignment_count` STRING COMMENT 'Number of times this reservation has been reassigned to a different room. Used to track operational disruptions and guest experience impact.',
    `reassignment_reason_code` STRING COMMENT 'Code indicating the reason for room reassignment. Null if no reassignment has occurred. Used for root cause analysis.. Valid values are `maintenance_issue|guest_complaint|overbooking|upgrade|operational|guest_request`',
    `reassignment_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent room reassignment. Null if no reassignment has occurred.',
    `room_condition_at_assignment` STRING COMMENT 'Housekeeping status of the room at the time of assignment. Ensures only ready rooms are assigned to arriving guests.. Valid values are `clean|inspected|ready|maintenance_required|out_of_order`',
    `smoking_preference` STRING COMMENT 'Smoking designation of the assigned room. Used to match guest preferences and comply with local regulations.. Valid values are `non_smoking|smoking`',
    `special_request_notes` STRING COMMENT 'Free-text notes capturing any special requests related to the room assignment (e.g., high floor, away from elevator, connecting rooms, accessible features).',
    `upgrade_category` STRING COMMENT 'High-level category of the upgrade indicating whether it was complimentary, paid, loyalty-driven, or operationally necessary.. Valid values are `complimentary|paid|loyalty|operational`',
    `upgrade_reason_code` STRING COMMENT 'Code indicating the reason for the room upgrade. Null if is_upgrade is false. Used for revenue management and guest satisfaction analysis. [ENUM-REF-CANDIDATE: loyalty_status|operational|paid_upgrade|service_recovery|availability|overbooking|vip|group_courtesy — 8 candidates stripped; promote to reference product]',
    `view_type` STRING COMMENT 'Type of view available from the assigned room. Used for guest preference matching and upsell opportunities. [ENUM-REF-CANDIDATE: ocean|city|mountain|garden|pool|courtyard|partial_ocean|no_view — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_room_assignment PRIMARY KEY(`room_assignment_id`)
) COMMENT 'Transactional record linking a confirmed reservation to a specific physical room at the property, capturing the assigned room number, room type, floor, assignment timestamp, assignment method (auto-assigned, manually assigned, guest-requested), upgrade flag, upgrade reason, and assignment status. Tracks room reassignments and upgrades throughout the pre-arrival and check-in process. Sourced from Oracle OPERA PMS room assignment module.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` (
    `booking_package_id` BIGINT COMMENT 'Unique identifier for the booking package record. Primary key.',
    `banquet_menu_package_id` BIGINT COMMENT 'Foreign key linking to fnb.banquet_menu_package. Business justification: Reservation packages bundling F&B components (e.g., Dinner Included, Breakfast Package) must resolve to a specific banquet_menu_package for fulfillment routing, cost allocation, and F&B revenue po',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Packages are created and sold as part of marketing campaigns (e.g., Holiday Package under a seasonal campaign). Linking booking_package to campaign enables campaign-level package revenue attribution',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Package bookings are frequently tied to specific campaign offers (e.g., Summer Escape promo). Revenue and marketing teams track offer-driven package uptake for campaign ROI reporting. A travel-hospi',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Booking_package currently has cancellation_policy (string) field. Normalizing to FK allows joining to get full policy details (penalty terms, free cancellation windows, etc.). Packages have specific c',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: booking_package carries denormalized market_segment_code. Package revenue reporting by market segment is a standard hospitality revenue analysis. Normalizing via FK enables direct package revenue-by-s',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Booking packages are frequently created under loyalty promotions (e.g., Stay 3 nights earn double points). Linking booking_package to promotion enables promotion completion tracking, bonus points po',
    `property_id` BIGINT COMMENT 'Reference to the property where the package is offered and fulfilled. Used for multi-property reporting and revenue allocation.',
    `property_outlet_id` BIGINT COMMENT 'Foreign key linking to property.property_outlet. Business justification: Packages with F&B components (breakfast-included, dinner credits, happy hour) are redeemable at specific property outlets. This FK enables outlet-level package redemption tracking, F&B revenue allocat',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the parent reservation to which this package is attached.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Reference to the rate plan under which this package is offered. Links package to pricing strategy and market segment.',
    `reward_catalog_id` BIGINT COMMENT 'Foreign key linking to loyalty.reward_catalog. Business justification: Free-night awards and experiential rewards from the loyalty reward catalog are fulfilled as booking packages. Linking booking_package to reward_catalog enables redemption fulfillment tracking, invento',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.package. Business justification: Hotel booking packages frequently include spa packages as components. Linking reservation.booking_package to spa.package enables pre-arrival spa scheduling, fulfillment tracking, and accurate revenue ',
    `cancellation_deadline` TIMESTAMP COMMENT 'Date and time by which the package can be cancelled without penalty. Used for revenue management and guest communication.',
    `cancellation_reason` STRING COMMENT 'Reason code or free-text explanation for package cancellation. Used for service recovery and trend analysis.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the package was cancelled. Null if package is still active.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether the package revenue is eligible for commission payment to Online Travel Agency (OTA), Global Distribution System (GDS), or other intermediaries.',
    `component_list` STRING COMMENT 'Comma-separated or structured list of individual components included in the package (e.g., breakfast for 2, spa credit $100, parking, airport transfer). Used for operational fulfillment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the package record was first created in the system. Used for audit trail and booking velocity analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for package pricing. Examples: USD, EUR, GBP, JPY.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Date when the package expires or is no longer available for consumption. Typically aligns with check-out date.',
    `fb_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of package revenue allocated to the Food and Beverage (F&B) department for departmental profit analysis.',
    `fulfillment_instructions` STRING COMMENT 'Operational instructions for property staff on how to deliver and track package components. May include Point of Sale (POS) codes, voucher numbers, or service delivery notes.',
    `is_inclusive` BOOLEAN COMMENT 'Indicates whether the package rate is included in the room rate (true) or charged separately (false). Affects Average Daily Rate (ADR) calculation.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the package is mandatory for the reservation (e.g., resort fee, breakfast inclusion) or optional add-on.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the package charges are refundable upon cancellation or modification of the reservation.',
    `modified_by` STRING COMMENT 'User ID or name of the staff member or system that last modified the package record. Used for audit and quality control.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the package record was last modified. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text operational notes or comments about the package. Used for internal communication and service delivery coordination.',
    `package_category` STRING COMMENT 'Classification of the package type for reporting and revenue allocation purposes.. Valid values are `meal_plan|amenity|experience|transportation|promotional|corporate`',
    `package_cost_amount` DECIMAL(18,2) COMMENT 'Total cost to the property for delivering the package components. Used for Gross Operating Profit (GOP) calculation.',
    `package_description` STRING COMMENT 'Detailed description of the package contents, inclusions, terms, and conditions. Used for guest communication and operational fulfillment.',
    `package_name` STRING COMMENT 'Human-readable name of the package. Examples: Bed and Breakfast, Romance Package, Golf Getaway, Spa Retreat.',
    `package_rate_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the package charged to the guest. Represents the package price component of the reservation.',
    `package_status` STRING COMMENT 'Current lifecycle status of the package within the reservation. Tracks from reservation through fulfillment or cancellation. [ENUM-REF-CANDIDATE: active|reserved|confirmed|consumed|cancelled|expired|no_show — 7 candidates stripped; promote to reference product]',
    `posting_rhythm` STRING COMMENT 'Frequency and timing rule for posting package charges to the guest folio. Determines revenue recognition timing.. Valid values are `once|daily|per_night|per_person|on_departure`',
    `quantity` STRING COMMENT 'Number of package units included in the reservation. Typically 1 per guest or per room depending on package type.',
    `redemption_date` DATE COMMENT 'Date when the package was fully redeemed or consumed by the guest. Null if not yet redeemed.',
    `redemption_status` STRING COMMENT 'Tracks whether the guest has consumed or redeemed the package components. Used for fulfillment tracking and service recovery.. Valid values are `not_redeemed|partially_redeemed|fully_redeemed|expired|waived`',
    `revenue_allocation_method` STRING COMMENT 'Method for allocating package revenue across departments (rooms, Food and Beverage (F&B), spa, etc.) per Uniform System of Accounts for the Lodging Industry (USALI) standards.. Valid values are `rooms_only|split_allocation|component_based|departmental`',
    `rooms_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of package revenue allocated to the Rooms department for Revenue Per Available Room (RevPAR) and departmental reporting.',
    `source_system` STRING COMMENT 'System or channel through which the package was added to the reservation. Used for channel attribution and commission tracking. [ENUM-REF-CANDIDATE: OPERA|SynXis|Delphi|Direct|OTA|GDS|CRS — 7 candidates stripped; promote to reference product]',
    `special_requests` STRING COMMENT 'Guest-specific requests or modifications to the standard package (e.g., dietary restrictions for breakfast, preferred spa treatment time).',
    `start_date` DATE COMMENT 'Date when the package becomes active and available for guest consumption. Typically aligns with check-in date.',
    `tax_inclusive` BOOLEAN COMMENT 'Indicates whether the package rate amount includes applicable taxes (true) or taxes are calculated separately (false).',
    `created_by` STRING COMMENT 'User ID or name of the staff member or system that added the package to the reservation. Used for audit and training purposes.',
    CONSTRAINT pk_booking_package PRIMARY KEY(`booking_package_id`)
) COMMENT 'Transactional record capturing package components bundled with a reservation, such as breakfast inclusion, spa credits, parking, airport transfers, romance packages, and F&B vouchers. Stores package code, package description, included components, package rate, component value, posting instructions, and redemption status. Supports revenue allocation across departments (rooms vs. F&B vs. spa) and package fulfillment tracking. Sourced from Oracle OPERA PMS package module.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ADD CONSTRAINT `fk_reservation_reservation_booking_travel_agent_id` FOREIGN KEY (`travel_agent_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`travel_agent`(`travel_agent_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ADD CONSTRAINT `fk_reservation_booking_status_history_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ADD CONSTRAINT `fk_reservation_cancellation_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ADD CONSTRAINT `fk_reservation_reservation_group_block_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_reservation_group_block_id` FOREIGN KEY (`reservation_group_block_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_group_block`(`reservation_group_block_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ADD CONSTRAINT `fk_reservation_group_block_pickup_reservation_rate_plan_id` FOREIGN KEY (`reservation_rate_plan_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan`(`reservation_rate_plan_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ADD CONSTRAINT `fk_reservation_reservation_rate_plan_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ADD CONSTRAINT `fk_reservation_reservation_special_request_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ADD CONSTRAINT `fk_reservation_travel_agent_parent_agency_reservation_travel_agent_id` FOREIGN KEY (`parent_agency_reservation_travel_agent_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`travel_agent`(`travel_agent_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_connected_room_assignment_id` FOREIGN KEY (`connected_room_assignment_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`room_assignment`(`room_assignment_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ADD CONSTRAINT `fk_reservation_room_assignment_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_cancellation_policy_id` FOREIGN KEY (`cancellation_policy_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`cancellation_policy`(`cancellation_policy_id`);
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ADD CONSTRAINT `fk_reservation_booking_package_reservation_booking_id` FOREIGN KEY (`reservation_booking_id`) REFERENCES `travel_hospitality_ecm`.`reservation`.`reservation_booking`(`reservation_booking_id`);

-- ========= TAGS =========
ALTER SCHEMA `travel_hospitality_ecm`.`reservation` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `travel_hospitality_ecm`.`reservation` SET TAGS ('dbx_domain' = 'reservation');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `reservation_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Strategy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `travel_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `accessibility_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Arrival Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `crs_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Central Reservation System (CRS) Confirmation Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `crs_confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `early_checkin_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Check-In Requested Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|corporate_account|travel_agent_voucher|prepaid|none');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `late_checkout_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Check-Out Requested Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `modification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modification Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `number_of_adults` SET TAGS ('dbx_business_glossary_term' = 'Number of Adults');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `number_of_children` SET TAGS ('dbx_business_glossary_term' = 'Number of Children');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `number_of_rooms` SET TAGS ('dbx_business_glossary_term' = 'Number of Rooms');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `pms_reservation_code` SET TAGS ('dbx_business_glossary_term' = 'Property Management System (PMS) Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `pms_reservation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `points_earned` SET TAGS ('dbx_business_glossary_term' = 'Points Earned');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `total_room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Room Revenue');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_booking` ALTER COLUMN `vip_status_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP Status Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `booking_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Status History Identifier');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `booking_source_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `booking_source_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|modification|cancellation|no_show|check_in|check_out');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `guest_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Sent Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `guest_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `modification_field_name` SET TAGS ('dbx_business_glossary_term' = 'Modification Field Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `modification_type` SET TAGS ('dbx_business_glossary_term' = 'Modification Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `no_show_reason_code` SET TAGS ('dbx_business_glossary_term' = 'No-Show Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `no_show_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `original_value` SET TAGS ('dbx_business_glossary_term' = 'Original Value');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `penalty_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Fee Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `property_code` SET TAGS ('dbx_business_glossary_term' = 'Property Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `property_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `rate_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Difference Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `sla_actual_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Minutes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Minutes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `system_source` SET TAGS ('dbx_business_glossary_term' = 'System Source');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `system_source` SET TAGS ('dbx_value_regex' = 'OPERA_PMS|SYNXIS_CRS|MOBILE_APP|KIOSK|INTERFACE|BATCH');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,50}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_status_history` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `cancellation_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `ota_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Partner ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_value_regex' = 'open|resolved_guest_favor|resolved_property_favor|withdrawn');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'guest_cancellation|property_cancellation|ota_cancellation|no_show');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `guarantee_charge_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Charge Processed Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|corporate_guarantee|travel_agent_guarantee|none');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `original_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Original Arrival Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `original_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `ota_chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Chargeback Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `ota_chargeback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Travel Agency (OTA) Chargeback Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `penalty_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applicable Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|failed');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Processing Channel');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `revenue_lost_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Lost Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `room_nights_lost` SET TAGS ('dbx_business_glossary_term' = 'Room Nights Lost');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `waiver_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authorized By');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation` ALTER COLUMN `window_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Window Hours');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` SET TAGS ('dbx_subdomain' = 'group_reservations');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Group Block ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `group_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Group Evaluation Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `reservation_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `room_block_id` SET TAGS ('dbx_business_glossary_term' = 'Room Block Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Group Arrival Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `attrition_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Attrition Clause Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `attrition_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attrition Threshold Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `available_room_count` SET TAGS ('dbx_business_glossary_term' = 'Available Room Count');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `billing_instruction` SET TAGS ('dbx_business_glossary_term' = 'Billing Instruction');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Group Block Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Group Block Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Group Block Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'tentative|definite|cancelled|waitlist|inquiry|contracted');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Group Block Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Group Contact Email');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Group Contact Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Group Contact Phone');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `contracted_room_count` SET TAGS ('dbx_business_glossary_term' = 'Contracted Room Count');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Group Block Cutoff Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Group Departure Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `group_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Rate Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `lra_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Room Availability (LRA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Group Block Notes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `pickup_room_count` SET TAGS ('dbx_business_glossary_term' = 'Pickup Room Count');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `revenue_forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_group_block` ALTER COLUMN `wash_schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Wash Schedule Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` SET TAGS ('dbx_subdomain' = 'group_reservations');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `group_block_pickup_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Pickup Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `reservation_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Arrival Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `block_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Block Utilization Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `booking_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `group_attendee_type` SET TAGS ('dbx_business_glossary_term' = 'Group Attendee Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guarantee_type` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|corporate|travel_agent|none');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_business_glossary_term' = 'Guest Email Address');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_business_glossary_term' = 'Guest Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `guest_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `nights` SET TAGS ('dbx_business_glossary_term' = 'Number of Nights');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_before_cutoff_flag` SET TAGS ('dbx_business_glossary_term' = 'Pickup Before Cutoff Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_number` SET TAGS ('dbx_business_glossary_term' = 'Pickup Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_status` SET TAGS ('dbx_business_glossary_term' = 'Pickup Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `pickup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pickup Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `remaining_block_rooms` SET TAGS ('dbx_business_glossary_term' = 'Remaining Block Rooms');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OPERA|SYNXIS|DELPHI|SALESFORCE|MICROS');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `total_room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Room Revenue');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`group_block_pickup` ALTER COLUMN `vip_indicator` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Indicator');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` SET TAGS ('dbx_subdomain' = 'group_reservations');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `reservation_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Rate Plan ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Days');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `booking_window_end_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window End Days');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `booking_window_start_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Start Days');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_corporate_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Corporate Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_direct_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Direct Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_gds_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Global Distribution System (GDS) Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Group Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `channel_ota_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Online Travel Agency (OTA) Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `commissionable_flag` SET TAGS ('dbx_business_glossary_term' = 'Commissionable Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `guarantee_method` SET TAGS ('dbx_value_regex' = 'credit_card|deposit|prepayment|direct_bill|none');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `guarantee_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `loyalty_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `loyalty_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Multiplier');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `maximum_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `member_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Only Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `minimum_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `package_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Inclusion Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Category');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Description');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `rate_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|expired');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SYNXIS|OPERA|IDEAS|MANUAL');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_rate_plan` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Terms and Conditions');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` SET TAGS ('dbx_subdomain' = 'group_reservations');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `allows_modification` SET TAGS ('dbx_business_glossary_term' = 'Allows Modification Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `applies_to_corporate_bookings` SET TAGS ('dbx_business_glossary_term' = 'Applies to Corporate Bookings Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `applies_to_group_bookings` SET TAGS ('dbx_business_glossary_term' = 'Applies to Group Bookings Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `channel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Channel Restrictions');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `deposit_due_days_before_arrival` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Days Before Arrival');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `deposit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deposit Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `deposit_required` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `free_cancellation_window_days` SET TAGS ('dbx_business_glossary_term' = 'Free Cancellation Window Days');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `free_cancellation_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Free Cancellation Window Hours');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `guarantee_required` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `guest_facing_summary` SET TAGS ('dbx_business_glossary_term' = 'Guest-Facing Summary');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `is_non_refundable` SET TAGS ('dbx_business_glossary_term' = 'Non-Refundable Flag (NRR - Non-Refundable Rate)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `legal_terms_text` SET TAGS ('dbx_business_glossary_term' = 'Legal Terms Text');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `modification_fee` SET TAGS ('dbx_business_glossary_term' = 'Modification Fee');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_type` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `no_show_penalty_type` SET TAGS ('dbx_value_regex' = 'first_night|full_stay|flat_fee|percentage_of_stay|same_as_cancellation');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_nights_count` SET TAGS ('dbx_business_glossary_term' = 'Penalty Nights Count');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Penalty Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'first_night|percentage_of_stay|flat_fee|full_stay|no_penalty|nights_based');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|suspended');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_tier` SET TAGS ('dbx_business_glossary_term' = 'Policy Tier');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `policy_tier` SET TAGS ('dbx_value_regex' = 'flexible|moderate|strict|non_refundable|super_flexible|custom');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `seasonal_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Override Allowed Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OPERA|SynXis|IDeaS|Manual|Legacy');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`cancellation_policy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `reservation_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Special Request ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `benefit_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Entitlement Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `failure_category` SET TAGS ('dbx_business_glossary_term' = 'Failure Category');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `guest_feedback_text` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Text');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `guest_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Notified Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `guest_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction (GSAT) Rating');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `impacts_loyalty_points` SET TAGS ('dbx_business_glossary_term' = 'Impacts Loyalty Points');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `is_pre_arrival` SET TAGS ('dbx_business_glossary_term' = 'Is Pre-Arrival Request');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Request');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `is_vip_request` SET TAGS ('dbx_business_glossary_term' = 'Is VIP (Very Important Person) Request');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `request_category` SET TAGS ('dbx_business_glossary_term' = 'Request Category');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `request_code` SET TAGS ('dbx_business_glossary_term' = 'Request Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `request_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `request_text` SET TAGS ('dbx_business_glossary_term' = 'Request Text');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `requires_charge` SET TAGS ('dbx_business_glossary_term' = 'Requires Charge');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`reservation_special_request` ALTER COLUMN `target_fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fulfillment Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` SET TAGS ('dbx_subdomain' = 'group_reservations');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Identifier');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `parent_agency_reservation_travel_agent_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Travel Agency ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Travel Agency Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Travel Agency Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'retail|corporate_tmc|online_travel_agency|tour_operator|consortium|wholesaler');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `arc_number` SET TAGS ('dbx_business_glossary_term' = 'Airlines Reporting Corporation (ARC) Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `arc_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,8}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `booking_volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Booking Volume Tier');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `booking_volume_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `gds_identifier` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Identifier');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `iata_number` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `iata_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `last_booking_date` SET TAGS ('dbx_business_glossary_term' = 'Last Booking Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Notes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `onboarding_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completed Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|direct_bill|virtual_card|net_remit');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `total_bookings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Bookings Count');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `total_revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Generated Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `total_revenue_generated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_status` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `travel_agent_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|blacklisted');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`travel_agent` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment Identifier');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `connected_room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Connected Room Assignment ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'auto_assigned|manually_assigned|guest_requested|loyalty_preference|group_block|pre_arrival_selection');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|confirmed|checked_in|checked_out|cancelled|reassigned');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `bed_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bed Configuration');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `early_checkin_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Check-In Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `guest_preference_match_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Preference Match Score');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `is_accessible_room` SET TAGS ('dbx_business_glossary_term' = 'Is Accessible Room Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `is_connecting_room` SET TAGS ('dbx_business_glossary_term' = 'Is Connecting Room Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `is_guest_requested` SET TAGS ('dbx_business_glossary_term' = 'Is Guest Requested Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `is_upgrade` SET TAGS ('dbx_business_glossary_term' = 'Is Upgrade Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `key_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Key Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `key_type` SET TAGS ('dbx_business_glossary_term' = 'Key Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `key_type` SET TAGS ('dbx_value_regex' = 'physical|mobile|rfid|magnetic_stripe');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `late_checkout_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Check-Out Flag');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Lock Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `lock_status` SET TAGS ('dbx_value_regex' = 'unlocked|locked|pending_release');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `locked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Locked Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `original_room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Original Room Type Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `previous_room_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Room Number');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_reason_code` SET TAGS ('dbx_value_regex' = 'maintenance_issue|guest_complaint|overbooking|upgrade|operational|guest_request');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `reassignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `room_condition_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Room Condition at Assignment');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `room_condition_at_assignment` SET TAGS ('dbx_value_regex' = 'clean|inspected|ready|maintenance_required|out_of_order');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_business_glossary_term' = 'Smoking Preference');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_value_regex' = 'non_smoking|smoking');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `special_request_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Request Notes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `upgrade_category` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Category');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `upgrade_category` SET TAGS ('dbx_value_regex' = 'complimentary|paid|loyalty|operational');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `upgrade_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Reason Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`room_assignment` ALTER COLUMN `view_type` SET TAGS ('dbx_business_glossary_term' = 'View Type');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `booking_package_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Package ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `banquet_menu_package_id` SET TAGS ('dbx_business_glossary_term' = 'Banquet Menu Package Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `property_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Property Outlet Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `reward_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Catalog Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `cancellation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Package Cancellation Deadline');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Package Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Package Cancelled Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `component_list` SET TAGS ('dbx_business_glossary_term' = 'Package Component List');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Package End Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `fb_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Revenue Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `fulfillment_instructions` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instructions');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `is_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Inclusive Package');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Package');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Is Refundable Package');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Package Notes');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_category` SET TAGS ('dbx_business_glossary_term' = 'Package Category');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_category` SET TAGS ('dbx_value_regex' = 'meal_plan|amenity|experience|transportation|promotional|corporate');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Package Cost Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Package Rate Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `posting_rhythm` SET TAGS ('dbx_business_glossary_term' = 'Posting Rhythm');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `posting_rhythm` SET TAGS ('dbx_value_regex' = 'once|daily|per_night|per_person|on_departure');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Package Quantity');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'not_redeemed|partially_redeemed|fully_redeemed|expired|waived');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Method');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `revenue_allocation_method` SET TAGS ('dbx_value_regex' = 'rooms_only|split_allocation|component_based|departmental');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `rooms_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Rooms Revenue Amount');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Package Special Requests');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Package Start Date');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive');
ALTER TABLE `travel_hospitality_ecm`.`reservation`.`booking_package` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
