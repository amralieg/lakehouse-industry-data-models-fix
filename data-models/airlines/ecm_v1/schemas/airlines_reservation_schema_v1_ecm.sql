-- Schema for Domain: reservation | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`reservation` COMMENT 'Manages PNR (Passenger Name Record) creation, booking records, itineraries, seat assignments, check-in, boarding passes, e-ticket issuance, EMD (Electronic Miscellaneous Document), reservation modifications, GDS distribution, interline agreements, codeshare bookings, and MCT (Minimum Connecting Time) validation. SSOT for all booking and ticketing transaction lifecycle data. Aligns with Amadeus Altéa Reservation and Inventory.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`pnr` (
    `pnr_id` BIGINT COMMENT 'Unique system identifier for the PNR. Primary key. Surrogate key for internal database operations.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Airlines track which marketing campaigns drove bookings for ROI measurement and attribution modeling. Marketing teams require PNR-to-campaign linkage for performance reporting and budget allocation de',
    `cdm_message_id` BIGINT COMMENT 'Foreign key linking to airport.cdm_message. Business justification: PNRs drive CDM messaging for collaborative decision-making. Flight coordination, delay management, and airport slot optimization require this link for operational efficiency and regulatory compliance.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every PNR is booked under a specific airline legal entity (company code) for revenue recognition, regulatory reporting (IATA, DOT), and interline settlement. Aviation domain experts expect this link f',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: PNRs for loyalty members drive mileage accrual, tier qualification, upgrade eligibility, benefit application. Core operational link for FFP program integration with reservations.',
    `group_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.group_booking. Business justification: A PNR can be part of a group booking master record (10+ passengers travelling together). This is the correct direction (many PNRs → one group booking). Column group_name can be retrieved via JOIN from',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Reservation-level safety incidents (booking system failures causing operational disruption, fraud cases escalated to security/safety, group booking coordination failures affecting passenger safety, sp',
    `org_unit_id` BIGINT COMMENT 'Office ID of the airline or agency office responsible for this PNR. Used for accountability, reporting, and revenue allocation. Format varies by PSS (Passenger Service System).',
    `agency_iata_number` STRING COMMENT 'Eight-digit IATA numeric code identifying the travel agency that created the booking. Null for direct bookings. Used for commission calculation and BSP settlement.. Valid values are `^[0-9]{8}$`',
    `base_fare_amount` DECIMAL(18,2) COMMENT 'Base fare component of the total fare, excluding taxes, fees, and surcharges. Used for revenue accounting and interline proration.',
    `booking_source` STRING COMMENT 'Origin system or channel through which the PNR was created. Distinguishes between GDS (Global Distribution System), direct airline channels, NDC (New Distribution Capability), call center, mobile app, web, or airport kiosk. [ENUM-REF-CANDIDATE: gds|direct|ndc|call_center|mobile_app|web|kiosk — 7 candidates stripped; promote to reference product]',
    `booking_status` STRING COMMENT 'Current lifecycle status of the PNR. Indicates whether the reservation is active, on waitlist, cancelled, or archived after travel completion or expiry.. Valid values are `confirmed|waitlisted|cancelled|archived|ticketed|pending`',
    `booking_type` STRING COMMENT 'Classification of the booking based on passenger type and commercial arrangement. Distinguishes individual, group, corporate contract, interline, and codeshare bookings.. Valid values are `individual|group|corporate|interline|codeshare`',
    `codeshare_indicator` BOOLEAN COMMENT 'Flag indicating whether the PNR includes codeshare segments (flights marketed by one airline but operated by another). True if codeshare present, false otherwise.',
    `contact_email` STRING COMMENT 'Primary email address for PNR-level communication. Used for booking confirmations, itinerary changes, and operational notifications. May differ from individual passenger emails.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for PNR-level communication. Used for operational notifications, IROP (Irregular Operations) alerts, and customer service contact.',
    `corporate_account_number` STRING COMMENT 'Corporate discount or contract account number associated with the booking. Used for negotiated fare application and corporate reporting.',
    `creating_agent_sign` STRING COMMENT 'Agent sign or user ID of the individual who created the PNR. Used for audit trail and quality control.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the PNR was first created in the reservation system. Represents the initial booking event. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this PNR. Determines the currency for total fare, taxes, and fees.. Valid values are `^[A-Z]{3}$`',
    `departure_date` DATE COMMENT 'Date of the first flight segment departure in the itinerary. Used for reporting and operational planning. Format: yyyy-MM-dd.',
    `destination_city_code` STRING COMMENT 'Three-letter IATA city code for the final arrival point in the itinerary. Used for origin-destination (O&D) analysis.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'Specific distribution channel or sub-channel identifier. For GDS bookings, includes the GDS name (Amadeus, Sabre, Travelport). For direct bookings, includes the specific platform or partner.',
    `form_of_payment_summary` STRING COMMENT 'Summary description of the payment method(s) used for this PNR. May include credit card type, cash, voucher, or multiple forms of payment. Detailed payment data stored separately for PCI compliance.',
    `interline_indicator` BOOLEAN COMMENT 'Flag indicating whether the PNR includes segments operated by multiple airlines under interline agreements. True if interline, false if single-carrier.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the PNR. Updated whenever any element of the PNR is changed (segments, passengers, services, remarks). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modifying_agent_sign` STRING COMMENT 'Agent sign or user ID of the individual who last modified the PNR. Updated with each change for audit trail.',
    `origin_city_code` STRING COMMENT 'Three-letter IATA city code for the first departure point in the itinerary. Used for origin-destination (O&D) analysis.. Valid values are `^[A-Z]{3}$`',
    `passenger_count` STRING COMMENT 'Total number of passengers included in this PNR. Supports group bookings and family travel.',
    `point_of_sale_city` STRING COMMENT 'Three-letter IATA city code representing the city where the booking was made. Used for market analysis and revenue management.. Valid values are `^[A-Z]{3}$`',
    `point_of_sale_country` STRING COMMENT 'Three-letter ISO country code representing the country where the booking was made. Critical for revenue accounting, tax calculation, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `purge_date` DATE COMMENT 'Date when the PNR is scheduled to be purged or archived from the active reservation system. Typically set based on last travel date plus retention period. Format: yyyy-MM-dd.',
    `queue_number` STRING COMMENT 'PSS queue number where the PNR is currently placed for agent action. Used for workflow management and ticketing time limit monitoring.',
    `record_locator` STRING COMMENT 'Six-character alphanumeric code uniquely identifying the PNR across systems. The externally-known business identifier used by agents, passengers, and partner systems. Also known as booking reference or confirmation code.. Valid values are `^[A-Z0-9]{6}$`',
    `return_date` DATE COMMENT 'Date of the return flight segment departure for round-trip itineraries. Null for one-way or multi-city trips. Format: yyyy-MM-dd.',
    `segment_count` STRING COMMENT 'Total number of flight segments (legs) included in this PNR itinerary. Each flight leg is counted separately.',
    `special_service_request_codes` STRING COMMENT 'Comma-separated list of four-letter SSR codes applicable to the entire PNR (e.g., WCHR for wheelchair, PETC for pet in cabin). Individual passenger SSRs stored separately.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount for the PNR, including government taxes, airport taxes, and other mandatory levies. Expressed in the currency specified by currency_code.',
    `ticketed_timestamp` TIMESTAMP COMMENT 'Date and time when the PNR was ticketed (e-ticket issued). Null if not yet ticketed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ticketing_time_limit` TIMESTAMP COMMENT 'Deadline by which the PNR must be ticketed or the reservation will be automatically cancelled. Critical for revenue management and inventory control. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `total_fare_amount` DECIMAL(18,2) COMMENT 'Total fare amount for all passengers and segments in the PNR, including base fare, taxes, fees, and surcharges. Expressed in the currency specified by currency_code.',
    `tour_code` STRING COMMENT 'Tour operator or bulk fare contract code associated with the PNR. Used for special fare validation and commission calculation.',
    `trip_type` STRING COMMENT 'Type of itinerary structure. One-way (single segment), round-trip (outbound and return), multi-city (multiple destinations), or open-jaw (different origin/destination for outbound and return).. Valid values are `one_way|round_trip|multi_city|open_jaw`',
    CONSTRAINT pk_pnr PRIMARY KEY(`pnr_id`)
) COMMENT 'Passenger Name Record (PNR) — the master booking record and SSOT for all reservation data within the airline. Captures the full PNR lifecycle from creation through ticketing, modification, and archival/purge. Stores PNR record locator (6-character alphanumeric), booking source (GDS/direct/NDC), distribution channel, booking date, ticketing time limit (TTL), booking status (confirmed/waitlisted/cancelled/archived), currency, total fare amount, form of payment summary, agency IATA number, responsible office ID, creating agent sign, creation timestamp, last modification timestamp, number of passengers, number of segments, and PNR purge date. Central hub entity to which all other reservation products relate. Aligns with Amadeus Altéa Reservation and IATA RP 1745 PNR standards.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`itinerary_segment` (
    `itinerary_segment_id` BIGINT COMMENT 'Unique identifier for the itinerary segment. Primary key for this entity representing a single booked flight leg within a PNR.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Flight planning, schedule optimization, passenger notifications, and operational assignment all require knowing which aircraft type operates each segment. Equipment_type_code is denormalized ICAO/IATA',
    `award_inventory_id` BIGINT COMMENT 'Foreign key linking to loyalty.award_inventory. Business justification: Award bookings consume specific award inventory allocations per segment. Business process: award seat allocation tracking, inventory management, waitlist clearance, dynamic award pricing.',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Segments book into specific cabin classes (First, Business, Premium Economy, Economy). This link is essential for cabin-level load factor reporting, service delivery (meal type, baggage allowance, lou',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Revenue management, seat inventory control, ancillary pricing (preferred seats, extra legroom), and passenger service delivery depend on knowing exact cabin layout for each segment. Cabin configuratio',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Revenue management analyzes which campaigns drive bookings on specific routes and flights for pricing strategy optimization. Segment-level campaign attribution enables route-specific promotional effec',
    `cdm_message_id` BIGINT COMMENT 'Foreign key linking to airport.cdm_message. Business justification: Flight segments generate CDM milestone messages (TOBT, EOBT, TSAT). Airport coordination, slot management, and turnaround optimization require this link for collaborative decision-making processes.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Flight segments are attributed to cost centers (route, hub, region) for management accounting, CASK/RASK analysis, and route profitability reporting. Essential for operational finance and network plan',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Every flight segment departs from a station. Flight planning, crew scheduling, slot coordination, ground handling, and operational reporting all require this link. Core operational relationship in air',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Segment-level FFP tracking required for mileage accrual calculation, tier qualifying segment counting, partner airline crediting. Business process: post-flight accrual posting per segment flown.',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Every booked segment must reference the inventory control record for the specific flight being sold. This is the foundational link enabling revenue management to track bookings against authorized capa',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Segments are booked on specific flight numbers. Critical for inventory control, codeshare management, schedule change processing, and GDS distribution. Core airline reservation system requirement link',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Flight segment-specific safety occurrences (in-flight turbulence injuries, cabin incidents, medical emergencies, passenger disturbances) require linkage to the itinerary segment for passenger manifest',
    `pnr_id` BIGINT COMMENT 'Reference to the parent PNR containing this segment. Links this flight leg to the overall booking record.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Every booked segment operates on a defined route in the network. Essential for schedule planning, revenue management, network analysis, and operational reporting. Aviation standard practice to link bo',
    `slot_id` BIGINT COMMENT 'Foreign key linking to airport.slot. Business justification: Flight segments at slot-coordinated airports consume allocated slots. Slot compliance monitoring, historic rights protection, and regulatory reporting (IATA slot coordination) require this link for sc',
    `turnaround_id` BIGINT COMMENT 'Foreign key linking to airport.turnaround. Business justification: Flight segments are served by turnarounds. Operational planning (minimum ground time), delay attribution, and ground handling cost allocation require this link for operational efficiency and cost mana',
    `action_code` STRING COMMENT 'Transaction action code representing the booking action taken. NN=Need, HN=Have need, HK=Holding confirmed, KK=Confirmed, UC=Unable to confirm, UN=Unable need, NO=No action, HL=Have waitlist, KL=Confirmed from waitlist, TK=Schedule change confirmed, TL=Schedule change waitlist, HX=Have cancel, XX=Cancel confirmed, WK=Waitlist, RQ=On request. [ENUM-REF-CANDIDATE: NN|HN|HK|KK|UC|UN|NO|HL|KL|TK|TL|HX|XX|WK|RQ — 15 candidates stripped; promote to reference product]',
    `arrival_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination airport of this segment.. Valid values are `^[A-Z]{3}$`',
    `baggage_allowance` STRING COMMENT 'Baggage allowance for this segment expressed in piece concept (e.g., 2PC) or weight concept (e.g., 23KG). Determined by fare class and route.',
    `booking_channel_code` STRING COMMENT 'Channel through which this segment was booked. GDS=Global Distribution System, WEB=Website, MOB=Mobile App, CTO=City Ticket Office, RES=Reservations Call Center, API=Direct API.. Valid values are `GDS|WEB|MOB|CTO|RES|API`',
    `booking_class_code` STRING COMMENT 'Single-letter Reservation Booking Designator (RBD) representing the fare class booked. Determines inventory bucket and fare rules.. Valid values are `^[A-Z]{1}$`',
    `codeshare_indicator` BOOLEAN COMMENT 'Flag indicating whether this segment is a codeshare flight where marketing and operating carriers differ.',
    `endorsement_restrictions` STRING COMMENT 'Free-text field containing fare rule endorsements and restrictions applicable to this segment (e.g., NON-REF, CHG FEE APPLIES).',
    `fare_amount` DECIMAL(18,2) COMMENT 'Base fare amount allocated to this segment for fare construction and revenue accounting purposes. Excludes taxes and fees.',
    `fare_basis_code` STRING COMMENT 'Alphanumeric code identifying the specific fare product and associated rules. Encodes booking class, seasonality, restrictions, and fare type.',
    `fare_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the fare amount.. Valid values are `^[A-Z]{3}$`',
    `flown_indicator` BOOLEAN COMMENT 'Flag indicating whether the passenger has completed travel on this segment. Set to true after departure or boarding confirmation.',
    `gds_pcc_code` STRING COMMENT 'GDS Pseudo City Code identifying the travel agency or corporate booking location that created this segment reservation.',
    `interline_indicator` BOOLEAN COMMENT 'Flag indicating whether this segment involves interline ticketing with a different carrier than adjacent segments in the itinerary.',
    `marketing_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier marketing and selling this segment. May differ from operating carrier in codeshare scenarios.. Valid values are `^[A-Z0-9]{2}$`',
    `marketing_flight_number` STRING COMMENT 'Flight number as marketed to the passenger. Includes numeric identifier and optional suffix letter.. Valid values are `^[0-9]{1,4}[A-Z]?$`',
    `marriage_group_indicator` STRING COMMENT 'Single-letter code grouping segments that must be priced together as a married segment. Segments with the same indicator are married for fare construction.. Valid values are `^[A-Z]{1}$`',
    `meal_service_code` STRING COMMENT 'IATA meal service code indicating the type of meal service provided. B=Breakfast, K=Continental Breakfast, L=Lunch, D=Dinner, S=Snack, V=Refreshment, M=Meal, R=Refreshment for purchase, G=Food for purchase, H=Hot meal, C=Alcoholic beverages for purchase, F=Food and beverages for purchase, P=Alcoholic beverages complimentary, O=Cold meal, N=No meal service. [ENUM-REF-CANDIDATE: B|K|L|D|S|V|M|R|G|H|C|F|P|O|N — 15 candidates stripped; promote to reference product]',
    `number_of_seats` STRING COMMENT 'Quantity of seats booked on this segment for the associated passengers in the PNR.',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier physically operating this flight. Populated when segment is a codeshare.. Valid values are `^[A-Z0-9]{2}$`',
    `operating_flight_number` STRING COMMENT 'Actual flight number operated by the operating carrier. Populated when segment is a codeshare and differs from marketing flight number.. Valid values are `^[0-9]{1,4}[A-Z]?$`',
    `schedule_change_indicator` BOOLEAN COMMENT 'Flag indicating whether this segment has experienced a schedule change since original booking, requiring passenger notification and acceptance.',
    `scheduled_arrival_datetime` TIMESTAMP COMMENT 'Scheduled arrival date and time in local airport time zone. Represents the planned gate arrival time at booking.',
    `scheduled_departure_datetime` TIMESTAMP COMMENT 'Scheduled departure date and time in local airport time zone. Represents the planned gate departure time at booking.',
    `segment_created_timestamp` TIMESTAMP COMMENT 'Date and time when this segment was first added to the PNR in the reservation system.',
    `segment_mileage` STRING COMMENT 'Great circle distance in miles between departure and arrival airports. Used for fare construction and frequent flyer accrual.',
    `segment_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this segment was last modified (status change, schedule change, or other update).',
    `segment_sequence_number` STRING COMMENT 'Sequential ordering of this segment within the PNR itinerary. Determines the travel flow from origin to final destination.',
    `segment_status_code` STRING COMMENT 'Current reservation status of the segment. HK=Confirmed, KK=Confirmed by carrier, KL=Confirmed waitlist cleared, HL=Have requested waitlist, UN=Unable to confirm, UC=Unable to accept, NO=No action taken, WK=Waitlisted, RQ=Requested, TK=Schedule change confirmed, TL=Schedule change waitlist. [ENUM-REF-CANDIDATE: HK|KK|KL|HL|UN|UC|NO|WK|RQ|TK|TL — 11 candidates stripped; promote to reference product]',
    `stopover_indicator` BOOLEAN COMMENT 'Flag indicating whether this segment represents a stopover (stay exceeding MCT) versus a connection in the passenger journey.',
    `ticketing_time_limit` TIMESTAMP COMMENT 'Deadline by which this segment must be ticketed or the reservation will be automatically cancelled. Set by fare rules or airline policy.',
    `tour_code` STRING COMMENT 'Alphanumeric code identifying a tour package or bulk fare contract associated with this segment. Used for negotiated or inclusive tour fares.',
    CONSTRAINT pk_itinerary_segment PRIMARY KEY(`itinerary_segment_id`)
) COMMENT 'Individual flight segment within a PNR itinerary. Represents a single booked flight leg including operating carrier code, flight number, departure airport IATA code, arrival airport IATA code, scheduled departure date and time, scheduled arrival date and time, booking class (RBD), cabin class, fare basis code, segment status code (HK/KL/UN/NO), number of seats, codeshare indicator, operating carrier flight number, marketing carrier code, equipment type, and segment sequence number. Core operational unit of the itinerary.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`e_ticket` (
    `e_ticket_id` BIGINT COMMENT 'Primary key for e_ticket',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Tickets generate accounts receivable entries in BSP/ARC settlement cycles. Airlines track AR aging, credit control, and cash collection by ticket. Natural link for revenue accounting and cash flow man',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Revenue accounting attributes ticket revenue to marketing campaigns for final ROI calculation after ticketing. Finance reconciles marketing spend against attributed ticket revenue to measure campaign ',
    `fare_quote_id` BIGINT COMMENT 'Foreign key linking to reservation.fare_quote. Business justification: E-ticket is issued based on a stored fare quote within the PNR. Linking to fare_quote provides the authoritative pricing record and fare calculation details. Columns fare_basis_code and fare_calculati',
    `org_unit_id` BIGINT COMMENT 'IATA 9-character office identifier (Office ID) of the location or agency that issued the ticket. Used for settlement and commission tracking.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger for whom this electronic ticket was issued. Links ticket to passenger master data.',
    `pnr_id` BIGINT COMMENT 'Reference to the Passenger Name Record (PNR) associated with this electronic ticket. Links the ticket to the booking record.',
    `base_fare_amount` DECIMAL(18,2) COMMENT 'Base fare amount for the ticket before taxes and fees. Represents the airlines revenue portion of the ticket price.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount paid to the issuing agent or travel agency for selling the ticket. Used for BSP/ARC settlement.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Commission rate percentage applied to calculate the commission amount. Null if flat commission was used.',
    `conjunction_ticket_indicator` BOOLEAN COMMENT 'Flag indicating whether this ticket is part of a conjunction ticket set (multiple tickets issued together for a single journey exceeding 4 flight coupons).',
    `conjunction_ticket_numbers` STRING COMMENT 'Comma-separated list of related conjunction ticket numbers if this ticket is part of a multi-ticket set. Empty if not a conjunction ticket.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this e-ticket record was first created in the reservation system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 3-letter currency code for all monetary amounts on this ticket (base fare, tax, total).. Valid values are `^[A-Z]{3}$`',
    `endorsement_restrictions` STRING COMMENT 'Free-text field containing fare restrictions, endorsements, and special conditions applicable to the ticket (e.g., NON-REFUNDABLE, VALID ON XX ONLY).',
    `equivalent_currency_code` STRING COMMENT 'ISO 4217 3-letter currency code for the equivalent fare amount. Null if no currency conversion was applied.. Valid values are `^[A-Z]{3}$`',
    `equivalent_fare_amount` DECIMAL(18,2) COMMENT 'Fare amount converted to the currency of the country of commencement of travel, if different from ticket currency. Used for settlement purposes.',
    `exchange_date` DATE COMMENT 'Date when the ticket was exchanged for a new ticket. Null if ticket has not been exchanged.',
    `exchange_ticket_indicator` BOOLEAN COMMENT 'Flag indicating whether this ticket was issued as an exchange for a previous ticket. True if this is a reissued ticket.',
    `form_of_payment_details` STRING COMMENT 'Detailed payment information including masked card number, approval code, or account reference. Sensitive financial data stored according to PCI-DSS requirements.',
    `form_of_payment_type` STRING COMMENT 'Primary payment method used to purchase the ticket. Identifies how the passenger paid for the ticket. [ENUM-REF-CANDIDATE: CASH|CREDIT_CARD|DEBIT_CARD|VOUCHER|MILES|CORPORATE_ACCOUNT|INVOICE — 7 candidates stripped; promote to reference product]',
    `gds_pcc` STRING COMMENT 'GDS Pseudo City Code (PCC) of the agency or office that created the booking. Used for GDS reporting and commission tracking.',
    `gds_record_locator` STRING COMMENT 'GDS-specific booking reference number (record locator) linking the ticket to the GDS reservation. May differ from airline PNR.',
    `in_connection_with_ticket` STRING COMMENT 'Ticket number of a related ticket when this ticket is issued in connection with another (e.g., companion ticket, family booking). Null if standalone.',
    `issue_date` DATE COMMENT 'Date when the electronic ticket was issued to the passenger. Represents the contractual agreement date.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise date and time when the electronic ticket was issued, including timezone. Used for audit and settlement purposes.',
    `issuing_airline_code` STRING COMMENT 'IATA 2-letter or 3-digit airline code of the carrier that issued the electronic ticket. Identifies the validating carrier responsible for the ticket.. Valid values are `^[A-Z0-9]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this e-ticket record was last updated. Tracks the most recent change to any field in the record.',
    `original_ticket_number` STRING COMMENT '13-digit ticket number of the original ticket if this is an exchange or reissue. Null for original issuances. Used to track ticket exchange history.',
    `refund_indicator` BOOLEAN COMMENT 'Flag indicating whether a refund has been processed for this ticket. True if ticket has been refunded (fully or partially).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount collected on the ticket. Sum of all applicable government taxes, airport fees, and surcharges.',
    `ticket_designator` STRING COMMENT 'Special fare qualifier or corporate discount code applied to the ticket. Used for negotiated corporate rates or promotional fares.',
    `ticket_number` STRING COMMENT '13-digit IATA standard ticket number uniquely identifying the electronic ticket document. Format: 3-digit airline code + 10-digit serial number. This is the contractual document of carriage identifier.. Valid values are `^[0-9]{13}$`',
    `ticket_status` STRING COMMENT 'Current lifecycle status of the electronic ticket. OPEN=valid for travel, USED=travel completed, VOID=cancelled before use, REFUNDED=refund processed, EXCHANGED=replaced by new ticket, SUSPENDED=temporarily invalid.. Valid values are `OPEN|USED|VOID|REFUNDED|EXCHANGED|SUSPENDED`',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount paid for the ticket including base fare, taxes, and all fees. This is the final price paid by the passenger.',
    `tour_code` STRING COMMENT 'Tour operator or bulk fare identifier if the ticket was issued under a tour or group contract. Null for regular published fares.',
    `validating_carrier_code` STRING COMMENT 'IATA airline code of the carrier responsible for fare rules, refunds, and exchanges. May differ from issuing airline in interline scenarios.. Valid values are `^[A-Z0-9]{2,3}$`',
    `void_date` DATE COMMENT 'Date when the ticket was voided. Null if ticket has not been voided. Voiding typically occurs within 24 hours of issuance.',
    CONSTRAINT pk_e_ticket PRIMARY KEY(`e_ticket_id`)
) COMMENT 'Electronic ticket (e-ticket) record representing the contractual document of carriage issued to a passenger. Stores ticket number (13-digit IATA format), conjunction ticket numbers, issuing airline code, issuing office IATA number, ticket issue date and time, ticket status (OPEN/USED/VOID/REFUNDED/EXCHANGED), fare amount, tax breakdown, total amount, form of payment, fare calculation string, endorsement/restriction text, tour code, commission amount, and original ticket number for exchanges. SSOT for ticketing lifecycle. Aligns with Amadeus Altéa ticketing module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` (
    `reservation_booking_passenger_id` BIGINT COMMENT 'Unique identifier for the passenger name element (PNE) within the PNR. This is the booking-scoped passenger reference; the canonical passenger identity master is owned by the passenger domain.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the canonical passenger master record in the passenger domain. Enables cross-booking passenger recognition and loyalty program linkage.',
    `pnr_id` BIGINT COMMENT 'Foreign key reference to the parent PNR booking record. Links this passenger name element to the reservation container.',
    `apis_data_complete_flag` BOOLEAN COMMENT 'Indicates whether all required APIS data elements (name, DOB, gender, nationality, passport) have been collected for this passenger. Required for international travel compliance.',
    `associated_infant_indicator` BOOLEAN COMMENT 'Flag indicating whether this adult passenger has an associated infant (lap child) traveling with them. Used for seat assignment and boarding validation.',
    `boarding_pass_issued_flag` BOOLEAN COMMENT 'Indicates whether a boarding pass has been issued to this passenger for at least one segment in the itinerary.',
    `booking_status` STRING COMMENT 'Current reservation status of this passenger within the PNR. Reflects confirmation, waitlist, cancellation, or no-show state.. Valid values are `CONFIRMED|WAITLISTED|CANCELLED|NO_SHOW`',
    `check_in_status` STRING COMMENT 'Current check-in and boarding status of the passenger. Tracks progression from reservation through boarding.. Valid values are `NOT_CHECKED_IN|CHECKED_IN|BOARDED|OFFLOADED`',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the passenger completed check-in for the first flight segment in the itinerary. Used for boarding priority and operational reporting.',
    `contact_email` STRING COMMENT 'Primary email address for this passenger. Used for e-ticket delivery, flight notifications, and IROP communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone_number` STRING COMMENT 'Primary contact phone number for this passenger. Used for flight notifications, IROP rebooking, and operational communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this passenger name element was first added to the PNR. Audit trail for booking creation.',
    `date_of_birth` DATE COMMENT 'Date of birth of the passenger. Required for infant and child passengers, and for APIS (Advanced Passenger Information System) compliance on international flights.',
    `emergency_contact_name` STRING COMMENT 'Full name of the passengers emergency contact person. Collected for safety and incident response purposes.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the passengers emergency contact person. Used in case of flight incidents or medical emergencies.',
    `first_name` STRING COMMENT 'Given name of the passenger as it appears on travel documents. Must match government-issued ID for international travel.',
    `frequent_flyer_number` STRING COMMENT 'Passengers frequent flyer membership number for the operating carrier or alliance partner. Used for mileage accrual, tier recognition, and SSR processing.',
    `frequent_flyer_tier_code` STRING COMMENT 'Current tier or status level of the passenger in the frequent flyer program. Used for priority boarding, lounge access, and upgrade eligibility.. Valid values are `BASIC|SILVER|GOLD|PLATINUM|DIAMOND`',
    `gender` STRING COMMENT 'Gender of the passenger as recorded in the booking. M=Male, F=Female, U=Unspecified, X=Non-binary. Required for APIS compliance.. Valid values are `M|F|U|X`',
    `known_traveller_number` STRING COMMENT 'TSA PreCheck or other trusted traveler program number. Enables expedited security screening for eligible passengers on US domestic and international flights.',
    `last_name` STRING COMMENT 'Family name or surname of the passenger as it appears on travel documents. Must match government-issued ID for international travel.',
    `meal_preference_code` STRING COMMENT 'IATA standard meal code representing the passengers dietary preference or restriction. VGML=Vegetarian, HNML=Hindu, KSML=Kosher, MOML=Muslim, AVML=Asian Vegetarian, DBML=Diabetic. [ENUM-REF-CANDIDATE: REGULAR|VGML|HNML|KSML|MOML|AVML|DBML — 7 candidates stripped; promote to reference product]',
    `middle_name` STRING COMMENT 'Middle name or initial of the passenger. Optional field used when provided on travel documents.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this passenger name element was last modified. Tracks name corrections, SSR updates, and status changes.',
    `nationality_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the passengers nationality. Required for APIS and visa validation.. Valid values are `^[A-Z]{3}$`',
    `passenger_sequence_number` STRING COMMENT 'Sequential ordering of this passenger within the PNR. Used for display, SSR association, and segment assignment. Typically starts at 1.',
    `passenger_type_code` STRING COMMENT 'IATA passenger type code indicating age category and fare eligibility. ADT=Adult, CHD=Child, INF=Infant (lap), INS=Infant (seat), YTH=Youth, UNN=Unaccompanied Minor.. Valid values are `ADT|CHD|INF|INS|YTH|UNN`',
    `redress_number` STRING COMMENT 'DHS Traveler Redress Inquiry Program (TRIP) number issued to passengers who have been misidentified during security screening. Prevents false matches on watchlists.',
    `seat_preference_code` STRING COMMENT 'Passengers preferred seat location type. Used by seat assignment algorithms and displayed to agents during check-in.. Valid values are `WINDOW|AISLE|MIDDLE|NONE`',
    `source_system_code` STRING COMMENT 'Identifies the PSS or GDS system through which this passenger name element was created. ALTEA=Amadeus Altéa, DIRECT=airline.com or mobile app.. Valid values are `ALTEA|SABRE|AMADEUS|WORLDSPAN|GALILEO|DIRECT`',
    `special_service_request_count` STRING COMMENT 'Total number of SSR records associated with this passenger in the PNR. Includes wheelchair assistance, unaccompanied minor service, pet in cabin, extra baggage, etc.',
    `suffix` STRING COMMENT 'Generational or professional suffix appended to the passenger name (e.g., Jr., Sr., III). Used for name disambiguation.. Valid values are `JR|SR|II|III|IV`',
    `ticket_issue_date` DATE COMMENT 'Date when the e-ticket was issued to this passenger. Used for fare rule validation and refund calculations.',
    `ticket_number` STRING COMMENT '13-digit IATA e-ticket number issued to this passenger. Format: 3-digit airline code + 10-digit serial number. Links to the ticket coupon records.. Valid values are `^[0-9]{13}$`',
    `title` STRING COMMENT 'Honorific title of the passenger as recorded in the booking. Used for ticket issuance and customer communication. [ENUM-REF-CANDIDATE: MR|MS|MRS|MISS|DR|PROF|MSTR — 7 candidates stripped; promote to reference product]',
    `unaccompanied_minor_flag` BOOLEAN COMMENT 'Indicates whether this passenger is traveling as an unaccompanied minor and requires special handling, escort service, and guardian handoff procedures.',
    `wheelchair_assistance_code` STRING COMMENT 'IATA SSR code indicating level of wheelchair assistance required. WCHR=Can walk short distances, WCHS=Cannot climb stairs, WCHC=Immobile, requires wheelchair throughout.. Valid values are `WCHR|WCHS|WCHC|NONE`',
    CONSTRAINT pk_reservation_booking_passenger PRIMARY KEY(`reservation_booking_passenger_id`)
) COMMENT 'Passenger name element (PNE) within a PNR — the reservation-context association of a traveller to a booking. Stores passenger title, first name, last name, suffix, passenger type code (ADT/CHD/INF/INS/YTH/UNN), date of birth, gender, nationality, associated infant indicator, frequent flyer number and tier (for display/SSR purposes), known traveller number (KTN), redress number, APIS data completeness flag, seat preference (window/aisle/none), meal preference code, SSR count, and passenger sequence number within the PNR. This is the booking-scoped passenger reference; the canonical passenger identity master is owned by the passenger domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`ssr` (
    `ssr_id` BIGINT COMMENT 'Unique identifier for the special service request record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the travel agent, airline staff member, or system user who created or last modified this SSR.',
    `itinerary_segment_id` BIGINT COMMENT 'Reference to the specific flight segment to which this SSR applies. Nullable if SSR applies to all segments.',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: SSRs like wheelchair assistance, unaccompanied minor supervision are fulfilled by specific cabin crew members. Airlines track which crew member provided the service for quality assurance, regulatory c',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Special service request failures (wheelchair assistance not provided causing injury, medical oxygen equipment malfunction, unaccompanied minor supervision lapses, service animal incidents) are safety ',
    `org_unit_id` BIGINT COMMENT 'IATA office identifier (9-character alphanumeric) of the agency or airline office that created this SSR.',
    `profile_id` BIGINT COMMENT 'Reference to the specific passenger within the PNR for whom this SSR applies. Nullable if SSR applies to all passengers.',
    `pnr_id` BIGINT COMMENT 'Reference to the PNR to which this SSR is attached.',
    `ramp_service_order_id` BIGINT COMMENT 'Foreign key linking to airport.ramp_service_order. Business justification: Special service requests (wheelchair, stretcher, oxygen) require ramp service coordination. Ground handling service delivery, equipment allocation, and SLA tracking depend on this link for operational',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: SSRs for wheelchair, medical oxygen, service animals trigger ADA/ACAA/EU accessibility compliance requirements. Special services must satisfy regulatory mandates; operations validate SSR against appli',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: SSR (Special Service Request) is often attached to a specific passenger name element within the PNR. While ssr has pax_profile_id, it should also link to the booking-context passenger to maintain the ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Airlines contract third-party vendors (wheelchair assistance, special meal catering, medical oxygen suppliers) to fulfill SSRs at stations. Operations teams track which vendor fulfilled each SSR for i',
    `action_required_flag` BOOLEAN COMMENT 'Indicates whether operational action is required by airline staff to fulfill this SSR (e.g., wheelchair provision, meal loading, document verification).',
    `apis_required_flag` BOOLEAN COMMENT 'Indicates whether this SSR is required for APIS compliance (e.g., DOCS, DOCA, DOCO SSRs for border control and security).',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why this SSR was cancelled (e.g., passenger request, flight change, service unavailable).',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when this SSR was cancelled or removed from the PNR. Null if still active.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for this SSR if charge_applicable_flag is true. Null if complimentary.',
    `charge_applicable_flag` BOOLEAN COMMENT 'Indicates whether this SSR incurs a charge to the passenger (e.g., paid meal upgrade, pet in cabin fee). False for complimentary services.',
    `charge_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `codeshare_flag` BOOLEAN COMMENT 'Indicates whether this SSR applies to a codeshare flight segment where the marketing and operating carriers differ.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SSR record was first created in the reservation system.',
    `creation_source` STRING COMMENT 'Channel or system through which the SSR was originally created (e.g., GDS, airline website, mobile app, call center, airport check-in, API integration). [ENUM-REF-CANDIDATE: gds|web|mobile|call_center|airport|api|amadeus|sabre|galileo|worldspan — 10 candidates stripped; promote to reference product]',
    `emd_number` STRING COMMENT '13-digit EMD number issued for this SSR if it is a paid ancillary service. Null if no EMD issued.. Valid values are `^[0-9]{13}$`',
    `expiry_date` DATE COMMENT 'Date after which this SSR is no longer valid or applicable. Relevant for time-sensitive SSRs such as travel documents or temporary medical conditions.',
    `free_text` STRING COMMENT 'Free-text field containing additional details or remarks associated with the SSR. May include passenger-specific instructions, medical details, or document numbers.',
    `fulfillment_status` STRING COMMENT 'Operational status indicating whether the SSR has been fulfilled by ground or cabin crew (e.g., wheelchair provided, meal loaded, document verified).. Valid values are `pending|fulfilled|partially_fulfilled|cancelled|failed|not_applicable`',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Date and time when the SSR was marked as fulfilled by operational staff. Null if not yet fulfilled.',
    `gds_record_locator` STRING COMMENT 'Six-character alphanumeric GDS record locator (PNR locator) in the originating GDS system (Amadeus, Sabre, Galileo, Worldspan).. Valid values are `^[A-Z0-9]{6}$`',
    `interline_agreement_flag` BOOLEAN COMMENT 'Indicates whether this SSR is subject to interline agreement terms between multiple carriers in a multi-carrier itinerary.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SSR record was last modified or updated.',
    `operating_airline_code` STRING COMMENT 'Two-character IATA airline code of the carrier operating the flight segment to which this SSR applies. May differ from responsible airline in codeshare scenarios.. Valid values are `^[A-Z0-9]{2}$`',
    `priority_level` STRING COMMENT 'Operational priority assigned to this SSR for fulfillment and crew attention (e.g., critical for medical oxygen, high for wheelchair, medium for meal).. Valid values are `low|medium|high|critical`',
    `quantity` STRING COMMENT 'Number of units or instances of this SSR requested (e.g., 2 wheelchairs, 3 special meals). Defaults to 1 if not specified.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this SSR is mandated by regulatory or security requirements (e.g., TSA, FAA, EASA, national civil aviation authorities).',
    `remarks` STRING COMMENT 'Additional internal remarks or notes related to this SSR for operational or customer service reference.',
    `responsible_airline_code` STRING COMMENT 'Two-character IATA airline code of the carrier responsible for fulfilling this SSR. Relevant for codeshare and interline bookings.. Valid values are `^[A-Z0-9]{2}$`',
    `sequence_number` STRING COMMENT 'Sequential ordering number of this SSR within the PNR or segment, used for display and processing order.',
    `ssr_category` STRING COMMENT 'Business classification of the SSR for operational routing and fulfillment (e.g., meal service, mobility assistance, travel documentation, frequent flyer program). [ENUM-REF-CANDIDATE: meal|wheelchair|medical|document|loyalty|security|baggage|pet|infant|unaccompanied_minor|seating|other — 12 candidates stripped; promote to reference product]',
    `ssr_code` STRING COMMENT 'Four-letter IATA SSR code identifying the type of special service (e.g., WCHR for wheelchair, VGML for vegetarian meal, UMNR for unaccompanied minor, DOCS for travel document, FQTV for frequent flyer).. Valid values are `^[A-Z]{4}$`',
    `ssr_status` STRING COMMENT 'Current status of the SSR. HK=confirmed by airline, KK=confirmed by carrier, UN=unable to confirm, NO=not processed, NN=need confirmation, UC=unable to confirm space, UU=unconfirmed, RQ=requested. [ENUM-REF-CANDIDATE: HK|KK|UN|NO|NN|UC|UU|RQ — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_ssr PRIMARY KEY(`ssr_id`)
) COMMENT 'Special Service Request (SSR) record attached to a PNR or specific segment/passenger combination. Captures SSR code (WCHR/VGML/UMNR/DOCS/DOCA/DOCO/FQTV etc.), SSR status (HK/KK/UN/NO/NN), free-text SSR remark, airline responsible for action, segment applicability, passenger applicability, SSR category (meal/wheelchair/document/loyalty/security), creation source, and action required flag. Supports operational fulfilment of passenger special needs and regulatory APIS/DOCA/DOCO document collection.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`boarding_pass` (
    `boarding_pass_id` BIGINT COMMENT 'Unique identifier for the boarding pass record. Primary key. Inferred role: TRANSACTION_HEADER (discrete check-in event with lifecycle).',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Gate agents, operations control, maintenance tracking, and post-flight reconciliation require knowing which specific tail number a passenger boarded. Critical for weight-and-balance verification, IROP',
    `consumer_protection_case_id` BIGINT COMMENT 'Foreign key linking to compliance.consumer_protection_case. Business justification: Denied boarding, delay compensation (EU261/DOT) cases reference specific boarding passes. Customer service and legal teams link boarding pass to case for compensation calculation and regulatory report',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Boarding passes are issued at departure stations. Passenger services, gate operations, boarding metrics, and regulatory reporting (e.g., DOT on-time performance) require station linkage for operationa',
    `flight_leg_id` BIGINT COMMENT 'Foreign key reference to the specific flight leg (operating flight) for which this boarding pass is valid.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Boarding passes are issued for specific flight numbers. Required for gate management, boarding control, operational reporting, and passenger flow analytics. Standard airport operations link boarding d',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: Boarding passes are issued for specific gate assignments. Operational coordination between reservation systems and airport operations (gate changes, boarding status) requires this link for real-time p',
    `gate_id` BIGINT COMMENT 'Foreign key linking to airport.gate. Business justification: Boarding passes specify gate assignments for passenger boarding. Gate utilization tracking, passenger flow management, and boarding sequence coordination require this link. Core operational relationsh',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Boarding pass is issued for a specific booked segment in the PNR itinerary. While boarding_pass has flight_leg_id (operational flight), it should also link to the booked segment to maintain the reserv',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Boarding process incidents (passenger slip/fall at gate, boarding bridge malfunction, gate area injuries) are safety occurrences requiring linkage to the specific boarding pass for passenger identific',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the passenger (party) to whom this boarding pass is issued. Satisfies TRANSACTION_HEADER minimum requirement for PARTY_REFERENCE.',
    `pfc_record_id` BIGINT COMMENT 'Foreign key linking to airport.pfc_record. Business justification: Boarding passes represent flown segments that trigger PFC collection for US domestic flights. Revenue accounting, regulatory reporting (DOT), and airport authority remittance require this link.',
    `pnr_id` BIGINT COMMENT 'Foreign key reference to the PNR (Passenger Name Record) that this boarding pass is issued under. Links to the reservation master record.',
    `baggage_item_id` BIGINT COMMENT 'Foreign key linking to airport.baggage_item. Business justification: Boarding passes are issued to passengers who check baggage. Baggage reconciliation (positive passenger bag match), tracking, and irregularity investigation require this link for operational safety and',
    `employee_id` BIGINT COMMENT 'Employee identifier of the gate agent who scanned the boarding pass at boarding. Null if self-scanned or not yet boarded.',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Boarding pass is issued to a specific passenger name element (PNE) within the PNR. While boarding_pass has pax_profile_id (master profile), it should also link to the booking-context passenger record ',
    `ticket_coupon_id` BIGINT COMMENT 'Foreign key reference to the specific ticket coupon (flight segment) for which this boarding pass is issued.',
    `arrival_airport_code` STRING COMMENT 'Three-letter IATA code of the arrival airport for this flight segment.. Valid values are `^[A-Z]{3}$`',
    `baggage_tag_numbers` STRING COMMENT 'Comma-separated list of baggage tag numbers (10-digit IATA license plate codes) for checked bags associated with this boarding pass.',
    `barcode_data` STRING COMMENT 'Encoded barcode data string conforming to IATA BCBP Type M format. Contains passenger name, flight details, seat, boarding pass number, and security data. Confidential due to embedded passenger information.',
    `boarding_group` STRING COMMENT 'Descriptive boarding group name assigned to the passenger (e.g., priority, general, family). Complements boarding_zone with business-friendly label.',
    `boarding_pass_number` STRING COMMENT 'Unique boarding pass sequence number issued by the check-in system. Business identifier for the boarding pass. Satisfies TRANSACTION_HEADER minimum requirement for BUSINESS_IDENTIFIER.. Valid values are `^[A-Z0-9]{1,15}$`',
    `boarding_pass_status` STRING COMMENT 'Current lifecycle status of the boarding pass. Tracks progression from issuance through boarding gate scan. Satisfies TRANSACTION_HEADER minimum requirement for LIFECYCLE_STATUS.. Valid values are `issued|printed|scanned|boarded|cancelled|expired`',
    `boarding_scan_timestamp` TIMESTAMP COMMENT 'Timestamp when the boarding pass barcode was scanned at the gate, confirming passenger boarded the aircraft. Null if not yet scanned.',
    `boarding_time` TIMESTAMP COMMENT 'Scheduled boarding commencement time printed on the boarding pass. Advises passengers when to arrive at the gate.',
    `boarding_zone` STRING COMMENT 'Boarding zone or group assigned to the passenger for sequenced boarding. May be numeric (1-9) or alphabetic (A-Z) depending on airline policy.. Valid values are `^[1-9]$|^[A-Z]$`',
    `check_in_counter_number` STRING COMMENT 'Counter or kiosk number where the boarding pass was issued. Null for web or mobile check-in.',
    `check_in_location_code` STRING COMMENT 'Three-letter IATA airport code where the boarding pass was issued. May differ from departure airport for interline or codeshare itineraries.. Valid values are `^[A-Z]{3}$`',
    `check_in_method` STRING COMMENT 'Channel through which the passenger completed check-in and received the boarding pass. CUSS = Common Use Self-Service.. Valid values are `web|mobile|kiosk|counter|cuss|gate`',
    `checked_bag_count` STRING COMMENT 'Number of checked bags associated with this boarding pass at check-in.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this boarding pass record was first created in the system. Satisfies TRANSACTION_HEADER minimum requirement for RECORD_AUDIT_CREATED.',
    `document_check_status` STRING COMMENT 'Status of travel document verification (passport, visa, ID) at check-in. Required for international flights.. Valid values are `not_required|pending|verified|failed`',
    `fast_track_eligible_flag` BOOLEAN COMMENT 'Indicates whether the passenger is eligible for fast-track security or priority boarding based on fare class, status, or purchase.',
    `format` STRING COMMENT 'Physical or digital format of the boarding pass issued to the passenger. BCBP = Bar Coded Boarding Pass (2D barcode).. Valid values are `bcbp_2d|paper|mobile|sms`',
    `issue_timestamp` TIMESTAMP COMMENT 'Timestamp when the boarding pass was first issued by the check-in system. Satisfies TRANSACTION_HEADER minimum requirement for BUSINESS_EVENT_TIMESTAMP.',
    `last_reprint_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent boarding pass reprint event. Null if never reprinted.',
    `lounge_access_flag` BOOLEAN COMMENT 'Indicates whether the passenger has lounge access entitlement printed on the boarding pass.',
    `marketing_carrier_code` STRING COMMENT 'Two-character IATA airline code of the marketing carrier (airline selling the ticket). May differ from operating carrier for codeshare flights.. Valid values are `^[A-Z0-9]{2}$`',
    `marketing_flight_number` STRING COMMENT 'Flight number as marketed to the passenger. May differ from operating flight number for codeshare flights.. Valid values are `^[0-9]{1,4}[A-Z]?$`',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the operating carrier (airline physically operating the flight).. Valid values are `^[A-Z0-9]{2}$`',
    `operating_flight_number` STRING COMMENT 'Flight number of the operating carrier. Authoritative flight identifier for operations.. Valid values are `^[0-9]{1,4}[A-Z]?$`',
    `reprint_count` STRING COMMENT 'Number of times this boarding pass has been reprinted (e.g., at kiosk, counter, or gate). Zero indicates original issuance.',
    `scheduled_departure_time` TIMESTAMP COMMENT 'Scheduled departure time (STD) of the flight as printed on the boarding pass. Local time at departure airport.',
    `seat_number` STRING COMMENT 'Seat assignment at the time of boarding pass issuance. Format: row number (1-3 digits) followed by seat letter (A-K, excluding I).. Valid values are `^[1-9][0-9]{0,2}[A-K]$`',
    `security_selectee_flag` BOOLEAN COMMENT 'Indicates whether the passenger has been selected for additional security screening by TSA or equivalent authority. Confidential security data.',
    `sequence_number` STRING COMMENT 'Sequential boarding pass number within the flight leg. Used for boarding order analytics and operational reporting.',
    `special_service_codes` STRING COMMENT 'Comma-separated list of IATA SSR codes applicable to this boarding pass (e.g., WCHR for wheelchair, PETC for pet in cabin, UMNR for unaccompanied minor).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this boarding pass record was last modified. Satisfies TRANSACTION_HEADER minimum requirement for RECORD_AUDIT_UPDATED.',
    CONSTRAINT pk_boarding_pass PRIMARY KEY(`boarding_pass_id`)
) COMMENT 'Boarding pass record issued to a passenger for a specific flight segment at check-in. Stores boarding pass sequence number, check-in method (web/mobile/kiosk/counter/CUSS), boarding pass format (BCBP/paper/mobile), barcode data (IATA BCBP Type M), gate number, boarding time, seat number at issuance, boarding zone/group, baggage tag numbers, security selectee flag, document check status, boarding pass issue timestamp, and boarding pass reprint count. SSOT for check-in and boarding event data.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`check_in_event` (
    `check_in_event_id` BIGINT COMMENT 'Unique identifier for the check-in event transaction. Primary key for the check-in event record.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Check-in systems must record tail number for operational reporting, weight-and-balance calculations, turnaround tracking, and baggage loading. Aircraft assignment is finalized by check-in time; captur',
    `booking_pnr_id` BIGINT COMMENT 'Foreign key reference to the booking record for which this check-in was performed.',
    `checkin_session_id` BIGINT COMMENT 'Foreign key linking to airport.checkin_session. Business justification: Check-in events are recorded within checkin sessions. Counter utilization metrics, agent performance tracking, and operational efficiency analysis require this link for facility and staffing planning.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the agent or staff member who processed the check-in, applicable for counter or assisted check-in transactions. Null for self-service check-ins.',
    `flight_leg_id` BIGINT COMMENT 'Foreign key reference to the specific flight leg for which the passenger checked in.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Check-in events occur for specific flight numbers. Essential for check-in analytics, station operations, load planning, and passenger flow management. Standard DCS (Departure Control System) requireme',
    `gate_assignment_id` BIGINT COMMENT 'Foreign key linking to airport.gate_assignment. Business justification: Check-in events precede gate assignments. Tracking passenger flow from check-in to gate, connection time analysis, and minimum connect time validation all require this link for operational planning.',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Check-in is performed for a specific booked segment in the PNR itinerary. While check_in_event has flight_leg_id (operational flight), it should also link to the booked segment to maintain the reserva',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Check-in area safety incidents (baggage handling injuries, counter accidents, system failures causing passenger distress, accessibility equipment failures) must link to the check-in event for root cau',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the passenger who performed the check-in.',
    `pfc_record_id` BIGINT COMMENT 'Foreign key linking to airport.pfc_record. Business justification: Check-in events for US domestic flights trigger PFC collection obligations. Revenue reconciliation, audit trails, and regulatory compliance reporting require this link for financial accuracy.',
    `pnr_id` BIGINT COMMENT 'Foreign key reference to the passenger name record associated with this check-in event.',
    `baggage_item_id` BIGINT COMMENT 'Foreign key linking to airport.baggage_item. Business justification: Baggage is accepted during check-in events. Operational tracking (bag count reconciliation), excess baggage fee validation, and irregularity investigation require this link for revenue and operational',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Check-in event is performed for a specific passenger name element in the PNR. While check_in_event has pax_profile_id, it should also link to the booking-context passenger to maintain the PNR-specific',
    `upgrade_request_id` BIGINT COMMENT 'Foreign key linking to loyalty.upgrade_request. Business justification: Check-in triggers operational upgrade clearance processing. Business process: departure control upgrade confirmation, seat assignment, boarding pass issuance with upgraded cabin, waitlist clearance.',
    `apis_submission_status` STRING COMMENT 'Status of the APIS data submission to border control authorities. APIS is required for international flights to transmit passenger data to destination countries.. Valid values are `submitted|pending|failed|not_required|exempted`',
    `apis_submission_timestamp` TIMESTAMP COMMENT 'The date and time when APIS data was successfully submitted to border control authorities.',
    `baggage_tag_numbers` STRING COMMENT 'Comma-separated list of 10-digit baggage tag numbers issued for checked bags during this check-in event. Used for baggage tracking and reconciliation.',
    `boarding_group` STRING COMMENT 'The boarding group or zone assigned to the passenger (e.g., Group 1, Zone A, Priority). Used for organized boarding processes.',
    `boarding_pass_number` STRING COMMENT 'Unique boarding pass identifier issued during check-in. Used for boarding gate validation and tracking.',
    `boarding_sequence_number` STRING COMMENT 'Sequential boarding number assigned to the passenger, used to determine boarding priority and order.',
    `check_in_channel` STRING COMMENT 'The channel or interface through which the passenger performed check-in. CUSS refers to Common Use Self-Service kiosks. [ENUM-REF-CANDIDATE: web|mobile|airport_kiosk|counter|cuss|api|call_center — 7 candidates stripped; promote to reference product]',
    `check_in_close_timestamp` TIMESTAMP COMMENT 'The scheduled or actual timestamp when check-in closed for this flight. Used to determine if passenger checked in before the cutoff time.',
    `check_in_confirmation_code` STRING COMMENT 'Unique confirmation code or reference number generated upon successful check-in completion, provided to the passenger.',
    `check_in_counter_number` STRING COMMENT 'The specific counter, kiosk, or terminal identifier where the check-in was performed. Applicable for airport-based check-ins.',
    `check_in_remarks` STRING COMMENT 'Free-text remarks or notes recorded by the agent or system during check-in, capturing special circumstances, passenger requests, or operational notes.',
    `check_in_sequence_number` STRING COMMENT 'Sequential number indicating the order of check-in within a booking or PNR when multiple passengers or segments are involved.',
    `check_in_station_code` STRING COMMENT 'Three-letter IATA airport code or city code where the check-in transaction was performed.. Valid values are `^[A-Z]{3}$`',
    `check_in_status` STRING COMMENT 'Current lifecycle status of the check-in event indicating whether the check-in was successfully completed, cancelled, or resulted in a no-show.. Valid values are `completed|cancelled|no_show|pending|failed`',
    `check_in_timestamp` TIMESTAMP COMMENT 'The exact date and time when the passenger completed the check-in transaction. This is the principal business event timestamp for the check-in event.',
    `checked_baggage_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of all checked baggage for this passenger during check-in.',
    `checked_bags_count` STRING COMMENT 'The total number of bags checked by the passenger during this check-in event.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this check-in event record was first created in the system. Used for audit trail and data lineage.',
    `document_verification_status` STRING COMMENT 'Status of travel document verification (passport, visa, ID) performed during check-in to ensure compliance with destination country requirements.. Valid values are `verified|pending|failed|not_required|manual_review`',
    `excess_baggage_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged for excess baggage beyond the allowed free baggage allowance. Zero if no excess baggage fee was applied.',
    `excess_baggage_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the excess baggage fee amount.. Valid values are `^[A-Z]{3}$`',
    `frequent_flyer_number` STRING COMMENT 'The passengers frequent flyer program membership number used during check-in for mileage accrual and status recognition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this check-in event record was last updated or modified. Used for audit trail and change tracking.',
    `minutes_before_departure` STRING COMMENT 'The number of minutes before scheduled departure time that the passenger completed check-in. Used for OTP analysis and no-show prediction.',
    `mobile_boarding_pass_issued_flag` BOOLEAN COMMENT 'Boolean indicator of whether a mobile boarding pass was issued to the passengers mobile device during check-in.',
    `priority_boarding_flag` BOOLEAN COMMENT 'Boolean indicator of whether the passenger is entitled to priority boarding based on ticket class, status, or purchased service.',
    `seat_assignment` STRING COMMENT 'The seat number assigned to the passenger during check-in (e.g., 12A, 23F). May be null if seat assignment is deferred.',
    `special_service_requests` STRING COMMENT 'Comma-separated list of SSR codes confirmed or added during check-in (e.g., WCHR for wheelchair, VGML for vegetarian meal, PETC for pet in cabin).',
    `upgrade_at_check_in_flag` BOOLEAN COMMENT 'Boolean indicator of whether the passenger received a cabin class upgrade during the check-in process.',
    `upgraded_cabin_class` STRING COMMENT 'The cabin class to which the passenger was upgraded during check-in (e.g., Business, First). Null if no upgrade occurred.',
    CONSTRAINT pk_check_in_event PRIMARY KEY(`check_in_event_id`)
) COMMENT 'Check-in transaction record capturing the act of a passenger checking in for a flight. Stores check-in timestamp, check-in channel (web/mobile/airport kiosk/counter/CUSS/API), check-in agent ID, check-in station (airport/city), check-in status (completed/cancelled/no-show), number of bags checked, total checked baggage weight, excess baggage fee amount, upgrade at check-in flag, APIS submission status, document verification status, and check-in close time. Enables OTP analysis, no-show tracking, and ground operations coordination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`pnr_remark` (
    `pnr_remark_id` BIGINT COMMENT 'Unique identifier for the PNR remark element. Primary key.',
    `pnr_id` BIGINT COMMENT 'Reference to the parent PNR containing this remark element.',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: PNR remark can be associated with a specific passenger name element (e.g., meal preference note, special assistance note). While pnr_remark has associated_passenger_number (INT), it should have a prop',
    `associated_passenger_number` STRING COMMENT 'Passenger sequence number within the PNR to which this remark applies. Null if the remark applies to all passengers or the booking as a whole.',
    `associated_segment_number` STRING COMMENT 'Flight segment number within the PNR to which this remark applies. Null if the remark applies to the entire PNR rather than a specific segment.',
    `creating_agent_sign` STRING COMMENT 'Agent sign-in code or initials of the individual who created this remark element. Used for audit trail and accountability.',
    `creating_office_iata_number` STRING COMMENT 'Nine-character IATA office identifier (Office ID) of the agency or airline office that created this remark. Format: 4-character city code + 5-character office identifier.. Valid values are `^[A-Z0-9]{9}$`',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when this remark element was first added to the PNR. Recorded in UTC.',
    `deleting_agent_sign` STRING COMMENT 'Agent sign-in code or initials of the individual who deleted this remark element. Null if remark is active.',
    `deleting_office_iata_number` STRING COMMENT 'Nine-character IATA office identifier of the agency or airline office that deleted this remark. Null if remark is active.. Valid values are `^[A-Z0-9]{9}$`',
    `deletion_timestamp` TIMESTAMP COMMENT 'Date and time when this remark element was deleted or marked inactive. Null for active remarks. Supports audit trail and historical analysis.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether this remark is restricted to specific user roles or offices. True for confidential remarks that should not be visible to all agents or external parties.',
    `is_printable_on_itinerary` BOOLEAN COMMENT 'Indicates whether this remark should appear on customer-facing itinerary documents. True for itinerary remarks; false for internal operational remarks.',
    `is_transmitted_to_carrier` BOOLEAN COMMENT 'Indicates whether this remark is transmitted to the operating carrier(s) via PNR distribution. True for OSI elements and operational remarks requiring carrier visibility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this remark element was last updated. Null if never modified after creation. Recorded in UTC.',
    `modifying_agent_sign` STRING COMMENT 'Agent sign-in code or initials of the individual who last modified this remark element. Null if never modified.',
    `modifying_office_iata_number` STRING COMMENT 'Nine-character IATA office identifier of the agency or airline office that last modified this remark. Null if never modified.. Valid values are `^[A-Z0-9]{9}$`',
    `osi_carrier_code` STRING COMMENT 'IATA two-letter or ICAO three-letter airline code identifying the carrier to which this OSI element is directed. Populated only when remark_type is osi.. Valid values are `^[A-Z0-9]{2,3}$`',
    `remark_category` STRING COMMENT 'Business category or subject area of the remark (e.g., special service request, operational note, customer preference, billing instruction, ground handling instruction).',
    `remark_sequence_number` STRING COMMENT 'Sequential ordering of this remark within the PNR. Used to maintain display order and support remark modification or deletion operations.',
    `remark_source_system` STRING COMMENT 'Identifier of the system or channel that originated this remark (e.g., Amadeus, Sabre, direct entry, web booking, mobile app, GDS interface).',
    `remark_status` STRING COMMENT 'Current lifecycle status of the remark element. Active remarks are visible and operational; deleted remarks are soft-deleted for audit purposes; archived remarks are retained for historical analysis.. Valid values are `active|deleted|archived`',
    `remark_text` STRING COMMENT 'Free-text content of the remark element. May contain operational instructions, customer notes, special handling requirements, or inter-carrier communication. Confidential due to potential inclusion of customer preferences or operational details.',
    `remark_type` STRING COMMENT 'Classification of the remark element. General remarks are visible to all agents; confidential remarks are restricted; invoice remarks support billing; itinerary remarks appear on customer documents; OSI (Other Service Information) elements are directed to carriers; accounting remarks support financial reconciliation.. Valid values are `general|confidential|invoice|itinerary|osi|accounting`',
    CONSTRAINT pk_pnr_remark PRIMARY KEY(`pnr_remark_id`)
) COMMENT 'Free-text and structured remark elements stored within a PNR. Captures remark type (general/confidential/invoice/itinerary/OSI/accounting), remark text, remark category, associated segment or passenger, creating office IATA number, creating agent sign, creation timestamp, and remark sequence number. Includes OSI (Other Service Information) elements directed to specific carriers. Supports operational communication between agents, carriers, and ground handlers.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`fare_quote` (
    `fare_quote_id` BIGINT COMMENT 'Unique identifier for the fare quote record within the PNR (Passenger Name Record). Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Fare quotes generated during promotional periods need campaign attribution for discount effectiveness tracking and promotional fare performance analysis. Revenue management uses this to evaluate promo',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Fare quotes are priced against specific RBD buckets with defined availability and fare rules. Revenue management requires this link to validate bucket availability at quote time, track which buckets a',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Branded fare product selection: fare quotes are built from specific fare families (Basic Economy, Main Cabin, etc.). Revenue management and reporting require tracking which branded product was quoted.',
    `original_fare_quote_id` BIGINT COMMENT 'Reference to the original fare quote ID if this is a repricing. Null for original quotes.',
    `pnr_id` BIGINT COMMENT 'Reference to the parent PNR (Passenger Name Record) containing this fare quote.',
    `base_fare_amount` DECIMAL(18,2) COMMENT 'Total base fare amount before taxes, fees, and surcharges. Sum of all segment fare basis amounts.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Calculated commission amount payable to the booking agent or distribution partner based on the fare and commission rate.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Percentage commission rate applicable to this fare quote for travel agency or distribution partner compensation.',
    `corporate_account_code` STRING COMMENT 'Corporate discount or account code applied to this fare quote for negotiated corporate pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fare quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the fare quote is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the base fare, including promotional codes, corporate discounts, or negotiated reductions.',
    `endorsement_text` STRING COMMENT 'Free-text endorsement or restriction box content printed on the ticket, specifying fare rules, non-refundable conditions, or carrier restrictions.',
    `fare_basis_summary` STRING COMMENT 'Concatenated or summarized list of fare basis codes applied across all segments in this quote (e.g., YLOW/YLOW/MLOW). Detailed segment-level fare basis stored in related segment records.',
    `fare_calculation_line` STRING COMMENT 'Encoded fare construction string showing city pairs, fare basis codes, and amounts per IATA fare calculation standards. Used for ticket validation and interline proration.',
    `fare_quote_number` STRING COMMENT 'Business identifier for the fare quote, typically assigned by the PSS (Passenger Service System) or GDS (Global Distribution System) at time of pricing.. Valid values are `^FQ[0-9]{6,10}$`',
    `fare_quote_status` STRING COMMENT 'Current lifecycle status of the fare quote: active (valid for ticketing), ticketed (converted to ticket), expired (past TTL), repriced (superseded by new quote), cancelled, or voided.. Valid values are `active|ticketed|expired|repriced|cancelled|voided`',
    `fare_type` STRING COMMENT 'Classification of the fare structure: published (public tariff), negotiated (corporate contract), private (confidential rate), award (FFP redemption), net (wholesale), bulk (group), or opaque (hidden carrier). [ENUM-REF-CANDIDATE: published|negotiated|private|award|net|bulk|opaque — 7 candidates stripped; promote to reference product]',
    `gds_code` STRING COMMENT 'Identifier of the GDS used for pricing: 1A (Amadeus), 1B (Abacus), 1S (Sabre), 1G (Galileo), 1P (Apollo), 1V (Worldspan). Null if not GDS-sourced.. Valid values are `1A|1B|1S|1G|1P|1V`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fare quote record was last updated or modified.',
    `number_of_passengers` STRING COMMENT 'Count of passengers covered by this fare quote. Typically 1 for individual pricing, or multiple for group or family fares.',
    `passenger_type_code` STRING COMMENT 'IATA passenger type code for which this fare quote applies: ADT (adult), CHD (child), INF (infant), SRC (senior), STU (student), MIL (military), YTH (youth). [ENUM-REF-CANDIDATE: ADT|CHD|INF|SRC|STU|MIL|YTH — 7 candidates stripped; promote to reference product]',
    `plating_carrier_code` STRING COMMENT 'Two-character IATA code of the airline whose ticket stock (plate) will be used to issue the ticket. May differ from validating carrier in interline scenarios.. Valid values are `^[A-Z0-9]{2}$`',
    `pricing_command` STRING COMMENT 'The cryptic command or API call used to generate this fare quote (e.g., FXP, WPNC, pricing modifiers). Used for audit and repricing.',
    `pricing_date` DATE COMMENT 'Date when the fare quote was calculated and stored. Critical for fare validity and repricing scenarios.',
    `pricing_source` STRING COMMENT 'Channel or system from which the fare quote was retrieved: GDS (Global Distribution System), NDC (New Distribution Capability), direct airline system, metasearch engine, OTA (Online Travel Agency), or consolidator.. Valid values are `GDS|NDC|direct|metasearch|OTA|consolidator`',
    `pricing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fare quote was generated, including time zone. Used for ticketing time limit enforcement and audit trails.',
    `private_fare_indicator` BOOLEAN COMMENT 'Flag indicating whether this fare quote uses a private or negotiated fare (true) versus a published public fare (false).',
    `promotional_code` STRING COMMENT 'Promotional or discount code applied at time of pricing to obtain special fare rates.',
    `repricing_indicator` BOOLEAN COMMENT 'Flag indicating whether this fare quote is a repricing of a previous quote (true) or an original pricing (false).',
    `ticketing_time_limit` TIMESTAMP COMMENT 'Deadline by which the ticket must be issued to honor this fare quote. After this time, the PNR may be cancelled or repriced.',
    `total_fare_amount` DECIMAL(18,2) COMMENT 'Grand total fare amount payable by passenger: base fare + taxes + surcharges - discounts. The ticketing amount.',
    `total_surcharge_amount` DECIMAL(18,2) COMMENT 'Sum of all carrier-imposed surcharges including YQ (fuel surcharge) and YR (carrier surcharge) codes.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Sum of all government taxes, airport fees, and regulatory charges applicable to this fare quote.',
    `tour_code` STRING COMMENT 'Bulk or inclusive tour code applied to the fare, indicating special tour operator or package pricing.',
    `validating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier responsible for fare validation, ticketing, and revenue settlement.. Valid values are `^[A-Z0-9]{2}$`',
    CONSTRAINT pk_fare_quote PRIMARY KEY(`fare_quote_id`)
) COMMENT 'Stored fare quote (pricing record) within a PNR capturing the fare calculation at time of booking or repricing. Stores fare quote number, pricing date, fare basis code per segment, published fare amount, applicable discount, total fare, tax itemisation, surcharges (YQ/YR fuel surcharge), pricing command used, validating carrier, ticketing time limit, fare type (published/negotiated/private/award), tour code, endorsement text, and pricing source (GDS/NDC/direct). Supports ticketing, repricing, and revenue accounting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`pnr_history` (
    `pnr_history_id` BIGINT COMMENT 'Unique identifier for each PNR history entry. Primary key. Inferred role: EVENT_LOG.',
    `pnr_id` BIGINT COMMENT 'Foreign key reference to the PNR master record. Links this history entry to the parent booking.',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: PNR history entry can be passenger-specific (e.g., name change, SSR addition). While pnr_history has passenger_number (INT), it should have a proper FK to booking_passenger to enable passenger-specifi',
    `agent_sign` STRING COMMENT 'Agent sine or user identifier of the person or system that performed the PNR modification. Used for accountability and audit trail.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the PNR modification. Used for categorizing change patterns and dispute resolution.',
    `change_reason_text` STRING COMMENT 'Free-text description providing additional context or explanation for the PNR modification.',
    `change_source` STRING COMMENT 'Channel or system interface through which the PNR modification was initiated. Identifies the origin of the change for audit and analytics.. Valid values are `gds|api|web|mobile|airport|call_center`',
    `change_timestamp` TIMESTAMP COMMENT 'Exact date and time when this PNR modification occurred. Principal event timestamp for audit trail reconstruction.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Agent commission amount associated with this change if applicable. Captured for revenue accounting and settlement.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Agent commission percentage applied to this transaction if applicable. Used for settlement and revenue reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this history record was created in the data warehouse. Audit field for data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for any monetary values in this history entry.. Valid values are `^[A-Z]{3}$`',
    `endorsement_text` STRING COMMENT 'Endorsement or restriction text added or modified in this change. Captures fare rule restrictions and ticket validity conditions.',
    `fare_basis_code` STRING COMMENT 'Fare basis code if this change involved fare repricing or fare class modification. Captures the fare product applied.',
    `field_name` STRING COMMENT 'Name of the PNR field or element that was modified. Identifies the specific data element affected by this change.',
    `form_of_payment_type` STRING COMMENT 'Payment method type if this change involved payment modification. Identifies the instrument used for transaction settlement.. Valid values are `cash|credit_card|debit_card|invoice|voucher|points`',
    `gds_code` STRING COMMENT 'Code identifying the GDS through which the change was processed. 1A=Amadeus, 1B=Abacus, 1G=Galileo, 1P=Worldspan, 1S=Sabre, 1V=Apollo.. Valid values are `1A|1B|1G|1P|1S|1V`',
    `history_entry_type` STRING COMMENT 'Type of PNR modification captured in this history entry. Discriminates the nature of the change event. [ENUM-REF-CANDIDATE: segment_add|segment_cancel|segment_modify|name_change|ticket_issuance|ticket_void|remark_add|remark_delete|ssr_add|ssr_cancel|seat_assignment|seat_change|payment_add|payment_modify|contact_change|split_pnr|merge_pnr|queue_placement|queue_removal|fare_quote|price_override|commission_override|endorsement_add|form_of_payment_change|ticketing_time_limit_set|ticketing_time_limit_extend|group_allocation|waitlist_add|waitlist_confirm|upgrade_request|upgrade_confirm — promote to reference product]. Valid values are `segment_add|segment_cancel|segment_modify|name_change|ticket_issuance|ticket_void`',
    `history_sequence_number` STRING COMMENT 'Sequential ordering number of this history entry within the PNR lifecycle. Enables chronological reconstruction of all changes.',
    `ip_address` STRING COMMENT 'IP address of the client or system that initiated the change. Used for security audit and fraud detection.',
    `is_automated_change` BOOLEAN COMMENT 'Boolean flag indicating whether this change was performed by an automated system process rather than manual agent action. True=automated, False=manual.',
    `new_value` DECIMAL(18,2) COMMENT 'New value of the field after the modification. Captures the after-state for audit trail and change tracking.',
    `office_iata_number` STRING COMMENT 'IATA-assigned office identification number where the change was made. 9-character alphanumeric code identifying the travel agency or airline office.. Valid values are `^[A-Z0-9]{9}$`',
    `old_value` DECIMAL(18,2) COMMENT 'Previous value of the field before the modification. Captures the before-state for audit comparison and rollback capability.',
    `passenger_number` STRING COMMENT 'Passenger sequence number within the PNR that was affected by this change. Null if change applies to all passengers.',
    `queue_number` STRING COMMENT 'Queue identifier if this change resulted in the PNR being placed on a work queue for follow-up action.',
    `record_locator` STRING COMMENT 'Six-character alphanumeric PNR record locator at the time of this change. Captures the booking reference for cross-system correlation.. Valid values are `^[A-Z0-9]{6}$`',
    `remark_text` STRING COMMENT 'Free-text remark or note added or modified in this change. Captures agent comments and special instructions.',
    `seat_number` STRING COMMENT 'Seat assignment if this change involved seat selection or modification. Format: row number followed by seat letter.. Valid values are `^[0-9]{1,3}[A-K]$`',
    `segment_number` STRING COMMENT 'Flight segment number within the PNR itinerary that was affected by this change. Null if change applies to entire PNR rather than specific segment.',
    `session_reference` STRING COMMENT 'Session identifier for the user or system session during which this change was made. Enables correlation of related changes within a session.',
    `ssr_code` STRING COMMENT 'Four-letter SSR code if this change involved adding or canceling a special service request. Examples: WCHR, VGML, PETC.. Valid values are `^[A-Z]{4}$`',
    `ticket_number` STRING COMMENT '13-digit e-ticket number if this change involved ticket issuance, void, or exchange. Links history entry to ticketing transaction.. Valid values are `^[0-9]{13}$`',
    `transaction_reference` STRING COMMENT 'Unique transaction identifier from the source system that processed this change. Enables correlation with external system logs.',
    `waiver_code` STRING COMMENT 'Code indicating any fare rule waiver or exception applied during this modification. Used for revenue integrity and policy compliance tracking.',
    CONSTRAINT pk_pnr_history PRIMARY KEY(`pnr_history_id`)
) COMMENT 'Audit history log of all changes made to a PNR throughout its lifecycle. Captures history entry type (segment add/cancel/modify, name change, ticket issuance, remark add, SSR add/cancel, seat change, payment change), old value, new value, change timestamp, agent sign, office IATA number, change source (GDS/API/web/mobile/airport), and history sequence number. Provides full PNR audit trail for dispute resolution, revenue integrity, and regulatory compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`booking_payment` (
    `booking_payment_id` BIGINT COMMENT 'Unique identifier for the booking payment record. Primary key for the booking payment entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Payment transactions require campaign attribution for calculating campaign-driven revenue and marketing ROI. Finance uses payment-to-campaign linkage to reconcile marketing spend against actual collec',
    `corporate_contract_id` BIGINT COMMENT 'Foreign key linking to revenue.corporate_contract. Business justification: Corporate account billing reconciliation: payments made under corporate contracts must link to the contract for soft-dollar credit tracking, volume commitment measurement, and invoice generation. Fina',
    `fare_quote_id` BIGINT COMMENT 'Foreign key linking to reservation.fare_quote. Business justification: Payment is made for a specific fare quote within the PNR. Linking to fare_quote enables tracking which pricing the payment was made against and supports payment reconciliation with the priced itinerar',
    `ffp_member_id` BIGINT COMMENT 'Reference to the frequent flyer program member account from which miles were redeemed. Applicable when payment method is miles redemption.',
    `mileage_redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.mileage_redemption. Business justification: Award booking copay payments reference the redemption transaction. Business process: award payment reconciliation, copay collection, refund processing for cancelled awards.',
    `pnr_id` BIGINT COMMENT 'Reference to the PNR (Passenger Name Record) associated with this payment transaction. Links payment to the booking record.',
    `agency_iata_number` STRING COMMENT 'IATA-assigned numeric identifier for the travel agency that processed the payment. Applicable when payment method is agency account.',
    `authorization_code` STRING COMMENT 'Authorization code returned by the payment gateway or card issuer upon successful payment authorization. Used for transaction tracking and reconciliation.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the payment method. Used for payment verification and fraud prevention.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (apartment, suite, etc.). Optional additional address detail.',
    `billing_city` STRING COMMENT 'City of the billing address associated with the payment method.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the billing address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address. Used for address verification and fraud prevention.',
    `billing_state_province` STRING COMMENT 'State or province of the billing address. Format varies by country (e.g., two-letter US state codes, full province names).',
    `card_expiry_month` STRING COMMENT 'Expiration month of the payment card (1-12). Used for payment authorization and validation.',
    `card_expiry_year` STRING COMMENT 'Expiration year of the payment card (four-digit year). Used for payment authorization and validation.',
    `card_type` STRING COMMENT 'Brand of the payment card used (e.g., Visa, Mastercard, American Express). Applicable only when payment method is credit or debit card. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners|unionpay — 7 candidates stripped; promote to reference product]',
    `cardholder_name` STRING COMMENT 'Name of the cardholder as it appears on the payment card. Used for payment verification and fraud prevention.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was first created in the system. Audit field for data lineage and compliance.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the payment gateway or fraud detection system (typically 0-100 scale). Higher scores indicate higher fraud risk.',
    `gateway_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment gateway or processor. Used for reconciliation, dispute resolution, and gateway-level tracking.',
    `instalment_count` STRING COMMENT 'Total number of instalments in the payment plan. Null if not an instalment payment.',
    `instalment_number` STRING COMMENT 'Current instalment number in the sequence (e.g., 1 of 3, 2 of 3). Null if not an instalment payment.',
    `instalment_plan_flag` BOOLEAN COMMENT 'Indicates whether this payment is part of an instalment plan. True if the payment is structured as multiple instalments, false otherwise.',
    `masked_card_number` STRING COMMENT 'Masked payment card number showing only the last four digits (e.g., ****1234) for identification and customer service purposes while maintaining PCI compliance.',
    `miles_redeemed_quantity` BIGINT COMMENT 'Number of frequent flyer miles redeemed for this payment. Applicable when payment method is miles redemption.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total monetary amount of the payment transaction in the specified currency. Represents the gross payment value before any adjustments.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP). Defines the currency in which the payment was processed.. Valid values are `^[A-Z]{3}$`',
    `payment_method_type` STRING COMMENT 'Type of payment instrument used for the transaction. Indicates the form of payment selected by the customer or agent. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|agency_account|voucher|miles_redemption|corporate_account|bank_transfer|digital_wallet — 9 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'Externally-known unique reference number for this payment transaction, used for reconciliation and customer service inquiries.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks the payment from authorization through settlement or failure. [ENUM-REF-CANDIDATE: pending|authorized|captured|settled|declined|failed|refunded|partially_refunded|chargeback|voided — 10 candidates stripped; promote to reference product]',
    `payment_timestamp` TIMESTAMP COMMENT 'Date and time when the payment transaction was initiated or authorized. Represents the business event time of the payment in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `processor_response_code` STRING COMMENT 'Response code returned by the payment processor indicating the result of the transaction (e.g., approval, decline reason). Used for troubleshooting and reporting.',
    `processor_response_message` STRING COMMENT 'Human-readable message from the payment processor describing the transaction result or decline reason.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the customer from this payment. Null if no refund has been processed.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed. Null if no refund has been issued.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was settled and funds were transferred. Null if payment has not yet been settled.',
    `three_ds_authentication_status` STRING COMMENT 'Status of 3D Secure authentication for the card transaction. Indicates whether additional cardholder verification was performed to reduce fraud risk.. Valid values are `not_attempted|authenticated|authentication_failed|challenge_required|not_enrolled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment record was last modified. Audit field for tracking changes and data lineage.',
    `voucher_code` STRING COMMENT 'Unique code of the voucher or travel credit used for payment. Applicable when payment method is voucher.',
    CONSTRAINT pk_booking_payment PRIMARY KEY(`booking_payment_id`)
) COMMENT 'Payment record associated with a PNR capturing the form of payment and transaction details for ticket and ancillary purchases. Stores payment method type (credit card/debit card/cash/agency account/voucher/miles redemption/corporate account), card type, masked card number, card expiry, cardholder name, payment amount, currency, payment status (authorised/settled/declined/refunded/chargeback), payment gateway transaction ID, 3DS authentication status, payment timestamp, and instalment plan details. SSOT for reservation-level payment capture.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`refund_transaction` (
    `refund_transaction_id` BIGINT COMMENT 'Primary key for refund_transaction',
    `arc_settlement_id` BIGINT COMMENT 'Reference to the ARC settlement record for this refund transaction, used for financial reconciliation with ARC in the US market.',
    `baggage_irregularity_id` BIGINT COMMENT 'Foreign key linking to airport.baggage_irregularity. Business justification: Refunds may be triggered by baggage delays, loss, or damage. Compensation processing, liability tracking, and claims reconciliation require this link for financial and customer service operations.',
    `bsp_settlement_id` BIGINT COMMENT 'Reference to the BSP settlement record for this refund transaction, used for financial reconciliation with IATA BSP.',
    `consumer_protection_case_id` BIGINT COMMENT 'Foreign key linking to compliance.consumer_protection_case. Business justification: Refunds often resolve consumer protection violations (involuntary denied boarding, cancellations, significant delays). Finance and legal teams link refund to originating case for regulatory reporting ',
    `employee_id` BIGINT COMMENT 'Reference to the airline agent or system user who processed the refund transaction.',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Refund transaction can be for specific unused segments in partial refund scenarios. Linking to itinerary_segment enables tracking which booked segments were refunded and supports segment-level refund ',
    `mileage_redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.mileage_redemption. Business justification: Award ticket refunds must reference original redemption for miles restoration. Business process: award cancellation, miles refund posting, penalty assessment, redemption reversal.',
    `pnr_id` BIGINT COMMENT 'Reference to the Passenger Name Record associated with this refund transaction.',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Refund transaction is issued for a specific passengers ticket within the PNR context. While refund_transaction has pax_profile_id, it should also link to the booking-context passenger to maintain the',
    `revenue_emd_id` BIGINT COMMENT 'Reference to the Electronic Miscellaneous Document being refunded, if applicable. Null for ticket-only refunds.',
    `ticket_id` BIGINT COMMENT 'Reference to the original ticket being refunded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this refund transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this refund transaction.. Valid values are `^[A-Z]{3}$`',
    `fee_refund_amount` DECIMAL(18,2) COMMENT 'The amount of carrier-imposed fees and surcharges being refunded.',
    `gds_code` STRING COMMENT 'Code identifying the GDS through which the refund was processed, if applicable (e.g., 1A for Amadeus, 1B for Sabre, 1G for Galileo).. Valid values are `^[A-Z0-9]{2,4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this refund transaction record was last updated or modified.',
    `miles_refunded` STRING COMMENT 'Number of frequent flyer miles refunded to the passengers FFP account, if refund method is miles.',
    `original_emd_number` STRING COMMENT 'The 13-digit EMD number of the original Electronic Miscellaneous Document being refunded, if applicable.. Valid values are `^[0-9]{13}$`',
    `original_fare_amount` DECIMAL(18,2) COMMENT 'The original base fare amount from the ticket or EMD before any refund calculations.',
    `original_form_of_payment` STRING COMMENT 'The original payment method used when the ticket or EMD was purchased. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|bank_transfer|check|voucher|miles — 7 candidates stripped; promote to reference product]',
    `original_ticket_number` STRING COMMENT 'The 13-digit ticket number of the original e-ticket being refunded.. Valid values are `^[0-9]{13}$`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The penalty or cancellation fee deducted from the original fare amount as per fare rules.',
    `processing_channel` STRING COMMENT 'The channel through which the refund was requested and processed.. Valid values are `web|mobile_app|call_center|airport_counter|gds|travel_agent`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The total amount being refunded to the passenger, after deducting penalties and fees.',
    `refund_approval_date` DATE COMMENT 'Date when the refund was approved by the airline or authorized agent.',
    `refund_method` STRING COMMENT 'The method by which the refund is issued: original form of payment (credit card, cash), travel voucher, frequent flyer miles, credit shell for future travel, or direct bank transfer.. Valid values are `original_form_of_payment|voucher|miles|credit_shell|bank_transfer`',
    `refund_notes` STRING COMMENT 'Free-text notes and comments regarding the refund transaction, including special circumstances or agent remarks.',
    `refund_processing_date` DATE COMMENT 'Date when the refund was fully processed and payment was issued or credited.',
    `refund_processing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the refund processing was completed.',
    `refund_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the refund (e.g., schedule change, flight cancellation, passenger no-show, medical emergency, death in family, fare difference).. Valid values are `^[A-Z0-9]{2,10}$`',
    `refund_reason_description` STRING COMMENT 'Detailed textual explanation of the refund reason, providing additional context beyond the reason code.',
    `refund_reference_number` STRING COMMENT 'Unique business identifier for the refund transaction, used for customer communication and tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `refund_request_date` DATE COMMENT 'Date when the refund was requested by the passenger or initiated by the airline.',
    `refund_request_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the refund request was submitted or created in the system.',
    `refund_status` STRING COMMENT 'Current lifecycle status of the refund transaction in the processing workflow.. Valid values are `requested|approved|processed|rejected|cancelled`',
    `refund_type` STRING COMMENT 'Classification of the refund: full (entire ticket value), partial (portion of ticket value), involuntary (airline-initiated due to schedule change, cancellation, or IROP), or voluntary (passenger-initiated).. Valid values are `full|partial|involuntary|voluntary`',
    `refund_voucher_number` STRING COMMENT 'Unique voucher number issued when refund method is voucher or credit shell, used for future travel redemption.. Valid values are `^[A-Z0-9]{8,16}$`',
    `tax_refund_amount` DECIMAL(18,2) COMMENT 'The total amount of taxes and government fees being refunded to the passenger.',
    `total_refund_amount` DECIMAL(18,2) COMMENT 'The total refund amount including base fare refund, tax refund, and fee refund, after all deductions.',
    `voucher_expiry_date` DATE COMMENT 'Expiration date of the refund voucher or credit shell, after which it cannot be redeemed.',
    `waiver_code` STRING COMMENT 'Code indicating if penalty fees were waived and the authorization reason (e.g., IROP, medical emergency, airline error, executive waiver).. Valid values are `^[A-Z0-9]{2,10}$`',
    `waiver_flag` BOOLEAN COMMENT 'Boolean indicator whether penalty waiver was applied to this refund transaction.',
    CONSTRAINT pk_refund_transaction PRIMARY KEY(`refund_transaction_id`)
) COMMENT 'Refund transaction record for voided, cancelled, or partially refunded tickets and EMDs. Stores refund type (full/partial/involuntary/voluntary), original ticket or EMD number, refund amount, penalty amount deducted, tax refund amount, refund method (original form of payment/voucher/miles), refund request date, refund processing date, refund status (requested/approved/processed/rejected), refund reason code, waiver code (for penalty waivers), processing agent ID, and refund reference number. Supports revenue accounting and BSP/ARC settlement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` (
    `schedule_change_notification_id` BIGINT COMMENT 'Unique identifier for the schedule change notification record. Primary key.',
    `consumer_protection_case_id` BIGINT COMMENT 'Foreign key linking to compliance.consumer_protection_case. Business justification: Schedule changes exceeding thresholds trigger EU261/DOT passenger rights (rebooking, refunds, compensation). Customer service creates consumer protection cases from notifications to track regulatory o',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Schedule change notifications reference specific flight numbers. Required for passenger notifications, rebooking workflows, operational recovery, and regulatory compliance (EU261, DOT). Standard airli',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Schedule change notification is generated when a flight schedule change impacts a specific segment in an existing PNR. Linking to itinerary_segment enables tracking which booked segment was affected b',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Schedule changes and IROPs often driven by aircraft swaps (gauge changes, maintenance substitutions). Tracking original vs new aircraft type is core to disruption management, passenger re-accommodatio',
    `pnr_id` BIGINT COMMENT 'Foreign key reference to the PNR impacted by the schedule change.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Schedule changes affect specific routes. Critical for IRROPS management, passenger reaccommodation, network disruption analysis, and operational recovery planning. Airlines track schedule changes by r',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the passenger accepted or rejected the schedule change, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX in UTC. Null if still pending.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the root cause of the schedule change (e.g., MAINT for maintenance, WX for weather, CREW for crew unavailability, SLOT for slot time adjustment, COMM for commercial decision).. Valid values are `^[A-Z]{2,4}$`',
    `codeshare_flag` BOOLEAN COMMENT 'Indicates whether the impacted flight is a codeshare operation (true) or not (false). Codeshare flights require coordination between marketing and operating carriers for schedule change notifications.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation amount offered or paid to the passenger due to the schedule change. Null if no compensation applicable.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, EUR, GBP). Null if no compensation applicable.. Valid values are `^[A-Z]{3}$`',
    `compensation_eligible_flag` BOOLEAN COMMENT 'Indicates whether the schedule change qualifies the passenger for compensation under applicable regulations (true) or not (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule change notification record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX in UTC.',
    `gds_record_locator` STRING COMMENT 'Six-character alphanumeric GDS booking reference if the PNR was created through a GDS (Amadeus, Sabre, Travelport). Used for GDS notification routing.. Valid values are `^[A-Z0-9]{6}$`',
    `impact_severity` STRING COMMENT 'Business assessment of the schedule change impact on the passenger: minor (less than 30 minutes), moderate (30 minutes to 2 hours), major (more than 2 hours or missed connection), or cancellation (flight no longer operating).. Valid values are `minor|moderate|major|cancellation`',
    `marketing_airline_code` STRING COMMENT 'Two-character IATA airline code of the carrier whose flight number appears on the ticket (relevant for codeshare flights).. Valid values are `^[A-Z0-9]{2}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule change notification record was last updated, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX in UTC.',
    `new_aircraft_type_code` STRING COMMENT 'Three-character IATA aircraft type code for the revised equipment after the change. Null if flight is cancelled or equipment unchanged.. Valid values are `^[A-Z0-9]{3}$`',
    `new_arrival_airport_code` STRING COMMENT 'Three-letter IATA airport code for the revised arrival airport. Null if flight is cancelled.. Valid values are `^[A-Z]{3}$`',
    `new_arrival_datetime` TIMESTAMP COMMENT 'The revised arrival date and time in local airport time after the schedule change, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if flight is cancelled.',
    `new_departure_airport_code` STRING COMMENT 'Three-letter IATA airport code for the revised departure airport. Null if flight is cancelled.. Valid values are `^[A-Z]{3}$`',
    `new_departure_datetime` TIMESTAMP COMMENT 'The revised departure date and time in local airport time after the schedule change, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if flight is cancelled.',
    `new_flight_number` STRING COMMENT 'The revised flight number after the schedule change, formatted as two-character airline code followed by 1-4 digit flight number and optional suffix. Null if flight is cancelled.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `notification_channel` STRING COMMENT 'Primary communication channel used to notify the passenger: email, SMS, GDS (Global Distribution System) message, travel agency notification, mobile app push notification, airport counter, or phone call. [ENUM-REF-CANDIDATE: email|sms|gds|travel_agency|mobile_app|airport_counter|phone_call — 7 candidates stripped; promote to reference product]',
    `notification_number` STRING COMMENT 'Externally-visible unique business identifier for the schedule change notification, formatted as SCN followed by 10 digits.. Valid values are `^SCN[0-9]{10}$`',
    `notification_status` STRING COMMENT 'Current lifecycle status of the notification: pending (queued for delivery), notified (successfully sent), acknowledged (passenger confirmed receipt), failed (delivery unsuccessful), or cancelled (notification voided).. Valid values are `pending|notified|acknowledged|failed|cancelled`',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the notification was sent to the passenger, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX in UTC.',
    `notification_type` STRING COMMENT 'Category of schedule change that triggered the notification: schedule change (general), flight cancellation, equipment change (aircraft type swap), routing change (different flight path), time change (departure/arrival adjustment), or gate change.. Valid values are `schedule_change|flight_cancellation|equipment_change|routing_change|time_change|gate_change`',
    `operating_airline_code` STRING COMMENT 'Two-character IATA airline code of the carrier actually operating the flight (relevant for codeshare flights where operating carrier differs from marketing carrier).. Valid values are `^[A-Z0-9]{2}$`',
    `original_arrival_airport_code` STRING COMMENT 'Three-letter IATA airport code for the original scheduled arrival airport.. Valid values are `^[A-Z]{3}$`',
    `original_arrival_datetime` TIMESTAMP COMMENT 'The originally scheduled arrival date and time in local airport time, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `original_departure_airport_code` STRING COMMENT 'Three-letter IATA airport code for the original scheduled departure airport.. Valid values are `^[A-Z]{3}$`',
    `original_departure_datetime` TIMESTAMP COMMENT 'The originally scheduled departure date and time in local airport time, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `original_flight_number` STRING COMMENT 'The flight number as originally booked before the schedule change, formatted as two-character airline code followed by 1-4 digit flight number and optional suffix.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `passenger_acceptance_status` STRING COMMENT 'Passenger response to the schedule change: accepted (passenger confirmed new itinerary), rejected (passenger declined and requested alternative), pending (awaiting passenger response), or auto_accepted (automatically accepted per policy after timeout period).. Valid values are `accepted|rejected|pending|auto_accepted`',
    `passenger_notification_status` STRING COMMENT 'Status of passenger notification delivery: notified (successfully delivered to passenger), pending (queued for delivery), failed (delivery attempt unsuccessful), or not_required (notification waived per business rules).. Valid values are `notified|pending|failed|not_required`',
    `reaccommodation_action` STRING COMMENT 'Action taken to reaccommodate the passenger: none (no action required), rebooked (moved to different flight), refunded (ticket refunded), voucher_issued (travel credit provided), upgraded (moved to higher cabin class), or alternate_routing (rerouted via different city pair).. Valid values are `none|rebooked|refunded|voucher_issued|upgraded|alternate_routing`',
    `reaccommodation_flight_number` STRING COMMENT 'Flight number of the alternate flight if passenger was rebooked. Null if no rebooking occurred.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `time_difference_minutes` STRING COMMENT 'Net change in departure time expressed in minutes. Positive values indicate delay, negative values indicate earlier departure. Null if flight is cancelled.',
    `travel_agency_iata_number` STRING COMMENT 'Eight-digit IATA agency numeric code if the booking was made through a travel agency. Used for agency notification routing.. Valid values are `^[0-9]{8}$`',
    CONSTRAINT pk_schedule_change_notification PRIMARY KEY(`schedule_change_notification_id`)
) COMMENT 'Schedule change notification record generated when a flight schedule change impacts an existing PNR. Stores notification type (schedule change/cancellation/equipment change/routing change), original flight details, new flight details, change reason code, impact severity (minor/major/cancellation), passenger notification status (notified/pending/failed), notification channel (email/SMS/GDS/agency), notification timestamp, passenger acceptance status (accepted/rejected/pending), and reaccommodation action taken. Supports IROP management and DOT/EASA schedule change compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`travel_document` (
    `travel_document_id` BIGINT COMMENT 'Primary key for travel_document',
    `employee_id` BIGINT COMMENT 'Identifier of the agent or system user who collected or entered the travel document information. Used for audit and quality control.',
    `org_unit_id` BIGINT COMMENT 'IATA office identifier or internal office code where the travel document information was collected. Used for audit trail and compliance reporting.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the passenger to whom this travel document belongs.',
    `pnr_id` BIGINT COMMENT 'Foreign key reference to the PNR this travel document is associated with.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Travel documents must satisfy APIS, visa, passport validity requirements mandated by destination countries. Border control compliance validation at check-in references regulatory requirements for docu',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Travel document (passport, visa) is collected for a specific passenger name element in the PNR for APIS compliance. While travel_document has pax_profile_id, it should also link to the booking-context',
    `apis_response_code` STRING COMMENT 'Response code received from the border control authority after APIS transmission. Used to identify acceptance, rejection, or error conditions.',
    `apis_response_message` STRING COMMENT 'Detailed response message received from the border control authority after APIS transmission. Contains error details or acceptance confirmation.',
    `apis_transmission_status` STRING COMMENT 'Status of the APIS data transmission to the destination country border control authority. Tracks whether passenger travel document data has been successfully submitted and acknowledged.. Valid values are `not_sent|sent|acknowledged|rejected|error`',
    `apis_transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the APIS data was transmitted to the border control authority.',
    `boarding_eligibility_status` STRING COMMENT 'Indicates whether the passenger is eligible to board based on travel document validation and APIS clearance. Used by gate agents and automated boarding systems.. Valid values are `eligible|ineligible|pending_review|conditional`',
    `collection_method` STRING COMMENT 'Channel through which the travel document information was collected from the passenger.. Valid values are `web_checkin|mobile_app|airport_kiosk|counter_agent|gds|api`',
    `compliance_validation_timestamp` TIMESTAMP COMMENT 'Date and time when the travel document record was last validated for regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the travel document record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the passenger as stated on the travel document. Required for APIS and border control identity verification.',
    `document_expiry_date` DATE COMMENT 'Date on which the travel document expires. Critical for validating passenger eligibility for international travel and compliance with destination country entry requirements (typically 6-month validity rule).',
    `document_issue_date` DATE COMMENT 'Date on which the travel document was issued by the issuing authority. Used for document validity verification.',
    `document_number` STRING COMMENT 'Unique alphanumeric identifier of the travel document as issued by the issuing authority. Required for border control and APIS transmission.',
    `document_type` STRING COMMENT 'Type of travel document presented by the passenger. Used for APIS (Advance Passenger Information System) compliance.. Valid values are `passport|national_id|visa|resident_permit|travel_permit|refugee_document`',
    `document_verification_status` STRING COMMENT 'Status of the travel document verification process. Indicates whether the document has been validated against issuing authority databases or manual inspection.. Valid values are `verified|pending|failed|not_verified|expired`',
    `gds_record_locator` STRING COMMENT 'GDS-specific record locator or confirmation code associated with the travel document collection. Used for cross-system reconciliation.',
    `gender` STRING COMMENT 'Gender of the passenger as stated on the travel document. M=Male, F=Female, X=Unspecified/Non-binary, U=Unknown. Required for APIS transmission.. Valid values are `M|F|X|U`',
    `given_names` STRING COMMENT 'Given name(s) (first and middle names) of the passenger exactly as they appear on the travel document. Required for APIS and border control matching.',
    `ineligibility_reason` STRING COMMENT 'Detailed reason why the passenger is ineligible to board, if boarding_eligibility_status is ineligible. May include expired document, APIS rejection, or missing information.',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code of the country that issued the travel document.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the travel document record was last modified or updated.',
    `nationality_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code representing the nationality of the passenger as stated on the travel document.. Valid values are `^[A-Z]{3}$`',
    `place_of_birth` STRING COMMENT 'City and/or country of birth of the passenger as stated on the travel document. May be required by certain destination countries for visa and entry validation.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the travel document record meets all regulatory requirements for international travel (APIS, Secure Flight, destination country rules). True if compliant, False if deficient.',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which the travel document record originated (e.g., Amadeus Altéa, Sabre, mobile app, web check-in).',
    `ssr_docs_element` STRING COMMENT 'Raw SSR DOCS element string as received from the GDS or PSS. Contains structured travel document information in IATA format for APIS transmission.',
    `surname` STRING COMMENT 'Surname (family name) of the passenger exactly as it appears on the travel document. Required for APIS and border control matching.',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the travel document verification was completed or last attempted.',
    CONSTRAINT pk_travel_document PRIMARY KEY(`travel_document_id`)
) COMMENT 'Passenger travel document record collected for APIS (Advance Passenger Information System) and border control compliance. Stores document type (passport/national ID/visa/resident permit/travel permit), document number, issuing country ISO code, nationality, document expiry date, document issue date, surname as on document, given names as on document, gender, date of birth, place of birth, and document verification status. Collected via SSR DOCS/DOCA/DOCO elements. Required for international travel regulatory compliance with TSA, CBP, and national border agencies.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`voluntary_change` (
    `voluntary_change_id` BIGINT COMMENT 'Unique identifier for the voluntary ticket change transaction. Primary key.',
    `booking_pnr_id` BIGINT COMMENT 'Reference to the booking record being modified through this voluntary change.',
    `employee_id` BIGINT COMMENT 'Reference to the agent who processed the voluntary change. Null for self-service channels.',
    `fare_quote_id` BIGINT COMMENT 'Foreign key linking to reservation.fare_quote. Business justification: Voluntary change transaction generates a new fare quote for repricing the modified itinerary. Linking to fare_quote enables tracking the pricing used for the change transaction and supports fare diffe',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to reservation.itinerary_segment. Business justification: Voluntary change transaction affects specific segments in the PNR itinerary. Linking to itinerary_segment enables tracking which booked segments were modified, cancelled, or rebooked as part of the vo',
    `mileage_redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.mileage_redemption. Business justification: Award ticket changes reference original redemption for reissue processing. Business process: award reissue, additional miles collection, change fee assessment, redemption adjustment.',
    `org_unit_id` BIGINT COMMENT 'IATA office identification code (9-character alphanumeric) of the office that processed the change. Format: 4-char city code + 5-char office identifier.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger initiating the voluntary change request.',
    `pnr_id` BIGINT COMMENT 'Reference to the PNR associated with this voluntary change transaction.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Voluntary change policies must comply with DOT/EU consumer protection rules (fee transparency, refund rights). Revenue management validates change fees and restrictions against regulatory requirements',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Voluntary changes often involve route changes. Essential for revenue management, change fee policy application, network demand analysis, and fare rule validation. Airlines track voluntary changes by r',
    `change_channel` STRING COMMENT 'Distribution channel through which the voluntary change was requested: web (airline website), mobile_app (airline mobile application), call_center (phone reservation center), airport_counter (airport ticket counter), travel_agent (travel agency), GDS (Global Distribution System), chatbot (automated chat assistant), or email (email request). [ENUM-REF-CANDIDATE: web|mobile_app|call_center|airport_counter|travel_agent|gds|chatbot|email — 8 candidates stripped; promote to reference product]',
    `change_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the airline for processing the voluntary ticket change. Zero if waived.',
    `change_fee_waiver_code` STRING COMMENT 'Code indicating the reason for change fee waiver if applicable (e.g., FFP elite status, fare family benefit, promotional waiver, irregular operations). Null if no waiver applied.. Valid values are `^[A-Z0-9]{2,10}$`',
    `change_processed_timestamp` TIMESTAMP COMMENT 'Date and time when the voluntary change was successfully processed and the new ticket was issued. Null if not yet completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the reason for the voluntary change (e.g., SCHED for schedule preference, PERS for personal reasons, BUSI for business needs).. Valid values are `^[A-Z0-9]{2,6}$`',
    `change_request_timestamp` TIMESTAMP COMMENT 'Date and time when the passenger initiated the voluntary change request. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `change_status` STRING COMMENT 'Current status of the voluntary change transaction in its lifecycle: pending (awaiting processing), processing (being handled), completed (successfully processed and new ticket issued), rejected (change request denied), cancelled (passenger cancelled the change request), or refunded (change reversed and fees refunded).. Valid values are `pending|processing|completed|rejected|cancelled|refunded`',
    `change_type` STRING COMMENT 'Category of voluntary change requested: date change (travel date modification), routing change (origin/destination/connection modification), name correction (passenger name spelling correction), cabin upgrade (economy to business/first), cabin downgrade (business/first to economy), carrier change (operating airline change), or mixed change (combination of multiple types). [ENUM-REF-CANDIDATE: date_change|routing_change|name_correction|cabin_upgrade|cabin_downgrade|carrier_change|mixed_change — 7 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this voluntary change transaction.. Valid values are `^[A-Z]{3}$`',
    `fare_difference_amount` DECIMAL(18,2) COMMENT 'Difference between the new fare and the original fare. Positive if new fare is higher (additional collection), negative if new fare is lower (refund due), zero if fares are equal.',
    `fare_rule_category` STRING COMMENT 'IATA fare rule category number governing the voluntary change (typically Category 16 for penalties/changes). Format: 1-2 digit number.. Valid values are `^[0-9]{1,2}$`',
    `form_of_payment_code` STRING COMMENT 'IATA standard form of payment code (e.g., CA for cash, CC for credit card, MS for miles, INV for invoice).. Valid values are `^[A-Z]{2,4}$`',
    `gds_record_locator` STRING COMMENT 'Six-character alphanumeric GDS booking reference code if the change was processed through a GDS (Amadeus, Sabre, Travelport).. Valid values are `^[A-Z0-9]{6}$`',
    `interline_agreement_flag` BOOLEAN COMMENT 'Indicates whether the voluntary change involves an interline agreement between multiple carriers. True if interline, False if single carrier.',
    `new_cabin_class` STRING COMMENT 'Cabin class of the new ticket after the voluntary change. Null if cabin class was not changed.. Valid values are `first|business|premium_economy|economy`',
    `new_departure_date` DATE COMMENT 'Scheduled departure date of the new itinerary after the voluntary change. Null if departure date was not changed. Format: yyyy-MM-dd.',
    `new_destination_airport_code` STRING COMMENT 'Three-letter IATA airport code of the destination airport in the new itinerary. Null if routing was not changed.. Valid values are `^[A-Z]{3}$`',
    `new_fare_basis_code` STRING COMMENT 'Fare basis code of the new ticket after the voluntary change.. Valid values are `^[A-Z0-9]{4,8}$`',
    `new_origin_airport_code` STRING COMMENT 'Three-letter IATA airport code of the origin airport in the new itinerary. Null if routing was not changed.. Valid values are `^[A-Z]{3}$`',
    `new_ticket_number` STRING COMMENT 'The 13-digit ticket number of the newly issued e-ticket after the voluntary change is processed.. Valid values are `^[0-9]{13}$`',
    `original_cabin_class` STRING COMMENT 'Cabin class of the original ticket: first (first class), business (business class), premium_economy (premium economy), or economy (economy class).. Valid values are `first|business|premium_economy|economy`',
    `original_departure_date` DATE COMMENT 'Scheduled departure date of the original itinerary before the voluntary change. Format: yyyy-MM-dd.',
    `original_destination_airport_code` STRING COMMENT 'Three-letter IATA airport code of the destination airport in the original itinerary.. Valid values are `^[A-Z]{3}$`',
    `original_fare_basis_code` STRING COMMENT 'Fare basis code of the original ticket indicating fare type, booking class, and fare rules.. Valid values are `^[A-Z0-9]{4,8}$`',
    `original_origin_airport_code` STRING COMMENT 'Three-letter IATA airport code of the origin airport in the original itinerary.. Valid values are `^[A-Z]{3}$`',
    `original_ticket_number` STRING COMMENT 'The 13-digit ticket number of the original e-ticket being changed. Format: 3-digit airline code + 10-digit serial number.. Valid values are `^[0-9]{13}$`',
    `payment_method` STRING COMMENT 'Payment instrument used for the voluntary change transaction: credit_card, debit_card, cash, voucher (travel voucher/credit), miles (frequent flyer miles), bank_transfer, or wallet (digital wallet). [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|voucher|miles|bank_transfer|wallet — 7 candidates stripped; promote to reference product]',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why the voluntary change was rejected (e.g., fare rule restriction, no availability, payment failure, outside change window). Null if not rejected.. Valid values are `^[A-Z0-9]{2,10}$`',
    `rejection_reason_text` STRING COMMENT 'Free-text explanation of why the voluntary change was rejected. Null if not rejected.',
    `remarks` STRING COMMENT 'Free-text remarks or notes about the voluntary change transaction, including special handling instructions or passenger comments.',
    `total_amount_collected` DECIMAL(18,2) COMMENT 'Total amount collected from the passenger for the voluntary change, including change fee and positive fare difference. Zero if no collection was required.',
    `total_amount_refunded` DECIMAL(18,2) COMMENT 'Total amount refunded to the passenger if the new fare is lower than the original fare (after deducting change fee). Zero if no refund was issued.',
    CONSTRAINT pk_voluntary_change PRIMARY KEY(`voluntary_change_id`)
) COMMENT 'Voluntary ticket change transaction record capturing passenger-initiated modifications to an existing booking. Stores change type (date change/routing change/name correction/cabin change/carrier change), original itinerary details, new itinerary details, change fee amount, fare difference amount, total amount collected or refunded, change fee waiver code, change request timestamp, change processed timestamp, change channel, agent ID, change status (pending/completed/rejected), and new ticket number issued. Supports revenue integrity and change fee revenue tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`group_booking` (
    `group_booking_id` BIGINT COMMENT 'Unique identifier for the group booking record. Primary key for coordinated reservations of 10+ passengers travelling together under a single group contract.',
    `employee_id` BIGINT COMMENT 'Identifier of the airline sales representative or agent responsible for managing the group booking relationship and contract execution.',
    `org_unit_id` BIGINT COMMENT 'IATA office identifier or internal office code where the group booking was created and is managed. Supports organizational accountability and reporting.',
    `cabin_class` STRING COMMENT 'Service class or cabin category contracted for the group booking. Defines the level of service and amenities provided to group passengers.. Valid values are `first|business|premium_economy|economy`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation or coded reason for group booking cancellation. Supports operational analysis and customer service documentation.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the group booking was cancelled. Null if the booking has not been cancelled. Critical for refund and penalty processing.',
    `contract_number` STRING COMMENT 'Unique contract reference number assigned to the group booking agreement. Used for legal documentation and financial settlement tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the group booking record was initially created in the reservation system. Audit trail for booking lifecycle tracking.',
    `departure_date` DATE COMMENT 'Scheduled departure date for the outbound travel segment of the group booking. Primary travel date for group coordination and planning.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Initial deposit amount required to secure the group booking. Represents the upfront payment obligation per the group contract terms.',
    `deposit_due_date` DATE COMMENT 'Deadline by which the deposit payment must be received to maintain the group booking option or confirmation status.',
    `deposit_received_flag` BOOLEAN COMMENT 'Indicator of whether the required deposit payment has been received and processed. True indicates deposit obligation fulfilled.',
    `destination_station_code` STRING COMMENT 'Three-letter IATA airport code representing the primary arrival point for the group travel. Defines the ending location of the group itinerary.. Valid values are `^[A-Z]{3}$`',
    `fare_basis_code` STRING COMMENT 'Negotiated fare basis code applicable to the group booking. Defines the fare rules, restrictions, and conditions governing the group travel contract.',
    `fare_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the negotiated fare amount. Defines the currency in which group pricing is denominated.. Valid values are `^[A-Z]{3}$`',
    `final_payment_due_date` DATE COMMENT 'Deadline by which full payment for all confirmed seats must be received. Critical milestone for group booking financial settlement.',
    `group_booking_status` STRING COMMENT 'Current lifecycle status of the group booking indicating progression through reservation, confirmation, ticketing, and fulfillment stages.. Valid values are `option|tentative|confirmed|partially_ticketed|fully_ticketed|cancelled`',
    `group_coordinator_email` STRING COMMENT 'Primary email address of the group coordinator for all booking communications, updates, and documentation delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `group_coordinator_name` STRING COMMENT 'Full name of the primary contact person responsible for coordinating the group booking on behalf of the organizing entity.',
    `group_coordinator_phone` STRING COMMENT 'Primary contact phone number for the group coordinator. Used for urgent communications and operational coordination.',
    `group_name` STRING COMMENT 'Business or descriptive name assigned to the group booking for identification and reference purposes.',
    `group_type` STRING COMMENT 'Classification of the group booking based on the nature of travel and organizational affiliation. Determines applicable policies, fare structures, and service requirements. [ENUM-REF-CANDIDATE: leisure|corporate|incentive|tour_operator|sports_team|military|government — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the group booking record. Tracks changes throughout the booking lifecycle.',
    `marketing_airline_code` STRING COMMENT 'IATA or ICAO airline code of the carrier marketing and selling the group booking. May differ from operating carrier in codeshare scenarios.. Valid values are `^[A-Z0-9]{2,3}$`',
    `name_list_deadline` DATE COMMENT 'Deadline by which the complete passenger name list must be submitted to the airline. Critical for inventory management and seat release policies.',
    `negotiated_fare_amount` DECIMAL(18,2) COMMENT 'Contracted fare amount per passenger for the group booking. Represents the negotiated rate agreed between the airline and group organizer.',
    `operating_airline_code` STRING COMMENT 'IATA or ICAO airline code of the carrier operating the flights for this group booking. Identifies the airline providing the actual air transportation service.. Valid values are `^[A-Z0-9]{2,3}$`',
    `origin_station_code` STRING COMMENT 'Three-letter IATA airport code representing the primary departure point for the group travel. Defines the starting location of the group itinerary.. Valid values are `^[A-Z]{3}$`',
    `pnr_locator_list` STRING COMMENT 'Comma-separated list of PNR record locators associated with individual passenger bookings within this group. Links group master record to individual reservations.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, instructions, or special handling requirements specific to the group booking. Supports operational coordination.',
    `return_date` DATE COMMENT 'Scheduled return date for the inbound travel segment of the group booking. Applicable for round-trip group travel arrangements.',
    `seats_confirmed` STRING COMMENT 'Number of seats that have been confirmed with passenger assignments and are ready for ticketing. Represents firm commitments within the group block.',
    `seats_named` STRING COMMENT 'Number of seats for which passenger names have been provided and assigned. Tracks name list completion progress against contracted seats.',
    `seats_ticketed` STRING COMMENT 'Number of seats for which electronic tickets have been issued. Tracks ticketing completion progress for the group.',
    `special_service_requirements` STRING COMMENT 'Consolidated list of special service requests applicable to the group, such as meal preferences, accessibility needs, or equipment requirements.',
    `ticketing_deadline` DATE COMMENT 'Final date by which all confirmed passengers must be ticketed. After this date, unticket seats may be released back to general inventory.',
    `total_seats_contracted` STRING COMMENT 'Total number of seats allocated and contracted for the group booking. Represents the inventory commitment made by the airline to the group organizer.',
    CONSTRAINT pk_group_booking PRIMARY KEY(`group_booking_id`)
) COMMENT 'Group booking master record for coordinated reservations of 10+ passengers travelling together under a single group contract. Stores group name, group type (leisure/corporate/incentive/tour operator/sports team/military/government), total seats contracted, seats named (passengers assigned), seats confirmed, group fare basis code, negotiated fare amount per passenger, deposit amount and due date, final payment due date, name list completion deadline, ticketing deadline, group booking status (option/tentative/confirmed/partially-ticketed/fully-ticketed/cancelled), group coordinator name and contact, sales owner, and associated PNR locator list. Supports group desk operations, bulk inventory allocation, deposit tracking, and name list management workflows.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`coupon_status` (
    `coupon_status_id` BIGINT COMMENT 'Unique identifier for the coupon status record. Primary key.',
    `booking_pnr_id` BIGINT COMMENT 'Reference to the booking record associated with this coupon.',
    `employee_id` BIGINT COMMENT 'Reference to the agent who processed the most recent status change for this coupon.',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Coupons are lifted/flown on specific flight numbers. Essential for revenue recognition, coupon reconciliation, fraud prevention, and interline settlement. Standard airline revenue accounting requireme',
    `itinerary_segment_id` BIGINT COMMENT 'Reference to the specific flight segment this coupon covers.',
    `org_unit_id` BIGINT COMMENT 'Reference to the office or station where the most recent status change was processed.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger for whom this coupon was issued.',
    `pnr_id` BIGINT COMMENT 'Reference to the PNR (Passenger Name Record) associated with this coupon status.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Coupon lift/flown status feeds BSP/ARC settlement reports and DOT revenue filings. Revenue accounting aggregates coupon data to regulatory submissions. Mandatory financial reporting process.',
    `reservation_booking_passenger_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_passenger. Business justification: Coupon status tracks the lifecycle of a ticket coupon issued to a specific passenger name element in the PNR. While coupon_status has pax_profile_id, it should also link to the booking-context passeng',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Ticket coupons are valid for specific routes. Critical for revenue accounting, interline settlement (BSP/ARC), coupon control, and fraud prevention. IATA standard practice linking coupons to route mas',
    `ticket_coupon_id` BIGINT COMMENT 'Reference to the ticket coupon in the revenue domain, which is the SSOT (System of Record) for the coupon financial document.',
    `previous_coupon_status_id` BIGINT COMMENT 'Self-referencing FK on coupon_status (previous_coupon_status_id)',
    `arrival_airport_code` STRING COMMENT 'IATA three-letter airport code for the arrival airport of this coupon segment.. Valid values are `^[A-Z]{3}$`',
    `baggage_allowance` STRING COMMENT 'Baggage allowance applicable to this coupon segment (e.g., 2PC, 23KG, 1PC).',
    `booking_class_code` STRING COMMENT 'Single-letter booking class (fare class) code for this coupon (e.g., Y, J, F, B, M).. Valid values are `^[A-Z]{1}$`',
    `cabin_class_code` STRING COMMENT 'Cabin class for this coupon: F=First, J=Business, W=Premium Economy, Y=Economy.. Valid values are `F|J|W|Y`',
    `checked_in_timestamp` TIMESTAMP COMMENT 'Timestamp when the passenger checked in for the flight segment covered by this coupon.',
    `codeshare_indicator` BOOLEAN COMMENT 'Flag indicating whether this coupon is part of a codeshare flight operation.',
    `coupon_sequence_number` STRING COMMENT 'Sequential number of the coupon within the ticket (1, 2, 3, 4 for multi-segment journeys).',
    `coupon_status_code` STRING COMMENT 'Current lifecycle status of the coupon: O=Open for Use, F=Flown/Used, L=Lifted/Boarded, A=Airport Control, C=Checked In, V=Void, E=Exchanged, R=Refunded, I=Irregular Operations, S=Suspended, U=Unavailable, P=Printed, Z=Archived. [ENUM-REF-CANDIDATE: O|F|L|A|C|V|E|R|I|S|U|P|Z — 13 candidates stripped; promote to reference product]',
    `coupon_status_description` STRING COMMENT 'Human-readable description of the current coupon status.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coupon status record was first created in the system, in ISO 8601 format.',
    `departure_airport_code` STRING COMMENT 'IATA three-letter airport code for the departure airport of this coupon segment.. Valid values are `^[A-Z]{3}$`',
    `endorsement_restrictions` STRING COMMENT 'Endorsement box text indicating restrictions or special conditions on this coupon (e.g., non-refundable, valid on XX only).',
    `exchange_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon was exchanged for a new ticket or itinerary.',
    `fare_basis_code` STRING COMMENT 'Fare basis code that defines the fare rules and restrictions applicable to this coupon.',
    `flight_number` STRING COMMENT 'Flight number associated with this coupon segment.. Valid values are `^[0-9]{1,4}[A-Z]{0,1}$`',
    `flown_date` DATE COMMENT 'The actual date the passenger flew on this coupon segment, in yyyy-MM-dd format. Null if not yet flown.',
    `flown_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the coupon was marked as flown/used, typically at gate closure or boarding completion.',
    `gds_record_locator` STRING COMMENT 'Six-character alphanumeric GDS (Global Distribution System) record locator associated with this coupon booking.. Valid values are `^[A-Z0-9]{6}$`',
    `interline_indicator` BOOLEAN COMMENT 'Flag indicating whether this coupon involves interline travel (ticketing agreement between different carriers).',
    `irop_indicator` BOOLEAN COMMENT 'Flag indicating whether this coupon status change was due to irregular operations (flight cancellation, delay, reroute).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this coupon status record was last modified, in ISO 8601 format.',
    `lifted_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon was lifted (passenger boarded the aircraft), per IATA coupon lifecycle.',
    `marketing_carrier_code` STRING COMMENT 'IATA two-character airline code of the carrier that marketed and sold the ticket.. Valid values are `^[A-Z0-9]{2}$`',
    `not_valid_after_date` DATE COMMENT 'Latest date this coupon is valid for travel, per fare rules, in yyyy-MM-dd format.',
    `not_valid_before_date` DATE COMMENT 'Earliest date this coupon is valid for travel, per fare rules, in yyyy-MM-dd format.',
    `operating_carrier_code` STRING COMMENT 'IATA two-character airline code of the carrier that operated the flight for this coupon.. Valid values are `^[A-Z0-9]{2}$`',
    `original_ticket_number` STRING COMMENT 'The original ticket number if this coupon was reissued or exchanged from a prior ticket.',
    `previous_status_code` STRING COMMENT 'The coupon status code immediately prior to the current status, enabling status transition tracking.',
    `processing_channel` STRING COMMENT 'Channel through which the coupon status change was processed. [ENUM-REF-CANDIDATE: web|mobile|kiosk|counter|call_center|gds|api — 7 candidates stripped; promote to reference product]',
    `refund_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon was refunded to the passenger.',
    `reissue_indicator` BOOLEAN COMMENT 'Flag indicating whether this coupon was reissued as part of a ticket exchange or voluntary change.',
    `remarks` STRING COMMENT 'Free-text remarks or notes related to this coupon status, for operational or customer service reference.',
    `scheduled_departure_date` DATE COMMENT 'Originally scheduled departure date for this coupon segment, in yyyy-MM-dd format.',
    `status_change_reason_code` STRING COMMENT 'Code indicating the reason for the status change (e.g., passenger no-show, voluntary change, involuntary reroute, schedule change).',
    `status_change_reason_text` STRING COMMENT 'Free-text description providing additional context for the status change.',
    `status_change_timestamp` TIMESTAMP COMMENT 'Date and time when the coupon status was last changed, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `ticket_number` STRING COMMENT 'The 13-digit electronic ticket number to which this coupon belongs, formatted per IATA standards.. Valid values are `^[0-9]{13}$`',
    `validating_carrier_code` STRING COMMENT 'IATA two-character code of the airline responsible for validating and settling this coupon.. Valid values are `^[A-Z0-9]{2}$`',
    `void_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon was voided, if applicable.',
    `waiver_code` STRING COMMENT 'Code indicating any fare rule waiver applied to this coupon (e.g., change fee waived due to IROP).',
    CONSTRAINT pk_coupon_status PRIMARY KEY(`coupon_status_id`)
) COMMENT 'Tracks the booking-context lifecycle status of each ticket coupon (open, used, exchanged, refunded, void) as managed within the reservation system, referencing revenue.ticket_coupon as the SSOT for the coupon financial document.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` (
    `segment_mileage_accrual_id` BIGINT COMMENT 'Unique identifier for this segment-to-accrual linkage record. Primary key for the association.',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to the flight segment that generated this mileage credit. References the specific booked leg including carrier, flight number, origin, destination, booking class, and cabin class used to calculate miles earned.',
    `mileage_accrual_id` BIGINT COMMENT 'Foreign key linking to the mileage accrual transaction record. References the specific credit event including member, accrual date, posting date, miles breakdown, and status.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this segment-accrual linkage record was created. Audit trail for when the segment was associated with the accrual transaction.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this segment-accrual linkage record was last updated. Tracks changes to posting status, miles allocation, or qualification status.',
    `qualifying_indicator` BOOLEAN COMMENT 'Flag indicating whether this segment qualifies for elite status qualification (EQM/EQS) in addition to redeemable miles. False for deeply discounted fares, award tickets, or partner segments with restricted earning.',
    `segment_base_miles` DECIMAL(18,2) COMMENT 'Base miles earned specifically from this segment, calculated from segment distance and fare class. When a journey-based accrual spans multiple segments, this attribute allocates the portion of base miles attributable to this specific segment.',
    `segment_contribution_date` DATE COMMENT 'Date when this segments contribution to the accrual was calculated. Typically the segment departure date for standard accruals, or the claim date for retroactive accruals.',
    `segment_elite_bonus_miles` DECIMAL(18,2) COMMENT 'Elite tier bonus miles earned specifically from this segment. Calculated by applying the members elite multiplier to this segments base miles.',
    `segment_posting_status` STRING COMMENT 'Status of this segments contribution to the accrual. Pending indicates awaiting flight completion or ticket validation. Posted indicates miles credited. Reversed indicates miles clawed back. Excluded indicates segment did not qualify for miles (award ticket, non-qualifying fare class).',
    `segment_promotional_bonus_miles` DECIMAL(18,2) COMMENT 'Promotional bonus miles earned specifically from this segment. Captures route-specific promotions, cabin-specific bonuses, or segment-level campaign credits.',
    CONSTRAINT pk_segment_mileage_accrual PRIMARY KEY(`segment_mileage_accrual_id`)
) COMMENT 'This association product represents the transactional linkage between a booked flight segment and the mileage credit event(s) it generates. Each record captures the specific miles earned from a particular segment, including base miles calculated from segment distance and fare class, elite bonuses, and promotional bonuses. A single segment can generate multiple accrual records when multiple passengers on the same PNR earn miles to different FFP accounts, when companions earn miles, or when retroactive claims are processed. Journey-based bonuses may reference multiple segments in a single accrual transaction.. Existence Justification: In airline loyalty operations, a single itinerary segment can generate multiple mileage accrual records when multiple passengers on the same PNR earn miles to different FFP accounts, when companions earn miles, when split crediting occurs (crediting to multiple programs), or when retroactive claims are processed months after travel. Conversely, a single mileage accrual transaction can reference multiple segments when journey-based bonuses are awarded (e.g., fly 3 segments in a month, earn 5000 bonus miles) or when promotional accruals span a multi-segment itinerary. The relationship itself carries critical business data: the specific miles breakdown attributable to each segment, posting status per segment, and qualification indicators.';

CREATE OR REPLACE TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` (
    `segment_ancillary_purchase_id` BIGINT COMMENT 'Unique identifier for this segment-level ancillary purchase transaction. Primary key for the association.',
    `itinerary_segment_id` BIGINT COMMENT 'Foreign key linking to the specific flight segment for which the ancillary product was purchased. Establishes which leg of the journey this ancillary service applies to.',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to the ancillary product in the master catalog. Identifies which ancillary service or product was purchased.',
    `profile_id` BIGINT COMMENT 'Reference to the specific passenger who purchased or will use this ancillary service on this segment. Links to passenger master data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this purchase record was created in the ancillary sales system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price paid amount.',
    `emd_number` STRING COMMENT 'Electronic Miscellaneous Document number issued for this ancillary purchase. IATA standard document for ancillary service transactions.',
    `fulfillment_notes` STRING COMMENT 'Free-text notes regarding the delivery or fulfillment of this ancillary service on this segment. Used for special requests, delivery issues, or operational notes.',
    `price_paid` DECIMAL(18,2) COMMENT 'Actual price paid for this ancillary purchase on this segment. May differ from catalog base price due to dynamic pricing, promotions, bundling, or passenger-specific discounts.',
    `purchase_channel` STRING COMMENT 'Sales channel through which the ancillary was purchased for this segment. WEB=airline website, MOBILE=mobile app, GDS=global distribution system, AIRPORT=airport counter, CALLCENTER=phone booking, INFLIGHT=onboard purchase.',
    `purchase_date` TIMESTAMP COMMENT 'Date and time when the ancillary product was purchased for this segment. Captures the transaction timestamp, which may differ from booking date or departure date.',
    `quantity` STRING COMMENT 'Number of units of the ancillary product purchased for this segment. For example, 2 checked bags, 1 meal, 3 lounge passes.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded if the ancillary purchase was cancelled or not delivered. Null if no refund issued.',
    `refund_date` TIMESTAMP COMMENT 'Date and time when refund was processed for this ancillary purchase. Null if no refund issued.',
    `service_status` STRING COMMENT 'Current fulfillment status of the ancillary service for this segment. PURCHASED=ordered but not confirmed, CONFIRMED=confirmed for delivery, DELIVERED=service provided, CANCELLED=cancelled before delivery, REFUNDED=refunded after cancellation, PENDING=awaiting confirmation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this purchase record was last modified.',
    CONSTRAINT pk_segment_ancillary_purchase PRIMARY KEY(`segment_ancillary_purchase_id`)
) COMMENT 'This association product represents the purchase transaction between an itinerary segment and an ancillary product from the catalog. It captures the segment-level merchandising event where a passenger purchases an ancillary service (baggage, seat upgrade, meal, Wi-Fi, etc.) for a specific flight leg. Each record links one itinerary segment to one ancillary product with transaction-specific attributes including purchase date, quantity, price paid, and service delivery status.. Existence Justification: In airline operations, passengers purchase ancillary products (baggage, meals, seat upgrades, Wi-Fi, lounge access) for specific flight segments within their itinerary. A single segment can have multiple ancillary purchases (e.g., checked bag + meal + priority boarding), and each ancillary product is purchased across thousands of segments daily. This is operational segment-level merchandising where the airline actively manages purchase transactions with attributes like purchase date, quantity, price paid, service delivery status, and EMD documentation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ADD CONSTRAINT `fk_reservation_pnr_group_booking_id` FOREIGN KEY (`group_booking_id`) REFERENCES `airlines_ecm`.`reservation`.`group_booking`(`group_booking_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ADD CONSTRAINT `fk_reservation_itinerary_segment_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_fare_quote_id` FOREIGN KEY (`fare_quote_id`) REFERENCES `airlines_ecm`.`reservation`.`fare_quote`(`fare_quote_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ADD CONSTRAINT `fk_reservation_e_ticket_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ADD CONSTRAINT `fk_reservation_reservation_booking_passenger_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ADD CONSTRAINT `fk_reservation_ssr_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ADD CONSTRAINT `fk_reservation_boarding_pass_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_booking_pnr_id` FOREIGN KEY (`booking_pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ADD CONSTRAINT `fk_reservation_check_in_event_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ADD CONSTRAINT `fk_reservation_pnr_remark_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ADD CONSTRAINT `fk_reservation_pnr_remark_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_original_fare_quote_id` FOREIGN KEY (`original_fare_quote_id`) REFERENCES `airlines_ecm`.`reservation`.`fare_quote`(`fare_quote_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ADD CONSTRAINT `fk_reservation_fare_quote_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ADD CONSTRAINT `fk_reservation_pnr_history_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ADD CONSTRAINT `fk_reservation_pnr_history_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_fare_quote_id` FOREIGN KEY (`fare_quote_id`) REFERENCES `airlines_ecm`.`reservation`.`fare_quote`(`fare_quote_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ADD CONSTRAINT `fk_reservation_booking_payment_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ADD CONSTRAINT `fk_reservation_refund_transaction_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ADD CONSTRAINT `fk_reservation_schedule_change_notification_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ADD CONSTRAINT `fk_reservation_schedule_change_notification_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ADD CONSTRAINT `fk_reservation_travel_document_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_booking_pnr_id` FOREIGN KEY (`booking_pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_fare_quote_id` FOREIGN KEY (`fare_quote_id`) REFERENCES `airlines_ecm`.`reservation`.`fare_quote`(`fare_quote_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ADD CONSTRAINT `fk_reservation_voluntary_change_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_booking_pnr_id` FOREIGN KEY (`booking_pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_pnr_id` FOREIGN KEY (`pnr_id`) REFERENCES `airlines_ecm`.`reservation`.`pnr`(`pnr_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_reservation_booking_passenger_id` FOREIGN KEY (`reservation_booking_passenger_id`) REFERENCES `airlines_ecm`.`reservation`.`reservation_booking_passenger`(`reservation_booking_passenger_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ADD CONSTRAINT `fk_reservation_coupon_status_previous_coupon_status_id` FOREIGN KEY (`previous_coupon_status_id`) REFERENCES `airlines_ecm`.`reservation`.`coupon_status`(`coupon_status_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ADD CONSTRAINT `fk_reservation_segment_mileage_accrual_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ADD CONSTRAINT `fk_reservation_segment_ancillary_purchase_itinerary_segment_id` FOREIGN KEY (`itinerary_segment_id`) REFERENCES `airlines_ecm`.`reservation`.`itinerary_segment`(`itinerary_segment_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`reservation` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `airlines_ecm`.`reservation` SET TAGS ('dbx_domain' = 'reservation');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Identifier');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `cdm_message_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Message Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `group_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Office Identifier');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `agency_iata_number` SET TAGS ('dbx_business_glossary_term' = 'Agency IATA Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `agency_iata_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `booking_source` SET TAGS ('dbx_business_glossary_term' = 'Booking Source');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'confirmed|waitlisted|cancelled|archived|ticketed|pending');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `booking_type` SET TAGS ('dbx_business_glossary_term' = 'Booking Type');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `booking_type` SET TAGS ('dbx_value_regex' = 'individual|group|corporate|interline|codeshare');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `codeshare_indicator` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `corporate_account_number` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `corporate_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `creating_agent_sign` SET TAGS ('dbx_business_glossary_term' = 'Creating Agent Sign');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PNR Creation Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `destination_city_code` SET TAGS ('dbx_business_glossary_term' = 'Destination City Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `destination_city_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `form_of_payment_summary` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Summary');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `interline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interline Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `last_modifying_agent_sign` SET TAGS ('dbx_business_glossary_term' = 'Last Modifying Agent Sign');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `origin_city_code` SET TAGS ('dbx_business_glossary_term' = 'Origin City Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `origin_city_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Passenger Count');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `point_of_sale_city` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) City');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `point_of_sale_city` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Country');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `purge_date` SET TAGS ('dbx_business_glossary_term' = 'PNR Purge Date');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `queue_number` SET TAGS ('dbx_business_glossary_term' = 'Queue Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `record_locator` SET TAGS ('dbx_business_glossary_term' = 'PNR Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `record_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `segment_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Count');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `special_service_request_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Codes');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `ticketed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticketed Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `ticketing_time_limit` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Time Limit (TTL)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `trip_type` SET TAGS ('dbx_business_glossary_term' = 'Trip Type');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr` ALTER COLUMN `trip_type` SET TAGS ('dbx_value_regex' = 'one_way|round_trip|multi_city|open_jaw');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `award_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Award Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `cdm_message_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Message Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `slot_id` SET TAGS ('dbx_business_glossary_term' = 'Slot Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `turnaround_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Action Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Arrival Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `baggage_allowance` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `booking_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `booking_channel_code` SET TAGS ('dbx_value_regex' = 'GDS|WEB|MOB|CTO|RES|API');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `booking_class_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Class Code (RBD)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `booking_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `codeshare_indicator` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `endorsement_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Restrictions');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `flown_indicator` SET TAGS ('dbx_business_glossary_term' = 'Flown Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `gds_pcc_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Pseudo City Code (PCC)');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `interline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interline Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `marketing_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Marketing Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `marketing_flight_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `marriage_group_indicator` SET TAGS ('dbx_business_glossary_term' = 'Marriage Group Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `marriage_group_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `meal_service_code` SET TAGS ('dbx_business_glossary_term' = 'Meal Service Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `number_of_seats` SET TAGS ('dbx_business_glossary_term' = 'Number of Seats');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `operating_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `operating_flight_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `schedule_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Schedule Change Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `scheduled_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Date and Time');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `scheduled_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Date and Time');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `segment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `segment_mileage` SET TAGS ('dbx_business_glossary_term' = 'Segment Mileage');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `segment_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `segment_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `segment_status_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Status Code');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `stopover_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stopover Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `ticketing_time_limit` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Time Limit');
ALTER TABLE `airlines_ecm`.`reservation`.`itinerary_segment` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` SET TAGS ('dbx_subdomain' = 'ticketing_operations');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `e_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'E Ticket Identifier');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `fare_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Quote Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Office ID');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `conjunction_ticket_indicator` SET TAGS ('dbx_business_glossary_term' = 'Conjunction Ticket Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `conjunction_ticket_numbers` SET TAGS ('dbx_business_glossary_term' = 'Conjunction Ticket Numbers');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `conjunction_ticket_numbers` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `conjunction_ticket_numbers` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `endorsement_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Endorsement and Restrictions');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `equivalent_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `equivalent_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `equivalent_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `exchange_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Date');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `exchange_ticket_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exchange Ticket Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `form_of_payment_details` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Details');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `form_of_payment_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `form_of_payment_details` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Type');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `gds_pcc` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Pseudo City Code (PCC)');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `in_connection_with_ticket` SET TAGS ('dbx_business_glossary_term' = 'In Connection With Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `in_connection_with_ticket` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `in_connection_with_ticket` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Ticket Issue Date');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Issue Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Airline Code');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Original Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `refund_indicator` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `ticket_designator` SET TAGS ('dbx_business_glossary_term' = 'Ticket Designator');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'OPEN|USED|VOID|REFUNDED|EXCHANGED|SUSPENDED');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Ticket Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Validating Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`e_ticket` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `apis_data_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Passenger Information System (APIS) Data Complete Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `associated_infant_indicator` SET TAGS ('dbx_business_glossary_term' = 'Associated Infant Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `boarding_pass_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Issued Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'CONFIRMED|WAITLISTED|CANCELLED|NO_SHOW');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `check_in_status` SET TAGS ('dbx_business_glossary_term' = 'Check-In Status');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `check_in_status` SET TAGS ('dbx_value_regex' = 'NOT_CHECKED_IN|CHECKED_IN|BOARDED|OFFLOADED');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Passenger Contact Email Address');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Passenger Contact Phone Number');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Passenger Date of Birth');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger First Name');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `frequent_flyer_number` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `frequent_flyer_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `frequent_flyer_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `frequent_flyer_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Tier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `frequent_flyer_tier_code` SET TAGS ('dbx_value_regex' = 'BASIC|SILVER|GOLD|PLATINUM|DIAMOND');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Passenger Gender');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|U|X');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `known_traveller_number` SET TAGS ('dbx_business_glossary_term' = 'Known Traveller Number (KTN)');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `known_traveller_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `known_traveller_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Last Name');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `meal_preference_code` SET TAGS ('dbx_business_glossary_term' = 'Meal Preference Code');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Middle Name');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Nationality Country Code');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `passenger_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Passenger Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = 'ADT|CHD|INF|INS|YTH|UNN');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `redress_number` SET TAGS ('dbx_business_glossary_term' = 'Redress Number');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `redress_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `redress_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `seat_preference_code` SET TAGS ('dbx_business_glossary_term' = 'Seat Preference Code');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `seat_preference_code` SET TAGS ('dbx_value_regex' = 'WINDOW|AISLE|MIDDLE|NONE');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ALTEA|SABRE|AMADEUS|WORLDSPAN|GALILEO|DIRECT');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `special_service_request_count` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Count');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Suffix');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'JR|SR|II|III|IV');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `ticket_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Ticket Issue Date');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Ticket (E-Ticket) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `ticket_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `ticket_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Passenger Title');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `unaccompanied_minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Unaccompanied Minor (UNN) Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `wheelchair_assistance_code` SET TAGS ('dbx_business_glossary_term' = 'Wheelchair Assistance Code');
ALTER TABLE `airlines_ecm`.`reservation`.`reservation_booking_passenger` ALTER COLUMN `wheelchair_assistance_code` SET TAGS ('dbx_value_regex' = 'WCHR|WCHS|WCHC|NONE');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` SET TAGS ('dbx_subdomain' = 'passenger_services');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `ssr_id` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Office ID');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `ramp_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ramp Service Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Required Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `apis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Advance Passenger Information System (APIS) Required Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `charge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Applicable Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `codeshare_flag` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `creation_source` SET TAGS ('dbx_business_glossary_term' = 'Creation Source');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `emd_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `emd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `free_text` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Free Text');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `free_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|fulfilled|partially_fulfilled|cancelled|failed|not_applicable');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `interline_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Airline Code');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `responsible_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Airline Code');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `responsible_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `ssr_category` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Category');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `ssr_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `ssr_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`reservation`.`ssr` ALTER COLUMN `ssr_status` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Status');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` SET TAGS ('dbx_subdomain' = 'passenger_services');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass ID');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `consumer_protection_case_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Case Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `gate_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `pfc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pfc Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `baggage_item_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Baggage Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Boarding Gate Agent ID');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon ID');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Arrival Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `baggage_tag_numbers` SET TAGS ('dbx_business_glossary_term' = 'Baggage Tag Numbers');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `barcode_data` SET TAGS ('dbx_business_glossary_term' = 'Barcode Data');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `barcode_data` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_group` SET TAGS ('dbx_business_glossary_term' = 'Boarding Group');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_pass_number` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Number');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_pass_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,15}$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_pass_status` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Status');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_pass_status` SET TAGS ('dbx_value_regex' = 'issued|printed|scanned|boarded|cancelled|expired');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Boarding Scan Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_time` SET TAGS ('dbx_business_glossary_term' = 'Boarding Time');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_zone` SET TAGS ('dbx_business_glossary_term' = 'Boarding Zone');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `boarding_zone` SET TAGS ('dbx_value_regex' = '^[1-9]$|^[A-Z]$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `check_in_counter_number` SET TAGS ('dbx_business_glossary_term' = 'Check-In Counter Number');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `check_in_location_code` SET TAGS ('dbx_business_glossary_term' = 'Check-In Location Code');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `check_in_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `check_in_method` SET TAGS ('dbx_business_glossary_term' = 'Check-In Method');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `check_in_method` SET TAGS ('dbx_value_regex' = 'web|mobile|kiosk|counter|cuss|gate');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `checked_bag_count` SET TAGS ('dbx_business_glossary_term' = 'Checked Bag Count');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `document_check_status` SET TAGS ('dbx_business_glossary_term' = 'Document Check Status');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `document_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|verified|failed');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `fast_track_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fast Track Eligible Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Format');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'bcbp_2d|paper|mobile|sms');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Issue Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `last_reprint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reprint Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `lounge_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Lounge Access Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `marketing_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Marketing Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `marketing_flight_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `operating_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `operating_flight_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `reprint_count` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Reprint Count');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `scheduled_departure_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Time');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `seat_number` SET TAGS ('dbx_business_glossary_term' = 'Seat Number');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `seat_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{0,2}[A-K]$');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `security_selectee_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Selectee Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `security_selectee_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `special_service_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Codes');
ALTER TABLE `airlines_ecm`.`reservation`.`boarding_pass` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` SET TAGS ('dbx_subdomain' = 'passenger_services');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_event_id` SET TAGS ('dbx_business_glossary_term' = 'Check-In Event ID');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `booking_pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Booking ID');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `checkin_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkin Session Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Check-In Agent ID');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg ID');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `gate_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Gate Assignment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `pfc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pfc Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `baggage_item_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Baggage Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `upgrade_request_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Request Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `apis_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Advanced Passenger Information System (APIS) Submission Status');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `apis_submission_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|failed|not_required|exempted');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `apis_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Advanced Passenger Information System (APIS) Submission Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `baggage_tag_numbers` SET TAGS ('dbx_business_glossary_term' = 'Baggage Tag Numbers');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `boarding_group` SET TAGS ('dbx_business_glossary_term' = 'Boarding Group');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `boarding_pass_number` SET TAGS ('dbx_business_glossary_term' = 'Boarding Pass Number');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `boarding_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Boarding Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_channel` SET TAGS ('dbx_business_glossary_term' = 'Check-In Channel');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Close Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_confirmation_code` SET TAGS ('dbx_business_glossary_term' = 'Check-In Confirmation Code');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_counter_number` SET TAGS ('dbx_business_glossary_term' = 'Check-In Counter Number');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_remarks` SET TAGS ('dbx_business_glossary_term' = 'Check-In Remarks');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Check-In Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_station_code` SET TAGS ('dbx_business_glossary_term' = 'Check-In Station Code');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_status` SET TAGS ('dbx_business_glossary_term' = 'Check-In Status');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_status` SET TAGS ('dbx_value_regex' = 'completed|cancelled|no_show|pending|failed');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `checked_baggage_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Checked Baggage Weight (Kilograms)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `checked_bags_count` SET TAGS ('dbx_business_glossary_term' = 'Checked Bags Count');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `document_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Document Verification Status');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `document_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required|manual_review');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `excess_baggage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Excess Baggage Fee Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `excess_baggage_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Excess Baggage Fee Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `excess_baggage_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `frequent_flyer_number` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `frequent_flyer_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `frequent_flyer_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `minutes_before_departure` SET TAGS ('dbx_business_glossary_term' = 'Minutes Before Departure');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `mobile_boarding_pass_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Boarding Pass Issued Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `mobile_boarding_pass_issued_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `mobile_boarding_pass_issued_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `priority_boarding_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Boarding Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `seat_assignment` SET TAGS ('dbx_business_glossary_term' = 'Seat Assignment');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `special_service_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Service Requests (SSR)');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `upgrade_at_check_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade at Check-In Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`check_in_event` ALTER COLUMN `upgraded_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Upgraded Cabin Class');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `pnr_remark_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Remark Identifier');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Identifier');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `associated_passenger_number` SET TAGS ('dbx_business_glossary_term' = 'Associated Passenger Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `associated_segment_number` SET TAGS ('dbx_business_glossary_term' = 'Associated Segment Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `creating_agent_sign` SET TAGS ('dbx_business_glossary_term' = 'Creating Agent Sign');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `creating_office_iata_number` SET TAGS ('dbx_business_glossary_term' = 'Creating Office International Air Transport Association (IATA) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `creating_office_iata_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{9}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remark Creation Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `deleting_agent_sign` SET TAGS ('dbx_business_glossary_term' = 'Deleting Agent Sign');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `deleting_office_iata_number` SET TAGS ('dbx_business_glossary_term' = 'Deleting Office International Air Transport Association (IATA) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `deleting_office_iata_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{9}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `deletion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remark Deletion Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `is_printable_on_itinerary` SET TAGS ('dbx_business_glossary_term' = 'Is Printable on Itinerary Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `is_transmitted_to_carrier` SET TAGS ('dbx_business_glossary_term' = 'Is Transmitted to Carrier Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remark Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `modifying_agent_sign` SET TAGS ('dbx_business_glossary_term' = 'Modifying Agent Sign');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `modifying_office_iata_number` SET TAGS ('dbx_business_glossary_term' = 'Modifying Office International Air Transport Association (IATA) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `modifying_office_iata_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{9}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `osi_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Other Service Information (OSI) Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `osi_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_category` SET TAGS ('dbx_business_glossary_term' = 'Remark Category');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Remark Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_source_system` SET TAGS ('dbx_business_glossary_term' = 'Remark Source System');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_status` SET TAGS ('dbx_business_glossary_term' = 'Remark Status');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_status` SET TAGS ('dbx_value_regex' = 'active|deleted|archived');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_text` SET TAGS ('dbx_business_glossary_term' = 'Remark Text');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_type` SET TAGS ('dbx_business_glossary_term' = 'Remark Type');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_remark` ALTER COLUMN `remark_type` SET TAGS ('dbx_value_regex' = 'general|confidential|invoice|itinerary|osi|accounting');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` SET TAGS ('dbx_subdomain' = 'ticketing_operations');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Quote Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `original_fare_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Original Fare Quote Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `corporate_account_code` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Code');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `corporate_account_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `endorsement_text` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Text');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_basis_summary` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Summary');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_calculation_line` SET TAGS ('dbx_business_glossary_term' = 'Fare Calculation Line');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_quote_number` SET TAGS ('dbx_business_glossary_term' = 'Fare Quote Number');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_quote_number` SET TAGS ('dbx_value_regex' = '^FQ[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_quote_status` SET TAGS ('dbx_business_glossary_term' = 'Fare Quote Status');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_quote_status` SET TAGS ('dbx_value_regex' = 'active|ticketed|expired|repriced|cancelled|voided');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `fare_type` SET TAGS ('dbx_business_glossary_term' = 'Fare Type');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `gds_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Code');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `gds_code` SET TAGS ('dbx_value_regex' = '1A|1B|1S|1G|1P|1V');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `number_of_passengers` SET TAGS ('dbx_business_glossary_term' = 'Number of Passengers');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `plating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Plating Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `plating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `pricing_command` SET TAGS ('dbx_business_glossary_term' = 'Pricing Command');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `pricing_source` SET TAGS ('dbx_value_regex' = 'GDS|NDC|direct|metasearch|OTA|consolidator');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `pricing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `private_fare_indicator` SET TAGS ('dbx_business_glossary_term' = 'Private Fare Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `repricing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Repricing Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `ticketing_time_limit` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Time Limit (TTL)');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `total_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Surcharge Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Validating Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`fare_quote` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `pnr_history_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) History ID');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `agent_sign` SET TAGS ('dbx_business_glossary_term' = 'Agent Sign');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `agent_sign` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `change_reason_text` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Text');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `change_source` SET TAGS ('dbx_business_glossary_term' = 'Change Source');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `change_source` SET TAGS ('dbx_value_regex' = 'gds|api|web|mobile|airport|call_center');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `endorsement_text` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Text');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Type');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_value_regex' = 'cash|credit_card|debit_card|invoice|voucher|points');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `gds_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `gds_code` SET TAGS ('dbx_value_regex' = '1A|1B|1G|1P|1S|1V');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `history_entry_type` SET TAGS ('dbx_business_glossary_term' = 'History Entry Type');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `history_entry_type` SET TAGS ('dbx_value_regex' = 'segment_add|segment_cancel|segment_modify|name_change|ticket_issuance|ticket_void');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `history_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'History Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `is_automated_change` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Change Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `office_iata_number` SET TAGS ('dbx_business_glossary_term' = 'Office International Air Transport Association (IATA) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `office_iata_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{9}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `old_value` SET TAGS ('dbx_business_glossary_term' = 'Old Value');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `passenger_number` SET TAGS ('dbx_business_glossary_term' = 'Passenger Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `queue_number` SET TAGS ('dbx_business_glossary_term' = 'Queue Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `record_locator` SET TAGS ('dbx_business_glossary_term' = 'Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `record_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `record_locator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `record_locator` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `remark_text` SET TAGS ('dbx_business_glossary_term' = 'Remark Text');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `seat_number` SET TAGS ('dbx_business_glossary_term' = 'Seat Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `seat_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}[A-K]$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `segment_number` SET TAGS ('dbx_business_glossary_term' = 'Segment Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `session_reference` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ssr_code` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) Code');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ssr_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ticket_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `ticket_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `airlines_ecm`.`reservation`.`pnr_history` ALTER COLUMN `waiver_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Code');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` SET TAGS ('dbx_subdomain' = 'ticketing_operations');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `booking_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Payment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `corporate_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `fare_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Quote Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `mileage_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Mileage Redemption Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `agency_iata_number` SET TAGS ('dbx_business_glossary_term' = 'Agency International Air Transport Association (IATA) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `gateway_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Transaction Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `instalment_count` SET TAGS ('dbx_business_glossary_term' = 'Instalment Count');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `instalment_number` SET TAGS ('dbx_business_glossary_term' = 'Instalment Number');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `instalment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Instalment Plan Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Card Number');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `miles_redeemed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Miles Redeemed Quantity');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `processor_response_code` SET TAGS ('dbx_business_glossary_term' = 'Processor Response Code');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `processor_response_message` SET TAGS ('dbx_business_glossary_term' = 'Processor Response Message');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Settlement Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Domain Secure (3DS) Authentication Status');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_value_regex' = 'not_attempted|authenticated|authentication_failed|challenge_required|not_enrolled');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`booking_payment` ALTER COLUMN `voucher_code` SET TAGS ('dbx_business_glossary_term' = 'Voucher Code');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` SET TAGS ('dbx_subdomain' = 'ticketing_operations');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Transaction Identifier');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `arc_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Airlines Reporting Corporation (ARC) Settlement ID');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `baggage_irregularity_id` SET TAGS ('dbx_business_glossary_term' = 'Baggage Irregularity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing and Settlement Plan (BSP) Settlement ID');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `consumer_protection_case_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Case Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent ID');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `mileage_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Mileage Redemption Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `revenue_emd_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket ID');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `fee_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Refund Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `gds_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Code');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `gds_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `miles_refunded` SET TAGS ('dbx_business_glossary_term' = 'Miles Refunded');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `original_emd_number` SET TAGS ('dbx_business_glossary_term' = 'Original Electronic Miscellaneous Document (EMD) Number');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `original_emd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `original_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Fare Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `original_form_of_payment` SET TAGS ('dbx_business_glossary_term' = 'Original Form of Payment (FOP)');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Original Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Processing Channel');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `processing_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|airport_counter|gds|travel_agent');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Approval Date');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_form_of_payment|voucher|miles|credit_shell|bank_transfer');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_processing_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processing Date');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processing Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Number');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_request_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Request Date');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Request Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'requested|approved|processed|rejected|cancelled');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'full|partial|involuntary|voluntary');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_voucher_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Voucher Number');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `refund_voucher_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `tax_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Refund Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `total_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Refund Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `voucher_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Voucher Expiry Date');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `waiver_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Code');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `waiver_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`reservation`.`refund_transaction` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` SET TAGS ('dbx_subdomain' = 'passenger_services');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `schedule_change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Change Notification ID');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `consumer_protection_case_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Case Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Original Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `codeshare_flag` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Eligible Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|cancellation');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `marketing_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Airline Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `marketing_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'New Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'New Arrival Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'New Arrival Date and Time');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_departure_airport_code` SET TAGS ('dbx_business_glossary_term' = 'New Departure Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_departure_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'New Departure Date and Time');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_flight_number` SET TAGS ('dbx_business_glossary_term' = 'New Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `new_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Change Notification Number');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^SCN[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'pending|notified|acknowledged|failed|cancelled');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'schedule_change|flight_cancellation|equipment_change|routing_change|time_change|gate_change');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Airline Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Original Arrival Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'Original Arrival Date and Time');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_departure_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_departure_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date and Time');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Original Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `original_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `passenger_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Passenger Acceptance Status');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `passenger_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending|auto_accepted');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `passenger_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Passenger Notification Status');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `passenger_notification_status` SET TAGS ('dbx_value_regex' = 'notified|pending|failed|not_required');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `reaccommodation_action` SET TAGS ('dbx_business_glossary_term' = 'Reaccommodation Action');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `reaccommodation_action` SET TAGS ('dbx_value_regex' = 'none|rebooked|refunded|voucher_issued|upgraded|alternate_routing');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `reaccommodation_flight_number` SET TAGS ('dbx_business_glossary_term' = 'Reaccommodation Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `reaccommodation_flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `time_difference_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Difference in Minutes');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `travel_agency_iata_number` SET TAGS ('dbx_business_glossary_term' = 'Travel Agency IATA Number');
ALTER TABLE `airlines_ecm`.`reservation`.`schedule_change_notification` ALTER COLUMN `travel_agency_iata_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` SET TAGS ('dbx_subdomain' = 'passenger_services');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `travel_document_id` SET TAGS ('dbx_business_glossary_term' = 'Travel Document Identifier');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collecting Agent ID');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Collecting Office ID');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `apis_response_code` SET TAGS ('dbx_business_glossary_term' = 'Advance Passenger Information System (APIS) Response Code');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `apis_response_message` SET TAGS ('dbx_business_glossary_term' = 'Advance Passenger Information System (APIS) Response Message');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `apis_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Advance Passenger Information System (APIS) Transmission Status');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `apis_transmission_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|rejected|error');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `apis_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Advance Passenger Information System (APIS) Transmission Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `boarding_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Boarding Eligibility Status');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `boarding_eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_review|conditional');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'web_checkin|mobile_app|airport_kiosk|counter_agent|gds|api');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `compliance_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validation Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Travel Document Number');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Travel Document Type');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|visa|resident_permit|travel_permit|refugee_document');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Document Verification Status');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `document_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_verified|expired');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|X|U');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `given_names` SET TAGS ('dbx_business_glossary_term' = 'Given Names');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `given_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `given_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Ineligibility Reason');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Place of Birth');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `ssr_docs_element` SET TAGS ('dbx_business_glossary_term' = 'Special Service Request (SSR) DOCS Element');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `surname` SET TAGS ('dbx_business_glossary_term' = 'Surname');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `surname` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `surname` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`travel_document` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` SET TAGS ('dbx_subdomain' = 'ticketing_operations');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `voluntary_change_id` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Change ID');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `booking_pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Booking ID');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `fare_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Quote Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `mileage_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Mileage Redemption Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Office ID');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_channel` SET TAGS ('dbx_business_glossary_term' = 'Change Channel');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Fee Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_fee_waiver_code` SET TAGS ('dbx_business_glossary_term' = 'Change Fee Waiver Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_fee_waiver_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Processed Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Request Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_status` SET TAGS ('dbx_value_regex' = 'pending|processing|completed|rejected|cancelled|refunded');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `fare_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Fare Difference Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `fare_rule_category` SET TAGS ('dbx_business_glossary_term' = 'Fare Rule Category');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `fare_rule_category` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `form_of_payment_code` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `form_of_payment_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `interline_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'New Cabin Class');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_departure_date` SET TAGS ('dbx_business_glossary_term' = 'New Departure Date');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'New Destination Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'New Fare Basis Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_fare_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'New Origin Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'New Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `new_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Original Cabin Class');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Original Destination Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Original Fare Basis Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_fare_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Original Origin Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Original Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `rejection_reason_text` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Text');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `total_amount_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Collected');
ALTER TABLE `airlines_ecm`.`reservation`.`voluntary_change` ALTER COLUMN `total_amount_refunded` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Refunded');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Owner Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Office Identifier (ID)');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Group Contract Number');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `deposit_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Received Flag');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Station Code');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `destination_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `final_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Due Date');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_booking_status` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Status');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_booking_status` SET TAGS ('dbx_value_regex' = 'option|tentative|confirmed|partially_ticketed|fully_ticketed|cancelled');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Group Coordinator Email Address');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Group Coordinator Name');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Group Coordinator Phone Number');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_coordinator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Name');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Type');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `marketing_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Airline Code');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `marketing_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `name_list_deadline` SET TAGS ('dbx_business_glossary_term' = 'Name List Completion Deadline');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `negotiated_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Fare Amount Per Passenger');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Airline Code');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Code');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `origin_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `pnr_locator_list` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator List');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Remarks');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `seats_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Seats Confirmed');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `seats_named` SET TAGS ('dbx_business_glossary_term' = 'Seats Named');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `seats_ticketed` SET TAGS ('dbx_business_glossary_term' = 'Seats Ticketed');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `special_service_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Service Requirements (SSR)');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `ticketing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Deadline');
ALTER TABLE `airlines_ecm`.`reservation`.`group_booking` ALTER COLUMN `total_seats_contracted` SET TAGS ('dbx_business_glossary_term' = 'Total Seats Contracted');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` SET TAGS ('dbx_subdomain' = 'ticketing_operations');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `coupon_status_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `booking_pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Booking ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Segment ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Office ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `reservation_booking_passenger_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Passenger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon ID');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `previous_coupon_status_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Arrival Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `baggage_allowance` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `booking_class_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Class Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `booking_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `cabin_class_code` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `cabin_class_code` SET TAGS ('dbx_value_regex' = 'F|J|W|Y');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `checked_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checked-In Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `codeshare_indicator` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `coupon_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Coupon Sequence Number');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `coupon_status_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `coupon_status_description` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status Description');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Departure Airport Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `endorsement_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Restrictions');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `exchange_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exchange Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]{0,1}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `flown_date` SET TAGS ('dbx_business_glossary_term' = 'Flown Date');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `flown_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Flown Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Record Locator');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `gds_record_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `interline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interline Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `irop_indicator` SET TAGS ('dbx_business_glossary_term' = 'Irregular Operations (IROP) Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `lifted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lifted Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `not_valid_after_date` SET TAGS ('dbx_business_glossary_term' = 'Not Valid After Date');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `not_valid_before_date` SET TAGS ('dbx_business_glossary_term' = 'Not Valid Before Date');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Original E-Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `previous_status_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Coupon Status Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Processing Channel');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `reissue_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reissue Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status Remarks');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `scheduled_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Date');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `status_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `status_change_reason_text` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Text');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'E-Ticket Number');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Validating Carrier Code');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`coupon_status` ALTER COLUMN `waiver_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Code');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` SET TAGS ('dbx_association_edges' = 'reservation.itinerary_segment,loyalty.mileage_accrual');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `segment_mileage_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Mileage Accrual ID');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Mileage Accrual - Itinerary Segment Id');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `mileage_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Mileage Accrual - Mileage Accrual Id');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `qualifying_indicator` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Indicator');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `segment_base_miles` SET TAGS ('dbx_business_glossary_term' = 'Segment Base Miles');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `segment_contribution_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Contribution Date');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `segment_elite_bonus_miles` SET TAGS ('dbx_business_glossary_term' = 'Segment Elite Bonus Miles');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `segment_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Posting Status');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_mileage_accrual` ALTER COLUMN `segment_promotional_bonus_miles` SET TAGS ('dbx_business_glossary_term' = 'Segment Promotional Bonus Miles');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` SET TAGS ('dbx_subdomain' = 'booking_management');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` SET TAGS ('dbx_association_edges' = 'reservation.itinerary_segment,ancillary.product_catalog');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `segment_ancillary_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Ancillary Purchase ID');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `itinerary_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Ancillary Purchase - Itinerary Segment Id');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Ancillary Purchase - Ancillary Product Id');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `emd_number` SET TAGS ('dbx_business_glossary_term' = 'EMD Number');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `fulfillment_notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `price_paid` SET TAGS ('dbx_business_glossary_term' = 'Price Paid');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `purchase_channel` SET TAGS ('dbx_business_glossary_term' = 'Purchase Channel');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `airlines_ecm`.`reservation`.`segment_ancillary_purchase` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
