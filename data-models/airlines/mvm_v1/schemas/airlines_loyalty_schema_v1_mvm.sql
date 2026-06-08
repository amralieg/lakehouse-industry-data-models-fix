-- Schema for Domain: loyalty | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`loyalty` COMMENT 'FFP (Frequent Flyer Program) management including member enrollment, tier status (elite levels), mileage accrual and redemption transactions, award bookings, partner airline earn/burn agreements, coalition programs, loyalty promotions, member benefits, upgrades, and lifetime status tracking. Aligns with Oracle Loyalty Cloud FFP Management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`ffp_member` (
    `ffp_member_id` BIGINT COMMENT 'Unique identifier for the FFP member record. Primary key for the loyalty member master.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: FFP members enroll under a specific airline legal entity (company_code), determining which entity holds the miles liability on its balance sheet. Airline groups operating multiple FFPs must attribute ',
    `tier_status_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier_status. Business justification: ffp_member.tier_level is a denormalized STRING copy of the members current tier. Adding tier_status_id FK to tier_status normalizes the current tier assignment, enabling JOIN to retrieve tier name, b',
    `address_line_1` STRING COMMENT 'First line of the members mailing address (street number and name).',
    `address_line_2` STRING COMMENT 'Second line of the members mailing address (apartment, suite, unit number).',
    `city` STRING COMMENT 'City of the members mailing address.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the members mailing address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FFP member record was first created in the system.',
    `current_miles_balance` DECIMAL(18,2) COMMENT 'Current available miles or points balance that can be redeemed for awards, upgrades, or partner benefits. Reflects accruals minus redemptions and expirations.',
    `date_of_birth` DATE COMMENT 'Members date of birth, used for age verification, birthday promotions, and member identity validation.',
    `email_address` STRING COMMENT 'Primary email address for member communication, account notifications, and promotional offers.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_consent_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to receive email communications. True=consent given, False=opt-out.',
    `enrollment_channel` STRING COMMENT 'Channel through which the member enrolled in the FFP. Used for channel attribution and marketing analysis.. Valid values are `web|mobile_app|airport|call_center|partner|inflight`',
    `enrollment_date` DATE COMMENT 'Date when the member first enrolled in the FFP. Used for tenure-based benefits and anniversary promotions.',
    `ffp_number` STRING COMMENT 'Externally-known unique FFP membership number issued to the member. This is the business identifier used across all customer touchpoints, partner airlines, and GDS systems.. Valid values are `^[A-Z0-9]{8,16}$`',
    `gender` STRING COMMENT 'Members gender. M=Male, F=Female, X=Non-binary/Other, U=Undisclosed/Prefer not to say.. Valid values are `M|F|X|U`',
    `home_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the members primary departure airport. Used for targeted route promotions and service personalization.. Valid values are `^[A-Z]{3}$`',
    `last_activity_date` DATE COMMENT 'Date of the members most recent FFP activity (flight, redemption, or partner transaction). Used for dormancy detection and reactivation campaigns.',
    `lifetime_miles_balance` DECIMAL(18,2) COMMENT 'Total cumulative miles or points earned by the member since enrollment, never decremented by redemptions. Used for lifetime status qualification.',
    `lifetime_status_flag` BOOLEAN COMMENT 'Indicates whether the member has achieved lifetime elite status, which is never revoked regardless of annual activity. True=lifetime status achieved, False=standard annual qualification.',
    `marketing_consent_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to receive marketing communications and promotional offers. True=consent given, False=opt-out.',
    `meal_preference` STRING COMMENT 'Members dietary preference or special meal request code (e.g., VGML=vegetarian, KSML=kosher, DBML=diabetic). Free-text or SSR code.',
    `member_first_name` STRING COMMENT 'First name (given name) of the FFP member as registered in the loyalty program.',
    `member_last_name` STRING COMMENT 'Last name (family name) of the FFP member as registered in the loyalty program.',
    `member_middle_name` STRING COMMENT 'Middle name or initial of the FFP member, if provided.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the FFP membership. Active=member in good standing, Inactive=no recent activity, Suspended=temporarily restricted, Closed=permanently terminated, Pending=enrollment not yet complete.. Valid values are `active|inactive|suspended|closed|pending`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the FFP member, including country code.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the members mailing address.',
    `preferred_cabin_class` STRING COMMENT 'Members preferred cabin class for travel. Used for upgrade targeting and personalized offers.. Valid values are `economy|premium_economy|business|first`',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code for member communication preferences.. Valid values are `^[a-z]{2}$`',
    `preferred_seat_type` STRING COMMENT 'Members preferred seat location on the aircraft.. Valid values are `window|aisle|middle|no_preference`',
    `sms_consent_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to receive SMS/text message communications. True=consent given, False=opt-out.',
    `special_service_requests` STRING COMMENT 'Comma-separated list of standard SSR codes for members recurring service needs (e.g., wheelchair assistance, extra legroom, pet travel).',
    `state_province` STRING COMMENT 'State, province, or region of the members mailing address.',
    `tier_expiration_date` DATE COMMENT 'Date when the current tier status expires and will be re-evaluated based on qualifying activity.',
    `tier_qualification_date` DATE COMMENT 'Date when the member achieved their current tier level.',
    `tier_qualifying_miles` DECIMAL(18,2) COMMENT 'Miles earned in the current qualification period that count toward tier status. Typically excludes bonus miles and partner accruals.',
    `tier_qualifying_segments` STRING COMMENT 'Number of flight segments flown in the current qualification period that count toward tier status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this FFP member record was last modified.',
    CONSTRAINT pk_ffp_member PRIMARY KEY(`ffp_member_id`)
) COMMENT 'Master record for Frequent Flyer Program (FFP) members. Captures member enrollment identity, FFP number, membership status, tier level (e.g., Silver, Gold, Platinum, Executive), tier qualification dates, lifetime miles balance, home airport, preferred language, communication preferences, enrollment channel, program join date, and member travel/service preferences (seat, meal, cabin, marketing consent). This is the SSOT for loyalty member identity and preferences within the loyalty domain — distinct from the passenger master in the passenger domain, which owns travel identity. Aligns with Oracle Loyalty Cloud member master.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`tier_status` (
    `tier_status_id` BIGINT COMMENT 'Unique identifier for the frequent flyer program tier status level. Primary key.',
    `award_booking_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the mileage cost of award bookings for members at this tier level (e.g., 10.00 for 10% discount). Zero if no discount is provided.',
    `benefits_summary` STRING COMMENT 'Comprehensive text description of all benefits, privileges, and entitlements associated with this tier level. Used for member communications, marketing materials, and customer service reference.',
    `bonus_mile_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base miles earned on eligible flights for members holding this tier status (e.g., 1.25 for 25% bonus, 1.50 for 50% bonus). Used to calculate total accrued miles including tier bonuses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier status record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_date` DATE COMMENT 'Date when this tier level definition became active and available for member qualification. Used for historical tracking of tier structure changes.',
    `expiration_date` DATE COMMENT 'Date when this tier level definition was discontinued or superseded. Null for currently active tiers. Used for historical tracking and legacy member support.',
    `extra_baggage_allowance_kg` STRING COMMENT 'Additional checked baggage weight allowance in kilograms granted to members at this tier level beyond the standard fare allowance. Zero if no extra allowance is provided.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier status record was most recently updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and audit purposes.',
    `lifetime_status_eligible_flag` BOOLEAN COMMENT 'Indicates whether achieving this tier level contributes toward lifetime status qualification. True if this tier counts toward lifetime elite status milestones.',
    `lounge_access_flag` BOOLEAN COMMENT 'Indicates whether members at this tier level have complimentary access to airline lounges (e.g., business class lounges, first class lounges, partner lounges). True if lounge access is a tier benefit.',
    `partner_tier_equivalent_code` STRING COMMENT 'Code representing the equivalent tier level in partner airline frequent flyer programs for reciprocal benefit recognition (e.g., Star Alliance Gold, oneworld Sapphire). Used for interline and codeshare benefit mapping.',
    `priority_baggage_flag` BOOLEAN COMMENT 'Indicates whether members at this tier level receive priority baggage handling, ensuring their checked luggage is among the first delivered at baggage claim. True if priority baggage handling is included.',
    `priority_boarding_flag` BOOLEAN COMMENT 'Indicates whether members at this tier level receive priority boarding privileges, allowing them to board the aircraft ahead of general passengers. True if priority boarding is included.',
    `priority_checkin_flag` BOOLEAN COMMENT 'Indicates whether members at this tier level have access to priority check-in counters and expedited check-in processes. True if priority check-in is a tier benefit.',
    `qualification_miles_threshold` DECIMAL(18,2) COMMENT 'Minimum number of qualifying miles a member must earn within the qualification period to achieve or maintain this tier status. Measured in miles flown on eligible flights.',
    `qualification_period_months` STRING COMMENT 'Number of months over which qualification activity is measured (e.g., 12 for calendar year, 24 for rolling two-year period). Defines the window for accumulating qualifying miles, segments, or spend.',
    `qualification_segments_threshold` STRING COMMENT 'Minimum number of qualifying flight segments a member must complete within the qualification period to achieve or maintain this tier status. One segment equals one takeoff and landing.',
    `qualification_spend_threshold` DECIMAL(18,2) COMMENT 'Minimum monetary spend amount on eligible flights required within the qualification period to achieve or maintain this tier status. Typically measured in the programs base currency.',
    `tier_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the tier level within the FFP system (e.g., SLV, GLD, PLT, EXPL). Used as business identifier in operational systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `tier_level` STRING COMMENT 'Numeric ranking of the tier within the program hierarchy, where higher numbers indicate more premium status (e.g., 1=Base, 2=Silver, 3=Gold, 4=Platinum). Used for tier comparison and upgrade logic.',
    `tier_name` STRING COMMENT 'Full marketing name of the tier level (e.g., Silver, Gold, Platinum, Executive Platinum). Human-readable label displayed to members and in customer communications.',
    `tier_status_status` STRING COMMENT 'Current lifecycle status of the tier level within the program. Active tiers are available for member qualification; discontinued tiers are legacy levels no longer offered but may still have active members.. Valid values are `active|inactive|discontinued|pending`',
    `tier_validity_months` STRING COMMENT 'Number of months the tier status remains valid once earned, before re-qualification is required. Common values are 12 (annual) or 24 (biennial).',
    `upgrade_eligibility_flag` BOOLEAN COMMENT 'Indicates whether members at this tier level are eligible for complimentary or mileage-based cabin upgrades (e.g., economy to business, business to first). True if upgrade benefits are included.',
    `waitlist_priority_rank` STRING COMMENT 'Numeric priority ranking for waitlist clearance and standby processing. Lower numbers indicate higher priority. Used when multiple members are waitlisted for the same flight or upgrade.',
    CONSTRAINT pk_tier_status PRIMARY KEY(`tier_status_id`)
) COMMENT 'Defines the elite tier levels within the FFP (e.g., Silver, Gold, Platinum, Executive Platinum). Captures tier name, tier code, qualification thresholds (miles, segments, spend), tier benefits summary, tier validity period rules, upgrade eligibility, lounge access entitlement, bonus mile multiplier, and priority service flags. Reference entity governing tier qualification logic across the program.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`tier_qualification` (
    `tier_qualification_id` BIGINT COMMENT 'Unique identifier for the tier qualification record. Primary key.',
    `ffp_member_id` BIGINT COMMENT 'Identifier of the FFP member who achieved or is pursuing this tier qualification.',
    `tier_status_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier_status. Business justification: tier_qualification records which tier level was achieved in each qualification period. tier_status is the master definition table for tier levels. The tier_achieved attribute (STRING) is a code/name t',
    `adjudication_notes` STRING COMMENT 'Free-text notes recorded by FFP administrators during the adjudication of status match, tier challenge, or special qualification cases.',
    `challenge_activity_achieved` STRING COMMENT 'Description of the actual activity achieved by the member during the tier challenge period, used to determine challenge success.',
    `challenge_activity_required` STRING COMMENT 'Description of the activity requirements (e.g., number of flights, miles, or spend) that the member must achieve during the tier challenge period to qualify.',
    `challenge_end_date` DATE COMMENT 'Date on which the tier challenge period ends and qualification is evaluated for members participating in a tier challenge program.',
    `challenge_start_date` DATE COMMENT 'Date on which the tier challenge period commenced for members participating in a tier challenge program.',
    `competing_airline_code` STRING COMMENT 'IATA two-letter or three-letter airline code of the competing carrier from which the member held status for status match or tier challenge purposes.. Valid values are `^[A-Z0-9]{2,3}$`',
    `competing_tier_held` STRING COMMENT 'Name or level of the elite tier held by the member with the competing airline at the time of status match or tier challenge request.',
    `extension_expiry_date` DATE COMMENT 'Date on which the tier extension period expires if an extension was granted.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether a tier extension or grace period was granted to the member (True if extension granted, False otherwise).',
    `extension_reason` STRING COMMENT 'Business reason for granting a tier extension (e.g., medical hardship, service recovery, loyalty gesture, pandemic exception).',
    `lifetime_miles_accumulated` DECIMAL(18,2) COMMENT 'Cumulative lifetime qualifying miles accumulated by the member across all qualification cycles, used for lifetime status determination.',
    `match_approval_date` DATE COMMENT 'Date on which the status match or tier challenge request was approved by the FFP administration team.',
    `match_outcome` STRING COMMENT 'Outcome of the status match or tier challenge request: approved (status granted), denied (request rejected), pending (under review), or expired (request lapsed).. Valid values are `approved|denied|pending|expired`',
    `processed_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier qualification record was processed, adjudicated, or finalized in the FFP system.',
    `proof_of_status_reference` STRING COMMENT 'Reference identifier or document number for the proof of status submitted by the member (e.g., membership card image, statement reference) for status match adjudication.',
    `qualification_source_breakdown` STRING COMMENT 'Detailed breakdown of the sources contributing to the qualification (e.g., own flights, partner airline flights, credit card spend, hotel stays, car rentals) with corresponding qualifying miles or segments.',
    `qualification_status` STRING COMMENT 'Current status of the tier qualification: in progress (cycle active), qualified (tier achieved), not qualified (thresholds not met), extended (grace period granted), expired (tier period ended), or revoked (status removed).. Valid values are `in_progress|qualified|not_qualified|extended|expired|revoked`',
    `qualification_type` STRING COMMENT 'Type of qualification event: standard annual qualification based on activity, status match from competing airline, tier challenge program, lifetime status award, promotional grant, or courtesy status.. Valid values are `standard_annual|status_match|tier_challenge|lifetime|promotional|courtesy`',
    `qualification_year` STRING COMMENT 'Calendar year in which the tier qualification was earned or evaluated.',
    `qualifying_miles_earned` DECIMAL(18,2) COMMENT 'Total qualifying miles (QM) earned by the member during the qualification period. Used to determine tier eligibility.',
    `qualifying_segments_earned` STRING COMMENT 'Total number of qualifying flight segments (QS) flown by the member during the qualification period. Used to determine tier eligibility.',
    `qualifying_spend_amount` DECIMAL(18,2) COMMENT 'Total qualifying spend (QSP) amount in base currency spent by the member on eligible flights and services during the qualification period. Used to determine tier eligibility.',
    `qualifying_spend_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the qualifying spend amount.. Valid values are `^[A-Z]{3}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier qualification record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier qualification record was last updated in the system.',
    `rollover_miles` DECIMAL(18,2) COMMENT 'Excess qualifying miles earned beyond the tier threshold that may roll over to the next qualification cycle or contribute to lifetime status.',
    `tier_achieved` STRING COMMENT 'The elite tier level achieved by the member as a result of this qualification (e.g., Silver, Gold, Platinum, Diamond, or lifetime tiers). [ENUM-REF-CANDIDATE: base|silver|gold|platinum|diamond|lifetime_gold|lifetime_platinum — 7 candidates stripped; promote to reference product]',
    `tier_effective_date` DATE COMMENT 'Date on which the achieved tier status becomes active and member benefits commence.',
    `tier_expiry_date` DATE COMMENT 'Date on which the achieved tier status expires unless re-qualified. Null for lifetime status.',
    `tier_threshold_miles` DECIMAL(18,2) COMMENT 'Minimum qualifying miles (QM) threshold required to achieve the tier for this qualification cycle.',
    `tier_threshold_segments` STRING COMMENT 'Minimum qualifying segments (QS) threshold required to achieve the tier for this qualification cycle.',
    `tier_threshold_spend` DECIMAL(18,2) COMMENT 'Minimum qualifying spend (QSP) threshold required to achieve the tier for this qualification cycle.',
    CONSTRAINT pk_tier_qualification PRIMARY KEY(`tier_qualification_id`)
) COMMENT 'Tracks each members active and historical tier qualification periods, including standard annual qualification cycles and special qualification events (status matches, tier challenges). Records qualification year/cycle, qualifying miles (QM), qualifying segments (QS), qualifying spend (QSP), tier achieved, tier effective date, tier expiry date, rollover miles, tier extension events, qualification source breakdown, and for status match/challenge cases: competing airline, competing tier held, proof of status reference, challenge conditions, challenge activity required/achieved, and match outcome. Enables year-end tier review processing, proactive tier challenge management, and competitive status match adjudication. Aligns with Oracle Loyalty Cloud tier qualification module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` (
    `mileage_accrual_id` BIGINT COMMENT 'Unique identifier for each mileage accrual transaction in the FFP (Frequent Flyer Program) ledger. Primary key for the mileage accrual record.',
    `booking_segment_id` BIGINT COMMENT 'Foreign key linking to flight.booking_segment. Business justification: Mileage accrual must trace back to the specific booking segment (fare class, cabin, ticket number, boarding status) for audit, dispute resolution, and retroactive accrual claims. Aviation loyalty oper',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: FFP mileage earning rates are multiplied by cabin class (e.g., Business earns 150% of base miles). Normalizes cabin_class text column. Core to loyalty program accrual calculation and member value prop',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Mileage accrual multipliers are determined by the exact fare class bucket (RBD) booked — Y earns 100%, discounted buckets earn less. Linking to fare_class_bucket enables precise accrual calculation an',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Branded fares have differentiated mileage earn rates (e.g., Basic Economy earns 50%, Premium earns 150%). Accrual calculation requires fare family reference. New attribute for earn rate determination.',
    `ffp_member_id` BIGINT COMMENT 'Unique identifier of the FFP member who earned the miles. Links to the loyalty member master record.',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Accrual records from flights must reference the actual operated flight leg (not just flight_number/date) for audit trail, dispute resolution, irregular operations adjustments, and reconciliation with ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: IFRS 15 requires loyalty accruals to post as deferred revenue liability in GL. Monthly accrual posting process links each accrual transaction to specific GL account for revenue recognition and financi',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to ancillary.order_item. Business justification: Miles accrual on ancillary purchases: members earn miles when purchasing ancillary products (seat upgrades, extra baggage, lounge access). This FK links each mileage accrual record to the specific anc',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Accruals track origin_airport_code; FK enables hub earning analysis, station performance metrics, and operational reporting on mileage earning patterns by station. Role prefix distinguishes from desti',
    `partner_program_id` BIGINT COMMENT 'Foreign key linking to loyalty.partner_program. Business justification: mileage_accrual has partner_code (STRING) attribute indicating miles earned on partner airline flights. partner_program is the master table for partner agreements. Adding partner_program_id FK enables',
    `partner_transaction_id` BIGINT COMMENT 'Foreign key linking to loyalty.partner_transaction. Business justification: mileage_accrual.partner_transaction_reference is a STRING denormalized reference to the originating partner transaction. When miles are earned through a partner (hotel, car rental, etc.), a partner_tr',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_promotion. Business justification: mileage_accrual has promotion_code (STRING) attribute indicating promotional bonus miles. loyalty_promotion is the master table for FFP promotional campaigns. Adding loyalty_promotion_id FK allows joi',
    `e_ticket_id` BIGINT COMMENT 'Foreign key linking to reservation.e_ticket. Business justification: Accrual records are posted FOR specific tickets. Structural link enables accrual reconciliation, audit, reversal processing. Business process: post-flight accrual posting, dispute resolution, ticket-t',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Route performance analysis by loyalty segment, award inventory planning based on accrual patterns, and route profitability calculations including loyalty program costs all require linking accruals to ',
    `ticket_coupon_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket_coupon. Business justification: Accruals must reference specific flown coupon for audit trail, dispute resolution, and revenue reconciliation. Core operational link. Replaces denormalized ticket_number with proper FK to ticket_coupo',
    `accrual_date` DATE COMMENT 'Business date when the mileage-earning activity occurred (e.g., flight departure date, partner transaction date, purchase date). This is the real-world event date, distinct from posting date.',
    `accrual_source_type` STRING COMMENT 'Category of the mileage earning activity. Distinguishes between flight-based earnings, partner transactions, direct purchases, and manual adjustments. [ENUM-REF-CANDIDATE: flight|partner_airline|credit_card|hotel|car_rental|retail|purchase|adjustment|reinstatement — 9 candidates stripped; promote to reference product]',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the mileage accrual transaction. Pending indicates awaiting validation or posting; posted indicates credited to member account; reversed indicates clawed back due to refund or fraud; expired indicates miles lapsed before use; cancelled indicates transaction voided.. Valid values are `pending|posted|reversed|expired|cancelled`',
    `adjustment_notes` STRING COMMENT 'Free-text explanation for manual adjustments. Captures customer service agent notes, retro-claim justification, or fraud investigation details. Null for standard accruals.',
    `adjustment_reason_code` STRING COMMENT 'Reason category for manual adjustments to member accounts. Null for standard flight and partner accruals. Used for goodwill credits, retro-active claims, error corrections, fraud reversals, and policy exceptions.. Valid values are `goodwill|retro_claim|error_correction|fraud_reversal|system_error|policy_exception`',
    `approval_reference` STRING COMMENT 'Case number, ticket number, or workflow reference for manual adjustments requiring supervisory approval. Null for standard accruals.',
    `base_miles` DECIMAL(18,2) COMMENT 'Core mileage amount earned before any bonuses or multipliers. For flights, typically calculated from actual flown distance or fare class earning rate. For partners, based on transaction value or partner agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the mileage accrual record was first created in the FFP ledger. Audit trail for record creation.',
    `elite_bonus_miles` DECIMAL(18,2) COMMENT 'Additional miles earned due to members elite tier status (e.g., Gold, Platinum, Diamond). Calculated as a percentage multiplier of base miles based on tier level.',
    `elite_bonus_multiplier` DECIMAL(18,2) COMMENT 'Percentage multiplier applied to base miles for elite tier members (e.g., 1.25 for 25% bonus, 1.50 for 50% bonus). Zero or 1.00 for non-elite members.',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight for flight-based accruals. Null for non-flight accruals.',
    `flight_number` STRING COMMENT 'IATA flight designator (carrier code + numeric flight number) for flight-based accruals. Null for non-flight accruals.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `marketing_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier whose flight number appears on the ticket for codeshare or interline accruals. Determines earning eligibility and rate. Null for non-flight accruals.. Valid values are `^[A-Z0-9]{2}$`',
    `miles_expiry_date` DATE COMMENT 'Date when the miles earned in this transaction will expire if not used. Null for programs with no expiration policy or lifetime miles.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the mileage accrual record was last updated. Audit trail for record modifications (e.g., status changes, adjustments, reversals).',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier that physically operated the flight for codeshare or interline accruals. May differ from marketing carrier. Null for non-flight accruals.. Valid values are `^[A-Z0-9]{2}$`',
    `pnr` STRING COMMENT 'Six-character alphanumeric booking reference for flight-based accruals. Links the mileage credit to the original reservation. Null for non-flight accruals.. Valid values are `^[A-Z0-9]{6}$`',
    `posting_date` DATE COMMENT 'Date when the miles were credited to the members FFP account. May differ from accrual date due to processing delays, batch cycles, or retro-claims.',
    `promotional_bonus_miles` DECIMAL(18,2) COMMENT 'Additional miles earned through limited-time promotions, campaigns, or special offers (e.g., double miles promotion, new route bonus, seasonal campaign). Zero if no promotion applies.',
    `reversal_date` DATE COMMENT 'Date when the miles were reversed or clawed back from the member account. Null unless accrual_status is reversed.',
    `reversal_reason` STRING COMMENT 'Explanation for why miles were reversed after initial posting (e.g., ticket refund, fraudulent activity detected, duplicate posting, partner transaction cancelled). Null unless accrual_status is reversed.',
    `total_miles_credited` DECIMAL(18,2) COMMENT 'Sum of base miles, elite bonus miles, and promotional bonus miles. This is the net amount credited to the members account for this transaction.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the partner transaction in the transaction currency for spend-based accruals (e.g., credit card purchase amount, hotel bill total). Null for distance-based flight accruals.',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for partner transactions where miles are earned based on spend amount (e.g., credit card purchases, hotel stays). Null for distance-based flight accruals.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_mileage_accrual PRIMARY KEY(`mileage_accrual_id`)
) COMMENT 'Transactional record of every mile-crediting event for an FFP member, including flight earnings, partner earnings, credit card accruals, miles purchases, manual adjustments (goodwill credits, retro-claims, error corrections, fraud reversals), and reinstatements. Captures accrual source (flight, partner, credit card, hotel, car rental, retail, purchase, adjustment), flight details (PNR, flight number, origin, destination, cabin class, fare class), partner transaction reference, base miles, bonus miles, elite bonus multiplier, promotional bonus, total miles credited, accrual date, posting date, accrual status (pending, posted, reversed), expiry date of earned miles, adjustment reason code, authorizing agent ID, and approval reference. Core SSOT ledger for all credit-side loyalty currency movements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` (
    `mileage_redemption_id` BIGINT COMMENT 'Unique identifier for the mileage redemption transaction. Primary key for the mileage redemption ledger.',
    `ffp_member_id` BIGINT COMMENT 'Identifier of the FFP member who redeemed miles. Links to the loyalty member master.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Mile redemptions trigger deferred revenue recognition in GL under IFRS 15. Each redemption posts to GL accounts to recognize previously deferred revenue, essential for accurate financial statements an',
    `partner_program_id` BIGINT COMMENT 'Identifier of the partner loyalty program or coalition program if redemption was made with a partner (e.g., hotel chain, car rental, retail partner). Null for airline-only redemptions.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_promotion. Business justification: mileage_redemption.promotion_code is a STRING denormalized reference to a loyalty promotion applied during redemption (e.g., discounted redemption promotion). Adding loyalty_promotion_id FK normalizes',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: Award redemptions result in ticket issuance. Direct link required for revenue recognition, refund processing, and loyalty liability reconciliation. Replaces denormalized e_ticket_number with proper FK',
    `award_booking_reference` STRING COMMENT 'Passenger Name Record (PNR) or booking reference for award flight redemptions. Null for non-flight redemptions.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for redemption cancellation (e.g., member request, flight cancellation, partner unavailability). Null if not cancelled.',
    `co_pay_amount` DECIMAL(18,2) COMMENT 'Cash amount paid by the member in addition to miles for this redemption (e.g., taxes, fees, or partial cash payment for award).',
    `co_pay_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the co-pay amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Date by which the redeemed award must be used or the redemption expires (e.g., award ticket validity end date). Null for non-expiring redemptions.',
    `miles_discount_applied` BIGINT COMMENT 'Number of miles discounted due to promotional campaign or elite status benefit. Zero if no discount applied.',
    `miles_redeemed` BIGINT COMMENT 'Total number of loyalty miles debited from the member account for this redemption transaction.',
    `partner_transaction_reference` STRING COMMENT 'External transaction reference provided by the partner program for reconciliation. Null for airline-only redemptions.',
    `processing_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the airline or partner for processing the redemption transaction (e.g., award booking fee, transfer fee).',
    `processing_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the processing fee.. Valid values are `^[A-Z]{3}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the source system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last modified in the source system.',
    `redemption_channel` STRING COMMENT 'Channel through which the member initiated the redemption: airline website, mobile app, call center, airport counter, partner portal, or self-service kiosk.. Valid values are `web|mobile_app|call_center|airport_counter|partner_portal|kiosk`',
    `redemption_notes` STRING COMMENT 'Free-text notes or comments about the redemption transaction, captured by agent or system for audit and customer service purposes.',
    `redemption_status` STRING COMMENT 'Current lifecycle status of the redemption transaction: requested (pending), confirmed (approved), ticketed (award ticket issued), cancelled (member cancelled), refunded (miles returned), or expired (award not used).. Valid values are `requested|confirmed|ticketed|cancelled|refunded|expired`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption transaction was initiated by the member or agent.',
    `redemption_transaction_number` STRING COMMENT 'Externally-visible unique transaction number for the redemption event, used for customer service and reconciliation.',
    `redemption_type` STRING COMMENT 'Category of redemption: award flight booking, cabin upgrade, partner airline/hotel reward, merchandise purchase, charity donation, peer-to-peer miles transfer, miles purchase with cash co-pay, or co-pay booking combining miles and cash. [ENUM-REF-CANDIDATE: award_flight|upgrade|partner_reward|merchandise|charity_donation|miles_transfer|purchase_miles|co_pay_booking — 8 candidates stripped; promote to reference product]',
    `refund_miles` BIGINT COMMENT 'Number of miles returned to the member account upon cancellation or refund of the redemption. Zero if no refund occurred.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when miles were refunded to the member account. Null if no refund occurred.',
    `source_system` STRING COMMENT 'Name or code of the operational system that originated this redemption record (e.g., Oracle Loyalty Cloud, partner API, legacy FFP system).',
    `transfer_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for transferring miles to another member. Null for non-transfer redemptions.',
    `transfer_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer fee.. Valid values are `^[A-Z]{3}$`',
    `transfer_recipient_ffp_number` STRING COMMENT 'FFP membership number of the recipient member for peer-to-peer miles transfers or family pooling. Null for non-transfer redemptions.',
    `transfer_type` STRING COMMENT 'Type of miles transfer: gift (peer-to-peer gifting), family_pool (pooling within family account), purchase (buying miles for another member), or none (not a transfer redemption).. Valid values are `gift|family_pool|purchase|none`',
    CONSTRAINT pk_mileage_redemption PRIMARY KEY(`mileage_redemption_id`)
) COMMENT 'Transactional record of every mile-debiting event for an FFP member, including award flights, upgrades, partner rewards, merchandise, charity donations, miles transfers (peer-to-peer gifting, family pooling), and purchase-based transfers. Captures redemption type, award booking reference, redemption miles deducted, co-pay cash amount, redemption date, redemption channel, redemption status (requested, confirmed, ticketed, cancelled, refunded), refund miles on cancellation, processing fees, transfer recipient FFP number (for transfers), transfer fee, and transfer type (gift, family pool, purchase). Core SSOT ledger for all debit-side loyalty currency movements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`miles_balance` (
    `miles_balance_id` BIGINT COMMENT 'Unique identifier for the miles balance ledger record. Primary key for the miles balance entity.',
    `ffp_member_id` BIGINT COMMENT 'Unique identifier of the FFP member to whom this miles balance belongs. Links to the member master record.',
    `account_inception_date` DATE COMMENT 'Date when the member first enrolled in the FFP and the miles balance account was created. Used for member tenure analysis and lifetime value calculation.',
    `balance_as_of_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this balance snapshot was calculated. Critical for point-in-time balance queries and historical balance reconstruction.',
    `balance_calculation_method` STRING COMMENT 'Method used to calculate this balance snapshot. Real-time balances are updated transactionally; batch balances are calculated in nightly runs; reconciled balances include manual adjustments.. Valid values are `REAL_TIME|BATCH|RECONCILED|ESTIMATED`',
    `balance_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this balance record was last modified by any transaction or adjustment. Used for data freshness validation and audit trail.',
    `balance_status` STRING COMMENT 'Current lifecycle status of the miles balance account. Active accounts allow accrual and redemption; suspended accounts are temporarily restricted; frozen accounts are under investigation; closed accounts are terminated.. Valid values are `active|suspended|frozen|closed`',
    `balance_version_number` STRING COMMENT 'Version number of this balance record, incremented with each update. Used for optimistic locking and concurrency control in real-time balance updates.',
    `bonus_miles_balance` BIGINT COMMENT 'Subset of total miles balance earned through promotional campaigns, partner bonuses, or special offers. Tracked separately for marketing attribution analysis.',
    `elite_bonus_miles_ytd` BIGINT COMMENT 'Additional miles earned year-to-date as elite tier status bonuses (e.g., 25%, 50%, 100% bonus on base miles). Separate from base miles for tier benefit tracking.',
    `is_lifetime_status_qualified` BOOLEAN COMMENT 'Boolean flag indicating whether the member has achieved lifetime elite status qualification based on lifetime miles earned or lifetime qualifying criteria. True if qualified, False otherwise.',
    `last_accrual_date` DATE COMMENT 'Date of the most recent miles accrual transaction posted to this account. Used for account activity monitoring and dormancy detection.',
    `last_redemption_date` DATE COMMENT 'Date of the most recent miles redemption transaction posted to this account. Used for member engagement analysis and redemption pattern tracking.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction (accrual or redemption) posted to this account. Used for account activity monitoring and expiration policy enforcement.',
    `lifetime_miles_earned` BIGINT COMMENT 'Cumulative total of all miles earned by the member since program enrollment. Used for lifetime status qualification and member recognition. Never decreases.',
    `lifetime_miles_redeemed` BIGINT COMMENT 'Cumulative total of all miles redeemed by the member since program enrollment. Used for member engagement analytics and redemption behavior analysis.',
    `member_number` STRING COMMENT 'The externally-known FFP membership number assigned to the member. Used for member identification across all touchpoints.. Valid values are `^[A-Z0-9]{8,12}$`',
    `miles_expiring_180_days` BIGINT COMMENT 'Total miles scheduled to expire within the next 180 days based on program expiration policy. Used for proactive member engagement and redemption encouragement.',
    `miles_expiring_90_days` BIGINT COMMENT 'Total miles scheduled to expire within the next 90 days based on program expiration policy. Used for member communication and retention campaigns.',
    `next_expiration_date` DATE COMMENT 'Date when the next batch of miles is scheduled to expire based on program expiration policy. Used for member notification and retention campaigns.',
    `on_hold_miles` BIGINT COMMENT 'Miles temporarily held and unavailable for redemption due to fraud investigation, dispute resolution, or account review. Released once issue is resolved.',
    `partner_miles_balance` BIGINT COMMENT 'Subset of total miles balance earned through partner airline flights, hotel stays, car rentals, credit card spend, or coalition program activities. Tracked for partner settlement.',
    `pending_miles` BIGINT COMMENT 'Miles that have been earned but not yet posted to the redeemable balance. Typically includes miles from recent flights or partner transactions awaiting verification.',
    `qualification_year_end_date` DATE COMMENT 'End date of the current qualification year for elite tier status. QM, QS, and QSP counters reset after this date.',
    `qualification_year_start_date` DATE COMMENT 'Start date of the current qualification year for elite tier status. Typically calendar year or membership anniversary date depending on program rules.',
    `qualifying_miles_ytd` BIGINT COMMENT 'Total qualifying miles earned year-to-date that count toward elite tier status qualification. QM are typically based on distance flown and fare class, excluding bonus miles.',
    `qualifying_segments_ytd` STRING COMMENT 'Total number of qualifying flight segments flown year-to-date that count toward elite tier status qualification. Each eligible flight leg counts as one segment.',
    `qualifying_spend_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the qualifying spend amount. Typically the program base currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `qualifying_spend_ytd` DECIMAL(18,2) COMMENT 'Total qualifying spend amount year-to-date that counts toward elite tier status qualification. Typically based on ticket price paid, excluding taxes and fees.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this miles balance record was first created in the data warehouse. Used for data lineage and audit trail.',
    `redeemable_miles` BIGINT COMMENT 'Subset of total miles balance that is currently available for redemption. Excludes miles that are pending, on hold, or not yet eligible for use.',
    `source_system_code` STRING COMMENT 'Code identifying the source system that last updated this balance record. Typically Oracle Loyalty Cloud for operational balances, or partner feed systems for coalition programs.. Valid values are `ORACLE_LOYALTY|LEGACY_FFP|PARTNER_FEED|MANUAL_ADJ`',
    `total_miles_balance` BIGINT COMMENT 'Total accumulated miles currently available in the member account, including all earned miles minus all redeemed miles. This is the authoritative running balance.',
    CONSTRAINT pk_miles_balance PRIMARY KEY(`miles_balance_id`)
) COMMENT 'Current and historical miles balance ledger for each FFP member. Maintains total miles balance, redeemable miles, qualifying miles (QM) year-to-date, qualifying segments (QS) year-to-date, qualifying spend (QSP) year-to-date, lifetime miles earned, lifetime miles redeemed, miles expiring in next 90/180 days, last transaction date, and balance as-of timestamp. Serves as the authoritative running balance for member account statements and real-time eligibility checks.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`award_booking` (
    `award_booking_id` BIGINT COMMENT 'Unique identifier for the award flight booking. Primary key for the award booking record.',
    `award_inventory_id` BIGINT COMMENT 'Foreign key linking to loyalty.award_inventory. Business justification: award_booking consumes award seat inventory from award_inventory. The award_inventory_bucket attribute (STRING) indicates which inventory bucket was used. Adding award_inventory_id FK links the bookin',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Award bookings require cabin class specification for pricing, availability, and seat allocation. Normalizes existing cabin_class text column. Essential for award inventory management and FFP redemptio',
    `ffp_member_id` BIGINT COMMENT 'Identifier of the FFP member who made the award booking. Links to the loyalty program member whose miles were redeemed.',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Once an award flight operates, the award booking must reconcile against the actual flight_leg for mileage posting confirmation, revenue accounting, and DOT reporting. The existing scheduled_flight FK ',
    `interline_billing_id` BIGINT COMMENT 'Foreign key linking to finance.interline_billing. Business justification: Partner award bookings (is_partner_award flag exists) on codeshare/alliance carriers generate interline billing entries for award settlement between carriers. Airlines must reconcile award redemptions',
    `mileage_redemption_id` BIGINT COMMENT 'Identifier linking to the mileage redemption transaction that debited the miles for this award booking.',
    `partner_program_id` BIGINT COMMENT 'Foreign key linking to loyalty.partner_program. Business justification: award_booking has is_partner_award flag, operating_carrier_code, and marketing_carrier_code attributes. When is_partner_award is true, the booking is made through a partner airline agreement. Adding p',
    `pnr_id` BIGINT COMMENT 'Foreign key linking to reservation.pnr. Business justification: Award bookings generate reservation PNRs for check-in, boarding, and operational processing. award_pnr is a denormalized PNR locator string on award_booking. This FK normalizes it, enabling check-in s',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_promotion. Business justification: award_booking has no FK to loyalty_promotion, yet promotional award bookings are a core FFP business concept (e.g., bonus mile promotions, discounted award redemptions). upgrade_request already carrie',
    `scheduled_flight_id` BIGINT COMMENT 'Foreign key linking to flight.scheduled_flight. Business justification: Award bookings must reference the scheduled flight master for inventory control, schedule changes, cancellation processing, and award seat allocation. Current flight_number/date denormalization is ins',
    `ticket_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket. Business justification: Award bookings generate tickets upon confirmation. Link required for ticketing workflow, refund processing, and revenue accounting. Replaces denormalized award_ticket_number with proper FK.',
    `award_type` STRING COMMENT 'Classification of the award booking type. Saver awards require fewer miles but have limited availability; standard awards have higher mileage cost but greater availability; upgrade awards convert paid tickets to higher cabin; companion awards allow a second passenger at reduced miles; mixed cabin combines different service classes; partner awards are on codeshare or alliance airlines.. Valid values are `saver|standard|upgrade|companion|mixed_cabin|partner`',
    `booking_channel` STRING COMMENT 'Channel through which the award booking was made. Web indicates airline website; mobile app is the carriers mobile application; call center is telephone reservation; airport counter is in-person booking; partner portal is through alliance or coalition partner; GDS is Global Distribution System booking.. Valid values are `web|mobile_app|call_center|airport_counter|partner_portal|gds`',
    `booking_status` STRING COMMENT 'Current lifecycle status of the award booking. Confirmed indicates space is held; waitlisted means awaiting availability; ticketed means e-ticket issued; cancelled indicates member-initiated cancellation; expired means booking lapsed without ticketing; pending indicates awaiting payment or verification.. Valid values are `confirmed|waitlisted|ticketed|cancelled|expired|pending`',
    `booking_timestamp` TIMESTAMP COMMENT 'Date and time when the award booking was created in the reservation system. Represents the moment the member initiated the award redemption.',
    `cancellation_reason` STRING COMMENT 'Reason code for award booking cancellation. Member request is voluntary cancellation; schedule change is airline-initiated due to flight changes; IROP is irregular operations; fraud is security cancellation; system timeout is automatic expiry; payment failure is co-pay processing issue.. Valid values are `member_request|schedule_change|irop|fraud|system_timeout|payment_failure`',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the award booking was cancelled. Null if booking has not been cancelled. Represents when the member or system terminated the reservation.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Monetary amount paid by the member in addition to miles for this award booking. Covers taxes, fees, and carrier-imposed surcharges not covered by miles.',
    `copay_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the co-pay amount. Indicates the currency in which taxes and fees were charged.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this award booking record was first created in the loyalty management system. Audit field for data lineage.',
    `departure_date` DATE COMMENT 'Scheduled date of departure for the outbound award flight. First travel date of the award itinerary.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the arrival airport of the award journey. Represents the final destination of the award travel itinerary.. Valid values are `^[A-Z]{3}$`',
    `is_partner_award` BOOLEAN COMMENT 'Boolean flag indicating whether this award booking involves travel on a partner airline (alliance member or codeshare partner) rather than the marketing carriers own metal.',
    `is_round_trip` BOOLEAN COMMENT 'Boolean flag indicating whether this is a round-trip award booking (true) or one-way (false). Round-trip awards include both outbound and return travel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this award booking record was last updated. Tracks the most recent change to any field in the record for audit purposes.',
    `marketing_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier whose FFP miles were redeemed. Represents the loyalty program under which the award was booked.. Valid values are `^[A-Z0-9]{2}$`',
    `number_of_passengers` STRING COMMENT 'Total count of passengers included in this award booking. Represents how many travelers are covered by this single award PNR.',
    `number_of_segments` STRING COMMENT 'Total count of flight segments (individual flight legs) included in this award booking itinerary. Multi-segment awards involve connections.',
    `operating_carrier_code` STRING COMMENT 'Two-character IATA airline code of the carrier operating the award flight. May differ from the marketing carrier if this is a codeshare or partner award.. Valid values are `^[A-Z0-9]{2}$`',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the departure airport of the award journey. Represents the starting point of the award travel itinerary.. Valid values are `^[A-Z]{3}$`',
    `refund_fee_miles` BIGINT COMMENT 'Number of FFP miles charged as a cancellation or change fee when refunding the award booking. Represents the penalty for award cancellation.',
    `refund_miles_amount` BIGINT COMMENT 'Number of FFP miles returned to the member account upon cancellation or refund of the award booking. May be less than original redemption if cancellation fees apply.',
    `return_date` DATE COMMENT 'Scheduled date of return for the inbound award flight. Null for one-way award bookings. Represents the return travel date for round-trip awards.',
    `ticketing_deadline` TIMESTAMP COMMENT 'Date and time by which the award booking must be ticketed or it will be automatically cancelled. Enforces time limits for award space holds.',
    `ticketing_status` STRING COMMENT 'Current status of e-ticket issuance for the award booking. Not ticketed means reservation exists but no ticket issued; ticketed means e-ticket generated; voided indicates ticket cancelled before travel; refunded means ticket cancelled with miles returned; exchanged means ticket modified for different travel.. Valid values are `not_ticketed|ticketed|voided|refunded|exchanged`',
    `ticketing_timestamp` TIMESTAMP COMMENT 'Date and time when the award e-ticket was issued. Null if booking has not been ticketed. Represents when the reservation was converted to a confirmed ticket.',
    `total_miles_redeemed` BIGINT COMMENT 'Total number of FFP miles debited from the member account for this award booking. Represents the mileage cost across all passengers and segments.',
    `waitlist_position` STRING COMMENT 'Numeric position in the waitlist queue for this award booking. Lower numbers indicate higher priority. Null if not waitlisted.',
    `waitlist_status` STRING COMMENT 'Status of waitlist request for award space. Not waitlisted means booking was immediately confirmed; waitlisted indicates awaiting availability; confirmed from waitlist means space opened and booking confirmed; waitlist expired means request timed out without confirmation.. Valid values are `not_waitlisted|waitlisted|confirmed_from_waitlist|waitlist_expired`',
    CONSTRAINT pk_award_booking PRIMARY KEY(`award_booking_id`)
) COMMENT 'Master record for award flight bookings made using FFP miles. Captures award PNR, award type (saver, standard, upgrade, companion), origin, destination, travel dates, cabin class, number of passengers, total miles cost, co-pay amount, ticketing status, award ticket number, booking channel, waitlist status, award inventory bucket used, partner airline involvement, and cancellation/refund details. Links to mileage_redemption for the miles debit event.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`partner_program` (
    `partner_program_id` BIGINT COMMENT 'Unique identifier for the FFP (Frequent Flyer Program) partner program agreement. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to route.carrier. Business justification: FFP partner airline programs must reference the structured carrier entity for partner settlement, accrual rate management, and interline reporting. partner_iata_code and partner_icao_code are denormal',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Partner program agreements are contracted by a specific legal entity (company_code). Airline groups with multiple subsidiaries must attribute partner program liabilities and settlement obligations to ',
    `accrual_delay_days` STRING COMMENT 'Number of days after a qualifying partner transaction before earned miles are posted to the member account. Allows for transaction validation and fraud prevention.',
    `agreement_effective_date` DATE COMMENT 'Date when the partner agreement becomes active and earn/burn transactions are permitted. Format: yyyy-MM-dd.',
    `agreement_expiry_date` DATE COMMENT 'Date when the partner agreement terminates. Null for evergreen agreements with no fixed end date. Format: yyyy-MM-dd.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the partner agreement. Active agreements permit earn/burn transactions; suspended/terminated agreements block new activity.. Valid values are `active|suspended|terminated|pending|draft|renewal`',
    `auto_enrollment_flag` BOOLEAN COMMENT 'Indicates whether Airlines FFP members are automatically enrolled in the partner loyalty program for seamless earn/burn. True if auto-enrollment is enabled.',
    `bonus_mile_eligibility_flag` BOOLEAN COMMENT 'Indicates whether transactions with this partner are eligible for promotional bonus mile campaigns and tier multipliers. True if eligible.',
    `burn_rate` DECIMAL(18,2) COMMENT 'Redemption rate for using FFP miles with this partner, expressed as miles required per reward unit (e.g., miles per free night, miles per rental day, miles per dollar value).',
    `burn_unit` STRING COMMENT 'Unit of measure for the burn rate calculation (e.g., per hotel night redeemed, per car rental day, per dollar value of merchandise). [ENUM-REF-CANDIDATE: night|day|dollar|euro|pound|item|service — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner program record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `earn_rate` DECIMAL(18,2) COMMENT 'Base mileage accrual rate for member transactions with this partner, expressed as miles earned per unit (dollar, euro, night, rental day, etc.). Subject to tier multipliers and promotions.',
    `earn_unit` STRING COMMENT 'Unit of measure for the earn rate calculation (e.g., per dollar spent, per hotel night, per car rental day). [ENUM-REF-CANDIDATE: dollar|euro|pound|night|day|transaction|point — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this partner program record. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maximum_earn_per_transaction` DECIMAL(18,2) COMMENT 'Maximum number of miles that can be earned in a single transaction with this partner. Null if no cap applies. Prevents abuse and controls liability.',
    `minimum_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction value (in settlement currency) required for a partner transaction to qualify for mileage accrual. Null if no minimum applies.',
    `partner_contact_email` STRING COMMENT 'Primary email address for the partner business contact. Used for operational communications, settlement queries, and program updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `partner_contact_name` STRING COMMENT 'Full name of the primary business contact at the partner organization responsible for FFP program coordination and issue resolution.',
    `partner_contact_phone` STRING COMMENT 'Primary telephone number for the partner business contact, including country code and extension where applicable.',
    `partner_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the partners primary country of operation or headquarters location.. Valid values are `^[A-Z]{3}$`',
    `partner_name` STRING COMMENT 'Legal or trading name of the FFP earn/burn partner organization (e.g., Marriott Hotels, Hertz Car Rental, Chase Bank).',
    `partner_program_code` STRING COMMENT 'Short alphanumeric code used in operational systems to identify this partner program in transaction records, reports, and member statements.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `partner_tax_number` STRING COMMENT 'Tax identification number or business registration number for the partner organization. Used for financial settlement and regulatory compliance.',
    `partner_type` STRING COMMENT 'Classification of the partner organization by business category. Determines applicable earn/burn rules and integration requirements. [ENUM-REF-CANDIDATE: airline_codeshare|hotel|car_rental|credit_card|retail|telecom|dining|travel_services — 8 candidates stripped; promote to reference product]',
    `partner_website_url` STRING COMMENT 'Primary website URL for the partner organization. Used for member communications and marketing materials promoting partner earn/burn opportunities.',
    `redemption_blackout_flag` BOOLEAN COMMENT 'Indicates whether this partner imposes blackout dates or capacity restrictions on award redemptions. True if blackouts apply.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial settlement of earn/burn transactions between Airlines and the partner (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `settlement_frequency` STRING COMMENT 'Frequency at which financial reconciliation and settlement occurs between Airlines and the partner for accrued earn/burn transactions.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `tier_recognition_flag` BOOLEAN COMMENT 'Indicates whether the partner honors Airlines FFP elite tier status with reciprocal benefits (e.g., priority service, upgrades, bonus earn). True if tier benefits apply.',
    CONSTRAINT pk_partner_program PRIMARY KEY(`partner_program_id`)
) COMMENT 'Master record for FFP earn/burn partner agreements. Captures partner name, partner type (airline codeshare, hotel, car rental, credit card, retail, telecom), partner IATA/ICAO code where applicable, earn rate (miles per dollar/unit), burn rate (miles per reward unit), partner tier recognition flag, partner bonus mile eligibility, agreement effective date, agreement expiry date, settlement currency, settlement frequency, and partner contact details. SSOT for all loyalty partner configurations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`partner_transaction` (
    `partner_transaction_id` BIGINT COMMENT 'Unique identifier for the partner transaction record. Primary key.',
    `ffp_member_id` BIGINT COMMENT 'Identifier of the FFP member who earned or redeemed miles through this partner transaction.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Partner transactions carry settlement_amount requiring GL posting for partner mile accrual cost recognition and partner billing reconciliation. Airlines post partner program revenue/cost to GL per acc',
    `original_transaction_partner_transaction_id` BIGINT COMMENT 'Reference to the original partner transaction ID if this record is a reversal or adjustment of a prior transaction.',
    `partner_program_id` BIGINT COMMENT 'Identifier of the partner program (hotel chain, car rental, credit card issuer, retail coalition) through which the transaction occurred.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_promotion. Business justification: partner_transaction has promotion_code (STRING) attribute for promotional bonus miles earned through partners. loyalty_promotion defines promotional campaigns. Adding loyalty_promotion_id FK enables j',
    `base_miles_awarded` STRING COMMENT 'Number of base FFP miles earned or redeemed through this partner transaction, calculated per the partner agreement earn/burn rate.',
    `bonus_miles_awarded` STRING COMMENT 'Number of bonus or promotional miles awarded in addition to base miles, based on member tier status, promotional campaigns, or partner-specific bonuses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner transaction record was first created in the Airlines FFP system.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this partner transaction is under dispute by the member or partner (true if disputed, false otherwise).',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the transaction is flagged for dispute (e.g., miles not posted, incorrect amount, transaction not recognized).',
    `dispute_resolution_date` DATE COMMENT 'Date when the dispute was resolved, if applicable.',
    `earn_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to calculate miles earned per unit of partner transaction amount, as defined in the partner agreement (e.g., 1.5 miles per dollar spent).',
    `expiration_date` DATE COMMENT 'Date when the miles awarded in this partner transaction will expire if not used, per FFP expiration policy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner transaction record was last modified in the Airlines FFP system.',
    `member_tier_at_transaction` STRING COMMENT 'FFP tier status of the member at the time of the partner transaction (e.g., Silver, Gold, Platinum), which may affect bonus miles calculation.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this partner transaction, used for operational context or special handling instructions.',
    `partner_category` STRING COMMENT 'Category of partner business type (hotel, car rental, credit card issuer, retail merchant, dining, travel services).. Valid values are `hotel|car_rental|credit_card|retail|dining|travel_services`',
    `partner_location_city` STRING COMMENT 'City where the partner transaction occurred.',
    `partner_location_code` STRING COMMENT 'Code identifying the specific partner location where the transaction occurred (e.g., hotel property code, car rental branch code, retail store identifier).',
    `partner_location_country_code` STRING COMMENT 'Three-letter ISO country code where the partner transaction occurred.. Valid values are `^[A-Z]{3}$`',
    `partner_location_name` STRING COMMENT 'Descriptive name of the partner location where the transaction occurred (e.g., Marriott Times Square, Hertz LAX Airport).',
    `posting_date` DATE COMMENT 'Date when the miles from this partner transaction were posted to the member FFP account ledger.',
    `posting_status` STRING COMMENT 'Current status of the transaction in the FFP posting workflow indicating whether miles have been successfully credited or debited to the member account.. Valid values are `pending|posted|rejected|reversed|under_review`',
    `reconciliation_date` DATE COMMENT 'Date when this transaction was reconciled with the partner for settlement purposes.',
    `reconciliation_status` STRING COMMENT 'Status of financial reconciliation between Airlines and the partner for this transaction.. Valid values are `pending|reconciled|discrepancy|partner_confirmed`',
    `reference` STRING COMMENT 'External reference number or confirmation code provided by the partner for this transaction. Used for reconciliation and dispute resolution.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal of a previous partner transaction (true if reversal, false otherwise).',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Amount paid or received by Airlines for this partner transaction as part of the partner revenue-sharing or cost-sharing agreement.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO currency code for the settlement amount between Airlines and the partner.. Valid values are `^[A-Z]{3}$`',
    `source_system` STRING COMMENT 'Name of the source system or partner integration platform from which this transaction was received (e.g., Oracle Loyalty Cloud, Partner API Gateway).',
    `source_system_transaction_code` STRING COMMENT 'Unique transaction identifier in the source system or partner platform, used for traceability and audit.',
    `total_miles` STRING COMMENT 'Total miles awarded or redeemed in this transaction (sum of base miles and bonus miles).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the partner transaction in the original transaction currency (e.g., hotel bill amount, car rental charge, credit card purchase amount).',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'Date when the partner transaction occurred (e.g., hotel checkout date, car rental return date, credit card purchase date).',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the partner transaction was recorded in the partner system, including time zone information.',
    `transaction_type` STRING COMMENT 'Type of partner transaction indicating whether miles were earned (accrual) or redeemed (burn), or if this is a reversal or adjustment.. Valid values are `earn|burn|reversal|adjustment|bonus`',
    CONSTRAINT pk_partner_transaction PRIMARY KEY(`partner_transaction_id`)
) COMMENT 'Transactional record of miles earned or redeemed through non-airline FFP partners (hotels, car rentals, credit cards, retail). Captures partner program ID, member FFP number, partner transaction reference, transaction date, transaction amount, transaction currency, miles awarded or redeemed, bonus miles, partner location/property, transaction type (earn/burn), posting status, and dispute flag. Feeds into mileage_accrual and mileage_redemption for consolidated member ledger.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`promotion` (
    `promotion_id` BIGINT COMMENT 'Unique identifier for the FFP (Frequent Flyer Program) promotional campaign. Primary key. Inferred role: MASTER_RESOURCE (promotional campaign as a managed marketing resource).',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Loyalty promotions require budget allocation for bonus miles and campaign costs. Links promotion to budget plan for cost tracking, variance analysis, and financial planning. Essential for marketing sp',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Loyalty promotions have actual_cost and estimated_cost requiring cost centre attribution for management accounting and marketing budget control. Airlines attribute promotion spend to specific cost cen',
    `fare_family_id` BIGINT COMMENT 'Foreign key linking to revenue.fare_family. Business justification: Loyalty promotions are routinely scoped to specific fare families (e.g., earn double miles on Flex fare family). Revenue and loyalty teams co-design promotions by fare family. Promotion eligibility ',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total financial cost incurred by the promotion after completion, calculated from bonus miles awarded and their valuation. Used for ROI (Return on Investment) analysis. Business-sensitive financial data.',
    `approval_status` STRING COMMENT 'Workflow approval state for the promotion before it can be scheduled or activated. Used for governance and financial control over promotional spend.. Valid values are `pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the manager or executive who approved the promotion. Null if not yet approved. Used for accountability and audit.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion was approved. Null if not yet approved. Distinct lifecycle event from creation and modification.',
    `bonus_miles_formula` STRING COMMENT 'Business rule or formula defining how bonus miles are calculated (e.g., 2x base miles, flat 5000 miles, base_miles * 1.5 + 1000). Free-text expression used by accrual engine. Measurement/value category for the promotion.',
    `communication_channel` STRING COMMENT 'Primary channel(s) used to communicate the promotion to members (email, SMS, push notification, in-app message, website banner, or all). Used for campaign execution and member engagement.. Valid values are `email|sms|push_notification|in_app|website|all`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion record was first created in the system. Record audit created timestamp.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estimated_cost and actual_cost (e.g., USD, EUR, GBP). Used for multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `eligible_member_tiers` STRING COMMENT 'Comma-separated list of FFP (Frequent Flyer Program) member tier codes eligible to participate (e.g., SILVER,GOLD,PLATINUM or ALL). Empty or ALL indicates no tier restriction.',
    `eligible_partners` STRING COMMENT 'Comma-separated list of partner airline IATA codes or coalition partner identifiers eligible for bonus earn (e.g., AA,BA,QF for airline partners or HOTEL_CHAIN_X for non-air partners). Empty or ALL indicates no partner restriction.',
    `end_date` DATE COMMENT 'Date when the promotion expires and no further bonus accruals are allowed. Effective-until date for the promotion. Nullable for open-ended promotions.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total financial cost or liability of the promotion in the airlines reporting currency (e.g., USD). Used for budgeting and financial planning. Business-sensitive financial data.',
    `external_promotion_code` STRING COMMENT 'Unique identifier for the promotion in the source operational system (e.g., Oracle Loyalty Cloud promotion ID). Used for cross-system reconciliation and data lineage.',
    `last_modified_by` STRING COMMENT 'User ID or name of the staff who last updated the promotion record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotion record was last updated. Record audit updated timestamp.',
    `maximum_bonus_cap` STRING COMMENT 'Maximum total bonus miles a member can earn under this promotion. Null indicates no cap. Used to control promotion liability and prevent abuse.',
    `opt_in_count` STRING COMMENT 'Total number of members who have opted into this promotion. Updated in real-time or batch. Used for campaign performance measurement.',
    `opt_in_required_flag` BOOLEAN COMMENT 'Indicates whether members must explicitly opt-in or register for the promotion (true) or if it is automatically applied to eligible members (false). Used for campaign engagement tracking.',
    `priority_rank` STRING COMMENT 'Numeric priority or precedence rank when multiple promotions are eligible for the same transaction. Lower number indicates higher priority. Used by accrual engine to resolve conflicts.',
    `promotion_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the promotion (e.g., DOUBLE2024, TIERBOOST). Used by members to opt-in or by system to auto-apply. Business identifier for the promotion.. Valid values are `^[A-Z0-9]{4,12}$`',
    `promotion_description` STRING COMMENT 'Detailed marketing description of the promotion, including terms, conditions, and member benefits. Used for customer communication and internal reference.',
    `promotion_name` STRING COMMENT 'Human-readable marketing name of the promotion (e.g., Summer Double Miles, Elite Status Challenge). Identity label for the promotion.',
    `promotion_status` STRING COMMENT 'Current lifecycle state of the promotion: draft (being designed), scheduled (approved, not yet started), active (currently running), paused (temporarily suspended), completed (ended successfully), cancelled (terminated before completion). Lifecycle status for the promotion.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `promotion_type` STRING COMMENT 'Classification of the promotional campaign mechanism: double_miles (2x earn rate), triple_miles (3x earn rate), tier_challenge (accelerated tier qualification), status_match (match competitor status), bonus_on_route (extra miles on specific routes), partner_bonus (bonus on partner airline or coalition earn), upgrade_bonus (complimentary or discounted upgrades). Classification category for the promotion. [ENUM-REF-CANDIDATE: double_miles|triple_miles|tier_challenge|status_match|bonus_on_route|partner_bonus|upgrade_bonus — 7 candidates stripped; promote to reference product]',
    `redemption_count` STRING COMMENT 'Total number of transactions or bookings where this promotion was successfully applied and bonus miles were awarded. Used for ROI (Return on Investment) analysis and campaign effectiveness.',
    `source_system` STRING COMMENT 'Name of the operational system where the promotion was originally created (e.g., Oracle Loyalty Cloud, Amadeus Altéa, Custom Promo Engine). Used for data lineage and integration troubleshooting.',
    `start_date` DATE COMMENT 'Date when the promotion becomes active and members can begin earning bonus miles or benefits. Effective-from date for the promotion.',
    `target_segment` STRING COMMENT 'Marketing segment or customer cohort targeted by this promotion (e.g., Inactive Members, High-Value Flyers, New Enrollees, Corporate Travelers). Used for campaign targeting and performance analysis.',
    `terms_and_conditions_url` STRING COMMENT 'Web URL linking to the full legal terms and conditions document for the promotion. Used for regulatory compliance and member transparency.. Valid values are `^https?://.*$`',
    `created_by` STRING COMMENT 'User ID or name of the marketing or loyalty operations staff who created the promotion record. Used for audit trail and accountability.',
    CONSTRAINT pk_promotion PRIMARY KEY(`promotion_id`)
) COMMENT 'Master record for FFP promotional campaigns offering bonus miles, tier accelerators, or special rewards. Captures promotion code, promotion name, promotion type (double miles, tier challenge, status match, bonus on route, partner bonus), target segment, eligible member tiers, eligible routes or partners, promotion start date, promotion end date, bonus miles formula, maximum bonus cap, opt-in requirement flag, opt-in count, redemption count, and promotion status. Aligns with Oracle Loyalty Cloud promotions module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` (
    `promotion_enrollment_id` BIGINT COMMENT 'Unique identifier for the promotion enrollment record. Primary key.',
    `ffp_member_id` BIGINT COMMENT 'Identifier of the FFP member who enrolled in the promotion.',
    `partner_program_id` BIGINT COMMENT 'Foreign key linking to loyalty.partner_program. Business justification: loyalty_promotion_enrollment has partner_code (STRING) and partner_promotion_flag (BOOLEAN) indicating partner-specific promotions. When a member enrolls in a partner promotion, the enrollment should ',
    `promotion_id` BIGINT COMMENT 'Identifier of the loyalty promotion in which the member enrolled.',
    `auto_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the member was automatically enrolled based on tier status or other eligibility criteria, versus explicit opt-in.',
    `bonus_miles_earned` BIGINT COMMENT 'Total bonus miles or points awarded to the member upon successful completion of the promotion.',
    `bonus_posting_date` DATE COMMENT 'Date when bonus miles or rewards were posted to the members FFP account.',
    `bonus_posting_status` STRING COMMENT 'Status of the bonus miles posting transaction to the members account.. Valid values are `pending|posted|failed|reversed|scheduled`',
    `cancellation_date` DATE COMMENT 'Date when the enrollment was cancelled by the member or system.',
    `cancellation_reason` STRING COMMENT 'Reason for enrollment cancellation (e.g., member request, account closure, fraud, terms violation).',
    `completion_date` DATE COMMENT 'Date when the promotion enrollment was marked as completed and rewards were posted or scheduled.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was first created in the system.',
    `enrollment_channel` STRING COMMENT 'Channel or touchpoint through which the member enrolled in the promotion.. Valid values are `web|mobile_app|email|call_center|airport_kiosk|partner_site`',
    `enrollment_date` DATE COMMENT 'Date when the member enrolled in the promotion.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment reference number for tracking and customer service inquiries.. Valid values are `^PROMO-[A-Z0-9]{8,12}$`',
    `enrollment_source_campaign` STRING COMMENT 'Marketing campaign code or identifier that drove the enrollment, used for campaign effectiveness tracking.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the promotion enrollment. Tracks progression from initial enrollment through completion or termination. [ENUM-REF-CANDIDATE: enrolled|in_progress|qualified|completed|expired|cancelled|disqualified — 7 candidates stripped; promote to reference product]',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the member enrolled in the promotion, including timezone information.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was last updated, used for audit trail and data synchronization.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether enrollment confirmation or completion notification was sent to the member.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when enrollment or completion notification was sent to the member.',
    `opt_in_consent_flag` BOOLEAN COMMENT 'Indicates whether the member provided explicit consent to participate in the promotion and receive related communications.',
    `partner_promotion_flag` BOOLEAN COMMENT 'Indicates whether this is a co-branded promotion with a partner airline, hotel, or coalition program.',
    `promotion_end_date` DATE COMMENT 'Date when the promotion period ends and qualification window closes.',
    `promotion_start_date` DATE COMMENT 'Date when the promotion period begins for this enrollment, may differ from enrollment date for future-dated promotions.',
    `qualification_criteria_type` STRING COMMENT 'Type of qualification criteria the member must meet to complete the promotion (e.g., number of flights, miles earned, spend threshold).. Valid values are `flight_count|segment_count|miles_flown|spend_amount|partner_activity|hybrid`',
    `qualification_current_value` DECIMAL(18,2) COMMENT 'Current progress value toward the qualification target, updated as qualifying activities are completed.',
    `qualification_deadline_date` DATE COMMENT 'Final date by which the member must complete qualification criteria to earn promotion rewards.',
    `qualification_percentage` DECIMAL(18,2) COMMENT 'Percentage of qualification criteria completed, calculated as (current_value / target_value) * 100.',
    `qualification_target_value` DECIMAL(18,2) COMMENT 'Target value the member must achieve to qualify for promotion completion (e.g., 5 flights, 10000 miles, 500 USD spend).',
    `qualification_unit` STRING COMMENT 'Unit of measure for qualification progress (e.g., flights, miles, currency units). [ENUM-REF-CANDIDATE: flights|segments|miles|kilometers|currency|points|nights|transactions — 8 candidates stripped; promote to reference product]',
    `qualified_date` DATE COMMENT 'Date when the member met all qualification criteria and became eligible for promotion rewards.',
    `qualifying_activities_count` STRING COMMENT 'Number of qualifying activities (flights, transactions, partner activities) completed toward promotion requirements.',
    `terms_version` STRING COMMENT 'Version identifier of the promotion terms and conditions that the member agreed to at enrollment.',
    `tier_bonus_multiplier` DECIMAL(18,2) COMMENT 'Additional multiplier applied to promotion rewards based on the members elite tier status at time of qualification.',
    CONSTRAINT pk_promotion_enrollment PRIMARY KEY(`promotion_enrollment_id`)
) COMMENT 'Tracks individual member opt-ins and participation in loyalty promotions. Records member FFP number, promotion ID, enrollment date, enrollment channel, qualification progress (e.g., flights completed vs. required), bonus miles awarded, promotion completion date, and promotion outcome status (enrolled, in-progress, completed, expired, cancelled). Enables targeted promotion tracking and bonus posting automation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`member_benefit` (
    `member_benefit_id` BIGINT COMMENT 'Unique identifier for the member benefit entitlement record. Primary key.',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Member benefits such as upgrade vouchers, lounge access, and extra baggage are often restricted to specific cabin classes. The denormalized cabin_class_restriction column should be replaced with a pro',
    `ffp_member_id` BIGINT COMMENT 'Reference to the FFP member who holds this benefit entitlement.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Member benefits have cost_to_airline attribute requiring GL posting for loyalty benefit cost accounting (lounge access, extra baggage, upgrades). Airlines must post benefit delivery costs to GL for ma',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to route.carrier. Business justification: Member benefits such as lounge access, upgrade eligibility, and baggage allowances on partner airlines require a structured reference to the partner carrier for eligibility validation at check-in and ',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to ancillary.product_catalog. Business justification: Benefit-to-product fulfillment mapping: loyalty member benefits (free seat selection, lounge access, extra baggage) correspond to specific ancillary product catalog entries for fulfillment, revenue ac',
    `tier_status_id` BIGINT COMMENT 'Reference to the FFP tier status to which this benefit is attached.',
    `activation_trigger` STRING COMMENT 'Event or condition that triggered the activation of this benefit entitlement (e.g., tier qualification, manual grant by admin, promotional campaign, lifetime status achievement, status challenge match).. Valid values are `tier_qualification|manual_grant|promotion|lifetime_status|challenge_match`',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the benefit automatically renews upon tier re-qualification or expiration (True) or requires manual re-issuance (False).',
    `benefit_code` STRING COMMENT 'Unique alphanumeric code identifying the benefit type (e.g., LOUNGE_ACCESS, PRIORITY_CHECKIN, EXTRA_BAG).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `benefit_description` STRING COMMENT 'Detailed description of the benefit entitlement, including terms, conditions, and usage instructions.',
    `benefit_name` STRING COMMENT 'Human-readable name of the benefit (e.g., Priority Lounge Access, Extra Baggage Allowance).',
    `benefit_quantity` STRING COMMENT 'Numeric quantity or limit of the benefit entitlement (e.g., 2 lounge passes, 20kg extra baggage). Null indicates unlimited.',
    `benefit_status` STRING COMMENT 'Current lifecycle status of the benefit entitlement: active (usable), suspended (temporarily unavailable), expired (validity period ended), revoked (administratively removed), or pending activation.. Valid values are `active|suspended|expired|revoked|pending_activation`',
    `benefit_terms` STRING COMMENT 'Full text of terms and conditions governing the use of this benefit, including restrictions, blackout dates, and eligibility criteria.',
    `benefit_type` STRING COMMENT 'Category of benefit entitlement: lounge access, priority check-in, priority boarding, extra baggage allowance, seat upgrade priority, companion ticket, bonus mile multiplier, or dedicated phone support. [ENUM-REF-CANDIDATE: lounge_access|priority_checkin|priority_boarding|extra_baggage|seat_upgrade|companion_ticket|bonus_miles|dedicated_support — 8 candidates stripped; promote to reference product]',
    `benefit_unit` STRING COMMENT 'Unit of measurement for the benefit quantity (e.g., passes, kg for baggage, segments, upgrade certificates, multiplier for bonus miles). [ENUM-REF-CANDIDATE: passes|kg|segments|upgrades|multiplier|tickets|hours — 7 candidates stripped; promote to reference product]',
    `benefit_validity_end_date` DATE COMMENT 'Date on which the benefit entitlement expires. Null indicates no expiration.',
    `benefit_validity_start_date` DATE COMMENT 'Date from which the benefit entitlement becomes active and usable by the member.',
    `blackout_dates` STRING COMMENT 'Comma-separated list of date ranges or specific dates when the benefit cannot be used (e.g., peak holiday periods). Null if no blackout dates apply.',
    `cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the cost_to_airline amount.. Valid values are `^[A-Z]{3}$`',
    `cost_to_airline` DECIMAL(18,2) COMMENT 'Estimated cost to the airline for providing this benefit entitlement, used for financial planning and benefit valuation analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit entitlement record was first created in the system.',
    `delivery_channel` STRING COMMENT 'Channel through which the benefit is delivered or redeemed (e.g., airport counter, online portal, mobile app, call center, partner location, automatic application).. Valid values are `airport|online|mobile_app|call_center|partner_location|automatic`',
    `geographic_restriction` STRING COMMENT 'Geographic scope or restriction for benefit usage (e.g., domestic only, international only, specific regions or airport codes). Null if no restriction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit entitlement record was most recently updated.',
    `last_usage_date` DATE COMMENT 'Date when the benefit was most recently used or redeemed by the member.',
    `notes` STRING COMMENT 'Free-text notes for internal use, capturing special circumstances, manual adjustments, or member service interactions related to this benefit.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the priority level of this benefit when multiple members compete for limited resources (e.g., upgrade waitlist priority). Lower numbers indicate higher priority.',
    `remaining_balance` STRING COMMENT 'Remaining quantity of the benefit available for use (benefit_quantity minus usage_count). Null if unlimited.',
    `revocation_reason` STRING COMMENT 'Reason for benefit revocation if status is revoked (e.g., tier downgrade, policy violation, account closure). Null if benefit has not been revoked.',
    `tier_applicability` STRING COMMENT 'Comma-separated list of tier codes to which this benefit applies (e.g., GOLD,PLATINUM,DIAMOND).. Valid values are `^[A-Z0-9,]+$`',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the benefit can be transferred to another FFP member or companion (True) or is non-transferable (False).',
    `usage_count` STRING COMMENT 'Number of times this benefit has been used or redeemed by the member during the current validity period.',
    `usage_history_summary` STRING COMMENT 'Summary text of benefit usage history, including dates, locations, and transaction references for audit and member inquiry purposes.',
    CONSTRAINT pk_member_benefit PRIMARY KEY(`member_benefit_id`)
) COMMENT 'Defines the specific benefit entitlements associated with each FFP tier or membership type and tracks their consumption. Captures benefit type (lounge access, priority check-in, extra baggage allowance, seat upgrade priority, companion ticket, bonus mile multiplier, dedicated phone line), benefit tier applicability, benefit quantity/limit, benefit validity period, benefit delivery channel, benefit terms, usage count, last usage date, remaining balance, and usage history summary. Reference entity linking tier levels to their operational benefit entitlements with consumption tracking for benefit cap enforcement and utilization reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`upgrade_request` (
    `upgrade_request_id` BIGINT COMMENT 'Unique identifier for the upgrade request. Primary key for the upgrade request entity.',
    `award_booking_id` BIGINT COMMENT 'Foreign key linking to loyalty.award_booking. Business justification: upgrade_request can be linked to award_booking when the upgrade is processed using FFP miles (miles-based cabin upgrade on an award ticket). This FK will be NULL for revenue ticket upgrades and compli',
    `booking_segment_id` BIGINT COMMENT 'Foreign key linking to flight.booking_segment. Business justification: Upgrade processing must update the specific booking segment record (seat assignment, cabin class, boarding sequence, fare basis) when an upgrade clears. Aviation upgrade management systems require a d',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Upgrade eligibility rules depend on current cabin class. Normalizes current_cabin_class text column. Required for upgrade policy enforcement and operational upgrade clearance workflows.',
    `ffp_member_id` BIGINT COMMENT 'Identifier of the FFP member who submitted the upgrade request.',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Upgrade requests target specific flight inventory for clearance processing. Critical for upgrade waitlist management, elite benefit fulfillment, and revenue management decisions on premium cabin inven',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Upgrade requests target specific operated flight legs for real-time inventory management, waitlist clearance processing, and operational upgrade execution at departure. Required for departure control ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Upgrade requests with co_pay_amount generate revenue GL postings; miles_deducted triggers liability release GL entries. Finance requires GL reference for upgrade co-pay revenue recognition and miles l',
    `mileage_redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.mileage_redemption. Business justification: upgrade_request.miles_deducted captures the miles amount but there is no FK to the mileage_redemption record that was created when miles were deducted for a miles-based upgrade. Adding mileage_redempt',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Requests track origin_airport_code; FK enables station-level upgrade inventory management, hub capacity planning, and operational reporting on upgrade demand by station. Role prefix for clarity.',
    `pnr_id` BIGINT COMMENT 'Foreign key linking to reservation.pnr. Business justification: Upgrade request processing at check-in and gate requires direct PNR reference to retrieve booking context, passenger count, and fare restrictions. The plain pnr attribute on upgrade_request is a denor',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_promotion. Business justification: upgrade_request has promotion_code (STRING) attribute. Upgrade requests can be part of promotional campaigns offering discounted or complimentary upgrades. Adding loyalty_promotion_id FK enables joini',
    `seat_map_id` BIGINT COMMENT 'Foreign key linking to fleet.seat_map. Business justification: Upgrade Seat Assignment Validation: when an upgrade clears, the assigned seat must be validated against the actual seat map (exit row, bulkhead, accessible restrictions). Linking upgrade_request to se',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Upgrade clearance processing checks fare class bucket availability in the target cabin before confirming an upgrade. The role prefix target_ distinguishes this from the current cabin reference. Avia',
    `ticket_coupon_id` BIGINT COMMENT 'Foreign key linking to revenue.ticket_coupon. Business justification: Upgrades apply to specific flight coupons. Link required for inventory control, revenue recognition (upgrade fees), and operational execution. New attribute; no existing candidate.',
    `upgrade_offer_id` BIGINT COMMENT 'Foreign key linking to ancillary.upgrade_offer. Business justification: Upgrade offer matching for loyalty requests: when a loyalty upgrade request is processed, the system must identify which ancillary upgrade_offer was presented or applied. This FK enables upgrade conve',
    `upgrade_transaction_id` BIGINT COMMENT 'Foreign key linking to ancillary.upgrade_transaction. Business justification: Upgrade clearance reconciliation: when a loyalty upgrade request (miles/complimentary) is fulfilled via a paid ancillary upgrade transaction, this FK links the two records for audit, revenue accountin',
    `cancellation_reason` STRING COMMENT 'Free-text explanation or standardized reason for why the upgrade request was cancelled.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade request was cancelled by the member or system.',
    `co_pay_amount` DECIMAL(18,2) COMMENT 'Monetary amount paid by the member in addition to miles for a co-pay upgrade. Null for complimentary or pure miles-based upgrades.',
    `co_pay_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the co-pay amount.. Valid values are `^[A-Z]{3}$`',
    `companion_upgrade_flag` BOOLEAN COMMENT 'Indicates whether this upgrade request includes a companion passenger traveling on the same PNR and eligible for upgrade under the members benefits.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason an upgrade request was denied: no availability in requested cabin, insufficient miles balance, ineligible fare class, cabin at capacity, operational restrictions, or request expired.. Valid values are `no_availability|insufficient_miles|ineligible_fare|cabin_full|operational_restriction|expired`',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the arrival airport for the flight segment.. Valid values are `^[A-Z]{3}$`',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade request will automatically expire if not cleared, typically set relative to departure time or check-in deadline.',
    `fare_class_code` STRING COMMENT 'Single-letter fare class booking code of the original ticket, which influences upgrade eligibility and priority.. Valid values are `^[A-Z]{1}$`',
    `flight_number` STRING COMMENT 'Flight number for which the upgrade is requested, consisting of two-letter airline code followed by numeric flight identifier.. Valid values are `^[A-Z]{2}[0-9]{1,4}$`',
    `miles_deducted` BIGINT COMMENT 'Number of frequent flyer miles deducted from the members account for a miles-based or co-pay upgrade. Null for complimentary elite upgrades.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the upgrade request, typically entered by agents or system for special handling instructions.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the departure airport for the flight segment.. Valid values are `^[A-Z]{3}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this upgrade request record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this upgrade request record was last modified in the system.',
    `request_channel` STRING COMMENT 'Channel through which the upgrade request was submitted: web portal, mobile application, call center agent, airport self-service kiosk, gate agent, or partner airline portal.. Valid values are `web|mobile_app|call_center|airport_kiosk|gate|partner_portal`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade request was initially submitted by the member or system.',
    `request_type` STRING COMMENT 'Type of upgrade request indicating the method or entitlement basis: complimentary elite upgrade based on tier status, miles-based redemption, co-pay upgrade combining miles and cash, operational upgrade at airline discretion, or revenue upgrade purchased at gate.. Valid values are `complimentary_elite|miles_based|co_pay|operational|revenue`',
    `requested_cabin_class` STRING COMMENT 'The target cabin class to which the passenger is requesting an upgrade.. Valid values are `premium_economy|business|first`',
    `seat_number_assigned` STRING COMMENT 'Specific seat number assigned to the passenger in the upgraded cabin once the upgrade is cleared. Format: row number followed by seat letter.. Valid values are `^[0-9]{1,3}[A-K]{1}$`',
    `source_system` STRING COMMENT 'Name or identifier of the operational system that originated this upgrade request record, such as Oracle Loyalty Cloud or Amadeus Altéa PSS.',
    `travel_date` DATE COMMENT 'Scheduled date of travel for the flight segment being upgraded.',
    `upgrade_cleared_timestamp` TIMESTAMP COMMENT 'Date and time when the upgrade was confirmed and cleared, allowing the passenger to board in the upgraded cabin.',
    `upgrade_priority_score` DECIMAL(18,2) COMMENT 'Calculated priority score determining the members position in the upgrade queue, based on factors such as tier status, fare class, lifetime miles, and request timing.',
    `upgrade_status` STRING COMMENT 'Current status of the upgrade request in its lifecycle: requested (initial submission), waitlisted (pending availability), confirmed (upgrade space allocated), cleared (passenger checked in with upgrade), denied (request rejected), expired (request lapsed), or cancelled (passenger withdrew request). [ENUM-REF-CANDIDATE: requested|waitlisted|confirmed|cleared|denied|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `waitlist_position` STRING COMMENT 'Current position of the member in the upgrade waitlist queue for the flight, with lower numbers indicating higher priority.',
    CONSTRAINT pk_upgrade_request PRIMARY KEY(`upgrade_request_id`)
) COMMENT 'Tracks member requests for complimentary or miles-based cabin upgrades. Captures request type (complimentary elite upgrade, miles upgrade, co-pay upgrade), member FFP number, PNR reference, flight number, travel date, origin, destination, requested cabin, current cabin, upgrade priority score, waitlist position, upgrade status (requested, waitlisted, confirmed, cleared, denied, expired), upgrade clearing timestamp, miles deducted if applicable, and upgrade source channel.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`miles_transfer` (
    `miles_transfer_id` BIGINT COMMENT 'Unique identifier for the peer-to-peer miles transfer transaction. Primary key.',
    `ffp_member_id` BIGINT COMMENT 'FFP member identifier of the member sending/gifting miles. References the member initiating the transfer.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_promotion. Business justification: miles_transfer.promotion_code is a STRING denormalized reference to a loyalty promotion (e.g., bonus miles for transferring miles during a promotional period). Adding loyalty_promotion_id FK normalize',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this transfer requires manual approval by FFP operations team (e.g., high-value transfers, fraud risk, first-time transfer). True if approval required, False if auto-approved.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer was approved. Null if auto-approved (approval timestamp equals transfer timestamp) or still pending.',
    `bonus_miles_awarded` BIGINT COMMENT 'Additional bonus miles awarded to sender or recipient as part of a transfer promotion. Zero if no bonus awarded.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the transfer was cancelled by sender or system before completion. Null if not cancelled.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the miles were successfully posted to recipient account and deducted from sender account. Null if transfer not yet completed.',
    `expiry_date` DATE COMMENT 'Date when the transferred miles will expire in the recipient account, if different from standard expiry rules. Null if standard expiry applies.',
    `fee_discount_applied` DECIMAL(18,2) COMMENT 'Monetary discount amount applied to the standard transfer fee due to promotion, tier status, or relationship type. Zero if no discount applied.',
    `fraud_review_flag` BOOLEAN COMMENT 'Indicates whether this transfer was flagged for manual fraud review. True if flagged, False otherwise.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Automated fraud detection risk score assigned to this transfer at time of initiation (0.00 = no risk, 100.00 = high risk). Used to flag suspicious transfers for review.',
    `miles_transferred` BIGINT COMMENT 'Quantity of loyalty miles transferred from sender to recipient in this transaction. Must be positive integer value.',
    `payment_method` STRING COMMENT 'Payment instrument used by sender to pay the transfer fee: credit_card, debit_card, miles_deduction (fee paid in miles), bank_transfer, paypal, wallet (digital wallet).. Valid values are `credit_card|debit_card|miles_deduction|bank_transfer|paypal|wallet`',
    `payment_reference_number` STRING COMMENT 'External payment gateway or processor transaction reference number for the transfer fee payment. Null if no fee charged.',
    `recipient_annual_receipt_consumed` BIGINT COMMENT 'Cumulative miles the recipient has received in the current calendar year after this transaction completes. Used to enforce annual receipt limits.',
    `recipient_annual_receipt_limit` BIGINT COMMENT 'Maximum miles the recipient is allowed to receive per calendar year according to FFP program rules. Captured at time of transfer for audit purposes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this record was first created in the source system. Audit field for data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this record was last modified in the source system. Audit field for change tracking.',
    `rejection_reason` STRING COMMENT 'Free-text explanation for why the transfer was rejected (e.g., insufficient miles, limit exceeded, fraud detected, policy violation). Null if not rejected.',
    `relationship_type` STRING COMMENT 'Declared relationship between sender and recipient. Some FFP programs offer preferential transfer terms for family members. Self-declared by sender at time of transfer. [ENUM-REF-CANDIDATE: family|friend|spouse|partner|child|parent|sibling|unrelated — 8 candidates stripped; promote to reference product]',
    `relationship_verified_flag` BOOLEAN COMMENT 'Indicates whether the declared relationship between sender and recipient has been verified by the airline (e.g., through documentation submission). True if verified, False if unverified or not required.',
    `reversal_reason` STRING COMMENT 'Free-text explanation for why a completed transfer was reversed (e.g., fraud investigation, payment chargeback, system error). Null if not reversed.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the transfer was reversed and miles returned to sender. Null if not reversed.',
    `sender_annual_transfer_consumed` BIGINT COMMENT 'Cumulative miles the sender has transferred in the current calendar year after this transaction completes. Used to enforce annual transfer limits.',
    `sender_annual_transfer_limit` BIGINT COMMENT 'Maximum miles the sender is allowed to transfer per calendar year according to FFP program rules and sender tier status. Captured at time of transfer for audit purposes.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this transfer record (e.g., Oracle Loyalty Cloud, legacy FFP system). Used for data lineage and reconciliation.',
    `transfer_channel` STRING COMMENT 'Digital or physical channel through which the transfer was initiated: web (airline website), mobile_app, call_center (agent-assisted), partner_portal (coalition partner interface), kiosk (airport self-service).. Valid values are `web|mobile_app|call_center|partner_portal|kiosk`',
    `transfer_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged to the sender for executing the miles transfer. Zero for fee-waived transfers (e.g., family pool contributions).',
    `transfer_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transfer fee amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transfer_notes` STRING COMMENT 'Free-text notes or comments about the transfer, entered by sender (e.g., gift message) or operations agent (e.g., special handling instructions). Null if no notes.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the miles transfer: pending (awaiting approval), approved (authorized but not yet posted), completed (miles successfully transferred), rejected (transfer denied), cancelled (sender cancelled before completion), reversed (transfer reversed after completion due to fraud or error).. Valid values are `pending|approved|completed|rejected|cancelled|reversed`',
    `transfer_timestamp` TIMESTAMP COMMENT 'Date and time when the miles transfer was initiated by the sender. Represents the business event time of the transfer request.',
    `transfer_transaction_number` STRING COMMENT 'Externally visible unique transaction reference number for the miles transfer, used for customer service inquiries and audit trails.. Valid values are `^[A-Z0-9]{8,20}$`',
    `transfer_type` STRING COMMENT 'Classification of the miles transfer transaction: gift (one-time transfer to another member), family_pool (contribution to family pooling account), purchase (bought miles transferred to recipient), share (reciprocal sharing arrangement), donation (charitable contribution of miles).. Valid values are `gift|family_pool|purchase|share|donation`',
    CONSTRAINT pk_miles_transfer PRIMARY KEY(`miles_transfer_id`)
) COMMENT 'Records peer-to-peer miles transfer transactions between FFP members (gifting, pooling, family sharing). Captures sender FFP number, recipient FFP number, miles transferred, transfer fee charged, transfer date, transfer type (gift, family pool contribution, purchase), transfer status, and applicable transfer limits consumed. Distinct from partner_transaction as it represents member-to-member movement of loyalty currency.';

CREATE OR REPLACE TABLE `airlines_ecm`.`loyalty`.`award_inventory` (
    `award_inventory_id` BIGINT COMMENT 'Unique identifier for the award inventory record. Primary key for the award seat allocation entity.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Award Inventory Configuration by Aircraft Type: loyalty teams allocate award seats only on aircraft types with the correct cabin product (e.g., lie-flat business). Without this FK, award inventory can',
    `cabin_class_id` BIGINT COMMENT 'Foreign key linking to inventory.cabin_class. Business justification: Award inventory allocation is managed per cabin class with distinct availability and pricing. Normalizes cabin_class text column. Critical for award seat availability management and FFP redemption ope',
    `cabin_configuration_id` BIGINT COMMENT 'Foreign key linking to fleet.cabin_configuration. Business justification: Award Seat Allocation by Cabin Configuration: award inventory must reflect the exact onboard product (seat count, lie-flat availability) defined in the cabin configuration. Loyalty revenue managers co',
    `fare_class_bucket_id` BIGINT COMMENT 'Foreign key linking to inventory.fare_class_bucket. Business justification: Award inventory is managed at the fare class bucket level in airline inventory systems (e.g., Altea). Award bucket codes map directly to RBD fare class buckets. Revenue management links award availabi',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Award inventory control requires reconciling award seat allocations against total flight capacity. Revenue management teams query flight_inventory to validate available seats before releasing award bu',
    `flight_number_id` BIGINT COMMENT 'Foreign key linking to route.flight_number. Business justification: Award seat inventory is allocated per scheduled flight number for GDS distribution and award availability management. Linking award_inventory to route.flight_number enables schedule-aware award capaci',
    `tier_status_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier_status. Business justification: award_inventory.minimum_tier_required is a STRING denormalized reference to the minimum tier level required to access this award inventory bucket. Adding minimum_tier_status_id FK to tier_status norma',
    `partner_program_id` BIGINT COMMENT 'Foreign key linking to loyalty.partner_program. Business justification: award_inventory has partner_award_availability_flag indicating partner award seats exist, but no FK to partner_program. Award inventory can be allocated specifically for partner airline redemptions. A',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Award seat allocation strategy by route, route profitability analysis including award redemption costs, and network planning for award availability all require linking award inventory to routes. Essen',
    `scheduled_flight_id` BIGINT COMMENT 'Foreign key linking to flight.scheduled_flight. Business justification: Award seat inventory is allocated and managed at the scheduled flight level. Revenue management systems control award availability per scheduled flight. The current award_inventory carries denormalize',
    `allocation_effective_date` DATE COMMENT 'The date from which this award seat allocation becomes effective and available for member booking.',
    `allocation_expiry_date` DATE COMMENT 'The date after which this award seat allocation expires and is no longer available for booking. Null for open-ended allocations.',
    `allocation_notes` STRING COMMENT 'Free-text notes regarding special conditions, restrictions, or context for this award inventory allocation. Used by revenue management and FFP operations teams.',
    `allocation_source` STRING COMMENT 'The source or method by which award seats were allocated to this inventory bucket. Revenue management indicates standard RM allocation; partner agreement indicates contractual allocation; promotional indicates campaign-driven allocation; dynamic indicates real-time algorithmic allocation.. Valid values are `revenue_management|partner_agreement|promotional|dynamic`',
    `award_bucket_type` STRING COMMENT 'The award redemption tier type. Saver awards require fewer miles but have limited availability; standard and premium awards offer greater availability at higher mileage cost.. Valid values are `saver|standard|premium|anytime`',
    `blackout_date_flag` BOOLEAN COMMENT 'Indicates whether this travel date is designated as a blackout date for award redemptions. True means no award seats are available regardless of inventory.',
    `booking_window_close_days` STRING COMMENT 'The minimum number of days before departure that award bookings close. Typically 1-14 days depending on route and cabin.',
    `booking_window_open_days` STRING COMMENT 'The number of days in advance that award seats become available for booking. Standard is 330-365 days for most airlines.',
    `cancellation_fee_waived_flag` BOOLEAN COMMENT 'Indicates whether the standard award cancellation fee is waived for bookings in this inventory bucket. Often applies to elite members or promotional awards.',
    `change_fee_waived_flag` BOOLEAN COMMENT 'Indicates whether the standard award change fee is waived for bookings in this inventory bucket. Often applies to elite members or promotional awards.',
    `co_pay_amount` DECIMAL(18,2) COMMENT 'The mandatory cash co-payment amount required in addition to miles for award redemption. Zero if no co-pay is required.',
    `co_pay_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the co-payment amount. Null if no co-pay is required.. Valid values are `^[A-Z]{3}$`',
    `dynamic_pricing_enabled_flag` BOOLEAN COMMENT 'Indicates whether dynamic award pricing is enabled for this inventory, allowing mileage cost to vary based on demand and availability rather than fixed award chart rates.',
    `elite_only_flag` BOOLEAN COMMENT 'Indicates whether award seat availability is restricted to elite tier members only. Used for premium cabin inventory management.',
    `inventory_status` STRING COMMENT 'The current operational status of the award inventory. Open means available for booking; closed means no longer accepting reservations; suspended means temporarily unavailable; restricted means limited access.. Valid values are `open|closed|suspended|restricted`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this award inventory record was last modified. Critical for real-time availability synchronization across distribution channels.',
    `miles_required` STRING COMMENT 'The number of FFP miles required to redeem one award seat in this bucket and cabin class. Varies by route, cabin, and bucket type.',
    `partner_award_availability_flag` BOOLEAN COMMENT 'Indicates whether these award seats are available for redemption by partner FFP members under reciprocal agreements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this award inventory record was first created in the system. Used for audit trail and data lineage.',
    `seats_available` STRING COMMENT 'The current number of award seats available for immediate booking. Decremented upon award reservation confirmation.',
    `seats_held` STRING COMMENT 'The number of award seats currently held in pending or unconfirmed reservations. These seats are temporarily unavailable but not yet redeemed.',
    `seats_redeemed` STRING COMMENT 'The cumulative number of award seats that have been successfully redeemed and ticketed for this flight, cabin, and bucket.',
    `seats_waitlisted` STRING COMMENT 'The number of members currently on the waitlist for award seats on this flight and cabin when availability is zero.',
    `total_award_seats_allocated` STRING COMMENT 'The total number of seats allocated to the FFP award inventory pool for this flight, cabin, and bucket combination. Set by revenue management.',
    `travel_date` DATE COMMENT 'The scheduled departure date of the flight for which award inventory is allocated. Key dimension for award seat availability queries.',
    `upgrade_eligible_flag` BOOLEAN COMMENT 'Indicates whether these award seats are eligible for mileage upgrade from a lower cabin class. Relevant for upgrade award inventory management.',
    CONSTRAINT pk_award_inventory PRIMARY KEY(`award_inventory_id`)
) COMMENT 'Manages the availability of award seats allocated for FFP redemption across flights and cabin classes. Captures flight number, travel date, origin, destination, cabin class, award bucket code (saver/standard/premium), total award seats allocated, seats available, seats held, seats redeemed, blackout date flag, partner award availability flag, and last updated timestamp. Distinct from the revenue inventory domain — this is the loyalty-specific award seat pool managed by the FFP program.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ADD CONSTRAINT `fk_loyalty_ffp_member_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ADD CONSTRAINT `fk_loyalty_tier_qualification_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ADD CONSTRAINT `fk_loyalty_tier_qualification_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_partner_program_id` FOREIGN KEY (`partner_program_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_program`(`partner_program_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_partner_transaction_id` FOREIGN KEY (`partner_transaction_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_transaction`(`partner_transaction_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ADD CONSTRAINT `fk_loyalty_mileage_accrual_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_partner_program_id` FOREIGN KEY (`partner_program_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_program`(`partner_program_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ADD CONSTRAINT `fk_loyalty_mileage_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ADD CONSTRAINT `fk_loyalty_miles_balance_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_award_inventory_id` FOREIGN KEY (`award_inventory_id`) REFERENCES `airlines_ecm`.`loyalty`.`award_inventory`(`award_inventory_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_mileage_redemption_id` FOREIGN KEY (`mileage_redemption_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_redemption`(`mileage_redemption_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_partner_program_id` FOREIGN KEY (`partner_program_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_program`(`partner_program_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ADD CONSTRAINT `fk_loyalty_award_booking_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ADD CONSTRAINT `fk_loyalty_partner_transaction_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ADD CONSTRAINT `fk_loyalty_partner_transaction_original_transaction_partner_transaction_id` FOREIGN KEY (`original_transaction_partner_transaction_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_transaction`(`partner_transaction_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ADD CONSTRAINT `fk_loyalty_partner_transaction_partner_program_id` FOREIGN KEY (`partner_program_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_program`(`partner_program_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ADD CONSTRAINT `fk_loyalty_partner_transaction_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_partner_program_id` FOREIGN KEY (`partner_program_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_program`(`partner_program_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ADD CONSTRAINT `fk_loyalty_promotion_enrollment_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ADD CONSTRAINT `fk_loyalty_member_benefit_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ADD CONSTRAINT `fk_loyalty_member_benefit_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_award_booking_id` FOREIGN KEY (`award_booking_id`) REFERENCES `airlines_ecm`.`loyalty`.`award_booking`(`award_booking_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_mileage_redemption_id` FOREIGN KEY (`mileage_redemption_id`) REFERENCES `airlines_ecm`.`loyalty`.`mileage_redemption`(`mileage_redemption_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ADD CONSTRAINT `fk_loyalty_upgrade_request_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ADD CONSTRAINT `fk_loyalty_miles_transfer_ffp_member_id` FOREIGN KEY (`ffp_member_id`) REFERENCES `airlines_ecm`.`loyalty`.`ffp_member`(`ffp_member_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ADD CONSTRAINT `fk_loyalty_miles_transfer_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `airlines_ecm`.`loyalty`.`promotion`(`promotion_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_tier_status_id` FOREIGN KEY (`tier_status_id`) REFERENCES `airlines_ecm`.`loyalty`.`tier_status`(`tier_status_id`);
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ADD CONSTRAINT `fk_loyalty_award_inventory_partner_program_id` FOREIGN KEY (`partner_program_id`) REFERENCES `airlines_ecm`.`loyalty`.`partner_program`(`partner_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`loyalty` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `airlines_ecm`.`loyalty` SET TAGS ('dbx_domain' = 'loyalty');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` SET TAGS ('dbx_subdomain' = 'member_management');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Status Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `current_miles_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Miles Balance');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `email_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Consent Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `email_consent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `email_consent_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|airport|call_center|partner|inflight');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `ffp_number` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `ffp_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `ffp_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `ffp_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|X|U');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `home_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Home Airport Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `home_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `lifetime_miles_balance` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Miles Balance');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `lifetime_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Status Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `marketing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `meal_preference` SET TAGS ('dbx_business_glossary_term' = 'Meal Preference');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_first_name` SET TAGS ('dbx_business_glossary_term' = 'Member First Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_last_name` SET TAGS ('dbx_business_glossary_term' = 'Member Last Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Member Middle Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `member_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `preferred_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Preferred Cabin Class');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `preferred_cabin_class` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `preferred_seat_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Seat Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `preferred_seat_type` SET TAGS ('dbx_value_regex' = 'window|aisle|middle|no_preference');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `sms_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Consent Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `special_service_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Service Requests (SSR)');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `tier_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiration Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `tier_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `tier_qualifying_miles` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualifying Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `tier_qualifying_segments` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualifying Segments');
ALTER TABLE `airlines_ecm`.`loyalty`.`ffp_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` SET TAGS ('dbx_subdomain' = 'member_management');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Status Identifier (ID)');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `award_booking_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Award Booking Discount Percentage');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Tier Benefits Summary');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `bonus_mile_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Bonus Mile Multiplier');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiration Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `extra_baggage_allowance_kg` SET TAGS ('dbx_business_glossary_term' = 'Extra Baggage Allowance (Kilograms)');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `lifetime_status_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Status Eligible Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `lounge_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Lounge Access Entitlement Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `partner_tier_equivalent_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Airline Tier Equivalent Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `priority_baggage_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Baggage Handling Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `priority_boarding_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Boarding Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `priority_checkin_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Check-In Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `qualification_miles_threshold` SET TAGS ('dbx_business_glossary_term' = 'Qualification Miles Threshold');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `qualification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period Duration (Months)');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `qualification_segments_threshold` SET TAGS ('dbx_business_glossary_term' = 'Qualification Segments Threshold');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `qualification_spend_threshold` SET TAGS ('dbx_business_glossary_term' = 'Qualification Spend Threshold');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level Rank');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_status_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_status_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `tier_validity_months` SET TAGS ('dbx_business_glossary_term' = 'Tier Validity Period (Months)');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `upgrade_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligibility Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_status` ALTER COLUMN `waitlist_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Priority Rank');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` SET TAGS ('dbx_subdomain' = 'member_management');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Status Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `adjudication_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `challenge_activity_achieved` SET TAGS ('dbx_business_glossary_term' = 'Challenge Activity Achieved');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `challenge_activity_required` SET TAGS ('dbx_business_glossary_term' = 'Challenge Activity Required');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `challenge_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Challenge End Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `challenge_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Challenge Start Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `competing_airline_code` SET TAGS ('dbx_business_glossary_term' = 'Competing Airline Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `competing_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `competing_tier_held` SET TAGS ('dbx_business_glossary_term' = 'Competing Tier Held');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `extension_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Expiry Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `lifetime_miles_accumulated` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Miles Accumulated');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `match_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Status Match Approval Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `match_outcome` SET TAGS ('dbx_business_glossary_term' = 'Status Match Outcome');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `match_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|expired');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `proof_of_status_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Status Reference');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualification_source_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Qualification Source Breakdown');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'in_progress|qualified|not_qualified|extended|expired|revoked');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'standard_annual|status_match|tier_challenge|lifetime|promotional|courtesy');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualification_year` SET TAGS ('dbx_business_glossary_term' = 'Qualification Year');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualifying_miles_earned` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Miles (QM) Earned');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualifying_segments_earned` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Segments (QS) Earned');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualifying_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend (QSP) Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualifying_spend_currency` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend Currency');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `qualifying_spend_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `rollover_miles` SET TAGS ('dbx_business_glossary_term' = 'Rollover Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_achieved` SET TAGS ('dbx_business_glossary_term' = 'Tier Achieved');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_threshold_miles` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Qualifying Miles (QM)');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_threshold_segments` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Qualifying Segments (QS)');
ALTER TABLE `airlines_ecm`.`loyalty`.`tier_qualification` ALTER COLUMN `tier_threshold_spend` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Qualifying Spend (QSP)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` SET TAGS ('dbx_subdomain' = 'miles_activity');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `mileage_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Mileage Accrual ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `booking_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Item Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `partner_program_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `partner_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `e_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation E Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `accrual_source_type` SET TAGS ('dbx_business_glossary_term' = 'Accrual Source Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|expired|cancelled');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `adjustment_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'goodwill|retro_claim|error_correction|fraud_reversal|system_error|policy_exception');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `base_miles` SET TAGS ('dbx_business_glossary_term' = 'Base Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `elite_bonus_miles` SET TAGS ('dbx_business_glossary_term' = 'Elite Bonus Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `elite_bonus_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Elite Bonus Multiplier');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `miles_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Miles Expiry Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `pnr` SET TAGS ('dbx_business_glossary_term' = 'Passenger Name Record (PNR)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `pnr` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `pnr` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `pnr` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `promotional_bonus_miles` SET TAGS ('dbx_business_glossary_term' = 'Promotional Bonus Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `total_miles_credited` SET TAGS ('dbx_business_glossary_term' = 'Total Miles Credited');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_accrual` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` SET TAGS ('dbx_subdomain' = 'miles_activity');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `mileage_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Mileage Redemption ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `partner_program_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `award_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'Award Booking Reference');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `co_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `co_pay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `co_pay_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `miles_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Miles Discount Applied');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `miles_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Miles Redeemed');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `partner_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction Reference');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `processing_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `processing_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|airport_counter|partner_portal|kiosk');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_notes` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'requested|confirmed|ticketed|cancelled|refunded|expired');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Transaction Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `refund_miles` SET TAGS ('dbx_business_glossary_term' = 'Refund Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_recipient_ffp_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Recipient Frequent Flyer Program (FFP) Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_recipient_ffp_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_recipient_ffp_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`mileage_redemption` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'gift|family_pool|purchase|none');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` SET TAGS ('dbx_subdomain' = 'miles_activity');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `miles_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Miles Balance ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `account_inception_date` SET TAGS ('dbx_business_glossary_term' = 'Account Inception Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `balance_as_of_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `balance_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Balance Calculation Method');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `balance_calculation_method` SET TAGS ('dbx_value_regex' = 'REAL_TIME|BATCH|RECONCILED|ESTIMATED');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `balance_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|suspended|frozen|closed');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `balance_version_number` SET TAGS ('dbx_business_glossary_term' = 'Balance Version Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `bonus_miles_balance` SET TAGS ('dbx_business_glossary_term' = 'Bonus Miles Balance');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `elite_bonus_miles_ytd` SET TAGS ('dbx_business_glossary_term' = 'Elite Bonus Miles Year-to-Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `is_lifetime_status_qualified` SET TAGS ('dbx_business_glossary_term' = 'Is Lifetime Status Qualified Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `last_accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accrual Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `last_redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Redemption Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `lifetime_miles_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Miles Earned');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `lifetime_miles_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Miles Redeemed');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `member_number` SET TAGS ('dbx_business_glossary_term' = 'FFP (Frequent Flyer Program) Member Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `member_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `miles_expiring_180_days` SET TAGS ('dbx_business_glossary_term' = 'Miles Expiring in 180 Days');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `miles_expiring_90_days` SET TAGS ('dbx_business_glossary_term' = 'Miles Expiring in 90 Days');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `next_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Expiration Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `on_hold_miles` SET TAGS ('dbx_business_glossary_term' = 'On-Hold Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `partner_miles_balance` SET TAGS ('dbx_business_glossary_term' = 'Partner Miles Balance');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `pending_miles` SET TAGS ('dbx_business_glossary_term' = 'Pending Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `qualification_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Year End Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `qualification_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Year Start Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `qualifying_miles_ytd` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Miles (QM) Year-to-Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `qualifying_segments_ytd` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Segments (QS) Year-to-Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `qualifying_spend_currency` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `qualifying_spend_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `qualifying_spend_ytd` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend (QSP) Year-to-Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `redeemable_miles` SET TAGS ('dbx_business_glossary_term' = 'Redeemable Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ORACLE_LOYALTY|LEGACY_FFP|PARTNER_FEED|MANUAL_ADJ');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_balance` ALTER COLUMN `total_miles_balance` SET TAGS ('dbx_business_glossary_term' = 'Total Miles Balance');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` SET TAGS ('dbx_subdomain' = 'award_inventory');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `award_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Award Booking ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `award_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Award Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `interline_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Billing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `mileage_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Mileage Redemption Transaction ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `partner_program_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Pnr Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `award_type` SET TAGS ('dbx_value_regex' = 'saver|standard|upgrade|companion|mixed_cabin|partner');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `booking_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|airport_counter|partner_portal|gds');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Award Booking Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'confirmed|waitlisted|ticketed|cancelled|expired|pending');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Award Booking Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'member_request|schedule_change|irop|fraud|system_timeout|payment_failure');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `copay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `copay_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `is_partner_award` SET TAGS ('dbx_business_glossary_term' = 'Is Partner Award Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `is_round_trip` SET TAGS ('dbx_business_glossary_term' = 'Is Round Trip Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Carrier Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `marketing_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `number_of_passengers` SET TAGS ('dbx_business_glossary_term' = 'Number of Passengers');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `number_of_segments` SET TAGS ('dbx_business_glossary_term' = 'Number of Segments');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Carrier Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `operating_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `refund_fee_miles` SET TAGS ('dbx_business_glossary_term' = 'Refund Fee Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `refund_miles_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Miles Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ticketing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Deadline');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ticketing_status` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ticketing_status` SET TAGS ('dbx_value_regex' = 'not_ticketed|ticketed|voided|refunded|exchanged');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `ticketing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ticketing Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `total_miles_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Total Miles Redeemed');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `waitlist_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_booking` ALTER COLUMN `waitlist_status` SET TAGS ('dbx_value_regex' = 'not_waitlisted|waitlisted|confirmed_from_waitlist|waitlist_expired');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` SET TAGS ('dbx_subdomain' = 'partner_promotions');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_program_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `accrual_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Accrual Delay Days');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|draft|renewal');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `auto_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Enrollment Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `bonus_mile_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Mile Eligibility Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `burn_rate` SET TAGS ('dbx_business_glossary_term' = 'Burn Rate');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `burn_unit` SET TAGS ('dbx_business_glossary_term' = 'Burn Unit');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Earn Rate');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `earn_unit` SET TAGS ('dbx_business_glossary_term' = 'Earn Unit');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `maximum_earn_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Earn Per Transaction');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `minimum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Email');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Phone');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_country_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Country Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_program_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Partner Tax ID (Identification)');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `partner_website_url` SET TAGS ('dbx_business_glossary_term' = 'Partner Website URL (Uniform Resource Locator)');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `redemption_blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Redemption Blackout Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_program` ALTER COLUMN `tier_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Recognition Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` SET TAGS ('dbx_subdomain' = 'partner_promotions');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `original_transaction_partner_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_program_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `base_miles_awarded` SET TAGS ('dbx_business_glossary_term' = 'Base Miles Awarded');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `bonus_miles_awarded` SET TAGS ('dbx_business_glossary_term' = 'Bonus Miles Awarded');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `earn_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Earn Rate Multiplier');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Miles Expiration Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `member_tier_at_transaction` SET TAGS ('dbx_business_glossary_term' = 'Member Tier at Transaction');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_category` SET TAGS ('dbx_business_glossary_term' = 'Partner Category');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_category` SET TAGS ('dbx_value_regex' = 'hotel|car_rental|credit_card|retail|dining|travel_services');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_location_city` SET TAGS ('dbx_business_glossary_term' = 'Partner Location City');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_location_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Location Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Location Country Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `partner_location_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Location Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'pending|posted|rejected|reversed|under_review');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|partner_confirmed');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Partner Transaction Reference Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `source_system_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `total_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Miles');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`partner_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earn|burn|reversal|adjustment|bonus');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` SET TAGS ('dbx_subdomain' = 'partner_promotions');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `fare_family_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Family Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `bonus_miles_formula` SET TAGS ('dbx_business_glossary_term' = 'Bonus Miles Formula');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|in_app|website|all');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `eligible_member_tiers` SET TAGS ('dbx_business_glossary_term' = 'Eligible Member Tiers');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `eligible_partners` SET TAGS ('dbx_business_glossary_term' = 'Eligible Partners');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `external_promotion_code` SET TAGS ('dbx_business_glossary_term' = 'External Promotion ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `maximum_bonus_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bonus Cap');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `opt_in_count` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Count');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `opt_in_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Required Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Description');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Segment');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` SET TAGS ('dbx_subdomain' = 'partner_promotions');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `promotion_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Enrollment ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `partner_program_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `auto_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Enrolled Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `bonus_miles_earned` SET TAGS ('dbx_business_glossary_term' = 'Bonus Miles Earned');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `bonus_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Bonus Posting Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `bonus_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Bonus Posting Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `bonus_posting_status` SET TAGS ('dbx_value_regex' = 'pending|posted|failed|reversed|scheduled');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|email|call_center|airport_kiosk|partner_site');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^PROMO-[A-Z0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_source_campaign` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source Campaign');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `opt_in_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Consent Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `partner_promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Partner Promotion Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `promotion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualification_criteria_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Criteria Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualification_criteria_type` SET TAGS ('dbx_value_regex' = 'flight_count|segment_count|miles_flown|spend_amount|partner_activity|hybrid');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualification_current_value` SET TAGS ('dbx_business_glossary_term' = 'Qualification Current Value');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualification_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Deadline Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualification_percentage` SET TAGS ('dbx_business_glossary_term' = 'Qualification Percentage');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualification_target_value` SET TAGS ('dbx_business_glossary_term' = 'Qualification Target Value');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualification_unit` SET TAGS ('dbx_business_glossary_term' = 'Qualification Unit');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualified_date` SET TAGS ('dbx_business_glossary_term' = 'Qualified Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `qualifying_activities_count` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Activities Count');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `terms_version` SET TAGS ('dbx_business_glossary_term' = 'Terms Version');
ALTER TABLE `airlines_ecm`.`loyalty`.`promotion_enrollment` ALTER COLUMN `tier_bonus_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Tier Bonus Multiplier');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` SET TAGS ('dbx_subdomain' = 'member_management');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `member_benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Member Benefit ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Carrier Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Status ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `activation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Activation Trigger');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `activation_trigger` SET TAGS ('dbx_value_regex' = 'tier_qualification|manual_grant|promotion|lifetime_status|challenge_match');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Description');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Name');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Benefit Quantity');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_activation');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_terms` SET TAGS ('dbx_business_glossary_term' = 'Benefit Terms and Conditions');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_unit` SET TAGS ('dbx_business_glossary_term' = 'Benefit Unit');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Validity End Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `benefit_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Validity Start Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `blackout_dates` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `cost_to_airline` SET TAGS ('dbx_business_glossary_term' = 'Cost to Airline');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `cost_to_airline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'airport|online|mobile_app|call_center|partner_location|automatic');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `tier_applicability` SET TAGS ('dbx_business_glossary_term' = 'Tier Applicability');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `tier_applicability` SET TAGS ('dbx_value_regex' = '^[A-Z0-9,]+$');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `airlines_ecm`.`loyalty`.`member_benefit` ALTER COLUMN `usage_history_summary` SET TAGS ('dbx_business_glossary_term' = 'Usage History Summary');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` SET TAGS ('dbx_subdomain' = 'member_management');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `upgrade_request_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Request ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `award_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Award Booking Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `booking_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Segment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Current Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `mileage_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Mileage Redemption Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `pnr_id` SET TAGS ('dbx_business_glossary_term' = 'Pnr Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `seat_map_id` SET TAGS ('dbx_business_glossary_term' = 'Seat Map Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Target Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `ticket_coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Ticket Coupon Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `upgrade_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Offer Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `upgrade_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Transaction Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `co_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `co_pay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `co_pay_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `companion_upgrade_flag` SET TAGS ('dbx_business_glossary_term' = 'Companion Upgrade Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_value_regex' = 'no_availability|insufficient_miles|ineligible_fare|cabin_full|operational_restriction|expired');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `fare_class_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `fare_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `miles_deducted` SET TAGS ('dbx_business_glossary_term' = 'Miles Deducted');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Request Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|airport_kiosk|gate|partner_portal');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Request Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'complimentary_elite|miles_based|co_pay|operational|revenue');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `requested_cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Requested Cabin Class');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `requested_cabin_class` SET TAGS ('dbx_value_regex' = 'premium_economy|business|first');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `seat_number_assigned` SET TAGS ('dbx_business_glossary_term' = 'Seat Number Assigned');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `seat_number_assigned` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}[A-K]{1}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `travel_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `upgrade_cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Cleared Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `upgrade_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Priority Score');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `upgrade_status` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`upgrade_request` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` SET TAGS ('dbx_subdomain' = 'miles_activity');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `miles_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Miles Transfer ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Frequent Flyer Program (FFP) Member ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `ffp_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Promotion Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `bonus_miles_awarded` SET TAGS ('dbx_business_glossary_term' = 'Bonus Miles Awarded');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `fee_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Fee Discount Applied');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `fraud_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `miles_transferred` SET TAGS ('dbx_business_glossary_term' = 'Miles Transferred');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|miles_deduction|bank_transfer|paypal|wallet');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `recipient_annual_receipt_consumed` SET TAGS ('dbx_business_glossary_term' = 'Recipient Annual Receipt Consumed');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `recipient_annual_receipt_limit` SET TAGS ('dbx_business_glossary_term' = 'Recipient Annual Receipt Limit');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `relationship_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Relationship Verified Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `sender_annual_transfer_consumed` SET TAGS ('dbx_business_glossary_term' = 'Sender Annual Transfer Consumed');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `sender_annual_transfer_limit` SET TAGS ('dbx_business_glossary_term' = 'Sender Annual Transfer Limit');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_channel` SET TAGS ('dbx_business_glossary_term' = 'Transfer Channel');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|partner_portal|kiosk');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Fee Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'pending|approved|completed|rejected|cancelled|reversed');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Transaction Number');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`miles_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'gift|family_pool|purchase|share|donation');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` SET TAGS ('dbx_subdomain' = 'award_inventory');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `award_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Award Inventory ID');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `cabin_class_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `cabin_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Cabin Configuration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `fare_class_bucket_id` SET TAGS ('dbx_business_glossary_term' = 'Fare Class Bucket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `flight_number_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Number Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `tier_status_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tier Status Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `partner_program_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Program Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `scheduled_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Flight Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `allocation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'revenue_management|partner_agreement|promotional|dynamic');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `award_bucket_type` SET TAGS ('dbx_business_glossary_term' = 'Award Bucket Type');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `award_bucket_type` SET TAGS ('dbx_value_regex' = 'saver|standard|premium|anytime');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `blackout_date_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Date Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `booking_window_close_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Close Days');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `booking_window_open_days` SET TAGS ('dbx_business_glossary_term' = 'Booking Window Open Days');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `cancellation_fee_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Fee Waived Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `change_fee_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Fee Waived Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `co_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Amount');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `co_pay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Currency Code');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `co_pay_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `dynamic_pricing_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Pricing Enabled Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `elite_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Elite Only Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|restricted');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `miles_required` SET TAGS ('dbx_business_glossary_term' = 'Miles Required');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `partner_award_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Partner Award Availability Flag');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `seats_available` SET TAGS ('dbx_business_glossary_term' = 'Seats Available');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `seats_held` SET TAGS ('dbx_business_glossary_term' = 'Seats Held');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `seats_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Seats Redeemed');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `seats_waitlisted` SET TAGS ('dbx_business_glossary_term' = 'Seats Waitlisted');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `total_award_seats_allocated` SET TAGS ('dbx_business_glossary_term' = 'Total Award Seats Allocated');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `travel_date` SET TAGS ('dbx_business_glossary_term' = 'Travel Date');
ALTER TABLE `airlines_ecm`.`loyalty`.`award_inventory` ALTER COLUMN `upgrade_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligible Flag');
