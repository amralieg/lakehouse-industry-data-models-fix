-- Schema for Domain: athletics | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:27:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`athletics` COMMENT 'Manages intercollegiate and intramural athletics programs including team rosters, game schedules, recruiting, scholarships, facilities scheduling, and NCAA/NAIA compliance reporting for student-athletes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`athletic_eligibility` (
    `athletic_eligibility_id` BIGINT COMMENT 'Unique identifier for the athletic eligibility record.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Eligibility certification explicitly requires verification of enrollment in a degree program and calculation of progress_toward_degree_percentage against that programs requirements. Compliance office',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance staff member who certified this eligibility record.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional eligibility policies supplement NCAA regulations with institution-specific requirements. Real business process: eligibility officers apply institutional policies (e.g., minimum GPA above',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Eligibility determinations must cite specific NCAA/conference bylaws (regulatory requirements). Real business process: eligibility certification officers reference specific regulatory requirements (e.',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: athletic_eligibility tracks eligibility for a specific sport. Currently uses sport_code/sport_name but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve sport_name and other spo',
    `student_athlete_id` BIGINT COMMENT 'Identifier of the student-athlete whose eligibility is being tracked. Links to the student master record.',
    `title_ix_case_id` BIGINT COMMENT 'Foreign key linking to compliance.title_ix_case. Business justification: Title IX cases can result in interim measures or sanctions affecting athletic eligibility (suspension from team activities, no-contact orders). Real business process: eligibility officers place compli',
    `academic_year` STRING COMMENT 'The academic year for which this eligibility record applies (e.g., 2023-2024).',
    `amateurism_certification_status` STRING COMMENT 'Status of the student-athletes amateurism certification through the NCAA Eligibility Center.. Valid values are `Certified|Not Certified|Pending|Expired`',
    `athletic_scholarship_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is receiving an athletic scholarship.',
    `certification_timestamp` TIMESTAMP COMMENT 'The date and time when this eligibility record was certified.',
    `compliance_hold_flag` BOOLEAN COMMENT 'Indicates whether a compliance hold has been placed on the student-athlete preventing participation until resolved.',
    `compliance_hold_reason` STRING COMMENT 'Description of the reason for any compliance hold placed on the student-athlete.',
    `credit_hours_enrolled` DECIMAL(18,2) COMMENT 'The number of credit hours in which the student-athlete is currently enrolled.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'The cumulative GPA of the student-athlete across all terms.',
    `degree_applicable_credits_earned` DECIMAL(18,2) COMMENT 'The total number of degree-applicable credit hours earned by the student-athlete.',
    `division_level` STRING COMMENT 'The athletic division level under which the student-athlete competes (NCAA DI, DII, DIII, NAIA, or NJCAA). [ENUM-REF-CANDIDATE: NCAA Division I|NCAA Division II|NCAA Division III|NAIA|NJCAA Division I|NJCAA Division II|NJCAA Division III — 7 candidates stripped; promote to reference product]',
    `eligibility_certification_date` DATE COMMENT 'The date on which the current eligibility status was certified by the institutions compliance office.',
    `eligibility_notes` STRING COMMENT 'Additional notes or comments regarding the student-athletes eligibility status, waivers, or special circumstances.',
    `eligibility_status` STRING COMMENT 'Current eligibility status of the student-athlete for competition in this sport.. Valid values are `Eligible|Ineligible|Conditionally Eligible|Pending Review|Suspended|Reinstated`',
    `eligibility_year` STRING COMMENT 'The year of eligibility for the student-athlete (1st through 5th year, or 6th year in rare cases with medical hardship).. Valid values are `1st Year|2nd Year|3rd Year|4th Year|5th Year|6th Year`',
    `full_time_enrollment_verified` BOOLEAN COMMENT 'Indicates whether the student-athlete has been verified as enrolled full-time for the current term.',
    `gpa_threshold_met` BOOLEAN COMMENT 'Indicates whether the student-athlete meets the minimum GPA threshold required for athletic eligibility.',
    `initial_eligibility_certified_date` DATE COMMENT 'The date on which the student-athletes initial eligibility was certified by the NCAA Eligibility Center.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this eligibility record was last updated.',
    `medical_hardship_season` STRING COMMENT 'The season for which a medical hardship waiver was granted or requested.',
    `medical_hardship_waiver_status` STRING COMMENT 'Status of any medical hardship waiver request that would grant an additional year of eligibility due to injury or illness.. Valid values are `Approved|Denied|Pending|Not Requested`',
    `minimum_credit_hours_met` BOOLEAN COMMENT 'Indicates whether the student-athlete meets the minimum credit hour requirement for eligibility (typically 12 credit hours for full-time status).',
    `next_eligibility_review_date` DATE COMMENT 'The scheduled date for the next eligibility review (typically at the start of each term or season).',
    `one_time_transfer_exception_used` BOOLEAN COMMENT 'Indicates whether the student-athlete has used their one-time transfer exception allowing immediate eligibility.',
    `progress_toward_degree_met` BOOLEAN COMMENT 'Indicates whether the student-athlete meets the progress-toward-degree requirement for continued eligibility.',
    `progress_toward_degree_percentage` DECIMAL(18,2) COMMENT 'The percentage of degree requirements completed by the student-athlete, used to determine eligibility continuation.',
    `record_effective_date` DATE COMMENT 'The date from which this eligibility record is effective.',
    `record_expiration_date` DATE COMMENT 'The date on which this eligibility record expires or is superseded by a new record.',
    `redshirt_status` STRING COMMENT 'Indicates whether the student-athlete is redshirting (practicing but not competing to preserve a year of eligibility).. Valid values are `Redshirt|Medical Redshirt|Not Redshirted|Not Applicable`',
    `redshirt_year` STRING COMMENT 'The academic year during which the student-athlete redshirted, if applicable.',
    `satisfactory_academic_progress_met` BOOLEAN COMMENT 'Indicates whether the student-athlete meets Satisfactory Academic Progress standards required for financial aid and athletic eligibility.',
    `seasons_competed` STRING COMMENT 'The number of seasons of competition the student-athlete has used in this sport.',
    `seasons_remaining` STRING COMMENT 'The number of seasons of competition remaining for the student-athlete in this sport.',
    `term_gpa` DECIMAL(18,2) COMMENT 'The GPA of the student-athlete for the current or most recent term.',
    `transfer_eligibility_status` STRING COMMENT 'Eligibility status specific to transfer students, indicating whether transfer requirements have been met.. Valid values are `Eligible|Ineligible|Pending|Not Applicable`',
    `transfer_institution_name` STRING COMMENT 'Name of the institution from which the student-athlete transferred, if applicable.',
    `transfer_student_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is a transfer student from another institution.',
    CONSTRAINT pk_athletic_eligibility PRIMARY KEY(`athletic_eligibility_id`)
) COMMENT 'Tracks NCAA or NAIA athletic eligibility status for student-athletes. Captures sport, division level (NCAA DI/DII/DIII, NAIA), eligibility year (1st–5th year), seasons of competition used, seasons remaining, full-time enrollment verification, minimum credit hour compliance, GPA eligibility threshold met flag, progress-toward-degree percentage, transfer eligibility status, medical hardship waiver status, and eligibility certification date. Supports compliance reporting to the NCAA Eligibility Center.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`sport` (
    `sport_id` BIGINT COMMENT 'Unique identifier for the sport program record. Primary key.',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: Some sports programs (athletic training, exercise science) subject to specialized accreditation standards (CAATE, CoAES). Real business process: programs track compliance with accreditation standards ',
    `parent_sport_id` BIGINT COMMENT 'Self-referencing FK on sport (parent_sport_id)',
    `championship_eligible_flag` BOOLEAN COMMENT 'Indicates whether the sport program is currently eligible to compete in conference and national championship events.',
    `competition_end_date` DATE COMMENT 'Official date when the regular season and championship competition ends for the current or upcoming season.',
    `competition_start_date` DATE COMMENT 'Official date when the team may begin competing in sanctioned contests for the current or upcoming season.',
    `compliance_notes` STRING COMMENT 'Free-text field for sport-specific compliance notes, waivers, sanctions, or special conditions affecting the program.',
    `conference_affiliation` STRING COMMENT 'Name of the athletic conference to which this sport program belongs (e.g., Big Ten, ACC, Ivy League). Null for independent programs.',
    `contact_sport_flag` BOOLEAN COMMENT 'Indicates whether the sport involves physical contact between participants, used for insurance and medical clearance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sport record was first created in the system.',
    `division_level` STRING COMMENT 'Competitive division level for intercollegiate sports (NCAA Division I/II/III, NAIA, NJCAA).. Valid values are `division-i|division-ii|division-iii|naia|njcaa|not-applicable`',
    `eada_reporting_code` STRING COMMENT 'Federal reporting code used for EADA compliance submissions to the U.S. Department of Education.. Valid values are `^[A-Z0-9]{2,6}$`',
    `end_date` DATE COMMENT 'Date when the sport program was discontinued or suspended. Null for active programs.',
    `gender_classification` STRING COMMENT 'Gender designation for the sport program, used for Title IX compliance and roster management.. Valid values are `men|women|mixed|coed`',
    `governing_body_code` STRING COMMENT 'Code representing the primary athletic governing body for this sport program.. Valid values are `NCAA|NAIA|NJCAA|USCAA|NCCAA|NONE`',
    `ipeds_sport_code` STRING COMMENT 'IPEDS standardized sport code used for federal athletics data reporting.. Valid values are `^[0-9]{2,4}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sport record was most recently modified.',
    `maximum_contests_allowed` STRING COMMENT 'Maximum number of contests (games, matches, meets) the team may participate in during a season, as defined by governing body rules.',
    `maximum_roster_size` STRING COMMENT 'Maximum number of student-athletes allowed on the active roster for this sport, as defined by governing body rules.',
    `maximum_scholarship_equivalencies` DECIMAL(18,2) COMMENT 'Maximum number of full scholarship equivalencies allowed for this sport under NCAA/NAIA rules. For head-count sports, this equals the maximum number of scholarships.',
    `minimum_roster_size` STRING COMMENT 'Minimum number of student-athletes required to field a competitive team for this sport.',
    `ncaa_sport_classification` STRING COMMENT 'NCAA classification indicating whether the sport has a national championship, is an emerging sport, or is non-championship.. Valid values are `championship|emerging|non-championship|not-applicable`',
    `practice_start_date` DATE COMMENT 'Official date when organized team practices may begin for the current or upcoming season, as defined by governing body rules.',
    `primary_facility_name` STRING COMMENT 'Name of the primary home facility where this sport program competes and practices.',
    `record_effective_date` DATE COMMENT 'Date from which this version of the sport record is effective, supporting historical tracking and temporal queries.',
    `revenue_producing_flag` BOOLEAN COMMENT 'Indicates whether the sport program generates significant revenue through ticket sales, media rights, or sponsorships.',
    `scholarship_model` STRING COMMENT 'NCAA scholarship allocation model: head-count (full scholarships only) or equivalency (partial scholarships allowed).. Valid values are `head-count|equivalency|none`',
    `season_type` STRING COMMENT 'Primary competitive season for the sport program, used for scheduling and eligibility tracking.. Valid values are `fall|winter|spring|year-round|multi-season`',
    `sport_code` STRING COMMENT 'Standardized short code for the sport (e.g., MBBALL for Mens Basketball, WSOC for Womens Soccer). Used for reporting and system integration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `sport_name` STRING COMMENT 'Full official name of the sport program (e.g., Mens Basketball, Womens Soccer, Co-Ed Swimming and Diving).',
    `sport_status` STRING COMMENT 'Current operational status of the sport program within the institution.. Valid values are `active|inactive|suspended|discontinued|emerging`',
    `sport_type` STRING COMMENT 'Classification of the sport program by competitive level and organizational structure.. Valid values are `intercollegiate|intramural|club|recreational`',
    `start_date` DATE COMMENT 'Date when the institution first sponsored this sport program.',
    `team_sport_flag` BOOLEAN COMMENT 'Indicates whether the sport is a team sport (true) or an individual sport (false). Used for roster management and scholarship allocation.',
    `title_ix_countable_flag` BOOLEAN COMMENT 'Indicates whether this sport program counts toward Title IX gender equity participation and scholarship calculations.',
    `varsity_level_flag` BOOLEAN COMMENT 'Indicates whether this is a varsity-level program (true) or sub-varsity/junior varsity (false).',
    `website_url` STRING COMMENT 'Public-facing website URL for the sport program, used for recruiting and fan engagement.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_sport PRIMARY KEY(`sport_id`)
) COMMENT 'Master catalog record for every intercollegiate and intramural sport program offered by the institution. Captures sport code, sport name, gender classification (men/women/mixed/co-ed), sport type (intercollegiate/intramural/club), NCAA/NAIA sport classification, governing body code, season type (fall/winter/spring/year-round), team sport flag, head count vs equivalency scholarship model, maximum roster size, maximum scholarship equivalencies allowed, sport status (active/inactive/suspended), and sport-level compliance notes.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`team` (
    `team_id` BIGINT COMMENT 'Unique identifier for the athletic team. Primary key for the team entity.',
    `athletic_facility_id` BIGINT COMMENT 'Foreign key reference to the facilities management system identifying the primary home venue for the team.',
    `coach_id` BIGINT COMMENT 'Foreign key reference to the staff member serving as head coach of the team.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Each team has an annual operating budget covering travel, equipment, recruiting, and game-day expenses. Budget vs. actual tracking is essential for financial management, variance analysis, and ensurin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Athletic teams are organizational units with operating budgets tracked in finance systems. Budget officers monitor team expenditures (travel, equipment, recruiting) by cost center for financial report',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `predecessor_team_id` BIGINT COMMENT 'Self-referencing FK on team (predecessor_team_id)',
    `academic_year` STRING COMMENT 'Academic year in which the team competes, formatted as YYYY-YYYY (e.g., 2024-2025).. Valid values are `^d{4}-d{4}$`',
    `apr_score` DECIMAL(18,2) COMMENT 'The teams Academic Progress Rate (APR) score, a metric measuring academic eligibility and retention of student-athletes. Calculated as a multi-year rate out of 1000.',
    `assistant_coach_count` STRING COMMENT 'Number of assistant coaches assigned to the team.',
    `compliance_certification_date` DATE COMMENT 'Date on which the teams compliance certification was last completed or renewed.',
    `compliance_certification_status` STRING COMMENT 'Current compliance certification status of the team with respect to NCAA, NAIA, or NJCAA rules and institutional policies (Certified, Pending, Non-Compliant, Under Review).. Valid values are `Certified|Pending|Non-Compliant|Under Review`',
    `conference_affiliation` STRING COMMENT 'Name of the athletic conference to which the team belongs (e.g., Big Ten, SEC, ACC, Patriot League, Independent).',
    `conference_code` STRING COMMENT 'Standardized code for the athletic conference (e.g., B1G for Big Ten, SEC for Southeastern Conference, ACC for Atlantic Coast Conference).. Valid values are `^[A-Z0-9]{2,10}$`',
    `conference_losses` STRING COMMENT 'Number of losses in conference competition during the academic year.',
    `conference_standing` STRING COMMENT 'Final standing or rank of the team within its conference for the academic year (1 = first place).',
    `conference_wins` STRING COMMENT 'Number of wins in conference competition during the academic year.',
    `division_level` STRING COMMENT 'Competitive division level at which the team competes (e.g., NCAA Division I, NCAA Division II, NCAA Division III, NAIA, NJCAA, USCAA, Club, Intramural). [ENUM-REF-CANDIDATE: NCAA-DI|NCAA-DII|NCAA-DIII|NAIA|NJCAA-DI|NJCAA-DII|NJCAA-DIII|USCAA|Club|Intramural — 10 candidates stripped; promote to reference product]',
    `established_date` DATE COMMENT 'Date when the team was first established or added to the institutions athletics program.',
    `gender` STRING COMMENT 'Gender classification of the team: M (Mens), F (Womens), C (Coed/Mixed).. Valid values are `M|F|C`',
    `gsr_rate` DECIMAL(18,2) COMMENT 'The teams Graduation Success Rate (GSR), measuring the percentage of student-athletes who graduate within six years. Expressed as a percentage (0-100).',
    `home_venue_name` STRING COMMENT 'Name of the primary facility where the team plays home competitions (e.g., Memorial Stadium, Smith Arena, Johnson Field).',
    `losses` STRING COMMENT 'Total number of losses recorded by the team in the academic year.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review or certification audit of the team.',
    `nickname` STRING COMMENT 'Informal or abbreviated team name used in communications and media (e.g., Eagles, Wildcats, Bulldogs).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the team (e.g., special achievements, sanctions, coaching changes, facility renovations).',
    `operating_budget` DECIMAL(18,2) COMMENT 'Total operating budget allocated to the team for the academic year, including coaching salaries, travel, equipment, recruiting, and other operational expenses.',
    `postseason_eligible` BOOLEAN COMMENT 'Indicates whether the team is eligible to participate in postseason competition (conference tournament, NCAA tournament, bowl games). True if eligible, False if ineligible due to sanctions, APR penalties, or other restrictions.',
    `postseason_participation` STRING COMMENT 'Description of postseason competitions the team participated in during the academic year (e.g., Conference Tournament, NCAA Tournament Round of 32, Bowl Game).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the team record was last updated in the system.',
    `revenue_generated` DECIMAL(18,2) COMMENT 'Total revenue generated by the team during the academic year, including ticket sales, sponsorships, media rights, and donations.',
    `roster_limit` STRING COMMENT 'Maximum number of student-athletes allowed on the roster per governing body rules (NCAA, NAIA, NJCAA).',
    `roster_size` STRING COMMENT 'Total number of student-athletes on the team roster for the academic year.',
    `scholarship_limit` DECIMAL(18,2) COMMENT 'Maximum number of full-time equivalent (FTE) athletic scholarships allowed for the team per governing body rules.',
    `scholarships_awarded` DECIMAL(18,2) COMMENT 'Total full-time equivalent (FTE) athletic scholarships awarded to student-athletes on the team for the academic year.',
    `season` STRING COMMENT 'Primary competition season for the team within the academic year (Fall, Winter, Spring, Summer).. Valid values are `Fall|Winter|Spring|Summer`',
    `team_name` STRING COMMENT 'Official name of the team, typically including institution mascot and sport (e.g., Eagles Mens Basketball, Wildcats Womens Soccer).',
    `team_status` STRING COMMENT 'Current operational status of the team (Active, Inactive, Suspended, Probation, Discontinued).. Valid values are `Active|Inactive|Suspended|Probation|Discontinued`',
    `ties` STRING COMMENT 'Total number of tie games recorded by the team in the academic year (applicable to sports that allow ties).',
    `title_ix_compliant` BOOLEAN COMMENT 'Indicates whether the team is in compliance with Title IX gender equity requirements. True if compliant, False if non-compliant or under review.',
    `wins` STRING COMMENT 'Total number of wins recorded by the team in the academic year.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master record for each athletic team fielded by the institution in a given academic year. Represents the operational unit of competition — e.g., Mens Basketball 2024-25. Captures team name, sport reference, academic year, competitive division (NCAA DI/DII/DIII, NAIA, NJCAA), conference affiliation, home venue, head coach assignment, team status (active/inactive/suspended), win-loss-tie record, conference standing, postseason eligibility flag, and team-level compliance certification status.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`roster` (
    `roster_id` BIGINT COMMENT 'Unique identifier for the roster record. Primary key for the roster entity.',
    `employee_id` BIGINT COMMENT 'Reference to the athletics compliance staff member who certified this roster entry.',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete assigned to this roster slot.',
    `team_id` BIGINT COMMENT 'Reference to the athletic team for which this roster entry applies.',
    `prior_roster_id` BIGINT COMMENT 'Self-referencing FK on roster (prior_roster_id)',
    `academic_year` STRING COMMENT 'The academic year for which this roster assignment is valid, formatted as YYYY-YYYY (e.g., 2023-2024).. Valid values are `^d{4}-d{4}$`',
    `add_date` DATE COMMENT 'The date the student-athlete was officially added to the team roster.',
    `captain_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete serves as a team captain during this roster period.',
    `certification_date` DATE COMMENT 'The date this roster entry was certified for compliance with NCAA or NAIA regulations.',
    `certification_status` STRING COMMENT 'The compliance certification status of this roster entry for NCAA or NAIA reporting requirements.. Valid values are `certified|pending|not_certified|under_review`',
    `compliance_hold_flag` BOOLEAN COMMENT 'Indicates whether there is a compliance hold preventing the student-athlete from competing.',
    `compliance_hold_reason` STRING COMMENT 'Description of the reason for any compliance hold placed on the student-athlete.',
    `drop_date` DATE COMMENT 'The date the student-athlete was officially removed from the team roster, if applicable. Null if still active.',
    `eligibility_year` STRING COMMENT 'The year of athletic eligibility being used by the student-athlete during this roster period.. Valid values are `freshman|sophomore|junior|senior|graduate|fifth_year`',
    `eligibility_years_remaining` STRING COMMENT 'The number of years of athletic eligibility remaining for the student-athlete after this roster period.',
    `height_inches` STRING COMMENT 'The student-athletes height in inches as recorded for roster publication.',
    `high_school_name` STRING COMMENT 'The name of the high school or preparatory institution the student-athlete attended prior to enrollment.',
    `home_state` STRING COMMENT 'The two-letter state code representing the student-athletes home state or region.. Valid values are `^[A-Z]{2}$`',
    `hometown` STRING COMMENT 'The hometown or city of origin of the student-athlete, typically used for roster publication and media guides.',
    `injury_status` STRING COMMENT 'Current injury or health status of the student-athlete affecting their roster participation.. Valid values are `healthy|injured|recovering|out_for_season`',
    `jersey_number` STRING COMMENT 'The jersey number assigned to the student-athlete for this roster period.. Valid values are `^[0-9]{1,3}$`',
    `medical_redshirt_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is taking a medical redshirt year due to injury or medical condition.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this roster assignment, including special circumstances or administrative details.',
    `one_time_transfer_exception_used` BOOLEAN COMMENT 'Indicates whether the student-athlete has used their one-time transfer exception for immediate eligibility.',
    `position_code` STRING COMMENT 'The abbreviated code representing the position or role the student-athlete plays on the team (e.g., QB, PG, MF).',
    `position_name` STRING COMMENT 'The full descriptive name of the position or role the student-athlete plays on the team (e.g., Quarterback, Point Guard, Midfielder).',
    `practice_squad_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is on the practice squad rather than the active competition roster.',
    `previous_institution_name` STRING COMMENT 'The name of the previous college or university attended by the student-athlete if they are a transfer student.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this roster record was first created in the system.',
    `record_effective_date` DATE COMMENT 'The date from which this roster record is considered effective for reporting and compliance purposes.',
    `record_expiration_date` DATE COMMENT 'The date after which this roster record is no longer considered active or valid. Null if currently active.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this roster record was last modified in the system.',
    `recruiting_class_year` STRING COMMENT 'The year the student-athlete was recruited and signed to join the program (e.g., 2023).. Valid values are `^d{4}$`',
    `redshirt_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is redshirting during this roster period (true) or actively competing (false).',
    `roster_status` STRING COMMENT 'Current status of the student-athlete on the roster, indicating their participation and funding classification.. Valid values are `active|redshirt|medical_redshirt|walk_on|scholarship|non_scholarship`',
    `scholarship_percentage` DECIMAL(18,2) COMMENT 'The percentage of full scholarship funding awarded to the student-athlete for this roster period (0.00 to 100.00).',
    `scholarship_status` STRING COMMENT 'Indicates whether the student-athlete is receiving athletic scholarship funding and the level of that funding.. Valid values are `full_scholarship|partial_scholarship|walk_on|none`',
    `starter_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is designated as a starting player for the team.',
    `term_code` STRING COMMENT 'The academic term code for this roster assignment (e.g., 202410 for Fall 2024).. Valid values are `^[A-Z0-9]{6}$`',
    `transfer_eligibility_status` STRING COMMENT 'The eligibility status of a transfer student-athlete under NCAA transfer rules.. Valid values are `eligible|ineligible|pending|waiver_granted`',
    `transfer_student_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete transferred from another institution and is subject to transfer eligibility rules.',
    `weight_pounds` STRING COMMENT 'The student-athletes weight in pounds as recorded for roster publication.',
    CONSTRAINT pk_roster PRIMARY KEY(`roster_id`)
) COMMENT 'Transactional record associating a student-athlete with a specific team for a specific academic year and term. Represents the official roster slot. Captures student-athlete reference, team reference, academic year, roster status (active/redshirt/medical redshirt/walk-on/scholarship/non-scholarship), jersey number, position, eligibility year used (freshman/sophomore/junior/senior/graduate), years of eligibility remaining, roster add date, roster drop date, and roster certification status for NCAA/NAIA compliance.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`student_athlete` (
    `student_athlete_id` BIGINT COMMENT 'Unique identifier for the student athlete record. Primary key for the student athlete entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: NCAA/NAIA eligibility rules require student-athletes to be enrolled in a specific degree program and maintain satisfactory progress toward that degree. Compliance officers verify program enrollment an',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Student-athletes may request disability accommodations affecting athletic participation (modified practice schedules, equipment modifications, academic accommodations). Real business process: disabili',
    `employee_id` BIGINT COMMENT 'Reference to the athletics department academic advisor assigned to support the student athletes academic progress.',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Links student-athletes to faculty research advisors for thesis/dissertation/independent study projects. Required for academic advising tracking, research mentorship reporting, and institutional assess',
    `profile_id` BIGINT COMMENT 'Reference to the student profile in the Student Information System (SIS). Links the athlete record to their academic identity.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Athletics compliance officers verify student-athletes have no account holds (registration, transcript, financial) before certifying eligibility. Real business process: pre-competition eligibility veri',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to compliance.training_program. Business justification: Student-athletes required to complete annual compliance training (NCAA rules, Title IX, substance abuse, gambling, sports wagering). Real business process: compliance office assigns required training,',
    `transfer_student_athlete_id` BIGINT COMMENT 'Self-referencing FK on student_athlete (transfer_student_athlete_id)',
    `amateurism_certification_status` STRING COMMENT 'Status of the student athletes amateurism certification, confirming they have not violated amateur status rules.. Valid values are `certified|pending|denied|not_required`',
    `athletic_scholarship_flag` BOOLEAN COMMENT 'Indicates whether the student athlete receives an athletic scholarship. True if scholarship awarded, False otherwise.',
    `compliance_hold_flag` BOOLEAN COMMENT 'Indicates whether a compliance hold has been placed on the student athlete preventing competition. True if hold exists, False otherwise.',
    `compliance_hold_reason` STRING COMMENT 'Explanation of why a compliance hold was placed on the student athlete (e.g., missing documentation, academic deficiency, rules violation investigation).',
    `division_level` STRING COMMENT 'The competitive division level at which the student athlete competes (NCAA Division I, II, III, NAIA, or NJCAA).. Valid values are `NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA`',
    `drug_testing_pool_flag` BOOLEAN COMMENT 'Indicates whether the student athlete is in the drug testing pool subject to random testing. True if in pool, False otherwise.',
    `eligibility_clock_start_term` STRING COMMENT 'Academic term when the student athletes eligibility clock began (format: YYYYTT where TT is 10=Fall, 20=Spring, 30=Summer).. Valid values are `^[0-9]{4}(10|20|30)$`',
    `eligibility_years_remaining` STRING COMMENT 'Number of years of athletic eligibility remaining for the student athlete.',
    `eligibility_years_used` STRING COMMENT 'Number of years of athletic eligibility the student athlete has used to date.',
    `enrollment_status` STRING COMMENT 'Current academic enrollment status of the student athlete. Full-time enrollment is typically required for athletic eligibility.. Valid values are `full_time|part_time|not_enrolled`',
    `height_inches` STRING COMMENT 'The student athletes height measured in inches. Used for roster information and sport-specific requirements.',
    `high_school_name` STRING COMMENT 'Name of the high school the student athlete attended prior to enrollment.',
    `hometown` STRING COMMENT 'The student athletes hometown (city and state/province) for roster and media guide purposes.',
    `initial_eligibility_certified_date` DATE COMMENT 'Date when the student athletes initial eligibility was certified by the NCAA Eligibility Center or equivalent governing body.',
    `jersey_number` STRING COMMENT 'The jersey number assigned to the student athlete for competition.. Valid values are `^[0-9]{1,3}$`',
    `medical_hardship_season` STRING COMMENT 'The season for which a medical hardship waiver was granted or requested (e.g., Fall 2022, Spring 2023).',
    `medical_hardship_waiver_status` STRING COMMENT 'Status of any medical hardship waiver request for additional eligibility due to injury or illness.. Valid values are `approved|denied|pending|not_requested`',
    `nil_agreement_flag` BOOLEAN COMMENT 'Indicates whether the student athlete has active Name, Image, and Likeness (NIL) agreements. True if NIL agreements exist, False otherwise.',
    `one_time_transfer_exception_used` BOOLEAN COMMENT 'Indicates whether the student athlete has used their one-time transfer exception allowing immediate eligibility. True if used, False if not.',
    `position` STRING COMMENT 'The primary playing position of the student athlete within their sport (e.g., Forward, Goalkeeper, Pitcher, Setter).',
    `previous_institution_name` STRING COMMENT 'Name of the previous institution from which the student athlete transferred, if applicable.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the student athlete record was first created in the athletics system.',
    `record_effective_date` DATE COMMENT 'Date when the current version of the student athlete record became effective. Used for historical tracking and compliance reporting.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the student athlete record was last updated in the athletics system.',
    `recruitment_class_year` STRING COMMENT 'The academic year in which the student athlete was recruited and entered the institution (e.g., 2023 for Fall 2023 recruits).',
    `redshirt_status` STRING COMMENT 'Indicates whether the student athlete is redshirting (preserving a year of eligibility by not competing). Includes standard redshirt, medical redshirt, or non-redshirt status.. Valid values are `redshirt|non_redshirt|medical_redshirt|not_applicable`',
    `redshirt_year` STRING COMMENT 'Academic term when the student athlete took a redshirt year (format: YYYYTT where TT is 10=Fall, 20=Spring, 30=Summer).. Valid values are `^[0-9]{4}(10|20|30)$`',
    `scholarship_percentage` DECIMAL(18,2) COMMENT 'Percentage of athletic scholarship awarded, expressed as a decimal (e.g., 75.00 for 75% scholarship). Used for equivalency sports.',
    `scholarship_type` STRING COMMENT 'Type of athletic scholarship awarded: full (covers full cost of attendance), partial (covers portion of costs), or none.. Valid values are `full|partial|none`',
    `secondary_sport_code` STRING COMMENT 'Optional secondary sport code for multi-sport athletes. Uses standard NCAA sport codes.. Valid values are `^[A-Z]{2,6}$`',
    `team_roster_status` STRING COMMENT 'Current status of the student athlete on the team roster. Indicates whether they are actively competing, injured, suspended, or no longer on the team.. Valid values are `active|inactive|suspended|injured|graduated|withdrawn`',
    `total_eligibility_years_granted` STRING COMMENT 'Total number of years of athletic eligibility granted to the student athlete. Typically 4 years for NCAA, but may be extended with waivers.',
    `transfer_eligibility_status` STRING COMMENT 'Current eligibility status for transfer student athletes. Indicates whether transfer eligibility requirements have been met.. Valid values are `eligible|ineligible|pending|not_applicable`',
    `transfer_student_flag` BOOLEAN COMMENT 'Indicates whether the student athlete transferred from another institution. True if transfer, False if not.',
    `weight_pounds` STRING COMMENT 'The student athletes weight measured in pounds. Used for roster information and sport-specific requirements.',
    CONSTRAINT pk_student_athlete PRIMARY KEY(`student_athlete_id`)
) COMMENT 'Master record for every student who participates or has participated in an intercollegiate or intramural athletic program. Serves as the athletics-domain identity anchor, extending the student.profile with athletics-specific attributes. Captures student reference, sport(s) of participation, recruitment class year, athletic scholarship flag, initial eligibility certification date, eligibility clock start term, total eligibility years granted, transfer eligibility status, medical hardship waiver history, and athletics department advising assignment.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`eligibility_certification` (
    `eligibility_certification_id` BIGINT COMMENT 'Unique identifier for the eligibility certification record. Primary key for this transactional record of NCAA or NAIA eligibility certification conducted for a student-athlete.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Eligibility certification documents must reference the specific academic program to calculate degree_applicable_credits_earned and progress_toward_degree_percentage. Required for NCAA compliance repor',
    `employee_id` BIGINT COMMENT 'Unique identifier for the compliance staff member or faculty athletics representative who certified this eligibility determination.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Eligibility certifications document compliance with specific regulatory requirements (NCAA bylaws, conference rules). Real business process: certification records must reference the specific regulator',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: eligibility_certification certifies eligibility for a specific sport. Currently uses sport_code/sport_name but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve sport_name and o',
    `student_athlete_id` BIGINT COMMENT 'Unique identifier for the student-athlete undergoing eligibility certification. Links to the student-athlete master record.',
    `prior_eligibility_certification_id` BIGINT COMMENT 'Self-referencing FK on eligibility_certification (prior_eligibility_certification_id)',
    `academic_year` STRING COMMENT 'The academic year for which this eligibility certification applies, formatted as YYYY-YYYY (e.g., 2023-2024).. Valid values are `^d{4}-d{4}$`',
    `amateurism_certification_status` STRING COMMENT 'Status of the student-athletes amateurism certification, confirming they have not violated amateur status rules.. Valid values are `certified|not_certified|pending|waiver_approved|not_applicable`',
    `athletic_scholarship_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is receiving athletically-related financial aid during this certification period.',
    `certification_date` DATE COMMENT 'Date when this eligibility certification was officially completed and approved by the certifying official.',
    `certification_notes` STRING COMMENT 'Additional notes, comments, or documentation related to this eligibility certification, including any special circumstances or conditions.',
    `certification_number` STRING COMMENT 'Business identifier or reference number assigned to this eligibility certification event. May be used for tracking and audit purposes.',
    `certification_status` STRING COMMENT 'Current status of the eligibility certification process indicating whether the student-athlete has been certified, denied, or is awaiting review or waiver decision.. Valid values are `certified|not_certified|pending|waiver_pending|conditionally_certified|ineligible`',
    `certification_term` STRING COMMENT 'The specific academic term or period for which eligibility is certified (fall, spring, summer, or full academic year).. Valid values are `fall|spring|summer|full_year`',
    `certification_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility certification record was created in the system, representing the business event time of the certification action.',
    `certifying_official_name` STRING COMMENT 'Full name of the compliance staff member or faculty athletics representative who certified this eligibility determination.',
    `compliance_hold_flag` BOOLEAN COMMENT 'Indicates whether a compliance hold has been placed on the student-athletes eligibility pending resolution of a compliance issue.',
    `compliance_hold_reason` STRING COMMENT 'Description of the reason for any compliance hold placed on the student-athletes eligibility.',
    `credit_hours_enrolled` DECIMAL(18,2) COMMENT 'Number of credit hours in which the student-athlete is enrolled for the certification term.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'The student-athletes cumulative grade point average at the time of certification.',
    `degree_applicable_credits_earned` DECIMAL(18,2) COMMENT 'Total number of degree-applicable credit hours earned by the student-athlete toward their declared degree program.',
    `degree_applicable_credits_required` DECIMAL(18,2) COMMENT 'Minimum number of degree-applicable credit hours required to be earned by this point in the student-athletes academic career for eligibility certification.',
    `division_level` STRING COMMENT 'The competitive division level under which the student-athlete competes (NCAA Division I, II, III, NAIA, NJCAA, or other).. Valid values are `NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA|other`',
    `eligibility_year` STRING COMMENT 'The year of eligibility being used by the student-athlete for this certification period (typically 1 through 5, representing freshman through fifth-year eligibility).',
    `full_time_enrollment_verified` BOOLEAN COMMENT 'Flag indicating whether the student-athletes full-time enrollment status has been verified for the certification period.',
    `gpa_requirement_met` BOOLEAN COMMENT 'Flag indicating whether the student-athlete meets the minimum GPA requirement for eligibility.',
    `initial_eligibility_certified_date` DATE COMMENT 'Date when the student-athletes initial eligibility was certified by the NCAA Eligibility Center or NAIA Eligibility Center upon first enrollment.',
    `initial_eligibility_clearance_source` STRING COMMENT 'The organization or process that provided initial eligibility clearance for the student-athlete (NCAA Eligibility Center, NAIA Eligibility Center, or institutional review).. Valid values are `NCAA_Eligibility_Center|NAIA_Eligibility_Center|institutional_review|not_applicable`',
    `medical_hardship_waiver_status` STRING COMMENT 'Status of any medical hardship waiver request that may affect the student-athletes eligibility or season of competition count.. Valid values are `approved|denied|pending|not_applicable`',
    `minimum_credit_hours_met` BOOLEAN COMMENT 'Flag indicating whether the student-athlete meets the minimum credit hour requirement for eligibility.',
    `minimum_credit_hours_required` DECIMAL(18,2) COMMENT 'Minimum number of credit hours required for full-time enrollment status and eligibility certification based on NCAA or NAIA rules.',
    `minimum_gpa_required` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA required for eligibility certification based on NCAA or NAIA academic progress rules.',
    `next_eligibility_review_date` DATE COMMENT 'Scheduled date for the next eligibility review or certification for this student-athlete.',
    `one_time_transfer_exception_used` BOOLEAN COMMENT 'Flag indicating whether the student-athlete has used their one-time transfer exception allowing immediate eligibility after transfer.',
    `progress_toward_degree_met` BOOLEAN COMMENT 'Flag indicating whether the student-athlete meets the progress toward degree requirement for eligibility.',
    `progress_toward_degree_percentage` DECIMAL(18,2) COMMENT 'Percentage of degree requirements completed by the student-athlete at the time of certification, used to assess satisfactory academic progress.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility certification record was first inserted into the data system for audit and lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eligibility certification record was last modified in the data system for audit and lineage tracking.',
    `redshirt_status` STRING COMMENT 'Indicates whether the student-athlete is using a redshirt year (practicing but not competing to preserve a year of eligibility).. Valid values are `redshirt|not_redshirt|medical_redshirt|not_applicable`',
    `seasons_competed` STRING COMMENT 'Total number of seasons the student-athlete has competed in this sport prior to this certification period.',
    `seasons_remaining` STRING COMMENT 'Number of seasons of eligibility remaining for the student-athlete after this certification period.',
    `term_gpa` DECIMAL(18,2) COMMENT 'The student-athletes grade point average for the most recently completed term prior to certification.',
    `transfer_eligibility_status` STRING COMMENT 'Status of transfer eligibility clearance for student-athletes who transferred from another institution, indicating whether they are immediately eligible or subject to transfer restrictions.. Valid values are `eligible|ineligible|pending|waiver_approved|one_time_exception_used|not_applicable`',
    `transfer_institution_name` STRING COMMENT 'Name of the previous institution from which the student-athlete transferred, if applicable.',
    `transfer_student_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete is a transfer student from another institution, which may affect eligibility rules and certification requirements.',
    `waiver_case_reference` STRING COMMENT 'Reference number or identifier for any waiver case submitted on behalf of the student-athlete related to this eligibility certification.',
    CONSTRAINT pk_eligibility_certification PRIMARY KEY(`eligibility_certification_id`)
) COMMENT 'Transactional record of the formal NCAA or NAIA eligibility certification conducted for a student-athlete each academic year. Captures certification period (academic year/term), certifying official, certification status (certified/not certified/pending/waiver pending), eligibility year being used, full-time enrollment verification, minimum credit hour progress rule compliance, GPA compliance flag, transfer eligibility clearance status, initial eligibility clearance source (NCAA Eligibility Center/NAIA Eligibility Center), certification date, and any waiver case references.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`athletic_scholarship` (
    `athletic_scholarship_id` BIGINT COMMENT 'Unique identifier for the athletic scholarship award record.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Scholarship expenses must post to specific general ledger accounts for financial statement preparation, EADA reporting (athletically-related student aid by gender), and NCAA financial reporting. Requi',
    `aid_award_id` BIGINT COMMENT 'Foreign key linking to aid.award. Business justification: Athletic scholarships are a type of financial aid award. This FK links athletic_scholarship to the aid award master, enabling unified financial aid tracking and compliance reporting (NCAA, Title IX, I',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Athletic scholarships are funded from specific restricted endowments, unrestricted operating funds, or donor-designated funds. Required for fund accounting, donor stewardship reporting, endowment spen',
    `nli_id` BIGINT COMMENT 'Foreign key linking to athletics.nli. Business justification: athletic_scholarship references nli_reference_number and nli_signed_date, indicating a relationship to the nli (National Letter of Intent) table. Adding nli_id FK enables JOIN to retrieve full NLI det',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional scholarship policies govern award processes, renewal criteria, and reduction/cancellation procedures beyond NCAA minimums. Real business process: scholarship award approval workflow requ',
    `employee_id` BIGINT COMMENT 'Unique identifier of the compliance staff member who verified the scholarship award. Null if verification is pending.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Scholarship awards must comply with specific NCAA regulations (equivalency limits, counter rules, financial aid bylaws). Real business process: compliance officers verify each scholarship against spec',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Athletic scholarships post as credits to student billing accounts. Financial aid office reconciles athletic aid with account balances for compliance reporting, billing statement generation, and 1098-T',
    `student_athlete_id` BIGINT COMMENT 'Unique identifier for the student-athlete receiving the scholarship award.',
    `tuition_charge_id` BIGINT COMMENT 'Foreign key linking to billing.tuition_charge. Business justification: Athletic scholarships offset specific tuition charges. Business must track which charges are covered by athletic aid for revenue recognition, 1098-T reporting, and NCAA compliance verification of scho',
    `renewed_athletic_scholarship_id` BIGINT COMMENT 'Self-referencing FK on athletic_scholarship (renewed_athletic_scholarship_id)',
    `academic_year` STRING COMMENT 'Academic year for which the scholarship is awarded, formatted as YYYY-YYYY (e.g., 2023-2024).. Valid values are `^d{4}-d{4}$`',
    `aid_type` STRING COMMENT 'Primary classification of the financial aid: athletic (based on athletic ability), academic (based on academic achievement), need_based (based on financial need), merit_based (based on non-athletic merit), or combined (multiple criteria).. Valid values are `athletic|academic|need_based|merit_based|combined`',
    `appeal_decision_date` DATE COMMENT 'Date when the final decision on the appeal was rendered. Null if appeal is pending or no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete has filed an appeal regarding scholarship reduction or cancellation (true) or no appeal has been filed (false).',
    `appeal_status` STRING COMMENT 'Current status of the student-athletes appeal: pending (under review), approved (appeal granted), denied (appeal rejected), or withdrawn (appeal retracted by student-athlete). Null if no appeal has been filed.. Valid values are `pending|approved|denied|withdrawn`',
    `award_approval_date` DATE COMMENT 'Date when the scholarship award was officially approved by the authorized staff member or committee.',
    `award_end_date` DATE COMMENT 'Date when the scholarship award period ends. May be null for multi-year awards pending annual renewal.',
    `award_start_date` DATE COMMENT 'Date when the scholarship award period begins and financial aid becomes effective.',
    `cancellation_date` DATE COMMENT 'Date when the scholarship cancellation became effective. Null if no cancellation has occurred.',
    `cancellation_flag` BOOLEAN COMMENT 'Indicates whether the scholarship has been cancelled before the end of the award period (true) or remains in effect (false).',
    `cancellation_reason` STRING COMMENT 'Detailed explanation for why the scholarship was cancelled, including reference to applicable NCAA bylaws or institutional policies. Null if no cancellation has occurred.',
    `compliance_verified_date` DATE COMMENT 'Date when the compliance office completed verification of the scholarship award. Null if verification is pending.',
    `compliance_verified_flag` BOOLEAN COMMENT 'Indicates whether the scholarship has been verified by the compliance office to meet all NCAA/NAIA regulations and institutional policies (true) or verification is pending (false).',
    `counter_exemption_reason` STRING COMMENT 'Explanation for why the scholarship is exempt from counting toward team limits (e.g., medical hardship waiver, academic honor award, need-based aid). Null if scholarship counts as a counter.',
    `counter_flag` BOOLEAN COMMENT 'Indicates whether this scholarship counts toward the teams NCAA/NAIA equivalency or head count limit (true) or is exempt from counting (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scholarship record was first created in the system.',
    `division_level` STRING COMMENT 'Athletic division level under which the scholarship is governed: NCAA Division I, II, or III, NAIA, or NJCAA (National Junior College Athletic Association).. Valid values are `NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA`',
    `equivalency_value` DECIMAL(18,2) COMMENT 'Numeric value representing the scholarship as a fraction of a full equivalency (e.g., 0.5000 for half scholarship, 1.0000 for full). Used for NCAA/NAIA equivalency limit calculations.',
    `fund_source` STRING COMMENT 'Source of funding for the scholarship (e.g., athletic department budget, endowment, donor-funded, institutional aid, conference grant).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the scholarship record was last modified in the system.',
    `multi_year_award_flag` BOOLEAN COMMENT 'Indicates whether the scholarship is a multi-year award guaranteed beyond a single academic year (true) or a one-year renewable award (false).',
    `multi_year_duration_years` STRING COMMENT 'Number of years for which a multi-year scholarship is guaranteed. Null for one-year renewable awards.',
    `nli_reference_number` STRING COMMENT 'Reference number for the National Letter of Intent signed by the student-athlete committing to the institution. Null if no NLI was signed.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the scholarship award.',
    `record_effective_date` DATE COMMENT 'Date when this version of the scholarship record became effective for reporting and compliance purposes.',
    `reduction_amount` DECIMAL(18,2) COMMENT 'Dollar amount by which the scholarship was reduced. Null if no reduction has occurred.',
    `reduction_date` DATE COMMENT 'Date when the scholarship reduction became effective. Null if no reduction has occurred.',
    `reduction_flag` BOOLEAN COMMENT 'Indicates whether the scholarship award amount has been reduced during the award period (true) or remains at the original amount (false).',
    `reduction_reason` STRING COMMENT 'Detailed explanation for why the scholarship was reduced, including reference to applicable NCAA bylaws or institutional policies. Null if no reduction has occurred.',
    `renewal_status` STRING COMMENT 'Status of scholarship renewal for the subsequent academic year: renewed (approved for continuation), not_renewed (not extended), pending_review (under evaluation), or ineligible (student-athlete does not meet renewal criteria).. Valid values are `renewed|not_renewed|pending_review|ineligible`',
    `scholarship_status` STRING COMMENT 'Current lifecycle status of the scholarship award: active (currently in effect), renewed (extended for another period), reduced (amount decreased), cancelled (terminated before completion), completed (award period ended normally), or pending (approved but not yet effective).. Valid values are `active|renewed|reduced|cancelled|completed|pending`',
    `scholarship_type` STRING COMMENT 'Classification of the scholarship award: full (covers full cost of attendance), partial (covers portion of costs), equivalency (counted toward team equivalency limit), or head_count (counted as one full scholarship regardless of amount).. Valid values are `full|partial|equivalency|head_count`',
    CONSTRAINT pk_athletic_scholarship PRIMARY KEY(`athletic_scholarship_id`)
) COMMENT 'Master record for each athletic scholarship award granted to a student-athlete. Captures scholarship type (full/partial/equivalency), award amount, award period (academic year), sport, scholarship equivalency value, National Letter of Intent (NLI) reference, scholarship renewal status, reduction or cancellation flag, reason for reduction/cancellation, appeal status, counters toward team equivalency limit flag, and compliance with NCAA/NAIA scholarship limits.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`nli` (
    `nli_id` BIGINT COMMENT 'Unique identifier for the National Letter of Intent agreement record.',
    `employee_id` BIGINT COMMENT 'Reference to the athletics compliance officer who reviewed and certified the NLI for NCAA compliance.',
    `nli_employee_id` BIGINT COMMENT 'Reference to the staff member (coach or recruiting coordinator) who managed the recruitment and NLI process for this prospect.',
    `prospect_id` BIGINT COMMENT 'Reference to the recruiting prospect record if the athlete has not yet enrolled.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: National Letter of Intent process governed by specific NCAA regulations and NLI program rules. Real business process: compliance officers review NLI signings against specific regulatory requirements (',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: National Letter of Intent commits institution to multi-year scholarship funding. Financial aid office links NLI to student account for tracking scholarship commitment fulfillment, ensuring promised ai',
    `student_athlete_id` BIGINT COMMENT 'Reference to the prospective student-athlete who signed the NLI agreement.',
    `superseded_nli_id` BIGINT COMMENT 'Self-referencing FK on nli (superseded_nli_id)',
    `academic_year_commitment` STRING COMMENT 'Academic year for which the prospective student-athlete commits to enroll and compete (e.g., 2024-2025).',
    `compliance_certification_date` DATE COMMENT 'Date on which the athletics compliance office certified that the NLI and recruitment process met all NCAA regulations.',
    `division_level` STRING COMMENT 'Athletic division level under which the NLI was signed.. Valid values are `Division I|Division II|Division III|NAIA|NJCAA`',
    `document_number` STRING COMMENT 'Official document number assigned to the signed NLI by the NCAA Eligibility Center or institutional athletics compliance office.',
    `enrollment_term` STRING COMMENT 'Academic term in which the student-athlete is expected to enroll under the NLI commitment.. Valid values are `Fall|Spring|Summer`',
    `expiration_date` DATE COMMENT 'Date on which the NLI commitment expires if the student-athlete does not enroll by the specified term.',
    `initial_eligibility_status` STRING COMMENT 'Status of the prospects initial eligibility certification by the NCAA Eligibility Center at the time of NLI signing.. Valid values are `Certified|Pending|Not Certified`',
    `institutional_signatory_name` STRING COMMENT 'Name of the institutional representative (typically Director of Athletics or designee) who signed the NLI on behalf of the institution.',
    `institutional_signatory_title` STRING COMMENT 'Official title of the institutional representative who signed the NLI (e.g., Director of Athletics, Compliance Officer).',
    `institutional_signature_date` DATE COMMENT 'Date on which the institutional representative signed the NLI, completing the binding agreement.',
    `ncaa_eligibility_center_number` STRING COMMENT 'Unique identifier assigned to the prospective student-athlete by the NCAA Eligibility Center for tracking initial eligibility certification.',
    `nli_status` STRING COMMENT 'Current status of the NLI agreement indicating whether it is active, voided, released, expired, or pending institutional acceptance.. Valid values are `Signed|Voided|Released|Expired|Pending`',
    `notes` STRING COMMENT 'Additional notes, comments, or special circumstances related to the NLI agreement, including any exceptions or unique conditions.',
    `parent_guardian_signature_date` DATE COMMENT 'Date on which the parent or legal guardian signed the NLI, if required.',
    `parent_guardian_signature_required` BOOLEAN COMMENT 'Indicates whether a parent or legal guardian signature was required on the NLI due to the prospect being a minor at the time of signing.',
    `penalty_waiver_date` DATE COMMENT 'Date on which the penalty waiver decision was rendered by the NCAA or institutional authority.',
    `penalty_waiver_status` STRING COMMENT 'Status of any waiver request to reduce or eliminate penalties associated with breaking the NLI commitment.. Valid values are `Granted|Denied|Pending|Not Applicable`',
    `program_year` STRING COMMENT 'NCAA NLI program year under which the agreement was executed, governing the applicable rules and regulations.',
    `record_created_by` STRING COMMENT 'User or system identifier of the person or process that created the NLI record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NLI record was first created in the system.',
    `record_updated_by` STRING COMMENT 'User or system identifier of the person or process that last updated the NLI record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the NLI record was last modified in the system.',
    `release_approval_date` DATE COMMENT 'Date on which the institution approved or denied the student-athletes release request.',
    `release_approval_status` STRING COMMENT 'Status of the institutional decision on the student-athletes request for release from the NLI.. Valid values are `Approved|Denied|Pending|Not Requested`',
    `release_conditions` STRING COMMENT 'Any conditions or restrictions placed on the release from the NLI (e.g., restrictions on contacting specific institutions, geographic limitations).',
    `release_request_date` DATE COMMENT 'Date on which the student-athlete formally requested release from the NLI commitment.',
    `release_request_reason` STRING COMMENT 'Documented reason provided by the student-athlete for requesting release from the NLI (e.g., coaching change, personal circumstances, academic program unavailability).',
    `scholarship_duration_years` DECIMAL(18,2) COMMENT 'Number of years for which the athletic scholarship is guaranteed under the NLI agreement.',
    `scholarship_offered` BOOLEAN COMMENT 'Indicates whether an athletic scholarship was offered as part of the NLI agreement.',
    `scholarship_type` STRING COMMENT 'Type of athletic scholarship offered (full, partial, or none) as part of the NLI commitment.. Valid values are `Full|Partial|None`',
    `signing_date` DATE COMMENT 'Date on which the prospective student-athlete signed the National Letter of Intent.',
    `signing_period` STRING COMMENT 'Designated NCAA signing period during which the NLI was executed (Early, Regular, or Late).. Valid values are `Early Signing Period|Regular Signing Period|Late Signing Period`',
    `void_date` DATE COMMENT 'Date on which the NLI was officially voided.',
    `void_reason` STRING COMMENT 'Documented reason for voiding the NLI (e.g., failure to meet admission requirements, NCAA eligibility issues, institutional program discontinuation).',
    CONSTRAINT pk_nli PRIMARY KEY(`nli_id`)
) COMMENT 'Master record for a National Letter of Intent (NLI) agreement signed by a prospective student-athlete committing to attend the institution. Captures prospect/student-athlete reference, sport, signing date, academic year of enrollment commitment, NLI status (signed/voided/released/expired), release request date, release approval status, penalty waiver status, NLI program year, and institutional signatory. Governs the binding commitment between the institution and the prospective athlete.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`recruit` (
    `recruit_id` BIGINT COMMENT 'Unique identifier for the prospective student-athlete recruit record. Primary key.',
    `coach_id` BIGINT COMMENT 'Identifier of the coaching staff member assigned as the primary recruiter for this prospect.',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: recruit is being recruited for a specific sport. Currently uses sport_code/sport_name but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve sport_name and other sport attributes',
    `transfer_recruit_id` BIGINT COMMENT 'Self-referencing FK on recruit (transfer_recruit_id)',
    `academic_eligibility_status` STRING COMMENT 'Pre-screening status of the prospects academic eligibility for NCAA competition based on high school coursework and standardized test scores.. Valid values are `not_screened|pending|cleared|at_risk|ineligible`',
    `act_score` STRING COMMENT 'Prospects ACT composite score, used in conjunction with GPA for NCAA initial eligibility determination.',
    `first_contact_date` DATE COMMENT 'Date of the initial permissible contact between coaching staff and the prospect.',
    `gpa` DECIMAL(18,2) COMMENT 'Cumulative high school grade point average of the prospect on a 4.0 scale, used for initial eligibility determination.',
    `height_inches` STRING COMMENT 'Prospects height measured in total inches, relevant for sport-specific evaluation.',
    `high_school_city` STRING COMMENT 'City where the prospects high school or secondary institution is located.',
    `high_school_graduation_year` STRING COMMENT 'Year the prospect is expected to graduate from high school or secondary institution.',
    `high_school_name` STRING COMMENT 'Name of the high school, preparatory school, or junior college the prospect currently attends or most recently attended.',
    `high_school_state_province` STRING COMMENT 'State or province where the prospects high school or secondary institution is located.',
    `last_contact_date` DATE COMMENT 'Date of the most recent permissible contact between coaching staff and the prospect or their family.',
    `national_letter_of_intent_signed` BOOLEAN COMMENT 'Indicates whether the prospect has signed a National Letter of Intent committing to the institution.',
    `nli_signed_date` DATE COMMENT 'Date on which the prospect signed the National Letter of Intent, if applicable.',
    `notes` STRING COMMENT 'Free-text notes and observations from coaching staff regarding the prospects skills, character, fit, and recruiting interactions.',
    `official_visit_count` STRING COMMENT 'Number of official visits the prospect has taken to the institution. NCAA limits official visits per sport and division.',
    `position` STRING COMMENT 'Primary playing position or role of the prospective student-athlete within the sport (e.g., Point Guard, Setter, Midfielder).',
    `prospect_address_line1` STRING COMMENT 'Street address line 1 of the prospective student-athletes residence.',
    `prospect_city` STRING COMMENT 'City of the prospective student-athletes residence.',
    `prospect_country_code` STRING COMMENT 'Three-letter ISO country code of the prospective student-athletes residence (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `prospect_email` STRING COMMENT 'Primary email address for contacting the prospective student-athlete during the recruiting process.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `prospect_first_name` STRING COMMENT 'First or given name of the prospective student-athlete being recruited.',
    `prospect_last_name` STRING COMMENT 'Last or family name of the prospective student-athlete being recruited.',
    `prospect_middle_name` STRING COMMENT 'Middle name or initial of the prospective student-athlete, if applicable.',
    `prospect_phone` STRING COMMENT 'Primary phone number for contacting the prospective student-athlete or their guardian.',
    `prospect_postal_code` STRING COMMENT 'Postal or ZIP code of the prospective student-athletes residence.',
    `prospect_rating` STRING COMMENT 'Recruiting service rating or ranking assigned to the prospect (e.g., 5-star, 4-star, 3-star, or numerical ranking).',
    `prospect_state_province` STRING COMMENT 'State or province of the prospective student-athletes residence.',
    `rating_source` STRING COMMENT 'Name of the recruiting service or organization that provided the prospect rating (e.g., 247Sports, Rivals, ESPN).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recruit record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this recruit record was last modified.',
    `recruiting_class_year` STRING COMMENT 'Academic year in which the prospect is expected to enroll and begin competing (e.g., 2025 for Fall 2025 enrollment).',
    `recruiting_status` STRING COMMENT 'Current stage of the recruiting process for this prospect. Tracks progression from initial identification through commitment or withdrawal. [ENUM-REF-CANDIDATE: identified|contacted|evaluated|offered|committed|signed|declined|withdrawn — promote to reference product]',
    `recruiting_status_date` DATE COMMENT 'Date when the current recruiting status was assigned or last updated.',
    `recruiting_territory` STRING COMMENT 'Geographic region or territory assigned to the recruiting coach responsible for this prospect (e.g., Southeast, Midwest, California).',
    `sat_score` STRING COMMENT 'Prospects SAT composite score, used in conjunction with GPA for NCAA initial eligibility determination.',
    `scholarship_offer_date` DATE COMMENT 'Date on which an athletic scholarship offer was extended to the prospect, if applicable.',
    `scholarship_offer_extended` BOOLEAN COMMENT 'Indicates whether an athletic scholarship offer has been extended to the prospect.',
    `unofficial_visit_count` STRING COMMENT 'Number of unofficial visits the prospect has made to the institution at their own expense.',
    `weight_pounds` STRING COMMENT 'Prospects weight measured in pounds, relevant for sport-specific evaluation.',
    CONSTRAINT pk_recruit PRIMARY KEY(`recruit_id`)
) COMMENT 'Master record for a prospective student-athlete being actively recruited by the athletics department. Captures prospect identity, sport of interest, recruiting class year, recruiting status (identified/contacted/evaluated/offered/committed/signed/declined/withdrawn), position, high school or junior college, graduation year, academic eligibility pre-screening status, official visit count, unofficial visit count, recruiting territory, assigned recruiting coach, and prospect rating/ranking source.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`recruiting_contact` (
    `recruiting_contact_id` BIGINT COMMENT 'Unique identifier for each recruiting contact interaction record. Primary key for the recruiting contact transaction.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional recruiting policies may impose restrictions beyond NCAA rules (e.g., contact approval processes, prohibited activities). Real business process: compliance officers review recruiting acti',
    `employee_id` BIGINT COMMENT 'Identifier of the athletics staff member (coach, recruiting coordinator, or authorized personnel) who initiated or conducted the recruiting contact.',
    `prospect_id` BIGINT COMMENT 'Identifier of the prospective student-athlete who was contacted or evaluated during this recruiting interaction.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Recruiting contacts must comply with specific NCAA recruiting bylaws (contact periods, evaluation periods, dead periods, contact limits). Real business process: compliance officers monitor recruiting ',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: recruiting_contact is made in context of recruiting for a specific sport. Currently uses sport_code but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve full sport details. No ',
    `tertiary_recruiting_record_created_by_staff_employee_id` BIGINT COMMENT 'Identifier of the staff member who created this recruiting contact record in the system. May be the coach who made the contact or administrative staff entering data.',
    `followup_recruiting_contact_id` BIGINT COMMENT 'Self-referencing FK on recruiting_contact (followup_recruiting_contact_id)',
    `academic_year` STRING COMMENT 'The academic year during which the recruiting contact occurred (e.g., 2023-2024). Used for annual compliance reporting and recruiting cycle analysis.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator that a potential compliance issue or violation was identified with this recruiting contact. Triggers further review by compliance staff.',
    `compliance_flag_reason` STRING COMMENT 'Detailed explanation of why a compliance flag was raised, including the specific NCAA bylaw or institutional policy that may have been violated.',
    `contact_city` STRING COMMENT 'City where the in-person recruiting contact or evaluation took place. Used for travel expense tracking and compliance documentation.',
    `contact_date` DATE COMMENT 'The calendar date on which the recruiting contact or communication occurred. Critical for compliance tracking against recruiting period rules.',
    `contact_duration_minutes` STRING COMMENT 'Length of the recruiting contact in minutes. Particularly important for phone calls and in-person meetings where duration limits may apply.',
    `contact_location` STRING COMMENT 'Physical location or venue where the contact occurred (e.g., high school campus, prospects home, athletics facility, tournament site). Required for in-person contacts and evaluations.',
    `contact_medium` STRING COMMENT 'The communication channel or platform used for the contact (e.g., phone, mobile, email, in-person, social media, video conference, mail). Distinct from contact type which describes the interaction nature. [ENUM-REF-CANDIDATE: phone|mobile|email|in_person|social_media|video_conference|mail — 7 candidates stripped; promote to reference product]',
    `contact_notes` STRING COMMENT 'Detailed confidential notes about the recruiting contact, including conversation highlights, prospect questions, family concerns, and coaching staff observations.',
    `contact_state` STRING COMMENT 'State or province where the in-person recruiting contact or evaluation occurred. Part of geographic recruiting analysis and compliance tracking.',
    `contact_subject` STRING COMMENT 'Brief subject or topic of the recruiting communication (e.g., scholarship offer discussion, campus visit invitation, academic program overview, team culture introduction).',
    `contact_time` TIMESTAMP COMMENT 'Precise date and time when the recruiting contact or communication took place, used for detailed compliance audit trails.',
    `contact_type` STRING COMMENT 'Classification of the recruiting interaction method. Determines permissibility rules under NCAA bylaws (e.g., phone call, text message, email, in-person evaluation, official visit, unofficial visit, campus tour, social media message, video call). [ENUM-REF-CANDIDATE: phone_call|text_message|email|in_person_evaluation|official_visit|unofficial_visit|campus_tour|social_media_message|video_call — 9 candidates stripped; promote to reference product]',
    `evaluation_notes` STRING COMMENT 'Confidential notes recorded by the coaching staff regarding the prospects athletic performance, character, academic standing, or fit with the program. Used for internal recruiting decisions.',
    `evaluation_type` STRING COMMENT 'For evaluation contacts, specifies the type of athletic activity being observed (e.g., game, practice, workout, combine, camp, showcase). Used to track evaluation opportunities against NCAA limits.. Valid values are `game|practice|workout|combine|camp|showcase`',
    `family_members_present` STRING COMMENT 'Names or relationship descriptions of family members who participated in or were present during the recruiting contact (e.g., mother, father, guardian, sibling).',
    `high_school_coach_present` BOOLEAN COMMENT 'Indicates whether the prospects high school or club coach was present during the recruiting contact or evaluation.',
    `initiator_role` STRING COMMENT 'The official role or title of the staff member who made the contact. Important for compliance as different roles have different recruiting privileges under NCAA rules.. Valid values are `head_coach|assistant_coach|recruiting_coordinator|director_of_operations|volunteer_coach`',
    `next_contact_planned_date` DATE COMMENT 'Scheduled date for the next planned recruiting contact or follow-up with this prospect. Used for recruiting workflow management.',
    `offer_extended` BOOLEAN COMMENT 'Indicates whether a formal scholarship offer or roster spot commitment was extended to the prospect during this contact.',
    `offer_type` STRING COMMENT 'Classification of the scholarship or roster offer extended (e.g., full scholarship, partial scholarship, preferred walk-on, recruited walk-on).. Valid values are `full_scholarship|partial_scholarship|preferred_walk_on|recruited_walk_on`',
    `official_visit_flag` BOOLEAN COMMENT 'Indicates whether this contact was part of an official visit paid for by the institution. Official visits are limited in number and subject to strict NCAA regulations.',
    `permissibility_review_date` DATE COMMENT 'Date when the compliance office reviewed and determined the permissibility status of this recruiting contact.',
    `permissibility_status` STRING COMMENT 'Compliance determination indicating whether the recruiting contact was permissible under NCAA rules, impermissible (violation), under review by compliance office, or waived through exception process.. Valid values are `permissible|impermissible|under_review|waived`',
    `prospect_family_present` BOOLEAN COMMENT 'Indicates whether the prospects family members (parents, guardians, or legal representatives) were present during the recruiting contact. Important for compliance documentation.',
    `prospect_interest_level` STRING COMMENT 'Coaching staffs assessment of the prospects interest level in the program following this contact (high, medium, low, undecided, committed elsewhere). Used for recruiting pipeline management.. Valid values are `high|medium|low|undecided|committed_elsewhere`',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this recruiting contact record was first created in the athletics compliance system. Used for audit trail and data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this recruiting contact record was last modified. Tracks changes to compliance status, notes, or other fields.',
    `recruiting_class_year` STRING COMMENT 'The expected high school graduation year or recruiting class year of the prospect (e.g., 2024, 2025). Used to organize recruiting efforts by class cohort.',
    `recruiting_period_type` STRING COMMENT 'Classification of the recruiting calendar period during which the contact occurred. NCAA defines four period types: contact period (in-person and off-campus contact allowed), evaluation period (in-person evaluation only, no contact), quiet period (on-campus contact only), dead period (no in-person contact).. Valid values are `contact|evaluation|quiet|dead`',
    `scholarship_discussed` BOOLEAN COMMENT 'Indicates whether athletic scholarship opportunities or financial aid were discussed during this recruiting contact. Important for tracking offer timelines and compliance.',
    `unofficial_visit_flag` BOOLEAN COMMENT 'Indicates whether this contact occurred during an unofficial visit where the prospect visited campus at their own expense.',
    `visit_end_date` DATE COMMENT 'For official or unofficial visits, the date the campus visit concluded. Used to calculate total visit duration for compliance purposes.',
    `visit_start_date` DATE COMMENT 'For official or unofficial visits, the date the campus visit began. Used to track visit duration and compliance with 48-hour official visit limits.',
    CONSTRAINT pk_recruiting_contact PRIMARY KEY(`recruiting_contact_id`)
) COMMENT 'Transactional record of each permissible recruiting contact or communication between athletics staff and a prospective student-athlete or their family. Captures recruit reference, contact date, contact type (phone call/text/email/in-person evaluation/official visit/unofficial visit/campus tour), contact initiator, contact medium, permissibility status (permissible/impermissible), sport, recruiting period classification (quiet/contact/dead/evaluation), and any compliance flag raised.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`official_visit` (
    `official_visit_id` BIGINT COMMENT 'Unique identifier for the official visit record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recruiting visit expenses are charged to team/sport cost centers for budget tracking and variance analysis. Enables athletic directors to monitor recruiting spending by sport against budgeted amounts ',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Official visit expenses (transportation, lodging, meals, entertainment tracked in total_visit_cost) must post to recruiting expense GL accounts for financial reporting and NCAA compliance. Required fo',
    `student_athlete_id` BIGINT COMMENT 'Reference to the current student-athlete assigned to host the prospect during the visit.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional visit policies govern approval processes, expense reimbursement, and entertainment restrictions. Real business process: visit pre-approval requires verification against institutional pol',
    `employee_id` BIGINT COMMENT 'Reference to the athletics staff member coordinating this official visit.',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective student-athlete being recruited.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Official visits governed by specific NCAA regulations (48-hour rule, expense limits, entertainment restrictions). Real business process: compliance pre-approval and post-certification of visits requir',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `tertiary_official_compliance_post_certified_by_staff_employee_id` BIGINT COMMENT 'Reference to the compliance staff member who certified the visit post-completion.',
    `rescheduled_official_visit_id` BIGINT COMMENT 'Self-referencing FK on official_visit (rescheduled_official_visit_id)',
    `academic_meeting_included_flag` BOOLEAN COMMENT 'Indicates whether meetings with academic advisors or faculty were included in the official visit.',
    `academic_year` STRING COMMENT 'Academic year during which the official visit takes place (e.g., 2023-2024).',
    `accompanying_parent_guardian_count` STRING COMMENT 'Number of parents or legal guardians accompanying the prospect on the official visit (NCAA allows institution to pay for up to two).',
    `accompanying_spouse_count` STRING COMMENT 'Number of spouses accompanying the prospect on the official visit (applicable for graduate transfers or older prospects).',
    `athletic_event_attendance_flag` BOOLEAN COMMENT 'Indicates whether the prospect attended an athletic event during the official visit.',
    `athletic_facilities_tour_included_flag` BOOLEAN COMMENT 'Indicates whether a tour of athletic facilities was included in the official visit itinerary.',
    `campus_tour_included_flag` BOOLEAN COMMENT 'Indicates whether a campus tour was included in the official visit itinerary.',
    `compliance_post_certification_date` DATE COMMENT 'Date when the compliance office certified the official visit as compliant after completion.',
    `compliance_post_certification_status` STRING COMMENT 'Status of compliance office post-visit certification confirming all expenses and activities were within NCAA regulations.. Valid values are `pending|certified|non_compliant|under_review`',
    `compliance_pre_approval_date` DATE COMMENT 'Date when the compliance office approved the official visit to proceed.',
    `compliance_pre_approval_status` STRING COMMENT 'Status of compliance office pre-approval for the official visit before it occurs.. Valid values are `pending|approved|denied|conditional`',
    `compliance_violation_description` STRING COMMENT 'Detailed description of any compliance violations identified related to this official visit.',
    `compliance_violation_flag` BOOLEAN COMMENT 'Indicates whether any NCAA compliance violations were identified during or after the official visit.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all expense amounts. Typically USD for U.S. institutions.. Valid values are `USD`',
    `division_level` STRING COMMENT 'Athletic division level of the institution conducting the official visit.. Valid values are `NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA`',
    `entertainment_expense_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the institution for entertainment activities during the official visit (tickets to athletic events, campus activities, etc.).',
    `itinerary_description` STRING COMMENT 'Detailed description of the planned activities and schedule for the official visit.',
    `lodging_expense_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the institution for the prospects lodging during the official visit.',
    `meals_expense_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the institution for meals provided to the prospect during the official visit.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this official visit record was first created in the system.',
    `record_effective_date` DATE COMMENT 'Date from which this official visit record is effective for reporting and compliance purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this official visit record was last updated in the system.',
    `recruiting_period_type` STRING COMMENT 'Type of NCAA recruiting period during which the official visit occurs (contact, evaluation, quiet, or dead period).. Valid values are `contact|evaluation|quiet|dead`',
    `total_visit_cost` DECIMAL(18,2) COMMENT 'Total cost of the official visit paid by the institution, including all allowable expenses.',
    `transportation_expense_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the institution for the prospects transportation to and from campus (airfare, mileage, etc.).',
    `visit_end_date` DATE COMMENT 'Date when the official visit ends. Must be within 48 hours of start date per NCAA regulations.',
    `visit_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the official visit ends, used for 48-hour compliance tracking.',
    `visit_notes` STRING COMMENT 'Additional notes or comments about the official visit from recruiting staff or compliance office.',
    `visit_number` STRING COMMENT 'Sequential number of this official visit for the prospect (NCAA allows up to 5 official visits per prospect across all institutions).',
    `visit_start_date` DATE COMMENT 'Date when the official visit begins. NCAA official visits may not exceed 48 hours.',
    `visit_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the official visit begins, used for 48-hour compliance tracking.',
    `visit_status` STRING COMMENT 'Current status of the official visit in its lifecycle.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    CONSTRAINT pk_official_visit PRIMARY KEY(`official_visit_id`)
) COMMENT 'Transactional record of an official paid campus visit by a prospective student-athlete, funded by the institution under NCAA/NAIA regulations. Captures recruit reference, sport, visit start date, visit end date, visit number (1st through 5th for NCAA), expenses paid (transportation/lodging/meals/entertainment), total visit cost, host student-athlete assigned, compliance pre-approval status, and post-visit compliance certification.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`game` (
    `game_id` BIGINT COMMENT 'Unique identifier for the athletic contest. Primary key.',
    `athletic_facility_id` BIGINT COMMENT 'Reference to the facility record where the game is played.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who certified the game result.',
    `rescheduled_game_id` BIGINT COMMENT 'Reference to the new game record if this game was rescheduled.',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `team_id` BIGINT COMMENT 'Reference to the institutional team participating in this game.',
    `academic_year` STRING COMMENT 'Academic year in which the game occurs (e.g., 2024-2025).',
    `attendance` STRING COMMENT 'Number of spectators who attended the game.',
    `away_team_score` STRING COMMENT 'Final score for the away team. Null if game not completed.',
    `broadcast_network` STRING COMMENT 'Television or streaming network broadcasting the game (e.g., ESPN, CBS Sports, conference network).',
    `broadcast_type` STRING COMMENT 'Type of media broadcast for the game (television, streaming, radio, none).. Valid values are `television|streaming|radio|none`',
    `cancellation_reason` STRING COMMENT 'Explanation for why the game was cancelled or postponed (e.g., weather, facility issue, COVID-19).',
    `conference_game_flag` BOOLEAN COMMENT 'Indicates whether this game counts toward conference standings (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the game record was first created in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `datetime` TIMESTAMP COMMENT 'Combined scheduled date and time of the game as a timestamp in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `game_date` DATE COMMENT 'Scheduled date of the athletic contest in yyyy-MM-dd format.',
    `game_number` STRING COMMENT 'Business identifier for the game, often used in schedules and communications (e.g., G-2024-001).',
    `game_status` STRING COMMENT 'Current status of the game in its lifecycle (scheduled, in progress, completed, cancelled, postponed, forfeited).. Valid values are `scheduled|in_progress|completed|cancelled|postponed|forfeited`',
    `game_time` TIMESTAMP COMMENT 'Scheduled start time of the game (e.g., 7:00 PM, 14:30).',
    `game_type` STRING COMMENT 'Classification of the game (regular season, conference, non-conference, exhibition, scrimmage, postseason, tournament).. Valid values are `regular_season|conference|non_conference|exhibition|scrimmage|postseason`',
    `head_official_name` STRING COMMENT 'Name of the head referee or umpire for the game.',
    `home_away_neutral` STRING COMMENT 'Indicates whether the game is played at the institutional home venue, away, or at a neutral site.. Valid values are `home|away|neutral`',
    `home_team_score` STRING COMMENT 'Final score for the home team. Null if game not completed.',
    `institutional_score` STRING COMMENT 'Final score for the institutions team (home or away). Null if game not completed.',
    `notes` STRING COMMENT 'Additional notes or comments about the game (e.g., notable performances, records broken, special circumstances).',
    `officials_assigned` STRING COMMENT 'Names of referees, umpires, or officials assigned to the game (comma-separated list).',
    `opponent_institution_code` STRING COMMENT 'Standard code identifying the opposing institution (e.g., IPEDS UnitID or NCAA institution code).',
    `opponent_name` STRING COMMENT 'Name of the opposing team or institution (e.g., University of Michigan, Ohio State).',
    `opponent_score` STRING COMMENT 'Final score for the opposing team. Null if game not completed.',
    `outcome` STRING COMMENT 'Result of the game from the institutional teams perspective (win, loss, tie, no contest, forfeit win, forfeit loss).. Valid values are `win|loss|tie|no_contest|forfeit_win|forfeit_loss`',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether the game went into overtime or extra innings (True/False).',
    `overtime_periods` STRING COMMENT 'Number of overtime periods or extra innings played.',
    `result_certified_flag` BOOLEAN COMMENT 'Indicates whether the game result has been officially certified by athletics administration (True/False).',
    `result_certified_timestamp` TIMESTAMP COMMENT 'Timestamp when the game result was officially certified in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `season` STRING COMMENT 'Athletic season designation (e.g., Fall 2024, Spring 2025, 2024-2025).',
    `ticket_revenue` DECIMAL(18,2) COMMENT 'Total revenue generated from ticket sales for this game in US dollars.',
    `tournament_name` STRING COMMENT 'Name of the tournament if the game is part of a tournament (e.g., NCAA Division I Championship, Conference Tournament).',
    `tournament_round` STRING COMMENT 'Round designation within a tournament (e.g., First Round, Quarterfinals, Semifinals, Finals).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the game record was last updated in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `venue_city` STRING COMMENT 'City where the game venue is located.',
    `venue_name` STRING COMMENT 'Name of the facility where the game is played (e.g., Memorial Stadium, Alumni Arena).',
    `venue_state` STRING COMMENT 'State or province where the game venue is located (two-letter abbreviation).',
    `weather_conditions` STRING COMMENT 'Weather conditions at game time for outdoor events (e.g., sunny, rainy, temperature).',
    CONSTRAINT pk_game PRIMARY KEY(`game_id`)
) COMMENT 'Master record for each scheduled athletic contest (game, match, meet, regatta, tournament bout) for an institutional team. Captures team reference, opponent name, opponent institution code, game date, game time, venue, home/away/neutral site designation, game type (regular season/conference/non-conference/exhibition/scrimmage/postseason/tournament), game status (scheduled/completed/cancelled/postponed/forfeited), final score (home/away), outcome (win/loss/tie/no contest), attendance, broadcast information, and officials assigned.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`game_participation` (
    `game_participation_id` BIGINT COMMENT 'Unique identifier for each student-athlete participation record in a specific game or contest. Primary key for the game participation entity.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member (coach, athletic trainer, compliance officer) who recorded this participation record. Links to the staff master record.',
    `game_id` BIGINT COMMENT 'Reference to the specific game or contest in which the student-athlete participated. Links to the game master record.',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete who participated in this game. Links to the student_athlete master record.',
    `team_id` BIGINT COMMENT 'Reference to the team for which the student-athlete participated in this game. Links to the team master record.',
    `amended_game_participation_id` BIGINT COMMENT 'Self-referencing FK on game_participation (amended_game_participation_id)',
    `academic_year` STRING COMMENT 'Academic year during which the game was played (e.g., 2023-2024). Used for eligibility tracking and compliance reporting.',
    `aces` STRING COMMENT 'Total aces served by the student-athlete in this match. Applicable to volleyball and tennis.',
    `assists` STRING COMMENT 'Total assists credited to the student-athlete in this game. Applicable to basketball, soccer, hockey, lacrosse.',
    `blocks` STRING COMMENT 'Total blocks recorded by the student-athlete in this game. Applicable to volleyball and basketball.',
    `competition_level` STRING COMMENT 'Level of competition for this game. Determines whether the game counts toward NCAA eligibility and season-of-competition limits.. Valid values are `varsity|junior_varsity|club|exhibition|scrimmage`',
    `counts_toward_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this game participation counts toward the student-athletes season of competition for NCAA eligibility purposes. True if counts, False otherwise.',
    `disciplinary_action_description` STRING COMMENT 'Detailed description of any disciplinary action taken against the student-athlete during or as a result of this game.',
    `disciplinary_action_flag` BOOLEAN COMMENT 'Indicates whether any disciplinary action was taken against the student-athlete during or as a result of this game. True if action taken, False otherwise.',
    `ejection_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete was ejected from the game. True if ejected, False otherwise. Critical for NCAA compliance and disciplinary tracking.',
    `ejection_reason` STRING COMMENT 'Detailed reason for ejection if the student-athlete was ejected from the game. Includes rule violation description and referee notes.',
    `fouls_committed` STRING COMMENT 'Total fouls committed by the student-athlete in this game. Applicable to basketball, soccer, and other contact sports.',
    `goals_scored` STRING COMMENT 'Total goals scored by the student-athlete in this game. Applicable to soccer, hockey, lacrosse, water polo.',
    `hits` STRING COMMENT 'Total hits recorded by the student-athlete in this game. Applicable to baseball and softball.',
    `injury_description` STRING COMMENT 'Brief description of the injury sustained during this game. Protected health information subject to HIPAA and FERPA restrictions.',
    `injury_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete sustained an injury during this game. True if injured, False otherwise. Critical for medical tracking and eligibility.',
    `innings_played` DECIMAL(18,2) COMMENT 'Number of innings the student-athlete participated in during the game. Applicable to baseball and softball.',
    `jersey_number` STRING COMMENT 'Jersey number worn by the student-athlete during this game. May differ from roster jersey number in some sports.',
    `kills` STRING COMMENT 'Total kills recorded by the student-athlete in this match. Applicable to volleyball.',
    `medical_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether medical clearance is required before the student-athlete can participate in future games. True if clearance required, False otherwise.',
    `minutes_played` DECIMAL(18,2) COMMENT 'Total minutes the student-athlete participated in the game. Applicable to sports with timed play (basketball, soccer, hockey, lacrosse).',
    `participation_notes` STRING COMMENT 'Additional notes or comments regarding the student-athletes participation in this game. May include coaching observations, special circumstances, or compliance notes.',
    `participation_status` STRING COMMENT 'Status indicating whether and how the student-athlete participated in the game. Critical for NCAA compliance reporting and eligibility tracking.. Valid values are `played|did_not_play|injured|suspended|ineligible|excused_absence`',
    `points_scored` STRING COMMENT 'Total points scored by the student-athlete in this game. Applicable to basketball, football (via touchdowns), track and field scoring systems.',
    `position_played` STRING COMMENT 'Primary position the student-athlete played during this game. Sport-specific position codes (e.g., QB, PG, MF, P).',
    `rebounds` STRING COMMENT 'Total rebounds (offensive and defensive combined) by the student-athlete in this game. Applicable to basketball.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this game participation record was first created in the system. Critical for audit trail and compliance verification.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this game participation record was last updated in the system. Critical for audit trail and compliance verification.',
    `red_cards` STRING COMMENT 'Number of red cards received by the student-athlete in this game. Applicable to soccer and other sports using card systems.',
    `runs_batted_in` STRING COMMENT 'Total runs batted in by the student-athlete in this game. Applicable to baseball and softball.',
    `saves` STRING COMMENT 'Total saves made by the student-athlete in this game. Applicable to goalkeepers in soccer, hockey, lacrosse, water polo.',
    `season` STRING COMMENT 'Academic season during which the game was played. Critical for NCAA eligibility clock and season-of-competition tracking.. Valid values are `fall|winter|spring|summer`',
    `sets_played` STRING COMMENT 'Number of sets the student-athlete participated in during the match. Applicable to volleyball and tennis.',
    `starter_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete was in the starting lineup for this game. True if starter, False if substitute or did not play.',
    `strikeouts` STRING COMMENT 'Total strikeouts recorded by the student-athlete in this game. For pitchers in baseball and softball, or batters who struck out.',
    `touchdowns` STRING COMMENT 'Total touchdowns scored by the student-athlete in this game. Applicable to football.',
    `yards_gained` STRING COMMENT 'Total yards gained by the student-athlete in this game. Applicable to football (rushing, passing, receiving yards).',
    `yellow_cards` STRING COMMENT 'Number of yellow cards received by the student-athlete in this game. Applicable to soccer and other sports using card systems.',
    CONSTRAINT pk_game_participation PRIMARY KEY(`game_participation_id`)
) COMMENT 'Transactional record capturing each student-athletes participation in a specific game or contest. Captures student-athlete reference, game reference, participation status (played/did not play/injured/suspended/ineligible), starter flag, minutes played or sets played, position played, individual statistics summary (sport-specific: points, rebounds, assists, yards, goals, times, etc.), and any disciplinary action during the contest.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`practice_session` (
    `practice_session_id` BIGINT COMMENT 'Unique identifier for the practice session record. Primary key.',
    `athletic_facility_id` BIGINT COMMENT 'Foreign key linking to athletics.athletic_facility. Business justification: practice_session has facility_id but this appears to point to a generic facility table. Since practice sessions are athletics-specific and athletic_facility exists as the domain-specific facility mast',
    `employee_id` BIGINT COMMENT 'Reference to the compliance staff member who certified this practice session record.',
    `facility_id` BIGINT COMMENT 'Reference to the athletic facility where the practice session was conducted.',
    `coach_id` BIGINT COMMENT 'Reference to the head coach responsible for supervising this practice session.',
    `team_id` BIGINT COMMENT 'Reference to the team conducting this practice session.',
    `makeup_practice_session_id` BIGINT COMMENT 'Self-referencing FK on practice_session (makeup_practice_session_id)',
    `academic_year` STRING COMMENT 'The academic year during which the practice session occurred, formatted as YYYY-YYYY (e.g., 2023-2024).',
    `attendance_count` STRING COMMENT 'Number of student-athletes who attended this practice session.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the practice session was cancelled or postponed, if applicable.',
    `cara_countable_flag` BOOLEAN COMMENT 'Indicates whether this practice session counts toward the weekly and seasonal NCAA CARA hour limits (20 hours per week, 8 hours per week out-of-season).',
    `competition_preparation_flag` BOOLEAN COMMENT 'Indicates whether this practice session was specifically focused on preparing for an upcoming competition or game.',
    `compliance_certification_timestamp` TIMESTAMP COMMENT 'Timestamp when the practice session was certified as compliant by athletics compliance staff.',
    `compliance_certified_flag` BOOLEAN COMMENT 'Indicates whether this practice session has been reviewed and certified as compliant with NCAA CARA hour regulations.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether this practice session requires additional compliance review due to unusual circumstances or potential rule violations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice session record was first created in the system.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the practice session in hours, calculated from start and end times. Used for NCAA CARA hour tracking.',
    `heat_index` STRING COMMENT 'Calculated heat index during the practice session, combining temperature and humidity for heat illness risk assessment.',
    `injury_count` STRING COMMENT 'Number of injuries that occurred during this practice session.',
    `injury_occurred_flag` BOOLEAN COMMENT 'Indicates whether any student-athlete injury occurred during this practice session.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this practice session record was most recently modified.',
    `mandatory_attendance_flag` BOOLEAN COMMENT 'Indicates whether attendance at this practice session was mandatory for all eligible team members.',
    `medical_staff_present_flag` BOOLEAN COMMENT 'Indicates whether athletic training or medical staff were present during the practice session for injury prevention and response.',
    `opponent_scouting_flag` BOOLEAN COMMENT 'Indicates whether this practice session included film review or scouting of an upcoming opponent.',
    `practice_date` DATE COMMENT 'The calendar date on which the practice session occurred. Principal business event timestamp for this transaction.',
    `practice_end_time` TIMESTAMP COMMENT 'The timestamp when the practice session concluded, used for precise CARA hour calculation.',
    `practice_focus` STRING COMMENT 'Primary focus or objective of the practice session (e.g., offensive drills, defensive strategy, conditioning, scrimmage).',
    `practice_intensity_level` STRING COMMENT 'Subjective assessment of the overall intensity level of the practice session.. Valid values are `light|moderate|high|maximum`',
    `practice_notes` STRING COMMENT 'Free-text notes about the practice session, including coaching observations, special circumstances, or compliance annotations.',
    `practice_session_number` STRING COMMENT 'Business identifier for the practice session, typically formatted as season-team-sequence (e.g., 2024-FB-001).',
    `practice_start_time` TIMESTAMP COMMENT 'The timestamp when the practice session began, used for precise CARA hour calculation.',
    `practice_status` STRING COMMENT 'Current lifecycle status of the practice session.. Valid values are `scheduled|completed|cancelled|postponed|in_progress`',
    `practice_type` STRING COMMENT 'Classification of the practice activity type. Determines whether the session counts toward NCAA CARA hour limits.. Valid values are `team_practice|individual_workout|film_session|walk_through|conditioning|weight_training`',
    `record_effective_date` DATE COMMENT 'The date from which this practice session record is considered effective for reporting and compliance purposes.',
    `scrimmage_flag` BOOLEAN COMMENT 'Indicates whether this practice session included a scrimmage or simulated game situation.',
    `season_designation` STRING COMMENT 'Designation of the competitive season phase during which the practice occurred. Affects CARA hour limits and compliance rules.. Valid values are `in_season|out_of_season|preseason|postseason|off_season`',
    `temperature_fahrenheit` STRING COMMENT 'Ambient temperature in degrees Fahrenheit during the practice session, used for heat safety monitoring.',
    `term_code` STRING COMMENT 'The academic term code during which the practice session occurred (e.g., 202401 for Spring 2024).',
    `video_recorded_flag` BOOLEAN COMMENT 'Indicates whether video footage of the practice session was recorded for coaching review and player development.',
    `weather_condition` STRING COMMENT 'Description of weather conditions during outdoor practice sessions, relevant for safety and performance tracking.',
    `weekly_cara_hours_accumulated` DECIMAL(18,2) COMMENT 'Running total of CARA hours accumulated for the team during the calendar week containing this practice session. Used to monitor compliance with the 20-hour weekly limit.',
    CONSTRAINT pk_practice_session PRIMARY KEY(`practice_session_id`)
) COMMENT 'Transactional record of a scheduled team practice session, used for NCAA countable athletically related activity (CARA) hour tracking. Captures team reference, practice date, start time, end time, duration in hours, practice type (team practice/individual workout/film session/walk-through/conditioning/weight training/competition preparation), CARA countable flag, weekly CARA hour accumulation, in-season vs out-of-season designation, and coach supervisor.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`athletic_facility` (
    `athletic_facility_id` BIGINT COMMENT 'Unique identifier for the athletic facility record. Primary key.',
    `building_id` BIGINT COMMENT 'Reference to the parent facility record in the institutional facilities domain. Links athletics-specific facility attributes to the enterprise facility master.',
    `clery_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.clery_incident. Business justification: Clery incidents occurring at athletic facilities must be tracked by location for geography classification and annual security report. Real business process: campus safety logs incidents by facility, a',
    `employee_id` BIGINT COMMENT 'Reference to the staff member responsible for day-to-day management and operations of this athletic facility.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Athletic facilities have dedicated operating and capital budgets for maintenance, utilities, renovations, and staffing. Budget tracking enables facility managers to monitor spending, plan capital proj',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Athletic facilities have operating budgets for maintenance, utilities, staffing, and capital improvements tracked by cost center. Required for facility financial management, budget planning, and cost ',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `parent_athletic_facility_id` BIGINT COMMENT 'Self-referencing FK on athletic_facility (parent_athletic_facility_id)',
    `ada_accessible_seating_count` STRING COMMENT 'Number of wheelchair-accessible seating positions available in the facility, as required by ADA compliance standards.',
    `building_square_footage` STRING COMMENT 'Total enclosed building square footage of the facility. Used for maintenance planning, utility allocation, and space utilization reporting.',
    `climate_controlled_flag` BOOLEAN COMMENT 'Indicates whether the facility has heating, ventilation, and air conditioning (HVAC) systems for climate control. True if climate controlled, False otherwise.',
    `concession_stands_count` STRING COMMENT 'Number of concession stands or food service points available in the facility for spectators.',
    `conference_affiliation` STRING COMMENT 'Name of the athletic conference whose standards this facility must meet (e.g., Big Ten, SEC, ACC). Used for conference-specific facility requirements.',
    `division_level` STRING COMMENT 'Athletic division level that this facility primarily serves (e.g., NCAA Division I, Division II, Division III, NAIA, NJCAA, club sports, intramural). [ENUM-REF-CANDIDATE: division_i|division_ii|division_iii|naia|njcaa|club|intramural — 7 candidates stripped; promote to reference product]',
    `facility_code` STRING COMMENT 'Short alphanumeric code used to identify the athletic facility in scheduling systems, event management, and reporting. Typically 3-10 characters.. Valid values are `^[A-Z0-9]{3,10}$`',
    `facility_name` STRING COMMENT 'Official name of the athletic facility (e.g., Memorial Stadium, Johnson Arena, Smith Aquatic Center).',
    `facility_status` STRING COMMENT 'Current operational status of the athletic facility (active, inactive, under construction, under renovation, decommissioned).. Valid values are `active|inactive|under_construction|under_renovation|decommissioned`',
    `facility_type` STRING COMMENT 'Classification of the athletic facility by its primary function and structure (e.g., stadium, arena, field, court, track, pool, weight room, training room, practice facility, locker room). [ENUM-REF-CANDIDATE: stadium|arena|field|court|track|pool|weight_room|training_room|practice_facility|locker_room — 10 candidates stripped; promote to reference product]',
    `home_venue_flag` BOOLEAN COMMENT 'Indicates whether this facility serves as the official home venue for one or more varsity teams. True if home venue, False otherwise.',
    `last_renovation_year` STRING COMMENT 'Year of the most recent major renovation or upgrade to the facility. Null if no major renovations have occurred since construction.',
    `lighting_lux_level` STRING COMMENT 'Measured illumination level in lux at playing surface level. Required for NCAA competition certification and broadcast standards.',
    `lighting_type` STRING COMMENT 'Type of lighting system installed in the facility (e.g., LED, metal halide, halogen, natural, none). Critical for scheduling evening events and broadcast compliance.. Valid values are `led|metal_halide|halogen|natural|none`',
    `locker_room_count` STRING COMMENT 'Number of team locker rooms available in the facility. Includes home, visitor, and official locker rooms.',
    `naia_certification_status` STRING COMMENT 'Current NAIA facility certification status indicating compliance with NAIA competition and safety standards. Applicable only for NAIA member institutions.. Valid values are `certified|provisional|not_certified|not_applicable`',
    `ncaa_certification_date` DATE COMMENT 'Date when the facility received its most recent NCAA certification. Null if not certified or not applicable.',
    `ncaa_certification_expiration_date` DATE COMMENT 'Date when the current NCAA facility certification expires and recertification is required. Null if not certified or not applicable.',
    `ncaa_certification_status` STRING COMMENT 'Current NCAA facility certification status indicating compliance with NCAA competition and safety standards (certified, provisional, not certified, not applicable for non-NCAA sports).. Valid values are `certified|provisional|not_certified|not_applicable`',
    `outdoor_flag` BOOLEAN COMMENT 'Indicates whether the facility is primarily an outdoor venue. True for outdoor facilities, False for indoor or enclosed facilities.',
    `parking_spaces_count` STRING COMMENT 'Number of parking spaces allocated to or adjacent to the athletic facility. Includes general, reserved, and ADA-accessible spaces.',
    `playing_surface_type` STRING COMMENT 'Type of playing surface installed in the facility (e.g., natural grass, artificial turf, hardwood, synthetic floor, clay, concrete, rubberized track, water, ice, sand). [ENUM-REF-CANDIDATE: natural_grass|artificial_turf|hardwood|synthetic_floor|clay|concrete|rubberized_track|water|ice|sand — 10 candidates stripped; promote to reference product]',
    `press_box_capacity` STRING COMMENT 'Number of media personnel that can be accommodated in the press box or media area. Null if no dedicated press area exists.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this athletic facility record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this athletic facility record was last modified in the system.',
    `restroom_count` STRING COMMENT 'Total number of public restroom facilities available in the venue. Used for capacity planning and ADA compliance verification.',
    `scheduling_priority` STRING COMMENT 'Numeric priority ranking used in facility scheduling systems to resolve conflicts. Lower numbers indicate higher priority (e.g., 1 = varsity competition, 2 = varsity practice, 3 = club sports, 4 = intramural).',
    `scoreboard_type` STRING COMMENT 'Type of scoreboard system installed in the facility (e.g., LED video, LED matrix, digital, manual, none).. Valid values are `led_video|led_matrix|digital|manual|none`',
    `seating_capacity` STRING COMMENT 'Maximum number of spectators that can be seated in the facility for events. Null for facilities without spectator seating (e.g., practice fields, weight rooms).',
    `secondary_sports_served` STRING COMMENT 'Comma-separated list of additional sports that utilize this facility for practice, competition, or training (e.g., Track and Field, Soccer, Lacrosse).',
    `standing_capacity` STRING COMMENT 'Maximum number of standing spectators allowed in designated standing areas. Null if no standing areas exist.',
    `surface_dimensions_length_ft` DECIMAL(18,2) COMMENT 'Length of the playing surface in feet. Used to verify compliance with sport-specific field/court dimension requirements.',
    `surface_dimensions_width_ft` DECIMAL(18,2) COMMENT 'Width of the playing surface in feet. Used to verify compliance with sport-specific field/court dimension requirements.',
    `training_room_available_flag` BOOLEAN COMMENT 'Indicates whether the facility includes an on-site athletic training room for injury treatment and rehabilitation. True if available, False otherwise.',
    `video_replay_system_flag` BOOLEAN COMMENT 'Indicates whether the facility is equipped with an instant replay system for officiating and fan engagement. True if equipped, False otherwise.',
    `weight_room_available_flag` BOOLEAN COMMENT 'Indicates whether the facility includes an on-site strength and conditioning weight room. True if available, False otherwise.',
    `year_built` STRING COMMENT 'Year the facility was originally constructed. Used for capital planning, depreciation, and renovation scheduling.',
    CONSTRAINT pk_athletic_facility PRIMARY KEY(`athletic_facility_id`)
) COMMENT 'Master record for athletics-specific facilities including stadiums, arenas, practice fields, weight rooms, aquatic centers, and training rooms. Extends the facility domain with athletics-specific attributes. Captures facility name, facility type, sport(s) served, seating capacity, playing surface type, lighting type, scoreboard type, locker room count, training room availability, NCAA/NAIA facility compliance certification status, home venue designation for teams, and scheduling priority.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`facility_event_booking` (
    `facility_event_booking_id` BIGINT COMMENT 'Unique identifier for the facility event booking record. Primary key for this transactional entity.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: External facility rentals (external_rental_flag=true, rental_revenue_amount tracked) generate accounts receivable invoices for revenue recognition and collection tracking. Required for revenue account',
    `athletic_facility_id` BIGINT COMMENT 'Foreign key linking to athletics.athletic_facility. Business justification: facility_event_booking has facility_id but this appears to point to a generic facility table. Since this is athletics domain and athletic_facility exists as the domain-specific facility master, adding',
    `facility_id` BIGINT COMMENT 'Reference to the athletic facility being booked (e.g., stadium, arena, practice field, gymnasium, natatorium).',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who approved this facility booking. Null if approval not yet granted or not required.',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `team_id` BIGINT COMMENT 'Reference to the athletic team requesting or using the facility. Null for non-team events.',
    `rescheduled_facility_event_booking_id` BIGINT COMMENT 'Self-referencing FK on facility_event_booking (rescheduled_facility_event_booking_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this booking requires administrative or athletic director approval before confirmation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this facility booking was approved. Null if not yet approved or approval not required.',
    `booking_number` STRING COMMENT 'Externally-visible unique booking reference number assigned to this facility reservation. Format: BK-YYYYMMDD.. Valid values are `^BK-[0-9]{8}$`',
    `booking_status` STRING COMMENT 'Current lifecycle status of the facility booking. Tracks progression from initial request through completion or cancellation.. Valid values are `requested|confirmed|in_progress|completed|cancelled|no_show`',
    `broadcast_flag` BOOLEAN COMMENT 'Indicates whether this event will be broadcast or live-streamed (television, radio, or digital platforms).',
    `cancellation_reason` STRING COMMENT 'Explanation for why this facility booking was cancelled. Null for non-cancelled bookings.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when this facility booking was cancelled. Null for non-cancelled bookings.',
    `catering_required_flag` BOOLEAN COMMENT 'Indicates whether catering or food service is required for this event.',
    `conference_game_flag` BOOLEAN COMMENT 'Indicates whether this event is a conference competition. True for conference games, false otherwise.',
    `conflict_check_status` STRING COMMENT 'Status of scheduling conflict verification against other facility bookings and institutional calendar events.. Valid values are `not_checked|no_conflict|conflict_detected|conflict_resolved`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this facility booking record was first created in the system. Audit trail for record creation.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Security deposit or advance payment collected for this facility booking. Expressed in US dollars (USD).',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the facility booking in hours, calculated from start to end time.',
    `end_time` TIMESTAMP COMMENT 'Scheduled end date and time for the facility use, including teardown time if applicable.',
    `equipment_needs` STRING COMMENT 'List of athletic or event equipment required for this booking (e.g., goals, nets, scoreboards, timing systems, audio-visual equipment).',
    `event_date` DATE COMMENT 'The calendar date on which the scheduled event or facility use occurs. Principal business event timestamp for this booking.',
    `event_type` STRING COMMENT 'Classification of the scheduled facility use. Distinguishes between athletic competitions, training activities, special events, and external rentals. [ENUM-REF-CANDIDATE: game|practice|scrimmage|tournament|camp|clinic|community_event|external_rental|commencement|concert|meeting — 11 candidates stripped; promote to reference product]',
    `expected_attendance` STRING COMMENT 'Anticipated number of attendees for this event. Used for capacity planning and staffing decisions.',
    `external_rental_flag` BOOLEAN COMMENT 'Indicates whether this booking is an external rental by a non-university organization generating revenue.',
    `home_away_indicator` STRING COMMENT 'Indicates whether this is a home game, away game, or neutral site event. Applicable to competitive athletic events only.. Valid values are `home|away|neutral`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this facility booking record was most recently modified. Audit trail for record changes.',
    `opponent_name` STRING COMMENT 'Name of the opposing team or institution for competitive events. Null for practices, rentals, and non-competitive events.',
    `parking_allocation_count` STRING COMMENT 'Number of parking spaces allocated or reserved for this event.',
    `postseason_flag` BOOLEAN COMMENT 'Indicates whether this event is part of postseason competition (playoffs, championships, tournaments).',
    `rental_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue generated from external facility rental. Null for internal university use. Expressed in US dollars (USD).',
    `requesting_contact_email` STRING COMMENT 'Email address of the primary contact person for this facility booking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requesting_contact_name` STRING COMMENT 'Full name of the primary contact person responsible for this booking request.',
    `requesting_contact_phone` STRING COMMENT 'Phone number of the primary contact person for this facility booking.',
    `requesting_organization_name` STRING COMMENT 'Name of the organization, department, or external entity requesting the facility booking. Used for non-team bookings such as external rentals or university events.',
    `security_required_flag` BOOLEAN COMMENT 'Indicates whether additional security personnel or campus police presence is required for this event.',
    `setup_requirements` STRING COMMENT 'Detailed description of facility setup needs including seating configuration, staging, lighting, sound system, and other special arrangements.',
    `special_instructions` STRING COMMENT 'Additional notes, requirements, or special considerations for this facility booking.',
    `start_time` TIMESTAMP COMMENT 'Scheduled start date and time for the facility use, including setup time if applicable.',
    `ticketed_event_flag` BOOLEAN COMMENT 'Indicates whether this event requires ticketing and admission control.',
    CONSTRAINT pk_facility_event_booking PRIMARY KEY(`facility_event_booking_id`)
) COMMENT 'Transactional record of a scheduled use of an athletic facility for a game, practice, special event, or external rental. Captures facility reference, booking date, start time, end time, event type (game/practice/tournament/community event/rental/commencement/concert), requesting team or organization, setup requirements, equipment needs, event status (requested/confirmed/cancelled), revenue generated for external rentals, and conflict check status.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`coach` (
    `coach_id` BIGINT COMMENT 'Unique identifier for the coaching staff member. Primary key for the coach entity.',
    `employee_id` BIGINT COMMENT 'Human-readable employee identifier assigned by the human resources system. Used for payroll, benefits, and institutional reporting.',
    `patron_id` BIGINT COMMENT 'Foreign key linking to library.patron. Business justification: Coaches use library services for professional development, recruiting research, and academic support activities. Tracking coach library usage enables targeted outreach, collection development for coac',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Links coaches with faculty appointments who conduct research (common in kinesiology, sports medicine, exercise science). Required for effort reporting, conflict of interest management, institutional r',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Coach salaries and benefits are charged to specific athletic department cost centers for budget tracking and financial reporting. Essential for payroll accounting, budget management, and EADA reportin',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `staff_employee_id` BIGINT COMMENT 'Reference to the staff member record in the human resources system. Links coaching staff to their broader institutional employment record.',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to compliance.training_program. Business justification: Coaches required to complete annual compliance training (NCAA rules, SafeSport, Title IX, recruiting regulations). Real business process: compliance office assigns required training programs to coache',
    `supervising_coach_id` BIGINT COMMENT 'Self-referencing FK on coach (supervising_coach_id)',
    `alma_mater` STRING COMMENT 'Name of the institution from which the coaching staff member earned their undergraduate degree. Used for media guides and biographical materials.',
    `background_check_date` DATE COMMENT 'Date the most recent background check was completed. Background checks must be renewed periodically per institutional policy.',
    `background_check_status` STRING COMMENT 'Status of required background check screening. All coaching staff with student-athlete contact must maintain current background clearance per institutional policy and NCAA SafeSport requirements.. Valid values are `cleared|pending|flagged|expired`',
    `bio_url` STRING COMMENT 'Web address of the coaching staff members official biography page on the athletics department website. Used for public information and media relations.',
    `cara_supervision_authorized` BOOLEAN COMMENT 'Indicates whether the coach is authorized to supervise countable athletically related activities under NCAA time management rules. Only certain staff roles are permitted to supervise CARA.',
    `coaching_role` STRING COMMENT 'Functional coaching role classification. Determines NCAA/NAIA countable coach status, recruiting authorization, and compensation structure. [ENUM-REF-CANDIDATE: head_coach|assistant_coach|associate_head_coach|graduate_assistant|volunteer_coach|strength_coach|athletic_trainer|director_of_operations — 8 candidates stripped; promote to reference product]',
    `coaching_specialization` STRING COMMENT 'Specific area of coaching expertise or position group responsibility. Examples include offensive coordinator, defensive backs coach, pitching coach, recruiting coordinator.',
    `compliance_training_completion_date` DATE COMMENT 'Date the coaching staff member completed the most recent NCAA compliance training. Training must be completed annually before the start of the recruiting period.',
    `compliance_training_status` STRING COMMENT 'Status of mandatory NCAA compliance training completion. All coaching staff must complete annual compliance training covering recruiting rules, eligibility, and amateurism.. Valid values are `completed|pending|expired`',
    `contract_end_date` DATE COMMENT 'Expiration date of the current coaching contract or employment agreement. Null for open-ended or at-will employment arrangements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current coaching contract or employment agreement. Used for tenure calculations and contract renewal tracking.',
    `countable_coach_flag` BOOLEAN COMMENT 'Indicates whether this coaching staff member counts against the NCAA limit for countable coaches in their sport. Countable coaches have specific recruiting and on-field coaching privileges.',
    `email_address` STRING COMMENT 'Primary institutional email address for the coaching staff member. Used for official communications, recruiting correspondence, and compliance notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_status` STRING COMMENT 'Current employment lifecycle status. Tracks whether the coach is actively employed, on leave, or separated from the institution.. Valid values are `active|on_leave|suspended|terminated|retired`',
    `employment_type` STRING COMMENT 'Classification of employment status. Determines compensation eligibility, benefits, and NCAA countable coach status.. Valid values are `full_time|part_time|volunteer|graduate_assistant|seasonal`',
    `first_name` STRING COMMENT 'Legal first name of the coaching staff member as recorded in human resources records.',
    `graduation_year` STRING COMMENT 'Year the coaching staff member graduated from their alma mater. Used for media guides and biographical materials.',
    `hire_date` DATE COMMENT 'Original date the coaching staff member was first hired by the athletics department, regardless of role changes or contract renewals.',
    `job_title` STRING COMMENT 'Official job title as recorded in human resources system. Examples include Head Coach, Assistant Coach, Associate Head Coach, Director of Operations.',
    `last_name` STRING COMMENT 'Legal last name of the coaching staff member as recorded in human resources records.',
    `middle_name` STRING COMMENT 'Legal middle name or initial of the coaching staff member.',
    `ncaa_certification_date` DATE COMMENT 'Date the coaching staff member completed NCAA coaching certification requirements. Required for countable coaches engaging in recruiting activities.',
    `ncaa_certification_expiration_date` DATE COMMENT 'Expiration date of NCAA coaching certification. Coaches must recertify before this date to maintain recruiting authorization.',
    `ncaa_certification_status` STRING COMMENT 'Status of NCAA coaching certification requirements. Certified coaches are authorized to engage in recruiting and on-field coaching activities per NCAA bylaws.. Valid values are `certified|pending|expired|not_required`',
    `notes` STRING COMMENT 'Free-text field for additional information about the coaching staff member, including special achievements, awards, or administrative notes.',
    `office_location` STRING COMMENT 'Physical office location or building assignment for the coaching staff member within the athletics facilities.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the coaching staff member. Used for recruiting, team communications, and emergency contact.',
    `photo_url` STRING COMMENT 'Web address of the coaching staff members official headshot or action photo. Used for media guides, website, and promotional materials.',
    `preferred_name` STRING COMMENT 'Name the coaching staff member prefers to be called in professional settings, used for rosters, media guides, and public communications.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coach record was first created in the athletics system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this coach record was most recently modified. Used for audit trail and change tracking.',
    `recruiting_authorization_level` STRING COMMENT 'Level of recruiting activity authorization. Full authorization allows on-campus and off-campus recruiting; limited restricts to on-campus only; none prohibits recruiting contact.. Valid values are `full|limited|none`',
    `safesport_training_completion_date` DATE COMMENT 'Date the coaching staff member completed the most recent SafeSport training module. Training must be renewed annually.',
    `safesport_training_status` STRING COMMENT 'Status of NCAA SafeSport training completion. All coaching staff with student-athlete contact must complete SafeSport training annually.. Valid values are `completed|pending|expired|not_required`',
    `secondary_sport_code` STRING COMMENT 'Standardized code for a secondary sport assignment, applicable when a coach serves multiple programs (common in smaller institutions or multi-season sports).',
    `termination_date` DATE COMMENT 'Date the coaching staff member separated from employment. Null for active employees.',
    `years_of_experience` STRING COMMENT 'Total years of coaching experience across all institutions and levels. Used for media guides, recruiting materials, and compensation benchmarking.',
    CONSTRAINT pk_coach PRIMARY KEY(`coach_id`)
) COMMENT 'Master record for all coaching and athletics support staff employed by the athletics department. Captures staff identity, title, coaching role (head coach/assistant coach/graduate assistant/volunteer coach/strength coach/athletic trainer), sport assignment, employment type (full-time/part-time/volunteer), contract start and end dates, NCAA/NAIA coaching certification status, recruiting authorization level, CARA supervision authorization, background check status, and mandatory compliance training completion status.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`athletic_award` (
    `athletic_award_id` BIGINT COMMENT 'Unique identifier for the athletic award record. Primary key for the athletic award entity.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member (coach, athletic director, faculty athletics representative) who nominated the student-athlete or team for the award. Null if nomination was external or not applicable.',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: athletic_award is given for achievement in a specific sport. Currently uses sport_code/sport_name but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve sport_name and other spor',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete who received the award. Null if the award is conferred upon a team rather than an individual.',
    `team_id` BIGINT COMMENT 'Reference to the team that received the award. Null if the award is conferred upon an individual rather than a team.',
    `tertiary_athletic_last_updated_by_staff_employee_id` BIGINT COMMENT 'Reference to the staff member who most recently updated the award record.',
    `superseded_athletic_award_id` BIGINT COMMENT 'Self-referencing FK on athletic_award (superseded_athletic_award_id)',
    `academic_year` STRING COMMENT 'Academic year during which the award was earned, typically formatted as YYYY-YYYY (e.g., 2023-2024).',
    `award_certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a physical or digital certificate has been issued to the recipient. True if issued, False otherwise.',
    `award_date` DATE COMMENT 'Date on which the award was officially conferred or announced. Format: yyyy-MM-dd.',
    `award_description` STRING COMMENT 'Detailed narrative description of the award, including criteria, significance, and any special circumstances or achievements that led to the recognition.',
    `award_level` STRING COMMENT 'Geographic or organizational scope of the award. Values include institutional (university-level), conference (athletic conference), regional (multi-state or regional association), national (country-wide), and international (global competition).. Valid values are `institutional|conference|regional|national|international`',
    `award_name` STRING COMMENT 'Full official name of the award, honor, or recognition conferred (e.g., All-Conference First Team, Academic All-American, Player of the Week, Most Valuable Player, Sportsmanship Award, Conference Championship Trophy).',
    `award_notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the award, including special circumstances, historical significance, or administrative remarks.',
    `award_status` STRING COMMENT 'Current status of the award. Values include pending (nomination or selection in progress), awarded (officially conferred), revoked (rescinded due to violation or ineligibility), and declined (recipient chose not to accept).. Valid values are `pending|awarded|revoked|declined`',
    `award_trophy_issued_flag` BOOLEAN COMMENT 'Indicates whether a physical trophy or plaque has been issued to the recipient. True if issued, False otherwise.',
    `award_type` STRING COMMENT 'Categorical classification of the award type. Standardized values include All-Conference, All-American, Academic All-American, Player of the Week, Player of the Month, Most Valuable Player (MVP), Rookie of the Year, Sportsmanship Award, and Championship Trophy. [ENUM-REF-CANDIDATE: all-conference|all-american|academic all-american|player of the week|player of the month|mvp|rookie of the year|sportsmanship|championship trophy — 9 candidates stripped; promote to reference product]',
    `awarding_body` STRING COMMENT 'Name of the organization, conference, or institution that conferred the award (e.g., Big Ten Conference, NCAA, College Sports Information Directors of America, institutional athletics department).',
    `benefit_description` STRING COMMENT 'Description of any non-monetary benefits associated with the award, such as equipment, travel, training opportunities, or recognition events.',
    `compliance_report_date` DATE COMMENT 'Date on which the award was reported to the governing body for compliance tracking. Null if not yet reported or not reportable. Format: yyyy-MM-dd.',
    `compliance_reportable_flag` BOOLEAN COMMENT 'Indicates whether the award must be reported to NCAA, NAIA, or other governing bodies for compliance purposes. True if reportable, False otherwise.',
    `conference_affiliation` STRING COMMENT 'Name of the athletic conference to which the team or student-athlete belonged at the time the award was earned (e.g., Big Ten Conference, Atlantic Coast Conference, Southeastern Conference).',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the award record. True for the current record, False for historical versions. Supports slowly changing dimension (SCD) Type 2 tracking.',
    `division_level` STRING COMMENT 'Athletic division or competitive level at which the award was earned. Values include NCAA Division I, NCAA Division II, NCAA Division III, NAIA (National Association of Intercollegiate Athletics), NJCAA (National Junior College Athletic Association), club, and intramural. [ENUM-REF-CANDIDATE: NCAA Division I|NCAA Division II|NCAA Division III|NAIA|NJCAA|club|intramural — 7 candidates stripped; promote to reference product]',
    `nomination_date` DATE COMMENT 'Date on which the student-athlete or team was nominated for the award. Null if nomination process does not apply. Format: yyyy-MM-dd.',
    `public_announcement_date` DATE COMMENT 'Date on which the award was publicly announced. Null if not yet announced or if public announcement does not apply. Format: yyyy-MM-dd.',
    `public_announcement_flag` BOOLEAN COMMENT 'Indicates whether the award has been publicly announced through press releases, social media, or institutional communications. True if announced, False otherwise.',
    `recipient_type` STRING COMMENT 'Indicates whether the award was conferred upon an individual student-athlete or a team. Values are individual or team.. Valid values are `individual|team`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the award record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_effective_date` DATE COMMENT 'Date from which this version of the award record is considered effective for reporting and analytics purposes. Supports slowly changing dimension (SCD) Type 2 tracking. Format: yyyy-MM-dd.',
    `record_expiration_date` DATE COMMENT 'Date on which this version of the award record is superseded by a newer version. Null for the current active record. Supports slowly changing dimension (SCD) Type 2 tracking. Format: yyyy-MM-dd.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the award record was most recently updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `scholarship_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the scholarship value (e.g., USD, CAD, EUR). Null if no financial benefit is associated with the award.. Valid values are `^[A-Z]{3}$`',
    `scholarship_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of any scholarship or financial benefit associated with the award, expressed in US dollars. Null if the award carries no financial benefit.',
    `season` STRING COMMENT 'Athletic season during which the award was earned. Values include fall, winter, spring, and summer.. Valid values are `fall|winter|spring|summer`',
    `selection_criteria` STRING COMMENT 'Description of the criteria used to select the award recipient, such as athletic performance, academic achievement, leadership, sportsmanship, or community service.',
    CONSTRAINT pk_athletic_award PRIMARY KEY(`athletic_award_id`)
) COMMENT 'Transactional record of an award, honor, or recognition conferred upon a student-athlete or team. Captures award type (All-Conference/All-American/Academic All-American/Player of the Week/MVP/Sportsmanship Award/Championship Trophy), award level (conference/regional/national/institutional), recipient type (individual/team), sport, academic year, awarding body, award date, and any associated scholarship or benefit value for compliance tracking.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`compliance_waiver` (
    `compliance_waiver_id` BIGINT COMMENT 'Unique identifier for the compliance waiver request. Primary key for the compliance waiver record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Athletic compliance waivers (eligibility waivers, medical hardship waivers) relate to specific institutional compliance obligations (NCAA rules, conference rules). This FK links athletics.compliance_w',
    `employee_id` BIGINT COMMENT 'Reference to the institutional compliance officer or staff member responsible for preparing and submitting the waiver request.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Waivers are requests for exceptions to specific regulatory requirements. Real business process: waiver submissions must identify the specific regulatory requirement (NCAA bylaw, conference rule) for w',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: compliance_waiver is submitted for a specific sport. Currently uses sport_code/sport_name but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve sport_name and other sport attrib',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete on whose behalf the waiver is submitted. Nullable for institution-level waivers not tied to a specific individual.',
    `appealed_compliance_waiver_id` BIGINT COMMENT 'Self-referencing FK on compliance_waiver (appealed_compliance_waiver_id)',
    `academic_year` STRING COMMENT 'Academic year during which the waiver applies, typically formatted as YYYY-YYYY (e.g., 2023-2024).',
    `appeal_decision_date` DATE COMMENT 'Date on which a decision was issued on the appeal. Null if appeal is still pending or no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an appeal has been filed following a denial decision (true) or not (false).',
    `appeal_outcome` STRING COMMENT 'Outcome of the appeal: upheld (original denial stands), overturned (waiver granted on appeal), remanded (sent back for further review). Null if no appeal or appeal pending.. Valid values are `upheld|overturned|remanded`',
    `appeal_submission_date` DATE COMMENT 'Date on which an appeal was submitted following a waiver denial. Null if no appeal has been filed.',
    `athletic_director_approval_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the athletic director approved the waiver submission (true) or not (false). Typically required for institutional waiver submissions.',
    `compliance_officer_name` STRING COMMENT 'Full name of the institutional compliance officer or staff member responsible for the waiver request.',
    `conference_code` STRING COMMENT 'Code representing the athletic conference if the waiver is submitted to a conference governing body.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance waiver record was first created in the system. Audit trail for record creation.',
    `decision_date` DATE COMMENT 'Date on which the governing body issued a decision (approval or denial) on the waiver request. Null if decision is still pending.',
    `decision_outcome` STRING COMMENT 'Final outcome of the waiver decision: approved (fully granted), denied (rejected), partially_approved (some relief granted), conditional_approval (approved with conditions).. Valid values are `approved|denied|partially_approved|conditional_approval`',
    `decision_rationale` STRING COMMENT 'Detailed explanation provided by the governing body for the waiver decision, including reasoning for approval or denial and any conditions imposed.',
    `eligibility_impact` STRING COMMENT 'Description of how the waiver decision impacts the student-athletes eligibility, including changes to eligibility clock, seasons of competition, or scholarship status.',
    `eligibility_year_adjustment` STRING COMMENT 'Adjustment to the student-athletes eligibility year count as a result of the waiver (positive for restored years, negative for forfeited years). Null if not applicable.',
    `expected_decision_date` DATE COMMENT 'Anticipated date by which a decision is expected from the governing body, based on standard processing timelines or expedited review schedules.',
    `governing_body` STRING COMMENT 'The governing body to which the waiver is submitted: NCAA (National Collegiate Athletic Association), NAIA (National Association of Intercollegiate Athletics), NJCAA (National Junior College Athletic Association), or conference-level governing body.. Valid values are `NCAA|NAIA|NJCAA|conference`',
    `governing_body_division` STRING COMMENT 'Division level within the governing body (e.g., Division I, Division II, Division III for NCAA).',
    `head_coach_endorsement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the head coach of the sport endorsed or supported the waiver request (true) or not (false).',
    `immediate_eligibility_granted` BOOLEAN COMMENT 'Boolean flag indicating whether the waiver granted immediate eligibility for competition (true) or if a waiting period applies (false). Applicable primarily to transfer waivers.',
    `institutional_position` STRING COMMENT 'The institutions official position or recommendation regarding the waiver request, as submitted to the governing body.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance waiver record was most recently updated. Audit trail for record modifications.',
    `priority_level` STRING COMMENT 'Priority level assigned to the waiver request: routine (standard processing), expedited (faster review requested), emergency (urgent review required due to time-sensitive circumstances).. Valid values are `routine|expedited|emergency`',
    `record_effective_date` DATE COMMENT 'Date from which this waiver record is effective for business purposes, typically aligned with the submission date or decision date.',
    `season` STRING COMMENT 'Athletic season for which the waiver applies: fall, winter, spring, or summer.. Valid values are `fall|winter|spring|summer`',
    `seasons_restored` STRING COMMENT 'Number of seasons of competition restored to the student-athlete as a result of the waiver approval. Null if waiver was denied or not applicable.',
    `submission_date` DATE COMMENT 'Date on which the waiver request was formally submitted to the governing body.',
    `supporting_documentation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether supporting documentation (medical records, transcripts, affidavits, etc.) was submitted with the waiver request (true) or not (false).',
    `waiver_notes` STRING COMMENT 'Additional notes, comments, or internal documentation related to the waiver request, including follow-up actions, communications with the governing body, or special considerations.',
    `waiver_number` STRING COMMENT 'Externally-known business identifier for the waiver request, often assigned by the governing body or institution compliance office.',
    `waiver_request_summary` STRING COMMENT 'Brief summary of the waiver request, including the circumstances and justification for the waiver as presented to the governing body.',
    `waiver_status` STRING COMMENT 'Current lifecycle status of the waiver request: draft (being prepared), submitted (sent to governing body), pending (awaiting initial review), under_review (actively being evaluated), approved (granted), denied (rejected), appealed (denial appealed), withdrawn (request withdrawn by institution). [ENUM-REF-CANDIDATE: draft|submitted|pending|under_review|approved|denied|appealed|withdrawn — 8 candidates stripped; promote to reference product]',
    `waiver_type` STRING COMMENT 'Classification of the waiver request type: eligibility (general eligibility exception), hardship (personal/family hardship), transfer (transfer eligibility exception), medical (medical hardship/injury), recruiting (recruiting violation waiver), amateurism (amateur status restoration).. Valid values are `eligibility|hardship|transfer|medical|recruiting|amateurism`',
    CONSTRAINT pk_compliance_waiver PRIMARY KEY(`compliance_waiver_id`)
) COMMENT 'Transactional record of a formal waiver request submitted to the NCAA, NAIA, or conference governing body on behalf of a student-athlete or the institution. Captures waiver type (eligibility/hardship/transfer/medical/recruiting/amateurism), student-athlete reference if applicable, sport, submission date, governing body, waiver status (draft/submitted/pending/approved/denied/appealed), decision date, decision rationale, and impact on eligibility clock.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`secondary_violation` (
    `secondary_violation_id` BIGINT COMMENT 'Unique identifier for the secondary NCAA or NAIA rules violation record. Primary key for the secondary_violation product.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Violations are breaches of specific regulatory requirements. Real business process: violation reports must cite the specific bylaw/regulation violated (e.g., NCAA Bylaw 13.1.2.1) for governing body re',
    `related_violation_secondary_violation_id` BIGINT COMMENT 'Reference to another secondary violation record if this violation is part of a pattern or related to a previous case.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: NCAA secondary violations requiring financial restitution (restitution_amount field) must post to specific GL accounts for expense tracking and compliance reporting. Required for accurate financial st',
    `employee_id` BIGINT COMMENT 'Reference to the athletics compliance staff member responsible for managing and documenting this violation case.',
    `secondary_employee_id` BIGINT COMMENT 'Reference to the athletics staff member (coach, administrator, support staff) involved in the violation, if applicable.',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: secondary_violation occurs in context of a specific sport. Currently uses sport_code but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve full sport details. No columns removed',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete involved in the violation, if applicable. May be null if violation involves only staff or boosters.',
    `team_id` BIGINT COMMENT 'Reference to the athletics team associated with the violation.',
    `related_secondary_violation_id` BIGINT COMMENT 'Self-referencing FK on secondary_violation (related_secondary_violation_id)',
    `academic_year` STRING COMMENT 'The academic year during which the violation occurred, typically expressed in format YYYY-YYYY (e.g., 2023-2024).',
    `bylaw_citation` STRING COMMENT 'Specific NCAA bylaw number, NAIA rule reference, or conference regulation that was violated.',
    `case_closure_date` DATE COMMENT 'The date on which the violation case was formally closed after all corrective actions, penalties, and restitution were completed.',
    `corrective_action_date` DATE COMMENT 'The date on which corrective actions were implemented or completed.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective measures implemented by the institution to address the violation and prevent recurrence.',
    `discovery_date` DATE COMMENT 'The date on which the institution became aware of the violation through internal monitoring, self-audit, or external notification.',
    `division_level` STRING COMMENT 'The competitive division level under which the violation occurred, determining applicable rule set.. Valid values are `Division I|Division II|Division III|NAIA`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary value of the violation, if applicable (e.g., impermissible benefits provided, scholarship overage, recruiting expense violation). Expressed in US dollars.',
    `governing_body` STRING COMMENT 'The athletics governing body whose rules were violated (NCAA, NAIA, or conference-specific).. Valid values are `NCAA|NAIA|conference`',
    `governing_body_notification_date` DATE COMMENT 'The date on which the NCAA, NAIA, or conference office was formally notified of the violation.',
    `investigation_completed_date` DATE COMMENT 'The date on which the investigation was concluded and findings were documented.',
    `investigation_start_date` DATE COMMENT 'The date on which the formal internal or external investigation of the violation commenced.',
    `involved_party_type` STRING COMMENT 'Classification of the primary party or parties involved in committing or being affected by the violation. [ENUM-REF-CANDIDATE: student_athlete|coach|staff|booster|representative|vendor|other — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional notes, context, or documentation references related to the violation case for internal compliance tracking.',
    `penalty_effective_date` DATE COMMENT 'The date on which imposed penalties or sanctions took effect.',
    `penalty_imposed` STRING COMMENT 'Description of any penalties, sanctions, or disciplinary actions imposed by the institution or governing body as a result of the violation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this violation record was first created in the compliance management system.',
    `record_effective_date` DATE COMMENT 'The business-effective date from which this version of the violation record is valid, supporting slowly changing dimension tracking for compliance audit trails.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this violation record was last modified, reflecting the most recent update to case status or details.',
    `repeat_violation_flag` BOOLEAN COMMENT 'Indicates whether this violation is a repeat of a similar violation within the prescribed time period, which may result in enhanced penalties.',
    `reported_by_name` STRING COMMENT 'Name of the individual who initially reported or identified the violation, if different from the compliance officer. May be confidential whistleblower information.',
    `restitution_amount` DECIMAL(18,2) COMMENT 'The monetary amount required to be repaid or donated to charity by the involved party, if restitution is required. Expressed in US dollars.',
    `restitution_completed_date` DATE COMMENT 'The date on which required restitution was completed and verified by the compliance office.',
    `restitution_required_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete or other party is required to make restitution (repayment or return of benefits) as part of the resolution.',
    `self_report_date` DATE COMMENT 'The date on which the institution submitted the self-report of the violation to the governing body, if applicable.',
    `self_reported_flag` BOOLEAN COMMENT 'Indicates whether the institution self-reported the violation to the governing body (true) or whether it was discovered through external investigation or audit (false).',
    `term_code` STRING COMMENT 'The academic term code during which the violation occurred, if applicable.',
    `violation_date` DATE COMMENT 'The date on which the secondary violation occurred or was first identified to have occurred.',
    `violation_description` STRING COMMENT 'Detailed narrative description of the violation circumstances, actions taken, and individuals involved. May contain sensitive personnel or student information.',
    `violation_number` STRING COMMENT 'Unique business identifier assigned to the violation case for tracking and reporting purposes.',
    `violation_status` STRING COMMENT 'Current lifecycle status of the violation case within the compliance workflow.. Valid values are `reported|under_investigation|resolved|closed|pending_review`',
    `violation_type` STRING COMMENT 'High-level category classifying the nature of the violation for reporting and trend analysis. [ENUM-REF-CANDIDATE: recruiting|financial_aid|eligibility|extra_benefits|practice|competition|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_secondary_violation PRIMARY KEY(`secondary_violation_id`)
) COMMENT 'Transactional record of a secondary NCAA or NAIA rules violation identified, self-reported, or investigated within the athletics department. Captures violation date, sport, involved parties (student-athlete/coach/staff/booster), rule citation (NCAA bylaw or NAIA rule), violation description, self-report flag, reporting date, governing body notification date, corrective action taken, penalty imposed, and case closure date. Distinct from major violations tracked in the compliance domain.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`eada_report` (
    `eada_report_id` BIGINT COMMENT 'Unique identifier for the EADA report submission record.',
    `campus_id` BIGINT COMMENT 'Identifier for the higher education institution submitting the EADA report.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: EADA reporting mandated by specific federal regulation (Equity in Athletics Disclosure Act, 20 U.S.C. 1092(e)). Real business process: annual EADA submission must reference the specific regulatory req',
    `amended_eada_report_id` BIGINT COMMENT 'Self-referencing FK on eada_report (amended_eada_report_id)',
    `athletics_director_email` STRING COMMENT 'Official email address of the Director of Athletics for EADA reporting correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `athletics_director_name` STRING COMMENT 'Full name of the Director of Athletics responsible for the athletics program during the reporting year.',
    `athletics_director_phone` STRING COMMENT 'Official phone number of the Director of Athletics for EADA reporting correspondence.',
    `certification_date` DATE COMMENT 'Date when the chief executive officer or designee certified the accuracy of the EADA report data.',
    `certified_by_name` STRING COMMENT 'Full name of the institutional official who certified the EADA report (typically the president or chancellor).',
    `certified_by_title` STRING COMMENT 'Official title of the person who certified the EADA report.',
    `coeducational_athletically_related_student_aid` DECIMAL(18,2) COMMENT 'Total athletically related student aid awarded to student-athletes in coeducational teams where applicable.',
    `coeducational_operating_expenses` DECIMAL(18,2) COMMENT 'Total operating expenses for coeducational teams where applicable.',
    `coeducational_participants` STRING COMMENT 'Total count of student-athletes participating in coeducational sports teams where applicable.',
    `coeducational_recruiting_expenses` DECIMAL(18,2) COMMENT 'Total recruiting expenses for coeducational teams where applicable.',
    `coeducational_revenues` DECIMAL(18,2) COMMENT 'Total revenues generated by or allocated to coeducational teams where applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the EADA report record was first created in the system.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the EADA report record was last modified.',
    `mens_assistant_coach_salaries_total` DECIMAL(18,2) COMMENT 'Total salaries and bonuses paid to all assistant coaches of mens teams during the reporting year.',
    `mens_athletically_related_student_aid` DECIMAL(18,2) COMMENT 'Total amount of athletically related student aid awarded to male student-athletes during the reporting year.',
    `mens_head_coach_salaries_total` DECIMAL(18,2) COMMENT 'Total salaries and bonuses paid to all head coaches of mens teams during the reporting year.',
    `mens_operating_expenses` DECIMAL(18,2) COMMENT 'Total operating expenses for mens teams including travel, equipment, uniforms, and game expenses.',
    `mens_recruiting_expenses` DECIMAL(18,2) COMMENT 'Total expenses incurred for recruiting prospective student-athletes for mens teams.',
    `mens_total_revenues` DECIMAL(18,2) COMMENT 'Total revenues generated by or allocated to mens athletics programs including ticket sales, media rights, donations, and institutional support.',
    `report_notes` STRING COMMENT 'Additional notes, clarifications, or contextual information about the EADA report data or submission.',
    `report_preparer_email` STRING COMMENT 'Email address of the staff member who prepared the EADA report for follow-up questions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `report_preparer_name` STRING COMMENT 'Full name of the staff member who prepared the EADA report data.',
    `report_preparer_phone` STRING COMMENT 'Phone number of the staff member who prepared the EADA report for follow-up questions.',
    `reporting_year` STRING COMMENT 'The academic year for which athletics data is being reported in YYYY format (e.g., 2023 represents the 2022-2023 academic year).',
    `submission_date` DATE COMMENT 'Date when the EADA report was officially submitted to the U.S. Department of Education.',
    `submission_status` STRING COMMENT 'Current status of the EADA report in the submission workflow to the U.S. Department of Education.. Valid values are `draft|submitted|accepted|rejected|amended|locked`',
    `total_athletics_expenses` DECIMAL(18,2) COMMENT 'Combined total expenses for the entire intercollegiate athletics program including both mens and womens sports.',
    `total_athletics_revenues` DECIMAL(18,2) COMMENT 'Combined total revenues for the entire intercollegiate athletics program including both mens and womens sports.',
    `total_female_assistant_coaches` STRING COMMENT 'Total count of female assistant coaches for all mens and womens teams.',
    `total_female_head_coaches` STRING COMMENT 'Total count of female head coaches for all mens and womens teams.',
    `total_female_participants` STRING COMMENT 'Total unduplicated count of female student-athletes who participated in intercollegiate athletics during the reporting year.',
    `total_male_assistant_coaches` STRING COMMENT 'Total count of male assistant coaches for all mens and womens teams.',
    `total_male_head_coaches` STRING COMMENT 'Total count of male head coaches for all mens and womens teams.',
    `total_male_participants` STRING COMMENT 'Total unduplicated count of male student-athletes who participated in intercollegiate athletics during the reporting year.',
    `womens_assistant_coach_salaries_total` DECIMAL(18,2) COMMENT 'Total salaries and bonuses paid to all assistant coaches of womens teams during the reporting year.',
    `womens_athletically_related_student_aid` DECIMAL(18,2) COMMENT 'Total amount of athletically related student aid awarded to female student-athletes during the reporting year.',
    `womens_head_coach_salaries_total` DECIMAL(18,2) COMMENT 'Total salaries and bonuses paid to all head coaches of womens teams during the reporting year.',
    `womens_operating_expenses` DECIMAL(18,2) COMMENT 'Total operating expenses for womens teams including travel, equipment, uniforms, and game expenses.',
    `womens_recruiting_expenses` DECIMAL(18,2) COMMENT 'Total expenses incurred for recruiting prospective student-athletes for womens teams.',
    `womens_total_revenues` DECIMAL(18,2) COMMENT 'Total revenues generated by or allocated to womens athletics programs including ticket sales, media rights, donations, and institutional support.',
    CONSTRAINT pk_eada_report PRIMARY KEY(`eada_report_id`)
) COMMENT 'Annual Equity in Athletics Disclosure Act (EADA) report record capturing the federally mandated gender equity and financial data submission for the institutions athletics program. Captures reporting year, total male/female participation counts by sport, coaching staff counts and salaries by gender and sport, operating expenses by sport and gender, recruiting expenses, athletically related student aid by sport and gender, revenues by sport, and submission status to the U.S. Department of Education.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`sports_medicine_case` (
    `sports_medicine_case_id` BIGINT COMMENT 'Unique identifier for the sports medicine case record. Primary key for the sports medicine case entity.',
    `employee_id` BIGINT COMMENT 'Reference to the certified athletic trainer who is the primary care provider for this sports medicine case.',
    `quaternary_sports_record_updated_by_staff_employee_id` BIGINT COMMENT 'Reference to the staff member who last updated this sports medicine case record.',
    `irb_protocol_id` BIGINT COMMENT 'Foreign key linking to research.irb_protocol. Business justification: Links medical cases enrolled in IRB-approved research studies (injury prevention trials, treatment efficacy studies, longitudinal health tracking). Required for research compliance, protocol enrollmen',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete who is the subject of this sports medicine case. Links to the student-athlete master record.',
    `tertiary_sports_cleared_by_physician_employee_id` BIGINT COMMENT 'Reference to the physician who provided final medical clearance for return to play.',
    `related_sports_medicine_case_id` BIGINT COMMENT 'Self-referencing FK on sports_medicine_case (related_sports_medicine_case_id)',
    `body_part` STRING COMMENT 'Specific body part or anatomical region affected by the injury or condition (e.g., knee, shoulder, ankle, head, lower back).',
    `body_side` STRING COMMENT 'Laterality of the injury indicating which side of the body is affected (left, right, bilateral, central, not applicable).. Valid values are `left|right|bilateral|central|not_applicable`',
    `case_closed_date` DATE COMMENT 'Date when the sports medicine case was officially closed, indicating the student-athlete has fully recovered or the case is no longer active.',
    `case_notes` STRING COMMENT 'Additional clinical notes, observations, or administrative comments related to the sports medicine case.',
    `case_number` STRING COMMENT 'Business identifier for the sports medicine case, typically formatted with sport code prefix and sequential number for tracking and reference purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}$`',
    `case_opened_date` DATE COMMENT 'Date when the sports medicine case was officially opened in the system.',
    `case_status` STRING COMMENT 'Current lifecycle status of the sports medicine case (open, in treatment, cleared, closed, chronic management).. Valid values are `open|in_treatment|cleared|closed|chronic_management`',
    `concussion_protocol_flag` BOOLEAN COMMENT 'Indicates whether this case involves a concussion and requires adherence to NCAA concussion management protocols (true/false).',
    `diagnosis_code` STRING COMMENT 'ICD-10 diagnosis code for the injury or medical condition, used for medical billing and insurance claims.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `diagnosis_description` STRING COMMENT 'Clinical diagnosis of the injury or medical condition in plain language, as determined by the treating physician or athletic trainer.',
    `estimated_recovery_days` STRING COMMENT 'Initial clinical estimate of the number of days until the student-athlete can return to full participation.',
    `injury_category` STRING COMMENT 'Broader categorical classification of the injury or condition (e.g., musculoskeletal, neurological, cardiovascular, respiratory, dermatological).',
    `injury_date` DATE COMMENT 'Date when the injury, illness, or medical condition occurred or was first identified.',
    `injury_description` STRING COMMENT 'Detailed narrative description of how the injury occurred, including circumstances, mechanism, and any contributing factors.',
    `injury_time` TIMESTAMP COMMENT 'Precise timestamp when the injury or medical event occurred, if known.',
    `injury_type` STRING COMMENT 'Classification of the injury or medical condition by type (acute, chronic, overuse, traumatic, illness, concussion, heat-related, cardiac, other). [ENUM-REF-CANDIDATE: acute|chronic|overuse|traumatic|illness|concussion|heat_related|cardiac|other — 9 candidates stripped; promote to reference product]',
    `insurance_claim_number` STRING COMMENT 'Reference number for the insurance claim filed for this injury or medical condition, if applicable.. Valid values are `^[A-Z0-9]{8,20}$`',
    `insurance_claim_status` STRING COMMENT 'Current status of the insurance claim associated with this sports medicine case (not filed, pending, approved, denied, paid, closed).. Valid values are `not_filed|pending|approved|denied|paid|closed`',
    `mechanism_of_injury` STRING COMMENT 'Context in which the injury occurred, indicating the activity type (game, practice, conditioning, weight training, non-athletic, unknown).. Valid values are `game|practice|conditioning|weight_training|non_athletic|unknown`',
    `medical_clearance_date` DATE COMMENT 'Date when the student-athlete received medical clearance to return to full athletic participation.',
    `medical_clearance_status` STRING COMMENT 'Current medical clearance status indicating whether the student-athlete is authorized to participate in athletic activities (not cleared, cleared with restrictions, fully cleared, pending evaluation).. Valid values are `not_cleared|cleared_with_restrictions|fully_cleared|pending_evaluation`',
    `medical_redshirt_applied_flag` BOOLEAN COMMENT 'Indicates whether a medical hardship waiver application has been submitted to the NCAA for this case (true/false).',
    `medical_redshirt_eligible_flag` BOOLEAN COMMENT 'Indicates whether this injury qualifies the student-athlete for a medical hardship waiver (medical redshirt) under NCAA rules (true/false).',
    `physician_referral_date` DATE COMMENT 'Date when the student-athlete was referred to a physician for medical evaluation or treatment.',
    `physician_referral_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete was referred to a physician for evaluation or treatment (true/false).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sports medicine case record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sports medicine case record was last modified in the system.',
    `reportable_injury_flag` BOOLEAN COMMENT 'Indicates whether this injury must be reported to the NCAA Injury Surveillance System or other regulatory bodies (true/false).',
    `return_to_play_protocol` STRING COMMENT 'Structured protocol governing the student-athletes progression back to full athletic participation, including stages and criteria for advancement.',
    `return_to_play_stage` STRING COMMENT 'Current stage in the return-to-play progression (initial rest, light activity, sport-specific exercise, non-contact practice, full contact practice, unrestricted participation).. Valid values are `initial_rest|light_activity|sport_specific|non_contact_practice|full_contact_practice|unrestricted_participation`',
    `severity_level` STRING COMMENT 'Clinical assessment of injury severity (minor, moderate, severe, catastrophic) based on expected recovery time and impact on participation.. Valid values are `minor|moderate|severe|catastrophic`',
    `treating_athletic_trainer_name` STRING COMMENT 'Full name of the certified athletic trainer managing this case.',
    `treating_physician_name` STRING COMMENT 'Full name of the physician who evaluated or treated the student-athlete.',
    `treatment_plan` STRING COMMENT 'Detailed description of the treatment plan including therapeutic interventions, rehabilitation protocols, medications, and activity restrictions.',
    CONSTRAINT pk_sports_medicine_case PRIMARY KEY(`sports_medicine_case_id`)
) COMMENT 'Master record for a student-athletes injury, illness, or medical condition managed by the athletics sports medicine staff. Captures student-athlete reference, sport, injury date, injury type, body part affected, mechanism of injury (game/practice/conditioning), diagnosis, treating athletic trainer, physician referral flag, treatment plan, return-to-play protocol stage, medical clearance status, medical redshirt eligibility flag, and insurance claim reference.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`drug_test` (
    `drug_test_id` BIGINT COMMENT 'Unique identifier for the drug test record. Primary key for the drug test entity.',
    `employee_id` BIGINT COMMENT 'Reference to the institutional staff member (typically compliance officer or athletic director) who notified the student-athlete of the test result.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Drug testing programs governed by specific NCAA/conference regulations and institutional policies. Real business process: testing protocols, substance lists, and sanction procedures must comply with s',
    `irb_protocol_id` BIGINT COMMENT 'Foreign key linking to research.irb_protocol. Business justification: Links drug testing data used in IRB-approved research (epidemiological studies, substance use patterns, testing efficacy research). Required for research compliance when de-identified testing data is ',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: drug_test is conducted for student-athletes in a specific sport. Currently uses sport_code/sport_name but lacks FK to sport master table. Adding sport_id enables JOIN to retrieve sport_name and other ',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete who was tested. Links to the student-athlete master record.',
    `retest_drug_test_id` BIGINT COMMENT 'Self-referencing FK on drug_test (retest_drug_test_id)',
    `appeal_decision_date` DATE COMMENT 'The date on which a final decision was rendered on the student-athletes appeal. Null if appeal is pending or no appeal was filed.',
    `appeal_filed_date` DATE COMMENT 'The date on which the student-athlete submitted a formal appeal of the test result or sanction. Null if no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete filed a formal appeal of the positive test result or imposed sanction.',
    `appeal_status` STRING COMMENT 'The current status of the appeal process: pending (under review), upheld (original decision affirmed), overturned (decision reversed), withdrawn (athlete withdrew appeal), or dismissed (appeal rejected on procedural grounds). Null if no appeal was filed.. Valid values are `pending|upheld|overturned|withdrawn|dismissed`',
    `b_sample_requested_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete requested analysis of the B sample (confirmatory sample) following a positive A sample result, as permitted under NCAA and WADA protocols.',
    `b_sample_result` STRING COMMENT 'The outcome of the B sample analysis: confirmed (positive result verified), not confirmed (positive result not verified), not requested (athlete did not request B sample analysis), or pending (analysis in progress).. Valid values are `confirmed|not_confirmed|not_requested|pending`',
    `chain_of_custody_number` STRING COMMENT 'Unique tracking number documenting the handling and transfer of the specimen from collection through analysis and storage.',
    `collection_site_code` STRING COMMENT 'Standardized code identifying the collection site or facility where the sample was obtained.',
    `concentration_level` STRING COMMENT 'The measured concentration or quantity of the detected substance in the specimen, typically expressed in ng/mL or other laboratory units. Applicable for positive results.',
    `games_missed` STRING COMMENT 'The number of contests or competitions the student-athlete was ineligible to participate in due to the drug test sanction.',
    `laboratory_accreditation_number` STRING COMMENT 'Accreditation identifier for the testing laboratory, confirming compliance with WADA or NCAA standards.',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, or administrative notes related to the drug test event, result, or sanction process.',
    `notification_date` DATE COMMENT 'The date on which the student-athlete was officially notified of a positive test result or other adverse finding.',
    `notification_method` STRING COMMENT 'The method by which the student-athlete was notified of the test result (in-person, phone, email, certified mail, or other).. Valid values are `in_person|phone|email|certified_mail|other`',
    `positive_substance_name` STRING COMMENT 'The specific banned substance or metabolite detected in a positive test result. Null if test result is negative.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug test record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug test record was last modified in the system.',
    `result_reported_date` DATE COMMENT 'The date on which the laboratory reported the test results to the institution or governing body.',
    `sanction_imposed` STRING COMMENT 'Description of the penalty or sanction imposed on the student-athlete as a result of a positive test (e.g., suspension from competition, loss of eligibility, mandatory counseling, withholding of financial aid). Null if no sanction was imposed.',
    `specimen_code` STRING COMMENT 'Unique identifier assigned to the biological specimen for chain of custody tracking and laboratory processing.',
    `specimen_type` STRING COMMENT 'The type of biological specimen collected for testing (urine, blood, saliva, or hair).. Valid values are `urine|blood|saliva|hair`',
    `substance_class` STRING COMMENT 'The category or class of the detected substance (e.g., stimulant, anabolic agent, cannabinoid, narcotic, diuretic, masking agent). Applicable for positive results.',
    `substances_tested` STRING COMMENT 'List or description of the substance classes or specific substances included in the testing panel (e.g., stimulants, anabolic agents, cannabinoids, narcotics, diuretics, masking agents).',
    `suspension_end_date` DATE COMMENT 'The date on which a suspension or eligibility withholding sanction ends, allowing the student-athlete to return to competition. Applicable if a suspension was imposed.',
    `suspension_start_date` DATE COMMENT 'The date on which a suspension or eligibility withholding sanction begins. Applicable if a suspension was imposed.',
    `test_date` DATE COMMENT 'The date on which the drug test sample was collected from the student-athlete.',
    `test_location` STRING COMMENT 'The physical location or facility where the drug test sample was collected.',
    `test_result` STRING COMMENT 'The outcome of the drug test: negative (no banned substances detected), positive (banned substance detected), dilute (sample concentration too low), invalid (sample compromised), refused (athlete declined to provide sample), or pending (results not yet available).. Valid values are `negative|positive|dilute|invalid|refused|pending`',
    `test_time` TIMESTAMP COMMENT 'The precise timestamp when the drug test sample was collected, including time zone information.',
    `test_type` STRING COMMENT 'The category of drug test administered: random selection, reasonable suspicion, championship event, post-season, pre-season, or follow-up testing.. Valid values are `random|reasonable_suspicion|championship|post_season|pre_season|follow_up`',
    `testing_laboratory_name` STRING COMMENT 'Name of the certified laboratory that performed the drug test analysis.',
    `testing_program` STRING COMMENT 'The governing body or program under which the drug test was administered (NCAA, conference, institutional, NAIA, or other).. Valid values are `NCAA|conference|institutional|NAIA|other`',
    `therapeutic_use_exemption_flag` BOOLEAN COMMENT 'Indicates whether the student-athlete has an approved Therapeutic Use Exemption for the detected substance, which may mitigate or nullify a positive result.',
    `threshold_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the detected substance concentration exceeded the NCAA or WADA reporting threshold, triggering a positive result.',
    `tue_approval_date` DATE COMMENT 'The date on which the Therapeutic Use Exemption was approved by the NCAA or institutional medical authority. Null if no TUE applies.',
    CONSTRAINT pk_drug_test PRIMARY KEY(`drug_test_id`)
) COMMENT 'Transactional record of a mandatory drug or substance testing event for a student-athlete under NCAA, conference, or institutional drug testing programs. Captures student-athlete reference, sport, test date, testing program (NCAA/conference/institutional), test type (random/reasonable suspicion/post-season/pre-season), substances tested, result (negative/positive/dilute/refused), chain of custody reference, positive finding notification date, sanction imposed, and appeal status.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`booster` (
    `booster_id` BIGINT COMMENT 'Unique identifier for the booster record. Primary key for the booster entity.',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Boosters are often donors to the institution. This FK links athletic boosters to the advancement donor master record, enabling unified donor relationship management across athletics and advancement. T',
    `employee_id` BIGINT COMMENT 'Identifier of the athletics compliance staff member assigned to monitor and manage this booster relationship.',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `third_party_contract_id` BIGINT COMMENT 'Foreign key linking to billing.third_party_contract. Business justification: Boosters/donors establish third-party payment contracts for student-athletes (corporate sponsors, booster clubs paying tuition). Business tracks booster-funded scholarships through third-party billing',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to compliance.training_program. Business justification: Boosters required to complete compliance briefings on NCAA rules (recruiting restrictions, impermissible benefits, representative of athletics interests designation). Real business process: compliance',
    `referred_by_booster_id` BIGINT COMMENT 'Self-referencing FK on booster (referred_by_booster_id)',
    `address_line1` STRING COMMENT 'First line of the boosters mailing address (street address).',
    `address_line2` STRING COMMENT 'Second line of the boosters mailing address (suite, apartment, building).',
    `alumni_flag` BOOLEAN COMMENT 'Indicates whether the booster is an alumnus/alumna of the institution.',
    `booster_status` STRING COMMENT 'Current status of the booster relationship: active (currently engaged), inactive (no recent activity), suspended (compliance hold), deceased (individual only), or restricted (prohibited from certain activities).. Valid values are `active|inactive|suspended|deceased|restricted`',
    `booster_type` STRING COMMENT 'Classification of the booster entity type: individual person, corporate entity, foundation, organization, alumni association, or booster club.. Valid values are `individual|corporate|foundation|organization|alumni_association|booster_club`',
    `city` STRING COMMENT 'City of the boosters mailing address.',
    `classification_date` DATE COMMENT 'Date when the individual or organization was officially classified as a booster under NCAA/NAIA definitions.',
    `club_member_flag` BOOLEAN COMMENT 'Indicates whether the booster is a member of an official athletics booster club or support organization.',
    `compliance_briefing_completed` BOOLEAN COMMENT 'Indicates whether the booster has successfully completed the required NCAA/NAIA compliance education and briefing.',
    `compliance_briefing_date` DATE COMMENT 'Date when the booster completed the most recent NCAA/NAIA compliance education and briefing.',
    `compliance_briefing_required` BOOLEAN COMMENT 'Indicates whether the booster is required to complete NCAA/NAIA compliance education and briefing based on their level of involvement.',
    `compliance_incident_count` STRING COMMENT 'Total number of compliance incidents or violations associated with this booster.',
    `compliance_incident_flag` BOOLEAN COMMENT 'Indicates whether the booster has been associated with any NCAA/NAIA compliance incidents or violations.',
    `compliance_restriction_details` STRING COMMENT 'Description of any compliance-related restrictions currently imposed on the booster, including scope and duration.',
    `compliance_restriction_flag` BOOLEAN COMMENT 'Indicates whether the booster is currently subject to any compliance-related restrictions on their involvement with the athletics program.',
    `corporate_sponsor_flag` BOOLEAN COMMENT 'Indicates whether the booster (typically corporate or foundation type) has entered into sponsorship agreements with the athletics program.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the boosters mailing address.. Valid values are `^[A-Z]{3}$`',
    `donor_flag` BOOLEAN COMMENT 'Indicates whether the booster has made financial contributions to the athletics program or related entities.',
    `former_student_athlete_flag` BOOLEAN COMMENT 'Indicates whether the booster was a former student-athlete at the institution.',
    `individual_first_name` STRING COMMENT 'First name of the booster if booster_type is individual. Null for corporate/foundation boosters.',
    `individual_last_name` STRING COMMENT 'Last name of the booster if booster_type is individual. Null for corporate/foundation boosters.',
    `individual_middle_name` STRING COMMENT 'Middle name or initial of the booster if booster_type is individual. Null for corporate/foundation boosters.',
    `involvement_type` STRING COMMENT 'Primary type of booster involvement with the athletics program: donor (financial contributor), volunteer (time/service), ticket holder (season ticket purchaser), sponsor (corporate sponsorship), board member (booster club leadership), or multiple (combination of types).. Valid values are `donor|volunteer|ticket_holder|sponsor|board_member|multiple`',
    `last_compliance_incident_date` DATE COMMENT 'Date of the most recent compliance incident or violation associated with this booster.',
    `last_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the most recent financial contribution made by the booster.',
    `last_contribution_date` DATE COMMENT 'Date of the most recent financial contribution made by the booster.',
    `next_compliance_briefing_due_date` DATE COMMENT 'Date by which the booster must complete their next compliance education and briefing to maintain active status.',
    `notes` STRING COMMENT 'Free-text notes regarding the booster relationship, involvement history, special considerations, or compliance observations.',
    `organization_name` STRING COMMENT 'Legal name of the organization, corporation, foundation, or booster club if booster_type is not individual. Null for individual boosters.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the boosters mailing address.',
    `primary_email` STRING COMMENT 'Primary email address for booster communication and compliance notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary contact phone number for the booster.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this booster record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this booster record was last updated in the system.',
    `season_ticket_holder_flag` BOOLEAN COMMENT 'Indicates whether the booster currently holds or has held season tickets for athletics events.',
    `secondary_sport_codes` STRING COMMENT 'Comma-separated list of additional sport codes the booster supports or is involved with beyond the primary sport.',
    `state_province` STRING COMMENT 'State or province of the boosters mailing address.',
    `total_lifetime_contributions` DECIMAL(18,2) COMMENT 'Cumulative total dollar amount of all financial contributions made by the booster to the athletics program since classification date. Summary field for reporting purposes.',
    `volunteer_flag` BOOLEAN COMMENT 'Indicates whether the booster has volunteered time or services to the athletics program.',
    CONSTRAINT pk_booster PRIMARY KEY(`booster_id`)
) COMMENT 'Master record for individuals and organizations classified as institutional boosters under NCAA/NAIA definitions — those who have promoted, assisted, or been involved with the athletics program. Captures booster name, organization, booster type (individual/corporate/foundation), classification date, sport(s) associated, financial contribution history summary, involvement type (donor/volunteer/ticket holder/sponsor), compliance briefing completion status, and any compliance incident associations.';

CREATE OR REPLACE TABLE `education_ecm`.`athletics`.`nil_activity` (
    `nil_activity_id` BIGINT COMMENT 'Unique identifier for the NIL activity record. Primary key for the nil_activity product.',
    `employee_id` BIGINT COMMENT 'Reference to the compliance staff member who conducted the institutional review of this NIL activity.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: NIL activities must comply with state laws and NCAA interim policy. Real business process: institutional review of NIL disclosures requires verification against specific regulatory requirements (state',
    `sport_id` BIGINT COMMENT 'FK to athletics.sport',
    `student_athlete_id` BIGINT COMMENT 'Reference to the student-athlete who entered into this NIL activity or agreement.',
    `superseded_nil_activity_id` BIGINT COMMENT 'Self-referencing FK on nil_activity (superseded_nil_activity_id)',
    `activity_description` STRING COMMENT 'Free-text description of the NIL activity, including the nature of services to be performed, deliverables, promotional obligations, and any other relevant details of the agreement.',
    `activity_number` STRING COMMENT 'Business identifier or tracking number assigned to this NIL activity for institutional reference and reporting purposes.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the NIL activity (e.g., active and ongoing, completed, cancelled before start, suspended, terminated early).. Valid values are `active|completed|cancelled|suspended|terminated`',
    `activity_type` STRING COMMENT 'Classification of the type of NIL activity or agreement entered into by the student-athlete (e.g., endorsement, social media promotion, personal appearance, autograph session, camp instruction, licensing, merchandise, media production). [ENUM-REF-CANDIDATE: endorsement|social_media|appearance|autograph|camp|licensing|merchandise|media|other — 9 candidates stripped; promote to reference product]',
    `agreement_end_date` DATE COMMENT 'The date on which the NIL agreement expires or terminates. Nullable for open-ended or ongoing agreements.',
    `agreement_start_date` DATE COMMENT 'The date on which the NIL agreement becomes effective and the student-athlete begins performing under the terms of the agreement.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the estimated compensation value is denominated (e.g., USD for United States Dollar).. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `compensation_type` STRING COMMENT 'Classification of the form of compensation provided under the NIL agreement (e.g., cash payment, goods, services, equity stake, mixed compensation).. Valid values are `cash|goods|services|equity|mixed|other`',
    `compliance_notes` STRING COMMENT 'Free-text notes from the compliance office regarding this NIL activity, including any concerns, follow-up actions, or special conditions imposed.',
    `conflict_of_interest_flag` BOOLEAN COMMENT 'Boolean indicator of whether this NIL activity presents a potential conflict of interest with institutional sponsors, partners, or values (e.g., competing brand, prohibited industry).',
    `conflict_of_interest_notes` STRING COMMENT 'Free-text notes describing any identified conflict of interest, the nature of the conflict, and any mitigation steps taken.',
    `disclosure_date` DATE COMMENT 'The date on which the student-athlete disclosed this NIL activity to the institution for compliance review and record-keeping purposes.',
    `disclosure_method` STRING COMMENT 'The method or channel through which the student-athlete disclosed the NIL activity to the institution (e.g., online portal, email submission, paper form, verbal notification).. Valid values are `online_portal|email|paper_form|verbal|other`',
    `estimated_compensation_value` DECIMAL(18,2) COMMENT 'The estimated total monetary value or fair market value of compensation the student-athlete will receive under this NIL agreement, including cash payments, goods, services, or other benefits.',
    `institutional_marks_approval_status` STRING COMMENT 'Status of institutional approval for the use of institutional trademarks or marks in this NIL activity (e.g., not applicable, pending approval, approved, denied).. Valid values are `not_applicable|pending|approved|denied`',
    `institutional_marks_used_flag` BOOLEAN COMMENT 'Boolean indicator of whether the NIL activity involves the use of institutional trademarks, logos, uniforms, or other intellectual property owned by the institution.',
    `institutional_review_status` STRING COMMENT 'Current status of the institutional compliance review of this NIL activity (e.g., pending review, reviewed, approved, flagged for concern, rejected, under investigation).. Valid values are `pending|reviewed|approved|flagged|rejected|under_investigation`',
    `ncaa_nil_policy_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this NIL activity complies with NCAA Name, Image, and Likeness interim policy and guidelines.',
    `ncaa_policy_version` STRING COMMENT 'Version or effective date reference of the NCAA NIL policy under which this activity was reviewed and approved.',
    `pay_for_play_flag` BOOLEAN COMMENT 'Boolean indicator of whether this NIL activity was flagged as potentially constituting impermissible pay-for-play compensation tied to athletic participation or performance.',
    `quid_pro_quo_flag` BOOLEAN COMMENT 'Boolean indicator of whether this NIL activity was flagged as potentially being a quid pro quo arrangement tied to enrollment, athletic performance, or recruiting inducement, which would violate NCAA policy.',
    `record_created_by` STRING COMMENT 'Identifier of the user or system process that created this NIL activity record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this NIL activity record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this NIL activity record was last modified or updated in the system.',
    `review_date` DATE COMMENT 'The date on which the institutional compliance office completed its review of this NIL activity.',
    `state_nil_law_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this NIL activity complies with applicable state Name, Image, and Likeness laws and regulations in the jurisdiction where the institution is located.',
    `state_nil_law_reference` STRING COMMENT 'Citation or reference to the specific state NIL law or statute that governs this activity (e.g., California SB 206, Florida HB 7003).',
    `tax_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this NIL activity requires tax reporting (e.g., IRS Form 1099-MISC or 1099-NEC) due to the value of compensation received.',
    `termination_date` DATE COMMENT 'The date on which the NIL agreement was terminated or cancelled, if applicable. Nullable for agreements that were completed or are still active.',
    `termination_reason` STRING COMMENT 'Free-text explanation of the reason for early termination or cancellation of the NIL agreement (e.g., compliance violation, mutual agreement, breach of contract).',
    `third_party_entity_name` STRING COMMENT 'Name of the third-party individual, business, or organization that is party to the NIL agreement with the student-athlete.',
    `third_party_entity_type` STRING COMMENT 'Classification of the third-party entity type (e.g., individual, corporation, limited liability company, partnership, nonprofit organization, NIL collective). [ENUM-REF-CANDIDATE: individual|corporation|llc|partnership|nonprofit|collective|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_nil_activity PRIMARY KEY(`nil_activity_id`)
) COMMENT 'Transactional record of a Name, Image, and Likeness (NIL) activity or agreement entered into by a student-athlete. Captures student-athlete reference, sport, NIL activity type (endorsement/social media/appearance/autograph/camp/licensing), third-party entity name, agreement start date, agreement end date, estimated compensation value, disclosure date, institutional review status (reviewed/approved/flagged), state NIL law compliance flag, and NCAA NIL policy compliance flag.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ADD CONSTRAINT `fk_athletics_athletic_eligibility_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ADD CONSTRAINT `fk_athletics_athletic_eligibility_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`sport` ADD CONSTRAINT `fk_athletics_sport_parent_sport_id` FOREIGN KEY (`parent_sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`team` ADD CONSTRAINT `fk_athletics_team_athletic_facility_id` FOREIGN KEY (`athletic_facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`athletics`.`team` ADD CONSTRAINT `fk_athletics_team_coach_id` FOREIGN KEY (`coach_id`) REFERENCES `education_ecm`.`athletics`.`coach`(`coach_id`);
ALTER TABLE `education_ecm`.`athletics`.`team` ADD CONSTRAINT `fk_athletics_team_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`team` ADD CONSTRAINT `fk_athletics_team_predecessor_team_id` FOREIGN KEY (`predecessor_team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`roster` ADD CONSTRAINT `fk_athletics_roster_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`roster` ADD CONSTRAINT `fk_athletics_roster_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`roster` ADD CONSTRAINT `fk_athletics_roster_prior_roster_id` FOREIGN KEY (`prior_roster_id`) REFERENCES `education_ecm`.`athletics`.`roster`(`roster_id`);
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ADD CONSTRAINT `fk_athletics_student_athlete_transfer_student_athlete_id` FOREIGN KEY (`transfer_student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ADD CONSTRAINT `fk_athletics_eligibility_certification_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ADD CONSTRAINT `fk_athletics_eligibility_certification_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ADD CONSTRAINT `fk_athletics_eligibility_certification_prior_eligibility_certification_id` FOREIGN KEY (`prior_eligibility_certification_id`) REFERENCES `education_ecm`.`athletics`.`eligibility_certification`(`eligibility_certification_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_nli_id` FOREIGN KEY (`nli_id`) REFERENCES `education_ecm`.`athletics`.`nli`(`nli_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ADD CONSTRAINT `fk_athletics_athletic_scholarship_renewed_athletic_scholarship_id` FOREIGN KEY (`renewed_athletic_scholarship_id`) REFERENCES `education_ecm`.`athletics`.`athletic_scholarship`(`athletic_scholarship_id`);
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`nli` ADD CONSTRAINT `fk_athletics_nli_superseded_nli_id` FOREIGN KEY (`superseded_nli_id`) REFERENCES `education_ecm`.`athletics`.`nli`(`nli_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruit` ADD CONSTRAINT `fk_athletics_recruit_coach_id` FOREIGN KEY (`coach_id`) REFERENCES `education_ecm`.`athletics`.`coach`(`coach_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruit` ADD CONSTRAINT `fk_athletics_recruit_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruit` ADD CONSTRAINT `fk_athletics_recruit_transfer_recruit_id` FOREIGN KEY (`transfer_recruit_id`) REFERENCES `education_ecm`.`athletics`.`recruit`(`recruit_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ADD CONSTRAINT `fk_athletics_recruiting_contact_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ADD CONSTRAINT `fk_athletics_recruiting_contact_followup_recruiting_contact_id` FOREIGN KEY (`followup_recruiting_contact_id`) REFERENCES `education_ecm`.`athletics`.`recruiting_contact`(`recruiting_contact_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ADD CONSTRAINT `fk_athletics_official_visit_rescheduled_official_visit_id` FOREIGN KEY (`rescheduled_official_visit_id`) REFERENCES `education_ecm`.`athletics`.`official_visit`(`official_visit_id`);
ALTER TABLE `education_ecm`.`athletics`.`game` ADD CONSTRAINT `fk_athletics_game_athletic_facility_id` FOREIGN KEY (`athletic_facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`athletics`.`game` ADD CONSTRAINT `fk_athletics_game_rescheduled_game_id` FOREIGN KEY (`rescheduled_game_id`) REFERENCES `education_ecm`.`athletics`.`game`(`game_id`);
ALTER TABLE `education_ecm`.`athletics`.`game` ADD CONSTRAINT `fk_athletics_game_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`game` ADD CONSTRAINT `fk_athletics_game_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ADD CONSTRAINT `fk_athletics_game_participation_game_id` FOREIGN KEY (`game_id`) REFERENCES `education_ecm`.`athletics`.`game`(`game_id`);
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ADD CONSTRAINT `fk_athletics_game_participation_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ADD CONSTRAINT `fk_athletics_game_participation_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ADD CONSTRAINT `fk_athletics_game_participation_amended_game_participation_id` FOREIGN KEY (`amended_game_participation_id`) REFERENCES `education_ecm`.`athletics`.`game_participation`(`game_participation_id`);
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ADD CONSTRAINT `fk_athletics_practice_session_athletic_facility_id` FOREIGN KEY (`athletic_facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ADD CONSTRAINT `fk_athletics_practice_session_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ADD CONSTRAINT `fk_athletics_practice_session_coach_id` FOREIGN KEY (`coach_id`) REFERENCES `education_ecm`.`athletics`.`coach`(`coach_id`);
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ADD CONSTRAINT `fk_athletics_practice_session_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ADD CONSTRAINT `fk_athletics_practice_session_makeup_practice_session_id` FOREIGN KEY (`makeup_practice_session_id`) REFERENCES `education_ecm`.`athletics`.`practice_session`(`practice_session_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ADD CONSTRAINT `fk_athletics_athletic_facility_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ADD CONSTRAINT `fk_athletics_athletic_facility_parent_athletic_facility_id` FOREIGN KEY (`parent_athletic_facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ADD CONSTRAINT `fk_athletics_facility_event_booking_athletic_facility_id` FOREIGN KEY (`athletic_facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ADD CONSTRAINT `fk_athletics_facility_event_booking_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `education_ecm`.`athletics`.`athletic_facility`(`athletic_facility_id`);
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ADD CONSTRAINT `fk_athletics_facility_event_booking_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ADD CONSTRAINT `fk_athletics_facility_event_booking_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ADD CONSTRAINT `fk_athletics_facility_event_booking_rescheduled_facility_event_booking_id` FOREIGN KEY (`rescheduled_facility_event_booking_id`) REFERENCES `education_ecm`.`athletics`.`facility_event_booking`(`facility_event_booking_id`);
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`coach` ADD CONSTRAINT `fk_athletics_coach_supervising_coach_id` FOREIGN KEY (`supervising_coach_id`) REFERENCES `education_ecm`.`athletics`.`coach`(`coach_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ADD CONSTRAINT `fk_athletics_athletic_award_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ADD CONSTRAINT `fk_athletics_athletic_award_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ADD CONSTRAINT `fk_athletics_athletic_award_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ADD CONSTRAINT `fk_athletics_athletic_award_superseded_athletic_award_id` FOREIGN KEY (`superseded_athletic_award_id`) REFERENCES `education_ecm`.`athletics`.`athletic_award`(`athletic_award_id`);
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ADD CONSTRAINT `fk_athletics_compliance_waiver_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ADD CONSTRAINT `fk_athletics_compliance_waiver_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ADD CONSTRAINT `fk_athletics_compliance_waiver_appealed_compliance_waiver_id` FOREIGN KEY (`appealed_compliance_waiver_id`) REFERENCES `education_ecm`.`athletics`.`compliance_waiver`(`compliance_waiver_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_related_violation_secondary_violation_id` FOREIGN KEY (`related_violation_secondary_violation_id`) REFERENCES `education_ecm`.`athletics`.`secondary_violation`(`secondary_violation_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_team_id` FOREIGN KEY (`team_id`) REFERENCES `education_ecm`.`athletics`.`team`(`team_id`);
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ADD CONSTRAINT `fk_athletics_secondary_violation_related_secondary_violation_id` FOREIGN KEY (`related_secondary_violation_id`) REFERENCES `education_ecm`.`athletics`.`secondary_violation`(`secondary_violation_id`);
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ADD CONSTRAINT `fk_athletics_eada_report_amended_eada_report_id` FOREIGN KEY (`amended_eada_report_id`) REFERENCES `education_ecm`.`athletics`.`eada_report`(`eada_report_id`);
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ADD CONSTRAINT `fk_athletics_sports_medicine_case_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ADD CONSTRAINT `fk_athletics_sports_medicine_case_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ADD CONSTRAINT `fk_athletics_sports_medicine_case_related_sports_medicine_case_id` FOREIGN KEY (`related_sports_medicine_case_id`) REFERENCES `education_ecm`.`athletics`.`sports_medicine_case`(`sports_medicine_case_id`);
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ADD CONSTRAINT `fk_athletics_drug_test_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ADD CONSTRAINT `fk_athletics_drug_test_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ADD CONSTRAINT `fk_athletics_drug_test_retest_drug_test_id` FOREIGN KEY (`retest_drug_test_id`) REFERENCES `education_ecm`.`athletics`.`drug_test`(`drug_test_id`);
ALTER TABLE `education_ecm`.`athletics`.`booster` ADD CONSTRAINT `fk_athletics_booster_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`booster` ADD CONSTRAINT `fk_athletics_booster_referred_by_booster_id` FOREIGN KEY (`referred_by_booster_id`) REFERENCES `education_ecm`.`athletics`.`booster`(`booster_id`);
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ADD CONSTRAINT `fk_athletics_nil_activity_sport_id` FOREIGN KEY (`sport_id`) REFERENCES `education_ecm`.`athletics`.`sport`(`sport_id`);
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ADD CONSTRAINT `fk_athletics_nil_activity_student_athlete_id` FOREIGN KEY (`student_athlete_id`) REFERENCES `education_ecm`.`athletics`.`student_athlete`(`student_athlete_id`);
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ADD CONSTRAINT `fk_athletics_nil_activity_superseded_nil_activity_id` FOREIGN KEY (`superseded_nil_activity_id`) REFERENCES `education_ecm`.`athletics`.`nil_activity`(`nil_activity_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`athletics` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`athletics` SET TAGS ('dbx_domain' = 'athletics');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` SET TAGS ('dbx_subdomain' = 'eligibility_compliance');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `athletic_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Eligibility ID');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certified By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `title_ix_case_id` SET TAGS ('dbx_business_glossary_term' = 'Title Ix Case Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `amateurism_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Amateurism Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `amateurism_certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Not Certified|Pending|Expired');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `athletic_scholarship_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletic Scholarship Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `compliance_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `compliance_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Reason');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `credit_hours_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Enrolled');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `degree_applicable_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Degree-Applicable Credits Earned');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `eligibility_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `eligibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Notes');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'Eligible|Ineligible|Conditionally Eligible|Pending Review|Suspended|Reinstated');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `eligibility_year` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Year');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `eligibility_year` SET TAGS ('dbx_value_regex' = '1st Year|2nd Year|3rd Year|4th Year|5th Year|6th Year');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `full_time_enrollment_verified` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Enrollment (FTE) Verified Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `gpa_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Eligibility Threshold Met Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `initial_eligibility_certified_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Eligibility Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `medical_hardship_season` SET TAGS ('dbx_business_glossary_term' = 'Medical Hardship Season');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `medical_hardship_season` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `medical_hardship_season` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Hardship Waiver Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_value_regex' = 'Approved|Denied|Pending|Not Requested');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `minimum_credit_hours_met` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours (CR) Compliance Met Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `next_eligibility_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Eligibility Review Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `one_time_transfer_exception_used` SET TAGS ('dbx_business_glossary_term' = 'One-Time Transfer Exception Used Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `progress_toward_degree_met` SET TAGS ('dbx_business_glossary_term' = 'Progress Toward Degree Requirement Met Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `progress_toward_degree_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Toward Degree Percentage');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `record_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Record Expiration Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `redshirt_status` SET TAGS ('dbx_business_glossary_term' = 'Redshirt Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `redshirt_status` SET TAGS ('dbx_value_regex' = 'Redshirt|Medical Redshirt|Not Redshirted|Not Applicable');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `redshirt_year` SET TAGS ('dbx_business_glossary_term' = 'Redshirt Year');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `satisfactory_academic_progress_met` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Met Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `seasons_competed` SET TAGS ('dbx_business_glossary_term' = 'Seasons of Competition Used');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `seasons_remaining` SET TAGS ('dbx_business_glossary_term' = 'Seasons of Competition Remaining');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `term_gpa` SET TAGS ('dbx_business_glossary_term' = 'Term Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Eligibility Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_value_regex' = 'Eligible|Ineligible|Pending|Not Applicable');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `transfer_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Transfer Institution Name');
ALTER TABLE `education_ecm`.`athletics`.`athletic_eligibility` ALTER COLUMN `transfer_student_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Student Flag');
ALTER TABLE `education_ecm`.`athletics`.`sport` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`athletics`.`sport` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `parent_sport_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `championship_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Championship Eligible Flag');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `competition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Competition End Date');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `competition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Competition Start Date');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `conference_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Conference Affiliation');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `contact_sport_flag` SET TAGS ('dbx_business_glossary_term' = 'Contact Sport Flag');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `division_level` SET TAGS ('dbx_value_regex' = 'division-i|division-ii|division-iii|naia|njcaa|not-applicable');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `eada_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Equity in Athletics Disclosure Act (EADA) Reporting Code');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `eada_reporting_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Sport End Date');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `gender_classification` SET TAGS ('dbx_business_glossary_term' = 'Gender Classification');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `gender_classification` SET TAGS ('dbx_value_regex' = 'men|women|mixed|coed');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `gender_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `gender_classification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `governing_body_code` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Code');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `governing_body_code` SET TAGS ('dbx_value_regex' = 'NCAA|NAIA|NJCAA|USCAA|NCCAA|NONE');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `ipeds_sport_code` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Sport Code');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `ipeds_sport_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}$');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `maximum_contests_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contests Allowed');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `maximum_roster_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Roster Size');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `maximum_scholarship_equivalencies` SET TAGS ('dbx_business_glossary_term' = 'Maximum Scholarship Equivalencies');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `minimum_roster_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Roster Size');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `ncaa_sport_classification` SET TAGS ('dbx_business_glossary_term' = 'National Collegiate Athletic Association (NCAA) Sport Classification');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `ncaa_sport_classification` SET TAGS ('dbx_value_regex' = 'championship|emerging|non-championship|not-applicable');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `practice_start_date` SET TAGS ('dbx_business_glossary_term' = 'Practice Start Date');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `primary_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Facility Name');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `revenue_producing_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Producing Flag');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `scholarship_model` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Model');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `scholarship_model` SET TAGS ('dbx_value_regex' = 'head-count|equivalency|none');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Season Type');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'fall|winter|spring|year-round|multi-season');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_code` SET TAGS ('dbx_business_glossary_term' = 'Sport Code');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_name` SET TAGS ('dbx_business_glossary_term' = 'Sport Name');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_status` SET TAGS ('dbx_business_glossary_term' = 'Sport Status');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|emerging');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_type` SET TAGS ('dbx_business_glossary_term' = 'Sport Type');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `sport_type` SET TAGS ('dbx_value_regex' = 'intercollegiate|intramural|club|recreational');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Sport Start Date');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `team_sport_flag` SET TAGS ('dbx_business_glossary_term' = 'Team Sport Flag');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `title_ix_countable_flag` SET TAGS ('dbx_business_glossary_term' = 'Title IX Countable Flag');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `varsity_level_flag` SET TAGS ('dbx_business_glossary_term' = 'Varsity Level Flag');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Sport Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`athletics`.`sport` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`athletics`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`team` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `athletic_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Home Venue Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `coach_id` SET TAGS ('dbx_business_glossary_term' = 'Head Coach Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `predecessor_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `apr_score` SET TAGS ('dbx_business_glossary_term' = 'Academic Progress Rate (APR) Score');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `assistant_coach_count` SET TAGS ('dbx_business_glossary_term' = 'Assistant Coach Count');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Pending|Non-Compliant|Under Review');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `conference_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Conference Affiliation');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `conference_code` SET TAGS ('dbx_business_glossary_term' = 'Conference Code');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `conference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `conference_losses` SET TAGS ('dbx_business_glossary_term' = 'Conference Losses');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `conference_standing` SET TAGS ('dbx_business_glossary_term' = 'Conference Standing');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `conference_wins` SET TAGS ('dbx_business_glossary_term' = 'Conference Wins');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Team Established Date');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender Classification');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|C');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `gsr_rate` SET TAGS ('dbx_business_glossary_term' = 'Graduation Success Rate (GSR) Percentage');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `home_venue_name` SET TAGS ('dbx_business_glossary_term' = 'Home Venue Name');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `losses` SET TAGS ('dbx_business_glossary_term' = 'Losses');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Team Nickname');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Team Notes');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `operating_budget` SET TAGS ('dbx_business_glossary_term' = 'Operating Budget Amount');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `operating_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `postseason_eligible` SET TAGS ('dbx_business_glossary_term' = 'Postseason Eligible Flag');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `postseason_participation` SET TAGS ('dbx_business_glossary_term' = 'Postseason Participation');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generated Amount');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `revenue_generated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `roster_limit` SET TAGS ('dbx_business_glossary_term' = 'Roster Limit');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `roster_size` SET TAGS ('dbx_business_glossary_term' = 'Roster Size');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `scholarship_limit` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Limit');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `scholarships_awarded` SET TAGS ('dbx_business_glossary_term' = 'Scholarships Awarded (Full-Time Equivalent)');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Competition Season');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'Fall|Winter|Spring|Summer');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Team Status');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Probation|Discontinued');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `ties` SET TAGS ('dbx_business_glossary_term' = 'Ties');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `title_ix_compliant` SET TAGS ('dbx_business_glossary_term' = 'Title IX Compliant Flag');
ALTER TABLE `education_ecm`.`athletics`.`team` ALTER COLUMN `wins` SET TAGS ('dbx_business_glossary_term' = 'Wins');
ALTER TABLE `education_ecm`.`athletics`.`roster` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`roster` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `roster_id` SET TAGS ('dbx_business_glossary_term' = 'Roster ID');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certified By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `prior_roster_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `add_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Add Date');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `captain_flag` SET TAGS ('dbx_business_glossary_term' = 'Captain Flag');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|not_certified|under_review');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `compliance_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Flag');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `compliance_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Reason');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `drop_date` SET TAGS ('dbx_business_glossary_term' = 'Roster Drop Date');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `eligibility_year` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Year');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `eligibility_year` SET TAGS ('dbx_value_regex' = 'freshman|sophomore|junior|senior|graduate|fifth_year');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `eligibility_years_remaining` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Years Remaining');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height in Inches');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `high_school_name` SET TAGS ('dbx_business_glossary_term' = 'High School Name');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `home_state` SET TAGS ('dbx_business_glossary_term' = 'Home State');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `home_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `hometown` SET TAGS ('dbx_business_glossary_term' = 'Hometown');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `injury_status` SET TAGS ('dbx_business_glossary_term' = 'Injury Status');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `injury_status` SET TAGS ('dbx_value_regex' = 'healthy|injured|recovering|out_for_season');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `jersey_number` SET TAGS ('dbx_business_glossary_term' = 'Jersey Number');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `jersey_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `medical_redshirt_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Redshirt Flag');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `medical_redshirt_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `medical_redshirt_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Roster Notes');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `one_time_transfer_exception_used` SET TAGS ('dbx_business_glossary_term' = 'One-Time Transfer Exception Used');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `position_name` SET TAGS ('dbx_business_glossary_term' = 'Position Name');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `practice_squad_flag` SET TAGS ('dbx_business_glossary_term' = 'Practice Squad Flag');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `previous_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Previous Institution Name');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `record_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Record Expiration Date');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `recruiting_class_year` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Class Year');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `recruiting_class_year` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `redshirt_flag` SET TAGS ('dbx_business_glossary_term' = 'Redshirt Flag');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_business_glossary_term' = 'Roster Status');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `roster_status` SET TAGS ('dbx_value_regex' = 'active|redshirt|medical_redshirt|walk_on|scholarship|non_scholarship');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `scholarship_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Percentage');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `scholarship_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `scholarship_status` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Status');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `scholarship_status` SET TAGS ('dbx_value_regex' = 'full_scholarship|partial_scholarship|walk_on|none');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `starter_flag` SET TAGS ('dbx_business_glossary_term' = 'Starter Flag');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Eligibility Status');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|waiver_granted');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `transfer_student_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Student Flag');
ALTER TABLE `education_ecm`.`athletics`.`roster` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight in Pounds');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student Athlete Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Advisor Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Research Advisor Pi Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `transfer_student_athlete_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `amateurism_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Amateurism Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `amateurism_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|denied|not_required');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `athletic_scholarship_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletic Scholarship Flag');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `compliance_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Flag');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `compliance_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Reason');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `division_level` SET TAGS ('dbx_value_regex' = 'NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `drug_testing_pool_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Testing Pool Flag');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `eligibility_clock_start_term` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Clock Start Term');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `eligibility_clock_start_term` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(10|20|30)$');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `eligibility_years_remaining` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Years Remaining');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `eligibility_years_used` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Years Used');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'full_time|part_time|not_enrolled');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height in Inches');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `high_school_name` SET TAGS ('dbx_business_glossary_term' = 'High School Name');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `hometown` SET TAGS ('dbx_business_glossary_term' = 'Hometown');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `initial_eligibility_certified_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Eligibility Certified Date');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `jersey_number` SET TAGS ('dbx_business_glossary_term' = 'Jersey Number');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `jersey_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}$');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `medical_hardship_season` SET TAGS ('dbx_business_glossary_term' = 'Medical Hardship Season');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `medical_hardship_season` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `medical_hardship_season` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Hardship Waiver Status');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|not_requested');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `nil_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Name Image Likeness (NIL) Agreement Flag');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `one_time_transfer_exception_used` SET TAGS ('dbx_business_glossary_term' = 'One-Time Transfer Exception Used');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Position');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `previous_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Previous Institution Name');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `recruitment_class_year` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Class Year');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `redshirt_status` SET TAGS ('dbx_business_glossary_term' = 'Redshirt Status');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `redshirt_status` SET TAGS ('dbx_value_regex' = 'redshirt|non_redshirt|medical_redshirt|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `redshirt_year` SET TAGS ('dbx_business_glossary_term' = 'Redshirt Year');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `redshirt_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(10|20|30)$');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `scholarship_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Percentage');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `scholarship_type` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Type');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `scholarship_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `secondary_sport_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Sport Code');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `secondary_sport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `team_roster_status` SET TAGS ('dbx_business_glossary_term' = 'Team Roster Status');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `team_roster_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|injured|graduated|withdrawn');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `total_eligibility_years_granted` SET TAGS ('dbx_business_glossary_term' = 'Total Eligibility Years Granted');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Eligibility Status');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `transfer_student_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Student Flag');
ALTER TABLE `education_ecm`.`athletics`.`student_athlete` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight in Pounds');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` SET TAGS ('dbx_subdomain' = 'eligibility_compliance');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `eligibility_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Certification ID');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `prior_eligibility_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `amateurism_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Amateurism Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `amateurism_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|pending|waiver_approved|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `athletic_scholarship_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletic Scholarship Flag');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|pending|waiver_pending|conditionally_certified|ineligible');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_term` SET TAGS ('dbx_business_glossary_term' = 'Certification Term');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_term` SET TAGS ('dbx_value_regex' = 'fall|spring|summer|full_year');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Certification Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `certifying_official_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Official Name');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `compliance_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Flag');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `compliance_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hold Reason');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `credit_hours_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Enrolled');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `degree_applicable_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Degree-Applicable Credits Earned');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `degree_applicable_credits_required` SET TAGS ('dbx_business_glossary_term' = 'Degree-Applicable Credits Required');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `division_level` SET TAGS ('dbx_value_regex' = 'NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA|other');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `eligibility_year` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Year');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `full_time_enrollment_verified` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Enrollment Verified');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `gpa_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Requirement Met');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `initial_eligibility_certified_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Eligibility Certified Date');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `initial_eligibility_clearance_source` SET TAGS ('dbx_business_glossary_term' = 'Initial Eligibility Clearance Source');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `initial_eligibility_clearance_source` SET TAGS ('dbx_value_regex' = 'NCAA_Eligibility_Center|NAIA_Eligibility_Center|institutional_review|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Hardship Waiver Status');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `medical_hardship_waiver_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `minimum_credit_hours_met` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours (CR) Met');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `minimum_credit_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours (CR) Required');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `minimum_gpa_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA) Required');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `next_eligibility_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Eligibility Review Date');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `one_time_transfer_exception_used` SET TAGS ('dbx_business_glossary_term' = 'One-Time Transfer Exception Used');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `progress_toward_degree_met` SET TAGS ('dbx_business_glossary_term' = 'Progress Toward Degree Met');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `progress_toward_degree_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Toward Degree Percentage');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `redshirt_status` SET TAGS ('dbx_business_glossary_term' = 'Redshirt Status');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `redshirt_status` SET TAGS ('dbx_value_regex' = 'redshirt|not_redshirt|medical_redshirt|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `seasons_competed` SET TAGS ('dbx_business_glossary_term' = 'Seasons Competed');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `seasons_remaining` SET TAGS ('dbx_business_glossary_term' = 'Seasons Remaining');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `term_gpa` SET TAGS ('dbx_business_glossary_term' = 'Term Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Eligibility Status');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `transfer_eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending|waiver_approved|one_time_exception_used|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `transfer_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Transfer Institution Name');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `transfer_student_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Student Flag');
ALTER TABLE `education_ecm`.`athletics`.`eligibility_certification` ALTER COLUMN `waiver_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Waiver Case Reference');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` SET TAGS ('dbx_subdomain' = 'financial_awards');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `athletic_scholarship_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Scholarship ID');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `aid_award_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `nli_id` SET TAGS ('dbx_business_glossary_term' = 'Nli Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `renewed_athletic_scholarship_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `aid_type` SET TAGS ('dbx_business_glossary_term' = 'Aid Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `aid_type` SET TAGS ('dbx_value_regex' = 'athletic|academic|need_based|merit_based|combined');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `award_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Award Approval Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `award_end_date` SET TAGS ('dbx_business_glossary_term' = 'Award End Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `award_start_date` SET TAGS ('dbx_business_glossary_term' = 'Award Start Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `cancellation_flag` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `compliance_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `counter_exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Counter Exemption Reason');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `counter_flag` SET TAGS ('dbx_business_glossary_term' = 'Counter Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `division_level` SET TAGS ('dbx_value_regex' = 'NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `equivalency_value` SET TAGS ('dbx_business_glossary_term' = 'Equivalency Value');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `fund_source` SET TAGS ('dbx_business_glossary_term' = 'Fund Source');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `multi_year_award_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Year Award Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `multi_year_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Multi-Year Duration Years');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `nli_reference_number` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) Reference Number');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `nli_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Reduction Amount');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `reduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `reduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `reduction_date` SET TAGS ('dbx_business_glossary_term' = 'Reduction Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `reduction_flag` SET TAGS ('dbx_business_glossary_term' = 'Reduction Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `reduction_reason` SET TAGS ('dbx_business_glossary_term' = 'Reduction Reason');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'renewed|not_renewed|pending_review|ineligible');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `scholarship_status` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `scholarship_status` SET TAGS ('dbx_value_regex' = 'active|renewed|reduced|cancelled|completed|pending');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `scholarship_type` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_scholarship` ALTER COLUMN `scholarship_type` SET TAGS ('dbx_value_regex' = 'full|partial|equivalency|head_count');
ALTER TABLE `education_ecm`.`athletics`.`nli` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`nli` SET TAGS ('dbx_subdomain' = 'recruitment_management');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `nli_id` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) ID');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `nli_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Coordinator ID');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `nli_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `nli_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `superseded_nli_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `academic_year_commitment` SET TAGS ('dbx_business_glossary_term' = 'Academic Year Commitment');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `compliance_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `division_level` SET TAGS ('dbx_value_regex' = 'Division I|Division II|Division III|NAIA|NJCAA');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) Document Number');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `enrollment_term` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `enrollment_term` SET TAGS ('dbx_value_regex' = 'Fall|Spring|Summer');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `initial_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Initial Eligibility Status');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `initial_eligibility_status` SET TAGS ('dbx_value_regex' = 'Certified|Pending|Not Certified');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `institutional_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Institutional Signatory Name');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `institutional_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Institutional Signatory Title');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `institutional_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Signature Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `ncaa_eligibility_center_number` SET TAGS ('dbx_business_glossary_term' = 'National Collegiate Athletic Association (NCAA) Eligibility Center ID');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `ncaa_eligibility_center_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `ncaa_eligibility_center_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `nli_status` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) Status');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `nli_status` SET TAGS ('dbx_value_regex' = 'Signed|Voided|Released|Expired|Pending');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) Notes');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `parent_guardian_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Parent or Guardian Signature Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `parent_guardian_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Parent or Guardian Signature Required');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `penalty_waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Waiver Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `penalty_waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Penalty Waiver Status');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `penalty_waiver_status` SET TAGS ('dbx_value_regex' = 'Granted|Denied|Pending|Not Applicable');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) Program Year');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `release_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Release Approval Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `release_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Release Approval Status');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `release_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Denied|Pending|Not Requested');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Release Conditions');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `release_request_date` SET TAGS ('dbx_business_glossary_term' = 'Release Request Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `release_request_reason` SET TAGS ('dbx_business_glossary_term' = 'Release Request Reason');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `scholarship_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Duration in Years');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `scholarship_offered` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Offered');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `scholarship_type` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Type');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `scholarship_type` SET TAGS ('dbx_value_regex' = 'Full|Partial|None');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Signing Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `signing_period` SET TAGS ('dbx_business_glossary_term' = 'Signing Period');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `signing_period` SET TAGS ('dbx_value_regex' = 'Early Signing Period|Regular Signing Period|Late Signing Period');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `education_ecm`.`athletics`.`nli` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `education_ecm`.`athletics`.`recruit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`recruit` SET TAGS ('dbx_subdomain' = 'recruitment_management');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `recruit_id` SET TAGS ('dbx_business_glossary_term' = 'Recruit Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `coach_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Recruiting Coach Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `transfer_recruit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `academic_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Academic Eligibility Status');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `academic_eligibility_status` SET TAGS ('dbx_value_regex' = 'not_screened|pending|cleared|at_risk|ineligible');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `act_score` SET TAGS ('dbx_business_glossary_term' = 'American College Testing (ACT) Score');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `first_contact_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Date');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `gpa` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height in Inches');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `high_school_city` SET TAGS ('dbx_business_glossary_term' = 'High School City');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `high_school_graduation_year` SET TAGS ('dbx_business_glossary_term' = 'High School Graduation Year');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `high_school_name` SET TAGS ('dbx_business_glossary_term' = 'High School Name');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `high_school_state_province` SET TAGS ('dbx_business_glossary_term' = 'High School State or Province');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `national_letter_of_intent_signed` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) Signed Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `nli_signed_date` SET TAGS ('dbx_business_glossary_term' = 'National Letter of Intent (NLI) Signed Date');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Notes');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `official_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Official Visit Count');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Position');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Prospect Address Line 1');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_city` SET TAGS ('dbx_business_glossary_term' = 'Prospect City');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_country_code` SET TAGS ('dbx_business_glossary_term' = 'Prospect Country Code');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_email` SET TAGS ('dbx_business_glossary_term' = 'Prospect Email Address');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_first_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect First Name');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_last_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Last Name');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Middle Name');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_phone` SET TAGS ('dbx_business_glossary_term' = 'Prospect Phone Number');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Prospect Postal Code');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_rating` SET TAGS ('dbx_business_glossary_term' = 'Prospect Rating');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_state_province` SET TAGS ('dbx_business_glossary_term' = 'Prospect State or Province');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `prospect_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `rating_source` SET TAGS ('dbx_business_glossary_term' = 'Rating Source');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `recruiting_class_year` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Class Year');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `recruiting_status` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Status');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `recruiting_status_date` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Status Date');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `recruiting_territory` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Territory');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `sat_score` SET TAGS ('dbx_business_glossary_term' = 'Scholastic Assessment Test (SAT) Score');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `scholarship_offer_date` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Offer Date');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `scholarship_offer_extended` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Offer Extended Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `unofficial_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Unofficial Visit Count');
ALTER TABLE `education_ecm`.`athletics`.`recruit` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight in Pounds');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` SET TAGS ('dbx_subdomain' = 'recruitment_management');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `recruiting_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Contact ID');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `tertiary_recruiting_record_created_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `tertiary_recruiting_record_created_by_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `tertiary_recruiting_record_created_by_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `followup_recruiting_contact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `compliance_flag_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag Reason');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_city` SET TAGS ('dbx_business_glossary_term' = 'Contact City');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Date');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Contact Duration (Minutes)');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_location` SET TAGS ('dbx_business_glossary_term' = 'Contact Location');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_medium` SET TAGS ('dbx_business_glossary_term' = 'Contact Medium');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_state` SET TAGS ('dbx_business_glossary_term' = 'Contact State');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_subject` SET TAGS ('dbx_business_glossary_term' = 'Contact Subject');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_time` SET TAGS ('dbx_business_glossary_term' = 'Contact Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'game|practice|workout|combine|camp|showcase');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `family_members_present` SET TAGS ('dbx_business_glossary_term' = 'Family Members Present');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `high_school_coach_present` SET TAGS ('dbx_business_glossary_term' = 'High School Coach Present Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `initiator_role` SET TAGS ('dbx_business_glossary_term' = 'Initiator Role');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `initiator_role` SET TAGS ('dbx_value_regex' = 'head_coach|assistant_coach|recruiting_coordinator|director_of_operations|volunteer_coach');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `next_contact_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Next Contact Planned Date');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `offer_extended` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'full_scholarship|partial_scholarship|preferred_walk_on|recruited_walk_on');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `official_visit_flag` SET TAGS ('dbx_business_glossary_term' = 'Official Visit Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `permissibility_review_date` SET TAGS ('dbx_business_glossary_term' = 'Permissibility Review Date');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `permissibility_status` SET TAGS ('dbx_business_glossary_term' = 'Permissibility Status');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `permissibility_status` SET TAGS ('dbx_value_regex' = 'permissible|impermissible|under_review|waived');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `prospect_family_present` SET TAGS ('dbx_business_glossary_term' = 'Prospect Family Present Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `prospect_interest_level` SET TAGS ('dbx_business_glossary_term' = 'Prospect Interest Level');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `prospect_interest_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|undecided|committed_elsewhere');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `recruiting_class_year` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Class Year');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `recruiting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Period Type');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `recruiting_period_type` SET TAGS ('dbx_value_regex' = 'contact|evaluation|quiet|dead');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `scholarship_discussed` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Discussed Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `unofficial_visit_flag` SET TAGS ('dbx_business_glossary_term' = 'Unofficial Visit Flag');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `visit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Visit End Date');
ALTER TABLE `education_ecm`.`athletics`.`recruiting_contact` ALTER COLUMN `visit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Start Date');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` SET TAGS ('dbx_subdomain' = 'recruitment_management');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `official_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Official Visit Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Host Student-Athlete Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Coordinator Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `tertiary_official_compliance_post_certified_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Post-Certified By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `tertiary_official_compliance_post_certified_by_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `tertiary_official_compliance_post_certified_by_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `rescheduled_official_visit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `academic_meeting_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Academic Meeting Included Flag');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `accompanying_parent_guardian_count` SET TAGS ('dbx_business_glossary_term' = 'Accompanying Parent or Guardian Count');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `accompanying_spouse_count` SET TAGS ('dbx_business_glossary_term' = 'Accompanying Spouse Count');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `athletic_event_attendance_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletic Event Attendance Flag');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `athletic_facilities_tour_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletic Facilities Tour Included Flag');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `campus_tour_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Campus Tour Included Flag');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_post_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Post-Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_post_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Post-Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_post_certification_status` SET TAGS ('dbx_value_regex' = 'pending|certified|non_compliant|under_review');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_pre_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Pre-Approval Date');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_pre_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Pre-Approval Status');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_pre_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|conditional');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_violation_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Description');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `compliance_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Flag');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `division_level` SET TAGS ('dbx_value_regex' = 'NCAA_D1|NCAA_D2|NCAA_D3|NAIA|NJCAA');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `entertainment_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Expense Amount');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `itinerary_description` SET TAGS ('dbx_business_glossary_term' = 'Itinerary Description');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `lodging_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Lodging Expense Amount');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `meals_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Meals Expense Amount');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `recruiting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Period Type');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `recruiting_period_type` SET TAGS ('dbx_value_regex' = 'contact|evaluation|quiet|dead');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `total_visit_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Visit Cost');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `transportation_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Transportation Expense Amount');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Visit End Date');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit End Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_notes` SET TAGS ('dbx_business_glossary_term' = 'Visit Notes');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Start Date');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Start Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `education_ecm`.`athletics`.`official_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `education_ecm`.`athletics`.`game` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`game` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_id` SET TAGS ('dbx_business_glossary_term' = 'Game Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `athletic_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Result Certified By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `rescheduled_game_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Game Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `attendance` SET TAGS ('dbx_business_glossary_term' = 'Attendance');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `away_team_score` SET TAGS ('dbx_business_glossary_term' = 'Away Team Score');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `broadcast_network` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Network');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `broadcast_type` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Type');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `broadcast_type` SET TAGS ('dbx_value_regex' = 'television|streaming|radio|none');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `conference_game_flag` SET TAGS ('dbx_business_glossary_term' = 'Conference Game Flag');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Game Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `datetime` SET TAGS ('dbx_business_glossary_term' = 'Game Date and Time');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_date` SET TAGS ('dbx_business_glossary_term' = 'Game Date');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_number` SET TAGS ('dbx_business_glossary_term' = 'Game Number');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_status` SET TAGS ('dbx_business_glossary_term' = 'Game Status');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed|forfeited');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_time` SET TAGS ('dbx_business_glossary_term' = 'Game Time');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_type` SET TAGS ('dbx_business_glossary_term' = 'Game Type');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `game_type` SET TAGS ('dbx_value_regex' = 'regular_season|conference|non_conference|exhibition|scrimmage|postseason');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `head_official_name` SET TAGS ('dbx_business_glossary_term' = 'Head Official Name');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `home_away_neutral` SET TAGS ('dbx_business_glossary_term' = 'Home Away Neutral Site Designation');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `home_away_neutral` SET TAGS ('dbx_value_regex' = 'home|away|neutral');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `home_team_score` SET TAGS ('dbx_business_glossary_term' = 'Home Team Score');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `institutional_score` SET TAGS ('dbx_business_glossary_term' = 'Institutional Score');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Game Notes');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `officials_assigned` SET TAGS ('dbx_business_glossary_term' = 'Officials Assigned');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `opponent_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Opponent Institution Code');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `opponent_name` SET TAGS ('dbx_business_glossary_term' = 'Opponent Name');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `opponent_score` SET TAGS ('dbx_business_glossary_term' = 'Opponent Score');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Game Outcome');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'win|loss|tie|no_contest|forfeit_win|forfeit_loss');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `overtime_periods` SET TAGS ('dbx_business_glossary_term' = 'Overtime Periods');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `result_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Result Certified Flag');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `result_certified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Result Certified Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `ticket_revenue` SET TAGS ('dbx_business_glossary_term' = 'Ticket Revenue');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `ticket_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `tournament_name` SET TAGS ('dbx_business_glossary_term' = 'Tournament Name');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `tournament_round` SET TAGS ('dbx_business_glossary_term' = 'Tournament Round');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Game Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `venue_state` SET TAGS ('dbx_business_glossary_term' = 'Venue State');
ALTER TABLE `education_ecm`.`athletics`.`game` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `game_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Game Participation ID');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `game_id` SET TAGS ('dbx_business_glossary_term' = 'Game ID');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `amended_game_participation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `aces` SET TAGS ('dbx_business_glossary_term' = 'Aces');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `assists` SET TAGS ('dbx_business_glossary_term' = 'Assists');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `blocks` SET TAGS ('dbx_business_glossary_term' = 'Blocks');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `competition_level` SET TAGS ('dbx_business_glossary_term' = 'Competition Level');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `competition_level` SET TAGS ('dbx_value_regex' = 'varsity|junior_varsity|club|exhibition|scrimmage');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `counts_toward_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Counts Toward Eligibility Flag');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `disciplinary_action_description` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Description');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `disciplinary_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Flag');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `ejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Ejection Flag');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `ejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Ejection Reason');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `fouls_committed` SET TAGS ('dbx_business_glossary_term' = 'Fouls Committed');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `goals_scored` SET TAGS ('dbx_business_glossary_term' = 'Goals Scored');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `hits` SET TAGS ('dbx_business_glossary_term' = 'Hits');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `injury_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `injury_flag` SET TAGS ('dbx_business_glossary_term' = 'Injury Flag');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `innings_played` SET TAGS ('dbx_business_glossary_term' = 'Innings Played');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `jersey_number` SET TAGS ('dbx_business_glossary_term' = 'Jersey Number');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `kills` SET TAGS ('dbx_business_glossary_term' = 'Kills');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `medical_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `medical_clearance_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `medical_clearance_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `minutes_played` SET TAGS ('dbx_business_glossary_term' = 'Minutes Played');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `participation_notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'played|did_not_play|injured|suspended|ineligible|excused_absence');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `points_scored` SET TAGS ('dbx_business_glossary_term' = 'Points Scored');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `position_played` SET TAGS ('dbx_business_glossary_term' = 'Position Played');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `rebounds` SET TAGS ('dbx_business_glossary_term' = 'Rebounds');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `red_cards` SET TAGS ('dbx_business_glossary_term' = 'Red Cards');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `runs_batted_in` SET TAGS ('dbx_business_glossary_term' = 'Runs Batted In (RBI)');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `saves` SET TAGS ('dbx_business_glossary_term' = 'Saves');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'fall|winter|spring|summer');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `sets_played` SET TAGS ('dbx_business_glossary_term' = 'Sets Played');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `starter_flag` SET TAGS ('dbx_business_glossary_term' = 'Starter Flag');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `strikeouts` SET TAGS ('dbx_business_glossary_term' = 'Strikeouts');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `touchdowns` SET TAGS ('dbx_business_glossary_term' = 'Touchdowns');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `yards_gained` SET TAGS ('dbx_business_glossary_term' = 'Yards Gained');
ALTER TABLE `education_ecm`.`athletics`.`game_participation` ALTER COLUMN `yellow_cards` SET TAGS ('dbx_business_glossary_term' = 'Yellow Cards');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_session_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Session Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `athletic_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Facility Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certified By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `coach_id` SET TAGS ('dbx_business_glossary_term' = 'Head Coach Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `makeup_practice_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `attendance_count` SET TAGS ('dbx_business_glossary_term' = 'Attendance Count');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `cara_countable_flag` SET TAGS ('dbx_business_glossary_term' = 'Countable Athletically Related Activity (CARA) Countable Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `competition_preparation_flag` SET TAGS ('dbx_business_glossary_term' = 'Competition Preparation Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `compliance_certification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `compliance_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certified Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `heat_index` SET TAGS ('dbx_business_glossary_term' = 'Heat Index');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `injury_count` SET TAGS ('dbx_business_glossary_term' = 'Injury Count');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `injury_occurred_flag` SET TAGS ('dbx_business_glossary_term' = 'Injury Occurred Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `mandatory_attendance_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Attendance Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `medical_staff_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Present Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `medical_staff_present_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `medical_staff_present_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `opponent_scouting_flag` SET TAGS ('dbx_business_glossary_term' = 'Opponent Scouting Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_date` SET TAGS ('dbx_business_glossary_term' = 'Practice Date');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_end_time` SET TAGS ('dbx_business_glossary_term' = 'Practice End Time');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_focus` SET TAGS ('dbx_business_glossary_term' = 'Practice Focus');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_intensity_level` SET TAGS ('dbx_business_glossary_term' = 'Practice Intensity Level');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_intensity_level` SET TAGS ('dbx_value_regex' = 'light|moderate|high|maximum');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_notes` SET TAGS ('dbx_business_glossary_term' = 'Practice Notes');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_session_number` SET TAGS ('dbx_business_glossary_term' = 'Practice Session Number');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_start_time` SET TAGS ('dbx_business_glossary_term' = 'Practice Start Time');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_status` SET TAGS ('dbx_business_glossary_term' = 'Practice Status');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|postponed|in_progress');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_type` SET TAGS ('dbx_business_glossary_term' = 'Practice Type');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `practice_type` SET TAGS ('dbx_value_regex' = 'team_practice|individual_workout|film_session|walk_through|conditioning|weight_training');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `scrimmage_flag` SET TAGS ('dbx_business_glossary_term' = 'Scrimmage Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `season_designation` SET TAGS ('dbx_business_glossary_term' = 'Season Designation');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `season_designation` SET TAGS ('dbx_value_regex' = 'in_season|out_of_season|preseason|postseason|off_season');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `video_recorded_flag` SET TAGS ('dbx_business_glossary_term' = 'Video Recorded Flag');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `education_ecm`.`athletics`.`practice_session` ALTER COLUMN `weekly_cara_hours_accumulated` SET TAGS ('dbx_business_glossary_term' = 'Weekly Countable Athletically Related Activity (CARA) Hours Accumulated');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `athletic_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Facility Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `clery_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Clery Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `parent_athletic_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `ada_accessible_seating_count` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accessible Seating Count');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `building_square_footage` SET TAGS ('dbx_business_glossary_term' = 'Building Square Footage');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `climate_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Climate Controlled Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `concession_stands_count` SET TAGS ('dbx_business_glossary_term' = 'Concession Stands Count');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `conference_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Conference Affiliation');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|under_renovation|decommissioned');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `home_venue_flag` SET TAGS ('dbx_business_glossary_term' = 'Home Venue Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `last_renovation_year` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Year');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `lighting_lux_level` SET TAGS ('dbx_business_glossary_term' = 'Lighting Lux Level');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `lighting_type` SET TAGS ('dbx_business_glossary_term' = 'Lighting Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `lighting_type` SET TAGS ('dbx_value_regex' = 'led|metal_halide|halogen|natural|none');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `locker_room_count` SET TAGS ('dbx_business_glossary_term' = 'Locker Room Count');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `naia_certification_status` SET TAGS ('dbx_business_glossary_term' = 'National Association of Intercollegiate Athletics (NAIA) Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `naia_certification_status` SET TAGS ('dbx_value_regex' = 'certified|provisional|not_certified|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `ncaa_certification_date` SET TAGS ('dbx_business_glossary_term' = 'National Collegiate Athletic Association (NCAA) Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `ncaa_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'National Collegiate Athletic Association (NCAA) Certification Expiration Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `ncaa_certification_status` SET TAGS ('dbx_business_glossary_term' = 'National Collegiate Athletic Association (NCAA) Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `ncaa_certification_status` SET TAGS ('dbx_value_regex' = 'certified|provisional|not_certified|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `outdoor_flag` SET TAGS ('dbx_business_glossary_term' = 'Outdoor Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `parking_spaces_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces Count');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `playing_surface_type` SET TAGS ('dbx_business_glossary_term' = 'Playing Surface Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `press_box_capacity` SET TAGS ('dbx_business_glossary_term' = 'Press Box Capacity');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `restroom_count` SET TAGS ('dbx_business_glossary_term' = 'Restroom Count');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Priority');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `scoreboard_type` SET TAGS ('dbx_business_glossary_term' = 'Scoreboard Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `scoreboard_type` SET TAGS ('dbx_value_regex' = 'led_video|led_matrix|digital|manual|none');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `seating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Seating Capacity');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `secondary_sports_served` SET TAGS ('dbx_business_glossary_term' = 'Secondary Sports Served');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `standing_capacity` SET TAGS ('dbx_business_glossary_term' = 'Standing Capacity');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `surface_dimensions_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Surface Dimensions Length (Feet)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `surface_dimensions_width_ft` SET TAGS ('dbx_business_glossary_term' = 'Surface Dimensions Width (Feet)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `training_room_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Room Available Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `video_replay_system_flag` SET TAGS ('dbx_business_glossary_term' = 'Video Replay System Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `weight_room_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Weight Room Available Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_facility` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `facility_event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Event Booking Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `athletic_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Facility Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `rescheduled_facility_event_booking_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_business_glossary_term' = 'Booking Reference Number');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `booking_number` SET TAGS ('dbx_value_regex' = '^BK-[0-9]{8}$');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'requested|confirmed|in_progress|completed|cancelled|no_show');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `broadcast_flag` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Event Flag');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `catering_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Catering Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `conference_game_flag` SET TAGS ('dbx_business_glossary_term' = 'Conference Game Flag');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'not_checked|no_conflict|conflict_detected|conflict_resolved');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Event Duration in Hours');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `equipment_needs` SET TAGS ('dbx_business_glossary_term' = 'Equipment Needs Description');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance Count');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `external_rental_flag` SET TAGS ('dbx_business_glossary_term' = 'External Rental Flag');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `home_away_indicator` SET TAGS ('dbx_business_glossary_term' = 'Home or Away Indicator');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `home_away_indicator` SET TAGS ('dbx_value_regex' = 'home|away|neutral');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `opponent_name` SET TAGS ('dbx_business_glossary_term' = 'Opponent Team Name');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `parking_allocation_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Allocation Count');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `postseason_flag` SET TAGS ('dbx_business_glossary_term' = 'Postseason Event Flag');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `rental_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Revenue Amount');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact Email Address');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact Name');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Requesting Contact Phone Number');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `requesting_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Organization Name');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `security_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `setup_requirements` SET TAGS ('dbx_business_glossary_term' = 'Setup Requirements Description');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `education_ecm`.`athletics`.`facility_event_booking` ALTER COLUMN `ticketed_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Ticketed Event Flag');
ALTER TABLE `education_ecm`.`athletics`.`coach` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`coach` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `coach_id` SET TAGS ('dbx_business_glossary_term' = 'Coach Identifier');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Salary Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Identifier');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `supervising_coach_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `alma_mater` SET TAGS ('dbx_business_glossary_term' = 'Alma Mater');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|expired');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `bio_url` SET TAGS ('dbx_business_glossary_term' = 'Biography URL (Uniform Resource Locator)');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `cara_supervision_authorized` SET TAGS ('dbx_business_glossary_term' = 'CARA (Countable Athletically Related Activities) Supervision Authorized');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `coaching_role` SET TAGS ('dbx_business_glossary_term' = 'Coaching Role');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `coaching_specialization` SET TAGS ('dbx_business_glossary_term' = 'Coaching Specialization');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `compliance_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `compliance_training_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Status');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `compliance_training_status` SET TAGS ('dbx_value_regex' = 'completed|pending|expired');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `countable_coach_flag` SET TAGS ('dbx_business_glossary_term' = 'Countable Coach Flag');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated|retired');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|volunteer|graduate_assistant|seasonal');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `ncaa_certification_date` SET TAGS ('dbx_business_glossary_term' = 'NCAA (National Collegiate Athletic Association) Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `ncaa_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'NCAA (National Collegiate Athletic Association) Certification Expiration Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `ncaa_certification_status` SET TAGS ('dbx_business_glossary_term' = 'NCAA (National Collegiate Athletic Association) Certification Status');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `ncaa_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|not_required');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Photo URL (Uniform Resource Locator)');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `recruiting_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Authorization Level');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `recruiting_authorization_level` SET TAGS ('dbx_value_regex' = 'full|limited|none');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `safesport_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'SafeSport Training Completion Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `safesport_training_status` SET TAGS ('dbx_business_glossary_term' = 'SafeSport Training Status');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `safesport_training_status` SET TAGS ('dbx_value_regex' = 'completed|pending|expired|not_required');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `secondary_sport_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Sport Code');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`athletics`.`coach` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` SET TAGS ('dbx_subdomain' = 'financial_awards');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `athletic_award_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Award Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Nominated By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `tertiary_athletic_last_updated_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `tertiary_athletic_last_updated_by_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `tertiary_athletic_last_updated_by_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `superseded_athletic_award_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Award Certificate Issued Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_description` SET TAGS ('dbx_business_glossary_term' = 'Award Description');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_level` SET TAGS ('dbx_business_glossary_term' = 'Award Level');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_level` SET TAGS ('dbx_value_regex' = 'institutional|conference|regional|national|international');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_name` SET TAGS ('dbx_business_glossary_term' = 'Award Name');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_notes` SET TAGS ('dbx_business_glossary_term' = 'Award Notes');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'pending|awarded|revoked|declined');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_trophy_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Award Trophy Issued Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `awarding_body` SET TAGS ('dbx_business_glossary_term' = 'Awarding Body');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `benefit_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Description');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `compliance_report_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Report Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `compliance_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reportable Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `conference_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Conference Affiliation');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `current_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `public_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `public_announcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Announcement Flag');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'individual|team');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `record_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Record Expiration Date');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `scholarship_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Currency Code');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `scholarship_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `scholarship_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Value Amount');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `scholarship_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `scholarship_value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'fall|winter|spring|summer');
ALTER TABLE `education_ecm`.`athletics`.`athletic_award` ALTER COLUMN `selection_criteria` SET TAGS ('dbx_business_glossary_term' = 'Selection Criteria');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` SET TAGS ('dbx_subdomain' = 'eligibility_compliance');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `compliance_waiver_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Waiver Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `appealed_compliance_waiver_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Outcome');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|remanded');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `appeal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `athletic_director_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletic Director (AD) Approval Flag');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `compliance_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Name');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `conference_code` SET TAGS ('dbx_business_glossary_term' = 'Conference Code');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Decision Date');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Waiver Decision Outcome');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|partially_approved|conditional_approval');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Waiver Decision Rationale');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `eligibility_impact` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Impact Description');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `eligibility_year_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Year Adjustment');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `expected_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Decision Date');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `governing_body` SET TAGS ('dbx_value_regex' = 'NCAA|NAIA|NJCAA|conference');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `governing_body_division` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Division Level');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `head_coach_endorsement_flag` SET TAGS ('dbx_business_glossary_term' = 'Head Coach Endorsement Flag');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `immediate_eligibility_granted` SET TAGS ('dbx_business_glossary_term' = 'Immediate Eligibility Granted Flag');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `institutional_position` SET TAGS ('dbx_business_glossary_term' = 'Institutional Position Statement');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Waiver Priority Level');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|expedited|emergency');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Athletic Season');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'fall|winter|spring|summer');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `seasons_restored` SET TAGS ('dbx_business_glossary_term' = 'Seasons of Competition Restored');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Submission Date');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `supporting_documentation_flag` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Submitted Flag');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `waiver_notes` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Notes');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `waiver_number` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Number');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `waiver_request_summary` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Summary');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Request Status');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `waiver_type` SET TAGS ('dbx_business_glossary_term' = 'Waiver Type Classification');
ALTER TABLE `education_ecm`.`athletics`.`compliance_waiver` ALTER COLUMN `waiver_type` SET TAGS ('dbx_value_regex' = 'eligibility|hardship|transfer|medical|recruiting|amateurism');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` SET TAGS ('dbx_subdomain' = 'eligibility_compliance');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `secondary_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Secondary Violation Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `related_violation_secondary_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Related Violation Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Restitution Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `secondary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Involved Staff Member Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `secondary_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `secondary_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `related_secondary_violation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `bylaw_citation` SET TAGS ('dbx_business_glossary_term' = 'Bylaw or Rule Citation');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `case_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `corrective_action_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Implementation Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Discovery Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `division_level` SET TAGS ('dbx_business_glossary_term' = 'Division Level');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `division_level` SET TAGS ('dbx_value_regex' = 'Division I|Division II|Division III|NAIA');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `governing_body` SET TAGS ('dbx_value_regex' = 'NCAA|NAIA|conference');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `governing_body_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Notification Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `involved_party_type` SET TAGS ('dbx_business_glossary_term' = 'Involved Party Type');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `penalty_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `penalty_imposed` SET TAGS ('dbx_business_glossary_term' = 'Penalty Imposed');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `repeat_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Violation Flag');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `restitution_amount` SET TAGS ('dbx_business_glossary_term' = 'Restitution Amount');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `restitution_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Restitution Completion Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `restitution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Restitution Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `self_report_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Report Submission Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `self_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Reported Flag');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Occurrence Date');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `violation_number` SET TAGS ('dbx_business_glossary_term' = 'Violation Case Number');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Case Status');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `violation_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|resolved|closed|pending_review');
ALTER TABLE `education_ecm`.`athletics`.`secondary_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type Classification');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` SET TAGS ('dbx_subdomain' = 'eligibility_compliance');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `eada_report_id` SET TAGS ('dbx_business_glossary_term' = 'Equity in Athletics Disclosure Act (EADA) Report ID');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Institution ID');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `amended_eada_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_email` SET TAGS ('dbx_business_glossary_term' = 'Athletics Director Email');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_name` SET TAGS ('dbx_business_glossary_term' = 'Athletics Director Name');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_phone` SET TAGS ('dbx_business_glossary_term' = 'Athletics Director Phone');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `athletics_director_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Certified By Name');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `certified_by_title` SET TAGS ('dbx_business_glossary_term' = 'Certified By Title');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `coeducational_athletically_related_student_aid` SET TAGS ('dbx_business_glossary_term' = 'Coeducational Athletically Related Student Aid');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `coeducational_operating_expenses` SET TAGS ('dbx_business_glossary_term' = 'Coeducational Operating Expenses');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `coeducational_participants` SET TAGS ('dbx_business_glossary_term' = 'Coeducational Participants');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `coeducational_recruiting_expenses` SET TAGS ('dbx_business_glossary_term' = 'Coeducational Recruiting Expenses');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `coeducational_revenues` SET TAGS ('dbx_business_glossary_term' = 'Coeducational Revenues');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_assistant_coach_salaries_total` SET TAGS ('dbx_business_glossary_term' = 'Mens Assistant Coach Salaries Total');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_assistant_coach_salaries_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_athletically_related_student_aid` SET TAGS ('dbx_business_glossary_term' = 'Mens Athletically Related Student Aid');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_head_coach_salaries_total` SET TAGS ('dbx_business_glossary_term' = 'Mens Head Coach Salaries Total');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_head_coach_salaries_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_operating_expenses` SET TAGS ('dbx_business_glossary_term' = 'Mens Operating Expenses');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_recruiting_expenses` SET TAGS ('dbx_business_glossary_term' = 'Mens Recruiting Expenses');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `mens_total_revenues` SET TAGS ('dbx_business_glossary_term' = 'Mens Total Revenues');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Report Preparer Email');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Report Preparer Name');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_phone` SET TAGS ('dbx_business_glossary_term' = 'Report Preparer Phone');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `report_preparer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended|locked');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_athletics_expenses` SET TAGS ('dbx_business_glossary_term' = 'Total Athletics Expenses');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_athletics_revenues` SET TAGS ('dbx_business_glossary_term' = 'Total Athletics Revenues');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_female_assistant_coaches` SET TAGS ('dbx_business_glossary_term' = 'Total Female Assistant Coaches');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_female_head_coaches` SET TAGS ('dbx_business_glossary_term' = 'Total Female Head Coaches');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_female_participants` SET TAGS ('dbx_business_glossary_term' = 'Total Female Participants');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_male_assistant_coaches` SET TAGS ('dbx_business_glossary_term' = 'Total Male Assistant Coaches');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_male_head_coaches` SET TAGS ('dbx_business_glossary_term' = 'Total Male Head Coaches');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `total_male_participants` SET TAGS ('dbx_business_glossary_term' = 'Total Male Participants');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_assistant_coach_salaries_total` SET TAGS ('dbx_business_glossary_term' = 'Womens Assistant Coach Salaries Total');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_assistant_coach_salaries_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_athletically_related_student_aid` SET TAGS ('dbx_business_glossary_term' = 'Womens Athletically Related Student Aid');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_head_coach_salaries_total` SET TAGS ('dbx_business_glossary_term' = 'Womens Head Coach Salaries Total');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_head_coach_salaries_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_operating_expenses` SET TAGS ('dbx_business_glossary_term' = 'Womens Operating Expenses');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_recruiting_expenses` SET TAGS ('dbx_business_glossary_term' = 'Womens Recruiting Expenses');
ALTER TABLE `education_ecm`.`athletics`.`eada_report` ALTER COLUMN `womens_total_revenues` SET TAGS ('dbx_business_glossary_term' = 'Womens Total Revenues');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` SET TAGS ('dbx_subdomain' = 'team_operations');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `sports_medicine_case_id` SET TAGS ('dbx_business_glossary_term' = 'Sports Medicine Case ID');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Treating Athletic Trainer ID');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `quaternary_sports_record_updated_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `quaternary_sports_record_updated_by_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `quaternary_sports_record_updated_by_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Irb Protocol Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `tertiary_sports_cleared_by_physician_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cleared By Physician ID');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `tertiary_sports_cleared_by_physician_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `related_sports_medicine_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `body_part` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `body_part` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `body_side` SET TAGS ('dbx_business_glossary_term' = 'Body Side');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `body_side` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|central|not_applicable');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `body_side` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Sports Medicine Case Number');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}$');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Date');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_treatment|cleared|closed|chronic_management');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `concussion_protocol_flag` SET TAGS ('dbx_business_glossary_term' = 'Concussion Protocol Flag');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `concussion_protocol_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD-10)');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `estimated_recovery_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Recovery Days');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `estimated_recovery_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_category` SET TAGS ('dbx_business_glossary_term' = 'Injury Category');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_date` SET TAGS ('dbx_business_glossary_term' = 'Injury Date');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_time` SET TAGS ('dbx_business_glossary_term' = 'Injury Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_time` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `injury_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `insurance_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Status');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `insurance_claim_status` SET TAGS ('dbx_value_regex' = 'not_filed|pending|approved|denied|paid|closed');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `insurance_claim_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `mechanism_of_injury` SET TAGS ('dbx_business_glossary_term' = 'Mechanism of Injury');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `mechanism_of_injury` SET TAGS ('dbx_value_regex' = 'game|practice|conditioning|weight_training|non_athletic|unknown');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `mechanism_of_injury` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Date');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Status');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_value_regex' = 'not_cleared|cleared_with_restrictions|fully_cleared|pending_evaluation');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_redshirt_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Redshirt Applied Flag');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_redshirt_applied_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_redshirt_applied_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_redshirt_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Redshirt Eligible Flag');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_redshirt_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `medical_redshirt_eligible_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `physician_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Physician Referral Date');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `physician_referral_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `physician_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Physician Referral Flag');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `physician_referral_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `reportable_injury_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable Injury Flag');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `return_to_play_protocol` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Play (RTP) Protocol');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `return_to_play_protocol` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `return_to_play_stage` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Play (RTP) Stage');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `return_to_play_stage` SET TAGS ('dbx_value_regex' = 'initial_rest|light_activity|sport_specific|non_contact_practice|full_contact_practice|unrestricted_participation');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `return_to_play_stage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity Level');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|severe|catastrophic');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `treating_athletic_trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Treating Athletic Trainer Name');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `treating_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Treating Physician Name');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `treating_physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `treatment_plan` SET TAGS ('dbx_business_glossary_term' = 'Treatment Plan');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `treatment_plan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`sports_medicine_case` ALTER COLUMN `treatment_plan` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` SET TAGS ('dbx_subdomain' = 'eligibility_compliance');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `drug_test_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Test ID');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Notified By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Irb Protocol Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `retest_drug_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|withdrawn|dismissed');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `appeal_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `b_sample_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'B Sample Requested Flag');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `b_sample_requested_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `b_sample_requested_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `b_sample_result` SET TAGS ('dbx_business_glossary_term' = 'B Sample Result');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `b_sample_result` SET TAGS ('dbx_value_regex' = 'confirmed|not_confirmed|not_requested|pending');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `b_sample_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `b_sample_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Number');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `collection_site_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Code');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `concentration_level` SET TAGS ('dbx_business_glossary_term' = 'Concentration Level');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `concentration_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `concentration_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `games_missed` SET TAGS ('dbx_business_glossary_term' = 'Games Missed');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `games_missed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `games_missed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `notification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `notification_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|certified_mail|other');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `positive_substance_name` SET TAGS ('dbx_business_glossary_term' = 'Positive Substance Name');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `positive_substance_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `positive_substance_name` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `result_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Result Reported Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `sanction_imposed` SET TAGS ('dbx_business_glossary_term' = 'Sanction Imposed');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `sanction_imposed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `sanction_imposed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `specimen_code` SET TAGS ('dbx_business_glossary_term' = 'Specimen ID');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `specimen_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'urine|blood|saliva|hair');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `substance_class` SET TAGS ('dbx_business_glossary_term' = 'Substance Class');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `substance_class` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `substance_class` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `substances_tested` SET TAGS ('dbx_business_glossary_term' = 'Substances Tested');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|dilute|invalid|refused|pending');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_time` SET TAGS ('dbx_business_glossary_term' = 'Test Time');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'random|reasonable_suspicion|championship|post_season|pre_season|follow_up');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `testing_laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory Name');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `testing_program` SET TAGS ('dbx_business_glossary_term' = 'Testing Program');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `testing_program` SET TAGS ('dbx_value_regex' = 'NCAA|conference|institutional|NAIA|other');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `therapeutic_use_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Use Exemption (TUE) Flag');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `therapeutic_use_exemption_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `therapeutic_use_exemption_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Exceeded Flag');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `threshold_exceeded_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `threshold_exceeded_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `tue_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Use Exemption (TUE) Approval Date');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `tue_approval_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`drug_test` ALTER COLUMN `tue_approval_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`athletics`.`booster` SET TAGS ('dbx_subdomain' = 'financial_awards');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `booster_id` SET TAGS ('dbx_business_glossary_term' = 'Booster Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Compliance Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `third_party_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Contract Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `referred_by_booster_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `alumni_flag` SET TAGS ('dbx_business_glossary_term' = 'Alumni Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `booster_status` SET TAGS ('dbx_business_glossary_term' = 'Booster Status');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `booster_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deceased|restricted');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `booster_type` SET TAGS ('dbx_business_glossary_term' = 'Booster Type Classification');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `booster_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|foundation|organization|alumni_association|booster_club');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Booster Classification Date');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `club_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Booster Club Member Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `compliance_briefing_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Briefing Completed Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `compliance_briefing_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Briefing Completion Date');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `compliance_briefing_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Briefing Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `compliance_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Count');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `compliance_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `compliance_restriction_details` SET TAGS ('dbx_business_glossary_term' = 'Compliance Restriction Details');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `compliance_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Restriction Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `corporate_sponsor_flag` SET TAGS ('dbx_business_glossary_term' = 'Corporate Sponsor Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `donor_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `former_student_athlete_flag` SET TAGS ('dbx_business_glossary_term' = 'Former Student-Athlete Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_first_name` SET TAGS ('dbx_business_glossary_term' = 'Individual Booster First Name');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_last_name` SET TAGS ('dbx_business_glossary_term' = 'Individual Booster Last Name');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Individual Booster Middle Name');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `individual_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `involvement_type` SET TAGS ('dbx_business_glossary_term' = 'Involvement Type');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `involvement_type` SET TAGS ('dbx_value_regex' = 'donor|volunteer|ticket_holder|sponsor|board_member|multiple');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `last_compliance_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Incident Date');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `last_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Contribution Amount');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `last_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `last_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `last_contribution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contribution Date');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `next_compliance_briefing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Briefing Due Date');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Booster Notes');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization or Corporate Booster Name');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `season_ticket_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Season Ticket Holder Flag');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `secondary_sport_codes` SET TAGS ('dbx_business_glossary_term' = 'Secondary Sport Codes');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `total_lifetime_contributions` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Contributions');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `total_lifetime_contributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `total_lifetime_contributions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`booster` ALTER COLUMN `volunteer_flag` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` SET TAGS ('dbx_subdomain' = 'financial_awards');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `nil_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Name, Image, and Likeness (NIL) Activity ID');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Staff ID');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `sport_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student-Athlete ID');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `superseded_nil_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `activity_number` SET TAGS ('dbx_business_glossary_term' = 'NIL Activity Number');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'active|completed|cancelled|suspended|terminated');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'NIL Activity Type');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'cash|goods|services|equity|mixed|other');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `conflict_of_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `conflict_of_interest_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Notes');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `disclosure_method` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Method');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `disclosure_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|paper_form|verbal|other');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `estimated_compensation_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Compensation Value');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `estimated_compensation_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `estimated_compensation_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `institutional_marks_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Marks Approval Status');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `institutional_marks_approval_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|denied');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `institutional_marks_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Marks Used Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `institutional_review_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Status');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `institutional_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|approved|flagged|rejected|under_investigation');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `ncaa_nil_policy_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'NCAA NIL Policy Compliance Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `ncaa_policy_version` SET TAGS ('dbx_business_glossary_term' = 'NCAA Policy Version');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `pay_for_play_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay for Play Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `quid_pro_quo_flag` SET TAGS ('dbx_business_glossary_term' = 'Quid Pro Quo Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `state_nil_law_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'State NIL Law Compliance Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `state_nil_law_reference` SET TAGS ('dbx_business_glossary_term' = 'State NIL Law Reference');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `tax_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Required Flag');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `third_party_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Entity Name');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `third_party_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`athletics`.`nil_activity` ALTER COLUMN `third_party_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Entity Type');
