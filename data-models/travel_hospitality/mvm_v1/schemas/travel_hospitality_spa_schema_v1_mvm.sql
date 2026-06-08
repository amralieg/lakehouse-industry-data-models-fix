-- Schema for Domain: spa | Business: Travel Hospitality | Version: v1_mvm
-- Generated on: 2026-05-08 06:03:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `travel_hospitality_ecm`.`spa` COMMENT 'Spa, wellness, and recreation operations management including treatment catalogs, therapist scheduling, guest appointments, retail product sales, facility management, and revenue tracking for spa, fitness, golf, and pool amenities across luxury and resort properties.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`treatment` (
    `treatment_id` BIGINT COMMENT 'Unique identifier for the spa treatment. Primary key for the treatment master catalog.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Treatments may be brand-signature offerings (Ritz-Carlton signature treatments, Mandarin Oriental therapies). Links treatment inventory to brand identity, supports brand differentiation, and enables b',
    `parent_treatment_id` BIGINT COMMENT 'Self-referencing FK on treatment (parent_treatment_id)',
    `room_type_id` BIGINT COMMENT 'Type of treatment room or facility required to deliver this service (e.g., single room, couples suite, wet room, outdoor cabana). Used for facility scheduling and capacity planning.',
    `touchpoint_id` BIGINT COMMENT 'Foreign key linking to experience.touchpoint. Business justification: Spa treatments are mapped to guest journey touchpoints for NPS/GSS attribution and journey-stage analytics. Linking treatment to touchpoint enables touchpoint-level satisfaction scoring by treatment c',
    `advance_booking_required_hours` STRING COMMENT 'Minimum number of hours advance notice required to book this treatment. Used for scheduling rules and guest communication.',
    `age_restriction` STRING COMMENT 'Minimum age requirement or age-related restrictions for this treatment (e.g., 18+, 16+ with parental consent). Used for compliance and liability management.',
    `cancellation_policy_hours` STRING COMMENT 'Number of hours before the appointment that a guest can cancel without penalty. Used for revenue protection and scheduling optimization.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether therapists or spa staff earn commission on sales of this treatment. Used for payroll and incentive compensation calculations.',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage commission rate paid to therapists or staff on sales of this treatment. Used for payroll processing and labor cost analysis.',
    `contraindications` STRING COMMENT 'Medical conditions, allergies, or circumstances under which the treatment should not be performed or requires physician approval. Critical for guest safety and liability management.',
    `cost_of_goods` DECIMAL(18,2) COMMENT 'Standard cost of consumable products, oils, lotions, and supplies used in delivering this treatment. Used for margin analysis and profitability reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment record was first created in the master catalog system. Used for audit trail and data lineage.',
    `duration_minutes` STRING COMMENT 'Standard duration of the treatment in minutes, used for scheduling, therapist allocation, and capacity planning.',
    `effective_end_date` DATE COMMENT 'Date when this treatment is no longer available for new bookings. Null indicates no planned end date. Supports seasonal offerings and menu rotation.',
    `effective_start_date` DATE COMMENT 'Date when this treatment becomes available for booking and display in guest-facing systems. Supports seasonal launches and menu updates.',
    `gender_preference` STRING COMMENT 'Indicates whether the treatment is designed for specific gender or can be offered to any guest. Used for marketing segmentation and therapist assignment.. Valid values are `any|male_only|female_only|couples`',
    `gratuity_included_flag` BOOLEAN COMMENT 'Indicates whether gratuity is included in the treatment price or added separately. Used for pricing transparency and billing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this treatment record was last updated. Used for change tracking and data synchronization across systems.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points a guest earns when purchasing this treatment. Used for loyalty program integration and guest engagement.',
    `minimum_certification` STRING COMMENT 'Minimum professional certification, license, or credential required to perform this treatment (e.g., Licensed Massage Therapist, Esthetician License, Cosmetology License).',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this treatment record. Used for audit trail and accountability.',
    `pregnancy_safe_flag` BOOLEAN COMMENT 'Indicates whether this treatment is safe for pregnant guests. Critical for guest safety screening and liability management.',
    `recommended_retail_price` DECIMAL(18,2) COMMENT 'Corporate-recommended retail price for this treatment in the base currency. Individual properties may adjust based on local market conditions and positioning.',
    `required_equipment` STRING COMMENT 'List of specialized equipment, tools, or facilities required to deliver this treatment (e.g., hydrotherapy tub, vichy shower, hot stone warmer, facial steamer).',
    `retail_products_used` STRING COMMENT 'List of retail product SKUs or product lines used during the treatment. Supports cross-sell opportunities and inventory planning.',
    `revenue_center` STRING COMMENT 'Revenue center to which this treatment is assigned for financial reporting and GOP (Gross Operating Profit) analysis per USALI standards.. Valid values are `spa|wellness|fitness|salon|recreation`',
    `seasonal_availability` STRING COMMENT 'Indicates specific seasons or months when this treatment is available (e.g., summer only for outdoor treatments, winter for specific wellness programs).',
    `skill_level_required` STRING COMMENT 'Minimum skill level classification required for a therapist to perform this treatment. Used for therapist assignment and training planning.. Valid values are `entry|intermediate|advanced|master`',
    `subcategory` STRING COMMENT 'Secondary classification providing more granular segmentation within the primary category (e.g., Swedish Massage, Deep Tissue, Hot Stone within Massage category).',
    `treatment_category` STRING COMMENT 'Primary classification of the spa treatment type. Used for menu organization, revenue reporting, and therapist skill matching.. Valid values are `massage|facial|body_treatment|hydrotherapy|nail_service|beauty_service`',
    `treatment_code` STRING COMMENT 'Unique alphanumeric business identifier for the treatment used across all properties and systems. This is the externally-known catalog code used in PMS, POS, and booking systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `treatment_description` STRING COMMENT 'Detailed narrative description of the treatment including techniques, benefits, and guest experience. Used in spa menus, websites, and booking confirmations.',
    `treatment_name` STRING COMMENT 'Full marketing name of the spa treatment as displayed to guests in menus, booking systems, and promotional materials.',
    `treatment_status` STRING COMMENT 'Current lifecycle status of the treatment in the master catalog. Controls availability for booking and display in guest-facing systems.. Valid values are `active|inactive|seasonal|discontinued`',
    `upsell_treatments` STRING COMMENT 'List of complementary treatment codes that can be recommended as add-ons or follow-up services. Supports revenue optimization and guest experience enhancement.',
    CONSTRAINT pk_treatment PRIMARY KEY(`treatment_id`)
) COMMENT 'Master catalog of all spa and wellness treatments offered across properties, including massages, facials, body wraps, hydrotherapy, and beauty services. Captures treatment name, treatment code, category (massage, facial, body, nail, fitness), duration in minutes, treatment description, contraindications, required equipment, skill level required, minimum therapist certification, recommended retail price, cost of goods, revenue center classification, and active status. This is the SSOT for spa treatment definitions across the portfolio.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` (
    `treatment_menu_id` BIGINT COMMENT 'Unique identifier for the property-level spa treatment menu. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Treatment menus are often launched or promoted through specific marketing campaigns (new menu launches, seasonal menu promotions). Tracks which campaigns drive menu awareness and bookings, essential f',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Treatment menus are designed for specific market segments (luxury leisure, corporate wellness, local membership). Business process: spa menu strategy aligns with property market segmentation for targe',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Treatment menus are brand-specific (Ritz-Carlton Spa vs. Westin Heavenly Spa vs. Six Senses Spa). Essential for brand-specific menu management, brand standards enforcement, and supporting brand differ',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or property where this treatment menu is offered.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Spa treatment menus are governed by hotel rate plans (e.g., a Spa Inclusive rate plan activates a specific treatment menu). Revenue managers link treatment menu pricing and distribution eligibility ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.segment. Business justification: Treatment menus are curated by guest CRM segment (e.g., loyalty elite, leisure transient, corporate). Replacing the denormalized target_guest_segment text with a proper FK to guest.segment enables seg',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A treatment menu is offered at a specific spa facility within a property. A property may have multiple spa facilities (main spa, pool spa, fitness spa), each with its own treatment menu. treatment_men',
    `superseded_treatment_menu_id` BIGINT COMMENT 'Self-referencing FK on treatment_menu (superseded_treatment_menu_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this treatment menu was approved for publication and operational use.',
    `booking_channel_availability` STRING COMMENT 'Comma-separated list of channels where this menu is available for booking (e.g., web,mobile,front_desk,concierge,spa_reception).',
    `cancellation_policy_code` STRING COMMENT 'Reference code to the cancellation policy applicable to treatments booked from this menu (e.g., hours notice required, penalty fees).. Valid values are `^[A-Z0-9_]{2,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this treatment menu record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing on this treatment menu (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `display_sequence` STRING COMMENT 'Numeric ordering value controlling the presentation sequence of this menu in guest-facing channels and staff systems.',
    `effective_end_date` DATE COMMENT 'Date when this treatment menu expires or is no longer available for guest bookings. Null indicates an open-ended menu.',
    `effective_start_date` DATE COMMENT 'Date when this treatment menu becomes active and available for guest bookings at the property.',
    `gift_certificate_eligible_flag` BOOLEAN COMMENT 'Indicates whether treatments from this menu can be purchased or redeemed using spa gift certificates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this treatment menu record was last updated.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether treatments from this menu are eligible for loyalty program points accrual or redemption.',
    `maximum_advance_booking_days` STRING COMMENT 'Maximum number of days in advance that guests can book treatments from this menu to manage inventory and demand.',
    `menu_brochure_url` STRING COMMENT 'URL to the downloadable PDF brochure or detailed menu document for guest reference and marketing distribution.. Valid values are `^https?://.*.pdf$`',
    `menu_code` STRING COMMENT 'Business identifier code for the treatment menu, used for operational reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `menu_description` STRING COMMENT 'Detailed narrative description of the treatment menu, its theme, philosophy, and guest experience positioning for marketing and operational use.',
    `menu_image_url` STRING COMMENT 'URL to the primary marketing image or hero image representing this treatment menu in digital channels.. Valid values are `^https?://.*.(jpg|jpeg|png|gif|webp)$`',
    `menu_name` STRING COMMENT 'Display name of the treatment menu as presented to guests and staff (e.g., Summer Wellness Collection, Signature Spa Experience).',
    `menu_type` STRING COMMENT 'Classification of the treatment menu by its thematic focus or service model (signature, express, seasonal, couples, wellness, therapeutic, luxury). [ENUM-REF-CANDIDATE: signature|express|seasonal|couples|wellness|therapeutic|luxury — 7 candidates stripped; promote to reference product]',
    `menu_version` STRING COMMENT 'Version number of the treatment menu to track revisions and updates over time (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `minimum_advance_booking_hours` STRING COMMENT 'Minimum number of hours in advance that guests must book treatments from this menu to allow for preparation and scheduling.',
    `notes` STRING COMMENT 'Free-form operational notes or comments about this treatment menu for internal staff reference (e.g., special instructions, seasonal considerations, marketing campaigns).',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether guests can book treatments from this menu through online self-service channels (web, mobile app).',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether treatments from this menu can be bundled into spa packages or multi-treatment offerings.',
    `pricing_override_flag` BOOLEAN COMMENT 'Indicates whether this property-level menu applies custom pricing that overrides the master catalog treatment prices.',
    `published_date` DATE COMMENT 'Date when the treatment menu was officially published and made available to guests.',
    `published_status` STRING COMMENT 'Current publication state of the treatment menu indicating whether it is visible to guests and available for booking.. Valid values are `draft|published|archived|suspended|under_review`',
    `season_type` STRING COMMENT 'Seasonal classification indicating when this menu is active (peak, off-peak, shoulder, holiday, year-round) to support dynamic pricing and availability.. Valid values are `peak|off_peak|shoulder|holiday|year_round`',
    CONSTRAINT pk_treatment_menu PRIMARY KEY(`treatment_menu_id`)
) COMMENT 'Property-level spa treatment menu defining which treatments from the master catalog are offered at a specific property during a defined period. Captures property reference, menu name, menu version, effective date range, season (peak, off-peak, holiday), menu type (signature, express, seasonal, couples), published status, and pricing overrides at the property level. Enables property-specific menu curation while maintaining a global treatment catalog.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`therapist` (
    `therapist_id` BIGINT COMMENT 'Unique identifier for the spa therapist. Primary key for the therapist master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Therapists are assigned to cost centers for labor cost tracking, payroll allocation, and departmental budgeting. Required for spa labor cost analysis, productivity metrics (revenue per therapist hour)',
    `property_id` BIGINT COMMENT 'Home property where the therapist is primarily assigned. Links to the property master for location-based scheduling and revenue allocation.',
    `supervisor_therapist_id` BIGINT COMMENT 'Self-referencing FK on therapist (supervisor_therapist_id)',
    `availability_schedule` STRING COMMENT 'Standard weekly availability pattern for the therapist (e.g., days of week, shift preferences). Used for automated scheduling and shift planning.',
    `certification_level` STRING COMMENT 'Professional certification or skill level of the therapist within the spas internal competency framework. Determines service eligibility, pricing tier, and training pathway.. Valid values are `entry|intermediate|advanced|master|director`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of service revenue paid to the therapist as commission. Used for incentive compensation calculations and revenue sharing models.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the therapist record was first created in the system. Used for audit trail and data lineage tracking.',
    `email_address` STRING COMMENT 'Primary email address for the therapist. Used for schedule notifications, training communications, and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_type` STRING COMMENT 'Classification of the therapists employment relationship with the property. Determines scheduling rules, benefit eligibility, and commission structures.. Valid values are `full-time|part-time|contractor|seasonal|on-call`',
    `first_name` STRING COMMENT 'Legal first name of the therapist as recorded in employment records. Used for guest communication, scheduling displays, and service attribution.',
    `gender` STRING COMMENT 'Gender identity of the therapist. Used to honor guest preferences for therapist gender during booking and to ensure compliance with cultural and religious accommodation requirements.. Valid values are `male|female|non-binary|prefer not to say`',
    `guest_rating_average` DECIMAL(18,2) COMMENT 'Average guest satisfaction rating for the therapist across all completed appointments, typically on a 1-5 scale. Used for performance management, guest matching, and service quality monitoring.',
    `hire_date` DATE COMMENT 'Date the therapist was hired or contracted by the property. Used for seniority calculations, anniversary recognition, and tenure-based benefits.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Base hourly compensation rate for the therapist. Used for payroll calculations, labor cost analysis, and service pricing models. Excludes commissions and tips.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages the therapist can communicate in fluently. Used to match therapists with international guests and enhance guest experience through native-language service.',
    `last_name` STRING COMMENT 'Legal last name of the therapist as recorded in employment records. Used for guest communication, scheduling displays, and service attribution.',
    `last_training_date` DATE COMMENT 'Date of the most recent training or continuing education session completed by the therapist. Used to track compliance with professional development requirements and certification renewal.',
    `max_appointments_per_day` STRING COMMENT 'Maximum number of treatment appointments the therapist can perform in a single day. Used for scheduling optimization and therapist wellness management to prevent burnout.',
    `next_certification_due_date` DATE COMMENT 'Date by which the therapist must complete their next certification renewal or continuing education requirement. Used for proactive compliance management and training scheduling.',
    `notes` STRING COMMENT 'Free-text field for operational notes about the therapist, including special accommodations, scheduling preferences, performance observations, or guest feedback themes. Used by spa management for personalized workforce management.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the therapist. Used for emergency contact, shift change notifications, and operational communication.',
    `preferred_name` STRING COMMENT 'Name the therapist prefers to use in guest-facing interactions and on spa schedules. May differ from legal name for cultural, personal, or professional branding reasons.',
    `primary_license_expiry_date` DATE COMMENT 'Expiration date of the therapists primary professional license. Monitored for compliance; therapists cannot perform services after expiry without renewal.',
    `primary_license_number` STRING COMMENT 'State or national professional license number for massage therapy, esthetics, or other regulated spa services. Required for regulatory compliance and insurance coverage.',
    `primary_license_state` STRING COMMENT 'Two-letter state code where the primary professional license was issued. Used to verify jurisdiction-specific compliance and reciprocity eligibility.. Valid values are `^[A-Z]{2}$`',
    `specializations` STRING COMMENT 'Comma-separated list of treatment modalities and techniques the therapist is certified to perform (e.g., Swedish massage, deep tissue, hot stone, Ayurvedic, reflexology, aromatherapy, prenatal, sports massage, esthetics, body wraps). Used for service matching and guest preference fulfillment.',
    `termination_date` DATE COMMENT 'Date the therapists employment or contract ended. Null for active therapists. Used for historical reporting and rehire eligibility assessment.',
    `therapist_code` STRING COMMENT 'Unique alphanumeric code assigned to the therapist for scheduling, Point of Sale (POS) transactions, and operational reporting. Used in spa management systems and guest-facing booking interfaces.. Valid values are `^[A-Z0-9]{4,12}$`',
    `therapist_status` STRING COMMENT 'Current operational status of the therapist. Active therapists are available for scheduling; inactive, on-leave, suspended, or terminated therapists are excluded from guest-facing booking systems.. Valid values are `active|inactive|on-leave|suspended|terminated`',
    `tip_eligible_flag` BOOLEAN COMMENT 'Indicates whether the therapist is eligible to receive gratuities from guests. Varies by employment type and local labor regulations.',
    `total_appointments_completed` STRING COMMENT 'Cumulative count of all spa appointments completed by the therapist since hire date. Used for productivity tracking, milestone recognition, and experience validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the therapist record was last modified. Used for audit trail, change tracking, and data synchronization across systems.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of professional experience as a spa therapist, including prior employment at other properties or spas. Used for skill-based pricing, guest matching, and training program placement.',
    CONSTRAINT pk_therapist PRIMARY KEY(`therapist_id`)
) COMMENT 'Spa and wellness therapist master record representing individual practitioners employed or contracted at a property. Captures therapist name, employee reference, therapist code, specializations (Swedish, deep tissue, hot stone, Ayurvedic, esthetics), certification levels, license numbers, license expiry dates, years of experience, languages spoken, gender preference availability, employment type (full-time, part-time, contractor), home property, and active status. Distinct from workforce.employee as it captures spa-specific professional credentials and treatment competencies.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` (
    `therapist_certification_id` BIGINT COMMENT 'Unique identifier for the therapist certification record. Primary key.',
    `renewed_spa_therapist_certification_id` BIGINT COMMENT 'Self-referencing FK on spa_therapist_certification (renewed_spa_therapist_certification_id)',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist who holds this certification. Links to the therapist master record.',
    `certification_document_url` STRING COMMENT 'The storage location or URL of the scanned certification document or digital credential. Enables audit trail and verification support.',
    `certification_level` STRING COMMENT 'The proficiency level or tier of the certification. Used to match therapist expertise to guest service expectations and premium treatment offerings.. Valid values are `entry|intermediate|advanced|master|instructor`',
    `certification_name` STRING COMMENT 'The full name or title of the certification as issued by the certifying body (e.g., Licensed Massage Therapist, Certified Esthetician, Brand Signature Massage Specialist).',
    `certification_number` STRING COMMENT 'The unique certificate or license number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_type` STRING COMMENT 'The category of certification held by the therapist. Distinguishes between state-mandated licenses, brand-specific training certifications, and safety certifications required for spa operations. [ENUM-REF-CANDIDATE: state_massage_license|esthetics_license|cosmetology_license|brand_certification|specialty_certification|cpr_certification|first_aid_certification — 7 candidates stripped; promote to reference product]',
    `continuing_education_hours_completed` DECIMAL(18,2) COMMENT 'The number of continuing education hours the therapist has completed toward the current renewal cycle. Enables proactive management of renewal readiness.',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'The number of continuing education hours required for renewal of this certification. Used to track therapist compliance with professional development requirements.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred to obtain or renew this certification, including exam fees, training fees, and application fees. Used for workforce development budgeting and ROI analysis.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the certification cost. Supports multi-currency operations for global property portfolios.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the system. Audit trail field.',
    `effective_date` DATE COMMENT 'The date from which the certification becomes valid and the therapist is authorized to perform services under this credential. May differ from issue date for pre-dated certifications.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Null for certifications with no expiration. Critical for compliance tracking and renewal scheduling.',
    `instructor_name` STRING COMMENT 'The name of the instructor or trainer who conducted the certification training. Relevant for brand certifications and internal training programs.',
    `is_brand_required` BOOLEAN COMMENT 'Indicates whether this certification is mandated by brand service standards for therapists to perform certain treatments. Used to enforce brand compliance.',
    `is_primary_certification` BOOLEAN COMMENT 'Indicates whether this is the therapists primary professional certification. Used to identify the main credential under which the therapist practices.',
    `is_state_required` BOOLEAN COMMENT 'Indicates whether this certification is required by state or local regulatory authorities for the therapist to legally practice. Critical for compliance and risk management.',
    `issue_date` DATE COMMENT 'The date the certification was originally issued to the therapist. Used to calculate tenure and experience levels.',
    `issuing_body` STRING COMMENT 'The name of the organization, state board, or institution that issued the certification (e.g., California Board of Barbering and Cosmetology, American Red Cross, Brand Training Academy).',
    `issuing_jurisdiction` STRING COMMENT 'The state, province, or country where the certification was issued. Critical for multi-property operations to ensure therapists hold valid licenses for the jurisdictions where they practice.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the certification, such as special conditions, restrictions, or verification details. Supports operational context and audit trails.',
    `reimbursement_status` STRING COMMENT 'Indicates whether the certification cost was reimbursed by the employer. Used to track workforce development investments and employee benefit utilization.. Valid values are `not_applicable|pending|approved|reimbursed|denied`',
    `renewal_date` DATE COMMENT 'The date the certification was last renewed. Tracks compliance with continuing education and renewal requirements.',
    `renewal_status` STRING COMMENT 'The current renewal state of the certification. Indicates whether the credential is active, approaching renewal, or has lapsed. Used to trigger renewal workflows and prevent scheduling of non-compliant therapists.. Valid values are `current|pending_renewal|expired|suspended|revoked|not_applicable`',
    `specialty_area` STRING COMMENT 'The specific treatment specialty or modality covered by this certification (e.g., Deep Tissue Massage, Hot Stone Therapy, Aromatherapy, Facial Treatments, Body Wraps). Enables matching therapist qualifications to guest service requests.',
    `training_completion_date` DATE COMMENT 'The date the therapist completed the training program associated with this certification. Relevant for brand certifications and specialty training.',
    `training_hours` DECIMAL(18,2) COMMENT 'The total number of training hours completed to earn this certification. Used to assess depth of qualification and compare against brand standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was last modified. Audit trail field for tracking changes to certification status, renewal, or verification.',
    `verification_date` DATE COMMENT 'The date the certification was last verified with the issuing authority. Used to track verification currency and schedule re-verification.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity of the certification with the issuing body.. Valid values are `online_registry|phone_verification|document_review|third_party_service|not_verified`',
    `verification_status` STRING COMMENT 'Indicates whether the certification has been independently verified with the issuing body. Critical for regulatory compliance and risk management.. Valid values are `verified|pending_verification|failed_verification|not_verified`',
    CONSTRAINT pk_therapist_certification PRIMARY KEY(`therapist_certification_id`)
) COMMENT 'Certification and qualification records for spa therapists tracking professional licenses, brand-mandated training completions, and specialty certifications. Captures therapist reference, certification type (state massage license, esthetics license, brand certification, CPR, first aid), issuing body, certification number, issue date, expiry date, renewal status, and verification status. Supports compliance with state licensing requirements and brand service standards.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` (
    `spa_facility_id` BIGINT COMMENT 'Unique identifier for the spa, wellness, or recreation facility. Primary key. Role: MASTER_RESOURCE.',
    `content_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.content_asset. Business justification: Spa facilities are showcased through content assets (facility photos, virtual tours, amenity videos, 360-degree views). Essential for facility marketing, property-level content management, and support',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each spa facility operates as a cost center for expense allocation, budget management, and departmental P&L reporting. Essential for multi-facility spa operations, cost allocation, and USALI-compliant',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Major spa facility renovations and FF&E investments are capitalized as fixed assets for depreciation. Required for PIP (Property Improvement Plan) tracking, capital expenditure reporting, FF&E reserve',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Spa facilities are associated with specific brands (brand-specific spa concepts, branded wellness experiences). Critical for brand-level spa operations, brand standards compliance, and supporting bran',
    `parent_spa_facility_id` BIGINT COMMENT 'Self-referencing FK on spa_facility (parent_spa_facility_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Each spa facility may operate as a distinct profit center for owner reporting and segment performance analysis. Essential for multi-facility spa portfolio management, facility-level GOP reporting, and',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Spa facilities host specific guest experience programs (e.g., a destination spa facility is the venue for a branded wellness retreat program). This link enables program eligibility scoping by facility',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Unified facility compliance reporting: spa facilities are registered as property facilities for licensing, ADA compliance, and health inspections. A facilities manager expects spa_facility to referenc',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this facility is located.',
    `accessibility_features` STRING COMMENT 'Comma-separated list of accessibility accommodations available at the facility (e.g., wheelchair_accessible, hearing_loop, braille_signage, accessible_treatment_tables). Supports ADA compliance tracking.',
    `average_daily_visitors` STRING COMMENT 'Average number of unique guests visiting the facility per day, calculated over a rolling 90-day period. Used for capacity planning and staffing optimization.',
    `certification_accreditation` STRING COMMENT 'Comma-separated list of industry certifications, accreditations, or awards held by the facility (e.g., Forbes Five Star Spa, LEED Gold Certified, International Spa Association Member). Supports marketing and quality assurance.',
    `contact_email` STRING COMMENT 'Primary email address for facility reservations, guest inquiries, and operational communication. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for guest inquiries, reservations, and facility operations. Organizational contact data classified as confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system. Supports audit trail and data lineage tracking.',
    `facility_code` STRING COMMENT 'Unique alphanumeric code identifying the facility within the property management system. Used for operational reference and system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `facility_name` STRING COMMENT 'Full business name of the spa, wellness, or recreation facility as presented to guests (e.g., Serenity Spa & Wellness Center, Championship Golf Course).',
    `facility_status` STRING COMMENT 'Current operational lifecycle status of the facility: active (open and operational), inactive (permanently closed), under_renovation (closed for Property Improvement Plan execution), temporarily_closed (short-term closure), seasonal (operates only during specific seasons).. Valid values are `active|inactive|under_renovation|temporarily_closed|seasonal`',
    `facility_type` STRING COMMENT 'Classification of the facility by primary service offering: spa (full-service spa with treatments), fitness_center (gym and exercise equipment), golf_course (golf amenity), pool (swimming pool and aquatic facilities), tennis_court (tennis and racquet sports), salon (hair and beauty salon).. Valid values are `spa|fitness_center|golf_course|pool|tennis_court|salon`',
    `fire_safety_compliance_date` DATE COMMENT 'Date of the most recent fire safety inspection and compliance certification. Required for local fire code adherence and insurance purposes.',
    `gender_designation` STRING COMMENT 'Gender access policy for the facility: co_ed (open to all genders), female_only (restricted to female guests), male_only (restricted to male guests), gender_neutral (inclusive non-binary policy).. Valid values are `co_ed|female_only|male_only|gender_neutral`',
    `guest_access_policy` STRING COMMENT 'Policy governing who may access the facility: hotel_guests_only (restricted to registered guests), members_only (membership or loyalty program required), public_access (open to general public), day_pass_available (non-guests may purchase day access).. Valid values are `hotel_guests_only|members_only|public_access|day_pass_available`',
    `health_safety_compliance_date` DATE COMMENT 'Date of the most recent health and safety inspection or compliance audit. Supports regulatory reporting and operational risk management.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent major renovation or Property Improvement Plan (PIP) completion for the facility. Used for Furniture Fixtures and Equipment (FF&E) lifecycle tracking and capital expenditure (CapEx) planning.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this facility record. Supports change tracking and data quality monitoring.',
    `locker_room_capacity` STRING COMMENT 'Total number of lockers available in changing and locker room facilities. Indicates maximum concurrent guest capacity for facility usage.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether purchases and services at this facility are eligible for loyalty program points accrual. True if loyalty integration is active.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age in years required for guest access to the facility. Common values: 16 for spa facilities, 18 for adult-only wellness centers, 0 for family-friendly pools.',
    `next_scheduled_renovation_date` DATE COMMENT 'Planned date for the next major renovation or facility upgrade. Supports long-term capital planning and guest communication regarding temporary closures.',
    `operating_hours_friday` STRING COMMENT 'Facility operating hours on Friday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_monday` STRING COMMENT 'Facility operating hours on Monday in 24-hour format (HH:MM-HH:MM) or closed if not operational. Example: 06:00-22:00.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_saturday` STRING COMMENT 'Facility operating hours on Saturday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_sunday` STRING COMMENT 'Facility operating hours on Sunday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_thursday` STRING COMMENT 'Facility operating hours on Thursday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_tuesday` STRING COMMENT 'Facility operating hours on Tuesday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `operating_hours_wednesday` STRING COMMENT 'Facility operating hours on Wednesday in 24-hour format (HH:MM-HH:MM) or closed if not operational.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$`',
    `outdoor_space_flag` BOOLEAN COMMENT 'Indicates whether the facility includes outdoor amenities or treatment areas (e.g., outdoor pools, rooftop yoga decks, garden relaxation areas). True if outdoor space exists.',
    `peak_season_months` STRING COMMENT 'Comma-separated list of month names or numbers representing peak demand periods for the facility (e.g., June,July,August or 6,7,8). Supports revenue management and staffing planning.',
    `relaxation_lounge_capacity` STRING COMMENT 'Maximum seating capacity in relaxation lounges and quiet areas where guests rest before or after treatments. Measured in number of seats.',
    `reservation_required_flag` BOOLEAN COMMENT 'Indicates whether advance reservations are required for facility access or services. True if reservations are mandatory, false if walk-ins are accepted.',
    `retail_area_flag` BOOLEAN COMMENT 'Indicates whether the facility includes a retail area for selling spa products, wellness merchandise, or branded goods. True if retail space exists.',
    `seasonal_close_date` DATE COMMENT 'Annual date when seasonal facility closes for the off-season. Null if facility operates year-round.',
    `seasonal_open_date` DATE COMMENT 'Annual date when seasonal facility opens for the operating season. Null if facility operates year-round.',
    `seasonal_operation_flag` BOOLEAN COMMENT 'Indicates whether the facility operates on a seasonal schedule (e.g., outdoor pools open only in summer, golf courses closed in winter). True if seasonal.',
    `square_footage` STRING COMMENT 'Total interior square footage of the facility. Used for space utilization analysis, renovation planning, and benchmarking against industry standards.',
    `total_treatment_rooms` STRING COMMENT 'Total number of individual treatment rooms available for spa services, massages, facials, and body treatments. Used for capacity planning and scheduling.',
    `wet_area_capacity` STRING COMMENT 'Maximum guest capacity for wet amenities including steam rooms, saunas, whirlpools, and hydrotherapy pools. Measured in number of guests.',
    CONSTRAINT pk_spa_facility PRIMARY KEY(`spa_facility_id`)
) COMMENT 'Master record for spa, fitness, golf, and pool facility assets at each property. Captures facility name, facility code, facility type (spa, fitness center, golf course, pool, tennis court, salon), property reference, total treatment rooms, wet area capacity, locker room capacity, relaxation lounge capacity, operating hours by day of week, gender designation (co-ed, female-only, male-only), accessibility features, renovation status, and active status. Complements property.facility with spa-specific operational attributes.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` (
    `treatment_room_id` BIGINT COMMENT 'Unique identifier for the treatment room. Primary key for the treatment room entity.',
    `adjoining_treatment_room_id` BIGINT COMMENT 'Self-referencing FK on treatment_room (adjoining_treatment_room_id)',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Spa treatment rooms follow specific cleaning protocols defined in hotel cleaning standards (sanitation requirements, turnaround time, chemical specifications, quality thresholds) for health code compl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Treatment rooms may function as sub-cost centers for detailed expense tracking and room-level profitability analysis. Required for spa space utilization analysis, room-level revenue per available hour',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Treatment room build-outs and specialized equipment installations are capitalized as fixed assets. Essential for leasehold improvement tracking, room-level asset depreciation, capital investment ROI a',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this treatment room operates. Enables property-level spa performance analysis and cross-property benchmarking.',
    `spa_facility_id` BIGINT COMMENT 'Reference to the parent spa facility where this treatment room is located. Links room to its operating facility for capacity planning and revenue attribution.',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the treatment room meets accessibility standards for guests with disabilities (wheelchair access, grab bars, adjustable equipment). Required for ADA compliance reporting.',
    `ambiance_features` STRING COMMENT 'Descriptive text listing special ambiance and sensory features of the treatment room (e.g., ocean view, fireplace, aromatherapy diffuser, Himalayan salt wall). Used for marketing and guest preference matching.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the treatment room record was first created in the system. Used for data lineage and audit trail purposes.',
    `equipment_list` STRING COMMENT 'Comma-separated list of major equipment and fixtures installed in the treatment room (e.g., massage table, hydrotherapy tub, steam generator, chromotherapy system). Used for treatment compatibility verification and maintenance planning.',
    `ffe_value` DECIMAL(18,2) COMMENT 'Total capitalized value of furniture, fixtures, and equipment installed in the treatment room. Used for asset management, depreciation calculations, and insurance purposes.',
    `floor_number` STRING COMMENT 'Floor level where the treatment room is located within the spa facility. Used for guest navigation and accessibility planning.',
    `gender_designation` STRING COMMENT 'Gender access policy for the treatment room. Determines booking eligibility and guest assignment rules for culturally sensitive spa operations.. Valid values are `male|female|unisex|private`',
    `has_chromotherapy` BOOLEAN COMMENT 'Indicates whether the treatment room is equipped with chromotherapy (color therapy) lighting system. Premium feature for holistic wellness treatments.',
    `has_heated_table` BOOLEAN COMMENT 'Indicates whether the treatment room is equipped with a heated massage table. Premium amenity that affects treatment offerings and guest experience.',
    `has_music_system` BOOLEAN COMMENT 'Indicates whether the treatment room has an integrated audio system for ambient music and guided meditation. Enhances guest relaxation experience.',
    `has_outdoor_access` BOOLEAN COMMENT 'Indicates whether the treatment room has direct access to outdoor space (terrace, garden, or private patio). Premium feature for resort spa properties.',
    `has_private_shower` BOOLEAN COMMENT 'Indicates whether the treatment room includes an en-suite shower facility. Premium amenity that enables extended treatment packages and hydrotherapy services.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly rental or utilization rate for the treatment room used in internal cost allocation and revenue management calculations. Business-confidential pricing data.',
    `last_maintenance_date` DATE COMMENT 'Date when the treatment room last underwent scheduled maintenance or deep cleaning. Used for preventive maintenance scheduling and quality assurance.',
    `last_renovation_date` DATE COMMENT 'Date when the treatment room last underwent major renovation or refurbishment. Used for capital expenditure tracking and property improvement planning.',
    `maintenance_status` STRING COMMENT 'Current maintenance state of the treatment room. Determines availability for scheduling and triggers maintenance workflow processes.. Valid values are `operational|maintenance|repair|renovation|inspection`',
    `max_occupancy` STRING COMMENT 'Maximum number of guests that can be accommodated simultaneously in the treatment room. Critical for scheduling and safety compliance.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or inspection of the treatment room. Used for capacity planning and maintenance workflow management.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, or unique characteristics of the treatment room not captured in structured fields.',
    `operational_status` STRING COMMENT 'Current operational availability status of the treatment room. Controls whether the room appears in booking systems and capacity calculations.. Valid values are `active|inactive|seasonal|temporarily_closed`',
    `room_code` STRING COMMENT 'Short standardized code for the treatment room used in scheduling systems and operational reports (e.g., TR01, VIP-A, WET-3).',
    `room_name` STRING COMMENT 'Human-readable name of the treatment room used for guest communication and staff scheduling (e.g., Serenity Suite, Ocean View Room, Couples Retreat).',
    `room_number` STRING COMMENT 'Alphanumeric room number or code used for operational identification and wayfinding within the spa facility.',
    `room_type` STRING COMMENT 'Classification of the treatment room based on its design and intended use. Determines applicable treatments, pricing tier, and scheduling rules. [ENUM-REF-CANDIDATE: single|couples|vip_suite|wet_room|hydrotherapy|sauna|steam|relaxation_lounge — 8 candidates stripped; promote to reference product]',
    `sanitation_protocol` STRING COMMENT 'Level of sanitation and hygiene protocol applied to the treatment room. Determines cleaning frequency, products used, and turnaround time between appointments.. Valid values are `standard|enhanced|medical_grade`',
    `square_footage` DECIMAL(18,2) COMMENT 'Total floor area of the treatment room measured in square feet. Used for capacity planning, pricing strategy, and facility benchmarking.',
    `temperature_control_type` STRING COMMENT 'Type of climate control system available in the treatment room. Affects guest comfort customization and energy management.. Valid values are `central_hvac|individual_thermostat|radiant_floor|none`',
    `turnaround_time_minutes` STRING COMMENT 'Standard time in minutes required to clean, sanitize, and prepare the treatment room between guest appointments. Critical for accurate scheduling and capacity optimization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the treatment room record was last modified. Used for change tracking and data quality monitoring.',
    CONSTRAINT pk_treatment_room PRIMARY KEY(`treatment_room_id`)
) COMMENT 'Master record for individual treatment rooms and spaces within a spa facility. Captures room name, room number, room code, facility reference, room type (single, couples, VIP suite, wet room, hydrotherapy, sauna, steam), floor, square footage, equipment list, ambiance features (music system, chromotherapy, heated table), maximum occupancy, gender designation, maintenance status, and active status. Enables granular room-level scheduling and capacity management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`appointment` (
    `appointment_id` BIGINT COMMENT 'Unique identifier for the spa appointment booking. Primary key for the appointment entity.',
    `profile_id` BIGINT COMMENT 'FK to guest.profile.profile_id — MUST-HAVE: Spa appointments must link to guest profile for intake form pre-population, allergy alerts, preference recall, and folio posting. Core guest experience continuity requirement.',
    `appointment_profile_id` BIGINT COMMENT 'Reference to the guest who booked the spa appointment. Links to the guest master data.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Spa appointments for corporate direct-bill accounts or group bookings generate AR invoices separate from individual guest folios. Essential for corporate billing, credit management, and revenue recogn',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Spa appointments booked via OTA, concierge, or direct web require booking_source attribution for commission accrual, source-of-business reporting, and channel cost-of-acquisition analysis. More granul',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Spa appointments are frequently driven by marketing campaigns (seasonal promotions, email offers, package campaigns). Essential for campaign ROI tracking, attribution analysis, and measuring marketing',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Appointments are frequently booked using specific offer codes from marketing campaigns (discount codes, promotional offers, package deals). Essential for offer redemption tracking, validation, discoun',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Treatment appointments generate revenue allocated to spa treatment cost centers for departmental reporting. Essential for USALI spa department schedules, treatment revenue analysis, and cost center bu',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Spa appointments booked through OTA, GDS, or direct channels require channel attribution for commission accrual, revenue reconciliation, and channel ROI analysis. Essential for finance to calculate ch',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Spa appointment revenue is posted to fiscal periods for period-end close and USALI spa department reporting. appointment already carries ledger_id, cost_center_id, profit_center_id — fiscal_period_id ',
    `fitness_class_id` BIGINT COMMENT 'Foreign key linking to spa.fitness_class. Business justification: An appointment may be for a fitness class session (personal training, group fitness booking) rather than a spa treatment. appointment has treatment_id for spa treatments but no fitness_class_id. This ',
    `guest_interaction_id` BIGINT COMMENT 'Foreign key linking to experience.guest_interaction. Business justification: Pre-appointment consultations (treatment selection, health screening) and post-service follow-ups are logged guest interactions. Guest journey tracking systems link interactions to appointments for to',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Spa appointments should be analyzed by guest segment for personalization and targeting (wellness seekers, luxury travelers, local residents). Critical for segment performance analysis, treatment recom',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Treatment revenue posts to service revenue GL accounts for financial reporting and revenue recognition. Required for spa service revenue accounting, GL reconciliation, and ASC 606 revenue recognition ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa appointments for loyalty members should link to loyalty.member for proper points accrual tracking and member benefit validation. This FK enables real-time points calculation and member tier benefi',
    `package_id` BIGINT COMMENT 'Reference to a spa package or bundle if this appointment is part of a multi-treatment package booking. Nullable for standalone appointments.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Treatment revenue flows to spa profit center for GOP, EBITDA, and segment profitability reporting. Required for spa profit center performance measurement, management fee basis calculation, and owner f',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the spa appointment is scheduled. Links to property master data.',
    `rescheduled_appointment_id` BIGINT COMMENT 'Self-referencing FK on appointment (rescheduled_appointment_id)',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the hotel reservation associated with this spa appointment. Nullable for local guests or day spa visitors without hotel stays.',
    `reservation_group_block_id` BIGINT COMMENT 'Reference to a group booking record if this appointment is part of a group spa event (e.g., bridal party, corporate wellness). Nullable for individual bookings.',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Spa appointments are charged to guest room folios for consolidated billing. Revenue management and guest accounting require linking appointments to rooms for folio posting, a core operational process ',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Spa ancillary revenue attribution per hotel stay is a core hospitality KPI. Linking appointment to stay_history enables stay-level spa revenue reporting, ancillary attachment rate analysis, and post-s',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist assigned to perform the treatment. Links to workforce/therapist master data. Nullable if therapist not yet assigned.',
    `therapist_schedule_id` BIGINT COMMENT 'Foreign key linking to spa.therapist_schedule. Business justification: An appointment consumes a specific therapist schedule slot. Linking appointment.therapist_schedule_id -> therapist_schedule.therapist_schedule_id enables operational tracking of schedule utilization, ',
    `treatment_id` BIGINT COMMENT 'Reference to the spa treatment or service being booked (e.g., Swedish massage, facial, body wrap). Links to treatment catalog.',
    `treatment_room_id` BIGINT COMMENT 'Reference to the specific treatment room or facility space where the appointment will take place. Links to room inventory.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the spa treatment was completed. Captured at treatment conclusion. Nullable if appointment not yet completed.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the spa treatment began. Captured at check-in or treatment commencement. Nullable if appointment not yet started.',
    `appointment_date` DATE COMMENT 'The calendar date on which the spa appointment is scheduled to occur. Used for day-level scheduling and reporting.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the spa appointment. Tracks progression from initial booking through completion or cancellation. Critical for operational workflow and revenue recognition. [ENUM-REF-CANDIDATE: booked|confirmed|checked-in|in-progress|completed|cancelled|no-show — 7 candidates stripped; promote to reference product]',
    `arrival_time` TIMESTAMP COMMENT 'The actual date and time when the guest arrived at the spa facility for their appointment. Nullable if guest has not yet arrived. Used for punctuality tracking and operational efficiency.',
    `booking_channel` STRING COMMENT 'The channel or interface through which the guest made the spa appointment booking. Used for channel performance analysis and guest behavior insights. [ENUM-REF-CANDIDATE: front-desk|online|concierge|mobile-app|phone|in-room|walk-in — 7 candidates stripped; promote to reference product]',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was originally created in the system. Immutable audit field for booking lead time analysis and demand forecasting.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded explanation for why the appointment was cancelled. Nullable if appointment not cancelled. Used for operational analysis and service recovery.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was cancelled. Nullable if appointment not cancelled. Used for cancellation policy enforcement and revenue impact analysis.',
    `cancelled_by` STRING COMMENT 'Indicates which party initiated the cancellation: guest, property staff, automated system, or marked as no-show. Used for accountability and policy application.. Valid values are `guest|property|system|no-show`',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the guest was formally checked in for their spa appointment by front desk or spa reception. Nullable if not yet checked in. Distinct from arrival_time.',
    `confirmation_number` STRING COMMENT 'Externally-facing unique confirmation code provided to the guest for appointment reference and verification. Generated at booking time and used for guest communication.. Valid values are `^[A-Z0-9]{8,12}$`',
    `duration_minutes` STRING COMMENT 'The scheduled duration of the spa treatment in minutes. Derived from treatment catalog but stored for historical accuracy and schedule optimization.',
    `external_booking_reference` STRING COMMENT 'External reference number from third-party booking platforms or partner systems. Nullable for direct bookings. Used for reconciliation and partner integration.',
    `guest_gender_preference` STRING COMMENT 'The guests preference for therapist gender. Used for therapist assignment and guest satisfaction optimization.. Valid values are `male|female|no-preference`',
    `guest_notes` STRING COMMENT 'Internal staff notes about the guest or appointment. May include service preferences, behavioral observations, or operational notes. Confidential and not shared with guest.',
    `intake_form_completed` BOOLEAN COMMENT 'Boolean flag indicating whether the guest has completed the required health and wellness intake form prior to treatment. Required for compliance and risk management.',
    `intake_form_completed_timestamp` TIMESTAMP COMMENT 'The date and time when the guest completed the intake form. Nullable if form not yet completed. Used for compliance tracking and operational readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment record was last updated. Used for change tracking and audit trail. Updated on any modification to appointment details.',
    `no_show_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the guest failed to appear for the scheduled appointment without prior cancellation. Used for no-show fee application and guest behavior tracking.',
    `prepayment_amount` DECIMAL(18,2) COMMENT 'The monetary amount prepaid by the guest at the time of booking, typically as a deposit or full payment. Used for revenue tracking and cancellation policy enforcement. Nullable if no prepayment required.',
    `prepayment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the prepayment amount. Required when prepayment_amount is populated. Supports multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `pressure_preference` STRING COMMENT 'The guests preferred massage pressure level for treatments involving massage. Captured during booking or intake to personalize treatment delivery.. Valid values are `light|medium|firm|extra-firm|no-preference`',
    `scheduled_end_time` TIMESTAMP COMMENT 'The planned date and time when the spa appointment is scheduled to end. Calculated based on treatment duration.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The planned date and time when the spa appointment is scheduled to begin. Includes time zone information for multi-property operations.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this appointment record (e.g., Oracle OPERA PMS, standalone spa management system). Used for data lineage and integration troubleshooting.',
    `special_health_notes` STRING COMMENT 'Free-text field capturing any health conditions, allergies, injuries, or medical considerations the guest disclosed that may affect treatment delivery. Critical for guest safety and liability management.',
    `special_requests` STRING COMMENT 'Free-text field capturing any special requests or preferences the guest communicated at booking time (e.g., room temperature, music preference, aromatherapy oils). Used to personalize guest experience.',
    `therapist_gender_preference` STRING COMMENT 'The guests stated preference for the gender of the therapist performing the treatment. Supports personalized service delivery.. Valid values are `male|female|no-preference`',
    CONSTRAINT pk_appointment PRIMARY KEY(`appointment_id`)
) COMMENT 'Core transactional record for a guest spa appointment booking. Captures appointment confirmation number, guest reference, reservation reference, property reference, treatment reference, therapist reference, treatment room reference, appointment date, scheduled start time, scheduled end time, actual start time, actual end time, appointment status (booked, confirmed, checked-in, in-progress, completed, cancelled, no-show), booking channel (front desk, online, concierge, mobile app), guest gender preference, therapist gender preference, pressure preference, special health notes, intake form completion status, pre-payment amount, and cancellation reason. This is the SSOT for spa appointment lifecycle management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` (
    `appointment_package_id` BIGINT COMMENT 'Unique identifier for the spa appointment package booking record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Reference to the parent spa appointment under which this package is booked.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Spa package bookings generate AR invoices for billing to guests or corporate accounts. appointment_package has payment_status, total_amount, and tax_amount fields indicating it is a billable transacti',
    `attribution_event_id` BIGINT COMMENT 'Foreign key linking to marketing.attribution_event. Business justification: Package bookings are high-value conversion events requiring attribution to marketing touchpoints. Critical for understanding marketing journey to package purchase, calculating high-value conversion at',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Spa appointment packages sold through OTA or other booking sources require source attribution for commission accrual and channel performance reporting. appointment_package already has distribution_cha',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Package bookings often result from targeted marketing campaigns. Critical for measuring campaign effectiveness on high-value spa packages, calculating campaign ROI, and understanding which promotional',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Package bookings often use promotional offer codes (package discounts, bundle offers, early booking discounts). Critical for tracking offer performance on high-value packages, measuring promotional ef',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Spa appointment packages reference cancellation policies for penalty calculation and guest communication. Normalizing to the canonical reservation.cancellation_policy entity ensures consistent policy ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Spa packages sold via distribution channels need channel tracking for commission calculation, rate parity monitoring, and package performance analysis. Critical for revenue management to assess channe',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Spa packages involve prepayments and multi-service deferred revenue; finance requires fiscal_period linkage on appointment_package for period-end revenue recognition reporting and to reconcile package',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa package bookings earn loyalty points and qualify for elite member package discounts. Essential for points accrual on package revenue, tier-based package pricing, and points redemption for spa pack',
    `package_id` BIGINT COMMENT 'Foreign key linking to spa.spa_package. Business justification: appointment_package represents a transactional booking of a spa package. Currently it stores denormalized package_code, package_name, and package_type strings. Adding spa_package_id FK to spa_package ',
    `parent_appointment_package_id` BIGINT COMMENT 'Self-referencing FK on appointment_package (parent_appointment_package_id)',
    `profile_id` BIGINT COMMENT 'Reference to the guest who booked this spa package.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to loyalty.promotion. Business justification: Spa appointment packages are frequently booked under active loyalty promotions (e.g., Book a spa package and earn 5,000 bonus points). Tracking the promotion on the appointment_package record enable',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa package is offered and redeemed.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Spa appointment packages sold as part of a hotel stay require direct linkage to the reservation for pre-arrival fulfillment planning, integrated folio billing, and revenue managers stay-level spa pac',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Spa package bookings reference rate plans for pricing structure, restrictions (min LOS, advance purchase), and channel applicability. Business process: spa package pricing follows hotel rate plan meth',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Package bookings by hotel guests are posted to room folios. Finance and guest services require room linkage for charge posting, billing reconciliation, and checkout settlement in integrated resort ope',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: An appointment package booking is fulfilled at a specific spa facility. appointment_package has property_id (cross-domain) but no in-domain link to spa_facility. This FK enables facility-level package',
    `addon_services_amount` DECIMAL(18,2) COMMENT 'Total amount charged for additional services added to the base package.',
    `booking_channel` STRING COMMENT 'Channel through which the spa package booking was made.. Valid values are `web|mobile app|phone|front desk|concierge|in-room tablet`',
    `booking_date` DATE COMMENT 'Date when the guest booked this spa package.',
    `booking_status` STRING COMMENT 'Current lifecycle status of the spa package booking.. Valid values are `pending|confirmed|in-progress|completed|cancelled|no-show`',
    `booking_timestamp` TIMESTAMP COMMENT 'Precise date and time when the spa package booking was created in the system.',
    `cancellation_deadline` TIMESTAMP COMMENT 'Date and time by which the guest must cancel to avoid penalties per the cancellation policy.',
    `cancellation_reason` STRING COMMENT 'Reason provided for cancelling the spa package booking.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the spa package booking was cancelled. Null if not cancelled.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the spa package experience was fully completed.',
    `complimentary_amenities` STRING COMMENT 'Comma-separated list of complimentary amenities included with the package (e.g., robe, slippers, refreshments, locker access).',
    `confirmation_number` STRING COMMENT 'Guest-facing confirmation number for the spa package booking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this appointment package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this package booking.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the package booking (promotional, loyalty, or negotiated).',
    `guest_arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the guest arrived at the spa facility to begin the package experience.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this spa package booking.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the guest to pay for or discount this spa package.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this appointment package record was last modified.',
    `package_duration_minutes` STRING COMMENT 'Total duration of the spa package in minutes, including all treatments and amenities.',
    `package_notes` STRING COMMENT 'Internal operational notes about the spa package booking for staff reference.',
    `package_price` DECIMAL(18,2) COMMENT 'Base price of the spa package before any add-ons, discounts, or taxes.',
    `payment_method` STRING COMMENT 'Payment instrument used to pay for the spa package. [ENUM-REF-CANDIDATE: credit card|debit card|room charge|loyalty points|gift certificate|cash|bank transfer — 7 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current payment status of the spa package booking.. Valid values are `pending|authorized|paid|refunded|partially refunded|failed`',
    `redemption_status` STRING COMMENT 'Indicates whether the guest has started or completed using the treatments included in the package.. Valid values are `not started|partially redeemed|fully redeemed|expired`',
    `scheduled_end_date` DATE COMMENT 'Date when the spa package experience is scheduled to conclude. Nullable for single-day packages.',
    `scheduled_start_date` DATE COMMENT 'Date when the spa package experience is scheduled to begin.',
    `special_requests` STRING COMMENT 'Guest-provided special requests or preferences for the spa package experience (e.g., allergies, temperature preferences, therapist gender).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the spa package booking.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final total amount charged for the spa package including base price, add-ons, discounts, and taxes.',
    `treatment_count` STRING COMMENT 'Number of individual spa treatments included in this package.',
    CONSTRAINT pk_appointment_package PRIMARY KEY(`appointment_package_id`)
) COMMENT 'Transactional record capturing spa package bookings where multiple treatments are bundled for a single guest visit or multi-day program. Captures package reference, appointment reference, guest reference, package name, package type (day spa, half-day, couples retreat, wellness journey, golf and spa), total package price, package duration, number of treatments included, add-on services, complimentary amenities (robe, slippers, refreshments), booking date, and redemption status. Supports spa package revenue tracking and guest experience management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`package` (
    `package_id` BIGINT COMMENT 'Unique identifier for the spa package. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Spa packages are frequently created as part of marketing campaigns (Valentines Day packages, summer wellness promotions, holiday specials). Links package inventory to promotional strategy, enabling c',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Spa packages define cancellation terms that must align with the hotels cancellation policy framework for consistent guest-facing communication and penalty processing. Normalizing cancellation_policy_',
    `content_asset_id` BIGINT COMMENT 'Foreign key linking to marketing.content_asset. Business justification: Spa packages are promoted through content assets (package brochures, promotional images, videos). Essential for content-to-package mapping, tracking content effectiveness, and managing package marketi',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Spa packages in luxury hotels are frequently tier-gated (e.g., Platinum Escape Package exclusively for Platinum loyalty members). Revenue and loyalty teams need to enforce and report on tier-based p',
    `menu_id` BIGINT COMMENT 'Foreign key linking to fnb.menu. Business justification: Luxury spa day packages routinely include a defined F&B menu (healthy lunch, afternoon tea, champagne service). Package designers and revenue managers must link the spa package to the specific F&B men',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Spa packages target specific market segments (leisure, group, corporate wellness) for revenue reporting and forecasting. Business process: spa revenue is analyzed by market segment for performance tra',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Spa packages are often brand-specific offerings (signature brand packages, brand-exclusive experiences). Links package inventory to brand positioning, supports brand differentiation, and enables brand',
    `parent_package_id` BIGINT COMMENT 'Self-referencing FK on package (parent_package_id)',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Spa packages are offered as components of guest experience programs (e.g., a Honeymoon Experience program includes a spa package). This link enables program-level revenue reporting, eligibility vali',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where this spa package is available. Links to property master data.',
    `reservation_rate_plan_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_rate_plan. Business justification: Spa packages are frequently bundled with room rate plans (romance, honeymoon, wellness packages). Revenue managers need this link to configure bundled pricing, allocate revenue between rooms and spa, ',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Hotel spa packages are routinely bundled with specific room types (e.g., Deluxe Suite Spa Escape). Revenue management and package configuration processes explicitly tie spa package eligibility and p',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.segment. Business justification: Spa packages have CRM-segment-based eligibility rules (e.g., loyalty elite packages, honeymoon packages for leisure segments). Linking package to guest.segment enables proper segment-gated package ava',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A spa package may be specific to a particular spa facility within a property (e.g., a couples retreat package only available at the main spa, not the pool spa). package has property_id (cross-domain) ',
    `age_restriction_minimum` STRING COMMENT 'Minimum age in years required for guests to book or participate in this package. Null if no age restriction applies.',
    `amenities_included` STRING COMMENT 'Description of facility amenities included with the package such as pool access, fitness center, relaxation lounge, or refreshments.',
    `cancellation_hours_notice` STRING COMMENT 'Number of hours notice required for cancellation without penalty. Industry standard ranges from 24 to 72 hours for spa packages.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether bookings of this package through third-party channels are eligible for commission payments.',
    `commission_percentage` DECIMAL(18,2) COMMENT 'Percentage of package price paid as commission to booking agents or channels. Null if not commission-eligible.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spa package record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for package pricing. Supports multi-currency operations across global properties.. Valid values are `^[A-Z]{3}$`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Fixed deposit amount required at booking if requires_deposit is true. Null if deposit is percentage-based or not required.',
    `deposit_percentage` DECIMAL(18,2) COMMENT 'Percentage of package price required as deposit at booking. Null if deposit is fixed amount or not required.',
    `gender_restriction` STRING COMMENT 'Gender-based restriction for package booking. Used for gender-specific facilities or cultural requirements.. Valid values are `none|male_only|female_only|couples_only`',
    `guest_type_eligibility` STRING COMMENT 'Defines which guest segments are eligible to book this package. Supports targeted offerings and loyalty program benefits.. Valid values are `all|hotel_guest|day_guest|member|loyalty_tier`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the package is currently active and available for booking. Inactive packages are hidden from guest-facing channels.',
    `loyalty_points_eligible` BOOLEAN COMMENT 'Indicates whether this package purchase is eligible for loyalty program points accrual.',
    `loyalty_points_value` STRING COMMENT 'Number of loyalty points awarded for purchasing this package. Null if not eligible for points.',
    `maximum_advance_booking_days` STRING COMMENT 'Maximum number of days in advance that the package can be booked. Controls inventory release and revenue management.',
    `maximum_party_size` STRING COMMENT 'Maximum number of guests allowed in a single booking of this package. Constrained by facility capacity and therapist availability.',
    `minimum_advance_booking_hours` STRING COMMENT 'Minimum number of hours required between booking time and appointment time. Ensures adequate preparation and therapist scheduling.',
    `minimum_party_size` STRING COMMENT 'Minimum number of guests required to book this package. Typically used for couples or group packages.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the spa package record. Supports accountability and audit requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the spa package record was last modified. Used for change tracking and data synchronization.',
    `package_category` STRING COMMENT 'Thematic category of the spa package used for menu organization and guest preference matching.. Valid values are `relaxation|therapeutic|beauty|fitness|wellness|specialty`',
    `package_code` STRING COMMENT 'Unique business identifier code for the spa package used across systems and guest-facing materials. Typically alphanumeric format used in PMS and booking systems.. Valid values are `^[A-Z0-9]{6,12}$`',
    `package_description` STRING COMMENT 'Detailed description of the spa package including benefits, experience highlights, and guest expectations. Used in marketing collateral and booking confirmations.',
    `package_name` STRING COMMENT 'Marketing name of the spa package displayed to guests and used in promotional materials.',
    `package_status` STRING COMMENT 'Current lifecycle status of the spa package. Controls visibility, bookability, and operational workflow.. Valid values are `active|inactive|seasonal|discontinued|pending_approval|archived`',
    `package_type` STRING COMMENT 'Classification of the spa package by format and target guest segment. Determines bundling rules and booking requirements.. Valid values are `day_spa|half_day|couples|wellness_program|golf_and_spa|resort_credit`',
    `promotional_rate` DECIMAL(18,2) COMMENT 'Discounted or promotional price for the spa package during specific campaigns or seasons. Null when no promotion is active.',
    `property_availability` STRING COMMENT 'Comma-separated list of property codes where this package is available. Supports multi-property package offerings.',
    `rack_rate` DECIMAL(18,2) COMMENT 'Standard published price for the spa package before any discounts or promotions. Equivalent to Best Available Rate (BAR) for spa services.',
    `requires_deposit` BOOLEAN COMMENT 'Indicates whether a deposit is required at time of booking to secure the package reservation.',
    `retail_products_included` STRING COMMENT 'List of retail product codes or descriptions included as part of the package. Supports spa retail integration and inventory management.',
    `service_charge_included` BOOLEAN COMMENT 'Indicates whether gratuity or service charge is included in the package price. Important for guest communication and revenue allocation.',
    `special_instructions` STRING COMMENT 'Operational notes and special instructions for spa staff regarding package delivery, setup requirements, or guest experience protocols.',
    `tax_inclusive` BOOLEAN COMMENT 'Indicates whether the package price includes applicable taxes or if taxes are added at checkout. Varies by jurisdiction.',
    `total_duration_minutes` STRING COMMENT 'Total duration of all included treatments and transitions in minutes. Used for scheduling and capacity planning.',
    `valid_from_date` DATE COMMENT 'Start date of the packages availability period. Package cannot be booked for dates before this.',
    `valid_to_date` DATE COMMENT 'End date of the packages availability period. Package cannot be booked for dates after this. Null indicates open-ended availability.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the spa package record. Supports accountability and audit requirements.',
    CONSTRAINT pk_package PRIMARY KEY(`package_id`)
) COMMENT 'Master catalog of spa packages and wellness programs available for guest booking. Captures package name, package code, package type (day spa, half-day, couples, wellness program, golf and spa, resort credit), included treatments list, total duration, rack rate, promotional rate, validity period, property availability, minimum advance booking requirement, cancellation policy, and active status. Distinct from appointment_package which is the transactional instance of a package booking.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` (
    `therapist_schedule_id` BIGINT COMMENT 'Unique identifier for the therapist schedule record. Primary key for the therapist schedule entity.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Therapist schedules drive labor cost accruals and overtime expense recognition; hotel finance teams must tie schedule data to fiscal periods for period-end payroll accrual entries and USALI labor cost',
    `original_therapist_schedule_id` BIGINT COMMENT 'Self-referencing FK on therapist_schedule (original_therapist_schedule_id)',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa facility is located. Links to the property master record.',
    `spa_facility_id` BIGINT COMMENT 'Reference to the spa facility where the therapist is scheduled to work. Links to the spa facility master record.',
    `therapist_id` BIGINT COMMENT 'Reference to the therapist assigned to this schedule. Links to the therapist master record.',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: therapist_schedule has a room_assignment STRING column that is a denormalized reference to a treatment room. Normalizing this to treatment_room_id -> treatment_room.treatment_room_id enables proper re',
    `actual_clock_in_time` TIMESTAMP COMMENT 'The actual timestamp when the therapist clocked in or checked in for their shift. Used for payroll processing, attendance tracking, and variance analysis against scheduled start time.',
    `actual_clock_out_time` TIMESTAMP COMMENT 'The actual timestamp when the therapist clocked out or checked out from their shift. Used for payroll processing, attendance tracking, and variance analysis against scheduled end time.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'The actual number of hours the therapist worked during this shift, calculated from clock-in and clock-out times. Used for payroll processing and labor cost analysis.',
    `break_duration_minutes` STRING COMMENT 'The total duration of break periods in minutes during this shift. Used for labor compliance reporting and accurate calculation of available treatment hours.',
    `break_end_time` TIMESTAMP COMMENT 'The timestamp when the therapists scheduled break period ends. Used to resume appointment availability after the break period.',
    `break_start_time` TIMESTAMP COMMENT 'The timestamp when the therapists scheduled break period begins. Used to block out time when the therapist is not available for appointments and to ensure compliance with labor regulations.',
    `cancellation_reason` STRING COMMENT 'The reason why this schedule was cancelled, if applicable. May include illness, personal emergency, facility closure, or other operational reasons. Used for workforce analytics and schedule reliability improvement.',
    `cancelled_by` STRING COMMENT 'The user ID or system identifier of the person who cancelled this schedule. Used for audit trail and accountability in schedule changes.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule was cancelled. Used for audit trail and analysis of schedule change patterns.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'The timestamp when the therapist acknowledged and confirmed their availability for this scheduled shift. Used for attendance tracking and schedule reliability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule record was first created in the system. Used for audit trail and data lineage tracking.',
    `last_modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this schedule record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule record was last modified. Used for audit trail, change tracking, and data freshness assessment.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether this shift qualifies for overtime compensation based on labor regulations and the therapists employment classification. True if overtime rules apply, false otherwise.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'The number of hours worked during this shift that qualify as overtime. Used for payroll processing and labor cost management.',
    `primary_treatment_specialty` STRING COMMENT 'The primary type of spa treatment the therapist is scheduled to provide during this shift (e.g., massage, facial, body treatment, nail services). Used for matching therapist skills with guest appointment requests.',
    `published_timestamp` TIMESTAMP COMMENT 'The timestamp when this schedule was published and made visible to the therapist and spa operations team. Used for schedule communication tracking and labor compliance.',
    `schedule_date` DATE COMMENT 'The calendar date for which this therapist schedule is defined. Used for daily scheduling and capacity planning.',
    `schedule_notes` STRING COMMENT 'Free-text notes or special instructions related to this schedule entry. May include information about special events, training sessions, equipment needs, or other operational details.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the therapist schedule. Draft schedules are being planned, published schedules are visible to staff, confirmed schedules are acknowledged by the therapist, cancelled schedules are voided, completed schedules have been worked, and no-show indicates the therapist did not report for the shift.. Valid values are `draft|published|confirmed|cancelled|completed|no_show`',
    `schedule_variance_minutes` STRING COMMENT 'The difference in minutes between scheduled hours and actual hours worked. Positive values indicate overtime, negative values indicate undertime. Used for schedule accuracy analysis and labor forecasting.',
    `scheduled_treatment_slots` STRING COMMENT 'The number of discrete treatment appointment slots scheduled during this shift. Used for capacity planning and appointment availability management.',
    `shift_end_time` TIMESTAMP COMMENT 'The timestamp when the therapists shift ends. Defines the end of the therapists availability window for appointments.',
    `shift_start_time` TIMESTAMP COMMENT 'The timestamp when the therapists shift begins. Defines the start of the therapists availability window for appointments.',
    `shift_type` STRING COMMENT 'Classification of the shift based on timing and operational role. Opening shifts cover early morning hours, mid shifts cover peak daytime hours, closing shifts cover evening hours, on-call shifts are for backup coverage, split shifts have a break in the middle, and double shifts cover extended hours.. Valid values are `opening|mid|closing|on_call|split|double`',
    `total_available_hours` DECIMAL(18,2) COMMENT 'The total number of hours the therapist is available for treatment appointments, excluding break periods and administrative time. Used for capacity planning and appointment scheduling.',
    `total_booked_hours` DECIMAL(18,2) COMMENT 'The total number of hours that have been booked with guest appointments during this shift. Used to calculate therapist utilization and identify available capacity.',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'The total number of hours the therapist is scheduled to work during this shift, calculated as the difference between shift end time and shift start time minus break periods. Used for labor cost planning and compliance with labor regulations.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'The percentage of available hours that have been booked with appointments, calculated as (total_booked_hours / total_available_hours) * 100. Key performance indicator (KPI) for spa productivity and revenue optimization.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this schedule record. Used for audit trail and accountability.',
    CONSTRAINT pk_therapist_schedule PRIMARY KEY(`therapist_schedule_id`)
) COMMENT 'Operational scheduling record defining therapist availability and shift assignments within the spa. Captures therapist reference, facility reference, schedule date, shift start time, shift end time, shift type (opening, mid, closing, on-call), scheduled treatment slots, break periods, total available hours, total booked hours, utilization percentage, schedule status (draft, published, confirmed), and last modified timestamp. Enables spa management to optimize therapist utilization and appointment capacity.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`intake_form` (
    `intake_form_id` BIGINT COMMENT 'Unique identifier for the spa guest health intake and consultation form. Primary key.',
    `appointment_id` BIGINT COMMENT 'Reference to the spa appointment for which this intake form was completed. Links to the spa appointment booking record.',
    `guest_interaction_id` BIGINT COMMENT 'Foreign key linking to experience.guest_interaction. Business justification: Intake form completion is a documented pre-service consultation touchpoint. Guest experience systems track intake as an interaction for journey mapping, guest effort scoring, and touchpoint optimizati',
    `prior_intake_form_id` BIGINT COMMENT 'Self-referencing FK on intake_form (prior_intake_form_id)',
    `profile_id` BIGINT COMMENT 'Reference to the guest completing this intake form. Links to the guest master record in the property management system.',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa treatment will be provided. Links to the property master record.',
    `therapist_id` BIGINT COMMENT 'Reference to the therapist who reviewed and approved the intake form. Links to the therapist employee record.',
    `allergy_details` STRING COMMENT 'Free-text description of specific allergies disclosed by the guest, including product ingredients, essential oils, nuts, latex, or other substances. Essential for safe treatment delivery.',
    `areas_to_avoid` STRING COMMENT 'Free-text description of specific body areas the guest requests to avoid during treatment due to injury, sensitivity, discomfort, or personal preference.',
    `aromatherapy_preference` STRING COMMENT 'Guest preference for aromatherapy scent during treatment. Enhances personalized spa experience and guest satisfaction. [ENUM-REF-CANDIDATE: lavender|eucalyptus|peppermint|citrus|rose|sandalwood|unscented|no_preference — 8 candidates stripped; promote to reference product]',
    `cardiovascular_condition_details` STRING COMMENT 'Free-text description of specific cardiovascular conditions disclosed by the guest. Provides therapist with detailed health context for treatment planning.',
    `completion_date` DATE COMMENT 'Date when the guest completed and submitted the intake form. Critical for determining form validity and compliance with pre-treatment requirements.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the guest submitted the completed intake form. Used for audit trail and form expiration calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the intake form record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_medications` STRING COMMENT 'Free-text list of medications currently being taken by the guest. Important for identifying potential interactions with spa treatments or products.',
    `data_privacy_acknowledgment` BOOLEAN COMMENT 'Indicates whether the guest has acknowledged the spa data privacy policy and understands how their personal and health information will be used and protected.',
    `data_privacy_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the guest acknowledged the data privacy policy. Required for GDPR and CCPA compliance documentation.',
    `form_expiration_date` DATE COMMENT 'Date when the intake form expires and must be renewed. Typically 6-12 months from completion date to ensure health information remains current.',
    `form_number` STRING COMMENT 'Human-readable business identifier for the intake form, typically formatted as IF- followed by numeric sequence. Used for guest communication and record retrieval.. Valid values are `^IF-[0-9]{8,12}$`',
    `form_status` STRING COMMENT 'Current lifecycle status of the intake form. Tracks progression from guest completion through therapist review and approval.. Valid values are `draft|submitted|reviewed|approved|rejected|expired`',
    `has_allergies` BOOLEAN COMMENT 'Indicates whether the guest has disclosed any allergies to products, ingredients, or environmental factors. Critical for preventing allergic reactions during treatment.',
    `has_cardiovascular_condition` BOOLEAN COMMENT 'Indicates whether the guest has disclosed any cardiovascular conditions such as hypertension, heart disease, or circulatory disorders. Critical for treatment safety assessment.',
    `has_previous_spa_experience` BOOLEAN COMMENT 'Indicates whether the guest has received spa treatments before. Helps therapist adjust communication and service delivery approach.',
    `has_recent_surgery` BOOLEAN COMMENT 'Indicates whether the guest has undergone surgery within the past 6-12 months. Important for identifying treatment contraindications and areas to avoid.',
    `has_skin_condition` BOOLEAN COMMENT 'Indicates whether the guest has disclosed any skin conditions such as eczema, psoriasis, rashes, or sensitivities. Important for product selection and treatment modifications.',
    `is_pregnant` BOOLEAN COMMENT 'Indicates whether the guest is currently pregnant. Critical for treatment contraindications and liability management.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the intake form was completed. Supports multilingual guest experience.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the intake form record was last modified. Supports change tracking and audit compliance.',
    `photography_consent_given` BOOLEAN COMMENT 'Indicates whether the guest has consented to photography or videography during their spa visit for marketing or promotional purposes.',
    `pregnancy_trimester` STRING COMMENT 'Current trimester of pregnancy if guest is pregnant. Used to determine appropriate treatment modifications and contraindications.. Valid values are `first|second|third|not_applicable`',
    `pressure_preference` STRING COMMENT 'Guest preference for massage pressure intensity. Guides therapist in delivering personalized treatment experience.. Valid values are `light|medium|firm|very_firm|no_preference`',
    `previous_spa_experience_notes` STRING COMMENT 'Free-text description of guest previous spa experiences, preferences, or concerns based on past treatments. Supports personalized service delivery.',
    `skin_condition_details` STRING COMMENT 'Free-text description of specific skin conditions disclosed by the guest. Guides therapist in selecting appropriate products and techniques.',
    `submission_channel` STRING COMMENT 'Channel through which the guest submitted the intake form. Used for channel analytics and process improvement.. Valid values are `web_portal|mobile_app|in_person_tablet|paper_form|email`',
    `surgery_details` STRING COMMENT 'Free-text description of recent surgeries including type, date, and location on body. Helps therapist identify areas requiring special care or avoidance.',
    `therapist_review_timestamp` TIMESTAMP COMMENT 'Date and time when the therapist completed their review of the intake form. Creates audit trail for quality assurance and compliance.',
    `therapist_reviewed` BOOLEAN COMMENT 'Indicates whether a licensed therapist has reviewed and approved the intake form prior to treatment. Required workflow step for quality assurance and liability management.',
    `treatment_consent_given` BOOLEAN COMMENT 'Indicates whether the guest has provided informed consent to receive the spa treatment. Required for legal liability protection and regulatory compliance.',
    `treatment_consent_timestamp` TIMESTAMP COMMENT 'Date and time when the guest provided treatment consent. Creates audit trail for legal and compliance purposes.',
    CONSTRAINT pk_intake_form PRIMARY KEY(`intake_form_id`)
) COMMENT 'Guest health intake and consultation form completed prior to spa treatments. Captures guest reference, appointment reference, form completion date, health conditions disclosed (pregnancy, cardiovascular, skin conditions, allergies, recent surgeries), medications listed, pressure preference, areas to avoid, aromatherapy preferences, previous spa experience, consent to treatment, consent to photography, data privacy acknowledgment, therapist review status, and therapist notes. Required for liability management and personalized treatment delivery.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`charge` (
    `charge_id` BIGINT COMMENT 'Unique identifier for the spa charge transaction. Primary key for the spa charge record.',
    `appointment_id` BIGINT COMMENT 'Reference to the spa appointment associated with this charge. Links the charge to the scheduled service.',
    `appointment_package_id` BIGINT COMMENT 'Foreign key linking to spa.appointment_package. Business justification: A spa charge may be generated for a specific package booking instance (appointment_package), not just the package catalog entry. charge already has package_id -> package.package_id (catalog reference)',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Spa charges posted to guest folios or billed to external accounts need to link to AR invoices for consolidated billing and receivables management. This FK enables integration between spa POS and finan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spa charges must be allocated to departmental cost centers for USALI-compliant financial reporting and departmental P&L analysis. Essential for spa department performance measurement, budget variance ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Spa charges must be posted to the correct fiscal period for USALI departmental revenue reporting and period-end GL close. charge already has ledger_id, cost_center_id, profit_center_id — fiscal_period',
    `fitness_class_id` BIGINT COMMENT 'Foreign key linking to spa.fitness_class. Business justification: A spa charge may be for a fitness class fee (drop-in class, personal training session). charge has treatment_id for treatment-related charges but no fitness_class_id. This FK enables accurate revenue ',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Spa charges bundle with F&B purchases in integrated resort POS. Guest charges spa treatment and restaurant meal to room on same transaction. Enables cross-department revenue analysis and unified guest',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Spa charges post to specific GL accounts in the ledger for financial statement preparation and audit trail. Required for revenue recognition, GL reconciliation, and SOX-compliant financial reporting i',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa charges require direct loyalty member link for points accrual on spa spend, tier-based spa pricing discounts, and member-only spa promotions. Critical for revenue attribution and loyalty program l',
    `membership_id` BIGINT COMMENT 'Foreign key linking to spa.membership. Business justification: A spa charge may be directly associated with a membership (e.g., annual membership fee charge, monthly billing, or member-discounted service charge). charge has loyalty_member_id (cross-domain) but no',
    `membership_visit_id` BIGINT COMMENT 'Foreign key linking to spa.membership_visit. Business justification: A spa charge may be generated during a specific membership visit (e.g., retail purchase, gratuity, or add-on service during a member visit). Linking charge.membership_visit_id -> membership_visit.memb',
    `package_id` BIGINT COMMENT 'Reference to the spa package or bundle if this charge is part of a multi-service offering. Links to spa package catalog.',
    `primary_original_charge_id` BIGINT COMMENT 'Reference to the original spa charge record if this is an adjustment or reversal. Links corrected charges to their source transactions.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who received the spa service or purchased the product. Links to the guest master record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Spa charges contribute to profit center P&L for segment reporting, management fee calculations, and owner distributions. Required for spa profit center GOP, EBITDA reporting, and incentive management ',
    `property_facility_id` BIGINT COMMENT 'Reference to the specific spa facility, treatment room, or amenity area where the service was provided. Supports facility utilization analytics.',
    `property_id` BIGINT COMMENT 'Reference to the property where the spa charge was incurred. Enables multi-property revenue tracking and reporting.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the hotel reservation associated with this spa charge, if applicable. Used for folio posting and guest stay tracking.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Spa charges reference rate plans when posted with negotiated rates, package inclusions, or loyalty discounts. Business process: spa charge posting with rate plan discounts ensures accurate revenue rec',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Spa charges are posted directly to guest room folios. Revenue accounting, folio management, and PMS integration require room linkage for charge routing, a fundamental billing process in hotel spa oper',
    `service_recovery_action_id` BIGINT COMMENT 'Foreign key linking to experience.service_recovery_action. Business justification: Service recovery often involves spa charge adjustments, waivers, or complimentary treatments. Finance systems must link recovery actions to specific charge records for GL reconciliation, cost center a',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist or service provider who delivered the treatment. Used for commission tracking and performance reporting.',
    `treatment_id` BIGINT COMMENT 'Reference to the spa treatment or service provided, if charge_type is treatment. Links to the spa treatment catalog.',
    `adjustment_reason` STRING COMMENT 'Reason for charge adjustment if posting_status is adjusted. Captures service recovery, pricing corrections, or billing disputes.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if charge_type is cancellation_fee. Captures guest no-show, late cancellation, or policy violation details.',
    `charge_date` DATE COMMENT 'Business date when the spa charge was incurred. Used for revenue recognition and daily operations reporting.',
    `charge_number` STRING COMMENT 'Externally-known unique reference number for the spa charge transaction, used for guest communication and reconciliation.',
    `charge_timestamp` TIMESTAMP COMMENT 'Precise date and time when the spa charge transaction was posted to the system. Principal business event timestamp for the transaction.',
    `charge_type` STRING COMMENT 'Classification of the spa charge indicating the nature of the transaction: treatment (spa service), retail (product sale), membership (club fee), day_pass (facility access), gratuity (tip), or cancellation_fee (no-show penalty).. Valid values are `treatment|retail|membership|day_pass|gratuity|cancellation_fee`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the spa charge record was first created in the system. Record audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Supports multi-currency operations across global properties.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this charge, including promotional discounts, loyalty rewards, or package inclusions. Reduces the gross charge amount.',
    `discount_code` STRING COMMENT 'Promotional or loyalty discount code applied to this charge. Used for marketing campaign tracking and discount reconciliation.',
    `folio_reference` STRING COMMENT 'Reference number of the guest folio in the PMS where this charge was posted. Links spa revenue to guest account for billing and settlement.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue recognition. Maps spa charges to the appropriate GL account per USALI chart of accounts.',
    `gratuity_included_flag` BOOLEAN COMMENT 'Indicates whether gratuity is included in the total charge amount. True if gratuity is pre-included, false if gratuity is separate or not applied.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the spa charge record was last modified. Supports audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the spa charge. May include special instructions, adjustments, or guest requests.',
    `payment_method` STRING COMMENT 'Method of payment for the spa charge: room_charge (posted to folio), credit_card (direct payment), cash, gift_card, loyalty_points (redemption), or comp (complimentary).. Valid values are `room_charge|credit_card|cash|gift_card|loyalty_points|comp`',
    `posting_status` STRING COMMENT 'Current lifecycle status of the charge transaction: posted (successfully recorded), voided (cancelled before settlement), adjusted (modified after posting), pending (awaiting approval), or reversed (corrected after settlement).. Valid values are `posted|voided|adjusted|pending|reversed`',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or services included in this charge line. Typically 1 for treatments, may be greater than 1 for retail products.',
    `revenue_center_code` STRING COMMENT 'USALI revenue center code for the spa department or facility where the charge was incurred. Used for departmental P&L reporting.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Mandatory service charge or facility fee applied to the spa charge, separate from gratuity. Common in resort and luxury properties.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to this charge, including sales tax, VAT, or other applicable taxes based on jurisdiction.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Final total amount of the spa charge including all adjustments, taxes, and fees. Net amount posted to guest folio or POS transaction.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit or service before discounts and taxes. Base rate for the treatment or product.',
    `voided_timestamp` TIMESTAMP COMMENT 'Date and time when the charge was voided, if applicable. Supports audit trail and financial reconciliation.',
    CONSTRAINT pk_charge PRIMARY KEY(`charge_id`)
) COMMENT 'Transactional record of all spa revenue charges posted to guest folios or point-of-sale systems. Captures charge reference number, appointment reference, guest reference, reservation reference, property reference, charge date, charge type (treatment, retail, membership, day pass, gratuity, cancellation fee), treatment or product reference, quantity, unit price, discount amount, tax amount, total charge amount, currency, revenue center, posting status (posted, voided, adjusted), PMS folio reference, and POS transaction reference. SSOT for spa revenue recognition and USALI departmental reporting.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`membership` (
    `membership_id` BIGINT COMMENT 'Unique identifier for the spa and wellness membership record. Primary key.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Monthly and annual spa membership billing generates recurring AR invoices for revenue recognition and collection tracking. Required for subscription revenue accounting, deferred revenue management, an',
    `attribution_event_id` BIGINT COMMENT 'Foreign key linking to marketing.attribution_event. Business justification: Membership enrollments are key conversion events requiring attribution to marketing touchpoints. Essential for understanding membership acquisition journey, calculating acquisition costs by channel, a',
    `booking_source_id` BIGINT COMMENT 'Foreign key linking to channel.booking_source. Business justification: Spa memberships sold via corporate sales channels, OTA, or direct booking sources require source attribution for commission accrual and member acquisition cost analysis. membership has distribution_ch',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Membership enrollments are frequently the result of acquisition campaigns (membership drives, enrollment promotions, referral campaigns). Critical for measuring membership marketing ROI, tracking acqu',
    `campaign_offer_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_offer. Business justification: Membership enrollments often use promotional offers (waived enrollment fees, discounted rates, first-month-free promotions). Essential for offer performance tracking, measuring membership acquisition ',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account sponsoring this membership. Populated only for corporate membership types where an employer or organization pays for employee memberships. Null for individual memberships.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Spa memberships sold through distribution partners (OTA wellness packages, corporate channels, travel agent networks) require channel attribution for commission calculation and membership acquisition ',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Memberships are often targeted to specific guest segments (local residents, frequent travelers, wellness enthusiasts). Essential for segment-based membership strategies, acquisition targeting, and mea',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Membership fees post to deferred/recurring revenue GL accounts for subscription revenue recognition. Essential for deferred revenue liability tracking, recurring revenue amortization, and ASC 606 comp',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Spa memberships are often bundled with hotel loyalty elite status, offering integrated benefits and cross-program recognition. Supports combined membership management, loyalty elite spa privileges, an',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Spa membership tier eligibility and benefit levels are directly governed by the guests loyalty program tier (e.g., Platinum members qualify for premium spa membership rates). Operations and finance t',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Spa memberships are marketed to specific segments (local residents, hotel guests, corporate accounts). Business process: membership revenue forecasting, segment performance analysis, and strategic pla',
    `nps_survey_id` BIGINT COMMENT 'Foreign key linking to experience.nps_survey. Business justification: Spa membership NPS surveys (renewal satisfaction, annual member surveys) are tracked against specific NPS survey instruments. Linking membership to nps_survey enables member satisfaction trend analysi',
    `profile_id` BIGINT COMMENT 'Reference to the guest enrolled in this spa membership. Links to the guest master record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Membership revenue is allocated to spa profit center for recurring revenue tracking and segment profitability. Required for membership program ROI analysis, profit center recurring revenue metrics, an',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Spa memberships are frequently structured as guest experience programs (e.g., an annual wellness membership is an experience program with defined benefits). Linking membership to program enables progr',
    `property_id` BIGINT COMMENT 'Reference to the property where this spa membership is valid. Spa memberships are typically property-specific rather than chain-wide.',
    `renewed_membership_id` BIGINT COMMENT 'Self-referencing FK on membership (renewed_membership_id)',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A spa membership grants access to a specific spa facility (or set of facilities). membership has property_id (cross-domain) but no in-domain link to spa_facility. This FK enables facility-level member',
    `annual_fee` DECIMAL(18,2) COMMENT 'Total annual membership fee. For annual memberships this is the upfront payment amount. For monthly memberships this represents the total annual cost (monthly fee times 12). Zero for complimentary memberships.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the membership is set to automatically renew at the end of the current term. True if auto-renewal is enabled and payment will be processed automatically, False if the membership will expire without manual renewal.',
    `cancellation_date` DATE COMMENT 'Date when the membership was cancelled. Null if membership has never been cancelled. Marks the effective end of the membership relationship.',
    `cancellation_notes` STRING COMMENT 'Free-text notes capturing additional details about the membership cancellation. May include guest feedback, retention offers made, or special circumstances. Used for qualitative analysis of member churn.',
    `cancellation_reason` STRING COMMENT 'Primary reason for membership cancellation. Member request indicates voluntary cancellation by the guest. Payment failure indicates cancellation due to non-payment. Relocation indicates member moved away from property area. Dissatisfaction indicates service quality issues. Health reasons indicates medical inability to use facilities. Cost concerns indicates financial reasons. Used for retention analysis and program improvement.. Valid values are `member_request|payment_failure|relocation|dissatisfaction|health_reasons|cost_concerns`',
    `contract_term_months` STRING COMMENT 'Length of the membership contract commitment in months. Common values are 1 for month-to-month, 12 for annual contracts, 24 or 36 for multi-year commitments. Null for lifetime or indefinite memberships.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for membership fees. Typically matches the propertys local currency.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to standard membership fees. Typically associated with promotional codes, corporate programs, or loyalty rewards. Zero indicates no discount. Maximum value 100.00 for fully complimentary memberships.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the member cancels before the end of the contract term. Zero for month-to-month memberships with no commitment. Used to enforce contract terms and recover acquisition costs.',
    `effective_start_date` DATE COMMENT 'Date when the membership benefits become active and the guest can begin using spa facilities and services. May differ from enrollment date if there is a waiting period or future-dated activation.',
    `enrollment_date` DATE COMMENT 'Date when the guest enrolled in the spa membership program. Marks the start of the membership relationship.',
    `expiry_date` DATE COMMENT 'Date when the current membership term expires. For monthly memberships this is typically one month from start date, for annual memberships one year. Null for lifetime or indefinite memberships.',
    `included_fitness_access` BOOLEAN COMMENT 'Indicates whether the membership includes unlimited access to fitness center facilities including gym equipment, group fitness classes, and personal training consultations. True if fitness access is included, False if not included or requires additional fees.',
    `included_guest_passes` STRING COMMENT 'Number of complimentary guest passes included with the membership per billing period. Guest passes allow the member to bring non-member guests to use spa and fitness facilities. Zero indicates no guest passes included.',
    `included_treatment_credits` STRING COMMENT 'Number of complimentary spa treatment credits included with the membership per billing period. Credits can typically be redeemed for massages, facials, body treatments, and other spa services. Zero indicates no included treatments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was most recently updated. Used for audit trail, change tracking, and data synchronization.',
    `last_payment_date` DATE COMMENT 'Date when the most recent membership fee payment was successfully processed. Used to track payment history and identify delinquent accounts.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member has consented to receive marketing communications about spa promotions, new services, and special events. True if opted in, False if opted out. Must be respected per GDPR and CCPA requirements.',
    `membership_number` STRING COMMENT 'Externally visible unique membership number issued to the guest. Used for identification at spa facilities and on membership cards.. Valid values are `^[A-Z0-9]{8,20}$`',
    `membership_status` STRING COMMENT 'Current lifecycle status of the spa membership. Active memberships have full benefits and access. Suspended memberships are temporarily on hold (e.g., medical leave, payment issue). Cancelled memberships have been terminated by member or property. Expired memberships have reached their end date without renewal. Pending memberships are awaiting activation or payment confirmation.. Valid values are `active|suspended|cancelled|expired|pending`',
    `membership_type` STRING COMMENT 'Type of membership based on billing frequency and enrollment channel. Monthly memberships renew each month, Annual memberships are paid yearly, Corporate memberships are sponsored by employer organizations, Complimentary memberships are granted as loyalty rewards or promotional offers.. Valid values are `monthly|annual|corporate|complimentary`',
    `monthly_fee` DECIMAL(18,2) COMMENT 'Recurring monthly membership fee charged to the guest. Applicable for monthly and annual memberships (annual divided by 12). Zero for complimentary memberships.',
    `next_billing_date` DATE COMMENT 'Date when the next membership fee payment is scheduled to be processed. Null for cancelled or expired memberships. Used for billing cycle management and revenue forecasting.',
    `payment_method_token` STRING COMMENT 'Tokenized reference to the payment method on file for recurring membership charges. Token is stored securely in PCI-compliant payment gateway and used for auto-renewal billing. Does not contain actual card numbers.. Valid values are `^[A-Za-z0-9_-]{16,64}$`',
    `payment_method_type` STRING COMMENT 'Type of payment method used for membership billing. Credit card and debit card are most common for individual memberships, bank account for direct debit, corporate billing for employer-sponsored memberships, room charge for in-house guests who want membership fees added to their folio.. Valid values are `credit_card|debit_card|bank_account|corporate_billing|room_charge`',
    `preferred_contact_method` STRING COMMENT 'Members preferred channel for receiving membership communications including billing notifications, appointment reminders, and promotional offers. Used to personalize communication strategy and improve member engagement.. Valid values are `email|phone|sms|mobile_app|postal_mail`',
    `promotional_code` STRING COMMENT 'Promotional or discount code applied at enrollment. Used to track marketing campaign effectiveness and apply special pricing or benefits. Null if no promotion was used.. Valid values are `^[A-Z0-9]{4,20}$`',
    `referral_source` STRING COMMENT 'Channel or source through which the guest learned about and enrolled in the spa membership program. Direct indicates walk-in enrollment. Member referral indicates existing member recommendation. Hotel guest indicates enrollment during property stay. Marketing campaign indicates response to promotional offer. Corporate program indicates employer wellness initiative. Online indicates website or app enrollment. Concierge indicates recommendation by hotel staff. [ENUM-REF-CANDIDATE: direct|member_referral|hotel_guest|marketing_campaign|corporate_program|online|concierge — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Operational system where this membership record originated. Opera PMS for memberships created at front desk, Spa Management System for spa-initiated enrollments, Salesforce CRM for marketing-driven enrollments, Mobile App or Web Portal for self-service enrollments. Used for data lineage and integration troubleshooting.. Valid values are `opera_pms|spa_management_system|salesforce_crm|mobile_app|web_portal`',
    `suspension_end_date` DATE COMMENT 'Date when the membership suspension is scheduled to end and membership will return to active status. Null if not currently suspended or if suspension is indefinite pending member action.',
    `suspension_start_date` DATE COMMENT 'Date when the membership was suspended. Null if membership has never been suspended or is not currently suspended. Used to track suspension periods for billing adjustments and benefit calculations.',
    CONSTRAINT pk_membership PRIMARY KEY(`membership_id`)
) COMMENT 'Spa and wellness membership master record for guests enrolled in property-level spa membership programs. Captures membership number, guest reference, property reference, membership tier (basic, premium, elite, unlimited), membership type (monthly, annual, corporate), enrollment date, expiry date, monthly fee, annual fee, included treatment credits, included fitness access, included guest passes, auto-renewal flag, payment method on file, membership status (active, suspended, cancelled, expired), and cancellation reason. Distinct from loyalty.member which manages the hotel-wide loyalty program.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` (
    `membership_visit_id` BIGINT COMMENT 'Unique identifier for the spa membership visit transaction. Primary key for this entity.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: A membership visit that involves a treatment credit redemption corresponds to a specific appointment booking. Linking membership_visit.appointment_id -> appointment.appointment_id allows operational r',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Membership visits generate incremental billable charges (retail_purchase_amount, gratuity_amount on membership_visit) that require AR invoice linkage for guest billing and accounts receivable tracking',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Membership visit credits consumed represent deferred revenue drawdown; finance teams require fiscal_period linkage to recognize the correct revenue amount per period and reconcile membership liability',
    `fitness_class_id` BIGINT COMMENT 'Foreign key linking to spa.fitness_class. Business justification: A membership visit may be for attendance at a fitness class (e.g., yoga, pilates, spin) rather than a treatment. membership_visit has visit_type STRING and treatment_id (for treatment visits) but no f',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Spa members purchase F&B during facility visits (smoothie bar, wellness café, poolside dining). Tracking combined spend per visit is standard membership analytics for calculating total member value an',
    `guest_feedback_id` BIGINT COMMENT 'Foreign key linking to experience.guest_feedback. Business justification: Spa membership visit satisfaction tracking requires linking visit records to guest feedback. Post-visit CSAT/NPS scores are attributed to specific membership visits for member retention analytics and ',
    `guest_interaction_id` BIGINT COMMENT 'Foreign key linking to experience.guest_interaction. Business justification: Each spa membership visit generates a guest interaction record (check-in, concierge contact, facility orientation). Linking membership_visit to guest_interaction enables interaction-level sentiment tr',
    `membership_id` BIGINT COMMENT 'Reference to the spa membership contract under which this visit occurred. Links to the membership agreement that governs credit allocation and benefits.',
    `prior_membership_visit_id` BIGINT COMMENT 'Self-referencing FK on membership_visit (prior_membership_visit_id)',
    `profile_id` BIGINT COMMENT 'Reference to the guest who made this spa facility visit. Links to the guest profile in the Property Management System (PMS).',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where the spa facility visit occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Spa membership visits during a hotel stay must be linked to the active reservation for integrated folio posting, stay-based benefit validation, and loyalty attribution. PMS-spa integration requires th',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Spa members staying as hotel guests may charge visit-related services to their room. Billing flexibility and guest convenience require room linkage for members who are also in-house guests at the prop',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Service recovery cases arising during spa membership visits (e.g., facility complaints, billing disputes, treatment issues) must be traceable to the specific visit. This supports SLA compliance report',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A membership visit occurs at a specific spa facility (main spa, fitness center, pool). membership_visit already has property_facility_id (cross-domain) but lacks an in-domain link to spa_facility. Thi',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Spa membership visits occurring during a hotel stay must be attributed to that stay for ancillary revenue reporting, loyalty tier validation at time of visit, and post-stay folio reconciliation. Hotel',
    `therapist_id` BIGINT COMMENT 'Reference to the spa therapist or wellness professional who provided the treatment service. Null for facility-only visits without treatment.',
    `treatment_id` BIGINT COMMENT 'Reference to the specific spa treatment or service redeemed during this visit. Null if the visit was for facility access only (fitness, pool) without a treatment.',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: When a spa member redeems a treatment credit, the visit occurs in a specific treatment room. Linking membership_visit.treatment_room_id -> treatment_room.treatment_room_id enables room utilization tra',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the visit was cancelled. Null for completed visits. Used for service recovery and operational improvement analysis.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the visit was cancelled. Null for non-cancelled visits. Used for cancellation policy enforcement and late-cancellation fee assessment.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the member checked in at the spa facility reception. Marks the start of the visit for duration tracking and capacity management.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Date and time when the member checked out from the spa facility. Marks the end of the visit for duration calculation and facility turnover.',
    `complimentary_flag` BOOLEAN COMMENT 'Indicator whether this visit was provided as a complimentary benefit or service recovery gesture without credit consumption or charge.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this visit record was first created in the source system. Audit trail for data lineage and compliance.',
    `credits_consumed` DECIMAL(18,2) COMMENT 'Number of membership credits deducted from the members balance for this visit. Zero for included benefits or complimentary access.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this visit record. Supports multi-currency operations for international resort properties.. Valid values are `^[A-Z]{3}$`',
    `feedback_comments` STRING COMMENT 'Free-text guest feedback or comments about the visit experience. Captured for service quality improvement and issue resolution.',
    `gratuity_amount` DECIMAL(18,2) COMMENT 'Tip or gratuity amount provided by the guest for therapist or service staff. Tracked separately for staff compensation and service quality correlation.',
    `guest_count` STRING COMMENT 'Number of guests included in this visit (member plus any authorized guests under guest pass privileges). Used for capacity planning and revenue allocation.',
    `guest_satisfaction_score` STRING COMMENT 'Post-visit satisfaction rating provided by the guest, typically on a scale of 1-10. Captured via post-service survey or feedback kiosk. Used for quality monitoring and therapist performance evaluation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this visit record was last updated in the source system. Audit trail for change tracking and data quality monitoring.',
    `no_show_flag` BOOLEAN COMMENT 'Indicator whether the member failed to appear for a scheduled visit without prior cancellation. Used for no-show policy enforcement and credit forfeiture rules.',
    `remaining_credit_balance` DECIMAL(18,2) COMMENT 'Snapshot of the membership credit balance remaining after this visit transaction. Enables point-in-time balance tracking and reconciliation.',
    `retail_purchase_amount` DECIMAL(18,2) COMMENT 'Total monetary value of spa retail products purchased during this visit. Separate from membership credits. Tracked for cross-sell revenue analysis.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Originally scheduled end date and time for the visit or treatment. Used for resource planning and schedule optimization.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Originally scheduled date and time for the visit or treatment appointment. Used for no-show detection and schedule adherence analysis.',
    `source_system` STRING COMMENT 'Name of the operational system that originated this visit record (spa management system, PMS, mobile app). Used for data lineage and reconciliation.',
    `special_request` STRING COMMENT 'Guest-provided special requests or preferences for this visit (room temperature, music preference, pressure level, accessibility needs). Used for personalized service delivery.',
    `visit_date` DATE COMMENT 'Calendar date on which the spa facility visit occurred. Primary business event date for utilization tracking and reporting.',
    `visit_number` STRING COMMENT 'Business identifier for the visit transaction. Externally visible reference number used for guest communication and service tracking.',
    `visit_status` STRING COMMENT 'Current lifecycle status of the membership visit. Tracks progression from scheduling through completion or cancellation.. Valid values are `scheduled|checked_in|in_progress|completed|cancelled|no_show`',
    `visit_type` STRING COMMENT 'Classification of the type of spa facility visit or membership benefit utilized. Determines credit consumption rules and access privileges. [ENUM-REF-CANDIDATE: fitness_access|pool_access|treatment_redemption|guest_pass|wellness_class|golf_access|spa_day_pass — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_membership_visit PRIMARY KEY(`membership_visit_id`)
) COMMENT 'Transactional record of each spa facility visit or treatment credit redemption by a spa member. Captures visit date, membership reference, guest reference, facility reference, visit type (fitness access, pool access, treatment redemption, guest pass), treatment reference if applicable, check-in time, check-out time, credits consumed, remaining credit balance, and staff who processed the visit. Enables membership utilization tracking and credit balance management.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` (
    `fitness_class_id` BIGINT COMMENT 'Unique identifier for the fitness class. Primary key.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to revenue.market_segment. Business justification: Fitness class pricing and access eligibility varies by market segment — complimentary for luxury transient guests, fee-based for group or select-service segments. Revenue and spa teams use market segm',
    `parent_fitness_class_id` BIGINT COMMENT 'Self-referencing FK on fitness_class (parent_fitness_class_id)',
    `program_id` BIGINT COMMENT 'Foreign key linking to experience.program. Business justification: Fitness classes are bundled into guest experience wellness programs (e.g., a Wellness Weekend program includes yoga and fitness classes). Linking fitness_class to program enables program enrollment ',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property where this fitness class is offered.',
    `revenue_rate_plan_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_rate_plan. Business justification: Fitness classes are included in hotel rate plans (e.g., Wellness Rate or Resort Fee Inclusive plans grant complimentary fitness access). Revenue management links fitness class definitions to rate ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.segment. Business justification: Fitness classes are targeted to specific guest CRM segments (e.g., complimentary for loyalty members, premium for resort guests). Replacing the denormalized target_guest_segment text with a FK to gues',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: A fitness class is offered within a specific spa/fitness facility. fitness_class has property_facility_id (cross-domain) but no in-domain link to spa_facility. This in-domain FK enables facility-level',
    `survey_template_id` BIGINT COMMENT 'Foreign key linking to experience.survey_template. Business justification: Post-fitness-class feedback uses specific survey templates (e.g., instructor rating, class intensity, facility cleanliness). Linking fitness_class to survey_template enables automated post-class surve',
    `advance_booking_required_hours` STRING COMMENT 'The minimum number of hours in advance that guests must book to reserve a spot in this class.',
    `age_restriction_maximum` STRING COMMENT 'The maximum age in years allowed for participation, if applicable (nullable for classes with no upper age limit).',
    `age_restriction_minimum` STRING COMMENT 'The minimum age in years required for a guest to participate in this fitness class.',
    `cancellation_policy_hours` STRING COMMENT 'The number of hours before the class start time by which guests must cancel to avoid charges or penalties.',
    `class_benefits` STRING COMMENT 'Summary of the health, wellness, and fitness benefits guests will gain from participating in this class.',
    `class_code` STRING COMMENT 'Unique business identifier code for the fitness class used in scheduling and booking systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `class_description` STRING COMMENT 'Detailed narrative description of the class content, benefits, and what guests can expect during the session.',
    `class_image_url` STRING COMMENT 'URL link to the promotional image or photo representing this fitness class in marketing materials and booking systems.',
    `class_name` STRING COMMENT 'The marketing and display name of the fitness class as presented to guests.',
    `class_status` STRING COMMENT 'Current lifecycle status of the fitness class in the catalog (active, inactive, seasonal, suspended, discontinued).. Valid values are `active|inactive|seasonal|suspended|discontinued`',
    `class_subcategory` STRING COMMENT 'More granular classification within the class type (e.g., Vinyasa Yoga, Hot Yoga, Power Pilates, Indoor Cycling).',
    `class_type` STRING COMMENT 'The category or discipline of the fitness class (e.g., yoga, pilates, spin, HIIT, aqua aerobics, meditation, stretching, strength training, barre, zumba, kickboxing). [ENUM-REF-CANDIDATE: yoga|pilates|spin|hiit|aqua_aerobics|meditation|stretching|strength_training|barre|zumba|kickboxing — 11 candidates stripped; promote to reference product]',
    `complimentary_flag` BOOLEAN COMMENT 'Indicates whether this class is offered as a complimentary amenity to guests at no charge.',
    `contraindications` STRING COMMENT 'Medical conditions, injuries, or circumstances under which guests should not participate in this class (e.g., pregnancy, heart conditions, recent surgery).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fitness class record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duration_minutes` STRING COMMENT 'The scheduled length of the fitness class in minutes.',
    `effective_end_date` DATE COMMENT 'The date when this fitness class is no longer available for booking; nullable for classes with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date when this fitness class becomes available for booking and scheduling.',
    `equipment_provided_flag` BOOLEAN COMMENT 'Indicates whether the facility provides all necessary equipment (True) or if guests must bring their own (False).',
    `equipment_required` STRING COMMENT 'List of equipment or props needed for the class (e.g., yoga mat, dumbbells, resistance bands, spin bike, pool access).',
    `fitness_level` STRING COMMENT 'The recommended fitness or experience level for participants (beginner, intermediate, advanced, all levels).. Valid values are `beginner|intermediate|advanced|all_levels`',
    `instructor_certification_required` STRING COMMENT 'The professional certifications or qualifications required for an instructor to teach this class (e.g., RYT-200, ACE Certified, CPR/AED).',
    `intensity_level` STRING COMMENT 'The physical intensity or exertion level of the class (low, moderate, high, variable).. Valid values are `low|moderate|high|variable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fitness class record was most recently updated.',
    `loyalty_points_earned` STRING COMMENT 'The number of loyalty program points a guest earns by attending this fitness class.',
    `loyalty_points_eligible_flag` BOOLEAN COMMENT 'Indicates whether participation in this class earns loyalty program points for the guest.',
    `maximum_participants` STRING COMMENT 'The maximum number of guests allowed to register for this class based on facility capacity and safety requirements.',
    `member_price` DECIMAL(18,2) COMMENT 'The discounted price offered to loyalty program members or spa membership holders.',
    `minimum_participants` STRING COMMENT 'The minimum number of registered guests required for the class to proceed; classes below this threshold may be cancelled.',
    `notes` STRING COMMENT 'Additional free-form notes or special instructions related to this fitness class for operational or guest communication purposes.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether guests can book this class through online channels (website, mobile app) or if it requires phone or in-person booking.',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether this class can be included in spa or wellness packages offered to guests.',
    `pregnancy_safe_flag` BOOLEAN COMMENT 'Indicates whether the class is safe for pregnant guests to participate in.',
    `seasonal_availability` STRING COMMENT 'Indicates whether the class is offered year-round or only during specific seasons.. Valid values are `year_round|summer_only|winter_only|spring_fall|peak_season|off_season`',
    `standard_price` DECIMAL(18,2) COMMENT 'The standard retail price charged to guests for participating in this fitness class.',
    CONSTRAINT pk_fitness_class PRIMARY KEY(`fitness_class_id`)
) COMMENT 'Master catalog of fitness and wellness classes offered at resort and hotel fitness facilities. Captures class name, class code, class type (yoga, pilates, spin, HIIT, aqua aerobics, meditation, stretching), instructor reference, facility reference, duration in minutes, maximum participants, minimum participants, equipment required, fitness level (beginner, intermediate, advanced), class description, and active status.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` (
    `treatment_menu_item_id` BIGINT COMMENT 'Primary key for the treatment_menu_item association',
    `treatment_id` BIGINT COMMENT 'Foreign key linking this menu item record to the master treatment catalog entry being included in the menu.',
    `treatment_menu_id` BIGINT COMMENT 'Foreign key linking this menu item record to the property-level treatment menu it belongs to.',
    `availability_flag` BOOLEAN COMMENT 'Indicates whether this treatment is currently active and bookable from this specific menu. Belongs to the association because a treatment may be available on one menu but suspended on another.',
    `display_sequence` STRING COMMENT 'Numeric ordering value controlling the presentation sequence of this treatment within the specific menu. Belongs to the association because the same treatment may appear in different positions on different menus.',
    `effective_end_date` DATE COMMENT 'Date after which this treatment is no longer offered on this specific menu. Belongs to the association because a treatment may be retired from one menu while remaining on others.',
    `effective_start_date` DATE COMMENT 'Date from which this treatment is active on this specific menu. Belongs to the association because a treatment may be added to a menu mid-season without changing the menus own effective dates.',
    `menu_price_override` DECIMAL(18,2) COMMENT 'Property-level price for this treatment as listed on this specific menu, overriding the master recommended_retail_price on the treatment catalog. Belongs to the association because price varies by menu and property context.',
    CONSTRAINT pk_treatment_menu_item PRIMARY KEY(`treatment_menu_item_id`)
) COMMENT 'This association product represents the inclusion (Contract) of a specific spa treatment in a specific property-level treatment menu. It captures the operational details of each treatment-on-menu combination: the property-level price override, display ordering, availability window, and active status. Each record links one treatment_menu to one treatment with attributes that exist only in the context of this menu-treatment pairing and cannot be stored on either parent entity alone.. Existence Justification: In spa operations, a treatment menu is a curated collection of treatments offered at a specific property for a defined period or season. A single treatment (e.g., Hot Stone Massage) genuinely appears on multiple menus simultaneously (main spa menu, couples menu, seasonal menu), and each menu contains many treatments. The business actively manages which treatments are included in which menus, at what property-level price, in what display order, and for what availability window — all of which are relationship-level data that belong to neither the menu nor the treatment alone.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`package_component` (
    `package_component_id` BIGINT COMMENT 'Primary key for the package_component association',
    `package_id` BIGINT COMMENT 'Foreign key linking this component record to the parent spa package in the master package catalog.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking this component record to the specific treatment included in the package.',
    `duration_override_minutes` BIGINT COMMENT 'Package-specific duration for this treatment in minutes, overriding the treatments standard duration_minutes when the package bundles a shorter or extended version. Null if the standard duration applies.',
    `is_optional_upgrade` BOOLEAN COMMENT 'Indicates whether this treatment is a core inclusion in the package (false) or an optional upgrade that guests may elect to add at booking (true). Drives booking flow and upsell logic.',
    `package_eligible_flag` BOOLEAN COMMENT 'Indicates whether this treatment can be included in spa packages or bundled offerings. Used for package configuration and revenue management. [Moved from treatment: This boolean on spa.treatment indicates whether a treatment CAN be included in packages, but once the formal package_component association exists, eligibility is implicitly confirmed by the existence of a component record. The flag becomes redundant and its meaning is better governed by the association. However, it may be retained on treatment as a catalog-level pre-qualification filter — recommend review by spa operations to determine if it should be deprecated post-association implementation.]',
    `price_contribution` DECIMAL(18,2) COMMENT 'Monetary amount attributed to this treatment within the package rack rate, used for revenue center allocation and financial reporting. Varies by package-treatment combination.',
    `quantity_included` BIGINT COMMENT 'Number of times this treatment is included in the package (e.g., 2 for a couples package that includes two massages). Belongs to the composition, not to either entity alone.',
    `sequence_in_package` BIGINT COMMENT 'Ordinal position of this treatment within the package experience flow (e.g., 1 = first treatment, 2 = second). Belongs to the composition, not to the package or treatment independently.',
    CONSTRAINT pk_package_component PRIMARY KEY(`package_component_id`)
) COMMENT 'This association product represents the inclusion of a specific treatment within a specific spa package catalog entry. It captures the composition contract between a package and its constituent treatments — defining how each treatment participates in the package, including sequencing, duration adjustments, quantity, price attribution, and whether the treatment is a core inclusion or an optional upgrade. Each record is a managed business entity created and maintained by spa operations staff when building or revising the package menu.. Existence Justification: Spa packages are catalog-level bundles composed of specific treatments — a package like Couples Retreat includes a Swedish massage, a facial, and hydrotherapy, while each of those treatments can appear in multiple packages. The business actively manages this composition: spa operations staff define which treatments are included in each package, at what quantity, duration override, and price contribution. This is a true operational M:N where the composition itself is a managed business entity, not an analytical derivation.';

CREATE OR REPLACE TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` (
    `therapist_treatment_qualification_id` BIGINT COMMENT 'Primary key for the therapist_treatment_qualification association',
    `therapist_id` BIGINT COMMENT 'Foreign key linking to the spa therapist being qualified for the treatment.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to the spa treatment for which the therapist is being qualified.',
    `approval_status` STRING COMMENT 'Current operational status of this therapist-treatment qualification. Only ACTIVE qualifications permit scheduling. SUSPENDED or REVOKED statuses may result from license lapses, guest complaints, or retraining requirements. This is the primary scheduling eligibility gate.',
    `approved_date` DATE COMMENT 'The date on which spa management formally approved this therapist to deliver this treatment. Used for compliance auditing, seniority-based scheduling preferences, and qualification expiry calculations.',
    `certification_required` STRING COMMENT 'The specific certification or credential that was verified when approving this therapist for this treatment. Captured at approval time to create an audit record independent of future changes to the treatments minimum_certification field.',
    `last_performed_date` DATE COMMENT 'The most recent date on which this therapist delivered this specific treatment. Used to identify therapists who may need refresher training due to inactivity on a particular modality, and to support scheduling recency preferences.',
    `proficiency_level` STRING COMMENT 'The therapists assessed skill level for this specific treatment. Distinct from the therapists general certification_level — a therapist may be an expert in Swedish massage but only competent in hot stone. Used for scheduling quality matching and guest experience optimization.',
    CONSTRAINT pk_therapist_treatment_qualification PRIMARY KEY(`therapist_treatment_qualification_id`)
) COMMENT 'This association product represents the formal qualification and authorization of a specific therapist to deliver a specific spa treatment. It captures the operational approval record that spa management actively maintains — including proficiency level, approval status, approval date, and recency of delivery. Each record links one therapist to one treatment and carries attributes that exist only in the context of that specific therapist-treatment authorization. This is the authoritative source for scheduling eligibility: only therapists with an active qualification record for a treatment may be booked to deliver it.. Existence Justification: In spa operations, therapists must be formally qualified and approved to perform specific treatments — not every therapist can perform every treatment due to certification, training, and brand approval requirements. This qualification relationship is actively managed by spa management: therapists are approved for treatments, their proficiency levels are tracked, approvals can be revoked, and audit trails are maintained. The business explicitly manages which therapist is authorized to deliver which treatment as an operational concept, not merely a derivable correlation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ADD CONSTRAINT `fk_spa_treatment_parent_treatment_id` FOREIGN KEY (`parent_treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ADD CONSTRAINT `fk_spa_treatment_menu_superseded_treatment_menu_id` FOREIGN KEY (`superseded_treatment_menu_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_menu`(`treatment_menu_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ADD CONSTRAINT `fk_spa_therapist_supervisor_therapist_id` FOREIGN KEY (`supervisor_therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ADD CONSTRAINT `fk_spa_therapist_certification_renewed_spa_therapist_certification_id` FOREIGN KEY (`renewed_spa_therapist_certification_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist_certification`(`therapist_certification_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ADD CONSTRAINT `fk_spa_therapist_certification_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ADD CONSTRAINT `fk_spa_spa_facility_parent_spa_facility_id` FOREIGN KEY (`parent_spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_adjoining_treatment_room_id` FOREIGN KEY (`adjoining_treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ADD CONSTRAINT `fk_spa_treatment_room_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_fitness_class_id` FOREIGN KEY (`fitness_class_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_rescheduled_appointment_id` FOREIGN KEY (`rescheduled_appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_therapist_schedule_id` FOREIGN KEY (`therapist_schedule_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist_schedule`(`therapist_schedule_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ADD CONSTRAINT `fk_spa_appointment_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_parent_appointment_package_id` FOREIGN KEY (`parent_appointment_package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment_package`(`appointment_package_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ADD CONSTRAINT `fk_spa_appointment_package_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_parent_package_id` FOREIGN KEY (`parent_package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ADD CONSTRAINT `fk_spa_package_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_original_therapist_schedule_id` FOREIGN KEY (`original_therapist_schedule_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist_schedule`(`therapist_schedule_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ADD CONSTRAINT `fk_spa_therapist_schedule_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_prior_intake_form_id` FOREIGN KEY (`prior_intake_form_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`intake_form`(`intake_form_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ADD CONSTRAINT `fk_spa_intake_form_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_appointment_package_id` FOREIGN KEY (`appointment_package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment_package`(`appointment_package_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_fitness_class_id` FOREIGN KEY (`fitness_class_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_membership_visit_id` FOREIGN KEY (`membership_visit_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership_visit`(`membership_visit_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_primary_original_charge_id` FOREIGN KEY (`primary_original_charge_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`charge`(`charge_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ADD CONSTRAINT `fk_spa_charge_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_renewed_membership_id` FOREIGN KEY (`renewed_membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ADD CONSTRAINT `fk_spa_membership_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`appointment`(`appointment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_fitness_class_id` FOREIGN KEY (`fitness_class_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_membership_id` FOREIGN KEY (`membership_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership`(`membership_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_prior_membership_visit_id` FOREIGN KEY (`prior_membership_visit_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`membership_visit`(`membership_visit_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ADD CONSTRAINT `fk_spa_membership_visit_treatment_room_id` FOREIGN KEY (`treatment_room_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_room`(`treatment_room_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_parent_fitness_class_id` FOREIGN KEY (`parent_fitness_class_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`fitness_class`(`fitness_class_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ADD CONSTRAINT `fk_spa_fitness_class_spa_facility_id` FOREIGN KEY (`spa_facility_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`spa_facility`(`spa_facility_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ADD CONSTRAINT `fk_spa_treatment_menu_item_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ADD CONSTRAINT `fk_spa_treatment_menu_item_treatment_menu_id` FOREIGN KEY (`treatment_menu_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment_menu`(`treatment_menu_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ADD CONSTRAINT `fk_spa_package_component_package_id` FOREIGN KEY (`package_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`package`(`package_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ADD CONSTRAINT `fk_spa_package_component_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ADD CONSTRAINT `fk_spa_therapist_treatment_qualification_therapist_id` FOREIGN KEY (`therapist_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`therapist`(`therapist_id`);
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ADD CONSTRAINT `fk_spa_therapist_treatment_qualification_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `travel_hospitality_ecm`.`spa`.`treatment`(`treatment_id`);

-- ========= TAGS =========
ALTER SCHEMA `travel_hospitality_ecm`.`spa` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `travel_hospitality_ecm`.`spa` SET TAGS ('dbx_domain' = 'spa');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `parent_treatment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `parent_treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `parent_treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Type Required');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `touchpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `advance_booking_required_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Required (Hours)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `age_restriction` SET TAGS ('dbx_business_glossary_term' = 'Age Restriction');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `cancellation_policy_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy (Hours)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (Percent)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `contraindications` SET TAGS ('dbx_business_glossary_term' = 'Treatment Contraindications');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `cost_of_goods` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods (COGS)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `cost_of_goods` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_business_glossary_term' = 'Gender Preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_value_regex' = 'any|male_only|female_only|couples');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `gender_preference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `gratuity_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Included Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `minimum_certification` SET TAGS ('dbx_business_glossary_term' = 'Minimum Therapist Certification');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `pregnancy_safe_flag` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Safe Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `recommended_retail_price` SET TAGS ('dbx_business_glossary_term' = 'Recommended Retail Price');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `required_equipment` SET TAGS ('dbx_business_glossary_term' = 'Required Equipment');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `retail_products_used` SET TAGS ('dbx_business_glossary_term' = 'Retail Products Used');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `revenue_center` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Classification');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `revenue_center` SET TAGS ('dbx_value_regex' = 'spa|wellness|fitness|salon|recreation');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `skill_level_required` SET TAGS ('dbx_business_glossary_term' = 'Therapist Skill Level Required');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `skill_level_required` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|master');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Treatment Subcategory');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_business_glossary_term' = 'Treatment Category');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_value_regex' = 'massage|facial|body_treatment|hydrotherapy|nail_service|beauty_service');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Description');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Treatment Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|discontinued');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment` ALTER COLUMN `upsell_treatments` SET TAGS ('dbx_business_glossary_term' = 'Recommended Upsell Treatments');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `superseded_treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `booking_channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Availability');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Display Sequence');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `gift_certificate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Certificate Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `maximum_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Booking Days');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_brochure_url` SET TAGS ('dbx_business_glossary_term' = 'Menu Brochure URL');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_brochure_url` SET TAGS ('dbx_value_regex' = '^https?://.*.pdf$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_business_glossary_term' = 'Menu Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_description` SET TAGS ('dbx_business_glossary_term' = 'Menu Description');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_image_url` SET TAGS ('dbx_business_glossary_term' = 'Menu Image URL');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*.(jpg|jpeg|png|gif|webp)$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_name` SET TAGS ('dbx_business_glossary_term' = 'Menu Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_type` SET TAGS ('dbx_business_glossary_term' = 'Menu Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_version` SET TAGS ('dbx_business_glossary_term' = 'Menu Version');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `menu_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `minimum_advance_booking_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `pricing_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Pricing Override Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `published_status` SET TAGS ('dbx_business_glossary_term' = 'Published Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `published_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived|suspended|under_review');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `season_type` SET TAGS ('dbx_business_glossary_term' = 'Season Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu` ALTER COLUMN `season_type` SET TAGS ('dbx_value_regex' = 'peak|off_peak|shoulder|holiday|year_round');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` SET TAGS ('dbx_subdomain' = 'therapist_operations');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `supervisor_therapist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `availability_schedule` SET TAGS ('dbx_business_glossary_term' = 'Availability Schedule');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|master|director');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Therapist Email Address');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|contractor|seasonal|on-call');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Therapist First Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Therapist Gender');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|prefer not to say');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `guest_rating_average` SET TAGS ('dbx_business_glossary_term' = 'Guest Rating Average');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Therapist Hire Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Therapist Last Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `last_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Training Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `max_appointments_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Appointments Per Day');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `next_certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Certification Due Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Therapist Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Therapist Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Therapist Preferred Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `primary_license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Primary License Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_business_glossary_term' = 'Primary License Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `primary_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `primary_license_state` SET TAGS ('dbx_business_glossary_term' = 'Primary License State');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `primary_license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `specializations` SET TAGS ('dbx_business_glossary_term' = 'Therapist Specializations');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Therapist Termination Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `therapist_code` SET TAGS ('dbx_business_glossary_term' = 'Therapist Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `therapist_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `therapist_status` SET TAGS ('dbx_business_glossary_term' = 'Therapist Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `therapist_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on-leave|suspended|terminated');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `tip_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Tip Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `total_appointments_completed` SET TAGS ('dbx_business_glossary_term' = 'Total Appointments Completed');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` SET TAGS ('dbx_subdomain' = 'therapist_operations');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `therapist_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Certification ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `renewed_spa_therapist_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|master|instructor');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `continuing_education_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `is_brand_required` SET TAGS ('dbx_business_glossary_term' = 'Is Brand Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `is_primary_certification` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Certification Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `is_state_required` SET TAGS ('dbx_business_glossary_term' = 'Is State Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|reimbursed|denied');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'current|pending_renewal|expired|suspended|revoked|not_applicable');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `specialty_area` SET TAGS ('dbx_business_glossary_term' = 'Specialty Area');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'online_registry|phone_verification|document_review|third_party_service|not_verified');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|failed_verification|not_verified');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` SET TAGS ('dbx_subdomain' = 'facility_booking');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `content_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `parent_spa_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `average_daily_visitors` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Visitors');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `certification_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Certification and Accreditation');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_renovation|temporarily_closed|seasonal');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'spa|fitness_center|golf_course|pool|tennis_court|salon');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `fire_safety_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Compliance Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Gender Designation');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_value_regex' = 'co_ed|female_only|male_only|gender_neutral');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `guest_access_policy` SET TAGS ('dbx_business_glossary_term' = 'Guest Access Policy');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `guest_access_policy` SET TAGS ('dbx_value_regex' = 'hotel_guests_only|members_only|public_access|day_pass_available');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `health_safety_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Health and Safety Compliance Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `health_safety_compliance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `health_safety_compliance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `locker_room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Locker Room Capacity');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `next_scheduled_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Renovation Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_friday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Friday');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_friday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_monday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Monday');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_monday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_saturday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Saturday');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_saturday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_sunday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Sunday');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_sunday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_thursday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Thursday');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_thursday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_tuesday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Tuesday');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_tuesday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_wednesday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Wednesday');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `operating_hours_wednesday` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]-([0-1][0-9]|2[0-3]):[0-5][0-9]$|^closed$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `outdoor_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Outdoor Space Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `peak_season_months` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Months');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `relaxation_lounge_capacity` SET TAGS ('dbx_business_glossary_term' = 'Relaxation Lounge Capacity');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `reservation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reservation Required Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `retail_area_flag` SET TAGS ('dbx_business_glossary_term' = 'Retail Area Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `seasonal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Close Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `seasonal_open_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Open Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `seasonal_operation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Operation Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `total_treatment_rooms` SET TAGS ('dbx_business_glossary_term' = 'Total Treatment Rooms');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `total_treatment_rooms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `total_treatment_rooms` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`spa_facility` ALTER COLUMN `wet_area_capacity` SET TAGS ('dbx_business_glossary_term' = 'Wet Area Capacity');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` SET TAGS ('dbx_subdomain' = 'facility_booking');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `adjoining_treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `ambiance_features` SET TAGS ('dbx_business_glossary_term' = 'Ambiance Features');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Equipment List');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `ffe_value` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Value');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `ffe_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_business_glossary_term' = 'Gender Designation');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_value_regex' = 'male|female|unisex|private');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `gender_designation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `has_chromotherapy` SET TAGS ('dbx_business_glossary_term' = 'Has Chromotherapy');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `has_heated_table` SET TAGS ('dbx_business_glossary_term' = 'Has Heated Table');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `has_music_system` SET TAGS ('dbx_business_glossary_term' = 'Has Music System');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `has_outdoor_access` SET TAGS ('dbx_business_glossary_term' = 'Has Outdoor Access');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `has_private_shower` SET TAGS ('dbx_business_glossary_term' = 'Has Private Shower');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|repair|renovation|inspection');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|temporarily_closed');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `room_code` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `room_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `room_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `sanitation_protocol` SET TAGS ('dbx_business_glossary_term' = 'Sanitation Protocol');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `sanitation_protocol` SET TAGS ('dbx_value_regex' = 'standard|enhanced|medical_grade');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `temperature_control_type` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `temperature_control_type` SET TAGS ('dbx_value_regex' = 'central_hvac|individual_thermostat|radiant_floor|none');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `turnaround_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Minutes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_room` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` SET TAGS ('dbx_subdomain' = 'facility_booking');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `appointment_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fitness Class Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Interaction Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `rescheduled_appointment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Booking ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `therapist_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Schedule Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Guest Arrival Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Party');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_value_regex' = 'guest|property|system|no-show');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Confirmation Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration in Minutes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `external_booking_reference` SET TAGS ('dbx_business_glossary_term' = 'External Booking Reference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_business_glossary_term' = 'Guest Gender Preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_value_regex' = 'male|female|no-preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_gender_preference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_notes` SET TAGS ('dbx_business_glossary_term' = 'Guest Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `guest_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `intake_form_completed` SET TAGS ('dbx_business_glossary_term' = 'Intake Form Completed Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `intake_form_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Intake Form Completed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `prepayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `prepayment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `prepayment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_business_glossary_term' = 'Pressure Preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_value_regex' = 'light|medium|firm|extra-firm|no-preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `special_health_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Health Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `special_health_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `special_health_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_business_glossary_term' = 'Therapist Gender Preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_value_regex' = 'male|female|no-preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment` ALTER COLUMN `therapist_gender_preference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `appointment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Package ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `attribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Event Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `parent_appointment_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `addon_services_amount` SET TAGS ('dbx_business_glossary_term' = 'Add-On Services Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `booking_channel` SET TAGS ('dbx_value_regex' = 'web|mobile app|phone|front desk|concierge|in-room tablet');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|in-progress|completed|cancelled|no-show');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `cancellation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Deadline');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `complimentary_amenities` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Amenities');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `guest_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Arrival Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `package_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Package Duration Minutes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `package_notes` SET TAGS ('dbx_business_glossary_term' = 'Package Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `package_price` SET TAGS ('dbx_business_glossary_term' = 'Package Price');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|paid|refunded|partially refunded|failed');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'not started|partially redeemed|fully redeemed|expired');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `treatment_count` SET TAGS ('dbx_business_glossary_term' = 'Treatment Count');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `treatment_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`appointment_package` ALTER COLUMN `treatment_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Package ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `content_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Eligible Loyalty Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Menu Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `parent_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `reservation_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `age_restriction_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `amenities_included` SET TAGS ('dbx_business_glossary_term' = 'Amenities Included');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `cancellation_hours_notice` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Hours Notice');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Percentage');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `deposit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deposit Percentage');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'none|male_only|female_only|couples_only');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `guest_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Guest Type Eligibility');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `guest_type_eligibility` SET TAGS ('dbx_value_regex' = 'all|hotel_guest|day_guest|member|loyalty_tier');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `loyalty_points_eligible` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `loyalty_points_value` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Value');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `maximum_advance_booking_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Advance Booking (Days)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `maximum_party_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Party Size');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `minimum_advance_booking_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Advance Booking (Hours)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `minimum_party_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Party Size');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_category` SET TAGS ('dbx_business_glossary_term' = 'Package Category');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_category` SET TAGS ('dbx_value_regex' = 'relaxation|therapeutic|beauty|fitness|wellness|specialty');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_name` SET TAGS ('dbx_business_glossary_term' = 'Package Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|discontinued|pending_approval|archived');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'day_spa|half_day|couples|wellness_program|golf_and_spa|resort_credit');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `promotional_rate` SET TAGS ('dbx_business_glossary_term' = 'Promotional Rate');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `property_availability` SET TAGS ('dbx_business_glossary_term' = 'Property Availability List');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `rack_rate` SET TAGS ('dbx_business_glossary_term' = 'Rack Rate');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `requires_deposit` SET TAGS ('dbx_business_glossary_term' = 'Requires Deposit Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `retail_products_included` SET TAGS ('dbx_business_glossary_term' = 'Retail Products Included');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `service_charge_included` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Included Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `tax_inclusive` SET TAGS ('dbx_business_glossary_term' = 'Tax Inclusive Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `total_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Duration (Minutes)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` SET TAGS ('dbx_subdomain' = 'therapist_operations');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `therapist_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Schedule ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `original_therapist_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `actual_clock_in_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock In Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `actual_clock_out_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock Out Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `break_end_time` SET TAGS ('dbx_business_glossary_term' = 'Break End Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `break_start_time` SET TAGS ('dbx_business_glossary_term' = 'Break Start Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `primary_treatment_specialty` SET TAGS ('dbx_business_glossary_term' = 'Primary Treatment Specialty');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `primary_treatment_specialty` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `primary_treatment_specialty` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|confirmed|cancelled|completed|no_show');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `schedule_variance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Minutes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `scheduled_treatment_slots` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Treatment Slots');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `scheduled_treatment_slots` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `scheduled_treatment_slots` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'opening|mid|closing|on_call|split|double');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `total_available_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Available Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `total_booked_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Booked Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` SET TAGS ('dbx_subdomain' = 'facility_booking');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `intake_form_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Form ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `guest_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Interaction Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `prior_intake_form_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `allergy_details` SET TAGS ('dbx_business_glossary_term' = 'Allergy Details');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `allergy_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `allergy_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `areas_to_avoid` SET TAGS ('dbx_business_glossary_term' = 'Areas to Avoid');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `areas_to_avoid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `areas_to_avoid` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `aromatherapy_preference` SET TAGS ('dbx_business_glossary_term' = 'Aromatherapy Preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `cardiovascular_condition_details` SET TAGS ('dbx_business_glossary_term' = 'Cardiovascular Condition Details');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `cardiovascular_condition_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `cardiovascular_condition_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `current_medications` SET TAGS ('dbx_business_glossary_term' = 'Current Medications');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `current_medications` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `current_medications` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Acknowledgment');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `data_privacy_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Acknowledgment Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `form_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Form Expiration Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `form_number` SET TAGS ('dbx_value_regex' = '^IF-[0-9]{8,12}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `form_status` SET TAGS ('dbx_business_glossary_term' = 'Form Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `form_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|rejected|expired');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_allergies` SET TAGS ('dbx_business_glossary_term' = 'Allergies Indicator');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_allergies` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_allergies` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_cardiovascular_condition` SET TAGS ('dbx_business_glossary_term' = 'Cardiovascular Condition Indicator');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_cardiovascular_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_cardiovascular_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_previous_spa_experience` SET TAGS ('dbx_business_glossary_term' = 'Previous Spa Experience Indicator');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_recent_surgery` SET TAGS ('dbx_business_glossary_term' = 'Recent Surgery Indicator');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_recent_surgery` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_recent_surgery` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_skin_condition` SET TAGS ('dbx_business_glossary_term' = 'Skin Condition Indicator');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_skin_condition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `has_skin_condition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `is_pregnant` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Indicator');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `is_pregnant` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `is_pregnant` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `photography_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Photography Consent Given');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Trimester');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_value_regex' = 'first|second|third|not_applicable');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `pregnancy_trimester` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_business_glossary_term' = 'Pressure Preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `pressure_preference` SET TAGS ('dbx_value_regex' = 'light|medium|firm|very_firm|no_preference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `previous_spa_experience_notes` SET TAGS ('dbx_business_glossary_term' = 'Previous Spa Experience Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `skin_condition_details` SET TAGS ('dbx_business_glossary_term' = 'Skin Condition Details');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `skin_condition_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `skin_condition_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|in_person_tablet|paper_form|email');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `surgery_details` SET TAGS ('dbx_business_glossary_term' = 'Surgery Details');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `surgery_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `surgery_details` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `therapist_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Therapist Review Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `therapist_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Therapist Reviewed Indicator');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_given` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Given');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_given` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_given` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`intake_form` ALTER COLUMN `treatment_consent_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` SET TAGS ('dbx_subdomain' = 'guest_membership');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Charge ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `appointment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Package Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fitness Class Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Pos Check Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `membership_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Visit Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `primary_original_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Original Charge ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `service_recovery_action_id` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Action Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `charge_date` SET TAGS ('dbx_business_glossary_term' = 'Charge Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `charge_number` SET TAGS ('dbx_business_glossary_term' = 'Charge Reference Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `charge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Charge Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'treatment|retail|membership|day_pass|gratuity|cancellation_fee');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `folio_reference` SET TAGS ('dbx_business_glossary_term' = 'Property Management System (PMS) Folio Reference');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `gratuity_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Included Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Charge Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'room_charge|credit_card|cash|gift_card|loyalty_points|comp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|voided|adjusted|pending|reversed');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `revenue_center_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Center Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`charge` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` SET TAGS ('dbx_subdomain' = 'guest_membership');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `attribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Event Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `booking_source_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Source Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `campaign_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `nps_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Nps Survey Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `renewed_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `annual_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'member_request|payment_failure|relocation|dissatisfaction|health_reasons|cost_concerns');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `included_fitness_access` SET TAGS ('dbx_business_glossary_term' = 'Included Fitness Access');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `included_guest_passes` SET TAGS ('dbx_business_glossary_term' = 'Included Guest Passes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `included_treatment_credits` SET TAGS ('dbx_business_glossary_term' = 'Included Treatment Credits');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `included_treatment_credits` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `included_treatment_credits` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|expired|pending');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'monthly|annual|corporate|complimentary');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `monthly_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Fee');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Token');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{16,64}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_account|corporate_billing|room_charge');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mobile_app|postal_mail');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `promotional_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'opera_pms|spa_management_system|salesforce_crm|mobile_app|web_portal');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` SET TAGS ('dbx_subdomain' = 'guest_membership');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `membership_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Visit ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fitness Class Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Pos Check Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `guest_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Interaction Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `prior_membership_visit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `complimentary_flag` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `credits_consumed` SET TAGS ('dbx_business_glossary_term' = 'Credits Consumed');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `gratuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Gratuity Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Count');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `guest_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `remaining_credit_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Credit Balance');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `retail_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Retail Purchase Amount');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `special_request` SET TAGS ('dbx_business_glossary_term' = 'Special Request');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|checked_in|in_progress|completed|cancelled|no_show');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`membership_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `fitness_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fitness Class ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `parent_fitness_class_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `revenue_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Rate Plan Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `survey_template_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Template Id (Foreign Key)');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `advance_booking_required_hours` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Required Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `age_restriction_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Restriction');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `age_restriction_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `cancellation_policy_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Hours');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_benefits` SET TAGS ('dbx_business_glossary_term' = 'Class Benefits');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Class Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Class Description');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_image_url` SET TAGS ('dbx_business_glossary_term' = 'Class Image URL');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Class Name');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_status` SET TAGS ('dbx_business_glossary_term' = 'Class Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|suspended|discontinued');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Class Subcategory');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `class_type` SET TAGS ('dbx_business_glossary_term' = 'Class Type');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `complimentary_flag` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `contraindications` SET TAGS ('dbx_business_glossary_term' = 'Contraindications');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `equipment_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Provided Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `fitness_level` SET TAGS ('dbx_business_glossary_term' = 'Fitness Level');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `fitness_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|all_levels');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `instructor_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Instructor Certification Required');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `intensity_level` SET TAGS ('dbx_business_glossary_term' = 'Intensity Level');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `intensity_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|variable');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `loyalty_points_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `maximum_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `member_price` SET TAGS ('dbx_business_glossary_term' = 'Member Price');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `minimum_participants` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participants');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `pregnancy_safe_flag` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Safe Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Availability');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `seasonal_availability` SET TAGS ('dbx_value_regex' = 'year_round|summer_only|winter_only|spring_fall|peak_season|off_season');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`fitness_class` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` SET TAGS ('dbx_association_edges' = 'spa.treatment_menu,spa.treatment');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Item - Treatment Menu Item Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_item_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_item_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Item - Treatment Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Item - Treatment Menu Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `treatment_menu_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Treatment Menu Availability');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `display_sequence` SET TAGS ('dbx_business_glossary_term' = 'Menu Display Sequence');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Effective End Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Effective Start Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`treatment_menu_item` ALTER COLUMN `menu_price_override` SET TAGS ('dbx_business_glossary_term' = 'Menu Price Override');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` SET TAGS ('dbx_subdomain' = 'treatment_catalog');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` SET TAGS ('dbx_association_edges' = 'spa.package,spa.treatment');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `package_component_id` SET TAGS ('dbx_business_glossary_term' = 'Package Component - Package Component Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Component - Package Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Package Component - Treatment Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `duration_override_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Override');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `is_optional_upgrade` SET TAGS ('dbx_business_glossary_term' = 'Optional Upgrade Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `package_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Package Eligible Flag');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `price_contribution` SET TAGS ('dbx_business_glossary_term' = 'Price Contribution');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `quantity_included` SET TAGS ('dbx_business_glossary_term' = 'Included Quantity');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`package_component` ALTER COLUMN `sequence_in_package` SET TAGS ('dbx_business_glossary_term' = 'Treatment Sequence');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` SET TAGS ('dbx_subdomain' = 'therapist_operations');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` SET TAGS ('dbx_association_edges' = 'spa.therapist,spa.treatment');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `therapist_treatment_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Treatment Qualification - Therapist Treatment Qualification Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `therapist_treatment_qualification_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `therapist_treatment_qualification_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `therapist_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Treatment Qualification - Therapist Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Therapist Treatment Qualification - Treatment Id');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Approval Status');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Approval Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Required Certification for Qualification');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Treatment Delivery Date');
ALTER TABLE `travel_hospitality_ecm`.`spa`.`therapist_treatment_qualification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Treatment Proficiency Level');
