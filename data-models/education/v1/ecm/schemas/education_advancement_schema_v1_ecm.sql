-- Schema for Domain: advancement | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:27:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`advancement` COMMENT 'Administers the complete post-graduation relationship lifecycle including alumni identity, engagement history, career outcomes, fundraising campaigns, donor management, gift processing, pledge tracking, prospect research, endowment stewardship, volunteer activities, and alumni events. Manages major gifts, annual giving, planned giving, and alumni relations as an integrated function.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumnus` (
    `alumnus_id` BIGINT COMMENT 'Unique identifier for the alumnus record. Primary key for the alumnus entity. This is the system-generated surrogate key that uniquely identifies each individual who has graduated from or attended the institution.',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Alumni profile stores primary degree CIP for segmentation, STEM alumni tracking, and targeted solicitation campaigns. Proper FK enables accurate STEM designation queries for NSF alumni surveys and OPT',
    `cocurricular_record_id` BIGINT COMMENT 'Foreign key linking to studentlife.cocurricular_record. Business justification: Gift officers leverage cocurricular achievements for donor storytelling, impact reporting, and leadership volunteer identification. Service hours, leadership roles, and awards inform recognition socie',
    `profile_id` BIGINT COMMENT 'Cross-reference to the original student identifier from the Student Information System (SIS). Links the alumnus record back to their student record for historical academic data retrieval. This is the business key that was assigned during enrollment.',
    `alternate_email` STRING COMMENT 'A secondary email address for the alumnus. Used as a backup contact method when the primary email is undeliverable or for work vs personal email segmentation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `alumni_status` STRING COMMENT 'The current engagement status of the alumnus record. Active indicates the alumnus is reachable and engaged; Deceased indicates confirmed death; Lost indicates contact information is outdated; Do Not Contact indicates explicit request to cease communications.. Valid values are `Active|Inactive|Deceased|Lost|Do Not Contact|Opted Out`',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'The cumulative GPA earned by the alumnus at the time of graduation. Used for honors society identification, scholarship donor reporting, and academic achievement recognition. Typically on a 4.0 scale.',
    `current_employer` STRING COMMENT 'The name of the organization where the alumnus is currently employed. Used for career outcomes tracking, employer engagement, and prospect research for major gift fundraising.',
    `current_job_title` STRING COMMENT 'The current professional title or position of the alumnus. Used for career outcomes reporting, networking events, and wealth screening for fundraising.',
    `date_of_birth` DATE COMMENT 'The date of birth of the alumnus. Used for age-based segmentation, reunion year calculations, and identity verification. Format: yyyy-MM-dd.',
    `deceased_date` DATE COMMENT 'The date on which the alumnus passed away, if known. Used for memorial records and in memoriam recognition. Format: yyyy-MM-dd.',
    `deceased_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the alumnus is deceased. True if confirmed deceased, False otherwise. Used to suppress communications and update alumni records appropriately.',
    `department_name` STRING COMMENT 'The academic department that administered the alumnus primary degree program. Used for department-level alumni engagement and faculty-alumni networking events.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Boolean flag indicating the alumnus has requested no contact from the institution. True if do-not-contact request is active, False otherwise. Suppresses all outreach including fundraising, events, and communications.',
    `do_not_solicit_flag` BOOLEAN COMMENT 'Boolean flag indicating the alumnus has requested no fundraising solicitations. True if do-not-solicit request is active, False otherwise. Suppresses fundraising appeals but allows other alumni communications.',
    `ethnicity` STRING COMMENT 'The self-reported ethnicity or race of the alumnus. Used for diversity reporting, IPEDS compliance, and targeted outreach to underrepresented alumni populations. [ENUM-REF-CANDIDATE: Hispanic or Latino|American Indian or Alaska Native|Asian|Black or African American|Native Hawaiian or Other Pacific Islander|White|Two or More Races|Unknown — promote to reference product]',
    `ferpa_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the alumnus has provided consent to share directory information under FERPA regulations. True if consent given, False if restricted. Controls publication of alumni information in directories and public listings.',
    `gender` STRING COMMENT 'The self-identified gender of the alumnus. Used for demographic reporting and diversity analytics. Supports inclusive gender identity options.. Valid values are `Male|Female|Non-Binary|Prefer Not to Disclose|Other|Unknown`',
    `graduation_date` DATE COMMENT 'The exact date on which the alumnus degree was conferred. Used for anniversary-based engagement and precise tenure calculations. Format: yyyy-MM-dd.',
    `graduation_term_code` STRING COMMENT 'The specific academic term code in which the alumnus graduated (e.g., 202305 for Spring 2023). Provides more granular graduation timing than year alone.',
    `graduation_year` STRING COMMENT 'The calendar year in which the alumnus graduated or completed their primary degree. Used for reunion planning, class-year segmentation, and alumni participation rate calculations.',
    `honors_designation` STRING COMMENT 'The Latin honors or other academic distinction awarded at graduation based on GPA or other criteria. Used for recognition programs and donor prospect research. [ENUM-REF-CANDIDATE: Summa Cum Laude|Magna Cum Laude|Cum Laude|Honors|High Honors|Highest Honors|None — 7 candidates stripped; promote to reference product]',
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
    `primary_degree_level` STRING COMMENT 'The highest degree level earned by the alumnus from the institution (e.g., Bachelor, Master, Doctoral, Certificate, Associate). Used for segmentation in fundraising appeals and alumni engagement strategies. [ENUM-REF-CANDIDATE: Certificate|Associate|Bachelor|Master|Doctoral|Professional|Post-Doctoral — promote to reference product]',
    `primary_degree_name` STRING COMMENT 'The full name of the primary degree earned (e.g., Bachelor of Science, Master of Business Administration, Doctor of Philosophy). Used for alumni directory listings and credential verification.',
    `primary_email` STRING COMMENT 'The primary email address for contacting the alumnus. Used for alumni communications, event invitations, fundraising campaigns, and institutional updates. This is the preferred digital contact channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_major` STRING COMMENT 'The primary field of study or major for the alumnus highest degree. Used for academic affinity segmentation and school/college-based fundraising campaigns.',
    `primary_phone` STRING COMMENT 'The primary telephone number for contacting the alumnus. Used for phonathon campaigns, event reminders, and urgent communications.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this alumnus record was first created in the system. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_source` STRING COMMENT 'The system or process that created or last significantly updated this alumnus record. Used for data lineage tracking and data quality auditing. [ENUM-REF-CANDIDATE: SIS|CRM|Manual Entry|Data Import|Alumni Survey|Third Party|Merge — 7 candidates stripped; promote to reference product]',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this alumnus record was last modified. Used for audit trail, data freshness assessment, and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `school_college_name` STRING COMMENT 'The name of the academic school, college, or division from which the alumnus graduated. Used for school-based fundraising campaigns and dean-level engagement strategies.',
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
    `secondary_email` STRING COMMENT 'An alternate email address for the alumnus, often a professional or work email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'The alumnus work or business telephone number.',
    CONSTRAINT pk_alumni_contact PRIMARY KEY(`alumni_contact_id`)
) COMMENT 'Stores all contact information and explicit communication preferences for each alumnus. Contact data includes addresses (home, mailing, seasonal, international), email addresses (personal, professional), phone numbers, LinkedIn profile URL, address verification status, and NCOA update dates. Communication preferences include preferred language, preferred contact method (email, postal mail, phone, SMS), frequency preferences (weekly, monthly, annual), topic opt-ins (career news, event invitations, fundraising appeals, institutional news), global do-not-contact flag, opt-in/opt-out flags per channel, consent timestamps, and consent source (web form, phone, event). Supports multi-address scenarios, FERPA-compliant outreach, CAN-SPAM/GDPR compliance, and international alumni communications.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumni_communication_preference` (
    `alumni_communication_preference_id` BIGINT COMMENT 'Unique identifier for each alumni communication preference record. Primary key for the alumni communication preference entity.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumni individual whose communication preferences are captured in this record. Links to the alumni master record.',
    `bounce_status` STRING COMMENT 'The current email deliverability status for this alumnus. Hard bounces indicate invalid addresses and trigger automatic suppression. Soft bounces are temporary delivery failures.. Valid values are `none|soft_bounce|hard_bounce|complaint`',
    `career_news_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive communications about career services, job postings, professional development, and networking opportunities.',
    `communication_frequency` STRING COMMENT 'The frequency at which the alumnus prefers to receive communications. Used to throttle outreach volume and respect alumni preferences.. Valid values are `daily|weekly|monthly|quarterly|annual|as_needed`',
    `consent_ip_address` STRING COMMENT 'The IP address from which the alumnus submitted their communication preferences via web form. Used for fraud detection and consent verification in compliance audits.',
    `consent_source` STRING COMMENT 'The channel or method through which the alumnus provided their communication preferences. Used for consent verification and audit trail purposes.. Valid values are `web_form|phone|email|event|mail_response|in_person`',
    `consent_timestamp` TIMESTAMP COMMENT 'The date and time when the alumnus provided or updated their communication preferences. Critical for GDPR and CAN-SPAM compliance auditing.',
    `consent_user_agent` STRING COMMENT 'The browser user agent string captured when the alumnus submitted preferences via web form. Provides technical context for consent verification.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this preference record was first created in the system. Used for audit trail and data lineage purposes.',
    `do_not_contact` BOOLEAN COMMENT 'Master suppression flag indicating the alumnus has requested no contact through any channel for any purpose. Overrides all other opt-in preferences. True if contact is prohibited.',
    `do_not_solicit` BOOLEAN COMMENT 'Indicates the alumnus has specifically requested not to receive fundraising solicitations while remaining open to other types of communications. True if fundraising solicitation is prohibited.',
    `double_opt_in_confirmed` BOOLEAN COMMENT 'Indicates whether the alumnus has confirmed their email opt-in via a double opt-in process (confirmation link). True if confirmed. Required for GDPR-compliant email marketing.',
    `double_opt_in_timestamp` TIMESTAMP COMMENT 'The date and time when the alumnus clicked the confirmation link in the double opt-in email. Provides audit trail for verified consent.',
    `email_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has explicitly opted in to receive email communications. True if opted in, False if opted out.',
    `event_invitations_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive invitations to alumni events including reunions, homecoming, regional gatherings, and networking events.',
    `fundraising_appeals_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive fundraising appeals including annual giving campaigns, major gift solicitations, and planned giving information.',
    `gdpr_consent_version` STRING COMMENT 'The version identifier of the GDPR consent language and privacy policy that the alumnus agreed to. Required for international alumni subject to GDPR.',
    `gdpr_lawful_basis` STRING COMMENT 'The GDPR Article 6 lawful basis under which the institution processes the alumnus communication data. Typically consent or legitimate interest for alumni relations.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `institutional_news_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive general institutional news including academic achievements, research highlights, campus updates, and alumni spotlights.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this preference record is the current active record for the alumnus. True if active. Supports preference versioning and historical tracking.',
    `last_bounce_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent email bounce event for this alumnus. Used to track deliverability issues and trigger address verification workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this preference record was last modified in the system. Used for change tracking and audit purposes.',
    `phone_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has consented to receive phone calls from the institution for engagement, fundraising, or event invitations.',
    `postal_mail_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive postal mail communications including newsletters, magazines, and fundraising appeals.',
    `preference_expiration_date` DATE COMMENT 'The date on which the current preferences expire and require re-confirmation. Used in jurisdictions requiring periodic consent renewal (e.g., GDPR soft opt-in).',
    `preference_last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when any preference field in this record was last modified. Used to track preference change history and recency.',
    `preference_source_system` STRING COMMENT 'The name of the source system or application from which this preference record originated (e.g., Blackbaud Raisers Edge, Slate CRM, Alumni Portal). Used for data lineage and integration troubleshooting.',
    `preferred_contact_method` STRING COMMENT 'The primary channel through which the alumnus prefers to be contacted. Used to route communications through the appropriate delivery system.. Valid values are `email|postal_mail|phone|sms|none`',
    `preferred_language` STRING COMMENT 'The language in which the alumnus prefers to receive communications. Supports multilingual outreach for international alumni populations.. Valid values are `en|es|fr|de|zh|ar`',
    `sms_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has consented to receive text messages (SMS) for event reminders, urgent updates, or brief announcements.',
    `spam_complaint_flag` BOOLEAN COMMENT 'Indicates whether the alumnus has marked institutional emails as spam. True if a spam complaint has been received. Triggers immediate suppression to protect sender reputation.',
    `spam_complaint_timestamp` TIMESTAMP COMMENT 'The date and time when the alumnus marked an institutional email as spam. Used for compliance reporting and sender reputation management.',
    `suppression_effective_date` DATE COMMENT 'The date on which the do-not-contact or do-not-solicit suppression became effective. Used to ensure compliance with suppression requests from the specified date forward.',
    `suppression_reason` STRING COMMENT 'Free-text explanation for why the alumnus is suppressed from communications. Captures context such as deceased status, legal request, or complaint history.',
    `unsubscribe_reason` STRING COMMENT 'Free-text or categorical reason provided by the alumnus for unsubscribing. Used for feedback analysis and communication strategy improvement.',
    `unsubscribe_timestamp` TIMESTAMP COMMENT 'The date and time when the alumnus unsubscribed from communications. Used to track opt-out events and ensure immediate suppression.',
    `volunteer_opportunities_opt_in` BOOLEAN COMMENT 'Indicates whether the alumnus has opted in to receive information about volunteer opportunities including mentoring, admissions support, career advising, and board service.',
    CONSTRAINT pk_alumni_communication_preference PRIMARY KEY(`alumni_communication_preference_id`)
) COMMENT 'Captures each alumnuss explicit communication preferences including preferred language, preferred contact method (email, postal mail, phone, SMS), frequency preferences (weekly, monthly, annual), topic opt-ins (career news, event invitations, fundraising appeals, institutional news), and global do-not-contact flag. Tracks consent timestamps and the source of consent (web form, phone, event). Supports FERPA-compliant outreach and CAN-SPAM/GDPR compliance for international alumni.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`affinity_group` (
    `affinity_group_id` BIGINT COMMENT 'Unique identifier for the affinity group. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Alumni chapters and affinity groups organized by program (MBA Alumni, Engineering Society, etc.) require FK for event targeting, engagement metrics, and program-specific fundraising campaigns. Replace',
    `alumnus_id` BIGINT COMMENT 'Unique identifier linking the chapter president to their alumnus record in the alumni master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Affinity groups often align with academic units/cost centers for budget and fundraising tracking. Creating affinity_group.cost_center_id to link to finance.cost_center for financial reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Affinity groups are reported by fiscal period for fundraising and engagement tracking. Creating affinity_group.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `employee_id` BIGINT COMMENT 'Unique identifier linking the staff liaison to their employee record in the human resources system.',
    `affinity_group_status` STRING COMMENT 'Current operational status of the affinity group in its lifecycle.. Valid values are `active|inactive|suspended|pending_approval|dissolved`',
    `annual_dues_amount` DECIMAL(18,2) COMMENT 'Standard annual membership dues amount charged to members of this affinity group, in USD. Null if no dues are required.',
    `annual_event_count` STRING COMMENT 'Number of events hosted by the affinity group in the current fiscal year. Key metric for chapter health assessment.',
    `associated_athletic_team` STRING COMMENT 'Name of the athletic team or sport supported by the affinity group (e.g., Football, Womens Basketball). Applicable to athletic booster clubs.',
    `charter_expiration_date` DATE COMMENT 'Date when the groups charter expires and requires renewal. Null for groups with perpetual charters.',
    `city` STRING COMMENT 'City where the affinity group is headquartered or primarily active.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the affinity group leadership or for general inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the affinity group leadership.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the primary country where the affinity group operates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the affinity group record was first created in the system.',
    `dues_required_flag` BOOLEAN COMMENT 'Indicates whether membership in this affinity group requires payment of dues. True if dues are required, False if membership is free.',
    `engagement_tier` STRING COMMENT 'Classification of the affinity groups engagement level based on activity metrics, event participation, and member involvement. Used for chapter health analysis and resource allocation.. Valid values are `platinum|gold|silver|bronze|emerging`',
    `founding_date` DATE COMMENT 'Date when the affinity group was officially established or chartered by the institution.',
    `geographic_region` STRING COMMENT 'Geographic area served by the affinity group (e.g., San Francisco Bay Area, Northeast Corridor, International - Europe). Applicable primarily to geographic chapters.',
    `group_code` STRING COMMENT 'Short alphanumeric code used to identify the affinity group in systems and reports.. Valid values are `^[A-Z0-9]{2,10}$`',
    `group_name` STRING COMMENT 'Official name of the affinity group, chapter, or alumni network as recognized by the institution.',
    `group_type` STRING COMMENT 'Classification of the affinity group by its organizing principle: geographic chapter (regional alumni clubs), academic college chapter (school/college-based), identity-based network (cultural, gender, LGBTQ+), athletic booster club (sports support), professional network (career/industry), or special interest (hobby, cause).. Valid values are `geographic_chapter|academic_college_chapter|identity_based_network|athletic_booster_club|professional_network|special_interest`',
    `last_event_date` DATE COMMENT 'Date of the most recent event hosted or sponsored by the affinity group. Used to track chapter activity and engagement.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the affinity group record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the affinity group record was last updated in the system.',
    `mailing_address_line1` STRING COMMENT 'First line of the mailing address for the affinity group (street address or P.O. Box).',
    `mailing_address_line2` STRING COMMENT 'Second line of the mailing address (suite, apartment, building, etc.). Nullable.',
    `mailing_city` STRING COMMENT 'City for the affinity groups mailing address.',
    `mailing_country_code` STRING COMMENT 'Three-letter ISO country code for the affinity groups mailing address.. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'Postal code or ZIP code for the affinity groups mailing address.',
    `mailing_state_province` STRING COMMENT 'State or province for the affinity groups mailing address.',
    `membership_count` STRING COMMENT 'Current number of active members enrolled in the affinity group. Updated periodically based on membership roster.',
    `mission_statement` STRING COMMENT 'Official mission statement or purpose description for the affinity group, articulating its goals and values.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the affinity group. Used by advancement staff for internal documentation.',
    `recognition_level` STRING COMMENT 'Institutional recognition level awarded to the affinity group based on performance criteria such as membership growth, event quality, fundraising, and volunteer engagement.. Valid values are `presidential|distinguished|standard|provisional`',
    `social_media_handle` STRING COMMENT 'Primary social media handle or username for the affinity group (e.g., Twitter, LinkedIn, Facebook). Format may vary by platform.',
    `state_province` STRING COMMENT 'State or province where the affinity group is primarily based. Applicable to domestic chapters.',
    `total_funds_raised_ytd` DECIMAL(18,2) COMMENT 'Total dollar amount raised by the affinity group in the current fiscal year through fundraising activities, in USD.',
    `website_url` STRING COMMENT 'Public website URL for the affinity group, if one exists. May be a dedicated site or a page on the institutional alumni portal.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_affinity_group PRIMARY KEY(`affinity_group_id`)
) COMMENT 'Defines the official alumni affinity groups, chapters, and networks recognized by the institution, and manages their membership rosters. Includes group name, type (geographic chapter, academic college chapter, identity-based network, athletic booster club, professional network), founding date, geographic region, associated college or school, active status, chapter president, and institutional staff liaison. Also captures individual membership records: member alumnus, membership start/end dates, role (member, officer, board member, chapter president), status (active, lapsed, honorary), enrollment method (self-enrolled, staff-assigned, event-triggered), and dues payment status. Supports chapter health analysis, officer succession planning, and engagement segmentation.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`group_membership` (
    `group_membership_id` BIGINT COMMENT 'Unique identifier for the group membership record. Primary key for the group membership entity.',
    `affinity_group_id` BIGINT COMMENT 'Reference to the affinity group or chapter to which the alumnus belongs. Links to the affinity group master record.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who holds this group membership. Links to the alumni master record.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Group memberships are tracked by fiscal period for affinity group reporting and dues tracking. Creating group_membership.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether this membership is set to automatically renew at the end of the current term. True means automatic renewal is enabled, false means manual renewal required.',
    `communication_preference` STRING COMMENT 'The preferred method of communication for this group membership. Indicates how the alumnus wishes to receive group-related communications and updates.. Valid values are `email|mail|phone|sms|none|all`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this membership record was first created in the system. Represents the initial capture of the membership relationship.',
    `dues_amount` DECIMAL(18,2) COMMENT 'The monetary amount of dues associated with this membership for the current period. May be zero for complimentary or honorary memberships.',
    `dues_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the dues amount. Typically USD for U.S. institutions but may vary for international chapters.. Valid values are `^[A-Z]{3}$`',
    `dues_paid_date` DATE COMMENT 'The date on which the membership dues were paid for the current period. Used to track payment timeliness and compliance.',
    `dues_payment_status` STRING COMMENT 'Current payment status of membership dues. Paid indicates full payment received, unpaid indicates no payment, waived indicates dues exempted, partial indicates incomplete payment, overdue indicates past due date, and pending indicates payment processing.. Valid values are `paid|unpaid|waived|partial|overdue|pending`',
    `election_date` DATE COMMENT 'The date on which the alumnus was elected to a leadership position within the affinity group. Applicable for elected officer roles.',
    `end_date` DATE COMMENT 'The date on which this membership ended or is scheduled to end. Null for active memberships with no defined end date. For annual memberships, represents the expiration date.',
    `events_attended_count` STRING COMMENT 'Total number of affinity group events attended by the alumnus since joining. Used to measure engagement level and chapter health.',
    `join_method` STRING COMMENT 'The mechanism by which the alumnus joined this affinity group. Self-enrolled indicates alumnus initiated, staff-assigned indicates advancement office action, event-triggered indicates automatic enrollment from event attendance, auto-assigned indicates system rule-based assignment, invitation-accepted indicates response to invitation, and application-approved indicates formal application process.. Valid values are `self_enrolled|staff_assigned|event_triggered|auto_assigned|invitation_accepted|application_approved`',
    `last_event_attended_date` DATE COMMENT 'The most recent date on which the alumnus attended an event hosted by this affinity group. Used to track recency of engagement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this membership record was most recently updated. Used for change tracking and data freshness assessment.',
    `last_renewed_date` DATE COMMENT 'The most recent date on which the alumnus renewed this membership. Tracks renewal history and engagement continuity.',
    `leadership_end_date` DATE COMMENT 'The date on which the alumnus completed or will complete their leadership term within the affinity group. Used for officer succession planning and historical tracking.',
    `leadership_start_date` DATE COMMENT 'The date on which the alumnus assumed a leadership role within the affinity group. Applicable only when membership_role indicates an officer or leadership position. Used for officer succession planning.',
    `membership_number` STRING COMMENT 'Externally-visible unique membership number or identifier assigned to this alumnus within the specific affinity group. May be used on membership cards or communications.',
    `membership_role` STRING COMMENT 'The role or position the alumnus holds within the affinity group. Distinguishes between general members and leadership positions such as officers, board members, or chapter presidents. [ENUM-REF-CANDIDATE: member|officer|board_member|chapter_president|vice_president|treasurer|secretary|committee_chair|honorary_member — 9 candidates stripped; promote to reference product]',
    `membership_status` STRING COMMENT 'Current lifecycle status of the membership. Active indicates current participation, lapsed indicates expired membership, honorary indicates special recognition status, suspended indicates temporary hold, pending indicates awaiting approval, and inactive indicates permanently ended.. Valid values are `active|lapsed|honorary|suspended|pending|inactive`',
    `membership_type` STRING COMMENT 'Classification of the membership indicating the category or tier. Regular is standard annual membership, lifetime is permanent membership, associate is non-graduate affiliate, emeritus is retired member, student is current student affiliate, and young alumni is recent graduate category.. Valid values are `regular|lifetime|associate|emeritus|student|young_alumni`',
    `nomination_date` DATE COMMENT 'The date on which the alumnus was nominated for membership or a leadership role within the affinity group. Used for governance and election tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this membership. May include special circumstances, historical context, or staff observations relevant to the membership relationship.',
    `opt_in_flag` BOOLEAN COMMENT 'Indicates whether the alumnus has explicitly opted in to receive communications and participate in activities for this affinity group. True means opted in, false means opted out.',
    `recognition_level` STRING COMMENT 'The recognition or tier level assigned to this membership based on engagement, giving, or service. Used for stewardship and recognition programs.. Valid values are `bronze|silver|gold|platinum|diamond|none`',
    `renewal_date` DATE COMMENT 'The date on which this membership is due for renewal. Used for annual or term-based memberships to track renewal cycles.',
    `source_system` STRING COMMENT 'The name of the operational system from which this membership record originated. Typically Blackbaud Raisers Edge or similar advancement CRM system.',
    `source_system_code` STRING COMMENT 'The unique identifier for this membership record in the source operational system. Used for data lineage and reconciliation.',
    `start_date` DATE COMMENT 'The date on which this membership became effective. Represents when the alumnus officially joined the affinity group.',
    `term_length_months` STRING COMMENT 'The length of the membership or leadership term in months. Used for term-based memberships and officer positions to calculate expiration and succession timing.',
    `volunteer_hours` DECIMAL(18,2) COMMENT 'Total number of volunteer hours contributed by the alumnus in their capacity as a member of this affinity group. Used to track engagement and recognize service.',
    CONSTRAINT pk_group_membership PRIMARY KEY(`group_membership_id`)
) COMMENT 'Association entity recording which alumni belong to which affinity groups or chapters. Captures membership start date, end date, membership role (member, officer, board member, chapter president), membership status (active, lapsed, honorary), how the alumnus joined (self-enrolled, staff-assigned, event-triggered), and dues payment status where applicable. Enables analysis of chapter health, officer succession, and engagement by affinity segment.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`engagement_activity` (
    `engagement_activity_id` BIGINT COMMENT 'Unique identifier for each engagement activity record. Primary key for the engagement activity entity.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who participated in this engagement activity. Links to the alumni master record.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising or engagement campaign associated with this activity. Nullable for activities not tied to a specific campaign.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Advancement offices track which CRM/donor management system (Raisers Edge, Salesforce Education Cloud, Ellucian Advance) recorded each engagement activity for system-of-record attribution, data quali',
    `event_id` BIGINT COMMENT 'Reference to the specific event record if this activity represents attendance at or participation in a scheduled event. Nullable for non-event activities.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Engagement activities occur in specific fiscal periods for donor relations tracking and reporting. Creating engagement_activity.fiscal_period_id to link to finance.fiscal_period for period-based repor',
    `employee_id` BIGINT COMMENT 'Reference to the advancement or alumni relations staff member who recorded or facilitated this engagement activity. Tracks ownership and accountability for relationship management.',
    `mentorship_program_id` BIGINT COMMENT 'Reference to the alumni relations or advancement program under which this activity was conducted. Examples include annual giving programs, volunteer programs, or career services initiatives.',
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
    `affinity_group_id` BIGINT COMMENT 'Foreign key linking to advancement.affinity_group. Business justification: alumni_event has a STRING attribute affinity_group that should be normalized to a FK relationship. An alumni event is typically organized by or for a specific affinity group/chapter. This creates pr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Alumni events are often hosted by academic units/cost centers for budget and expense tracking. Creating alumni_event.cost_center_id to link to finance.cost_center for event cost allocation.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Alumni events occur in specific fiscal periods for budget and expense tracking. Creating alumni_event.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `actual_attendance` STRING COMMENT 'Final count of attendees who participated in the event. Populated after event completion for ROI (Return on Investment) analysis and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first created in the system. Used for audit trail and event planning timeline analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts (e.g., USD, CAD, GBP). Supports international events with local pricing.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Format of event delivery. In-person requires physical venue; virtual is online-only; hybrid offers both options simultaneously.. Valid values are `in_person|virtual|hybrid`',
    `early_registration_deadline` DATE COMMENT 'Deadline for early-bird registration pricing. Used to incentivize advance commitments and improve planning accuracy.',
    `early_registration_fee` DECIMAL(18,2) COMMENT 'Discounted registration cost for attendees who register before the early deadline, in US dollars.',
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
    `guest_registration_fee` DECIMAL(18,2) COMMENT 'Cost for non-alumni guests (spouses, partners, friends) to attend the event, in US dollars.',
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
    `standard_registration_fee` DECIMAL(18,2) COMMENT 'Base cost for an individual to attend the event, in US dollars. Zero indicates a free event.',
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
    `payment_amount` DECIMAL(18,2) COMMENT 'Total monetary amount paid or due for the registration, including all tickets and guests. Expressed in the institutions base currency (USD).',
    `payment_date` DATE COMMENT 'Date when payment was received or processed for the registration.',
    `payment_method` STRING COMMENT 'Instrument used for payment (e.g., credit card, bank transfer, check, cash, complimentary waiver). Distinct from payment channel.',
    `payment_status` STRING COMMENT 'Current status of payment for the registration. Tracks whether payment has been received, is outstanding, or has been refunded.. Valid values are `paid|pending|refunded|waived|failed|partial`',
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

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`volunteer_role` (
    `volunteer_role_id` BIGINT COMMENT 'Unique identifier for the volunteer role. Primary key for the volunteer role catalog.',
    `active_status` STRING COMMENT 'Current lifecycle status of the volunteer role. Active roles are available for volunteer assignment; inactive roles are not currently recruiting.. Valid values are `active|inactive|suspended|under_review|archived`',
    `application_required` BOOLEAN COMMENT 'Indicates whether volunteers must submit a formal application to be considered for this role. False indicates open enrollment or staff assignment.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether volunteer assignments to this role require formal approval by advancement staff or leadership. True for high-visibility or sensitive roles.',
    `associated_program` STRING COMMENT 'The specific volunteer program or initiative this role supports (e.g., Alumni Admissions Network, Career Connections Program, Annual Fund Leadership Council).',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether volunteers in this role must complete a background check before service. True for roles involving minors or sensitive institutional access.',
    `benefits_description` STRING COMMENT 'Description of benefits, recognition, or perks provided to volunteers in this role (e.g., Invitation to annual volunteer recognition dinner, Professional development opportunities, Networking access).',
    `capacity_target` STRING COMMENT 'Target number of volunteers needed to fill this role across the institution. Used for recruitment planning and capacity management.',
    `created_date` DATE COMMENT 'Date when this volunteer role record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this volunteer role definition was retired or superseded. Null indicates the role is currently active.',
    `effective_start_date` DATE COMMENT 'Date when this volunteer role definition became active and available for volunteer assignment. Used for historical tracking of role evolution.',
    `geographic_restriction` STRING COMMENT 'Geographic limitations for volunteer service in this role (e.g., Local area only, Regional chapters, No restriction). Used for volunteer matching and assignment.',
    `impact_statement` STRING COMMENT 'Statement describing the institutional impact and value of this volunteer role. Used in recruitment materials to inspire volunteer engagement.',
    `last_modified_date` DATE COMMENT 'Date when this volunteer role record was most recently updated. Used for change tracking and data quality monitoring.',
    `last_reviewed_date` DATE COMMENT 'Date when this volunteer role definition was last reviewed by advancement staff for accuracy and relevance. Used to ensure role catalog currency.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this volunteer role definition. Used for proactive role catalog maintenance.',
    `owning_office` STRING COMMENT 'The institutional office or department responsible for managing this volunteer role (e.g., Office of Alumni Relations, Office of Admissions, Career Services, Annual Giving).',
    `preferred_qualifications` STRING COMMENT 'Desired but not mandatory qualifications that would enhance volunteer effectiveness in this role (e.g., Leadership experience, Public speaking skills, Industry expertise).',
    `remote_eligible` BOOLEAN COMMENT 'Indicates whether this volunteer role can be performed remotely or requires on-campus presence. True enables broader geographic volunteer participation.',
    `reporting_relationship` STRING COMMENT 'Description of the staff member or committee to whom volunteers in this role report (e.g., Director of Alumni Relations, Regional Volunteer Coordinator, Annual Fund Manager).',
    `required_qualifications` STRING COMMENT 'Mandatory qualifications, credentials, or prerequisites for volunteers to serve in this role (e.g., Must be alumnus/alumna, Minimum 5 years professional experience, Background check required).',
    `role_category` STRING COMMENT 'Primary classification of the volunteer role by functional area. Determines the type of engagement and reporting hierarchy. [ENUM-REF-CANDIDATE: admissions_ambassador|career_mentor|class_agent|reunion_committee|advisory_board|scholarship_interviewer|phonathon_caller|event_volunteer|student_mentor|fundraising_volunteer|other — 11 candidates stripped; promote to reference product]',
    `role_code` STRING COMMENT 'Short alphanumeric code used for internal reference and reporting (e.g., ADM-AMB, CAR-MEN, CLS-AGT).',
    `role_description` STRING COMMENT 'Comprehensive description of the volunteer role including responsibilities, expectations, and impact. Used for volunteer recruitment and orientation materials.',
    `role_name` STRING COMMENT 'The official name of the volunteer role as presented to alumni and volunteers (e.g., Admissions Ambassador, Career Mentor, Class Agent, Reunion Committee Member).',
    `role_subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the role category (e.g., within Career Mentor: Industry Mentor, Mock Interview Coach, Resume Reviewer).',
    `term_length_months` STRING COMMENT 'Standard length of service term for this volunteer role in months (e.g., 12 for one-year term, 36 for three-year term). Null indicates ongoing or flexible term.',
    `time_commitment_estimate` STRING COMMENT 'Expected time commitment for the volunteer role expressed in hours per month, hours per year, or descriptive terms (e.g., 2-4 hours per month, 10 hours annually, Flexible).',
    `time_commitment_hours_max` DECIMAL(18,2) COMMENT 'Maximum estimated hours per year expected for this volunteer role. Used for volunteer matching and capacity planning.',
    `time_commitment_hours_min` DECIMAL(18,2) COMMENT 'Minimum estimated hours per year required for this volunteer role. Used for volunteer matching and capacity planning.',
    `training_description` STRING COMMENT 'Description of required training programs, modules, or orientation sessions volunteers must complete (e.g., FERPA training, Admissions interview protocol, Fundraising ethics).',
    `training_required` BOOLEAN COMMENT 'Indicates whether volunteers must complete formal training before beginning service in this role. True for roles requiring specific knowledge or compliance training.',
    `visibility_status` STRING COMMENT 'Controls who can view and apply for this volunteer role in self-service portals. Public roles appear on public website; invitation-only roles require staff nomination.. Valid values are `public|alumni_only|invitation_only|internal`',
    CONSTRAINT pk_volunteer_role PRIMARY KEY(`volunteer_role_id`)
) COMMENT 'Defines the catalog of volunteer roles available to alumni within institutional programs. Captures role name, role category (admissions ambassador, career mentor, class agent, reunion committee, advisory board member, scholarship interviewer, phonathon caller), associated program or office, time commitment estimate, required qualifications, active status, and role description. Serves as the reference for volunteer assignment and tracking.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`volunteer_assignment` (
    `volunteer_assignment_id` BIGINT COMMENT 'Unique identifier for the volunteer assignment record. Primary key for the volunteer assignment entity.',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Alumni volunteers serving in official institutional capacities (admissions interviewers, mentors, board members) may request ADA accommodations for participation. Required for compliance with ADA Titl',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who is assigned to this volunteer role. Links to the alumni master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Volunteer assignments often support academic units/cost centers. Creating volunteer_assignment.cost_center_id to link to finance.cost_center for program cost allocation and reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member who coordinates and manages this volunteer assignment. Used for accountability and communication.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Volunteer assignments are tracked by fiscal period for program reporting and cost allocation. Creating volunteer_assignment.fiscal_period_id to link to finance.fiscal_period for period-based reporting',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Faculty PIs volunteer for advancement activities (advisory boards, fundraising events, donor cultivation). Advancement tracks faculty engagement for recognition, stewardship, and volunteer management.',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: Volunteers requiring IT support (VPN access for remote mentoring, application training, equipment loans for events) generate service requests that link to volunteer context for prioritization, cost tr',
    `volunteer_role_id` BIGINT COMMENT 'Reference to the volunteer role catalog entry that defines the role type, requirements, and program association.',
    `assignment_end_date` DATE COMMENT 'The date when the volunteer assignment officially ends or is scheduled to end. Nullable for open-ended assignments.',
    `assignment_notes` STRING COMMENT 'General free-text notes about the volunteer assignment, including special arrangements, preferences, or contextual information.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for the volunteer assignment, formatted as VA- followed by 8 digits. Used for tracking and reporting purposes.. Valid values are `^VA-[0-9]{8}$`',
    `assignment_start_date` DATE COMMENT 'The date when the volunteer assignment officially begins. Used for tenure calculation and capacity planning.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the volunteer assignment. Active indicates the volunteer is currently serving; completed indicates the assignment has ended successfully; on-hold indicates temporary suspension; cancelled indicates early termination; pending indicates awaiting start.. Valid values are `active|completed|on-hold|cancelled|pending`',
    `background_check_date` DATE COMMENT 'The date when the background check was completed or cleared. Nullable if not yet completed or not required.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether a background check is required for this volunteer assignment (e.g., for roles involving minors or sensitive data). True if required; false otherwise.',
    `background_check_status` STRING COMMENT 'Current status of the background check for this volunteer assignment. Not-required if no check is needed; pending if in progress; cleared if approved; flagged if issues identified.. Valid values are `not-required|pending|cleared|flagged`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this volunteer assignment record was first created in the system. Used for audit trail and data lineage.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Calculated engagement score for this volunteer assignment based on hours served, performance, and impact. Used for advancement qualification and major gift prospect identification.',
    `hours_served` DECIMAL(18,2) COMMENT 'Total number of volunteer hours served by the alumnus in this assignment. Used for recognition programs and engagement scoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this volunteer assignment record was last updated. Used for audit trail and change tracking.',
    `performance_notes` STRING COMMENT 'Free-text notes documenting the volunteers performance, contributions, challenges, and feedback. Used for stewardship and future assignment planning.',
    `performance_rating` STRING COMMENT 'Overall performance assessment of the volunteer in this assignment. Used for future assignment decisions and recognition.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|not-rated`',
    `recognition_awarded_flag` BOOLEAN COMMENT 'Indicates whether formal recognition (award, certificate, event invitation) has been awarded for this volunteer assignment. True if awarded; false otherwise.',
    `recognition_date` DATE COMMENT 'The date when formal recognition was awarded to the volunteer for this assignment. Nullable if not yet awarded.',
    `recognition_level` STRING COMMENT 'Recognition tier awarded to the volunteer based on hours served, impact, and tenure. Used for stewardship and awards programs.. Valid values are `bronze|silver|gold|platinum|lifetime`',
    `renewal_date` DATE COMMENT 'The date when the volunteer assignment was renewed or is scheduled for renewal review. Nullable if not applicable.',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether the volunteer is eligible for renewal of this assignment upon completion. True if eligible; false otherwise.',
    `termination_notes` STRING COMMENT 'Free-text notes documenting the circumstances and details of the assignment termination. Used for stewardship and future engagement planning.',
    `termination_reason` STRING COMMENT 'The reason why the volunteer assignment ended or was terminated. Used for retention analysis and program improvement.. Valid values are `completed-term|personal-reasons|performance-issues|role-eliminated|volunteer-request|other`',
    `time_commitment_hours` DECIMAL(18,2) COMMENT 'Estimated or expected number of hours per month or per assignment period that the volunteer role requires. Used for capacity planning and volunteer recruitment.',
    `training_completed_flag` BOOLEAN COMMENT 'Indicates whether the volunteer has completed required training for this assignment. True if training is complete; false otherwise.',
    `training_completion_date` DATE COMMENT 'The date when the volunteer completed required training for this assignment. Nullable if training is not yet complete.',
    CONSTRAINT pk_volunteer_assignment PRIMARY KEY(`volunteer_assignment_id`)
) COMMENT 'Manages the full alumni volunteer lifecycle including the catalog of available volunteer roles and individual assignment records. Role catalog captures: role name, category (admissions ambassador, career mentor, class agent, reunion committee, advisory board member, scholarship interviewer, phonathon caller), associated program or office, time commitment estimate, required qualifications, and active status. Assignment records capture: alumnus reference, assigned role, assignment start/end dates, hours served, assignment status (active, completed, on-hold), performance notes, and recognition level (bronze, silver, gold, lifetime). Supports volunteer recruitment, capacity planning, recognition programs, and engagement scoring for advancement qualification.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`career_record` (
    `career_record_id` BIGINT COMMENT 'Unique identifier for the alumni career record. Primary key for the career history tracking system.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program from which the alumni graduated. Links career outcomes to specific degree programs for program-level ROI analysis and accreditation reporting.',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Career outcomes data (employment rates, salary ranges, job placement timelines) are REQUIRED accreditation evidence for ABET, ACBSP, CACREP, and other specialized accreditors. Direct link needed for d',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumni individual whose career is being tracked. Links to the alumni master record in the advancement domain.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Accreditation bodies (ABET, regional accreditors) require employment outcome reporting by specific program and course sequences. Linking career records to course sections enables program-level effecti',
    `survey_response_id` BIGINT COMMENT 'Reference to the alumni survey response that provided this career information. Links career data to broader alumni engagement and satisfaction surveys for integrated analysis.',
    `career_field_alignment` STRING COMMENT 'Assessment of how closely the position aligns with the alumnis degree program. Used for program effectiveness evaluation and accreditation reporting to AACSB, ABET, and other specialized accreditors.. Valid values are `directly-related|related|unrelated|unknown`',
    `career_notes` STRING COMMENT 'Free-text field for additional context about the career position, including special achievements, awards, promotions, or unique circumstances. Supports personalized alumni engagement and success story identification.',
    `cip_code` STRING COMMENT 'Six-digit CIP code of the degree program associated with this career record. Enables standardized career outcomes reporting by academic discipline for IPEDS and accreditation.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `company_website` STRING COMMENT 'Official website URL of the employer organization. Supports employer research, corporate partnership development, and validation of employer information.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this career record was first created in the system. Supports data lineage tracking and audit trail requirements under FERPA (Family Educational Rights and Privacy Act).',
    `data_collection_method` STRING COMMENT 'Specific method used to collect the career information. Distinguishes between online forms, phone interviews, email surveys, LinkedIn API integration, manual data entry by staff, or batch imports. Used for data quality assessment and process improvement.. Valid values are `online-form|phone-interview|email-survey|linkedin-api|manual-entry|batch-import`',
    `data_source` STRING COMMENT 'Origin of the career information. Indicates whether data was self-reported by alumni, imported from LinkedIn, collected via survey, provided by career services, verified by employer, or obtained from third-party sources. Critical for data quality assessment.. Valid values are `self-reported|linkedin-import|survey|career-services|employer-verification|third-party`',
    `employer_industry_code` STRING COMMENT 'Six-digit NAICS code classifying the employers primary industry sector. Used for career field analysis and accreditation reporting to AACSB and ABET.. Valid values are `^[0-9]{2,6}$`',
    `employer_name` STRING COMMENT 'Full legal or commonly recognized name of the organization employing the alumni. Supports career outcomes reporting and employer relationship tracking.',
    `employer_size_category` STRING COMMENT 'Classification of employer organization size. Startup (1-50 employees), Small (51-500), Medium (501-5000), Large (5001-50000), Enterprise (50000+). Supports employer relationship strategy and career outcomes diversity analysis.. Valid values are `startup|small|medium|large|enterprise`',
    `employment_city` STRING COMMENT 'City where the alumni is employed. Supports geographic distribution analysis and regional alumni engagement strategies.',
    `employment_country` STRING COMMENT 'Three-letter ISO country code where the alumni is employed. Supports international alumni tracking and global career outcomes reporting.. Valid values are `^[A-Z]{3}$`',
    `employment_state_province` STRING COMMENT 'Two-letter state or province code where the alumni is employed. Follows USPS state abbreviations for US locations and ISO 3166-2 for international.. Valid values are `^[A-Z]{2}$`',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement. Distinguishes between full-time, part-time, self-employed, contract, academic positions, and internships for FTE (Full-Time Equivalent) calculations and outcomes reporting.. Valid values are `full-time|part-time|self-employed|contract|academic|internship`',
    `end_date` DATE COMMENT 'Date the alumni ended employment in this position. Null for current positions. Supports career mobility and retention analysis.',
    `is_current_position` BOOLEAN COMMENT 'Flag indicating whether this is the alumnis current employment position. True for active employment, false for historical positions.',
    `is_featured_success_story` BOOLEAN COMMENT 'Flag indicating whether this career record has been selected as a featured alumni success story for marketing, recruitment, or advancement communications. Supports storytelling and donor engagement initiatives.',
    `is_self_employed` BOOLEAN COMMENT 'Flag indicating whether the alumni is self-employed or operates their own business. Supports entrepreneurship tracking and specialized alumni engagement programs for business owners.',
    `is_stem_position` BOOLEAN COMMENT 'Flag indicating whether the position is classified as a STEM career. Used for STEM program outcomes reporting, federal grant compliance (NSF, NIH), and specialized accreditation (ABET).',
    `job_function_category` STRING COMMENT 'Broad functional area of the position such as Engineering, Marketing, Finance, Operations, Research, Education, Healthcare, Legal, or Technology. Supports career pathway analysis and alumni networking by professional interest.',
    `job_title` STRING COMMENT 'Official position title held by the alumni at the employer organization. Captures role level and functional area for career progression analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this career record was most recently updated. Tracks data currency and supports change detection for downstream analytics and reporting systems.',
    `last_verified_date` DATE COMMENT 'Date when the career information was last verified or confirmed as accurate. Used to assess data freshness and prioritize outreach for data updates.',
    `linkedin_profile_url` STRING COMMENT 'URL to the alumnis LinkedIn profile. Enables automated career data updates via LinkedIn API integration and supports alumni professional networking initiatives.. Valid values are `^https://www.linkedin.com/in/[a-zA-Z0-9_-]+/?$`',
    `position_sequence_number` STRING COMMENT 'Sequential number indicating the order of this position in the alumnis career history. First position after graduation is 1, second is 2, etc. Supports career mobility and progression analysis.',
    `record_status` STRING COMMENT 'Current lifecycle status of the career record. Active records are current and verified, archived records are historical, pending-verification records await confirmation, disputed records have data quality issues, and deleted records are soft-deleted for audit purposes.. Valid values are `active|archived|pending-verification|disputed|deleted`',
    `remote_work_status` STRING COMMENT 'Classification of work location arrangement. Captures whether position is on-site, hybrid, or fully remote. Relevant for post-pandemic career outcomes analysis and alumni geographic engagement.. Valid values are `on-site|hybrid|fully-remote|not-specified`',
    `salary_range_band` STRING COMMENT 'Categorical salary range for the position. Collected in bands to protect privacy while enabling ROI (Return on Investment) and career outcomes analysis for accreditation.. Valid values are `under-30k|30k-50k|50k-75k|75k-100k|100k-150k|over-150k`',
    `seniority_level` STRING COMMENT 'Career level classification of the position. Tracks alumni career progression and leadership attainment for advancement engagement and program effectiveness metrics.. Valid values are `entry-level|mid-level|senior|executive|c-suite`',
    `start_date` DATE COMMENT 'Date the alumni began employment in this position. Used to calculate time-to-employment metrics and career tenure analysis.',
    `supervisor_title` STRING COMMENT 'Job title of the alumnis direct supervisor or manager. Provides organizational context and supports alumni networking by identifying potential mentors or senior alumni connections.',
    `years_to_position` DECIMAL(18,2) COMMENT 'Calculated number of years from degree completion to the start of this position. Used for time-to-employment metrics and career progression analysis for accreditation and program evaluation.',
    CONSTRAINT pk_career_record PRIMARY KEY(`career_record_id`)
) COMMENT 'Tracks the professional career history and current employment status of alumni. Captures employer name, employer industry (NAICS code), job title, employment type (full-time, part-time, self-employed, academic), start date, end date, city/state/country of employment, salary range band, career field alignment with degree (related/unrelated), data source (alumni self-reported, LinkedIn import, survey), and last verified date. Supports career outcomes reporting, accreditation data (AACSB, ABET), and alumni career services.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`advanced_degree` (
    `advanced_degree_id` BIGINT COMMENT 'Unique identifier for the advanced degree record. Primary key for this entity.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who earned this advanced degree at an external institution after leaving this institution.',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Alumni advanced degree tracking for outcomes assessment and prospect research (wealth screening) requires proper CIP classification. Enables analysis of graduate school pathways by field and STEM desi',
    `awarding_institution_city` STRING COMMENT 'The city where the awarding institution is located.',
    `awarding_institution_country` STRING COMMENT 'The three-letter ISO country code of the country where the awarding institution is located (e.g., USA, GBR, CAN, AUS).. Valid values are `^[A-Z]{3}$`',
    `awarding_institution_ipeds_code` STRING COMMENT 'The six-digit IPEDS Unit ID (UNITID) that uniquely identifies the awarding institution in the federal postsecondary education database.. Valid values are `^[0-9]{6}$`',
    `awarding_institution_name` STRING COMMENT 'The full official name of the external institution that conferred this advanced degree to the alumnus.',
    `awarding_institution_state` STRING COMMENT 'The state, province, or region where the awarding institution is located (applicable for USA, Canada, and other federated countries).',
    `awarding_institution_type` STRING COMMENT 'The institutional control or sector classification of the awarding institution (public, private nonprofit, private for-profit, or foreign).. Valid values are `public|private_nonprofit|private_for_profit|foreign`',
    `career_relevance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this advanced degree is directly relevant to the alumnus current or intended career path, used for career outcomes analysis.',
    `concentration_specialization` STRING COMMENT 'The specific concentration, specialization, track, or focus area within the broader field of study (e.g., Finance concentration within MBA, Artificial Intelligence specialization within Computer Science PhD).',
    `created_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this advanced degree record was first created in the system (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `data_source` STRING COMMENT 'The source from which this advanced degree information was obtained (e.g., alumni survey, LinkedIn, National Student Clearinghouse, prospect research, direct alumnus report, institutional partnership).',
    `degree_level` STRING COMMENT 'The level of the advanced degree earned (masters, doctoral, professional such as JD/MD/MBA, post-doctoral, graduate certificate, or specialist degree).. Valid values are `masters|doctoral|professional|post_doctoral|graduate_certificate|specialist`',
    `degree_record_number` STRING COMMENT 'Business identifier for this advanced degree record, used for tracking and reference in advancement systems.',
    `degree_status` STRING COMMENT 'The current status of the advanced degree record (completed and verified, in progress, withdrawn, deferred, verified by institution, or unverified self-reported).. Valid values are `completed|in_progress|withdrawn|deferred|verified|unverified`',
    `degree_title` STRING COMMENT 'The full official title of the degree as conferred by the awarding institution (e.g., Master of Business Administration, Doctor of Philosophy in Computer Science).',
    `degree_type` STRING COMMENT 'The specific type or abbreviation of the degree earned (e.g., MBA, PhD, JD, MD, MS, MA, EdD, DBA, MFA, MPH).',
    `enrollment_start_year` STRING COMMENT 'The calendar year in which the alumnus began enrollment in the advanced degree program at the awarding institution.',
    `field_of_study` STRING COMMENT 'The primary academic discipline or field of study for the advanced degree (e.g., Computer Science, Business Administration, Medicine, Law, Engineering).',
    `funding_source` STRING COMMENT 'The primary source of funding for the advanced degree program (e.g., self-funded, employer-sponsored, fellowship, assistantship, scholarship, research grant).',
    `graduation_date` DATE COMMENT 'The specific date on which the advanced degree was officially conferred (format: yyyy-MM-dd).',
    `graduation_year` STRING COMMENT 'The calendar year in which the alumnus graduated and was conferred the advanced degree.',
    `honors_distinction` STRING COMMENT 'Any honors, distinctions, or special recognitions received with the advanced degree (e.g., summa cum laude, magna cum laude, with distinction, departmental honors).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this advanced degree record was most recently updated or modified (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `major_advisor_name` STRING COMMENT 'The name of the primary faculty advisor, dissertation chair, or thesis supervisor who guided the alumnus through the advanced degree program.',
    `notes` STRING COMMENT 'Free-text notes or additional context about the advanced degree, including any special circumstances, clarifications, or supplementary information.',
    `prospect_research_flag` BOOLEAN COMMENT 'Boolean indicator of whether this advanced degree record was obtained through prospect research activities for fundraising purposes.',
    `record_created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this advanced degree record.',
    `record_created_date` DATE COMMENT 'The date on which this advanced degree record was first created in the system (format: yyyy-MM-dd).',
    `record_last_modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that most recently modified this advanced degree record.',
    `record_last_modified_date` DATE COMMENT 'The date on which this advanced degree record was most recently updated or modified (format: yyyy-MM-dd).',
    `thesis_dissertation_title` STRING COMMENT 'The title of the thesis, dissertation, or capstone project completed as part of the advanced degree requirements (applicable primarily to masters and doctoral degrees).',
    `verification_date` DATE COMMENT 'The date on which the advanced degree information was officially verified through external documentation or institutional confirmation (format: yyyy-MM-dd).',
    `verification_method` STRING COMMENT 'The method used to verify the advanced degree information (e.g., official transcript, National Student Clearinghouse, institutional registrar confirmation, LinkedIn profile, alumni survey).',
    `verification_status` STRING COMMENT 'Indicates whether the advanced degree information has been verified through official transcripts or institutional confirmation, or is self-reported by the alumnus.. Valid values are `verified|self_reported|pending_verification|unable_to_verify`',
    CONSTRAINT pk_advanced_degree PRIMARY KEY(`advanced_degree_id`)
) COMMENT 'Records post-baccalaureate and advanced degrees earned by alumni at other institutions after leaving this institution. Captures degree level (masters, doctoral, professional — JD, MD, MBA), degree type, awarding institution name, field of study, CIP code, graduation year, and data source. Distinct from the curriculum domains degree records (which track degrees earned HERE) — this captures external educational attainment for alumni outcomes reporting and prospect research.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`mentorship_program` (
    `mentorship_program_id` BIGINT COMMENT 'Unique identifier for the mentorship program. Primary key for the mentorship program entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Mentorship programs are often run by academic units/cost centers. Creating mentorship_program.cost_center_id to link to finance.cost_center for program budget and expense tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who serves as the primary coordinator and point of contact for the mentorship program. Responsible for program administration, participant support, and outcome tracking.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Mentorship programs run in specific fiscal periods for budget and program tracking. Creating mentorship_program.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic college, school, or administrative unit that sponsors and oversees this mentorship program. May be a college of business, engineering, arts and sciences, or a central alumni relations office.',
    `owning_org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Mentorship programs are institutional engagement initiatives requiring org hierarchy linkage for budget ownership, program performance reporting by college/department, resource allocation, and alumni ',
    `application_close_date` DATE COMMENT 'The date when applications for the mentorship program close for the current cycle. After this date, no new applications are accepted until the next cycle.',
    `application_open_date` DATE COMMENT 'The date when applications for the mentorship program open for the current cycle. Used to manage enrollment windows and communications.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether mentors must pass a background check before participating in the program. Typically required for programs involving current students or minors. True if required, false if not required.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total budget allocated to operate the mentorship program for the current fiscal year, including staff time, marketing, events, technology platform costs, and participant support. Amount in institutional base currency.',
    `contact_email` STRING COMMENT 'Primary email address for inquiries about the mentorship program. Typically monitored by the program coordinator or advancement office staff.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for inquiries about the mentorship program. Organizational contact information for the program office.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this mentorship program record was first created in the system. Used for audit trail and data lineage tracking.',
    `eligibility_criteria` STRING COMMENT 'Requirements that alumni or students must meet to participate in the program as mentors or mentees, such as graduation year, degree level, professional experience, geographic location, or membership status.',
    `funding_source` STRING COMMENT 'Description of how the mentorship program is funded, such as institutional operating budget, endowment income, donor-restricted gifts, participant fees, or corporate sponsorship.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this mentorship program record was most recently updated. Used for audit trail, change tracking, and data quality monitoring.',
    `matching_criteria` STRING COMMENT 'Detailed description of the criteria used to match mentors and mentees, such as industry sector, career stage, geographic location, academic major, demographic factors, professional interests, and personal goals.',
    `matching_methodology` STRING COMMENT 'The method used to pair mentors with mentees. Staff-matched programs have advancement staff manually review profiles and create matches. Self-selected programs allow participants to browse and choose their own matches. Algorithm-matched programs use automated matching based on criteria such as industry, location, interests, and goals. Hybrid programs combine multiple approaches.. Valid values are `staff-matched|self-selected|algorithm-matched|hybrid`',
    `maximum_mentee_capacity` STRING COMMENT 'The maximum number of mentees that can be enrolled in the program during a single cycle. Used for capacity planning and application management.',
    `maximum_mentor_capacity` STRING COMMENT 'The maximum number of mentors that can be enrolled in the program during a single cycle. Used for capacity planning and recruitment management.',
    `orientation_required_flag` BOOLEAN COMMENT 'Indicates whether participants must complete an orientation session before beginning their mentorship relationship. True if orientation is mandatory, false if optional or not offered.',
    `program_code` STRING COMMENT 'Short alphanumeric code used to uniquely identify the program in operational systems and reporting. Typically 4-12 characters.. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_cycle` STRING COMMENT 'The operational cycle or term structure for the mentorship program. Academic year programs run September through May. Semester programs align with fall or spring terms. Rolling programs accept applications and match participants continuously throughout the year.. Valid values are `academic year|fall semester|spring semester|summer term|rolling|calendar year`',
    `program_description` STRING COMMENT 'Comprehensive description of the mentorship programs purpose, goals, structure, and benefits. Used in marketing materials, program catalogs, and participant communications.',
    `program_duration_months` STRING COMMENT 'The standard length of a mentorship relationship in this program, measured in months. Common durations are 6, 9, or 12 months.',
    `program_end_date` DATE COMMENT 'The date when the mentorship program was permanently closed or archived, if applicable. Null for active or ongoing programs.',
    `program_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged to participants to enroll in the mentorship program, if applicable. Zero or null if the program is offered at no cost. Amount in institutional base currency.',
    `program_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the program fee amount. Typically USD for U.S. institutions.. Valid values are `^[A-Z]{3}$`',
    `program_launch_date` DATE COMMENT 'The date when the mentorship program was first launched and began accepting participants. Used for historical tracking and program maturity analysis.',
    `program_name` STRING COMMENT 'The official name of the mentorship program as it appears in institutional communications and marketing materials.',
    `program_notes` STRING COMMENT 'Free-form text field for additional information, special considerations, historical context, or operational notes about the mentorship program that do not fit in other structured fields.',
    `program_objectives` STRING COMMENT 'Specific learning and development objectives that the program aims to achieve for participants, such as career advancement, skill development, network expansion, or leadership growth.',
    `program_status` STRING COMMENT 'Current operational status of the mentorship program. Active programs are currently accepting applications and matching participants. Inactive programs are not currently running but may resume. Suspended programs are temporarily paused. Planning programs are in development. Archived programs are permanently closed.. Valid values are `active|inactive|suspended|planning|archived`',
    `program_type` STRING COMMENT 'Classification of the mentorship program by its primary focus area. Career mentorship supports professional development, academic mentorship supports scholarly pursuits, entrepreneurship supports startup and business ventures, diversity and inclusion supports underrepresented populations, peer mentorship connects alumni of similar experience levels, and executive mentorship connects senior leaders with emerging leaders.. Valid values are `career mentorship|academic mentorship|entrepreneurship|diversity and inclusion|peer mentorship|executive mentorship`',
    `program_website_url` STRING COMMENT 'The web address where prospective participants can learn more about the program, view requirements, and submit applications.. Valid values are `^https?://.*$`',
    `scholarship_available_flag` BOOLEAN COMMENT 'Indicates whether financial assistance or fee waivers are available for participants who cannot afford the program fee. True if scholarships are offered, false if not.',
    `success_metrics` STRING COMMENT 'Key performance indicators (KPIs) used to measure program effectiveness, such as participant satisfaction scores, match completion rates, career advancement outcomes, or engagement levels.',
    `target_audience` STRING COMMENT 'Description of the intended participant population for the program, such as recent graduates, mid-career professionals, executive leaders, students from specific majors, or alumni from underrepresented groups.',
    `time_commitment_hours` DECIMAL(18,2) COMMENT 'Expected number of hours per month or per cycle that participants should commit to the mentorship relationship. Used to set expectations and ensure program quality.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether mentors must complete formal training before being matched with mentees. True if training is mandatory, false if optional or not offered.',
    `virtual_participation_allowed_flag` BOOLEAN COMMENT 'Indicates whether mentorship relationships can be conducted entirely remotely via video conferencing, phone, and email. True if virtual participation is permitted, false if in-person meetings are required.',
    CONSTRAINT pk_mentorship_program PRIMARY KEY(`mentorship_program_id`)
) COMMENT 'Defines the institutions formal alumni mentorship programs. Captures program name, program type (career mentorship, academic mentorship, entrepreneurship, diversity and inclusion), sponsoring college or office, program cycle (academic year, semester, rolling), maximum mentee capacity, application open/close dates, matching methodology (staff-matched, self-selected, algorithm-matched), active status, and program coordinator. Serves as the catalog for mentorship enrollment and matching.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`mentorship_match` (
    `mentorship_match_id` BIGINT COMMENT 'Unique identifier for the mentorship match record. Primary key for the mentorship match entity.',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Student mentees may have ADA accommodations that must be communicated to alumni mentors (communication format preferences, meeting accessibility needs). Required for program compliance and to ensure e',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Many institutions integrate alumni mentorship into credit-bearing courses (capstone, internship, practicum courses). Linking matches to course sections enables academic credit tracking, experiential l',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or volunteer coordinator responsible for overseeing this mentorship match.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Mentorship programs operated through dedicated platforms (PeopleGrove, Graduway, Mentor Collective) require system attribution for usage analytics, matching algorithm performance, ROI measurement, and',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Mentorship matches are tracked by fiscal period for program reporting and outcomes assessment. Creating mentorship_match.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus serving as the mentor in this match. Links to the alumnus master record.',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Faculty PIs serve as mentors in advancement programs (career mentoring, research mentoring). Advancement tracks faculty engagement for recognition, volunteer management, and demonstrating institutiona',
    `mentorship_program_id` BIGINT COMMENT 'Reference to the formal mentorship program under which this match was created.',
    `profile_id` BIGINT COMMENT 'Reference to the mentee in this match. May be a current student or fellow alumnus depending on program type.',
    `actual_duration_months` STRING COMMENT 'The actual duration of the mentorship relationship in months, calculated from start to end date.',
    `agreement_signed_date` DATE COMMENT 'Date when the mentorship agreement was signed by both parties.',
    `agreement_signed_flag` BOOLEAN COMMENT 'Indicates whether both mentor and mentee signed the mentorship agreement or commitment form.',
    `communication_frequency` STRING COMMENT 'The agreed-upon frequency of communication between mentor and mentee.. Valid values are `weekly|biweekly|monthly|quarterly|as_needed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mentorship match record was first created in the system.',
    `expected_duration_months` STRING COMMENT 'The planned duration of the mentorship relationship in months as defined by the program structure.',
    `focus_area` STRING COMMENT 'Primary focus area or theme of the mentorship relationship as defined at match creation. [ENUM-REF-CANDIDATE: career_development|academic_guidance|networking|industry_transition|leadership|entrepreneurship|work_life_balance — 7 candidates stripped; promote to reference product]',
    `industry_alignment` STRING COMMENT 'The industry or professional field that this mentorship match is focused on (e.g., Technology, Healthcare, Finance).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this mentorship match record was last updated in the system.',
    `match_date` DATE COMMENT 'The date when the mentor and mentee were formally paired and the mentorship relationship began.',
    `match_end_date` DATE COMMENT 'The date when the mentorship relationship concluded, either through successful completion or early termination.',
    `match_method` STRING COMMENT 'The method used to create this match: algorithm-based matching, manual assignment by coordinator, self-selection by participants, or hybrid approach.. Valid values are `algorithm|manual|self_selected|coordinator_assigned|hybrid`',
    `match_notes` STRING COMMENT 'Free-text notes or comments about the mentorship match, including coordinator observations, special circumstances, or program-specific details.',
    `match_number` STRING COMMENT 'Business identifier for the mentorship match, used for external reference and communication.',
    `match_quality_score` DECIMAL(18,2) COMMENT 'Algorithmic or coordinator-assigned score indicating the quality or compatibility of the mentor-mentee pairing, typically on a scale of 1.00 to 5.00.',
    `match_start_date` DATE COMMENT 'The official start date of the mentorship relationship, which may differ from match_date if there was a delay between pairing and first interaction.',
    `match_status` STRING COMMENT 'Current lifecycle status of the mentorship match. Active indicates ongoing relationship; completed indicates successful conclusion; withdrawn indicates early termination; paused indicates temporary suspension.. Valid values are `active|completed|withdrawn|paused|pending|cancelled`',
    `mentee_goals_achieved` STRING COMMENT 'Number of mentee-defined goals that were successfully achieved during the mentorship relationship.',
    `mentee_goals_total` STRING COMMENT 'Total number of goals defined by the mentee at the start of the mentorship relationship.',
    `mentee_satisfaction_rating` DECIMAL(18,2) COMMENT 'Mentees satisfaction rating for the mentorship experience, typically on a scale of 1.00 to 5.00.',
    `mentee_type` STRING COMMENT 'Indicates whether the mentee is a current student or a fellow alumnus participating in peer mentorship.. Valid values are `student|alumnus`',
    `mentor_satisfaction_rating` DECIMAL(18,2) COMMENT 'Mentors satisfaction rating for the mentorship experience, typically on a scale of 1.00 to 5.00.',
    `orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether both mentor and mentee completed the required program orientation before beginning their relationship.',
    `orientation_completion_date` DATE COMMENT 'Date when both participants completed the mentorship program orientation.',
    `primary_communication_mode` STRING COMMENT 'The primary method of communication used by the mentor and mentee for their interactions.. Valid values are `in_person|video_call|phone|email|messaging|hybrid`',
    `program_cycle` STRING COMMENT 'The cohort or cycle designation for this match (e.g., Fall 2023, Spring 2024, FY2024-Q1).',
    `recognition_awarded_flag` BOOLEAN COMMENT 'Indicates whether the mentor received formal recognition or awards for their participation in this match.',
    `recognition_type` STRING COMMENT 'Type of recognition awarded to the mentor (e.g., certificate, award, public acknowledgment, points).',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether this mentorship match is eligible for renewal or extension into another program cycle.',
    `renewed_flag` BOOLEAN COMMENT 'Indicates whether this mentorship match was renewed or extended beyond the original program cycle.',
    `sessions_completed` STRING COMMENT 'Total count of documented mentorship sessions or interactions completed between mentor and mentee.',
    `sessions_expected` STRING COMMENT 'The target number of mentorship sessions defined by the program requirements for this match.',
    `termination_reason` STRING COMMENT 'Reason for early termination or withdrawal from the mentorship relationship if applicable (e.g., scheduling conflicts, relocation, goal mismatch).',
    CONSTRAINT pk_mentorship_match PRIMARY KEY(`mentorship_match_id`)
) COMMENT 'Transactional record of a formal pairing between an alumni mentor and a student or fellow alumnus mentee within a mentorship program. Captures match date, match method, mentor alumnus reference, mentee reference (student or alumnus), program cycle, match status (active, completed, withdrawn, paused), number of sessions completed, mentee satisfaction rating, mentor satisfaction rating, and match end date. Enables program effectiveness measurement and mentor recognition.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` (
    `lifelong_learning_enrollment_id` BIGINT COMMENT 'Unique identifier for the lifelong learning enrollment record. Primary key for this entity.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus participating in the lifelong learning program. Links to the alumnus master record.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Alumni lifelong learning enrollments are actual course registrations requiring integration with instruction systems for scheduling, grading, transcript recording, and revenue attribution. Essential fo',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Continuing education courses delivered via LMS platforms (Canvas, Blackboard, Moodle) or specialized systems (Destiny One, CourseStorm) require system linkage for enrollment synchronization, completio',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Lifelong learning enrollments occur in specific fiscal periods for revenue and program tracking. Creating lifelong_learning_enrollment.fiscal_period_id to link to finance.fiscal_period for period-base',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Lifelong learning enrollments generate billing accounts for tuition and fees. Essential for alumni program billing integration, revenue recognition, and financial aid processing for continuing educati',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Continuing education and certificate programs are often scheduled within institutional term structures for administrative consistency, resource planning, and financial aid eligibility determination. E',
    `tuition_charge_id` BIGINT COMMENT 'Foreign key linking to billing.tuition_charge. Business justification: Direct link from lifelong learning enrollment to specific tuition charge enables precise revenue tracking, refund processing, and financial reporting for alumni continuing education programs. Critical',
    `actual_completion_date` DATE COMMENT 'Actual date on which the alumnus completed all requirements for the lifelong learning program. Null if the program has not been completed.',
    `certificate_issue_date` DATE COMMENT 'Date on which the certificate of completion was issued to the alumnus. Null if no certificate has been issued.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a certificate of completion or achievement was issued to the alumnus upon successful completion of the program.',
    `certificate_number` STRING COMMENT 'Unique identifier or serial number assigned to the certificate issued for this enrollment. Used for verification and authentication purposes.',
    `ceu_credits_earned` DECIMAL(18,2) COMMENT 'Number of Continuing Education Unit credits earned by the alumnus upon successful completion of the program. CEUs are a standard measure of non-credit professional development.',
    `completion_status` STRING COMMENT 'Indicator of whether the alumnus successfully completed the lifelong learning program and met all requirements for certification or recognition.. Valid values are `completed|not_completed|in_progress|withdrawn|incomplete`',
    `contact_hours` DECIMAL(18,2) COMMENT 'Total number of instructional contact hours associated with the lifelong learning program. Used for professional licensing and certification requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_modality` STRING COMMENT 'Method by which the lifelong learning program is delivered. Indicates whether the program is conducted in-person, fully online, or in a hybrid format combining both.. Valid values are `in_person|online|hybrid|synchronous_online|asynchronous_online`',
    `engagement_score` DECIMAL(18,2) COMMENT 'Quantitative measure of the alumnuss engagement with the lifelong learning program, based on participation metrics such as login frequency, content completion, and interaction with materials.',
    `enrollment_date` DATE COMMENT 'Date on which the alumnus enrolled in the lifelong learning program. Represents the official start of the enrollment relationship.',
    `enrollment_notes` STRING COMMENT 'Free-text notes or comments related to the enrollment. May include special accommodations, administrative notes, or other relevant information.',
    `enrollment_number` STRING COMMENT 'Business identifier for the lifelong learning enrollment. Externally visible enrollment reference number used in communications and reporting.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment. Tracks whether the alumnus is actively enrolled, has completed the program, withdrawn, or is in another state. [ENUM-REF-CANDIDATE: enrolled|in_progress|completed|withdrawn|incomplete|deferred|cancelled — 7 candidates stripped; promote to reference product]',
    `expected_completion_date` DATE COMMENT 'Anticipated date by which the alumnus is expected to complete the lifelong learning program based on the program schedule and duration.',
    `grade_earned` STRING COMMENT 'Final grade or assessment result earned by the alumnus in the lifelong learning program. May be a letter grade, pass/fail, or other institutional grading scale.',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or facilitator for the lifelong learning program. May be null for self-paced or asynchronous programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was last updated or modified. Used for audit trail and change tracking.',
    `oer_based_flag` BOOLEAN COMMENT 'Indicates whether the lifelong learning program is based on or incorporates Open Educational Resources. Supports tracking of OER adoption and alumni engagement with open content.',
    `offering_type` STRING COMMENT 'Classification of the lifelong learning offering type. Distinguishes between MOOCs (Massive Open Online Courses), certificate programs, executive education, alumni audit courses, online modules, workshops, and other professional development formats. [ENUM-REF-CANDIDATE: mooc|certificate_program|executive_education|alumni_audit|online_module|workshop|professional_development|continuing_education — 8 candidates stripped; promote to reference product]',
    `owning_college` STRING COMMENT 'Name of the college, school, or academic division that owns and administers the lifelong learning program (e.g., College of Business, School of Engineering, Division of Continuing Education).',
    `owning_department` STRING COMMENT 'Name of the department or unit within the college that is responsible for the lifelong learning program.',
    `pass_fail_indicator` STRING COMMENT 'Simple pass/fail indicator for programs that use binary assessment rather than letter grades.. Valid values are `pass|fail|not_graded|in_progress`',
    `payment_date` DATE COMMENT 'Date on which tuition payment was received or processed for the lifelong learning enrollment.',
    `payment_status` STRING COMMENT 'Status of tuition payment for the lifelong learning enrollment. Indicates whether fees have been paid, waived, or are outstanding.. Valid values are `paid|unpaid|partial|waived|refunded|pending`',
    `platform_name` STRING COMMENT 'Name of the learning management system or platform used to deliver the lifelong learning program (e.g., Canvas, Coursera, edX, institutional LMS).',
    `program_code` STRING COMMENT 'Institutional code or identifier for the lifelong learning program. Used for internal classification and reporting.',
    `program_name` STRING COMMENT 'Full name of the lifelong learning program or course in which the alumnus is enrolled. Examples include certificate program names, executive education course titles, or MOOC names.',
    `registration_source` STRING COMMENT 'Channel or method through which the alumnus registered for the lifelong learning program. Used for marketing attribution and channel effectiveness analysis. [ENUM-REF-CANDIDATE: web|mobile_app|phone|email|in_person|referral|event — 7 candidates stripped; promote to reference product]',
    `scholarship_amount` DECIMAL(18,2) COMMENT 'Dollar amount of scholarship or financial aid applied to the enrollment tuition. Null if no scholarship was applied.',
    `scholarship_applied_flag` BOOLEAN COMMENT 'Indicates whether a scholarship, discount, or financial aid was applied to reduce the tuition cost for this enrollment.',
    `start_date` DATE COMMENT 'Date on which the lifelong learning program officially begins instruction or content delivery. May differ from enrollment date if enrollment occurs before program start.',
    `tuition_amount` DECIMAL(18,2) COMMENT 'Tuition fee charged for the lifelong learning program. May be zero for complimentary alumni offerings or OER-based programs.',
    `tuition_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tuition amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `withdrawal_date` DATE COMMENT 'Date on which the alumnus officially withdrew from the lifelong learning program. Null if the alumnus has not withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the alumnus for withdrawing from the lifelong learning program. Used for program improvement and retention analysis.',
    CONSTRAINT pk_lifelong_learning_enrollment PRIMARY KEY(`lifelong_learning_enrollment_id`)
) COMMENT 'Records alumni participation in continuing education, professional development, and lifelong learning offerings provided by the institution. Captures program or course name, offering type (MOOC, certificate program, executive education, alumni audit, online module, workshop), enrollment date, completion date, completion status, CEU credits earned, tuition paid (if any), delivery modality (in-person, online, hybrid), and associated college or school. Supports alumni engagement through education and tracks OER and MOOC participation.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumni_survey` (
    `alumni_survey_id` BIGINT COMMENT 'Unique identifier for the alumni survey campaign. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Alumni outcome surveys are required for accreditation (SACSCOC, ABET, AACSB) and IPEDS reporting, aggregated by program. Replaces denormalized academic_program_code with proper FK for program-level ou',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Alumni outcomes surveys (employment rates, graduate school placement, salary data) are REQUIRED evidence for specialized accreditors (ABET, AACSB, ACEN) and regional standards on student achievement. ',
    `alumnus_id` BIGINT COMMENT 'Identifier of the alumnus who responded to this survey. Links to the alumnus master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Alumni surveys are often administered by academic units/cost centers for accreditation and outcomes assessment. Creating alumni_survey.cost_center_id to link to finance.cost_center for survey cost all',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Survey instruments deployed through specific platforms (Qualtrics, SurveyMonkey, Alchemer) need system tracking for response data integration, accreditation reporting workflows, and platform cost allo',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Alumni surveys are conducted in specific fiscal periods for outcomes assessment and accreditation reporting. Creating alumni_survey.fiscal_period_id to link to finance.fiscal_period for period-based r',
    `campaign_id` BIGINT COMMENT 'Identifier of the parent survey campaign under which this individual response was collected.',
    `accreditation_association` STRING COMMENT 'The accrediting body for which this survey data will be reported (e.g., AACSB, ABET, HLC, SACSCOC). Determines specific data elements required.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of survey questions completed by this respondent (e.g., 85.50 for 85.5% completion).',
    `continuing_education_institution` STRING COMMENT 'Name of the institution where the alumnus is pursuing further education, if applicable.',
    `continuing_education_program` STRING COMMENT 'The program or degree the alumnus is pursuing in continuing education.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this survey response record was first created in the system.',
    `degree_level` STRING COMMENT 'The level of degree earned by the alumnus at graduation.. Valid values are `associate|bachelor|master|doctoral|professional|certificate`',
    `delivery_channel` STRING COMMENT 'The channel through which the survey was delivered to the alumnus.. Valid values are `email|web_portal|phone|mail|in_person|mobile_app`',
    `employer_name` STRING COMMENT 'Name of the organization employing the alumnus at time of response, if employed.',
    `employment_status` STRING COMMENT 'The employment status of the alumnus at the time of survey response. Critical for NACE First Destination and IPEDS Graduate Outcomes reporting. [ENUM-REF-CANDIDATE: employed_full_time|employed_part_time|self_employed|continuing_education|military_service|volunteer_service|seeking_employment|not_seeking — 8 candidates stripped; promote to reference product]',
    `graduation_term` STRING COMMENT 'The academic term in which the alumnus graduated.. Valid values are `fall|spring|summer|winter`',
    `graduation_year` STRING COMMENT 'The year the alumnus graduated, used for cohort analysis and longitudinal tracking.',
    `industry_sector` STRING COMMENT 'The industry sector of the alumnus employer (e.g., Technology, Healthcare, Finance, Education, Manufacturing).',
    `instrument_version` STRING COMMENT 'Version identifier of the survey instrument used (e.g., v2.1, 2024-Spring). Ensures consistency when survey questions evolve over time.',
    `invitation_sent_date` DATE COMMENT 'The date the survey invitation was sent to the alumnus.',
    `job_location_city` STRING COMMENT 'City where the alumnus is employed.',
    `job_location_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the alumnus is employed (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `job_location_state_province` STRING COMMENT 'State or province where the alumnus is employed.',
    `job_related_to_degree` BOOLEAN COMMENT 'Indicates whether the alumnus current employment is related to their degree field. Used for program effectiveness assessment.',
    `job_start_date` DATE COMMENT 'The date the alumnus began their current employment position.',
    `job_title` STRING COMMENT 'The job title or position held by the alumnus at time of response, if employed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this survey response record was last updated.',
    `last_reminder_date` DATE COMMENT 'The date of the most recent reminder communication sent to the alumnus.',
    `notes` STRING COMMENT 'Free-text notes or comments about this survey response, including any data quality issues, follow-up actions, or contextual information.',
    `reminder_count` STRING COMMENT 'Number of reminder communications sent to the alumnus to encourage survey completion.',
    `response_date` DATE COMMENT 'The date on which the alumnus submitted their survey response.',
    `response_rate_target` DECIMAL(18,2) COMMENT 'The target response rate percentage for the survey campaign (e.g., 65.00 for 65%). Used to assess campaign effectiveness.',
    `response_source` STRING COMMENT 'The method by which the response data was obtained. Some institutions supplement direct survey responses with data from other sources.. Valid values are `direct_survey|linkedin_scrape|manual_entry|third_party_vendor|phone_interview`',
    `response_status` STRING COMMENT 'Status of this individual alumnus response indicating completion level.. Valid values are `not_started|in_progress|completed|abandoned|invalid`',
    `response_timestamp` TIMESTAMP COMMENT 'The precise date and time when the alumnus completed and submitted the survey response.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reported salary (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `salary_range` STRING COMMENT 'The salary range or band reported by the alumnus. Often collected in ranges rather than exact amounts to improve response rates.',
    `satisfaction_score` STRING COMMENT 'Overall satisfaction rating provided by the alumnus regarding their educational experience (typically on a scale such as 1-5 or 1-10).',
    `survey_name` STRING COMMENT 'The official name of the survey campaign (e.g., Class of 2023 First Destination Survey, Alumni Career Outcomes Survey 2024).',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey campaign.. Valid values are `draft|active|paused|closed|archived`',
    `survey_type` STRING COMMENT 'The category of survey being administered. Determines the question set and reporting requirements.. Valid values are `first_destination|career_outcomes|engagement|satisfaction|program_assessment|employer_feedback`',
    `target_population` STRING COMMENT 'Description of the intended respondent population (e.g., Class of 2023 Bachelor Degree Recipients, MBA Graduates 2020-2023, Engineering Alumni 5-Year Post-Graduation).',
    `verification_date` DATE COMMENT 'The date on which the response data was verified by advancement staff.',
    `verification_status` STRING COMMENT 'Indicates whether the response data has been verified for accuracy and completeness, particularly important for accreditation reporting.. Valid values are `unverified|verified|flagged_for_review|rejected`',
    `would_recommend` BOOLEAN COMMENT 'Indicates whether the alumnus would recommend the institution or program to others. Key metric for Net Promoter Score (NPS) calculation.',
    CONSTRAINT pk_alumni_survey PRIMARY KEY(`alumni_survey_id`)
) COMMENT 'Manages alumni survey campaigns and individual response collection. Captures survey definition (name, type, target population, instrument version, delivery channel, response rate target, accreditation association) and individual alumnus responses (response date, completion status, structured answers, employment status at response time). Supports IPEDS graduate outcomes reporting, NACE First Destination Survey, AACSB/ABET accreditation data, and program-level assessment.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`survey_response` (
    `survey_response_id` BIGINT COMMENT 'Unique identifier for the survey response record. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Individual survey responses must link to programs for accreditation evidence files and program review. Enables employment rate calculations, salary analysis, and satisfaction metrics by program as req',
    `alumni_survey_id` BIGINT COMMENT 'Reference to the survey instrument that this response belongs to.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who submitted this survey response.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: First-destination and alumni outcome surveys must link to specific courses for program-level assessment. Required for IPEDS graduate outcome reporting, specialized accreditation (AACSB, ACEN), and ins',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or coordinator responsible for administering this survey and managing responses.',
    `academic_college` STRING COMMENT 'College or school within the institution from which the alumnus graduated.',
    `accreditation_reporting_cycle` STRING COMMENT 'Accreditation reporting cycle or year in which this response was used (e.g., 2023-2024, Fall 2023).',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of survey questions answered by the alumnus, calculated as answered questions divided by total questions.',
    `continuing_education_institution` STRING COMMENT 'Name of the institution where the alumnus is pursuing continuing education, if applicable.',
    `continuing_education_program` STRING COMMENT 'Name or type of the continuing education program the alumnus is enrolled in.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was first created in the data warehouse.',
    `employer_name` STRING COMMENT 'Name of the organization employing the alumnus at the time of response.',
    `employment_status` STRING COMMENT 'Employment status of the alumnus at the time of survey response, used for graduate outcomes reporting and accreditation.. Valid values are `employed|unemployed|continuing_education|military|volunteer|not_seeking`',
    `first_access_date` DATE COMMENT 'Date when the alumnus first opened or accessed the survey.',
    `graduation_year` STRING COMMENT 'Year the alumnus graduated from the institution, used for cohort analysis and outcomes tracking.',
    `incentive_offered_flag` BOOLEAN COMMENT 'Indicates whether an incentive (gift card, prize entry, donation) was offered to encourage survey completion.',
    `incentive_type` STRING COMMENT 'Type of incentive offered to the alumnus (e.g., gift card, prize drawing entry, charitable donation).',
    `industry_sector` STRING COMMENT 'Industry sector or field in which the alumnus is employed, typically aligned with NAICS or similar classification systems.',
    `ipeds_reportable_flag` BOOLEAN COMMENT 'Indicates whether this response meets IPEDS graduate outcomes reporting criteria and was included in federal reporting.',
    `job_location_city` STRING COMMENT 'City where the alumnus is employed or working.',
    `job_location_country_code` STRING COMMENT 'Three-letter ISO 3166 country code for the job location (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `job_location_state_province` STRING COMMENT 'State or province where the alumnus is employed or working.',
    `job_related_to_degree_flag` BOOLEAN COMMENT 'Indicates whether the alumnus reported that their current job is related to their degree program.',
    `job_search_duration_months` STRING COMMENT 'Number of months the alumnus spent searching for employment after graduation.',
    `job_title` STRING COMMENT 'Job title or position held by the alumnus at the time of response.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey response record was last updated in the data warehouse.',
    `reminder_count` STRING COMMENT 'Number of reminder communications sent to the alumnus before the response was received.',
    `response_channel` STRING COMMENT 'Channel or medium through which the alumnus submitted the survey response (web portal, mobile app, email link, phone interview, postal mail, or in-person event).. Valid values are `web|mobile|email|phone|mail|in_person`',
    `response_date` DATE COMMENT 'Date when the alumnus submitted or last updated the survey response.',
    `response_notes` STRING COMMENT 'Free-text notes or comments recorded by survey administrators regarding this response.',
    `response_number` STRING COMMENT 'Business identifier for the survey response, typically generated by the survey platform or advancement system.',
    `response_payload_json` STRING COMMENT 'JSON-formatted payload containing individual question responses and structured survey data for flexible storage and analysis.',
    `response_status` STRING COMMENT 'Current completion status of the survey response indicating whether the alumnus completed, partially completed, refused, abandoned, is still in progress, or allowed the survey to expire.. Valid values are `complete|partial|refused|abandoned|in_progress|expired`',
    `response_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the survey response was submitted or last saved, including time zone information.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reported salary (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `salary_range` STRING COMMENT 'Salary range reported by the alumnus, typically captured as a bracket rather than exact amount to encourage response.',
    `satisfaction_rating` STRING COMMENT 'Overall satisfaction rating provided by the alumnus, typically on a numeric scale (e.g., 1-5 or 1-10).',
    `source_system` STRING COMMENT 'Name of the source system from which this survey response was captured (e.g., Blackbaud Raisers Edge, Qualtrics, SurveyMonkey).',
    `source_system_code` STRING COMMENT 'Unique identifier for this survey response in the source system, used for data lineage and reconciliation.',
    `survey_invitation_date` DATE COMMENT 'Date when the survey invitation was sent to the alumnus.',
    `used_in_accreditation_flag` BOOLEAN COMMENT 'Indicates whether this response was included in accreditation reporting (AACSB, ABET, program-level accreditation, or IPEDS).',
    `would_recommend_flag` BOOLEAN COMMENT 'Indicates whether the alumnus would recommend the institution to others, often used for Net Promoter Score (NPS) calculation.',
    CONSTRAINT pk_survey_response PRIMARY KEY(`survey_response_id`)
) COMMENT 'Transactional record capturing an individual alumnuss response to an alumni survey. Captures survey reference, alumnus reference, response date, response channel, completion status (complete, partial, refused), individual question responses stored as structured fields or JSON payload, employment status at time of response, salary range reported, and whether the response was used in accreditation reporting. Supports IPEDS graduate outcomes, NACE First Destination Survey, and program-level accreditation data.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`alumni_award` (
    `alumni_award_id` BIGINT COMMENT 'Unique identifier for the alumni award record. Primary key.',
    `alumni_event_id` BIGINT COMMENT 'Reference to the alumni event where the award was presented (e.g., homecoming, gala, commencement).',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who received or was nominated for this award.',
    `award_catalog_id` BIGINT COMMENT 'Reference to the award definition in the institutional award catalog, defining the award name, category, and criteria.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Alumni awards are often given by academic units/cost centers. Creating alumni_award.cost_center_id to link to finance.cost_center for award cost allocation and budget tracking.',
    `endowment_id` BIGINT COMMENT 'Reference to the endowment fund that supports this award, if funded by a named endowment.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Alumni awards are given in specific fiscal periods for recognition and budget tracking. Creating alumni_award.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Alumni awards often have eligibility criteria based on graduation term (e.g., 5-year, 10-year alumni awards). Award ceremonies are scheduled relative to reunion cycles tied to specific graduation term',
    `approval_authority` STRING COMMENT 'Name or title of the individual or body that provided final approval for the award.',
    `approval_date` DATE COMMENT 'Date when the award selection received final institutional approval (e.g., by President, Board of Trustees).',
    `award_category` STRING COMMENT 'Primary classification of the award type, used for reporting and segmentation of recognition programs.. Valid values are `distinguished_alumni|young_alumni_achievement|service_award|honorary_degree|hall_of_fame|lifetime_achievement`',
    `award_name` STRING COMMENT 'Full name of the award as it appears on certificates and in official communications (e.g., Distinguished Alumni Award, Young Alumni Achievement Award).',
    `award_number` STRING COMMENT 'Externally-known unique identifier or tracking number for this specific award instance, used in publications and communications.',
    `award_status` STRING COMMENT 'Current lifecycle status of the award record, tracking progression from nomination through presentation. [ENUM-REF-CANDIDATE: nominated|under_review|selected|approved|declined|presented|revoked — 7 candidates stripped; promote to reference product]',
    `award_subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the award category (e.g., professional achievement, community service, academic excellence).',
    `award_year` STRING COMMENT 'Calendar or academic year in which the award was conferred, used for historical tracking and cohort analysis.',
    `citation_text` STRING COMMENT 'Official citation or commendation text read during the presentation ceremony and printed on the award certificate, summarizing the recipients achievements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this award record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this award record was most recently updated.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Cash or scholarship value associated with the award, if applicable. Null for recognition-only awards.',
    `nomination_date` DATE COMMENT 'Date when the alumnus was formally nominated for this award.',
    `nomination_source` STRING COMMENT 'Origin or channel through which the nomination was submitted. [ENUM-REF-CANDIDATE: self|peer|faculty|staff|committee|board|public — 7 candidates stripped; promote to reference product]',
    `nomination_statement` STRING COMMENT 'Detailed narrative statement submitted by the nominator explaining why the alumnus should receive the award.',
    `nominator_name` STRING COMMENT 'Full name of the individual or organization who submitted the nomination.',
    `nominator_relationship` STRING COMMENT 'Description of the nominators relationship to the nominee (e.g., colleague, classmate, supervisor, community partner).',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, or administrative notes related to the award.',
    `presentation_date` DATE COMMENT 'Date when the award was formally presented to the recipient at a ceremony or event.',
    `presentation_location` STRING COMMENT 'Venue or location where the award presentation ceremony took place.',
    `presenter_name` STRING COMMENT 'Name of the individual who formally presented the award to the recipient (e.g., President, Dean, Board Chair).',
    `prospect_qualification_flag` BOOLEAN COMMENT 'Indicates whether this award recipient should be flagged as a major gift prospect for advancement cultivation.',
    `publication_date` DATE COMMENT 'Date when the award was announced in alumni publications, website, or press releases.',
    `publication_flag` BOOLEAN COMMENT 'Indicates whether the award recipient has consented to public announcement and publication of the award in alumni communications.',
    `recipient_class_year` STRING COMMENT 'Graduation year of the award recipient, used for reunion planning and cohort analysis.',
    `recipient_degree` STRING COMMENT 'Primary degree earned by the recipient from the institution (e.g., BA, BS, MBA, PhD).',
    `recipient_major` STRING COMMENT 'Primary academic major or field of study of the award recipient during their time at the institution.',
    `review_committee` STRING COMMENT 'Name or identifier of the committee responsible for evaluating this award nomination.',
    `review_start_date` DATE COMMENT 'Date when the selection committee began formal review of this nomination.',
    `revocation_date` DATE COMMENT 'Date when the award was revoked, if applicable. Null for awards in good standing.',
    `revocation_reason` STRING COMMENT 'Explanation for why the award was revoked, if applicable. Confidential institutional record.',
    `selection_date` DATE COMMENT 'Date when the recipient was officially selected to receive the award by the review committee or governing body.',
    `selection_rationale` STRING COMMENT 'Internal documentation of the committees reasoning and justification for selecting this recipient.',
    CONSTRAINT pk_alumni_award PRIMARY KEY(`alumni_award_id`)
) COMMENT 'Manages institutional awards, honors, and recognition programs for alumni, including both the award catalog (name, category, selection criteria, nomination process) and recipient records (nomination date, selection date, presentation date, citation text, ceremony reference). Award categories include distinguished alumni, young alumni achievement, service award, honorary degree, and hall of fame induction. Supports recognition tracking, alumni publications, and advancement prospect qualification.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`award_recipient` (
    `award_recipient_id` BIGINT COMMENT 'Unique identifier for the award recipient record. Primary key for the award recipient entity.',
    `alumni_award_id` BIGINT COMMENT 'Reference to the specific institutional award being conferred. Links to the award master data defining award name, criteria, and prestige level.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus receiving the award. Links to alumni master record containing biographical and engagement history.',
    `event_id` BIGINT COMMENT 'Reference to the alumni event at which the award was presented. Links to event master data for venue, attendance, and program details.',
    `award_year` STRING COMMENT 'Calendar or fiscal year in which the award was conferred. Used for cohort analysis and historical tracking of award recipients.',
    `citation_text` STRING COMMENT 'Official narrative citation read at the award presentation ceremony. Summarizes the recipients accomplishments and contributions that merited the award.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this award recipient record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary award amount. Typically USD for U.S. institutions but may vary for international awards.. Valid values are `^[A-Z]{3}$`',
    `engagement_score_impact` STRING COMMENT 'Point value added to the recipients overall alumni engagement score as a result of receiving this award. Reflects increased connection to the institution.',
    `featured_in_publication_flag` BOOLEAN COMMENT 'Indicates whether the award recipient was featured in alumni magazines, newsletters, or other institutional publications. Used to track recognition and engagement activities.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who most recently modified this award recipient record. Supports audit and accountability requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this award recipient record was most recently updated. Tracks the currency of the data and supports change detection.',
    `monetary_award_amount` DECIMAL(18,2) COMMENT 'Dollar value of any monetary prize or stipend accompanying the award. Some awards are purely honorary while others include financial recognition.',
    `nomination_date` DATE COMMENT 'Date on which the alumnus was formally nominated for the award. Marks the beginning of the selection process.',
    `nomination_source` STRING COMMENT 'Origin or channel through which the nomination was submitted. Indicates whether the nomination came from the alumnus themselves, peers, institutional leadership, or other sources. [ENUM-REF-CANDIDATE: self|peer|faculty|staff|alumni_chapter|advancement_office|president|board_of_trustees|other — 9 candidates stripped; promote to reference product]',
    `nomination_statement` STRING COMMENT 'Narrative text submitted by the nominator describing why the alumnus merits the award. Includes accomplishments, impact, and alignment with award criteria.',
    `nominator_name` STRING COMMENT 'Full name of the individual who submitted the nomination. May be kept confidential depending on institutional policy.',
    `nominator_relationship` STRING COMMENT 'Description of the nominators relationship to the award recipient (e.g., classmate, colleague, faculty advisor, supervisor). Provides context for the nomination.',
    `notes` STRING COMMENT 'Free-form text field for advancement staff to record additional context, special circumstances, follow-up actions, or other relevant information about the award recipient.',
    `presentation_date` DATE COMMENT 'Date on which the award was formally presented to the recipient. Typically occurs at a ceremony, gala, or commencement event.',
    `presentation_location` STRING COMMENT 'Physical or virtual location where the award was presented. May include venue name, city, or virtual platform details.',
    `press_release_date` DATE COMMENT 'Date on which the press release announcing the award was distributed to media outlets and published on institutional channels.',
    `press_release_issued_flag` BOOLEAN COMMENT 'Indicates whether a press release was issued to announce the award. Used to track public relations activities and media coverage.',
    `prospect_qualification_flag` BOOLEAN COMMENT 'Indicates whether this award recipient has been identified as a major gift prospect based on the award recognition. Award recipients often have increased capacity and affinity for giving.',
    `prospect_rating` STRING COMMENT 'Fundraising capacity rating assigned to the award recipient following the award conferral. May be updated based on research into the recipients professional success and philanthropic capacity.',
    `publication_issue` STRING COMMENT 'Specific issue or edition of the alumni publication in which the recipient was featured. Includes publication name, volume, and issue number.',
    `recipient_acceptance_date` DATE COMMENT 'Date on which the alumnus formally accepted the award. Triggers planning for presentation ceremony and public announcement.',
    `recipient_acceptance_status` STRING COMMENT 'Indicates whether the selected alumnus has formally accepted the award. Some recipients may decline due to personal or professional reasons.. Valid values are `pending|accepted|declined|no_response`',
    `recipient_number` STRING COMMENT 'Business-facing unique identifier for this award recipient record. Used in communications, certificates, and external reporting. Format may include award year and sequence.',
    `recognition_level` STRING COMMENT 'Scope or tier of the award indicating whether it is institution-wide, college-specific, department-level, or broader (national/international). Used for prospect qualification and engagement scoring. [ENUM-REF-CANDIDATE: institutional|college|department|chapter|regional|national|international — 7 candidates stripped; promote to reference product]',
    `selection_committee_review_date` DATE COMMENT 'Date on which the selection committee formally reviewed and evaluated the nomination. Represents a key milestone in the award decision process.',
    `selection_decision_date` DATE COMMENT 'Date on which the selection committee or governing body made the final decision to confer the award to this recipient.',
    `selection_status` STRING COMMENT 'Current state of the award recipient record in the selection and conferral lifecycle. Tracks progression from nomination through final award presentation.. Valid values are `nominated|under_review|selected|declined|deferred|not_selected`',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this award recipient record. Supports audit and accountability requirements.',
    CONSTRAINT pk_award_recipient PRIMARY KEY(`award_recipient_id`)
) COMMENT 'Transactional record of an alumnus receiving a specific institutional award in a given year. Captures award reference, alumnus reference, nomination date, nomination source, selection committee decision date, award presentation date, award ceremony event reference, citation text, press release issued flag, and whether the recipient was featured in alumni publications. Enables recognition tracking and advancement prospect qualification.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`outreach_communication` (
    `outreach_communication_id` BIGINT COMMENT 'Unique identifier for the outreach communication record. Primary key.',
    `alumnus_id` BIGINT COMMENT 'Identifier of the alumnus who received this communication. Links to the alumnus master record.',
    `appeal_id` BIGINT COMMENT 'Identifier of the specific fundraising appeal or solicitation associated with this communication, if applicable.',
    `campaign_id` BIGINT COMMENT 'Identifier of the fundraising or engagement campaign associated with this communication, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the alumni relations or advancement staff member who sent or initiated the communication.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Communications sent via specific platforms (Constant Contact, Mailchimp, Slate) require system attribution for deliverability tracking, bounce analysis, CAN-SPAM compliance reporting, and vendor perfo',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Outreach communications occur in specific fiscal periods for campaign tracking and cost allocation. Creating outreach_communication.fiscal_period_id to link to finance.fiscal_period for period-based r',
    `bounce_reason` STRING COMMENT 'The reason provided by the delivery system for why the communication bounced or failed to deliver (e.g., invalid address, mailbox full).',
    `clicked_flag` BOOLEAN COMMENT 'Indicates whether the recipient clicked on any link within the digital communication. True if clicked, False if not clicked or not tracked.',
    `clicked_timestamp` TIMESTAMP COMMENT 'The date and time when the recipient first clicked on a link within the digital communication, if tracked.',
    `communication_date` DATE COMMENT 'The date on which the communication was sent or initiated to the alumnus.',
    `communication_notes` STRING COMMENT 'Additional notes or comments about this communication, including context, special circumstances, or staff observations.',
    `communication_number` STRING COMMENT 'Business-facing unique identifier or tracking number for this outreach communication, used for reference and audit purposes.',
    `communication_status` STRING COMMENT 'The current lifecycle status of the communication record (draft, scheduled, sent, completed, cancelled).. Valid values are `draft|scheduled|sent|completed|cancelled`',
    `communication_timestamp` TIMESTAMP COMMENT 'The precise date and time when the communication was sent or initiated, including time zone information.',
    `communication_type` STRING COMMENT 'The medium or channel through which the communication was sent (email, letter, phone call, text message, social media direct message, postcard).. Valid values are `email|letter|phone_call|text_message|social_media_dm|postcard`',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred to send this communication (e.g., postage, printing, SMS fees, email service fees).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this communication record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `delivery_status` STRING COMMENT 'The delivery status of the communication indicating whether it was successfully sent, delivered, bounced, or failed.. Valid values are `sent|delivered|bounced|undelivered|failed`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the communication was confirmed as delivered to the recipient, if applicable.',
    `ferpa_compliant_flag` BOOLEAN COMMENT 'Indicates whether this communication was logged and handled in compliance with FERPA regulations. True if compliant, False otherwise.',
    `follow_up_date` DATE COMMENT 'The scheduled or target date for follow-up action related to this communication.',
    `follow_up_notes` STRING COMMENT 'Notes or instructions regarding the required follow-up action for this communication.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether follow-up action is required by advancement staff based on this communication or its response. True if follow-up needed, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this communication record was last updated or modified in the system.',
    `message_body` STRING COMMENT 'The full text content or body of the communication sent to the alumnus.',
    `opened_flag` BOOLEAN COMMENT 'Indicates whether the digital communication (email, text) was opened by the recipient. True if opened, False if not opened or not tracked.',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when the digital communication was first opened by the recipient, if tracked.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the alumnus opted out of future communications as a result of this outreach. True if opted out, False otherwise.',
    `package_code` STRING COMMENT 'A code identifying the specific communication package or template used for this outreach (e.g., annual fund letter package A, reunion email template B).',
    `response_date` DATE COMMENT 'The date on which a response was received from the alumnus, if applicable.',
    `response_received_flag` BOOLEAN COMMENT 'Indicates whether a response was received from the alumnus following this communication. True if response received, False otherwise.',
    `response_type` STRING COMMENT 'The type or nature of the response received from the alumnus (e.g., gift, pledge, inquiry, opt-out request, complaint).. Valid values are `gift|pledge|inquiry|opt_out|complaint|other`',
    `segment_code` STRING COMMENT 'A code identifying the alumni segment or target audience group for this communication (e.g., major gift prospects, young alumni, reunion class).',
    `sender_email` STRING COMMENT 'The email address from which the communication was sent, if applicable.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'The name of the staff member or office that appears as the sender of the communication.',
    `solicitation_code` STRING COMMENT 'A code or identifier used to track the specific solicitation strategy or segment associated with this communication.',
    `source_system` STRING COMMENT 'The name of the source system or platform from which this communication record originated (e.g., Blackbaud Raisers Edge, Slate CRM, email marketing platform).',
    `source_system_code` STRING COMMENT 'The unique identifier for this communication record in the source system of record.',
    `subject` STRING COMMENT 'The subject line or topic of the communication (e.g., email subject, letter title, call purpose).',
    CONSTRAINT pk_outreach_communication PRIMARY KEY(`outreach_communication_id`)
) COMMENT 'Transactional record of each outbound communication sent to an alumnus by alumni relations or advancement staff. Captures communication type (email, letter, phone call, text message, social media direct message), communication date, subject or topic, associated campaign or appeal, staff sender, delivery status (sent, delivered, bounced, undelivered), open/click flag for digital communications, response received flag, and follow-up action required. Supports communication history, FERPA-compliant contact logging, and outreach effectiveness tracking.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`donor` (
    `donor_id` BIGINT COMMENT 'Unique identifier for the donor record. Primary key for the donor entity. Serves as the system-of-record identifier in Blackbaud Raisers Edge.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Donors who are alumni require direct linkage for comprehensive constituent relationship management, lifetime giving analysis, and integrated advancement operations. Enables single-view reporting acros',
    `constituent_id` BIGINT COMMENT 'External constituent identifier from Blackbaud Raisers Edge. Business-facing identifier used for donor lookup and correspondence.',
    `employee_id` BIGINT COMMENT 'Identifier of the advancement officer or gift officer assigned to manage the relationship with this donor. Used for portfolio management and accountability.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Donors with institutional accounts (online giving portals, event registration, donor dashboards) require identity linkage for SSO authentication, personalized giving history displays, and secure docum',
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
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this gift. Used for campaign performance tracking and goal attainment reporting.',
    `donor_id` BIGINT COMMENT 'Reference to the alumnus or external donor who made the gift. Links to the donor master record in the advancement system.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Gifts processed through specific payment platforms (Blackbaud Merchant Services, Stripe, PayPal) require system attribution for payment reconciliation, PCI-DSS compliance auditing, transaction fee ana',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Gifts are recorded in specific fiscal periods for revenue recognition and financial reporting. Creating gift.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member, volunteer, or alumnus who solicited or facilitated the gift. Used for crediting and performance tracking.',
    `gift_officer_employee_id` BIGINT COMMENT 'Reference to the advancement staff member responsible for managing the donor relationship and processing this gift. Used for portfolio management and performance tracking.',
    `ipeds_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.ipeds_submission. Business justification: Gifts are reported in IPEDS Finance component (private gifts/grants revenue) and IPEDS Endowment component. Direct link required for data integrity, audit reconciliation, and to support IPEDS keyholde',
    `pledge_id` BIGINT COMMENT 'Reference to the pledge record if this gift is a payment toward a multi-year pledge commitment. Links to the pledge master record for tracking fulfillment.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Major gifts trigger IRS Form 990 reporting, UBIT filings, and state charitable solicitation registrations. Link required for audit trail verification and to support annual compliance filing reconcilia',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Gifts often designated for specific research awards or labs. Critical for stewardship reporting, impact metrics, and fund accounting. Advancement must track which gifts support which research for dono',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Gifts post to specific revenue ledger accounts for GL accounting. Creating gift.revenue_ledger_account_id to link to finance.ledger_account for revenue recognition and financial reporting.',
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
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Campaigns span fiscal periods and are reported by period for fundraising progress tracking. Creating campaign.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Campaigns are institutional fundraising initiatives requiring org hierarchy linkage for budget ownership, gift allocation reporting, campaign performance dashboards by college/unit, and stewardship ac',
    `parent_campaign_id` BIGINT COMMENT 'Reference to the parent campaign if this is a sub-campaign within a larger comprehensive campaign hierarchy.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Advancement funds map to academic cost centers for stewardship reporting and budget alignment. Creating advancement_fund.cost_center_id to link to finance.cost_center for financial and operational rep',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Advancement funds are reported and valued by fiscal period for financial reporting. Creating advancement_fund.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Advancement funds (endowments, scholarships, capital campaigns) map to general ledger accounts for financial tracking and reporting. This FK links advancement_fund to the finance ledger_account master',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Advancement funds are budget entities requiring org hierarchy linkage for financial accountability, NACUBO/IPEDS reporting, stewardship reporting, and institutional budget roll-ups. Owning_college_sch',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Endowed funds distribute to specific research awards annually. Critical for fund accounting, stewardship reporting, and demonstrating research impact to donors. Links gift-funded endowments to the res',
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
    `affinity_group_id` BIGINT COMMENT 'Reference to the affinity group or alumni chapter associated with this appeal, if targeted to a specific group.',
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
    `advancement_fund_id` BIGINT COMMENT 'Identifier linking to the institutional fund or campaign master record. Used for gift allocation and financial reporting integration.',
    `campaign_id` BIGINT COMMENT 'Identifier of the fundraising campaign or initiative to which this major gift proposal is attributed. Links to campaign master data for performance tracking and goal measurement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Major gift proposals often support specific academic units/cost centers for budget planning. Creating major_gift_proposal.cost_center_id to link to finance.cost_center for proposal tracking and budget',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Major gift proposals are tracked by fiscal period for pipeline reporting and forecasting. Creating major_gift_proposal.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the major gifts officer or fundraiser assigned to manage and steward this proposal through the solicitation lifecycle.',
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
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign under which this planned gift commitment was secured, if applicable. Used for campaign reporting and goal tracking.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus who has made the planned gift commitment. Links to the alumnus master record.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member or planned giving officer who cultivated and secured this commitment. Used for performance tracking and relationship continuity.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Planned gifts are tracked by fiscal period for pipeline reporting and estate planning. Creating planned_gift.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Planned gifts (bequests, charitable remainder trusts, gift annuities) trigger IRS Form 8282, 990 Schedule D, and state insurance department filings for gift annuity reserves. Direct link required for ',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Planned gifts often designated for research (bequests for endowed chairs, estate gifts for research programs). Advancement tracks intended beneficiary awards for stewardship, financial planning, and e',
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
    `stewardship_plan_id` BIGINT COMMENT 'Reference to the overarching stewardship plan this action fulfills.',
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
    `advancement_fund_id` BIGINT COMMENT 'Reference to the master fund record in the finance domain. Links this endowment to the institutional fund accounting structure.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement or finance staff member responsible for managing this endowments stewardship, reporting, and donor relations.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Endowments are valued and reported by fiscal period for financial statements. Creating endowment.fiscal_period_id to link to finance.fiscal_period for period-based valuation and reporting.',
    `gift_agreement_id` BIGINT COMMENT 'Reference to the legal gift agreement document that governs this endowments terms, restrictions, and spending provisions.',
    `investment_pool_id` BIGINT COMMENT 'Reference to the investment pool in which this endowments assets are invested. Most endowments participate in a commingled investment pool for economies of scale.',
    `donor_id` BIGINT COMMENT 'Reference to the primary donor (alumnus or constituent) who established this endowment. Used for stewardship reporting and donor relations.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Endowments post to principal ledger accounts for GL accounting of endowment assets. Creating endowment.principal_ledger_account_id to link to finance.ledger_account for financial reporting.',
    `accounting_segment` STRING COMMENT 'The chart of accounts segment or cost center code to which spending distributions from this endowment are posted in the general ledger.',
    `annual_distribution_amount` DECIMAL(18,2) COMMENT 'The dollar amount authorized for spending distribution from this endowment for the current fiscal year. Calculated based on spending policy rate and market value.',
    `benefiting_college` STRING COMMENT 'The academic college or school that receives spending distributions from this endowment. May be institution-wide for unrestricted endowments.',
    `benefiting_department` STRING COMMENT 'The specific academic department or administrative unit that receives spending distributions from this endowment, if more granular than college level.',
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

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`matching_gift_claim` (
    `matching_gift_claim_id` BIGINT COMMENT 'Unique identifier for the matching gift claim record. Primary key.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the institutional fund or designation to which the matching gift proceeds are allocated.',
    `alumnus_id` BIGINT COMMENT 'Reference to the alumnus donor who made the original gift eligible for employer matching.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign to which the matching gift is attributed for development reporting.',
    `gift_id` BIGINT COMMENT 'Reference to the original donor gift that qualifies for employer matching. Links to the gift transaction that triggered this matching gift claim.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member responsible for processing and tracking this matching gift claim.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Matching gift claims are recorded in specific fiscal periods for revenue recognition. Creating matching_gift_claim.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Matching gift claims generate GL journal entries when payments are received. Creating matching_gift_claim.journal_entry_id to link to finance.journal_entry for revenue recognition and audit trail.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Matching gifts may be designated for specific research awards. Advancement tracks designation for fund accounting, stewardship, and ensuring matching funds are applied correctly. Links corporate match',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Matching gift claims post to revenue ledger accounts for GL accounting. Creating matching_gift_claim.revenue_ledger_account_id to link to finance.ledger_account for revenue recognition.',
    `acknowledgment_date` DATE COMMENT 'Date when the gift acknowledgment for the matching gift was sent to the donor.',
    `acknowledgment_sent_flag` BOOLEAN COMMENT 'Indicates whether a gift acknowledgment letter or receipt was sent to the donor for the matching gift received.',
    `appeal_date` DATE COMMENT 'Date when an appeal was submitted to the employer to reconsider a denied matching gift claim.',
    `appeal_outcome` STRING COMMENT 'The result of the matching gift claim appeal process, if an appeal was submitted.. Valid values are `pending|approved|denied|withdrawn`',
    `appeal_submitted_flag` BOOLEAN COMMENT 'Indicates whether an appeal was submitted to the employer after an initial denial of the matching gift claim.',
    `claim_number` STRING COMMENT 'Business identifier for the matching gift claim, often assigned by the matching gift platform or employer. Used for tracking and correspondence.',
    `claim_status` STRING COMMENT 'Current lifecycle status of the matching gift claim in the processing workflow. [ENUM-REF-CANDIDATE: pending|submitted|under_review|approved|paid|denied|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `claimed_match_amount` DECIMAL(18,2) COMMENT 'The total matching gift amount claimed from the employer, calculated based on the original gift amount and match ratio.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this matching gift claim record was first created in the advancement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the matching gift claim amounts (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `deadline_date` DATE COMMENT 'The deadline date by which the matching gift claim must be submitted to the employer to remain eligible, typically based on the original gift date.',
    `denial_date` DATE COMMENT 'Date when the matching gift claim was officially denied by the employer or platform.',
    `denial_reason` STRING COMMENT 'Explanation provided by the employer or platform for why the matching gift claim was denied, if applicable.',
    `employer_name` STRING COMMENT 'Name of the corporation or employer organization that provides the matching gift program.',
    `employer_organization_code` BIGINT COMMENT 'Reference to the employer organization entity in the advancement system that sponsors the matching gift program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this matching gift claim record was most recently updated in the advancement system.',
    `match_ratio` DECIMAL(18,2) COMMENT 'The ratio at which the employer matches the employee donation (e.g., 1.00 for dollar-for-dollar, 2.00 for two-to-one, 0.50 for half-match). Expressed as a multiplier.',
    `matching_gift_program_name` STRING COMMENT 'Name of the specific matching gift program offered by the employer, as some employers may have multiple programs with different rules.',
    `maximum_match_amount` DECIMAL(18,2) COMMENT 'The maximum total matching gift amount the employer will provide per employee per calendar or fiscal year.',
    `minimum_gift_amount` DECIMAL(18,2) COMMENT 'The minimum donation amount required by the employer matching gift program for a gift to qualify for matching.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the matching gift claim processing, communications with employer, or special circumstances.',
    `original_gift_amount` DECIMAL(18,2) COMMENT 'The amount of the original donor gift that qualifies for employer matching, in the gift currency.',
    `payment_method` STRING COMMENT 'The payment instrument or method used by the employer to remit the matching gift funds.. Valid values are `check|wire_transfer|ach|credit_card|stock_transfer|other`',
    `payment_received_date` DATE COMMENT 'Date when the institution received the matching gift payment from the employer.',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction identifier provided by the employer for the matching gift payment (e.g., check number, wire confirmation).',
    `platform_claim_reference` STRING COMMENT 'External claim identifier assigned by the third-party matching gift platform for tracking and reconciliation.',
    `source_system` STRING COMMENT 'Name of the source system from which this matching gift claim record originated (e.g., Blackbaud Raisers Edge, Double the Donation API).',
    `source_system_code` STRING COMMENT 'The unique identifier for this matching gift claim record in the source system, used for data lineage and reconciliation.',
    `submission_date` DATE COMMENT 'Date when the matching gift claim was submitted to the employer or matching gift platform for processing.',
    `submission_method` STRING COMMENT 'The method or channel through which the matching gift claim was submitted to the employer.. Valid values are `online_portal|paper_form|email|third_party_platform|phone|fax`',
    `third_party_platform_name` STRING COMMENT 'Name of the third-party matching gift service or platform used to facilitate the claim (e.g., Double the Donation, HEP Development, Benevity).',
    `verification_date` DATE COMMENT 'Date when the employer verified the employees donation and approved the matching gift claim.',
    `verification_status` STRING COMMENT 'Status of employer verification of the employees donation and eligibility for matching gift program.. Valid values are `not_verified|pending_verification|verified|failed_verification`',
    CONSTRAINT pk_matching_gift_claim PRIMARY KEY(`matching_gift_claim_id`)
) COMMENT 'Tracks corporate matching gift submissions and fulfillment for gifts where an employer matches an employees donation. Captures the original donor gift reference, employer/corporation name, match ratio, claimed amount, submission date, employer verification status, payment received date, and matching gift program rules. Enables advancement staff to maximize matching gift revenue and track outstanding claims. Sourced from Blackbaud Raisers Edge and third-party matching gift platforms (e.g., Double the Donation).';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the advancement event record. Primary key for the advancement event entity.',
    `affinity_group_id` BIGINT COMMENT 'Reference to the alumni affinity group sponsoring or associated with this event. Examples: regional alumni chapter, academic college alumni society, athletic booster club. Null for institution-wide events.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Advancement events (galas, donor receptions, alumni gatherings) occur in campus buildings. This FK links advancement_event to the facility building master, enabling facility scheduling and space utili',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this event. Links the event to broader fundraising initiatives such as capital campaigns, annual giving drives, or endowment campaigns.',
    `clery_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.clery_incident. Business justification: Alumni events held on campus or in Clery geography (Greek houses, adjacent properties) where crimes occur must be Clery-reported per 34 CFR 668.46. Link required for incident location verification and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Advancement events are often hosted by academic units/cost centers for budget and expense tracking. Creating advancement_event.cost_center_id to link to finance.cost_center for event cost allocation.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member responsible for planning and executing this event. Primary point of contact for event logistics, vendor coordination, and post-event reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Advancement events occur in specific fiscal periods for budget and expense tracking. Creating advancement_event.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: Advancement events requiring IT support (AV setup, live streaming, registration kiosks, WiFi provisioning) generate service requests that link to event context for resource planning, cost allocation, ',
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

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`recognition_society` (
    `recognition_society_id` BIGINT COMMENT 'Unique identifier for the donor recognition society or giving club. Primary key.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the specific fund or endowment that this recognition society supports or is tied to for giving credit.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign with which this recognition society is primarily associated, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recognition societies are often tied to academic units/cost centers for budget and event tracking. Creating recognition_society.cost_center_id to link to finance.cost_center for financial reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement staff member responsible for coordinating stewardship activities and member engagement for this recognition society.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Recognition societies are reported by fiscal period for fundraising and membership tracking. Creating recognition_society.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Recognition societies are donor stewardship programs requiring org hierarchy linkage for budget ownership, membership reporting by academic unit, event planning coordination, and institutional advance',
    `active_member_count` STRING COMMENT 'Current number of active members who meet the giving threshold and are in good standing within the recognition society.',
    `annual_recognition_event_flag` BOOLEAN COMMENT 'Indicates whether the recognition society hosts an annual signature event for members (True) or not (False).',
    `contact_email` STRING COMMENT 'Primary email address for inquiries and communications regarding the recognition society.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for inquiries and communications regarding the recognition society.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this recognition society record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the recognition society ceased operations or was retired, if applicable. Null for active societies.',
    `effective_start_date` DATE COMMENT 'Date from which the recognition society began accepting members and conferring benefits under current criteria.',
    `endowment_funded_flag` BOOLEAN COMMENT 'Indicates whether the recognition society is supported by or tied to an endowed fund (True) or operates through annual giving (False).',
    `founding_date` DATE COMMENT 'Date on which the recognition society was established or officially launched by the institution.',
    `giving_level_tier` STRING COMMENT 'Hierarchical tier or level within the institutional donor recognition structure (e.g., Platinum, Gold, Silver, Bronze, or numeric tier designation).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this recognition society record was most recently updated or modified.',
    `lifetime_member_count` STRING COMMENT 'Total cumulative count of all individuals who have ever qualified for membership in the recognition society since its inception.',
    `member_benefits_summary` STRING COMMENT 'Summary of benefits, privileges, and recognition opportunities provided to members (e.g., exclusive events, publications, naming opportunities, special access).',
    `membership_renewal_required_flag` BOOLEAN COMMENT 'Indicates whether members must renew their membership annually by meeting the giving threshold each year (True) or if membership is conferred permanently once achieved (False).',
    `minimum_giving_threshold` DECIMAL(18,2) COMMENT 'Minimum cumulative or annual gift amount required for membership eligibility in the recognition society.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special considerations, historical context, or administrative remarks about the recognition society.',
    `prospect_qualification_flag` BOOLEAN COMMENT 'Indicates whether membership in this recognition society qualifies donors for major gift prospect research and cultivation (True) or not (False).',
    `recognition_level` STRING COMMENT 'Descriptive label for the level of institutional recognition conferred to members (e.g., Benefactor, Patron, Fellow, Associate).',
    `recognition_publication_flag` BOOLEAN COMMENT 'Indicates whether members of this recognition society are publicly acknowledged in institutional publications, honor rolls, or donor reports (True) or kept confidential (False).',
    `society_code` STRING COMMENT 'Short alphanumeric code used to identify the recognition society in operational systems and reporting.',
    `society_description` STRING COMMENT 'Detailed narrative description of the recognition societys purpose, history, and significance within the institutions advancement program.',
    `society_name` STRING COMMENT 'Official name of the donor recognition society or giving club (e.g., Presidents Circle, Deans Society, Heritage Society).',
    `society_status` STRING COMMENT 'Current operational status of the recognition society indicating whether it is actively accepting members and conferring benefits.. Valid values are `active|inactive|suspended|archived`',
    `society_type` STRING COMMENT 'Classification of the recognition society by giving program type (annual giving leadership clubs, major gift societies, planned giving heritage societies, cumulative lifetime giving, or special purpose recognition).. Valid values are `annual_giving|major_gifts|planned_giving|leadership|cumulative|special_purpose`',
    `threshold_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum giving threshold (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `threshold_period` STRING COMMENT 'Time period over which the minimum giving threshold is measured (annual giving, lifetime cumulative, specific campaign, fiscal year, or calendar year).. Valid values are `annual|lifetime|campaign|fiscal_year|calendar_year`',
    `total_funds_raised_ytd` DECIMAL(18,2) COMMENT 'Cumulative amount of funds raised from members of this recognition society during the current fiscal year.',
    `visibility_status` STRING COMMENT 'Indicates the public visibility and accessibility of the recognition society (publicly promoted, private/confidential, restricted to certain constituencies, or invitation-only).. Valid values are `public|private|restricted|invitation_only`',
    `website_url` STRING COMMENT 'Web address of the dedicated page or microsite providing information about the recognition society, membership criteria, and benefits.',
    CONSTRAINT pk_recognition_society PRIMARY KEY(`recognition_society_id`)
) COMMENT 'Master record for a named donor recognition society or giving club (e.g., Presidents Circle, Deans Society, Heritage Society for planned giving, annual giving leadership clubs), capturing society name, minimum giving threshold, giving level tier, associated fund or campaign, member benefits, and active member count. Supports tiered donor recognition programs and stewardship differentiation by giving level.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`corporate_sponsorship` (
    `corporate_sponsorship_id` BIGINT COMMENT 'Unique identifier for the corporate sponsorship agreement. Primary key for this entity.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the institutional fund or account where sponsorship revenue is deposited and tracked.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign under which this sponsorship was secured, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Corporate sponsorships often support specific academic units/cost centers. Creating corporate_sponsorship.cost_center_id to link to finance.cost_center for revenue allocation and budget tracking.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Corporate sponsorships are recorded in specific fiscal periods for revenue recognition. Creating corporate_sponsorship.fiscal_period_id to link to finance.fiscal_period for period-based reporting.',
    `employee_id` BIGINT COMMENT 'Identifier for the advancement staff member assigned to manage the sponsor relationship, coordinate benefit delivery, and serve as primary institutional contact.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Corporate sponsorships may trigger UBIT (unrelated business income tax) filings if quid-pro-quo benefits exceed IRS safe harbors. Link required for tax compliance review and Form 990-T preparation.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Corporate sponsorships post to revenue ledger accounts for GL accounting. Creating corporate_sponsorship.revenue_ledger_account_id to link to finance.ledger_account for revenue recognition.',
    `organization_id` BIGINT COMMENT 'Reference to the corporate or foundation entity providing the sponsorship. Links to the organization master record in the advancement system.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship agreement automatically renews unless either party provides notice of termination.',
    `benefit_package_description` STRING COMMENT 'Detailed description of the recognition benefits, naming rights, event access, branding opportunities, and other quid pro quo benefits provided to the sponsor in exchange for their financial support.',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed sponsorship agreement document stored in the institutional document management system.',
    `contract_duration_months` STRING COMMENT 'Length of the sponsorship agreement in months, calculated from start to end date.',
    `contract_end_date` DATE COMMENT 'Date when the sponsorship agreement expires and sponsor benefits cease, unless renewed.',
    `contract_start_date` DATE COMMENT 'Date when the sponsorship agreement becomes effective and sponsor benefits begin to accrue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sponsorship record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the sponsorship amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fulfillment_completion_date` DATE COMMENT 'Date when all sponsor benefits and recognition obligations were fully delivered and completed.',
    `fulfillment_status` STRING COMMENT 'Current status of benefit delivery to the sponsor, tracking whether promised recognition and benefits have been provided.. Valid values are `not_started|in_progress|completed|partially_fulfilled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sponsorship record was most recently updated in the system.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the sponsor.',
    `naming_rights_granted` STRING COMMENT 'Specific naming rights granted to the sponsor (e.g., building name, program name, endowed chair title, event title).',
    `next_payment_due_date` DATE COMMENT 'Date when the next scheduled sponsorship payment is expected from the sponsor.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or contextual information about the sponsorship agreement.',
    `payment_outstanding` DECIMAL(18,2) COMMENT 'Remaining sponsorship amount not yet received, calculated as total sponsorship amount minus payments received to date.',
    `payment_received_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount of sponsorship payments received from the sponsor as of the current date.',
    `payment_schedule` STRING COMMENT 'Frequency and timing of sponsorship payments (lump sum, annual installments, semi-annual, quarterly, monthly, or milestone-based).. Valid values are `lump_sum|annual|semi_annual|quarterly|monthly|milestone`',
    `prospect_research_flag` BOOLEAN COMMENT 'Indicates whether this sponsor has been identified as a prospect for future major gift solicitation beyond sponsorship.',
    `recognition_level` STRING COMMENT 'Tiered recognition level assigned to the sponsor based on sponsorship amount and benefit package (platinum, gold, silver, bronze, or supporting).. Valid values are `platinum|gold|silver|bronze|supporting`',
    `renewal_date` DATE COMMENT 'Date by which the sponsorship agreement must be renewed or renegotiated to continue beyond the current term.',
    `renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether this sponsorship agreement is eligible for renewal at the end of the current term.',
    `sponsor_contact_email` STRING COMMENT 'Email address of the primary contact person at the sponsoring organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sponsor_contact_name` STRING COMMENT 'Name of the primary contact person at the sponsoring organization responsible for this agreement.',
    `sponsor_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the sponsoring organization.',
    `sponsorship_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the sponsorship commitment over the full contract period, representing the gross financial support provided by the sponsor.',
    `sponsorship_number` STRING COMMENT 'Externally-known unique identifier for the sponsorship agreement, used in contracts, invoices, and communications with the sponsor.',
    `sponsorship_status` STRING COMMENT 'Current lifecycle state of the sponsorship agreement (draft under negotiation, pending approval, active and in effect, fulfilled and completed, expired at term end, or terminated early).. Valid values are `draft|pending|active|fulfilled|expired|terminated`',
    `sponsorship_type` STRING COMMENT 'Category of sponsorship indicating what institutional asset or activity is being sponsored (event, academic program, facility naming, research initiative, scholarship fund, or athletics).. Valid values are `event|program|facility|research|scholarship|athletics`',
    `termination_date` DATE COMMENT 'Date when the sponsorship agreement was terminated early, if applicable.',
    `termination_reason` STRING COMMENT 'Explanation for why the sponsorship agreement was terminated before the scheduled end date.',
    CONSTRAINT pk_corporate_sponsorship PRIMARY KEY(`corporate_sponsorship_id`)
) COMMENT 'Master record for a corporate or foundation sponsorship agreement where a company provides financial support in exchange for institutional recognition, naming rights, event sponsorship, or research partnership benefits. Captures sponsor name, sponsorship type (event, program, facility, research, scholarship), sponsorship amount, benefit package, contract period, renewal date, assigned relationship manager, and fulfillment status. Distinct from a standard gift (no quid pro quo) and from a research grant (governed by Kuali Research).';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`advancement_registration` (
    `advancement_registration_id` BIGINT COMMENT 'Primary key for advancement_registration',
    `alumni_event_id` BIGINT COMMENT 'Foreign key linking to the alumni event for which registration occurred',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to the alumnus who registered for the event',
    `alumni_event_registration_id` BIGINT COMMENT 'Unique identifier for this registration record. Primary key for the registration association.',
    `advancement_registration_date` TIMESTAMP COMMENT 'Timestamp when the alumnus registered for the event. Critical for early-bird pricing determination and registration sequence tracking.',
    `cancellation_date` DATE COMMENT 'Date when the alumnus cancelled their registration. Null if registration is active. Used for refund processing and capacity management.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Timestamp when the alumnus checked in at the event venue or virtual platform. Used for attendance tracking and participation rate calculations. Null if registered but did not attend.',
    `confirmation_email_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the registration confirmation email was sent to the alumnus. Used for communication audit trail.',
    `dietary_requirements` STRING COMMENT 'Free-text field capturing any dietary restrictions or preferences for catered events (e.g., vegetarian, gluten-free, kosher, allergies). Used for catering planning and attendee accommodation.',
    `guest_count` STRING COMMENT 'Number of non-alumni guests accompanying this alumnus registration. Used for total headcount planning and guest fee calculation.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Actual amount paid by the alumnus for this registration, in the currency specified by the event. May differ from standard pricing due to discounts, scholarships, or complimentary access.',
    `payment_method` STRING COMMENT 'Method used to pay for the registration (credit_card, check, wire_transfer, complimentary, scholarship). Used for reconciliation and financial reporting.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration (confirmed, waitlisted, cancelled, attended, no_show). Controls communication workflows and attendance reporting.',
    `ticket_type` STRING COMMENT 'Classification of the registration ticket (standard, early_bird, guest, vip, complimentary). Determines pricing and access level for the event.',
    CONSTRAINT pk_advancement_registration PRIMARY KEY(`advancement_registration_id`)
) COMMENT 'This association product represents the Event between alumnus and alumni_event. It captures the operational business process of alumni registering for, paying for, and attending institutional events. Each record links one alumnus to one alumni_event with transactional attributes that exist only in the context of this specific registration instance.. Existence Justification: Alumni event registration is a well-established operational business process in higher education advancement. Alumni register for multiple events over their lifetime (homecoming, reunions, regional chapters, career networking), and each event hosts multiple alumni attendees. The institution actively manages registrations as discrete business transactions with payment processing, capacity management, dietary accommodations, check-in tracking, and cancellation workflows.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`advancement_assignment` (
    `advancement_assignment_id` BIGINT COMMENT 'Primary key for advancement_assignment',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to the alumnus who is serving in this volunteer assignment',
    `volunteer_assignment_id` BIGINT COMMENT 'Unique identifier for this volunteer assignment record. Primary key.',
    `volunteer_role_id` BIGINT COMMENT 'Foreign key linking to the volunteer role being filled by this assignment',
    `application_date` DATE COMMENT 'Date when the alumnus applied for or was nominated for this volunteer role assignment.',
    `approval_date` DATE COMMENT 'Date when this volunteer assignment was formally approved by the owning office or program manager.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this volunteer assignment. Tracks whether the assignment is active, completed, or in another state.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was first created in the system.',
    `end_date` DATE COMMENT 'The date when the alumnus completed or ended service in this volunteer role. Null indicates an active ongoing assignment. Corresponds to assignment_end_date from detection data.',
    `engagement_score` DECIMAL(18,2) COMMENT 'Calculated metric measuring the alumnus level of engagement and activity in this volunteer role assignment. Used for volunteer retention and recognition. From detection data.',
    `hours_served` DECIMAL(18,2) COMMENT 'Total number of volunteer hours the alumnus has contributed in this specific role assignment. Used for recognition, reporting, and impact measurement. From detection data.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated.',
    `notes` STRING COMMENT 'Free-text notes about this specific volunteer assignment including special circumstances, achievements, or coordination details.',
    `performance_rating` STRING COMMENT 'Evaluation of the alumnus performance in this volunteer role assignment. Used for recognition decisions and future assignment planning. From detection data.',
    `start_date` DATE COMMENT 'The date when the alumnus began serving in this volunteer role. Corresponds to assignment_start_date from detection data.',
    `training_completed_flag` BOOLEAN COMMENT 'Indicates whether the alumnus has completed required training for this specific volunteer role assignment. From detection data.',
    CONSTRAINT pk_advancement_assignment PRIMARY KEY(`advancement_assignment_id`)
) COMMENT 'This association product represents the Assignment between alumnus and volunteer_role. It captures the operational record of an alumnus serving in a specific volunteer capacity within institutional programs. Each record links one alumnus to one volunteer_role with attributes that track the lifecycle, performance, and engagement of that specific volunteer assignment. Supports volunteer management, recognition programs, and institutional advancement reporting.. Existence Justification: In higher education advancement operations, alumni regularly serve in multiple volunteer roles simultaneously or over time (e.g., an alumnus may serve as both a career mentor and a reunion committee member, or transition from phonathon caller to advisory board member). Conversely, each volunteer role (admissions ambassador, scholarship interviewer, etc.) is filled by multiple alumni across the institution. The business actively manages these assignments as operational records with lifecycle tracking, performance evaluation, and engagement measurement.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`campaign_volunteer` (
    `campaign_volunteer_id` BIGINT COMMENT 'Unique identifier for this faculty campaign volunteer assignment record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the fundraising campaign in which the instructor is volunteering',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the faculty instructor serving as a campaign volunteer',
    `dollars_raised` DECIMAL(18,2) COMMENT 'Total dollar amount raised by this volunteer through their solicitation efforts in this campaign. Used for performance tracking and recognition.',
    `participation_end_date` DATE COMMENT 'Date when the instructor completed or ended their volunteer service for this campaign. Null for ongoing volunteer assignments.',
    `participation_start_date` DATE COMMENT 'Date when the instructor began volunteering for this campaign. Marks the start of their volunteer assignment.',
    `recognition_level` STRING COMMENT 'Recognition tier awarded to the volunteer based on their contribution to the campaign (dollars raised, hours contributed, leadership demonstrated). Used for volunteer appreciation and stewardship.',
    `recruitment_date` DATE COMMENT 'Date when the instructor was recruited or invited to volunteer for this campaign.',
    `solicitation_assignment_count` STRING COMMENT 'Number of donor solicitation assignments given to this volunteer for this campaign. Tracks workload and activity level.',
    `training_completed_date` DATE COMMENT 'Date when the volunteer completed required training for their campaign role (solicitation techniques, campaign messaging, donor cultivation). Null if training not required or not yet completed.',
    `volunteer_role` STRING COMMENT 'The specific role the instructor plays in the campaign (solicitor, committee member, ambassador, etc.). Determines responsibilities and expectations.',
    `volunteer_status` STRING COMMENT 'Current status of the volunteer assignment: active (currently volunteering), inactive (paused), completed (assignment finished), declined (invitation declined).',
    CONSTRAINT pk_campaign_volunteer PRIMARY KEY(`campaign_volunteer_id`)
) COMMENT 'This association product represents the volunteer participation relationship between faculty instructors and fundraising campaigns. It captures faculty volunteer assignments as solicitors, committee members, or ambassadors in advancement campaigns. Each record links one instructor to one campaign with attributes tracking their volunteer role, solicitation outcomes, participation period, and recognition level.. Existence Justification: In higher education advancement operations, faculty instructors serve as volunteers in multiple fundraising campaigns simultaneously (annual fund, capital campaign, college-specific drives), and each campaign recruits multiple faculty volunteers to serve as solicitors, committee members, and ambassadors. The advancement office actively manages these volunteer assignments, tracking each instructors role, solicitation outcomes, dollars raised, participation period, and recognition level for each campaign they support.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`advancement_application_access` (
    `advancement_application_access_id` BIGINT COMMENT 'Primary key for advancement_application_access',
    `access_entitlement_id` BIGINT COMMENT 'Unique identifier for this access provisioning record. Primary key for the application_access association.',
    `access_provisioning_event_id` BIGINT COMMENT 'Reference to the IT service request or workflow that authorized this access provisioning. Used for audit and compliance tracking.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to the alumnus who has been granted access to the enterprise application',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to the enterprise application to which access has been provisioned',
    `access_granted_date` DATE COMMENT 'Date when access to this enterprise application was provisioned for the alumnus. Used for access lifecycle tracking and audit compliance.',
    `access_level` STRING COMMENT 'Level of access or permission granted to the alumnus for this application (read-only, standard, power-user, admin). Determines what features and data the alumnus can access.',
    `access_revoked_date` DATE COMMENT 'Date when access was revoked or deprovisioned, if applicable. Used for access lifecycle tracking and audit trails.',
    `access_status` STRING COMMENT 'Current status of this access provisioning (active, suspended, expired, revoked). Used for access governance and security compliance.',
    `cost_allocation_code` STRING COMMENT 'Budget code or cost center to which this license cost should be allocated. Used for IT chargeback and financial reporting.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent login by this alumnus to this application. Used for engagement analytics and license reclamation (identifying unused licenses).',
    `license_type` STRING COMMENT 'Type of software license assigned to this alumnus for this application (named-user, concurrent, site, free-tier). Used for license cost allocation and compliance tracking.',
    `usage_frequency` STRING COMMENT 'Calculated or categorized frequency of application usage by this alumnus (daily, weekly, monthly, quarterly, rarely, never). Used for engagement scoring and cost allocation.',
    CONSTRAINT pk_advancement_application_access PRIMARY KEY(`advancement_application_access_id`)
) COMMENT 'This association product represents the access provisioning relationship between alumni and enterprise applications. It captures when alumni are granted access to institutional systems (giving portal, career services platform, email forwarding, library systems, event registration), what level of access they have, and their usage patterns. Each record links one alumnus to one enterprise application with attributes that exist only in the context of this access relationship. Supports IT cost allocation, license management, and alumni engagement analytics.. Existence Justification: Alumni access multiple enterprise applications throughout their relationship with the institution (giving portal, career services platform, email forwarding, library systems, event registration), and each application serves many alumni. IT teams actively provision and manage these access relationships, tracking access levels, usage patterns, and license assignments for cost allocation, security compliance, and engagement analytics. This is an operational M:N relationship that IT staff create, update, and revoke as part of user access management.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`award_catalog` (
    `award_catalog_id` BIGINT COMMENT 'Primary key for award_catalog',
    `endowment_id` BIGINT COMMENT 'Reference to the endowment or fund that financially supports the award, if applicable.',
    `parent_award_catalog_id` BIGINT COMMENT 'Self-referencing FK on award_catalog (parent_award_catalog_id)',
    `approval_authority` STRING COMMENT 'Title or body that has final approval authority for award recipients (e.g., Board of Trustees, President, Dean, Alumni Board).',
    `award_category` STRING COMMENT 'Organizational scope or level at which the award is granted (institutional-wide, school/college-level, departmental, etc.).',
    `award_code` STRING COMMENT 'Unique business identifier code for the award, used in external communications and donor-facing materials.',
    `award_name` STRING COMMENT 'Official name of the award or recognition as it appears on certificates and public materials.',
    `award_type` STRING COMMENT 'Classification of the award category. [ENUM-REF-CANDIDATE: honorary_degree|distinguished_alumni|service_award|donor_recognition|academic_achievement|leadership_award|lifetime_achievement|volunteer_recognition|young_alumni|faculty_excellence|staff_excellence|community_impact — promote to reference product]',
    `commencement_presentation_flag` BOOLEAN COMMENT 'Indicates whether the award is typically presented during commencement ceremonies (true) or at other events (false).',
    `conferral_frequency` STRING COMMENT 'How often the award is granted (annually, biennially, on an ad-hoc basis, etc.).',
    `contact_email` STRING COMMENT 'Email address for inquiries about the award, nomination process, or selection criteria.',
    `contact_phone` STRING COMMENT 'Phone number for inquiries about the award program.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this award catalog record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value (e.g., USD, GBP, EUR).',
    `award_catalog_description` STRING COMMENT 'Detailed narrative description of the award purpose, criteria, and significance.',
    `display_order` STRING COMMENT 'Numeric value used to control the sort order when displaying awards in lists or on websites.',
    `effective_end_date` DATE COMMENT 'Date after which the award is no longer available for conferral. Null indicates the award is ongoing.',
    `effective_start_date` DATE COMMENT 'Date from which the award becomes active and available for conferral.',
    `eligibility_criteria` STRING COMMENT 'Formal requirements and qualifications that nominees must meet to be considered for this award.',
    `established_date` DATE COMMENT 'Date when the award was officially established or created by the institution.',
    `historical_recipient_count` STRING COMMENT 'Total number of individuals or entities who have received this award since its establishment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this award catalog record was most recently updated.',
    `maximum_recipients_per_cycle` STRING COMMENT 'Maximum number of individuals or entities that may receive this award in a single conferral cycle. Null indicates no limit.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Cash or scholarship amount associated with the award, if any. Null for non-monetary awards.',
    `nomination_deadline_description` STRING COMMENT 'Description of nomination deadline timing (e.g., January 31 annually, Rolling basis, 60 days before commencement).',
    `nomination_required_flag` BOOLEAN COMMENT 'Indicates whether a formal nomination process is required (true) or if recipients are selected through other means (false).',
    `notes` STRING COMMENT 'Additional administrative notes, special instructions, or historical context about the award.',
    `physical_award_type` STRING COMMENT 'Type of physical recognition item presented to recipients (plaque, medal, certificate, etc.).',
    `public_announcement_flag` BOOLEAN COMMENT 'Indicates whether award recipients are publicly announced and recognized (true) or kept confidential (false).',
    `selection_process` STRING COMMENT 'Description of the nomination, review, and selection methodology used to determine award recipients.',
    `self_nomination_allowed_flag` BOOLEAN COMMENT 'Indicates whether individuals may nominate themselves for this award (true) or must be nominated by others (false).',
    `sponsoring_unit` STRING COMMENT 'Name of the institutional unit, school, college, department, or alumni chapter that sponsors and administers the award.',
    `award_catalog_status` STRING COMMENT 'Current lifecycle status of the award in the catalog. Active awards are available for nomination and conferral.',
    `website_url` STRING COMMENT 'Web address of the page containing detailed information about the award, nomination process, and past recipients.',
    CONSTRAINT pk_award_catalog PRIMARY KEY(`award_catalog_id`)
) COMMENT 'Master reference table for award_catalog. Referenced by award_catalog_id.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`organization` (
    `organization_id` BIGINT COMMENT 'Primary key for organization',
    `parent_organization_id` BIGINT COMMENT 'Self-referencing FK on organization (parent_organization_id)',
    `address_line_1` STRING COMMENT 'The first line of the organizations primary physical address (street number and name).',
    `address_line_2` STRING COMMENT 'The second line of the organizations primary physical address (suite, floor, building, etc.).',
    `annual_revenue` DECIMAL(18,2) COMMENT 'The estimated or reported annual revenue of the organization, used for prospect research and capacity rating.',
    `city` STRING COMMENT 'The city where the organization is located.',
    `country_code` STRING COMMENT 'The three-letter ISO country code for the organizations location.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the organization record was first created in the system.',
    `data_source` STRING COMMENT 'The system or source from which the organization record originated (e.g., CRM, manual entry, data import).',
    `doing_business_as_name` STRING COMMENT 'The trade name or DBA name under which the organization operates, if different from legal name.',
    `donor_recognition_level` STRING COMMENT 'The recognition level or tier assigned to the organization based on cumulative giving (e.g., Platinum, Gold, Silver, Bronze).',
    `employee_count` STRING COMMENT 'The approximate number of employees working for the organization.',
    `fax_number` STRING COMMENT 'The fax number for the organization, if applicable.',
    `foundation_assets` DECIMAL(18,2) COMMENT 'The total assets held by the organization if it is a foundation, used for prospect research.',
    `industry_classification` STRING COMMENT 'The primary industry or sector in which the organization operates (e.g., technology, healthcare, manufacturing, education).',
    `last_gift_amount` DECIMAL(18,2) COMMENT 'The amount of the most recent gift received from the organization.',
    `last_gift_date` DATE COMMENT 'The date of the most recent gift received from the organization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the organization record was last updated.',
    `legal_name` STRING COMMENT 'The official legal name of the organization as registered with governing authorities.',
    `lifetime_giving_amount` DECIMAL(18,2) COMMENT 'The total cumulative amount of gifts and pledges received from the organization over its entire relationship history.',
    `matching_gift_eligible` BOOLEAN COMMENT 'Indicates whether the organization offers a matching gift program for employee donations.',
    `matching_gift_ratio` STRING COMMENT 'The ratio at which the organization matches employee gifts (e.g., 1:1, 2:1, 1:2).',
    `organization_name` STRING COMMENT 'The full legal or operating name of the organization.',
    `notes` STRING COMMENT 'Free-form notes or comments about the organization, including relationship history, preferences, or special considerations.',
    `organization_type` STRING COMMENT 'The legal classification of the organization (e.g., corporation, foundation, nonprofit, government entity, trust, partnership).',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the organizations address.',
    `preferred_communication_method` STRING COMMENT 'The organizations preferred method of communication for advancement outreach.',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the organization for advancement purposes.',
    `primary_contact_title` STRING COMMENT 'The job title of the primary contact person at the organization.',
    `primary_email` STRING COMMENT 'The primary email address for contacting the organization.',
    `primary_phone` STRING COMMENT 'The primary phone number for contacting the organization.',
    `relationship_end_date` DATE COMMENT 'The date when the relationship with the organization ended, if applicable.',
    `relationship_start_date` DATE COMMENT 'The date when the relationship with the organization was established.',
    `relationship_type` STRING COMMENT 'The primary type of relationship the organization has with the institution (e.g., donor, sponsor, partner, vendor, affiliate, employer).',
    `solicitation_code` STRING COMMENT 'A code indicating the organizations solicitation preferences or restrictions (e.g., do not solicit, mail only, phone only).',
    `state_province` STRING COMMENT 'The state or province where the organization is located.',
    `organization_status` STRING COMMENT 'The current operational status of the organization in the advancement system lifecycle.',
    `tax_identification_number` STRING COMMENT 'The tax identification number assigned to the organization by the relevant tax authority (e.g., EIN in the United States).',
    `website_url` STRING COMMENT 'The primary website URL for the organization.',
    CONSTRAINT pk_organization PRIMARY KEY(`organization_id`)
) COMMENT 'Master reference table for organization. Referenced by sponsor_organization_id.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`constituent` (
    `constituent_id` BIGINT COMMENT 'Primary key for constituent',
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
    `degree_earned` STRING COMMENT 'The primary degree or credential earned by the constituent (e.g., BA, BS, MBA, PhD).',
    `donor_status` STRING COMMENT 'Classification of the constituents giving status (e.g., active donor, lapsed donor, major gift donor, planned giving prospect).',
    `employer_name` STRING COMMENT 'Current employer or organization where the constituent works.',
    `engagement_score` STRING COMMENT 'Calculated score representing the constituents level of engagement with the institution based on interactions, event attendance, and communication responses.',
    `first_name` STRING COMMENT 'Legal first name or given name of the constituent.',
    `gender` STRING COMMENT 'Self-identified gender of the constituent.',
    `giving_capacity_rating` STRING COMMENT 'Estimated philanthropic capacity rating for the constituent based on wealth screening and prospect research.',
    `graduation_year` STRING COMMENT 'The year the constituent graduated from the institution, used for class year segmentation.',
    `industry` STRING COMMENT 'The industry sector in which the constituent is employed.',
    `job_title` STRING COMMENT 'Current job title or position held by the constituent.',
    `last_name` STRING COMMENT 'Legal last name or surname of the constituent.',
    `lifetime_giving_amount` DECIMAL(18,2) COMMENT 'Total cumulative amount of all gifts made by the constituent to the institution over their lifetime.',
    `maiden_name` STRING COMMENT 'Birth surname or previous surname of the constituent, typically used for alumni tracking.',
    `major_field_of_study` STRING COMMENT 'The primary academic major or field of study for the constituents degree.',
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

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`gift_agreement` (
    `gift_agreement_id` BIGINT COMMENT 'Primary key for gift_agreement',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign under which this gift agreement was solicited and secured.',
    `donor_id` BIGINT COMMENT 'Reference to the primary donor or constituent who established this gift agreement.',
    `employee_id` BIGINT COMMENT 'Reference to the advancement officer or volunteer who was primarily responsible for securing this gift agreement.',
    `advancement_fund_id` BIGINT COMMENT 'Reference to the institutional fund or account that will receive and manage the gift proceeds.',
    `amended_gift_agreement_id` BIGINT COMMENT 'Self-referencing FK on gift_agreement (amended_gift_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the gift agreement, typically used in donor communications and legal documentation.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the gift agreement indicating its operational standing and enforceability.',
    `agreement_type` STRING COMMENT 'Classification of the gift agreement based on the nature and purpose of the philanthropic commitment.',
    `balance_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the gift agreement, calculated as commitment amount minus paid amount.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Total monetary value pledged by the donor under this gift agreement, representing the full commitment before any payments.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this gift agreement record was first created in the advancement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the monetary denomination of the gift agreement amounts.',
    `effective_date` DATE COMMENT 'Date when the gift agreement becomes legally binding and enforceable between the institution and the donor.',
    `expiration_date` DATE COMMENT 'Date when the gift agreement terms conclude or the commitment period ends. Nullable for perpetual agreements.',
    `final_payment_date` DATE COMMENT 'Scheduled date for the last payment installment, marking the expected fulfillment of the gift commitment.',
    `first_payment_date` DATE COMMENT 'Scheduled date for the initial payment installment under this gift agreement.',
    `gift_purpose` STRING COMMENT 'Detailed narrative describing the donors intended use and purpose for the gift, including any restrictions or designations.',
    `gift_valuation_date` DATE COMMENT 'Date on which non-cash gifts were appraised or valued for accounting and tax reporting purposes.',
    `is_anonymous` BOOLEAN COMMENT 'Flag indicating whether the donor has requested anonymity in public recognition and reporting of this gift.',
    `is_matching_eligible` BOOLEAN COMMENT 'Flag indicating whether this gift agreement qualifies for corporate or foundation matching gift programs.',
    `legal_document_reference` STRING COMMENT 'Reference identifier for the formal legal contract or memorandum of understanding governing this gift agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this gift agreement record was last updated or modified.',
    `naming_opportunity` STRING COMMENT 'Specific building, program, scholarship, or institutional asset that will bear the donors name or designated honoree name.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional context, special conditions, or internal comments about the gift agreement.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount received to date against this gift agreement, tracking fulfillment progress.',
    `payment_frequency` STRING COMMENT 'Scheduled frequency at which the donor will make installment payments toward fulfilling the gift commitment.',
    `payment_method` STRING COMMENT 'Primary instrument or mechanism through which the donor will transfer gift payments to the institution.',
    `proposal_date` DATE COMMENT 'Date when the formal gift proposal was presented to the donor for consideration.',
    `recognition_level` STRING COMMENT 'Stewardship tier or recognition category assigned to this gift agreement, determining naming rights and acknowledgment benefits.',
    `reporting_frequency` STRING COMMENT 'Scheduled frequency for providing impact reports and updates to the donor regarding the use and outcomes of their gift.',
    `restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on the use of gift funds, aligned with accounting standards for nonprofit organizations.',
    `signed_date` DATE COMMENT 'Date when the donor and institutional representative executed the gift agreement with binding signatures.',
    `stewardship_plan` STRING COMMENT 'Documented plan for ongoing donor engagement, reporting, and recognition activities associated with this gift agreement.',
    `tax_deductible_amount` DECIMAL(18,2) COMMENT 'Portion of the gift commitment that qualifies for charitable tax deduction under applicable tax regulations.',
    CONSTRAINT pk_gift_agreement PRIMARY KEY(`gift_agreement_id`)
) COMMENT 'Master reference table for gift_agreement. Referenced by gift_agreement_id.';

CREATE OR REPLACE TABLE `education_ecm`.`advancement`.`stewardship_plan` (
    `stewardship_plan_id` BIGINT COMMENT 'Primary key for stewardship_plan',
    `advancement_fund_id` BIGINT COMMENT 'The unique identifier of the fund or designation that this stewardship plan supports (e.g., scholarship fund, endowment, capital project).',
    `campaign_id` BIGINT COMMENT 'The unique identifier of the fundraising campaign associated with this stewardship plan.',
    `employee_id` BIGINT COMMENT 'The unique identifier of the advancement officer or gift officer responsible for managing relationships under this stewardship plan.',
    `superseded_stewardship_plan_id` BIGINT COMMENT 'Self-referencing FK on stewardship_plan (superseded_stewardship_plan_id)',
    `annual_report_flag` BOOLEAN COMMENT 'Indicates whether donors in this stewardship plan receive a personalized annual impact report.',
    `approval_date` DATE COMMENT 'The date when this stewardship plan was formally approved by the appropriate authority.',
    `approval_status` STRING COMMENT 'The approval workflow status of the stewardship plan indicating whether it has been reviewed and authorized by leadership.',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved this stewardship plan for implementation.',
    `benefits_summary` STRING COMMENT 'A summary of the benefits, privileges, and recognition opportunities provided to donors under this stewardship plan.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The allocated budget for executing stewardship activities under this plan for the fiscal year.',
    `contact_strategy` STRING COMMENT 'The overall approach and methodology for donor contact and engagement defined by this stewardship plan (e.g., personalized outreach, event-based, digital-first, relationship-driven).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this stewardship plan record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for gift level thresholds (e.g., USD, GBP, EUR, CAD).',
    `stewardship_plan_description` STRING COMMENT 'A detailed narrative description of the stewardship plan objectives, activities, and engagement strategy.',
    `donor_segment` STRING COMMENT 'The target donor segment or constituency group that this stewardship plan is designed to engage (e.g., major donors, alumni, corporate partners, foundation supporters).',
    `effective_end_date` DATE COMMENT 'The date when this stewardship plan expires or is no longer active. Null indicates an open-ended plan.',
    `effective_start_date` DATE COMMENT 'The date when this stewardship plan becomes active and begins to govern donor engagement activities.',
    `engagement_frequency` STRING COMMENT 'The planned frequency of donor touchpoints and stewardship activities under this plan.',
    `event_invitation_flag` BOOLEAN COMMENT 'Indicates whether donors in this stewardship plan are invited to exclusive donor events and recognition ceremonies.',
    `gift_acknowledgment_template` STRING COMMENT 'The name or identifier of the gift acknowledgment letter template used for donors in this stewardship plan.',
    `gift_level_maximum` DECIMAL(18,2) COMMENT 'The maximum gift amount threshold for this stewardship plan tier. Null indicates no upper limit.',
    `gift_level_minimum` DECIMAL(18,2) COMMENT 'The minimum gift amount threshold that qualifies a donor for inclusion in this stewardship plan.',
    `last_review_date` DATE COMMENT 'The date when this stewardship plan was most recently reviewed and assessed for effectiveness.',
    `modified_by` STRING COMMENT 'The username or identifier of the individual who last modified this stewardship plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this stewardship plan record was last updated or modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this stewardship plan.',
    `notes` STRING COMMENT 'Additional free-form notes, comments, or observations about the stewardship plan for internal reference.',
    `plan_code` STRING COMMENT 'The unique business code or identifier assigned to this stewardship plan for external reference and system integration.',
    `plan_name` STRING COMMENT 'The human-readable name or title of the stewardship plan used for identification and reporting purposes.',
    `plan_type` STRING COMMENT 'The category or classification of the stewardship plan based on the fundraising program it supports.',
    `primary_contact_method` STRING COMMENT 'The preferred or primary channel for donor communication under this stewardship plan.',
    `priority_score` STRING COMMENT 'A numeric score representing the relative priority or importance of this stewardship plan within the advancement portfolio (higher values indicate higher priority).',
    `recognition_level` STRING COMMENT 'The tier or level of donor recognition associated with this stewardship plan (e.g., Presidents Circle, Deans Society, Founders Club).',
    `review_cycle` STRING COMMENT 'The scheduled frequency for reviewing and updating this stewardship plan to ensure continued relevance and effectiveness.',
    `stewardship_plan_status` STRING COMMENT 'The current lifecycle status of the stewardship plan indicating whether it is actively in use, under development, or retired.',
    `target_donor_count` STRING COMMENT 'The projected or target number of donors expected to be managed under this stewardship plan.',
    `created_by` STRING COMMENT 'The username or identifier of the individual who created this stewardship plan record.',
    CONSTRAINT pk_stewardship_plan PRIMARY KEY(`stewardship_plan_id`)
) COMMENT 'Master reference table for stewardship_plan. Referenced by stewardship_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ADD CONSTRAINT `fk_advancement_alumni_contact_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ADD CONSTRAINT `fk_advancement_alumni_communication_preference_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ADD CONSTRAINT `fk_advancement_affinity_group_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ADD CONSTRAINT `fk_advancement_group_membership_affinity_group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `education_ecm`.`advancement`.`affinity_group`(`affinity_group_id`);
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ADD CONSTRAINT `fk_advancement_group_membership_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ADD CONSTRAINT `fk_advancement_engagement_activity_mentorship_program_id` FOREIGN KEY (`mentorship_program_id`) REFERENCES `education_ecm`.`advancement`.`mentorship_program`(`mentorship_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ADD CONSTRAINT `fk_advancement_alumni_event_affinity_group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `education_ecm`.`advancement`.`affinity_group`(`affinity_group_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_alumni_event_id` FOREIGN KEY (`alumni_event_id`) REFERENCES `education_ecm`.`advancement`.`alumni_event`(`alumni_event_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ADD CONSTRAINT `fk_advancement_alumni_event_registration_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ADD CONSTRAINT `fk_advancement_volunteer_assignment_volunteer_role_id` FOREIGN KEY (`volunteer_role_id`) REFERENCES `education_ecm`.`advancement`.`volunteer_role`(`volunteer_role_id`);
ALTER TABLE `education_ecm`.`advancement`.`career_record` ADD CONSTRAINT `fk_advancement_career_record_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`career_record` ADD CONSTRAINT `fk_advancement_career_record_survey_response_id` FOREIGN KEY (`survey_response_id`) REFERENCES `education_ecm`.`advancement`.`survey_response`(`survey_response_id`);
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ADD CONSTRAINT `fk_advancement_advanced_degree_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ADD CONSTRAINT `fk_advancement_mentorship_match_mentorship_program_id` FOREIGN KEY (`mentorship_program_id`) REFERENCES `education_ecm`.`advancement`.`mentorship_program`(`mentorship_program_id`);
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ADD CONSTRAINT `fk_advancement_lifelong_learning_enrollment_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ADD CONSTRAINT `fk_advancement_alumni_survey_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ADD CONSTRAINT `fk_advancement_alumni_survey_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ADD CONSTRAINT `fk_advancement_survey_response_alumni_survey_id` FOREIGN KEY (`alumni_survey_id`) REFERENCES `education_ecm`.`advancement`.`alumni_survey`(`alumni_survey_id`);
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ADD CONSTRAINT `fk_advancement_survey_response_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ADD CONSTRAINT `fk_advancement_alumni_award_alumni_event_id` FOREIGN KEY (`alumni_event_id`) REFERENCES `education_ecm`.`advancement`.`alumni_event`(`alumni_event_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ADD CONSTRAINT `fk_advancement_alumni_award_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ADD CONSTRAINT `fk_advancement_alumni_award_award_catalog_id` FOREIGN KEY (`award_catalog_id`) REFERENCES `education_ecm`.`advancement`.`award_catalog`(`award_catalog_id`);
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ADD CONSTRAINT `fk_advancement_alumni_award_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ADD CONSTRAINT `fk_advancement_award_recipient_alumni_award_id` FOREIGN KEY (`alumni_award_id`) REFERENCES `education_ecm`.`advancement`.`alumni_award`(`alumni_award_id`);
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ADD CONSTRAINT `fk_advancement_award_recipient_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ADD CONSTRAINT `fk_advancement_award_recipient_event_id` FOREIGN KEY (`event_id`) REFERENCES `education_ecm`.`advancement`.`event`(`event_id`);
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ADD CONSTRAINT `fk_advancement_outreach_communication_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ADD CONSTRAINT `fk_advancement_outreach_communication_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `education_ecm`.`advancement`.`appeal`(`appeal_id`);
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ADD CONSTRAINT `fk_advancement_outreach_communication_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
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
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_affinity_group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `education_ecm`.`advancement`.`affinity_group`(`affinity_group_id`);
ALTER TABLE `education_ecm`.`advancement`.`appeal` ADD CONSTRAINT `fk_advancement_appeal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ADD CONSTRAINT `fk_advancement_major_gift_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ADD CONSTRAINT `fk_advancement_planned_gift_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ADD CONSTRAINT `fk_advancement_prospect_rating_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `education_ecm`.`advancement`.`appeal`(`appeal_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_gift_id` FOREIGN KEY (`gift_id`) REFERENCES `education_ecm`.`advancement`.`gift`(`gift_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `education_ecm`.`advancement`.`pledge`(`pledge_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ADD CONSTRAINT `fk_advancement_stewardship_action_stewardship_plan_id` FOREIGN KEY (`stewardship_plan_id`) REFERENCES `education_ecm`.`advancement`.`stewardship_plan`(`stewardship_plan_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_gift_agreement_id` FOREIGN KEY (`gift_agreement_id`) REFERENCES `education_ecm`.`advancement`.`gift_agreement`(`gift_agreement_id`);
ALTER TABLE `education_ecm`.`advancement`.`endowment` ADD CONSTRAINT `fk_advancement_endowment_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ADD CONSTRAINT `fk_advancement_matching_gift_claim_gift_id` FOREIGN KEY (`gift_id`) REFERENCES `education_ecm`.`advancement`.`gift`(`gift_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_affinity_group_id` FOREIGN KEY (`affinity_group_id`) REFERENCES `education_ecm`.`advancement`.`affinity_group`(`affinity_group_id`);
ALTER TABLE `education_ecm`.`advancement`.`event` ADD CONSTRAINT `fk_advancement_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ADD CONSTRAINT `fk_advancement_recognition_society_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ADD CONSTRAINT `fk_advancement_recognition_society_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ADD CONSTRAINT `fk_advancement_corporate_sponsorship_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `education_ecm`.`advancement`.`organization`(`organization_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ADD CONSTRAINT `fk_advancement_advancement_registration_alumni_event_id` FOREIGN KEY (`alumni_event_id`) REFERENCES `education_ecm`.`advancement`.`alumni_event`(`alumni_event_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ADD CONSTRAINT `fk_advancement_advancement_registration_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ADD CONSTRAINT `fk_advancement_advancement_registration_alumni_event_registration_id` FOREIGN KEY (`alumni_event_registration_id`) REFERENCES `education_ecm`.`advancement`.`alumni_event_registration`(`alumni_event_registration_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ADD CONSTRAINT `fk_advancement_advancement_assignment_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ADD CONSTRAINT `fk_advancement_advancement_assignment_volunteer_assignment_id` FOREIGN KEY (`volunteer_assignment_id`) REFERENCES `education_ecm`.`advancement`.`volunteer_assignment`(`volunteer_assignment_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ADD CONSTRAINT `fk_advancement_advancement_assignment_volunteer_role_id` FOREIGN KEY (`volunteer_role_id`) REFERENCES `education_ecm`.`advancement`.`volunteer_role`(`volunteer_role_id`);
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ADD CONSTRAINT `fk_advancement_campaign_volunteer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ADD CONSTRAINT `fk_advancement_advancement_application_access_alumnus_id` FOREIGN KEY (`alumnus_id`) REFERENCES `education_ecm`.`advancement`.`alumnus`(`alumnus_id`);
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` ADD CONSTRAINT `fk_advancement_award_catalog_endowment_id` FOREIGN KEY (`endowment_id`) REFERENCES `education_ecm`.`advancement`.`endowment`(`endowment_id`);
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` ADD CONSTRAINT `fk_advancement_award_catalog_parent_award_catalog_id` FOREIGN KEY (`parent_award_catalog_id`) REFERENCES `education_ecm`.`advancement`.`award_catalog`(`award_catalog_id`);
ALTER TABLE `education_ecm`.`advancement`.`organization` ADD CONSTRAINT `fk_advancement_organization_parent_organization_id` FOREIGN KEY (`parent_organization_id`) REFERENCES `education_ecm`.`advancement`.`organization`(`organization_id`);
ALTER TABLE `education_ecm`.`advancement`.`constituent` ADD CONSTRAINT `fk_advancement_constituent_spouse_constituent_id` FOREIGN KEY (`spouse_constituent_id`) REFERENCES `education_ecm`.`advancement`.`constituent`(`constituent_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` ADD CONSTRAINT `fk_advancement_gift_agreement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` ADD CONSTRAINT `fk_advancement_gift_agreement_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `education_ecm`.`advancement`.`donor`(`donor_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` ADD CONSTRAINT `fk_advancement_gift_agreement_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` ADD CONSTRAINT `fk_advancement_gift_agreement_amended_gift_agreement_id` FOREIGN KEY (`amended_gift_agreement_id`) REFERENCES `education_ecm`.`advancement`.`gift_agreement`(`gift_agreement_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` ADD CONSTRAINT `fk_advancement_stewardship_plan_advancement_fund_id` FOREIGN KEY (`advancement_fund_id`) REFERENCES `education_ecm`.`advancement`.`advancement_fund`(`advancement_fund_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` ADD CONSTRAINT `fk_advancement_stewardship_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `education_ecm`.`advancement`.`campaign`(`campaign_id`);
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` ADD CONSTRAINT `fk_advancement_stewardship_plan_superseded_stewardship_plan_id` FOREIGN KEY (`superseded_stewardship_plan_id`) REFERENCES `education_ecm`.`advancement`.`stewardship_plan`(`stewardship_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`advancement` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `education_ecm`.`advancement` SET TAGS ('dbx_domain' = 'advancement');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `cocurricular_record_id` SET TAGS ('dbx_business_glossary_term' = 'Cocurricular Record Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
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
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `graduation_date` SET TAGS ('dbx_business_glossary_term' = 'Graduation Date');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `graduation_term_code` SET TAGS ('dbx_business_glossary_term' = 'Graduation Term Code');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `honors_designation` SET TAGS ('dbx_business_glossary_term' = 'Honors Designation');
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
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_degree_level` SET TAGS ('dbx_business_glossary_term' = 'Primary Degree Level');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_degree_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Degree Name');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_major` SET TAGS ('dbx_business_glossary_term' = 'Primary Major');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumnus` ALTER COLUMN `school_college_name` SET TAGS ('dbx_business_glossary_term' = 'School or College Name');
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
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_business_glossary_term' = 'Secondary Email Address');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_contact` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `alumni_communication_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni Communication Preference Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `bounce_status` SET TAGS ('dbx_business_glossary_term' = 'Email Bounce Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `bounce_status` SET TAGS ('dbx_value_regex' = 'none|soft_bounce|hard_bounce|complaint');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `career_news_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Career News Topic Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `communication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency Preference');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `communication_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|as_needed');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consent Internet Protocol (IP) Address');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source Channel');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_source` SET TAGS ('dbx_value_regex' = 'web_form|phone|email|event|mail_response|in_person');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_business_glossary_term' = 'Consent User Agent String');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `consent_user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Global Do Not Contact Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `do_not_solicit` SET TAGS ('dbx_business_glossary_term' = 'Do Not Solicit for Fundraising Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `double_opt_in_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `double_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Communication Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `event_invitations_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Event Invitations Topic Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `fundraising_appeals_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Appeals Topic Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `gdpr_consent_version` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Version');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis for Processing');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `institutional_news_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Institutional News Topic Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Preference Record Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `last_bounce_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Email Bounce Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Phone Communication Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `postal_mail_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Postal Mail Communication Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `preference_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Expiration Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `preference_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Last Updated Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `preference_source_system` SET TAGS ('dbx_business_glossary_term' = 'Preference Source System');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|sms|none');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ar');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Communication Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `spam_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `spam_complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Spam Complaint Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `suppression_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Suppression Effective Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Communication Suppression Reason');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `unsubscribe_reason` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Reason');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `unsubscribe_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_communication_preference` ALTER COLUMN `volunteer_opportunities_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Opportunities Topic Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `affinity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group ID');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Chapter President Alumnus ID');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Staff Liaison Employee ID');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `affinity_group_status` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Status');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `affinity_group_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|dissolved');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `annual_dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Dues Amount');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `annual_event_count` SET TAGS ('dbx_business_glossary_term' = 'Annual Event Count');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `associated_athletic_team` SET TAGS ('dbx_business_glossary_term' = 'Associated Athletic Team');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `charter_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Charter Expiration Date');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `dues_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Dues Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `engagement_tier` SET TAGS ('dbx_business_glossary_term' = 'Engagement Tier');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `engagement_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|emerging');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `founding_date` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Founding Date');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Code');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Name');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Type');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `group_type` SET TAGS ('dbx_value_regex' = 'geographic_chapter|academic_college_chapter|identity_based_network|athletic_booster_club|professional_network|special_interest');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `last_event_date` SET TAGS ('dbx_business_glossary_term' = 'Last Event Date');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `membership_count` SET TAGS ('dbx_business_glossary_term' = 'Membership Count');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `mission_statement` SET TAGS ('dbx_business_glossary_term' = 'Mission Statement');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `recognition_level` SET TAGS ('dbx_value_regex' = 'presidential|distinguished|standard|provisional');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `social_media_handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `total_funds_raised_ytd` SET TAGS ('dbx_business_glossary_term' = 'Total Funds Raised Year-to-Date (YTD)');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL (Uniform Resource Locator)');
ALTER TABLE `education_ecm`.`advancement`.`affinity_group` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `group_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Group Membership Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `affinity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|mail|phone|sms|none|all');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Membership Dues Amount');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `dues_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Dues Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `dues_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `dues_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Dues Paid Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Dues Payment Status');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `dues_payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|waived|partial|overdue|pending');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `events_attended_count` SET TAGS ('dbx_business_glossary_term' = 'Events Attended Count');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `join_method` SET TAGS ('dbx_business_glossary_term' = 'Join Method');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `join_method` SET TAGS ('dbx_value_regex' = 'self_enrolled|staff_assigned|event_triggered|auto_assigned|invitation_accepted|application_approved');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `last_event_attended_date` SET TAGS ('dbx_business_glossary_term' = 'Last Event Attended Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `last_renewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewed Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `leadership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Leadership End Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `leadership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leadership Start Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `membership_role` SET TAGS ('dbx_business_glossary_term' = 'Membership Role');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|lapsed|honorary|suspended|pending|inactive');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'regular|lifetime|associate|emeritus|student|young_alumni');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Membership Notes');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Flag');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `recognition_level` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond|none');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Renewal Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `term_length_months` SET TAGS ('dbx_business_glossary_term' = 'Term Length in Months');
ALTER TABLE `education_ecm`.`advancement`.`group_membership` ALTER COLUMN `volunteer_hours` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Hours');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `engagement_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Activity Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`engagement_activity` ALTER COLUMN `mentorship_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
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
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `affinity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `early_registration_deadline` SET TAGS ('dbx_business_glossary_term' = 'Early Registration Deadline');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `early_registration_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Registration Fee');
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
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `guest_registration_fee` SET TAGS ('dbx_business_glossary_term' = 'Guest Registration Fee');
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
ALTER TABLE `education_ecm`.`advancement`.`alumni_event` ALTER COLUMN `standard_registration_fee` SET TAGS ('dbx_business_glossary_term' = 'Standard Registration Fee');
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
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_event_registration` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|refunded|waived|failed|partial');
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
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `volunteer_role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role ID');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|archived');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `application_required` SET TAGS ('dbx_business_glossary_term' = 'Application Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `associated_program` SET TAGS ('dbx_business_glossary_term' = 'Associated Program');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `benefits_description` SET TAGS ('dbx_business_glossary_term' = 'Benefits Description');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `capacity_target` SET TAGS ('dbx_business_glossary_term' = 'Capacity Target');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `impact_statement` SET TAGS ('dbx_business_glossary_term' = 'Impact Statement');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `owning_office` SET TAGS ('dbx_business_glossary_term' = 'Owning Office');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `preferred_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Qualifications');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Eligible Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `reporting_relationship` SET TAGS ('dbx_business_glossary_term' = 'Reporting Relationship');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `required_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Required Qualifications');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `role_category` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Category');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Code');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Description');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Name');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `role_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Subcategory');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `term_length_months` SET TAGS ('dbx_business_glossary_term' = 'Term Length in Months');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `time_commitment_estimate` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Estimate');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `time_commitment_hours_max` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Hours Maximum');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `time_commitment_hours_min` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Hours Minimum');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `visibility_status` SET TAGS ('dbx_business_glossary_term' = 'Visibility Status');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_role` ALTER COLUMN `visibility_status` SET TAGS ('dbx_value_regex' = 'public|alumni_only|invitation_only|internal');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `volunteer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Assignment ID');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus ID');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Coordinator ID');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `volunteer_role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role ID');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^VA-[0-9]{8}$');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|completed|on-hold|cancelled|pending');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|cleared|flagged');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `hours_served` SET TAGS ('dbx_business_glossary_term' = 'Hours Served');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `performance_notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|not-rated');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `recognition_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognition Awarded Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `recognition_level` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|lifetime');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `termination_notes` SET TAGS ('dbx_business_glossary_term' = 'Termination Notes');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'completed-term|personal-reasons|performance-issues|role-eliminated|volunteer-request|other');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `time_commitment_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Hours');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `education_ecm`.`advancement`.`volunteer_assignment` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `education_ecm`.`advancement`.`career_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`career_record` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `career_record_id` SET TAGS ('dbx_business_glossary_term' = 'Career Record ID');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Program ID');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni ID');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Response ID');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `career_field_alignment` SET TAGS ('dbx_business_glossary_term' = 'Career Field Alignment with Degree');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `career_field_alignment` SET TAGS ('dbx_value_regex' = 'directly-related|related|unrelated|unknown');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `career_notes` SET TAGS ('dbx_business_glossary_term' = 'Career Notes');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `company_website` SET TAGS ('dbx_business_glossary_term' = 'Company Website URL');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `company_website` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_value_regex' = 'online-form|phone-interview|email-survey|linkedin-api|manual-entry|batch-import');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Career Data Source');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'self-reported|linkedin-import|survey|career-services|employer-verification|third-party');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employer_industry_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employer_industry_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,6}$');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Name');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employer_size_category` SET TAGS ('dbx_business_glossary_term' = 'Employer Size Category');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employer_size_category` SET TAGS ('dbx_value_regex' = 'startup|small|medium|large|enterprise');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employment_city` SET TAGS ('dbx_business_glossary_term' = 'Employment City');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employment_country` SET TAGS ('dbx_business_glossary_term' = 'Employment Country');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employment_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employment_state_province` SET TAGS ('dbx_business_glossary_term' = 'Employment State or Province');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employment_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|self-employed|contract|academic|internship');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Employment End Date');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `is_current_position` SET TAGS ('dbx_business_glossary_term' = 'Current Position Indicator');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `is_featured_success_story` SET TAGS ('dbx_business_glossary_term' = 'Featured Success Story Indicator');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `is_self_employed` SET TAGS ('dbx_business_glossary_term' = 'Self-Employed Indicator');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `is_stem_position` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Position Indicator');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `job_function_category` SET TAGS ('dbx_business_glossary_term' = 'Job Function Category');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_value_regex' = '^https://www.linkedin.com/in/[a-zA-Z0-9_-]+/?$');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `position_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Position Sequence Number');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Career Record Status');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|pending-verification|disputed|deleted');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `remote_work_status` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Status');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `remote_work_status` SET TAGS ('dbx_value_regex' = 'on-site|hybrid|fully-remote|not-specified');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `salary_range_band` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Band');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `salary_range_band` SET TAGS ('dbx_value_regex' = 'under-30k|30k-50k|50k-75k|75k-100k|100k-150k|over-150k');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `salary_range_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'entry-level|mid-level|senior|executive|c-suite');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Start Date');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `supervisor_title` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Title');
ALTER TABLE `education_ecm`.`advancement`.`career_record` ALTER COLUMN `years_to_position` SET TAGS ('dbx_business_glossary_term' = 'Years to Position from Graduation');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `advanced_degree_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Degree ID');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus ID');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_city` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution City');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_country` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution Country');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_ipeds_code` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution IPEDS (Integrated Postsecondary Education Data System) ID');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_ipeds_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution Name');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_state` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution State or Province');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_type` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution Type');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `awarding_institution_type` SET TAGS ('dbx_value_regex' = 'public|private_nonprofit|private_for_profit|foreign');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `career_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Career Relevance Flag');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `concentration_specialization` SET TAGS ('dbx_business_glossary_term' = 'Concentration or Specialization');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'masters|doctoral|professional|post_doctoral|graduate_certificate|specialist');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `degree_record_number` SET TAGS ('dbx_business_glossary_term' = 'Degree Record Number');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `degree_status` SET TAGS ('dbx_business_glossary_term' = 'Degree Status');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `degree_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|withdrawn|deferred|verified|unverified');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `degree_title` SET TAGS ('dbx_business_glossary_term' = 'Degree Title');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `enrollment_start_year` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Year');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `field_of_study` SET TAGS ('dbx_business_glossary_term' = 'Field of Study');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `graduation_date` SET TAGS ('dbx_business_glossary_term' = 'Graduation Date');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `honors_distinction` SET TAGS ('dbx_business_glossary_term' = 'Honors or Distinction');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `major_advisor_name` SET TAGS ('dbx_business_glossary_term' = 'Major Advisor or Dissertation Chair Name');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `prospect_research_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospect Research Flag');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `record_created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `record_last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `record_last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `thesis_dissertation_title` SET TAGS ('dbx_business_glossary_term' = 'Thesis or Dissertation Title');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`advancement`.`advanced_degree` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|self_reported|pending_verification|unable_to_verify');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `mentorship_program_id` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Coordinator Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring College Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `owning_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `application_close_date` SET TAGS ('dbx_business_glossary_term' = 'Application Close Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `application_open_date` SET TAGS ('dbx_business_glossary_term' = 'Application Open Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email Address');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Description');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `matching_criteria` SET TAGS ('dbx_business_glossary_term' = 'Matching Criteria Description');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `matching_methodology` SET TAGS ('dbx_business_glossary_term' = 'Matching Methodology');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `matching_methodology` SET TAGS ('dbx_value_regex' = 'staff-matched|self-selected|algorithm-matched|hybrid');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `maximum_mentee_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Mentee Capacity');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `maximum_mentor_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Mentor Capacity');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `orientation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Orientation Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Code');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_cycle` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Cycle');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_cycle` SET TAGS ('dbx_value_regex' = 'academic year|fall semester|spring semester|summer term|rolling|calendar year');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Description');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Program Duration in Months');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Fee Amount');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Fee Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Name');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_objectives` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Objectives');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Status');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planning|archived');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Type');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'career mentorship|academic mentorship|entrepreneurship|diversity and inclusion|peer mentorship|executive mentorship');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `scholarship_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Available Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `success_metrics` SET TAGS ('dbx_business_glossary_term' = 'Success Metrics Description');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `time_commitment_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Hours');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_program` ALTER COLUMN `virtual_participation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Virtual Participation Allowed Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentorship_match_id` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Match Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Coordinator Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Mentor Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Mentor Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentorship_program_id` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Mentee Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `actual_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Months');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `agreement_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `communication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `communication_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|as_needed');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `expected_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Expected Duration in Months');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `focus_area` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Focus Area');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `industry_alignment` SET TAGS ('dbx_business_glossary_term' = 'Industry Alignment');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_date` SET TAGS ('dbx_business_glossary_term' = 'Match Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_end_date` SET TAGS ('dbx_business_glossary_term' = 'Match End Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Match Method');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_method` SET TAGS ('dbx_value_regex' = 'algorithm|manual|self_selected|coordinator_assigned|hybrid');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_notes` SET TAGS ('dbx_business_glossary_term' = 'Match Notes');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_number` SET TAGS ('dbx_business_glossary_term' = 'Match Number');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Match Quality Score');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_start_date` SET TAGS ('dbx_business_glossary_term' = 'Match Start Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'active|completed|withdrawn|paused|pending|cancelled');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentee_goals_achieved` SET TAGS ('dbx_business_glossary_term' = 'Mentee Goals Achieved Count');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentee_goals_total` SET TAGS ('dbx_business_glossary_term' = 'Mentee Total Goals Count');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentee_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Mentee Satisfaction Rating');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentee_type` SET TAGS ('dbx_business_glossary_term' = 'Mentee Type');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentee_type` SET TAGS ('dbx_value_regex' = 'student|alumnus');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `mentor_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Mentor Satisfaction Rating');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `orientation_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completed Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `orientation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completion Date');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `primary_communication_mode` SET TAGS ('dbx_business_glossary_term' = 'Primary Communication Mode');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `primary_communication_mode` SET TAGS ('dbx_value_regex' = 'in_person|video_call|phone|email|messaging|hybrid');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `program_cycle` SET TAGS ('dbx_business_glossary_term' = 'Program Cycle');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `recognition_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognition Awarded Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `recognition_type` SET TAGS ('dbx_business_glossary_term' = 'Recognition Type');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `renewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewed Flag');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `sessions_completed` SET TAGS ('dbx_business_glossary_term' = 'Number of Sessions Completed');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `sessions_expected` SET TAGS ('dbx_business_glossary_term' = 'Number of Sessions Expected');
ALTER TABLE `education_ecm`.`advancement`.`mentorship_match` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `lifelong_learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Lifelong Learning Enrollment Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `ceu_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Unit (CEU) Credits Earned');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|not_completed|in_progress|withdrawn|incomplete');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `contact_hours` SET TAGS ('dbx_business_glossary_term' = 'Contact Hours');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|synchronous_online|asynchronous_online');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `expected_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Completion Date');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `grade_earned` SET TAGS ('dbx_business_glossary_term' = 'Grade Earned');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `oer_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Based Flag');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Offering Type');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `owning_college` SET TAGS ('dbx_business_glossary_term' = 'Owning College');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `pass_fail_indicator` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Indicator');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `pass_fail_indicator` SET TAGS ('dbx_value_regex' = 'pass|fail|not_graded|in_progress');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial|waived|refunded|pending');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Amount');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `scholarship_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Applied Flag');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `tuition_amount` SET TAGS ('dbx_business_glossary_term' = 'Tuition Amount');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `tuition_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Tuition Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `tuition_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`advancement`.`lifelong_learning_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `alumni_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni Survey ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Campaign ID');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `accreditation_association` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Association');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `continuing_education_institution` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Institution');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `continuing_education_program` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Program');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'associate|bachelor|master|doctoral|professional|certificate');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|web_portal|phone|mail|in_person|mobile_app');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `graduation_term` SET TAGS ('dbx_business_glossary_term' = 'Graduation Term');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `graduation_term` SET TAGS ('dbx_value_regex' = 'fall|spring|summer|winter');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `instrument_version` SET TAGS ('dbx_business_glossary_term' = 'Instrument Version');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `invitation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Sent Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `job_location_city` SET TAGS ('dbx_business_glossary_term' = 'Job Location City');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `job_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Job Location Country Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `job_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `job_location_state_province` SET TAGS ('dbx_business_glossary_term' = 'Job Location State or Province');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `job_related_to_degree` SET TAGS ('dbx_business_glossary_term' = 'Job Related to Degree');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `job_start_date` SET TAGS ('dbx_business_glossary_term' = 'Job Start Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `last_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `response_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Target');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `response_source` SET TAGS ('dbx_business_glossary_term' = 'Response Source');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `response_source` SET TAGS ('dbx_value_regex' = 'direct_survey|linkedin_scrape|manual_entry|third_party_vendor|phone_interview');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|abandoned|invalid');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `salary_range` SET TAGS ('dbx_business_glossary_term' = 'Salary Range');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `salary_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Score');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|closed|archived');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'first_destination|career_outcomes|engagement|satisfaction|program_assessment|employer_feedback');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `target_population` SET TAGS ('dbx_business_glossary_term' = 'Target Population');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|flagged_for_review|rejected');
ALTER TABLE `education_ecm`.`advancement`.`alumni_survey` ALTER COLUMN `would_recommend` SET TAGS ('dbx_business_glossary_term' = 'Would Recommend');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Response ID');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `alumni_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus ID');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Coordinator ID');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `academic_college` SET TAGS ('dbx_business_glossary_term' = 'Academic College');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `accreditation_reporting_cycle` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Reporting Cycle');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `continuing_education_institution` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Institution');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `continuing_education_program` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Program');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Name');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'employed|unemployed|continuing_education|military|volunteer|not_seeking');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `first_access_date` SET TAGS ('dbx_business_glossary_term' = 'First Access Date');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `incentive_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered Flag');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `ipeds_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Reportable Flag');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `job_location_city` SET TAGS ('dbx_business_glossary_term' = 'Job Location City');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `job_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Job Location Country Code');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `job_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `job_location_state_province` SET TAGS ('dbx_business_glossary_term' = 'Job Location State or Province');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `job_related_to_degree_flag` SET TAGS ('dbx_business_glossary_term' = 'Job Related to Degree Flag');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `job_search_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Job Search Duration in Months');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|email|phone|mail|in_person');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_notes` SET TAGS ('dbx_business_glossary_term' = 'Response Notes');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_payload_json` SET TAGS ('dbx_business_glossary_term' = 'Response Payload JSON');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'complete|partial|refused|abandoned|in_progress|expired');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `salary_range` SET TAGS ('dbx_business_glossary_term' = 'Salary Range');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `salary_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `survey_invitation_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Invitation Date');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `used_in_accreditation_flag` SET TAGS ('dbx_business_glossary_term' = 'Used in Accreditation Flag');
ALTER TABLE `education_ecm`.`advancement`.`survey_response` ALTER COLUMN `would_recommend_flag` SET TAGS ('dbx_business_glossary_term' = 'Would Recommend Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `alumni_award_id` SET TAGS ('dbx_business_glossary_term' = 'Alumni Award Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `alumni_event_id` SET TAGS ('dbx_business_glossary_term' = 'Presentation Event Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Award Catalog Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `endowment_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_category` SET TAGS ('dbx_business_glossary_term' = 'Award Category');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_category` SET TAGS ('dbx_value_regex' = 'distinguished_alumni|young_alumni_achievement|service_award|honorary_degree|hall_of_fame|lifetime_achievement');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_name` SET TAGS ('dbx_business_glossary_term' = 'Award Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Award Subcategory');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `award_year` SET TAGS ('dbx_business_glossary_term' = 'Award Year');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `citation_text` SET TAGS ('dbx_business_glossary_term' = 'Citation Text');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `nomination_source` SET TAGS ('dbx_business_glossary_term' = 'Nomination Source');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `nomination_statement` SET TAGS ('dbx_business_glossary_term' = 'Nomination Statement');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `nomination_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `nominator_name` SET TAGS ('dbx_business_glossary_term' = 'Nominator Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `nominator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `nominator_relationship` SET TAGS ('dbx_business_glossary_term' = 'Nominator Relationship');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `presentation_location` SET TAGS ('dbx_business_glossary_term' = 'Presentation Location');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `presenter_name` SET TAGS ('dbx_business_glossary_term' = 'Presenter Name');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `prospect_qualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospect Qualification Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `publication_flag` SET TAGS ('dbx_business_glossary_term' = 'Publication Flag');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `recipient_class_year` SET TAGS ('dbx_business_glossary_term' = 'Recipient Class Year');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `recipient_degree` SET TAGS ('dbx_business_glossary_term' = 'Recipient Degree');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `recipient_major` SET TAGS ('dbx_business_glossary_term' = 'Recipient Major');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `review_committee` SET TAGS ('dbx_business_glossary_term' = 'Review Committee');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `selection_date` SET TAGS ('dbx_business_glossary_term' = 'Selection Date');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `selection_rationale` SET TAGS ('dbx_business_glossary_term' = 'Selection Rationale');
ALTER TABLE `education_ecm`.`advancement`.`alumni_award` ALTER COLUMN `selection_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `award_recipient_id` SET TAGS ('dbx_business_glossary_term' = 'Award Recipient Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `alumni_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Presentation Event Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `award_year` SET TAGS ('dbx_business_glossary_term' = 'Award Year');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `citation_text` SET TAGS ('dbx_business_glossary_term' = 'Award Citation Text');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `engagement_score_impact` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score Impact');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `featured_in_publication_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured in Alumni Publication Flag');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `monetary_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Monetary Award Amount');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `nomination_source` SET TAGS ('dbx_business_glossary_term' = 'Nomination Source');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `nomination_statement` SET TAGS ('dbx_business_glossary_term' = 'Nomination Statement');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `nomination_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `nominator_name` SET TAGS ('dbx_business_glossary_term' = 'Nominator Name');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `nominator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `nominator_relationship` SET TAGS ('dbx_business_glossary_term' = 'Nominator Relationship to Recipient');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Award Recipient Notes');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Award Presentation Date');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `presentation_location` SET TAGS ('dbx_business_glossary_term' = 'Award Presentation Location');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `press_release_date` SET TAGS ('dbx_business_glossary_term' = 'Press Release Date');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `press_release_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Press Release Issued Flag');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `prospect_qualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospect Qualification Flag');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `prospect_rating` SET TAGS ('dbx_business_glossary_term' = 'Prospect Rating');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `publication_issue` SET TAGS ('dbx_business_glossary_term' = 'Publication Issue Reference');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `recipient_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Recipient Acceptance Date');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `recipient_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Recipient Acceptance Status');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `recipient_acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|no_response');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `recipient_number` SET TAGS ('dbx_business_glossary_term' = 'Award Recipient Number');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `selection_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Selection Committee Review Date');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `selection_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Selection Decision Date');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `selection_status` SET TAGS ('dbx_business_glossary_term' = 'Selection Status');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `selection_status` SET TAGS ('dbx_value_regex' = 'nominated|under_review|selected|declined|deferred|not_selected');
ALTER TABLE `education_ecm`.`advancement`.`award_recipient` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `outreach_communication_id` SET TAGS ('dbx_business_glossary_term' = 'Outreach Communication ID');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus ID');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal ID');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Staff ID');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `bounce_reason` SET TAGS ('dbx_business_glossary_term' = 'Bounce Reason');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `clicked_flag` SET TAGS ('dbx_business_glossary_term' = 'Clicked Flag');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `clicked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clicked Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_date` SET TAGS ('dbx_business_glossary_term' = 'Communication Date');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_notes` SET TAGS ('dbx_business_glossary_term' = 'Communication Notes');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_number` SET TAGS ('dbx_business_glossary_term' = 'Communication Number');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Status');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|sent|completed|cancelled');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'email|letter|phone_call|text_message|social_media_dm|postcard');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|bounced|undelivered|failed');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `ferpa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Compliant Flag');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Notes');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `message_body` SET TAGS ('dbx_business_glossary_term' = 'Message Body');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `opened_flag` SET TAGS ('dbx_business_glossary_term' = 'Opened Flag');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `response_type` SET TAGS ('dbx_business_glossary_term' = 'Response Type');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `response_type` SET TAGS ('dbx_value_regex' = 'gift|pledge|inquiry|opt_out|complaint|other');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `solicitation_code` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Code');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `education_ecm`.`advancement`.`outreach_communication` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject');
ALTER TABLE `education_ecm`.`advancement`.`donor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`donor` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Officer Identifier');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`donor` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`advancement`.`gift` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Officer Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_officer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `gift_officer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `ipeds_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Ipeds Submission Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`gift` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ledger Account Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`advancement`.`pledge` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
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
ALTER TABLE `education_ecm`.`advancement`.`campaign` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Coordinator Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign Identifier (ID)');
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
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Advancement Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`advancement_fund` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`advancement`.`appeal` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Designation Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`appeal` ALTER COLUMN `affinity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Identifier (ID)');
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
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `major_gift_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Proposal ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Officer ID');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`major_gift_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `planned_gift_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Gift Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`planned_gift` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `prospect_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Rating Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`prospect_rating` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
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
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
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
ALTER TABLE `education_ecm`.`advancement`.`stewardship_action` ALTER COLUMN `stewardship_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Plan Identifier (ID)');
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
ALTER TABLE `education_ecm`.`advancement`.`endowment` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `endowment_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Manager Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `gift_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Agreement Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `investment_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Pool Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `accounting_segment` SET TAGS ('dbx_business_glossary_term' = 'Accounting Segment Code');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `annual_distribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Distribution Amount');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `benefiting_college` SET TAGS ('dbx_business_glossary_term' = 'Benefiting College or School');
ALTER TABLE `education_ecm`.`advancement`.`endowment` ALTER COLUMN `benefiting_department` SET TAGS ('dbx_business_glossary_term' = 'Benefiting Department');
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
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `matching_gift_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Claim Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Fundraising Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Gift Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Staff Member Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Sent Date');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `acknowledgment_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Acknowledgment Sent Flag');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Status');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `appeal_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Flag');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Claim Number');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Claim Status');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `claimed_match_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Matching Gift Amount');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Deadline Date');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Date');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Reason');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `employer_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Organization Name');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `employer_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Employer Organization Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `match_ratio` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Ratio');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `matching_gift_program_name` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Program Name');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `maximum_match_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Annual Match Amount');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `minimum_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Eligible Gift Amount');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Claim Notes');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `original_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Donor Gift Amount');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Payment Method');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|credit_card|stock_transfer|other');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Payment Received Date');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `platform_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Platform Claim Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|email|third_party_platform|phone|fax');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `third_party_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Matching Gift Platform Name');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Employer Verification Date');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Employer Verification Status');
ALTER TABLE `education_ecm`.`advancement`.`matching_gift_claim` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|pending_verification|verified|failed_verification');
ALTER TABLE `education_ecm`.`advancement`.`event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`event` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Advancement Event Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `affinity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `clery_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Clery Incident Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Organizing Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`event` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `recognition_society_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition Society Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Coordinator Identifier (ID)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `active_member_count` SET TAGS ('dbx_business_glossary_term' = 'Active Member Count');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `annual_recognition_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual Recognition Event Flag');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `endowment_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Endowment Funded Flag');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `founding_date` SET TAGS ('dbx_business_glossary_term' = 'Founding Date');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `giving_level_tier` SET TAGS ('dbx_business_glossary_term' = 'Giving Level Tier');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `lifetime_member_count` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Member Count');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `member_benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Member Benefits Summary');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `membership_renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Membership Renewal Required Flag');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `minimum_giving_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Giving Threshold');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `prospect_qualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospect Qualification Flag');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `recognition_publication_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognition Publication Flag');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `society_code` SET TAGS ('dbx_business_glossary_term' = 'Society Code');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `society_description` SET TAGS ('dbx_business_glossary_term' = 'Society Description');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `society_name` SET TAGS ('dbx_business_glossary_term' = 'Society Name');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `society_status` SET TAGS ('dbx_business_glossary_term' = 'Society Status');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `society_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `society_type` SET TAGS ('dbx_business_glossary_term' = 'Society Type');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `society_type` SET TAGS ('dbx_value_regex' = 'annual_giving|major_gifts|planned_giving|leadership|cumulative|special_purpose');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `threshold_period` SET TAGS ('dbx_business_glossary_term' = 'Threshold Period');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `threshold_period` SET TAGS ('dbx_value_regex' = 'annual|lifetime|campaign|fiscal_year|calendar_year');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `total_funds_raised_ytd` SET TAGS ('dbx_business_glossary_term' = 'Total Funds Raised Year-to-Date (YTD)');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `visibility_status` SET TAGS ('dbx_business_glossary_term' = 'Visibility Status');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `visibility_status` SET TAGS ('dbx_value_regex' = 'public|private|restricted|invitation_only');
ALTER TABLE `education_ecm`.`advancement`.`recognition_society` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `corporate_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Sponsorship ID');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization ID');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Flag');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `benefit_package_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Description');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Months');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `fulfillment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Completion Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|partially_fulfilled');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `naming_rights_granted` SET TAGS ('dbx_business_glossary_term' = 'Naming Rights Granted');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `next_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Notes');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `payment_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Payment Outstanding');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `payment_received_to_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received to Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'lump_sum|annual|semi_annual|quarterly|monthly|milestone');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `prospect_research_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospect Research Flag');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `recognition_level` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|supporting');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible Flag');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Email');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Name');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Phone');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsorship_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Sponsorship Amount');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsorship_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Agreement Number');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsorship_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Agreement Status');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsorship_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|fulfilled|expired|terminated');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Type');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_value_regex' = 'event|program|facility|research|scholarship|athletics');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`advancement`.`corporate_sponsorship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` SET TAGS ('dbx_association_edges' = 'advancement.alumnus,advancement.alumni_event');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `advancement_registration_id` SET TAGS ('dbx_business_glossary_term' = 'advancement_registration Identifier');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `alumni_event_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Alumni Event Id');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Registration - Alumnus Id');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `alumni_event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Identifier');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `advancement_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `confirmation_email_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Email Sent Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `confirmation_email_sent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `confirmation_email_sent_timestamp` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `dietary_requirements` SET TAGS ('dbx_business_glossary_term' = 'Dietary Requirements');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Count');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `payment_amount` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `payment_method` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `education_ecm`.`advancement`.`advancement_registration` ALTER COLUMN `ticket_type` SET TAGS ('dbx_business_glossary_term' = 'Ticket Type');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` SET TAGS ('dbx_association_edges' = 'advancement.alumnus,advancement.volunteer_role');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `advancement_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'advancement_assignment Identifier');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Alumnus Id');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `volunteer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `volunteer_role_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Volunteer Role Id');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `hours_served` SET TAGS ('dbx_business_glossary_term' = 'Hours Served');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_assignment` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` SET TAGS ('dbx_association_edges' = 'faculty.instructor,advancement.campaign');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `campaign_volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Volunteer Identifier');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Volunteer - Campaign Id');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Volunteer - Instructor Id');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `dollars_raised` SET TAGS ('dbx_business_glossary_term' = 'Dollars Raised by Volunteer');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Participation End Date');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Participation Start Date');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Recognition Level');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `recruitment_date` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Recruitment Date');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `solicitation_assignment_count` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Assignment Count');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `training_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Training Completion Date');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `volunteer_role` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role');
ALTER TABLE `education_ecm`.`advancement`.`campaign_volunteer` ALTER COLUMN `volunteer_status` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Status');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` SET TAGS ('dbx_association_edges' = 'advancement.alumnus,technology.enterprise_application');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `advancement_application_access_id` SET TAGS ('dbx_business_glossary_term' = 'advancement_application_access Identifier');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Application Access Identifier');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `access_provisioning_event_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Request Identifier');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Application Access - Alumnus Id');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Access - Enterprise Application Id');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `access_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Access Granted Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `access_revoked_date` SET TAGS ('dbx_business_glossary_term' = 'Access Revoked Date');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `access_status` SET TAGS ('dbx_business_glossary_term' = 'Access Status');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `cost_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Code');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `education_ecm`.`advancement`.`advancement_application_access` ALTER COLUMN `usage_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Frequency');
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` SET TAGS ('dbx_subdomain' = 'alumni_relations');
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` ALTER COLUMN `award_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Award Catalog Identifier');
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` ALTER COLUMN `parent_award_catalog_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`award_catalog` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`organization` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `parent_organization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `foundation_assets` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `last_gift_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `last_gift_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `lifetime_giving_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `lifetime_giving_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`organization` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`constituent` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `spouse_constituent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `alternate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `alternate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `business_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `business_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `giving_capacity_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `lifetime_giving_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `maiden_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`constituent` ALTER COLUMN `maiden_name` SET TAGS ('dbx_pii_name' = 'true');
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
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` ALTER COLUMN `gift_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Agreement Identifier');
ALTER TABLE `education_ecm`.`advancement`.`gift_agreement` ALTER COLUMN `amended_gift_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` ALTER COLUMN `stewardship_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Plan Identifier');
ALTER TABLE `education_ecm`.`advancement`.`stewardship_plan` ALTER COLUMN `superseded_stewardship_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
