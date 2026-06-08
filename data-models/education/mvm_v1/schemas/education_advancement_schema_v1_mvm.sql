-- Schema for Domain: advancement | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:13:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`advancement` COMMENT 'Administers the complete post-graduation relationship lifecycle including alumni identity, engagement history, career outcomes, fundraising campaigns, donor management, gift processing, pledge tracking, prospect research, endowment stewardship, volunteer activities, and alumni events. Manages major gifts, annual giving, planned giving, and alumni relations as an integrated function.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumnus` (
    `alumnus_id` BIGINT COMMENT 'Unique identifier for the alumnus record. Primary key for the alumnus entity. This is the system-generated surrogate key that uniquely identifies each individual who has graduated from or attended the institution.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Alumni segmentation, reunion planning, program-specific fundraising appeals, and IPEDS alumni outcome reporting all require linking alumni to their graduating academic program. Higher-ed advancement o',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Alumni profile stores primary degree CIP for segmentation, STEM alumni tracking, and targeted solicitation campaigns. Proper FK enables accurate STEM designation queries for NSF alumni surveys and OPT',
    `degree_conferral_id` BIGINT COMMENT 'Foreign key linking to student.degree_conferral. Business justification: Alumni records are created from degree conferral events. Advancement staff use this link for alumni segmentation by degree level/major, stewardship reporting, and reunion class assignment. A higher-ed',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Alumni segmentation by graduating college/department drives targeted fundraising campaigns, reunion planning, and IPEDS alumni reporting. Higher-ed advancement offices routinely segment alumni by acad',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Reunion planning and cohort giving reports require linking alumni to their graduation term record (census date, commencement date, term type). graduation_term_code is a denormalized plain attribute; r',
    `profile_id` BIGINT COMMENT 'Cross-reference to the original student identifier from the Student Information System (SIS). Links the alumnus record back to their student record for historical academic data retrieval. This is the business key that was assigned during enrollment.',
    `alternate_email` STRING COMMENT 'A secondary email address for the alumnus. Used as a backup contact method when the primary email is undeliverable or for work vs personal email segmentation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `alumni_status` STRING COMMENT 'The current engagement status of the alumnus record. Active indicates the alumnus is reachable and engaged; Deceased indicates confirmed death; Lost indicates contact information is outdated; Do Not Contact indicates explicit request to cease communications.. Valid values are `Active|Inactive|Deceased|Lost|Do Not Contact|Opted Out`',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'The cumulative GPA earned by the alumnus at the time of graduation. Used for honors society identification, scholarship donor reporting, and academic achievement recognition. Typically on a 4.0 scale.',
    `current_employer` STRING COMMENT 'The name of the organization where the alumnus is currently employed. Used for career outcomes tracking, employer engagement, and prospect research for major gift fundraising.',
    `current_job_title` STRING COMMENT 'The current professional title or position of the alumnus. Used for career outcomes reporting, networking events, and wealth screening for fundraising.',
    `date_of_birth` DATE COMMENT 'The date of birth of the alumnus. Used for age-based segmentation, reunion year calculations, and identity verification. Format: yyyy-MM-dd.',
    `deceased_date` DATE COMMENT 'The date on which the alumnus passed away, if known. Used for memorial records and in memoriam recognition. Format: yyyy-MM-dd.',
    `deceased_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the alumnus is deceased. True if confirmed deceased, False otherwise. Used to suppress communications and update alumni records appropriately.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Boolean flag indicating the alumnus has requested no contact from the institution. True if do-not-contact request is active, False otherwise. Suppresses all outreach including fundraising, events, and communications.',
    `do_not_solicit_flag` BOOLEAN COMMENT 'Boolean flag indicating the alumnus has requested no fundraising solicitations. True if do-not-solicit request is active, False otherwise. Suppresses fundraising appeals but allows other alumni communications.',
    `ethnicity` STRING COMMENT 'The self-reported ethnicity or race of the alumnus. Used for diversity reporting, IPEDS compliance, and targeted outreach to underrepresented alumni populations. [ENUM-REF-CANDIDATE: Hispanic or Latino|American Indian or Alaska Native|Asian|Black or African American|Native Hawaiian or Other Pacific Islander|White|Two or More Races|Unknown — promote to reference product]',
    `ferpa_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the alumnus has provided consent to share directory information under FERPA regulations. True if consent given, False if restricted. Controls publication of alumni information in directories and public listings.',
    `gender` STRING COMMENT 'The self-identified gender of the alumnus. Used for demographic reporting and diversity analytics. Supports inclusive gender identity options.. Valid values are `Male|Female|Non-Binary|Prefer Not to Disclose|Other|Unknown`',
    `legal_first_name` STRING COMMENT 'The legal first name of the alumnus as recorded in official institutional records and on the degree conferred. Used for official transcripts, diplomas, and legal correspondence.',
    `legal_last_name` STRING COMMENT 'The legal last name (surname/family name) of the alumnus as recorded in official institutional records and on the degree conferred. Used for official transcripts, diplomas, and legal correspondence.',
    `legal_middle_name` STRING COMMENT 'The legal middle name or initial of the alumnus as recorded in official institutional records. May be null if no middle name was provided.',
    `linkedin_profile_url` STRING COMMENT 'The URL to the alumnus LinkedIn profile. Used for professional networking, career outcomes verification, and prospect research.',
    `maiden_name` STRING COMMENT 'The birth surname of the alumnus, typically used to track alumni who have changed their last name after graduation. Critical for alumni search and reunion planning.',
    `mailing_address_line1` STRING COMMENT 'The first line of the alumnus mailing address (street number and name, apartment/unit number). Used for direct mail campaigns, alumni magazine distribution, and event invitations.',
    `mailing_address_line2` STRING COMMENT 'The second line of the alumnus mailing address (additional address details such as suite, building, or care-of information). Optional field.',
    `mailing_city` STRING COMMENT 'The city of the alumnus mailing address. Used for geographic segmentation of alumni populations and regional event planning.',
    `mailing_country_code` STRING COMMENT 'The three-letter ISO country code of the alumnus mailing address. Used for international alumni segmentation and global engagement strategies.. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'The postal code or ZIP code of the alumnus mailing address. Used for mail sorting, geographic analysis, and targeted regional campaigns.',
    `mailing_state_province` STRING COMMENT 'The state or province of the alumnus mailing address. Used for regional alumni chapter organization and state-level reporting.',
    `mobile_phone` STRING COMMENT 'The mobile/cell phone number of the alumnus. Used for SMS communications, text-to-give campaigns, and mobile-first engagement strategies.',
    `preferred_first_name` STRING COMMENT 'The first name the alumnus prefers to be called in informal communications, alumni events, and publications. May differ from legal name. Used for personalized engagement and respecting individual identity preferences.',
    `preferred_last_name` STRING COMMENT 'The last name the alumnus prefers to be used in informal communications and alumni engagement activities. Often reflects name changes due to marriage or personal preference.',
    `primary_email` STRING COMMENT 'The primary email address for contacting the alumnus. Used for alumni communications, event invitations, fundraising campaigns, and institutional updates. This is the preferred digital contact channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The primary telephone number for contacting the alumnus. Used for phonathon campaigns, event reminders, and urgent communications.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this alumnus record was first created in the system. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_source` STRING COMMENT 'The system or process that created or last significantly updated this alumnus record. Used for data lineage tracking and data quality auditing. [ENUM-REF-CANDIDATE: SIS|CRM|Manual Entry|Data Import|Alumni Survey|Third Party|Merge — 7 candidates stripped; promote to reference product]',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this alumnus record was last modified. Used for audit trail, data freshness assessment, and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_alumnus PRIMARY KEY(`alumnus_id`)
) COMMENT 'Master record for every individual who has graduated from or attended the institution. Serves as the SSOT for alumni identity, capturing legal name, preferred name, graduation year, degree(s) earned, primary major/CIP code, student ID cross-reference, demographic data, FERPA consent flags, deceased indicator, and record source. This is the foundational entity for all alumni relations, advancement, and career services activities. Supports IPEDS graduation rate reporting and alumni participation rate calculations.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumni_contact` (
    `alumni_contact_id` BIGINT COMMENT 'Unique identifier for the alumni contact record. Primary key.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus this contact record belongs to. Links to the alumni master record.',
    `address_verification_status` STRING COMMENT 'Indicates whether the address has been verified through USPS or other address validation services.. Valid values are `verified|unverified|invalid|pending`',
    `contact_frequency_preference` STRING COMMENT 'How often the alumnus wishes to receive communications from the institution.. Valid values are `weekly|monthly|quarterly|annual`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this contact record was first created in the system.',
    `do_not_call_flag` BOOLEAN COMMENT 'Indicates the alumnus has opted out of telephone communications.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Global flag indicating the alumnus has requested no contact from the institution across all channels.',
    `do_not_email_flag` BOOLEAN COMMENT 'Indicates the alumnus has opted out of email communications.',
    `do_not_mail_flag` BOOLEAN COMMENT 'Indicates the alumnus has opted out of postal mail communications.',
    `do_not_sms_flag` BOOLEAN COMMENT 'Indicates the alumnus has opted out of SMS text message communications.',
    `email_consent_source` STRING COMMENT 'The channel or method through which email consent was obtained.. Valid values are `web_form|phone|event|paper_form|imported`',
    `email_consent_timestamp` TIMESTAMP COMMENT 'The date and time when the alumnus provided consent for email communications.',
    `home_address_line1` STRING COMMENT 'The first line of the alumnus home mailing address (street number and name).',
    `home_address_line2` STRING COMMENT 'The second line of the alumnus home mailing address (apartment, suite, unit number).',
    `home_city` STRING COMMENT 'The city of the alumnus home address.',
    `home_country_code` STRING COMMENT 'The three-letter ISO country code of the alumnus home address.. Valid values are `^[A-Z]{3}$`',
    `home_phone` STRING COMMENT 'The alumnus home telephone number for voice contact.',
    `home_postal_code` STRING COMMENT 'The postal or ZIP code of the alumnus home address.',
    `home_state_province` STRING COMMENT 'The state or province of the alumnus home address.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this contact record was last updated.',
    `linkedin_profile_url` STRING COMMENT 'The URL to the alumnus LinkedIn profile for professional networking and career tracking.',
    `mailing_address_line1` STRING COMMENT 'The first line of the alumnus preferred mailing address if different from home address.',
    `mailing_address_line2` STRING COMMENT 'The second line of the alumnus preferred mailing address.',
    `mailing_city` STRING COMMENT 'The city of the alumnus preferred mailing address.',
    `mailing_country_code` STRING COMMENT 'The three-letter ISO country code of the alumnus preferred mailing address.. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'The postal or ZIP code of the alumnus preferred mailing address.',
    `mailing_state_province` STRING COMMENT 'The state or province of the alumnus preferred mailing address.',
    `mobile_phone` STRING COMMENT 'The alumnus mobile telephone number for voice and SMS contact.',
    `ncoa_update_date` DATE COMMENT 'The date when the address was last updated through the USPS National Change of Address database.',
    `opt_in_career_news` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive career-related news and opportunities.',
    `opt_in_event_invitations` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive invitations to alumni events.',
    `opt_in_fundraising_appeals` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive fundraising and donation appeals.',
    `opt_in_institutional_news` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive general institutional news and updates.',
    `phone_consent_source` STRING COMMENT 'The channel or method through which phone consent was obtained.. Valid values are `web_form|phone|event|paper_form|imported`',
    `phone_consent_timestamp` TIMESTAMP COMMENT 'The date and time when the alumnus provided consent for phone communications.',
    `preferred_contact_method` STRING COMMENT 'The alumnus preferred method for receiving communications from the institution.. Valid values are `email|postal_mail|phone|sms`',
    `preferred_language` STRING COMMENT 'The alumnus preferred language for communications using ISO 639-2 three-letter codes (ENG=English, SPA=Spanish, FRA=French, DEU=German, ZHO=Chinese, JPN=Japanese).. Valid values are `ENG|SPA|FRA|DEU|ZHO|JPN`',
    `preferred_name` STRING COMMENT 'The name the alumnus prefers to be addressed by in communications and events.',
    `primary_email` STRING COMMENT 'The primary email address for alumni communications. Used as the default contact channel for digital outreach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `seasonal_address_line1` STRING COMMENT 'The first line of a seasonal or temporary address (e.g., winter residence).',
    `seasonal_address_line2` STRING COMMENT 'The second line of a seasonal or temporary address.',
    `seasonal_city` STRING COMMENT 'The city of the seasonal or temporary address.',
    `seasonal_country_code` STRING COMMENT 'The three-letter ISO country code of the seasonal or temporary address.. Valid values are `^[A-Z]{3}$`',
    `seasonal_end_date` DATE COMMENT 'The date when the seasonal address becomes inactive each year.',
    `seasonal_postal_code` STRING COMMENT 'The postal or ZIP code of the seasonal or temporary address.',
    `seasonal_start_date` DATE COMMENT 'The date when the seasonal address becomes active each year.',
    `seasonal_state_province` STRING COMMENT 'The state or province of the seasonal or temporary address.',
    `work_phone` STRING COMMENT 'The alumnus work or business telephone number.',
    CONSTRAINT pk_alumni_contact PRIMARY KEY(`alumni_contact_id`)
) COMMENT 'Stores all contact information and explicit communication preferences for each alumnus. Contact data includes addresses (home, mailing, seasonal, international), email addresses (personal, professional), phone numbers, LinkedIn profile URL, address verification status, and NCOA update dates. Communication preferences include preferred language, preferred contact method (email, postal mail, phone, SMS), frequency preferences (weekly, monthly, annual), topic opt-ins (career news, event invitations, fundraising appeals, institutional news), global do-not-contact flag, opt-in/opt-out flags per channel, consent timestamps, and consent source (web form, phone, event). Supports multi-address scenarios, FERPA-compliant outreach, CAN-SPAM/GDPR compliance, and international alumni communications.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`engagement_activity` (
    `engagement_activity_id` BIGINT COMMENT 'Unique identifier for each engagement activity record. Primary key for the engagement activity entity.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who participated in this engagement activity. Links to the alumni master record.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising or engagement campaign associated with this activity. Nullable for activities not tied to a specific campaign.',
    `campus_event_id` BIGINT COMMENT 'Foreign key linking to studentlife.campus_event. Business justification: Advancement officers record alumni engagement activities when alumni attend campus events (not just alumni-specific events). Linking engagement_activity to campus_event enables moves management scorin',
    `event_id` BIGINT COMMENT 'Reference to the specific event record if this activity represents attendance at or participation in a scheduled event. Nullable for non-event activities.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Engagement activities occur in specific fiscal periods for donor relations tracking and reporting. Creating engagement_activity.fiscal_period_id to link to finance.fiscal_period for period-based repor',
    `major_gift_proposal_id` BIGINT COMMENT 'Foreign key linking to advancement.major_gift_proposal. Business justification: Engagement activities are the transactional record of cultivation and stewardship interactions. The engagement_activity table has an explicit attribute is_major_gift_related (BOOLEAN) indicating that ',
    `employee_id` BIGINT COMMENT 'Reference to the advancement or alumni relations staff member who recorded or facilitated this engagement activity. Tracks ownership and accountability for relationship management.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Engagement activities center on research (lab tours, research presentations, symposia). Advancement tracks which research awards are featured in donor cultivation for major gift proposals and stewards',
    `activity_date` DATE COMMENT 'The date on which the engagement activity occurred. Represents the primary business event timestamp for this interaction.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the engagement activity. Tracks whether the activity was completed as planned, cancelled, or is still pending.. Valid values are `completed|scheduled|cancelled|no_show|pending`',
    `activity_timestamp` TIMESTAMP COMMENT 'Precise date and time when the engagement activity took place. Provides granular timing for activities requiring time-of-day tracking.',
    `activity_type` STRING COMMENT 'Classification of the engagement activity. Defines the nature of the interaction between the alumnus and the institution. [ENUM-REF-CANDIDATE: event_attendance|volunteer_service|mentorship_session|career_fair_participation|webinar|campus_visit|phone_call|email_response|social_media_interaction|donation_solicitation|survey_response|networking_event|reunion_attendance|board_meeting|committee_participation — promote to reference product]. Valid values are `event_attendance|volunteer_service|mentorship_session|career_fair_participation|webinar|campus_visit`',
    `attendee_count` STRING COMMENT 'Number of individuals who participated in the engagement activity. Applicable to group activities such as events, webinars, or meetings. Null for one-on-one interactions.',
    `channel` STRING COMMENT 'The communication or interaction channel through which the engagement activity was conducted. Distinguishes the medium of interaction from the activity type.. Valid values are `in_person|phone|email|web|mobile_app|social_media`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred by the institution to conduct this engagement activity. Includes event costs, travel expenses, materials, or other direct expenditures. Used for ROI analysis and budget tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this engagement activity record was first created in the system. Audit field for data governance and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount. Supports multi-currency tracking for institutions with international operations.. Valid values are `^[A-Z]{3}$`',
    `duration_minutes` STRING COMMENT 'Length of the engagement activity in minutes. Applicable to activities with measurable duration such as phone calls, meetings, mentorship sessions, or events.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Quantitative score assigned to this activity representing its contribution to the alumnus overall engagement level. Used for engagement scoring models and prospect qualification. Scale and methodology defined by institutional advancement strategy.',
    `follow_up_date` DATE COMMENT 'Target date by which follow-up action should be completed. Nullable if no follow-up is required or scheduled.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether this engagement activity requires a follow-up action or contact. Used to drive task management and ensure relationship continuity.',
    `is_major_gift_related` BOOLEAN COMMENT 'Indicates whether this engagement activity is part of a major gift cultivation, solicitation, or stewardship effort. Used to prioritize high-value donor relationship activities.',
    `is_volunteer_activity` BOOLEAN COMMENT 'Indicates whether this activity represents volunteer service by the alumnus on behalf of the institution. Used to track volunteer engagement separately from other interaction types.',
    `location` STRING COMMENT 'Physical or virtual location where the engagement activity took place. May include campus building names, city names, or virtual platform identifiers.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this engagement activity record. Audit field for accountability and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this engagement activity record was last updated. Audit field for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Detailed free-text notes documenting the content, discussion points, outcomes, and any follow-up actions from the engagement activity. Critical for relationship continuity and institutional memory.',
    `outcome` STRING COMMENT 'Result or outcome of the engagement activity. Captures whether the activity achieved its intended purpose and what next steps may be required.. Valid values are `successful|unsuccessful|follow_up_required|no_contact|declined`',
    `priority_level` STRING COMMENT 'Priority classification assigned to this engagement activity based on strategic importance, donor capacity, or relationship stage. Guides staff time allocation and follow-up urgency.. Valid values are `high|medium|low`',
    `response_code` STRING COMMENT 'Standardized code capturing the alumnus response or reaction to the engagement activity. Used for tracking sentiment and engagement quality across interactions.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this engagement activity record in the source operational system. Enables traceability and reconciliation with source systems.',
    `source_system` STRING COMMENT 'Name of the operational system from which this engagement activity record originated. Examples include Blackbaud Raisers Edge, Slate CRM, or manual entry systems.',
    `subject` STRING COMMENT 'Brief subject line or title summarizing the purpose or topic of the engagement activity. Provides quick context for the interaction.',
    `created_by` STRING COMMENT 'User identifier or system account that created this engagement activity record. Audit field for accountability and data quality tracking.',
    CONSTRAINT pk_engagement_activity PRIMARY KEY(`engagement_activity_id`)
) COMMENT 'Transactional record of every meaningful interaction between an alumnus and the institution. Captures activity type (event attendance, volunteer service, mentorship session, career fair participation, webinar, campus visit, phone call, email response, social media interaction), activity date, channel, associated program or campaign, staff member who recorded the interaction, engagement score contribution, and notes. This is the primary engagement history ledger for alumni relations and advancement qualification.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumni_event` (
    `alumni_event_id` BIGINT COMMENT 'Unique identifier for the alumni event record. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Alumni events are frequently program-specific (Engineering alumni reunion, Business school networking night). Linking events to academic programs enables program-level engagement reporting, targeted i',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to advancement.campaign. Business justification: Alumni events frequently serve as fundraising vehicles tied to specific campaigns. The alumni_event product has explicit fundraising attributes: is_fundraising_event (BOOLEAN) and fundraising_goal_amo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Alumni events are often hosted by academic units/cost centers for budget and expense tracking. Creating alumni_event.cost_center_id to link to finance.cost_center for event cost allocation.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Alumni events occur in specific fiscal periods for budget and expense tracking. Creating alumni_event.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Alumni events are frequently organized by specific colleges or departments (e.g., Engineering Alumni Night, Business School Reunion). Linking to org_unit enables alumni engagement reporting by academi',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Alumni events held on campus require a specific room assignment for capacity planning, AV setup, and space utilization reporting. alumni_event has venue_name/address for off-campus but no FK for on-ca',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Alumni reunion events and homecoming events are scheduled around specific academic terms (commencement, fall/spring terms). Advancement staff align event planning with term calendars for venue booking',
    `actual_attendance` STRING COMMENT 'Final count of attendees who participated in the event. Populated after event completion for ROI (Return on Investment) analysis and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first created in the system. Used for audit trail and event planning timeline analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts (e.g., USD, CAD, GBP). Supports international events with local pricing.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Format of event delivery. In-person requires physical venue; virtual is online-only; hybrid offers both options simultaneously.. Valid values are `in_person|virtual|hybrid`',
    `early_registration_deadline` DATE COMMENT 'Deadline for early-bird registration pricing. Used to incentivize advance commitments and improve planning accuracy.',
    `event_code` STRING COMMENT 'Externally-known unique business identifier for the event, used in communications and registration systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `event_description` STRING COMMENT 'Detailed narrative description of the event, including agenda highlights, speakers, activities, and value proposition. Used in marketing materials and registration pages.',
    `event_end_date` DATE COMMENT 'The date the event concludes. For single-day events, this equals the start date. For multi-day events (e.g., reunion weekend), this is the final day.',
    `event_end_time` TIMESTAMP COMMENT 'Precise timestamp when the event programming concludes, including time zone information.',
    `event_name` STRING COMMENT 'Full descriptive name of the alumni event as displayed in marketing materials and communications.',
    `event_start_date` DATE COMMENT 'The date the event begins. For single-day events, this is the event date. For multi-day events, this is the first day.',
    `event_start_time` TIMESTAMP COMMENT 'Precise timestamp when the event programming begins, including time zone information for accurate scheduling across regions.',
    `event_status` STRING COMMENT 'Current lifecycle status of the event. Controls visibility, registration availability, and reporting inclusion. [ENUM-REF-CANDIDATE: draft|planning|registration_open|registration_closed|in_progress|completed|cancelled|postponed — 8 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the alumni event by its primary purpose and format. Determines programming, budget allocation, and success metrics. [ENUM-REF-CANDIDATE: homecoming|reunion|regional_chapter|career_networking|commencement|donor_recognition|athletic_event|volunteer_service|lecture_series|gala|other — 11 candidates stripped; promote to reference product]',
    `fundraising_goal_amount` DECIMAL(18,2) COMMENT 'Target dollar amount to be raised through the event, if applicable. Null for non-fundraising events.',
    `is_fundraising_event` BOOLEAN COMMENT 'Indicates whether the event has a fundraising component or goal (e.g., gala, donor recognition dinner). True triggers gift tracking and campaign attribution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record. Tracks changes throughout the event lifecycle.',
    `organizing_staff_email` STRING COMMENT 'Email address of the primary event organizer. Used for attendee inquiries and internal coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `organizing_staff_name` STRING COMMENT 'Name of the primary advancement staff member responsible for planning and executing the event.',
    `organizing_staff_phone` STRING COMMENT 'Phone number of the primary event organizer for urgent inquiries and day-of-event coordination.',
    `registration_capacity` STRING COMMENT 'Maximum number of attendees the event can accommodate, based on venue capacity or virtual platform limits. Null indicates unlimited capacity.',
    `registration_close_date` DATE COMMENT 'Date when registration closes. After this date, no new registrations are accepted unless manually overridden.',
    `registration_open_date` DATE COMMENT 'Date when registration becomes available to alumni. Controls visibility in event portals and communications.',
    `requires_rsvp` BOOLEAN COMMENT 'Indicates whether attendees must formally register or RSVP to attend. True for capacity-limited or catered events; false for open-access events.',
    `reunion_class_year` STRING COMMENT 'Graduation year for reunion events (e.g., 1995, 2010). Null for non-reunion events. Used to calculate milestone reunions (5th, 10th, 25th, 50th).',
    `target_attendance` STRING COMMENT 'Planned or goal number of attendees for the event. Used for budgeting, venue selection, and success measurement.',
    `venue_address_line1` STRING COMMENT 'Primary street address of the event venue. Business-confidential organizational contact data.',
    `venue_address_line2` STRING COMMENT 'Secondary address information for the venue (suite, floor, building name). Business-confidential organizational contact data.',
    `venue_city` STRING COMMENT 'City where the event venue is located. Used for regional event analysis and alumni engagement mapping.',
    `venue_country_code` STRING COMMENT 'Three-letter ISO country code for the venue location (e.g., USA, CAN, GBR). Supports international alumni engagement.. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'Name of the physical location or facility hosting the event (e.g., Alumni Center, Grand Ballroom, Stadium Club). Null for virtual-only events.',
    `venue_postal_code` STRING COMMENT 'Postal or ZIP code for the venue. Business-confidential organizational contact data.',
    `venue_state_province` STRING COMMENT 'Two-letter state or province code for the venue location (e.g., CA, NY, ON).. Valid values are `^[A-Z]{2}$`',
    `virtual_meeting_url` STRING COMMENT 'Web link for accessing the virtual event. Confidential to prevent unauthorized access. Null for in-person-only events.',
    `virtual_platform` STRING COMMENT 'Name of the online platform used for virtual or hybrid events (e.g., Zoom, Microsoft Teams, Hopin). Null for in-person-only events.',
    CONSTRAINT pk_alumni_event PRIMARY KEY(`alumni_event_id`)
) COMMENT 'Master record for alumni-focused events organized or co-sponsored by the institution. Captures event name, type (homecoming, reunion, regional chapter event, career networking, commencement, donor recognition, athletic event), event date(s), location (venue name, city, state, country), virtual/hybrid flag, registration capacity, registration open/close dates, event cost, associated affinity group or college, and organizing staff. Distinct from the instruction domains class schedule — this covers alumni relations programming.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumni_event_registration` (
    `alumni_event_registration_id` BIGINT COMMENT 'Unique identifier for the alumni event registration record. Primary key for this entity.',
    `alumni_event_id` BIGINT COMMENT 'Identifier of the alumni event for which the registration is made. Links to the alumni event master record.',
    `alumnus_id` BIGINT COMMENT 'Identifier of the alumnus registering for the event. Links to the alumni master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who entered the registration on behalf of the alumnus. Null if self-registered by the alumnus.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Alumni event registrations occur in specific fiscal periods for event revenue and attendance tracking. Creating alumni_event_registration.fiscal_period_id to link to finance.fiscal_period for period-b',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Alumni event registration payments processed through the central billing system should reference billing.payment for reconciliation and audit. Current denormalized payment columns (payment_amount, pay',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Alumni event registration fees are commonly billed to a participants institutional student/alumni account in higher-ed. This link enables the billing system to post event charges directly to the acco',
    `accessibility_requirements` STRING COMMENT 'Free-text description of any accessibility accommodations needed by the alumnus (e.g., wheelchair access, sign language interpreter, hearing assistance). Ensures ADA (Americans with Disabilities Act) compliance.',
    `cancellation_date` DATE COMMENT 'Date when the registration was cancelled by the alumnus or staff. Null if the registration was not cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation or categorized reason for registration cancellation (e.g., schedule conflict, illness, duplicate registration). Used for event planning improvement.',
    `check_in_method` STRING COMMENT 'Method or channel used to check in the alumnus at the event (e.g., mobile app, QR code scan, manual staff entry).. Valid values are `mobile_app|qr_code|staff_manual|kiosk|badge_scan`',
    `check_in_timestamp` TIMESTAMP COMMENT 'Precise date and time when the alumnus checked in at the event venue. Null if the alumnus did not attend. Used for attendance verification and engagement scoring.',
    `confirmation_email_sent_flag` BOOLEAN COMMENT 'Indicates whether a registration confirmation email was successfully sent to the alumnus.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this registration record was first created in the database. Used for audit trail and data lineage.',
    `dietary_requirements` STRING COMMENT 'Free-text description of any dietary restrictions, allergies, or preferences specified by the alumnus (e.g., vegetarian, vegan, gluten-free, nut allergy). Used for catering planning.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Calculated score representing the level of engagement demonstrated by this registration (e.g., based on early registration, attendance, participation). Used for alumni relationship scoring and predictive analytics.',
    `guest_count` STRING COMMENT 'Number of additional guests accompanying the alumnus to the event. Used for capacity planning and catering.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this registration record was last updated. Used for audit trail and change tracking.',
    `name_badge_printed_flag` BOOLEAN COMMENT 'Indicates whether a name badge has been printed for the alumnus for this event.',
    `notes` STRING COMMENT 'Internal staff notes or comments about the registration, not visible to the alumnus. Used for operational coordination and special handling instructions.',
    `referral_source` STRING COMMENT 'How the alumnus learned about the event (e.g., email invitation, social media, word of mouth, website). Used for marketing effectiveness analysis.',
    `registration_campaign_code` STRING COMMENT 'Marketing campaign code or tracking identifier associated with the registration source. Enables ROI (Return on Investment) analysis of promotional efforts.',
    `registration_date` DATE COMMENT 'Date when the alumnus registered for the event. Represents the business event date of registration submission.',
    `registration_number` STRING COMMENT 'Externally visible unique registration confirmation number provided to the alumnus upon successful registration.',
    `registration_source` STRING COMMENT 'Channel or interface through which the registration was submitted. Enables analysis of registration channel effectiveness.. Valid values are `online_portal|staff_entry|mobile_app|phone|email|walk_in`',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration. Tracks progression from initial registration through event attendance or cancellation.. Valid values are `registered|waitlisted|cancelled|attended|no-show|pending`',
    `registration_timestamp` TIMESTAMP COMMENT 'Precise date and time when the registration was submitted, including time zone information. Used for audit and sequence analysis.',
    `reminder_email_sent_flag` BOOLEAN COMMENT 'Indicates whether a pre-event reminder email was successfully sent to the alumnus.',
    `special_requests` STRING COMMENT 'Additional notes or special requests submitted by the alumnus during registration (e.g., seating preferences, program participation).',
    `table_assignment` STRING COMMENT 'Assigned table number or seating location for the alumnus at the event. Used for seated events with assigned seating.',
    `ticket_type` STRING COMMENT 'Type or category of ticket selected by the alumnus (e.g., general admission, VIP, early bird, complimentary, student rate). Determines pricing and access level.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether the alumnus is designated as a VIP (Very Important Person) for this event, requiring special handling or recognition.',
    `waitlist_added_date` DATE COMMENT 'Date when the alumnus was added to the event waitlist. Null if never waitlisted.',
    `waitlist_position` STRING COMMENT 'Numeric position of the alumnus on the event waitlist if registration status is waitlisted. Null if not on waitlist.',
    CONSTRAINT pk_alumni_event_registration PRIMARY KEY(`alumni_event_registration_id`)
) COMMENT 'Transactional record capturing each alumnuss registration for an alumni event. Includes registration date, registration status (registered, waitlisted, cancelled, attended, no-show), ticket type, payment amount, payment status, dietary or accessibility requirements, guest count, check-in timestamp, and registration source (online portal, staff entry, mobile app). Enables attendance tracking, event ROI analysis, and engagement scoring.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`donor` (
    `donor_id` BIGINT COMMENT 'Unique identifier for the donor record. Primary key for the donor entity. Serves as the system-of-record identifier in Blackbaud Raisers Edge.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Donors who are alumni require direct linkage for comprehensive constituent relationship management, lifetime giving analysis, and integrated advancement operations. Enables single-view reporting acros',
    `constituent_id` BIGINT COMMENT 'External constituent identifier from Blackbaud Raisers Edge. Business-facing identifier used for donor lookup and correspondence.',
    `employee_id` BIGINT COMMENT 'Identifier of the advancement officer or gift officer assigned to manage the relationship with this donor. Used for portfolio management and accountability.',
    `primary_spouse_donor_id` BIGINT COMMENT 'Identifier of the donors spouse if the spouse is also a constituent in the database. Used for household giving analysis and joint recognition.',
    `address_verification_status` STRING COMMENT 'Status of address validation through USPS NCOA or other verification services. Indicates deliverability and accuracy of mailing address.. Valid values are `verified|unverified|invalid|ncoa_updated`',
    `alternate_email` STRING COMMENT 'Secondary email address for donor contact. Used when primary email is unavailable or for specific communication preferences.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `consecutive_giving_years` STRING COMMENT 'Number of consecutive fiscal years the donor has made a gift. Used to identify loyal donors for recognition societies and retention strategies.',
    `constituent_classification` STRING COMMENT 'CASE-compliant constituent classification indicating primary relationship to the institution. Used for segmentation and reporting to CASE and VSE surveys.. Valid values are `alumnus|parent|friend|faculty|staff|corporation`',
    `deceased_date` DATE COMMENT 'Date of death for deceased donors. Used for memorial gift processing and estate settlement tracking.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the donor is deceased. When true, suppresses all solicitation communications and triggers estate/planned giving protocols.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates the donor has requested no contact from the institution. When true, suppresses all solicitation, marketing, and non-essential communications. Overrides all other communication preferences.',
    `do_not_solicit_flag` BOOLEAN COMMENT 'Indicates the donor has requested no fundraising solicitations. When true, suppresses appeals and solicitation calls but allows stewardship and informational communications.',
    `donor_status` STRING COMMENT 'Current lifecycle status of the donor record. Active donors have given within the last 24 months. Lapsed donors have not given recently but have historical giving. Deceased and do-not-contact statuses suppress solicitation.. Valid values are `active|lapsed|deceased|inactive|do_not_contact`',
    `donor_type` STRING COMMENT 'Classification of the donor entity type. Determines applicable tax treatment, reporting requirements, and stewardship protocols.. Valid values are `individual|corporation|foundation|organization|government|trust`',
    `fiscal_year_giving_total` DECIMAL(18,2) COMMENT 'Total giving from this donor in the current fiscal year. Used for annual fund reporting and donor recognition society qualification.',
    `giving_capacity_rating` STRING COMMENT 'Prospect research rating indicating the donors estimated philanthropic capacity. Used for major gift identification and portfolio assignment. Proprietary rating scale from wealth screening vendor.',
    `legal_name` STRING COMMENT 'Full legal name of the donor as it appears on official documents, tax receipts, and gift agreements. For individuals: full legal name. For organizations: registered legal entity name.',
    `mobile_phone` STRING COMMENT 'Mobile telephone number for SMS communications and mobile-first outreach. Subject to TCPA consent requirements for text messaging.',
    `ncoa_update_date` DATE COMMENT 'Date when the donors address was last updated through USPS National Change of Address processing. Used to maintain address accuracy and reduce returned mail.',
    `portfolio_assignment` STRING COMMENT 'Fundraising portfolio to which the donor is assigned. Indicates which advancement officer or team is responsible for donor cultivation and solicitation.. Valid values are `major_gifts|principal_gifts|planned_giving|annual_giving|corporate_foundation|unassigned`',
    `preferred_name` STRING COMMENT 'Name the donor prefers to be addressed by in communications, event materials, and donor recognition. May differ from legal name.',
    `primary_address_line1` STRING COMMENT 'First line of the donors primary mailing address (street number and name). Used for gift acknowledgments, tax receipts, and solicitation mailings.',
    `primary_address_line2` STRING COMMENT 'Second line of the donors primary mailing address (apartment, suite, unit, building). Optional field for additional address details.',
    `primary_affiliation` STRING COMMENT 'Primary institutional affiliation of the donor (e.g., College of Engineering, School of Business, Athletics). Used for targeted appeals and recognition.',
    `primary_city` STRING COMMENT 'City name for the donors primary mailing address. Used for geographic segmentation and regional campaign targeting.',
    `primary_country_code` STRING COMMENT 'Three-letter ISO country code for the donors primary mailing address. Used for international donor segmentation and tax compliance.. Valid values are `^[A-Z]{3}$`',
    `primary_email` STRING COMMENT 'Primary email address for donor communications, gift acknowledgments, and electronic correspondence. Subject to CAN-SPAM compliance.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary telephone contact number for the donor. Used for solicitation calls, event invitations, and stewardship outreach.',
    `primary_postal_code` STRING COMMENT 'Postal or ZIP code for the donors primary mailing address. Used for address validation, NCOA processing, and geographic analysis.',
    `primary_state_province` STRING COMMENT 'State or province code for the donors primary mailing address. Two-letter abbreviation for US states or equivalent for international addresses.',
    `record_created_date` TIMESTAMP COMMENT 'Timestamp when this donor record was first created in the system. Used for data lineage and audit trail.',
    `record_last_modified_date` TIMESTAMP COMMENT 'Timestamp when this donor record was last updated. Used for data quality monitoring and change tracking.',
    `salutation` STRING COMMENT 'Formal salutation used in correspondence and communications (e.g., Dr., Mr., Mrs., Ms., The Honorable). Respects donor preferences for formal address.',
    `stewardship_tier` STRING COMMENT 'Donor stewardship level based on cumulative giving, giving capacity, and engagement. Determines frequency and type of personalized outreach and recognition.. Valid values are `platinum|gold|silver|bronze|standard`',
    `wealth_screening_date` DATE COMMENT 'Date when the donors wealth and capacity rating was last updated through electronic screening or prospect research. Used to ensure rating currency.',
    `work_phone` STRING COMMENT 'Business telephone number for corporate donors or individual donors who prefer work contact. Includes extension if applicable.',
    CONSTRAINT pk_donor PRIMARY KEY(`donor_id`)
) COMMENT 'Master record for all donors and prospective donors (individuals, corporations, foundations, and organizations). SSOT for donor identity, biographical data, contact information, addresses, communication preferences, giving capacity ratings, relationship classification, and inter-constituent relationships (spouse, employer, parent-child). Sourced from Blackbaud Raisers Edge. Tracks donor type, primary affiliation, CASE-compliant constituent classification, stewardship tier, and portfolio assignment to gift officers. Includes contact details (addresses, phones, emails with type and preference flags) and relationship graph data previously modeled separately.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`gift` (
    `gift_id` BIGINT COMMENT 'Unique identifier for the gift transaction. Primary key for the gift record.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the institutional fund or account to which the gift is designated. Links to the fund master record for tracking gift allocation and endowment stewardship.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to advancement.appeal. Business justification: gift has a STRING attribute appeal_code that should be normalized to a FK relationship. Gifts are often made in response to specific fundraising appeals. The appeal entity already exists in the doma',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Gift deposit reconciliation: gifts are deposited into specific institutional bank accounts (lockbox, wire, operating). Treasury and advancement reconcile gift deposits daily by bank account. gift has ',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this gift. Used for campaign performance tracking and goal attainment reporting.',
    `donor_id` BIGINT COMMENT 'Reference to the alumnus or external donor who made the gift. Links to the donor master record in the advancement system.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Gifts are recorded in specific fiscal periods for revenue recognition and financial reporting. Creating gift.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member, volunteer, or alumnus who solicited or facilitated the gift. Used for crediting and performance tracking.',
    `gift_officer_employee_id` BIGINT COMMENT 'Reference to the advancement staff member responsible for managing the donor relationship and processing this gift. Used for portfolio management and performance tracking.',
    `pledge_id` BIGINT COMMENT 'Reference to the pledge record if this gift is a payment toward a multi-year pledge commitment. Links to the pledge master record for tracking fulfillment.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Gifts often designated for specific research awards or labs. Critical for stewardship reporting, impact metrics, and fund accounting. Advancement must track which gifts support which research for dono',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Gifts post to specific revenue ledger accounts for GL accounting. Creating gift.revenue_ledger_account_id to link to finance.ledger_account for revenue recognition and financial reporting.',
    `scholarship_id` BIGINT COMMENT 'Foreign key linking to aid.scholarship. Business justification: Gifts are frequently designated to specific named scholarships; advancement offices must track gift-to-scholarship designation for gift restriction compliance, IPEDS reporting, and donor stewardship. ',
    `acknowledgment_date` DATE COMMENT 'The date the acknowledgment letter or receipt was sent to the donor. Required for IRS substantiation requirements and donor stewardship tracking.',
    `acknowledgment_status` STRING COMMENT 'Indicates whether a thank-you acknowledgment letter or receipt has been sent to the donor. Critical for donor stewardship and IRS compliance.. Valid values are `pending|sent|not_required`',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the gift in the transaction currency. For in-kind gifts, this represents the fair market value as appraised or declared.',
    `amount_usd` DECIMAL(18,2) COMMENT 'The gift amount converted to US Dollars using the exchange rate on the gift date. Used for consolidated reporting and CASE VSE compliance.',
    `anonymous_flag` BOOLEAN COMMENT 'Indicates whether the donor has requested anonymity for this gift. When true, donor identity is not disclosed in public recognition or reporting.',
    `case_reportable_flag` BOOLEAN COMMENT 'Indicates whether this gift qualifies for inclusion in CASE Voluntary Support of Education (VSE) reporting. Based on CASE counting standards and gift type.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this gift record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the gift amount (e.g., USD, EUR, GBP). Required for international gift processing and multi-currency reporting.. Valid values are `^[A-Z]{3}$`',
    `deposit_date` DATE COMMENT 'The date the gift funds were deposited into the institutional bank account. Used for cash flow tracking and financial reconciliation.',
    `first_gift_date` DATE COMMENT 'Date of the donors first recorded gift to the institution. Used to calculate donor tenure and loyalty metrics. [Moved from donor: This attribute represents the date of the first gift transaction, which is a derived value from the gift association. It should be calculated from gift.gift_date rather than stored redundantly on the donor record.]',
    `gift_date` DATE COMMENT 'The date the gift was received or postmarked, representing the official transaction date for accounting and reporting purposes. This is the primary business event timestamp for the gift.',
    `gift_number` STRING COMMENT 'Business identifier for the gift transaction, typically a human-readable sequential or formatted number assigned by the advancement office for tracking and reference purposes.',
    `gift_source` STRING COMMENT 'Classification of the donor type: individual, corporation, foundation, organization, or other entity. Used for CASE VSE reporting and donor segmentation.. Valid values are `individual|corporation|foundation|organization|other`',
    `gift_status` STRING COMMENT 'Current lifecycle status of the gift transaction indicating whether it has been received, is pending processing, or has been cancelled or adjusted.. Valid values are `received|pledged|pending|cancelled|refunded|adjusted`',
    `gift_type` STRING COMMENT 'Classification of the gift based on its nature: outright gift, pledge payment, matching gift, gift-in-kind, securities transfer, or planned giving instrument.. Valid values are `outright|pledge_payment|matching|in_kind|securities|planned`',
    `in_kind_description` STRING COMMENT 'Detailed description of the donated property, goods, or services for in-kind gifts. Required for IRS substantiation and institutional asset management.',
    `ipeds_reportable_flag` BOOLEAN COMMENT 'Indicates whether this gift must be included in IPEDS Finance Survey reporting to the U.S. Department of Education.',
    `largest_gift_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the largest single gift received from this donor. Used for major gift benchmarking and upgrade solicitation strategies. [Moved from donor: This attribute represents the amount of the largest gift transaction, which is a derived value from the gift association. It should be calculated from gift.gift_amount rather than stored redundantly on the donor record.]',
    `last_gift_date` DATE COMMENT 'Date of the donors most recent gift. Used to identify lapsed donors and calculate recency metrics for predictive modeling. [Moved from donor: This attribute represents the date of the most recent gift transaction, which is a derived value from the gift association. It should be calculated from gift.gift_date rather than stored redundantly on the donor record.]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this gift record was most recently updated. Used for audit trail, change tracking, and data synchronization.',
    `lifetime_giving_total` DECIMAL(18,2) COMMENT 'Cumulative total of all gifts received from this donor since the first gift date. Includes cash, pledges paid, and gifts-in-kind at fair market value. Excludes pledge balances. [Moved from donor: This attribute represents the cumulative sum of all gift amounts, which is a derived aggregate from the gift association. It should be calculated from SUM(gift.gift_amount) rather than stored redundantly on the donor record.]',
    `matching_gift_company_name` STRING COMMENT 'Name of the corporation or employer that may provide a matching gift for this donation. Used for matching gift claim processing.',
    `matching_gift_eligible_flag` BOOLEAN COMMENT 'Indicates whether this gift is eligible for corporate matching gift programs. Used to trigger matching gift solicitation workflows.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special instructions, or donor communications related to the gift. Used for stewardship and internal coordination.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to make the gift: cash, check, credit card, wire transfer, ACH, stock transfer, property donation, or other method. [ENUM-REF-CANDIDATE: cash|check|credit_card|wire_transfer|ach|stock|property|other — 8 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External reference number from the payment processor, bank, or credit card transaction. Used for reconciliation and audit trail.',
    `purpose` STRING COMMENT 'Free-text description of the donors intended use or purpose for the gift. Captures donor intent for restricted gifts and stewardship reporting.',
    `receipt_number` STRING COMMENT 'Unique receipt number issued to the donor for tax purposes. Required for gifts above IRS thresholds and for donor record-keeping.',
    `restriction_type` STRING COMMENT 'Classification of gift restrictions per FASB/GASB accounting standards: unrestricted, temporarily restricted, or permanently restricted (endowment).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `source_system` STRING COMMENT 'Name of the operational system from which this gift record originated (e.g., Blackbaud Raisers Edge, manual entry). Used for data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier for this gift record in the source operational system. Used for data lineage, reconciliation, and bi-directional synchronization.',
    `stock_shares` DECIMAL(18,2) COMMENT 'Number of shares transferred for securities gifts. Used in conjunction with stock price to calculate gift value.',
    `stock_symbol` STRING COMMENT 'Ticker symbol for securities gifts. Used for tracking stock transfers and calculating fair market value at the time of transfer.',
    `tax_deductible_amount` DECIMAL(18,2) COMMENT 'The portion of the gift amount that qualifies as tax-deductible under IRS regulations. May differ from gift amount for quid pro quo gifts or benefits received.',
    CONSTRAINT pk_gift PRIMARY KEY(`gift_id`)
) COMMENT 'Transactional record of every completed gift received by the institution, including outright gifts, matching gifts, gifts-in-kind, and securities transfers. Captures gift date, amount, fund designation, gift type (cash, check, credit card, wire, stock, in-kind), campaign attribution, appeal code, acknowledgment status, and receipting information. SSOT for gift history and the primary source for CASE VSE (Voluntary Support of Education) reporting and IPEDS finance reporting. Sourced from Blackbaud Raisers Edge gift module.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`pledge` (
    `pledge_id` BIGINT COMMENT 'Unique identifier for the pledge record. Primary key.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the designated fund or endowment to which the pledge is directed.',
    `appeal_id` BIGINT COMMENT 'Reference to the specific fundraising appeal or solicitation effort that resulted in this pledge.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this pledge.',
    `donor_id` BIGINT COMMENT 'Reference to the alumnus or constituent who made the pledge commitment.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member, volunteer, or alumnus who solicited this pledge.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Pledges are recorded in specific fiscal periods for receivable tracking and financial reporting. Creating pledge.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Pledges post to pledge receivable ledger accounts for GL accounting. Creating pledge.receivable_ledger_account_id to link to finance.ledger_account for receivable tracking and financial reporting.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Pledges designated for research need linkage to specific awards for fulfillment tracking, stewardship, and financial planning. Advancement tracks pledge payments against research funding commitments f',
    `scholarship_id` BIGINT COMMENT 'Foreign key linking to aid.scholarship. Business justification: Pledges are designated to specific scholarships; pledge administration requires tracking which scholarship a multi-year pledge funds for installment billing, gift restriction compliance, and scholarsh',
    `acknowledgment_date` DATE COMMENT 'The date on which the pledge acknowledgment letter or receipt was sent to the donor.',
    `acknowledgment_sent_flag` BOOLEAN COMMENT 'Indicates whether a formal acknowledgment letter or receipt has been sent to the donor for this pledge.',
    `amount` DECIMAL(18,2) COMMENT 'The total committed amount of the pledge across all installments, representing the donors full commitment.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The cumulative amount that has been paid against the pledge to date, calculated from completed installment payments.',
    `anonymous_flag` BOOLEAN COMMENT 'Indicates whether the donor has requested that this pledge remain anonymous in public recognition and reporting.',
    `balance_outstanding` DECIMAL(18,2) COMMENT 'The remaining unpaid balance on the pledge, calculated as pledge_amount minus amount_paid minus write_off_amount.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pledge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `designation` STRING COMMENT 'The specific purpose, program, or project to which the pledge is designated, such as scholarship fund, building project, or unrestricted support.',
    `final_installment_date` DATE COMMENT 'The due date for the final scheduled installment payment, representing the expected completion date of the pledge.',
    `first_installment_date` DATE COMMENT 'The due date for the first scheduled installment payment.',
    `installment_frequency` STRING COMMENT 'The recurring schedule on which pledge installments are due, such as monthly, quarterly, or annually.. Valid values are `one_time|monthly|quarterly|semi_annual|annual|custom`',
    `installments_paid` STRING COMMENT 'The count of installments that have been successfully paid to date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was most recently updated in the data platform.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The amount of the most recent installment payment received.',
    `last_payment_date` DATE COMMENT 'The date on which the most recent installment payment was received.',
    `matching_gift_eligible_flag` BOOLEAN COMMENT 'Indicates whether this pledge is eligible for corporate matching gift programs.',
    `next_installment_amount` DECIMAL(18,2) COMMENT 'The scheduled payment amount for the next upcoming installment.',
    `next_installment_date` DATE COMMENT 'The due date for the next upcoming installment payment, used for reminder workflows and aging analysis.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, donor preferences, or stewardship considerations related to the pledge.',
    `number_of_installments` STRING COMMENT 'The total number of scheduled installment payments for this pledge.',
    `payment_method` STRING COMMENT 'The preferred or default payment instrument the donor will use to fulfill pledge installments, such as check, credit card, or electronic funds transfer (EFT). [ENUM-REF-CANDIDATE: check|credit_card|eft|wire|stock|cash|payroll_deduction — 7 candidates stripped; promote to reference product]',
    `pledge_date` DATE COMMENT 'The date on which the donor formally committed to the pledge. This is the principal business event timestamp for the pledge origination.',
    `pledge_number` STRING COMMENT 'Business-facing unique identifier or reference number for the pledge, often used in donor communications and receipts.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of the pledge commitment indicating whether it is active, fulfilled, or terminated.. Valid values are `active|completed|cancelled|defaulted|written_off|pending`',
    `pledge_type` STRING COMMENT 'Classification of the pledge based on its structure and conditions, such as outright, multi-year installment, or conditional commitment.. Valid values are `outright|multi_year|conditional|matching|challenge|endowment`',
    `reminder_date` DATE COMMENT 'The date on which a payment reminder should be sent to the donor for an upcoming installment.',
    `source_system` STRING COMMENT 'The name of the operational system from which this pledge record was sourced, typically Blackbaud Raisers Edge.',
    `source_system_code` STRING COMMENT 'The unique identifier for this pledge record in the source operational system.',
    `tax_deductible_amount` DECIMAL(18,2) COMMENT 'The portion of the pledge that qualifies as a tax-deductible charitable contribution under IRS regulations.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The portion of the pledge that has been written off as uncollectible, reducing the expected receivable.',
    `write_off_date` DATE COMMENT 'The date on which the pledge or a portion thereof was written off as uncollectible.',
    `write_off_reason` STRING COMMENT 'Explanation or justification for writing off the pledge amount, such as donor financial hardship, death, or inability to contact.',
    CONSTRAINT pk_pledge PRIMARY KEY(`pledge_id`)
) COMMENT 'Record of a donors formal commitment to make a future gift, including multi-year pledge schedules with individual installment detail (due dates, scheduled amounts, payment status per installment), pledge balance, installment frequency, reminder dates, and fulfillment status. Tracks pledge origination date, total amount, amount paid to date, outstanding balance, write-off amounts, and installment-level aging. Supports pledge reminder workflows, automated installment tracking, and aging analysis. Sourced from Blackbaud Raisers Edge pledge module. Distinct from gift (completed transactions) and planned_gift (deferred/estate commitments).';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the fundraising campaign or donor recognition program. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaigns often align with academic cost centers for budget allocation and expense tracking. Creating campaign.cost_center_id to link to finance.cost_center for financial reporting and stewardship.',
    `employee_id` BIGINT COMMENT 'Staff member responsible for coordinating and managing the campaign.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Campaign fund management: comprehensive campaigns designate one or more finance funds to receive proceeds. Finance and advancement jointly track campaign-to-fund allocation for budget-to-actual report',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Campaigns span fiscal periods and are reported by period for fundraising progress tracking. Creating campaign.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Campaigns are institutional fundraising initiatives requiring org hierarchy linkage for budget ownership, gift allocation reporting, campaign performance dashboards by college/unit, and stewardship ac',
    `parent_campaign_id` BIGINT COMMENT 'Reference to the parent campaign if this is a sub-campaign within a larger comprehensive campaign hierarchy.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Fundraising campaigns require state charitable solicitation registration filings (Unified Registration Statement) in states where the institution solicits. The campaigns case_reporting_classification',
    `active_membership_count` STRING COMMENT 'Current number of active members in a recognition society. Null for fundraising campaigns.',
    `amount_raised` DECIMAL(18,2) COMMENT 'Total amount raised to date, including gifts, pledges, and planned gifts counted toward the campaign goal.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for campaign operations, marketing, events, and staffing.',
    `campaign_description` STRING COMMENT 'Detailed narrative describing the campaign purpose, objectives, and intended impact.',
    `campaign_name` STRING COMMENT 'Full name of the fundraising campaign or recognition society.',
    `campaign_number` STRING COMMENT 'Externally-known business identifier for the campaign, used in communications and reporting.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign: planning (pre-launch), quiet_phase (leadership gifts), public_phase (broad solicitation), active (ongoing), completed (goal achieved), suspended (temporarily paused), or cancelled (terminated). [ENUM-REF-CANDIDATE: planning|quiet_phase|public_phase|active|completed|suspended|cancelled — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the campaign: comprehensive (institution-wide), capital (facilities/infrastructure), annual (yearly giving), endowment (permanent funds), emergency (crisis response), or recognition_society (donor club/giving circle).. Valid values are `comprehensive|capital|annual|endowment|emergency|recognition_society`',
    `case_reporting_classification` STRING COMMENT 'CASE standard classification code for reporting purposes (e.g., comprehensive campaign, capital campaign).',
    `contact_email` STRING COMMENT 'Primary email address for campaign inquiries and donor communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for campaign office or coordinator.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this campaign (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `donor_count` STRING COMMENT 'Total number of unique donors who have contributed to this campaign.',
    `end_date` DATE COMMENT 'Planned or actual end date of the campaign. Null for ongoing recognition societies.',
    `gift_counting_rules` STRING COMMENT 'Description of which gift types are counted toward campaign totals (e.g., outright gifts, pledges, planned gifts, matching gifts).',
    `goal_amount` DECIMAL(18,2) COMMENT 'Target fundraising amount for the campaign in the specified currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was last updated.',
    `member_benefits_description` STRING COMMENT 'Description of benefits provided to members of a recognition society (e.g., event invitations, publications, naming opportunities).',
    `minimum_giving_threshold` DECIMAL(18,2) COMMENT 'Minimum cumulative or annual giving amount required for membership in a recognition society. Null for fundraising campaigns.',
    `notes` STRING COMMENT 'Additional notes, comments, or internal documentation about the campaign.',
    `phase` STRING COMMENT 'Current operational phase: planning (pre-launch), quiet (leadership solicitation), public (broad outreach), or completion (wrap-up and stewardship).. Valid values are `planning|quiet|public|completion`',
    `priority` STRING COMMENT 'Institutional priority level assigned to this campaign for resource allocation and strategic focus.. Valid values are `high|medium|low`',
    `public_launch_date` DATE COMMENT 'Date when the campaign transitioned from quiet phase to public phase and broad solicitation began.',
    `quiet_phase_goal_amount` DECIMAL(18,2) COMMENT 'Target amount to be raised during the quiet phase before public launch, typically from leadership donors.',
    `recognition_tier` STRING COMMENT 'Tier or level within a recognition society hierarchy (e.g., Bronze, Silver, Gold, Platinum). Applicable to recognition societies.',
    `start_date` DATE COMMENT 'Official start date when the campaign becomes active for gift counting and solicitation.',
    `stewardship_plan` STRING COMMENT 'Description of donor stewardship activities and recognition plans for campaign contributors.',
    `success_metrics` STRING COMMENT 'Key performance indicators and success criteria for evaluating campaign effectiveness beyond dollar goals.',
    `visibility_status` STRING COMMENT 'Controls who can view campaign information: public (all), internal (institution only), or confidential (restricted access).. Valid values are `public|internal|confidential`',
    `website_url` STRING COMMENT 'Public website URL for the campaign with information, updates, and online giving portal.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for fundraising campaigns and donor recognition programs. For campaigns: captures campaign name, type (comprehensive, capital, annual, endowment, emergency), start/end dates, goal amount, amount raised, donor count, phase, sub-campaign hierarchy, and CASE reporting classification. For recognition societies/giving clubs: captures society name, minimum giving threshold, tier, member benefits, and active membership roster. SSOT for campaign definitions and recognition program structures used across gift, pledge, and appeal records.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`advancement_fund` (
    `advancement_fund_id` BIGINT COMMENT 'Unique identifier for the advancement fund. Primary key for the fund master record.',
    `student_org_id` BIGINT COMMENT 'Foreign key linking to studentlife.student_org. Business justification: Donors establish named funds to benefit specific student organizations (e.g., endowed support for student newspaper, Greek chapter scholarship fund). Advancement stewardship reporting requires linking',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Advancement funds map to academic cost centers for stewardship reporting and budget alignment. Creating advancement_fund.cost_center_id to link to finance.cost_center for financial and operational rep',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Advancement funds are designated to support specific academic programs. Fund-to-program reporting, stewardship impact statements, and budget allocation tracking require this link. Role prefix designa',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Fund establishment and GL tracking: every advancement fund (endowment, restricted gift fund) maps to a finance fund in the GL. Controllers require this link for fund balance reporting, spending policy',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Advancement funds are reported and valued by fiscal period for financial reporting. Creating advancement_fund.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Advancement funds (endowments, scholarships, capital campaigns) map to general ledger accounts for financial tracking and reporting. This FK links advancement_fund to the finance ledger_account master',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Advancement funds are budget entities requiring org hierarchy linkage for financial accountability, NACUBO/IPEDS reporting, stewardship reporting, and institutional budget roll-ups. Owning_college_sch',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Advancement funds with ipeds_reportable_flag, nacubo_classification, and variance_reporting_required_flag trigger IRS 990 Schedule D, UPMIFA, and state AG filings. Higher-ed advancement officers expec',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: advancement_fund.facilities_support_flag indicates funds designated for specific buildings, but no FK identifies which building. Stewardship reporting and donor impact communications require linking a',
    `closure_date` DATE COMMENT 'Date the fund was permanently closed to new gifts and distributions ceased. Applicable for term endowments that have expired or funds that have been fully expended per donor intent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund record was first created in the advancement system. Used for data lineage and audit trail.',
    `current_market_value` DECIMAL(18,2) COMMENT 'Current total market value of the fund including principal, accumulated income, and investment gains/losses. Updated periodically based on investment pool valuation cycles.',
    `donor_advised_flag` BOOLEAN COMMENT 'Indicates whether the fund allows donor advisory privileges for distribution recommendations. True if donor retains advisory rights per gift agreement; false for fully institutionally-controlled funds.',
    `donor_recognition_level` STRING COMMENT 'Recognition tier or society membership associated with the fund based on gift size (e.g., Presidents Circle, Founders Society, Legacy Society). Used for donor engagement and event invitations.',
    `establishment_date` DATE COMMENT 'Date the fund was officially established and began accepting gifts. Corresponds to board approval date or execution of gift agreement.',
    `facilities_support_flag` BOOLEAN COMMENT 'Indicates whether the fund supports capital projects, building maintenance, or facility improvements. True for facilities funds; false otherwise.',
    `faculty_support_flag` BOOLEAN COMMENT 'Indicates whether the fund supports faculty positions, research, or professional development (e.g., endowed chairs, professorships, research grants). True for faculty support funds; false otherwise.',
    `first_distribution_date` DATE COMMENT 'Date of the first distribution from the fund to support its designated purpose. May differ from establishment date if fund needed to reach minimum threshold or had a waiting period.',
    `fund_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the fund in financial systems and donor communications. Used for gift designation and general ledger mapping.. Valid values are `^[A-Z0-9]{4,12}$`',
    `fund_name` STRING COMMENT 'Official name of the fund as established by donor agreement or institutional policy. Used in donor reports, gift receipts, and stewardship communications.',
    `fund_status` STRING COMMENT 'Current operational status of the fund. Active funds accept gifts and make distributions; inactive funds are temporarily not accepting gifts; closed funds are permanently closed; suspended funds are under review; pending-establishment funds are awaiting final approval or minimum threshold.. Valid values are `active|inactive|closed|suspended|pending-establishment`',
    `fund_type` STRING COMMENT 'Classification of the fund based on spending restrictions and permanence. Endowed funds maintain principal in perpetuity; expendable funds can be fully spent; restricted funds have donor-imposed purpose restrictions; unrestricted funds have no donor restrictions; quasi-endowments are board-designated; term endowments revert after a specified period.. Valid values are `endowed|expendable|restricted|unrestricted|quasi-endowment|term-endowment`',
    `gift_agreement_document_url` STRING COMMENT 'URL or file path to the executed gift agreement or memorandum of understanding that established the fund and specifies donor restrictions and institutional obligations.',
    `gift_restriction_terms` STRING COMMENT 'Detailed text of donor-imposed restrictions on fund use, including purpose restrictions, eligibility criteria for beneficiaries, geographic limitations, time restrictions, and any other conditions specified in the gift agreement.',
    `investment_pool_assignment` STRING COMMENT 'Name or identifier of the investment pool in which the fund assets are invested (e.g., Long-Term Investment Pool, Balanced Pool, Fixed Income Pool). Determines investment strategy and return profile.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund record was most recently updated. Used for change tracking and data quality monitoring.',
    `last_valuation_date` DATE COMMENT 'Date of the most recent market valuation used to update the current market value. Typically corresponds to fiscal quarter-end or year-end investment pool valuation.',
    `market_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the current market value (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `minimum_endowment_threshold` DECIMAL(18,2) COMMENT 'Minimum principal balance required to establish or maintain the fund as an endowment. Funds below this threshold may be held in a pooled fund until the minimum is reached.',
    `nacubo_classification` STRING COMMENT 'Standardized fund classification per NACUBO reporting taxonomy. Used for endowment surveys, peer benchmarking, and financial statement preparation.. Valid values are `true-endowment|term-endowment|quasi-endowment|expendable-restricted|expendable-unrestricted|annuity-life-income`',
    `notes` STRING COMMENT 'Free-text field for additional context, special handling instructions, historical background, or operational notes relevant to fund administration and stewardship.',
    `original_gift_amount` DECIMAL(18,2) COMMENT 'Total amount of the original gift(s) that established the fund, representing the historical principal. Used for UPMIFA historic dollar value calculations and endowment preservation compliance.',
    `program_support_flag` BOOLEAN COMMENT 'Indicates whether the fund supports academic programs, departmental operations, or institutional initiatives. True for program support funds; false otherwise.',
    `purpose_description` STRING COMMENT 'Detailed narrative describing the intended use of fund distributions, including eligible expenditure categories, beneficiary populations, and programmatic objectives as specified in the gift agreement or board resolution.',
    `reporting_frequency` STRING COMMENT 'Frequency of stewardship reports to be provided to donors or fund beneficiaries, as specified in the gift agreement or institutional policy.. Valid values are `annual|semi-annual|quarterly|as-requested|none`',
    `scholarship_fund_flag` BOOLEAN COMMENT 'Indicates whether the fund is designated for student financial aid (scholarships, fellowships, or awards). True for scholarship funds; false for other purposes.',
    `spending_calculation_method` STRING COMMENT 'Methodology used to calculate annual distributions. Total-return applies rate to smoothed market value; income-only distributes actual investment income; hybrid combines approaches; unit-value uses pooled fund units.. Valid values are `total-return|income-only|hybrid|unit-value`',
    `spending_policy_rate` DECIMAL(18,2) COMMENT 'Annual distribution rate applied to the fund balance to calculate available spending, typically expressed as a decimal (e.g., 0.0450 for 4.5%). May be institution-wide policy or fund-specific per donor agreement.',
    `stewardship_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the fund requires periodic stewardship reports to donors or their designees. True if donor agreement specifies reporting obligations; false otherwise.',
    `threshold_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum endowment threshold amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `underwater_status_flag` BOOLEAN COMMENT 'Indicates whether the fund current market value has fallen below the historic dollar value (original gift amount), creating an underwater endowment. True if underwater; false if market value exceeds or equals historic value. Critical for UPMIFA compliance and spending decisions.',
    `variance_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the fund requires institutional approval or board notification for expenditures that deviate from the stated purpose or exceed normal spending policy. True if variance reporting is required per gift agreement or policy; false otherwise.',
    CONSTRAINT pk_advancement_fund PRIMARY KEY(`advancement_fund_id`)
) COMMENT 'Master record for a designated fund that receives and holds gift revenue for a specific institutional purpose. Captures fund name, code, type (endowed, expendable, restricted, unrestricted, quasi-endowment), purpose description, college/unit designation, minimum endowment threshold, fund status, NACUBO classification, and gift restriction terms (purpose restrictions, eligibility criteria, donor-imposed conditions, reporting requirements). SSOT for fund definitions and restriction compliance. Primary dimension for gift designation reporting. Linked to finance domain general ledger accounts.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique identifier for the fundraising appeal or solicitation effort. Primary key.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the primary fund or designation that gifts from this appeal are directed toward (e.g., scholarship fund, capital project, unrestricted annual fund).',
    `campaign_id` BIGINT COMMENT 'Reference to the parent fundraising campaign under which this appeal is organized.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member, volunteer, or external vendor responsible for executing this appeal.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Appeals run in specific fiscal periods for fundraising tracking and ROI analysis. Creating appeal.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic college or school benefiting from or sponsoring this appeal.',
    `appeal_code` STRING COMMENT 'Unique business identifier code for the appeal used in tracking and reporting. Typically alphanumeric code assigned by advancement office.. Valid values are `^[A-Z0-9]{4,12}$`',
    `appeal_description` STRING COMMENT 'Detailed description of the appeal purpose, messaging strategy, and intended outcomes.',
    `appeal_name` STRING COMMENT 'Descriptive name of the fundraising appeal or solicitation effort (e.g., Annual Fund Spring Mail, Homecoming Phonathon, Presidents Circle Dinner).',
    `appeal_status` STRING COMMENT 'Current lifecycle status of the appeal indicating whether it is planned, active, completed, cancelled, or suspended.. Valid values are `planned|active|completed|cancelled|suspended`',
    `appeal_type` STRING COMMENT 'Classification of the solicitation method used for this appeal (direct mail, email, phone, event, digital, personal ask, social media). [ENUM-REF-CANDIDATE: direct_mail|email|phone|event|digital|personal_ask|social_media — 7 candidates stripped; promote to reference product]',
    `ask_amount_high` DECIMAL(18,2) COMMENT 'Highest suggested gift amount presented to prospects in this appeal.',
    `ask_amount_low` DECIMAL(18,2) COMMENT 'Lowest suggested gift amount presented to prospects in this appeal.',
    `ask_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the ask amounts (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `average_gift_amount` DECIMAL(18,2) COMMENT 'Average gift amount received per responding donor for this appeal, calculated as total_revenue_amount / response_count.',
    `case_reportable_flag` BOOLEAN COMMENT 'Indicates whether this appeal and its results are included in CASE reporting and benchmarking surveys.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the solicitation cost amount (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this appeal record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this appeal record was last updated in the system.',
    `notes` STRING COMMENT 'Additional notes, observations, or lessons learned from executing this appeal, used for future planning and continuous improvement.',
    `owning_office` STRING COMMENT 'Name of the advancement office or unit responsible for managing this appeal (e.g., Annual Giving, Major Gifts, Alumni Relations, Development Office).',
    `package_code` STRING COMMENT 'Code identifying the specific solicitation package or creative treatment used in this appeal (e.g., letter version, email template, script version).. Valid values are `^[A-Z0-9]{2,10}$`',
    `response_count` STRING COMMENT 'Number of individuals or households who responded to this appeal with a gift or pledge.',
    `response_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of targeted individuals who responded to the appeal, calculated as (response_count / target_count) * 100.',
    `reunion_class_year` STRING COMMENT 'Graduation year of the alumni class targeted for reunion giving in this appeal, if applicable.',
    `revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total revenue amount (e.g., USD, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `roi_percentage` DECIMAL(18,2) COMMENT 'Return on investment for this appeal expressed as a percentage, calculated as ((total_revenue_amount - solicitation_cost_amount) / solicitation_cost_amount) * 100.',
    `solicitation_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to execute this appeal including printing, postage, event costs, staff time, and vendor fees.',
    `solicitation_end_date` DATE COMMENT 'Date when the appeal solicitation effort ends or is scheduled to end.',
    `solicitation_start_date` DATE COMMENT 'Date when the appeal solicitation effort begins or began. Represents the principal business event timestamp for this appeal.',
    `target_audience_segment` STRING COMMENT 'Description of the donor or prospect segment targeted by this appeal (e.g., alumni class of 2010, LYBUNT donors, major gift prospects, parents of current students).',
    `target_count` STRING COMMENT 'Number of individuals or households targeted for solicitation in this appeal.',
    `total_revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue generated from gifts and pledges attributed to this appeal.',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Master record for a specific fundraising solicitation or outreach effort within a campaign, such as a direct mail piece, email solicitation, phonathon, or event ask. Captures appeal name, appeal code, appeal type (mail, email, phone, event, digital, personal ask), associated campaign, solicitation date range, target audience segment, cost of solicitation, response rate, and total revenue generated. Enables ROI analysis at the appeal level and supports CASE reporting on solicitation methods.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`major_gift_proposal` (
    `major_gift_proposal_id` BIGINT COMMENT 'Unique identifier for the major gift proposal record. Primary key for the major gift proposal entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Major gift proposals are tied to specific academic programs (endowed chairs, program scholarships, facility naming). Gift officers track proposals by program for pipeline reporting and campaign planni',
    `advancement_fund_id` BIGINT COMMENT 'Identifier linking to the institutional fund or campaign master record. Used for gift allocation and financial reporting integration.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Major gift proposals in higher ed are designated to a specific college or academic unit (e.g., $5M to School of Engineering). Gift officers and deans require pipeline reporting by unit; fund_designati',
    `campaign_id` BIGINT COMMENT 'Identifier of the fundraising campaign or initiative to which this major gift proposal is attributed. Links to campaign master data for performance tracking and goal measurement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Major gift proposals often support specific academic units/cost centers for budget planning. Creating major_gift_proposal.cost_center_id to link to finance.cost_center for proposal tracking and budget',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: A major gift proposal is a formal solicitation directed at a specific donor. The product description explicitly states it Tracks a formal major gift solicitation proposal from cultivation through ask',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Major gift proposals are tracked by fiscal period for pipeline reporting and forecasting. Creating major_gift_proposal.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Major gift proposals with board_approval_required_flag and gift_agreement_executed_flag must be evaluated against the institutions gift acceptance policy. Gift officers and compliance staff reference',
    `employee_id` BIGINT COMMENT 'Identifier of the major gifts officer or fundraiser assigned to manage and steward this proposal through the solicitation lifecycle.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Major gift proposals in higher ed routinely involve building naming rights negotiations. major_gift_proposal.naming_opportunity is plain text; a FK to the specific building enables gift officers to ma',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Major gift proposals involving non-cash assets, international donors, or charitable trust vehicles require IRS Form 8283, state AG approval filings, or OFAC screening submissions before the gift is bo',
    `scholarship_id` BIGINT COMMENT 'Foreign key linking to aid.scholarship. Business justification: Major gift proposals are frequently structured around establishing or endowing a named scholarship; gift officers need the proposal-to-scholarship link to track proposal outcomes, coordinate with fina',
    `actual_close_date` DATE COMMENT 'Date when the prospect made a final commitment decision (accepted or declined). Null until the proposal reaches a closed-won or closed-lost stage.',
    `ask_amount` DECIMAL(18,2) COMMENT 'The monetary amount being requested from the prospect in this major gift solicitation. Represents the target gift size for pipeline forecasting and capacity planning.',
    `ask_date` DATE COMMENT 'Date when the formal solicitation ask was made to the prospect. Represents the key milestone when the proposal moved from cultivation to active solicitation.',
    `board_approval_date` DATE COMMENT 'Date when the board of trustees or governing body formally approved acceptance of the major gift. Null if board approval is not required or has not yet occurred.',
    `board_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the major gift proposal requires formal approval from the board of trustees or institutional leadership before acceptance. Typically true for gifts above a certain threshold or with special conditions.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Actual amount committed by the prospect if the proposal was accepted. May differ from the original ask amount due to negotiation. Null if proposal was declined or is still open.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether the major gift proposal contains sensitive or confidential information requiring restricted access. Used for data security and privacy compliance in advancement operations.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the major gift proposal record was first created in the advancement database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the ask amount (e.g., USD, GBP, EUR). Required for international fundraising and multi-currency gift tracking.. Valid values are `^[A-Z]{3}$`',
    `decline_reason` STRING COMMENT 'Explanation or category code for why the prospect declined the major gift proposal. Used for prospect intelligence and future cultivation strategy. Null if proposal was not declined.',
    `expected_close_date` DATE COMMENT 'Anticipated date when the prospect is expected to make a commitment decision on the major gift proposal. Used for pipeline forecasting and fiscal year revenue projections.',
    `fund_designation` STRING COMMENT 'Name or code of the institutional fund, endowment, or program to which the major gift will be directed (e.g., Engineering Scholarship Fund, Athletics Capital Campaign, Unrestricted Annual Fund).',
    `gift_agreement_date` DATE COMMENT 'Date when the formal gift agreement was executed by all parties. Used for legal compliance and stewardship reporting. Null if no agreement is required or has not been executed.',
    `gift_agreement_executed_flag` BOOLEAN COMMENT 'Indicates whether a formal gift agreement or memorandum of understanding has been signed by both the donor and the institution. Required for endowments and restricted gifts with specific terms.',
    `gift_purpose` STRING COMMENT 'Primary purpose or use category for the proposed major gift (e.g., endowment, capital project, program operating support, scholarship, research funding, unrestricted support). [ENUM-REF-CANDIDATE: endowment|capital|program-support|scholarship|research|unrestricted|faculty-support|student-support — 8 candidates stripped; promote to reference product]',
    `last_contact_date` DATE COMMENT 'Date of the most recent substantive contact or interaction with the prospect regarding this proposal. Used for tracking cultivation activity and ensuring timely follow-up.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the major gift proposal record was most recently updated. Used for audit trail, change tracking, and data synchronization.',
    `naming_opportunity` STRING COMMENT 'Description of any building, room, endowment, or program naming rights associated with the major gift proposal. Null if no naming opportunity is part of the solicitation.',
    `next_action_date` DATE COMMENT 'Scheduled date for the next planned action or follow-up activity related to the proposal. Used for gift officer task management and pipeline velocity tracking.',
    `next_action_description` STRING COMMENT 'Description of the next planned action or step in the solicitation process (e.g., Schedule site visit, Send proposal document, Follow-up call with spouse).',
    `notes` STRING COMMENT 'Free-form text field for gift officers to record additional context, strategy notes, prospect preferences, or other relevant information about the major gift proposal that does not fit structured fields.',
    `probability_percentage` STRING COMMENT 'Estimated likelihood (0-100%) that the proposal will result in a closed-won outcome. Used for weighted pipeline forecasting and revenue projections. Typically increases as proposal advances through stages.',
    `proposal_description` STRING COMMENT 'Detailed narrative describing the major gift proposal, including the case for support, impact statement, and specific use of funds. Used for proposal documentation and stewardship reporting.',
    `proposal_document_url` STRING COMMENT 'Link or file path to the formal written proposal document, case statement, or presentation materials. Used for document management and proposal version control.',
    `proposal_number` STRING COMMENT 'Business identifier for the major gift proposal, typically a human-readable code or number used by gift officers and advancement staff to reference the proposal in communications and reports.',
    `proposal_outcome` STRING COMMENT 'Final disposition of the major gift proposal. Indicates whether the prospect accepted, declined, deferred the decision, or the proposal was withdrawn. Null until proposal reaches a terminal stage.. Valid values are `pending|accepted|declined|deferred|withdrawn|converted`',
    `proposal_stage` STRING COMMENT 'Current stage of the major gift proposal in the fundraising pipeline. Tracks progression from initial identification through cultivation, ask, and closure. Used for pipeline management and forecasting. [ENUM-REF-CANDIDATE: identification|qualification|cultivation|solicitation|negotiation|stewardship|closed-won|closed-lost — 8 candidates stripped; promote to reference product]',
    `proposal_start_date` DATE COMMENT 'Date when the major gift proposal was formally created and entered into the advancement system. Marks the beginning of the proposals lifecycle for tracking and reporting.',
    `proposal_status` STRING COMMENT 'Operational status of the proposal indicating whether it is actively being pursued, on hold, withdrawn, or completed. Complements proposal_stage with administrative state information. [ENUM-REF-CANDIDATE: active|pending|on-hold|withdrawn|declined|accepted|completed — 7 candidates stripped; promote to reference product]',
    `proposal_title` STRING COMMENT 'Descriptive title or name of the major gift proposal, summarizing the purpose or focus of the solicitation (e.g., Endowed Chair in Computer Science, New Engineering Building Campaign).',
    `proposal_type` STRING COMMENT 'Classification of the major gift proposal by gift instrument or structure (e.g., outright cash gift, multi-year pledge, planned/deferred gift, foundation grant, corporate sponsorship, in-kind donation).. Valid values are `outright-gift|pledge|planned-gift|grant|corporate-sponsorship|in-kind`',
    `recognition_level` STRING COMMENT 'Donor recognition tier or giving society level associated with the proposed gift amount (e.g., Presidents Circle, Founders Society, Legacy Circle). Used for stewardship planning and benefits fulfillment.',
    `weighted_amount` DECIMAL(18,2) COMMENT 'Calculated value representing ask_amount multiplied by probability_percentage, used for realistic pipeline forecasting and expected revenue modeling.',
    CONSTRAINT pk_major_gift_proposal PRIMARY KEY(`major_gift_proposal_id`)
) COMMENT 'Tracks a formal major gift solicitation proposal from cultivation through ask to close, representing the primary workflow record for major gifts officers. Captures proposal title, ask amount, ask date, expected close date, actual close date, proposal stage (identification, qualification, cultivation, solicitation, stewardship, closed-won, closed-lost), assigned gift officer, primary prospect, fund designation, and proposal outcome. Supports pipeline management and major gifts forecasting. Sourced from Blackbaud Raisers Edge proposal module.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`planned_gift` (
    `planned_gift_id` BIGINT COMMENT 'Unique identifier for the planned gift record. Primary key.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the institutional fund or endowment that will receive the planned gift proceeds upon maturity. Links to fund master record.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Planned gifts are designated to specific academic units; planned giving officers and deans track the pipeline of future gifts by college for long-range financial planning. designation_purpose is a tex',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign under which this planned gift commitment was secured, if applicable. Used for campaign reporting and goal tracking.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Planned gifts (bequests, charitable remainder trusts) are designated to specific academic programs. Planned giving pipeline reporting by program, stewardship of expectancies, and program-level gift pr',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who has made the planned gift commitment. Links to the alumnus master record.',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: A planned gift (bequest, charitable remainder trust, etc.) is made by a donor. While planned_gift.donor_alumnus_id links to the alumnus record, not all planned gift donors are alumni (e.g., corporatio',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member or planned giving officer who cultivated and secured this commitment. Used for performance tracking and relationship continuity.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Planned gifts are tracked by fiscal period for pipeline reporting and estate planning. Creating planned_gift.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Planned gifts with gift_vehicle_type (CRTs, bequests, CLATs) are accepted or declined based on the institutions gift acceptance policy. Planned giving officers must link each commitment to the govern',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Planned gifts (bequests, charitable remainder trusts, gift annuities) trigger IRS Form 8282, 990 Schedule D, and state insurance department filings for gift annuity reserves. Direct link required for ',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Planned gifts often designated for research (bequests for endowed chairs, estate gifts for research programs). Advancement tracks intended beneficiary awards for stewardship, financial planning, and e',
    `scholarship_id` BIGINT COMMENT 'Foreign key linking to aid.scholarship. Business justification: Planned gifts (bequests, charitable remainder trusts) are commonly designated to named scholarships; planned giving officers must link the gift vehicle to the specific scholarship for estate administr',
    `actual_maturity_date` DATE COMMENT 'Actual date when the planned gift matured and assets were transferred to the institution. Populated when commitment status reaches matured.',
    `anonymous_flag` BOOLEAN COMMENT 'Indicates whether the donor has requested complete anonymity for this planned gift commitment. Overrides all recognition and publication settings.',
    `commitment_date` DATE COMMENT 'Date when the donor formally communicated or documented their planned gift intention. Principal business event timestamp for this commitment.',
    `commitment_number` STRING COMMENT 'Externally-known unique identifier or reference number for the planned gift commitment, used in donor communications and legal documentation.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the planned gift commitment. Tracks progression from initial intention through legal execution to maturity or revocation.. Valid values are `intention|documented|executed|matured|revoked|lapsed`',
    `contingent_beneficiary_flag` BOOLEAN COMMENT 'Indicates whether the institution is named as a contingent (secondary) beneficiary rather than primary beneficiary. Affects probability of realization and pipeline valuation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this planned gift record was first created in the data platform. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `designation_purpose` STRING COMMENT 'Intended use or purpose of the planned gift proceeds as specified by the donor (e.g., scholarship endowment, faculty chair, unrestricted support, capital project).',
    `documentation_date` DATE COMMENT 'Date when legal documentation was executed or verified. Distinct from commitment date, which may precede formal documentation.',
    `estate_percentage` DECIMAL(18,2) COMMENT 'Percentage of the donors estate designated for the institution in bequest commitments. Null for fixed-amount or non-bequest vehicles.',
    `estimated_value_amount` DECIMAL(18,2) COMMENT 'Estimated present or future value of the planned gift at maturity, used for pipeline reporting and stewardship tier assignment. Subject to periodic revaluation.',
    `expected_maturity_date` DATE COMMENT 'Anticipated date when the planned gift will be realized and transferred to the institution. May be estimated based on actuarial tables for life-contingent gifts.',
    `fixed_amount` DECIMAL(18,2) COMMENT 'Specific dollar amount designated in the planned gift commitment. Used for fixed bequests and annuity contracts. Null for percentage-based commitments.',
    `gift_vehicle_type` STRING COMMENT 'The legal instrument or vehicle through which the planned gift will be realized. Determines tax treatment, timing, and stewardship approach.. Valid values are `bequest|charitable_remainder_trust|charitable_gift_annuity|life_insurance|retained_life_estate|charitable_lead_trust`',
    `last_contact_date` DATE COMMENT 'Date of most recent stewardship contact or engagement activity with the donor regarding this planned gift commitment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this planned gift record was most recently updated in the data platform. Audit trail for change tracking.',
    `legal_documentation_status` STRING COMMENT 'Level of legal formalization of the planned gift commitment. Tracks progression from verbal intention through executed legal instruments to institutional verification.. Valid values are `verbal_intention|letter_of_intent|draft_document|executed_document|verified`',
    `next_contact_date` DATE COMMENT 'Scheduled date for next stewardship contact or follow-up activity. Used for relationship management and stewardship workflow.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special conditions, donor preferences, or stewardship considerations for this planned gift commitment.',
    `primary_beneficiary_name` STRING COMMENT 'Name of the primary beneficiary organization as documented in the legal instrument. Typically the institutions legal name or a specific college/school within it.',
    `prospect_rating` STRING COMMENT 'Prospect research rating indicating the donors overall giving capacity and engagement level. Used for portfolio assignment and cultivation strategy.. Valid values are `major|principal|leadership|standard`',
    `recognition_name` STRING COMMENT 'Name(s) to be used for donor recognition purposes in planned giving society materials, honor rolls, and stewardship communications. May differ from legal name.',
    `recognition_published_flag` BOOLEAN COMMENT 'Indicates whether the donor has consented to public recognition of their planned gift commitment in institutional publications and honor rolls.',
    `revaluation_date` DATE COMMENT 'Date when the estimated value was last reviewed and updated. Planned gifts should be periodically revalued based on market conditions and actuarial updates.',
    `revocable_flag` BOOLEAN COMMENT 'Indicates whether the donor retains the legal right to revoke or modify the planned gift commitment. True for most bequests; false for irrevocable trusts and executed annuities.',
    `revocation_date` DATE COMMENT 'Date when the donor formally revoked or withdrew the planned gift commitment. Populated when commitment status changes to revoked.',
    `revocation_reason` STRING COMMENT 'Explanation or reason provided for revocation of the planned gift commitment. Used for relationship management and program improvement analysis.',
    `source_system` STRING COMMENT 'Name of the operational system from which this planned gift record originated (e.g., Blackbaud Raisers Edge, custom planned giving database).',
    `source_system_code` STRING COMMENT 'Unique identifier for this planned gift record in the source operational system. Used for data lineage and reconciliation.',
    `stewardship_tier` STRING COMMENT 'Recognition and stewardship tier assigned based on estimated gift value, donor relationship, and institutional priorities. Determines engagement strategy and benefits.. Valid values are `heritage_society|legacy_circle|planned_giving_society|estate_partner|standard`',
    `verification_method` STRING COMMENT 'Method by which the institution verified the existence and terms of the planned gift commitment.. Valid values are `donor_letter|attorney_confirmation|estate_document_copy|trust_agreement|insurance_policy|beneficiary_designation`',
    CONSTRAINT pk_planned_gift PRIMARY KEY(`planned_gift_id`)
) COMMENT 'Record of a deferred or estate gift commitment (bequest intention, charitable remainder trust, charitable gift annuity, life insurance assignment, retained life estate) made by a donor. Captures gift vehicle type, estimated value, estate percentage or fixed amount, maturity date, legal documentation status, revocability, and stewardship tier. Distinct from pledge (which is a binding near-term commitment) and from gift (which is a completed transaction). Supports planned giving program management and estate pipeline reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`prospect_rating` (
    `prospect_rating_id` BIGINT COMMENT 'Unique identifier for the prospect rating record. Primary key for the prospect rating entity.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus or donor being rated. Links to the alumnus master record.',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: The prospect_rating product description states it Stores wealth screening and prospect research ratings for donors and prospects. Currently it only has alumnus_id, but prospect research is conducted',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Prospect ratings are done in specific fiscal periods for pipeline tracking and forecasting. Creating prospect_rating.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member (major gifts officer or prospect manager) assigned to manage this prospect based on the rating.',
    `affinity_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the prospects emotional connection and engagement with the institution, based on attendance, volunteerism, event participation, and communication responsiveness.',
    `approval_date` DATE COMMENT 'Date when the rating was formally approved for use in major gifts officer portfolio assignment and solicitation strategy.',
    `assigned_rating_tier` STRING COMMENT 'Portfolio management tier assigned for major gifts officer workload distribution: tier 1 (highest capacity/priority), tier 2, tier 3, tier 4, or unassigned.. Valid values are `tier_1|tier_2|tier_3|tier_4|unassigned`',
    `board_memberships` STRING COMMENT 'Corporate and nonprofit board memberships held by the prospect, indicating leadership capacity and network connections.',
    `business_interests_value` DECIMAL(18,2) COMMENT 'Estimated value of private business ownership, partnerships, and closely-held company interests based on business valuation data and public filings.',
    `capacity_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all capacity amounts (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `capacity_rating` STRING COMMENT 'Overall giving capacity tier assigned to the prospect: major (100K-999K), principal (1M+), planned (estate gift potential), annual (under 100K), or unrated.. Valid values are `major|principal|planned|annual|unrated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect rating record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the completeness and reliability of the underlying data used to generate the rating, often provided by wealth screening vendors.',
    `estimated_annual_income` DECIMAL(18,2) COMMENT 'Estimated annual income from all sources including salary, bonuses, investment income, and business income, derived from compensation disclosures and wealth screening data.',
    `estimated_capacity_amount` DECIMAL(18,2) COMMENT 'Estimated total giving capacity in dollars based on wealth indicators, typically representing a lifetime giving potential or single major gift capacity.',
    `estimated_capacity_range_high` DECIMAL(18,2) COMMENT 'Upper bound of the estimated giving capacity range in dollars.',
    `estimated_capacity_range_low` DECIMAL(18,2) COMMENT 'Lower bound of the estimated giving capacity range in dollars.',
    `estimated_net_worth` DECIMAL(18,2) COMMENT 'Total estimated net worth calculated as sum of all assets (real estate, stocks, business interests, other investments) minus estimated liabilities.',
    `foundation_affiliations` STRING COMMENT 'Names of private foundations where the prospect serves as trustee, officer, or donor, sourced from IRS Form 990 filings.',
    `inclination_rating` STRING COMMENT 'Qualitative assessment of the prospects likelihood to give based on past giving behavior, philanthropic interests, and engagement patterns.. Valid values are `high|medium|low|unknown`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect rating record was last updated, supporting audit trail and data lineage requirements.',
    `last_reviewed_date` DATE COMMENT 'Date when the rating was last reviewed and validated by prospect research staff, ensuring currency and accuracy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next rating review and refresh, typically 12-24 months from last review per CASE best practices.',
    `philanthropic_interests` STRING COMMENT 'Known philanthropic interests and giving priorities of the prospect based on past giving history, foundation grants, board memberships, and public statements.',
    `political_contributions_flag` BOOLEAN COMMENT 'Indicates whether the prospect has made political contributions disclosed in Federal Election Commission (FEC) records, signaling capacity and civic engagement.',
    `portfolio_assignment_date` DATE COMMENT 'Date when the prospect was assigned to a major gifts officer portfolio based on this rating.',
    `propensity_score` DECIMAL(18,2) COMMENT 'Predictive score (0-100) indicating likelihood of making a gift, often generated by statistical modeling or machine learning algorithms based on historical donor behavior.',
    `rating_date` DATE COMMENT 'Date when the prospect rating was assigned or last updated. Principal business event timestamp for the rating lifecycle.',
    `rating_effective_date` DATE COMMENT 'Date from which the rating becomes effective for prospect management and major gifts officer portfolio assignment.',
    `rating_expiration_date` DATE COMMENT 'Date when the rating expires and should be refreshed. Typically 12-24 months from rating date per CASE best practices.',
    `rating_notes` STRING COMMENT 'Free-text notes from prospect researchers providing context, qualitative insights, and recommendations for cultivation strategy based on the rating.',
    `rating_number` STRING COMMENT 'Business identifier for the prospect rating record, typically assigned by the wealth screening vendor or prospect research office.',
    `rating_status` STRING COMMENT 'Current lifecycle status of the prospect rating: active (current and valid), expired (outdated), under review (being reassessed), pending (awaiting approval), or archived (historical record).. Valid values are `active|expired|under_review|pending|archived`',
    `rating_type` STRING COMMENT 'Classification of the rating methodology used: wealth screening from third-party vendor, manual prospect research, peer screening, electronic screening, or combined approach.. Valid values are `wealth_screening|manual_research|peer_screening|electronic_screening|combined`',
    `real_estate_holdings_value` DECIMAL(18,2) COMMENT 'Estimated total value of real estate holdings owned by the prospect, sourced from public property records and wealth screening vendors.',
    `research_confidence_level` STRING COMMENT 'Confidence level in the accuracy and completeness of the wealth indicators and capacity estimate: high (multiple verified sources), medium (limited sources), low (estimated or inferred).. Valid values are `high|medium|low`',
    `research_source` STRING COMMENT 'Name of the third-party wealth screening vendor or research source that provided the rating data (e.g., DonorSearch, iWave, WealthEngine, RelSci).',
    `research_vendor_code` STRING COMMENT 'External identifier assigned by the wealth screening vendor to this rating record, used for data reconciliation and vendor support.',
    `stock_ownership_value` DECIMAL(18,2) COMMENT 'Estimated value of publicly traded stock holdings, including insider holdings reported to SEC and beneficial ownership disclosed in proxy statements.',
    `wealth_indicator_source` STRING COMMENT 'Primary source of wealth indicators used in the rating: public records, SEC filings, proxy statements, Forbes/Fortune lists, foundation 990s, or third-party wealth screening vendor.',
    CONSTRAINT pk_prospect_rating PRIMARY KEY(`prospect_rating_id`)
) COMMENT 'Stores wealth screening and prospect research ratings for donors and prospects, capturing estimated giving capacity, affinity score, inclination rating, wealth indicators (real estate holdings, stock ownership, business interests, compensation), research source, rating date, and assigned rating tier. Supports prospect research workflows and major gifts officer portfolio management. Sourced from third-party wealth screening vendors (e.g., DonorSearch, iWave) integrated into Blackbaud Raisers Edge.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`stewardship_action` (
    `stewardship_action_id` BIGINT COMMENT 'Unique identifier for the stewardship action record. Primary key.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the specific fund or endowment being stewarded through this action.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to advancement.appeal. Business justification: stewardship_action has a STRING attribute appeal_code that should be normalized to a FK relationship. Stewardship actions (thank-you letters, impact reports, donor communications) are often tied to ',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this stewardship action.',
    `donor_id` BIGINT COMMENT 'Reference to the donor or alumnus receiving this stewardship communication.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member responsible for executing this stewardship action.',
    `ferpa_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.ferpa_disclosure. Business justification: Stewardship reports to donors often include student/scholarship recipient information (names, majors, photos, testimonials). Each disclosure requires FERPA compliance documentation per 34 CFR 99.32 re',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Stewardship actions are recorded in specific fiscal periods for cost tracking and reporting. Creating stewardship_action.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `gift_id` BIGINT COMMENT 'Reference to the specific gift being acknowledged or stewarded, if applicable.',
    `pledge_id` BIGINT COMMENT 'Reference to the pledge being stewarded, if applicable.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Stewardship communications reference specific research awards funded by gifts (impact reports, thank-you letters, annual updates). Critical for donor relations, demonstrating research outcomes, and ma',
    `scholarship_id` BIGINT COMMENT 'Foreign key linking to aid.scholarship. Business justification: Stewardship actions (thank-you letters, impact reports) are sent to donors on behalf of named scholarships. Linking stewardship_action to the specific scholarship enables automated donor impact report',
    `action_date` DATE COMMENT 'The date the stewardship action was performed or is scheduled to be performed.',
    `action_number` STRING COMMENT 'Human-readable business identifier for the stewardship action, often used for tracking and reference.',
    `action_status` STRING COMMENT 'Current lifecycle status of the stewardship action (planned, in progress, completed, cancelled, deferred).. Valid values are `planned|in_progress|completed|cancelled|deferred`',
    `action_type` STRING COMMENT 'Category of stewardship activity performed (e.g., thank-you letter, impact report, IRS 501(c)(3) substantiation letter, scholarship recipient introduction, named space dedication, endowment fund report, recognition event, personal visit, phone call, email update). [ENUM-REF-CANDIDATE: thank_you_letter|impact_report|gift_acknowledgment|scholarship_introduction|named_space_dedication|endowment_report|recognition_event|personal_visit|phone_call|email_update — 10 candidates stripped; promote to reference product]',
    `assigned_staff_name` STRING COMMENT 'Full name of the advancement staff member assigned to this stewardship action.',
    `communication_channel` STRING COMMENT 'The delivery method or channel used for the stewardship communication (mail, email, phone, in-person, video call, text message).. Valid values are `mail|email|phone|in_person|video_call|text_message`',
    `completion_date` DATE COMMENT 'The actual date the stewardship action was completed and delivered.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred for executing this stewardship action (printing, postage, event costs).',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this stewardship action record was first created in the system.',
    `delivery_status` STRING COMMENT 'Status indicating whether the stewardship communication was successfully delivered to the donor.. Valid values are `pending|sent|delivered|bounced|failed|returned`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the stewardship communication was delivered or sent.',
    `donor_response_date` DATE COMMENT 'Date when the donor responded to the stewardship communication.',
    `donor_response_notes` STRING COMMENT 'Free-text notes capturing the content or sentiment of the donors response.',
    `donor_response_received` BOOLEAN COMMENT 'Indicates whether the donor provided a response or acknowledgment to this stewardship action.',
    `donor_response_type` STRING COMMENT 'Method by which the donor responded to the stewardship action.. Valid values are `email|phone|letter|in_person|none`',
    `fund_name` STRING COMMENT 'Name of the fund or endowment being stewarded.',
    `impact_metrics_included` BOOLEAN COMMENT 'Indicates whether quantitative impact metrics or outcomes were included in this stewardship communication.',
    `irs_acknowledgment_required` BOOLEAN COMMENT 'Indicates whether this stewardship action fulfills IRS 501(c)(3) substantiation letter requirements for gifts of $250 or more.',
    `irs_acknowledgment_sent_date` DATE COMMENT 'Date when the IRS-compliant gift acknowledgment letter was sent to the donor.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this stewardship action record was most recently updated.',
    `message_body` STRING COMMENT 'Full text content of the stewardship communication message.',
    `moves_management_stage` STRING COMMENT 'Stage in the moves management cycle that this stewardship action supports (identification, cultivation, solicitation, stewardship).',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this stewardship action for internal reference.',
    `recognition_level` STRING COMMENT 'Recognition tier or giving society level referenced in this stewardship action (e.g., Presidents Circle, Deans Society).',
    `scheduled_date` DATE COMMENT 'The originally planned date for this stewardship action, used for tracking timeliness and compliance with stewardship timelines.',
    `scholarship_recipient_name` STRING COMMENT 'Name of the student receiving scholarship support from the donors gift, used in scholarship introduction letters.',
    `signer_name` STRING COMMENT 'Name of the individual whose signature appears on the stewardship communication (e.g., President, Dean, Development Officer).',
    `signer_title` STRING COMMENT 'Official title of the individual signing the stewardship communication.',
    `subject_line` STRING COMMENT 'Subject line or title of the stewardship communication, particularly for emails and letters.',
    `template_code` STRING COMMENT 'Code identifying the template or format used for this stewardship communication.',
    `template_name` STRING COMMENT 'Descriptive name of the template used for this stewardship communication.',
    CONSTRAINT pk_stewardship_action PRIMARY KEY(`stewardship_action_id`)
) COMMENT 'Records individual stewardship and donor communication activities including thank-you letters, impact reports, gift acknowledgments (IRS 501(c)(3) substantiation letters), scholarship recipient introductions, named space dedications, endowment fund reports, recognition events, personal visits, and formal outreach communications. Captures action type, channel (mail, email, phone, in-person), date, assigned staff, donor response, template used, signer, delivery status, and completion status. Supports stewardship plan fulfillment, acknowledgment compliance within IRS-required timeframes, and moves management contact reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`endowment` (
    `endowment_id` BIGINT COMMENT 'Unique identifier for the endowed fund record. Primary key for the endowment entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Endowments are established to support specific academic programs (scholarships, chairs, fellowships). NACUBO stewardship reporting and donor impact reports require linking endowments to the benefiting',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Endowments are designated to specific academic units; NACUBO and stewardship reporting require linking endowment funds to their benefiting college or department. benefiting_department and benefiting_c',
    `student_org_id` BIGINT COMMENT 'Foreign key linking to studentlife.student_org. Business justification: Endowments are frequently established to permanently support specific student organizations. Annual stewardship reports to donors require identifying the benefiting student org. Higher-education advan',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Endowment spending distributions are disbursed on a per-academic-term basis (e.g., scholarship awards each semester). Advancement and finance teams report annual distribution amounts by term. A higher',
    `employee_id` BIGINT COMMENT 'Reference to the advancement or finance staff member responsible for managing this endowments stewardship, reporting, and donor relations.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Endowment accounting: each endowment is carried as a distinct finance fund (principal and income pools). The endowment spending policy calculation, underwater fund monitoring, and GASB 68/FASB ASC 958',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Endowments are valued and reported by fiscal period for financial statements. Creating endowment.fiscal_period_id to link to finance.fiscal_period for period-based valuation and reporting.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Endowments frequently fund named campus buildings (e.g., the Smith Hall endowment). Stewardship reporting and NACUBO compliance require linking an endowment to the specific building it supports or nam',
    `donor_id` BIGINT COMMENT 'Reference to the primary donor (alumnus or constituent) who established this endowment. Used for stewardship reporting and donor relations.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Endowments post to principal ledger accounts for GL accounting of endowment assets. Creating endowment.principal_ledger_account_id to link to finance.ledger_account for financial reporting.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Endowments with ipeds_reportable_flag and nacubo_reportable_flag require IRS Form 990 Schedule D and NACUBO annual survey filings. Endowment officers need a direct link to the specific regulatory fili',
    `accounting_segment` STRING COMMENT 'The chart of accounts segment or cost center code to which spending distributions from this endowment are posted in the general ledger.',
    `annual_distribution_amount` DECIMAL(18,2) COMMENT 'The dollar amount authorized for spending distribution from this endowment for the current fiscal year. Calculated based on spending policy rate and market value.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this endowment record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_principal_amount` DECIMAL(18,2) COMMENT 'The current corpus or principal balance of the endowment, including all subsequent gifts added to principal. Represents the donor-restricted amount that must be maintained in perpetuity for true endowments.',
    `establishment_date` DATE COMMENT 'The date when the endowment fund was officially established and began accepting gifts. Marks the beginning of the funds operational lifecycle.',
    `fund_name` STRING COMMENT 'The official name of the endowed fund, typically reflecting the donors naming preference or the funds purpose.',
    `fund_number` STRING COMMENT 'The externally-known fund accounting number assigned to this endowment in the institutional chart of accounts. Used for financial reporting and donor communication.',
    `fund_purpose` STRING COMMENT 'Detailed description of the donor-specified purpose and restrictions for spending distributions from this endowment. Defines how funds may be used (e.g., scholarships, faculty support, program funding).',
    `fund_status` STRING COMMENT 'Current lifecycle status of the endowment fund. Active: fund is operational and distributing. Inactive: temporarily not distributing. Closed: fund has been terminated. Suspended: distributions paused pending review. Pending establishment: fund committed but not yet operational.. Valid values are `active|inactive|closed|suspended|pending_establishment`',
    `fund_type` STRING COMMENT 'Classification of the endowment based on donor restrictions and institutional policy. True endowment: donor-restricted principal in perpetuity. Quasi-endowment: board-designated funds functioning as endowment. Term endowment: donor-restricted for a specified period.. Valid values are `true_endowment|quasi_endowment|term_endowment`',
    `ipeds_reportable_flag` BOOLEAN COMMENT 'Indicates whether this endowment is included in the institutions annual IPEDS Finance Survey endowment reporting. True if reportable, False if excluded.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this endowment record was most recently updated. Used for audit trail and change tracking.',
    `last_stewardship_report_date` DATE COMMENT 'The date when the most recent annual stewardship report was sent to the donor or their designee. Used to track stewardship compliance.',
    `market_value` DECIMAL(18,2) COMMENT 'The current fair market value of the endowment fund, including principal, accumulated gains, and reinvested income. This is the total investable asset value used for spending distribution calculations.',
    `market_value_date` DATE COMMENT 'The date as of which the market value was calculated. Typically the last business day of the fiscal quarter or year.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum endowment balance required by institutional policy before spending distributions can begin. Typically $25,000 to $50,000 for most institutions.',
    `nacubo_reportable_flag` BOOLEAN COMMENT 'Indicates whether this endowment is included in the institutions annual NACUBO-Commonfund Study of Endowments participation. True if reportable, False if excluded.',
    `named_honoree` STRING COMMENT 'The individual or entity honored or memorialized by this endowment, as specified by the donor. Used in fund naming and stewardship communications.',
    `next_stewardship_report_due_date` DATE COMMENT 'The date by which the next annual stewardship report is due to be sent to the donor. Typically aligned with fiscal year-end reporting cycles.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical context about this endowment that does not fit in structured fields.',
    `original_gift_date` DATE COMMENT 'The date when the initial gift that established this endowment was received. May differ from establishment date if there was a delay in fund setup.',
    `original_principal_amount` DECIMAL(18,2) COMMENT 'The initial gift amount that established the endowment. This is the historic dollar value of the original contribution and serves as the baseline for UPMIFA spending policy calculations.',
    `purpose_category` STRING COMMENT 'High-level classification of the endowments spending purpose for reporting and analysis. Aligns with NACUBO and IPEDS endowment reporting categories.. Valid values are `scholarship|faculty_support|program_support|research|facilities|unrestricted`',
    `spending_policy_method` STRING COMMENT 'The methodology used to calculate annual spending distributions. Total return: percentage of smoothed market value. Income only: actual income earned. Hybrid: combination approach.. Valid values are `total_return|income_only|hybrid`',
    `spending_policy_rate` DECIMAL(18,2) COMMENT 'The annual spending distribution rate applied to this endowment, expressed as a decimal (e.g., 0.0450 for 4.5%). Determines the amount available for spending each year under the institutions UPMIFA-compliant spending policy.',
    `stewardship_report_status` STRING COMMENT 'Status of the annual endowment stewardship report to the donor. Required: report must be sent. Completed: report has been delivered. Waived: donor declined reporting. Pending: report in preparation.. Valid values are `required|completed|waived|pending`',
    `underwater_amount` DECIMAL(18,2) COMMENT 'The dollar amount by which the current market value is below the original principal, if the endowment is underwater. Null or zero if not underwater.',
    `underwater_flag` BOOLEAN COMMENT 'Indicates whether the endowments current market value has fallen below the original principal amount (underwater status). True if underwater, False if not. Affects spending policy decisions under UPMIFA.',
    `unit_market_value` DECIMAL(18,2) COMMENT 'The current market value per unit in the investment pool. Used to calculate the endowments total market value from units held.',
    `units_held` DECIMAL(18,2) COMMENT 'The number of units this endowment holds in the investment pool. Market value equals units held multiplied by unit market value.',
    `ytd_distribution_amount` DECIMAL(18,2) COMMENT 'The cumulative amount distributed from this endowment during the current fiscal year to date. Used to track spending against the annual authorization.',
    CONSTRAINT pk_endowment PRIMARY KEY(`endowment_id`)
) COMMENT 'Master record for an individual endowed fund tracking the endowments market value, original gift principal, spending distribution amount, payout rate, investment pool allocation, fund purpose, named honoree, and annual endowment report status. Supports endowment stewardship reporting to donors and compliance with UPMIFA (Uniform Prudent Management of Institutional Funds Act) spending policy. Linked to the fund master record and to finance domain investment pool records.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the advancement event record. Primary key for the advancement event entity.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Advancement events (galas, donor receptions, alumni gatherings) occur in campus buildings. This FK links advancement_event to the facility building master, enabling facility scheduling and space utili',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this event. Links the event to broader fundraising initiatives such as capital campaigns, annual giving drives, or endowment campaigns.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Advancement events are often hosted by academic units/cost centers for budget and expense tracking. Creating advancement_event.cost_center_id to link to finance.cost_center for event cost allocation.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member responsible for planning and executing this event. Primary point of contact for event logistics, vendor coordination, and post-event reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Advancement events occur in specific fiscal periods for budget and expense tracking. Creating advancement_event.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: advancement.event already has building_id→facility.building; room_id is the natural next level for event logistics. Advancement event planners need the specific room for AV setup, seating configuratio',
    `actual_attendance` STRING COMMENT 'Confirmed number of individuals who attended the event. Captured through check-in systems or manual counts. Used for ROI analysis, per-attendee cost calculation, and future planning.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred for the advancement event after completion. Compared against budget to calculate variance and inform future event planning. Includes all invoiced and paid expenses.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocated for the advancement event. Includes venue rental, catering, entertainment, marketing, staffing, and other direct costs. Used for financial planning and variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this advancement event record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts associated with this event (registration fees, budget, costs). Typically USD for U.S. institutions but may vary for international events.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Format through which the event is delivered to attendees. In-person events require physical venue, virtual events use online platforms, hybrid events combine both modalities.. Valid values are `in_person|virtual|hybrid`',
    `early_registration_deadline` DATE COMMENT 'Date by which registrants must register to receive early registration pricing or benefits. Incentivizes early commitment and aids in planning.',
    `early_registration_fee` DECIMAL(18,2) COMMENT 'Discounted ticket price for attendees who register before the early registration deadline. Incentivizes early commitment and improves planning accuracy.',
    `end_time` TIMESTAMP COMMENT 'Precise date and time when the advancement event concludes. Used for venue booking, catering planning, and staff scheduling.',
    `event_date` DATE COMMENT 'Calendar date on which the advancement event takes place. Primary business event timestamp for scheduling, reporting, and fiscal year attribution.',
    `event_description` STRING COMMENT 'Detailed narrative description of the advancement event including purpose, agenda, featured speakers, and expected outcomes. Used in invitations, marketing materials, and internal planning documents.',
    `event_name` STRING COMMENT 'Official name of the advancement event as it appears in invitations, marketing materials, and donor communications. Examples: Annual Scholarship Gala, Presidents Circle Reception, Engineering Building Groundbreaking.',
    `event_number` STRING COMMENT 'Externally-visible unique business identifier for the advancement event. Used in communications, invitations, and reporting. Format may follow institutional conventions (e.g., EVT-2024-001).',
    `event_status` STRING COMMENT 'Current lifecycle state of the advancement event. Tracks progression from initial planning through execution and post-event follow-up. [ENUM-REF-CANDIDATE: planning|registration_open|registration_closed|in_progress|completed|cancelled|postponed — 7 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the advancement event by format and purpose. Determines event planning requirements, budget allocation, and success metrics. [ENUM-REF-CANDIDATE: gala|reception|groundbreaking|lecture_series|campaign_kickoff|donor_recognition|stewardship_dinner|reunion|cultivation_event|solicitation_event — 10 candidates stripped; promote to reference product]',
    `fundraising_goal_amount` DECIMAL(18,2) COMMENT 'Target dollar amount of gifts or pledges to be secured at or attributed to this event. Used for fundraising events with solicitation components. Null for non-fundraising events.',
    `guest_registration_fee` DECIMAL(18,2) COMMENT 'Ticket price for guests accompanying registered alumni or donors. May differ from standard alumni pricing to reflect different engagement levels.',
    `is_fundraising_event` BOOLEAN COMMENT 'Indicates whether this event includes direct fundraising solicitation or gift commitments. True for galas with pledge drives, campaign kickoffs, or solicitation dinners. Affects IRS reporting and gift attribution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this advancement event record was most recently updated. Audit field for change tracking and data quality monitoring.',
    `purpose` STRING COMMENT 'Primary strategic objective of the event within the donor engagement lifecycle. Cultivation events build relationships, stewardship events thank donors, recognition events honor contributions, and solicitation events request gifts.. Valid values are `cultivation|stewardship|recognition|solicitation|prospect_identification|donor_education`',
    `registration_capacity` STRING COMMENT 'Maximum number of attendees that can register for the event. Determined by venue capacity, catering limits, or strategic attendance targets. Used to manage waitlists and close registration.',
    `registration_close_date` DATE COMMENT 'Date when event registration closes. After this date, no new registrations are accepted. Used for final headcount, catering orders, and seating arrangements.',
    `registration_open_date` DATE COMMENT 'Date when event registration becomes available to invitees. Marks the beginning of the registration period and triggers invitation communications.',
    `requires_rsvp` BOOLEAN COMMENT 'Indicates whether attendees must formally register or RSVP to attend the event. True for capacity-limited or catered events requiring headcount. False for open-invitation events.',
    `reunion_class_year` STRING COMMENT 'Graduation year of the alumni class being honored at a reunion event. Used for milestone reunion planning (5th, 10th, 25th, 50th anniversaries). Null for non-reunion events.',
    `standard_registration_fee` DECIMAL(18,2) COMMENT 'Regular ticket price for event attendance after early registration period. May vary by attendee type (alumnus, guest, non-alumnus). Revenue supports event costs and may contribute to fundraising goals.',
    `start_time` TIMESTAMP COMMENT 'Precise date and time when the advancement event begins. Used for invitation details, venue coordination, and attendance tracking.',
    `target_attendance` STRING COMMENT 'Planned or goal number of attendees for the event. Set during planning phase based on venue capacity, strategic objectives, and historical data. Used to measure event success.',
    `venue_address_line1` STRING COMMENT 'First line of the venue street address including building number and street name. Used for invitations, directions, and logistics coordination.',
    `venue_address_line2` STRING COMMENT 'Second line of the venue street address for suite, floor, room number, or building name. Optional field for additional location details.',
    `venue_city` STRING COMMENT 'City or municipality where the event venue is located. Used for regional event analysis and travel planning for attendees.',
    `venue_country_code` STRING COMMENT 'Three-letter ISO country code for the event venue location. Supports international event tracking and regional alumni engagement analysis.. Valid values are `^[A-Z]{3}$`',
    `venue_postal_code` STRING COMMENT 'Postal or ZIP code for the event venue location. Used for mapping, proximity analysis, and mailing logistics.',
    `venue_state_province` STRING COMMENT 'State, province, or administrative region where the event venue is located. Supports geographic segmentation and regional engagement analysis.',
    `virtual_meeting_url` STRING COMMENT 'Web address or link for accessing the virtual event platform. Distributed to registered attendees prior to the event. Confidential to prevent unauthorized access.',
    `virtual_platform` STRING COMMENT 'Name of the technology platform used for virtual or hybrid event delivery. Examples: Zoom, Microsoft Teams, Webex, Hopin. Null for in-person only events.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Master record for donor cultivation and stewardship events organized by the advancement office, including gala dinners, donor recognition ceremonies, named lecture series, groundbreakings, campaign kickoffs, and regional receptions. Captures event name, type, date, location, capacity, budget, actual cost, associated campaign, and event purpose (cultivation, stewardship, recognition, solicitation). Includes registration and attendance tracking at the individual level (registrant type, attendance status, meal preference, table assignment, registration fee). Distinct from academic or student events managed in other domains.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`constituent` (
    `constituent_id` BIGINT COMMENT 'Primary key for constituent',
    `profile_id` BIGINT COMMENT 'Foreign key linking to student.profile. Business justification: Current students participate in advancement as phonathon callers, student volunteers, and donors. Linking constituent to student profile enables FERPA-compliant identity resolution, duplicate suppress',
    `spouse_constituent_id` BIGINT COMMENT 'Self-referencing FK on constituent (spouse_constituent_id)',
    `alternate_email` STRING COMMENT 'Secondary email address for the constituent, used as a backup contact method.',
    `alumni_status` STRING COMMENT 'Classification of the constituents alumni relationship (e.g., graduate, attendee without degree, honorary degree recipient).',
    `business_phone` STRING COMMENT 'Work or business telephone number for the constituent.',
    `constituent_status` STRING COMMENT 'Current lifecycle status of the constituent record in the advancement system.',
    `constituent_type` STRING COMMENT 'Classification of the constituents relationship to the institution (e.g., alumni, donor, friend of the university, parent, faculty, staff).',
    `data_source` STRING COMMENT 'The originating system or source from which the constituent record was created or imported.',
    `date_of_birth` DATE COMMENT 'The constituents date of birth, used for age verification and demographic analysis.',
    `deceased_date` DATE COMMENT 'Date when the constituent passed away, if applicable.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the constituent is deceased. True if deceased, False if living.',
    `donor_status` STRING COMMENT 'Classification of the constituents giving status (e.g., active donor, lapsed donor, major gift donor, planned giving prospect).',
    `employer_name` STRING COMMENT 'Current employer or organization where the constituent works.',
    `engagement_score` STRING COMMENT 'Calculated score representing the constituents level of engagement with the institution based on interactions, event attendance, and communication responses.',
    `first_name` STRING COMMENT 'Legal first name or given name of the constituent.',
    `gender` STRING COMMENT 'Self-identified gender of the constituent.',
    `giving_capacity_rating` STRING COMMENT 'Estimated philanthropic capacity rating for the constituent based on wealth screening and prospect research.',
    `industry` STRING COMMENT 'The industry sector in which the constituent is employed.',
    `job_title` STRING COMMENT 'Current job title or position held by the constituent.',
    `last_name` STRING COMMENT 'Legal last name or surname of the constituent.',
    `lifetime_giving_amount` DECIMAL(18,2) COMMENT 'Total cumulative amount of all gifts made by the constituent to the institution over their lifetime.',
    `maiden_name` STRING COMMENT 'Birth surname or previous surname of the constituent, typically used for alumni tracking.',
    `marital_status` STRING COMMENT 'Current marital status of the constituent.',
    `middle_name` STRING COMMENT 'Middle name or middle initial of the constituent.',
    `mobile_phone` STRING COMMENT 'Mobile or cell phone number for the constituent, used for text messaging and mobile outreach.',
    `preferred_name` STRING COMMENT 'The name the constituent prefers to be called, which may differ from their legal name.',
    `prefix` STRING COMMENT 'Honorific or title prefix for the constituent (e.g., Dr., Mr., Ms., Prof.).',
    `primary_address_line1` STRING COMMENT 'First line of the constituents primary mailing address (street number and name).',
    `primary_address_line2` STRING COMMENT 'Second line of the primary address (apartment, suite, unit number).',
    `primary_city` STRING COMMENT 'City name for the constituents primary address.',
    `primary_country` STRING COMMENT 'Three-letter ISO country code for the constituents primary address (e.g., USA, CAN, GBR).',
    `primary_email` STRING COMMENT 'The primary email address used for constituent communication and engagement.',
    `primary_phone` STRING COMMENT 'The primary telephone number for contacting the constituent.',
    `primary_postal_code` STRING COMMENT 'Postal code or ZIP code for the constituents primary address.',
    `primary_state_province` STRING COMMENT 'State, province, or region for the constituents primary address.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when the constituent record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the constituent record was last modified.',
    `solicitation_status` STRING COMMENT 'Indicates whether and how the constituent may be solicited for gifts or contacted for fundraising purposes.',
    `suffix` STRING COMMENT 'Name suffix for the constituent (e.g., Jr., Sr., III, PhD, Esq.).',
    `volunteer_status` STRING COMMENT 'Indicates the constituents current volunteer engagement status with the institution.',
    CONSTRAINT pk_constituent PRIMARY KEY(`constituent_id`)
) COMMENT 'Master reference table for constituent. Referenced by constituent_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ADD CONSTRAINT `fk_advancement_alumni_contact_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_major_gift_proposal_id` FOREIGN KEY (`major_gift_proposal_id`) REFERENCES `education_ecm`.`advancement`.`major_gift_proposal`(`major_gift_proposal_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_alumni_event_id` FOREIGN KEY (`alumni_event_id`) REFERENCES `education_ecm`.`advancement`.`alumni_event`(`alumni_event_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`donor` ADD CONSTRAINT `fk_advancement_donor_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`donor` ADD CONSTRAINT `fk_advancement_donor_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `education_ecm`.`advancement`.`constituent`(`constituent_id`);
ALTER TABLE `education_ecm`.`advancement`.`donor` ADD CONSTRAINT `fk_advancement_donor_primary_spouse_donor_id` FOREIGN KEY (`primary_spouse_donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `education_ecm`.`advancement`.`appeal`(`appeal_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift` ADD CONSTRAINT `fk_advancement_gift_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `education_ecm`.`advancement`.`pledge`(`pledge_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `education_ecm`.`advancement`.`appeal`(`appeal_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`pledge` ADD CONSTRAINT `fk_advancement_pledge_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign` ADD CONSTRAINT `fk_advancement_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ADD CONSTRAINT `fk_advancement_prospect_rating_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ADD CONSTRAINT `fk_advancement_prospect_rating_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `education_ecm`.`advancement`.`appeal`(`appeal_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_gift_id` FOREIGN KEY (`gift_id`) REFERENCES `education_ecm`.`advancement`.`gift`(`gift_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `education_ecm`.`advancement`.`pledge`(`pledge_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`constituent` ADD CONSTRAINT `fk_advancement_constituent_spouse_constituent_id` FOREIGN KEY (`spouse_constituent_id`) REFERENCES `education_ecm`.`advancement`.`constituent`(`constituent_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`advancement` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `education_ecm`.`advancement` SET TAGS ('dbx_domain' = 'advancement');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `degree_conferral_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Conferral Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Graduating Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alternate_email` SET TAGS ('dbx_business_glossary_term' = 'Alternate Email Address');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alternate_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alternate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alternate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alumni_status` SET TAGS ('dbx_business_glossary_term' = 'Alumni Status');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alumni_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deceased|Lost|Do Not Contact|Opted Out');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Deceased Date');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `deceased_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `do_not_solicit_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Solicit Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `ferpa_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Consent Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'Male|Female|Non-Binary|Prefer Not to Disclose|Other|Unknown');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `maiden_name` SET TAGS ('dbx_business_glossary_term' = 'Maiden Name');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `maiden_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `maiden_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `preferred_first_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred First Name');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `preferred_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `preferred_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `preferred_last_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Last Name');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `preferred_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `preferred_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `alumni_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni Contact ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|invalid|pending');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `contact_frequency_preference` SET TAGS ('dbx_business_glossary_term' = 'Contact Frequency Preference');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `contact_frequency_preference` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `do_not_call_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `do_not_email_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Email Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `do_not_email_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `do_not_email_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `do_not_mail_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Mail Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `do_not_sms_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not SMS Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `email_consent_source` SET TAGS ('dbx_business_glossary_term' = 'Email Consent Source');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `email_consent_source` SET TAGS ('dbx_value_regex' = 'web_form|phone|event|paper_form|imported');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `email_consent_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `email_consent_source` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `email_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Email Consent Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `email_consent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `email_consent_timestamp` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Home Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_city` SET TAGS ('dbx_business_glossary_term' = 'Home City');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_country_code` SET TAGS ('dbx_business_glossary_term' = 'Home Country Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_business_glossary_term' = 'Home Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Home Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_state_province` SET TAGS ('dbx_business_glossary_term' = 'Home State or Province');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `home_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `ncoa_update_date` SET TAGS ('dbx_business_glossary_term' = 'National Change of Address (NCOA) Update Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `opt_in_career_news` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Career News');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `opt_in_event_invitations` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Event Invitations');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `opt_in_fundraising_appeals` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Fundraising Appeals');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `opt_in_institutional_news` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Institutional News');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `phone_consent_source` SET TAGS ('dbx_business_glossary_term' = 'Phone Consent Source');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `phone_consent_source` SET TAGS ('dbx_value_regex' = 'web_form|phone|event|paper_form|imported');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `phone_consent_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `phone_consent_source` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `phone_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Phone Consent Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `phone_consent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `phone_consent_timestamp` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|sms');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA|DEU|ZHO|JPN');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_city` SET TAGS ('dbx_business_glossary_term' = 'Seasonal City');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_country_code` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Country Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Address End Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Address Start Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_state_province` SET TAGS ('dbx_business_glossary_term' = 'Seasonal State or Province');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `seasonal_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `engagement_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Activity Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `campus_event_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `major_gift_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Proposal Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'completed|scheduled|cancelled|no_show|pending');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'event_attendance|volunteer_service|mentorship_session|career_fair_participation|webinar|campus_visit');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|web|mobile_app|social_media');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Activity Cost Amount');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `is_major_gift_related` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Related Flag');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `is_volunteer_activity` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Activity Flag');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Activity Location');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|follow_up_required|no_contact|declined');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Activity Subject');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `alumni_event_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni Event ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizing Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `early_registration_deadline` SET TAGS ('dbx_business_glossary_term' = 'Early Registration Deadline');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_end_date` SET TAGS ('dbx_business_glossary_term' = 'Event End Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_start_date` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `fundraising_goal_amount` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Goal Amount');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `is_fundraising_event` SET TAGS ('dbx_business_glossary_term' = 'Is Fundraising Event');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_email` SET TAGS ('dbx_business_glossary_term' = 'Organizing Staff Email');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Organizing Staff Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_phone` SET TAGS ('dbx_business_glossary_term' = 'Organizing Staff Phone');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `organizing_staff_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `registration_capacity` SET TAGS ('dbx_business_glossary_term' = 'Registration Capacity');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `requires_rsvp` SET TAGS ('dbx_business_glossary_term' = 'Requires RSVP (Répondez Sil Vous Plaît)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `reunion_class_year` SET TAGS ('dbx_business_glossary_term' = 'Reunion Class Year');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `target_attendance` SET TAGS ('dbx_business_glossary_term' = 'Target Attendance');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Venue Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Venue Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_business_glossary_term' = 'Venue State or Province');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `virtual_meeting_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Meeting URL (Uniform Resource Locator)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `virtual_meeting_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `alumni_event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni Event Registration ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `alumni_event_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Registered By Staff ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `accessibility_requirements` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirements');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `check_in_method` SET TAGS ('dbx_business_glossary_term' = 'Check-In Method');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `check_in_method` SET TAGS ('dbx_value_regex' = 'mobile_app|qr_code|staff_manual|kiosk|badge_scan');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `confirmation_email_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Email Sent Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `confirmation_email_sent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `confirmation_email_sent_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `dietary_requirements` SET TAGS ('dbx_business_glossary_term' = 'Dietary Requirements');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Count');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `name_badge_printed_flag` SET TAGS ('dbx_business_glossary_term' = 'Name Badge Printed Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Campaign Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_value_regex' = 'online_portal|staff_entry|mobile_app|phone|email|walk_in');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|waitlisted|cancelled|attended|no-show|pending');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `reminder_email_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Email Sent Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `reminder_email_sent_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `reminder_email_sent_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `table_assignment` SET TAGS ('dbx_business_glossary_term' = 'Table Assignment');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `ticket_type` SET TAGS ('dbx_business_glossary_term' = 'Ticket Type');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `waitlist_added_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Added Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `education_ecm`.`advancement`.`donor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`donor` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Officer Identifier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_spouse_donor_id` SET TAGS ('dbx_business_glossary_term' = 'Spouse Donor Identifier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|invalid|ncoa_updated');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `alternate_email` SET TAGS ('dbx_business_glossary_term' = 'Alternate Email Address');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `alternate_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `alternate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `alternate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `consecutive_giving_years` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Giving Years');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `constituent_classification` SET TAGS ('dbx_business_glossary_term' = 'Council for Advancement and Support of Education (CASE) Constituent Classification');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `constituent_classification` SET TAGS ('dbx_value_regex' = 'alumnus|parent|friend|faculty|staff|corporation');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Deceased Date');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `do_not_solicit_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Solicit Flag');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `donor_status` SET TAGS ('dbx_business_glossary_term' = 'Donor Status');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `donor_status` SET TAGS ('dbx_value_regex' = 'active|lapsed|deceased|inactive|do_not_contact');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `donor_type` SET TAGS ('dbx_business_glossary_term' = 'Donor Type');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `donor_type` SET TAGS ('dbx_value_regex' = 'individual|corporation|foundation|organization|government|trust');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `fiscal_year_giving_total` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Giving Total');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `fiscal_year_giving_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `giving_capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Giving Capacity Rating');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `giving_capacity_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `ncoa_update_date` SET TAGS ('dbx_business_glossary_term' = 'National Change of Address (NCOA) Update Date');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `portfolio_assignment` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Assignment');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `portfolio_assignment` SET TAGS ('dbx_value_regex' = 'major_gifts|principal_gifts|planned_giving|annual_giving|corporate_foundation|unassigned');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Affiliation');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_city` SET TAGS ('dbx_business_glossary_term' = 'Primary City');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_business_glossary_term' = 'Primary State or Province');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `record_created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `record_last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Salutation');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `stewardship_tier` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Tier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `stewardship_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `wealth_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Wealth Screening Date');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`gift` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_officer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_officer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `scholarship_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|sent|not_required');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Gift Amount');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Gift Amount in United States Dollars (USD)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `anonymous_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Flag');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `case_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Council for Advancement and Support of Education (CASE) Reportable Flag');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `first_gift_date` SET TAGS ('dbx_business_glossary_term' = 'First Gift Date');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_date` SET TAGS ('dbx_business_glossary_term' = 'Gift Date');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Number');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_source` SET TAGS ('dbx_business_glossary_term' = 'Gift Source');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_source` SET TAGS ('dbx_value_regex' = 'individual|corporation|foundation|organization|other');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_status` SET TAGS ('dbx_business_glossary_term' = 'Gift Status');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_status` SET TAGS ('dbx_value_regex' = 'received|pledged|pending|cancelled|refunded|adjusted');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_type` SET TAGS ('dbx_business_glossary_term' = 'Gift Type');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_type` SET TAGS ('dbx_value_regex' = 'outright|pledge_payment|matching|in_kind|securities|planned');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `in_kind_description` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Gift Description');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `ipeds_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `largest_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Largest Gift Amount');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `largest_gift_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `last_gift_date` SET TAGS ('dbx_business_glossary_term' = 'Last Gift Date');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `lifetime_giving_total` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Giving Total');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `lifetime_giving_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `matching_gift_company_name` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Company Name');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `matching_gift_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Eligible Flag');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Gift Notes');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Gift Purpose');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `stock_shares` SET TAGS ('dbx_business_glossary_term' = 'Stock Shares');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `stock_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Symbol');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `tax_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Deductible Amount');
ALTER TABLE `education_ecm`.`advancement`.`pledge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`pledge` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `scholarship_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `acknowledgment_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Sent Flag');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Pledge Total Amount');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid to Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `anonymous_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Pledge Flag');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `balance_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `designation` SET TAGS ('dbx_business_glossary_term' = 'Pledge Designation');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `final_installment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Installment Due Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `first_installment_date` SET TAGS ('dbx_business_glossary_term' = 'First Installment Due Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|custom');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `installments_paid` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid Count');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `matching_gift_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Eligible Flag');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `next_installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Amount');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `next_installment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Due Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pledge Notes');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `pledge_number` SET TAGS ('dbx_business_glossary_term' = 'Pledge Number');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Pledge Status');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_value_regex' = 'active|completed|cancelled|defaulted|written_off|pending');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_business_glossary_term' = 'Pledge Type');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_value_regex' = 'outright|multi_year|conditional|matching|challenge|endowment');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Reminder Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `tax_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Deductible Amount');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `education_ecm`.`advancement`.`pledge` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `education_ecm`.`advancement`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`campaign` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Coordinator Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `active_membership_count` SET TAGS ('dbx_business_glossary_term' = 'Active Membership Count');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `amount_raised` SET TAGS ('dbx_business_glossary_term' = 'Amount Raised');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget Amount');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_number` SET TAGS ('dbx_business_glossary_term' = 'Campaign Number');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'comprehensive|capital|annual|endowment|emergency|recognition_society');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `case_reporting_classification` SET TAGS ('dbx_business_glossary_term' = 'Council for Advancement and Support of Education (CASE) Reporting Classification');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Campaign Contact Email Address');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Campaign Contact Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `donor_count` SET TAGS ('dbx_business_glossary_term' = 'Donor Count');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `gift_counting_rules` SET TAGS ('dbx_business_glossary_term' = 'Gift Counting Rules');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `goal_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Goal Amount');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `member_benefits_description` SET TAGS ('dbx_business_glossary_term' = 'Member Benefits Description');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `minimum_giving_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Giving Threshold');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Campaign Phase');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'planning|quiet|public|completion');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `public_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Public Launch Date');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `quiet_phase_goal_amount` SET TAGS ('dbx_business_glossary_term' = 'Quiet Phase Goal Amount');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `recognition_tier` SET TAGS ('dbx_business_glossary_term' = 'Recognition Tier');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `stewardship_plan` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Plan');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `success_metrics` SET TAGS ('dbx_business_glossary_term' = 'Success Metrics');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `visibility_status` SET TAGS ('dbx_business_glossary_term' = 'Visibility Status');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `visibility_status` SET TAGS ('dbx_value_regex' = 'public|internal|confidential');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Campaign Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Advancement Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Benefiting Student Org Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Designated Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Supported Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `current_market_value` SET TAGS ('dbx_business_glossary_term' = 'Current Market Value');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `donor_advised_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Advised Flag');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `donor_recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Donor Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Establishment Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `facilities_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Facilities Support Flag');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `faculty_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Faculty Support Flag');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `first_distribution_date` SET TAGS ('dbx_business_glossary_term' = 'First Distribution Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending-establishment');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'endowed|expendable|restricted|unrestricted|quasi-endowment|term-endowment');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `gift_agreement_document_url` SET TAGS ('dbx_business_glossary_term' = 'Gift Agreement Document Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `gift_agreement_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `gift_restriction_terms` SET TAGS ('dbx_business_glossary_term' = 'Gift Restriction Terms');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `investment_pool_assignment` SET TAGS ('dbx_business_glossary_term' = 'Investment Pool Assignment');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `market_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Market Value Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `market_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `minimum_endowment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Endowment Threshold');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `nacubo_classification` SET TAGS ('dbx_business_glossary_term' = 'National Association of College and University Business Officers (NACUBO) Classification');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `nacubo_classification` SET TAGS ('dbx_value_regex' = 'true-endowment|term-endowment|quasi-endowment|expendable-restricted|expendable-unrestricted|annuity-life-income');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fund Notes');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `original_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Gift Amount');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `program_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Support Flag');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Purpose Description');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|as-requested|none');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `scholarship_fund_flag` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Fund Flag');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `spending_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Spending Calculation Method');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `spending_calculation_method` SET TAGS ('dbx_value_regex' = 'total-return|income-only|hybrid|unit-value');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `spending_policy_rate` SET TAGS ('dbx_business_glossary_term' = 'Spending Policy Rate');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `stewardship_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Reporting Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `underwater_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Underwater Status Flag');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `variance_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Reporting Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`appeal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`appeal` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Designation Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College or School Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Code');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Description');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_business_glossary_term' = 'Appeal Name');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|suspended');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `ask_amount_high` SET TAGS ('dbx_business_glossary_term' = 'Ask Amount High');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `ask_amount_low` SET TAGS ('dbx_business_glossary_term' = 'Ask Amount Low');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `ask_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Ask Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `ask_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `average_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Gift Amount');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `case_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Council for Advancement and Support of Education (CASE) Reportable Flag');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `owning_office` SET TAGS ('dbx_business_glossary_term' = 'Owning Office');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `response_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Percentage');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `reunion_class_year` SET TAGS ('dbx_business_glossary_term' = 'Reunion Class Year');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `solicitation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Cost Amount');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `solicitation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Solicitation End Date');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `solicitation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Start Date');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `target_count` SET TAGS ('dbx_business_glossary_term' = 'Target Count');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Amount');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `major_gift_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Proposal ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefiting Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Acceptance Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Officer ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `scholarship_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `ask_amount` SET TAGS ('dbx_business_glossary_term' = 'Ask Amount');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `ask_date` SET TAGS ('dbx_business_glossary_term' = 'Ask Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `board_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `fund_designation` SET TAGS ('dbx_business_glossary_term' = 'Fund Designation');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `gift_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Gift Agreement Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `gift_agreement_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Agreement Executed Flag');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `gift_purpose` SET TAGS ('dbx_business_glossary_term' = 'Gift Purpose');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `naming_opportunity` SET TAGS ('dbx_business_glossary_term' = 'Naming Opportunity');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `next_action_description` SET TAGS ('dbx_business_glossary_term' = 'Next Action Description');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proposal Notes');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_business_glossary_term' = 'Proposal Description');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_document_url` SET TAGS ('dbx_business_glossary_term' = 'Proposal Document URL');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Proposal Outcome');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_outcome` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|deferred|withdrawn|converted');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_stage` SET TAGS ('dbx_business_glossary_term' = 'Proposal Stage');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Start Date');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_title` SET TAGS ('dbx_business_glossary_term' = 'Proposal Title');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'outright-gift|pledge|planned-gift|grant|corporate-sponsorship|in-kind');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `weighted_amount` SET TAGS ('dbx_business_glossary_term' = 'Weighted Amount');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `planned_gift_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Gift Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefiting Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Designated Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Acceptance Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `scholarship_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `actual_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Maturity Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `anonymous_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Flag');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Planned Gift Commitment Number');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'intention|documented|executed|matured|revoked|lapsed');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `contingent_beneficiary_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingent Beneficiary Flag');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `designation_purpose` SET TAGS ('dbx_business_glossary_term' = 'Designation Purpose');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `documentation_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `estate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Estate Percentage');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value Amount');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `expected_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Maturity Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Amount');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `gift_vehicle_type` SET TAGS ('dbx_business_glossary_term' = 'Gift Vehicle Type');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `gift_vehicle_type` SET TAGS ('dbx_value_regex' = 'bequest|charitable_remainder_trust|charitable_gift_annuity|life_insurance|retained_life_estate|charitable_lead_trust');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `legal_documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Documentation Status');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `legal_documentation_status` SET TAGS ('dbx_value_regex' = 'verbal_intention|letter_of_intent|draft_document|executed_document|verified');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `next_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Next Contact Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Name');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `prospect_rating` SET TAGS ('dbx_business_glossary_term' = 'Prospect Rating');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `prospect_rating` SET TAGS ('dbx_value_regex' = 'major|principal|leadership|standard');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `recognition_name` SET TAGS ('dbx_business_glossary_term' = 'Recognition Name');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `recognition_published_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognition Published Flag');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `revocable_flag` SET TAGS ('dbx_business_glossary_term' = 'Revocable Flag');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `stewardship_tier` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Tier');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `stewardship_tier` SET TAGS ('dbx_value_regex' = 'heritage_society|legacy_circle|planned_giving_society|estate_partner|standard');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'donor_letter|attorney_confirmation|estate_document_copy|trust_agreement|insurance_policy|beneficiary_designation');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` SET TAGS ('dbx_subdomain' = 'donor_fundraising');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `prospect_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Rating Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gifts Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `affinity_score` SET TAGS ('dbx_business_glossary_term' = 'Affinity Score');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `assigned_rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Assigned Rating Tier');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `assigned_rating_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|unassigned');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `board_memberships` SET TAGS ('dbx_business_glossary_term' = 'Board Memberships');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `business_interests_value` SET TAGS ('dbx_business_glossary_term' = 'Business Interests Value');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `capacity_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Capacity Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `capacity_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_value_regex' = 'major|principal|planned|annual|unrated');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `estimated_annual_income` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Income');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `estimated_capacity_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capacity Amount');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `estimated_capacity_range_high` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capacity Range High');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `estimated_capacity_range_low` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capacity Range Low');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `estimated_net_worth` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Worth');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `foundation_affiliations` SET TAGS ('dbx_business_glossary_term' = 'Foundation Affiliations');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `inclination_rating` SET TAGS ('dbx_business_glossary_term' = 'Inclination Rating');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `inclination_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `philanthropic_interests` SET TAGS ('dbx_business_glossary_term' = 'Philanthropic Interests');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `political_contributions_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Contributions Flag');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `portfolio_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Assignment Date');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `propensity_score` SET TAGS ('dbx_business_glossary_term' = 'Propensity Score');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_notes` SET TAGS ('dbx_business_glossary_term' = 'Rating Notes');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_number` SET TAGS ('dbx_business_glossary_term' = 'Rating Number');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'active|expired|under_review|pending|archived');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Type');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_value_regex' = 'wealth_screening|manual_research|peer_screening|electronic_screening|combined');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `real_estate_holdings_value` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Holdings Value');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `research_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Research Confidence Level');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `research_confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `research_source` SET TAGS ('dbx_business_glossary_term' = 'Research Source');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `research_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Research Vendor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `stock_ownership_value` SET TAGS ('dbx_business_glossary_term' = 'Stock Ownership Value');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `wealth_indicator_source` SET TAGS ('dbx_business_glossary_term' = 'Wealth Indicator Source');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` SET TAGS ('dbx_subdomain' = 'stewardship_endowment');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `stewardship_action_id` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Action Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `ferpa_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Ferpa Disclosure Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `scholarship_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Action Date');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Action Number');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Action Status');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Action Type');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `assigned_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff Name');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'mail|email|phone|in_person|video_call|text_message');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Action Cost Amount');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|sent|delivered|bounced|failed|returned');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `donor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Response Date');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `donor_response_notes` SET TAGS ('dbx_business_glossary_term' = 'Donor Response Notes');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `donor_response_received` SET TAGS ('dbx_business_glossary_term' = 'Donor Response Received Flag');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `donor_response_type` SET TAGS ('dbx_business_glossary_term' = 'Donor Response Type');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `donor_response_type` SET TAGS ('dbx_value_regex' = 'email|phone|letter|in_person|none');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `impact_metrics_included` SET TAGS ('dbx_business_glossary_term' = 'Impact Metrics Included Flag');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `irs_acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Service (IRS) Acknowledgment Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `irs_acknowledgment_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Service (IRS) Acknowledgment Sent Date');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `message_body` SET TAGS ('dbx_business_glossary_term' = 'Communication Message Body');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `moves_management_stage` SET TAGS ('dbx_business_glossary_term' = 'Moves Management Stage');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Action Notes');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Donor Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Action Date');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `scholarship_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Recipient Name');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `scholarship_recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `scholarship_recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `signer_name` SET TAGS ('dbx_business_glossary_term' = 'Letter Signer Name');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `signer_title` SET TAGS ('dbx_business_glossary_term' = 'Letter Signer Title');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject Line');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Code');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Name');
ALTER TABLE `education_ecm`.`advancement`.`endowment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`endowment` SET TAGS ('dbx_subdomain' = 'stewardship_endowment');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `endowment_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Benefiting Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefiting Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Benefiting Student Org Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Manager Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Named Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `accounting_segment` SET TAGS ('dbx_business_glossary_term' = 'Accounting Segment Code');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `annual_distribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Distribution Amount');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `current_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Principal Amount');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Endowment Establishment Date');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Endowment Fund Name');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fund_number` SET TAGS ('dbx_business_glossary_term' = 'Fund Number');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fund_purpose` SET TAGS ('dbx_business_glossary_term' = 'Endowment Fund Purpose');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Endowment Fund Status');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending_establishment');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Endowment Fund Type');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'true_endowment|quasi_endowment|term_endowment');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `ipeds_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `last_stewardship_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stewardship Report Date');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Endowment Market Value');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `market_value_date` SET TAGS ('dbx_business_glossary_term' = 'Market Value As-Of Date');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `minimum_balance_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `nacubo_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'National Association of College and University Business Officers (NACUBO) Reportable Flag');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `named_honoree` SET TAGS ('dbx_business_glossary_term' = 'Named Honoree');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `next_stewardship_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Stewardship Report Due Date');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Endowment Notes');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `original_gift_date` SET TAGS ('dbx_business_glossary_term' = 'Original Gift Date');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `original_principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Principal Amount');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `purpose_category` SET TAGS ('dbx_business_glossary_term' = 'Purpose Category');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `purpose_category` SET TAGS ('dbx_value_regex' = 'scholarship|faculty_support|program_support|research|facilities|unrestricted');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `spending_policy_method` SET TAGS ('dbx_business_glossary_term' = 'Spending Policy Method');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `spending_policy_method` SET TAGS ('dbx_value_regex' = 'total_return|income_only|hybrid');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `spending_policy_rate` SET TAGS ('dbx_business_glossary_term' = 'Spending Policy Rate');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `stewardship_report_status` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Report Status');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `stewardship_report_status` SET TAGS ('dbx_value_regex' = 'required|completed|waived|pending');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `underwater_amount` SET TAGS ('dbx_business_glossary_term' = 'Underwater Amount');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `underwater_flag` SET TAGS ('dbx_business_glossary_term' = 'Underwater Status Flag');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `unit_market_value` SET TAGS ('dbx_business_glossary_term' = 'Investment Pool Unit Market Value');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `units_held` SET TAGS ('dbx_business_glossary_term' = 'Investment Pool Units Held');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `ytd_distribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Year-To-Date (YTD) Distribution Amount');
ALTER TABLE `education_ecm`.`advancement`.`event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`event` SET TAGS ('dbx_subdomain' = 'stewardship_endowment');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Advancement Event Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Organizing Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `early_registration_deadline` SET TAGS ('dbx_business_glossary_term' = 'Early Registration Deadline');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `early_registration_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Registration Fee');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `fundraising_goal_amount` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Goal Amount');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `guest_registration_fee` SET TAGS ('dbx_business_glossary_term' = 'Guest Registration Fee');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `is_fundraising_event` SET TAGS ('dbx_business_glossary_term' = 'Is Fundraising Event Flag');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Event Purpose');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'cultivation|stewardship|recognition|solicitation|prospect_identification|donor_education');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `registration_capacity` SET TAGS ('dbx_business_glossary_term' = 'Registration Capacity');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `requires_rsvp` SET TAGS ('dbx_business_glossary_term' = 'Requires Reservation (RSVP) Flag');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `reunion_class_year` SET TAGS ('dbx_business_glossary_term' = 'Reunion Class Year');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `standard_registration_fee` SET TAGS ('dbx_business_glossary_term' = 'Standard Registration Fee');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Event Start Time');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `target_attendance` SET TAGS ('dbx_business_glossary_term' = 'Target Attendance');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Venue Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Venue Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_business_glossary_term' = 'Venue State or Province');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `virtual_meeting_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Meeting Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `virtual_meeting_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform');
ALTER TABLE `education_ecm`.`advancement`.`constituent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`constituent` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `spouse_constituent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `alternate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `alternate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `business_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `business_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `giving_capacity_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `lifetime_giving_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `maiden_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `maiden_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `primary_state_province` SET TAGS ('dbx_pii_address' = 'true');
