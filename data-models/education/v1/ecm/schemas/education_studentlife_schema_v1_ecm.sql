-- Schema for Domain: studentlife | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`studentlife` COMMENT 'Manages student affairs operations including campus housing assignments, dining services, health and counseling services, student organizations, campus events, conduct adjudication support, and co-curricular engagement tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` (
    `studentlife_housing_assignment_id` BIGINT COMMENT 'Unique identifier for the housing assignment record. Primary key for the housing assignment entity.',
    `account_hold_id` BIGINT COMMENT 'Foreign key linking to billing.account_hold. Business justification: Unpaid housing charges trigger account holds preventing future housing assignments and registration. Links housing assignment to billing hold for operational enforcement of payment requirements and ho',
    `dining_plan_id` BIGINT COMMENT 'Identifier of the meal plan associated with this housing assignment. Many residence halls require or include a meal plan. Links to the meal plan master record. Nullable if no meal plan is associated.',
    `employee_id` BIGINT COMMENT 'The user identifier of the housing staff member or system user who created or last modified this housing assignment. Used for audit and accountability purposes.',
    `enrollment_application_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_application. Business justification: Housing assignments are made to admitted students. Linking to the original application enables tracking the full enrollment funnel from application through housing placement, supports yield analysis b',
    `housing_application_id` BIGINT COMMENT 'Foreign key linking to studentlife.housing_application. Business justification: A housing assignment is the OUTCOME of a housing application. Business process: student submits housing_application (with preferences, roommate requests, special accommodations), then housing office p',
    `housing_contract_id` BIGINT COMMENT 'Identifier of the housing contract or agreement that governs this assignment. The contract specifies terms, conditions, fees, and policies. Links to the housing contract master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Housing operations are auxiliary enterprise cost centers in higher ed. Assignments generate room and board revenue that must be allocated to specific cost centers for budget management, variance analy',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Housing charges post to specific revenue ledger accounts for financial statement preparation. Direct link enables accurate revenue recognition, supports month-end close processes, and facilitates auxi',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student assigned to the residence hall room or bed space. Links to the student master record in the Student Information System (SIS).',
    `residence_hall_id` BIGINT COMMENT 'Identifier of the residence hall building where the student is assigned. Links to the residence hall master record.',
    `residence_room_id` BIGINT COMMENT 'Foreign key linking to studentlife.residence_room. Business justification: Housing assignments are to specific ROOMS within residence halls, not just halls. Currently housing_assignment has residence_hall_id (FK to hall) and room_number (STRING), but no FK to the residence_r',
    `roommate_group_id` BIGINT COMMENT 'Identifier of the roommate group or suite assignment that links multiple students sharing the same room or suite. Used to track roommate relationships and preferences. Nullable for single-occupancy assignments.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term or session for which this housing assignment is effective. Links to the term master record.',
    `previous_studentlife_housing_assignment_id` BIGINT COMMENT 'Self-referencing FK on studentlife_housing_assignment (previous_studentlife_housing_assignment_id)',
    `accommodation_notes` STRING COMMENT 'Confidential notes describing the nature of special accommodations provided for this assignment. May include details about accessibility features, medical equipment, or other modifications. Restricted access due to privacy considerations.',
    `assignment_action_code` STRING COMMENT 'Code indicating the administrative action or trigger that created or modified this housing assignment. Initial assignment is the first placement; room change is a student-initiated move; emergency relocation is due to facility issues; administrative move is staff-initiated; student request is a voluntary change; disciplinary action is due to conduct issues.. Valid values are `initial_assignment|room_change|emergency_relocation|administrative_move|student_request|disciplinary_action`',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'The date and time when this housing assignment record was first created in the system. Represents the initial assignment action.',
    `assignment_end_date` DATE COMMENT 'The date on which the housing assignment expires and the student is expected to vacate the assigned space. Typically aligns with the end of the academic term or a designated move-out date. Nullable for open-ended assignments.',
    `assignment_fee_amount` DECIMAL(18,2) COMMENT 'The total housing fee amount charged for this assignment for the specified term. Includes room charges and may include mandatory fees. Expressed in the institutions base currency (typically USD for U.S. institutions).',
    `assignment_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this housing assignment record was last modified or updated in the system. Tracks the most recent change to any field in the record.',
    `assignment_notes` STRING COMMENT 'Free-text notes or comments related to this housing assignment. May include special instructions, administrative notes, or other relevant information for housing staff.',
    `assignment_priority_code` STRING COMMENT 'Code indicating the priority level or method by which the student received this housing assignment. Priority assignments are for students with special status (e.g., returning residents, athletes); guaranteed assignments are contractually promised; waitlist assignments were initially on a waiting list; lottery assignments were allocated through a random selection process.. Valid values are `standard|priority|guaranteed|waitlist|lottery`',
    `assignment_start_date` DATE COMMENT 'The date on which the housing assignment becomes effective and the student is authorized to occupy the assigned space. Typically aligns with the start of the academic term or a designated move-in date.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the housing assignment. Pending indicates awaiting confirmation or payment; active indicates the student is currently assigned and occupying or authorized to occupy the space; cancelled indicates the assignment was revoked before occupancy; expired indicates the assignment term has ended; terminated indicates early termination; on hold indicates temporary suspension.. Valid values are `pending|active|cancelled|expired|terminated|on_hold`',
    `assignment_type` STRING COMMENT 'Classification of the housing assignment indicating the nature or purpose of the assignment. Standard assignments are regular student housing; medical accommodations are for students with documented health needs; resident assistant assignments are for student staff; overflow and temporary are for capacity management; guest assignments are for short-term visitors.. Valid values are `standard|medical_accommodation|resident_assistant|overflow|temporary|guest`',
    `cancellation_date` DATE COMMENT 'The date on which the housing assignment was cancelled or terminated. Null if the assignment has not been cancelled.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason for cancellation or termination of the housing assignment if the assignment status is cancelled or terminated. Student withdrawal indicates the student left the institution; financial hardship indicates inability to pay; disciplinary indicates conduct violations; medical indicates health reasons; transfer indicates move to another institution; administrative indicates institutional decision; student request indicates voluntary cancellation. [ENUM-REF-CANDIDATE: student_withdrawal|financial_hardship|disciplinary|medical|transfer|administrative|student_request — 7 candidates stripped; promote to reference product]',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the student physically checked into the assigned residence hall room and took occupancy. Recorded by housing staff during the move-in process. Null if the student has not yet checked in.',
    `check_out_timestamp` TIMESTAMP COMMENT 'The date and time when the student physically checked out of the assigned residence hall room and vacated the space. Recorded by housing staff during the move-out process. Null if the student has not yet checked out.',
    `damage_assessment_flag` BOOLEAN COMMENT 'Boolean indicator of whether a damage assessment was conducted for this assignment at check-out. True indicates assessment was completed; false indicates no assessment or assessment pending.',
    `damage_charge_amount` DECIMAL(18,2) COMMENT 'The total amount charged to the student for damages to the assigned room or furnishings beyond normal wear and tear. Assessed during check-out inspection. Zero if no damages were found. Expressed in the institutions base currency.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The refundable or non-refundable deposit amount required to secure this housing assignment. Typically collected at the time of assignment confirmation. Expressed in the institutions base currency.',
    `emergency_contact_name` STRING COMMENT 'The full name of the emergency contact person designated by the student for this housing assignment. Used by housing staff in case of emergencies or urgent situations.',
    `emergency_contact_phone` STRING COMMENT 'The primary phone number of the emergency contact person. Used by housing staff to reach the contact in case of emergencies.',
    `key_issued_date` DATE COMMENT 'The date on which the physical key or access card was issued to the student. Null if no key has been issued.',
    `key_issued_flag` BOOLEAN COMMENT 'Boolean indicator of whether a physical key or access card has been issued to the student for this assignment. True indicates key has been issued; false indicates key has not been issued or has been returned.',
    `key_returned_date` DATE COMMENT 'The date on which the student returned the physical key or access card at the end of the assignment. Null if the key has not been returned.',
    `occupancy_rate_code` STRING COMMENT 'Code indicating the intended occupancy level of the assigned room or space. Single is one student per room; double is two students; triple is three students; quad is four students; suite is a multi-room unit with shared common space.. Valid values are `single|double|triple|quad|suite`',
    `refund_amount` DECIMAL(18,2) COMMENT 'The amount refunded to the student upon cancellation or early termination of the housing assignment, calculated according to the institutions refund policy. Zero if no refund is due. Expressed in the institutions base currency.',
    `room_type_code` STRING COMMENT 'Code indicating the type or style of the assigned room. Standard is a traditional dormitory room; apartment includes kitchen facilities; suite has multiple bedrooms with shared living space; studio is a single-room unit; accessible is ADA-compliant; honors is for honors program students; wellness is substance-free; quiet is designated low-noise. [ENUM-REF-CANDIDATE: standard|apartment|suite|studio|accessible|honors|wellness|quiet — 8 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Code identifying the source system or module from which this housing assignment record originated. Typically the housing management module of the Student Information System (SIS) such as Ellucian Banner Housing or similar system.',
    `source_system_record_code` STRING COMMENT 'The unique identifier or primary key of this housing assignment record in the source operational system. Used for data lineage and reconciliation between the lakehouse and source systems.',
    `special_accommodation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this assignment includes special accommodations for the student due to documented medical, disability, or other needs. True indicates accommodations are in place; false indicates a standard assignment.',
    CONSTRAINT pk_studentlife_housing_assignment PRIMARY KEY(`studentlife_housing_assignment_id`)
) COMMENT 'Transactional record of a students assignment to a specific residence hall room or bed space for a given term or academic year. Captures assignment start and end dates, assignment type (standard, medical, RA, overflow), room and bed identifiers, assignment status (pending, active, cancelled, expired), check-in and check-out timestamps, meal plan linkage, roommate group reference, and the administrative action that triggered the assignment. Serves as the authoritative record for residential occupancy.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`housing_application` (
    `housing_application_id` BIGINT COMMENT 'Unique identifier for the housing application record. Primary key for the housing application entity.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term or semester for which the student is applying for housing (e.g., Fall 2024, Spring 2025).',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Housing application fees are non-refundable revenue that posts to specific ledger accounts. Link supports fee revenue tracking, reconciliation of application fee payments to general ledger, and ensure',
    `award_package_id` BIGINT COMMENT 'Foreign key linking to aid.award_package. Business justification: Housing applications reference financial aid packages for affordability verification and housing deposit waiver eligibility. This FK links housing_application to the aid award_package master, enabling',
    `employee_id` BIGINT COMMENT 'Identifier of the housing staff member who reviewed and processed the application.',
    `enrollment_application_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_application. Business justification: Housing applications are submitted by admitted students post-acceptance. Institutions track which admission application corresponds to each housing request for yield management, enrollment confirmatio',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Housing application fees and deposits are payments processed through billing system. Links application to payment transaction for payment verification, deposit refund processing, and financial reconci',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student submitting the housing application. Links to the student master record.',
    `quaternary_housing_roommate_preference_3_student_profile_id` BIGINT COMMENT 'Student ID of the third preferred roommate selected by the applicant for mutual roommate matching.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Housing application fees and deposits are financial transactions that post to student accounts. Billing office tracks payment status to determine application completion and deposit refund eligibility ',
    `tertiary_housing_roommate_preference_2_student_profile_id` BIGINT COMMENT 'Student ID of the second preferred roommate selected by the applicant for mutual roommate matching.',
    `superseded_housing_application_id` BIGINT COMMENT 'Self-referencing FK on housing_application (superseded_housing_application_id)',
    `accommodation_description` STRING COMMENT 'Detailed description of the special accommodations requested by the student, including accessibility needs, medical requirements, or other documented needs.',
    `accommodation_documentation_received_flag` BOOLEAN COMMENT 'Indicates whether required documentation supporting the accommodation request has been received from the student or disability services office.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the non-refundable housing application fee charged to the student.',
    `application_fee_payment_date` DATE COMMENT 'Date when the housing application fee payment was received and processed.',
    `application_fee_payment_status` STRING COMMENT 'Current payment status of the housing application fee indicating whether the fee has been paid, waived, or is still pending.. Valid values are `pending|paid|waived|refunded`',
    `application_notes` STRING COMMENT 'Free-text notes or comments entered by housing staff regarding the application review, special circumstances, or administrative actions.',
    `application_number` STRING COMMENT 'Externally visible unique application number assigned to the housing application for tracking and reference purposes. Format: HA followed by 8 digits.. Valid values are `^HA[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the housing application indicating its position in the review and assignment workflow. [ENUM-REF-CANDIDATE: submitted|under_review|approved|assigned|waitlisted|cancelled|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `building_preference_1` STRING COMMENT 'Name or code of the students first-choice residence hall or housing facility.',
    `building_preference_2` STRING COMMENT 'Name or code of the students second-choice residence hall or housing facility.',
    `building_preference_3` STRING COMMENT 'Name or code of the students third-choice residence hall or housing facility.',
    `cancellation_reason` STRING COMMENT 'Reason provided for cancelling or withdrawing the housing application (e.g., student withdrew from university, found off-campus housing, financial reasons).',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the housing application was cancelled or withdrawn by the student or housing office.',
    `contract_end_date` DATE COMMENT 'Effective end date of the housing contract period for which the student is applying.',
    `contract_start_date` DATE COMMENT 'Effective start date of the housing contract period for which the student is applying.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the housing application record was first created in the system.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the refundable or partially refundable housing deposit required to secure the housing assignment.',
    `deposit_payment_date` DATE COMMENT 'Date when the housing deposit payment was received and processed.',
    `deposit_payment_status` STRING COMMENT 'Current payment status of the housing deposit indicating whether the deposit has been paid, waived, refunded, or forfeited.. Valid values are `pending|paid|waived|refunded|forfeited`',
    `early_arrival_reason` STRING COMMENT 'Reason or justification for the early arrival request (e.g., athletic team reporting, orientation leader training, international student acclimation).. Valid values are `athletics|orientation_leader|international_student|academic_program|other`',
    `early_arrival_requested_flag` BOOLEAN COMMENT 'Indicates whether the student has requested permission to move in before the standard move-in date (e.g., for athletics, orientation leaders, international students).',
    `emergency_contact_name` STRING COMMENT 'Full name of the primary emergency contact person for the student while residing in campus housing.',
    `emergency_contact_phone` STRING COMMENT 'Primary phone number of the emergency contact person for the student.. Valid values are `^+?[0-9]{10,15}$`',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact person to the student (e.g., parent, guardian, spouse, sibling). [ENUM-REF-CANDIDATE: parent|guardian|spouse|sibling|other_family|friend|other — 7 candidates stripped; promote to reference product]',
    `expected_arrival_date` DATE COMMENT 'Date when the student expects to arrive on campus and move into housing, if different from the standard move-in date.',
    `gender_inclusive_housing_flag` BOOLEAN COMMENT 'Indicates whether the student has opted into gender-inclusive housing where students of different genders may share a room or suite.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the housing application record was last updated or modified.',
    `late_arrival_expected_flag` BOOLEAN COMMENT 'Indicates whether the student expects to arrive after the standard move-in date due to travel, academic, or personal reasons.',
    `lifestyle_preference` STRING COMMENT 'Living-learning community or lifestyle environment preference selected by the student (e.g., quiet study floors, substance-free housing, wellness community). [ENUM-REF-CANDIDATE: quiet_study|social|substance_free|wellness|honors|international|STEM — 7 candidates stripped; promote to reference product]',
    `lottery_number` STRING COMMENT 'Randomly assigned number used to determine housing assignment priority within the same priority group when demand exceeds capacity.',
    `meal_plan_preference` STRING COMMENT 'Preferred dining meal plan option selected by the student as part of the housing application.. Valid values are `unlimited|14_meals|10_meals|5_meals|commuter|none`',
    `parking_permit_requested_flag` BOOLEAN COMMENT 'Indicates whether the student has requested a parking permit as part of the housing application process.',
    `priority_group` STRING COMMENT 'Classification of the applicant into priority categories that determine housing assignment order and eligibility for specific housing types. [ENUM-REF-CANDIDATE: freshman_required|returning_student|transfer_student|graduate_student|international_student|athlete|honors_program — 7 candidates stripped; promote to reference product]',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the housing application was reviewed by housing staff.',
    `room_type_preference` STRING COMMENT 'Primary room configuration preference selected by the student (single occupancy, double, triple, quad, suite-style, or apartment-style).. Valid values are `single|double|triple|quad|suite|apartment`',
    `special_accommodation_requested_flag` BOOLEAN COMMENT 'Indicates whether the student has requested special accommodations due to disability, medical condition, or other documented need.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the student submitted the housing application. Used for priority ordering and deadline enforcement.',
    CONSTRAINT pk_housing_application PRIMARY KEY(`housing_application_id`)
) COMMENT 'Master record for a students formal application for on-campus housing for a specific term or academic year. Captures application submission date, application status (submitted, under review, assigned, waitlisted, cancelled), housing preference selections (room type, building preference, single/double/triple, gender-inclusive), special accommodation requests, roommate preference entries, application fee payment status, priority group (freshman required, returning, graduate), and lottery number assignment. Distinct from the assignment record which is created after placement.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`residence_hall` (
    `residence_hall_id` BIGINT COMMENT 'Unique identifier for the on-campus residential facility. Primary key for the residence hall master record.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Residence halls are buildings in the facility inventory. Required for work order management, capital project planning, facility condition assessments, ADA compliance tracking, energy reporting, and sp',
    `parent_residence_hall_id` BIGINT COMMENT 'Self-referencing FK on residence_hall (parent_residence_hall_id)',
    `ada_room_count` STRING COMMENT 'Number of rooms in the residence hall that are specifically designed and equipped to meet ADA accessibility requirements (wider doorways, roll-in showers, accessible fixtures). Null or zero if no ADA rooms available.',
    `building_nickname` STRING COMMENT 'Informal or commonly used name for the residence hall by students and campus community (e.g., The Towers, Old Dorm). May be null if no nickname exists.',
    `campus_location` STRING COMMENT 'Geographic area or zone of the campus where the residence hall is located. Used for housing assignment preferences and proximity planning to academic buildings.. Valid values are `main_campus|north_campus|south_campus|east_campus|west_campus|satellite_campus`',
    `effective_date` DATE COMMENT 'Date when this residence hall record became effective or when the hall was first opened for student occupancy. Used for historical tracking and reporting.',
    `end_date` DATE COMMENT 'Date when this residence hall record was terminated or when the hall was permanently closed. Null for currently active halls. Used for historical tracking and decommissioning records.',
    `fire_safety_system_type` STRING COMMENT 'Type of fire safety system installed in the residence hall. Sprinkler = automatic sprinkler system; Alarm-only = fire alarm and detection only; Sprinkler-and-alarm = both systems; None = no automated fire safety system (rare, legacy buildings only).. Valid values are `sprinkler|alarm_only|sprinkler_and_alarm|none`',
    `floor_count` STRING COMMENT 'Total number of floors in the residence hall building, including ground floor. Used for facilities planning and emergency response planning.',
    `gender_designation` STRING COMMENT 'Gender assignment policy for the residence hall. All-gender = open to all gender identities; Women-only/Men-only = single-gender facility; Mixed-by-floor = different floors designated for different genders; Mixed-by-wing = different wings/sections designated for different genders.. Valid values are `all_gender|women_only|men_only|mixed_by_floor|mixed_by_wing`',
    `hall_type` STRING COMMENT 'Classification of the residence hall based on room configuration and living arrangement. Traditional = corridor-style with shared bathrooms; Suite-style = multiple bedrooms sharing common area and bathroom; Apartment = full kitchen and living space; LLC (Living Learning Community) = thematic residential program; Honors = designated for honors college students; Graduate = for graduate students; Family = for married/family housing. [ENUM-REF-CANDIDATE: traditional|suite_style|apartment|llc|honors|graduate|family — 7 candidates stripped; promote to reference product]',
    `has_24hr_desk_staff` BOOLEAN COMMENT 'Indicates whether the residence hall has a staffed front desk or reception area operating 24 hours per day. True = 24-hour staffing; False = limited hours or no desk staff.',
    `has_air_conditioning` BOOLEAN COMMENT 'Indicates whether the residence hall has air conditioning in residential rooms. True = air conditioned; False = no air conditioning. Important for student housing preferences and summer session planning.',
    `has_computer_lab` BOOLEAN COMMENT 'Indicates whether the residence hall has a computer lab with workstations available to residents. True = computer lab available; False = no computer lab.',
    `has_dining_hall` BOOLEAN COMMENT 'Indicates whether the residence hall has an on-site dining hall or cafeteria within the building. True = dining hall in building; False = no on-site dining.',
    `has_elevator` BOOLEAN COMMENT 'Indicates whether the residence hall is equipped with elevator access. True = elevator available; False = stairs only. Critical for accessibility planning and move-in logistics.',
    `has_fitness_center` BOOLEAN COMMENT 'Indicates whether the residence hall has an on-site fitness center or exercise room available to residents. True = fitness facility available; False = no fitness center.',
    `has_kitchen_facility` BOOLEAN COMMENT 'Indicates whether the residence hall has shared kitchen facilities available to residents (excludes in-unit kitchens in apartment-style halls). True = communal kitchen available; False = no shared kitchen.',
    `has_laundry_facility` BOOLEAN COMMENT 'Indicates whether the residence hall has on-site laundry facilities (washers and dryers) available to residents. True = laundry available; False = no laundry facility.',
    `has_study_rooms` BOOLEAN COMMENT 'Indicates whether the residence hall has dedicated study rooms or quiet study spaces available to residents. True = study rooms available; False = no dedicated study spaces.',
    `housing_office_contact_name` STRING COMMENT 'Name of the primary housing office staff member or hall director responsible for this residence hall. Used for operational communications and student inquiries.',
    `housing_office_email` STRING COMMENT 'Primary email address for the housing office or hall director responsible for this residence hall. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `housing_office_phone` STRING COMMENT 'Primary phone number for the housing office or hall director responsible for this residence hall. Classified as confidential organizational contact data.',
    `is_ada_accessible` BOOLEAN COMMENT 'Indicates whether the residence hall meets ADA accessibility standards and has accessible rooms available for students with disabilities. True = ADA compliant with accessible units; False = not fully accessible.',
    `occupancy_term_pattern` STRING COMMENT 'Standard term pattern for which the residence hall is available for student occupancy. Academic-year = fall and spring only; Year-round = all terms including summer; Fall-spring-only = closed in summer; Summer-only = only open for summer sessions.. Valid values are `academic_year|year_round|fall_spring_only|summer_only`',
    `operational_status` STRING COMMENT 'Current operational state of the residence hall. Open = actively housing students; Closed = temporarily not in use; Under-renovation = closed for capital improvements; Seasonal = only open certain terms (e.g., summer-only); Decommissioned = permanently closed and no longer used for housing.. Valid values are `open|closed|under_renovation|seasonal|decommissioned`',
    `parking_availability` STRING COMMENT 'Assessment of parking availability near the residence hall for resident students. None = no parking; Limited = very few spaces; Adequate = sufficient for most residents; Ample = abundant parking.. Valid values are `none|limited|adequate|ample`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this residence hall record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this residence hall record was last modified in the system. Used for audit trail and change tracking.',
    `resident_assistant_count` STRING COMMENT 'Number of Resident Assistants (RAs) or peer staff members assigned to the residence hall. Used for staffing planning and student support ratio calculations.',
    `security_access_type` STRING COMMENT 'Method of building access control for the residence hall. Card-access = electronic card reader system; Key-access = traditional physical keys; Biometric = fingerprint or facial recognition; Open-access = no controlled entry (rare).. Valid values are `card_access|key_access|biometric|open_access`',
    `total_bed_capacity` STRING COMMENT 'Maximum number of students that can be housed in the residence hall when fully occupied. Used for enrollment planning and housing assignment capacity management.',
    `total_room_count` STRING COMMENT 'Total number of assignable residential rooms in the building, including singles, doubles, triples, and suites. Excludes common areas and staff apartments.',
    CONSTRAINT pk_residence_hall PRIMARY KEY(`residence_hall_id`)
) COMMENT 'Master record for each on-campus residential facility managed by student housing. Captures building code, building name, campus location, hall type (traditional, suite-style, apartment, LLC — Living Learning Community), total bed capacity, gender designation (all-gender, women-only, men-only, mixed), construction year, renovation year, amenity flags (laundry, kitchen, study rooms, elevator, ADA accessible), housing office contact, and operational status (open, closed, under renovation). Complements facility.building with housing-specific operational attributes.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`residence_room` (
    `residence_room_id` BIGINT COMMENT 'Unique identifier for the residence room. Primary key for the residence room entity.',
    `llc_program_id` BIGINT COMMENT 'FK to studentlife.llc_program',
    `residence_hall_id` BIGINT COMMENT 'Foreign key reference to the residence hall that contains this room.',
    `connected_residence_room_id` BIGINT COMMENT 'Self-referencing FK on residence_room (connected_residence_room_id)',
    `ada_accessible` BOOLEAN COMMENT 'Indicates whether the room meets ADA accessibility requirements for students with physical disabilities (wheelchair access, accessible bathroom, etc.).',
    `ada_features` STRING COMMENT 'Detailed description of specific ADA accessibility features present in the room (e.g., roll-in shower, lowered counters, visual fire alarms, wider doorways).',
    `air_conditioning` BOOLEAN COMMENT 'Indicates whether the room has air conditioning. Important for student preferences and medical accommodations.',
    `available_from_date` DATE COMMENT 'The date from which the room becomes available for occupancy in the current academic term.',
    `available_until_date` DATE COMMENT 'The date until which the room remains available for occupancy in the current academic term (typically end of semester or academic year).',
    `bathroom_type` STRING COMMENT 'Classification of bathroom facilities associated with the room (private in-room, shared between two rooms, suite bathroom, communal hall bathroom).. Valid values are `private|shared|suite|communal`',
    `bed_count` STRING COMMENT 'The total number of beds physically available in the room. Represents the physical capacity of the room.',
    `cable_tv_available` BOOLEAN COMMENT 'Indicates whether cable television service is available in the room.',
    `closet_count` STRING COMMENT 'Number of closets or wardrobe units available in the room for student storage.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this room record was first created in the system.',
    `current_occupancy_count` STRING COMMENT 'The current number of students actively assigned to and occupying this room.',
    `floor_number` STRING COMMENT 'The floor level on which the room is located within the residence hall. Ground floor is typically 1, basement may be 0 or negative.',
    `furnished` BOOLEAN COMMENT 'Indicates whether the room comes furnished with standard university furniture (bed, desk, chair, dresser).',
    `furniture_description` STRING COMMENT 'Detailed description of furniture items included in the room (e.g., twin XL bed, desk with hutch, rolling chair, 4-drawer dresser).',
    `gender_designation` STRING COMMENT 'The gender designation policy for room assignment (male, female, gender_inclusive, gender_neutral). Used to enforce housing assignment policies.. Valid values are `male|female|gender_inclusive|gender_neutral`',
    `internet_access_type` STRING COMMENT 'Type of internet connectivity available in the room (wired ethernet, wireless WiFi, both, or none).. Valid values are `wired|wireless|both|none`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this room record is currently active in the housing inventory. Inactive rooms are no longer available for assignment.',
    `is_honors_housing` BOOLEAN COMMENT 'Flag indicating whether this room is part of honors housing reserved for students in the honors program.',
    `is_llc_room` BOOLEAN COMMENT 'Flag indicating whether this room is part of a Living Learning Community (LLC) or themed housing program.',
    `is_medical_accommodation` BOOLEAN COMMENT 'Flag indicating whether this room is designated for students requiring medical accommodations (e.g., air conditioning for medical conditions, proximity to elevators, single room for health reasons).',
    `is_quiet_floor` BOOLEAN COMMENT 'Flag indicating whether this room is located on a designated quiet floor with enhanced noise restrictions.',
    `is_ra_room` BOOLEAN COMMENT 'Flag indicating whether this room is designated for a Resident Assistant (RA) or other student staff member.',
    `is_substance_free` BOOLEAN COMMENT 'Flag indicating whether this room is part of substance-free housing where residents commit to abstaining from alcohol and drugs.',
    `kitchen_type` STRING COMMENT 'Type of kitchen facilities available to room occupants (none, kitchenette, full kitchen, shared floor kitchen).. Valid values are `none|kitchenette|full_kitchen|shared_floor`',
    `last_renovation_date` DATE COMMENT 'The date when the room last underwent renovation or significant refurbishment. Used for maintenance planning and quality assessment.',
    `maximum_occupancy` STRING COMMENT 'The maximum number of students that can be assigned to this room according to housing policy and fire code regulations.',
    `notes` STRING COMMENT 'Additional notes or comments about the room, including special features, restrictions, or maintenance issues.',
    `occupancy_status` STRING COMMENT 'Current occupancy state relative to capacity (vacant, partial, full, overbooked). Distinct from room_status which indicates operational availability.. Valid values are `vacant|partial|full|overbooked`',
    `room_number` STRING COMMENT 'The official room number or identifier within the residence hall (e.g., 201, 3A, Suite 405). This is the human-readable identifier used for room assignments and communications.',
    `room_rate_amount` DECIMAL(18,2) COMMENT 'The standard housing rate charged per semester or academic year for this room. Used for billing and financial planning.',
    `room_rate_period` STRING COMMENT 'The billing period for the room rate (semester, academic year, monthly, annual).. Valid values are `semester|academic_year|monthly|annual`',
    `room_status` STRING COMMENT 'Current operational status of the room indicating its availability for assignment (available, occupied, offline, reserved, maintenance, renovation).. Valid values are `available|occupied|offline|reserved|maintenance|renovation`',
    `room_type` STRING COMMENT 'Classification of the room based on its configuration and intended occupancy structure (single, double, triple, quad, suite, studio, apartment, efficiency). [ENUM-REF-CANDIDATE: single|double|triple|quad|suite|studio|apartment|efficiency — 8 candidates stripped; promote to reference product]',
    `square_footage` DECIMAL(18,2) COMMENT 'The total floor area of the room measured in square feet. Used for space planning and occupancy standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this room record was last modified in the system.',
    `view_description` STRING COMMENT 'Description of the view from the room windows (e.g., courtyard, campus quad, parking lot, city skyline). May influence student preferences.',
    `window_count` STRING COMMENT 'Number of windows in the room. Relevant for natural light, ventilation, and student preferences.',
    CONSTRAINT pk_residence_room PRIMARY KEY(`residence_room_id`)
) COMMENT 'Master record for each individual room or suite within a residence hall, representing the assignable unit of on-campus housing. Captures room number, floor, room type (single, double, triple, quad, suite, studio, apartment), bed count, square footage, ADA accessibility status, gender designation, occupancy status (available, occupied, offline, reserved), current occupancy count, maximum occupancy, and special designation flags (RA room, LLC room, medical accommodation room). Provides the inventory of assignable housing units.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`dining_plan` (
    `dining_plan_id` BIGINT COMMENT 'Unique identifier for the dining plan catalog record. Primary key for the dining plan reference entity.',
    `superseded_dining_plan_id` BIGINT COMMENT 'Self-referencing FK on dining_plan (superseded_dining_plan_id)',
    `academic_year` STRING COMMENT 'Academic year for which this dining plan catalog is effective, in format YYYY-YYYY (e.g., 2023-2024). Dining plans are typically versioned annually with pricing and structure changes.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `block_meal_count` STRING COMMENT 'Total number of meal swipes allocated for the entire term or academic year for block-based plans. Null for weekly and declining balance plans.',
    `carryover_limit` STRING COMMENT 'Maximum number of unused meals or maximum dollar amount of dining dollars that can roll over to the next term if rollover is allowed. Null if no rollover is permitted or if rollover is unlimited.',
    `created_date` DATE COMMENT 'Date when this dining plan catalog record was first created in the system. Used for audit trail and data lineage tracking.',
    `dietary_accommodation_notes` STRING COMMENT 'Notes on special dietary accommodations or allergen-friendly options available under this plan (e.g., vegetarian, vegan, gluten-free, kosher, halal stations available at all eligible locations). Used for accessibility and compliance documentation.',
    `dining_dollars_amount` DECIMAL(18,2) COMMENT 'Dollar value of flex dollars (also called dining dollars or declining balance) included with the plan per term. Used at retail dining locations, convenience stores, and cafes. Zero for meal-only plans.',
    `effective_end_date` DATE COMMENT 'Date when this dining plan expires and is no longer available for new enrollments or usage. Typically aligns with the end of the academic term or year.',
    `effective_start_date` DATE COMMENT 'Date when this dining plan becomes available for student selection and use. Typically aligns with the start of the academic term or year.',
    `eligible_dining_locations` STRING COMMENT 'Comma-separated list or description of dining hall names and retail locations where this plan can be used (e.g., Main Dining Hall, North Commons, Campus Cafe, Student Union Food Court). May reference all-access or restricted location sets.',
    `eligible_student_types` STRING COMMENT 'Description of student classifications eligible to purchase this plan (e.g., Residential students only, Commuters, Graduate students, All students). Used to control plan availability during registration.',
    `guest_swipes_included` STRING COMMENT 'Number of guest meal passes included with the plan per term, allowing the plan holder to bring guests to dining halls. Zero if no guest privileges are included.',
    `last_modified_date` DATE COMMENT 'Date when this dining plan catalog record was most recently updated. Tracks changes to pricing, structure, or availability.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this dining plan is required for certain student populations (e.g., first-year students living on campus). True if mandatory, false if optional.',
    `mandatory_for_population` STRING COMMENT 'Description of the student population for whom this plan is mandatory (e.g., First-year residents, All on-campus students, Sophomore residents in traditional halls). Null if plan is not mandatory for any group.',
    `meal_equivalency_value` DECIMAL(18,2) COMMENT 'Dollar value assigned to one meal swipe when used at retail dining locations instead of all-you-care-to-eat dining halls. Allows students to use meal swipes as credit at cafes and food courts. Null if meal equivalency is not offered.',
    `meals_per_week` STRING COMMENT 'Number of meal swipes available per week for weekly-based plans. Null for block plans and declining balance plans.',
    `online_ordering_enabled_flag` BOOLEAN COMMENT 'Indicates whether this dining plan supports mobile app or web-based ordering for pickup or delivery at participating dining locations. True if online ordering is enabled, false otherwise.',
    `plan_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the dining plan in the catalog (e.g., UNL19, COM10, BLK150). Used for registration and billing system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `plan_description` STRING COMMENT 'Detailed description of the dining plan features, benefits, restrictions, and intended audience. Used for marketing materials, student portal displays, and advising resources.',
    `plan_name` STRING COMMENT 'Full descriptive name of the dining plan as displayed to students and families (e.g., Unlimited Meal Plan, 10 Meals Per Week Plus $200 Flex, Commuter Block 50).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the dining plan in the catalog: active (available for selection), inactive (temporarily unavailable), pending (scheduled for future activation), discontinued (no longer offered but historical records exist), archived (historical record only).. Valid values are `active|inactive|pending|discontinued|archived`',
    `plan_type` STRING COMMENT 'Classification of the dining plan structure: unlimited (unlimited swipes per week), block (fixed number of meals per term), declining_balance (dollar-based account), commuter (limited access for non-residents), hybrid (combination of meals and dollars), flex (flexible allocation).. Valid values are `unlimited|block|declining_balance|commuter|hybrid|flex`',
    `price_per_term` DECIMAL(18,2) COMMENT 'Cost of the dining plan for one academic term (semester or quarter) in US dollars. Used for student billing and financial aid Cost of Attendance (COA) calculations.',
    `price_per_year` DECIMAL(18,2) COMMENT 'Total annual cost of the dining plan for the full academic year in US dollars. Null if plan is only offered on a per-term basis.',
    `refund_policy` STRING COMMENT 'Description of the refund or cancellation policy for this dining plan, including deadlines, prorated refund schedules, and conditions for full or partial refunds (e.g., 100% refund before census date, prorated through week 4, no refund after week 4).',
    `rollover_allowed_flag` BOOLEAN COMMENT 'Indicates whether unused meals or dining dollars can roll over from one term to the next within the same academic year. True if rollover is permitted, false otherwise.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the dining plan charges are exempt from sales tax under state or local regulations. True if tax-exempt, false if taxable. Varies by jurisdiction and plan structure.',
    CONSTRAINT pk_dining_plan PRIMARY KEY(`dining_plan_id`)
) COMMENT 'Reference catalog record defining the meal plan options offered by the institutions dining services for a given academic year. Captures plan code, plan name, plan type (block, declining balance, unlimited, commuter), number of meals per week or block allotment, dining dollar (flex dollar) allocation, eligible dining locations, price per term, mandatory vs. optional designation by student population, and active status. Serves as the authoritative catalog of available dining plan offerings.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`dining_enrollment` (
    `dining_enrollment_id` BIGINT COMMENT 'Unique identifier for the dining enrollment record. Primary key for the dining enrollment entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dining services operate as self-supporting auxiliary enterprises with dedicated cost centers. Meal plan enrollments drive revenue allocation, cost recovery analysis, and budget performance tracking es',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Meal plan charges post to specific revenue ledger accounts for revenue recognition. Link enables accurate auxiliary enterprise financial reporting, supports revenue reconciliation processes, and facil',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: Meal plan costs are often included in payment plans alongside tuition and housing. Links dining enrollment to payment arrangement for installment billing of board charges and payment default tracking.',
    `dining_plan_id` BIGINT COMMENT 'Unique identifier of the specific meal plan selected by the student. References the meal plan catalog.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student enrolled in the dining plan. Links to the student master record.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Meal plan charges are billed to student accounts each term. Links dining enrollment to financial account for charge posting, payment tracking, refund processing, and financial aid disbursement coordin',
    `term_id` BIGINT COMMENT 'Unique identifier of the academic term for which the dining plan is active. Links to the academic calendar.',
    `changed_from_dining_enrollment_id` BIGINT COMMENT 'Self-referencing FK on dining_enrollment (changed_from_dining_enrollment_id)',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the meal plan is set to automatically renew for the next term. Used for enrollment forecasting and student communication.',
    `billing_status` STRING COMMENT 'Current status of the billing transaction for this dining enrollment. Tracks whether charges have been posted, paid, or adjusted.. Valid values are `pending|billed|paid|refunded|waived`',
    `billing_trigger_date` DATE COMMENT 'Date when the dining plan charge should be posted to the student billing system. Used for integration with student accounts and financial aid disbursement timing.',
    `cancellation_date` DATE COMMENT 'Date when the dining enrollment was cancelled. Null if enrollment is still active or completed normally.',
    `cancellation_reason` STRING COMMENT 'Reason code for dining plan cancellation. Used for refund policy application and retention analysis. [ENUM-REF-CANDIDATE: withdrawal|housing_change|medical|financial|graduation|transfer|other — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dining enrollment record was first created in the system. Used for audit trail and data lineage.',
    `daily_meal_limit` STRING COMMENT 'Maximum number of meals allowed per day for plans with daily caps. Null for unlimited plans.',
    `dietary_restriction_flag` BOOLEAN COMMENT 'Indicates whether the student has documented dietary restrictions or allergies requiring special meal accommodations. Used for dining services planning and compliance.',
    `dietary_restriction_notes` STRING COMMENT 'Free-text description of specific dietary restrictions, allergies, or medical dietary requirements. Confidential information used by dining services staff.',
    `dining_dollar_balance` DECIMAL(18,2) COMMENT 'Current remaining balance of dining dollars available to the student. Applicable for declining balance and hybrid plans. Decrements with each transaction.',
    `effective_end_date` DATE COMMENT 'Date when the dining plan coverage ends. Marks the last day the student can use the meal plan benefits. Typically aligns with term end date.',
    `effective_start_date` DATE COMMENT 'Date when the dining plan coverage begins. Marks the first day the student can use the meal plan benefits.',
    `enrollment_date` DATE COMMENT 'Date when the student enrolled in the dining plan. Represents the business event date when the enrollment contract was established.',
    `enrollment_number` STRING COMMENT 'Human-readable business identifier for the dining enrollment. Externally visible reference number used in student communications and billing statements.. Valid values are `^DE[0-9]{10}$`',
    `enrollment_source` STRING COMMENT 'Channel or system through which the dining enrollment was created. Used for process analysis and system integration tracking.. Valid values are `online_portal|housing_application|manual_entry|bulk_import|mobile_app|administrative`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the dining enrollment. Indicates whether the enrollment is active, has been cancelled, is suspended, pending activation, completed for the term, or has been changed to a different plan.. Valid values are `active|cancelled|suspended|pending|completed|changed`',
    `exemption_reason` STRING COMMENT 'Documented reason for meal plan exemption request. Used for policy compliance and audit purposes.',
    `exemption_status` STRING COMMENT 'Status of any request for exemption from mandatory meal plan requirements. Tracks approval workflow for students seeking waivers.. Valid values are `none|approved|pending|denied`',
    `guest_meal_allowance` STRING COMMENT 'Total number of guest meals permitted under this meal plan for the enrollment period. Null if guest meals are not included in the plan.',
    `guest_meals_used` STRING COMMENT 'Number of guest meal privileges used by the student during the enrollment period. Tracks when students bring non-enrolled guests to dining facilities.',
    `housing_requirement_flag` BOOLEAN COMMENT 'Indicates whether the meal plan enrollment is mandatory due to on-campus housing requirements. Used for policy enforcement and exemption tracking.',
    `initial_dining_dollar_amount` DECIMAL(18,2) COMMENT 'Original dining dollar allocation at the start of the enrollment period. Used to calculate usage and remaining balance.',
    `initial_meal_count` STRING COMMENT 'Total number of meals allocated at enrollment for block meal plans. Used to track usage and calculate remaining meals.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dining enrollment record was last updated. Used for audit trail and change tracking.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent dining transaction (meal swipe or dining dollar purchase) under this enrollment. Used for activity monitoring and engagement analysis.',
    `meals_remaining` STRING COMMENT 'Number of meals remaining in the current enrollment period for block meal plans. Decrements with each meal swipe. Null for unlimited or declining balance plans.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the dining enrollment. Used by dining services staff for special circumstances or administrative annotations.',
    `plan_change_date` DATE COMMENT 'Date when the student changed from one meal plan to another during the term. Null if no plan change occurred.',
    `plan_change_reason` STRING COMMENT 'Reason code for why the student changed meal plans. Used for operational analysis and policy evaluation.. Valid values are `housing_change|dietary_needs|financial|usage_pattern|administrative|other`',
    `plan_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the meal plan for the enrollment period. Amount charged to the student account.',
    `plan_type` STRING COMMENT 'Category of meal plan structure. Unlimited allows unrestricted dining hall access; block provides a fixed number of meals per term; declining balance uses a dollar amount; commuter is designed for non-resident students; hybrid combines features; flex offers maximum flexibility.. Valid values are `unlimited|block|declining_balance|commuter|hybrid|flex`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Dollar amount refunded to the student upon cancellation or plan change. Calculated based on refund policy and usage.',
    `refund_processed_date` DATE COMMENT 'Date when the refund was processed and posted to the student account. Null if no refund was issued.',
    `rollover_balance_amount` DECIMAL(18,2) COMMENT 'Dining dollar balance carried over from the previous term, if permitted by plan rules. Null if no rollover is allowed or applicable.',
    `weekly_meal_limit` STRING COMMENT 'Maximum number of meals allowed per week for plans with weekly caps. Null for unlimited or term-block plans.',
    CONSTRAINT pk_dining_enrollment PRIMARY KEY(`dining_enrollment_id`)
) COMMENT 'Transactional record of a students enrollment in a specific dining/meal plan for a given term. Captures enrollment date, plan selected, term, enrollment status (active, cancelled, changed), dining dollar balance, meals remaining (for block plans), number of guest meals used, plan change history reference, and the billing trigger date for integration with the student billing domain. Tracks the students active dining contract for the term.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`dining_transaction` (
    `dining_transaction_id` BIGINT COMMENT 'Unique identifier for the dining transaction record. Primary key for the dining transaction entity.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term during which the transaction occurred. Links to the academic term master record. Used for term-based meal plan analysis and reporting.',
    `building_id` BIGINT COMMENT 'Identifier of the campus dining facility where the transaction occurred. Links to the dining facility master record.',
    `dining_enrollment_id` BIGINT COMMENT 'Foreign key linking to studentlife.dining_enrollment. Business justification: dining_transaction currently links to dining_plan (the plan definition) but not to dining_enrollment (the students active enrollment instance for a term). A transaction should link to the specific en',
    `dining_plan_id` BIGINT COMMENT 'Identifier of the meal plan associated with this transaction. Links to the students active meal plan at the time of transaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the dining services staff member who processed the transaction at the terminal. Used for operational accountability and training purposes. Null for self-service kiosk transactions.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Dining transactions occur at POS terminals tracked as IT assets. Real business process: POS device inventory management, maintenance scheduling, transaction reconciliation, and hardware lifecycle trac',
    `original_transaction_dining_transaction_id` BIGINT COMMENT 'Identifier of the original transaction that this refund transaction is reversing. Links to another dining transaction record. Null if this is not a refund transaction.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who performed the dining transaction. Links to the student master record.',
    `refund_transaction_id` BIGINT COMMENT 'Identifier of the refund transaction that reversed this original transaction. Links to another dining transaction record. Null if transaction has not been refunded.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Individual dining purchases (guest meals, à la carte items) may be charged to student accounts when declining balance is used. Enables financial reconciliation of dining transactions with student bill',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Individual dining transactions (cash sales, dining dollars) post to revenue accounts daily. Link supports point-of-sale revenue reconciliation, daily cash management, month-end close processes, and en',
    `reversal_dining_transaction_id` BIGINT COMMENT 'Self-referencing FK on dining_transaction (reversal_dining_transaction_id)',
    `authorization_code` STRING COMMENT 'Payment authorization code returned by the payment processor for credit card, debit card, or mobile payment transactions. Used for payment reconciliation and dispute resolution. Null for meal plan and cash transactions.. Valid values are `^[A-Z0-9]{0,20}$`',
    `balance_after` DECIMAL(18,2) COMMENT 'Students dining dollar or declining balance account balance in US dollars immediately after this transaction was processed. Provides audit trail for balance changes. Null for meal plan swipe transactions that do not use monetary balance.',
    `balance_before` DECIMAL(18,2) COMMENT 'Students dining dollar or declining balance account balance in US dollars immediately before this transaction was processed. Null for meal plan swipe transactions that do not use monetary balance.',
    `card_last_four` STRING COMMENT 'Last four digits of the credit or debit card used for the transaction. Stored for customer service and dispute resolution purposes. Null for non-card payment methods. Full card number is never stored per PCI compliance.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'Type of credit or debit card used for the transaction. Used for payment processing fee analysis and reconciliation. Null for non-card payment methods.. Valid values are `visa|mastercard|amex|discover|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction record was first created in the system. Audit field for data lineage and troubleshooting. May differ slightly from transaction_timestamp due to processing delays.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction. Typically USD for US-based institutions. Included for international campus locations or study abroad programs.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of discount applied to the transaction in US dollars. Zero if no discount applied. Used for promotional tracking and revenue reconciliation.',
    `discount_code` STRING COMMENT 'Promotional or employee discount code applied to the transaction. Used for special pricing programs, staff discounts, or promotional campaigns. Null if no discount applied.. Valid values are `^[A-Z0-9]{0,20}$`',
    `guest_count` STRING COMMENT 'Number of guest meals included in this transaction. Used when a student uses meal plan swipes or pays for guests. Zero for standard single-person transactions.',
    `is_refunded` BOOLEAN COMMENT 'Indicates whether this transaction has been refunded. True if a refund was issued, false otherwise. Used for financial reconciliation and customer service tracking.',
    `meal_period` STRING COMMENT 'Designated meal period during which the transaction occurred. Used for meal plan swipe validation and dining facility operational reporting. All-day applies to retail and grab-and-go locations without period restrictions.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `meals_decremented` STRING COMMENT 'Number of meal swipes deducted from the students meal plan balance as a result of this transaction. Typically 1 for standard meal swipe, 0 for non-meal-plan transactions, may be greater than 1 for guest meals charged to meal plan.',
    `meals_remaining` STRING COMMENT 'Number of meal swipes remaining on the students meal plan after this transaction was processed. Provides audit trail for meal plan consumption. Null for non-meal-plan transactions.',
    `notes` STRING COMMENT 'Additional notes or comments about the transaction. May include customer service notes, exception handling details, or operational remarks. Free-form text field.',
    `order_number` STRING COMMENT 'Order number for made-to-order or catering transactions. Used to track order fulfillment and customer pickup. Null for standard meal swipe and grab-and-go transactions.. Valid values are `^[A-Z0-9]{0,20}$`',
    `payment_method` STRING COMMENT 'Payment instrument used to complete the transaction. Meal plan uses prepaid meal swipes, dining dollars and declining balance use prepaid account funds, credit/debit card and cash are direct payment, mobile payment includes Apple Pay and Google Pay, campus card uses student ID card payment feature. [ENUM-REF-CANDIDATE: meal_plan|dining_dollars|declining_balance|credit_card|debit_card|cash|mobile_payment|campus_card — 8 candidates stripped; promote to reference product]',
    `special_instructions` STRING COMMENT 'Customer-provided special instructions or notes for the order. Applicable to made-to-order and catering transactions. May include dietary restrictions, preparation preferences, or delivery instructions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sales tax amount applied to the transaction in US dollars. Applicable to retail purchases and certain dining dollar transactions based on state and local tax regulations. May be zero for meal plan swipes.',
    `terminal_code` STRING COMMENT 'Identifier of the point-of-sale terminal or kiosk where the transaction was processed. Used for terminal reconciliation, troubleshooting, and location-specific analytics within a dining facility.. Valid values are `^[A-Z0-9]{4,15}$`',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added by the customer in US dollars. Applicable to catering orders and certain full-service dining locations. Zero for most standard dining hall transactions.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount charged or deducted for the transaction in US dollars, including base transaction amount, tax, and tip. Represents the final impact to the students account or payment method.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the transaction in US dollars. For meal swipes this may be zero or the equivalent meal value, for dining dollars and declining balance this is the amount deducted, for cash and card transactions this is the amount charged.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or receipt number generated at the point of sale. Used for customer service inquiries and reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `transaction_source` STRING COMMENT 'System or channel through which the transaction was initiated. POS terminal for in-person swipes, mobile app for mobile ordering, web portal for online catering orders, kiosk for self-service stations, catering system for event orders.. Valid values are `pos_terminal|mobile_app|web_portal|kiosk|catering_system`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the dining transaction. Completed indicates successful transaction, voided indicates cancelled before settlement, refunded indicates reversed after settlement, pending indicates authorization in progress, failed indicates declined or error.. Valid values are `completed|voided|refunded|pending|failed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the dining transaction was completed at the point of sale terminal. Represents the actual business event time of the meal swipe or purchase.',
    `transaction_type` STRING COMMENT 'Category of dining transaction indicating how the meal or purchase was processed. Meal swipe decrements meal plan count, dining dollar and declining balance deduct from prepaid balance, guest meal charges guest rate, catering applies to event orders, retail purchase covers convenience store items.. Valid values are `meal_swipe|dining_dollar|guest_meal|catering|retail_purchase|declining_balance`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this transaction record was last modified in the system. Audit field for tracking status changes, refunds, or corrections. Null if record has never been updated after creation.',
    CONSTRAINT pk_dining_transaction PRIMARY KEY(`dining_transaction_id`)
) COMMENT 'Transactional record of each individual dining swipe, declining balance purchase, or dining dollar redemption at a campus dining facility. Captures transaction timestamp, dining location, transaction type (meal swipe, dining dollar, guest meal, catering), amount charged or meals decremented, payment method (meal plan, dining dollars, cash, credit card), terminal ID, and resulting balance after transaction. Provides the detailed usage ledger for dining plan consumption and dining services revenue tracking.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`health_visit` (
    `health_visit_id` BIGINT COMMENT 'Unique identifier for the student health center or counseling center visit encounter record.',
    `health_appointment_id` BIGINT COMMENT 'Unique identifier of the scheduled appointment record associated with this visit, if applicable.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Health center visits occur in specific buildings. Required for facility cost allocation to student health services, ADA compliance verification, space utilization surveys, and room booking integration',
    `employee_id` BIGINT COMMENT 'Unique identifier of the healthcare provider or counselor who conducted the visit.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Student health centers operate as institutional cost centers requiring budget tracking and cost allocation. Visits drive staffing costs, supply expenses, and fee-for-service revenue when applicable. L',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Health visits require identity verification for HIPAA-compliant access to electronic health records and patient portals. Real business process: secure authentication for health information systems, au',
    `immunization_record_id` BIGINT COMMENT 'Foreign key linking to studentlife.immunization_record. Business justification: Health visits often verify, administer, or document immunizations. Student health centers track which visit resulted in immunization record creation or update. Enables integrated medical record keepin',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who received health or counseling services during this visit.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Student health services bill copays, visit charges, and lab fees to student accounts when not covered by insurance. Links health visit to billing account for charge posting and payment collection.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Health visit charges (copays, service fees) post to specific revenue accounts. Link supports healthcare revenue tracking, insurance billing reconciliation, and ensures proper revenue classification fo',
    `followup_health_visit_id` BIGINT COMMENT 'Self-referencing FK on health_visit (followup_health_visit_id)',
    `cancellation_reason` STRING COMMENT 'Documented reason for cancellation of the health visit by the student or provider.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the health visit was cancelled.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the student checked in or arrived for the health visit.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Date and time when the student checked out or departed after the health visit.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Copayment amount charged to the student for this health visit, in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this health visit record was first created in the system.',
    `diagnosis_code` STRING COMMENT 'Primary diagnosis code assigned during the visit, typically using ICD-10-CM or DSM-5 coding standards.',
    `diagnosis_description` STRING COMMENT 'Human-readable description of the primary diagnosis or clinical impression from the visit.',
    `ferpa_release_on_file_flag` BOOLEAN COMMENT 'Indicates whether a valid FERPA release is on file authorizing disclosure of health visit information to parents or other parties.',
    `follow_up_date` DATE COMMENT 'Recommended or scheduled date for the follow-up visit or appointment.',
    `follow_up_instructions` STRING COMMENT 'Clinical instructions or guidance provided to the student for follow-up care, self-care, or next steps.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up visit or appointment is required based on the clinical assessment.',
    `hipaa_consent_on_file_flag` BOOLEAN COMMENT 'Indicates whether a valid HIPAA consent form is on file for this student, authorizing the use and disclosure of protected health information.',
    `insurance_carrier` STRING COMMENT 'Name of the health insurance carrier or plan used for billing this visit.',
    `insurance_used_flag` BOOLEAN COMMENT 'Indicates whether the student used health insurance coverage for this visit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this health visit record was last updated or modified.',
    `no_show_reason` STRING COMMENT 'Documented reason or explanation for why the student did not attend a scheduled health visit.',
    `presenting_complaint` STRING COMMENT 'The primary reason for the visit as stated by the student or observed by the intake staff; chief complaint or presenting concern.',
    `provider_credential_type` STRING COMMENT 'Professional credential or license type of the provider (e.g., MD, DO, NP, PA, LCSW, PhD, PsyD, RN).',
    `provider_name` STRING COMMENT 'Full name of the healthcare provider, physician, nurse practitioner, or counselor who conducted the visit.',
    `reason_for_visit` STRING COMMENT 'Detailed description of the clinical or counseling reason for the student health visit, including symptoms or concerns.',
    `record_source_system` STRING COMMENT 'Name or identifier of the source system or electronic health record (EHR) system from which this visit record originated.',
    `referral_destination` STRING COMMENT 'Name or description of the provider, specialist, or facility to which the student was referred.',
    `referral_flag` BOOLEAN COMMENT 'Indicates whether the student was referred to another provider, specialist, or external facility as a result of this visit.',
    `referral_reason` STRING COMMENT 'Clinical or counseling reason for the referral to another provider or facility.',
    `soap_note_reference` STRING COMMENT 'Reference identifier or document link to the clinical SOAP note (Subjective, Objective, Assessment, Plan) created during the visit.',
    `telehealth_platform` STRING COMMENT 'Name or identifier of the telehealth platform or video conferencing system used if the visit was conducted remotely.',
    `visit_charge_amount` DECIMAL(18,2) COMMENT 'Total charge amount for the health visit before insurance adjustments, in US dollars.',
    `visit_date` DATE COMMENT 'The calendar date on which the student health or counseling visit occurred.',
    `visit_duration_minutes` STRING COMMENT 'Total duration of the health visit in minutes, from check-in to check-out.',
    `visit_notes` STRING COMMENT 'Additional clinical or administrative notes related to the health visit encounter.',
    `visit_number` STRING COMMENT 'Business identifier or encounter number assigned to this health visit for tracking and billing purposes.',
    `visit_status` STRING COMMENT 'Current lifecycle status of the health visit: scheduled, completed, no-show, cancelled, or in-progress.. Valid values are `scheduled|completed|no_show|cancelled|in_progress`',
    `visit_time` TIMESTAMP COMMENT 'The precise date and time when the student health or counseling visit began.',
    `visit_type` STRING COMMENT 'Classification of the health visit by service category: primary care, urgent care, immunization, counseling intake, follow-up, or telehealth.. Valid values are `primary_care|urgent_care|immunization|counseling_intake|follow_up|telehealth`',
    CONSTRAINT pk_health_visit PRIMARY KEY(`health_visit_id`)
) COMMENT 'Transactional record of a student visit to the campus student health center or counseling center. Captures visit date and time, visit type (primary care, urgent care, immunization, counseling intake, follow-up, telehealth), presenting complaint or reason for visit, provider name and credential type, visit status (scheduled, completed, no-show, cancelled), SOAP note reference, referral flag, referral destination, follow-up required flag, and HIPAA-compliant data handling indicators. Serves as the encounter record for campus health services.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`immunization_record` (
    `immunization_record_id` BIGINT COMMENT 'Unique identifier for the immunization record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the health services staff member who reviewed and verified this immunization record. Links to the staff or employee master record. Supports audit trail and accountability.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Immunization records are managed in specialized health compliance applications (Medicat, Point & Click, Epic). Real business process: integration with student health information systems for compliance',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student to whom this immunization record belongs. Links to the student master record in the Student Information System (SIS).',
    `booster_immunization_record_id` BIGINT COMMENT 'Self-referencing FK on immunization_record (booster_immunization_record_id)',
    `academic_term_code` STRING COMMENT 'The academic term code for which this immunization compliance status applies. Links to the term master record. Supports term-specific compliance tracking and hold enforcement.',
    `administration_date` DATE COMMENT 'The date on which the immunization was administered to the student. Critical for determining compliance status and expiration timelines.',
    `compliance_hold_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a registration or enrollment hold is active due to non-compliance with this immunization requirement. True indicates hold is active and student cannot register; false indicates no hold. Drives SIS (Student Information System) hold enforcement.',
    `compliance_status` STRING COMMENT 'The current compliance status of the student for this immunization requirement. Compliant indicates all requirements met; non-compliant indicates missing or incomplete immunization; exemption granted indicates approved waiver; pending verification indicates documentation submitted but not yet confirmed; expired indicates previously compliant but now past expiration date. Drives registration hold logic.. Valid values are `Compliant|Non-Compliant|Exemption Granted|Pending Verification|Expired`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this immunization record was first created in the system. Supports audit trail and data lineage tracking.',
    `document_reference_number` STRING COMMENT 'The reference number or identifier for the physical or digital immunization documentation stored in the student health record system. Enables retrieval of supporting documentation for audit or verification purposes.',
    `dose_sequence_number` STRING COMMENT 'The sequential dose number for multi-dose immunization series (e.g., 1 for first dose, 2 for second dose). Tracks completion progress for vaccines requiring multiple administrations.',
    `exemption_approval_date` DATE COMMENT 'The date on which the exemption was approved by the institution or authorized health personnel. Nullable if no exemption applies.',
    `exemption_documentation_on_file` BOOLEAN COMMENT 'Boolean flag indicating whether supporting documentation for the exemption (e.g., physician letter, religious affidavit) is on file with the institution. True indicates documentation is present; false indicates missing or not applicable.',
    `exemption_expiration_date` DATE COMMENT 'The date on which the exemption expires and requires renewal. Some exemptions (e.g., medical) may be temporary. Nullable for permanent exemptions or when no exemption applies.',
    `exemption_type` STRING COMMENT 'The type of exemption granted if the student is not required to receive the immunization. Medical exemptions are based on health contraindications; religious exemptions are based on sincerely held religious beliefs; philosophical exemptions are based on personal or moral beliefs (where permitted by state law). None indicates no exemption applies.. Valid values are `Medical|Religious|Philosophical|None`',
    `expiration_date` DATE COMMENT 'The date on which the immunization expires and requires renewal or booster. Used to trigger compliance alerts and registration holds. Nullable for immunizations with lifetime validity.',
    `hold_effective_date` DATE COMMENT 'The date on which the compliance hold was placed on the student account. Nullable if no hold is active.',
    `hold_release_date` DATE COMMENT 'The date on which the compliance hold was released after the student achieved compliance or received an exemption. Nullable if hold is still active or never placed.',
    `immunization_name` STRING COMMENT 'The specific name or brand of the vaccine administered (e.g., Pfizer-BioNTech COVID-19, Menactra, Gardasil). Provides detailed identification beyond the general type.',
    `immunization_type` STRING COMMENT 'The type of immunization administered or documented. Common types include MMR (Measles Mumps Rubella), meningococcal, hepatitis B, varicella (chickenpox), COVID-19, and influenza. Required for public health compliance and registration hold enforcement.. Valid values are `MMR|Meningococcal|Hepatitis B|Varicella|COVID-19|Influenza`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this immunization record is currently active. True indicates active; false indicates the record has been superseded, corrected, or voided. Supports record lifecycle management.',
    `is_required_for_enrollment` BOOLEAN COMMENT 'Boolean flag indicating whether this immunization is required for enrollment at the institution. True indicates mandatory; false indicates recommended but not required. Drives hold enforcement logic.',
    `is_required_for_housing` BOOLEAN COMMENT 'Boolean flag indicating whether this immunization is specifically required for students living in campus housing. True indicates mandatory for housing residents; false indicates not a housing-specific requirement. Some immunizations (e.g., meningococcal) may have housing-specific mandates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this immunization record was last modified. Supports audit trail and change tracking.',
    `lot_number` STRING COMMENT 'The manufacturer lot number of the vaccine administered. Critical for tracking in case of recalls or adverse event investigations.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the immunization record. May include special circumstances, follow-up requirements, or clarifications from health services staff.',
    `notification_method` STRING COMMENT 'The method by which the compliance notification was sent to the student. Email indicates electronic mail; portal message indicates student portal notification; mail indicates postal mail; SMS indicates text message; phone indicates voice call.. Valid values are `Email|Portal Message|Mail|SMS|Phone`',
    `notification_sent_date` DATE COMMENT 'The date on which the most recent compliance notification was sent to the student regarding this immunization requirement. Supports communication tracking and FERPA compliance.',
    `provider_location` STRING COMMENT 'The city and state or country where the immunization was administered. Supports verification and international student documentation.',
    `provider_name` STRING COMMENT 'The name of the healthcare provider, clinic, or facility that administered the immunization. Used for verification and audit purposes.',
    `review_timestamp` TIMESTAMP COMMENT 'The date and time when the immunization record was last reviewed by health services staff. Supports audit trail and compliance verification workflows.',
    `source_system` STRING COMMENT 'The name of the source system from which this immunization record originated (e.g., Ellucian Banner Student Health module, Medicat, state immunization registry). Supports data lineage and integration tracking.',
    `verification_date` DATE COMMENT 'The date on which the immunization record was verified by the institution or authorized health personnel. Distinct from administration date; tracks when the institution confirmed the record.',
    `verification_source` STRING COMMENT 'The source from which the immunization record was verified. Self-reported indicates student-provided documentation; provider-verified indicates confirmation from a healthcare provider; state registry indicates data pulled from state immunization information systems; school record indicates transfer from prior educational institution; military record indicates documentation from military service; international record indicates foreign healthcare documentation.. Valid values are `Self-Reported|Provider-Verified|State Registry|School Record|Military Record|International Record`',
    CONSTRAINT pk_immunization_record PRIMARY KEY(`immunization_record_id`)
) COMMENT 'Master record tracking a students immunization compliance status as required by the institution and applicable state public health regulations. Captures immunization type (MMR, meningococcal, hepatitis B, varicella, COVID-19, influenza, TB test), dose sequence number, administration date, expiration date, verification source (self-reported, provider-verified, state registry), compliance status (compliant, non-compliant, exemption granted), exemption type (medical, religious, philosophical), and compliance hold trigger flag. Supports public health compliance and registration hold enforcement.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`counseling_case` (
    `counseling_case_id` BIGINT COMMENT 'Unique identifier for the counseling case record. Primary key for the counseling case entity.',
    `term_id` BIGINT COMMENT 'Unique identifier of the academic term during which the counseling case was opened. Links to the academic term reference table.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Counseling sessions occur in buildings requiring space assignment validation, facility cost allocation to counseling services, and ADA accessibility verification. Supports indirect cost rate calculati',
    `employee_id` BIGINT COMMENT 'Unique identifier of the primary counselor assigned to this case. Links to the faculty or staff member providing therapeutic services.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Counseling cases require secure identity accounts for confidential mental health system access and telehealth platforms. Real business process: HIPAA-compliant authentication for counseling management',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student receiving counseling services. Links to the student master record.',
    `referred_from_counseling_case_id` BIGINT COMMENT 'Self-referencing FK on counseling_case (referred_from_counseling_case_id)',
    `cancellation_count` STRING COMMENT 'Number of scheduled appointments the student cancelled with advance notice. Used to track engagement patterns.',
    `case_close_date` DATE COMMENT 'Date when the counseling case was officially closed. Null for active cases.',
    `case_closure_reason` STRING COMMENT 'The reason why the counseling case was closed, such as treatment goals met, student request, referral to external provider, excessive no-shows, student graduation or withdrawal, or session limit reached. [ENUM-REF-CANDIDATE: goals_met|student_request|referred_out|no_show|graduated|withdrew|session_limit_reached|mutual_agreement|other — 9 candidates stripped; promote to reference product]',
    `case_notes_summary` STRING COMMENT 'High-level summary of the counseling case, including treatment goals, progress, and key clinical observations. Detailed session notes are stored separately in compliance with HIPAA and clinical documentation standards.',
    `case_number` STRING COMMENT 'Human-readable business identifier for the counseling case, typically formatted as CC-YYYYNNNN where YYYY is year and NNNN is sequential number.. Valid values are `^CC-[0-9]{8}$`',
    `case_open_date` DATE COMMENT 'Date when the counseling case was officially opened and the student was assigned to a counselor or placed on the waitlist.',
    `case_status` STRING COMMENT 'Current lifecycle status of the counseling case indicating whether the case is actively being treated, closed, referred to external provider, awaiting assignment, temporarily suspended, or pending initial intake.. Valid values are `active|closed|referred_out|on_waitlist|suspended|intake_pending`',
    `consent_to_contact_emergency` BOOLEAN COMMENT 'Boolean flag indicating whether the student has provided consent for the counseling center to contact their emergency contact in case of a mental health crisis or safety concern.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the counseling case record was first created in the system.',
    `crisis_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this case involved a mental health crisis requiring immediate intervention, such as suicidal ideation, self-harm, or severe psychological distress.',
    `external_referral_made` BOOLEAN COMMENT 'Boolean flag indicating whether the student was referred to an external mental health provider or community resource due to needs exceeding campus counseling center capacity or scope.',
    `external_referral_provider` STRING COMMENT 'Name of the external mental health provider, clinic, or organization to which the student was referred. Null if no external referral was made.',
    `external_referral_reason` STRING COMMENT 'Clinical or administrative reason for referring the student to an external provider, such as need for long-term therapy, specialized treatment, psychiatric medication management, or services beyond campus counseling center scope.',
    `follow_up_date` DATE COMMENT 'Scheduled date for a follow-up session or check-in after case closure, if recommended by the counselor. Null if no follow-up is planned.',
    `follow_up_recommended_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the counselor recommended follow-up counseling or check-in sessions after case closure to monitor student well-being.',
    `hospitalization_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the student required psychiatric hospitalization or emergency department evaluation during the course of this counseling case.',
    `insurance_used_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the student used health insurance to cover counseling services, applicable if the campus counseling center bills insurance for services.',
    `intake_date` DATE COMMENT 'Date of the initial intake assessment session when the student first met with a counselor to discuss presenting concerns and establish treatment goals.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the counseling case record was last updated in the system, reflecting changes to case status, session count, or other attributes.',
    `mandated_referral_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the student was mandated to attend counseling by the Dean of Students, conduct board, or other university authority as part of a disciplinary or intervention process.',
    `mandated_session_requirement` STRING COMMENT 'Number of counseling sessions the student is required to complete as part of a mandated referral. Null if not a mandated case.',
    `no_show_count` STRING COMMENT 'Number of scheduled appointments the student failed to attend without prior cancellation. Used to track engagement and enforce attendance policies.',
    `presenting_concern_primary` STRING COMMENT 'The primary mental health concern or issue that brought the student to counseling services, as identified during intake assessment. [ENUM-REF-CANDIDATE: anxiety|depression|academic_stress|crisis|relationship|grief_loss|trauma|substance_use|eating_disorder|identity_development|adjustment|other — 12 candidates stripped; promote to reference product]',
    `presenting_concern_secondary` STRING COMMENT 'A secondary mental health concern identified during intake, if applicable. May be null if only one primary concern exists. [ENUM-REF-CANDIDATE: anxiety|depression|academic_stress|crisis|relationship|grief_loss|trauma|substance_use|eating_disorder|identity_development|adjustment|other|none — 13 candidates stripped; promote to reference product]',
    `referral_source` STRING COMMENT 'The source or party that referred the student to counseling services, such as self-referral, faculty member, resident advisor, dean of students, campus health center, athletics staff, academic advisor, peer, or family member. [ENUM-REF-CANDIDATE: self_referral|faculty|resident_advisor|dean_of_students|health_center|athletics|academic_advisor|peer|family|other — 10 candidates stripped; promote to reference product]',
    `risk_level` STRING COMMENT 'Clinical assessment of the students risk level for self-harm, harm to others, or severe functional impairment. Used to prioritize care and determine appropriate intervention level.. Valid values are `low|moderate|high|crisis|not_assessed`',
    `session_count` STRING COMMENT 'Total number of counseling sessions attended by the student for this case. Updated as sessions occur.',
    `session_limit` STRING COMMENT 'Maximum number of sessions allowed for this case under campus counseling center policy, typically ranging from 6 to 12 sessions per academic year. May be null for unlimited or crisis cases.',
    `treatment_approach` STRING COMMENT 'The theoretical therapeutic approach or clinical framework used by the counselor, such as Cognitive Behavioral Therapy (CBT), Dialectical Behavior Therapy (DBT), psychodynamic, humanistic, or integrative approaches. [ENUM-REF-CANDIDATE: CBT|DBT|psychodynamic|humanistic|solution_focused|integrative|supportive|other — 8 candidates stripped; promote to reference product]',
    `treatment_modality` STRING COMMENT 'The primary therapeutic approach or format used for this case, such as individual therapy, group therapy, crisis intervention, or consultation. [ENUM-REF-CANDIDATE: individual|group|crisis_intervention|couples|family|consultation|psychoeducation — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_counseling_case PRIMARY KEY(`counseling_case_id`)
) COMMENT 'Master record for a students ongoing counseling or mental health case managed through the campus counseling center. Captures case open date, case status (active, closed, referred out, on waitlist), presenting concerns (anxiety, depression, academic stress, crisis, relationship), risk level assessment (low, moderate, high, crisis), assigned counselor, treatment modality (individual, group, crisis intervention), session count, case closure reason, and external referral details. Distinct from health_visit which captures individual encounters; this record tracks the longitudinal therapeutic relationship.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`student_org` (
    `student_org_id` BIGINT COMMENT 'Unique identifier for the student organization record. Primary key.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Organizations receive allocations from student activity funds, student government funds, or specific restricted funds. Link supports fund accounting, ensures compliance with fund restrictions, and ena',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Student organizations are assigned IT equipment (projectors, cameras, laptops, sound systems) for events and operations. Real business process: equipment checkout, inventory management, damage trackin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Student organizations receiving institutional budget allocations are tracked as cost centers or sub-accounts within student affairs. Link enables budget oversight, expenditure tracking, and ensures or',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to faculty.instructor. Business justification: Student organizations require faculty advisors for institutional recognition, budget approval, risk management oversight, and compliance reporting. Currently denormalized as name/email. Core operation',
    `profile_id` BIGINT COMMENT 'FK to student.profile',
    `third_party_contract_id` BIGINT COMMENT 'Foreign key linking to billing.third_party_contract. Business justification: Student organizations with external sponsors (Greek national organizations, professional societies) may have billing contracts where sponsor pays member fees. Links organization to sponsor billing arr',
    `parent_student_org_id` BIGINT COMMENT 'Self-referencing FK on student_org (parent_student_org_id)',
    `affiliation_type` STRING COMMENT 'Indicates whether the organization is independent, affiliated with a national organization, a regional chapter, university-sponsored, or departmentally affiliated.. Valid values are `independent|national_affiliate|regional_chapter|university_sponsored|departmental`',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'Annual budget allocation amount provided to the organization by student government or institutional funding sources.',
    `conduct_violations_count` STRING COMMENT 'Number of student conduct violations or policy infractions associated with the organization in the current academic year.',
    `constitution_last_updated_date` DATE COMMENT 'Date when the organizations constitution or governing document was last revised and submitted to Student Affairs.',
    `constitution_on_file_flag` BOOLEAN COMMENT 'Indicates whether the organization has submitted and has on file a current constitution or governing document as required for recognition.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this student organization record was first created in the system.',
    `derecognition_date` DATE COMMENT 'Date when the organization was officially derecognized and lost institutional recognition status.',
    `derecognition_reason` STRING COMMENT 'Explanation or reason for the organizations derecognition, if applicable.',
    `greek_council` STRING COMMENT 'For Greek life organizations, indicates the governing council: IFC (Interfraternity Council), Panhellenic, NPHC (National Pan-Hellenic Council), MGC (Multicultural Greek Council), or none if not applicable.. Valid values are `IFC|Panhellenic|NPHC|MGC|none`',
    `hazing_prevention_training_date` DATE COMMENT 'Date when organization officers most recently completed required hazing prevention training.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the organizations current liability insurance policy, if applicable.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the organization is required to maintain liability insurance based on its activities and risk tier.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this student organization record was most recently updated.',
    `last_re_registration_date` DATE COMMENT 'Date when the organization most recently completed its re-registration process.',
    `meeting_location` STRING COMMENT 'Primary or regular meeting location for the organization, typically a building and room designation on campus.',
    `meeting_schedule` STRING COMMENT 'Regular meeting schedule for the organization, typically expressed as day of week and time (e.g., Tuesdays 6:00 PM).',
    `member_count` STRING COMMENT 'Current number of active members in the organization as of the last roster update.',
    `mission_statement` STRING COMMENT 'Official mission statement or purpose description of the organization as stated in its constitution or registration materials.',
    `national_affiliation_name` STRING COMMENT 'Name of the national or international parent organization if the student organization is a local chapter or affiliate.',
    `org_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the organization for registration, financial, and administrative purposes. Used as the business identifier across campus systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `org_name` STRING COMMENT 'Official registered name of the student organization as recognized by the institution.',
    `org_type` STRING COMMENT 'Primary classification of the student organization based on its mission and activities. Categories include academic/honor society, cultural/identity, recreational/club sport, service/volunteer, Greek life, professional, religious, political, and special interest. [ENUM-REF-CANDIDATE: academic|honor_society|cultural|recreational|club_sport|service|greek_life|professional|religious|political|special_interest — 11 candidates stripped; promote to reference product]',
    `probation_end_date` DATE COMMENT 'Date when the organizations probation period is scheduled to end or was lifted.',
    `probation_start_date` DATE COMMENT 'Date when the organization was placed on probation status, if applicable.',
    `re_registration_due_date` DATE COMMENT 'Date by which the organization must complete annual or periodic re-registration to maintain active status. Typically aligned with academic year cycles.',
    `recognition_date` DATE COMMENT 'Date when the organization was first officially recognized by the institution or most recently re-recognized after a period of derecognition.',
    `recognition_status` STRING COMMENT 'Current lifecycle status of the organizations official recognition by the institution. Active organizations have full privileges; inactive organizations are dormant; probation indicates conditional status; suspended organizations have privileges revoked temporarily; derecognized organizations have lost official status; pending indicates application under review.. Valid values are `active|inactive|probation|suspended|derecognized|pending`',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the organization based on activity type, history, and compliance record. Used for determining oversight and insurance requirements.. Valid values are `low|medium|high`',
    `secondary_advisor_name` STRING COMMENT 'Full name of an optional secondary or co-advisor for the organization.',
    `social_media_handle` STRING COMMENT 'Primary social media account handle or username for the organization (e.g., Instagram, Twitter/X handle).',
    `suspension_end_date` DATE COMMENT 'Date when the organizations suspension period is scheduled to end or was lifted.',
    `suspension_start_date` DATE COMMENT 'Date when the organization was placed on suspension status, if applicable.',
    `treasurer_email` STRING COMMENT 'Institutional email address of the organizations treasurer for financial communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `treasurer_name` STRING COMMENT 'Full name of the current student serving as treasurer or financial officer of the organization.',
    `website_url` STRING COMMENT 'Official website or web page URL for the organization, used for public information and recruitment.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_student_org PRIMARY KEY(`student_org_id`)
) COMMENT 'Master record for each officially recognized student organization at the institution. Captures organization name, organization code, organization type (academic/honor society, cultural/identity, recreational/club sport, service/volunteer, Greek life, professional, religious, political, special interest), recognition status (active, inactive, probation, suspended, derecognized), recognition date, re-registration due date, primary advisor name and department, officer roster reference, constitution on file flag, financial account reference, and meeting location. Serves as the authoritative registry of recognized student organizations.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`org_membership` (
    `org_membership_id` BIGINT COMMENT 'Unique identifier for the student organization membership record. Primary key for the org_membership product.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Organization membership requires identity accounts for provisioning access to org-specific collaboration tools, file shares, email lists, and communication platforms. Real business process: automated ',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who holds this organization membership. Links to the student master record.',
    `student_org_id` BIGINT COMMENT 'Unique identifier of the student organization to which the student belongs. Links to the student organization master record.',
    `renewed_org_membership_id` BIGINT COMMENT 'Self-referencing FK on org_membership (renewed_org_membership_id)',
    `academic_year` STRING COMMENT 'The academic year during which this membership is active, formatted as YYYY-YYYY (e.g., 2023-2024).. Valid values are `^d{4}-d{4}$`',
    `attendance_count` STRING COMMENT 'The number of organization meetings or events the student has attended during the current membership period.',
    `conduct_violation_date` DATE COMMENT 'The date of the most recent conduct violation or disciplinary action related to this membership, if applicable.',
    `conduct_violation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the student has any conduct violations or disciplinary actions associated with their membership in this organization. True if violations exist, False otherwise.',
    `created_date` TIMESTAMP COMMENT 'Timestamp indicating when this membership record was first created in the system.',
    `dues_amount` DECIMAL(18,2) COMMENT 'The monetary amount of membership dues required or paid by the student for the current membership period, in US dollars.',
    `dues_paid_flag` BOOLEAN COMMENT 'Boolean indicator of whether the student has paid required membership dues for the current academic year or term. True if paid, False if unpaid.',
    `dues_payment_date` DATE COMMENT 'The date on which the student paid their membership dues. Null if dues have not been paid.',
    `dues_waived_flag` BOOLEAN COMMENT 'Boolean indicator of whether membership dues have been waived for this student due to financial hardship, scholarship, or other exemption. True if waived, False otherwise.',
    `election_date` DATE COMMENT 'The date on which the student was elected or appointed to their current role within the organization. Applicable primarily for officer positions.',
    `good_standing_flag` BOOLEAN COMMENT 'Boolean indicator of whether the student is in good standing with the organization, meeting all participation, conduct, and financial requirements. True if in good standing, False otherwise.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp indicating when this membership record was last updated or modified in the system.',
    `leadership_training_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the student has completed required leadership training for their role within the organization. True if completed, False otherwise.',
    `membership_end_date` DATE COMMENT 'The date on which the students membership in the organization officially ended or is scheduled to end. Null for ongoing memberships.',
    `membership_notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the students membership, role, or participation in the organization.',
    `membership_role` STRING COMMENT 'The role or position the student holds within the organization (e.g., member, officer, president, vice_president, treasurer, secretary, advisor). [ENUM-REF-CANDIDATE: member|officer|president|vice_president|treasurer|secretary|advisor — 7 candidates stripped; promote to reference product]',
    `membership_start_date` DATE COMMENT 'The date on which the students membership in the organization officially began.',
    `membership_status` STRING COMMENT 'Current status of the membership indicating whether the student is actively participating, inactive, has resigned, been removed, suspended, or on probation.. Valid values are `active|inactive|resigned|removed|suspended|probation`',
    `membership_term` STRING COMMENT 'The academic term in which the membership was established or is active (fall, spring, summer, or full_year for year-long memberships).. Valid values are `fall|spring|summer|full_year`',
    `probation_end_date` DATE COMMENT 'The date on which the students membership probation period is scheduled to end, if applicable.',
    `probation_start_date` DATE COMMENT 'The date on which the students membership probation period began, if applicable.',
    `removal_date` DATE COMMENT 'The date on which the student was removed from the organization by organizational leadership or university administration, if applicable.',
    `removal_reason` STRING COMMENT 'Free-text explanation of why the student was removed from the organization, if applicable.',
    `resignation_date` DATE COMMENT 'The date on which the student formally resigned from the organization, if applicable.',
    `resignation_reason` STRING COMMENT 'Free-text explanation of why the student resigned from the organization, if provided.',
    `role_end_date` DATE COMMENT 'The date on which the students current role within the organization ended or is scheduled to end. Null for ongoing roles.',
    `role_start_date` DATE COMMENT 'The date on which the student assumed their current role within the organization. May differ from membership_start_date if the student was promoted or changed roles.',
    `training_completion_date` DATE COMMENT 'The date on which the student completed required leadership or role-specific training for the organization.',
    `transcript_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this membership is eligible to appear on the students co-curricular transcript or engagement record. True if eligible, False otherwise.',
    `volunteer_hours` DECIMAL(18,2) COMMENT 'The total number of volunteer or service hours the student has contributed through this organization during the current membership period.',
    `voting_rights_flag` BOOLEAN COMMENT 'Boolean indicator of whether the student has voting rights within the organization. True if the student can vote, False otherwise.',
    `waiver_reason` STRING COMMENT 'Free-text explanation of why membership dues were waived for this student, if applicable.',
    CONSTRAINT pk_org_membership PRIMARY KEY(`org_membership_id`)
) COMMENT 'Association record capturing a students membership in a recognized student organization for a given academic year. Captures membership start date, membership end date, membership role (member, officer, president, treasurer, secretary, advisor), membership status (active, inactive, resigned, removed), dues paid flag, dues amount, and the term in which membership was established. Tracks the full roster and role history of student organization participation for co-curricular engagement records.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`campus_event` (
    `campus_event_id` BIGINT COMMENT 'Unique identifier for the campus event record. Primary key for the campus_event product.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Events need building-level context for facility operations when room is TBD, for outdoor events on building grounds, or building-wide events. Complements existing room_id FK. Supports facility utiliza',
    `employee_id` BIGINT COMMENT 'Identifier of the student affairs staff member or administrator who approved the event.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Events incur expenses (catering, supplies, facilities) charged to sponsoring department cost centers. Link enables event cost tracking, budget variance analysis, and ensures departments manage event s',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Event expenses post to specific ledger accounts (programming supplies, contracted services, food service). Link supports expense tracking, budget monitoring, and facilitates proper expense classificat',
    `identity_account_id` BIGINT COMMENT 'Identifier of the user (staff or student) who last modified the event record.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Campus events require IT equipment reservations (AV gear, laptops, projectors, microphones). Real business process: event technology support, equipment scheduling, setup/teardown tracking, and post-ev',
    `llc_program_id` BIGINT COMMENT 'Foreign key linking to studentlife.llc_program. Business justification: Campus events can be organized by or targeted to specific Living Learning Communities. An LLC program may host events exclusive to its members (e.g., Engineering LLC Speaker Series, Honors LLC Stud',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic or administrative department co-sponsoring or supporting the event, if applicable.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Event registration fees are paid through billing system. Links event to payment transaction for payment verification, refund processing upon cancellation, and revenue reconciliation of event programmi',
    `room_id` BIGINT COMMENT 'Identifier of the campus facility, room, or outdoor space where the event will be held.',
    `sponsor_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.sponsor_invoice. Business justification: Sponsored campus events generate invoices to external organizations for event costs. Links event to billing invoice for sponsor payment tracking and revenue recognition of externally-funded programmin',
    `student_org_id` BIGINT COMMENT 'Identifier of the primary student organization, department, or campus life office that is organizing or sponsoring the event.',
    `parent_campus_event_id` BIGINT COMMENT 'Self-referencing FK on campus_event (parent_campus_event_id)',
    `accessibility_accommodations` STRING COMMENT 'Description of accessibility features and accommodations provided for the event to ensure inclusive participation (e.g., ASL interpretation, wheelchair access, dietary accommodations).',
    `actual_attendance` STRING COMMENT 'Actual number of participants who attended the event, recorded after event completion for reporting and assessment.',
    `actual_expense_amount` DECIMAL(18,2) COMMENT 'Total actual expenses incurred for the event, recorded after event completion for financial reconciliation and reporting.',
    `approval_date` DATE COMMENT 'Date when the event received formal approval from the appropriate authority to proceed with planning and execution.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the event requires formal approval from student affairs administration or a campus event review committee before proceeding.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated or approved for the event, covering all anticipated expenses including venue, catering, speakers, materials, and promotion.',
    `cancellation_reason` STRING COMMENT 'Explanation or justification for why the event was cancelled or postponed, if applicable.',
    `cocurricular_credit_eligible_flag` BOOLEAN COMMENT 'Indicates whether attendance at this event qualifies for co-curricular transcript credit or student engagement recognition.',
    `cocurricular_credit_hours` DECIMAL(18,2) COMMENT 'Number of co-curricular credit hours awarded to students who attend and complete participation requirements for the event.',
    `contact_email` STRING COMMENT 'Email address of the primary contact person for the event, used for participant inquiries and event coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the staff member, advisor, or student leader serving as the primary contact for event inquiries and coordination.',
    `contact_phone` STRING COMMENT 'Phone number of the primary contact person for the event, used for urgent inquiries and coordination.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campus event record was first created in the system.',
    `event_category` STRING COMMENT 'Broad categorical grouping of the event for reporting and analytics purposes, distinct from event_type which provides more granular classification. [ENUM-REF-CANDIDATE: academic|social|cultural|athletic|professional|service|wellness — 7 candidates stripped; promote to reference product]',
    `event_description` STRING COMMENT 'Detailed narrative description of the event purpose, agenda, speakers, activities, and learning outcomes for promotional and informational purposes.',
    `event_end_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the campus event is expected to conclude.',
    `event_location_name` STRING COMMENT 'Human-readable name of the event venue or location for display and communication purposes.',
    `event_name` STRING COMMENT 'Official name or title of the campus event as it appears in promotional materials and event calendars.',
    `event_number` STRING COMMENT 'Externally-visible unique business identifier for the campus event, used for registration, promotion, and tracking purposes.. Valid values are `^EVT-[0-9]{6,10}$`',
    `event_start_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the campus event is set to begin, representing the principal business event timestamp.',
    `event_status` STRING COMMENT 'Current lifecycle status of the campus event indicating its progression through planning, approval, execution, and completion stages.. Valid values are `planned|approved|active|completed|cancelled|postponed`',
    `event_type` STRING COMMENT 'Classification of the campus event by its primary purpose or format. [ENUM-REF-CANDIDATE: lecture|concert|cultural_celebration|athletic|orientation|leadership_workshop|community_service|social|greek_life|career_fair|academic_symposium|wellness_program|diversity_initiative|student_government|club_meeting|fundraiser|volunteer_opportunity — promote to reference product]. Valid values are `lecture|concert|cultural_celebration|athletic|orientation|leadership_workshop`',
    `expected_attendance` STRING COMMENT 'Estimated number of participants or attendees anticipated for the event, used for planning and resource allocation.',
    `funding_source` STRING COMMENT 'Description of the primary funding source or account used to finance the event (e.g., student activities fee, departmental budget, external sponsorship).',
    `hybrid_event_flag` BOOLEAN COMMENT 'Indicates whether the event offers both in-person and virtual attendance options simultaneously.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campus event record was most recently updated or modified.',
    `registration_capacity` STRING COMMENT 'Maximum number of registrations or attendees allowed for the event, based on venue capacity or program constraints.',
    `registration_close_date` DATE COMMENT 'Date when registration for the event closes, after which no additional registrations are accepted.',
    `registration_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to students or participants to register for or attend the event, if applicable.',
    `registration_open_date` DATE COMMENT 'Date when registration for the event becomes available to eligible students and participants.',
    `registration_required_flag` BOOLEAN COMMENT 'Indicates whether students or attendees must register in advance to participate in the event.',
    `target_audience` STRING COMMENT 'Description of the intended participant population for the event (e.g., first-year students, graduate students, specific majors, all students, faculty and staff).',
    `virtual_event_flag` BOOLEAN COMMENT 'Indicates whether the event is conducted entirely online or in a virtual format rather than in-person.',
    `virtual_platform` STRING COMMENT 'Name of the online platform or technology used to host the virtual or hybrid event (e.g., Zoom, Microsoft Teams, Canvas Conferences).',
    CONSTRAINT pk_campus_event PRIMARY KEY(`campus_event_id`)
) COMMENT 'Master record for campus events organized or co-sponsored by student affairs, student organizations, or campus life offices. Captures event name, event type (lecture, concert, cultural celebration, athletic, orientation, leadership workshop, community service, social, Greek life, career fair), sponsoring organization or department, event date and time, event location, expected attendance, registration required flag, registration capacity, event status (planned, approved, active, completed, cancelled), and co-curricular credit eligibility flag. Distinct from admission.recruitment_event and alumni.alumni_event which serve different populations.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`event_attendance` (
    `event_attendance_id` BIGINT COMMENT 'Unique identifier for the event attendance record. Primary key for the event attendance transaction.',
    `term_id` BIGINT COMMENT 'Unique identifier of the academic term during which the event occurred. Used for co-curricular transcript organization and term-based engagement reporting.',
    `campus_event_id` BIGINT COMMENT 'Unique identifier of the campus event that the student attended. Links to the event master record.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Event check-in systems authenticate attendees via identity accounts for digital check-in kiosks and co-curricular credit tracking. Real business process: automated attendance verification, co-curricul',
    `employee_id` BIGINT COMMENT 'Unique identifier of the staff member or student worker who processed the check-in, if manual or staff-assisted. Used for operational accountability and training.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who attended or registered for the event. Links to the student master record.',
    `student_org_id` BIGINT COMMENT 'Unique identifier of the student organization hosting or sponsoring the event, if applicable. Used for organization engagement tracking and funding accountability.',
    `corrected_event_attendance_id` BIGINT COMMENT 'Self-referencing FK on event_attendance (corrected_event_attendance_id)',
    `accommodation_description` STRING COMMENT 'Description of the special accommodations requested or provided for the student. Confidential information used for service delivery and compliance documentation.',
    `attendance_duration_minutes` STRING COMMENT 'Calculated duration of the students attendance in minutes, derived from check-in and check-out timestamps. Used to verify minimum attendance requirements for credit eligibility.',
    `attendance_method` STRING COMMENT 'Method by which the student checked in to the event. Tracks the technology or process used for attendance verification (card swipe, QR code scan, manual entry by staff, mobile app, kiosk, or NFC tap).. Valid values are `card-swipe|qr-scan|manual|mobile-app|kiosk|nfc`',
    `attendance_notes` STRING COMMENT 'Free-text notes or comments about the attendance record, entered by staff or system. Used for operational context and issue resolution.',
    `attendance_number` STRING COMMENT 'Business-facing unique identifier or confirmation number for this attendance record, used for check-in verification and student reference.',
    `attendance_status` STRING COMMENT 'Current status of the students attendance at the event. Tracks whether the student attended, was a no-show, was waitlisted, cancelled their registration, or is currently checked in.. Valid values are `attended|no-show|waitlisted|cancelled|checked-in`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation provided by the student or staff for why the attendance was cancelled. Used for event planning and student engagement analysis.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the student cancelled their event registration or attendance. Used for capacity management and no-show analytics.',
    `check_in_location` STRING COMMENT 'Physical location or station where the student checked in (e.g., Main Entrance, Registration Desk A, Mobile Check-In). Used for operational logistics and flow analysis.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the student checked in to the event. Represents the principal business event timestamp for attendance verification and capacity tracking.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Date and time when the student checked out from the event. Used to calculate duration of attendance and verify full participation for co-curricular credit eligibility.',
    `co_curricular_credit_awarded_flag` BOOLEAN COMMENT 'Indicates whether co-curricular credit was awarded to the student for attending this event. Used for co-curricular transcript generation and engagement tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this attendance record was first created in the system. Used for audit trail and data lineage.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Numeric amount of co-curricular credit awarded for this attendance. May represent hours, points, or units depending on institutional policy.',
    `credit_type` STRING COMMENT 'Type or category of co-curricular credit awarded for this attendance (e.g., Leadership, Community Service, Cultural Engagement, Professional Development, Wellness). Aligns with institutional co-curricular learning outcomes.',
    `credit_unit` STRING COMMENT 'Unit of measure for the co-curricular credit amount (hours, points, units, or credits). Provides context for the credit_amount field.. Valid values are `hours|points|units|credits`',
    `feedback_rating` STRING COMMENT 'Numeric rating provided by the student in their event feedback (e.g., 1-5 scale). Used for event quality assessment and continuous improvement.',
    `feedback_submitted_flag` BOOLEAN COMMENT 'Indicates whether the student submitted post-event feedback or evaluation. Used to track response rates and link to event feedback records.',
    `guest_count` STRING COMMENT 'Number of guests the student brought to the event, if guests were permitted. Used for capacity tracking and event planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this attendance record was last updated in the system. Used for audit trail and change tracking.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the student registered for the event but did not attend (no-show). Used for engagement analytics and future event planning.',
    `participation_level` STRING COMMENT 'Level or role of the students participation in the event (attendee, active participant, volunteer, presenter, or organizer). Used for differentiated co-curricular credit and leadership tracking.. Valid values are `attendee|participant|volunteer|presenter|organizer`',
    `payment_method` STRING COMMENT 'Method used by the student to pay for the event ticket (e.g., credit card, student account charge, cash, mobile payment). Used for financial reconciliation and payment analytics. [ENUM-REF-CANDIDATE: credit-card|debit-card|student-account|cash|mobile-payment|check|voucher — promote to reference product]',
    `payment_status` STRING COMMENT 'Status of the ticket payment for the event (paid, pending, waived, refunded, or unpaid). Used for financial reconciliation and access control.. Valid values are `paid|pending|waived|refunded|unpaid`',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the student registered for the event. Distinct from check-in; represents the initial commitment or RSVP.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this attendance record (e.g., Campus Labs Engage, OrgSync, custom event management system). Used for data lineage and integration troubleshooting.',
    `special_accommodation_requested_flag` BOOLEAN COMMENT 'Indicates whether the student requested special accommodations for attending the event (e.g., accessibility, dietary, language interpretation). Used for compliance and service delivery.',
    `ticket_cost_amount` DECIMAL(18,2) COMMENT 'Cost of the event ticket paid by the student, if the event required payment. Zero for free events. Used for revenue tracking and financial reporting.',
    `ticket_number` STRING COMMENT 'Unique ticket or confirmation number issued to the student for event entry, if ticketing was used. Used for access control and attendance verification.',
    `verification_status` STRING COMMENT 'Status of attendance verification by staff or automated process. Indicates whether the attendance has been verified, is pending review, was disputed by the student, or has been corrected.. Valid values are `verified|pending|disputed|corrected`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the attendance record was verified or approved by staff. Used for audit trail and credit processing timelines.',
    `waitlist_position` STRING COMMENT 'Position of the student on the event waitlist if attendance status is waitlisted. Used for capacity management and automated notification when space becomes available.',
    `waitlist_timestamp` TIMESTAMP COMMENT 'Date and time when the student was added to the event waitlist. Used to determine waitlist priority and manage capacity.',
    CONSTRAINT pk_event_attendance PRIMARY KEY(`event_attendance_id`)
) COMMENT 'Transactional record capturing a students attendance at a campus event, used for co-curricular engagement tracking and event capacity management. Captures check-in timestamp, check-out timestamp, attendance method (swipe, QR scan, manual), co-curricular credit awarded flag, credit type and amount, and attendance status (attended, no-show, waitlisted). Provides the foundational data for co-curricular transcripts and student engagement analytics.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`conduct_case` (
    `conduct_case_id` BIGINT COMMENT 'Unique identifier for the student conduct case record. Primary key for the conduct case entity.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term during which the alleged incident occurred or the case was initiated.',
    `employee_id` BIGINT COMMENT 'Identifier of the conduct officer or administrator assigned to investigate and adjudicate this case.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to technology.incident. Business justification: Student conduct violations frequently involve IT policy breaches (network abuse, unauthorized access, cyberbullying, copyright infringement). Real business process: linking conduct cases to IT securit',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who is the respondent in this conduct case. Links to the student master record.',
    `studentlife_housing_assignment_id` BIGINT COMMENT 'Foreign key linking to studentlife.housing_assignment. Business justification: Conduct violations often occur in or affect housing (roommate conflicts, noise violations, substance violations). Conduct officers need to know students housing assignment for investigation, interim ',
    `appeal_conduct_case_id` BIGINT COMMENT 'Self-referencing FK on conduct_case (appeal_conduct_case_id)',
    `advisor_present_flag` BOOLEAN COMMENT 'Indicates whether the student was accompanied by an advisor (attorney, parent, or support person) during the hearing process.',
    `appeal_decision` STRING COMMENT 'Outcome of the appeal process indicating whether the original finding and sanctions were upheld, modified, or overturned.. Valid values are `upheld|overturned|sanction modified|remanded`',
    `appeal_decision_date` DATE COMMENT 'Date when the appeal decision was issued by the appellate authority.',
    `appeal_filed_date` DATE COMMENT 'Date when the student submitted a formal appeal of the conduct case outcome.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the student filed a formal appeal of the conduct finding or sanctions.',
    `appeal_grounds` STRING COMMENT 'Basis or rationale provided by the student for appealing the conduct case decision (e.g., procedural error, new evidence, disproportionate sanction).',
    `case_closure_date` DATE COMMENT 'Date when the conduct case was officially closed, either after sanctions were completed, appeal process concluded, or case was dismissed.',
    `case_notes` STRING COMMENT 'Internal administrative notes and comments regarding the conduct case, investigation, hearing, or sanction compliance. Confidential staff use only.',
    `case_number` STRING COMMENT 'Human-readable unique case number assigned to this conduct matter for tracking and reference purposes. Typically follows institutional numbering convention (e.g., COND-2024-00123).',
    `case_status` STRING COMMENT 'Current lifecycle status of the conduct case indicating where it stands in the adjudication process. [ENUM-REF-CANDIDATE: reported|under investigation|hearing scheduled|resolved|appealed|closed|dismissed — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this conduct case record was first created in the system.',
    `finding` STRING COMMENT 'Official determination of responsibility for the alleged conduct violation following the hearing or administrative review.. Valid values are `responsible|not responsible|deferred|insufficient evidence`',
    `finding_date` DATE COMMENT 'Date when the official finding of responsibility or non-responsibility was issued.',
    `hearing_date` DATE COMMENT 'Date when the formal conduct hearing was held to adjudicate the alleged violation.',
    `hearing_location` STRING COMMENT 'Physical or virtual location where the conduct hearing took place (e.g., Student Affairs Office, Zoom meeting).',
    `hearing_type` STRING COMMENT 'Type of adjudication process used to resolve the conduct case. Administrative hearings are conducted by a single officer; panel hearings involve multiple decision-makers.. Valid values are `administrative|panel|informal resolution|no hearing required`',
    `incident_location` STRING COMMENT 'Physical location or facility where the alleged conduct violation occurred (e.g., residence hall name, building code, off-campus location description).',
    `incident_occurrence_date` DATE COMMENT 'Date when the alleged conduct violation actually occurred. May differ from the report date if the incident was reported after the fact.',
    `incident_report_date` DATE COMMENT 'Date when the alleged conduct violation was formally reported to the institution. This is the official start of the case record, distinct from when the incident occurred.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation phase was completed and the case was ready for hearing or administrative resolution.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of the alleged conduct violation began.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this conduct case record was last updated or modified in the system.',
    `parent_notification_date` DATE COMMENT 'Date when parent or guardian notification was sent regarding the conduct case.',
    `parent_notification_flag` BOOLEAN COMMENT 'Indicates whether the students parent or guardian was notified of the conduct case per institutional policy and FERPA exceptions.',
    `reporting_party_name` STRING COMMENT 'Name of the individual who reported the conduct violation. Confidential and may be redacted in certain circumstances per institutional policy.',
    `reporting_party_type` STRING COMMENT 'Category of the individual or entity who reported the alleged conduct violation to the institution. [ENUM-REF-CANDIDATE: student|faculty|staff|resident assistant|campus security|external party|anonymous — 7 candidates stripped; promote to reference product]',
    `sanction_completion_date` DATE COMMENT 'Date when the student successfully completed all imposed sanctions and fulfilled all conduct case requirements.',
    `sanction_completion_deadline` DATE COMMENT 'Date by which the student must complete all imposed sanctions (e.g., finish community service hours, complete educational program).',
    `sanction_completion_status` STRING COMMENT 'Current status of the students progress in fulfilling the imposed sanctions.. Valid values are `not started|in progress|completed|overdue|waived`',
    `sanction_description` STRING COMMENT 'Detailed description of all sanctions imposed, including specific requirements, conditions, and expectations for completion.',
    `sanction_effective_date` DATE COMMENT 'Date when the imposed sanctions take effect and the student must begin compliance.',
    `sanction_primary` STRING COMMENT 'Primary disciplinary sanction imposed on the student if found responsible for the conduct violation. [ENUM-REF-CANDIDATE: warning|probation|suspension|expulsion|educational program|community service|restitution|housing removal|no contact order — 9 candidates stripped; promote to reference product]',
    `sanction_secondary` STRING COMMENT 'Additional sanctions imposed beyond the primary sanction. May include multiple requirements such as educational programs, community service hours, or counseling.',
    `student_attendance_status` STRING COMMENT 'Indicates whether the respondent student attended the scheduled conduct hearing.. Valid values are `attended|did not attend|excused absence`',
    `transcript_notation_flag` BOOLEAN COMMENT 'Indicates whether the conduct violation and sanctions result in a notation on the students academic transcript per institutional policy.',
    `transcript_notation_text` STRING COMMENT 'Specific text that appears on the students academic transcript if a notation is required (e.g., Disciplinary Suspension, Conduct Probation).',
    `violation_description` STRING COMMENT 'Detailed narrative description of the alleged conduct violation, including circumstances, witnesses, and evidence summary. Confidential case information.',
    `violation_type_primary` STRING COMMENT 'Primary category of the alleged student code of conduct violation. Represents the most serious or predominant charge in cases with multiple allegations. [ENUM-REF-CANDIDATE: academic dishonesty|alcohol|drug|harassment|physical altercation|property damage|noise disruption|theft|unauthorized access — 9 candidates stripped; promote to reference product]',
    `violation_type_secondary` STRING COMMENT 'Additional violation category if the case involves multiple alleged infractions. Free-text or comma-separated list of secondary charges.',
    CONSTRAINT pk_conduct_case PRIMARY KEY(`conduct_case_id`)
) COMMENT 'Master record for a student conduct case initiated under the institutions student code of conduct. Captures incident report date, case number, alleged violation type(s) (academic dishonesty, alcohol/drug, harassment, physical altercation, property damage, noise/disruption), case status (reported, under investigation, hearing scheduled, resolved, appealed, closed), hearing type (administrative, panel), hearing date, finding (responsible, not responsible, deferred), sanction(s) imposed, sanction completion deadline, appeal filed flag, and case closure date. Complements compliance.title_ix_case which handles Title IX-specific matters; this record covers the broader student conduct adjudication process.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`conduct_sanction` (
    `conduct_sanction_id` BIGINT COMMENT 'Unique identifier for the conduct sanction record. Primary key for the conduct sanction entity.',
    `account_hold_id` BIGINT COMMENT 'Foreign key linking to billing.account_hold. Business justification: Unpaid restitution or conduct fines trigger account holds preventing registration and transcript release. Links sanction to billing hold for financial enforcement of conduct penalties and hold release',
    `conduct_case_id` BIGINT COMMENT 'Reference to the parent conduct case that resulted in this sanction. A single conduct case may result in multiple sanctions.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or conduct officer who assigned this sanction to the student.',
    `profile_id` BIGINT COMMENT 'Reference to the student who is subject to this sanction. Links to the student master record.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Restitution amounts and conduct-related fines are billed to student accounts. Links sanction financial penalties to billing system for charge posting, payment tracking, and hold enforcement until rest',
    `studentlife_housing_assignment_id` BIGINT COMMENT 'Foreign key linking to studentlife.housing_assignment. Business justification: Specific sanctions include housing removal, reassignment, or restrictions (banned from specific halls). Conduct system must link sanction to affected housing assignment for enforcement. Housing staff ',
    `tertiary_conduct_waived_by_staff_employee_id` BIGINT COMMENT 'Reference to the staff member who authorized the waiver of this sanction. Null if sanction was not waived.',
    `superseded_conduct_sanction_id` BIGINT COMMENT 'Self-referencing FK on conduct_sanction (superseded_conduct_sanction_id)',
    `appeal_deadline_date` DATE COMMENT 'Last date by which the student may submit an appeal of this sanction. Null if sanction is not appealable.',
    `appeal_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student has the right to appeal this sanction under the institutions conduct policies.',
    `assigned_date` DATE COMMENT 'Date when the sanction was officially assigned to the student following the conduct case resolution.',
    `completion_date` DATE COMMENT 'Actual date when the student fulfilled all requirements of the sanction, as verified by the conduct office or designated staff member.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sanction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for restitution amounts. Typically USD for U.S. institutions.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Deadline by which the student must complete the sanction requirements. Null for sanctions without a completion requirement such as warnings.',
    `effective_end_date` DATE COMMENT 'Date when the sanction expires or is no longer in effect. Relevant for time-bound sanctions such as probation periods or no-contact orders.',
    `effective_start_date` DATE COMMENT 'Date when the sanction becomes active and enforceable. May differ from assigned date if the sanction is deferred or scheduled to begin at a future date.',
    `external_agency_reported_flag` BOOLEAN COMMENT 'Indicates whether this sanction or the underlying conduct case was reported to an external agency such as law enforcement, accreditation bodies, or regulatory authorities.',
    `hold_placed_flag` BOOLEAN COMMENT 'Indicates whether a registration or administrative hold was placed on the students account as part of this sanction enforcement.',
    `hold_type` STRING COMMENT 'Type of hold placed on the students account if hold_placed_flag is true. Null if no hold was placed.. Valid values are `registration|transcript|graduation|financial|disciplinary`',
    `hours_completed` DECIMAL(18,2) COMMENT 'Number of hours the student has completed toward the sanction requirement. Updated as progress is documented.',
    `hours_required` DECIMAL(18,2) COMMENT 'Number of hours required for completion, applicable to community service, educational programs, or counseling sessions. Null for sanctions without hour requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sanction record was last updated, reflecting any changes to status, completion progress, or other attributes.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the sanction, its administration, or special circumstances. Confidential internal documentation.',
    `parent_notification_required_flag` BOOLEAN COMMENT 'Indicates whether institutional policy requires notification to the students parent or guardian for this sanction, typically for serious violations or for students under age 21 in alcohol/drug cases.',
    `parent_notification_sent_date` DATE COMMENT 'Date when notification was sent to the students parent or guardian. Null if notification was not required or not yet sent.',
    `restitution_amount` DECIMAL(18,2) COMMENT 'Monetary amount the student is required to pay as restitution for damages, losses, or costs incurred. Null for non-financial sanctions.',
    `restitution_paid_amount` DECIMAL(18,2) COMMENT 'Amount of restitution the student has paid to date. Updated as payments are received and processed.',
    `sanction_category` STRING COMMENT 'Broader classification grouping of the sanction type for reporting and analytics purposes.. Valid values are `educational|punitive|restorative|restrictive|administrative|interim`',
    `sanction_description` STRING COMMENT 'Detailed narrative description of the specific sanction requirements, conditions, and expectations imposed on the student.',
    `sanction_number` STRING COMMENT 'Business identifier for the sanction, typically formatted as a human-readable reference number used in correspondence and documentation.',
    `sanction_status` STRING COMMENT 'Current lifecycle status of the sanction indicating whether the student has fulfilled the requirements.. Valid values are `pending|in_progress|completed|not_completed|waived|appealed`',
    `sanction_type` STRING COMMENT 'Classification of the sanction imposed. [ENUM-REF-CANDIDATE: disciplinary_warning|disciplinary_probation|educational_program|community_service|restitution|suspension|expulsion|housing_removal|no_contact_order|transcript_notation|loss_of_privileges|deferred_suspension — promote to reference product]',
    `severity_level` STRING COMMENT 'Classification of the sanction severity, used for reporting, trend analysis, and determining escalation paths for repeat offenders.. Valid values are `minor|moderate|serious|severe`',
    `transcript_notation_flag` BOOLEAN COMMENT 'Indicates whether this sanction results in a notation on the students academic transcript, typically for serious violations such as suspension or expulsion.',
    `transcript_notation_text` STRING COMMENT 'Exact text that appears on the students transcript if transcript notation is required. Null if no notation applies.',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the sanction completion was verified by the designated staff member.',
    `waiver_date` DATE COMMENT 'Date when the sanction waiver was approved. Null if sanction was not waived.',
    `waiver_reason` STRING COMMENT 'Explanation for why the sanction was waived or modified, if applicable. Null if sanction was not waived.',
    CONSTRAINT pk_conduct_sanction PRIMARY KEY(`conduct_sanction_id`)
) COMMENT 'Transactional record of a specific sanction imposed on a student as an outcome of a conduct case. Captures sanction type (disciplinary warning, disciplinary probation, educational program, community service hours, restitution, suspension, expulsion, housing removal, no-contact order), sanction description, assigned date, due date, completion date, completion status (pending, completed, not completed, waived), and verifying staff member. A single conduct case may result in multiple sanctions, each tracked independently with its own completion lifecycle.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`cocurricular_record` (
    `cocurricular_record_id` BIGINT COMMENT 'Unique identifier for the co-curricular record. Primary key for this master record aggregating a students verified co-curricular engagement portfolio.',
    `employee_id` BIGINT COMMENT 'Identifier of the student affairs staff member who most recently verified the accuracy and completeness of this co-curricular record.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Co-curricular transcripts are generated from dedicated student engagement platforms (Presence, OrgSync, CampusLabs). Real business process: integration with co-curricular management applications for t',
    `last_modified_by_staff_employee_id` BIGINT COMMENT 'Identifier of the staff member who most recently modified this co-curricular record.',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student to whom this co-curricular record belongs. Links to the student master record.',
    `prior_cocurricular_record_id` BIGINT COMMENT 'Self-referencing FK on cocurricular_record (prior_cocurricular_record_id)',
    `academic_year` STRING COMMENT 'The current or most recent academic year associated with this co-curricular record (e.g., 2023-2024).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this co-curricular record was first created in the system.',
    `employer_verification_count` STRING COMMENT 'Count of times this co-curricular record has been requested for verification by prospective employers.',
    `engagement_level` STRING COMMENT 'Qualitative assessment of the students overall level of co-curricular engagement based on credits, hours, and participation metrics.. Valid values are `minimal|moderate|active|highly_active|exceptional`',
    `enrollment_end_date` DATE COMMENT 'Date when the students enrollment ended (graduation, withdrawal, or transfer), marking the closure of active co-curricular record accumulation.',
    `enrollment_start_date` DATE COMMENT 'Date when the student first enrolled at the institution, marking the beginning of their co-curricular record accumulation period.',
    `first_activity_date` DATE COMMENT 'Date of the students first recorded co-curricular activity or engagement during their enrollment.',
    `graduate_school_verification_count` STRING COMMENT 'Count of times this co-curricular record has been requested for verification by graduate or professional schools.',
    `graduation_requirement_met_flag` BOOLEAN COMMENT 'Indicates whether the student has met the minimum co-curricular engagement requirements for graduation as defined by institutional policy.',
    `hold_reason` STRING COMMENT 'Explanation of why a transcript hold has been placed on this co-curricular record, if applicable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this co-curricular record is currently active and being maintained, or has been archived due to student departure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this co-curricular record was most recently updated or modified.',
    `major_program` STRING COMMENT 'The students primary academic major or program of study, providing context for co-curricular engagement alignment.',
    `most_recent_activity_date` DATE COMMENT 'Date of the students most recent verified co-curricular activity or engagement.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and verification of the co-curricular record.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the co-curricular record, including special circumstances, verification issues, or administrative annotations.',
    `primary_engagement_category` STRING COMMENT 'The category of co-curricular engagement in which the student has demonstrated the highest level of participation (e.g., leadership, service, athletics, arts).',
    `record_number` STRING COMMENT 'Human-readable business identifier for the co-curricular record, often used for external reference and transcript generation.',
    `record_status` STRING COMMENT 'Current lifecycle status of the co-curricular record indicating whether it is actively maintained, verified, or archived.. Valid values are `active|inactive|verified|pending_verification|archived|suspended`',
    `scholarship_eligible_flag` BOOLEAN COMMENT 'Indicates whether the students co-curricular record meets the eligibility criteria for co-curricular-based scholarships and awards.',
    `student_classification` STRING COMMENT 'The students academic classification level at the time of the most recent co-curricular record update.. Valid values are `freshman|sophomore|junior|senior|graduate|non_degree`',
    `total_awards_received` STRING COMMENT 'Count of awards, honors, and recognitions received by the student for co-curricular achievements and contributions.',
    `total_cocurricular_credits` DECIMAL(18,2) COMMENT 'Cumulative total of co-curricular credits earned by the student across all verified activities and engagements throughout their enrollment.',
    `total_events_attended` STRING COMMENT 'Count of verified campus events, workshops, seminars, and co-curricular programs attended by the student.',
    `total_leadership_roles` STRING COMMENT 'Count of distinct leadership positions held by the student in student organizations, clubs, and campus activities.',
    `total_organizations_participated` STRING COMMENT 'Count of distinct student organizations, clubs, and groups in which the student has participated as a member or leader.',
    `total_service_hours` DECIMAL(18,2) COMMENT 'Cumulative total of verified community service and volunteer hours completed by the student during their enrollment.',
    `transcript_generation_date` DATE COMMENT 'Date when the official co-curricular transcript was most recently generated for this student, used for graduation requirements or external verification.',
    `transcript_hold_flag` BOOLEAN COMMENT 'Indicates whether there is an administrative hold preventing the release of the co-curricular transcript (e.g., pending verification, conduct issues).',
    `transcript_release_authorized_flag` BOOLEAN COMMENT 'Indicates whether the student has authorized the release of their co-curricular transcript to external parties (employers, graduate schools).',
    `transcript_version_number` STRING COMMENT 'Version number of the co-curricular transcript, incremented each time a new official transcript is generated.',
    `verification_date` DATE COMMENT 'Date when the co-curricular record was most recently verified by authorized staff.',
    `verification_status` STRING COMMENT 'Indicates whether the co-curricular activities and achievements documented in this record have been officially verified by authorized staff.. Valid values are `verified|unverified|partially_verified|pending_review|rejected`',
    CONSTRAINT pk_cocurricular_record PRIMARY KEY(`cocurricular_record_id`)
) COMMENT 'Master record aggregating a students verified co-curricular engagement portfolio across their enrollment. Captures total co-curricular credits earned, leadership roles held, service hours logged, organizations participated in, events attended, awards and recognitions received, co-curricular transcript generation date, and verification status. Serves as the authoritative co-curricular transcript record used for graduation requirements, scholarship eligibility, and employer/graduate school verification. Distinct from academic_history which tracks coursework.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`service_learning_placement` (
    `service_learning_placement_id` BIGINT COMMENT 'Unique identifier for the service learning placement record. Primary key for this entity.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term during which this service learning placement occurs.',
    `course_id` BIGINT COMMENT 'Identifier of the academic course to which this service learning placement is linked, if the placement is course-embedded. Null if the placement is purely co-curricular.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or administrator who approved this service learning placement.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member or academic staff who supervises and evaluates the students service learning placement from the institutional side.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service learning programs operate within academic department cost centers. Placements drive program costs (transportation, insurance, site coordination) and may be grant-funded. Link enables program c',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student assigned to this service learning placement. Links to the student master record.',
    `irb_protocol_id` BIGINT COMMENT 'Foreign key linking to research.irb_protocol. Business justification: Service-learning placements involving human subjects research require IRB protocol approval before student participation. Universities must verify IRB compliance for student research activities to mee',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: Service learning placements generate IT support requests for technology needs at community partner sites (VPN access, equipment, software). Real business process: IT support ticketing for off-campus l',
    `student_org_id` BIGINT COMMENT 'Foreign key linking to studentlife.student_org. Business justification: Service learning placements can be organized, coordinated, or sponsored by student organizations (e.g., a community service organization coordinates volunteer placements, an environmental club organiz',
    `tuition_charge_id` BIGINT COMMENT 'Foreign key linking to billing.tuition_charge. Business justification: Service learning placements may have associated course fees or lab charges. Links placement to specific tuition charge for financial tracking of course-related fees and refund calculation if placement',
    `prior_service_learning_placement_id` BIGINT COMMENT 'Self-referencing FK on service_learning_placement (prior_service_learning_placement_id)',
    `academic_credit_hours` DECIMAL(18,2) COMMENT 'Number of academic credit hours associated with this service learning placement if it is embedded within a for-credit course. Null for purely co-curricular placements.',
    `actual_end_date` DATE COMMENT 'Actual date on which the student completed or terminated service activities at the placement site, which may differ from the planned end date.',
    `approval_date` DATE COMMENT 'Date on which the service learning placement was officially approved by the institution or program coordinator.',
    `background_check_completion_date` DATE COMMENT 'Date on which the student completed the required background check or clearance for this service learning placement.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether the service learning site requires the student to complete a background check or clearance before beginning service activities.',
    `co_curricular_credit_awarded` DECIMAL(18,2) COMMENT 'Amount of co-curricular credit or recognition units awarded to the student upon successful completion of this service learning placement, if applicable to the institutions co-curricular transcript or recognition program.',
    `completed_service_hours` DECIMAL(18,2) COMMENT 'Total number of service hours the student has completed at this placement site as of the last update, tracked toward the required hours commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this service learning placement record was first created in the system.',
    `hours_verification_method` STRING COMMENT 'Method used to verify and document the students completed service hours, such as paper timesheet, supervisor confirmation, student self-report, or electronic tracking system.. Valid values are `timesheet|supervisor_confirmation|self_report|electronic_tracking`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this service learning placement record was last updated or modified in the system.',
    `learning_objectives` STRING COMMENT 'Documented learning objectives or outcomes that the student is expected to achieve through this service learning placement, aligned with course or program goals.',
    `liability_waiver_signed_flag` BOOLEAN COMMENT 'Indicates whether the student has signed the required liability waiver or release form for participation in this service learning placement.',
    `placement_approval_status` STRING COMMENT 'Approval status of the service learning placement by the institution or program coordinator, indicating whether the placement has been approved, is pending review, denied, or conditionally approved.. Valid values are `pending|approved|denied|conditional`',
    `placement_end_date` DATE COMMENT 'Date on which the student is scheduled to complete service activities at the placement site. Represents the planned conclusion of the service learning commitment.',
    `placement_notes` STRING COMMENT 'Free-text notes or comments about the service learning placement, including special arrangements, accommodations, or observations by staff or faculty.',
    `placement_number` STRING COMMENT 'Business-facing unique identifier or reference number for this service learning placement, used for tracking and communication purposes.',
    `placement_start_date` DATE COMMENT 'Date on which the student begins service activities at the placement site. Represents the effective start of the service learning commitment.',
    `placement_status` STRING COMMENT 'Current lifecycle status of the service learning placement indicating whether it is pending approval, actively in progress, completed, cancelled by the institution, or withdrawn by the student.. Valid values are `pending|active|completed|cancelled|withdrawn`',
    `placement_type` STRING COMMENT 'Classification of the service learning placement indicating whether it is embedded within a course, part of co-curricular programming, a hybrid model, or an independent study arrangement.. Valid values are `course_embedded|co_curricular|hybrid|independent_study`',
    `reflection_required_flag` BOOLEAN COMMENT 'Indicates whether the student is required to submit written or oral reflections on their service learning experience as part of the placement requirements.',
    `reflection_submission_date` DATE COMMENT 'Date on which the student submitted their service learning reflection materials for review.',
    `reflection_submission_status` STRING COMMENT 'Current status of the students reflection submission requirement, indicating whether reflection is not required, pending submission, submitted and under review, approved, or requires revision.. Valid values are `not_required|pending|submitted|approved|revision_needed`',
    `required_service_hours` DECIMAL(18,2) COMMENT 'Total number of service hours the student is required to complete at this placement site to fulfill course or co-curricular requirements.',
    `site_address_line1` STRING COMMENT 'First line of the street address for the service learning site location.',
    `site_address_line2` STRING COMMENT 'Second line of the street address for the service learning site location, typically used for suite or unit numbers.',
    `site_city` STRING COMMENT 'City where the service learning site is located.',
    `site_contact_email` STRING COMMENT 'Email address of the primary contact person at the service learning site for coordination and communication purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `site_contact_name` STRING COMMENT 'Full name of the primary contact person at the service learning site, typically the on-site supervisor or coordinator.',
    `site_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the service learning site.',
    `site_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the service learning site.',
    `site_country_code` STRING COMMENT 'Three-letter ISO country code for the service learning site location.. Valid values are `^[A-Z]{3}$`',
    `site_name` STRING COMMENT 'Name of the community organization, agency, or institution where the student is performing service learning activities.',
    `site_organization_type` STRING COMMENT 'Classification of the service learning site organization by sector type, such as nonprofit, government agency, K-12 educational institution, healthcare facility, faith-based organization, corporate entity, or other. [ENUM-REF-CANDIDATE: nonprofit|government|k12_education|healthcare|faith_based|corporate|other — 7 candidates stripped; promote to reference product]',
    `site_postal_code` STRING COMMENT 'Postal or ZIP code for the service learning site location.',
    `site_state_province` STRING COMMENT 'State or province where the service learning site is located.',
    `transportation_provided_flag` BOOLEAN COMMENT 'Indicates whether the institution provides transportation assistance to the student for travel to and from the service learning site.',
    CONSTRAINT pk_service_learning_placement PRIMARY KEY(`service_learning_placement_id`)
) COMMENT 'Transactional record of a students placement in a community service or service-learning site as part of a co-curricular or course-embedded service requirement. Captures placement site name, site organization type (nonprofit, government, K-12, healthcare), placement start and end dates, required service hours, completed service hours, supervisor name and contact, learning objectives, reflection submission status, and co-curricular credit awarded. Tracks the operational fulfillment of service-learning commitments distinct from academic course enrollment.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`wellness_program` (
    `wellness_program_id` BIGINT COMMENT 'Unique identifier for the wellness program record. Primary key for the wellness program entity.',
    `term_id` BIGINT COMMENT 'Reference to the academic term during which this wellness program offering is scheduled. Links to the academic calendar for reporting and planning.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wellness programs operate within student affairs cost centers (counseling, health promotion). Link enables program cost tracking, budget management, and supports cost-per-participant analysis essentia',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Many wellness programs are funded by federal grants (substance abuse prevention, mental health services, wellness promotion). Link supports grant accounting, ensures compliance with grant restrictions',
    `prerequisite_wellness_program_id` BIGINT COMMENT 'Self-referencing FK on wellness_program (prerequisite_wellness_program_id)',
    `assessment_method` STRING COMMENT 'Approach used to evaluate student learning and program effectiveness, such as pre/post surveys, reflective journals, or behavioral assessments.',
    `attendance_requirement_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of sessions a student must attend to receive completion credit for the wellness program.',
    `cocurricular_competency_area` STRING COMMENT 'The co-curricular learning competency domain this wellness program addresses, such as personal wellness, health literacy, or community engagement.',
    `cocurricular_credit_eligible_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this wellness program qualifies for co-curricular transcript credit or recognition.',
    `cocurricular_credit_hours` DECIMAL(18,2) COMMENT 'Number of co-curricular credit hours awarded upon successful completion of the wellness program. Null if program is not credit-eligible.',
    `completion_criteria` STRING COMMENT 'Requirements students must meet to successfully complete the wellness program, including attendance thresholds, assignments, or assessments.',
    `confidentiality_level` STRING COMMENT 'Level of privacy protection applied to student participation records in this wellness program. Restricted programs may involve sensitive health topics requiring enhanced privacy.. Valid values are `public|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the wellness program record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_format` STRING COMMENT 'Method by which the wellness program content is delivered to participating students. Determines scheduling and resource requirements.. Valid values are `workshop|online_module|peer_led|one_on_one|hybrid|group_session`',
    `facilitator_credentials` STRING COMMENT 'Professional certifications, licenses, or qualifications held by the program facilitator relevant to the wellness program content area.',
    `facilitator_name` STRING COMMENT 'Name of the primary staff member, clinician, or peer educator responsible for leading the wellness program.',
    `fee_waiver_available_flag` BOOLEAN COMMENT 'Indicates whether financial need-based fee waivers are available for students who cannot afford the program fee.',
    `grant_funded_flag` BOOLEAN COMMENT 'Indicates whether the wellness program is supported by external grant funding from government agencies, foundations, or health organizations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the wellness program record was most recently updated. Used for change tracking and data quality monitoring.',
    `learning_outcomes` STRING COMMENT 'Specific knowledge, skills, or behaviors students are expected to gain or demonstrate upon completion of the wellness program. Aligned with assessment practices.',
    `location_name` STRING COMMENT 'Name of the building, room, or facility where in-person wellness program sessions are held. Null for fully online programs.',
    `minimum_enrollment` STRING COMMENT 'Minimum number of student participants required for the program to run. Programs below this threshold may be cancelled.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the staff member who last modified the wellness program record. Used for accountability and audit purposes.',
    `online_platform` STRING COMMENT 'Name of the digital platform or learning management system used for online or hybrid wellness program delivery, such as Canvas, Zoom, or custom portal.',
    `partner_organizations` STRING COMMENT 'Names of external community organizations, health agencies, or campus partners collaborating on program delivery or funding.',
    `prerequisite_requirements` STRING COMMENT 'Any prior programs, trainings, or qualifications students must complete before enrolling in this wellness program. Null if no prerequisites exist.',
    `program_capacity` STRING COMMENT 'Maximum number of students who can participate in a single offering of the wellness program. Used for enrollment management and resource planning.',
    `program_code` STRING COMMENT 'Unique business identifier code for the wellness program used for catalog reference and registration systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the wellness program objectives, content, activities, and expected student outcomes. Used in marketing and catalog materials.',
    `program_end_date` DATE COMMENT 'Date when the wellness program offering concludes. Used for completion tracking and co-curricular credit verification.',
    `program_fee_amount` DECIMAL(18,2) COMMENT 'Cost charged to students for participation in the wellness program. Zero if the program is offered at no charge.',
    `program_name` STRING COMMENT 'Official name of the wellness program as displayed in student-facing materials and program catalogs.',
    `program_start_date` DATE COMMENT 'Date when the wellness program offering begins. Used for scheduling and student registration planning.',
    `program_status` STRING COMMENT 'Current operational status of the wellness program indicating availability for student enrollment and participation.. Valid values are `active|inactive|suspended|archived|planned`',
    `program_type` STRING COMMENT 'Classification of the wellness program by its primary health promotion focus area. Determines program objectives and target outcomes.. Valid values are `substance_abuse_prevention|sexual_health_education|stress_management|nutrition_counseling|fitness_challenge|peer_health_education`',
    `registration_close_date` DATE COMMENT 'Date when student registration closes for the wellness program. After this date, enrollment may be restricted or require special permission.',
    `registration_open_date` DATE COMMENT 'Date when student registration opens for the wellness program. Used for enrollment management and communications.',
    `registration_required_flag` BOOLEAN COMMENT 'Indicates whether students must pre-register for the wellness program or if it is available on a drop-in basis.',
    `session_count` STRING COMMENT 'Total number of individual sessions or meetings that comprise the complete wellness program. Used for attendance tracking and completion criteria.',
    `session_duration_minutes` STRING COMMENT 'Length of each program session in minutes. Used for scheduling and student time commitment planning.',
    `sponsoring_department` STRING COMMENT 'Name of the student affairs department or unit responsible for administering and funding the wellness program, such as Student Health Services or Counseling Center.',
    `target_population` STRING COMMENT 'Description of the intended student audience for the wellness program, including class year, demographic focus, or special population criteria.',
    `total_contact_hours` DECIMAL(18,2) COMMENT 'Total number of instructional or facilitated hours students will complete across all program sessions. Used for co-curricular credit calculation.',
    CONSTRAINT pk_wellness_program PRIMARY KEY(`wellness_program_id`)
) COMMENT 'Master record for structured wellness, health promotion, and prevention programs offered through student health or student affairs. Captures program name, program type (substance abuse prevention, sexual health education, stress management, nutrition counseling, fitness challenge, peer health education), delivery format (workshop, online module, peer-led, one-on-one), target population, program capacity, facilitator name, program dates, completion criteria, and co-curricular credit eligibility. Provides the catalog of wellness programming available to students.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`wellness_participation` (
    `wellness_participation_id` BIGINT COMMENT 'Unique identifier for the wellness participation record. Primary key for tracking individual student engagement in campus wellness programs.',
    `conduct_case_id` BIGINT COMMENT 'Identifier of the student conduct case if this wellness participation is part of a conduct sanction or educational requirement. Null if not conduct-related.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Wellness program participants need identity accounts for accessing program materials, scheduling appointments, and virtual wellness sessions. Real business process: authentication for wellness platfor',
    `modified_by_user_identity_account_id` BIGINT COMMENT 'Identifier of the system user who last modified this wellness participation record. Used for audit trail and accountability.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Wellness program fees are paid through billing system. Links program participation to payment transaction for payment verification, refund processing upon withdrawal, and revenue reconciliation of wel',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who referred the student to the wellness program, if applicable. Null for self-referrals.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student participating in the wellness program. Links to the student master record.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Wellness programs with fees (fitness classes, nutrition counseling) bill to student accounts. Links program participation to billing account for charge posting, payment tracking, and fee waiver proces',
    `term_id` BIGINT COMMENT 'Academic term during which the wellness participation occurred. Links to the academic term master record.',
    `wellness_program_id` BIGINT COMMENT 'Unique identifier of the wellness program in which the student is participating. Links to the wellness program catalog.',
    `prior_wellness_participation_id` BIGINT COMMENT 'Self-referencing FK on wellness_participation (prior_wellness_participation_id)',
    `assessment_improvement_score` DECIMAL(18,2) COMMENT 'Calculated difference between post-assessment and pre-assessment scores, representing the measurable improvement in wellness indicators. Positive values indicate improvement.',
    `attendance_count` STRING COMMENT 'Number of sessions or events the student attended as part of this wellness program. Used to track engagement level.',
    `cocurricular_category` STRING COMMENT 'Category or domain of co-curricular learning this wellness program contributes to (e.g., personal wellness, health literacy, stress management).',
    `cocurricular_credit_awarded` DECIMAL(18,2) COMMENT 'Number of co-curricular credits awarded to the student for completing this wellness program. Used for co-curricular transcript and engagement tracking.',
    `completion_date` DATE COMMENT 'Date when the student completed all requirements of the wellness program. Null if program is not yet completed or was withdrawn.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of program requirements completed by the student, calculated as attendance count divided by required attendance count. Used to track progress toward completion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wellness participation record was first created in the system. Used for audit trail and data lineage.',
    `delivery_mode` STRING COMMENT 'Mode of delivery for the wellness program (in-person, virtual, hybrid, self-paced). Important for accessibility and program planning.. Valid values are `in-person|virtual|hybrid|self-paced`',
    `enrollment_date` DATE COMMENT 'Date when the student enrolled in or registered for the wellness program. Represents the principal business event timestamp for this participation record.',
    `fee_waived_flag` BOOLEAN COMMENT 'Indicates whether the program fee was waived for this student due to financial need, scholarship, or other institutional policy.',
    `fee_waiver_reason` STRING COMMENT 'Explanation or reason code for why the program fee was waived for this student. Null if fee was not waived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this wellness participation record was last updated in the system. Used for audit trail and change tracking.',
    `location` STRING COMMENT 'Physical or virtual location where the wellness program was conducted (e.g., Health Center Room 201, Virtual via Zoom, Recreation Center).',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether participation in this wellness program was mandatory for the student (e.g., conduct sanction, housing requirement) or voluntary.',
    `notes` STRING COMMENT 'Free-text notes or comments about this wellness participation record, including special circumstances, accommodations provided, or follow-up actions needed.',
    `participation_number` STRING COMMENT 'Business-facing unique identifier or confirmation number for this wellness participation record, used for student communication and tracking.',
    `participation_status` STRING COMMENT 'Current status of the students participation in the wellness program. Tracks lifecycle from enrollment through completion or withdrawal.. Valid values are `enrolled|completed|withdrew|no-show|in-progress|cancelled`',
    `post_assessment_date` DATE COMMENT 'Date when the post-program assessment was completed by the student.',
    `post_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score from the post-program assessment measuring wellness indicators after program completion. Used to measure program effectiveness and student improvement.',
    `pre_assessment_date` DATE COMMENT 'Date when the pre-program assessment was completed by the student.',
    `pre_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score from the pre-program assessment measuring baseline wellness indicators. Used to measure program effectiveness through pre/post comparison.',
    `program_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the student for participating in this wellness program. May be zero for free programs. Expressed in institutional base currency (USD).',
    `referral_source` STRING COMMENT 'Source or channel through which the student was referred to or learned about the wellness program. Critical for understanding program reach and effectiveness. [ENUM-REF-CANDIDATE: self-referred|counselor-referred|health-center|conduct-sanction|faculty-referred|peer-referred|residence-life — 7 candidates stripped; promote to reference product]',
    `required_attendance_count` STRING COMMENT 'Number of sessions or events the student was required to attend to complete the wellness program. Used to calculate completion percentage.',
    `satisfaction_comments` STRING COMMENT 'Free-text comments provided by the student regarding their experience with the wellness program. Used for qualitative program assessment.',
    `satisfaction_rating` STRING COMMENT 'Student satisfaction rating for the wellness program, typically on a scale of 1-5 or 1-10. Used for program quality assessment and continuous improvement.',
    `satisfaction_rating_scale` STRING COMMENT 'The scale used for the satisfaction rating (e.g., 1-5, 1-10) to provide context for interpreting the satisfaction rating value.. Valid values are `1-5|1-10`',
    `start_date` DATE COMMENT 'Date when the student began actively participating in the wellness program. May differ from enrollment date for programs with scheduled start dates.',
    `withdrawal_date` DATE COMMENT 'Date when the student withdrew from the wellness program before completion. Null if student did not withdraw.',
    `withdrawal_reason` STRING COMMENT 'Explanation or reason code for why the student withdrew from the wellness program. Used for program improvement and retention analysis.',
    CONSTRAINT pk_wellness_participation PRIMARY KEY(`wellness_participation_id`)
) COMMENT 'Transactional record of a students participation in or completion of a campus wellness program. Captures enrollment date, completion date, completion status (enrolled, completed, withdrew, no-show), pre/post assessment scores where applicable, satisfaction rating, co-curricular credit awarded, and referral source (self-referred, counselor-referred, conduct sanction, health center). Enables tracking of student wellness engagement and program effectiveness measurement.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`roommate_group` (
    `roommate_group_id` BIGINT COMMENT 'Unique identifier for the roommate group record. Primary key for the roommate group entity.',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which this roommate group is formed. Links to the term during which housing assignment will occur.',
    `residence_hall_id` BIGINT COMMENT 'Reference to the residence hall building where the roommate group has been assigned. Populated when group_status reaches assigned.',
    `identity_account_id` BIGINT COMMENT 'System user identifier of the person who created the roommate group record (typically the group leader student or housing staff member).',
    `last_modified_by_user_identity_account_id` BIGINT COMMENT 'System user identifier of the person who most recently modified the roommate group record.',
    `profile_id` BIGINT COMMENT 'Reference to the student who initiated or leads the roommate group. This student typically has administrative privileges to add or remove members.',
    `merged_from_roommate_group_id` BIGINT COMMENT 'Self-referencing FK on roommate_group (merged_from_roommate_group_id)',
    `accommodation_notes` STRING COMMENT 'Confidential notes describing special accommodation requirements for the roommate group, used by housing staff during assignment process.',
    `all_members_confirmed_flag` BOOLEAN COMMENT 'Indicates whether all members of the roommate group have confirmed their mutual agreement to room together. True when confirmed_member_count equals target_group_size.',
    `application_deadline_date` DATE COMMENT 'Final date by which the roommate group must be complete and all members confirmed to be considered for housing assignment in the target term.',
    `assigned_room_number` STRING COMMENT 'Specific room number within the assigned residence hall where the roommate group will reside.',
    `assignment_date` DATE COMMENT 'Date when the roommate group was assigned to a specific residence hall room by the housing office.',
    `building_preference_1` STRING COMMENT 'Primary residence hall building preference for the roommate group.',
    `building_preference_2` STRING COMMENT 'Secondary residence hall building preference for the roommate group.',
    `building_preference_3` STRING COMMENT 'Tertiary residence hall building preference for the roommate group.',
    `completion_date` DATE COMMENT 'Date when all members confirmed their participation and the group reached complete status, making it eligible for housing assignment.',
    `confirmed_member_count` STRING COMMENT 'Number of group members who have explicitly confirmed their participation in the roommate group.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the roommate group record was first created in the database.',
    `current_member_count` STRING COMMENT 'Current number of students who have joined this roommate group, including those pending confirmation.',
    `dissolution_date` DATE COMMENT 'Date when the roommate group was dissolved or cancelled, either by member request or administrative action.',
    `dissolution_reason` STRING COMMENT 'Explanation for why the roommate group was dissolved or cancelled (e.g., member withdrawal, mutual agreement, administrative action, missed deadline).',
    `formation_date` DATE COMMENT 'Date when the roommate group was initially created by the group leader.',
    `formation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the roommate group record was created in the housing system.',
    `gender_inclusive_housing_flag` BOOLEAN COMMENT 'Indicates whether the roommate group is requesting gender-inclusive housing, allowing students of different gender identities to room together.',
    `group_name` STRING COMMENT 'Optional friendly name assigned by the group members to identify their roommate group (e.g., The Study Squad, Engineering Friends).',
    `group_notes` STRING COMMENT 'Free-text notes about the roommate group maintained by housing staff, including special considerations, communication history, or processing notes.',
    `group_number` STRING COMMENT 'Business identifier for the roommate group, typically displayed to students and housing staff. Format: RMG- followed by numeric sequence.. Valid values are `^RMG-[0-9]{6,10}$`',
    `group_status` STRING COMMENT 'Current lifecycle status of the roommate group. Forming: group is being assembled; Pending Confirmation: awaiting member confirmations; Complete: all members confirmed and ready for assignment; Assigned: group has been assigned to housing; Dissolved: group disbanded before assignment; Cancelled: group cancelled by members or staff; Expired: group not completed before deadline. [ENUM-REF-CANDIDATE: forming|pending_confirmation|complete|assigned|dissolved|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `invitation_code` STRING COMMENT 'Unique code generated for the roommate group that prospective members can use to join the group. Typically shared among friends planning to room together.. Valid values are `^[A-Z0-9]{6,12}$`',
    `invitation_expiration_date` DATE COMMENT 'Date after which the invitation code is no longer valid for new members to join the roommate group.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this roommate group record is currently active in the system. False for historical or soft-deleted records.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the roommate group record was most recently updated.',
    `lifestyle_preference` STRING COMMENT 'Shared lifestyle preferences for the roommate group (e.g., quiet study environment, substance-free, honors community, STEM-focused).',
    `lottery_number` STRING COMMENT 'Random lottery number assigned to the roommate group for housing selection priority within their priority group. Lower numbers typically receive earlier selection times.',
    `priority_group` STRING COMMENT 'Priority classification for housing assignment (e.g., returning residents, honors students, athletes, first-year students). Used to sequence assignment processing.',
    `room_type_preference` STRING COMMENT 'Type of room the roommate group prefers to be assigned to, must align with target group size.. Valid values are `single|double|triple|quad|suite|apartment`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system from which this roommate group record originated (e.g., BANNER, SLATE, STARREZ).',
    `source_system_record_code` STRING COMMENT 'Primary key or unique identifier of this roommate group record in the source operational system, used for data lineage and reconciliation.',
    `special_accommodation_requested_flag` BOOLEAN COMMENT 'Indicates whether any member of the roommate group has requested special housing accommodations (e.g., ADA accessibility, medical needs).',
    `target_group_size` STRING COMMENT 'Intended number of members for this roommate group, typically matching the bed count of desired room type (e.g., 2 for double, 3 for triple, 4 for quad).',
    CONSTRAINT pk_roommate_group PRIMARY KEY(`roommate_group_id`)
) COMMENT 'Master record for a student-formed roommate group created during the housing application process. Captures group formation date, group status (forming, complete, assigned, dissolved), group size, group leader student reference, mutual confirmation status of all members, and the housing application term. Enables the housing office to honor roommate preferences during the room assignment process and tracks the lifecycle of roommate group formation from self-selection through assignment.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`housing_waitlist` (
    `housing_waitlist_id` BIGINT COMMENT 'Unique identifier for the housing waitlist record. Primary key.',
    `term_id` BIGINT COMMENT 'The academic term for which the student is seeking housing. Links to the term master record.',
    `employee_id` BIGINT COMMENT 'The identifier of the housing staff member who processed or last updated the waitlist entry. Links to the staff or employee master record.',
    `enrollment_application_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_application. Business justification: Housing waitlists are populated by admitted students who confirmed enrollment but lack housing assignments. Linking to the application enables prioritization by admit type (FTIAC, transfer, internatio',
    `housing_application_id` BIGINT COMMENT 'Foreign key linking to studentlife.housing_application. Business justification: A housing waitlist entry is created when a housing application cannot be immediately fulfilled due to capacity constraints. Business process: student submits housing_application, housing office determ',
    `llc_program_id` BIGINT COMMENT 'FK to studentlife.llc_program',
    `residence_hall_id` BIGINT COMMENT 'The residence hall that was offered to the student from the waitlist. Null if no offer has been made.',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student on the waitlist. Links to the student master record.',
    `building_id` BIGINT COMMENT 'The specific residence hall or building the student is waiting for, if applicable. Null if the waitlist is for general housing without a building preference.',
    `roommate_group_id` BIGINT COMMENT 'Foreign key linking to studentlife.roommate_group. Business justification: Students on the housing waitlist may have formed a roommate group during their application process. The waitlist entry should track which roommate group (if any) the student is part of, so when housin',
    `transferred_from_housing_waitlist_id` BIGINT COMMENT 'Self-referencing FK on housing_waitlist (transferred_from_housing_waitlist_id)',
    `accommodation_description` STRING COMMENT 'Detailed description of the special accommodations requested by the student. May include medical, accessibility, or other special needs. Confidential information.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this waitlist record was first created in the system. Audit trail field.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The amount of the deposit required to remain on the waitlist or to accept an offer. Null if no deposit is required.',
    `deposit_payment_date` DATE COMMENT 'The date the deposit was paid by the student. Null if not yet paid or not required.',
    `deposit_payment_status` STRING COMMENT 'The payment status of the required deposit. Indicates whether the deposit has been paid, is pending, has been waived, refunded, or is not required.. Valid values are `paid|pending|waived|refunded|not_required`',
    `deposit_required_flag` BOOLEAN COMMENT 'Indicates whether a deposit is required to remain on the waitlist or to accept an offer. True if required, False otherwise.',
    `entry_date` DATE COMMENT 'The date the student was placed on the housing waitlist. This is the principal business event timestamp for this transactional record.',
    `gender_inclusive_housing_flag` BOOLEAN COMMENT 'Indicates whether the student has requested gender-inclusive housing. True if requested, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this waitlist record was last modified or updated in the system. Audit trail field.',
    `notes` STRING COMMENT 'Free-text notes or comments about the waitlist entry. May include staff observations, special circumstances, or processing notes.',
    `notification_sent_date` DATE COMMENT 'The date the most recent notification was sent to the student regarding their waitlist status or offer. Null if no notification has been sent.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification (email, letter, portal message) has been sent to the student regarding their waitlist status or offer. True if sent, False otherwise.',
    `offer_date` DATE COMMENT 'The date housing was offered to the student from the waitlist. Null if no offer has been made yet.',
    `offer_response_date` DATE COMMENT 'The date the student responded to the housing offer (accepted or declined). Null if no response has been received.',
    `offer_response_deadline` DATE COMMENT 'The deadline by which the student must respond to the housing offer. Null if no offer has been made. After this date, the offer may expire.',
    `offered_room_number` STRING COMMENT 'The specific room number that was offered to the student from the waitlist. Null if no offer has been made.',
    `offered_room_type` STRING COMMENT 'The type of room that was offered to the student (e.g., single, double, triple, suite). Null if no offer has been made.',
    `priority_group` STRING COMMENT 'The priority group or category the student belongs to for waitlist processing (e.g., returning_student, freshman, transfer, athlete, honors, medical_need). Used to segment and prioritize waitlist processing.',
    `priority_tier` STRING COMMENT 'The priority tier assigned to the student for waitlist processing. Higher tiers (tier_1) receive priority over lower tiers. Used to manage special populations such as returning students, athletes, or students with documented needs.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|standard`',
    `removal_date` DATE COMMENT 'The date the student was removed from the waitlist. Applicable when status is removed, cancelled, or expired.',
    `removal_reason` STRING COMMENT 'The reason the student was removed from the waitlist (e.g., student_request, no_response, enrolled_elsewhere, disciplinary, administrative). Null if still active or offered.',
    `requested_room_type` STRING COMMENT 'The type of room the student is waiting for (e.g., single, double, triple, suite, apartment). May be null if the waitlist is for general housing without a specific room type preference.',
    `source_system_code` STRING COMMENT 'The code or identifier of the source system from which this waitlist record originated (e.g., Banner, Slate, custom housing system). Used for data lineage and integration tracking.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this waitlist record in the source system. Used for data lineage, reconciliation, and integration tracking.',
    `special_accommodation_flag` BOOLEAN COMMENT 'Indicates whether the student has requested special accommodations (e.g., ADA accessibility, medical needs) for their housing assignment. True if accommodations are requested, False otherwise.',
    `waitlist_number` STRING COMMENT 'The externally-known waitlist confirmation or tracking number provided to the student.',
    `waitlist_position` STRING COMMENT 'The students current position or rank on the waitlist. Lower numbers indicate higher priority. Position may change as students ahead are assigned or removed.',
    `waitlist_status` STRING COMMENT 'Current status of the waitlist entry in its lifecycle. Active indicates the student is waiting; offered indicates housing has been offered; accepted indicates the student accepted the offer; declined indicates the student declined the offer; expired indicates the offer expired without response; removed indicates the student was removed from the waitlist; cancelled indicates the student cancelled their waitlist entry. [ENUM-REF-CANDIDATE: active|offered|accepted|declined|expired|removed|cancelled — 7 candidates stripped; promote to reference product]',
    `waitlist_type` STRING COMMENT 'The type or category of waitlist the student is on. Indicates whether the waitlist is for general housing, a specific building, a specific room type, a Living Learning Community (LLC), honors housing, or medical accommodation housing.. Valid values are `general|building_specific|room_type_specific|llc|honors|medical_accommodation`',
    CONSTRAINT pk_housing_waitlist PRIMARY KEY(`housing_waitlist_id`)
) COMMENT 'Transactional record tracking a students position on the campus housing waitlist when no immediate assignment is available. Captures waitlist entry date, waitlist position number, waitlist type (general, specific building, specific room type, LLC), priority tier, waitlist status (active, offered, accepted, declined, expired, removed), offer date if applicable, offer response deadline, and the term for which housing is sought. Enables housing operations to manage demand overflow and communicate availability to waitlisted students.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`llc_program` (
    `llc_program_id` BIGINT COMMENT 'Unique identifier for the Living Learning Community program. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Living-Learning Communities are academically themed residential programs tied to specific majors (e.g., Engineering LLC, Honors LLC, Business LLC). Business processes: LLC eligibility verification by ',
    `identity_account_id` BIGINT COMMENT 'Identifier of the system user who last modified this LLC program record. Used for audit trail and accountability.',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Living-learning communities operate within housing or academic affairs cost centers with dedicated budgets for programming, faculty fellows, and special amenities. Link enables program cost allocation',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department or college that sponsors or partners with this LLC program. Links to the academic organizational structure.',
    `primary_llc_employee_id` BIGINT COMMENT 'Unique identifier of the staff member serving as the administrative coordinator for this LLC program. Links to the employee master record.',
    `instructor_id` BIGINT COMMENT 'Unique identifier of the faculty member serving as the academic fellow for this LLC program. Links to the faculty master record.',
    `residence_hall_id` BIGINT COMMENT 'Identifier of the residence hall where this LLC program is housed. Links to the residence hall master record.',
    `parent_llc_program_id` BIGINT COMMENT 'Self-referencing FK on llc_program (parent_llc_program_id)',
    `academic_course_requirement` STRING COMMENT 'Description of any required academic courses that LLC participants must enroll in as part of the program (e.g., Must enroll in UNIV 101 LLC Seminar, Complete one course from approved list).',
    `academic_year` STRING COMMENT 'Academic year for which this LLC program configuration is effective, in format YYYY-YYYY (e.g., 2023-2024). Programs may have different configurations across years.. Valid values are `^d{4}-d{4}$`',
    `application_deadline_date` DATE COMMENT 'Final date by which students must submit their LLC program application for the upcoming academic year. Null if no application is required.',
    `application_required_flag` BOOLEAN COMMENT 'Indicates whether students must submit a separate application to be considered for admission to this LLC program. True if application required, False if open enrollment.',
    `assessment_method` STRING COMMENT 'Description of how student learning outcomes and program effectiveness are measured (e.g., Pre/post surveys, Focus groups, Retention analysis, GPA comparison).',
    `cocurricular_requirements` STRING COMMENT 'Description of mandatory co-curricular activities, events, or service hours that LLC participants must complete (e.g., Attend 6 academic seminars per semester, Complete 20 hours of community service, Participate in monthly faculty dinners).',
    `cohort_capacity` STRING COMMENT 'Maximum number of students that can be enrolled in this LLC program for a given academic year. Represents the bed capacity allocated to the program.',
    `contact_email` STRING COMMENT 'Primary email address for inquiries about this LLC program. Used by prospective students and parents for questions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for inquiries about this LLC program. Used by prospective students and parents for questions.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this LLC program record was first created in the system. Used for audit trail and data lineage.',
    `current_enrollment_count` STRING COMMENT 'Current number of students enrolled in this LLC program for the active academic term. Updated as students are assigned or removed.',
    `effective_end_date` DATE COMMENT 'Date when this LLC program configuration expires or is no longer available. Null for ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date when this LLC program configuration becomes effective and available for student applications or assignments.',
    `eligible_class_levels` STRING COMMENT 'Academic class levels eligible to participate in this LLC program (e.g., First Year Only, First and Second Year, All Undergraduates, Graduate Students). Defines the target student population.',
    `floor_assignment` STRING COMMENT 'Specific floor or floors within the residence hall designated for this LLC program. May be a single floor number or range (e.g., 3, 2-3, East Wing Floor 4).',
    `gpa_requirement` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA required for admission or continued participation in this LLC program. Null if no GPA requirement exists. Typically on a 4.0 scale.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this LLC program record was most recently updated. Used for audit trail and change tracking.',
    `learning_outcomes` STRING COMMENT 'Documented learning outcomes that students are expected to achieve through participation in this LLC program. Used for assessment and accreditation reporting.',
    `marketing_description` STRING COMMENT 'Student-facing promotional description of the LLC program used in recruitment materials, housing brochures, and the institutional website. Emphasizes benefits and unique features.',
    `minimum_enrollment` STRING COMMENT 'Minimum number of students required to launch or sustain this LLC program. Programs below this threshold may be cancelled or consolidated.',
    `partnership_organizations` STRING COMMENT 'Names of external organizations, community partners, or campus units that collaborate with this LLC program to provide programming, resources, or experiential learning opportunities.',
    `program_code` STRING COMMENT 'Short alphanumeric code used to identify the LLC program in student information systems and housing applications. Typically 3-10 characters.. Valid values are `^[A-Z0-9]{3,10}$`',
    `program_fee_amount` DECIMAL(18,2) COMMENT 'Additional fee charged to students participating in this LLC program beyond standard housing costs. Covers special programming, materials, or activities. Null if no additional fee.',
    `program_fee_period` STRING COMMENT 'Billing frequency for the LLC program fee. Indicates whether the fee is charged per term, per semester, per year, or as a one-time charge.. Valid values are `Per Term|Per Semester|Per Year|One Time`',
    `program_name` STRING COMMENT 'Full official name of the Living Learning Community program as it appears in marketing materials and student-facing communications.',
    `program_short_name` STRING COMMENT 'Abbreviated or informal name of the LLC program used in internal communications and space management systems.',
    `program_status` STRING COMMENT 'Current operational status of the LLC program. Active programs are accepting applications and enrolling students. Inactive or discontinued programs are no longer offered. Pilot programs are in trial phase.. Valid values are `Active|Inactive|Suspended|Under Review|Pilot|Discontinued`',
    `selection_process` STRING COMMENT 'Method used to select students for admission to the LLC program when applications exceed capacity. Common processes include first-come-first-served, lottery, holistic review, GPA threshold, interview, essay review, or faculty nomination. [ENUM-REF-CANDIDATE: First Come First Served|Lottery|Holistic Review|GPA Threshold|Interview|Essay Review|Faculty Nomination — 7 candidates stripped; promote to reference product]',
    `special_amenities` STRING COMMENT 'Description of unique physical amenities or resources available to LLC participants (e.g., Dedicated study lounge, Maker space, Language practice room, Faculty-in-residence apartment).',
    `theme_category` STRING COMMENT 'Primary thematic focus area of the LLC program that defines its academic or co-curricular identity. Common categories include STEM, honors, sustainability, social justice, entrepreneurship, language immersion, arts, health sciences, leadership, service learning, global studies, and first-year experience. [ENUM-REF-CANDIDATE: STEM|Honors|Sustainability|Social Justice|Entrepreneurship|Language Immersion|Arts|Health Sciences|Leadership|Service Learning|Global Studies|First Year Experience — 12 candidates stripped; promote to reference product]',
    `theme_description` STRING COMMENT 'Detailed narrative description of the LLC program theme, learning objectives, and expected student outcomes. Used in recruitment materials and program documentation.',
    `website_url` STRING COMMENT 'Web address of the dedicated page or site providing detailed information about this LLC program, including application instructions and program benefits.',
    `wing_section` STRING COMMENT 'Specific wing, section, or zone within the residence hall designated for this LLC program (e.g., North Wing, Tower A, Section B).',
    CONSTRAINT pk_llc_program PRIMARY KEY(`llc_program_id`)
) COMMENT 'Master record for Living Learning Community (LLC) programs offered within residence halls, which combine residential living with academic or thematic programming. Captures LLC name, LLC theme or focus area (STEM, honors, sustainability, social justice, entrepreneurship, language immersion), affiliated academic department or college, faculty fellow name, residence hall and floor assignment, application required flag, application deadline, cohort capacity, co-curricular requirements, and program status. LLCs are a distinct student affairs product that bridges housing and academic engagement.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`llc_enrollment` (
    `llc_enrollment_id` BIGINT COMMENT 'Unique identifier for the LLC enrollment record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the student affairs staff member who reviewed and processed the LLC application.',
    `enrollment_application_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_application. Business justification: Living-Learning Community applications are often part of or linked to the admissions application process. Tracking this connection supports targeted recruitment of high-ability students, yield strateg',
    `instructor_id` BIGINT COMMENT 'Unique identifier of the faculty member assigned as the students mentor within the Living Learning Community program.',
    `llc_program_id` BIGINT COMMENT 'Unique identifier of the LLC program in which the student is enrolled. Links to the LLC program master record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student enrolled in the Living Learning Community program. Links to the student master record.',
    `residence_hall_id` BIGINT COMMENT 'Unique identifier of the residence hall where the LLC program is housed and the student resides.',
    `studentlife_housing_assignment_id` BIGINT COMMENT 'Unique identifier linking this LLC enrollment to the students housing assignment record, establishing the residential component of the Living Learning Community.',
    `term_id` BIGINT COMMENT 'Unique identifier of the academic term (semester, quarter) for which the LLC enrollment is active. Links to the term master record.',
    `prior_llc_enrollment_id` BIGINT COMMENT 'Self-referencing FK on llc_enrollment (prior_llc_enrollment_id)',
    `academic_standing` STRING COMMENT 'The students academic standing status within the LLC program, reflecting their academic performance and compliance with program requirements.. Valid values are `good_standing|probation|suspension|dismissal`',
    `academic_year` STRING COMMENT 'The academic year for which the student is enrolled in the LLC program, formatted as YYYY-YYYY (e.g., 2023-2024).. Valid values are `^d{4}-d{4}$`',
    `acceptance_date` DATE COMMENT 'Date when the student was officially accepted into the Living Learning Community program.',
    `application_date` DATE COMMENT 'Date when the student submitted their application to join the Living Learning Community program.',
    `application_essay_submitted_flag` BOOLEAN COMMENT 'Indicator of whether the student submitted a required application essay as part of their LLC application (True) or not (False).',
    `application_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the student submitted their LLC application, including time of day for audit and sequencing purposes.',
    `cocurricular_participation_hours` DECIMAL(18,2) COMMENT 'Total number of hours the student has logged participating in co-curricular activities, events, and programming within the Living Learning Community.',
    `cohort_year` STRING COMMENT 'The year the student joined the LLC program, used to track cohort-based outcomes and retention.',
    `completion_date` DATE COMMENT 'Date when the student successfully completed all requirements of the Living Learning Community program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LLC enrollment record was first created in the system.',
    `enrollment_date` DATE COMMENT 'Date when the student officially enrolled in the LLC program, confirming their participation.',
    `enrollment_end_date` DATE COMMENT 'Effective end date of the students participation in the Living Learning Community program for the academic period.',
    `enrollment_fee_amount` DECIMAL(18,2) COMMENT 'Additional fee amount charged to the student for participation in the Living Learning Community program, if applicable.',
    `enrollment_notes` STRING COMMENT 'Free-text notes and comments related to the students LLC enrollment, including special circumstances, accommodations, or administrative remarks.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment number assigned to this LLC enrollment for tracking and reference purposes.',
    `enrollment_start_date` DATE COMMENT 'Effective start date of the students participation in the Living Learning Community program for the academic period.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the LLC enrollment. Tracks the students progression from application through program completion or withdrawal.. Valid values are `applied|accepted|enrolled|withdrawn|completed|denied`',
    `fee_waived_flag` BOOLEAN COMMENT 'Indicator of whether the LLC enrollment fee was waived for the student (True) or charged (False).',
    `gpa_at_enrollment` DECIMAL(18,2) COMMENT 'The students cumulative GPA at the time of LLC enrollment, used for eligibility verification and baseline tracking.',
    `gpa_requirement` DECIMAL(18,2) COMMENT 'Minimum GPA required for the student to remain in good standing within the LLC program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LLC enrollment record was most recently updated or modified.',
    `participation_hours_met_flag` BOOLEAN COMMENT 'Indicator of whether the student has met the required co-curricular participation hours threshold (True) or not (False).',
    `priority_group` STRING COMMENT 'Classification code indicating the students priority group for LLC placement (e.g., honors, first-year, transfer, special interest).',
    `program_completion_flag` BOOLEAN COMMENT 'Indicator of whether the student successfully completed the LLC program requirements (True) or did not complete (False).',
    `required_participation_hours` DECIMAL(18,2) COMMENT 'Minimum number of co-curricular participation hours required for successful completion of the LLC program.',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when the LLC application was reviewed and a decision was made by student affairs staff.',
    `room_number` STRING COMMENT 'Specific room number within the residence hall assigned to the student as part of their LLC enrollment.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this LLC enrollment data originated (e.g., Banner, Workday, custom housing system).',
    `transcript_notation_flag` BOOLEAN COMMENT 'Indicator of whether successful LLC program completion will be noted on the students official academic transcript (True) or not (False).',
    `waiver_reason` STRING COMMENT 'Explanation or reason code for why the LLC enrollment fee was waived for the student.',
    `withdrawal_date` DATE COMMENT 'Date when the student withdrew from the Living Learning Community program, if applicable.',
    `withdrawal_reason` STRING COMMENT 'Explanation or reason code for why the student withdrew from the LLC program.',
    CONSTRAINT pk_llc_enrollment PRIMARY KEY(`llc_enrollment_id`)
) COMMENT 'Transactional record of a students enrollment in a Living Learning Community (LLC) program for a given academic year. Captures application date, acceptance date, enrollment status (applied, accepted, enrolled, withdrawn, completed), academic year, housing assignment linkage, co-curricular participation hours logged within the LLC, and program completion flag. Tracks the students participation lifecycle within an LLC from application through program completion.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`hall_service_provision` (
    `hall_service_provision_id` BIGINT COMMENT 'Unique identifier for this residence hall IT service provisioning record. Primary key.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to the IT service being provisioned to the residence hall',
    `residence_hall_id` BIGINT COMMENT 'Foreign key linking to the residence hall receiving IT service provisioning',
    `bandwidth_allocation_mbps` STRING COMMENT 'Total bandwidth allocated in megabits per second for this IT service to this residence hall. Used for network capacity planning and service delivery.',
    `last_service_review_date` DATE COMMENT 'Date of the most recent service review or assessment for this hall-service provisioning. Used to track periodic reviews of service adequacy, performance, and cost.',
    `monthly_cost` DECIMAL(18,2) COMMENT 'Monthly cost allocated to this residence hall for this IT service provisioning. Used for cost recovery, chargeback, and budget allocation to residential facilities.',
    `notes` STRING COMMENT 'Free-text notes about this specific service provisioning, including special configurations, exceptions, or historical context.',
    `port_count` STRING COMMENT 'Number of network ports or connection points provisioned for this service in this residence hall. Relevant for services like wired network connectivity.',
    `provision_status` STRING COMMENT 'Current operational status of this service provisioning (active, suspended, pending, decommissioned). Tracks lifecycle of the hall-service relationship.',
    `service_activation_date` DATE COMMENT 'Date when this IT service was first activated and made available to the residence hall. Tracks when the provisioning relationship began.',
    `service_contact_email` STRING COMMENT 'Email address of the contact responsible for this service provisioning. Used for service coordination and issue escalation.',
    `service_contact_name` STRING COMMENT 'Name of the IT staff member or hall technology coordinator responsible for managing this specific service provisioning relationship.',
    `service_tier` STRING COMMENT 'Service level tier provisioned for this hall-service combination (e.g., standard, enhanced, premium). Determines feature set, bandwidth, and support level specific to this provisioning.',
    `sla_level` STRING COMMENT 'Service level agreement tier specific to this hall-service provisioning (e.g., gold, silver, bronze). May differ from the services default SLA based on hall priority or contract.',
    CONSTRAINT pk_hall_service_provision PRIMARY KEY(`hall_service_provision_id`)
) COMMENT 'This association product represents the ongoing IT service delivery contract between a residence hall and an IT service. It captures the specific configuration, service tier, bandwidth allocation, port count, cost allocation, and SLA commitments for each hall-service pairing. Each record links one residence hall to one IT service with attributes that exist only in the context of this provisioning relationship, enabling residential IT service management, cost recovery, and SLA tracking.. Existence Justification: Residence halls consume multiple IT services simultaneously (network connectivity, cable TV, phone service, security camera systems, card access, printing services, learning management system access), and each IT service is delivered to multiple residence halls across campus. The business actively manages these provisioning relationships with hall-specific service tiers, bandwidth allocations, port counts, monthly cost allocations for chargeback, and SLA commitments that vary by hall priority and service type.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`org_application_access` (
    `org_application_access_id` BIGINT COMMENT 'Unique identifier for this access grant record. Primary key.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to the enterprise application for which access has been provisioned',
    `student_org_id` BIGINT COMMENT 'Foreign key linking to the student organization that has been granted application access',
    `access_level` STRING COMMENT 'Level of access or permission tier granted to the student organization for this application (read-only, standard-user, power-user, administrator, custom). Determines what functions and data the organization can access.',
    `approval_status` STRING COMMENT 'Current approval and lifecycle status of the access grant (pending, approved, denied, revoked, expired). Tracks the access request and provisioning workflow state.',
    `approver_name` STRING COMMENT 'Name of the IT or business stakeholder who approved the application access request for this student organization.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the applications annual license cost allocated to this student organization for chargeback or cost recovery purposes. Used in IT financial management and budget allocation.',
    `deprovisioning_date` DATE COMMENT 'Date when application access was revoked or deprovisioned for the student organization, if applicable.',
    `expiration_date` DATE COMMENT 'Date when the application access grant expires or is scheduled for review and renewal. May align with organization re-registration cycles or contract terms.',
    `last_usage_date` DATE COMMENT 'Date when the student organization last actively used or logged into the application. Used for license optimization and access review.',
    `license_count` STRING COMMENT 'Number of user licenses or seats allocated to the student organization for this application.',
    `notes` STRING COMMENT 'Free-text notes or comments about this access grant, including special configurations, restrictions, or business context.',
    `provisioning_date` DATE COMMENT 'Date when application access was initially provisioned and activated for the student organization.',
    `usage_purpose` STRING COMMENT 'Business justification or intended use case for why the student organization requires access to this application (e.g., event management, financial tracking, member communication, collaboration).',
    CONSTRAINT pk_org_application_access PRIMARY KEY(`org_application_access_id`)
) COMMENT 'This association product represents the provisioned access relationship between student organizations and enterprise applications. It captures the business process of granting, managing, and tracking application access for student organizations, including access levels, provisioning lifecycle, usage purpose, and cost allocation. Each record links one student organization to one enterprise application with attributes that exist only in the context of this access grant.. Existence Justification: Student organizations require access to multiple enterprise applications to support their operations (financial systems for budget tracking, collaboration tools for member communication, event management platforms, etc.), and each enterprise application serves multiple student organizations across the institution. The IT department actively manages this many-to-many relationship through an application access provisioning process that tracks access levels, approval workflows, provisioning dates, expiration cycles, usage purposes, and cost allocation for chargeback purposes.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`health_appointment` (
    `health_appointment_id` BIGINT COMMENT 'Primary key for health_appointment',
    `building_id` BIGINT COMMENT 'Unique identifier of the campus health facility or clinic location where the appointment is scheduled.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the healthcare provider (physician, nurse, counselor, therapist) assigned to conduct the appointment.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who scheduled or attended the health appointment.',
    `followup_health_appointment_id` BIGINT COMMENT 'Self-referencing FK on health_appointment (followup_health_appointment_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the health appointment concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the health appointment began, as recorded during check-in or service delivery.',
    `appointment_notes` STRING COMMENT 'Additional clinical or administrative notes recorded during or after the health appointment.',
    `appointment_number` STRING COMMENT 'Business-facing unique appointment reference number used for scheduling and tracking purposes.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the health appointment indicating its progression through the care delivery workflow.',
    `appointment_type` STRING COMMENT 'Classification of the health appointment based on the nature of service provided.',
    `billing_code` STRING COMMENT 'The billing or procedure code associated with the health appointment for financial and insurance processing.',
    `cancellation_reason` STRING COMMENT 'The reason provided for cancelling the health appointment, if applicable.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the health appointment was cancelled.',
    `cancelled_by` STRING COMMENT 'Indicates the party who initiated the cancellation of the health appointment.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The total charge amount in US dollars for the health appointment services rendered.',
    `check_in_time` TIMESTAMP COMMENT 'The date and time when the student checked in for the health appointment at the facility reception.',
    `chief_complaint` STRING COMMENT 'The primary reason or symptom reported by the student for seeking the health appointment.',
    `confirmation_method` STRING COMMENT 'The communication channel used to confirm the health appointment with the student.',
    `consent_date` DATE COMMENT 'The date on which informed consent was obtained from the student.',
    `consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent for treatment or services was obtained from the student.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The copayment amount in US dollars required from the student for the health appointment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the health appointment record was first created in the system.',
    `duration_minutes` STRING COMMENT 'The scheduled or actual duration of the health appointment measured in minutes.',
    `follow_up_date` DATE COMMENT 'The recommended or scheduled date for the follow-up appointment, if applicable.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up appointment or additional care is required based on the outcome of this appointment.',
    `insurance_verified` BOOLEAN COMMENT 'Indicates whether the students health insurance coverage has been verified prior to the appointment.',
    `language_preference` STRING COMMENT 'The preferred language for communication and service delivery during the health appointment.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the health appointment record was last modified or updated.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the student failed to attend the scheduled health appointment without prior cancellation.',
    `payment_status` STRING COMMENT 'The current status of payment processing for the health appointment charges.',
    `priority_level` STRING COMMENT 'The urgency classification of the health appointment indicating the required response time.',
    `referral_source` STRING COMMENT 'The origin or channel through which the student was referred for the health appointment.',
    `reminder_sent_flag` BOOLEAN COMMENT 'Indicates whether an appointment reminder notification was sent to the student.',
    `reminder_sent_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment reminder notification was sent to the student.',
    `room_number` STRING COMMENT 'The specific room or examination space within the health facility where the appointment takes place.',
    `scheduled_date` DATE COMMENT 'The calendar date on which the health appointment is scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the health appointment is scheduled to end.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the health appointment is scheduled to begin.',
    `telehealth_flag` BOOLEAN COMMENT 'Indicates whether the health appointment was conducted via telehealth or virtual consultation rather than in-person.',
    `telehealth_platform` STRING COMMENT 'The name or identifier of the telehealth platform or technology used for virtual appointments.',
    `visit_reason` STRING COMMENT 'Detailed description of the purpose or clinical reason for the health appointment.',
    `wait_time_minutes` STRING COMMENT 'The duration in minutes between check-in and the actual start of the appointment, used for service quality monitoring.',
    CONSTRAINT pk_health_appointment PRIMARY KEY(`health_appointment_id`)
) COMMENT 'Master reference table for health_appointment. Referenced by appointment_id.';

CREATE OR REPLACE TABLE `education_ecm`.`studentlife`.`housing_contract` (
    `housing_contract_id` BIGINT COMMENT 'Primary key for housing_contract',
    `building_id` BIGINT COMMENT 'Reference to the residential facility (residence hall, apartment complex) covered by this contract.',
    `dining_plan_id` BIGINT COMMENT 'Reference to the dining services meal plan associated with this housing contract.',
    `profile_id` BIGINT COMMENT 'Reference to the student who is the primary party to this housing contract.',
    `room_id` BIGINT COMMENT 'Reference to the specific room unit assigned under this housing contract.',
    `renewed_housing_contract_id` BIGINT COMMENT 'Self-referencing FK on housing_contract (renewed_housing_contract_id)',
    `academic_term` STRING COMMENT 'Specific academic term or semester covered by this housing contract within the academic year.',
    `academic_year` STRING COMMENT 'Academic year period for which this housing contract is valid, formatted as start-year hyphen end-year (e.g., 2023-2024).',
    `cancellation_date` DATE COMMENT 'Date when the housing contract was officially cancelled by either the student or the institution.',
    `cancellation_fee_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for early termination or cancellation of the housing contract.',
    `cancellation_reason` STRING COMMENT 'Explanation or category describing why the housing contract was cancelled.',
    `check_in_date` DATE COMMENT 'Actual date when the student physically moved into the assigned housing unit.',
    `check_out_date` DATE COMMENT 'Actual date when the student physically vacated the assigned housing unit and returned keys.',
    `contract_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the housing contract for the full contract period before any adjustments or fees.',
    `contract_number` STRING COMMENT 'Externally-visible unique contract number assigned to the housing agreement for student reference and administrative tracking.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the housing contract indicating its operational status and enforceability.',
    `contract_type` STRING COMMENT 'Classification of the housing contract based on duration and academic calendar alignment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this housing contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Refundable security deposit amount required to secure the housing contract and cover potential damages.',
    `effective_end_date` DATE COMMENT 'Date when the housing contract expires and the students occupancy rights terminate.',
    `effective_start_date` DATE COMMENT 'Date when the housing contract becomes binding and the students occupancy rights begin.',
    `emergency_contact_name` STRING COMMENT 'Full name of the primary emergency contact person designated by the student for this housing contract.',
    `emergency_contact_phone` STRING COMMENT 'Primary telephone number for the designated emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact person to the student (e.g., parent, guardian, spouse, sibling).',
    `fees_amount` DECIMAL(18,2) COMMENT 'Total of additional non-refundable fees associated with the housing contract such as application fees, processing fees, or amenity fees.',
    `modified_by` STRING COMMENT 'Identifier of the system user or process that last modified this housing contract record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this housing contract record was last updated or modified.',
    `notes` STRING COMMENT 'Free-form administrative notes or comments related to this housing contract for internal staff reference.',
    `occupancy_status` STRING COMMENT 'Current physical occupancy state of the student in the contracted housing unit.',
    `parent_guardian_signature_required` BOOLEAN COMMENT 'Indicates whether parental or guardian co-signature is required for this housing contract, typically for students under 18 years of age.',
    `parent_guardian_signed_date` DATE COMMENT 'Date when the parent or legal guardian co-signed the housing contract if required.',
    `payment_schedule` STRING COMMENT 'Frequency and timing structure for housing contract payment installments.',
    `renewal_eligible` BOOLEAN COMMENT 'Indicates whether the student is eligible to renew this housing contract for a subsequent term or academic year.',
    `room_type` STRING COMMENT 'Classification of the room configuration indicating occupancy capacity and layout style.',
    `roommate_preference` STRING COMMENT 'Student-indicated preferences or requests for roommate matching used during room assignment.',
    `signed_date` DATE COMMENT 'Date when the student executed the housing contract by providing their signature or electronic acceptance.',
    `special_accommodations` STRING COMMENT 'Description of any approved disability accommodations or special housing needs associated with this contract.',
    `terms_accepted` BOOLEAN COMMENT 'Indicates whether the student has formally accepted the terms and conditions of the housing contract.',
    `terms_version` STRING COMMENT 'Version identifier of the housing contract terms and conditions document that the student accepted.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount due under the housing contract including base contract amount, deposit, and all fees.',
    `created_by` STRING COMMENT 'Identifier of the system user or process that created this housing contract record.',
    CONSTRAINT pk_housing_contract PRIMARY KEY(`housing_contract_id`)
) COMMENT 'Master reference table for housing_contract. Referenced by housing_contract_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_dining_plan_id` FOREIGN KEY (`dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_housing_application_id` FOREIGN KEY (`housing_application_id`) REFERENCES `education_ecm`.`studentlife`.`housing_application`(`housing_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_housing_contract_id` FOREIGN KEY (`housing_contract_id`) REFERENCES `education_ecm`.`studentlife`.`housing_contract`(`housing_contract_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_residence_room_id` FOREIGN KEY (`residence_room_id`) REFERENCES `education_ecm`.`studentlife`.`residence_room`(`residence_room_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_roommate_group_id` FOREIGN KEY (`roommate_group_id`) REFERENCES `education_ecm`.`studentlife`.`roommate_group`(`roommate_group_id`);
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ADD CONSTRAINT `fk_studentlife_studentlife_housing_assignment_previous_studentlife_housing_assignment_id` FOREIGN KEY (`previous_studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ADD CONSTRAINT `fk_studentlife_housing_application_superseded_housing_application_id` FOREIGN KEY (`superseded_housing_application_id`) REFERENCES `education_ecm`.`studentlife`.`housing_application`(`housing_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ADD CONSTRAINT `fk_studentlife_residence_hall_parent_residence_hall_id` FOREIGN KEY (`parent_residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ADD CONSTRAINT `fk_studentlife_residence_room_llc_program_id` FOREIGN KEY (`llc_program_id`) REFERENCES `education_ecm`.`studentlife`.`llc_program`(`llc_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ADD CONSTRAINT `fk_studentlife_residence_room_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ADD CONSTRAINT `fk_studentlife_residence_room_connected_residence_room_id` FOREIGN KEY (`connected_residence_room_id`) REFERENCES `education_ecm`.`studentlife`.`residence_room`(`residence_room_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ADD CONSTRAINT `fk_studentlife_dining_plan_superseded_dining_plan_id` FOREIGN KEY (`superseded_dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_dining_plan_id` FOREIGN KEY (`dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ADD CONSTRAINT `fk_studentlife_dining_enrollment_changed_from_dining_enrollment_id` FOREIGN KEY (`changed_from_dining_enrollment_id`) REFERENCES `education_ecm`.`studentlife`.`dining_enrollment`(`dining_enrollment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_dining_enrollment_id` FOREIGN KEY (`dining_enrollment_id`) REFERENCES `education_ecm`.`studentlife`.`dining_enrollment`(`dining_enrollment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_dining_plan_id` FOREIGN KEY (`dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_original_transaction_dining_transaction_id` FOREIGN KEY (`original_transaction_dining_transaction_id`) REFERENCES `education_ecm`.`studentlife`.`dining_transaction`(`dining_transaction_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_refund_transaction_id` FOREIGN KEY (`refund_transaction_id`) REFERENCES `education_ecm`.`studentlife`.`dining_transaction`(`dining_transaction_id`);
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ADD CONSTRAINT `fk_studentlife_dining_transaction_reversal_dining_transaction_id` FOREIGN KEY (`reversal_dining_transaction_id`) REFERENCES `education_ecm`.`studentlife`.`dining_transaction`(`dining_transaction_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_health_appointment_id` FOREIGN KEY (`health_appointment_id`) REFERENCES `education_ecm`.`studentlife`.`health_appointment`(`health_appointment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_immunization_record_id` FOREIGN KEY (`immunization_record_id`) REFERENCES `education_ecm`.`studentlife`.`immunization_record`(`immunization_record_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ADD CONSTRAINT `fk_studentlife_health_visit_followup_health_visit_id` FOREIGN KEY (`followup_health_visit_id`) REFERENCES `education_ecm`.`studentlife`.`health_visit`(`health_visit_id`);
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ADD CONSTRAINT `fk_studentlife_immunization_record_booster_immunization_record_id` FOREIGN KEY (`booster_immunization_record_id`) REFERENCES `education_ecm`.`studentlife`.`immunization_record`(`immunization_record_id`);
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ADD CONSTRAINT `fk_studentlife_counseling_case_referred_from_counseling_case_id` FOREIGN KEY (`referred_from_counseling_case_id`) REFERENCES `education_ecm`.`studentlife`.`counseling_case`(`counseling_case_id`);
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ADD CONSTRAINT `fk_studentlife_student_org_parent_student_org_id` FOREIGN KEY (`parent_student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ADD CONSTRAINT `fk_studentlife_org_membership_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ADD CONSTRAINT `fk_studentlife_org_membership_renewed_org_membership_id` FOREIGN KEY (`renewed_org_membership_id`) REFERENCES `education_ecm`.`studentlife`.`org_membership`(`org_membership_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_llc_program_id` FOREIGN KEY (`llc_program_id`) REFERENCES `education_ecm`.`studentlife`.`llc_program`(`llc_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ADD CONSTRAINT `fk_studentlife_campus_event_parent_campus_event_id` FOREIGN KEY (`parent_campus_event_id`) REFERENCES `education_ecm`.`studentlife`.`campus_event`(`campus_event_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_campus_event_id` FOREIGN KEY (`campus_event_id`) REFERENCES `education_ecm`.`studentlife`.`campus_event`(`campus_event_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ADD CONSTRAINT `fk_studentlife_event_attendance_corrected_event_attendance_id` FOREIGN KEY (`corrected_event_attendance_id`) REFERENCES `education_ecm`.`studentlife`.`event_attendance`(`event_attendance_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ADD CONSTRAINT `fk_studentlife_conduct_case_appeal_conduct_case_id` FOREIGN KEY (`appeal_conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ADD CONSTRAINT `fk_studentlife_conduct_sanction_superseded_conduct_sanction_id` FOREIGN KEY (`superseded_conduct_sanction_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_sanction`(`conduct_sanction_id`);
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ADD CONSTRAINT `fk_studentlife_cocurricular_record_prior_cocurricular_record_id` FOREIGN KEY (`prior_cocurricular_record_id`) REFERENCES `education_ecm`.`studentlife`.`cocurricular_record`(`cocurricular_record_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ADD CONSTRAINT `fk_studentlife_service_learning_placement_prior_service_learning_placement_id` FOREIGN KEY (`prior_service_learning_placement_id`) REFERENCES `education_ecm`.`studentlife`.`service_learning_placement`(`service_learning_placement_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ADD CONSTRAINT `fk_studentlife_wellness_program_prerequisite_wellness_program_id` FOREIGN KEY (`prerequisite_wellness_program_id`) REFERENCES `education_ecm`.`studentlife`.`wellness_program`(`wellness_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_conduct_case_id` FOREIGN KEY (`conduct_case_id`) REFERENCES `education_ecm`.`studentlife`.`conduct_case`(`conduct_case_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_wellness_program_id` FOREIGN KEY (`wellness_program_id`) REFERENCES `education_ecm`.`studentlife`.`wellness_program`(`wellness_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ADD CONSTRAINT `fk_studentlife_wellness_participation_prior_wellness_participation_id` FOREIGN KEY (`prior_wellness_participation_id`) REFERENCES `education_ecm`.`studentlife`.`wellness_participation`(`wellness_participation_id`);
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ADD CONSTRAINT `fk_studentlife_roommate_group_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ADD CONSTRAINT `fk_studentlife_roommate_group_merged_from_roommate_group_id` FOREIGN KEY (`merged_from_roommate_group_id`) REFERENCES `education_ecm`.`studentlife`.`roommate_group`(`roommate_group_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_housing_application_id` FOREIGN KEY (`housing_application_id`) REFERENCES `education_ecm`.`studentlife`.`housing_application`(`housing_application_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_llc_program_id` FOREIGN KEY (`llc_program_id`) REFERENCES `education_ecm`.`studentlife`.`llc_program`(`llc_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_roommate_group_id` FOREIGN KEY (`roommate_group_id`) REFERENCES `education_ecm`.`studentlife`.`roommate_group`(`roommate_group_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ADD CONSTRAINT `fk_studentlife_housing_waitlist_transferred_from_housing_waitlist_id` FOREIGN KEY (`transferred_from_housing_waitlist_id`) REFERENCES `education_ecm`.`studentlife`.`housing_waitlist`(`housing_waitlist_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ADD CONSTRAINT `fk_studentlife_llc_program_parent_llc_program_id` FOREIGN KEY (`parent_llc_program_id`) REFERENCES `education_ecm`.`studentlife`.`llc_program`(`llc_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_llc_program_id` FOREIGN KEY (`llc_program_id`) REFERENCES `education_ecm`.`studentlife`.`llc_program`(`llc_program_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_studentlife_housing_assignment_id` FOREIGN KEY (`studentlife_housing_assignment_id`) REFERENCES `education_ecm`.`studentlife`.`studentlife_housing_assignment`(`studentlife_housing_assignment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ADD CONSTRAINT `fk_studentlife_llc_enrollment_prior_llc_enrollment_id` FOREIGN KEY (`prior_llc_enrollment_id`) REFERENCES `education_ecm`.`studentlife`.`llc_enrollment`(`llc_enrollment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ADD CONSTRAINT `fk_studentlife_hall_service_provision_residence_hall_id` FOREIGN KEY (`residence_hall_id`) REFERENCES `education_ecm`.`studentlife`.`residence_hall`(`residence_hall_id`);
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ADD CONSTRAINT `fk_studentlife_org_application_access_student_org_id` FOREIGN KEY (`student_org_id`) REFERENCES `education_ecm`.`studentlife`.`student_org`(`student_org_id`);
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ADD CONSTRAINT `fk_studentlife_health_appointment_followup_health_appointment_id` FOREIGN KEY (`followup_health_appointment_id`) REFERENCES `education_ecm`.`studentlife`.`health_appointment`(`health_appointment_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ADD CONSTRAINT `fk_studentlife_housing_contract_dining_plan_id` FOREIGN KEY (`dining_plan_id`) REFERENCES `education_ecm`.`studentlife`.`dining_plan`(`dining_plan_id`);
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ADD CONSTRAINT `fk_studentlife_housing_contract_renewed_housing_contract_id` FOREIGN KEY (`renewed_housing_contract_id`) REFERENCES `education_ecm`.`studentlife`.`housing_contract`(`housing_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`studentlife` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`studentlife` SET TAGS ('dbx_domain' = 'studentlife');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `studentlife_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `account_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `dining_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `housing_application_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `housing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Contract Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Revenue Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Hall Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `residence_room_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `roommate_group_id` SET TAGS ('dbx_business_glossary_term' = 'Roommate Group Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `previous_studentlife_housing_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `accommodation_notes` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Notes');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `accommodation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_action_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Action Code');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_action_code` SET TAGS ('dbx_value_regex' = 'initial_assignment|room_change|emergency_relocation|administrative_move|student_request|disciplinary_action');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Assignment Fee Amount');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_priority_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Code');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_priority_code` SET TAGS ('dbx_value_regex' = 'standard|priority|guaranteed|waitlist|lottery');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'pending|active|cancelled|expired|terminated|on_hold');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'standard|medical_accommodation|resident_assistant|overflow|temporary|guest');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `damage_assessment_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Assessment Flag');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `damage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Damage Charge Amount');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `key_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Key Issued Date');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `key_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Issued Flag');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `key_returned_date` SET TAGS ('dbx_business_glossary_term' = 'Key Returned Date');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `occupancy_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Rate Code');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `occupancy_rate_code` SET TAGS ('dbx_value_regex' = 'single|double|triple|quad|suite');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`studentlife_housing_assignment` ALTER COLUMN `special_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Accommodation Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `housing_application_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Application ID');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `award_package_id` SET TAGS ('dbx_business_glossary_term' = 'Aid Package Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Staff ID');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `quaternary_housing_roommate_preference_3_student_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Third Roommate Preference Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `tertiary_housing_roommate_preference_2_student_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Second Roommate Preference Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `superseded_housing_application_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Description');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `accommodation_documentation_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Documentation Received Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Amount');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Payment Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_fee_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Payment Status');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_fee_payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|waived|refunded');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_notes` SET TAGS ('dbx_business_glossary_term' = 'Application Notes');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Housing Application Number');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^HA[0-9]{8}$');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `building_preference_1` SET TAGS ('dbx_business_glossary_term' = 'First Building Preference');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `building_preference_2` SET TAGS ('dbx_business_glossary_term' = 'Second Building Preference');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `building_preference_3` SET TAGS ('dbx_business_glossary_term' = 'Third Building Preference');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Cancellation Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Housing Contract End Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Housing Contract Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Housing Deposit Amount');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `deposit_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Payment Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `deposit_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Payment Status');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `deposit_payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|waived|refunded|forfeited');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `early_arrival_reason` SET TAGS ('dbx_business_glossary_term' = 'Early Arrival Reason');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `early_arrival_reason` SET TAGS ('dbx_value_regex' = 'athletics|orientation_leader|international_student|academic_program|other');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `early_arrival_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Arrival Requested Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender-Inclusive Housing Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `late_arrival_expected_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Arrival Expected Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `lifestyle_preference` SET TAGS ('dbx_business_glossary_term' = 'Lifestyle Preference');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `lottery_number` SET TAGS ('dbx_business_glossary_term' = 'Lottery Number');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `meal_plan_preference` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Preference');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `meal_plan_preference` SET TAGS ('dbx_value_regex' = 'unlimited|14_meals|10_meals|5_meals|commuter|none');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `parking_permit_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Parking Permit Requested Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `priority_group` SET TAGS ('dbx_business_glossary_term' = 'Priority Group');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Review Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `room_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Room Type Preference');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `room_type_preference` SET TAGS ('dbx_value_regex' = 'single|double|triple|quad|suite|apartment');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `special_accommodation_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Accommodation Requested Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_application` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Hall Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `parent_residence_hall_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `ada_room_count` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Room Count');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `building_nickname` SET TAGS ('dbx_business_glossary_term' = 'Building Nickname');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `campus_location` SET TAGS ('dbx_business_glossary_term' = 'Campus Location');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `campus_location` SET TAGS ('dbx_value_regex' = 'main_campus|north_campus|south_campus|east_campus|west_campus|satellite_campus');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `fire_safety_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety System Type');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `fire_safety_system_type` SET TAGS ('dbx_value_regex' = 'sprinkler|alarm_only|sprinkler_and_alarm|none');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `floor_count` SET TAGS ('dbx_business_glossary_term' = 'Floor Count');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Gender Designation');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `gender_designation` SET TAGS ('dbx_value_regex' = 'all_gender|women_only|men_only|mixed_by_floor|mixed_by_wing');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `gender_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `hall_type` SET TAGS ('dbx_business_glossary_term' = 'Hall Type');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_24hr_desk_staff` SET TAGS ('dbx_business_glossary_term' = 'Has 24-Hour Desk Staff Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_air_conditioning` SET TAGS ('dbx_business_glossary_term' = 'Has Air Conditioning Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_computer_lab` SET TAGS ('dbx_business_glossary_term' = 'Has Computer Lab Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_dining_hall` SET TAGS ('dbx_business_glossary_term' = 'Has Dining Hall Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_elevator` SET TAGS ('dbx_business_glossary_term' = 'Has Elevator Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_fitness_center` SET TAGS ('dbx_business_glossary_term' = 'Has Fitness Center Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_kitchen_facility` SET TAGS ('dbx_business_glossary_term' = 'Has Kitchen Facility Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_laundry_facility` SET TAGS ('dbx_business_glossary_term' = 'Has Laundry Facility Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `has_study_rooms` SET TAGS ('dbx_business_glossary_term' = 'Has Study Rooms Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Housing Office Contact Name');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_email` SET TAGS ('dbx_business_glossary_term' = 'Housing Office Email Address');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_phone` SET TAGS ('dbx_business_glossary_term' = 'Housing Office Phone Number');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `housing_office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `is_ada_accessible` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accessible Flag');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `occupancy_term_pattern` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Term Pattern');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `occupancy_term_pattern` SET TAGS ('dbx_value_regex' = 'academic_year|year_round|fall_spring_only|summer_only');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'open|closed|under_renovation|seasonal|decommissioned');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `parking_availability` SET TAGS ('dbx_business_glossary_term' = 'Parking Availability');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `parking_availability` SET TAGS ('dbx_value_regex' = 'none|limited|adequate|ample');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `resident_assistant_count` SET TAGS ('dbx_business_glossary_term' = 'Resident Assistant (RA) Count');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `security_access_type` SET TAGS ('dbx_business_glossary_term' = 'Security Access Type');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `security_access_type` SET TAGS ('dbx_value_regex' = 'card_access|key_access|biometric|open_access');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `total_bed_capacity` SET TAGS ('dbx_business_glossary_term' = 'Total Bed Capacity');
ALTER TABLE `education_ecm`.`studentlife`.`residence_hall` ALTER COLUMN `total_room_count` SET TAGS ('dbx_business_glossary_term' = 'Total Room Count');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `residence_room_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Room Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `llc_program_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Hall Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `connected_residence_room_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `ada_accessible` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accessible');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `ada_features` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Features');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `air_conditioning` SET TAGS ('dbx_business_glossary_term' = 'Air Conditioning Available');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Available From Date');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `available_until_date` SET TAGS ('dbx_business_glossary_term' = 'Available Until Date');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `bathroom_type` SET TAGS ('dbx_business_glossary_term' = 'Bathroom Type');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `bathroom_type` SET TAGS ('dbx_value_regex' = 'private|shared|suite|communal');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `bed_count` SET TAGS ('dbx_business_glossary_term' = 'Bed Count');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `cable_tv_available` SET TAGS ('dbx_business_glossary_term' = 'Cable Television (TV) Available');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `closet_count` SET TAGS ('dbx_business_glossary_term' = 'Closet Count');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `current_occupancy_count` SET TAGS ('dbx_business_glossary_term' = 'Current Occupancy Count');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `furnished` SET TAGS ('dbx_business_glossary_term' = 'Furnished');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `furniture_description` SET TAGS ('dbx_business_glossary_term' = 'Furniture Description');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Gender Designation');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_value_regex' = 'male|female|gender_inclusive|gender_neutral');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `internet_access_type` SET TAGS ('dbx_business_glossary_term' = 'Internet Access Type');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `internet_access_type` SET TAGS ('dbx_value_regex' = 'wired|wireless|both|none');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_honors_housing` SET TAGS ('dbx_business_glossary_term' = 'Is Honors Housing');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_llc_room` SET TAGS ('dbx_business_glossary_term' = 'Is Living Learning Community (LLC) Room');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_medical_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Is Medical Accommodation Room');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_medical_accommodation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_medical_accommodation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_quiet_floor` SET TAGS ('dbx_business_glossary_term' = 'Is Quiet Floor');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_ra_room` SET TAGS ('dbx_business_glossary_term' = 'Is Resident Assistant (RA) Room');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `is_substance_free` SET TAGS ('dbx_business_glossary_term' = 'Is Substance Free Housing');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `kitchen_type` SET TAGS ('dbx_business_glossary_term' = 'Kitchen Type');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `kitchen_type` SET TAGS ('dbx_value_regex' = 'none|kitchenette|full_kitchen|shared_floor');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `maximum_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Room Notes');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'vacant|partial|full|overbooked');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `room_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Room Rate Amount');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `room_rate_period` SET TAGS ('dbx_business_glossary_term' = 'Room Rate Period');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `room_rate_period` SET TAGS ('dbx_value_regex' = 'semester|academic_year|monthly|annual');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `room_status` SET TAGS ('dbx_business_glossary_term' = 'Room Status');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `room_status` SET TAGS ('dbx_value_regex' = 'available|occupied|offline|reserved|maintenance|renovation');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `room_type` SET TAGS ('dbx_business_glossary_term' = 'Room Type');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `view_description` SET TAGS ('dbx_business_glossary_term' = 'View Description');
ALTER TABLE `education_ecm`.`studentlife`.`residence_room` ALTER COLUMN `window_count` SET TAGS ('dbx_business_glossary_term' = 'Window Count');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `dining_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `superseded_dining_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `block_meal_count` SET TAGS ('dbx_business_glossary_term' = 'Block Meal Count');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `carryover_limit` SET TAGS ('dbx_business_glossary_term' = 'Carryover Limit');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `dietary_accommodation_notes` SET TAGS ('dbx_business_glossary_term' = 'Dietary Accommodation Notes');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `dining_dollars_amount` SET TAGS ('dbx_business_glossary_term' = 'Dining Dollars Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `eligible_dining_locations` SET TAGS ('dbx_business_glossary_term' = 'Eligible Dining Locations');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `eligible_student_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Student Types');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `guest_swipes_included` SET TAGS ('dbx_business_glossary_term' = 'Guest Swipes Included');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Plan Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `mandatory_for_population` SET TAGS ('dbx_business_glossary_term' = 'Mandatory For Population');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `meal_equivalency_value` SET TAGS ('dbx_business_glossary_term' = 'Meal Equivalency Value');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `meals_per_week` SET TAGS ('dbx_business_glossary_term' = 'Meals Per Week');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `online_ordering_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering Enabled Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Code');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Description');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Name');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Status');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|discontinued|archived');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Type');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'unlimited|block|declining_balance|commuter|hybrid|flex');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `price_per_term` SET TAGS ('dbx_business_glossary_term' = 'Price Per Term');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `price_per_year` SET TAGS ('dbx_business_glossary_term' = 'Price Per Year');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `refund_policy` SET TAGS ('dbx_business_glossary_term' = 'Refund Policy');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `rollover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Allowed Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_plan` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `dining_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Enrollment Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Revenue Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `dining_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `changed_from_dining_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'pending|billed|paid|refunded|waived');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `billing_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Trigger Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `daily_meal_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Meal Limit');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `dietary_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `dietary_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction Notes');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `dietary_restriction_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `dining_dollar_balance` SET TAGS ('dbx_business_glossary_term' = 'Dining Dollar Balance');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Dining Enrollment Number');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^DE[0-9]{10}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online_portal|housing_application|manual_entry|bulk_import|mobile_app|administrative');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|suspended|pending|completed|changed');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Exemption Status');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `exemption_status` SET TAGS ('dbx_value_regex' = 'none|approved|pending|denied');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `guest_meal_allowance` SET TAGS ('dbx_business_glossary_term' = 'Guest Meal Allowance');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `guest_meals_used` SET TAGS ('dbx_business_glossary_term' = 'Guest Meals Used');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `housing_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Housing Requirement Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `initial_dining_dollar_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Dining Dollar Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `initial_meal_count` SET TAGS ('dbx_business_glossary_term' = 'Initial Meal Count');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `meals_remaining` SET TAGS ('dbx_business_glossary_term' = 'Meals Remaining');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `plan_change_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Change Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `plan_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Plan Change Reason');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `plan_change_reason` SET TAGS ('dbx_value_regex' = 'housing_change|dietary_needs|financial|usage_pattern|administrative|other');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `plan_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Cost Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Type');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'unlimited|block|declining_balance|commuter|hybrid|flex');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `refund_processed_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Date');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `rollover_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Rollover Balance Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_enrollment` ALTER COLUMN `weekly_meal_limit` SET TAGS ('dbx_business_glossary_term' = 'Weekly Meal Limit');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `dining_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Transaction ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Facility ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `dining_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Enrollment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `dining_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `original_transaction_dining_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `refund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Transaction ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `reversal_dining_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,20}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `balance_after` SET TAGS ('dbx_business_glossary_term' = 'Balance After Transaction');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `balance_before` SET TAGS ('dbx_business_glossary_term' = 'Balance Before Transaction');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `discount_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,20}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Count');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `is_refunded` SET TAGS ('dbx_business_glossary_term' = 'Is Refunded Flag');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `meal_period` SET TAGS ('dbx_business_glossary_term' = 'Meal Period');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `meal_period` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `meals_decremented` SET TAGS ('dbx_business_glossary_term' = 'Meals Decremented');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `meals_remaining` SET TAGS ('dbx_business_glossary_term' = 'Meals Remaining After Transaction');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,20}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `terminal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_source` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_source` SET TAGS ('dbx_value_regex' = 'pos_terminal|mobile_app|web_portal|kiosk|catering_system');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|voided|refunded|pending|failed');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'meal_swipe|dining_dollar|guest_meal|catering|retail_purchase|declining_balance');
ALTER TABLE `education_ecm`.`studentlife`.`dining_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` SET TAGS ('dbx_subdomain' = 'wellness_support');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Health Visit ID');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `health_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Health Services Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `immunization_record_id` SET TAGS ('dbx_business_glossary_term' = 'Immunization Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Charge Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `followup_health_visit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `copay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `ferpa_release_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Release On File Flag');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `follow_up_instructions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Instructions');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `follow_up_instructions` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `follow_up_instructions` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `hipaa_consent_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA (Health Insurance Portability and Accountability Act) Consent On File Flag');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `insurance_carrier` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `insurance_carrier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `insurance_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Used Flag');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `no_show_reason` SET TAGS ('dbx_business_glossary_term' = 'No-Show Reason');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `presenting_complaint` SET TAGS ('dbx_business_glossary_term' = 'Presenting Complaint');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `presenting_complaint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `presenting_complaint` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `provider_credential_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Credential Type');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `reason_for_visit` SET TAGS ('dbx_business_glossary_term' = 'Reason for Visit');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `reason_for_visit` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `reason_for_visit` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `referral_destination` SET TAGS ('dbx_business_glossary_term' = 'Referral Destination');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Flag');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `referral_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `referral_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `referral_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `soap_note_reference` SET TAGS ('dbx_business_glossary_term' = 'SOAP (Subjective Objective Assessment Plan) Note Reference');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `soap_note_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `soap_note_reference` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Visit Charge Amount');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Visit Duration Minutes');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_notes` SET TAGS ('dbx_business_glossary_term' = 'Visit Notes');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|no_show|cancelled|in_progress');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_time` SET TAGS ('dbx_business_glossary_term' = 'Visit Time');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `education_ecm`.`studentlife`.`health_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'primary_care|urgent_care|immunization|counseling_intake|follow_up|telehealth');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` SET TAGS ('dbx_subdomain' = 'wellness_support');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `immunization_record_id` SET TAGS ('dbx_business_glossary_term' = 'Immunization Record Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed by Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `booster_immunization_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `academic_term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `administration_date` SET TAGS ('dbx_business_glossary_term' = 'Administration Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `compliance_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Flag');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Exemption Granted|Pending Verification|Expired');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `dose_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Dose Sequence Number');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `exemption_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Approval Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `exemption_documentation_on_file` SET TAGS ('dbx_business_glossary_term' = 'Exemption Documentation on File Flag');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `exemption_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Expiration Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Exemption Type');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'Medical|Religious|Philosophical|None');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `hold_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Effective Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `immunization_name` SET TAGS ('dbx_business_glossary_term' = 'Immunization Name');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `immunization_type` SET TAGS ('dbx_business_glossary_term' = 'Immunization Type');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `immunization_type` SET TAGS ('dbx_value_regex' = 'MMR|Meningococcal|Hepatitis B|Varicella|COVID-19|Influenza');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `is_required_for_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Required for Enrollment Flag');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `is_required_for_housing` SET TAGS ('dbx_business_glossary_term' = 'Required for Housing Flag');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Lot Number');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Immunization Record Notes');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'Email|Portal Message|Mail|SMS|Phone');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `provider_location` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Provider Location');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Provider Name');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `education_ecm`.`studentlife`.`immunization_record` ALTER COLUMN `verification_source` SET TAGS ('dbx_value_regex' = 'Self-Reported|Provider-Verified|State Registry|School Record|Military Record|International Record');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` SET TAGS ('dbx_subdomain' = 'wellness_support');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `counseling_case_id` SET TAGS ('dbx_business_glossary_term' = 'Counseling Case ID');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Counselor ID');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `referred_from_counseling_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `cancellation_count` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Count');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_close_date` SET TAGS ('dbx_business_glossary_term' = 'Case Close Date');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Reason');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_notes_summary` SET TAGS ('dbx_business_glossary_term' = 'Case Notes Summary');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_notes_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{8}$');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_open_date` SET TAGS ('dbx_business_glossary_term' = 'Case Open Date');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'active|closed|referred_out|on_waitlist|suspended|intake_pending');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `consent_to_contact_emergency` SET TAGS ('dbx_business_glossary_term' = 'Consent to Contact Emergency Contact Flag');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `crisis_flag` SET TAGS ('dbx_business_glossary_term' = 'Crisis Flag');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `crisis_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `external_referral_made` SET TAGS ('dbx_business_glossary_term' = 'External Referral Made Flag');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `external_referral_provider` SET TAGS ('dbx_business_glossary_term' = 'External Referral Provider Name');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `external_referral_provider` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `external_referral_reason` SET TAGS ('dbx_business_glossary_term' = 'External Referral Reason');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `external_referral_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `follow_up_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Recommended Flag');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `hospitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Hospitalization Flag');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `hospitalization_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `insurance_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Used Flag');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `intake_date` SET TAGS ('dbx_business_glossary_term' = 'Intake Date');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `mandated_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandated Referral Flag');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `mandated_session_requirement` SET TAGS ('dbx_business_glossary_term' = 'Mandated Session Requirement');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `no_show_count` SET TAGS ('dbx_business_glossary_term' = 'No-Show Count');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `presenting_concern_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Presenting Concern');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `presenting_concern_primary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `presenting_concern_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Presenting Concern');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `presenting_concern_secondary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level Assessment');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|crisis|not_assessed');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `risk_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `session_count` SET TAGS ('dbx_business_glossary_term' = 'Session Count');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `session_limit` SET TAGS ('dbx_business_glossary_term' = 'Session Limit');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `treatment_approach` SET TAGS ('dbx_business_glossary_term' = 'Treatment Approach');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `treatment_approach` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `treatment_approach` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `treatment_modality` SET TAGS ('dbx_business_glossary_term' = 'Treatment Modality');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `treatment_modality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`counseling_case` ALTER COLUMN `treatment_modality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` SET TAGS ('dbx_subdomain' = 'campus_engagement');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Student Organization ID');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Org Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Org Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Advisor Instructor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `profile_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `third_party_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `parent_student_org_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Type');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_value_regex' = 'independent|national_affiliate|regional_chapter|university_sponsored|departmental');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `conduct_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Conduct Violations Count');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `constitution_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Constitution Last Updated Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `constitution_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Constitution On File Flag');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `derecognition_date` SET TAGS ('dbx_business_glossary_term' = 'Derecognition Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `derecognition_reason` SET TAGS ('dbx_business_glossary_term' = 'Derecognition Reason');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `greek_council` SET TAGS ('dbx_business_glossary_term' = 'Greek Council');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `greek_council` SET TAGS ('dbx_value_regex' = 'IFC|Panhellenic|NPHC|MGC|none');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `hazing_prevention_training_date` SET TAGS ('dbx_business_glossary_term' = 'Hazing Prevention Training Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `last_re_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Re-Registration Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `meeting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Meeting Schedule');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `mission_statement` SET TAGS ('dbx_business_glossary_term' = 'Mission Statement');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `national_affiliation_name` SET TAGS ('dbx_business_glossary_term' = 'National Affiliation Name');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `org_code` SET TAGS ('dbx_business_glossary_term' = 'Organization Code');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `org_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `org_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `probation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Probation Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `re_registration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Registration Due Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Recognition Status');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|probation|suspended|derecognized|pending');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `secondary_advisor_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Advisor Name');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `treasurer_email` SET TAGS ('dbx_business_glossary_term' = 'Treasurer Email Address');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `treasurer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `treasurer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `treasurer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `treasurer_name` SET TAGS ('dbx_business_glossary_term' = 'Treasurer Name');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `treasurer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `treasurer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL (Uniform Resource Locator)');
ALTER TABLE `education_ecm`.`studentlife`.`student_org` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` SET TAGS ('dbx_subdomain' = 'campus_engagement');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `org_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Membership Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Student Organization Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `renewed_org_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Attendance Count');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `conduct_violation_date` SET TAGS ('dbx_business_glossary_term' = 'Conduct Violation Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `conduct_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Conduct Violation Flag');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Dues Amount');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `dues_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Dues Paid Flag');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `dues_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Dues Payment Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `dues_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Dues Waived Flag');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `good_standing_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Standing Flag');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `leadership_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Leadership Training Completed Flag');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_notes` SET TAGS ('dbx_business_glossary_term' = 'Membership Notes');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_business_glossary_term' = 'Membership Role');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|resigned|removed|suspended|probation');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_term` SET TAGS ('dbx_business_glossary_term' = 'Membership Term');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `membership_term` SET TAGS ('dbx_value_regex' = 'fall|spring|summer|full_year');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `probation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Probation Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `resignation_date` SET TAGS ('dbx_business_glossary_term' = 'Resignation Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `resignation_reason` SET TAGS ('dbx_business_glossary_term' = 'Resignation Reason');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `role_end_date` SET TAGS ('dbx_business_glossary_term' = 'Role End Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `role_start_date` SET TAGS ('dbx_business_glossary_term' = 'Role Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `transcript_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Eligible Flag');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `volunteer_hours` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Hours');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `voting_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Flag');
ALTER TABLE `education_ecm`.`studentlife`.`org_membership` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` SET TAGS ('dbx_subdomain' = 'campus_engagement');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `campus_event_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Event ID');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff ID');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Event Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Event Expense Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `llc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Llc Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Department ID');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Event Location ID');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `sponsor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Organization ID');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `parent_campus_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `accessibility_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodations');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `actual_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expense Amount');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `cocurricular_credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Credit Eligible Flag');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `cocurricular_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Credit Hours');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Event End Date and Time');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_location_name` SET TAGS ('dbx_business_glossary_term' = 'Event Location Name');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^EVT-[0-9]{6,10}$');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date and Time');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'planned|approved|active|completed|cancelled|postponed');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'lecture|concert|cultural_celebration|athletic|orientation|leadership_workshop');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `hybrid_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Hybrid Event Flag');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `registration_capacity` SET TAGS ('dbx_business_glossary_term' = 'Registration Capacity');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `registration_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Amount');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `virtual_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event Flag');
ALTER TABLE `education_ecm`.`studentlife`.`campus_event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` SET TAGS ('dbx_subdomain' = 'campus_engagement');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `event_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Event Attendance ID');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `campus_event_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Check-In Staff ID');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Student Organization ID');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `corrected_event_attendance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Description');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `attendance_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Attendance Duration Minutes');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `attendance_method` SET TAGS ('dbx_business_glossary_term' = 'Attendance Method');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `attendance_method` SET TAGS ('dbx_value_regex' = 'card-swipe|qr-scan|manual|mobile-app|kiosk|nfc');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `attendance_notes` SET TAGS ('dbx_business_glossary_term' = 'Attendance Notes');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `attendance_number` SET TAGS ('dbx_business_glossary_term' = 'Attendance Number');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'attended|no-show|waitlisted|cancelled|checked-in');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `check_in_location` SET TAGS ('dbx_business_glossary_term' = 'Check-In Location');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `co_curricular_credit_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Credit Awarded Flag');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `credit_unit` SET TAGS ('dbx_business_glossary_term' = 'Credit Unit');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `credit_unit` SET TAGS ('dbx_value_regex' = 'hours|points|units|credits');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `feedback_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submitted Flag');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Count');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `participation_level` SET TAGS ('dbx_business_glossary_term' = 'Participation Level');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `participation_level` SET TAGS ('dbx_value_regex' = 'attendee|participant|volunteer|presenter|organizer');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|waived|refunded|unpaid');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `special_accommodation_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Accommodation Requested Flag');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `ticket_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Ticket Cost Amount');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|disputed|corrected');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `education_ecm`.`studentlife`.`event_attendance` ALTER COLUMN `waitlist_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` SET TAGS ('dbx_subdomain' = 'behavioral_standards');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `conduct_case_id` SET TAGS ('dbx_business_glossary_term' = 'Conduct Case Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Conduct Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `studentlife_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `appeal_conduct_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `advisor_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Advisor Present Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_value_regex' = 'upheld|overturned|sanction modified|remanded');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `appeal_grounds` SET TAGS ('dbx_business_glossary_term' = 'Appeal Grounds');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `case_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Conduct Case Notes');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Conduct Case Number');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Conduct Case Status');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `finding` SET TAGS ('dbx_business_glossary_term' = 'Conduct Finding');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `finding` SET TAGS ('dbx_value_regex' = 'responsible|not responsible|deferred|insufficient evidence');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `hearing_location` SET TAGS ('dbx_business_glossary_term' = 'Hearing Location');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `hearing_type` SET TAGS ('dbx_business_glossary_term' = 'Hearing Type');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `hearing_type` SET TAGS ('dbx_value_regex' = 'administrative|panel|informal resolution|no hearing required');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `incident_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `incident_report_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `parent_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Parent Notification Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `parent_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Parent Notification Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `reporting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Party Name');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `reporting_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `reporting_party_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Party Type');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_completion_deadline` SET TAGS ('dbx_business_glossary_term' = 'Sanction Completion Deadline');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Completion Status');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_completion_status` SET TAGS ('dbx_value_regex' = 'not started|in progress|completed|overdue|waived');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_description` SET TAGS ('dbx_business_glossary_term' = 'Sanction Description');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Effective Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Sanction');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `sanction_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Sanction');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `student_attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Student Attendance Status');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `student_attendance_status` SET TAGS ('dbx_value_regex' = 'attended|did not attend|excused absence');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `transcript_notation_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Notation Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `transcript_notation_text` SET TAGS ('dbx_business_glossary_term' = 'Transcript Notation Text');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `transcript_notation_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `violation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `violation_type_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Violation Type');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_case` ALTER COLUMN `violation_type_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Violation Type');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` SET TAGS ('dbx_subdomain' = 'behavioral_standards');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `conduct_sanction_id` SET TAGS ('dbx_business_glossary_term' = 'Conduct Sanction Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `account_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `conduct_case_id` SET TAGS ('dbx_business_glossary_term' = 'Conduct Case Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `studentlife_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `tertiary_conduct_waived_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waived By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `tertiary_conduct_waived_by_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `tertiary_conduct_waived_by_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `superseded_conduct_sanction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `appeal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligible Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Assigned Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Due Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Effective End Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Effective Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `external_agency_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'External Agency Reported Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `hold_placed_flag` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Placed Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'registration|transcript|graduation|financial|disciplinary');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Completed Hours');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `hours_required` SET TAGS ('dbx_business_glossary_term' = 'Required Hours');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sanction Notes');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `parent_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Parent Notification Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `parent_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Parent Notification Sent Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `restitution_amount` SET TAGS ('dbx_business_glossary_term' = 'Restitution Amount');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `restitution_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Restitution Paid Amount');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_category` SET TAGS ('dbx_business_glossary_term' = 'Sanction Category');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_category` SET TAGS ('dbx_value_regex' = 'educational|punitive|restorative|restrictive|administrative|interim');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_description` SET TAGS ('dbx_business_glossary_term' = 'Sanction Description');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_number` SET TAGS ('dbx_business_glossary_term' = 'Sanction Number');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Completion Status');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_completed|waived|appealed');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `sanction_type` SET TAGS ('dbx_business_glossary_term' = 'Sanction Type');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Sanction Severity Level');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|serious|severe');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `transcript_notation_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Notation Flag');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `transcript_notation_text` SET TAGS ('dbx_business_glossary_term' = 'Transcript Notation Text');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `transcript_notation_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`studentlife`.`conduct_sanction` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` SET TAGS ('dbx_subdomain' = 'campus_engagement');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `cocurricular_record_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Record Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `last_modified_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `prior_cocurricular_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `employer_verification_count` SET TAGS ('dbx_business_glossary_term' = 'Employer Verification Request Count');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `engagement_level` SET TAGS ('dbx_business_glossary_term' = 'Overall Engagement Level');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `engagement_level` SET TAGS ('dbx_value_regex' = 'minimal|moderate|active|highly_active|exceptional');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `first_activity_date` SET TAGS ('dbx_business_glossary_term' = 'First Co-Curricular Activity Date');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `graduate_school_verification_count` SET TAGS ('dbx_business_glossary_term' = 'Graduate School Verification Request Count');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `graduation_requirement_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Graduation Requirement Met Flag');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record Flag');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `major_program` SET TAGS ('dbx_business_glossary_term' = 'Major Program');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `most_recent_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Co-Curricular Activity Date');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Record Notes');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `primary_engagement_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Engagement Category');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Record Number');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Record Status');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|verified|pending_verification|archived|suspended');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `scholarship_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Eligible Flag');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `student_classification` SET TAGS ('dbx_business_glossary_term' = 'Student Classification');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `student_classification` SET TAGS ('dbx_value_regex' = 'freshman|sophomore|junior|senior|graduate|non_degree');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `total_awards_received` SET TAGS ('dbx_business_glossary_term' = 'Total Awards and Recognitions Received');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `total_cocurricular_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Co-Curricular Credits Earned');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `total_events_attended` SET TAGS ('dbx_business_glossary_term' = 'Total Events Attended');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `total_leadership_roles` SET TAGS ('dbx_business_glossary_term' = 'Total Leadership Roles Held');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `total_organizations_participated` SET TAGS ('dbx_business_glossary_term' = 'Total Organizations Participated');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `total_service_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Service Hours Logged');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `transcript_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Transcript Generation Date');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `transcript_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Hold Flag');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `transcript_release_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Release Authorized Flag');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `transcript_version_number` SET TAGS ('dbx_business_glossary_term' = 'Transcript Version Number');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`studentlife`.`cocurricular_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|partially_verified|pending_review|rejected');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` SET TAGS ('dbx_subdomain' = 'campus_engagement');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `service_learning_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Learning Placement Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Supervisor Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Irb Protocol Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Student Org Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `prior_service_learning_placement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `academic_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Academic Credit Hours (CR)');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `co_curricular_credit_awarded` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Credit Awarded');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `completed_service_hours` SET TAGS ('dbx_business_glossary_term' = 'Completed Service Hours');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `hours_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Hours Verification Method');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `hours_verification_method` SET TAGS ('dbx_value_regex' = 'timesheet|supervisor_confirmation|self_report|electronic_tracking');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `liability_waiver_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Liability Waiver Signed Flag');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Approval Status');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|conditional');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Placement End Date');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_notes` SET TAGS ('dbx_business_glossary_term' = 'Placement Notes');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_number` SET TAGS ('dbx_business_glossary_term' = 'Placement Number');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|withdrawn');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'course_embedded|co_curricular|hybrid|independent_study');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `reflection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reflection Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `reflection_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Reflection Submission Date');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `reflection_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Reflection Submission Status');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `reflection_submission_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|approved|revision_needed');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `required_service_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Service Hours');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 1');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line 2');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_city` SET TAGS ('dbx_business_glossary_term' = 'Site City');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Email Address');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Title');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_country_code` SET TAGS ('dbx_business_glossary_term' = 'Site Country Code');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Service Site Name');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_organization_type` SET TAGS ('dbx_business_glossary_term' = 'Site Organization Type');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Site Postal Code');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `site_state_province` SET TAGS ('dbx_business_glossary_term' = 'Site State or Province');
ALTER TABLE `education_ecm`.`studentlife`.`service_learning_placement` ALTER COLUMN `transportation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Provided Flag');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` SET TAGS ('dbx_subdomain' = 'wellness_support');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `wellness_program_id` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Program Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Program Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `prerequisite_wellness_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `attendance_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Requirement Percentage');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `cocurricular_competency_area` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Competency Area');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `cocurricular_credit_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Credit Eligible Flag');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `cocurricular_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Credit Hours');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `completion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Completion Criteria');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|confidential|restricted');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'workshop|online_module|peer_led|one_on_one|hybrid|group_session');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `facilitator_credentials` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Credentials');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `fee_waiver_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Available Flag');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `grant_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Flag');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `learning_outcomes` SET TAGS ('dbx_business_glossary_term' = 'Learning Outcomes');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `minimum_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Enrollment');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `online_platform` SET TAGS ('dbx_business_glossary_term' = 'Online Platform');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `partner_organizations` SET TAGS ('dbx_business_glossary_term' = 'Partner Organizations');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `prerequisite_requirements` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Requirements');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_capacity` SET TAGS ('dbx_business_glossary_term' = 'Program Capacity');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Fee Amount');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived|planned');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'substance_abuse_prevention|sexual_health_education|stress_management|nutrition_counseling|fitness_challenge|peer_health_education');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `session_count` SET TAGS ('dbx_business_glossary_term' = 'Session Count');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration in Minutes');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `sponsoring_department` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Department');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_program` ALTER COLUMN `total_contact_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Contact Hours');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` SET TAGS ('dbx_subdomain' = 'wellness_support');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `wellness_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Wellness Participation ID');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `conduct_case_id` SET TAGS ('dbx_business_glossary_term' = 'Conduct Case ID');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Staff ID');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `wellness_program_id` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program ID');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `prior_wellness_participation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `assessment_improvement_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Improvement Score');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Attendance Count');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `cocurricular_category` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Category');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `cocurricular_credit_awarded` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Credit Awarded');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'in-person|virtual|hybrid|self-paced');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `fee_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Waived Flag');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Program Location');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `participation_number` SET TAGS ('dbx_business_glossary_term' = 'Participation Number');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'enrolled|completed|withdrew|no-show|in-progress|cancelled');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `post_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Assessment Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `post_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Assessment Score');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `pre_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Assessment Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `pre_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Pre-Assessment Score');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `program_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Fee Amount');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `required_attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Required Attendance Count');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `satisfaction_comments` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Comments');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `satisfaction_rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating Scale');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `satisfaction_rating_scale` SET TAGS ('dbx_value_regex' = '1-5|1-10');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`studentlife`.`wellness_participation` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `roommate_group_id` SET TAGS ('dbx_business_glossary_term' = 'Roommate Group Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Residence Hall Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Group Leader Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `merged_from_roommate_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `accommodation_notes` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Notes');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `accommodation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `all_members_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'All Members Confirmed Flag');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `application_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline Date');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `assigned_room_number` SET TAGS ('dbx_business_glossary_term' = 'Assigned Room Number');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Date');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `building_preference_1` SET TAGS ('dbx_business_glossary_term' = 'First Building Preference');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `building_preference_2` SET TAGS ('dbx_business_glossary_term' = 'Second Building Preference');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `building_preference_3` SET TAGS ('dbx_business_glossary_term' = 'Third Building Preference');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Group Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `confirmed_member_count` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Member Count');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `current_member_count` SET TAGS ('dbx_business_glossary_term' = 'Current Member Count');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Group Dissolution Date');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `dissolution_reason` SET TAGS ('dbx_business_glossary_term' = 'Group Dissolution Reason');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Group Formation Date');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `formation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Group Formation Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender Inclusive Housing Flag');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Roommate Group Name');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `group_notes` SET TAGS ('dbx_business_glossary_term' = 'Roommate Group Notes');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Roommate Group Number');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `group_number` SET TAGS ('dbx_value_regex' = '^RMG-[0-9]{6,10}$');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `group_status` SET TAGS ('dbx_business_glossary_term' = 'Roommate Group Status');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `invitation_code` SET TAGS ('dbx_business_glossary_term' = 'Group Invitation Code');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `invitation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `invitation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Expiration Date');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `lifestyle_preference` SET TAGS ('dbx_business_glossary_term' = 'Lifestyle Preference');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `lottery_number` SET TAGS ('dbx_business_glossary_term' = 'Housing Lottery Number');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `priority_group` SET TAGS ('dbx_business_glossary_term' = 'Housing Priority Group');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `room_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Room Type Preference');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `room_type_preference` SET TAGS ('dbx_value_regex' = 'single|double|triple|quad|suite|apartment');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `special_accommodation_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Accommodation Requested Flag');
ALTER TABLE `education_ecm`.`studentlife`.`roommate_group` ALTER COLUMN `target_group_size` SET TAGS ('dbx_business_glossary_term' = 'Target Group Size');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `housing_waitlist_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Waitlist Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `housing_application_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `llc_program_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Offered Residence Hall Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Building Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `roommate_group_id` SET TAGS ('dbx_business_glossary_term' = 'Roommate Group Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `transferred_from_housing_waitlist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Description');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `accommodation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `deposit_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Payment Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `deposit_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Payment Status');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `deposit_payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|waived|refunded|not_required');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `deposit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender Inclusive Housing Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `gender_inclusive_housing_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Notes');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Housing Offer Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `offer_response_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Response Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `offer_response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Offer Response Deadline Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `offered_room_number` SET TAGS ('dbx_business_glossary_term' = 'Offered Room Number');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `offered_room_type` SET TAGS ('dbx_business_glossary_term' = 'Offered Room Type');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `priority_group` SET TAGS ('dbx_business_glossary_term' = 'Priority Group');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|standard');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Removal Date');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Removal Reason');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `requested_room_type` SET TAGS ('dbx_business_glossary_term' = 'Requested Room Type');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `special_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Accommodation Flag');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `waitlist_number` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Number');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position Number');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `waitlist_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Status');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `waitlist_type` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Type');
ALTER TABLE `education_ecm`.`studentlife`.`housing_waitlist` ALTER COLUMN `waitlist_type` SET TAGS ('dbx_value_regex' = 'general|building_specific|room_type_specific|llc|honors|medical_accommodation');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `llc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Program ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Llc Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Department ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `primary_llc_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Coordinator ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `primary_llc_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `primary_llc_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Fellow ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Hall ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `parent_llc_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `academic_course_requirement` SET TAGS ('dbx_business_glossary_term' = 'Academic Course Requirement');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `application_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `application_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Required Flag');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `cocurricular_requirements` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Requirements');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `cohort_capacity` SET TAGS ('dbx_business_glossary_term' = 'Cohort Capacity');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email Address');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone Number');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `current_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `eligible_class_levels` SET TAGS ('dbx_business_glossary_term' = 'Eligible Class Levels');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `floor_assignment` SET TAGS ('dbx_business_glossary_term' = 'Floor Assignment');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `gpa_requirement` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Requirement');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `learning_outcomes` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcomes (SLO)');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `marketing_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Description');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `minimum_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Enrollment');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `partnership_organizations` SET TAGS ('dbx_business_glossary_term' = 'Partnership Organizations');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Program Code');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Fee Amount');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_fee_period` SET TAGS ('dbx_business_glossary_term' = 'Program Fee Period');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_fee_period` SET TAGS ('dbx_value_regex' = 'Per Term|Per Semester|Per Year|One Time');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Program Name');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_short_name` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Program Short Name');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Under Review|Pilot|Discontinued');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `selection_process` SET TAGS ('dbx_business_glossary_term' = 'Selection Process');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `special_amenities` SET TAGS ('dbx_business_glossary_term' = 'Special Amenities');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `theme_category` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Theme Category');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `theme_description` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Theme Description');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`studentlife`.`llc_program` ALTER COLUMN `wing_section` SET TAGS ('dbx_business_glossary_term' = 'Wing or Section Assignment');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `llc_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Enrollment ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Staff ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Mentor ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `llc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Living Learning Community (LLC) Program ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Hall ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `studentlife_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `prior_llc_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `academic_standing` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `academic_standing` SET TAGS ('dbx_value_regex' = 'good_standing|probation|suspension|dismissal');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `application_essay_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Essay Submitted Flag');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `cocurricular_participation_hours` SET TAGS ('dbx_business_glossary_term' = 'Co-Curricular Participation Hours');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `cohort_year` SET TAGS ('dbx_business_glossary_term' = 'Cohort Year');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee Amount');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'applied|accepted|enrolled|withdrawn|completed|denied');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `fee_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Waived Flag');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `gpa_at_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) at Enrollment');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `gpa_requirement` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Requirement');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `participation_hours_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Participation Hours Met Flag');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `priority_group` SET TAGS ('dbx_business_glossary_term' = 'Priority Group');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `program_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Completion Flag');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `required_participation_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Participation Hours');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `transcript_notation_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Notation Flag');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`studentlife`.`llc_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` SET TAGS ('dbx_association_edges' = 'studentlife.residence_hall,technology.it_service');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `hall_service_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Hall Service Provision Identifier');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Hall Service Provision - It Service Id');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `residence_hall_id` SET TAGS ('dbx_business_glossary_term' = 'Hall Service Provision - Residence Hall Id');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `bandwidth_allocation_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Allocation');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `last_service_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Review Date');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `monthly_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Service Cost');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Notes');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `port_count` SET TAGS ('dbx_business_glossary_term' = 'Port Count');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `provision_status` SET TAGS ('dbx_business_glossary_term' = 'Provision Status');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Service Activation Date');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Service Contact Email');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Service Contact Name');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier');
ALTER TABLE `education_ecm`.`studentlife`.`hall_service_provision` ALTER COLUMN `sla_level` SET TAGS ('dbx_business_glossary_term' = 'SLA Level');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` SET TAGS ('dbx_subdomain' = 'campus_engagement');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` SET TAGS ('dbx_association_edges' = 'studentlife.student_org,technology.enterprise_application');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `org_application_access_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Application Access Identifier');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Org Application Access - Enterprise Application Id');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Org Application Access - Student Org Id');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Access Approver Name');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `deprovisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioning Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Access Expiration Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `license_count` SET TAGS ('dbx_business_glossary_term' = 'License Count');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Access Notes');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Date');
ALTER TABLE `education_ecm`.`studentlife`.`org_application_access` ALTER COLUMN `usage_purpose` SET TAGS ('dbx_business_glossary_term' = 'Usage Purpose');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` SET TAGS ('dbx_subdomain' = 'wellness_support');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `health_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Health Appointment Identifier');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `followup_health_appointment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `appointment_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `appointment_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `chief_complaint` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `copay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `visit_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`health_appointment` ALTER COLUMN `visit_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` SET TAGS ('dbx_subdomain' = 'residential_services');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ALTER COLUMN `housing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Contract Identifier');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ALTER COLUMN `renewed_housing_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`studentlife`.`housing_contract` ALTER COLUMN `special_accommodations` SET TAGS ('dbx_confidential' = 'true');
