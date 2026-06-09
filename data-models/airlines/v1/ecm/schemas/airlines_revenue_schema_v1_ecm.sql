-- Schema for Domain: revenue | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`revenue` COMMENT 'Revenue management and pricing SSOT — HOW the airline prices and captures revenue. Owns fare structures, pricing rules, yield management parameters, fare classes, dynamic pricing, RASK/CASK/RPK/ASK performance metrics, revenue accounting records, BSP (Billing and Settlement Plan) settlements, ARC reporting, and ancillary revenue aggregation. Aligns with Sabre AirVision Revenue Management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`fare` (
    `fare_id` BIGINT COMMENT 'Unique surrogate identifier for the fare record in the lakehouse silver layer. Primary key for the fare master definition table.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Fares are managed by route/region cost centers for yield management accountability and revenue optimization. Links pricing strategy to financial responsibility centers.',
    `fare_class_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_class. Business justification: Fares are associated with booking classes (RBDs). The booking_class attribute in fare should reference the authoritative fare_class master. Standard N:1 relationship. No bidirectional conflict. bookin',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Individual fares are grouped into fare families (branded fares). A fare belongs to one fare family. This is the authoritative link between the atomic fare definition and its branded fare grouping. Sta',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Fare construction must comply with specific regulatory requirements (DOT pricing transparency, EU unbundling mandates, accessibility pricing rules). ATPCO fare filings reference regulatory mandates th',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Fares are defined for specific routes. This FK links the fare to the route master for pricing analysis, revenue management, and competitive benchmarking.',
    `advance_purchase_days` STRING COMMENT 'Minimum number of days before departure that the ticket must be purchased to qualify for this fare. A value of 0 indicates no advance purchase requirement. Key yield management parameter.',
    `amount` DECIMAL(18,2) COMMENT 'Published or filed fare amount in the specified currency, representing the one-way or round-trip base fare before taxes and surcharges. This is the principal monetary value of the fare record as filed with ATPCO or SITA.',
    `atpco_record_type` STRING COMMENT 'ATPCO record type number identifying the category of fare data: Record 1=Fare by Rule, Record 2=Fare Amount, Record 3=Fare Rules, Record 4=Footnote, Record 5=Routing, Record 6=Fare Class. Governs how the fare is processed in GDS and PSS systems.. Valid values are `1|2|3|4|5|6`',
    `basis_code` STRING COMMENT 'ATPCO-standard alphanumeric code uniquely identifying the fare construction rules, booking class, and conditions (e.g., YOW, KLAXOW, B21NR). The atomic pricing identifier used across GDS, PSS, and revenue management systems. Maximum 8 characters per ATPCO convention.. Valid values are `^[A-Z0-9]{1,8}$`',
    `booking_class` STRING COMMENT 'Single-letter IATA Reservation Booking Designator (RBD) that maps this fare to an inventory bucket in the PSS (e.g., Y, B, M, Q, K). Controls seat availability and yield management in Amadeus Altéa and Sabre AirVision.. Valid values are `^[A-Z]{1}$`',
    `cabin_class` STRING COMMENT 'Physical cabin of service associated with this fare (e.g., first, business, premium_economy, economy). Determines the onboard product and service level entitlement for the passenger.. Valid values are `first|business|premium_economy|economy`',
    `carrier_code` STRING COMMENT 'IATA two-letter airline designator code of the validating or operating carrier for whom this fare is filed (e.g., AA, BA, SQ). Identifies the airline that owns and controls the fare filing.. Valid values are `^[A-Z0-9]{2}$`',
    `changeable_indicator` BOOLEAN COMMENT 'Indicates whether the itinerary or date may be changed after ticketing (True) or is a fixed non-changeable fare (False). May be subject to a change fee defined in the associated fare rule.',
    `class_code` STRING COMMENT 'One or two-letter code representing the fare class grouping within the cabin (e.g., Y for full economy, B for discounted economy). Used in revenue management for yield optimization and load factor reporting.. Valid values are `^[A-Z]{1,2}$`',
    `combinability_code` STRING COMMENT 'ATPCO code governing how this fare may be combined with other fares in a half-round-trip or end-on-end combination. Controls fare construction logic in GDS and PSS pricing engines.. Valid values are `^[A-Z0-9]{1,3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fare record was first ingested into the lakehouse silver layer from the source system (Sabre AirVision or ATPCO feed). Supports data lineage, audit, and regulatory compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the fare amount is denominated (e.g., USD, EUR, GBP). Determines the settlement currency for BSP and ARC reporting.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'IATA three-letter airport or city code representing the arrival point of the fares origin-destination city pair (e.g., LAX, CDG, NRT). Together with origin defines the O&D market for revenue management analysis.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the fare destination point. Used for international fare applicability, bilateral air service agreement compliance, and CORSIA carbon reporting.. Valid values are `^[A-Z]{3}$`',
    `directionality` STRING COMMENT 'Indicates whether the fare applies to a one-way journey, round-trip, circle trip, or open-jaw itinerary. Determines how the fare is combined in fare construction and pricing calculations.. Valid values are `one_way|round_trip|circle_trip|open_jaw`',
    `discontinue_date` DATE COMMENT 'The date after which this fare is no longer valid for ticketing. A null value indicates the fare has no defined expiry. Aligns with ATPCO fare filing discontinue date field.',
    `effective_date` DATE COMMENT 'The date from which this fare becomes valid for ticketing and travel. Fares may not be sold or applied to itineraries before this date. Aligns with ATPCO fare filing effective date field.',
    `fare_status` STRING COMMENT 'Current lifecycle state of the fare record: active (available for sale), inactive (not currently sellable), pending (filed but not yet effective), withdrawn (removed from filing), superseded (replaced by a newer fare version).. Valid values are `active|inactive|pending|withdrawn|superseded`',
    `fare_type` STRING COMMENT 'Classification of the fare by its distribution and ownership model. Published fares are filed publicly via ATPCO/SITA; negotiated fares are corporate or agency-specific; private fares are not publicly visible in GDS; web fares are exclusive to direct channels; net fares are wholesale fares for consolidators. [ENUM-REF-CANDIDATE: published|negotiated|private|web|net|consolidator — promote to reference product]. Valid values are `published|negotiated|private|web|net`',
    `filing_date` DATE COMMENT 'The date on which this fare was originally filed with ATPCO, SITA, or the carriers own system. Used for audit trails, regulatory compliance, and fare history analysis.',
    `global_indicator` STRING COMMENT 'IATA-defined two-letter code specifying the geographic routing area applicable to this fare (e.g., AT=Atlantic, PA=Pacific, TS=Trans-Siberian, AP=Asia-Pacific). Governs which routing rules and mileage systems apply for fare construction. [ENUM-REF-CANDIDATE: AT|PA|TS|AP|SA|EH|FE|NA|PO|RU|US — 11 candidates stripped; promote to reference product]',
    `iata_fare_filing_ref` STRING COMMENT 'IATA-assigned reference number or identifier for the fare filing submission. Used for audit, dispute resolution, and cross-referencing with IATA BSP settlement records.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this fare record in the lakehouse, including fare amount changes, status updates, or rule amendments. Supports data lineage and audit requirements.',
    `maximum_stay_days` STRING COMMENT 'Maximum number of days the passenger may remain at the destination before the return journey must commence. A null value indicates no maximum stay restriction.',
    `minimum_stay_days` STRING COMMENT 'Minimum number of days the passenger must remain at the destination before returning, as required by this fares conditions. Commonly used for round-trip leisure fares to prevent business travelers from using discounted fares.',
    `origin_airport_code` STRING COMMENT 'IATA three-letter airport or city code representing the departure point of the fares origin-destination city pair (e.g., JFK, LHR, SIN). Defines the directional applicability of the fare.. Valid values are `^[A-Z]{3}$`',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the fare origin point. Used for regulatory compliance, DOT reporting, and country-of-sale restrictions.. Valid values are `^[A-Z]{3}$`',
    `ownership` STRING COMMENT 'Identifies the filing channel through which this fare was submitted and is maintained: ATPCO (Airline Tariff Publishing Company), SITA (Société Internationale de Télécommunications Aéronautiques), or carrier-filed directly into the PSS.. Valid values are `ATPCO|SITA|carrier_filed`',
    `owrt_indicator` STRING COMMENT 'ATPCO one-way/round-trip indicator: O=one-way only, R=round-trip only, X=either. Controls how the fare may be combined in half-round-trip pricing and fare construction.. Valid values are `O|R|X`',
    `passenger_type_code` STRING COMMENT 'IATA three-letter Passenger Type Code specifying the eligible passenger category for this fare (e.g., ADT=Adult, CHD=Child, INF=Infant, SRC=Senior, MIL=Military, STU=Student). Restricts fare applicability to qualifying passengers.. Valid values are `^[A-Z]{3}$`',
    `refundable_indicator` BOOLEAN COMMENT 'Indicates whether this fare is eligible for a cash refund upon cancellation (True) or is non-refundable (False). Critical for passenger service, revenue accounting, and DOT consumer protection compliance.',
    `routing_number` STRING COMMENT 'ATPCO-assigned routing number that specifies the permitted intermediate points and carrier combinations for this fare. A value of 0 typically indicates a mileage-based fare with no specific routing restriction.. Valid values are `^[0-9]{1,5}$`',
    `sales_restriction` STRING COMMENT 'Defines geographic or channel restrictions on where this fare may be sold. Controls distribution eligibility across GDS, direct channels, and agency networks. [ENUM-REF-CANDIDATE: no_restriction|country_of_origin|carrier_office|internet_only|agency_only|consolidator_only — promote to reference product]. Valid values are `no_restriction|country_of_origin|carrier_office|internet_only|agency_only`',
    `tariff_code` STRING COMMENT 'Alphanumeric code identifying the specific tariff under which this fare is filed (e.g., PUBL for published, PRIV for private). Determines the visibility and distribution rules in GDS channels.. Valid values are `^[A-Z0-9]{2,4}$`',
    `tariff_number` STRING COMMENT 'ATPCO tariff number identifying the rule set (conditions, restrictions, penalties) associated with this fare. Links the fare amount to its governing fare rules in the ATPCO database.. Valid values are `^[A-Z0-9]{1,4}$`',
    `ticketing_carrier_code` STRING COMMENT 'IATA two-letter code of the carrier authorized to issue tickets under this fare. May differ from the operating carrier in codeshare and interline arrangements. Used for BSP settlement and ARC reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `travel_discontinue_date` DATE COMMENT 'The last date on which travel may be completed using this fare. Defines the travel validity window in conjunction with travel_effective_date.',
    `travel_effective_date` DATE COMMENT 'The earliest date on which travel may commence using this fare. Distinct from the ticketing effective date; governs the travel window rather than the sale window.',
    CONSTRAINT pk_fare PRIMARY KEY(`fare_id`)
) COMMENT 'Master fare definition record representing a published or private fare basis — the atomic pricing unit in the airline revenue management system. Owns fare basis code, fare amount, currency, cabin class, booking class (RBD), fare type (published/negotiated/private/web), one-way or round-trip indicator, directionality, origin-destination city pair, carrier designator, ticketing carrier, global indicator, routing number, fare tariff number, IATA fare filing reference, effective date, discontinue date, and fare ownership (ATPCO/SITA/carrier-filed). Aligns with Sabre AirVision fare filing and ATPCO Fare Filing standards.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`fare_rule` (
    `fare_rule_id` BIGINT COMMENT 'Unique surrogate identifier for the fare rule record in the Silver layer lakehouse. Primary key for this entity.',
    `fare_class_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_class. Business justification: Fare rules often specify which booking classes (RBDs) they apply to. The fare_class_code attribute in fare_rule should reference the authoritative fare_class master. Standard N:1 relationship. No bidi',
    `fare_id` BIGINT COMMENT 'Reference to the parent fare basis code to which this rule applies. Links the rule to its governing fare product in the revenue management system.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Fare rules must comply with specific regulatory requirements (EC261 refund mandates, DOT change fee caps, transparency rules). Regulatory requirements directly constrain fare rule construction; airlin',
    `advance_purchase_hours` STRING COMMENT 'Minimum number of hours before departure by which the ticket must be purchased to qualify for this fare (ATPCO Cat 5). Null if no advance purchase requirement applies. Expressed in hours to accommodate sub-day requirements (e.g., 3-hour, 6-hour, 24-hour, 72-hour, 168-hour/7-day, 336-hour/14-day).',
    `atpco_category_number` STRING COMMENT 'ATPCO rule category number (Cat 1–35) that classifies the type of restriction or condition this rule record governs. Examples: Cat 2 = Day/Time, Cat 3 = Seasonality, Cat 4 = Flight Application, Cat 5 = Advance Purchase, Cat 6 = Min Stay, Cat 7 = Max Stay, Cat 8 = Stopovers, Cat 9 = Transfers, Cat 14 = Travel Restrictions, Cat 15 = Sales Restrictions, Cat 16 = Penalties, Cat 31 = Voluntary Changes, Cat 33 = Voluntary Refunds.',
    `blackout_end_date` DATE COMMENT 'End date of a travel blackout period during which this fare is not available for travel (ATPCO Cat 11). Null if no blackout period applies.',
    `blackout_start_date` DATE COMMENT 'Start date of a travel blackout period during which this fare is not available for travel (ATPCO Cat 11 — Blackout Dates). Null if no blackout period applies. Multiple blackout periods should be stored as separate rule records.',
    `cabin_type` STRING COMMENT 'Physical cabin of the aircraft to which this fare rule applies. Determines the service level and seating configuration associated with the fare.. Valid values are `economy|premium_economy|business|first`',
    `carrier_code` STRING COMMENT 'IATA two-letter airline designator code of the validating carrier that owns and filed this fare rule. Identifies the airline responsible for the tariff.. Valid values are `^[A-Z0-9]{2}$`',
    `category_name` STRING COMMENT 'Human-readable name of the ATPCO rule category (e.g., Advance Purchase, Minimum Stay, Maximum Stay, Stopovers, Transfers, Penalties, Combinability, Blackout Dates, Seasonality, Day/Time Restrictions). Derived from the ATPCO category number for display and reporting purposes.',
    `change_fee_amount` DECIMAL(18,2) COMMENT 'Monetary penalty charged to the passenger for a voluntary ticket change under this fare rule (ATPCO Cat 31). Expressed in the currency defined by change_fee_currency. Null if changes are not permitted or no fee applies.',
    `change_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the change fee amount is denominated (e.g., USD, EUR, GBP). Null if no change fee applies.. Valid values are `^[A-Z]{3}$`',
    `combinability_type` STRING COMMENT 'Specifies how this fare may be combined with other fares to construct a complete itinerary (ATPCO Cat 10). end_on_end = fares combined sequentially; back_to_back = two one-way fares used together; open_jaw = origin or destination differs on outbound/return; round_trip = must be used as a round trip; none = no combination permitted.. Valid values are `end_on_end|back_to_back|open_jaw|round_trip|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fare rule record was first created in the Silver layer data product. Supports audit trail and data lineage tracking.',
    `destination_airport_code` STRING COMMENT 'IATA three-letter airport code for the destination to which this fare rule applies. Used to scope the rule to a specific arrival market. Null if the rule applies globally regardless of destination.. Valid values are `^[A-Z]{3}$`',
    `discontinue_date` DATE COMMENT 'Date after which this fare rule is no longer applicable. Null indicates the rule is open-ended with no planned expiry. Corresponds to the ATPCO discontinue date field.',
    `effective_date` DATE COMMENT 'Date from which this fare rule becomes commercially effective and is applied by the pricing engine. Aligns with the ATPCO effective date field in the tariff filing.',
    `endorsement_text` STRING COMMENT 'Free-text endorsement or restriction box content that must be printed on the ticket (ATPCO Cat 20 — Endorsements). Contains regulatory or commercial restrictions such as NON-ENDORSE/NON-REROUTE, VALID ON XX ONLY, or NO REFUND AFTER DEPARTURE. Required by IATA ticketing standards.',
    `fare_class_code` STRING COMMENT 'Single or two-letter booking class code (RBD — Reservations Booking Designator) associated with this fare rule. Determines the inventory bucket in which seats are sold under this fare. Examples: Y (full economy), B, M, H, Q, V, W (discounted economy), J, C, D (business), F, A (first).. Valid values are `^[A-Z]{1,2}$`',
    `global_indicator` STRING COMMENT 'IATA global indicator code that defines the geographic routing area for which this fare rule is valid. Determines the applicable IATA area and sub-area for international fare construction. Examples: AT = Atlantic, PA = Pacific, PN = Pacific/North America, EH = Eastern Hemisphere, WH = Western Hemisphere. [ENUM-REF-CANDIDATE: AT|PA|PN|PO|AP|EH|FE|TS|WH|ZA — 10 candidates stripped; promote to reference product]',
    `is_changeable` BOOLEAN COMMENT 'Indicates whether the ticket issued under this fare may be voluntarily changed (date, routing, or flight change) by the passenger (ATPCO Cat 31 — Voluntary Changes). True = changes permitted (possibly with fee); False = no changes allowed.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the fare is eligible for a monetary refund upon cancellation (ATPCO Cat 33 — Voluntary Refunds). True = refundable (possibly with penalty); False = non-refundable.',
    `max_stay_days` STRING COMMENT 'Maximum number of days the passenger may remain at the destination before the return journey must commence (ATPCO Cat 7). Null if no maximum stay restriction applies.',
    `min_stay_days` STRING COMMENT 'Minimum number of days the passenger must remain at the destination before returning, as required by this fare rule (ATPCO Cat 6). Null if no minimum stay applies. A value of 0 with a non-null field indicates a Sunday rule (must include a Saturday night).',
    `min_stay_type` STRING COMMENT 'Qualifier for the minimum stay requirement. days = calendar day count applies; saturday_night = passenger must include a Saturday night at destination; none = no minimum stay restriction.. Valid values are `days|saturday_night|none`',
    `origin_airport_code` STRING COMMENT 'IATA three-letter airport code for the point of origin to which this fare rule applies. Used to scope the rule to a specific departure market. Null if the rule applies globally regardless of origin.. Valid values are `^[A-Z]{3}$`',
    `permitted_days_of_week` STRING COMMENT 'Comma-separated list of days of the week on which travel under this fare is permitted (ATPCO Cat 2 — Day/Time). Values: MON, TUE, WED, THU, FRI, SAT, SUN. Null or empty means all days are permitted. Example: MON,TUE,WED,THU restricts to weekday travel only.',
    `refund_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty deducted from the refund amount when a passenger cancels a refundable ticket under this fare rule (ATPCO Cat 33). Expressed in the currency defined by refund_penalty_currency. Null if the fare is non-refundable or no penalty applies.',
    `refund_penalty_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the refund penalty amount is denominated. Null if no refund penalty applies.. Valid values are `^[A-Z]{3}$`',
    `rule_number` STRING COMMENT 'Carrier-assigned rule number that groups related rule categories under a single tariff filing. Used by pricing engines to retrieve the full rule set for a fare basis. Corresponds to the ATPCO rule number field.. Valid values are `^[A-Z0-9]{1,10}$`',
    `rule_status` STRING COMMENT 'Current lifecycle status of the fare rule record. active = currently in force and applied by pricing engines; inactive = suspended or withdrawn; superseded = replaced by a newer rule version; pending = filed but not yet effective.. Valid values are `active|inactive|superseded|pending`',
    `rule_text` STRING COMMENT 'Complete free-text narrative of the fare rule as filed with ATPCO or the carriers internal tariff system. Contains the full legal and commercial conditions of use. Used by ticketing agents and displayed in GDS fare displays.',
    `sales_restriction_type` STRING COMMENT 'Channel restriction governing where this fare may be sold (ATPCO Cat 15 — Sales Restrictions). internet_only = only available via airline direct web/app; agency_only = only through accredited travel agents; direct_only = only via airline direct channels; gds_only = only through Global Distribution Systems; none = no channel restriction.. Valid values are `internet_only|agency_only|direct_only|gds_only|none`',
    `season_type` STRING COMMENT 'Seasonal classification applied to this fare rule (ATPCO Cat 3 — Seasonality). Determines the travel season band in which the fare is valid. peak = high-demand season; shoulder = transitional season; off_peak = low-demand season; none = no seasonal restriction.. Valid values are `peak|shoulder|off_peak|none`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this fare rule was sourced. ATPCO = Airline Tariff Publishing Company filing; SABRE = Sabre AirVision Revenue Management; AMADEUS = Amadeus Altéa; INTERNAL = carriers internal pricing system.. Valid values are `ATPCO|SABRE|AMADEUS|INTERNAL`',
    `stopovers_permitted` STRING COMMENT 'Maximum number of stopovers (intentional interruptions of journey exceeding the Minimum Connecting Time) permitted under this fare rule (ATPCO Cat 8). A value of 0 means no stopovers allowed; null means unlimited.',
    `tariff_number` STRING COMMENT 'ATPCO tariff number under which this rule is filed. Tariffs group fare rules by market type (e.g., domestic, international, specific bilateral markets). Used by GDS pricing engines to locate applicable rules.. Valid values are `^[A-Z0-9]{1,8}$`',
    `tour_code` STRING COMMENT 'Tour operator or inclusive tour code required to be present on the ticket for this fare to be valid (ATPCO Cat 27 — Tour Conductor Discounts / inclusive tour requirements). Null if no tour code is required. Used for IT (Inclusive Tour) and BT (Bulk Tour) fares.',
    `transfers_permitted` STRING COMMENT 'Maximum number of transfers (connections within Minimum Connecting Time) permitted under this fare rule (ATPCO Cat 9). A value of 0 means no transfers allowed; null means unlimited.',
    `travel_restriction_type` STRING COMMENT 'Directional travel restriction applied to this fare rule (ATPCO Cat 14 — Travel Restrictions). Specifies whether the rule applies to the outbound journey, inbound journey, or both directions of travel.. Valid values are `outbound_only|inbound_only|both|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fare rule record was most recently modified. Used to detect changes from the source ATPCO filing or Sabre AirVision Revenue Management system and support incremental data loads.',
    CONSTRAINT pk_fare_rule PRIMARY KEY(`fare_rule_id`)
) COMMENT 'Business rules governing the conditions of use for a fare basis — the regulatory and commercial constraints attached to a fare. Captures rule category (advance purchase, minimum/maximum stay, stopovers, transfers, combinability, blackout dates, seasonality, day-of-week restrictions, tour code requirements, penalties, refundability, endorsement/restriction text). References the parent fare and ATPCO rule category numbers (Cat 1–35). Owns the full rule text and structured rule parameters used by pricing engines and ticketing systems.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`fare_class` (
    `fare_class_id` BIGINT COMMENT 'Unique surrogate identifier for each Reservation Booking Designator (RBD) fare class record in the revenue management system. Primary key for the fare_class master reference table.',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Fare classes (booking classes/RBDs) are defined within specific cabin products, mapping service levels to pricing tiers. Foundational relationship for fare structure, revenue management, and inventory',
    `advance_purchase_days` STRING COMMENT 'Minimum number of days before departure that a ticket must be purchased to qualify for this fare class (e.g., 7, 14, 21 days). A value of 0 indicates no advance purchase requirement. Used by Sabre AirVision Revenue Management to enforce time-based fare restrictions and manage booking curve yield optimization.',
    `availability_control_method` STRING COMMENT 'Revenue management inventory control methodology applied to this fare class: leg = leg-based availability control; segment = segment-level control; od = Origin and Destination (O&D) control; virtual_nesting = virtual nesting across multiple fare classes. Determines how Sabre AirVision allocates and protects seat inventory for this RBD across the network.. Valid values are `leg|segment|od|virtual_nesting`',
    `award_redemption_class` BOOLEAN COMMENT 'Indicates whether this fare class is designated as an FFP (Frequent Flyer Program) award redemption booking class (True), meaning seats in this class are allocated from the award inventory pool and redeemed using loyalty miles/points rather than cash. Award classes are managed separately in Oracle Loyalty Cloud and do not generate direct ticket revenue.',
    `blackout_applicable` BOOLEAN COMMENT 'Indicates whether this fare class is subject to blackout date restrictions (True), meaning it cannot be sold or used for travel during defined peak or holiday periods. When True, blackout dates are defined in the associated fare rule or seasonal restriction records. Relevant for both revenue fares and FFP award redemption classes.',
    `carry_on_bag_allowance` STRING COMMENT 'Number of carry-on baggage items (cabin bags) included at no additional charge for passengers traveling in this fare class. A value of 0 indicates no complimentary carry-on allowance (applicable to ultra-low-cost basic fare products). Feeds ancillary revenue calculation and gate agent enforcement workflows.',
    `changeable` BOOLEAN COMMENT 'Indicates whether the itinerary on a ticket issued in this fare class can be changed after purchase (True) or is a fixed, non-changeable booking (False). When True, change fees and fare difference rules defined in the associated fare rule record apply. Drives Amadeus Altéa PSS voluntary change workflow.',
    `checked_bag_allowance` STRING COMMENT 'Number of checked baggage pieces included at no additional charge for passengers traveling in this fare class. A value of 0 indicates no complimentary checked baggage (e.g., basic economy). Drives ancillary baggage fee revenue calculation and EMD (Electronic Miscellaneous Document) issuance logic in Amadeus Altéa.',
    `codeshare_eligible` BOOLEAN COMMENT 'Indicates whether this fare class may be sold on codeshare-operated flights (True) or is restricted to the operating carriers own metal only (False). Codeshare eligibility governs interline proration and revenue sharing agreements between partner airlines under BSP settlement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fare class record was first created in the revenue management system. Provides audit trail for fare class configuration history and supports regulatory compliance reporting requirements.',
    `distribution_channel` STRING COMMENT 'Specifies the permitted distribution channels through which this fare class may be sold: all = no channel restriction; gds_only = available only through Global Distribution System (GDS) channels; direct_only = available only through the airlines direct channels (website, app, airport); ndc_only = available only through IATA NDC-compliant channels; gds_and_direct = available through both GDS and direct channels. Critical for revenue management channel strategy and NDC migration tracking.. Valid values are `all|gds_only|direct_only|ndc_only|gds_and_direct`',
    `effective_date` DATE COMMENT 'Calendar date from which this fare class definition becomes active and available for booking and inventory allocation in the PSS and revenue management system. Used to manage fare class lifecycle transitions and seasonal product introductions.',
    `expiry_date` DATE COMMENT 'Calendar date after which this fare class definition is no longer active for new bookings. A null value indicates the fare class has no defined expiry and remains active indefinitely. Used to manage seasonal fare class retirement and product sunset timelines.',
    `family` STRING COMMENT 'Grouping label that clusters related RBDs into a commercial fare product family (e.g., FLEX, SEMI-FLEX, SAVER, BASIC, BUSINESS_FLEX, BUSINESS_SAVER). Used by Sabre AirVision Revenue Management for fare family-level yield management, ancillary bundling rules, and customer-facing fare product presentation. [ENUM-REF-CANDIDATE: FLEX|SEMI-FLEX|SAVER|BASIC|BUSINESS_FLEX|BUSINESS_SAVER|LIGHT — promote to reference product]',
    `fare_basis_code_pattern` STRING COMMENT 'Alphanumeric pattern or prefix associated with fare basis codes that map to this fare class (e.g., YOW, BAPOW14, QSAVER21). Fare basis codes are the detailed pricing identifiers used in ATPCO (Airline Tariff Publishing Company) fare filings and GDS displays. This field captures the naming convention pattern rather than individual fare basis codes, which are managed in the fare rule product.',
    `fare_class_description` STRING COMMENT 'Free-text business description of this fare class, capturing its commercial purpose, target customer segment, and key product characteristics (e.g., Fully flexible full-fare economy class with unlimited changes and refunds, eligible for all upgrades and lounge access). Used in internal revenue management documentation and business reporting.',
    `fare_class_status` STRING COMMENT 'Current lifecycle status of the fare class record: active = currently in use for booking and inventory control; inactive = suspended from sale but retained for historical reference; deprecated = permanently retired RBD no longer used in any market; seasonal = active only during defined seasonal periods. Governs whether the RBD is available for inventory allocation in the PSS.. Valid values are `active|inactive|deprecated|seasonal`',
    `interline_eligible` BOOLEAN COMMENT 'Indicates whether tickets issued in this fare class may be used on interline itineraries involving other carriers under interline ticketing agreements (True) or are restricted to the issuing carriers own flights only (False). Interline eligibility affects BSP settlement, ARC reporting, and proration calculations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this fare class record in the revenue management system. Used for change data capture (CDC) in the Databricks Silver Layer ingestion pipeline and audit trail maintenance.',
    `lounge_access_included` BOOLEAN COMMENT 'Indicates whether airport lounge access is included as a bundled benefit for passengers traveling in this fare class (True) or is not included (False). Typically True for premium cabin classes (First, Business) and certain elite fare products. Drives lounge access entitlement checks at airport ground operations.',
    `max_stay_days` STRING COMMENT 'Maximum number of days the passenger may remain at the destination before the return journey must commence, as required by this fare class. A null value indicates no maximum stay restriction. Enforced during ticketing by the Amadeus Altéa PSS fare calculation engine.',
    `mileage_accrual_multiplier` DECIMAL(18,2) COMMENT 'Decimal multiplier applied to base flight distance (in miles or kilometers) to calculate Frequent Flyer Program (FFP) miles/points earned when a ticket is issued in this fare class. For example, 1.00 = 100% accrual, 0.50 = 50% accrual, 1.50 = 150% elite bonus accrual. A value of 0.00 indicates no mileage accrual (e.g., deeply discounted or award redemption classes). Feeds Oracle Loyalty Cloud FFP accrual calculation engine.',
    `min_stay_days` STRING COMMENT 'Minimum number of days the passenger must remain at the destination before returning, as required by this fare class (e.g., Saturday night stay requirement = 1 day minimum). A value of 0 indicates no minimum stay requirement. Used to prevent business travelers from arbitraging leisure fares.',
    `no_show_fee_applicable` BOOLEAN COMMENT 'Indicates whether a no-show penalty fee is charged when a passenger holding a ticket in this fare class fails to cancel before departure and does not board the flight (True). No-show fees are an ancillary revenue stream tracked in SAP S/4HANA and reported in ARC settlement.',
    `overbooking_eligible` BOOLEAN COMMENT 'Indicates whether seats sold in this fare class are included in the overbooking authorization calculation (True) or are excluded from overbooking (e.g., group blocks, charter allocations, staff travel) (False). Overbooking-eligible classes contribute to the denied boarding risk pool managed by Sabre AirVision Revenue Management.',
    `priority_boarding_included` BOOLEAN COMMENT 'Indicates whether priority boarding access is included as a bundled benefit for passengers traveling in this fare class (True) or must be purchased separately as an ancillary service (False). Relevant for fare product differentiation and ancillary revenue attribution in SAP S/4HANA.',
    `rbd_code` STRING COMMENT 'Single uppercase alphabetic character representing the booking class letter code (e.g., Y, B, M, Q, H, K, L, V, W, S, T, G, E, N, R, O, X, I, J, C, D, Z, F, A, P, U) as defined by IATA Resolution 728. This is the inventory bucket identifier used in the Global Distribution System (GDS) and Passenger Service System (PSS) to control seat availability at each price point.. Valid values are `^[A-Z]$`',
    `refundable` BOOLEAN COMMENT 'Indicates whether tickets issued in this fare class are eligible for a monetary refund upon cancellation (True) or are non-refundable (False). Non-refundable fares may still qualify for travel credit or voucher issuance depending on fare rules. Critical for revenue accounting, BSP (Billing and Settlement Plan) settlement, and ARC reporting.',
    `revenue_class_type` STRING COMMENT 'Categorizes the commercial nature of this fare class for revenue accounting and BSP/ARC settlement purposes: revenue = standard commercial fare generating ticket revenue; award = FFP redemption (no cash revenue); staff = employee/industry discount travel; charter = charter block-seat allocation; group = group booking class; tour_operator = wholesale tour operator allocation. Drives revenue recognition rules in SAP S/4HANA FI/CO.. Valid values are `revenue|award|staff|charter|group|tour_operator`',
    `same_day_change_eligible` BOOLEAN COMMENT 'Indicates whether tickets issued in this fare class qualify for same-day confirmed flight changes (True) or are restricted to the originally booked flight (False). Drives customer service agent workflows in the Amadeus Altéa PSS and is a key commercial differentiator between fare products.',
    `seat_selection_included` BOOLEAN COMMENT 'Indicates whether advance seat selection is included at no additional charge for passengers booking this fare class (True) or whether seat selection requires an additional ancillary fee (False). Drives ancillary seat revenue calculation and the seat map availability display in the booking engine.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this fare class record originated: SABRE_AV = Sabre AirVision Revenue Management; AMADEUS_ALTEA = Amadeus Altéa Inventory PSS; MANUAL = manually entered configuration; ATPCO = sourced from ATPCO fare filing. Supports data lineage tracking in the Databricks Silver Layer lakehouse.. Valid values are `SABRE_AV|AMADEUS_ALTEA|MANUAL|ATPCO`',
    `standby_eligible` BOOLEAN COMMENT 'Indicates whether passengers holding tickets in this fare class may be placed on the standby list for an earlier or alternative flight at no additional charge (True) or are restricted from standby (False). Relevant for same-day change and irregular operations (IROP) reprotection workflows.',
    `upgrade_eligible` BOOLEAN COMMENT 'Indicates whether tickets booked in this fare class are eligible for complimentary or paid cabin upgrades (True) or are explicitly excluded from upgrade consideration (False). Upgrade eligibility is enforced at check-in and gate by the Amadeus Altéa PSS and is a key differentiator between fare products in the same cabin.',
    `yield_class_rank` STRING COMMENT 'Ordinal ranking of this RBD within its cabin by revenue yield, where 1 represents the highest-yielding (most expensive) booking class and higher numbers represent progressively lower-yielding classes. Used by the revenue management system to sequence inventory bucket availability — higher-ranked (lower-yield) classes are closed first as load factor increases, protecting higher-yield inventory. Directly drives RASK (Revenue per Available Seat Kilometer) optimization logic.',
    CONSTRAINT pk_fare_class PRIMARY KEY(`fare_class_id`)
) COMMENT 'Reference master for Reservation Booking Designators (RBDs) defining the booking class hierarchy — the inventory bucket alphabet that maps sellable seats to fare products. Each record defines a single RBD: cabin assignment (First/Business/Premium Economy/Economy), booking class letter code (Y, B, M, Q, etc.), fare class family grouping, yield class ranking within cabin, upgrade eligibility flag, mileage accrual multiplier, and revenue management bucket assignment. Serves as the bridge between inventory availability (how many seats to sell at each price point) and revenue accounting (what was actually sold and at what yield).';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`pricing_record` (
    `pricing_record_id` BIGINT COMMENT 'Unique surrogate identifier for each pricing calculation event generated by the pricing engine. Primary key of this table.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to revenue.agency. Business justification: Pricing quotes generated for travel agencies should reference the agency master. This enables agency-specific pricing and commission tracking. Standard N:1 relationship. No bidirectional conflict.',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to ancillary.bundle. Business justification: Pricing quotes in airline reservation systems must track which fare family/ancillary bundle was selected during shopping. Revenue management and offer construction depend on this link to calculate tot',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Airlines track which marketing campaigns drive pricing quotes and shopping sessions for campaign ROI measurement, conversion funnel analysis, and marketing attribution. Essential for measuring campaig',
    `corporate_contract_id` BIGINT COMMENT 'Foreign key linking to revenue.corporate_contract. Business justification: Pricing calculations can apply corporate contract discounts. This links the pricing event to the contract being applied. Standard N:1 relationship. No bidirectional conflict.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Pricing decisions are attributed to cost centers for revenue management accountability and performance tracking. Links RM actions to financial outcomes.',
    `fare_class_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_class. Business justification: Pricing records capture the booking_class (RBD) that was quoted. This should reference the authoritative fare_class master. Standard N:1 relationship. No bidirectional conflict. booking_class remains ',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Pricing calculations should capture which fare family (branded fare) was quoted. This enables revenue analysis by brand tier. Standard N:1 relationship. No bidirectional conflict.',
    `fare_id` BIGINT COMMENT 'Foreign key linking to revenue.fare. Business justification: Pricing records are generated from fare definitions. A pricing_record represents a quote/calculation event based on a specific fare basis. The fare_basis_code attribute in pricing_record should refere',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Pricing quotes are generated from real-time flight inventory availability. Revenue management systems query specific flight inventory to calculate fares, apply booking class availability, and generate',
    `fare_quote_id` BIGINT COMMENT 'The native quote or pricing solution identifier assigned by the GDS (e.g., Sabre, Amadeus, Travelport) when the fare was priced through a GDS channel. Null for direct or NDC-sourced pricing. Used for GDS billing reconciliation.',
    `profile_id` BIGINT COMMENT 'Reference to the passenger profile for whom this fare was priced. Links the pricing event to the traveller identity in the Passenger domain.',
    `advance_purchase_days` STRING COMMENT 'Number of days before departure that the ticket must be purchased to qualify for this fare, as defined in the fare rules. Zero indicates no advance purchase requirement. Key yield management parameter.',
    `base_fare_amount` DECIMAL(18,2) COMMENT 'The net fare amount before taxes, fees, and surcharges, expressed in the pricing currency. Represents the airlines revenue component used for yield and RASK calculations. Part of the MONETARY_TRIPLET.',
    `booking_class` STRING COMMENT 'Single-letter Reservation Booking Designator (RBD) / inventory class in which the fare was priced (e.g., Y, B, M, Q, V). Determines seat availability consumption in the inventory system.. Valid values are `^[A-Z]{1}$`',
    `cabin_class` STRING COMMENT 'Physical cabin of service associated with the priced fare. Derived from the booking class mapping. Used for revenue reporting segmentation by cabin.. Valid values are `FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY`',
    `carrier_surcharge_amount` DECIMAL(18,2) COMMENT 'Total carrier-imposed surcharges (YQ fuel surcharge and YR carrier-imposed fees) applied to this fare. Distinct from government taxes; retained by the carrier. Critical for revenue accounting and BSP settlement reconciliation.',
    `changeable_flag` BOOLEAN COMMENT 'Indicates whether the priced fare permits voluntary changes (True) or is a no-change fare (False). If True, change fees and fare difference rules from the fare basis apply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing record was first persisted to the Silver Layer data store. Audit field for data lineage tracking. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the fare was originally priced (e.g., USD, EUR, GBP). Required for BSP settlement and multi-currency revenue accounting. Part of the MONETARY_TRIPLET.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the journey destination point used in the fare construction. Defines the end of the priced itinerary.. Valid values are `^[A-Z]{3}$`',
    `equivalent_fare_amount` DECIMAL(18,2) COMMENT 'Base fare amount converted to IATA Neutral Units of Construction (NUC) or the airlines reporting currency equivalent. Used for international fare construction, proration, and interline settlement where fares are built in NUC and converted via IATA Rate of Exchange (ROE).',
    `fare_basis_code` STRING COMMENT 'Primary IATA fare basis code applied to the priced itinerary (e.g., YLOWUS, QHXAP). Encodes the fare class, booking class, seasonality, advance purchase, and restriction conditions. For multi-segment itineraries, this represents the governing fare basis code.',
    `fare_type` STRING COMMENT 'Classification of the fare by its commercial nature. PUBLIC = filed public tariff fare; PRIVATE = unpublished/private fare; NEGOTIATED = corporate or agency negotiated rate; CORPORATE = corporate account fare; NET = net fare for consolidators; TOUR = inclusive tour fare. Impacts revenue accounting and BSP settlement.. Valid values are `PUBLIC|PRIVATE|NEGOTIATED|CORPORATE|NET|TOUR`',
    `form_of_payment_restriction` STRING COMMENT 'Any restriction on the form of payment permitted for this fare. NONE = no restriction; CREDIT_CARD_ONLY = must be paid by credit card; CASH_ONLY = cash payment required; SPECIFIC_CARD = restricted to a specific card type or issuer; MILES_ONLY = award redemption only. Impacts checkout and payment processing.. Valid values are `NONE|CREDIT_CARD_ONLY|CASH_ONLY|SPECIFIC_CARD|MILES_ONLY`',
    `iata_rate_of_exchange` DECIMAL(18,2) COMMENT 'The IATA-published Rate of Exchange (ROE) used to convert the NUC fare amount to the local pricing currency at the time of pricing. Required for international fare construction and interline proration under IATA Resolution 722.',
    `max_stay_requirement` STRING COMMENT 'Maximum stay condition attached to the fare rule (e.g., 1M for one month, 30D for 30 days). Null if no maximum stay applies. Constrains the return travel date for round-trip fares.',
    `min_stay_requirement` STRING COMMENT 'Minimum stay condition attached to the fare rule (e.g., SU for Sunday night stay, 3D for 3 days). Null if no minimum stay applies. Used for round-trip fare rule validation.',
    `ndc_offer_reference` STRING COMMENT 'Unique offer identifier assigned by the airlines NDC offer engine when the fare was priced via an IATA NDC-compliant channel. Null for GDS or legacy-sourced pricing. Enables NDC order management and settlement.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the journey origin point used in the fare construction. Defines the start of the priced itinerary.. Valid values are `^[A-Z]{3}$`',
    `passenger_type_code` STRING COMMENT 'IATA-standard Passenger Type Code (PTC) indicating the traveller category used for fare calculation. ADT = Adult; CHD = Child; INF = Infant; YTH = Youth; MIL = Military; SRC = Senior. Determines applicable fare rules and discount eligibility.. Valid values are `ADT|CHD|INF|YTH|MIL|SRC`',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric booking reference (PNR locator) in the Passenger Service System (PSS) to which this pricing record is associated. Links the fare quote to the reservation context.. Valid values are `^[A-Z0-9]{6}$`',
    `pricing_date` DATE COMMENT 'The calendar date on which the fare was priced. Used to determine applicable fare rules, advance purchase requirements, and seasonality. Distinct from the ticketing date and travel date.',
    `pricing_source` STRING COMMENT 'The distribution channel or system through which this fare was priced. GDS = Global Distribution System (e.g., Amadeus, Sabre, Travelport); DIRECT = airline direct website/app; NDC = IATA New Distribution Capability; API = third-party API; INTERLINE = interline agreement pricing; CODESHARE = codeshare partner pricing.. Valid values are `GDS|DIRECT|NDC|API|INTERLINE|CODESHARE`',
    `pricing_status` STRING COMMENT 'Current lifecycle state of the pricing record. QUOTED = fare quote generated but not yet ticketed; TICKETED = fare has been issued as an e-ticket; EXPIRED = ticketing time limit passed without issuance; CANCELLED = booking cancelled; REPRICED = superseded by a subsequent pricing event; VOIDED = ticket voided post-issuance.. Valid values are `QUOTED|TICKETED|EXPIRED|CANCELLED|REPRICED|VOIDED`',
    `pricing_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) when the pricing engine generated this fare quote or pricing calculation. Represents the principal business event time for this transaction. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `quote_reference` STRING COMMENT 'Externally-known unique identifier assigned by the pricing engine (Sabre AirVision) to this specific fare quote or pricing calculation event. Used for audit trail and repricing reconciliation.',
    `refundable_flag` BOOLEAN COMMENT 'Indicates whether the priced fare is refundable (True) or non-refundable (False) per the applicable fare rules. Critical for customer service, revenue protection, and DOT consumer protection compliance.',
    `return_date` DATE COMMENT 'The scheduled departure date of the return journey for round-trip fares. Null for one-way fares. Used for minimum/maximum stay rule validation in fare construction.',
    `routing_code` STRING COMMENT 'IATA routing code or routing number associated with the fare basis, specifying permitted intermediate points and carrier combinations for the priced itinerary. Governs which connecting points are allowed under the fare rules.',
    `segment_count` STRING COMMENT 'Total number of flight segments (individual flight legs) included in the priced itinerary. Used to identify direct vs. connecting itineraries and for proration calculations on multi-segment fares.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Aggregate of all government-imposed taxes applied to this fare (e.g., US Federal Excise Tax, PFC, international departure/arrival taxes). Collected on behalf of taxing authorities and remitted via BSP/ARC. Part of the MONETARY_TRIPLET.',
    `ticketing_time_limit` TIMESTAMP COMMENT 'The deadline by which the e-ticket must be issued to honour this fare quote. After this timestamp, the fare quote expires and the booking must be repriced. Critical for revenue management and seat inventory control.',
    `total_fare_amount` DECIMAL(18,2) COMMENT 'Total amount payable by the passenger: base fare + taxes + carrier surcharges. This is the amount displayed to the customer and collected at ticketing. Represents the net total in the MONETARY_TRIPLET. Compliant with DOT full-fare advertising rules.',
    `travel_date` DATE COMMENT 'The scheduled departure date of the first flight segment in the priced itinerary. Used for advance purchase rule validation, seasonality determination, and revenue period attribution.',
    `trip_type` STRING COMMENT 'Classification of the itinerary structure. OW = One-Way; RT = Round-Trip; OJ = Open-Jaw; CT = Circle Trip. Determines fare construction method and applicable fare rules under IATA Resolution 722.. Valid values are `OW|RT|OJ|CT`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this pricing record (e.g., status change from QUOTED to TICKETED, repricing event). Audit field for change tracking. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `validating_carrier_code` STRING COMMENT 'Two-character IATA airline designator of the validating carrier responsible for issuing the ticket and settling with BSP/ARC. May differ from the operating carrier on codeshare or interline itineraries.. Valid values are `^[A-Z0-9]{2}$`',
    CONSTRAINT pk_pricing_record PRIMARY KEY(`pricing_record_id`)
) COMMENT 'Transactional record of a fare quote or pricing calculation event generated by the pricing engine for a specific itinerary and passenger type combination. Captures the priced itinerary (origin, destination, routing, flight segments), total fare amount, tax breakdown, surcharges (YQ/YR fuel surcharge, carrier-imposed fees), passenger type code (ADT/CHD/INF), fare basis codes applied per segment, pricing date, ticketing time limit, form of payment restrictions, and pricing source (GDS, direct, NDC). Represents the SSOT for how a specific booking was priced before ticketing.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`tax_fee` (
    `tax_fee_id` BIGINT COMMENT 'Unique surrogate identifier for each tax or fee record in the reference master. Primary key for the tax_fee data product.',
    `tax_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_transaction. Business justification: Tax codes in revenue system must reconcile to tax transactions in finance for remittance, compliance, and audit. Required for tax authority reporting.',
    `airport_code` STRING COMMENT 'IATA three-letter airport code to which this tax or fee is specifically scoped (e.g., LHR for Heathrow Passenger Facility Charge). Null if the tax is not airport-specific. Used for airport-level charge applicability in the pricing engine.. Valid values are `^[A-Z]{3}$`',
    `applicability_scope` STRING COMMENT 'Indicates whether the tax or fee applies to domestic itineraries, international itineraries, or both. A key filter used by the pricing engine when constructing the tax breakdown for a ticket.. Valid values are `domestic|international|both`',
    `cabin_class_applicability` STRING COMMENT 'Specifies the cabin class to which this tax or fee applies: all (applies regardless of cabin), economy, premium_economy, business, first. Certain taxes (e.g., UK Air Passenger Duty Band B) vary by cabin class.. Valid values are `all|economy|premium_economy|business|first`',
    `calculation_method` STRING COMMENT 'Defines how the tax or fee amount is computed: flat_amount (fixed monetary amount per occurrence), ad_valorem_percent (percentage of the applicable fare or charge base), per_segment (charged once per flight segment), per_coupon (charged per ticket coupon), per_pax_per_direction (charged per passenger per direction of travel). Drives the pricing engine calculation logic.. Valid values are `flat_amount|ad_valorem_percent|per_segment|per_coupon|per_pax_per_direction`',
    `collecting_authority_name` STRING COMMENT 'Full legal name of the authority or entity to which the collected tax or fee must be remitted (e.g., Internal Revenue Service, Heathrow Airport Holdings, EUROCONTROL). Used in remittance instructions and regulatory filings.',
    `collecting_authority_type` STRING COMMENT 'Category of the entity legally mandated to collect and remit the tax or fee: government (national or sub-national tax authority), airport_operator (airport authority or concessionaire), carrier (airline collecting on behalf of itself), intergovernmental (body such as EUROCONTROL). Determines remittance workflow and BSP/ARC settlement routing.. Valid values are `government|airport_operator|carrier|intergovernmental`',
    `corsia_applicable` BOOLEAN COMMENT 'Indicates whether this tax or fee is related to or counts toward CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) compliance obligations (True) or is unrelated to carbon/environmental compliance (False).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax or fee record was first created in the revenue management reference master. Supports audit trail and data lineage requirements for the Silver Layer lakehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the tax or fee rate_amount is denominated (e.g., USD, GBP, EUR). Null or not applicable for ad_valorem_percent types where the rate is a dimensionless percentage.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code of the arrival country to which this tax or fee applies. Null if the tax applies globally or is not destination-country-specific. Used in conjunction with origin_country_code for bilateral tax rule matching.. Valid values are `^[A-Z]{2}$`',
    `effective_date` DATE COMMENT 'The calendar date from which this tax or fee rate and rules become effective and must be applied to new ticket issuances. Aligns with the IATA ticketing date convention for tax applicability.',
    `exempt_passenger_types` STRING COMMENT 'Comma-separated list of IATA Passenger Type Codes (PTCs) or categories that are legally exempt from this tax or fee (e.g., INF,DIP,GOV for infants, diplomatic, and government passengers). Null if no exemptions apply. Used by the pricing engine to suppress the tax for qualifying passengers.',
    `expiry_date` DATE COMMENT 'The calendar date after which this tax or fee record is no longer applicable to new ticket issuances. Null for open-ended taxes with no legislated sunset date. Enables the pricing engine to apply only currently valid tax rules.',
    `gds_display_code` STRING COMMENT 'The tax or fee code as it appears in GDS (Global Distribution System) displays and fare quote responses (e.g., Amadeus, Sabre, Travelport). May differ from the IATA tax_code in legacy GDS implementations. Used for GDS reconciliation and agency settlement.. Valid values are `^[A-Z0-9]{2,4}$`',
    `gl_account_code` STRING COMMENT 'The SAP S/4HANA general ledger account code to which collected amounts for this tax or fee are posted in the revenue accounting system. Ensures correct financial reporting and tax liability tracking on the balance sheet.',
    `iata_tax_category` STRING COMMENT 'IATA-defined category distinguishing the nature of the charge as published in the IATA Tax Code Directory: tax (government-mandated levy), fee (service-based charge), charge (airport or infrastructure charge), surcharge (carrier-imposed additional charge such as fuel surcharge YQ/YR).. Valid values are `tax|fee|charge|surcharge`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax or fee record was most recently modified in the revenue management reference master. Used for incremental data pipeline processing and change data capture in the Databricks Silver Layer.',
    `maximum_amount` DECIMAL(18,2) COMMENT 'The maximum monetary amount of the tax or fee that may be collected, capping the calculated value. Applicable to ad_valorem_percent taxes with a legislated ceiling. Denominated in currency_code. Null if no cap applies.',
    `minimum_amount` DECIMAL(18,2) COMMENT 'The minimum monetary amount of the tax or fee that must be collected, regardless of the calculated value. Applicable primarily to ad_valorem_percent taxes where the computed amount could fall below a legislated floor. Denominated in currency_code.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code of the departure country to which this tax or fee applies. Null if the tax applies globally or is not origin-country-specific. Used by the pricing engine for route-specific tax applicability filtering.. Valid values are `^[A-Z]{2}$`',
    `passenger_type_applicability` STRING COMMENT 'Specifies which IATA passenger type codes (PTCs) are subject to this tax or fee: all (applies to every passenger type), adult, child, infant, unaccompanied_minor. Certain taxes (e.g., UK APD) have reduced or zero rates for infants.. Valid values are `all|adult|child|infant|unaccompanied_minor`',
    `published_date` DATE COMMENT 'The date on which the collecting authority officially published or announced this tax or fee rate or rule change. Distinct from effective_date; used for advance notice compliance tracking and pricing team workflow management.',
    `rate_amount` DECIMAL(18,2) COMMENT 'The monetary amount or percentage rate of the tax or fee. For flat_amount and per-segment/per-coupon types, this is the fixed charge value. For ad_valorem_percent, this is the percentage rate (e.g., 7.5 for 7.5%). Interpreted in conjunction with calculation_method.',
    `refundable` BOOLEAN COMMENT 'Indicates whether this tax or fee is refundable to the passenger upon ticket cancellation or refund (True) or is non-refundable (False). Drives the refund calculation logic in the Passenger Service System and revenue accounting.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific legislation, regulation, or IATA resolution that mandates or authorizes this tax or fee (e.g., US Internal Revenue Code Section 4261, UK Finance Act 1994 Section 28, IATA Resolution 728). Supports regulatory compliance documentation and audit.',
    `remittance_channel` STRING COMMENT 'The settlement channel through which collected tax amounts are remitted: bsp (IATA Billing and Settlement Plan), arc (Airlines Reporting Corporation), direct_to_authority (direct payment to government or airport), interline_settlement (via interline billing agreement). Drives the revenue accounting remittance workflow.. Valid values are `bsp|arc|direct_to_authority|interline_settlement`',
    `remittance_destination_code` STRING COMMENT 'Standardized code identifying the remittance destination account or clearing body (e.g., BSP country code, ARC settlement code, or government tax authority reference). Used by revenue accounting to route tax remittance payments correctly.. Valid values are `^[A-Z0-9]{2,10}$`',
    `route_specific` BOOLEAN COMMENT 'Indicates whether this tax or fee is applicable only to specific origin-destination route pairs (True) or applies broadly based on country/airport-level rules (False). When True, origin_country_code, destination_country_code, and/or airport_code fields define the specific applicability.',
    `sap_tax_code` STRING COMMENT 'The corresponding tax code as configured in SAP S/4HANA FI/CO module for general ledger posting and tax remittance processing. Enables automated mapping between the IATA tax_code and the SAP financial accounting tax configuration for revenue accounting.. Valid values are `^[A-Z0-9]{1,4}$`',
    `superseded_by_tax_code` STRING COMMENT 'The IATA tax code of the successor record when this tax or fee has been superseded (status = superseded). Enables the pricing engine and revenue accounting to trace the lineage of tax code changes and apply the correct current code.. Valid values are `^[A-Z0-9]{2,4}$`',
    `tax_basis` STRING COMMENT 'The fare component or amount upon which an ad_valorem_percent tax is calculated: base_fare (net fare excluding taxes), total_fare (gross fare including other charges), fuel_surcharge (applied only to the YQ/YR surcharge component), carrier_imposed_fee, ticket_price. Relevant only for ad_valorem_percent calculation_method.. Valid values are `base_fare|total_fare|fuel_surcharge|carrier_imposed_fee|ticket_price`',
    `tax_code` STRING COMMENT 'IATA-standard two-to-four character alphanumeric code uniquely identifying the tax or fee (e.g., US, YQ, YR, GB, DE). Used by pricing engines, GDS, and BSP settlement to identify and apply the correct charge on a ticket.. Valid values are `^[A-Z0-9]{2,4}$`',
    `tax_fee_status` STRING COMMENT 'Lifecycle status of the tax or fee record: active (currently in force and applicable), inactive (no longer applicable), superseded (replaced by a newer version of the same tax code), pending (approved but not yet effective). Controls whether the pricing engine includes this record in tax calculations.. Valid values are `active|inactive|superseded|pending`',
    `tax_name` STRING COMMENT 'Full descriptive name of the tax or fee as published by the collecting authority (e.g., US Federal Excise Tax, UK Air Passenger Duty, Airport Passenger Facility Charge). Displayed on passenger itineraries and tax remittance reports.',
    `tax_type` STRING COMMENT 'High-level classification of the charge: government_tax (legislated by a national or regional authority), airport_charge (levied by an airport operator), carrier_surcharge (carrier-imposed fee such as fuel or insurance surcharge), security_fee (security-related government levy), passenger_facility_charge (PFC levied by US airports under FAA authority), environmental_levy (carbon or environmental charge such as CORSIA). [ENUM-REF-CANDIDATE: government_tax|airport_charge|carrier_surcharge|security_fee|passenger_facility_charge|environmental_levy|other — promote to reference product]. Valid values are `government_tax|airport_charge|carrier_surcharge|security_fee|passenger_facility_charge|environmental_levy`',
    `ticket_type_applicability` STRING COMMENT 'Specifies the ticket document type to which this tax or fee applies: all, e_ticket (electronic ticket), paper_ticket, emd (Electronic Miscellaneous Document). Most modern taxes apply to all ticket types, but some legacy charges are document-type-specific.. Valid values are `all|e_ticket|paper_ticket|emd`',
    `version_number` STRING COMMENT 'Sequential version number of this tax or fee record, incremented each time the rate, rules, or applicability conditions are updated by the collecting authority. Enables historical rate tracking and audit trail for tax remittance reconciliation.',
    `waivable` BOOLEAN COMMENT 'Indicates whether the carrier has authority to waive this tax or fee under specific circumstances (True) or whether collection is legally mandatory and cannot be waived (False). Relevant for IROP (Irregular Operations) handling and diplomatic/government fare exemptions.',
    CONSTRAINT pk_tax_fee PRIMARY KEY(`tax_fee_id`)
) COMMENT 'Reference master for all government-mandated taxes, carrier-imposed fees, and airport charges applicable to air tickets. Defines tax/fee code (IATA standard tax codes), tax name, collecting authority (government, airport, carrier), tax type (ad valorem percentage, flat amount, per-segment), currency, applicability rules (domestic/international, route-specific, passenger type), effective and expiry dates, and remittance destination. Used by pricing engines to construct the full ticket price breakdown and by revenue accounting for tax remittance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`yield_parameter` (
    `yield_parameter_id` BIGINT COMMENT 'Unique surrogate identifier for the yield management parameter configuration record. Primary key for this entity.',
    `bid_price_curve_id` BIGINT COMMENT 'Reference identifier for the bid price curve configuration applied to this yield parameter set. The bid price curve defines the minimum acceptable revenue threshold per seat at each inventory level.',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Yield management parameters can be configured at the fare family level (branded fare optimization). This links yield management settings to the fare family being optimized. Standard N:1 relationship. ',
    `fare_id` BIGINT COMMENT 'Foreign key linking to revenue.fare. Business justification: Yield parameters define revenue management optimization settings (RASK targets, load factor targets, overbooking rates, bid price curves) that are configured FOR specific fare contexts. The yield_para',
    `approved_by` STRING COMMENT 'Name or employee identifier of the Revenue Manager who authorized this yield parameter configuration for production use. Supports audit trail and governance accountability.',
    `booking_class_threshold_count` STRING COMMENT 'Number of booking class availability thresholds (authorization levels) configured for this yield parameter set. Defines how many fare class buckets are actively managed by the RM optimization engine.',
    `cabin_class` STRING COMMENT 'Aircraft cabin class to which this yield parameter configuration applies. Null when the parameter applies across all cabins on the market or route.. Valid values are `first|business|premium_economy|economy`',
    `cancellation_rate` DECIMAL(18,2) COMMENT 'Historical booking cancellation rate (0.0000–1.0000) for this market or route, used alongside no-show rate to calibrate overbooking levels and availability controls.',
    `cask_benchmark` DECIMAL(18,2) COMMENT 'Cost per Available Seat Kilometer (CASK) benchmark in the operating currency used as the cost floor reference for yield optimization decisions. Sourced from SAP S/4HANA FI/CO cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this yield parameter configuration record was first created in the system. Supports audit trail and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary yield parameters (RASK target, CASK benchmark, yield floor, pricing bounds) are expressed for this configuration.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination point of the market or route to which this yield parameter applies. Null for global or flight-group-level parameters.. Valid values are `^[A-Z]{3}$`',
    `dilution_tolerance` DECIMAL(18,2) COMMENT 'Maximum acceptable revenue dilution rate — the percentage of passengers who could have paid a higher fare but were sold a lower fare class. Constrains how aggressively lower booking classes are opened.',
    `dynamic_pricing_ceiling` DECIMAL(18,2) COMMENT 'Maximum fare amount (in operating currency) above which the dynamic pricing engine is not permitted to set a fare for this market or route. Prevents consumer protection violations and brand damage.',
    `dynamic_pricing_enabled` BOOLEAN COMMENT 'Indicates whether dynamic (continuous) pricing is enabled for this yield parameter configuration. When true, the RM engine applies real-time fare adjustments within authorized bounds rather than discrete fare class steps.',
    `dynamic_pricing_floor` DECIMAL(18,2) COMMENT 'Minimum fare amount (in operating currency) below which the dynamic pricing engine is not permitted to set a fare for this market or route. Protects against revenue dilution under automated pricing.',
    `effective_from` DATE COMMENT 'Calendar date from which this yield parameter configuration becomes active and is applied by the RM optimization engine. Aligns with schedule season or pricing period start.',
    `effective_until` DATE COMMENT 'Calendar date on which this yield parameter configuration expires and is no longer applied. Null for open-ended configurations. Aligns with schedule season or pricing period end.',
    `forecast_horizon_days` STRING COMMENT 'Number of days ahead for which the demand forecast is generated and applied in yield optimization. Defines the planning window for booking class availability controls.',
    `forecast_model_type` STRING COMMENT 'Type of demand forecasting model applied by the RM optimization engine for this parameter set. Determines how historical booking curves and pickup patterns are weighted in availability decisions.. Valid values are `additive|multiplicative|hybrid|neural_network|pickup`',
    `group_booking_threshold` STRING COMMENT 'Minimum number of passengers (Pax) that qualifies a booking as a group booking, triggering separate group inventory controls and pricing rules distinct from individual seat availability management.',
    `historical_weight` DECIMAL(18,2) COMMENT 'Weighting factor (0.0000–1.0000) applied to historical booking data in the blended demand forecast model. Higher values favor historical patterns; lower values favor recent pickup trends. Must sum to 1.0 with pickup_weight.',
    `last_reviewed_date` DATE COMMENT 'Date on which this yield parameter configuration was most recently reviewed by the Revenue Management team. Supports governance tracking and parameter staleness detection.',
    `load_factor_minimum` DECIMAL(18,2) COMMENT 'Minimum acceptable load factor threshold below which the RM system triggers promotional availability or fare class opening actions. Expressed as a percentage (0.00–100.00).',
    `load_factor_target` DECIMAL(18,2) COMMENT 'Target load factor (percentage of available seats filled with revenue passengers) for this market or route configuration. Expressed as a percentage (0.00–100.00). Balances spoilage risk against dilution risk in RM optimization.',
    `minimum_yield_floor` DECIMAL(18,2) COMMENT 'Minimum acceptable yield (revenue per Revenue Passenger Kilometer) below which seat inventory must not be sold. Acts as the absolute revenue protection floor in bid price calculations. Expressed in operating currency per RPK.',
    `no_show_rate` DECIMAL(18,2) COMMENT 'Historical no-show rate (0.0000–1.0000) for this market or route, used as an input to overbooking authorization calculations. Sourced from Amadeus Altéa PSS departure control data.',
    `od_control_enabled` BOOLEAN COMMENT 'Indicates whether origin-destination (O&D) network revenue management control is active for this parameter set. When true, the RM engine optimizes across connecting itineraries rather than leg-by-leg.',
    `optimization_method` STRING COMMENT 'Optimization algorithm applied by Sabre AirVision for seat inventory allocation under this parameter set. EMSR-A and EMSR-B are Expected Marginal Seat Revenue variants; LP-based and network bid price methods support O&D (origin-destination) optimization.. Valid values are `emsr_a|emsr_b|lp_based|network_bid_price|hybrid`',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the origin point of the market or route to which this yield parameter applies. Null for global or flight-group-level parameters.. Valid values are `^[A-Z]{3}$`',
    `overbooking_authorization_rate` DECIMAL(18,2) COMMENT 'Authorized overbooking percentage above physical seat capacity for this market or route. Expressed as a percentage above 100% (e.g., 5.00 means 5% above capacity). Governed by DOT consumer protection regulations and airline denied boarding policy.',
    `parameter_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this yield parameter configuration within Sabre AirVision RM. Used for cross-system reference and audit trails.. Valid values are `^[A-Z0-9_]{3,30}$`',
    `parameter_description` STRING COMMENT 'Free-text description providing business context for this yield parameter configuration, including rationale for non-standard settings, market conditions, or special events driving the configuration.',
    `parameter_name` STRING COMMENT 'Human-readable name describing the yield parameter configuration, e.g., TRANSATLANTIC_PEAK_SUMMER_2025. Used for display and reporting in revenue management dashboards.',
    `parameter_status` STRING COMMENT 'Current lifecycle state of the yield parameter configuration record. Active records are applied by the RM optimization engine; draft records are under review; archived records are retained for historical analysis.. Valid values are `active|inactive|draft|archived|pending_review`',
    `parameter_type` STRING COMMENT 'Categorizes the scope at which this yield parameter applies: market-level, route-level, flight-group-level, cabin-level, or global default. Determines the optimization hierarchy in Sabre AirVision.. Valid values are `market|route|flight_group|cabin|global`',
    `pickup_weight` DECIMAL(18,2) COMMENT 'Weighting factor (0.0000–1.0000) applied to recent booking pickup trend data in the blended demand forecast model. Complements historical_weight; both must sum to 1.0.',
    `rask_target` DECIMAL(18,2) COMMENT 'Target Revenue per Available Seat Kilometer (RASK) in the operating currency for this market or route configuration. Expressed as revenue per ASK. Used as the primary revenue performance benchmark in RM optimization.',
    `review_frequency` STRING COMMENT 'Scheduled frequency at which the Revenue Management team reviews and potentially updates this yield parameter configuration. Drives the RM governance and parameter maintenance workflow.. Valid values are `daily|weekly|bi_weekly|monthly|seasonal`',
    `season_code` STRING COMMENT 'IATA scheduling season code (e.g., S25 for Summer 2025, W25 for Winter 2025/26) during which this yield parameter is operative. Supports seasonal revenue management cycle alignment.. Valid values are `^(S|W)[0-9]{2}$`',
    `spoilage_tolerance` DECIMAL(18,2) COMMENT 'Maximum acceptable seat spoilage rate (percentage of seats departing empty) tolerated before the RM system adjusts availability controls to open lower fare classes. Expressed as a percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this yield parameter configuration record was most recently modified. Used for change detection, incremental processing, and audit trail in the Databricks Silver Layer.',
    CONSTRAINT pk_yield_parameter PRIMARY KEY(`yield_parameter_id`)
) COMMENT 'Revenue management configuration record defining yield management parameters and optimization settings for a specific market, route, or flight group. Stores bid price curves, booking class availability thresholds, load factor targets, revenue per available seat kilometer (RASK) targets, cost per available seat kilometer (CASK) benchmarks, minimum acceptable yield floors, overbooking authorization levels, spoilage and dilution tolerance settings, and forecast model weights. Owned by the Revenue Management team and aligned with Sabre AirVision RM optimization modules.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`ticket` (
    `ticket_id` BIGINT COMMENT 'Primary key for ticket',
    `agency_id` BIGINT COMMENT 'Foreign key linking to revenue.agency. Business justification: Tickets sold through travel agencies should reference the agency master. This enables agency performance tracking and commission calculation. Standard N:1 relationship. No bidirectional conflict.',
    `bsp_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.bsp_settlement. Business justification: Tickets sold through BSP channels are included in BSP settlement batches. The ticket should reference which BSP settlement batch it was included in. This is a temporal FK (populated during billing cyc',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Core revenue attribution requirement - airlines must link actual ticket sales to originating marketing campaigns for ROAS calculation, campaign performance measurement, and marketing budget optimizati',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every ticket is issued by a legal entity (company code) for IFRS 15 revenue recognition, consolidated financial reporting, and regulatory compliance. Essential for multi-entity airline groups.',
    `corporate_contract_id` BIGINT COMMENT 'Foreign key linking to revenue.corporate_contract. Business justification: Tickets can be issued under corporate contracts. This links the ticket to the negotiated contract terms. Standard N:1 relationship. No bidirectional conflict.',
    `fare_class_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_class. Business justification: Tickets have a booking_class attribute that should reference the authoritative fare_class master. Standard N:1 relationship. No bidirectional conflict. booking_class remains as denormalized lookup.',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Tickets are issued under branded fare families (Basic Economy, Main Cabin, Premium, etc.). While fare_family_id already exists in ndc_offer_order, traditional tickets should also reference the fare fa',
    `fare_id` BIGINT COMMENT 'Foreign key linking to revenue.fare. Business justification: Tickets are issued based on a specific fare. The fare_basis_code in ticket should reference the authoritative fare master record. This establishes which published/private fare was used for the ticket ',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Tickets must track FFP member for mileage accrual posting, tier recognition, and revenue attribution. Core operational link between revenue capture and loyalty program. Replaces denormalized ffp_membe',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Tracks crew member who manually issued ticket at airport counter/service desk. Required for crew sales performance tracking, commission calculation for crew-issued tickets, and audit trail. Existing i',
    `profile_id` BIGINT COMMENT 'Reference to the passenger master record associated with this ticket. Links the ticket to the travellers profile for loyalty, reporting, and personalisation. PARTY_REFERENCE category.',
    `pnr_id` BIGINT COMMENT 'FK to reservation.pnr.pnr_id — Tickets are issued against PNR bookings. This link enables revenue-to-booking traceability for refund processing, exchange handling, and revenue recognition against booking context.',
    `pricing_record_id` BIGINT COMMENT 'Foreign key linking to revenue.pricing_record. Business justification: Tickets are issued based on a pricing calculation event. The pricing_record captures the quote/calculation that led to the ticket issuance. This establishes the audit trail from ticket back to the pri',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Tickets are issued for travel on specific routes; route determines applicable fare rules, bilateral agreements, traffic rights, and revenue recognition treatment. Critical for revenue accounting, inte',
    `base_fare_amount` DECIMAL(18,2) COMMENT 'The published or negotiated base fare amount before taxes, fees, and surcharges, expressed in the tickets fare currency. Core component of the MONETARY_TRIPLET. Used for yield calculation (revenue per RPK), RASK, and BSP/ARC settlement.',
    `booking_class` STRING COMMENT 'Single-letter Reservation Booking Designator (RBD) representing the inventory class in which the ticket was booked (e.g., Y, B, M, Q, V). Determines the fare level, upgrade eligibility, and frequent flyer mileage accrual. Aligns with inventory bucket management.. Valid values are `^[A-Z]{1}$`',
    `cabin_class` STRING COMMENT 'The physical cabin of service for which the ticket was issued. F=First, C=Business, W=Premium Economy, Y=Economy. Used for revenue segmentation, load factor analysis, and RASK reporting.. Valid values are `F|C|W|Y`',
    `conjunction_ticket_indicator` BOOLEAN COMMENT 'Flag indicating whether this ticket is part of a conjunction ticket set (multiple ticket documents covering a single itinerary exceeding 4 coupons). True = conjunction ticket; False = standalone ticket. Required for correct coupon sequencing and BSP settlement.',
    `conjunction_ticket_number` STRING COMMENT 'The 13-digit ticket number of the related conjunction ticket document in the same set. Populated only when conjunction_ticket_indicator is True. Enables full itinerary reconstruction across multiple ticket documents.. Valid values are `^[0-9]{13}$`',
    `coupon_count` STRING COMMENT 'Number of flight coupons (individual flight segments) contained within this ticket document. Standard tickets carry 1–4 coupons. Used for itinerary completeness validation and conjunction ticket detection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ticket record was first ingested into the lakehouse silver layer. Distinct from issue_timestamp which reflects the real-world ticketing event. Used for data lineage and audit. RECORD_AUDIT_CREATED category.',
    `destination_airport_code` STRING COMMENT 'IATA three-letter airport code of the ticketed journeys final destination. Combined with origin forms the O&D (Origin and Destination) pair for yield management and revenue accounting.. Valid values are `^[A-Z]{3}$`',
    `endorsement_restriction_text` STRING COMMENT 'Free-text endorsement and restriction field printed on the ticket indicating fare conditions such as NON-ENDORSE/NON-REROUTE, VALID ON XX ONLY, or interline restrictions. Governs reissue, refund, and exchange eligibility.',
    `fare_basis_code` STRING COMMENT 'The alphanumeric fare basis code identifying the specific fare product applied to this ticket (e.g., YLOWUS, BAPUS30). Encodes the booking class, fare family, restrictions, and seasonality. Drives revenue accounting, yield analysis, and RASK/RPK reporting in Sabre AirVision.. Valid values are `^[A-Z0-9]{1,10}$`',
    `fare_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the ticket fare amounts (base, tax, total, net remit) are denominated. Required for multi-currency BSP settlement and FX conversion in revenue accounting.. Valid values are `^[A-Z]{3}$`',
    `fare_type` STRING COMMENT 'Classification of the fare applied to the ticket. PUB=Published/ATPCO filed fare, NEG=Negotiated/corporate fare, NET=Net/bulk fare, GOV=Government fare, FFP=Frequent Flyer award ticket, GRP=Group fare. Drives revenue accounting treatment and yield analysis in Sabre AirVision. [ENUM-REF-CANDIDATE: PUB|NEG|NET|GOV|FFP|GRP|EMD — promote to reference product]. Valid values are `PUB|NEG|NET|GOV|FFP|GRP`',
    `ffp_miles_earned` STRING COMMENT 'Number of frequent flyer miles/points accrued on this ticket based on the fare basis, booking class, and FFP tier. Zero for award tickets (fare_type=FFP) or non-accruing fares. Feeds Oracle Loyalty Cloud for member account crediting.',
    `form_of_payment_detail` STRING COMMENT 'Masked payment instrument detail, e.g., last 4 digits of credit card number with card type prefix (VISA****1234) or bank reference. Stored in masked/tokenised form per PCI DSS. Used for settlement reconciliation and chargeback management.',
    `form_of_payment_type` STRING COMMENT 'Code indicating the payment instrument used to purchase the ticket. CC=Credit Card, CA=Cash, CK=Check, TP=Tour Order/Prepaid, MS=Miscellaneous, EP=Electronic Payment/EMD. Drives BSP/ARC settlement routing and fraud monitoring. [ENUM-REF-CANDIDATE: CC|CA|CK|TP|MS|EP|GV|LO — promote to reference product]. Valid values are `CC|CA|CK|TP|MS|EP`',
    `issue_timestamp` TIMESTAMP COMMENT 'The exact date and time (UTC) at which the e-ticket was issued by the ticketing system. Serves as the principal business event timestamp for the ticket transaction lifecycle. Used in BSP/ARC reporting periods and revenue recognition. BUSINESS_EVENT_TIMESTAMP category.',
    `net_remit_amount` DECIMAL(18,2) COMMENT 'The net amount remitted to the airline after deducting agency commission and applicable incentives from the total fare. Used in BSP/ARC settlement reconciliation and airline revenue accounting in SAP S/4HANA FI.',
    `origin_airport_code` STRING COMMENT 'IATA three-letter airport code of the ticketed journeys origin point. Used for route revenue analysis, OTP reporting, and regulatory filings.. Valid values are `^[A-Z]{3}$`',
    `original_ticket_number` STRING COMMENT 'The 13-digit IATA ticket number of the original ticket when this record represents a reissued or exchanged ticket. Null for original issuances. Enables exchange chain tracing for revenue accounting and DOT consumer protection reporting.. Valid values are `^[0-9]{13}$`',
    `passenger_name` STRING COMMENT 'Full name of the ticketed passenger as printed on the ticket, in IATA PNR name format (SURNAME/FIRSTNAME TITLE). Stored on the ticket for check-in, boarding, and regulatory compliance. PII — restricted.',
    `passenger_type_code` STRING COMMENT 'IATA Passenger Type Code classifying the traveller category for fare eligibility and pricing. ADT=Adult, CHD=Child, INF=Infant (no seat), INS=Infant with seat, UNN=Unaccompanied Minor, MIL=Military, SRC=Senior Citizen. Drives fare rule application and tax calculation. [ENUM-REF-CANDIDATE: ADT|CHD|INF|INS|UNN|MIL|SRC — promote to reference product]',
    `pnr_locator` STRING COMMENT 'The 6-character alphanumeric GDS booking reference (PNR locator) associated with this ticket. Links the issued ticket back to the originating reservation in Amadeus Altéa or the GDS. Essential for IROP handling, reprotection, and customer service.. Valid values are `^[A-Z0-9]{6}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary amount refunded to the passenger when ticket_status is refunded. May be less than total_fare_amount due to cancellation penalties or non-refundable fare components. Used for revenue accounting and DOT refund compliance reporting.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when a refund was processed for this ticket. Null for non-refunded tickets. Used for DOT consumer protection reporting (14 CFR Part 250), revenue reversal accounting, and refund SLA monitoring.',
    `sale_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country in which the ticket was sold. Determines applicable taxes, consumer protection regulations (DOT, EASA), and BSP/ARC settlement jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `sales_channel` STRING COMMENT 'Distribution channel through which the ticket was sold. GDS=Global Distribution System (Amadeus/Sabre/Travelport), DIRECT_WEB=airline.com, MOBILE=airline mobile app, AIRPORT=airport ticket office, CALL_CENTER=reservations centre, NDC=IATA New Distribution Capability, INTERLINE=interline agreement. Used for distribution cost analysis and channel revenue attribution. [ENUM-REF-CANDIDATE: GDS|DIRECT_WEB|MOBILE|AIRPORT|CALL_CENTER|NDC|INTERLINE|OTA — promote to reference product]',
    `tax_total_amount` DECIMAL(18,2) COMMENT 'Aggregate of all government taxes, airport fees, and surcharges (e.g., PFC, September 11th Security Fee, fuel surcharge YQ/YR) applied to the ticket. Part of the MONETARY_TRIPLET adjustment component. Detailed tax breakdown is stored at coupon level.',
    `ticket_number` STRING COMMENT 'The globally unique 13-digit IATA-format ticket number comprising the 3-digit airline numeric code, a 10-digit serial number, and a check digit. This is the primary external business identifier for the issued e-ticket, used in BSP/ARC settlement, GDS lookups, and passenger check-in. BUSINESS_IDENTIFIER category.. Valid values are `^[0-9]{13}$`',
    `ticket_status` STRING COMMENT 'Current state of the e-ticket in its lifecycle. open = issued and valid for travel; used = all coupons flown; refunded = fare returned to passenger; voided = cancelled within BSP/ARC void window; exchanged = reissued against a new ticket; lifted = coupon checked in and boarded. LIFECYCLE_STATUS category.. Valid values are `open|used|refunded|voided|exchanged|lifted`',
    `total_fare_amount` DECIMAL(18,2) COMMENT 'Total amount charged to the passenger including base fare, taxes, and all fees. Equals base_fare_amount + tax_total_amount. MONETARY_TRIPLET net total. Used for BSP/ARC settlement, revenue recognition, and passenger receipt.',
    `tour_code` STRING COMMENT 'Alphanumeric tour code printed on the ticket, used to identify negotiated/net fares, bulk fares, or tour operator contracts. Required for BSP/ARC net remit reporting and commission audit. Blank for published fares.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this ticket record in the lakehouse silver layer, capturing status changes, reissues, or corrections. RECORD_AUDIT_UPDATED category.',
    `void_timestamp` TIMESTAMP COMMENT 'Date and time when the ticket was voided within the BSP/ARC void window (typically same-day or T+1). Null for non-voided tickets. Required for BSP/ARC void transaction reporting and revenue reversal in SAP S/4HANA.',
    CONSTRAINT pk_ticket PRIMARY KEY(`ticket_id`)
) COMMENT 'Electronic ticket (e-ticket) master record representing the issued travel document for a passenger. Stores ticket number (13-digit IATA format), issuing carrier code, issuing office/IATA location identifier, ticket issue date and time, passenger name, passenger type code, form of payment, total fare amount, tax total, net remit amount, ticket status (open/used/refunded/voided/exchanged/lifted), conjunction ticket indicator, tour code, endorsement/restriction text, original ticket number (for exchanges), and BSP/ARC reporting indicator. SSOT for issued ticket lifecycle.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`ticket_coupon` (
    `ticket_coupon_id` BIGINT COMMENT 'Primary key for ticket_coupon',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Ticket coupons represent flown segments; airlines must track which aircraft operated each coupon for revenue allocation to specific assets, aircraft-level RASK/CASK analysis, and lease cost recovery c',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Flight-leg level revenue attribution to campaigns enables route-specific and O&D-specific campaign performance analysis. Airlines analyze which campaigns drive bookings on specific routes for targeted',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each coupon represents revenue recognized by a specific legal entity. Required for consolidated financial statements and intercompany eliminations in multi-entity airline operations.',
    `consumer_protection_case_id` BIGINT COMMENT 'Foreign key linking to compliance.consumer_protection_case. Business justification: Consumer protection cases (EC261 delay compensation, DOT denied boarding) are triggered by specific flight coupons. Regulatory reporting requires coupon-level tracking to calculate compensation thresh',
    `fare_class_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_class. Business justification: Each coupon has a booking_class attribute (RBD code). This should reference the authoritative fare_class master which defines the RBD hierarchy and yield management rules. Standard N:1 relationship. N',
    `fare_id` BIGINT COMMENT 'Foreign key linking to revenue.fare. Business justification: Each flight coupon within a ticket can have its own fare basis (especially for multi-segment journeys with different fare components). The fare_basis_code in ticket_coupon should reference the authori',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Each ticket coupon is issued against a specific flight inventory allocation, consuming a seat from the booking class bucket. Critical for inventory deduction, lift reporting, and reconciling sold vs. ',
    `flight_leg_id` BIGINT COMMENT 'Reference to the operating flight record for which this coupon is valid, linking to the flight operations domain for schedule and OTP data.',
    `fuel_uplift_order_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_uplift_order. Business justification: Airlines allocate actual fuel costs to flown segments for segment-level profitability analysis and revenue accounting. Each ticket coupon represents a passenger on a specific flight leg that consumed ',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Ticket coupons require origin station linkage for revenue accounting, interline settlement proration, station P&L reporting, and BSP/ARC reconciliation. Origin_airport_code is denormalized station ref',
    `profile_id` BIGINT COMMENT 'Reference to the passenger record associated with this coupon, enabling coupon-level revenue attribution to an individual traveller.',
    `pnr_id` BIGINT COMMENT 'Reference to the Passenger Name Record (PNR) associated with this coupon, linking the coupon to the originating reservation in the Amadeus Altéa Passenger Service System (PSS).',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Each coupon represents a flight segment on a specific route; essential for revenue allocation, prorate calculations between carriers, interline settlement, and route-level revenue performance analysis',
    `ticket_id` BIGINT COMMENT 'Reference to the parent e-ticket record to which this coupon belongs. Each e-ticket may contain up to four flight coupons (one per segment).',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Airlines track which maintenance work orders caused flight disruptions affecting specific ticket coupons for passenger compensation claims, revenue impact analysis, and operational performance reporti',
    `actual_departure_date` DATE COMMENT 'Actual calendar date on which the passenger departed on this coupon segment. May differ from scheduled departure date due to IROP (Irregular Operations), reprotection, or voluntary rebooking. Used for revenue recognition and OTP reporting.',
    `baggage_allowance` STRING COMMENT 'Free checked baggage allowance associated with this coupon, expressed either as piece concept (e.g., 2PC) or weight concept (e.g., 23KG) per IATA Resolution 302. Drives ancillary revenue opportunity identification and customer service.. Valid values are `^[0-9]{1,2}(PC|KG)$`',
    `booking_class` STRING COMMENT 'Single-letter Reservation Booking Designator (RBD) representing the fare class inventory bucket in which the seat was booked (e.g., Y, B, M, Q, V). Drives yield management, load factor analysis, and revenue accounting. Aligns with Sabre AirVision inventory buckets.. Valid values are `^[A-Z]{1}$`',
    `cabin_class` STRING COMMENT 'IATA cabin class code indicating the physical cabin in which the passenger travels: F=First, C=Business, W=Premium Economy, Y=Economy. Drives revenue segmentation, RASK analysis, and yield reporting.. Valid values are `F|C|W|Y`',
    `coupon_number` STRING COMMENT 'Sequential coupon number within the e-ticket (1 through 4), indicating the position of this flight segment in the itinerary. IATA mandates a maximum of four coupons per ticket.',
    `coupon_status` STRING COMMENT 'Current lifecycle status of the flight coupon per IATA coupon status codes: O=Open for use, A=Airport control (lifted), F=Flown/used, R=Refunded, V=Voided, S=Suspended, E=Exchanged, L=Lifted/boarded. SSOT for coupon-level revenue recognition and BSP/ARC coupon reporting. [ENUM-REF-CANDIDATE: O|A|F|R|V|S|E|L — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone offset) at which this coupon record was first created in the source Passenger Service System (Amadeus Altéa). Used for audit trail and data lineage in the silver layer.',
    `departure_date` DATE COMMENT 'Scheduled calendar date of departure for this coupon segment as printed on the ticket (yyyy-MM-dd). Used for validity checking, revenue period allocation, and BSP/ARC settlement date matching.',
    `destination_airport_code` STRING COMMENT 'IATA 3-letter airport code for the arrival point of this coupon segment (e.g., CDG, SIN). Used for route-level revenue analysis and O&D (origin-destination) yield management.. Valid values are `^[A-Z]{3}$`',
    `exchange_ticket_number` STRING COMMENT '13-digit ticket number of the original e-ticket that was exchanged to produce this coupon. Populated when coupon_status is E (Exchanged). Required for BSP/ARC exchange transaction reporting and revenue accounting audit trail.. Valid values are `^[0-9]{13}$`',
    `fare_amount` DECIMAL(18,2) COMMENT 'Base fare amount allocated to this individual coupon segment in the ticket currency, before taxes and surcharges. Used for coupon-level revenue recognition, BSP/ARC settlement, and yield (revenue per RPK) calculation.',
    `fare_basis_code` STRING COMMENT 'Alphanumeric code (up to 15 characters) identifying the specific fare rule set applied to this coupon, encoding cabin, booking class, seasonality, advance purchase, and restrictions (e.g., YLOWUS, QAPEX14). SSOT for fare rule application and revenue accounting.. Valid values are `^[A-Z0-9]{1,15}$`',
    `fare_construction_indicator` STRING COMMENT 'Indicates the fare construction method applied to this coupon: NUC=Neutral Unit of Construction (IATA proration), SITI=Sold Inside/Ticketed Inside, SOTO=Sold Outside/Ticketed Outside, SITO=Sold Inside/Ticketed Outside, SOTI=Sold Outside/Ticketed Inside. Governs BSP settlement currency conversion rules.. Valid values are `NUC|SITI|SOTO|SITO|SOTI`',
    `fare_currency_code` STRING COMMENT 'ISO 4217 3-letter currency code in which the fare amount is denominated (e.g., USD, EUR, GBP). Required for BSP/ARC settlement and multi-currency revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `flight_number` STRING COMMENT 'IATA-format flight number (2-character airline designator + up to 4-digit numeric suffix) as printed on the coupon. Represents the marketed flight number, which may differ from the operating carrier in codeshare arrangements.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}$`',
    `flown_date` DATE COMMENT 'Calendar date on which the passenger actually flew this coupon segment, as recorded by the departure control system at boarding. Populated when coupon_status is F (Flown). Triggers revenue recognition under IFRS 15.',
    `issuing_date` DATE COMMENT 'Calendar date on which the e-ticket containing this coupon was issued. Used for revenue period allocation, BSP/ARC reporting cycles, and advance purchase restriction validation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone offset) at which this coupon record was most recently modified in the source system. Tracks status changes, exchanges, refunds, and reprotection events for audit and incremental load processing.',
    `lifted_timestamp` TIMESTAMP COMMENT 'Precise date and time (ISO 8601 with timezone offset) at which the coupon was lifted (scanned/validated) at the boarding gate. Captured by the Amadeus Altéa Departure Control System (DCS). Used for OOOI event correlation and OTP measurement.',
    `marketing_carrier_code` STRING COMMENT 'IATA 2-character designator of the airline that sold and marketed the flight. In codeshare operations this is the airline whose flight number appears on the ticket coupon.. Valid values are `^[A-Z0-9]{2}$`',
    `not_valid_after_date` DATE COMMENT 'Latest date on which this coupon may be used for travel, as specified by the fare rule. Enforced at check-in and boarding. Null indicates no upper validity restriction (open-dated coupon).',
    `not_valid_before_date` DATE COMMENT 'Earliest date on which this coupon may be used for travel, as specified by the fare rule. Enforced at check-in and boarding. Null indicates no lower validity restriction.',
    `nuc_amount` DECIMAL(18,2) COMMENT 'Fare amount expressed in IATA Neutral Units of Construction (NUC), the currency-neutral unit used for international fare proration and interline revenue accounting. Converted to local currency using IATA Rate of Exchange (ROE).',
    `operating_carrier_code` STRING COMMENT 'IATA 2-character designator of the airline actually operating the flight. Differs from the marketing carrier code in codeshare and interline arrangements. Required for BSP/ARC settlement and DOT reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded for this coupon when coupon_status is R (Refunded), net of applicable cancellation penalties. Used for revenue reversal accounting, BSP/ARC refund settlement, and customer refund tracking.',
    `refund_date` DATE COMMENT 'Calendar date on which the refund for this coupon was processed. Populated when coupon_status is R (Refunded). Used for revenue reversal period allocation and BSP/ARC refund cycle reporting.',
    `settlement_type` STRING COMMENT 'Identifies the settlement channel through which this coupon will be or has been financially settled: BSP=IATA Billing and Settlement Plan, ARC=Airlines Reporting Corporation (US domestic), DIRECT=direct airline settlement, INTERLINE=interline billing via IATA Clearing House.. Valid values are `BSP|ARC|DIRECT|INTERLINE`',
    `stopover_indicator` BOOLEAN COMMENT 'Indicates whether this coupon point constitutes a stopover (True) or a connection (False) per IATA fare construction rules. A stopover is a deliberate break in journey exceeding 24 hours domestically or 24 hours internationally. Affects fare construction and through-fare applicability.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes, fees, and surcharges (YQ/YR fuel surcharge, airport taxes, PFC, government levies) allocated to this coupon segment. Required for BSP/ARC settlement and regulatory tax remittance reporting.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount for this coupon segment (fare_amount + tax_amount) in the ticket currency. Used as the gross revenue figure for coupon-level BSP/ARC settlement and revenue accounting.',
    `void_date` DATE COMMENT 'Calendar date on which this coupon was voided. Populated when coupon_status is V (Voided). Voiding is only permitted on the date of issuance per BSP/ARC rules. Used for revenue accounting and settlement reconciliation.',
    CONSTRAINT pk_ticket_coupon PRIMARY KEY(`ticket_coupon_id`)
) COMMENT 'Individual flight coupon record within an e-ticket, representing one segment of travel. Each e-ticket may contain up to four flight coupons. Captures coupon number, flight number, origin and destination, departure date, cabin class, booking class (RBD), fare basis code, not-valid-before/after dates, baggage allowance, coupon status (open/used/lifted/flown/refunded/voided/suspended/exchanged), stopover indicator, and actual flight date used. SSOT for coupon-level revenue recognition and BSP/ARC coupon reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`revenue_emd` (
    `revenue_emd_id` BIGINT COMMENT 'Unique surrogate identifier for the Electronic Miscellaneous Document (EMD) record in the lakehouse silver layer. Primary key for this entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: EMDs (ancillary revenue) are issued by legal entities and must be attributed for IFRS 15 revenue recognition and financial reporting by legal entity.',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Ancillary purchases (baggage, seats, lounge) earn loyalty miles. EMDs must link to FFP member for accrual posting and tier benefit validation. Replaces denormalized frequent_flyer_number with proper F',
    `member_id` BIGINT COMMENT 'Foreign key linking to crew.crew_member. Business justification: Tracks cabin crew member who sold ancillary service onboard (baggage upgrade, seat selection, meals). Essential for onboard revenue attribution, crew sales incentive programs, and commission calculati',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: EMDs issued for safety-related service recovery (hotel vouchers after emergency landings, meal vouchers during safety delays, ground transportation after diversions). Operational reality in irregular ',
    `org_unit_id` BIGINT COMMENT 'IATA-assigned office/agency identifier (city code + 8-digit numeric) of the office that issued the EMD (airline ticket office, travel agency, or online channel). Used for BSP/ARC settlement, commission calculation, and sales channel analytics.',
    `pricing_record_id` BIGINT COMMENT 'Foreign key linking to revenue.pricing_record. Business justification: EMDs (Electronic Miscellaneous Documents) for ancillary services may be priced through the same pricing engine as tickets. Linking EMD to the pricing_record that calculated its cost establishes the pr',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: EMD (Electronic Miscellaneous Document) is issued in conjunction with or independently of a ticket. The emd table has associated_ticket_number (STRING) which is a business key reference. Adding ticket',
    `associated_ticket_coupon` STRING COMMENT 'The coupon number on the associated air ticket (1–4) to which this EMD coupon is linked (EMD-A only). Enables segment-level association between the ancillary service and the specific flight leg it relates to.',
    `base_amount` DECIMAL(18,2) COMMENT 'The base fare component of the EMD before taxes and fees, in the transaction currency. Used for yield analysis, RASK computation, and ancillary revenue decomposition in Sabre AirVision Revenue Management.',
    `bsp_arc_billing_period` STRING COMMENT 'The BSP or ARC billing period (remittance date in YYYY-MM-DD format) in which this EMD is included for settlement. Used for cash flow forecasting, accounts receivable aging, and BSP/ARC reconciliation in SAP S/4HANA.. Valid values are `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`',
    `bsp_arc_reporting_flag` BOOLEAN COMMENT 'Indicates whether this EMD is subject to BSP (Billing and Settlement Plan) or ARC (Airlines Reporting Corporation) settlement reporting (True) or is settled directly outside BSP/ARC (False). Drives inclusion in BSP/ARC billing files and SAP S/4HANA accounts receivable postings.',
    `coupon_number` STRING COMMENT 'Sequential coupon number within the EMD document (1–4), identifying the specific service coupon. Each coupon corresponds to one service event or flight segment. Used for coupon-level status tracking and BSP/ARC settlement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EMD record was first captured in the lakehouse silver layer. Used for data lineage, audit trail, and SLA monitoring of data pipeline latency.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction currency in which the EMD was issued (e.g., USD, EUR, GBP). Required for multi-currency BSP/ARC settlement and SAP S/4HANA FX revaluation.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code of the destination station for the associated flight segment (e.g., LAX, CDG). Used for route-level ancillary revenue analytics and geographic revenue attribution.. Valid values are `^[A-Z]{3}$`',
    `emd_number` STRING COMMENT 'The 13-digit IATA-standard EMD document number, structured as airline code (3 digits) + form code (1 digit) + serial number (6 digits) + check digit (1 digit) + coupon count (2 digits). This is the externally-known business identifier used in BSP/ARC settlement and passenger-facing communications.. Valid values are `^[0-9]{13}$`',
    `emd_status` STRING COMMENT 'Current lifecycle status of the EMD coupon: open (issued, not yet used), used (service delivered), refunded (amount returned to passenger), voided (cancelled same-day before BSP/ARC lift), exchanged (reissued as new EMD), suspended (temporarily held). Drives revenue recognition and BSP/ARC settlement eligibility. [ENUM-REF-CANDIDATE: open|used|refunded|voided|exchanged|suspended — promote to reference product if additional statuses are required]. Valid values are `open|used|refunded|voided|exchanged|suspended`',
    `emd_type` STRING COMMENT 'Indicates whether the EMD is an EMD-A (Associated — linked to an air ticket coupon) or EMD-S (Standalone — issued independently of a ticket, e.g., lounge access, excess baggage sold separately). Drives BSP/ARC settlement routing and revenue accounting treatment.. Valid values are `EMD-A|EMD-S`',
    `equivalent_amount` DECIMAL(18,2) COMMENT 'Total EMD amount converted to the airlines base/reporting currency using the IATA Rate of Exchange (IROE) applicable at time of issuance. Used for consolidated ancillary revenue reporting, RASK/CASK analytics, and SAP S/4HANA FI ledger posting in functional currency.',
    `exchange_emd_number` STRING COMMENT 'The 13-digit EMD number of the original document from which this EMD was exchanged/reissued. Null if this is an original issuance. Used for document lineage tracking, refund difference calculation, and BSP/ARC exchange reporting.. Valid values are `^[0-9]{13}$`',
    `flight_number` STRING COMMENT 'IATA flight number (carrier code + numeric) of the flight segment to which this EMD service is associated (e.g., AA1234). Applicable for EMD-A and segment-specific EMD-S services. Used for flight-level ancillary revenue attribution and OTP impact analysis.. Valid values are `^[A-Z]{2}[0-9]{1,4}$`',
    `form_of_payment_detail` STRING COMMENT 'Masked payment instrument detail (e.g., last 4 digits of credit card, voucher number, check number). Full card numbers are NEVER stored per PCI DSS. Used for payment reconciliation and dispute resolution.',
    `form_of_payment_type` STRING COMMENT 'The type of payment instrument used to settle this EMD (e.g., credit_card, debit_card, cash, check, miles redemption, voucher, agency credit). Drives PCI compliance scope, BSP/ARC settlement method, and revenue accounting treatment. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|check|miles|voucher|agency_credit|other — promote to reference product]',
    `gds_code` STRING COMMENT 'Two-character code identifying the Global Distribution System (GDS) through which the EMD was issued (e.g., 1A=Amadeus, 1S=Sabre, 1G=Galileo/Travelport, 1V=Worldspan). Null for direct channel sales. Used for GDS incentive reconciliation and distribution cost analytics.. Valid values are `^[A-Z]{2}$`',
    `interline_indicator` BOOLEAN COMMENT 'Indicates whether this EMD involves an interline agreement (True), meaning the service may be delivered by a carrier other than the issuing airline. Drives interline proration, billing, and settlement processes.',
    `issue_date` DATE COMMENT 'Calendar date on which the EMD was issued to the passenger. The principal business event date for revenue recognition, BSP/ARC billing period assignment, and ancillary revenue reporting.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) at which the EMD was issued in the Amadeus Altéa PSS or Sabre system. Used for audit trails, intraday revenue reporting, and IROP reissuance sequencing.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this EMD record in the lakehouse silver layer (e.g., status change from open to used, refund processing). Used for change data capture, audit trails, and downstream incremental processing.',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA designator of the airline actually operating the flight or delivering the service (may differ from issuing airline in codeshare or interline scenarios). Used for interline proration and service delivery accountability.. Valid values are `^[A-Z0-9]{2}$`',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code of the origin station for the associated flight segment (e.g., JFK, LHR). Used for route-level ancillary revenue analytics and geographic revenue attribution.. Valid values are `^[A-Z]{3}$`',
    `passenger_name` STRING COMMENT 'Full name of the passenger for whom the EMD was issued, in IATA surname/given-name format (e.g., SMITH/JOHN MR). Required for passenger identification during service delivery and BSP/ARC settlement.',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record (PNR) booking reference in the Amadeus Altéa PSS under which this EMD was issued. Links the ancillary document to the passenger booking for itinerary management and customer service.. Valid values are `^[A-Z0-9]{6}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The amount refunded to the passenger for this EMD in the transaction currency. Null if not refunded. Used for refund liability accounting, BSP/ARC debit memo processing, and DOT consumer protection compliance reporting.',
    `refund_date` DATE COMMENT 'Calendar date on which a refund was processed for this EMD. Null if not refunded. Used for refund liability tracking, BSP/ARC debit memo reconciliation, and DOT consumer protection reporting.',
    `rfic` STRING COMMENT 'Single-character IATA Reason for Issuance Code (RFIC) classifying the broad category of ancillary service (e.g., A=Air Transportation, B=Surface Transportation, C=Baggage, D=Financial Impact, E=Airport Services, F=Merchandise, G=In-flight Services, I=Individual Airline Use). Used for BSP/ARC reporting and revenue categorisation.. Valid values are `^[A-Z]$`',
    `rfisc` STRING COMMENT 'Three-character IATA Reason for Issuance Sub-Code (RFISC) providing granular classification of the ancillary service within the RFIC category (e.g., 0B5=Checked Baggage 1st Piece, 0CC=Seat Selection, 0B1=Priority Boarding). Used for ancillary revenue analytics, yield management, and regulatory reporting.. Valid values are `^[A-Z0-9]{3}$`',
    `sales_channel` STRING COMMENT 'The distribution channel through which the EMD was sold (e.g., direct_web, mobile_app, airport_kiosk, call_center, travel_agency, GDS, NDC, airport_counter). Used for ancillary revenue channel analytics and distribution cost management. [ENUM-REF-CANDIDATE: direct_web|mobile_app|airport_kiosk|call_center|travel_agency|gds|ndc|airport_counter — promote to reference product]',
    `service_date` DATE COMMENT 'The scheduled date on which the ancillary service is to be delivered or consumed (e.g., flight date for excess baggage, lounge access date). May differ from issue_date for advance purchases. Used for revenue recognition scheduling and service fulfilment tracking.',
    `service_description` STRING COMMENT 'Human-readable description of the ancillary service covered by this EMD (e.g., Excess Baggage 23kg, Seat Upgrade to Business Class, Airport Lounge Access, Priority Boarding, Pet in Cabin). Sourced from the Sabre AirVision / Amadeus Altéa service catalogue.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes, fees, and surcharges applied to this EMD (e.g., Passenger Facility Charge (PFC), government taxes, carrier-imposed surcharges), in the transaction currency. Required for tax remittance, BSP/ARC settlement, and SAP S/4HANA FI tax accounting.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount collected from the passenger for this EMD (base_amount + tax_amount), in the transaction currency. The gross revenue figure used for BSP/ARC settlement, SAP S/4HANA revenue posting, and ancillary revenue reporting.',
    `used_date` DATE COMMENT 'Calendar date on which the EMD coupon was lifted (service delivered). Null if status is not used. Used for revenue recognition timing and service delivery confirmation.',
    `void_date` DATE COMMENT 'Calendar date on which the EMD was voided (same-day cancellation before BSP/ARC lift). Null if not voided. Required for BSP/ARC void reporting and revenue reversal.',
    CONSTRAINT pk_revenue_emd PRIMARY KEY(`revenue_emd_id`)
) COMMENT 'Electronic Miscellaneous Document (EMD) record for ancillary services sold in conjunction with or independently of an air ticket. Captures EMD number, EMD type (EMD-A associated / EMD-S standalone), service type code (IATA RFIC/RFISC), service description (excess baggage, seat upgrade, lounge access, priority boarding, etc.), associated ticket number, coupon reference, amount, currency, form of payment, issue date, issuing office, EMD status (open/used/refunded/voided), and BSP/ARC reporting flag. SSOT for ancillary revenue document lifecycle.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`bsp_settlement` (
    `bsp_settlement_id` BIGINT COMMENT 'Unique surrogate identifier for each BSP settlement transaction record in the airlines revenue management system. Primary key for this entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: BSP settlements are reconciled to specific legal entities for cash management, AR/AP posting, and financial statement preparation. Core treasury and accounting process.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: BSP settlement reports are submitted as regulatory filings to civil aviation authorities in many jurisdictions. Monthly BSP data feeds regulatory financial oversight, traffic statistics reporting, and',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: BSP settlements are processed and reconciled at specific stations; station FK enables settlement audit trails, station-level remittance tracking, and cost center allocation for settlement processing.',
    `acm_amount` DECIMAL(18,2) COMMENT 'Total value of Agency Credit Memos (ACMs) issued to the travel agent in this settlement period. ACMs represent credits owed to the agent for airline-initiated corrections, overpayments, or goodwill adjustments. Positive value reduces agent liability.',
    `adjustment_reference` STRING COMMENT 'Reference number or identifier for any corrective adjustment applied to this BSP settlement. Populated when settlement_status is adjusted. Links to the originating ADM, ACM, or manual journal entry in the revenue accounting system (SAP S/4HANA).',
    `adm_amount` DECIMAL(18,2) COMMENT 'Total value of Agency Debit Memos (ADMs) raised against the travel agent in this settlement period. ADMs recover amounts owed to the airline due to agent errors, fare violations, or unauthorized discounts. Positive value increases agent liability.',
    `agent_iata_code` STRING COMMENT 'The 8-digit IATA-assigned numeric code uniquely identifying the travel agency or sales outlet participating in the BSP settlement. Used as the primary agent identifier in IATA BSP transactions and reconciliation.. Valid values are `^[0-9]{8}$`',
    `agent_name` STRING COMMENT 'Legal or trading name of the travel agency or sales outlet as registered with IATA BSP. Used for reporting, dispute resolution, and agent performance analytics.',
    `airline_numeric_code` STRING COMMENT 'Three-digit IATA numeric airline code used in ticket number prefixes and BSP settlement files to identify the validating carrier. Complements the two-letter IATA designator for settlement and ticketing purposes.. Valid values are `^[0-9]{3}$`',
    `arc_report_reference` STRING COMMENT 'Reference identifier linking this BSP settlement to the corresponding ARC (Airlines Reporting Corporation) settlement report for US-market transactions. Populated for settlements processed through ARC rather than IATA BSP. Used for dual-channel reconciliation.',
    `billing_period_end_date` DATE COMMENT 'End date of the IATA BSP billing period covered by this settlement. Together with billing_period_start_date, defines the complete billing window for ticket sales included in this settlement.',
    `billing_period_start_date` DATE COMMENT 'Start date of the IATA BSP billing period covered by this settlement. BSP billing periods are typically bi-monthly or monthly depending on the market. Defines the range of ticket sales included in this settlement.',
    `bsp_file_reference` STRING COMMENT 'Externally-known IATA BSP file reference number assigned by the BSP clearing system to uniquely identify the settlement file batch. Used for reconciliation with IATA BSP reports and agent remittance matching.. Valid values are `^BSP-[A-Z]{2,3}-[0-9]{4}-[0-9]{6}$`',
    `bsp_market_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code identifying the BSP market (country or territory) in which this settlement was processed. Determines the applicable BSP rules, currency, and remittance schedule.. Valid values are `^[A-Z]{2}$`',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total commission amount deducted from gross sales and credited to the travel agent as per the applicable commission agreement. Reduces the net remittance amount owed to the airline.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The percentage commission rate applied to the base fare to calculate the commission_amount for this settlement. Expressed as a decimal (e.g., 0.0100 = 1%). Determined by the airline-agent commission agreement and applicable IATA rules.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code associated with the revenue management or sales function responsible for this BSP settlement. Used for internal financial reporting and P&L attribution by sales region or distribution channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this BSP settlement record was first captured in the airlines revenue management data platform. Used for audit trail and data lineage tracking.',
    `dispute_raised_date` DATE COMMENT 'Date on which the dispute was formally raised against this BSP settlement by either the airline or the travel agent. Populated only when settlement_status is disputed. Used to track dispute aging and SLA compliance.',
    `dispute_reason_code` STRING COMMENT 'Standardized IATA or internal code describing the reason for a disputed BSP settlement. Populated only when settlement_status is disputed. Used for dispute management, root cause analysis, and agent relationship management. [ENUM-REF-CANDIDATE: FARE_DIFF|COMM_DISPUTE|TAX_ERROR|DUPLICATE|UNAUTH_REFUND|ADM_REJECT — promote to reference product]',
    `dispute_resolution_date` DATE COMMENT 'Date on which the dispute for this BSP settlement was formally resolved. Populated when settlement_status transitions from disputed to settled or adjusted. Used for dispute lifecycle reporting and agent relationship analytics.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the settlement amounts from the BSP market local currency to the airlines functional reporting currency (e.g., USD or EUR). Sourced from IATA Rate of Exchange (IROE) or the airlines treasury system.',
    `gds_provider_code` STRING COMMENT 'Code identifying the Global Distribution System (GDS) through which the tickets in this settlement were issued. Common values: 1A (Amadeus), 1S (Sabre), 1G (Galileo/Travelport), 1V (Worldspan), 1P (Apollo). Used for channel analytics and GDS incentive reconciliation.. Valid values are `1A|1S|1G|1V|1P`',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account code to which this BSP settlement is posted for revenue recognition and financial reporting. Enables direct linkage between BSP settlement records and the airlines financial statements.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total gross ticket sales value (fare + taxes + surcharges) billed to the travel agent in this BSP settlement period, before deduction of commissions or adjustments. Expressed in the settlement currency.',
    `interline_indicator` BOOLEAN COMMENT 'Flag indicating whether this BSP settlement includes interline ticket sales where the validating carrier is settling on behalf of one or more operating carriers under an interline ticketing agreement. True = interline settlement; False = single-carrier settlement.',
    `ndc_indicator` BOOLEAN COMMENT 'Flag indicating whether the tickets in this BSP settlement were issued via IATA New Distribution Capability (NDC) API channels rather than traditional GDS. True = NDC-sourced settlement; False = traditional GDS/BSP settlement. Used for NDC adoption tracking and distribution analytics.',
    `net_remittance_amount` DECIMAL(18,2) COMMENT 'Net amount remitted by the travel agent to the airline after deducting commissions and applying any ADM/ACM adjustments from gross sales. This is the actual cash settlement amount transferred through the BSP clearing mechanism.',
    `pfc_amount` DECIMAL(18,2) COMMENT 'Total Passenger Facility Charge (PFC) amounts collected by the travel agent on behalf of US airports and included in this BSP settlement. PFCs are FAA-regulated charges that must be separately tracked and remitted to the relevant airport authorities.',
    `remittance_due_date` DATE COMMENT 'The date by which the travel agent is contractually required to remit the net settlement amount to the BSP clearing house. Determined by the BSP market remittance schedule. Used for cash flow forecasting and overdue tracking.',
    `sales_channel` STRING COMMENT 'The distribution channel through which the tickets in this BSP settlement were sold. Used for channel revenue analytics and distribution cost management. [ENUM-REF-CANDIDATE: GDS|direct|online_travel_agency|corporate|consolidator|NDC — promote to reference product]. Valid values are `GDS|direct|online_travel_agency|corporate|consolidator`',
    `settlement_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which the BSP settlement amounts (gross sales, commission, net remittance) are denominated. Determined by the BSP market country and IATA currency rules.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'The principal business event date on which the BSP clearing house executed the financial settlement and funds were remitted between the travel agent and the airline. Corresponds to the IATA BSP remittance date.',
    `settlement_status` STRING COMMENT 'Current lifecycle state of the BSP settlement transaction. pending indicates awaiting clearing; settled indicates funds remitted; disputed indicates agent or airline has raised a discrepancy; adjusted indicates a corrective entry has been applied; cancelled indicates the settlement was voided.. Valid values are `pending|settled|disputed|adjusted|cancelled`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total government taxes, airport fees, and fuel surcharges (YQ/YR) included in the gross sales amount. Taxes are collected by the agent on behalf of the airline and relevant authorities and must be separately tracked for regulatory remittance.',
    `ticket_count` STRING COMMENT 'Total number of individual e-tickets included in this BSP settlement transaction. Used for volume reconciliation and agent productivity reporting.',
    `ticket_number_range_end` STRING COMMENT 'The last e-ticket number in the range of tickets covered by this BSP settlement transaction. Together with ticket_number_range_start, defines the complete set of tickets included in this settlement batch.. Valid values are `^[0-9]{3}-[0-9]{10}$`',
    `ticket_number_range_start` STRING COMMENT 'The first e-ticket number in the range of tickets covered by this BSP settlement transaction. Follows IATA 13-digit ticket number format (3-digit airline code prefix + 10-digit serial). Used for reconciliation with the Passenger Service System (PSS).. Valid values are `^[0-9]{3}-[0-9]{10}$`',
    `transaction_type` STRING COMMENT 'Classification of the BSP settlement transaction. sale is a standard ticket sale; refund is a passenger refund; ADM (Agency Debit Memo) is a debit raised against the agent; ACM (Agency Credit Memo) is a credit issued to the agent; reversal is a correction of a prior transaction; adjustment is a manual correction entry. [ENUM-REF-CANDIDATE: sale|refund|ADM|ACM|reversal|adjustment — promote to reference product]. Valid values are `sale|refund|ADM|ACM|reversal|adjustment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this BSP settlement record was last modified in the airlines revenue management data platform. Tracks adjustments, status changes, and dispute resolutions.',
    CONSTRAINT pk_bsp_settlement PRIMARY KEY(`bsp_settlement_id`)
) COMMENT 'BSP (Billing and Settlement Plan) settlement transaction record representing the financial settlement between the airline and travel agents through the IATA BSP clearing mechanism. Captures BSP billing period, agent IATA code, agent name, country/BSP market, transaction type (sale/refund/ADM/ACM), ticket number range, gross sales amount, commission amount, net remittance amount, currency, settlement date, BSP file reference, and settlement status (pending/settled/disputed/adjusted). SSOT for BSP-channel revenue collection and agent settlement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`arc_settlement` (
    `arc_settlement_id` BIGINT COMMENT 'Unique surrogate identifier for each ARC settlement transaction record in the silver layer lakehouse. Primary key for this entity.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: ARC settlements create AR entries for amounts due from ARC. Required for cash application and AR reconciliation in US market operations.',
    `agency_id` BIGINT COMMENT 'Reference to the travel agency master record that submitted this settlement transaction through the ARC system.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: ARC settlements flow to specific legal entities for financial reporting and cash reconciliation. Essential for US market airline financial operations.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: ARC settlement reports constitute regulatory filings for DOT Form 41 financial reporting. Airlines must file quarterly financial data derived from ARC settlements to maintain operating certificates an',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: ARC settlements require station-level tracking for remittance reconciliation, regulatory reporting, station cost center allocation, and audit compliance. Settlement processing occurs at specific stati',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: ARC settlement records represent the financial settlement transaction for US-market travel agency ticket sales. Each settlement record references a specific ticket that was sold. The arc_settlement pr',
    `adm_acm_reason_code` STRING COMMENT 'Standardized reason code for Agency Debit Memo (ADM) or Agency Credit Memo (ACM) transactions, indicating the cause of the debit or credit adjustment (e.g., fare difference, commission clawback, waiver). Null for SALE, REFUND, EXCHANGE, and VOID transaction types. [ENUM-REF-CANDIDATE: FARE_DIFF|COMM_CLAWBACK|WAIVER|TAX_ADJ|SURCHARGE|OTHER — promote to reference product]',
    `agency_name` STRING COMMENT 'Legal or trade name of the travel agency or corporate entity associated with the ARC agency number. Used for reporting, reconciliation, and dispute resolution.',
    `arc_agency_number` STRING COMMENT 'Eight-digit ARC-assigned numeric identifier for the travel agency or corporate location that issued or processed the ticket. Used as the primary agency identifier in ARC settlement reporting and reconciliation.. Valid values are `^[0-9]{8}$`',
    `arc_period_number` STRING COMMENT 'ARC reporting period identifier in YYYY-WW format representing the calendar year and weekly settlement period (1–52) during which this transaction was reported and settled. ARC operates on a weekly settlement cycle.. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    `base_fare_amount` DECIMAL(18,2) COMMENT 'Pure transportation fare component of the ticket, excluding all taxes, fees, surcharges, and ancillary charges. Used for yield calculation (revenue per RPK), RASK analysis, and revenue management performance reporting.',
    `cabin_class` STRING COMMENT 'Service cabin class of the ticketed itinerary: FIRST, BUSINESS, PREMIUM_ECONOMY, or ECONOMY. Used for revenue segmentation, yield analysis, and RASK/CASK reporting.. Valid values are `FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY`',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount deducted by the travel agency from the gross ticket amount as authorized by the airlines commission policy. Reduces the net remittance to the airline. May be zero for net-fare or commission-free transactions.',
    `conjunction_ticket_number` STRING COMMENT 'Ticket number of the associated conjunction ticket when the itinerary spans more than one ticket document. Null when the transaction involves a single standalone ticket.. Valid values are `^[0-9]{3}-[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ARC settlement record was first loaded into the silver layer lakehouse. Represents the data ingestion audit trail timestamp in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which the ARC settlement amounts (gross, tax, commission, net) are denominated. ARC US-market settlements are predominantly in USD.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the final destination on the ticketed itinerary. Used for route analysis, revenue allocation, and DOT reporting.. Valid values are `^[A-Z]{3}$`',
    `dispute_reference` STRING COMMENT 'ARC-assigned reference number for a formal dispute raised against this settlement transaction by the airline or the travel agency. Populated only when settlement_status is DISPUTED. Used for dispute tracking and resolution management.',
    `endorsement_restriction` STRING COMMENT 'Free-text endorsement or restriction box content from the ticket document, indicating fare restrictions, interline endorsements, or special conditions (e.g., NON-ENDORSE, NON-REROUTE, VALID ON XX ONLY). Used for fare audit and refund eligibility determination.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the transaction currency to the settlement currency (USD) when the ticket was issued in a foreign currency. Value of 1.0 for USD-denominated transactions. Used for multi-currency reconciliation.',
    `fare_basis_code` STRING COMMENT 'Alphanumeric fare basis code identifying the specific fare rule and booking class under which the ticket was priced. Used for revenue management analysis, yield reporting, and fare audit.',
    `gds_code` STRING COMMENT 'Code identifying the Global Distribution System (GDS) through which the ticket was booked and issued: 1A (Amadeus), 1S (Sabre), 1G (Galileo/Travelport), 1V (Worldspan/Travelport), 1P (Apollo/Travelport). Used for distribution channel analysis and GDS incentive reconciliation.. Valid values are `1A|1S|1G|1V|1P`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total face value of the ticket or transaction before deduction of commission, taxes, and fees. Represents the full amount charged to the passenger as reported in the ARC settlement. Expressed in the settlement currency.',
    `is_codeshare` BOOLEAN COMMENT 'Indicates whether the ticketed itinerary includes one or more codeshare flight segments where the marketing carrier differs from the operating carrier. True for codeshare itineraries; False otherwise. Relevant for revenue sharing and codeshare agreement reconciliation.',
    `is_interline` BOOLEAN COMMENT 'Indicates whether the ticketed itinerary involves one or more interline segments operated by a carrier other than the validating carrier. True when interline agreements apply; False for single-carrier itineraries. Affects revenue proration and interline settlement.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount remitted to or from the airline after deducting agency commission from the gross amount. Calculated as gross_amount minus commission_amount. This is the actual cash flow amount settled through ARCs weekly settlement cycle.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the point of origin on the ticketed itinerary. Used for route analysis, revenue allocation, and DOT reporting.. Valid values are `^[A-Z]{3}$`',
    `original_ticket_number` STRING COMMENT 'Ticket number of the original ticket document when this transaction is an exchange or refund. Enables traceability of the full ticket lifecycle from original issuance through exchange or refund. Null for original sale transactions.. Valid values are `^[0-9]{3}-[0-9]{10}$`',
    `pfc_amount` DECIMAL(18,2) COMMENT 'Total Passenger Facility Charge (PFC) collected on the ticket, as mandated by the FAA for airport improvement projects. Must be separately tracked and remitted to the applicable airport authority. Regulated under 14 CFR Part 158.',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record (PNR) locator code from the Global Distribution System (GDS) or Passenger Service System (PSS) associated with the ticketed booking. Links the settlement record to the reservation for reconciliation.. Valid values are `^[A-Z0-9]{6}$`',
    `point_of_sale_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the ticket was sold. ARC governs US point-of-sale transactions; this field confirms US-origin sales and identifies any international point-of-sale exceptions.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Calendar date on which ARC completed the financial settlement and funds were transferred between the airline and the travel agency for this transaction. Corresponds to the ARC weekly settlement processing date.',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the ARC settlement transaction: PENDING (submitted, awaiting settlement), SETTLED (funds transferred and confirmed), DISPUTED (under agency or airline dispute), REVERSED (settlement reversed post-processing), REJECTED (rejected by ARC for data or compliance errors).. Valid values are `PENDING|SETTLED|DISPUTED|REVERSED|REJECTED`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total amount of government-imposed taxes, airport fees, and surcharges (e.g., PFC — Passenger Facility Charge, segment fees, international departure taxes) included in the gross ticket amount. Separated for revenue recognition and tax remittance purposes.',
    `tour_code` STRING COMMENT 'Tour operator or corporate account code printed on the ticket, used to identify negotiated fares, corporate contracts, or tour operator agreements. Used for revenue accounting, commission override validation, and contract compliance auditing.',
    `transaction_date` DATE COMMENT 'Date on which the ticket was originally issued, refunded, exchanged, or voided by the travel agency. Represents the business event date as recorded in the ARC report, distinct from the settlement processing date.',
    `transaction_type` STRING COMMENT 'Classification of the ARC settlement transaction: SALE (new ticket issuance), REFUND (ticket refund to passenger), EXCHANGE (ticket reissue/exchange), VOID (same-week void of issued ticket), ADM (Agency Debit Memo — amount collected from agency), ACM (Agency Credit Memo — amount credited to agency).. Valid values are `SALE|REFUND|EXCHANGE|VOID|ADM|ACM`',
    `travel_date` DATE COMMENT 'Date of the first flight segment on the ticketed itinerary. Used for revenue recognition timing, yield analysis, and period allocation in revenue accounting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this ARC settlement record in the silver layer, reflecting status changes, dispute updates, or correction reprocessing. ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    CONSTRAINT pk_arc_settlement PRIMARY KEY(`arc_settlement_id`)
) COMMENT 'ARC (Airlines Reporting Corporation) settlement transaction record for US-market travel agency ticket sales and refunds settled through the ARC IAR (Industry Agents Handbook) system. Captures ARC period, agency ARC number, agency name, transaction type (sale/refund/exchange/void), ticket number, gross amount, commission, net amount, currency, settlement date, ARC report reference, and settlement status. Distinct from BSP settlements as ARC governs the US domestic and US-point-of-sale international market with different rules and reporting requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`adm` (
    `adm_id` BIGINT COMMENT 'Unique surrogate identifier for the Agency Debit Memo record in the lakehouse silver layer. Primary key for this entity.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: ADMs issued to agents create AP entries when credits are due (e.g., disputed ADMs resolved in agent favor). Links revenue adjustments to payables.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to revenue.agency. Business justification: ADMs are issued to travel agencies. The agent_iata_code and agent_name attributes in adm should reference the authoritative agency master. Standard N:1 relationship. No bidirectional conflict. agent_i',
    `arc_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.arc_settlement. Business justification: ADMs can also be processed through ARC settlement cycles (US market). The arc_reporting_period attribute in adm indicates its part of an ARC settlement. This should be a FK to the authoritative arc_s',
    `bsp_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.bsp_settlement. Business justification: ADMs (Agency Debit Memos) are processed through BSP settlement cycles. The bsp_billing_period attribute in adm indicates its part of a BSP settlement. This should be a FK to the authoritative bsp_set',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Agency debit memos impact specific legal entity financials (revenue adjustments, AR). Required for accurate financial reporting by legal entity.',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: ADM (Agency Debit Memo) is issued to recover funds for ticketing errors or policy violations. Each ADM references one ticket. The adm table has ticket_number (STRING) as a business key. Adding ticket_',
    `adm_number` STRING COMMENT 'Externally-known, human-readable ADM document number assigned by the issuing airline. Used as the primary reference in BSP/ARC settlement communications and agent correspondence. Typically follows IATA document numbering conventions.',
    `authorised_commission_rate` DECIMAL(18,2) COMMENT 'The commission rate (decimal fraction) that the airline had authorised for the agent on this transaction. Compared against commission_rate to determine if a commission clawback ADM is warranted.',
    `collected_fare_amount` DECIMAL(18,2) COMMENT 'The actual fare amount collected by the travel agent on the ticket transaction. The difference between original_fare_amount and collected_fare_amount typically constitutes the fare-difference ADM debit.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate (as a decimal fraction, e.g., 0.0100 for 1%) that was applied or claimed by the agent on the underlying ticket. Used to calculate commission clawback ADMs where the agent applied an unauthorised or incorrect commission.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the travel agents location. Determines the applicable BSP market rules, dispute timelines, and regulatory jurisdiction for the ADM.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ADM record was first captured in the revenue management system or lakehouse. Provides the audit trail creation marker per data governance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the ADM debit amount is denominated and settled (e.g., USD, EUR, GBP). Aligns with the BSP or ARC settlement currency for the agents market.. Valid values are `^[A-Z]{3}$`',
    `debit_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount being debited from the travel agent by this ADM, expressed in the settlement currency. Represents the principal financial claim before any adjustments or waivers.',
    `destination_airport_code` STRING COMMENT 'IATA three-letter airport code for the destination point of the ticket or itinerary associated with this ADM. Used alongside origin for market-level revenue recovery analysis.. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'Calendar date on which the travel agent formally submitted a dispute against this ADM. Null if the ADM has not been disputed. Used to verify dispute was raised within the allowable dispute window.',
    `dispute_deadline_date` DATE COMMENT 'Last calendar date by which the travel agent may formally dispute this ADM under IATA Resolution 850m or ARC rules. Calculated from the issue date per applicable BSP/ARC market rules. After this date, an undisputed ADM is deemed accepted.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the ADM dispute workflow: undisputed (agent has not contested), disputed (agent has raised a formal dispute), waived (airline has waived the debit), upheld (dispute rejected, debit stands), reversed (ADM cancelled and debit reversed).. Valid values are `undisputed|disputed|waived|upheld|reversed`',
    `fare_basis_code` STRING COMMENT 'IATA fare basis code of the fare that should have been applied to the ticket, as determined by the airlines revenue management and pricing system. Used to substantiate fare-difference ADMs.',
    `gds_code` STRING COMMENT 'Code identifying the Global Distribution System through which the original ticket was booked (e.g., 1A=Amadeus, 1S=Sabre, 1G=Galileo, 1V=Worldspan, FD=direct). Relevant for identifying the booking channel and routing disputes.. Valid values are `1A|1S|1G|1V|FD`',
    `issue_date` DATE COMMENT 'Calendar date on which the ADM was formally issued by the airline to the travel agent. Serves as the principal business event date for settlement cycle inclusion and dispute deadline calculation.',
    `issuing_office_code` STRING COMMENT 'Airline office or station code of the revenue accounting unit that issued this ADM. Used for internal routing, accountability tracking, and regional revenue recovery reporting.',
    `net_debit_amount` DECIMAL(18,2) COMMENT 'Net amount recoverable from the agent after applying any approved waivers, partial reversals, or adjustments to the gross debit amount. Used for final BSP/ARC settlement processing.',
    `origin_airport_code` STRING COMMENT 'IATA three-letter airport code for the origin point of the ticket or itinerary associated with this ADM. Used for market analysis and routing of revenue recovery claims.. Valid values are `^[A-Z]{3}$`',
    `original_fare_amount` DECIMAL(18,2) COMMENT 'The fare amount that should have been applied to the ticket per the airlines published or filed fare rules, as determined by the revenue management system. Used to calculate the fare difference that forms the basis of the ADM debit.',
    `passenger_name` STRING COMMENT 'Name of the passenger on the ticket associated with this ADM, as recorded in the PNR. Captured for audit and dispute evidence purposes. Classified as restricted PII.',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric GDS booking reference (PNR locator) associated with the ticket or transaction underlying this ADM. Enables traceability back to the original reservation in Amadeus Altéa or the GDS.. Valid values are `^[A-Z0-9]{6}$`',
    `reason_code` STRING COMMENT 'IATA-standard reason code classifying the cause of the ADM (e.g., fare difference, commission clawback, ticketing error, refund discrepancy, tax error, waiver misuse). Drives downstream reporting and dispute categorisation. [ENUM-REF-CANDIDATE: FARE|COMM|TAX|RFND|WAIV|TKTERR|POLICY|OTHER — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative description of the specific reason for issuing the ADM, supplementing the structured reason code. Provides the agent with a human-readable explanation of the debit claim.',
    `resolution_date` DATE COMMENT 'Calendar date on which the ADM dispute was formally resolved (upheld, waived, or reversed). Null if the ADM is still open or undisputed. Used for SLA tracking and revenue recovery reporting.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the outcome of the ADM dispute resolution process, including rationale for upholding, waiving, or reversing the debit. Captured by the revenue accounting team for audit trail purposes.',
    `settlement_channel` STRING COMMENT 'Billing and settlement channel through which this ADM is processed: BSP (IATA Billing and Settlement Plan for international markets), ARC (Airlines Reporting Corporation for US market), or DIRECT (bilateral direct settlement outside BSP/ARC).. Valid values are `BSP|ARC|DIRECT`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component included within or associated with the ADM debit, such as VAT or applicable government taxes on the fare difference or commission recovery. May be zero if no tax applies.',
    `ticket_issue_date` DATE COMMENT 'Calendar date on which the original ticket associated with this ADM was issued by the travel agent. Used to determine applicable fare rules, commission agreements, and statute of limitations for recovery.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this ADM record, including status changes, dispute updates, resolution entries, or amount adjustments. Supports change data capture and audit trail requirements.',
    `waiver_code` STRING COMMENT 'Airline-issued waiver or exception code authorising the reduction or cancellation of the ADM debit. Populated when the airline agrees to waive the claim, typically referencing a commercial agreement, goodwill gesture, or documented error by the airline.',
    CONSTRAINT pk_adm PRIMARY KEY(`adm_id`)
) COMMENT 'Agency Debit Memo (ADM) record issued by the airline to a travel agent to recover funds for ticketing errors, fare differences, commission clawbacks, or policy violations. Captures ADM number, issuing airline, agent IATA/ARC code, agent name, related ticket number, ADM reason code (IATA standard), ADM reason description, debit amount, currency, issue date, dispute deadline, dispute status (undisputed/disputed/waived/upheld/reversed), BSP/ARC channel, and resolution notes. SSOT for agent billing dispute and revenue recovery management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`recognition` (
    `recognition_id` BIGINT COMMENT 'Primary key for recognition',
    `arc_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.arc_settlement. Business justification: Revenue recognition records for ARC-settled tickets should reference the ARC settlement batch. The bsp_arc_report_period attribute indicates settlement tracking. This should be a FK to the authoritati',
    `bsp_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.bsp_settlement. Business justification: Revenue recognition records track when revenue is recognized from flown/used tickets. The bsp_arc_report_period attribute indicates BSP settlement tracking. This should be a FK to the authoritative bs',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Revenue is attributed to cost centers (routes, hubs, regions) for profitability analysis, management reporting, and route P&L. Standard airline financial management practice.',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Revenue accounting must tie recognized revenue to the specific flight inventory instance flown for accurate proration, interline settlement, and GL posting. Required for IFRS 15 compliance, matching r',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Revenue accounting records post to GL for IFRS 15 compliance and financial statement preparation. Core integration between revenue and finance systems.',
    `interline_prorate_id` BIGINT COMMENT 'Foreign key linking to revenue.interline_prorate. Business justification: Revenue recognition records for interline journeys should reference the prorate agreement that governs revenue sharing. The prorate_agreement_reference and interline_partner_code attributes in recogni',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Revenue accounting requires origin station FK for cost center allocation, station-level P&L reporting, interline settlement, and GL posting by station. Origin_airport_code is denormalized station refe',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Revenue accounting records feed regulatory financial filings (DOT Form 41, IATA financial reports, bilateral agreement traffic reports). Airlines must file periodic revenue reports to authorities; thi',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Revenue accounting requires route-level attribution for prorate agreement application, bilateral settlement calculations, and P&L reporting by route. Route determines prorate factors, interline partne',
    `ticket_coupon_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket_coupon. Business justification: revenue_recognition records represent recognized revenue entries for flown or used travel. Each accounting record corresponds to one ticket coupon (flight segment). The table has ticket_number and cou',
    `accounting_period` STRING COMMENT 'Financial accounting period (YYYY-MM) in which this revenue is recognized, aligned with the airlines fiscal calendar. Drives period-close reporting in SAP S/4HANA FI/CO and DOT financial filings.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `accounting_status` STRING COMMENT 'Current workflow status of this revenue recognition record: PENDING (awaiting period-close processing), RECOGNIZED (revenue posted to GL), ADJUSTED (corrected after initial recognition), REVERSED (voided/cancelled entry), DISPUTED (under interline billing dispute).. Valid values are `PENDING|RECOGNIZED|ADJUSTED|REVERSED|DISPUTED`',
    `adjustment_reason_code` STRING COMMENT 'Standardized code indicating the reason for a revenue adjustment or reversal (e.g., IROP reprotection, involuntary downgrade, fare recalculation, interline dispute resolution). Populated only when accounting_status is ADJUSTED or REVERSED.',
    `booking_class` STRING COMMENT 'Single-letter Reservation Booking Designator (RBD) representing the fare class/inventory bucket in which the ticket was booked (e.g., Y, B, M, Q, V). Drives yield management analysis and links to Sabre AirVision fare class buckets.. Valid values are `^[A-Z]{1}$`',
    `cabin_class` STRING COMMENT 'IATA cabin class code indicating the physical cabin in which the passenger traveled: F (First), C (Business), W (Premium Economy), Y (Economy). Used for cabin-level revenue disaggregation and yield analysis.. Valid values are `F|C|W|Y`',
    `codeshare_flag` BOOLEAN COMMENT 'Indicates whether this coupon was flown on a codeshare flight where the issuing carriers flight number was marketed but operated by a partner airline. Affects revenue recognition treatment and interline settlement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue accounting record was first created in the system. Used for audit trail, data lineage, and period-close reconciliation.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the arrival station of the coupon segment. Combined with origin forms the O&D pair for revenue accounting and yield management analysis.. Valid values are `^[A-Z]{3}$`',
    `emd_number` STRING COMMENT 'IATA Electronic Miscellaneous Document number when this revenue recognition record relates to an ancillary service (e.g., excess baggage, seat upgrade, lounge access) rather than a flight coupon. Null for standard flight coupons.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'IATA Rate of Exchange (IROE) applied to convert the fare from the ticketing currency to the settlement/reporting currency at the time of ticketing. Used for multi-currency revenue normalization in financial reporting.',
    `fare_amount` DECIMAL(18,2) COMMENT 'Base fare amount recognized for this coupon in the settlement currency, excluding taxes and surcharges. For interline itineraries this is the prorated share allocated to this carrier. Core revenue figure for RASK and yield calculations.',
    `fare_basis_code` STRING COMMENT 'Alphanumeric fare basis code (e.g., YLOWUS, QXAP21) identifying the specific fare rule set applied to this ticket coupon. Encodes cabin, booking class, restrictions, and seasonality. Key reference for revenue accounting and prorate calculations.',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight on which the coupon was flown or the service was consumed. This is the primary business event date for revenue recognition under the flown basis.',
    `flight_number` STRING COMMENT 'IATA airline designator and numeric flight number (e.g., AA1234) identifying the operating flight on which the coupon was consumed. Used to link revenue to flight operations data.. Valid values are `^[A-Z]{2}[0-9]{1,4}$`',
    `form_of_payment_type` STRING COMMENT 'Category of payment instrument used to purchase the ticket: CASH, CC (Credit Card), CHECK, VOUCHER, MILES (frequent flyer redemption), AGENCY (agency credit), OTHER. Drives revenue disaggregation between cash and non-cash revenue. [ENUM-REF-CANDIDATE: CASH|CC|CHECK|VOUCHER|MILES|AGENCY|OTHER — promote to reference product]',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Carrier-imposed fuel surcharge (IATA codes YQ for fuel surcharge, YR for carrier-imposed miscellaneous surcharge) collected on this coupon. Tracked separately for revenue accounting transparency and regulatory compliance.',
    `interline_flag` BOOLEAN COMMENT 'Indicates whether this coupon is part of an interline itinerary involving two or more carriers under an interline ticketing agreement. When true, prorate_amount and prorate_agreement_reference are applicable.',
    `issuing_airline_code` STRING COMMENT 'Two-character IATA designator of the airline that issued the ticket document. May differ from the operating carrier on codeshare or interline itineraries. Used to determine revenue accounting ownership.. Valid values are `^[A-Z0-9]{2}$`',
    `operating_airline_code` STRING COMMENT 'Two-character IATA designator of the airline that physically operated the flight. Differs from issuing_airline_code on codeshare flights. Required for IATA SSIM reporting and DOT on-time performance attribution.. Valid values are `^[A-Z0-9]{2}$`',
    `passenger_type_code` STRING COMMENT 'IATA Passenger Type Code indicating the category of traveler: ADT (Adult), CHD (Child), INF (Infant), MIL (Military), GOV (Government), STU (Student). Affects fare applicability and revenue disaggregation.. Valid values are `ADT|CHD|INF|MIL|GOV|STU`',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record locator from the Amadeus Altéa PSS linking this revenue record to the originating reservation. Used for traceability between revenue accounting and reservation systems.. Valid values are `^[A-Z0-9]{6}$`',
    `prorate_amount` DECIMAL(18,2) COMMENT 'The carriers prorated share of the total through-fare for interline itineraries, calculated per the applicable IATA prorate agreement or bilateral prorate factor. Equals fare_amount for online (single-carrier) itineraries.',
    `recognition_method` STRING COMMENT 'Method by which revenue is recognized for this record: FLOWN (recognized upon flight completion), ACCRUAL (deferred/accrual basis), PRORATE (interline prorate allocation), REDEMPTION (FFP miles redemption), REVERSAL (corrective reversal entry). Aligns with IFRS 15 performance obligation satisfaction.. Valid values are `FLOWN|ACCRUAL|PRORATE|REDEMPTION|REVERSAL`',
    `recognition_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition entry was processed and posted in the revenue accounting system. Represents the business event time of recognition, distinct from the flight date and the record audit timestamp.',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'Fare amount converted to the airlines functional reporting currency (e.g., USD) using the IROE exchange rate. Used for consolidated financial reporting in SAP S/4HANA FI/CO and DOT/IATA statistical submissions.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the fare and surcharge amounts are denominated for BSP/ARC settlement (e.g., USD, EUR, GBP). Determines the settlement currency for interline billing.. Valid values are `^[A-Z]{3}$`',
    `source_system_record_reference` STRING COMMENT 'Native record identifier from the originating revenue accounting system (Sabre AirVision Revenue Management or SAP S/4HANA) for traceability and reconciliation between the lakehouse Silver layer and the operational system of record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Aggregate of all government-mandated taxes collected on this coupon (e.g., departure tax, VAT, PFC, segment tax). Reported separately from fare revenue per IATA revenue accounting standards and DOT reporting requirements.',
    `ticket_issue_date` DATE COMMENT 'Date on which the original ticket was issued. Used to determine the advance purchase window, applicable fare rules, and the deferred revenue liability period between ticketing and flight date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this revenue accounting record (e.g., adjustment, status change, prorate recalculation). Used for incremental data processing in the Databricks Silver layer.',
    CONSTRAINT pk_recognition PRIMARY KEY(`recognition_id`)
) COMMENT 'Revenue accounting transaction record representing the recognized revenue entry for a flown or used ticket coupon or EMD. Captures the accounting period, ticket/coupon reference, flight date, origin-destination, cabin, booking class, fare amount recognized, prorate share (for interline), tax amounts, surcharges, form of payment, passenger type, revenue recognition method (flown/accrual), interline prorate agreement reference, and accounting status (pending/recognized/adjusted/reversed). SSOT for passenger revenue recognition aligned with IATA revenue accounting standards and airline financial reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`interline_prorate` (
    `interline_prorate_id` BIGINT COMMENT 'Unique surrogate identifier for each interline prorate agreement or proration transaction record in the silver layer lakehouse.',
    `arc_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.arc_settlement. Business justification: Interline prorate settlements can also be processed through ARC channels. The settlement_period attribute indicates settlement tracking. This should be a FK to the authoritative arc_settlement record.',
    `bsp_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.bsp_settlement. Business justification: Interline prorate settlements are processed through BSP channels. The settlement_period attribute indicates settlement tracking. This should be a FK to the authoritative bsp_settlement record. Standar',
    `interline_billing_id` BIGINT COMMENT 'Foreign key linking to finance.interline_billing. Business justification: Prorate agreements drive interline billing transactions for settlement with partner airlines. Direct operational dependency for interline revenue accounting.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Prorate agreements are route-specific; route determines applicable bilateral ASA, traffic rights category, and revenue split methodology between operating and marketing carriers. Essential for interli',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: interline_prorate records define how revenue from multi-carrier itineraries is split between airlines. Each proration transaction references one ticket. The table has ticket_number (STRING) as a busin',
    `agreement_reference_number` STRING COMMENT 'Externally-known reference number assigned to the interline prorate agreement, used for identification in IATA billing and settlement communications. Corresponds to the Specific Prorate Agreement (SPA) or IATA pro-rate factor agreement identifier. BUSINESS_IDENTIFIER category.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the interline prorate agreement: ACTIVE (in force), SUSPENDED (temporarily halted), EXPIRED (past effective period), TERMINATED (cancelled before expiry), PENDING (awaiting activation). LIFECYCLE_STATUS category.. Valid values are `ACTIVE|SUSPENDED|EXPIRED|TERMINATED|PENDING`',
    `agreement_type` STRING COMMENT 'Classification of the interline prorate agreement method: SPA (Specific Prorate Agreement), IATA_PRF (IATA Pro-Rate Factor), MILEAGE (mileage-based proration), FIXED_AMOUNT (fixed monetary split), or PERCENTAGE (percentage-based split). CLASSIFICATION_OR_TYPE category.. Valid values are `SPA|IATA_PRF|MILEAGE|FIXED_AMOUNT|PERCENTAGE`',
    `cabin_class` STRING COMMENT 'Cabin class to which this prorate agreement applies, restricting the agreement to a specific service level (e.g., FIRST, BUSINESS, PREMIUM_ECONOMY, ECONOMY). Null if the agreement applies to all cabin classes.. Valid values are `FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY`',
    `calculation_method` STRING COMMENT 'Method used to calculate the revenue proration between interline carriers: PROPORTIONAL (based on segment distance), EQUAL_SPLIT (equal share per carrier), MILEAGE_RATIO (IATA mileage-based), AGREED_FACTOR (bilaterally negotiated factor), FIXED (fixed amount per agreement). [ENUM-REF-CANDIDATE: PROPORTIONAL|EQUAL_SPLIT|MILEAGE_RATIO|AGREED_FACTOR|FIXED — promote to reference product]. Valid values are `PROPORTIONAL|EQUAL_SPLIT|MILEAGE_RATIO|AGREED_FACTOR|FIXED`',
    `collected_fare_amount` DECIMAL(18,2) COMMENT 'Total fare amount collected from the passenger for the interline itinerary, in the settlement currency. This is the gross base amount from which the prorate split is calculated. MONETARY_TRIPLET — gross base amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline prorate record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). RECORD_AUDIT_CREATED category.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the prorate amount or settlement value is denominated (e.g., USD, EUR, GBP). Applies to FIXED_AMOUNT and PERCENTAGE agreement types.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination point of the interline route or market to which this prorate agreement applies.. Valid values are `^[A-Z]{3}$`',
    `directionality` STRING COMMENT 'Indicates whether the prorate agreement applies to one-way (OW), round-trip (RT), or circle-trip (CT) itineraries. Aligns with IATA fare directionality conventions.. Valid values are `OW|RT|CT`',
    `dispute_status` STRING COMMENT 'Indicates whether the proration transaction or agreement is subject to an interline billing dispute: NONE (no dispute), DISPUTED (partner carrier has raised a dispute), UNDER_REVIEW (dispute under investigation), RESOLVED (dispute settled).. Valid values are `NONE|DISPUTED|UNDER_REVIEW|RESOLVED`',
    `effective_date` DATE COMMENT 'Date from which the interline prorate agreement becomes binding and applicable to interline revenue splits. EFFECTIVE_FROM category.',
    `expiry_date` DATE COMMENT 'Date on which the interline prorate agreement ceases to be binding. Null indicates an open-ended agreement with no defined termination date. EFFECTIVE_UNTIL category.',
    `fare_basis_code` STRING COMMENT 'Fare basis code restricting the applicability of this prorate agreement to a specific fare product or fare family. Null if the agreement applies across all fare basis codes in the market.',
    `global_indicator` STRING COMMENT 'Two-letter IATA global indicator code defining the geographic routing area applicable to this prorate agreement (e.g., AT for Atlantic, PA for Pacific, AP for Asia-Pacific, EH for Eastern Hemisphere). Constrains the routing scope of the agreement.. Valid values are `^[A-Z]{2}$`',
    `iata_conference_area` STRING COMMENT 'IATA Traffic Conference area applicable to this prorate agreement: TC1 (Americas), TC2 (Europe, Middle East, Africa), TC3 (Asia-Pacific). Determines the IATA tariff conference jurisdiction governing the agreement.. Valid values are `TC1|TC2|TC3`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline prorate record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). RECORD_AUDIT_UPDATED category.',
    `maximum_prorate_amount` DECIMAL(18,2) COMMENT 'Ceiling value for the prorate allocation in the agreement currency. Caps the carriers revenue share to prevent over-recovery on high-yield itineraries under fixed-factor agreements.',
    `minimum_prorate_amount` DECIMAL(18,2) COMMENT 'Floor value for the prorate allocation in the agreement currency. Ensures the carrier receives at least this amount regardless of the calculated prorate factor or percentage. Protects against under-recovery on low-yield itineraries.',
    `notes` STRING COMMENT 'Free-text field for additional remarks, special conditions, or negotiation notes associated with the interline prorate agreement or transaction. Used by revenue management analysts for context not captured in structured fields.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the origin point of the interline route or market to which this prorate agreement applies.. Valid values are `^[A-Z]{3}$`',
    `own_carrier_code` STRING COMMENT 'Two-character IATA airline designator code of the operating airline (the airline owning this record) that is party to the prorate agreement.. Valid values are `^[A-Z0-9]{2}$`',
    `partner_carrier_code` STRING COMMENT 'Two-character IATA airline designator code of the interline partner carrier participating in the prorate agreement. Identifies the counterparty airline for revenue split purposes.. Valid values are `^[A-Z0-9]{2}$`',
    `passenger_type_code` STRING COMMENT 'Three-letter IATA Passenger Type Code (PTC) indicating the passenger category (e.g., ADT for adult, CHD for child, INF for infant) to which this prorate agreement applies. Null if applicable to all passenger types.. Valid values are `^[A-Z]{3}$`',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record (PNR) locator from the Amadeus Altéa PSS or GDS, linking the proration transaction to the passenger booking record.. Valid values are `^[A-Z0-9]{6}$`',
    `prorate_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount allocated to this carrier under the prorate agreement, expressed in the agreement currency. Used for FIXED_AMOUNT agreement types where a specific dollar/currency value is agreed rather than a factor or percentage.',
    `prorate_basis` STRING COMMENT 'The underlying basis on which proration is computed: FARE (based on published fare components), MILEAGE (based on IATA TPM/MPM mileage), WEIGHT (cargo weight-based, for cargo interline), or REVENUE (based on actual collected revenue).. Valid values are `FARE|MILEAGE|WEIGHT|REVENUE`',
    `prorate_factor` DECIMAL(18,2) COMMENT 'Numeric prorate factor (ratio) applied to the total fare to determine the revenue share allocated to this carriers segment of the interline journey. Used for IATA_PRF and MILEAGE agreement types. Value between 0 and 1 representing the carriers proportional share.',
    `prorate_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total interline fare revenue allocated to this carrier under the prorate agreement. Used for PERCENTAGE agreement types. Value between 0.0000 and 100.0000.',
    `prorated_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue amount allocated to the own carrier after applying the prorate factor, percentage, or fixed amount to the collected fare. This is the carriers actual revenue share from the interline itinerary. MONETARY_TRIPLET — net total.',
    `record_type` STRING COMMENT 'Discriminator indicating whether this record represents a prorate AGREEMENT (the standing agreement defining split rules) or a TRANSACTION (an actual proration event applied to a settled interline billing).. Valid values are `AGREEMENT|TRANSACTION`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes, fees, and surcharges (e.g., PFC, government taxes, fuel surcharges) associated with the interline proration transaction. Excluded from the prorate base fare calculation per IATA standards. MONETARY_TRIPLET — adjustment amount.',
    `ticketing_carrier_code` STRING COMMENT 'Two-character IATA airline designator code of the carrier that issued the ticket for the interline itinerary. The ticketing carrier may differ from the operating carrier and determines BSP/ARC settlement responsibility.. Valid values are `^[A-Z0-9]{2}$`',
    `transaction_date` DATE COMMENT 'Date on which the actual proration transaction was applied to a settled interline billing. Populated only for TRANSACTION record types; null for AGREEMENT records. BUSINESS_EVENT_TIMESTAMP category.',
    `via_airport_code` STRING COMMENT 'Three-letter IATA airport code for an intermediate connecting point that further qualifies the applicable market for this prorate agreement. Null if the agreement applies to all routings between origin and destination.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_interline_prorate PRIMARY KEY(`interline_prorate_id`)
) COMMENT 'Interline prorate agreement and proration record defining how revenue from a multi-carrier itinerary is split between participating airlines. Captures prorate agreement type (IATA pro-rate factor/mileage/specific prorate agreement), partner carrier code, applicable route/market, prorate factor or amount, currency, effective and expiry dates, agreement reference number, and proration calculation method. Also stores actual proration transaction records for settled interline billing. Aligns with IATA interline billing and settlement standards.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`fare_family` (
    `fare_family_id` BIGINT COMMENT 'Unique surrogate identifier for the fare family (branded fare) record in the revenue management system. Primary key for this entity.',
    `advance_purchase_days` STRING COMMENT 'Minimum number of days before departure that a ticket must be purchased under this fare family. Zero indicates no advance purchase requirement. Aligns with ATPCO Category 5 advance purchase rules.',
    `ancillary_bundle_code` STRING COMMENT 'Reference code identifying the ancillary services bundle configuration associated with this fare family in the ancillary revenue management system. Links to the specific set of included and excluded ancillary services (EMD-eligible items) for merchandising.. Valid values are `^[A-Z0-9]{2,15}$`',
    `brand_name` STRING COMMENT 'Commercial marketing name of the fare family as displayed to passengers across all sales channels (e.g., Basic Economy, Standard, Flex, Business Lite, Business Plus). This is the customer-facing label used in GDS displays, NDC offers, and airline.com.',
    `cabin_class` STRING COMMENT 'Physical cabin of the aircraft to which this fare family applies. Determines the seating product and service level associated with the branded fare. Aligns with IATA cabin class designations.. Valid values are `ECONOMY|PREMIUM_ECONOMY|BUSINESS|FIRST`',
    `carrier_code` STRING COMMENT 'Two-letter IATA airline designator code of the carrier that owns and markets this fare family. Used to scope the branded fare to a specific operating or marketing carrier in multi-carrier environments.. Valid values are `^[A-Z0-9]{2}$`',
    `carry_on_bags_included` STRING COMMENT 'Number of carry-on bags included in the fare family at no additional charge. Zero indicates no carry-on is included (e.g., Basic Economy). Used for ancillary merchandising and EMD issuance logic.',
    `change_fee_amount` DECIMAL(18,2) COMMENT 'Flat fee in the fare familys base currency charged to the passenger for changing an itinerary when change_permitted is true. Zero indicates a fee-free change. Null indicates changes are not permitted.',
    `change_permitted` BOOLEAN COMMENT 'Indicates whether the passenger is permitted to change the itinerary (date, routing, or flight) on a ticket issued under this fare family. When true, change_fee_amount may apply.',
    `checked_bags_included` STRING COMMENT 'Number of checked baggage pieces included in the fare family at no additional charge. Drives ancillary upsell logic and EMD issuance in Amadeus Altéa. Reported per DOT baggage disclosure requirements.',
    `combinability_permitted` BOOLEAN COMMENT 'Indicates whether fares within this fare family may be combined with fares from other fare families or carriers to construct a round-trip or multi-sector itinerary. Aligns with ATPCO Category 10 combinability rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp (ISO 8601 with timezone offset) when this fare family record was first created in the revenue management system. Provides audit trail for fare family lifecycle management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which change_fee_amount and refund_fee_amount are denominated (e.g., USD, EUR, GBP). Aligns with IATA BSP settlement currency conventions.. Valid values are `^[A-Z]{3}$`',
    `discontinue_date` DATE COMMENT 'Calendar date after which this fare family is no longer available for new bookings. Null indicates the fare family is open-ended with no planned end date. Aligns with ATPCO discontinue date conventions.',
    `display_priority` STRING COMMENT 'Integer ranking that controls the display order of fare families in shopping results across GDS, NDC, and direct channels. Lower values indicate higher display priority (e.g., 1 = displayed first). Used by Sabre AirVision and Amadeus Altéa for branded fare shelf ordering.',
    `effective_date` DATE COMMENT 'Calendar date from which this fare family becomes commercially active and available for sale across all applicable channels. Aligns with ATPCO fare filing effective date conventions.',
    `family_status` STRING COMMENT 'Current operational status of the fare family in the revenue management and merchandising system. ACTIVE = currently sold; DRAFT = under configuration; RETIRED = no longer sold; SUSPENDED = temporarily withdrawn from sale.. Valid values are `ACTIVE|INACTIVE|DRAFT|RETIRED|SUSPENDED`',
    `fare_class_mapping` STRING COMMENT 'Comma-separated list of one-letter IATA booking class codes (RBDs) that are associated with this fare family (e.g., Y,B,M,H). Defines which inventory buckets in Amadeus Altéa and Sabre AirVision are merchandised under this branded fare.',
    `fare_family_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the fare family across GDS, NDC, and direct channels (e.g., BASICECO, FLEX, BIZPLUS). Used as the business key in Sabre AirVision and distributed to Amadeus Altéa for branded fare merchandising.. Valid values are `^[A-Z0-9]{2,10}$`',
    `gds_display_indicator` BOOLEAN COMMENT 'Indicates whether this fare family is visible and bookable through Global Distribution System (GDS) channels (e.g., Amadeus, Sabre, Travelport). When false, the fare family is restricted to direct or NDC channels only.',
    `interline_permitted` BOOLEAN COMMENT 'Indicates whether tickets issued under this fare family may be used on interline partner carrier segments. When false, the fare family is restricted to the issuing carriers own-metal flights only.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp (ISO 8601 with timezone offset) when this fare family record was most recently modified in the revenue management system. Used for change data capture (CDC) and incremental lakehouse ingestion.',
    `lounge_access_included` BOOLEAN COMMENT 'Indicates whether complimentary airport lounge access is included as part of this fare familys service bundle. Typically applicable to premium cabin fare families (Business Plus, First).',
    `marketing_description` STRING COMMENT 'Short customer-facing marketing description of the fare familys value proposition, displayed in booking flows and GDS/NDC shopping responses (e.g., Our most flexible fare with full refund and free seat selection). Maximum 500 characters.',
    `maximum_stay_days` STRING COMMENT 'Maximum number of days the passenger may remain at the destination before returning, as required by this fare familys conditions. Null indicates no maximum stay restriction. Aligns with ATPCO Category 7.',
    `meal_service_type` STRING COMMENT 'Type of complimentary meal or catering service included with this fare family. NONE = no complimentary meal; SNACK = light snack; MEAL = standard meal; PREMIUM_MEAL = enhanced meal selection; MULTI_COURSE = full multi-course dining (typically First/Business).. Valid values are `NONE|SNACK|MEAL|PREMIUM_MEAL|MULTI_COURSE`',
    `miles_accrual_rate` DECIMAL(18,2) COMMENT 'Percentage of base miles earned per Revenue Passenger Kilometer (RPK) flown under this fare family, expressed as a decimal multiplier (e.g., 0.50 = 50%, 1.00 = 100%, 1.50 = 150%). Feeds Oracle Loyalty Cloud FFP mileage posting logic.',
    `minimum_stay_days` STRING COMMENT 'Minimum number of days the passenger must remain at the destination before returning, as required by this fare familys conditions. Zero or null indicates no minimum stay requirement. Aligns with ATPCO Category 6.',
    `ndc_eligible` BOOLEAN COMMENT 'Indicates whether this fare family is available for distribution via IATA New Distribution Capability (NDC) API channels, enabling rich offer and order management with full ancillary bundling.',
    `passenger_type_code` STRING COMMENT 'Three-letter IATA Passenger Type Code (PTC) indicating the passenger category eligible for this fare family (e.g., ADT = Adult, CHD = Child, INF = Infant, MIL = Military). Null indicates the fare family applies to all passenger types.. Valid values are `^[A-Z]{3}$`',
    `priority_boarding_included` BOOLEAN COMMENT 'Indicates whether priority boarding is included as part of this fare familys service bundle, allowing passengers to board before general boarding groups.',
    `refund_fee_amount` DECIMAL(18,2) COMMENT 'Flat fee in the fare familys base currency charged to the passenger when processing a refund where refund_permitted is true. Zero indicates a fee-free refund. Null indicates refunds are not permitted.',
    `refund_permitted` BOOLEAN COMMENT 'Indicates whether a refund to the original form of payment is permitted for tickets issued under this fare family. Drives refund eligibility logic in Amadeus Altéa and BSP/ARC settlement processing.',
    `route_applicability` STRING COMMENT 'Geographic scope of routes to which this fare family applies. DOMESTIC = within a single country; INTERNATIONAL = cross-border; TRANSOCEANIC = long-haul intercontinental; ALL = no geographic restriction.. Valid values are `DOMESTIC|INTERNATIONAL|TRANSOCEANIC|ALL`',
    `sabre_brand_code` STRING COMMENT 'Native brand identifier assigned to this fare family within the Sabre AirVision Revenue Management system. Used for system-of-record traceability and reconciliation between the lakehouse silver layer and the operational Sabre environment.. Valid values are `^[A-Z0-9]{1,20}$`',
    `seat_selection_included` STRING COMMENT 'Level of complimentary seat selection included with this fare family. NONE = no free seat selection; STANDARD = standard seats only; PREFERRED = preferred/extra-legroom seats; ANY = unrestricted seat selection including premium seats.. Valid values are `NONE|STANDARD|PREFERRED|ANY`',
    `tier_level` STRING COMMENT 'Numeric tier ranking of this fare family within its cabin class, used for upsell and cross-sell logic (e.g., 1 = entry-level Basic Economy, 2 = Standard, 3 = Flex within Economy cabin). Enables structured upsell path configuration in Sabre AirVision.',
    `upgrade_eligible` BOOLEAN COMMENT 'Indicates whether tickets issued under this fare family are eligible for complimentary or paid cabin upgrades (e.g., using miles, cash, or status). Feeds upgrade inventory logic in Amadeus Altéa.',
    `wifi_included` BOOLEAN COMMENT 'Indicates whether complimentary in-flight Wi-Fi connectivity is included as part of this fare familys ancillary service bundle.',
    CONSTRAINT pk_fare_family PRIMARY KEY(`fare_family_id`)
) COMMENT 'Fare family (branded fare) master record defining a named bundle of fare conditions and ancillary inclusions marketed under a commercial brand name (e.g., Basic Economy, Standard, Flex, Business Lite, Business Plus). Captures fare family code, commercial brand name, cabin applicability, included services (carry-on baggage, checked baggage, seat selection, lounge access, miles accrual rate, change/refund conditions), fare class mapping, display priority, and marketing description. Enables branded fare merchandising across GDS, NDC, and direct channels.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`corporate_contract` (
    `corporate_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the corporate travel contract record in the revenue management system. Primary key for this entity.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account or Travel Management Company (TMC) that is party to this contract. Links to the corporate account master record.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the airlines account manager responsible for managing and maintaining this corporate contract relationship. Links to the workforce/HR employee master.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Corporate contracts frequently specify aircraft type restrictions (widebody-only for long-haul, specific cabin configurations). Contract compliance validation, pricing accuracy, and inventory allocati',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to ancillary.bundle. Business justification: Corporate contracts negotiate specific ancillary bundle inclusions (e.g., free checked bags, lounge access for all travelers). Contract management and corporate booking tools require this link to enfo',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Corporate contracts often specify which fare families (branded fares) are eligible under the contract. The applicable_cabin_classes and applicable_booking_classes attributes suggest fare family applic',
    `ffp_member_id` BIGINT COMMENT 'Foreign key linking to loyalty.ffp_member. Business justification: Corporate contracts often specify individual traveler FFP accounts for mileage accrual despite company payment. Tracks personal loyalty benefits within corporate travel programs. New attribute; no exi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Corporate travel contracts often specify preferred ground handlers, catering suppliers, or FBO services as part of negotiated packages. Airlines track these vendor preferences to ensure contract compl',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Corporate discount contracts often require regulatory filing under bilateral air service agreements and government contract disclosure rules. DOT requires filing of certain corporate agreements; inter',
    `advance_purchase_days` STRING COMMENT 'Minimum number of days before departure that a booking must be made to qualify for the negotiated corporate fare. Zero indicates no advance purchase requirement.',
    `applicable_booking_classes` STRING COMMENT 'Pipe-delimited list of RBD (Reservation Booking Designator) booking class codes to which this contracts fares apply (e.g., Y|B|M|K). Governs inventory access in the Amadeus Altéa PSS.',
    `applicable_cabin_classes` STRING COMMENT 'Pipe-delimited list of cabin classes to which the negotiated fares or discounts under this contract apply (e.g., Y|C|F for Economy, Business, First). Aligns with IATA cabin class designators.',
    `auto_renewal_indicator` BOOLEAN COMMENT 'Indicates whether this corporate contract is set to automatically renew upon reaching the expiry date without requiring a new signed agreement. True = auto-renews; False = requires manual renewal.',
    `blackout_dates` STRING COMMENT 'Pipe-delimited list of specific dates or date ranges (in yyyy-MM-dd format) during which the corporate contract fares are not applicable (e.g., peak holiday periods, major events). Stored as a structured string for downstream parsing.',
    `carrier_code` STRING COMMENT 'IATA two-letter designator of the operating or marketing carrier to which this corporate contract applies. Relevant for codeshare and interline agreements where the contracting carrier may differ from the operating carrier.. Valid values are `^[A-Z0-9]{2}$`',
    `changeable_indicator` BOOLEAN COMMENT 'Indicates whether tickets issued under this corporate contract permit voluntary changes (rebooking). True = changes permitted; False = no changes allowed. Governs change fee waiver rules.',
    `commission_override_rate` DECIMAL(18,2) COMMENT 'Negotiated commission rate (as a percentage) paid to the TMC or travel agent above the standard base commission, applicable when contract_type is commission_override. Expressed as a percentage (e.g., 5.00 = 5%).',
    `contract_name` STRING COMMENT 'Descriptive name of the corporate contract, typically including the corporate account name and contract year (e.g., Acme Corp Global Agreement 2024). Used for display and reporting purposes.',
    `contract_number` STRING COMMENT 'Externally-known unique reference number assigned to the corporate contract, used in correspondence with the corporate account and TMC. Serves as the business identifier across systems including Sabre AirVision and SAP S/4HANA.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the corporate contract. Draft: under negotiation. Active: in force and bookable. Expired: past end date. Suspended: temporarily halted. Terminated: cancelled before end date.. Valid values are `draft|active|expired|suspended|terminated`',
    `contract_type` STRING COMMENT 'Classification of the pricing mechanism governing this corporate agreement. Net fare: fixed negotiated fare net of commission. Discount: percentage reduction off published fare. Commission override: elevated agency commission. Soft dollar: non-cash incentive credits. Zone fare: flat fare within a geographic zone.. Valid values are `net_fare|discount|commission_override|soft_dollar|zone_fare`',
    `corporate_contact_email` STRING COMMENT 'Email address of the primary contact person at the corporate account or TMC for contract-related communications, reporting delivery, and renewal notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `corporate_contact_name` STRING COMMENT 'Full name of the primary contact person at the corporate account or TMC who is the counterpart for this contract. Used for contract correspondence and account management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate contract record was first created in the revenue management system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary values (net fare amounts, volume commitments, soft dollar credits) under this contract are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_airport_codes` STRING COMMENT 'Pipe-delimited list of IATA three-letter airport codes representing the destination points covered by this corporate contract. Null or wildcard indicates all destinations are applicable.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated percentage discount applied to the applicable published or base fare for this corporate contract. Expressed as a percentage (e.g., 15.00 = 15%). Applicable when contract_type is discount. Null for net_fare or commission_override contracts.',
    `effective_date` DATE COMMENT 'Date from which the corporate contract terms become binding and fares are bookable. Aligns with ATPCO fare filing effective dates where applicable.',
    `expiry_date` DATE COMMENT 'Date on which the corporate contract ceases to be binding. After this date, fares under this contract are no longer bookable unless the contract is renewed. Nullable for open-ended agreements.',
    `gds_corporate_code` STRING COMMENT 'Unique corporate code loaded into the Global Distribution System (GDS) — such as Amadeus, Sabre, or Travelport — that travel agents and TMCs use to access the negotiated corporate fares when booking on behalf of the corporate account.. Valid values are `^[A-Z0-9]{3,8}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this corporate contract record in the revenue management system. Used for change tracking, audit compliance, and incremental data pipeline processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `min_revenue_commitment` DECIMAL(18,2) COMMENT 'Minimum annual or contract-period revenue (in contract currency) that the corporate account commits to generate under this agreement. Used for volume-based tier qualification and rebate calculations.',
    `min_segment_commitment` STRING COMMENT 'Minimum number of flight segments the corporate account commits to book with the airline during the contract period. Used alongside or as an alternative to min_revenue_commitment for volume qualification.',
    `net_fare_amount` DECIMAL(18,2) COMMENT 'Fixed negotiated net fare amount agreed under this corporate contract, net of all commissions and agency fees. Applicable when contract_type is net_fare. Expressed in the contract currency.',
    `origin_airport_codes` STRING COMMENT 'Pipe-delimited list of IATA three-letter airport codes representing the origin points covered by this corporate contract. Null or wildcard indicates all origins are applicable.',
    `pnr_corporate_code` STRING COMMENT 'Corporate identifier embedded in the PNR (Passenger Name Record) to associate bookings with this corporate contract for tracking, reporting, and volume measurement purposes within the Amadeus Altéa PSS.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Percentage rebate paid back to the corporate account when volume commitments are met or exceeded. Expressed as a percentage of qualifying revenue (e.g., 3.00 = 3%).',
    `rebate_threshold_amount` DECIMAL(18,2) COMMENT 'Revenue threshold (in contract currency) that the corporate account must exceed to qualify for a volume rebate payment. When actual revenue exceeds this threshold, the rebate_rate applies to the qualifying spend.',
    `refundable_indicator` BOOLEAN COMMENT 'Indicates whether tickets issued under this corporate contract are refundable. True = refundable; False = non-refundable. Governs refund processing in the Amadeus Altéa PSS.',
    `renewal_date` DATE COMMENT 'Scheduled date for contract renewal review or automatic renewal. Used by account managers to trigger renegotiation workflows ahead of expiry.',
    `reporting_requirement` STRING COMMENT 'Frequency at which the airline is contractually obligated to provide travel and spend reports to the corporate account or TMC. Drives automated report scheduling in the revenue management system.. Valid values are `none|monthly|quarterly|annual|on_demand`',
    `signing_date` DATE COMMENT 'Date on which the corporate contract was formally executed and signed by both the airline and the corporate account or TMC. Used for audit and legal compliance tracking.',
    `soft_dollar_credit_amount` DECIMAL(18,2) COMMENT 'Total non-cash incentive credit amount committed under this contract for soft dollar arrangements (e.g., upgrades, lounge access, marketing co-op funds). Applicable when contract_type is soft_dollar. Expressed in contract currency.',
    `volume_measurement_period` STRING COMMENT 'The time period over which minimum volume commitments (revenue or segment) are measured and evaluated for compliance and rebate qualification.. Valid values are `annual|semi_annual|quarterly|contract_period`',
    CONSTRAINT pk_corporate_contract PRIMARY KEY(`corporate_contract_id`)
) COMMENT 'Corporate travel contract record defining negotiated fare agreements between the airline and corporate accounts or travel management companies (TMCs). Captures contract reference number, corporate account name and ID, contract type (net fare/discount/commission override/soft dollar), applicable markets and routes, discount percentage or net fare amounts, minimum volume commitment (revenue or segment targets), contract period, blackout dates, reporting requirements, account manager, and contract status (draft/active/expired/suspended). SSOT for corporate pricing and B2B revenue agreements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`revenue_refund` (
    `revenue_refund_id` BIGINT COMMENT 'Primary key for refund',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Refunds create AP obligations to passengers or agents. Required for cash disbursement processing and AP aging.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to revenue.agency. Business justification: Refunds processed through travel agencies should reference the agency master. The travel_agent_iata_code attribute in revenue_refund should reference the authoritative agency record. Standard N:1 rela',
    `arc_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.arc_settlement. Business justification: Refunds processed through ARC channels are included in ARC settlement batches. The bsp_arc_settlement_date attribute suggests settlement tracking. This should be a FK to the authoritative arc_settleme',
    `bsp_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.bsp_settlement. Business justification: Refunds processed through BSP channels are included in BSP settlement batches. The bsp_arc_settlement_date attribute suggests settlement tracking. This should be a FK to the authoritative bsp_settleme',
    `employee_id` BIGINT COMMENT 'Identifier of the airline agent, travel agent IATA code, or automated system (e.g., AUTO-IROP-ENGINE) that approved the refund. Used for audit, fraud detection, and agent performance tracking. Populated with a system identifier when approval is automated.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Refunds resulting from maintenance-induced cancellations/delays must link to causative work orders for cost recovery from maintenance providers, dispute resolution, and operational impact tracking. Cr',
    `profile_id` BIGINT COMMENT 'Reference to the passenger (traveller) record who is the beneficiary of this refund. Links to the passenger master data entity in the Passenger domain.',
    `revenue_emd_id` BIGINT COMMENT 'Foreign key linking to revenue.emd. Business justification: revenue_refund can also process refunds for EMDs (ancillary services). Each refund may reference one EMD. The table has original_emd_number (STRING) as a business key. Adding emd_id FK to emd.emd_id e',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: revenue_refund captures refund transactions for tickets. Each refund references one original ticket. The table has original_ticket_number (STRING) as a business key. Adding ticket_id FK to ticket.reve',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when the refund was approved by an authorised agent or automated revenue management rule engine. Distinct from the processed timestamp; captures the approval decision event in the refund workflow lifecycle.',
    `bsp_arc_settlement_date` DATE COMMENT 'The date on which the refund amount was settled through the IATA Billing and Settlement Plan (BSP) or Airlines Reporting Corporation (ARC) settlement cycle. Null for direct refunds or miles refunds not routed through BSP/ARC.',
    `cabin_class` STRING COMMENT 'The cabin class of the original ticket being refunded. F — First Class; C — Business Class; W — Premium Economy; Y — Economy. Used for revenue reversal reporting segmented by cabin.. Valid values are `F|C|W|Y`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this refund transaction record was first created in the lakehouse silver layer. Audit trail field for data lineage and record provenance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts on this refund transaction are expressed (e.g., USD, EUR, GBP). Aligns with the currency of the original ticket sale.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code of the final destination on the original ticket or EMD being refunded. Used for revenue reversal reporting by route and for regulatory reporting to DOT.. Valid values are `^[A-Z]{3}$`',
    `fare_amount` DECIMAL(18,2) COMMENT 'The net base fare amount approved for refund after deducting any applicable cancellation penalty from the gross fare amount. This is the fare component of the total refund disbursement. Expressed in the transaction currency.',
    `fare_basis_code` STRING COMMENT 'The ATPCO fare basis code of the original fare being refunded (e.g., YLOWUS, QSAVER). Determines the applicable refund and penalty rules per ATPCO Category 16. Sourced from the original ticket coupon data in Amadeus Altéa PSS.',
    `ffp_miles_refunded` STRING COMMENT 'Number of Frequent Flyer Program (FFP) miles credited back to the passengers loyalty account as the refund method, or miles reinstated when an award ticket is cancelled. Populated only when refund_method is miles. Interfaces with Oracle Loyalty Cloud FFP Management.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger (GL) account code to which the revenue reversal entry for this refund is posted (e.g., revenue reversal account, refund liability account). Enables reconciliation between the refund transaction system and the financial accounting system.',
    `gross_fare_amount` DECIMAL(18,2) COMMENT 'The total base fare amount on the original ticket or EMD before any taxes, fees, or surcharges. Represents the revenue component subject to refund calculation and penalty deduction. Expressed in the transaction currency.',
    `involuntary_reason` STRING COMMENT 'For involuntary refunds, the specific airline-caused reason triggering the mandatory refund obligation. flight_cancellation — flight cancelled by airline; significant_delay — delay exceeding regulatory threshold; denied_boarding — involuntary denied boarding (IDB); downgrade — passenger downgraded to lower cabin; schedule_change — schedule change beyond passenger tolerance. Null for voluntary refunds.. Valid values are `flight_cancellation|significant_delay|denied_boarding|downgrade|schedule_change`',
    `issuing_airline_code` STRING COMMENT 'Two-character IATA carrier code of the airline that originally issued the ticket or EMD being refunded. May differ from the operating carrier in codeshare or interline scenarios. Used for BSP/ARC settlement routing.. Valid values are `^[A-Z0-9]{2,3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this refund transaction record was last modified in the lakehouse silver layer. Used for incremental data pipeline processing and audit trail maintenance.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code of the origin point on the original ticket or EMD being refunded. Used for revenue reversal reporting by route and for regulatory reporting to DOT.. Valid values are `^[A-Z]{3}$`',
    `original_departure_date` DATE COMMENT 'The scheduled departure date of the first flight segment on the original ticket. Used to determine refund eligibility windows, advance purchase rule compliance, and revenue period attribution for accounting.',
    `original_form_of_payment_code` STRING COMMENT 'IATA-standard form of payment code from the original ticket transaction (e.g., CC — credit card, CA — cash, CK — check, MS — miscellaneous, TP — tour order). Required for original_form_of_payment refund method to route the credit correctly through BSP or ARC settlement.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount deducted from the gross fare amount per the fare rule conditions (e.g., ATPCO Category 16 — Penalties). Zero for involuntary refunds and IROP refunds where no penalty applies. Expressed in the transaction currency.',
    `pnr_code` STRING COMMENT 'Six-character alphanumeric Passenger Name Record (PNR) locator code in the Amadeus Altéa PSS associated with the original booking from which this refund originates. Links the refund to the reservation context.. Valid values are `^[A-Z0-9]{6}$`',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when the refund was fully processed and funds were disbursed or credit was issued. Used to calculate refund processing duration for DOT compliance (7-day rule for credit card refunds, 20-day rule for cash/check). Null if not yet processed.',
    `reason_code` STRING COMMENT 'Standardised IATA or carrier-defined reason code identifying the specific cause of the refund (e.g., CANX — flight cancelled, DELY — significant delay, INVOL — involuntary reroute, SKED — schedule change, VOLU — voluntary cancellation). Sourced from Sabre AirVision Revenue Management and Amadeus Altéa PSS refund reason tables. [ENUM-REF-CANDIDATE: CANX|DELY|INVOL|SKED|VOLU|DNBD|WVNO|MEDX|BEAV|DUPL — promote to reference product]',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to this refund transaction by the Passenger Service System (PSS) or revenue accounting system. Used for passenger and agent communication and BSP/ARC settlement tracking.',
    `refund_method` STRING COMMENT 'The method by which the refund value is returned to the passenger or agent. original_form_of_payment — credit back to the original payment instrument; voucher — travel credit voucher issued; miles — Frequent Flyer Program (FFP) miles credited; cash — physical cash refund at airport; bank_transfer — direct bank transfer; check — paper check issued.. Valid values are `original_form_of_payment|voucher|miles|cash|bank_transfer|check`',
    `refund_status` STRING COMMENT 'Current workflow lifecycle state of the refund transaction. requested — refund application received; approved — authorised by agent or automated rule; processed — funds disbursed or credit issued; rejected — refund denied; pending — awaiting additional information or system processing.. Valid values are `requested|approved|processed|rejected|pending`',
    `refund_type` STRING COMMENT 'Classification of the reason category driving the refund. voluntary — passenger-initiated cancellation; involuntary — airline-initiated cancellation or denial of boarding; irop — Irregular Operations (IROP) such as flight cancellation or significant delay; schedule_change — airline schedule change exceeding MCT or passenger tolerance thresholds; no_show_waiver — waiver granted for no-show penalty under exceptional circumstances.. Valid values are `voluntary|involuntary|irop|schedule_change|no_show_waiver`',
    `request_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when the refund was formally requested by the passenger, travel agent, or automated system. This is the principal business event timestamp for the refund lifecycle and is used for DOT refund processing time compliance measurement.',
    `sales_channel` STRING COMMENT 'The distribution channel through which the original ticket was sold, which determines the refund routing and settlement process. direct — airline website or app; gds — Global Distribution System (GDS) such as Amadeus or Sabre; ota — Online Travel Agency; airport — airport ticket office; call_center — airline reservations call centre; interline — interline ticketing agreement.. Valid values are `direct|gds|ota|airport|call_center|interline`',
    `tax_breakdown_json` STRING COMMENT 'Serialised JSON string containing the itemised breakdown of individual tax and fee components included in the tax_refund_amount (e.g., {"US": 12.50, "XF": 4.50, "AY": 5.60}). Each key is the IATA tax code and the value is the refund amount for that tax. Required for regulatory tax reporting and passenger transparency.',
    `tax_refund_amount` DECIMAL(18,2) COMMENT 'Total amount of government taxes and airport fees refunded to the passenger. Taxes are generally refundable even when the fare is non-refundable (e.g., Passenger Facility Charges (PFC), government-imposed taxes). Expressed in the transaction currency.',
    `total_refund_amount` DECIMAL(18,2) COMMENT 'The total monetary amount disbursed to the passenger or agent, equal to refund_fare_amount plus tax_refund_amount. This is the net settlement value of the refund transaction. Expressed in the transaction currency. Used for revenue reversal accounting in SAP S/4HANA FI/CO.',
    `voucher_number` STRING COMMENT 'Unique identifier of the travel credit voucher issued to the passenger when refund_method is voucher. Used to track voucher liability on the balance sheet and redemption against future bookings. Null when refund method is not voucher.',
    `waiver_code` STRING COMMENT 'Airline-issued waiver code authorising the override of standard fare rule penalty conditions (e.g., weather waiver, pandemic waiver, operational disruption waiver). When populated, the penalty_amount is typically zero. Sourced from Sabre AirVision Revenue Management waiver management module.',
    CONSTRAINT pk_revenue_refund PRIMARY KEY(`revenue_refund_id`)
) COMMENT 'Refund transaction record capturing the processing of a ticket or EMD refund to a passenger or agent. Stores refund reference number, original ticket/EMD number, refund type (voluntary/involuntary/IROP/schedule change), refund amount, penalty amount deducted, tax refund breakdown, refund method (original form of payment/voucher/miles), refund request date, processing date, refund status (requested/approved/processed/rejected/pending), approving agent or system, and BSP/ARC refund indicator. SSOT for refund liability management and revenue reversal accounting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`ticket_exchange` (
    `ticket_exchange_id` BIGINT COMMENT 'Primary key for ticket_exchange',
    `agency_id` BIGINT COMMENT 'Foreign key linking to revenue.agency. Business justification: Ticket exchanges processed through travel agencies should reference the agency master. Standard N:1 relationship. No bidirectional conflict.',
    `arc_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.arc_settlement. Business justification: Ticket exchanges processed through ARC channels are included in ARC settlement batches. The settlement_plan_type attribute suggests settlement tracking. This should be a FK to the authoritative arc_se',
    `bsp_settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.bsp_settlement. Business justification: Ticket exchanges (reissues) processed through BSP channels are included in BSP settlement batches. The settlement_plan_type attribute suggests settlement tracking. This should be a FK to the authorita',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Exchange transactions post to GL for revenue adjustments (fare differences, penalties). Required for accurate revenue recognition and financial reporting.',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Involuntary exchanges due to safety-related disruptions (aircraft swaps for technical issues, flight cancellations due to safety concerns). Business process for waiver code application and revenue pro',
    `org_unit_id` BIGINT COMMENT 'IATA-assigned office or agency identifier (IATA numeric code or pseudo-city code) of the entity that processed the ticket exchange. Used for BSP settlement attribution, agency commission tracking, and ARC reporting.',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: ticket_exchange captures voluntary or involuntary ticket modifications (reissues). Each exchange references an original ticket being exchanged. The table has original_ticket_number (STRING) as a busin',
    `profile_id` BIGINT COMMENT 'Reference to the passenger profile record for whom the ticket exchange was performed. Serves as the PARTY_REFERENCE linking this transaction to the traveller.',
    `collection_method` STRING COMMENT 'Method by which any additional fare difference or penalty was collected from the passenger. EMD (Electronic Miscellaneous Document) is used for ancillary collections per IATA standards. Waived applies to involuntary exchanges. [ENUM-REF-CANDIDATE: cash|credit_card|emd|residual_value|waived — promote to reference product]. Valid values are `cash|credit_card|emd|residual_value|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this exchange transaction record was first captured in the Silver layer data product. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this exchange transaction are denominated (e.g., USD, EUR, GBP). Aligns with the point-of-sale currency at the time of exchange.. Valid values are `^[A-Z]{3}$`',
    `emd_number` STRING COMMENT '13-digit IATA Electronic Miscellaneous Document (EMD) number issued to collect the fare difference or penalty amount when the collection method is EMD. Null when collection is made by other means.. Valid values are `^[0-9]{13}$`',
    `exchange_date` TIMESTAMP COMMENT 'Principal business event timestamp recording the exact date and time (with timezone offset) when the ticket exchange transaction was executed in the PSS. Distinct from audit timestamps. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `exchange_reference_number` STRING COMMENT 'Externally-known business identifier for the ticket exchange transaction, typically generated by the Passenger Service System (PSS) or GDS at the time of reissue. Used for cross-system reconciliation and customer-facing reference.',
    `exchange_status` STRING COMMENT 'Current lifecycle status of the ticket exchange transaction. Pending indicates initiated but not finalized; completed indicates successfully processed; voided indicates cancelled before settlement; failed indicates processing error; reversed indicates post-completion reversal.. Valid values are `pending|completed|voided|failed|reversed`',
    `exchange_type` STRING COMMENT 'Classification of the reason or nature of the ticket exchange. Voluntary indicates passenger-initiated change; involuntary indicates airline-initiated change; upgrade/downgrade reflect cabin class changes; irop_reprotection covers Irregular Operations (IROP) rebooking; schedule_change covers airline schedule modifications. [ENUM-REF-CANDIDATE: voluntary|involuntary|upgrade|downgrade|irop_reprotection|schedule_change — promote to reference product]. Valid values are `voluntary|involuntary|upgrade|downgrade|irop_reprotection|schedule_change`',
    `fare_difference_amount` DECIMAL(18,2) COMMENT 'Net monetary difference between the new fare amount and the original fare amount (new_fare_amount minus original_fare_amount). A positive value indicates an additional collection (ADC) owed by the passenger; a negative value indicates a residual credit. Central to revenue impact tracking for ticket reissues.',
    `gds_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the Global Distribution System (GDS) — such as Amadeus or Sabre — at the time the exchange was processed. Used for cross-system reconciliation between the PSS and GDS settlement records.',
    `involuntary_reason_code` STRING COMMENT 'Airline-defined reason code specifying the cause of an involuntary ticket exchange (e.g., flight cancellation, significant schedule change, equipment downgrade, denied boarding). Populated only when exchange_type is involuntary or irop_reprotection. Required for DOT and EASA regulatory reporting on involuntary rerouting.',
    `issuing_carrier_code` STRING COMMENT 'IATA two-letter or ICAO three-letter airline designator code of the carrier that issued the new ticket. May differ from the operating carrier in codeshare or interline scenarios.. Valid values are `^[A-Z0-9]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this exchange transaction record was last modified in the Silver layer data product. Used for incremental load tracking and change detection. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `new_cabin_class` STRING COMMENT 'IATA cabin class code of the newly issued ticket after exchange. F=First, C=Business, W=Premium Economy, Y=Economy. Used in conjunction with original_cabin_class to classify upgrade or downgrade transactions.. Valid values are `F|C|W|Y`',
    `new_destination_airport_code` STRING COMMENT 'IATA three-letter airport code of the final destination on the newly issued ticket itinerary after exchange. Used for O&D revenue analysis and network planning.. Valid values are `^[A-Z]{3}$`',
    `new_fare_amount` DECIMAL(18,2) COMMENT 'Gross base fare amount of the newly issued ticket in the transaction currency, excluding taxes and fees. Used to compute the fare difference and assess revenue uplift or dilution from the exchange.',
    `new_fare_basis_code` STRING COMMENT 'IATA fare basis code of the newly issued ticket after exchange. Identifies the fare product, booking class, and applicable conditions governing the replacement itinerary. Used for revenue impact analysis and yield management reporting.. Valid values are `^[A-Z0-9]{1,10}$`',
    `new_origin_airport_code` STRING COMMENT 'IATA three-letter airport code of the origin point on the newly issued ticket itinerary after exchange. Used for route-level revenue impact analysis and yield management reporting.. Valid values are `^[A-Z]{3}$`',
    `new_ticket_number` STRING COMMENT '13-digit IATA e-ticket number of the newly issued ticket resulting from the exchange. Conforms to IATA standard ticket numbering. Used to link the exchange event to the replacement travel document.. Valid values are `^[0-9]{13}$`',
    `new_travel_date` DATE COMMENT 'Scheduled departure date of the first flight segment on the newly issued ticket itinerary after exchange. Used for demand forecasting, load factor impact assessment, and revenue period reporting.',
    `original_cabin_class` STRING COMMENT 'IATA cabin class code of the original ticket prior to exchange. F=First, C=Business, W=Premium Economy, Y=Economy. Used to identify upgrade/downgrade exchanges and assess revenue impact.. Valid values are `F|C|W|Y`',
    `original_destination_airport_code` STRING COMMENT 'IATA three-letter airport code of the final destination on the original ticket itinerary prior to exchange. Used for O&D (Origin and Destination) revenue analysis.. Valid values are `^[A-Z]{3}$`',
    `original_fare_amount` DECIMAL(18,2) COMMENT 'Gross base fare amount of the original ticket in the transaction currency, excluding taxes and fees. Used as the baseline for fare difference calculation and revenue accounting reconciliation.',
    `original_fare_basis_code` STRING COMMENT 'IATA fare basis code of the original ticket prior to exchange. Identifies the fare product, booking class, and applicable conditions that governed the original itinerary. Used for fare difference calculation and revenue accounting.. Valid values are `^[A-Z0-9]{1,10}$`',
    `original_origin_airport_code` STRING COMMENT 'IATA three-letter airport code of the origin point on the original ticket itinerary prior to exchange. Used for route-level revenue impact analysis and yield management reporting.. Valid values are `^[A-Z]{3}$`',
    `original_travel_date` DATE COMMENT 'Scheduled departure date of the first flight segment on the original ticket itinerary prior to exchange. Used for seasonality analysis, advance purchase tracking, and revenue accounting period alignment.',
    `passenger_type_code` STRING COMMENT 'IATA three-letter Passenger Type Code (PTC) applicable to the exchanged ticket (e.g., ADT=Adult, CHD=Child, INF=Infant, MIL=Military). Determines applicable fare rules, penalty waivers, and pricing logic for the exchange.. Valid values are `^[A-Z]{3}$`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Change fee or penalty amount charged to the passenger for the voluntary ticket exchange, as defined by the applicable fare rule. Zero for involuntary exchanges or IROP reprotections where penalties are waived per IATA Resolution 735.',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record (PNR) locator code associated with the booking in which the exchange occurred. Links the exchange transaction to the reservation context in Amadeus Altéa.. Valid values are `^[A-Z0-9]{6}$`',
    `sales_channel` STRING COMMENT 'Distribution channel through which the ticket exchange was processed. GDS (Global Distribution System) covers Amadeus/Sabre/Travelport agency sales; NDC (New Distribution Capability) covers IATA NDC API channels; direct channels cover airline-owned touchpoints. [ENUM-REF-CANDIDATE: gds|direct_web|direct_mobile|airport_counter|call_center|ndc|interline — promote to reference product]',
    `settlement_plan_type` STRING COMMENT 'Identifies the settlement mechanism through which the exchange transaction will be financially settled. BSP (Billing and Settlement Plan) for IATA-member markets; ARC (Airlines Reporting Corporation) for US/Canada markets; direct for airline-direct sales channels.. Valid values are `BSP|ARC|direct`',
    `tax_difference_amount` DECIMAL(18,2) COMMENT 'Net difference in applicable taxes and surcharges between the new ticket and the original ticket. Positive indicates additional tax collection; negative indicates tax credit. Required for accurate BSP settlement and revenue accounting.',
    `validating_carrier_code` STRING COMMENT 'IATA two-letter airline designator code of the validating carrier responsible for the new ticket. The validating carrier is accountable for BSP settlement and revenue recognition on the reissued document.. Valid values are `^[A-Z0-9]{2}$`',
    `waiver_code` STRING COMMENT 'Airline-issued waiver code authorizing the exchange under special circumstances (e.g., weather events, IROP, pandemic waivers, elite status benefit). When populated, indicates that standard change fees or fare rules were overridden. Sourced from Amadeus Altéa or Sabre AirVision waiver management.',
    `waiver_reason` STRING COMMENT 'Categorical reason code explaining why a waiver was applied to the exchange transaction. Used for waiver cost tracking, regulatory compliance reporting, and customer service analytics. [ENUM-REF-CANDIDATE: weather|irop|schedule_change|goodwill|elite_status|pandemic|other — promote to reference product]',
    CONSTRAINT pk_ticket_exchange PRIMARY KEY(`ticket_exchange_id`)
) COMMENT 'Ticket exchange (reissue) transaction record capturing the voluntary or involuntary modification of an existing ticket to a new itinerary or fare. Stores exchange reference number, original ticket number, new ticket number, exchange type (voluntary/involuntary/upgrade/downgrade/IROP reprotection), fare difference amount (additional collection or residual value), penalty amount, exchange date, exchanging office, original fare basis, new fare basis, and exchange status. SSOT for ticket reissue lifecycle and associated revenue impact tracking.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` (
    `flight_revenue_performance_id` BIGINT COMMENT 'Unique surrogate identifier for the flight revenue performance record. Primary key for this post-departure revenue snapshot.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Flight revenue performance analysis requires linking to specific aircraft for profitability by asset, maintenance cost allocation, CASM calculations per tail, and lease cost recovery. Essential for fl',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Actual flight revenue performance is compared against budget plans for variance analysis, management reporting, and forecast accuracy assessment. Core financial planning process.',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Revenue performance reporting breaks down fare revenue, load factor, and yield by cabin class (First, Business, Economy). Essential for cabin-level profitability analysis, pricing strategy, and capaci',
    `catering_order_id` BIGINT COMMENT 'Foreign key linking to procurement.catering_order. Business justification: Flight profitability analysis requires matching catering costs to revenue for accurate margin calculation per flight. Essential for route performance evaluation, catering spend optimization, and under',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Flight revenue is attributed to cost centers (routes, hubs) for route P&L analysis and profitability management. Standard airline financial reporting requirement.',
    `fuel_uplift_order_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_uplift_order. Business justification: Flight-level P&L reporting requires linking revenue performance to actual fuel costs for that specific flight. Core operational metric for route profitability analysis, fuel efficiency monitoring, and',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Flight revenue performance metrics must track maintenance events causing delays/cancellations to calculate true operational RASK, attribute revenue loss to maintenance costs, and support executive rep',
    `inventory_leg_id` BIGINT COMMENT 'Reference to the inventory leg record in the inventory domain, linking revenue performance to the corresponding seat inventory control record for this flight leg.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Flight revenue analysis requires origin station FK for yield management, route profitability reporting, station P&L, and RASK/yield benchmarking by station. Origin_airport_code is denormalized.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Revenue performance metrics are analyzed by route for yield management, capacity planning, route profitability assessment, and network optimization decisions. Route provides direct aggregation level f',
    `scheduled_flight_id` BIGINT COMMENT 'Reference to the operated flight instance in the flight operations domain. Links this revenue record to the specific departed flight.',
    `aircraft_type_code` STRING COMMENT 'ICAO aircraft type designator (e.g., B738, A320, B77W) for the aircraft operated on this flight. Drives ASK computation and unit cost benchmarking (CASK).. Valid values are `^[A-Z0-9]{3,4}$`',
    `ancillary_revenue_amount` DECIMAL(18,2) COMMENT 'Total ancillary revenue attributed to this flight, including checked baggage fees, seat selection fees, onboard retail, and other non-fare charges collected from passengers on this specific flight leg.',
    `ask` DECIMAL(18,2) COMMENT 'Available Seat Kilometers for this flight, computed as available_seats multiplied by the great-circle distance in kilometers between origin and destination. Represents the capacity deployed and is the denominator for RASK and CASK calculations.',
    `available_seats` STRING COMMENT 'Total number of seats available for sale on this flight across all cabins, as configured in the inventory system at departure. Used as the denominator for load factor and ASK calculations.',
    `average_fare_amount` DECIMAL(18,2) COMMENT 'Average base fare revenue per revenue passenger carried on this flight, computed as total_fare_revenue_amount / passengers_carried. Used to benchmark pricing effectiveness against RM forecast and competitor fares.',
    `business_fare_revenue_amount` DECIMAL(18,2) COMMENT 'Total base fare revenue collected from business class cabin passengers on this flight. Enables cabin-level revenue contribution and yield analysis to evaluate premium cabin pricing decisions.',
    `business_passengers` STRING COMMENT 'Number of revenue passengers carried in the business class cabin on this flight. Enables cabin-level yield and revenue contribution analysis critical for long-haul RM strategy evaluation.',
    `carrier_code` STRING COMMENT 'Two-character IATA airline designator of the operating carrier for this flight. Distinguishes own-metal operations from codeshare or wet-lease operations for revenue attribution.. Valid values are `^[A-Z0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue performance record was first created in the system, typically triggered by gate departure confirmation from the flight operations system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this record are expressed (e.g., USD, EUR, GBP). Aligns with the BSP/ARC settlement currency for the origin country.. Valid values are `^[A-Z]{3}$`',
    `denied_boarding_count` STRING COMMENT 'Number of passengers who were involuntarily denied boarding on this flight due to overbooking. Tracked for DOT consumer protection reporting, compensation cost accounting, and overbooking policy calibration.',
    `departure_timestamp` TIMESTAMP COMMENT 'Actual gate-out timestamp (the Out event in OOOI reporting) recorded at block-off. This is the principal business event timestamp anchoring the revenue performance record to the real-world flight departure.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the arrival station of this flight leg (e.g., LAX, CDG). Combined with origin defines the O&D market for yield and RASK analysis.. Valid values are `^[A-Z]{3}$`',
    `economy_fare_revenue_amount` DECIMAL(18,2) COMMENT 'Total base fare revenue collected from economy cabin passengers on this flight. Enables cabin-level revenue contribution and yield analysis to evaluate economy pricing decisions.',
    `economy_passengers` STRING COMMENT 'Number of revenue passengers carried in the economy cabin (including economy plus/premium economy where applicable) on this flight. Enables cabin-level load factor and revenue mix analysis.',
    `first_class_fare_revenue_amount` DECIMAL(18,2) COMMENT 'Total base fare revenue collected from first class cabin passengers on this flight. Nullable for routes without a first class product. Enables premium cabin revenue contribution analysis.',
    `first_class_passengers` STRING COMMENT 'Number of revenue passengers carried in the first class cabin on this flight. Nullable for aircraft types or routes without a first class product. Enables premium cabin revenue contribution analysis.',
    `flight_date` DATE COMMENT 'Scheduled local departure date of the flight at the origin station. Used as the primary date dimension for revenue performance reporting and RM decision evaluation.',
    `flight_distance_km` DECIMAL(18,2) COMMENT 'Great-circle distance in kilometers between the origin and destination airports for this flight leg. Used as the distance input for ASK, RPK, yield, and RASK calculations. Sourced from the route network reference data.',
    `flight_number` STRING COMMENT 'IATA-format marketing flight number (e.g., AA101, BA272) identifying the scheduled service. Combines carrier code and numeric designator as published in the schedule.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this revenue performance record, including post-departure revenue adjustments, BSP settlement updates, or correction entries.',
    `load_factor` DECIMAL(18,2) COMMENT 'Ratio of revenue passengers carried to available seats, expressed as a decimal (e.g., 0.8750 = 87.50%). Core RM performance metric measuring seat utilization achieved versus capacity deployed. Computed as passengers_carried / available_seats.',
    `no_show_count` STRING COMMENT 'Number of passengers who held confirmed reservations (PNRs) for this flight but did not board. Critical input for overbooking model calibration and RM forecast accuracy assessment.',
    `overbooking_factor` DECIMAL(18,2) COMMENT 'The overbooking authorization factor applied to this flight at departure, expressed as a ratio above 1.0 (e.g., 1.0500 = 5% overbooking). Captures the RM decision input for post-departure overbooking outcome evaluation.',
    `overbooking_outcome` STRING COMMENT 'Categorical outcome of the overbooking strategy applied to this flight. under_sold indicates seats departed empty; exact_sell indicates full utilization without denied boardings; over_sold indicates denied boardings occurred; cancelled indicates the flight was cancelled.. Valid values are `under_sold|exact_sell|over_sold|cancelled`',
    `passengers_carried` STRING COMMENT 'Total number of revenue passengers who boarded and were carried on this flight across all cabins. Excludes non-revenue passengers (staff travel, deadhead crew). Used as the numerator for load factor and RPK calculations.',
    `rask` DECIMAL(18,2) COMMENT 'Total revenue (fare + ancillary + upgrade) divided by Available Seat Kilometers (ASK) for this flight. Primary unit revenue productivity metric used by RM and finance to evaluate pricing effectiveness against capacity deployed.',
    `record_status` STRING COMMENT 'Lifecycle status of this revenue performance record. provisional indicates the record was created at gate departure before full revenue accounting close; final indicates BSP/ARC settlement is complete; adjusted indicates a post-close correction has been applied; cancelled indicates the flight was cancelled after initial record creation.. Valid values are `final|provisional|adjusted|cancelled`',
    `revenue_accounting_period` STRING COMMENT 'The BSP/ARC settlement accounting period (year-month) to which this flights revenue is attributed for financial close and regulatory reporting. Aligns with IATA BSP billing period calendar.. Valid values are `^[0-9]{4}-[0-9]{2}$`',
    `rpk` DECIMAL(18,2) COMMENT 'Revenue Passenger Kilometers for this flight, computed as passengers_carried multiplied by the great-circle distance in kilometers. Measures actual traffic volume and is the denominator for yield calculation.',
    `total_fare_revenue_amount` DECIMAL(18,2) COMMENT 'Gross base fare revenue collected for all passengers on this flight across all cabins, excluding taxes, fees, and ancillary charges. This is the primary revenue line used for yield and RASK computation. Expressed in the settlement currency.',
    `upgrade_count` STRING COMMENT 'Total number of passengers upgraded to a higher cabin class on this flight, including paid upgrades, complimentary upgrades, and loyalty-tier upgrades. Used to evaluate upgrade revenue opportunity and cabin mix management.',
    `upgrade_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue collected from paid cabin upgrades on this flight, including gate upgrades, bid upgrades, and instant upgrade purchases. Tracked separately to evaluate upgrade yield contribution.',
    `voluntary_denied_boarding_count` STRING COMMENT 'Number of passengers who voluntarily accepted compensation and gave up their confirmed seat on this flight. Tracked separately from involuntary denied boarding for DOT reporting and compensation cost management.',
    `yield_per_rpk` DECIMAL(18,2) COMMENT 'Fare revenue divided by Revenue Passenger Kilometers (RPK) for this flight. Measures the average revenue earned per unit of traffic carried, the core yield metric in airline revenue management. Expressed in the settlement currency per kilometer.',
    CONSTRAINT pk_flight_revenue_performance PRIMARY KEY(`flight_revenue_performance_id`)
) COMMENT 'Operational revenue performance record capturing the actual revenue outcome for a departed flight — the post-departure revenue snapshot used for RM performance measurement. Stores flight number, flight date, origin, destination, cabin-level revenue (total fare revenue, ancillary revenue, upgrade revenue), passengers carried by RBD, load factor achieved, yield per RPK, RASK, ASK, RPK, average fare, no-show count, denied boarding count, upgrade count, and overbooking outcome. This is an operational RM post-departure record (not an analytics aggregate) used to evaluate RM decisions and feed forecast model calibration.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` (
    `revenue_surcharge_id` BIGINT COMMENT 'Unique system-generated identifier for the carrier-imposed surcharge master record. Primary key for the revenue_surcharge product.',
    `tax_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_transaction. Business justification: Surcharges (fuel YQ/YR) may have tax implications requiring linkage to tax transactions for compliance and remittance. Varies by jurisdiction.',
    `amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount of the surcharge applied per coupon/sector when the calculation method is flat-rate. Expressed in the currency defined by currency_code. Null when the surcharge is percentage-based. Used in fare construction and ticket pricing.',
    `atpco_record_type` STRING COMMENT 'ATPCO record type number identifying the tariff record structure used for this surcharge filing (e.g., Record 1 for general rules, Record 2 for fare rules, Record 7 for surcharges). Required for ATPCO-filed surcharges to enable correct parsing and application by GDS systems.. Valid values are `^[0-9]{1,2}$`',
    `booking_class_applicability` STRING COMMENT 'Comma-separated list of RBD (Reservation Booking Designator) booking class codes to which this surcharge applies (e.g., Y,B,M,H,Q). Null or empty indicates applicability to all booking classes. Used in Sabre AirVision pricing rules to restrict surcharge to specific inventory buckets.',
    `cabin_applicability` STRING COMMENT 'Cabin class scope for which this surcharge is applicable. All indicates the surcharge applies across all cabins; individual cabin values restrict applicability to specific service classes. Drives differential surcharge pricing by cabin in revenue management.. Valid values are `all|first|business|premium_economy|economy`',
    `calculation_method` STRING COMMENT 'Method used to compute the surcharge amount on a ticket. Flat applies a fixed monetary amount per coupon; percentage applies a rate against the base fare; per_mile and per_km apply a distance-based rate. Determines how the surcharge is computed in the Sabre AirVision pricing engine.. Valid values are `flat|percentage|per_mile|per_km`',
    `carrier_code` STRING COMMENT 'IATA two-letter designator of the airline imposing this surcharge. Identifies the operating or marketing carrier responsible for the surcharge filing. Used in BSP settlement and ARC reporting to attribute surcharge revenue to the correct carrier.. Valid values are `^[A-Z0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this surcharge record was first created in the data platform. Provides the audit creation trail for the Silver layer record and supports data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the surcharge amount is denominated (e.g., USD, EUR, GBP). Applies to flat-rate surcharges. Used in BSP/ARC settlement, NUC conversion, and revenue accounting.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'IATA three-letter airport code for the destination point of the route to which this surcharge applies. Null indicates global applicability or zone-based routing. Used in O&D-specific surcharge rules and route network pricing.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code for the country of destination to which this surcharge applies. Used when the surcharge is defined at country level rather than specific airport level. Supports country-pair surcharge rules common in international fuel surcharge filings.. Valid values are `^[A-Z]{2}$`',
    `directionality` STRING COMMENT 'Directional applicability of the surcharge relative to the origin-destination pair. Both applies the surcharge in either direction; outbound applies only when traveling from origin to destination; inbound applies only in the reverse direction. Relevant for asymmetric fuel surcharge structures on international routes.. Valid values are `both|outbound|inbound`',
    `discontinue_date` DATE COMMENT 'Date after which this surcharge record is no longer applicable to new ticket issuances. Null indicates an open-ended surcharge with no planned expiry. Used in ATPCO tariff management and revenue management system configuration.',
    `effective_date` DATE COMMENT 'Date from which this surcharge record becomes applicable to new ticket issuances. Aligns with ATPCO filing effective date. Surcharges are not applied to tickets issued before this date.',
    `filing_date` DATE COMMENT 'Date on which this surcharge was filed with ATPCO or submitted to the carriers PSS. Used for audit trail, regulatory compliance, and tracking the lead time between filing and effectiveness. Required for DOT fare transparency compliance.',
    `filing_source` STRING COMMENT 'Source channel through which this surcharge was filed and distributed. ATPCO (Airline Tariff Publishing Company) is the primary industry filing channel; carrier_direct indicates the surcharge was loaded directly into the carriers PSS without ATPCO filing; GDS indicates direct GDS filing; BSP indicates filing via IATA Billing and Settlement Plan.. Valid values are `ATPCO|carrier_direct|GDS|BSP`',
    `global_indicator` STRING COMMENT 'IATA global indicator code defining the geographic routing area for which this surcharge applies (e.g., AT = Atlantic, PA = Pacific, TS = Trans-Siberian). Used in conjunction with IATA fare construction rules to determine surcharge applicability on international itineraries.. Valid values are `^(AT|PA|TS|AP|FE|WH|EH|SA|PO|RU|US|CA|TC1|TC2|TC3)?$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this surcharge record in the data platform. Supports change data capture, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    `maximum_amount` DECIMAL(18,2) COMMENT 'Maximum monetary ceiling for the surcharge when using percentage-based calculation. Caps the surcharge on high-fare tickets to maintain competitive pricing. Expressed in the currency defined by currency_code.',
    `minimum_amount` DECIMAL(18,2) COMMENT 'Minimum monetary floor for the surcharge when using percentage-based calculation. Ensures the surcharge does not fall below a commercially viable threshold on low-fare tickets. Expressed in the currency defined by currency_code.',
    `ndc_eligible` BOOLEAN COMMENT 'Indicates whether this surcharge is eligible for distribution via IATA New Distribution Capability (NDC) channels. True enables the surcharge to be included in NDC offer and order management flows. Supports the airlines NDC distribution strategy and modern retailing initiatives.',
    `nuc_amount` DECIMAL(18,2) COMMENT 'Surcharge amount expressed in IATA Neutral Units of Construction (NUC) for international fare construction. NUC amounts are currency-neutral and converted to local currency using IATA-published ROE (Rate of Exchange) at time of ticketing. Required for IATA-compliant international fare construction.',
    `origin_airport_code` STRING COMMENT 'IATA three-letter airport code for the origin point of the route to which this surcharge applies. Null indicates global applicability or zone-based routing. Used in O&D-specific surcharge rules and route network pricing.. Valid values are `^[A-Z]{3}$`',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 country code for the country of origin to which this surcharge applies. Used when the surcharge is defined at country level rather than specific airport level. Supports country-pair surcharge rules common in international fuel surcharge filings.. Valid values are `^[A-Z]{2}$`',
    `passenger_type_code` STRING COMMENT 'IATA Passenger Type Code (PTC) indicating the passenger category to which this surcharge applies (e.g., ADT for adult, CHD for child, INF for infant). Null indicates applicability to all passenger types. Drives surcharge waiver logic for infants and discounted passenger categories.. Valid values are `^[A-Z]{3}$`',
    `per_coupon_indicator` BOOLEAN COMMENT 'Indicates whether the surcharge amount is applied per flight coupon (sector) or per ticket/journey. True = per coupon (each flight segment incurs the surcharge independently); False = per ticket (surcharge applied once per ticket regardless of number of sectors). Critical for multi-sector itinerary pricing.',
    `percentage_rate` DECIMAL(18,2) COMMENT 'Percentage of the base fare applied as the surcharge when the calculation method is percentage-based. Expressed as a decimal (e.g., 5.25 = 5.25%). Null when the surcharge is a flat amount. Used in dynamic pricing and revenue management yield calculations.',
    `route_applicability` STRING COMMENT 'Scope of route coverage for this surcharge. Global applies to all routes operated by the carrier; regional applies to a defined geographic zone; specific_od applies only to the origin-destination pair defined by origin_airport_code and destination_airport_code; domestic/international restrict by border crossing.. Valid values are `global|regional|specific_od|domestic|international`',
    `sales_restriction` STRING COMMENT 'Restriction on the sales channel through which tickets subject to this surcharge may be issued. Online_only restricts to direct digital channels; agency_only restricts to GDS/travel agency channels; direct_only restricts to carrier-direct channels. Supports NDC and direct distribution surcharge differentiation.. Valid values are `none|online_only|offline_only|agency_only|direct_only`',
    `sub_code` STRING COMMENT 'Carrier-defined sub-code qualifying the primary surcharge code (e.g., YQ/F for fuel, YQ/I for infrastructure). Used by ATPCO and GDS systems to distinguish multiple surcharge types filed under the same two-letter code.. Valid values are `^[A-Z0-9]{1,3}$`',
    `surcharge_code` STRING COMMENT 'IATA-standard two-letter tax/surcharge code identifying the surcharge category. YQ denotes fuel surcharge (carrier-imposed); YR denotes carrier-imposed miscellaneous fees. These codes appear on the ticket and in BSP/ARC settlement reporting.. Valid values are `^[A-Z]{2}$`',
    `surcharge_name` STRING COMMENT 'Human-readable commercial name of the surcharge as displayed on itinerary receipts, e-tickets, and customer-facing documents (e.g., Fuel Surcharge, Carrier Imposed Fee, Security Surcharge). Used in customer communications and GDS display.',
    `surcharge_status` STRING COMMENT 'Current lifecycle state of the surcharge record. Active surcharges are applied to new ticket issuances; pending surcharges are filed but not yet effective; expired surcharges have passed their discontinue date; withdrawn surcharges have been retracted by the carrier prior to effectiveness.. Valid values are `active|inactive|pending|expired|withdrawn`',
    `surcharge_type` STRING COMMENT 'Business classification of the surcharge indicating its economic purpose. Fuel surcharges (YQ) recover jet fuel cost volatility; infrastructure surcharges recover airport/facility costs; security surcharges recover security screening costs; carrier-imposed fees cover miscellaneous carrier costs. Drives revenue accounting treatment and P&L allocation.. Valid values are `fuel|infrastructure|security|carrier_imposed|environmental|insurance`',
    `tariff_number` STRING COMMENT 'ATPCO tariff number under which this surcharge is filed. Identifies the specific tariff publication containing the surcharge rule. Used in conjunction with carrier_code and surcharge_code for ATPCO record retrieval and GDS distribution.. Valid values are `^[A-Z0-9]{1,4}$`',
    `travel_discontinue_date` DATE COMMENT 'Latest travel/departure date for which this surcharge applies. Null indicates no travel date restriction. Used in conjunction with travel_effective_date to define the travel window subject to the surcharge.',
    `travel_effective_date` DATE COMMENT 'Earliest travel/departure date for which this surcharge applies. Distinct from the ticketing effective date — controls which itineraries are subject to the surcharge based on the outbound travel date rather than the ticket issuance date.',
    CONSTRAINT pk_revenue_surcharge PRIMARY KEY(`revenue_surcharge_id`)
) COMMENT 'Carrier-imposed surcharge master record defining fuel surcharges (YQ), carrier-imposed fees (YR), and other non-government surcharges applied to air tickets. Captures surcharge code (YQ/YR and sub-codes), surcharge type (fuel/infrastructure/security/carrier-imposed), applicable carrier, route applicability (global/regional/specific O&D), amount or percentage, currency, cabin applicability, effective and expiry dates, and filing source (ATPCO/carrier direct). Distinct from government taxes (tax_fee) — surcharges are carrier-controlled and subject to different revenue accounting treatment.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` (
    `ndc_offer_order_id` BIGINT COMMENT 'Unique surrogate identifier for the NDC offer order record in the Silver layer lakehouse. Primary key for this entity. TRANSACTION_HEADER role — represents a confirmed booking transacted through an IATA NDC-compliant API channel.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to revenue.agency. Business justification: NDC orders placed by travel agencies should reference the agency master. The agency_iata_number attribute in ndc_offer_order should reference the authoritative agency record. Standard N:1 relationship',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: NDC orders are issued by legal entities for revenue recognition and financial reporting. Essential for modern airline distribution financial accounting.',
    `corporate_contract_id` BIGINT COMMENT 'Foreign key linking to revenue.corporate_contract. Business justification: NDC orders can be booked under corporate contracts. The corporate_account_code attribute in ndc_offer_order suggests corporate contract applicability. This should be a FK to the authoritative corporat',
    `fare_family_id` BIGINT COMMENT 'Reference to the fare family (branded fare) associated with the primary flight component of this NDC order. Links to revenue.fare_family to identify the product bundle (e.g., Basic Economy, Main Cabin, Business Select) and its included ancillary entitlements.',
    `fare_id` BIGINT COMMENT 'Foreign key linking to revenue.fare. Business justification: NDC orders are built on fare structures. The fare_basis_code in ndc_offer_order should reference the authoritative fare master. This links the NDC distribution channel back to the core fare definition',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: NDC offers are generated from real-time flight inventory availability queries. The offer-to-order flow must reference the specific inventory instance to ensure seat availability, apply dynamic pricing',
    `profile_id` BIGINT COMMENT 'Reference to the primary passenger (traveler) associated with this NDC order. PARTY_REFERENCE for this TRANSACTION_HEADER — the counterparty who will consume the ordered flight and ancillary services. For multi-passenger orders, this references the lead passenger.',
    `pricing_record_id` BIGINT COMMENT 'Reference to the upstream pricing record in revenue.pricing_record that produced the offer from which this order was created. Links NDC order to the quoted fare and pricing parameters.',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: NDC offers are generated for specific routes; route determines applicable fare families, ancillary bundles, dynamic pricing rules, and branded fare availability. Essential for offer construction, pric',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: NDC orders result in ticket issuance. The ticket_number attribute in ndc_offer_order should reference the authoritative ticket record. This links the NDC order to the issued ticket. Standard N:1 relat',
    `ancillary_amount` DECIMAL(18,2) COMMENT 'Total revenue from ancillary services (e.g., seat upgrades, extra baggage, lounge access, in-flight meals, Wi-Fi) included in this NDC order. Enables ancillary revenue attribution and modern retailing performance measurement separate from base fare revenue.',
    `base_fare_amount` DECIMAL(18,2) COMMENT 'The base fare component of the total order price, excluding taxes, fees, and carrier surcharges. Expressed in the order currency. Part of the MONETARY_TRIPLET for this TRANSACTION_HEADER. Used for yield calculation (revenue per RPK) and RASK/CASK performance measurement.',
    `buyer_type` STRING COMMENT 'Classification of the entity that placed the NDC order. DIRECT_TRAVELER = consumer booking directly on airline.com; TRAVEL_AGENT = IATA-accredited travel agency; CORPORATE = corporate self-booking tool; OTA = Online Travel Agency aggregator; TMC = Travel Management Company. Drives NDC channel attribution and distribution cost analysis.. Valid values are `DIRECT_TRAVELER|TRAVEL_AGENT|CORPORATE|OTA|TMC`',
    `cabin_class` STRING COMMENT 'The cabin class of service for the primary flight component of this NDC order. Drives revenue accounting classification, yield management reporting (RASK by cabin), and load factor calculations by cabin.. Valid values are `FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'UTC timestamp when this NDC order was cancelled. Null for active, ticketed, or fulfilled orders. Used for cancellation rate analysis, refund processing timelines, and DOT consumer protection compliance reporting (14 CFR Part 259 — 24-hour cancellation rule).',
    `created_timestamp` TIMESTAMP COMMENT 'UTC timestamp when this record was first written into the Silver layer lakehouse. RECORD_AUDIT_CREATED for data lineage and pipeline monitoring. Distinct from order_created_timestamp which reflects the business event time.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the NDC order total is denominated (e.g., USD, EUR, GBP). Part of the MONETARY_TRIPLET. The currency in which the buyer was quoted and charged. Required for multi-currency revenue accounting and BSP settlement.. Valid values are `^[A-Z]{3}$`',
    `destination_airport_code` STRING COMMENT 'IATA three-letter airport code for the final destination airport of the primary journey in this NDC order (e.g., LAX, CDG, SIN). Used for O&D (Origin and Destination) revenue analysis, route profitability, and yield management.. Valid values are `^[A-Z]{3}$`',
    `fare_basis_code` STRING COMMENT 'ATPCO-standard fare basis code applied to the primary flight segment of this NDC order (e.g., Y26NR, QOWUS). Encodes fare type, booking class, restrictions, and advance purchase requirements. Used for revenue accounting, interline proration, and regulatory fare filing compliance.',
    `ffp_member_number` STRING COMMENT 'The frequent flyer program (FFP) membership number of the lead passenger associated with this NDC order. Used to credit earned miles, apply redemption discounts, and track loyalty program engagement through the NDC channel. Classified as confidential PII as it identifies a specific loyalty member.',
    `form_of_payment_type` STRING COMMENT 'The type of payment instrument used to settle this NDC order. MIXED indicates a combination of payment types (e.g., miles + credit card). Drives payment processing routing, BSP settlement method, and revenue accounting treatment. Card numbers are NOT stored here per PCI DSS.. Valid values are `CREDIT_CARD|DEBIT_CARD|BANK_TRANSFER|MILES_REDEMPTION|VOUCHER|MIXED`',
    `last_servicing_timestamp` TIMESTAMP COMMENT 'UTC timestamp of the most recent post-order servicing action (e.g., change, upgrade, ancillary modification) applied to this NDC order. Null if no servicing actions have occurred. Supports IROP (Irregular Operations) reprotection tracking and order change audit.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'UTC timestamp of the most recent modification to this record in the Silver layer lakehouse. RECORD_AUDIT_UPDATED for change tracking and incremental processing. Updated on every order lifecycle state change, servicing action, or payment status update.',
    `loyalty_miles_earned` STRING COMMENT 'Number of frequent flyer program (FFP) miles or points accrued by the lead passenger for this NDC order based on the fare family accrual rate and distance flown. Populated upon flight completion. Used for loyalty liability accounting and FFP program performance reporting.',
    `ndc_order_reference` STRING COMMENT 'Externally-known alphanumeric order reference assigned by the airline NDC Order Management System at order creation. Communicated to the buyer (traveler, agent, corporate) as the booking confirmation number. Distinct from the PNR locator used in legacy GDS channels. BUSINESS_IDENTIFIER for this TRANSACTION_HEADER.',
    `ndc_provider_code` STRING COMMENT 'Identifier of the NDC-certified aggregator, GDS, or direct connect provider through which this order was transacted (e.g., Amadeus NDC, Sabre NDC, Travelport NDC, or airline direct API). Enables distribution cost analysis and provider performance benchmarking.',
    `ndc_schema_version` STRING COMMENT 'The IATA NDC XML schema version used to create and process this order (e.g., 17.2, 18.1, 19.1, 20.1, 21.3). Critical for API compatibility management, schema migration tracking, and ensuring correct message parsing across NDC schema generations.',
    `order_created_timestamp` TIMESTAMP COMMENT 'UTC timestamp when the NDC order was first created in the airline Order Management System following buyer acceptance of the offer. This is the principal real-world business event time (BUSINESS_EVENT_TIMESTAMP) for this transaction — distinct from the ETL audit timestamp.',
    `order_status` STRING COMMENT 'Current state of the NDC order in its lifecycle workflow. ORDERED = order created but not yet ticketed; TICKETED = e-ticket issued; CHANGED = order modified post-creation; CANCELLED = order cancelled; FULFILLED = all flight coupons flown; EXPIRED = order lapsed without ticketing. LIFECYCLE_STATUS for this TRANSACTION_HEADER.. Valid values are `ORDERED|TICKETED|CHANGED|CANCELLED|FULFILLED|EXPIRED`',
    `origin_airport_code` STRING COMMENT 'IATA three-letter airport code for the origin airport of the primary journey in this NDC order (e.g., JFK, LHR, DXB). Used for route-level revenue attribution, RASK/ASK calculations, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `original_offer_reference` STRING COMMENT 'The NDC offer identifier returned by the airline shopping/pricing engine (AirShopping or OfferPrice response) that the buyer accepted and converted into this order. Enables traceability from order back to the original priced offer for revenue attribution and offer conversion analytics.',
    `passenger_count` STRING COMMENT 'Total number of passengers (Pax) included in this NDC order across all passenger type codes (ADT, CHD, INF). Used for load factor calculations, revenue per passenger analysis, and group booking identification.',
    `payment_status` STRING COMMENT 'Current payment processing status for this NDC order. PENDING = awaiting payment; AUTHORIZED = payment authorized but not yet captured; CAPTURED = payment successfully collected; REFUNDED = full refund processed; PARTIALLY_REFUNDED = partial refund issued; FAILED = payment collection failed.. Valid values are `PENDING|AUTHORIZED|CAPTURED|REFUNDED|PARTIALLY_REFUNDED|FAILED`',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record (PNR) locator in the Amadeus Altéa PSS that corresponds to this NDC order. Populated when the NDC order is mirrored into the legacy PSS for operational handling (check-in, boarding). May be null for pure NDC-native orders not requiring PSS synchronisation.. Valid values are `^[A-Z0-9]{6}$`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary amount refunded to the buyer for this NDC order upon cancellation or partial cancellation. Zero for non-refunded orders. Used for revenue leakage analysis, refund liability reporting, and DOT consumer protection compliance.',
    `sales_channel` STRING COMMENT 'The specific distribution channel through which the NDC order was transacted. Distinct from buyer_type (who bought) — this captures the technical/commercial interface used (how they bought). Enables retailing performance measurement by channel and supports RASK attribution by distribution channel.. Valid values are `AIRLINE_DIRECT|NDC_AGGREGATOR|GDS_NDC|CORPORATE_PORTAL|TMC_API`',
    `servicing_action_count` STRING COMMENT 'Cumulative count of post-order servicing actions (changes, upgrades, seat modifications, ancillary additions/removals, name corrections) applied to this NDC order since creation. A non-zero value indicates the order has been modified. Used for servicing cost analysis and order complexity measurement.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total government taxes, airport fees, and Passenger Facility Charges (PFC) levied on this NDC order. Part of the MONETARY_TRIPLET. Includes all IATA-standard tax codes (YQ/YR carrier surcharges, government taxes). Required for DOT full-fare advertising compliance.',
    `ticketing_time_limit` TIMESTAMP COMMENT 'The deadline by which an e-ticket must be issued for this NDC order before it auto-cancels. A critical operational field in airline reservations — if the TTL passes without ticketing, the order expires and inventory is released. Aligns with Amadeus Altéa TTL functionality.',
    `total_order_amount` DECIMAL(18,2) COMMENT 'The gross total amount payable for this NDC order, inclusive of base fare, taxes, carrier surcharges, and ancillary service charges. Net total in the MONETARY_TRIPLET. This is the amount presented to the buyer at order confirmation and used for revenue accounting and BSP settlement.',
    `trip_type` STRING COMMENT 'Classification of the journey type for this NDC order. ONE_WAY = single direction travel; ROUND_TRIP = outbound and return to origin; MULTI_CITY = three or more distinct city pairs. Affects fare construction, combinability rules, and revenue accounting treatment.. Valid values are `ONE_WAY|ROUND_TRIP|MULTI_CITY`',
    CONSTRAINT pk_ndc_offer_order PRIMARY KEY(`ndc_offer_order_id`)
) COMMENT 'NDC (New Distribution Capability) order record representing a confirmed booking and its associated offer components transacted through IATA NDC-compliant API channels (airline.com, aggregators, TMC integrations). Captures NDC order ID, original offer reference, order creation timestamp, buyer type (direct traveler/agent/corporate), ordered components (flight segments, ancillary services, fare family), total price, currency, payment status, order lifecycle state (ordered/ticketed/cancelled/changed), servicing history, and NDC schema version. SSOT for NDC-channel revenue attribution and modern retailing distribution performance measurement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` (
    `contract_inventory_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for this contract-flight allocation record',
    `corporate_contract_id` BIGINT COMMENT 'Foreign key linking to the corporate travel contract that governs this allocation',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to the specific flight-date inventory record covered by this contract allocation',
    `allocated_seats` STRING COMMENT 'Number of seats on this flight-date allocated or reserved for this corporate contract. May be soft allocation (priority access) or hard block (guaranteed availability).',
    `allocation_status` STRING COMMENT 'Current operational status of this contract-flight allocation. ACTIVE: allocation is live and bookable. SUSPENDED: temporarily unavailable. EXPIRED: allocation period ended. CANCELLED: allocation removed before expiry.',
    `allocation_type` STRING COMMENT 'Classification of how seats are allocated. HARD_BLOCK: seats guaranteed and blocked from general sale. SOFT_ALLOCATION: preferential access without blocking. PRIORITY_ACCESS: first-right-of-refusal on availability.',
    `applicable_booking_classes` STRING COMMENT 'Pipe-delimited list of RBD (Reservation Booking Designator) codes that are eligible under this contract for this specific flight. May be a subset of the overall contract booking classes based on route or flight characteristics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract-flight allocation record was created in the system',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated percentage discount applied to bookings under this contract on this specific flight. May vary by route, cabin, or flight characteristics even within the same contract.',
    `effective_date` DATE COMMENT 'Date from which this contract allocation becomes active for this flight inventory. May differ from overall contract effective date if allocation is phased or route-specific.',
    `expiry_date` DATE COMMENT 'Date on which this contract allocation ceases to be valid for this flight inventory. May differ from overall contract expiry if allocation is seasonal or route-specific.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this allocation record, including seat usage updates',
    `revenue_generated` DECIMAL(18,2) COMMENT 'Total revenue generated from bookings under this corporate contract on this specific flight-date. Used for contract performance tracking and volume commitment measurement.',
    `seats_used` STRING COMMENT 'Number of seats actually booked and consumed under this corporate contract on this specific flight-date. Used to track contract utilization and volume commitment progress.',
    CONSTRAINT pk_contract_inventory_allocation PRIMARY KEY(`contract_inventory_allocation_id`)
) COMMENT 'This association product represents the allocation agreement between corporate_contract and flight_inventory. It captures the specific seat inventory allocated to each corporate contract on each flight-date combination, tracking usage, discount application, and booking class restrictions. Each record links one corporate contract to one flight_inventory with attributes that exist only in the context of this allocation relationship. Essential for corporate sales management, revenue tracking, and inventory control.. Existence Justification: Corporate contracts in airline revenue management grant negotiated fares and seat allocations across multiple flights within defined route networks and date ranges. Each flight inventory can simultaneously have multiple corporate contracts applicable from different corporate accounts or TMCs. The airline actively manages contract-specific seat allocations, tracks usage against volume commitments, and applies contract-specific discounts and booking class restrictions per flight-date combination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`fare_applicability` (
    `fare_applicability_id` BIGINT COMMENT 'Unique surrogate identifier for this fare-inventory applicability record.',
    `fare_id` BIGINT COMMENT 'Foreign key linking to the master fare definition record. Identifies which published or private fare basis is authorized for sale on the associated flight inventory.',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to the flight inventory record. Identifies the specific flight-date combination for which this fare is available for sale.',
    `authorized_capacity` STRING COMMENT 'Revenue management-approved seat count authorized for sale under this specific fare on this flight-date. Subset of the flight inventorys total authorized capacity, allocated to this fare basis code. Used for fare class bucket management and yield optimization.',
    `availability_status` STRING COMMENT 'Current operational availability status of this fare on this specific flight inventory. OPEN=available for sale, CLOSED=not available (yield management decision or sold out), WAITLIST=accepting waitlist bookings only, RESTRICTED=available with conditions. Controlled by revenue management systems in real-time.',
    `booking_class` STRING COMMENT 'Single-letter IATA Reservation Booking Designator (RBD) that maps this fare to a specific inventory bucket on this flight. Controls which fare class bucket configuration this fare draws availability from. Critical for revenue management yield optimization.',
    `cabin_class` STRING COMMENT 'Physical cabin of service for this fare-flight combination. Ensures fare is mapped to the correct cabin capacity pool in the flight inventory record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fare-inventory applicability record was created in the revenue management system.',
    `discontinue_date` DATE COMMENT 'The date after which this specific fare is no longer valid for sale on this specific flight inventory instance. Used to manage fare availability windows and promotional periods at the flight-date level.',
    `effective_date` DATE COMMENT 'The date from which this specific fare becomes valid for sale on this specific flight inventory instance. May differ from the fares global effective_date when fare availability is restricted to specific flight-date windows.',
    `fare_applicability_status` STRING COMMENT 'Lifecycle status of this fare-inventory applicability record. ACTIVE=currently in effect, SUSPENDED=temporarily disabled by revenue management, EXPIRED=past discontinue_date, WITHDRAWN=removed from sale by carrier decision.',
    `last_booking_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent booking made using this fare on this flight inventory. Used for booking curve analysis and revenue management forecasting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this fare-inventory applicability record, including availability status changes, capacity adjustments, or date window updates.',
    `seats_sold_under_fare` STRING COMMENT 'Current count of confirmed bookings made using this specific fare on this flight-date. Tracked separately from flight inventory total seats_sold to enable fare-level revenue analysis and yield management decisions.',
    CONSTRAINT pk_fare_applicability PRIMARY KEY(`fare_applicability_id`)
) COMMENT 'This association product represents the operational marriage between published fares and sellable flight inventory in the airline revenue management system. It captures the fare-inventory control relationship that determines which fare basis codes are authorized for sale on specific flight-date combinations. Each record links one fare to one flight inventory instance with attributes that govern booking class mapping, availability control, and fare validity windows. This is the core operational entity consumed by GDS, direct booking channels, and yield optimization systems to determine fare availability in real-time.. Existence Justification: In airline revenue management operations, a single published fare (e.g., fare basis code Y7APEX) is valid across multiple flight inventory instances—same route, different departure dates, different times of day—and each flight inventory instance can be sold under multiple fare basis codes simultaneously (full-fare Y, advance purchase Y7APEX, negotiated corporate fares, etc.). The business actively manages this many-to-many relationship through revenue management systems that control which fares are available on which flights, with fare-specific availability status, booking class mappings, and authorized capacity allocations per fare-flight combination.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` (
    `corporate_ancillary_entitlement_id` BIGINT COMMENT 'Unique surrogate identifier for this corporate ancillary entitlement record',
    `corporate_contract_id` BIGINT COMMENT 'Foreign key linking to the corporate travel contract that defines this ancillary entitlement',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to the specific ancillary product covered by this entitlement',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this ancillary entitlement should be automatically applied to eligible bookings under this corporate contract or requires manual selection',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary entitlement was added to the corporate contract',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the negotiated price of this ancillary product',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated percentage discount applied to this specific ancillary product under this corporate contract, may differ from the base contract discount',
    `effective_date` DATE COMMENT 'Date from which this ancillary entitlement becomes active under the corporate contract, may differ from the overall contract effective date if products are added mid-term',
    `entitlement_status` STRING COMMENT 'Current status of this specific ancillary entitlement within the corporate contract (active, suspended, expired, pending)',
    `expiry_date` DATE COMMENT 'Date on which this ancillary entitlement ceases to be valid under the corporate contract, may differ from the overall contract expiry if products are removed or terms change',
    `included_quantity` STRING COMMENT 'Number of units of this ancillary product included free or bundled per passenger or per booking under this corporate contract (e.g., 2 free checked bags, 1 lounge access per trip)',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary entitlement terms were last modified',
    `negotiated_price` DECIMAL(18,2) COMMENT 'Fixed negotiated price for this ancillary product under this corporate contract, overriding the standard catalog price',
    `usage_limit_per_booking` STRING COMMENT 'Maximum number of times this ancillary entitlement can be used per booking under the corporate contract terms',
    `usage_limit_per_passenger` STRING COMMENT 'Maximum number of times this ancillary entitlement can be used per passenger per trip under the corporate contract terms',
    CONSTRAINT pk_corporate_ancillary_entitlement PRIMARY KEY(`corporate_ancillary_entitlement_id`)
) COMMENT 'This association product represents the negotiated terms and pricing for specific ancillary products within corporate travel contracts. It captures the per-product discount rates, included quantities, negotiated pricing, and validity periods that exist only in the context of a specific corporate contract and ancillary product combination. Each record links one corporate contract to one ancillary product with the negotiated commercial terms that govern how that ancillary is priced and bundled for that corporate account.. Existence Justification: Corporate travel contracts negotiate specific terms for multiple ancillary products (baggage, seats, lounge access, meals, upgrades), and each ancillary product has different negotiated terms across multiple corporate accounts. Contract managers actively create and manage per-product entitlements with distinct discount rates, included quantities, negotiated prices, and validity periods that vary by contract-product combination. This is an operational business entity that revenue teams query and maintain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` (
    `revenue_bundle_component_id` BIGINT COMMENT 'Primary key for revenue_bundle_component',
    `ancillary_bundle_component_id` BIGINT COMMENT 'Unique surrogate identifier for this fare family ancillary inclusion record. Primary key for the association.',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to the fare family (branded fare) that includes this ancillary product',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to the ancillary product included in this fare family bundle',
    `channel_override` STRING COMMENT 'Comma-separated list of sales channels where this specific fare family-ancillary inclusion configuration applies differently than the default. Used for channel-specific bundling strategies (e.g., GDS vs. direct web). Null indicates no channel-specific override. This override is specific to the fare family-ancillary pairing.',
    `display_priority` STRING COMMENT 'Sort order for displaying this ancillary product within the fare family bundle presentation across sales channels. Lower numbers display first. Used to highlight key value propositions (e.g., baggage allowance before Wi-Fi). This priority is specific to how the ancillary is merchandised within this particular fare family.',
    `effective_date` DATE COMMENT 'Calendar date from which this ancillary product inclusion configuration becomes active for the fare family. Used for managing seasonal bundles, promotional periods, and merchandising campaigns. This effective date is specific to the fare family-ancillary pairing, independent of the effective dates of the fare family or ancillary product themselves.',
    `expiry_date` DATE COMMENT 'Calendar date after which this ancillary product inclusion configuration is no longer active for the fare family. Null indicates indefinite inclusion. Used for time-limited promotional bundles and seasonal merchandising. This expiry date is specific to the fare family-ancillary pairing.',
    `inclusion_type` STRING COMMENT 'Defines how the ancillary product is offered within this fare family. INCLUDED = complimentary at no additional charge, DISCOUNTED = available at reduced price, EXCLUDED = not available for purchase, PURCHASABLE = available at standard price. This attribute exists only in the context of the fare family-ancillary pairing.',
    `incremental_charge_amount` DECIMAL(18,2) COMMENT 'Additional charge or discount amount applied to the ancillary product base price when purchased within this fare family context. Positive values represent upcharges, negative values represent discounts, zero indicates no price delta from base. Currency matches the fare family currency_code. This pricing delta exists only in the relationship between fare family and ancillary product.',
    `marketing_highlight_flag` BOOLEAN COMMENT 'Indicates whether this ancillary inclusion should be prominently featured in fare family marketing materials and comparison charts. True for key differentiators (e.g., Premium Economy highlighting extra legroom and priority boarding). This marketing emphasis is specific to the fare family-ancillary relationship.',
    `quantity_entitlement` STRING COMMENT 'Number of units of the ancillary product included or available at the specified inclusion type within this fare family. For example, 2 checked bags included, or 1 lounge access permitted. Zero indicates availability without quantity limit. This quantity is specific to the fare family-ancillary combination.',
    CONSTRAINT pk_revenue_bundle_component PRIMARY KEY(`revenue_bundle_component_id`)
) COMMENT 'This association product represents the inclusion relationship between fare families and ancillary products. It captures how each branded fare bundle includes, excludes, or offers discounted access to specific ancillary services. Each record links one fare family to one ancillary product with attributes defining the inclusion type, quantity entitlements, pricing deltas, and effective periods that exist only in the context of this bundling relationship.. Existence Justification: Airlines configure branded fare families (e.g., Basic Economy, Premium Economy, Business Flex) as bundles that include multiple ancillary products at different entitlement levels. A single fare family includes many ancillary products (baggage, seat selection, lounge access, meals, Wi-Fi), and each ancillary product appears across multiple fare families with varying inclusion types (free, discounted, excluded) and quantity limits. Product managers actively manage these bundle configurations, adjusting inclusions, pricing deltas, and effective periods as part of merchandising strategy.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`agency` (
    `agency_id` BIGINT COMMENT 'Primary key for agency',
    `parent_agency_id` BIGINT COMMENT 'Reference to the parent or host agency if this agency operates as a branch or sub-agency within a larger agency network. Null for independent agencies.',
    `accreditation_date` DATE COMMENT 'The date when the agency received its IATA accreditation, enabling it to sell airline tickets through the BSP or ARC systems.',
    `address_line_1` STRING COMMENT 'First line of the agencys registered business address, typically containing street number and street name.',
    `address_line_2` STRING COMMENT 'Second line of the agencys business address for suite, floor, building, or other supplementary location information.',
    `agency_name` STRING COMMENT 'The full legal registered name of the travel agency as it appears in official business documentation and contracts.',
    `agency_status` STRING COMMENT 'Current operational status of the agency in the airlines distribution network. Active agencies can issue tickets and receive commissions.',
    `agency_type` STRING COMMENT 'Classification of the agency based on its primary business model and customer segment served.',
    `annual_sales_volume` DECIMAL(18,2) COMMENT 'Total ticket sales revenue generated by the agency in the most recent fiscal year, used for performance segmentation and commission tier determination.',
    `arc_number` STRING COMMENT 'Seven-digit numeric identifier assigned by ARC to agencies operating in the United States for ticket settlement and reporting purposes.',
    `bsp_country_code` STRING COMMENT 'Three-letter ISO country code identifying the BSP jurisdiction under which the agency operates and settles transactions.',
    `city` STRING COMMENT 'City or municipality where the agencys registered business office is located.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The standard commission percentage paid to the agency on ticket sales, expressed as a percentage (e.g., 5.00 for 5%). This is the base rate before any overrides or incentives.',
    `contract_effective_date` DATE COMMENT 'The date when the agencys distribution agreement with the airline became effective, establishing the commercial relationship.',
    `contract_expiration_date` DATE COMMENT 'The date when the current agency distribution agreement expires. Null for evergreen or indefinite agreements.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the agency is registered and operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was first created in the system, capturing the initial data entry event.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure or outstanding balance allowed for the agency under direct billing arrangements. Null if not applicable.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency in which the agency conducts transactions and receives commission payments.',
    `gds_code` STRING COMMENT 'Primary GDS platform used by the agency for booking and ticketing airline inventory.',
    `iata_number` STRING COMMENT 'Eight-digit numeric code assigned by IATA to identify accredited travel agencies globally. This is the primary business identifier used in BSP settlements and ARC reporting.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or financial audit conducted on the agencys operations and ticket sales practices.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in this agency record, used for change tracking and data synchronization.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic business review or contract renewal discussion with the agency.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional operational notes, special handling instructions, or historical context about the agency relationship.',
    `override_commission_rate` DECIMAL(18,2) COMMENT 'Additional commission percentage awarded to high-performing agencies based on volume or strategic partnership agreements. Null if no override applies.',
    `payment_method` STRING COMMENT 'The primary settlement mechanism through which the agency remits ticket sales proceeds to the airline.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the agencys business address, used for mail delivery and geographic segmentation.',
    `preferred_agency_flag` BOOLEAN COMMENT 'Indicates whether this agency has been designated as a preferred or strategic partner receiving enhanced support, priority service, or special incentives.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for agency communications, notifications, and support.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the agency for operational and commercial communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the agencys main business contact, including country and area codes.',
    `region_code` STRING COMMENT 'Internal airline sales region or territory code to which this agency is assigned for sales management and reporting purposes.',
    `risk_rating` STRING COMMENT 'Internal credit and operational risk assessment classification for the agency, used to determine credit terms and monitoring requirements.',
    `state_province` STRING COMMENT 'State, province, or primary administrative subdivision where the agency is located.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number or business registration number for the agency, used for tax reporting and compliance.',
    `trade_name` STRING COMMENT 'The commercial or doing-business-as (DBA) name under which the agency operates and markets its services to customers.',
    CONSTRAINT pk_agency PRIMARY KEY(`agency_id`)
) COMMENT 'Master reference table for agency. Referenced by agency_id.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`corporate_account` (
    `corporate_account_id` BIGINT COMMENT 'Primary key for corporate_account',
    `employee_id` BIGINT COMMENT 'Identifier of the airline employee responsible for managing this corporate account relationship.',
    `parent_corporate_account_id` BIGINT COMMENT 'Self-referencing FK on corporate_account (parent_corporate_account_id)',
    `account_name` STRING COMMENT 'Legal or trading name of the corporate entity holding this account.',
    `account_number` STRING COMMENT 'Externally-visible unique account number assigned to the corporate customer for billing and reference purposes.',
    `account_status` STRING COMMENT 'Current lifecycle status of the corporate account indicating whether it is operational and eligible for bookings.',
    `account_type` STRING COMMENT 'Classification of the corporate account based on business segment and size.',
    `annual_revenue_commitment_amount` DECIMAL(18,2) COMMENT 'Minimum annual revenue the corporate customer has committed to generate under the agreement.',
    `annual_revenue_commitment_currency_code` STRING COMMENT 'Three-letter ISO currency code for the annual revenue commitment amount.',
    `auto_ticketing_enabled` BOOLEAN COMMENT 'Indicates whether automatic ticket issuance is enabled for bookings made under this corporate account.',
    `billing_address_line1` STRING COMMENT 'First line of the corporate billing address including street number and name.',
    `billing_address_line2` STRING COMMENT 'Second line of the corporate billing address for suite, floor, or building information.',
    `billing_city` STRING COMMENT 'City or municipality of the corporate billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code of the corporate billing address.',
    `billing_cycle_day` STRING COMMENT 'Day of the month on which invoices are generated for this corporate account (1-31).',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the corporate billing address.',
    `billing_state_province` STRING COMMENT 'State, province, or region of the corporate billing address.',
    `contract_end_date` DATE COMMENT 'Date when the corporate account agreement expires. Null indicates an open-ended or evergreen agreement.',
    `contract_start_date` DATE COMMENT 'Date when the corporate account agreement becomes effective and the account is authorized to begin transacting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate account record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for this corporate account before payment is required.',
    `credit_limit_currency_code` STRING COMMENT 'Three-letter ISO currency code for the credit limit amount.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to base fares as negotiated in the corporate agreement.',
    `fare_basis_code` STRING COMMENT 'Fare basis code identifying the special corporate fare class and rules applicable to this account.',
    `industry_sector` STRING COMMENT 'Primary industry sector of the corporate customer for segmentation and analytics purposes.',
    `last_booking_date` DATE COMMENT 'Date of the most recent booking made under this corporate account for activity tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate account record was last updated.',
    `loyalty_program_integration_enabled` BOOLEAN COMMENT 'Indicates whether travelers under this corporate account can earn and redeem loyalty points.',
    `notes` STRING COMMENT 'Free-text field for account managers to record special instructions, preferences, or historical context.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due per the corporate agreement.',
    `preferred_cabin_class` STRING COMMENT 'Default cabin class preference for travelers booking under this corporate account.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for account communications and notifications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person responsible for managing this corporate account.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary business contact for urgent account matters.',
    `revenue_tier` STRING COMMENT 'Tier classification based on annual revenue contribution used for prioritization and service levels.',
    `risk_rating` STRING COMMENT 'Credit risk assessment rating assigned to this corporate account based on payment history and financial health.',
    `tax_identifier` STRING COMMENT 'Tax identification number or VAT registration number of the corporate entity for invoicing and compliance.',
    `total_bookings_count` STRING COMMENT 'Cumulative count of all bookings made under this corporate account since inception.',
    `travel_policy_url` STRING COMMENT 'Web address linking to the corporate customers internal travel policy document for reference.',
    CONSTRAINT pk_corporate_account PRIMARY KEY(`corporate_account_id`)
) COMMENT 'Master reference table for corporate_account. Referenced by account_id.';

CREATE OR REPLACE TABLE `airlines_ecm`.`revenue`.`bid_price_curve` (
    `bid_price_curve_id` BIGINT COMMENT 'Primary key for bid_price_curve',
    `employee_id` BIGINT COMMENT 'Reference to the revenue management analyst or system user who approved this bid price curve for operational use.',
    `scheduled_flight_id` BIGINT COMMENT 'Reference to the specific flight this bid price curve applies to.',
    `superseded_bid_price_curve_id` BIGINT COMMENT 'Self-referencing FK on bid_price_curve (superseded_bid_price_curve_id)',
    `approval_status` STRING COMMENT 'The approval workflow status for this bid price curve, indicating whether it has been reviewed and approved for operational use.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this bid price curve was approved for operational use.',
    `authorization_level` STRING COMMENT 'The maximum number of seats authorized for sale in this booking class at the current bid price.',
    `base_bid_price_amount` DECIMAL(18,2) COMMENT 'The baseline bid price value representing the minimum acceptable revenue per seat for this curve segment.',
    `booking_class_code` STRING COMMENT 'Single-letter code representing the specific booking class (fare bucket) within the cabin class.',
    `cabin_class_code` STRING COMMENT 'Single-letter code representing the cabin class (e.g., F=First, J=Business, Y=Economy) this bid price curve applies to.',
    `capacity_available_units` STRING COMMENT 'The total number of seats available for sale in the booking class this bid price curve applies to.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bid price curve record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this bid price curve.',
    `curve_code` STRING COMMENT 'Externally-known unique business identifier for the bid price curve, used in revenue management systems and operational references.',
    `curve_generation_method` STRING COMMENT 'The method used to generate this bid price curve: automated (system-generated), manual (analyst-created), hybrid (combination), or machine learning based.',
    `curve_name` STRING COMMENT 'Human-readable descriptive name for the bid price curve, typically indicating the route, season, or market segment it applies to.',
    `curve_type` STRING COMMENT 'Classification of the bid price curve methodology: static (fixed), dynamic (real-time adjusted), hybrid (combination), forecast-based (demand forecast driven), or historical (based on past performance).',
    `days_before_departure_end` STRING COMMENT 'The ending point in the booking window (days before departure) for which this bid price curve is applicable.',
    `days_before_departure_start` STRING COMMENT 'The starting point in the booking window (days before departure) for which this bid price curve is applicable.',
    `demand_forecast_units` STRING COMMENT 'The forecasted demand in number of seats or passengers for the flight leg and booking class this curve applies to.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the destination of the flight leg this curve applies to.',
    `displacement_cost_amount` DECIMAL(18,2) COMMENT 'The estimated revenue loss from displacing a higher-value passenger by accepting a lower-value booking.',
    `effective_from_date` DATE COMMENT 'The date from which this bid price curve becomes active and applicable for revenue management calculations.',
    `effective_to_date` DATE COMMENT 'The date until which this bid price curve remains active. Nullable for open-ended curves.',
    `last_optimization_timestamp` TIMESTAMP COMMENT 'The date and time when this bid price curve was last recalculated or optimized by the revenue management system.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bid price curve record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments from revenue management analysts regarding special considerations, overrides, or context for this bid price curve.',
    `optimization_model` STRING COMMENT 'The revenue optimization model used to generate this bid price curve. EMSR (Expected Marginal Seat Revenue) variants, network optimization, leg-based, or Origin and Destination (O&D) based models.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the origin of the flight leg this curve applies to.',
    `protection_level` STRING COMMENT 'The number of seats protected (reserved) for higher-value booking classes, used in nested inventory control.',
    `spill_cost_amount` DECIMAL(18,2) COMMENT 'The estimated revenue loss from turning away demand due to inventory restrictions or overbooking limits.',
    `bid_price_curve_status` STRING COMMENT 'Current lifecycle status of the bid price curve indicating whether it is actively being used in revenue management decisions.',
    `version_number` STRING COMMENT 'Sequential version number for this bid price curve, incremented each time the curve is recalculated or updated.',
    CONSTRAINT pk_bid_price_curve PRIMARY KEY(`bid_price_curve_id`)
) COMMENT 'Master reference table for bid_price_curve. Referenced by bid_price_curve_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ADD CONSTRAINT `fk_revenue_fare_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ADD CONSTRAINT `fk_revenue_fare_rule_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ADD CONSTRAINT `fk_revenue_fare_rule_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ADD CONSTRAINT `fk_revenue_pricing_record_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ADD CONSTRAINT `fk_revenue_yield_parameter_bid_price_curve_id` FOREIGN KEY (`bid_price_curve_id`) REFERENCES `airlines_ecm`.`revenue`.`bid_price_curve`(`bid_price_curve_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ADD CONSTRAINT `fk_revenue_yield_parameter_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ADD CONSTRAINT `fk_revenue_yield_parameter_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ADD CONSTRAINT `fk_revenue_ticket_pricing_record_id` FOREIGN KEY (`pricing_record_id`) REFERENCES `airlines_ecm`.`revenue`.`pricing_record`(`pricing_record_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_fare_class_id` FOREIGN KEY (`fare_class_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_class`(`fare_class_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ADD CONSTRAINT `fk_revenue_ticket_coupon_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_pricing_record_id` FOREIGN KEY (`pricing_record_id`) REFERENCES `airlines_ecm`.`revenue`.`pricing_record`(`pricing_record_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ADD CONSTRAINT `fk_revenue_revenue_emd_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ADD CONSTRAINT `fk_revenue_arc_settlement_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ADD CONSTRAINT `fk_revenue_arc_settlement_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ADD CONSTRAINT `fk_revenue_adm_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ADD CONSTRAINT `fk_revenue_adm_arc_settlement_id` FOREIGN KEY (`arc_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`arc_settlement`(`arc_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ADD CONSTRAINT `fk_revenue_adm_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ADD CONSTRAINT `fk_revenue_adm_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_arc_settlement_id` FOREIGN KEY (`arc_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`arc_settlement`(`arc_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_interline_prorate_id` FOREIGN KEY (`interline_prorate_id`) REFERENCES `airlines_ecm`.`revenue`.`interline_prorate`(`interline_prorate_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ADD CONSTRAINT `fk_revenue_recognition_ticket_coupon_id` FOREIGN KEY (`ticket_coupon_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket_coupon`(`ticket_coupon_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_arc_settlement_id` FOREIGN KEY (`arc_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`arc_settlement`(`arc_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ADD CONSTRAINT `fk_revenue_interline_prorate_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ADD CONSTRAINT `fk_revenue_corporate_contract_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_arc_settlement_id` FOREIGN KEY (`arc_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`arc_settlement`(`arc_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_revenue_emd_id` FOREIGN KEY (`revenue_emd_id`) REFERENCES `airlines_ecm`.`revenue`.`revenue_emd`(`revenue_emd_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ADD CONSTRAINT `fk_revenue_revenue_refund_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_arc_settlement_id` FOREIGN KEY (`arc_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`arc_settlement`(`arc_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_bsp_settlement_id` FOREIGN KEY (`bsp_settlement_id`) REFERENCES `airlines_ecm`.`revenue`.`bsp_settlement`(`bsp_settlement_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ADD CONSTRAINT `fk_revenue_ticket_exchange_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_pricing_record_id` FOREIGN KEY (`pricing_record_id`) REFERENCES `airlines_ecm`.`revenue`.`pricing_record`(`pricing_record_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ADD CONSTRAINT `fk_revenue_ndc_offer_order_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `airlines_ecm`.`revenue`.`ticket`(`ticket_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ADD CONSTRAINT `fk_revenue_contract_inventory_allocation_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ADD CONSTRAINT `fk_revenue_fare_applicability_fare_id` FOREIGN KEY (`fare_id`) REFERENCES `airlines_ecm`.`revenue`.`fare`(`fare_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ADD CONSTRAINT `fk_revenue_corporate_ancillary_entitlement_corporate_contract_id` FOREIGN KEY (`corporate_contract_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_contract`(`corporate_contract_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ADD CONSTRAINT `fk_revenue_revenue_bundle_component_fare_family_id` FOREIGN KEY (`fare_family_id`) REFERENCES `airlines_ecm`.`revenue`.`fare_family`(`fare_family_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ADD CONSTRAINT `fk_revenue_agency_parent_agency_id` FOREIGN KEY (`parent_agency_id`) REFERENCES `airlines_ecm`.`revenue`.`agency`(`agency_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ADD CONSTRAINT `fk_revenue_corporate_account_parent_corporate_account_id` FOREIGN KEY (`parent_corporate_account_id`) REFERENCES `airlines_ecm`.`revenue`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `airlines_ecm`.`revenue`.`bid_price_curve` ADD CONSTRAINT `fk_revenue_bid_price_curve_superseded_bid_price_curve_id` FOREIGN KEY (`superseded_bid_price_curve_id`) REFERENCES `airlines_ecm`.`revenue`.`bid_price_curve`(`bid_price_curve_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`revenue` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `airlines_ecm`.`revenue` SET TAGS ('dbx_domain' = 'revenue');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare ID');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `fare_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `atpco_record_type` SET TAGS ('dbx_business_glossary_term' = 'ATPCO Record Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `atpco_record_type` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,8}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class (RBD - Reservation Booking Designator)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Designator Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `changeable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Changeable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `combinability_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Combinability Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `combinability_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `directionality` SET TAGS ('dbx_business_glossary_term' = 'Fare Directionality');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `directionality` SET TAGS ('dbx_value_regex' = 'one_way|round_trip|circle_trip|open_jaw');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Fare Discontinue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Fare Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `fare_status` SET TAGS ('dbx_business_glossary_term' = 'Fare Lifecycle Status');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `fare_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|withdrawn|superseded');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `fare_type` SET TAGS ('dbx_business_glossary_term' = 'Fare Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `fare_type` SET TAGS ('dbx_value_regex' = 'published|negotiated|private|web|net');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Fare Filing Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `global_indicator` SET TAGS ('dbx_business_glossary_term' = 'Global Indicator (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `iata_fare_filing_ref` SET TAGS ('dbx_business_glossary_term' = 'IATA Fare Filing Reference');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `maximum_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `minimum_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `ownership` SET TAGS ('dbx_business_glossary_term' = 'Fare Ownership / Filing Source');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `ownership` SET TAGS ('dbx_value_regex' = 'ATPCO|SITA|carrier_filed');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `owrt_indicator` SET TAGS ('dbx_business_glossary_term' = 'One-Way / Round-Trip (OWRT) Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `owrt_indicator` SET TAGS ('dbx_value_regex' = 'O|R|X');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `refundable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Refundable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number (ATPCO)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,5}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `sales_restriction` SET TAGS ('dbx_business_glossary_term' = 'Sales Restriction');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `sales_restriction` SET TAGS ('dbx_value_regex' = 'no_restriction|country_of_origin|carrier_office|internet_only|agency_only');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Tariff Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `tariff_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Fare Tariff Number (ATPCO)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `tariff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `ticketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Carrier Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `ticketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `travel_discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Discontinue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare` ALTER COLUMN `travel_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `fare_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Rule ID');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `fare_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis ID');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `advance_purchase_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Requirement (Hours)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `atpco_category_number` SET TAGS ('dbx_business_glossary_term' = 'Airline Tariff Publishing Company (ATPCO) Category Number');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `blackout_end_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period End Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `blackout_start_date` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Start Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `cabin_type` SET TAGS ('dbx_business_glossary_term' = 'Cabin Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `cabin_type` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Category Name');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `change_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Change Fee Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `change_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `change_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Change Fee Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `change_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `combinability_type` SET TAGS ('dbx_business_glossary_term' = 'Combinability Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `combinability_type` SET TAGS ('dbx_value_regex' = 'end_on_end|back_to_back|open_jaw|round_trip|none');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Rule Discontinue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `endorsement_text` SET TAGS ('dbx_business_glossary_term' = 'Endorsement and Restriction Text');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `fare_class_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Code (Booking Class)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `fare_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `global_indicator` SET TAGS ('dbx_business_glossary_term' = 'Global Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `is_changeable` SET TAGS ('dbx_business_glossary_term' = 'Changeable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Refundable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `max_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `min_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `min_stay_type` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `min_stay_type` SET TAGS ('dbx_value_regex' = 'days|saturday_night|none');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `permitted_days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Permitted Days of Week');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `refund_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Penalty Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `refund_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `refund_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Refund Penalty Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `refund_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `rule_number` SET TAGS ('dbx_business_glossary_term' = 'Fare Rule Number');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `rule_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Fare Rule Status');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|pending');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `rule_text` SET TAGS ('dbx_business_glossary_term' = 'Fare Rule Full Text');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `sales_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Restriction Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `sales_restriction_type` SET TAGS ('dbx_value_regex' = 'internet_only|agency_only|direct_only|gds_only|none');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'peak|shoulder|off_peak|none');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ATPCO|SABRE|AMADEUS|INTERNAL');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `stopovers_permitted` SET TAGS ('dbx_business_glossary_term' = 'Stopovers Permitted Count');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Tariff Number');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `tariff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,8}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `transfers_permitted` SET TAGS ('dbx_business_glossary_term' = 'Transfers Permitted Count');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `travel_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Travel Restriction Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `travel_restriction_type` SET TAGS ('dbx_value_regex' = 'outbound_only|inbound_only|both|none');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `fare_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class ID');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `availability_control_method` SET TAGS ('dbx_business_glossary_term' = 'Availability Control Method');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `availability_control_method` SET TAGS ('dbx_value_regex' = 'leg|segment|od|virtual_nesting');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `award_redemption_class` SET TAGS ('dbx_business_glossary_term' = 'Award Redemption Class Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `blackout_applicable` SET TAGS ('dbx_business_glossary_term' = 'Blackout Period Applicable Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `carry_on_bag_allowance` SET TAGS ('dbx_business_glossary_term' = 'Carry-On Baggage Allowance (Pieces)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `changeable` SET TAGS ('dbx_business_glossary_term' = 'Changeable Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `checked_bag_allowance` SET TAGS ('dbx_business_glossary_term' = 'Checked Baggage Allowance (Pieces)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `codeshare_eligible` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Eligible Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Restriction');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'all|gds_only|direct_only|ndc_only|gds_and_direct');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `family` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Family');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `fare_basis_code_pattern` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code Pattern');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `fare_class_description` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Description');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `fare_class_status` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Status');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `fare_class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|seasonal');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `interline_eligible` SET TAGS ('dbx_business_glossary_term' = 'Interline Eligible Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `lounge_access_included` SET TAGS ('dbx_business_glossary_term' = 'Lounge Access Included Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `max_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `mileage_accrual_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Mileage Accrual Multiplier');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `min_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `no_show_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'No-Show Fee Applicable Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `overbooking_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Eligible Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `priority_boarding_included` SET TAGS ('dbx_business_glossary_term' = 'Priority Boarding Included Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `rbd_code` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Designator (RBD) Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `rbd_code` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `refundable` SET TAGS ('dbx_business_glossary_term' = 'Refundable Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `revenue_class_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `revenue_class_type` SET TAGS ('dbx_value_regex' = 'revenue|award|staff|charter|group|tour_operator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `same_day_change_eligible` SET TAGS ('dbx_business_glossary_term' = 'Same-Day Change Eligible Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `seat_selection_included` SET TAGS ('dbx_business_glossary_term' = 'Seat Selection Included Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SABRE_AV|AMADEUS_ALTEA|MANUAL|ATPCO');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `standby_eligible` SET TAGS ('dbx_business_glossary_term' = 'Standby Eligible Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `upgrade_eligible` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligible Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_class` ALTER COLUMN `yield_class_rank` SET TAGS ('dbx_business_glossary_term' = 'Yield Class Rank');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pricing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record ID');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `corporate_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `fare_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `fare_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Quote ID');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class (RBD)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `carrier_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier-Imposed Surcharge Amount (YQ/YR)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `carrier_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `changeable_flag` SET TAGS ('dbx_business_glossary_term' = 'Changeable Fare Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `equivalent_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Fare Amount (NUC)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `equivalent_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `fare_type` SET TAGS ('dbx_business_glossary_term' = 'Fare Type');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `fare_type` SET TAGS ('dbx_value_regex' = 'PUBLIC|PRIVATE|NEGOTIATED|CORPORATE|NET|TOUR');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `form_of_payment_restriction` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment Restriction');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `form_of_payment_restriction` SET TAGS ('dbx_value_regex' = 'NONE|CREDIT_CARD_ONLY|CASH_ONLY|SPECIFIC_CARD|MILES_ONLY');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `iata_rate_of_exchange` SET TAGS ('dbx_business_glossary_term' = 'IATA Rate of Exchange (ROE)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `max_stay_requirement` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stay Requirement');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `min_stay_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Requirement');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `ndc_offer_reference` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Offer ID');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = 'ADT|CHD|INF|YTH|MIL|SRC');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pricing_source` SET TAGS ('dbx_value_regex' = 'GDS|DIRECT|NDC|API|INTERLINE|CODESHARE');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pricing_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record Status');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pricing_status` SET TAGS ('dbx_value_regex' = 'QUOTED|TICKETED|EXPIRED|CANCELLED|REPRICED|VOIDED');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `pricing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Event Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `quote_reference` SET TAGS ('dbx_business_glossary_term' = 'Fare Quote Reference');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundable Fare Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Travel Date');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `routing_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Routing Code');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `segment_count` SET TAGS ('dbx_business_glossary_term' = 'Flight Segment Count');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `ticketing_time_limit` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Time Limit (TTL)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fare Amount (All-In)');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `travel_date` SET TAGS ('dbx_business_glossary_term' = 'Outbound Travel Date');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `trip_type` SET TAGS ('dbx_business_glossary_term' = 'Trip Type');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `trip_type` SET TAGS ('dbx_value_regex' = 'OW|RT|OJ|CT');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Validating Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`pricing_record` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Tax and Fee ID');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `airport_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicability Scope');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_value_regex' = 'domestic|international|both');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `cabin_class_applicability` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Applicability');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `cabin_class_applicability` SET TAGS ('dbx_value_regex' = 'all|economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat_amount|ad_valorem_percent|per_segment|per_coupon|per_pax_per_direction');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `collecting_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Collecting Authority Name');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `collecting_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Collecting Authority Type');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `collecting_authority_type` SET TAGS ('dbx_value_regex' = 'government|airport_operator|carrier|intergovernmental');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `corsia_applicable` SET TAGS ('dbx_business_glossary_term' = 'CORSIA Applicable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `exempt_passenger_types` SET TAGS ('dbx_business_glossary_term' = 'Exempt Passenger Types');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Expiry Date');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `gds_display_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Display Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `gds_display_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `iata_tax_category` SET TAGS ('dbx_business_glossary_term' = 'IATA Tax Category');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `iata_tax_category` SET TAGS ('dbx_value_regex' = 'tax|fee|charge|surcharge');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `maximum_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Maximum Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Minimum Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `passenger_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Applicability');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `passenger_type_applicability` SET TAGS ('dbx_value_regex' = 'all|adult|child|infant|unaccompanied_minor');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Published Date');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `refundable` SET TAGS ('dbx_business_glossary_term' = 'Tax Refundable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `remittance_channel` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `remittance_channel` SET TAGS ('dbx_value_regex' = 'bsp|arc|direct_to_authority|interline_settlement');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `remittance_destination_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Destination Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `remittance_destination_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `route_specific` SET TAGS ('dbx_business_glossary_term' = 'Route-Specific Tax Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `sap_tax_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Tax Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `sap_tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `superseded_by_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tax Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `superseded_by_tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_basis` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Basis');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_basis` SET TAGS ('dbx_value_regex' = 'base_fare|total_fare|fuel_surcharge|carrier_imposed_fee|ticket_price');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax and Fee Code');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_fee_status` SET TAGS ('dbx_business_glossary_term' = 'Tax and Fee Record Status');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_fee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|pending');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_name` SET TAGS ('dbx_business_glossary_term' = 'Tax and Fee Name');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax and Fee Type');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'government_tax|airport_charge|carrier_surcharge|security_fee|passenger_facility_charge|environmental_levy');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `ticket_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Ticket Type Applicability');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `ticket_type_applicability` SET TAGS ('dbx_value_regex' = 'all|e_ticket|paper_ticket|emd');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Version Number');
ALTER TABLE `airlines_ecm`.`revenue`.`tax_fee` ALTER COLUMN `waivable` SET TAGS ('dbx_business_glossary_term' = 'Tax Waivable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `yield_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Parameter ID');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `bid_price_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Price Curve ID');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Revenue Manager)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `booking_class_threshold_count` SET TAGS ('dbx_business_glossary_term' = 'Booking Class Availability Threshold Count');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `cancellation_rate` SET TAGS ('dbx_business_glossary_term' = 'Historical Cancellation Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `cask_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Cost per Available Seat Kilometer (CASK) Benchmark');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `cask_benchmark` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `dilution_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Dilution Tolerance (%)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `dynamic_pricing_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Pricing Ceiling Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `dynamic_pricing_ceiling` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `dynamic_pricing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Pricing Enabled Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `dynamic_pricing_floor` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Pricing Floor Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `dynamic_pricing_floor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `forecast_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Type');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_value_regex' = 'additive|multiplicative|hybrid|neural_network|pickup');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `group_booking_threshold` SET TAGS ('dbx_business_glossary_term' = 'Group Booking Threshold (Pax)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `historical_weight` SET TAGS ('dbx_business_glossary_term' = 'Historical Data Weight');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `load_factor_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Load Factor (%)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `load_factor_target` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Target (%)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `minimum_yield_floor` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Yield Floor');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `minimum_yield_floor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `no_show_rate` SET TAGS ('dbx_business_glossary_term' = 'Historical No-Show Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `od_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Origin-Destination (O&D) Control Enabled Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `optimization_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Management Optimization Method');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `optimization_method` SET TAGS ('dbx_value_regex' = 'emsr_a|emsr_b|lp_based|network_bid_price|hybrid');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `overbooking_authorization_rate` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Authorization Rate (%)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Yield Parameter Code');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,30}$');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_description` SET TAGS ('dbx_business_glossary_term' = 'Yield Parameter Description');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Yield Parameter Name');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Yield Parameter Status');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|pending_review');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Yield Parameter Type');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `parameter_type` SET TAGS ('dbx_value_regex' = 'market|route|flight_group|cabin|global');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `pickup_weight` SET TAGS ('dbx_business_glossary_term' = 'Pickup Trend Weight');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `rask_target` SET TAGS ('dbx_business_glossary_term' = 'Revenue per Available Seat Kilometer (RASK) Target');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `rask_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Parameter Review Frequency');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi_weekly|monthly|seasonal');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Season Code');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^(S|W)[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `spoilage_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Spoilage Tolerance (%)');
ALTER TABLE `airlines_ecm`.`revenue`.`yield_parameter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` SET TAGS ('dbx_subdomain' = 'document_fulfillment');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Bsp Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `corporate_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `pricing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class (RBD — Reservation Booking Designator)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'F|C|W|Y');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `conjunction_ticket_indicator` SET TAGS ('dbx_business_glossary_term' = 'Conjunction Ticket Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `conjunction_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Conjunction Ticket Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `conjunction_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `coupon_count` SET TAGS ('dbx_business_glossary_term' = 'Flight Coupon Count');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `endorsement_restriction_text` SET TAGS ('dbx_business_glossary_term' = 'Endorsement and Restriction Text');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_type` SET TAGS ('dbx_business_glossary_term' = 'Fare Type Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `fare_type` SET TAGS ('dbx_value_regex' = 'PUB|NEG|NET|GOV|FFP|GRP');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ffp_miles_earned` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Miles Earned');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `form_of_payment_detail` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment Detail (Masked)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `form_of_payment_detail` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `form_of_payment_detail` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Type Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_value_regex' = 'CC|CA|CK|TP|MS|EP');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Issue Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `net_remit_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Remit Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `net_remit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `net_remit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Original Ticket Number (Exchange Reference)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `passenger_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Name Field');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `passenger_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `passenger_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Refund Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `sale_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Sale Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `sale_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Ticket Sales Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `tax_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `tax_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `tax_total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'IATA 13-Digit Ticket Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Lifecycle Status');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `ticket_status` SET TAGS ('dbx_value_regex' = 'open|used|refunded|voided|exchanged|lifted');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Ticket Fare Amount (Gross)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `total_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticket Void Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` SET TAGS ('dbx_subdomain' = 'document_fulfillment');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `consumer_protection_case_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Case Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fuel_uplift_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `actual_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `baggage_allowance` SET TAGS ('dbx_business_glossary_term' = 'Baggage Allowance');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `baggage_allowance` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}(PC|KG)$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class / Reservation Booking Designator (RBD)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'F|C|W|Y');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `coupon_number` SET TAGS ('dbx_business_glossary_term' = 'Coupon Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_business_glossary_term' = 'Coupon Status Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `exchange_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Exchange Ticket Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `exchange_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Coupon Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,15}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_construction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fare Construction Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_construction_indicator` SET TAGS ('dbx_value_regex' = 'NUC|SITI|SOTO|SITO|SOTI');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `fare_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `flown_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Flown Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `issuing_date` SET TAGS ('dbx_business_glossary_term' = 'Ticket Issuance Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `lifted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coupon Lifted Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `not_valid_after_date` SET TAGS ('dbx_business_glossary_term' = 'Not Valid After Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `not_valid_before_date` SET TAGS ('dbx_business_glossary_term' = 'Not Valid Before Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `nuc_amount` SET TAGS ('dbx_business_glossary_term' = 'Neutral Unit of Construction (NUC) Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Coupon Refund Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Refund Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'BSP|ARC|DIRECT|INTERLINE');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `stopover_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stopover Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Coupon Tax Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Coupon Total Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_coupon` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Void Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` SET TAGS ('dbx_subdomain' = 'document_fulfillment');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `revenue_emd_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) ID');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Crew Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Office IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `pricing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `associated_ticket_coupon` SET TAGS ('dbx_business_glossary_term' = 'Associated Ticket Coupon Reference');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'EMD Base Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `base_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `bsp_arc_billing_period` SET TAGS ('dbx_business_glossary_term' = 'BSP/ARC Billing Period');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `bsp_arc_billing_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `bsp_arc_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'BSP/ARC Reporting Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `coupon_number` SET TAGS ('dbx_business_glossary_term' = 'EMD Coupon Number');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `emd_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Number');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `emd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `emd_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Status');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `emd_status` SET TAGS ('dbx_value_regex' = 'open|used|refunded|voided|exchanged|suspended');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `emd_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Type');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `emd_type` SET TAGS ('dbx_value_regex' = 'EMD-A|EMD-S');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `equivalent_amount` SET TAGS ('dbx_business_glossary_term' = 'EMD Equivalent Amount (Airline Currency)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `equivalent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `equivalent_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `exchange_emd_number` SET TAGS ('dbx_business_glossary_term' = 'Exchanged-From EMD Number');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `exchange_emd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Associated Flight Number');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `form_of_payment_detail` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Detail');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `form_of_payment_detail` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `form_of_payment_detail` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment (FOP) Type');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `gds_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `gds_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `interline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interline EMD Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'EMD Issue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'EMD Issue Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `passenger_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `passenger_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `passenger_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'EMD Refund Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'EMD Refund Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `rfic` SET TAGS ('dbx_business_glossary_term' = 'Reason for Issuance Code (RFIC)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `rfic` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `rfisc` SET TAGS ('dbx_business_glossary_term' = 'Reason for Issuance Sub-Code (RFISC)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `rfisc` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Description');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'EMD Tax and Fee Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'EMD Total Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `used_date` SET TAGS ('dbx_business_glossary_term' = 'EMD Used Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_emd` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'EMD Void Date');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` SET TAGS ('dbx_subdomain' = 'agency_reconciliation');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing and Settlement Plan (BSP) Settlement ID');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `acm_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Credit Memo (ACM) Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `acm_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `acm_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `adjustment_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Adjustment Reference');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `adm_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Debit Memo (ADM) Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `adm_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `adm_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `agent_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `agent_iata_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Travel Agent Name');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `agent_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `airline_numeric_code` SET TAGS ('dbx_business_glossary_term' = 'Airline IATA Numeric Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `airline_numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `arc_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Airlines Reporting Corporation (ARC) Report Reference');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'BSP Billing Period End Date');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'BSP Billing Period Start Date');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `bsp_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Billing and Settlement Plan (BSP) File Reference');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `bsp_file_reference` SET TAGS ('dbx_value_regex' = '^BSP-[A-Z]{2,3}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `bsp_market_country_code` SET TAGS ('dbx_business_glossary_term' = 'BSP Market Country Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `bsp_market_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `commission_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Dispute Reason Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'BSP Settlement Exchange Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `gds_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Provider Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `gds_provider_code` SET TAGS ('dbx_value_regex' = '1A|1S|1G|1V|1P');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `interline_indicator` SET TAGS ('dbx_business_glossary_term' = 'Interline Settlement Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `ndc_indicator` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `net_remittance_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Remittance Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `net_remittance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `net_remittance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `pfc_amount` SET TAGS ('dbx_business_glossary_term' = 'Passenger Facility Charge (PFC) Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `remittance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Due Date');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'GDS|direct|online_travel_agency|corporate|consolidator');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'BSP Settlement Date');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'BSP Settlement Status');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|disputed|adjusted|cancelled');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax and Surcharge Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `ticket_count` SET TAGS ('dbx_business_glossary_term' = 'Ticket Count');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `ticket_number_range_end` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number Range End');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `ticket_number_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `ticket_number_range_start` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number Range Start');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `ticket_number_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'BSP Transaction Type');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'sale|refund|ADM|ACM|reversal|adjustment');
ALTER TABLE `airlines_ecm`.`revenue`.`bsp_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` SET TAGS ('dbx_subdomain' = 'agency_reconciliation');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `arc_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Airlines Reporting Corporation (ARC) Settlement ID');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Travel Agency ID');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `adm_acm_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Debit Memo / Agency Credit Memo (ADM/ACM) Reason Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Travel Agency Name');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `agency_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `arc_agency_number` SET TAGS ('dbx_business_glossary_term' = 'ARC Agency Number');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `arc_agency_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `arc_agency_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `arc_period_number` SET TAGS ('dbx_business_glossary_term' = 'ARC Settlement Period Number');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `arc_period_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `commission_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `conjunction_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Conjunction Ticket Number');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `conjunction_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `dispute_reference` SET TAGS ('dbx_business_glossary_term' = 'ARC Dispute Reference Number');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `endorsement_restriction` SET TAGS ('dbx_business_glossary_term' = 'Ticket Endorsement and Restriction');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `gds_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `gds_code` SET TAGS ('dbx_value_regex' = '1A|1S|1G|1V|1P');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Ticket Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `is_codeshare` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Ticket Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `is_interline` SET TAGS ('dbx_business_glossary_term' = 'Interline Ticket Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Original Ticket Number');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `original_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `pfc_amount` SET TAGS ('dbx_business_glossary_term' = 'Passenger Facility Charge (PFC) Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale Country Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `point_of_sale_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'ARC Settlement Date');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'ARC Settlement Status');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'PENDING|SETTLED|DISPUTED|REVERSED|REJECTED');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax and Fee Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `tour_code` SET TAGS ('dbx_business_glossary_term' = 'Tour Code');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Issue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'ARC Transaction Type');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'SALE|REFUND|EXCHANGE|VOID|ADM|ACM');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `travel_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Commencement Date');
ALTER TABLE `airlines_ecm`.`revenue`.`arc_settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` SET TAGS ('dbx_subdomain' = 'agency_reconciliation');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `adm_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Debit Memo (ADM) ID');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `arc_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Arc Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Bsp Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `adm_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Debit Memo (ADM) Number');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `authorised_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Authorised Agent Commission Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `authorised_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `collected_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Collected Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `collected_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `collected_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agent Commission Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Agent Country Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'ADM Debit Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `debit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'ADM Dispute Date');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `dispute_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'ADM Dispute Deadline Date');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'ADM Dispute Status');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'undisputed|disputed|waived|upheld|reversed');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `gds_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `gds_code` SET TAGS ('dbx_value_regex' = '1A|1S|1G|1V|FD');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'ADM Issue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `issuing_office_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Airline Office Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `net_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'ADM Net Debit Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `net_debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `net_debit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `original_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `original_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `original_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `passenger_name` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `passenger_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `passenger_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'ADM Reason Code');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'ADM Reason Description');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'ADM Resolution Date');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'ADM Resolution Notes');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `settlement_channel` SET TAGS ('dbx_business_glossary_term' = 'Settlement Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `settlement_channel` SET TAGS ('dbx_value_regex' = 'BSP|ARC|DIRECT');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'ADM Tax Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `ticket_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Original Ticket Issue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`adm` ALTER COLUMN `waiver_code` SET TAGS ('dbx_business_glossary_term' = 'ADM Waiver Code');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` SET TAGS ('dbx_subdomain' = 'accounting_performance');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `arc_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Arc Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Bsp Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `interline_prorate_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Prorate Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `accounting_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Accounting Status');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `accounting_status` SET TAGS ('dbx_value_regex' = 'PENDING|RECOGNIZED|ADJUSTED|REVERSED|DISPUTED');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Adjustment Reason Code');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Booking Class (RBD)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `booking_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'F|C|W|Y');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `codeshare_flag` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Flight Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `emd_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Number');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'IATA Rate of Exchange (IROE)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment Type');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge (YQ/YR) Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `interline_flag` SET TAGS ('dbx_business_glossary_term' = 'Interline Itinerary Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Airline Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Airline Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `operating_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = 'ADT|CHD|INF|MIL|GOV|STU');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `prorate_amount` SET TAGS ('dbx_business_glossary_term' = 'Interline Prorate Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `prorate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `prorate_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'FLOWN|ACCRUAL|PRORATE|REDEMPTION|REVERSAL');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `recognition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `ticket_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Ticket Issue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`recognition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `interline_prorate_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Prorate ID');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `arc_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Arc Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Bsp Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `interline_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Billing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Interline Prorate Agreement Reference Number');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Prorate Agreement Status');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|SUSPENDED|EXPIRED|TERMINATED|PENDING');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Prorate Agreement Type');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'SPA|IATA_PRF|MILEAGE|FIXED_AMOUNT|PERCENTAGE');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Calculation Method');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'PROPORTIONAL|EQUAL_SPLIT|MILEAGE_RATIO|AGREED_FACTOR|FIXED');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `collected_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Collected Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `collected_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `directionality` SET TAGS ('dbx_business_glossary_term' = 'Fare Directionality');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `directionality` SET TAGS ('dbx_value_regex' = 'OW|RT|CT');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Prorate Dispute Status');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'NONE|DISPUTED|UNDER_REVIEW|RESOLVED');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `global_indicator` SET TAGS ('dbx_business_glossary_term' = 'Global Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `global_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `iata_conference_area` SET TAGS ('dbx_business_glossary_term' = 'IATA Traffic Conference Area');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `iata_conference_area` SET TAGS ('dbx_value_regex' = 'TC1|TC2|TC3');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `maximum_prorate_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Prorate Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `maximum_prorate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `minimum_prorate_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Prorate Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `minimum_prorate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prorate Agreement Notes');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `own_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Own Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `own_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `partner_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `partner_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorate_amount` SET TAGS ('dbx_business_glossary_term' = 'Prorate Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorate_basis` SET TAGS ('dbx_business_glossary_term' = 'Prorate Basis');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorate_basis` SET TAGS ('dbx_value_regex' = 'FARE|MILEAGE|WEIGHT|REVENUE');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorate_factor` SET TAGS ('dbx_business_glossary_term' = 'Prorate Factor');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prorate Percentage');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorated_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Prorated Revenue Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `prorated_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Prorate Record Type');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `record_type` SET TAGS ('dbx_value_regex' = 'AGREEMENT|TRANSACTION');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax and Surcharge Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `ticketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `ticketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Proration Transaction Date');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `via_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Via Airport IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`interline_prorate` ALTER COLUMN `via_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family ID');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `ancillary_bundle_code` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Bundle Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `ancillary_bundle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Branded Fare Commercial Name');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'ECONOMY|PREMIUM_ECONOMY|BUSINESS|FIRST');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `carry_on_bags_included` SET TAGS ('dbx_business_glossary_term' = 'Carry-On Bags Included Count');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `change_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Ticket Change Fee Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `change_permitted` SET TAGS ('dbx_business_glossary_term' = 'Ticket Change Permitted Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `checked_bags_included` SET TAGS ('dbx_business_glossary_term' = 'Checked Bags Included Count');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `combinability_permitted` SET TAGS ('dbx_business_glossary_term' = 'Fare Combinability Permitted Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Discontinue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Display Priority');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `family_status` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Lifecycle Status');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `family_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|DRAFT|RETIRED|SUSPENDED');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `fare_class_mapping` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Booking Code Mapping');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `fare_family_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Code');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `fare_family_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `gds_display_indicator` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Display Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `interline_permitted` SET TAGS ('dbx_business_glossary_term' = 'Interline Ticketing Permitted Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `lounge_access_included` SET TAGS ('dbx_business_glossary_term' = 'Lounge Access Included Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Marketing Description');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `maximum_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `meal_service_type` SET TAGS ('dbx_business_glossary_term' = 'Meal Service Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `meal_service_type` SET TAGS ('dbx_value_regex' = 'NONE|SNACK|MEAL|PREMIUM_MEAL|MULTI_COURSE');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `miles_accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Miles Accrual Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `minimum_stay_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stay Requirement (Days)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `ndc_eligible` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Eligible Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `priority_boarding_included` SET TAGS ('dbx_business_glossary_term' = 'Priority Boarding Included Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `refund_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Ticket Refund Fee Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `refund_permitted` SET TAGS ('dbx_business_glossary_term' = 'Ticket Refund Permitted Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `route_applicability` SET TAGS ('dbx_business_glossary_term' = 'Route Applicability Scope');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `route_applicability` SET TAGS ('dbx_value_regex' = 'DOMESTIC|INTERNATIONAL|TRANSOCEANIC|ALL');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `sabre_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Sabre AirVision Brand Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `sabre_brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `seat_selection_included` SET TAGS ('dbx_business_glossary_term' = 'Seat Selection Inclusion Type');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `seat_selection_included` SET TAGS ('dbx_value_regex' = 'NONE|STANDARD|PREFERRED|ANY');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Tier Level');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `upgrade_eligible` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligibility Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_family` ALTER COLUMN `wifi_included` SET TAGS ('dbx_business_glossary_term' = 'In-Flight Wi-Fi Included Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Contract ID');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee ID');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Bundle Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Ffp Member Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `advance_purchase_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Purchase Days');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `applicable_booking_classes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Booking Classes');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `applicable_cabin_classes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Cabin Classes');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `auto_renewal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `blackout_dates` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `changeable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Changeable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `commission_override_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Override Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `commission_override_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|suspended|terminated');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'net_fare|discount|commission_override|soft_dollar|zone_fare');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Corporate Contact Email Address');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Corporate Contact Name');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `corporate_contact_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `destination_airport_codes` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Codes');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `gds_corporate_code` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Corporate Code');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `gds_corporate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,8}$');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `gds_corporate_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `min_revenue_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Revenue Commitment');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `min_revenue_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `min_segment_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Segment Commitment');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `min_segment_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `net_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `net_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `origin_airport_codes` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Codes');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `pnr_corporate_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Corporate Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `rebate_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `rebate_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `refundable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Refundable Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Date');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_value_regex' = 'none|monthly|quarterly|annual|on_demand');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signing Date');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `soft_dollar_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Soft Dollar Credit Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `soft_dollar_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `volume_measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Volume Measurement Period');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_contract` ALTER COLUMN `volume_measurement_period` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|contract_period');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` SET TAGS ('dbx_subdomain' = 'document_fulfillment');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `revenue_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `arc_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Arc Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Bsp Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Agent ID');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `revenue_emd_id` SET TAGS ('dbx_business_glossary_term' = 'Emd Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `bsp_arc_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'BSP/ARC Settlement Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'F|C|W|Y');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `ffp_miles_refunded` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Miles Refunded');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `gross_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `gross_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `gross_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `involuntary_reason` SET TAGS ('dbx_business_glossary_term' = 'Involuntary Refund Reason');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `involuntary_reason` SET TAGS ('dbx_value_regex' = 'flight_cancellation|significant_delay|denied_boarding|downgrade|schedule_change');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Airline Code (IATA Carrier Code)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `issuing_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `original_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `original_form_of_payment_code` SET TAGS ('dbx_business_glossary_term' = 'Original Form of Payment (FOP) Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Penalty Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `pnr_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `pnr_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `pnr_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Number');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_form_of_payment|voucher|miles|cash|bank_transfer|check');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'requested|approved|processed|rejected|pending');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|irop|schedule_change|no_show_waiver');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Request Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|gds|ota|airport|call_center|interline');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `tax_breakdown_json` SET TAGS ('dbx_business_glossary_term' = 'Tax Refund Breakdown (JSON)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `tax_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Refund Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `tax_refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `tax_refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `total_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Refund Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `total_refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `total_refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `voucher_number` SET TAGS ('dbx_business_glossary_term' = 'Travel Credit Voucher Number');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_refund` ALTER COLUMN `waiver_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` SET TAGS ('dbx_subdomain' = 'document_fulfillment');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `ticket_exchange_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Exchange Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `arc_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Arc Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `bsp_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Bsp Settlement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Exchanging Office IATA ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Original Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Additional Collection Method');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'cash|credit_card|emd|residual_value|waived');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `emd_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Miscellaneous Document (EMD) Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `emd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `exchange_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Transaction Date and Time');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `exchange_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Exchange Reference Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `exchange_status` SET TAGS ('dbx_business_glossary_term' = 'Exchange Transaction Status');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `exchange_status` SET TAGS ('dbx_value_regex' = 'pending|completed|voided|failed|reversed');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|upgrade|downgrade|irop_reprotection|schedule_change');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `fare_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Fare Difference Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `fare_difference_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `fare_difference_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `gds_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Global Distribution System (GDS) Transaction ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `involuntary_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Involuntary Exchange Reason Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `issuing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Carrier Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `issuing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'New Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_cabin_class` SET TAGS ('dbx_value_regex' = 'F|C|W|Y');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'New Destination Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'New Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'New Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_fare_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'New Origin Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'New Ticket Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `new_travel_date` SET TAGS ('dbx_business_glossary_term' = 'New Travel Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Original Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_cabin_class` SET TAGS ('dbx_value_regex' = 'F|C|W|Y');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Original Destination Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Original Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_fare_basis_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Original Origin Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `original_travel_date` SET TAGS ('dbx_business_glossary_term' = 'Original Travel Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Exchange Penalty Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `settlement_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Plan Type');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `settlement_plan_type` SET TAGS ('dbx_value_regex' = 'BSP|ARC|direct');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `tax_difference_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Difference Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `tax_difference_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `tax_difference_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Validating Carrier Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `validating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `waiver_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Waiver Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ticket_exchange` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Exchange Waiver Reason');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` SET TAGS ('dbx_subdomain' = 'accounting_performance');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `flight_revenue_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Revenue Performance ID');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `catering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `fuel_uplift_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Impacting Work Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `inventory_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Leg ID');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code (ICAO)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `ancillary_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Revenue Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `ancillary_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `ask` SET TAGS ('dbx_business_glossary_term' = 'Available Seat Kilometers (ASK)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `available_seats` SET TAGS ('dbx_business_glossary_term' = 'Available Seats (Capacity)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `average_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Fare Amount (Average Ticket Revenue)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `average_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `business_fare_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Business Cabin Fare Revenue Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `business_fare_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `business_passengers` SET TAGS ('dbx_business_glossary_term' = 'Business Cabin Passengers Carried');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `denied_boarding_count` SET TAGS ('dbx_business_glossary_term' = 'Involuntary Denied Boarding Count (IDB)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Gate Departure Timestamp (OOOI Out)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `economy_fare_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Economy Cabin Fare Revenue Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `economy_fare_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `economy_passengers` SET TAGS ('dbx_business_glossary_term' = 'Economy Cabin Passengers Carried');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `first_class_fare_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'First Class Cabin Fare Revenue Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `first_class_fare_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `first_class_passengers` SET TAGS ('dbx_business_glossary_term' = 'First Class Cabin Passengers Carried');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date (Departure Date)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `flight_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Flight Distance (Great-Circle Kilometers)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `load_factor` SET TAGS ('dbx_business_glossary_term' = 'Load Factor (Seat Occupancy Rate)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `no_show_count` SET TAGS ('dbx_business_glossary_term' = 'No-Show Passenger Count');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `overbooking_factor` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Factor (Authorization Level)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `overbooking_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `overbooking_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Outcome');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `overbooking_outcome` SET TAGS ('dbx_value_regex' = 'under_sold|exact_sell|over_sold|cancelled');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `passengers_carried` SET TAGS ('dbx_business_glossary_term' = 'Passengers Carried (Revenue Pax)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `rask` SET TAGS ('dbx_business_glossary_term' = 'Revenue per Available Seat Kilometer (RASK)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `rask` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Performance Record Status');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'final|provisional|adjusted|cancelled');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `revenue_accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Accounting Period (YYYY-MM)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `revenue_accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `rpk` SET TAGS ('dbx_business_glossary_term' = 'Revenue Passenger Kilometers (RPK)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `total_fare_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fare Revenue Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `total_fare_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `upgrade_count` SET TAGS ('dbx_business_glossary_term' = 'Cabin Upgrade Count');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `upgrade_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Revenue Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `upgrade_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `voluntary_denied_boarding_count` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Denied Boarding Count (VDB)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `yield_per_rpk` SET TAGS ('dbx_business_glossary_term' = 'Yield per Revenue Passenger Kilometer (RPK)');
ALTER TABLE `airlines_ecm`.`revenue`.`flight_revenue_performance` ALTER COLUMN `yield_per_rpk` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `revenue_surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Surcharge ID');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `tax_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `atpco_record_type` SET TAGS ('dbx_business_glossary_term' = 'ATPCO Record Type');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `atpco_record_type` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `booking_class_applicability` SET TAGS ('dbx_business_glossary_term' = 'Booking Class Applicability');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `cabin_applicability` SET TAGS ('dbx_business_glossary_term' = 'Cabin Applicability');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `cabin_applicability` SET TAGS ('dbx_value_regex' = 'all|first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Calculation Method');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat|percentage|per_mile|per_km');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `directionality` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Directionality');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `directionality` SET TAGS ('dbx_value_regex' = 'both|outbound|inbound');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Discontinue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Filing Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `filing_source` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Filing Source');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `filing_source` SET TAGS ('dbx_value_regex' = 'ATPCO|carrier_direct|GDS|BSP');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `global_indicator` SET TAGS ('dbx_business_glossary_term' = 'Global Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `global_indicator` SET TAGS ('dbx_value_regex' = '^(AT|PA|TS|AP|FE|WH|EH|SA|PO|RU|US|CA|TC1|TC2|TC3)?$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `maximum_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Surcharge Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `maximum_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Surcharge Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `minimum_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `ndc_eligible` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Eligible');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `nuc_amount` SET TAGS ('dbx_business_glossary_term' = 'Neutral Unit of Construction (NUC) Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `nuc_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_business_glossary_term' = 'Passenger Type Code (PTC)');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `passenger_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `per_coupon_indicator` SET TAGS ('dbx_business_glossary_term' = 'Per Coupon Indicator');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Percentage Rate');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `percentage_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `route_applicability` SET TAGS ('dbx_business_glossary_term' = 'Route Applicability');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `route_applicability` SET TAGS ('dbx_value_regex' = 'global|regional|specific_od|domestic|international');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `sales_restriction` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Restriction');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `sales_restriction` SET TAGS ('dbx_value_regex' = 'none|online_only|offline_only|agency_only|direct_only');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `sub_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Sub-Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `sub_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Code');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `surcharge_name` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Name');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Status');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|withdrawn');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_value_regex' = 'fuel|infrastructure|security|carrier_imposed|environmental|insurance');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Tariff Number');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `tariff_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `travel_discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Discontinue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_surcharge` ALTER COLUMN `travel_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` SET TAGS ('dbx_subdomain' = 'document_fulfillment');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ndc_offer_order_id` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Offer Order ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `corporate_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Passenger ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `pricing_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Record ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ancillary_amount` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ancillary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ancillary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fare Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `base_fare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `buyer_type` SET TAGS ('dbx_business_glossary_term' = 'NDC Buyer Type');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `buyer_type` SET TAGS ('dbx_value_regex' = 'DIRECT_TRAVELER|TRAVEL_AGENT|CORPORATE|OTA|TMC');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'FIRST|BUSINESS|PREMIUM_ECONOMY|ECONOMY');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Cancellation Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Order Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ffp_member_number` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ffp_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ffp_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment Type');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `form_of_payment_type` SET TAGS ('dbx_value_regex' = 'CREDIT_CARD|DEBIT_CARD|BANK_TRANSFER|MILES_REDEMPTION|VOUCHER|MIXED');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `last_servicing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Servicing Action Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `loyalty_miles_earned` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Miles Earned');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ndc_order_reference` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Order Reference Number');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ndc_provider_code` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Provider ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ndc_schema_version` SET TAGS ('dbx_business_glossary_term' = 'New Distribution Capability (NDC) Schema Version');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `order_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'NDC Order Creation Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'NDC Order Lifecycle Status');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'ORDERED|TICKETED|CHANGED|CANCELLED|FULFILLED|EXPIRED');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `original_offer_reference` SET TAGS ('dbx_business_glossary_term' = 'Original New Distribution Capability (NDC) Offer ID');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `passenger_count` SET TAGS ('dbx_business_glossary_term' = 'Passenger Count');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'NDC Order Payment Status');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'PENDING|AUTHORIZED|CAPTURED|REFUNDED|PARTIALLY_REFUNDED|FAILED');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR) Locator');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'NDC Sales Channel');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'AIRLINE_DIRECT|NDC_AGGREGATOR|GDS_NDC|CORPORATE_PORTAL|TMC_API');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `servicing_action_count` SET TAGS ('dbx_business_glossary_term' = 'Servicing Action Count');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax and Fee Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `ticketing_time_limit` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Time Limit (TTL)');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Total NDC Order Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `trip_type` SET TAGS ('dbx_business_glossary_term' = 'Trip Type');
ALTER TABLE `airlines_ecm`.`revenue`.`ndc_offer_order` ALTER COLUMN `trip_type` SET TAGS ('dbx_value_regex' = 'ONE_WAY|ROUND_TRIP|MULTI_CITY');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` SET TAGS ('dbx_association_edges' = 'revenue.corporate_contract,inventory.flight_inventory');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `contract_inventory_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Inventory Allocation Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `corporate_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Inventory Allocation - Corporate Contract Id');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Inventory Allocation - Flight Inventory Id');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `allocated_seats` SET TAGS ('dbx_business_glossary_term' = 'Allocated Seat Count');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `applicable_booking_classes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Booking Classes');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Applied Discount Percentage');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generated');
ALTER TABLE `airlines_ecm`.`revenue`.`contract_inventory_allocation` ALTER COLUMN `seats_used` SET TAGS ('dbx_business_glossary_term' = 'Seats Used Count');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` SET TAGS ('dbx_association_edges' = 'revenue.fare,inventory.flight_inventory');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `fare_applicability_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Applicability Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `fare_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Applicability - Fare Id');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Applicability - Flight Inventory Id');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `authorized_capacity` SET TAGS ('dbx_business_glossary_term' = 'Fare-Specific Authorized Capacity');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Fare Availability Status');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `booking_class` SET TAGS ('dbx_business_glossary_term' = 'Mapped Booking Class');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Assignment');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Discontinue Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `fare_applicability_status` SET TAGS ('dbx_business_glossary_term' = 'Fare Applicability Record Status');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `last_booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Booking Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`fare_applicability` ALTER COLUMN `seats_sold_under_fare` SET TAGS ('dbx_business_glossary_term' = 'Seats Sold Under Fare');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` SET TAGS ('dbx_association_edges' = 'revenue.corporate_contract,ancillary.product_catalog');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `corporate_ancillary_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Ancillary Entitlement ID');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `corporate_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Ancillary Entitlement - Corporate Contract Id');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Ancillary Entitlement - Ancillary Product Id');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Created Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Currency Code');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Discount Percentage');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Expiry Date');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `included_quantity` SET TAGS ('dbx_business_glossary_term' = 'Included Quantity');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `negotiated_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Ancillary Price');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `usage_limit_per_booking` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Per Booking');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_ancillary_entitlement` ALTER COLUMN `usage_limit_per_passenger` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Per Passenger');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` SET TAGS ('dbx_association_edges' = 'revenue.fare_family,ancillary.product_catalog');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `revenue_bundle_component_id` SET TAGS ('dbx_business_glossary_term' = 'revenue_bundle_component Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `ancillary_bundle_component_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component - Fare Family Id');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Component - Ancillary Product Id');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `channel_override` SET TAGS ('dbx_business_glossary_term' = 'Channel Override');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `inclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Type');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `incremental_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Incremental Charge Amount');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `marketing_highlight_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Highlight Flag');
ALTER TABLE `airlines_ecm`.`revenue`.`revenue_bundle_component` ALTER COLUMN `quantity_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Quantity Entitlement');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` SET TAGS ('dbx_subdomain' = 'agency_reconciliation');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `annual_sales_volume` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`agency` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` SET TAGS ('dbx_subdomain' = 'accounting_performance');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `parent_corporate_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `annual_revenue_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`revenue`.`bid_price_curve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`revenue`.`bid_price_curve` SET TAGS ('dbx_subdomain' = 'pricing_strategy');
ALTER TABLE `airlines_ecm`.`revenue`.`bid_price_curve` ALTER COLUMN `bid_price_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Price Curve Identifier');
ALTER TABLE `airlines_ecm`.`revenue`.`bid_price_curve` ALTER COLUMN `superseded_bid_price_curve_id` SET TAGS ('dbx_self_ref_fk' = 'true');
